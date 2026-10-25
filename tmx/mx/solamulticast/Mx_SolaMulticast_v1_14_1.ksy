# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaMulticast Hsvf v1.14.1
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Multicast
#   Encoding: High Speed Vendor Feed
#   Version: 1.14.1
#   Date: 2/5/2024
#   Specification: MX SOLA HSVF Multicast Specifications Guide (1.14.1).pdf
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
  id: tmx_mx_solamulticast_hsvf_v1_14_1
  title: Tmx Mx SolaMulticast Hsvf v1.14.1
  license: GPL-3.0
  endian: be

doc: 'TMX Group Montreal Exchange Sola Multicast Hsvf v1.14.1'
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
            '"D"': option_request_for_quote_message
            '"DB"': future_options_request_for_quote_message
            '"DF"': future_request_for_quote_message
            '"DS"': strategy_request_for_quote_message
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
            '"IF"': future_trade_cancellation_message
            '"IS"': strategy_trade_cancellation_message
            '"J"': option_instrument_keys_message
            '"JB"': future_options_instrument_keys_message
            '"JE"': underlying_instrument_keys_message
            '"JF"': futures_instrument_keys_message
            '"JS"': strategy_instrument_keys_message
            '"M"': option_auction_beginning_message
            '"MS"': strategy_auction_beginning_message
            '"N"': option_summary_message
            '"NB"': future_options_summary_message
            '"NF"': futures_summary_message
            '"NS"': strategy_summary_message
            '"O"': option_initial_and_improvement_order_message
            '"OS"': strategy_initial_and_improvement_order_message
            '"Q"': beginning_of_options_summary_message
            '"QB"': beginning_of_future_options_summary_message
            '"QF"': beginning_of_futures_summary_message
            '"QS"': beginning_of_strategy_summary_message
            '"T"': option_auction_ending_message
            '"TS"': strategy_auction_ending_message
            '"XF"': futures_trade_correction_message
            '"GR"': group_status_message
            '"GS"': group_status_strategies_message
            '"KF"': future_deliverables_message
            '"L"': bulletins_message
            '"S"': end_of_sales_message
            '"TT"': tick_table_message
            '"U"': end_of_transmission_message
            '"V"': circuit_assurance_message
            '"SD"': start_of_day_message
      - id: hsvf_etx
        type: u1
        doc: 'End of Hsvf message'
  message_header_struct:
    seq:
      - id: sequence_number
        type: str
        size: 10
        encoding: ASCII
        doc: 'The sequence numbers will range from 0000000001 to 9999999999 (decimal, ASCII)'
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the type of message being sent'
      - id: message_timestamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'System timestamp, YYYYMMDDHHMMSSmmmuuu'
  option_trade_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_negative_million_pair
            _: net_change_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
  option_symbol:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Option expiry month code Refer to Month Codes'
      - id: strike_price_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_negative_million_pair
            _: strike_price_numeric_pair
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the option expiry year'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the option'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  strike_price_negative_whole_pair:
    seq:
      - id: raw_strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_negative_ten_pair:
    seq:
      - id: raw_strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_negative_hundred_pair:
    seq:
      - id: raw_strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_negative_thousand_pair:
    seq:
      - id: raw_strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_negative_ten_thousand_pair:
    seq:
      - id: raw_strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_negative_million_pair:
    seq:
      - id: raw_strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_numeric_pair:
    seq:
      - id: strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_negative_whole_pair:
    seq:
      - id: raw_trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_negative_ten_pair:
    seq:
      - id: raw_trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_negative_hundred_pair:
    seq:
      - id: raw_trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_negative_thousand_pair:
    seq:
      - id: raw_trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_negative_ten_thousand_pair:
    seq:
      - id: raw_trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_negative_million_pair:
    seq:
      - id: raw_trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  trade_price_numeric_pair:
    seq:
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_change_negative_whole_pair:
    seq:
      - id: raw_net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_negative_ten_pair:
    seq:
      - id: raw_net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_negative_hundred_pair:
    seq:
      - id: raw_net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_negative_thousand_pair:
    seq:
      - id: raw_net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_negative_million_pair:
    seq:
      - id: raw_net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  future_options_trade_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_future_options_trade_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_future_options_trade_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_future_options_trade_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_future_options_trade_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_future_options_trade_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_future_options_trade_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_future_options_trade_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_future_options_trade_message_negative_million_pair
            _: net_change_future_options_trade_message_numeric_pair
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
  future_option_symbol:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: symbol_month
        type: u1
        enum: symbol_month
        doc: 'Option symbol month code'
      - id: symbol_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the option symbol year'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the option'
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'Call or Put'
      - id: strike_price_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_negative_million_pair
            _: strike_price_numeric_pair
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  net_change_future_options_trade_message_negative_whole_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_trade_message_negative_ten_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_trade_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_trade_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_trade_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_trade_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_trade_message_negative_million_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_trade_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  futures_trade_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_futures_trade_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_futures_trade_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_futures_trade_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_futures_trade_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_futures_trade_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_futures_trade_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_futures_trade_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_futures_trade_message_negative_million_pair
            _: net_change_futures_trade_message_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
  future_product:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Future base symbol'
      - id: symbol_month
        type: u1
        enum: symbol_month
        doc: 'Option symbol month code'
      - id: symbol_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the option symbol year'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the option'
  net_change_futures_trade_message_negative_whole_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_message_negative_ten_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_message_negative_million_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  strategy_trade_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy The legs are defined in message type JS Alphanumeric with ".","+","-"'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_sign
        type: u1
        enum: trade_price_sign
        doc: 'For Trade Price field (sign)'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_negative_million_pair
            _: net_change_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
  option_request_for_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
  future_options_request_for_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
  future_request_for_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
  strategy_request_for_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy The legs are defined in message type JS Alphanumeric with ".","+","-"'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
  instrument_schedule_notice_option_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol_schedule_notice
        type: option_symbol_schedule_notice
        doc: 'Option symbology'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
  option_symbol_schedule_notice:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Option expiry month code Refer to Month Codes'
      - id: strike_price_schedule_notice_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_schedule_notice_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_schedule_notice_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_schedule_notice_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_schedule_notice_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_schedule_notice_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_schedule_notice_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_schedule_notice_negative_million_pair
            _: strike_price_schedule_notice_numeric_pair
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the option expiry year'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the option'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  strike_price_schedule_notice_negative_whole_pair:
    seq:
      - id: raw_strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_schedule_notice_negative_ten_pair:
    seq:
      - id: raw_strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_schedule_notice_negative_hundred_pair:
    seq:
      - id: raw_strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_schedule_notice_negative_thousand_pair:
    seq:
      - id: raw_strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_schedule_notice_negative_ten_thousand_pair:
    seq:
      - id: raw_strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_schedule_notice_negative_hundred_thousand_pair:
    seq:
      - id: raw_strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_schedule_notice_negative_million_pair:
    seq:
      - id: raw_strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_schedule_notice_numeric_pair:
    seq:
      - id: strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  instrument_schedule_notice_futures_option_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
  instrument_schedule_notice_future_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
  instrument_schedule_notice_strategy_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy The legs are defined in message type JS Alphanumeric with ".","+","-"'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
  option_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: bid_price_quote
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            '"A"': bid_price_quote_numeric_negative_whole_pair
            '"B"': bid_price_quote_numeric_negative_ten_pair
            '"C"': bid_price_quote_numeric_negative_hundred_pair
            '"D"': bid_price_quote_numeric_negative_thousand_pair
            '"E"': bid_price_quote_numeric_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_negative_million_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_quote
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            '"A"': ask_price_quote_numeric_negative_whole_pair
            '"B"': ask_price_quote_numeric_negative_ten_pair
            '"C"': ask_price_quote_numeric_negative_hundred_pair
            '"D"': ask_price_quote_numeric_negative_thousand_pair
            '"E"': ask_price_quote_numeric_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_negative_million_pair
            _: ask_price_quote_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  bid_price_quote_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_opening_pair:
    seq:
      - id: ask_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_negative_whole_pair:
    seq:
      - id: raw_ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_negative_ten_pair:
    seq:
      - id: raw_ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_negative_hundred_pair:
    seq:
      - id: raw_ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_negative_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_negative_million_pair:
    seq:
      - id: raw_ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_pair:
    seq:
      - id: ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  future_options_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: bid_price_quote
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            '"A"': bid_price_quote_numeric_negative_whole_pair
            '"B"': bid_price_quote_numeric_negative_ten_pair
            '"C"': bid_price_quote_numeric_negative_hundred_pair
            '"D"': bid_price_quote_numeric_negative_thousand_pair
            '"E"': bid_price_quote_numeric_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_negative_million_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_quote
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            '"A"': ask_price_quote_numeric_negative_whole_pair
            '"B"': ask_price_quote_numeric_negative_ten_pair
            '"C"': ask_price_quote_numeric_negative_hundred_pair
            '"D"': ask_price_quote_numeric_negative_thousand_pair
            '"E"': ask_price_quote_numeric_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_negative_million_pair
            _: ask_price_quote_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  futures_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: bid_price_quote_futures_quote_message
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_futures_quote_message_opening_pair
            '"0"': bid_price_quote_futures_quote_message_opening_pair
            '"A"': bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_whole_pair
            '"B"': bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_ten_pair
            '"C"': bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_hundred_pair
            '"D"': bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_thousand_pair
            '"E"': bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_million_pair
            _: bid_price_quote_futures_quote_message_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of futures contracts represented by the Bid Price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: ask_price_quote_futures_quote_message
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_futures_quote_message_opening_pair
            '"0"': ask_price_quote_futures_quote_message_opening_pair
            '"A"': ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_whole_pair
            '"B"': ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_ten_pair
            '"C"': ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_hundred_pair
            '"D"': ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_thousand_pair
            '"E"': ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_million_pair
            _: ask_price_quote_futures_quote_message_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of futures contracts represented by the Ask Price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  bid_price_quote_futures_quote_message_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_futures_quote_message_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_futures_quote_message_opening_pair:
    seq:
      - id: ask_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair_negative_million_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_futures_quote_message_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_futures_quote_message_numeric_pair:
    seq:
      - id: ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strategy_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy The legs are defined in message type JS Alphanumeric with ".","+","-"'
      - id: bid_price_sign
        type: u1
        enum: bid_price_sign
        doc: 'For Bid Price field'
      - id: bid_price_quote
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            '"A"': bid_price_quote_numeric_negative_whole_pair
            '"B"': bid_price_quote_numeric_negative_ten_pair
            '"C"': bid_price_quote_numeric_negative_hundred_pair
            '"D"': bid_price_quote_numeric_negative_thousand_pair
            '"E"': bid_price_quote_numeric_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_negative_million_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of futures contracts represented by the Bid Price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price_quote
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            '"A"': ask_price_quote_numeric_negative_whole_pair
            '"B"': ask_price_quote_numeric_negative_ten_pair
            '"C"': ask_price_quote_numeric_negative_hundred_pair
            '"D"': ask_price_quote_numeric_negative_thousand_pair
            '"E"': ask_price_quote_numeric_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_negative_million_pair
            _: ask_price_quote_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of futures contracts represented by the Ask Price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  option_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_market_depth_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: market_depth_level
        type: market_depth_level
        repeat: expr
        repeat-expr: num_market_depth_level.to_i
        doc: 'Option Market Depth'
  market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote_market_depth_level
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_market_depth_level_opening_pair
            '"0"': bid_price_quote_market_depth_level_opening_pair
            '"A"': bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_whole_pair
            '"B"': bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_ten_pair
            '"C"': bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_hundred_pair
            '"D"': bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_thousand_pair
            '"E"': bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_million_pair
            _: bid_price_quote_market_depth_level_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price For Implied, it represents the indicative quantity at the best (1st limit) implied bid price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
      - id: ask_price_quote_market_depth_level
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_market_depth_level_opening_pair
            '"0"': ask_price_quote_market_depth_level_opening_pair
            '"A"': ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_whole_pair
            '"B"': ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_ten_pair
            '"C"': ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_hundred_pair
            '"D"': ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_thousand_pair
            '"E"': ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_million_pair
            _: ask_price_quote_market_depth_level_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price For Implied, it represents the indicative quantity at the best (1st limit) implied ask price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  bid_price_quote_market_depth_level_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_market_depth_level_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the option series For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_market_depth_level_opening_pair:
    seq:
      - id: ask_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair_negative_million_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_market_depth_level_numeric_pair:
    seq:
      - id: ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the option series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  future_options_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_future_options_market_depth_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: future_options_market_depth_level
        type: future_options_market_depth_level
        repeat: expr
        repeat-expr: num_future_options_market_depth_level.to_i
        doc: 'Option Market Depth'
  future_options_market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote_market_depth_level_hb
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_market_depth_level_hb_opening_pair
            '"0"': bid_price_quote_market_depth_level_hb_opening_pair
            '"A"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_whole_pair
            '"B"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_ten_pair
            '"C"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_pair
            '"D"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_thousand_pair
            '"E"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_million_pair
            _: bid_price_quote_market_depth_level_hb_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Total number of contracts being bid at this price For Implied, it represents the indicative quantity at the best (1st limit) implied bid price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
      - id: ask_price_quote_market_depth_level_hb
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_market_depth_level_hb_opening_pair
            '"0"': ask_price_quote_market_depth_level_hb_opening_pair
            '"A"': ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_whole_pair
            '"B"': ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_ten_pair
            '"C"': ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_pair
            '"D"': ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_thousand_pair
            '"E"': ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_million_pair
            _: ask_price_quote_market_depth_level_hb_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Total number of contracts being offered at this price For Implied, it represents the indicative quantity at the best (1st limit) implied ask price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  bid_price_quote_market_depth_level_hb_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_market_depth_level_hb_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid Price for the series. For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_market_depth_level_hb_opening_pair:
    seq:
      - id: ask_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair_negative_million_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_market_depth_level_hb_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_market_depth_level_hb_numeric_pair:
    seq:
      - id: ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the series For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  futures_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_futures_market_depth_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: futures_market_depth_level
        type: futures_market_depth_level
        repeat: expr
        repeat-expr: num_futures_market_depth_level.to_i
        doc: 'Option Market Depth'
  futures_market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote_market_depth_level_hf
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_market_depth_level_hf_opening_pair
            '"0"': bid_price_quote_market_depth_level_hf_opening_pair
            '"A"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_whole_pair
            '"B"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_ten_pair
            '"C"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_hundred_pair
            '"D"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_thousand_pair
            '"E"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_million_pair
            _: bid_price_quote_market_depth_level_hf_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of futures contracts represented by the Bid Price For Implied, it represents he indicative quantity at the best (1st limit) implied bid price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
      - id: ask_price_futures_depth_market_depth_level_hf
        type:
          switch-on: peek_ask_price_futures_depth_opening
          cases:
            '"OUV"': ask_price_futures_depth_market_depth_level_hf_opening_pair
            '"0"': ask_price_futures_depth_market_depth_level_hf_opening_pair
            '"A"': ask_price_futures_depth_numeric_negative_whole_pair
            '"B"': ask_price_futures_depth_numeric_negative_ten_pair
            '"C"': ask_price_futures_depth_numeric_negative_hundred_pair
            '"D"': ask_price_futures_depth_numeric_negative_thousand_pair
            '"E"': ask_price_futures_depth_numeric_negative_ten_thousand_pair
            '"F"': ask_price_futures_depth_numeric_negative_hundred_thousand_pair
            '"G"': ask_price_futures_depth_numeric_negative_million_pair
            _: ask_price_futures_depth_market_depth_level_hf_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of futures contracts represented by the Ask Price For Implied, it represents the indicative quantity at the best (1st limit) implied ask price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_futures_depth_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  bid_price_quote_market_depth_level_hf_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_market_depth_level_hf_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_market_depth_level_hf_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_market_depth_level_hf_opening_pair:
    seq:
      - id: ask_price_futures_depth_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_numeric_negative_whole_pair:
    seq:
      - id: raw_ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_numeric_negative_ten_pair:
    seq:
      - id: raw_ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_numeric_negative_hundred_pair:
    seq:
      - id: raw_ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_numeric_negative_thousand_pair:
    seq:
      - id: raw_ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_numeric_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_numeric_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_numeric_negative_million_pair:
    seq:
      - id: raw_ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_market_depth_level_hf_numeric_pair:
    seq:
      - id: ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strategy_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy The legs are defined in message type JS Alphanumeric with ".","+","-"'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_strategy_market_depth_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: strategy_market_depth_level
        type: strategy_market_depth_level
        repeat: expr
        repeat-expr: num_strategy_market_depth_level.to_i
        doc: 'Strategy Market Depth Level'
  strategy_market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_sign
        type: u1
        enum: bid_price_sign
        doc: 'For Bid Price field'
      - id: bid_price_quote_strategy_market_depth_level
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_strategy_market_depth_level_opening_pair
            '"0"': bid_price_quote_strategy_market_depth_level_opening_pair
            '"A"': bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_whole_pair
            '"B"': bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_pair
            '"C"': bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_pair
            '"D"': bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_thousand_pair
            '"E"': bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_million_pair
            _: bid_price_quote_strategy_market_depth_level_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of strategy units represented by the Bid Price For Implied, it represents the indicative quantity at the best (1st limit) implied bid price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price_quote_strategy_market_depth_level
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_strategy_market_depth_level_opening_pair
            '"0"': ask_price_quote_strategy_market_depth_level_opening_pair
            '"A"': ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_whole_pair
            '"B"': ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_pair
            '"C"': ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_pair
            '"D"': ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_thousand_pair
            '"E"': ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_million_pair
            _: ask_price_quote_strategy_market_depth_level_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of strategy units represented by the Ask Price For Implied, it represents the indicative quantity at the best (1st limit) implied ask price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 7
        encoding: ASCII
  bid_price_quote_strategy_market_depth_level_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_strategy_market_depth_level_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bid price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_strategy_market_depth_level_opening_pair:
    seq:
      - id: ask_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair_negative_million_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_market_depth_level_numeric_pair
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_strategy_market_depth_level_numeric_pair:
    seq:
      - id: ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ask price for the strategy instrument For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  option_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
  future_options_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
  future_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
  strategy_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy The legs are defined in message type JS Alphanumeric with ".","+","-"'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_sign
        type: u1
        enum: trade_price_sign
        doc: 'For Trade Price field (sign)'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
  option_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency used for the option Strike Price'
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum authorized number of contract per order'
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum authorized number of contract per order'
      - id: maximum_threshold_price_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_negative_million_pair
            _: maximum_threshold_price_numeric_pair
      - id: minimum_threshold_price_instrument_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_instrument_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_instrument_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_instrument_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_instrument_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_instrument_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_instrument_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_instrument_negative_million_pair
            _: minimum_threshold_price_instrument_numeric_pair
      - id: tick_increment
        type:
          switch-on: peek_tick_increment_fraction_indicator
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
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_negative_whole_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_negative_ten_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_negative_hundred_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_negative_thousand_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_negative_ten_thousand_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_negative_hundred_thousand_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_negative_million_pair
            'tick_increment_fraction_indicator::times_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Type of option'
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines the type of instruments'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument'
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'External identifier used by traders when entering an order'
      - id: option_marker
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Refer to Options Markers'
      - id: underlying_symbol_root
        type: str
        size: 12
        encoding: ASCII
        doc: 'Symbol root for the underlying security'
      - id: contract_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Defines the quantity of an underlying per contract'
      - id: tick_value_fraction_pair
        type:
          switch-on: peek_tick_value_fraction_indicator
          cases:
            'tick_value_fraction_indicator::negative_whole': tick_value_negative_whole_pair
            'tick_value_fraction_indicator::negative_ten': tick_value_negative_ten_pair
            'tick_value_fraction_indicator::negative_hundred': tick_value_negative_hundred_pair
            'tick_value_fraction_indicator::negative_thousand': tick_value_negative_thousand_pair
            'tick_value_fraction_indicator::negative_ten_thousand': tick_value_negative_ten_thousand_pair
            'tick_value_fraction_indicator::negative_hundred_thousand': tick_value_negative_hundred_thousand_pair
            'tick_value_fraction_indicator::negative_million': tick_value_negative_million_pair
            _: tick_value_numeric_pair
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the currency of an underlying'
      - id: delivery_type
        type: u1
        enum: delivery_type
        doc: 'Indicates the delivery type of the instrument'
      - id: last_trading_datetime
        type: yyyymmddhhmmss_ascii_timestamp
        doc: 'Indicates when the instrument stops trading'
    instances:
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_increment_fraction_indicator
      peek_tick_value_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_value_fraction_indicator
  maximum_threshold_price_negative_whole_pair:
    seq:
      - id: raw_maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_negative_ten_pair:
    seq:
      - id: raw_maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_negative_hundred_pair:
    seq:
      - id: raw_maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_negative_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_negative_ten_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_negative_million_pair:
    seq:
      - id: raw_maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_numeric_pair:
    seq:
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_negative_whole_pair:
    seq:
      - id: raw_minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_negative_ten_pair:
    seq:
      - id: raw_minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_negative_hundred_pair:
    seq:
      - id: raw_minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_negative_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_negative_ten_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_negative_hundred_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_negative_million_pair:
    seq:
      - id: raw_minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_instrument_numeric_pair:
    seq:
      - id: minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_increment_numeric_pair:
    seq:
      - id: tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_numeric_negative_whole_pair:
    seq:
      - id: raw_tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_numeric_negative_ten_pair:
    seq:
      - id: raw_tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_numeric_negative_hundred_pair:
    seq:
      - id: raw_tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_numeric_negative_thousand_pair:
    seq:
      - id: raw_tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_numeric_negative_ten_thousand_pair:
    seq:
      - id: raw_tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_numeric_negative_hundred_thousand_pair:
    seq:
      - id: raw_tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_numeric_negative_million_pair:
    seq:
      - id: raw_tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_increment_raw_pair:
    seq:
      - id: tick_increment_raw
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
  tick_value_negative_whole_pair:
    seq:
      - id: raw_tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_value_negative_ten_pair:
    seq:
      - id: raw_tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_value_negative_hundred_pair:
    seq:
      - id: raw_tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_value_negative_thousand_pair:
    seq:
      - id: raw_tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_value_negative_ten_thousand_pair:
    seq:
      - id: raw_tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_value_negative_hundred_thousand_pair:
    seq:
      - id: raw_tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_value_negative_million_pair:
    seq:
      - id: raw_tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_value_numeric_pair:
    seq:
      - id: tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  future_options_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: expiry_date
        type: yymmdd_ascii_date
        doc: 'Expiry date'
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency used for the option Strike Price'
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum authorized number of contract per order'
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum authorized number of contract per order'
      - id: maximum_threshold_price_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_negative_million_pair
            _: maximum_threshold_price_numeric_pair
      - id: minimum_threshold_price_instrument_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_instrument_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_instrument_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_instrument_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_instrument_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_instrument_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_instrument_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_instrument_negative_million_pair
            _: minimum_threshold_price_instrument_numeric_pair
      - id: tick_increment
        type:
          switch-on: peek_tick_increment_fraction_indicator
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
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_negative_whole_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_negative_ten_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_negative_hundred_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_negative_thousand_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_negative_ten_thousand_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_negative_hundred_thousand_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_negative_million_pair
            'tick_increment_fraction_indicator::times_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines the type of instruments'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument'
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'External identifier used by traders when entering an order'
      - id: contract_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Defines the quantity of an underlying per contract'
      - id: tick_value_fraction_pair
        type:
          switch-on: peek_tick_value_fraction_indicator
          cases:
            'tick_value_fraction_indicator::negative_whole': tick_value_negative_whole_pair
            'tick_value_fraction_indicator::negative_ten': tick_value_negative_ten_pair
            'tick_value_fraction_indicator::negative_hundred': tick_value_negative_hundred_pair
            'tick_value_fraction_indicator::negative_thousand': tick_value_negative_thousand_pair
            'tick_value_fraction_indicator::negative_ten_thousand': tick_value_negative_ten_thousand_pair
            'tick_value_fraction_indicator::negative_hundred_thousand': tick_value_negative_hundred_thousand_pair
            'tick_value_fraction_indicator::negative_million': tick_value_negative_million_pair
            _: tick_value_numeric_pair
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the currency of an underlying'
      - id: delivery_type
        type: u1
        enum: delivery_type
        doc: 'Indicates the delivery type of the instrument'
      - id: underlying_root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Root symbol of the underlying future'
      - id: underlying_symbol_month
        type: u1
        enum: underlying_symbol_month
        doc: 'Symbol month of the underlying futures contract'
      - id: underlying_symbol_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last 2 digits of the symbol yearof the underlying futures contract'
      - id: last_trading_datetime
        type: yyyymmddhhmmss_ascii_timestamp
        doc: 'Indicates when the instrument stops trading'
    instances:
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_increment_fraction_indicator
      peek_tick_value_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_value_fraction_indicator
  underlying_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument'
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'External identifier used by traders when entering an order'
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines the type of instruments'
  futures_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: expiry_date
        type: yymmdd_ascii_date
        doc: 'Expiry date'
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum authorized number of contract per order'
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum authorized number of contract per order'
      - id: maximum_threshold_price_futures_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_futures_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_futures_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_futures_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_futures_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_futures_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_futures_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_futures_negative_million_pair
            _: maximum_threshold_price_futures_numeric_pair
      - id: minimum_threshold_price_futures_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_futures_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_futures_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_futures_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_futures_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_futures_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_futures_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_futures_negative_million_pair
            _: minimum_threshold_price_futures_numeric_pair
      - id: tick_increment
        type:
          switch-on: peek_tick_increment_fraction_indicator
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
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_negative_whole_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_negative_ten_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_negative_hundred_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_negative_thousand_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_negative_ten_thousand_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_negative_hundred_thousand_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_negative_million_pair
            'tick_increment_fraction_indicator::times_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines the type of instruments'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument'
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'External identifier used by traders when entering an order'
      - id: contract_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Defines the quantity of an underlying per contract'
      - id: tick_value_fraction_pair
        type:
          switch-on: peek_tick_value_fraction_indicator
          cases:
            'tick_value_fraction_indicator::negative_whole': tick_value_negative_whole_pair
            'tick_value_fraction_indicator::negative_ten': tick_value_negative_ten_pair
            'tick_value_fraction_indicator::negative_hundred': tick_value_negative_hundred_pair
            'tick_value_fraction_indicator::negative_thousand': tick_value_negative_thousand_pair
            'tick_value_fraction_indicator::negative_ten_thousand': tick_value_negative_ten_thousand_pair
            'tick_value_fraction_indicator::negative_hundred_thousand': tick_value_negative_hundred_thousand_pair
            'tick_value_fraction_indicator::negative_million': tick_value_negative_million_pair
            _: tick_value_numeric_pair
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the currency of an underlying'
      - id: underlying_symbol
        type: str
        size: 12
        encoding: ASCII
        doc: 'Symbol root for the underlying security'
      - id: delivery_type
        type: u1
        enum: delivery_type
        doc: 'Indicates the delivery type of the instrument'
      - id: associated_product
        type: associated_product
        doc: 'Associated future product symbology'
      - id: last_trading_datetime
        type: yyyymmddhhmmss_ascii_timestamp
        doc: 'Indicates when the instrument stops trading'
    instances:
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_increment_fraction_indicator
      peek_tick_value_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_value_fraction_indicator
  maximum_threshold_price_futures_negative_whole_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_futures_negative_ten_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_futures_negative_hundred_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_futures_negative_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_futures_negative_ten_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_futures_negative_hundred_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_futures_negative_million_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_futures_numeric_pair:
    seq:
      - id: maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_negative_whole_pair:
    seq:
      - id: raw_minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_negative_ten_pair:
    seq:
      - id: raw_minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_negative_hundred_pair:
    seq:
      - id: raw_minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_negative_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_negative_ten_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_negative_hundred_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_negative_million_pair:
    seq:
      - id: raw_minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_futures_numeric_pair:
    seq:
      - id: minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  associated_product:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: symbol_month
        type: u1
        enum: symbol_month
        doc: 'Option symbol month code'
      - id: symbol_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the option symbol year'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the option'
  strategy_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the contract expiry year from the first expiring leg'
      - id: expiry_month_strategy
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contract expiry month from the first expiring leg Refer to Month Codes. For Market Flow Indicator first letter W, use the Call Options and Strategies month table (A-L). For first letter U, V or Y, use the Futures / Futures Options / Strategies month table. For June, W uses F and U, V and Y use M'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Contract expiry day from the first expiring leg'
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum authorized number of contract per order'
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum authorized number of contract per order'
      - id: maximum_threshold_price_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_negative_million_pair
            _: maximum_threshold_price_numeric_pair
      - id: minimum_threshold_price_strategy_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_strategy_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_strategy_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_strategy_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_strategy_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_strategy_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_strategy_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_strategy_negative_million_pair
            _: minimum_threshold_price_strategy_numeric_pair
      - id: tick_increment
        type:
          switch-on: peek_tick_increment_fraction_indicator
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
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_negative_whole_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_negative_ten_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_negative_hundred_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_negative_thousand_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_negative_ten_thousand_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_negative_hundred_thousand_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_negative_million_pair
            'tick_increment_fraction_indicator::times_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::times_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines the type of instruments'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument'
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'External identifier used by traders when entering an order'
      - id: strategy_allow_implied
        type: u1
        enum: strategy_allow_implied
        doc: 'Indicates if the Strategy supports Implied Pricing'
      - id: strategy_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines the code of the strategy'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'Defines the type of the strategy'
      - id: last_trading_datetime
        type: yyyymmddhhmmss_ascii_timestamp
        doc: 'Indicates when the instrument stops trading'
      - id: variable_legs_strategy_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines strategy code of the covered variable legs'
      - id: num_strategy_instrument_leg
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of legs in the strategy'
      - id: strategy_instrument_leg
        type: strategy_instrument_leg
        repeat: expr
        repeat-expr: num_strategy_instrument_leg.to_i
        doc: 'Strategy Instrument Leg'
    instances:
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_increment_fraction_indicator
  minimum_threshold_price_strategy_negative_whole_pair:
    seq:
      - id: raw_minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_strategy_negative_ten_pair:
    seq:
      - id: raw_minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_strategy_negative_hundred_pair:
    seq:
      - id: raw_minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_strategy_negative_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_strategy_negative_ten_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_strategy_negative_hundred_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_strategy_negative_million_pair:
    seq:
      - id: raw_minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_strategy_numeric_pair:
    seq:
      - id: minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strategy_instrument_leg:
    seq:
      - id: leg_group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group of the Leg Instrument'
      - id: leg_instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Leg Instrument'
      - id: leg_ratio_or_delta_fraction_pair
        type:
          switch-on: peek_leg_ratio_or_delta_fraction_indicator
          cases:
            'leg_ratio_or_delta_fraction_indicator::negative_whole': leg_ratio_or_delta_negative_whole_pair
            'leg_ratio_or_delta_fraction_indicator::negative_ten': leg_ratio_or_delta_negative_ten_pair
            'leg_ratio_or_delta_fraction_indicator::negative_hundred': leg_ratio_or_delta_negative_hundred_pair
            'leg_ratio_or_delta_fraction_indicator::negative_thousand': leg_ratio_or_delta_negative_thousand_pair
            'leg_ratio_or_delta_fraction_indicator::negative_ten_thousand': leg_ratio_or_delta_negative_ten_thousand_pair
            'leg_ratio_or_delta_fraction_indicator::negative_hundred_thousand': leg_ratio_or_delta_negative_hundred_thousand_pair
            'leg_ratio_or_delta_fraction_indicator::negative_million': leg_ratio_or_delta_negative_million_pair
            _: leg_ratio_or_delta_numeric_pair
      - id: leg_price_fraction_pair
        type:
          switch-on: peek_leg_price_fraction_indicator
          cases:
            'leg_price_fraction_indicator::negative_whole': leg_price_negative_whole_pair
            'leg_price_fraction_indicator::negative_ten': leg_price_negative_ten_pair
            'leg_price_fraction_indicator::negative_hundred': leg_price_negative_hundred_pair
            'leg_price_fraction_indicator::negative_thousand': leg_price_negative_thousand_pair
            'leg_price_fraction_indicator::negative_ten_thousand': leg_price_negative_ten_thousand_pair
            'leg_price_fraction_indicator::negative_hundred_thousand': leg_price_negative_hundred_thousand_pair
            'leg_price_fraction_indicator::negative_million': leg_price_negative_million_pair
            _: leg_price_numeric_pair
    instances:
      peek_leg_ratio_or_delta_fraction_indicator:
        pos: _io.pos + 4
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
      peek_leg_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: leg_price_fraction_indicator
  leg_ratio_or_delta_negative_whole_pair:
    seq:
      - id: raw_leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_ratio_or_delta_negative_ten_pair:
    seq:
      - id: raw_leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_ratio_or_delta_negative_hundred_pair:
    seq:
      - id: raw_leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_ratio_or_delta_negative_thousand_pair:
    seq:
      - id: raw_leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_ratio_or_delta_negative_ten_thousand_pair:
    seq:
      - id: raw_leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_ratio_or_delta_negative_hundred_thousand_pair:
    seq:
      - id: raw_leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_ratio_or_delta_negative_million_pair:
    seq:
      - id: raw_leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_ratio_or_delta_numeric_pair:
    seq:
      - id: leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_negative_whole_pair:
    seq:
      - id: raw_leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_negative_ten_pair:
    seq:
      - id: raw_leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_negative_hundred_pair:
    seq:
      - id: raw_leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_negative_thousand_pair:
    seq:
      - id: raw_leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_negative_ten_thousand_pair:
    seq:
      - id: raw_leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_negative_million_pair:
    seq:
      - id: raw_leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  leg_price_numeric_pair:
    seq:
      - id: leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  option_auction_beginning_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
      - id: initial_order_side
        type: u1
        enum: initial_order_side
        doc: 'Indicates the side of the initial order'
      - id: initial_order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the initial order'
      - id: initial_order_price_fraction_pair
        type:
          switch-on: peek_initial_order_price_fraction_indicator
          cases:
            'initial_order_price_fraction_indicator::negative_whole': initial_order_price_negative_whole_pair
            'initial_order_price_fraction_indicator::negative_ten': initial_order_price_negative_ten_pair
            'initial_order_price_fraction_indicator::negative_hundred': initial_order_price_negative_hundred_pair
            'initial_order_price_fraction_indicator::negative_thousand': initial_order_price_negative_thousand_pair
            'initial_order_price_fraction_indicator::negative_ten_thousand': initial_order_price_negative_ten_thousand_pair
            'initial_order_price_fraction_indicator::negative_hundred_thousand': initial_order_price_negative_hundred_thousand_pair
            'initial_order_price_fraction_indicator::negative_million': initial_order_price_negative_million_pair
            _: initial_order_price_numeric_pair
      - id: auction_expiry_timestamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Indicates the expiry time of the auction'
      - id: auction_duration
        type: str
        size: 12
        encoding: ASCII
        doc: 'Indicates the duration of the auction'
      - id: initial_quantity_assured
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the initial order guaranteed to the dealer if he remains at the best price point'
    instances:
      peek_initial_order_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: initial_order_price_fraction_indicator
  initial_order_price_negative_whole_pair:
    seq:
      - id: raw_initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  initial_order_price_negative_ten_pair:
    seq:
      - id: raw_initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  initial_order_price_negative_hundred_pair:
    seq:
      - id: raw_initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  initial_order_price_negative_thousand_pair:
    seq:
      - id: raw_initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  initial_order_price_negative_ten_thousand_pair:
    seq:
      - id: raw_initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  initial_order_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  initial_order_price_negative_million_pair:
    seq:
      - id: raw_initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  initial_order_price_numeric_pair:
    seq:
      - id: initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: u1
        enum: initial_order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strategy_auction_beginning_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
      - id: initial_order_side
        type: u1
        enum: initial_order_side
        doc: 'Indicates the side of the initial order'
      - id: initial_order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the initial order'
      - id: initial_order_price_fraction_pair
        type:
          switch-on: peek_initial_order_price_fraction_indicator
          cases:
            'initial_order_price_fraction_indicator::negative_whole': initial_order_price_negative_whole_pair
            'initial_order_price_fraction_indicator::negative_ten': initial_order_price_negative_ten_pair
            'initial_order_price_fraction_indicator::negative_hundred': initial_order_price_negative_hundred_pair
            'initial_order_price_fraction_indicator::negative_thousand': initial_order_price_negative_thousand_pair
            'initial_order_price_fraction_indicator::negative_ten_thousand': initial_order_price_negative_ten_thousand_pair
            'initial_order_price_fraction_indicator::negative_hundred_thousand': initial_order_price_negative_hundred_thousand_pair
            'initial_order_price_fraction_indicator::negative_million': initial_order_price_negative_million_pair
            _: initial_order_price_numeric_pair
      - id: auction_expiry_timestamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Indicates the expiry time of the auction'
      - id: auction_duration
        type: str
        size: 12
        encoding: ASCII
        doc: 'Indicates the duration of the auction'
      - id: initial_quantity_assured
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the initial order guaranteed to the dealer if he remains at the best price point'
    instances:
      peek_initial_order_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: initial_order_price_fraction_indicator
  option_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: bid_price_summary_fraction_pair
        type:
          switch-on: peek_bid_price_fraction_indicator
          cases:
            'bid_price_fraction_indicator::negative_whole': bid_price_summary_negative_whole_pair
            'bid_price_fraction_indicator::negative_ten': bid_price_summary_negative_ten_pair
            'bid_price_fraction_indicator::negative_hundred': bid_price_summary_negative_hundred_pair
            'bid_price_fraction_indicator::negative_thousand': bid_price_summary_negative_thousand_pair
            'bid_price_fraction_indicator::negative_ten_thousand': bid_price_summary_negative_ten_thousand_pair
            'bid_price_fraction_indicator::negative_hundred_thousand': bid_price_summary_negative_hundred_thousand_pair
            'bid_price_fraction_indicator::negative_million': bid_price_summary_negative_million_pair
            _: bid_price_summary_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_summary_fraction_pair
        type:
          switch-on: peek_ask_price_fraction_indicator
          cases:
            'ask_price_fraction_indicator::negative_whole': ask_price_summary_negative_whole_pair
            'ask_price_fraction_indicator::negative_ten': ask_price_summary_negative_ten_pair
            'ask_price_fraction_indicator::negative_hundred': ask_price_summary_negative_hundred_pair
            'ask_price_fraction_indicator::negative_thousand': ask_price_summary_negative_thousand_pair
            'ask_price_fraction_indicator::negative_ten_thousand': ask_price_summary_negative_ten_thousand_pair
            'ask_price_fraction_indicator::negative_hundred_thousand': ask_price_summary_negative_hundred_thousand_pair
            'ask_price_fraction_indicator::negative_million': ask_price_summary_negative_million_pair
            _: ask_price_summary_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price_fraction_pair
        type:
          switch-on: peek_last_price_fraction_indicator
          cases:
            'last_price_fraction_indicator::negative_whole': last_price_negative_whole_pair
            'last_price_fraction_indicator::negative_ten': last_price_negative_ten_pair
            'last_price_fraction_indicator::negative_hundred': last_price_negative_hundred_pair
            'last_price_fraction_indicator::negative_thousand': last_price_negative_thousand_pair
            'last_price_fraction_indicator::negative_ten_thousand': last_price_negative_ten_thousand_pair
            'last_price_fraction_indicator::negative_hundred_thousand': last_price_negative_hundred_thousand_pair
            'last_price_fraction_indicator::negative_million': last_price_negative_million_pair
            _: last_price_numeric_pair
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains current outstanding number of contracts in the series Updated on a trade by trade basis Refer to Indicator Code'
      - id: open_interest_date
        type: yymmdd_ascii_date
        doc: 'Open interest date'
      - id: tick
        type: u1
        enum: tick
        doc: 'Determined by the difference between last price and the previous different trade price'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_option_summary_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_option_summary_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_option_summary_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_option_summary_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_option_summary_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_option_summary_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_option_summary_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_option_summary_message_negative_million_pair
            _: net_change_option_summary_message_numeric_pair
      - id: open_price_fraction_pair
        type:
          switch-on: peek_open_price_fraction_indicator
          cases:
            'open_price_fraction_indicator::negative_whole': open_price_negative_whole_pair
            'open_price_fraction_indicator::negative_ten': open_price_negative_ten_pair
            'open_price_fraction_indicator::negative_hundred': open_price_negative_hundred_pair
            'open_price_fraction_indicator::negative_thousand': open_price_negative_thousand_pair
            'open_price_fraction_indicator::negative_ten_thousand': open_price_negative_ten_thousand_pair
            'open_price_fraction_indicator::negative_hundred_thousand': open_price_negative_hundred_thousand_pair
            'open_price_fraction_indicator::negative_million': open_price_negative_million_pair
            _: open_price_numeric_pair
      - id: high_price_fraction_pair
        type:
          switch-on: peek_high_price_fraction_indicator
          cases:
            'high_price_fraction_indicator::negative_whole': high_price_negative_whole_pair
            'high_price_fraction_indicator::negative_ten': high_price_negative_ten_pair
            'high_price_fraction_indicator::negative_hundred': high_price_negative_hundred_pair
            'high_price_fraction_indicator::negative_thousand': high_price_negative_thousand_pair
            'high_price_fraction_indicator::negative_ten_thousand': high_price_negative_ten_thousand_pair
            'high_price_fraction_indicator::negative_hundred_thousand': high_price_negative_hundred_thousand_pair
            'high_price_fraction_indicator::negative_million': high_price_negative_million_pair
            _: high_price_numeric_pair
      - id: low_price_fraction_pair
        type:
          switch-on: peek_low_price_fraction_indicator
          cases:
            'low_price_fraction_indicator::negative_whole': low_price_negative_whole_pair
            'low_price_fraction_indicator::negative_ten': low_price_negative_ten_pair
            'low_price_fraction_indicator::negative_hundred': low_price_negative_hundred_pair
            'low_price_fraction_indicator::negative_thousand': low_price_negative_thousand_pair
            'low_price_fraction_indicator::negative_ten_thousand': low_price_negative_ten_thousand_pair
            'low_price_fraction_indicator::negative_hundred_thousand': low_price_negative_hundred_thousand_pair
            'low_price_fraction_indicator::negative_million': low_price_negative_million_pair
            _: low_price_numeric_pair
      - id: option_marker
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Refer to Options Markers'
      - id: closing_price_fraction_pair
        type:
          switch-on: peek_closing_price_fraction_indicator
          cases:
            'closing_price_fraction_indicator::negative_whole': closing_price_negative_whole_pair
            'closing_price_fraction_indicator::negative_ten': closing_price_negative_ten_pair
            'closing_price_fraction_indicator::negative_hundred': closing_price_negative_hundred_pair
            'closing_price_fraction_indicator::negative_thousand': closing_price_negative_thousand_pair
            'closing_price_fraction_indicator::negative_ten_thousand': closing_price_negative_ten_thousand_pair
            'closing_price_fraction_indicator::negative_hundred_thousand': closing_price_negative_hundred_thousand_pair
            'closing_price_fraction_indicator::negative_million': closing_price_negative_million_pair
            _: closing_price_numeric_pair
      - id: previous_closing_price_fraction_pair
        type:
          switch-on: peek_previous_closing_price_fraction_indicator
          cases:
            'previous_closing_price_fraction_indicator::negative_whole': previous_closing_price_negative_whole_pair
            'previous_closing_price_fraction_indicator::negative_ten': previous_closing_price_negative_ten_pair
            'previous_closing_price_fraction_indicator::negative_hundred': previous_closing_price_negative_hundred_pair
            'previous_closing_price_fraction_indicator::negative_thousand': previous_closing_price_negative_thousand_pair
            'previous_closing_price_fraction_indicator::negative_ten_thousand': previous_closing_price_negative_ten_thousand_pair
            'previous_closing_price_fraction_indicator::negative_hundred_thousand': previous_closing_price_negative_hundred_thousand_pair
            'previous_closing_price_fraction_indicator::negative_million': previous_closing_price_negative_million_pair
            _: previous_closing_price_numeric_pair
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
    instances:
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: last_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
      peek_open_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: open_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: low_price_fraction_indicator
      peek_closing_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: closing_price_fraction_indicator
      peek_previous_closing_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: previous_closing_price_fraction_indicator
  bid_price_summary_negative_whole_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_summary_negative_ten_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_summary_negative_hundred_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_summary_negative_thousand_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_summary_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_summary_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_summary_negative_million_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_summary_numeric_pair:
    seq:
      - id: bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_negative_whole_pair:
    seq:
      - id: raw_ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_negative_ten_pair:
    seq:
      - id: raw_ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_negative_hundred_pair:
    seq:
      - id: raw_ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_negative_thousand_pair:
    seq:
      - id: raw_ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_negative_million_pair:
    seq:
      - id: raw_ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_summary_numeric_pair:
    seq:
      - id: ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_negative_whole_pair:
    seq:
      - id: raw_last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_negative_ten_pair:
    seq:
      - id: raw_last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_negative_hundred_pair:
    seq:
      - id: raw_last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_negative_thousand_pair:
    seq:
      - id: raw_last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_negative_ten_thousand_pair:
    seq:
      - id: raw_last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_negative_million_pair:
    seq:
      - id: raw_last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_numeric_pair:
    seq:
      - id: last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_change_option_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_option_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_option_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_option_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_option_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_option_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_option_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_option_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_option_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_option_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_option_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_option_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_option_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_option_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_option_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  open_price_negative_whole_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_negative_ten_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_negative_hundred_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_negative_thousand_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_negative_ten_thousand_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_negative_million_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_numeric_pair:
    seq:
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_negative_whole_pair:
    seq:
      - id: raw_high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_negative_ten_pair:
    seq:
      - id: raw_high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_negative_hundred_pair:
    seq:
      - id: raw_high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_negative_thousand_pair:
    seq:
      - id: raw_high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_negative_ten_thousand_pair:
    seq:
      - id: raw_high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_negative_million_pair:
    seq:
      - id: raw_high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  high_price_numeric_pair:
    seq:
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_negative_whole_pair:
    seq:
      - id: raw_low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_negative_ten_pair:
    seq:
      - id: raw_low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_negative_hundred_pair:
    seq:
      - id: raw_low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_negative_thousand_pair:
    seq:
      - id: raw_low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_negative_ten_thousand_pair:
    seq:
      - id: raw_low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_negative_million_pair:
    seq:
      - id: raw_low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  low_price_numeric_pair:
    seq:
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_negative_whole_pair:
    seq:
      - id: raw_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_negative_ten_pair:
    seq:
      - id: raw_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_negative_hundred_pair:
    seq:
      - id: raw_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_negative_thousand_pair:
    seq:
      - id: raw_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_negative_ten_thousand_pair:
    seq:
      - id: raw_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_negative_million_pair:
    seq:
      - id: raw_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  closing_price_numeric_pair:
    seq:
      - id: closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: u1
        enum: closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_negative_whole_pair:
    seq:
      - id: raw_previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_negative_ten_pair:
    seq:
      - id: raw_previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_negative_hundred_pair:
    seq:
      - id: raw_previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_negative_thousand_pair:
    seq:
      - id: raw_previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_negative_ten_thousand_pair:
    seq:
      - id: raw_previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_negative_million_pair:
    seq:
      - id: raw_previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_closing_price_numeric_pair:
    seq:
      - id: previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
        type: u1
        enum: previous_closing_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  future_options_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: bid_price_summary_fraction_pair
        type:
          switch-on: peek_bid_price_fraction_indicator
          cases:
            'bid_price_fraction_indicator::negative_whole': bid_price_summary_negative_whole_pair
            'bid_price_fraction_indicator::negative_ten': bid_price_summary_negative_ten_pair
            'bid_price_fraction_indicator::negative_hundred': bid_price_summary_negative_hundred_pair
            'bid_price_fraction_indicator::negative_thousand': bid_price_summary_negative_thousand_pair
            'bid_price_fraction_indicator::negative_ten_thousand': bid_price_summary_negative_ten_thousand_pair
            'bid_price_fraction_indicator::negative_hundred_thousand': bid_price_summary_negative_hundred_thousand_pair
            'bid_price_fraction_indicator::negative_million': bid_price_summary_negative_million_pair
            _: bid_price_summary_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_summary_fraction_pair
        type:
          switch-on: peek_ask_price_fraction_indicator
          cases:
            'ask_price_fraction_indicator::negative_whole': ask_price_summary_negative_whole_pair
            'ask_price_fraction_indicator::negative_ten': ask_price_summary_negative_ten_pair
            'ask_price_fraction_indicator::negative_hundred': ask_price_summary_negative_hundred_pair
            'ask_price_fraction_indicator::negative_thousand': ask_price_summary_negative_thousand_pair
            'ask_price_fraction_indicator::negative_ten_thousand': ask_price_summary_negative_ten_thousand_pair
            'ask_price_fraction_indicator::negative_hundred_thousand': ask_price_summary_negative_hundred_thousand_pair
            'ask_price_fraction_indicator::negative_million': ask_price_summary_negative_million_pair
            _: ask_price_summary_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price_fraction_pair
        type:
          switch-on: peek_last_price_fraction_indicator
          cases:
            'last_price_fraction_indicator::negative_whole': last_price_negative_whole_pair
            'last_price_fraction_indicator::negative_ten': last_price_negative_ten_pair
            'last_price_fraction_indicator::negative_hundred': last_price_negative_hundred_pair
            'last_price_fraction_indicator::negative_thousand': last_price_negative_thousand_pair
            'last_price_fraction_indicator::negative_ten_thousand': last_price_negative_ten_thousand_pair
            'last_price_fraction_indicator::negative_hundred_thousand': last_price_negative_hundred_thousand_pair
            'last_price_fraction_indicator::negative_million': last_price_negative_million_pair
            _: last_price_numeric_pair
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Outstanding number of contracts in the series as of the previous day'
      - id: open_interest_date
        type: yymmdd_ascii_date
        doc: 'Open interest date'
      - id: tick
        type: u1
        enum: tick
        doc: 'Determined by the difference between last price and the previous different trade price'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_future_options_summary_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_future_options_summary_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_future_options_summary_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_future_options_summary_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_future_options_summary_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_future_options_summary_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_future_options_summary_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_future_options_summary_message_negative_million_pair
            _: net_change_future_options_summary_message_numeric_pair
      - id: opening_price_fraction_pair
        type:
          switch-on: peek_opening_price_fraction_indicator
          cases:
            'opening_price_fraction_indicator::negative_whole': opening_price_negative_whole_pair
            'opening_price_fraction_indicator::negative_ten': opening_price_negative_ten_pair
            'opening_price_fraction_indicator::negative_hundred': opening_price_negative_hundred_pair
            'opening_price_fraction_indicator::negative_thousand': opening_price_negative_thousand_pair
            'opening_price_fraction_indicator::negative_ten_thousand': opening_price_negative_ten_thousand_pair
            'opening_price_fraction_indicator::negative_hundred_thousand': opening_price_negative_hundred_thousand_pair
            'opening_price_fraction_indicator::negative_million': opening_price_negative_million_pair
            _: opening_price_numeric_pair
      - id: high_price_fraction_pair
        type:
          switch-on: peek_high_price_fraction_indicator
          cases:
            'high_price_fraction_indicator::negative_whole': high_price_negative_whole_pair
            'high_price_fraction_indicator::negative_ten': high_price_negative_ten_pair
            'high_price_fraction_indicator::negative_hundred': high_price_negative_hundred_pair
            'high_price_fraction_indicator::negative_thousand': high_price_negative_thousand_pair
            'high_price_fraction_indicator::negative_ten_thousand': high_price_negative_ten_thousand_pair
            'high_price_fraction_indicator::negative_hundred_thousand': high_price_negative_hundred_thousand_pair
            'high_price_fraction_indicator::negative_million': high_price_negative_million_pair
            _: high_price_numeric_pair
      - id: low_price_fraction_pair
        type:
          switch-on: peek_low_price_fraction_indicator
          cases:
            'low_price_fraction_indicator::negative_whole': low_price_negative_whole_pair
            'low_price_fraction_indicator::negative_ten': low_price_negative_ten_pair
            'low_price_fraction_indicator::negative_hundred': low_price_negative_hundred_pair
            'low_price_fraction_indicator::negative_thousand': low_price_negative_thousand_pair
            'low_price_fraction_indicator::negative_ten_thousand': low_price_negative_ten_thousand_pair
            'low_price_fraction_indicator::negative_hundred_thousand': low_price_negative_hundred_thousand_pair
            'low_price_fraction_indicator::negative_million': low_price_negative_million_pair
            _: low_price_numeric_pair
      - id: settlement_price_fraction_pair
        type:
          switch-on: peek_settlement_price_fraction_indicator
          cases:
            'settlement_price_fraction_indicator::negative_whole': settlement_price_negative_whole_pair
            'settlement_price_fraction_indicator::negative_ten': settlement_price_negative_ten_pair
            'settlement_price_fraction_indicator::negative_hundred': settlement_price_negative_hundred_pair
            'settlement_price_fraction_indicator::negative_thousand': settlement_price_negative_thousand_pair
            'settlement_price_fraction_indicator::negative_ten_thousand': settlement_price_negative_ten_thousand_pair
            'settlement_price_fraction_indicator::negative_hundred_thousand': settlement_price_negative_hundred_thousand_pair
            'settlement_price_fraction_indicator::negative_million': settlement_price_negative_million_pair
            _: settlement_price_numeric_pair
      - id: previous_settlement_price_fraction_pair
        type:
          switch-on: peek_previous_settlement_price_fraction_indicator
          cases:
            'previous_settlement_price_fraction_indicator::negative_whole': previous_settlement_price_negative_whole_pair
            'previous_settlement_price_fraction_indicator::negative_ten': previous_settlement_price_negative_ten_pair
            'previous_settlement_price_fraction_indicator::negative_hundred': previous_settlement_price_negative_hundred_pair
            'previous_settlement_price_fraction_indicator::negative_thousand': previous_settlement_price_negative_thousand_pair
            'previous_settlement_price_fraction_indicator::negative_ten_thousand': previous_settlement_price_negative_ten_thousand_pair
            'previous_settlement_price_fraction_indicator::negative_hundred_thousand': previous_settlement_price_negative_hundred_thousand_pair
            'previous_settlement_price_fraction_indicator::negative_million': previous_settlement_price_negative_million_pair
            _: previous_settlement_price_numeric_pair
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
    instances:
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: last_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
      peek_opening_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: opening_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: low_price_fraction_indicator
      peek_settlement_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: settlement_price_fraction_indicator
      peek_previous_settlement_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: previous_settlement_price_fraction_indicator
  net_change_future_options_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  opening_price_negative_whole_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  opening_price_negative_ten_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  opening_price_negative_hundred_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  opening_price_negative_thousand_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  opening_price_negative_ten_thousand_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  opening_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  opening_price_negative_million_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  opening_price_numeric_pair:
    seq:
      - id: opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_whole_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_ten_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_hundred_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_thousand_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_ten_thousand_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_million_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_numeric_pair:
    seq:
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_negative_whole_pair:
    seq:
      - id: raw_previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_negative_ten_pair:
    seq:
      - id: raw_previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_negative_hundred_pair:
    seq:
      - id: raw_previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_negative_thousand_pair:
    seq:
      - id: raw_previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_negative_ten_thousand_pair:
    seq:
      - id: raw_previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_negative_million_pair:
    seq:
      - id: raw_previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_settlement_price_numeric_pair:
    seq:
      - id: previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  futures_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: bid_price_summary_fraction_pair
        type:
          switch-on: peek_bid_price_fraction_indicator
          cases:
            'bid_price_fraction_indicator::negative_whole': bid_price_summary_negative_whole_pair
            'bid_price_fraction_indicator::negative_ten': bid_price_summary_negative_ten_pair
            'bid_price_fraction_indicator::negative_hundred': bid_price_summary_negative_hundred_pair
            'bid_price_fraction_indicator::negative_thousand': bid_price_summary_negative_thousand_pair
            'bid_price_fraction_indicator::negative_ten_thousand': bid_price_summary_negative_ten_thousand_pair
            'bid_price_fraction_indicator::negative_hundred_thousand': bid_price_summary_negative_hundred_thousand_pair
            'bid_price_fraction_indicator::negative_million': bid_price_summary_negative_million_pair
            _: bid_price_summary_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_summary_fraction_pair
        type:
          switch-on: peek_ask_price_fraction_indicator
          cases:
            'ask_price_fraction_indicator::negative_whole': ask_price_summary_negative_whole_pair
            'ask_price_fraction_indicator::negative_ten': ask_price_summary_negative_ten_pair
            'ask_price_fraction_indicator::negative_hundred': ask_price_summary_negative_hundred_pair
            'ask_price_fraction_indicator::negative_thousand': ask_price_summary_negative_thousand_pair
            'ask_price_fraction_indicator::negative_ten_thousand': ask_price_summary_negative_ten_thousand_pair
            'ask_price_fraction_indicator::negative_hundred_thousand': ask_price_summary_negative_hundred_thousand_pair
            'ask_price_fraction_indicator::negative_million': ask_price_summary_negative_million_pair
            _: ask_price_summary_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price_fraction_pair
        type:
          switch-on: peek_last_price_fraction_indicator
          cases:
            'last_price_fraction_indicator::negative_whole': last_price_negative_whole_pair
            'last_price_fraction_indicator::negative_ten': last_price_negative_ten_pair
            'last_price_fraction_indicator::negative_hundred': last_price_negative_hundred_pair
            'last_price_fraction_indicator::negative_thousand': last_price_negative_thousand_pair
            'last_price_fraction_indicator::negative_ten_thousand': last_price_negative_ten_thousand_pair
            'last_price_fraction_indicator::negative_hundred_thousand': last_price_negative_hundred_thousand_pair
            'last_price_fraction_indicator::negative_million': last_price_negative_million_pair
            _: last_price_numeric_pair
      - id: open_price_fraction_pair
        type:
          switch-on: peek_open_price_fraction_indicator
          cases:
            'open_price_fraction_indicator::negative_whole': open_price_negative_whole_pair
            'open_price_fraction_indicator::negative_ten': open_price_negative_ten_pair
            'open_price_fraction_indicator::negative_hundred': open_price_negative_hundred_pair
            'open_price_fraction_indicator::negative_thousand': open_price_negative_thousand_pair
            'open_price_fraction_indicator::negative_ten_thousand': open_price_negative_ten_thousand_pair
            'open_price_fraction_indicator::negative_hundred_thousand': open_price_negative_hundred_thousand_pair
            'open_price_fraction_indicator::negative_million': open_price_negative_million_pair
            _: open_price_numeric_pair
      - id: high_price_fraction_pair
        type:
          switch-on: peek_high_price_fraction_indicator
          cases:
            'high_price_fraction_indicator::negative_whole': high_price_negative_whole_pair
            'high_price_fraction_indicator::negative_ten': high_price_negative_ten_pair
            'high_price_fraction_indicator::negative_hundred': high_price_negative_hundred_pair
            'high_price_fraction_indicator::negative_thousand': high_price_negative_thousand_pair
            'high_price_fraction_indicator::negative_ten_thousand': high_price_negative_ten_thousand_pair
            'high_price_fraction_indicator::negative_hundred_thousand': high_price_negative_hundred_thousand_pair
            'high_price_fraction_indicator::negative_million': high_price_negative_million_pair
            _: high_price_numeric_pair
      - id: low_price_fraction_pair
        type:
          switch-on: peek_low_price_fraction_indicator
          cases:
            'low_price_fraction_indicator::negative_whole': low_price_negative_whole_pair
            'low_price_fraction_indicator::negative_ten': low_price_negative_ten_pair
            'low_price_fraction_indicator::negative_hundred': low_price_negative_hundred_pair
            'low_price_fraction_indicator::negative_thousand': low_price_negative_thousand_pair
            'low_price_fraction_indicator::negative_ten_thousand': low_price_negative_ten_thousand_pair
            'low_price_fraction_indicator::negative_hundred_thousand': low_price_negative_hundred_thousand_pair
            'low_price_fraction_indicator::negative_million': low_price_negative_million_pair
            _: low_price_numeric_pair
      - id: settlement_price_fraction_pair
        type:
          switch-on: peek_settlement_price_fraction_indicator
          cases:
            'settlement_price_fraction_indicator::negative_whole': settlement_price_negative_whole_pair
            'settlement_price_fraction_indicator::negative_ten': settlement_price_negative_ten_pair
            'settlement_price_fraction_indicator::negative_hundred': settlement_price_negative_hundred_pair
            'settlement_price_fraction_indicator::negative_thousand': settlement_price_negative_thousand_pair
            'settlement_price_fraction_indicator::negative_ten_thousand': settlement_price_negative_ten_thousand_pair
            'settlement_price_fraction_indicator::negative_hundred_thousand': settlement_price_negative_hundred_thousand_pair
            'settlement_price_fraction_indicator::negative_million': settlement_price_negative_million_pair
            _: settlement_price_numeric_pair
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_futures_summary_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_futures_summary_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_futures_summary_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_futures_summary_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_futures_summary_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_futures_summary_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_futures_summary_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_futures_summary_message_negative_million_pair
            _: net_change_futures_summary_message_numeric_pair
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: previous_settlement_fraction_pair
        type:
          switch-on: peek_previous_settlement_fraction_indicator
          cases:
            'previous_settlement_fraction_indicator::negative_whole': previous_settlement_negative_whole_pair
            'previous_settlement_fraction_indicator::negative_ten': previous_settlement_negative_ten_pair
            'previous_settlement_fraction_indicator::negative_hundred': previous_settlement_negative_hundred_pair
            'previous_settlement_fraction_indicator::negative_thousand': previous_settlement_negative_thousand_pair
            'previous_settlement_fraction_indicator::negative_ten_thousand': previous_settlement_negative_ten_thousand_pair
            'previous_settlement_fraction_indicator::negative_hundred_thousand': previous_settlement_negative_hundred_thousand_pair
            'previous_settlement_fraction_indicator::negative_million': previous_settlement_negative_million_pair
            _: previous_settlement_numeric_pair
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous day’s outstanding number of contracts in the series Refer to Indicator Code'
      - id: open_interest_date
        type: yymmdd_ascii_date
        doc: 'Open interest date'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
      - id: external_price_at_source_fraction_pair
        type:
          switch-on: peek_external_price_fraction_indicator
          cases:
            'external_price_fraction_indicator::negative_whole': external_price_at_source_negative_whole_pair
            'external_price_fraction_indicator::negative_ten': external_price_at_source_negative_ten_pair
            'external_price_fraction_indicator::negative_hundred': external_price_at_source_negative_hundred_pair
            'external_price_fraction_indicator::negative_thousand': external_price_at_source_negative_thousand_pair
            'external_price_fraction_indicator::negative_ten_thousand': external_price_at_source_negative_ten_thousand_pair
            'external_price_fraction_indicator::negative_hundred_thousand': external_price_at_source_negative_hundred_thousand_pair
            'external_price_fraction_indicator::negative_million': external_price_at_source_negative_million_pair
            _: external_price_at_source_numeric_pair
    instances:
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: last_price_fraction_indicator
      peek_open_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: open_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: low_price_fraction_indicator
      peek_settlement_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: settlement_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
      peek_previous_settlement_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: previous_settlement_fraction_indicator
      peek_external_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: external_price_fraction_indicator
  net_change_futures_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  previous_settlement_negative_whole_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  previous_settlement_negative_ten_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  previous_settlement_negative_hundred_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  previous_settlement_negative_thousand_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  previous_settlement_negative_ten_thousand_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  previous_settlement_negative_hundred_thousand_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  previous_settlement_negative_million_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  previous_settlement_numeric_pair:
    seq:
      - id: previous_settlement
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
  external_price_at_source_negative_whole_pair:
    seq:
      - id: raw_external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  external_price_at_source_negative_ten_pair:
    seq:
      - id: raw_external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  external_price_at_source_negative_hundred_pair:
    seq:
      - id: raw_external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  external_price_at_source_negative_thousand_pair:
    seq:
      - id: raw_external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  external_price_at_source_negative_ten_thousand_pair:
    seq:
      - id: raw_external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  external_price_at_source_negative_hundred_thousand_pair:
    seq:
      - id: raw_external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  external_price_at_source_negative_million_pair:
    seq:
      - id: raw_external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  external_price_at_source_numeric_pair:
    seq:
      - id: external_price_at_source
        type: str
        size: 7
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
        doc: 'Fraction indicator for last price obtained from external pricing source'
  strategy_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy The legs are defined in message type JS Alphanumeric with “.”,”+”,”-“'
      - id: bid_price_sign
        type: u1
        enum: bid_price_sign
        doc: 'For Bid Price field'
      - id: bid_price_summary_fraction_pair
        type:
          switch-on: peek_bid_price_fraction_indicator
          cases:
            'bid_price_fraction_indicator::negative_whole': bid_price_summary_negative_whole_pair
            'bid_price_fraction_indicator::negative_ten': bid_price_summary_negative_ten_pair
            'bid_price_fraction_indicator::negative_hundred': bid_price_summary_negative_hundred_pair
            'bid_price_fraction_indicator::negative_thousand': bid_price_summary_negative_thousand_pair
            'bid_price_fraction_indicator::negative_ten_thousand': bid_price_summary_negative_ten_thousand_pair
            'bid_price_fraction_indicator::negative_hundred_thousand': bid_price_summary_negative_hundred_thousand_pair
            'bid_price_fraction_indicator::negative_million': bid_price_summary_negative_million_pair
            _: bid_price_summary_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price_summary_fraction_pair
        type:
          switch-on: peek_ask_price_fraction_indicator
          cases:
            'ask_price_fraction_indicator::negative_whole': ask_price_summary_negative_whole_pair
            'ask_price_fraction_indicator::negative_ten': ask_price_summary_negative_ten_pair
            'ask_price_fraction_indicator::negative_hundred': ask_price_summary_negative_hundred_pair
            'ask_price_fraction_indicator::negative_thousand': ask_price_summary_negative_thousand_pair
            'ask_price_fraction_indicator::negative_ten_thousand': ask_price_summary_negative_ten_thousand_pair
            'ask_price_fraction_indicator::negative_hundred_thousand': ask_price_summary_negative_hundred_thousand_pair
            'ask_price_fraction_indicator::negative_million': ask_price_summary_negative_million_pair
            _: ask_price_summary_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price_sign
        type: u1
        enum: last_price_sign
        doc: 'For the Last Price field'
      - id: last_price_fraction_pair
        type:
          switch-on: peek_last_price_fraction_indicator
          cases:
            'last_price_fraction_indicator::negative_whole': last_price_negative_whole_pair
            'last_price_fraction_indicator::negative_ten': last_price_negative_ten_pair
            'last_price_fraction_indicator::negative_hundred': last_price_negative_hundred_pair
            'last_price_fraction_indicator::negative_thousand': last_price_negative_thousand_pair
            'last_price_fraction_indicator::negative_ten_thousand': last_price_negative_ten_thousand_pair
            'last_price_fraction_indicator::negative_hundred_thousand': last_price_negative_hundred_thousand_pair
            'last_price_fraction_indicator::negative_million': last_price_negative_million_pair
            _: last_price_numeric_pair
      - id: open_price_sign
        type: u1
        enum: open_price_sign
        doc: 'For the Open Price field'
      - id: open_price_fraction_pair
        type:
          switch-on: peek_open_price_fraction_indicator
          cases:
            'open_price_fraction_indicator::negative_whole': open_price_negative_whole_pair
            'open_price_fraction_indicator::negative_ten': open_price_negative_ten_pair
            'open_price_fraction_indicator::negative_hundred': open_price_negative_hundred_pair
            'open_price_fraction_indicator::negative_thousand': open_price_negative_thousand_pair
            'open_price_fraction_indicator::negative_ten_thousand': open_price_negative_ten_thousand_pair
            'open_price_fraction_indicator::negative_hundred_thousand': open_price_negative_hundred_thousand_pair
            'open_price_fraction_indicator::negative_million': open_price_negative_million_pair
            _: open_price_numeric_pair
      - id: high_price_sign
        type: u1
        enum: high_price_sign
        doc: 'For the High Price field'
      - id: high_price_fraction_pair
        type:
          switch-on: peek_high_price_fraction_indicator
          cases:
            'high_price_fraction_indicator::negative_whole': high_price_negative_whole_pair
            'high_price_fraction_indicator::negative_ten': high_price_negative_ten_pair
            'high_price_fraction_indicator::negative_hundred': high_price_negative_hundred_pair
            'high_price_fraction_indicator::negative_thousand': high_price_negative_thousand_pair
            'high_price_fraction_indicator::negative_ten_thousand': high_price_negative_ten_thousand_pair
            'high_price_fraction_indicator::negative_hundred_thousand': high_price_negative_hundred_thousand_pair
            'high_price_fraction_indicator::negative_million': high_price_negative_million_pair
            _: high_price_numeric_pair
      - id: low_price_sign
        type: u1
        enum: low_price_sign
        doc: 'For the Low Price field'
      - id: low_price_fraction_pair
        type:
          switch-on: peek_low_price_fraction_indicator
          cases:
            'low_price_fraction_indicator::negative_whole': low_price_negative_whole_pair
            'low_price_fraction_indicator::negative_ten': low_price_negative_ten_pair
            'low_price_fraction_indicator::negative_hundred': low_price_negative_hundred_pair
            'low_price_fraction_indicator::negative_thousand': low_price_negative_thousand_pair
            'low_price_fraction_indicator::negative_ten_thousand': low_price_negative_ten_thousand_pair
            'low_price_fraction_indicator::negative_hundred_thousand': low_price_negative_hundred_thousand_pair
            'low_price_fraction_indicator::negative_million': low_price_negative_million_pair
            _: low_price_numeric_pair
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_strategy_summary_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_strategy_summary_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_strategy_summary_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_strategy_summary_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_strategy_summary_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_strategy_summary_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_strategy_summary_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_strategy_summary_message_negative_million_pair
            _: net_change_strategy_summary_message_numeric_pair
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
    instances:
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: last_price_fraction_indicator
      peek_open_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: open_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: low_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
  net_change_strategy_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  option_initial_and_improvement_order_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Indicates the side of the initial order'
      - id: order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of an improvement order'
      - id: order_price_fraction_pair
        type:
          switch-on: peek_order_price_fraction_indicator
          cases:
            'order_price_fraction_indicator::negative_whole': order_price_negative_whole_pair
            'order_price_fraction_indicator::negative_ten': order_price_negative_ten_pair
            'order_price_fraction_indicator::negative_hundred': order_price_negative_hundred_pair
            'order_price_fraction_indicator::negative_thousand': order_price_negative_thousand_pair
            'order_price_fraction_indicator::negative_ten_thousand': order_price_negative_ten_thousand_pair
            'order_price_fraction_indicator::negative_hundred_thousand': order_price_negative_hundred_thousand_pair
            'order_price_fraction_indicator::negative_million': order_price_negative_million_pair
            _: order_price_numeric_pair
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Allocated by the trading engine at each valid order entry'
      - id: previous_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Order Id of the order modified'
    instances:
      peek_order_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: order_price_fraction_indicator
  order_price_negative_whole_pair:
    seq:
      - id: raw_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  order_price_negative_ten_pair:
    seq:
      - id: raw_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  order_price_negative_hundred_pair:
    seq:
      - id: raw_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  order_price_negative_thousand_pair:
    seq:
      - id: raw_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  order_price_negative_ten_thousand_pair:
    seq:
      - id: raw_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  order_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  order_price_negative_million_pair:
    seq:
      - id: raw_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  order_price_numeric_pair:
    seq:
      - id: order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: u1
        enum: order_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strategy_initial_and_improvement_order_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Indicates the side of the initial order'
      - id: order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of an improvement order'
      - id: order_price_fraction_pair
        type:
          switch-on: peek_order_price_fraction_indicator
          cases:
            'order_price_fraction_indicator::negative_whole': order_price_negative_whole_pair
            'order_price_fraction_indicator::negative_ten': order_price_negative_ten_pair
            'order_price_fraction_indicator::negative_hundred': order_price_negative_hundred_pair
            'order_price_fraction_indicator::negative_thousand': order_price_negative_thousand_pair
            'order_price_fraction_indicator::negative_ten_thousand': order_price_negative_ten_thousand_pair
            'order_price_fraction_indicator::negative_hundred_thousand': order_price_negative_hundred_thousand_pair
            'order_price_fraction_indicator::negative_million': order_price_negative_million_pair
            _: order_price_numeric_pair
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Allocated by the trading engine at each valid order entry'
      - id: previous_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Order Id of the order modified'
    instances:
      peek_order_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: order_price_fraction_indicator
  beginning_of_options_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
  beginning_of_future_options_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
  beginning_of_futures_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
  beginning_of_strategy_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
  option_auction_ending_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
  strategy_auction_ending_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of an auction'
  futures_trade_correction_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price_fraction_pair
        type:
          switch-on: peek_trade_price_fraction_indicator
          cases:
            'trade_price_fraction_indicator::negative_whole': trade_price_negative_whole_pair
            'trade_price_fraction_indicator::negative_ten': trade_price_negative_ten_pair
            'trade_price_fraction_indicator::negative_hundred': trade_price_negative_hundred_pair
            'trade_price_fraction_indicator::negative_thousand': trade_price_negative_thousand_pair
            'trade_price_fraction_indicator::negative_ten_thousand': trade_price_negative_ten_thousand_pair
            'trade_price_fraction_indicator::negative_hundred_thousand': trade_price_negative_hundred_thousand_pair
            'trade_price_fraction_indicator::negative_million': trade_price_negative_million_pair
            _: trade_price_numeric_pair
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_futures_trade_correction_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_futures_trade_correction_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_futures_trade_correction_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_futures_trade_correction_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_futures_trade_correction_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_futures_trade_correction_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_futures_trade_correction_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_futures_trade_correction_message_negative_million_pair
            _: net_change_futures_trade_correction_message_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: net_change_fraction_indicator
  net_change_futures_trade_correction_message_negative_whole_pair:
    seq:
      - id: raw_net_change_futures_trade_correction_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_correction_message_negative_ten_pair:
    seq:
      - id: raw_net_change_futures_trade_correction_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_correction_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_futures_trade_correction_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_correction_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_futures_trade_correction_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_correction_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_futures_trade_correction_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_correction_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_futures_trade_correction_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_correction_message_negative_million_pair:
    seq:
      - id: raw_net_change_futures_trade_correction_message
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_trade_correction_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  group_status_message:
    seq:
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
        doc: 'Group status of the trading instrument'
  group_status_strategies_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: group_status
        type: u1
        enum: group_status
        doc: 'Group status of the trading instrument'
  future_deliverables_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: num_bond_definition
        type: str
        size: 2
        encoding: ASCII
        doc: 'Total number of contracts traded'
      - id: bond_definition
        type: bond_definition
        repeat: expr
        repeat-expr: num_bond_definition.to_i
        doc: 'Bond Definition'
  bond_definition:
    seq:
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond expiration'
      - id: coupon_fraction_pair
        type:
          switch-on: peek_coupon_fraction_indicator
          cases:
            'coupon_fraction_indicator::negative_whole': coupon_negative_whole_pair
            'coupon_fraction_indicator::negative_ten': coupon_negative_ten_pair
            'coupon_fraction_indicator::negative_hundred': coupon_negative_hundred_pair
            'coupon_fraction_indicator::negative_thousand': coupon_negative_thousand_pair
            'coupon_fraction_indicator::negative_ten_thousand': coupon_negative_ten_thousand_pair
            'coupon_fraction_indicator::negative_hundred_thousand': coupon_negative_hundred_thousand_pair
            'coupon_fraction_indicator::negative_million': coupon_negative_million_pair
            _: coupon_numeric_pair
      - id: outstanding_bond_value
        type: str
        size: 8
        encoding: ASCII
        doc: 'Outstanding amount'
      - id: conversion_factor_fraction_pair
        type:
          switch-on: peek_conversion_factor_fraction_indicator
          cases:
            'conversion_factor_fraction_indicator::negative_whole': conversion_factor_negative_whole_pair
            'conversion_factor_fraction_indicator::negative_ten': conversion_factor_negative_ten_pair
            'conversion_factor_fraction_indicator::negative_hundred': conversion_factor_negative_hundred_pair
            'conversion_factor_fraction_indicator::negative_thousand': conversion_factor_negative_thousand_pair
            'conversion_factor_fraction_indicator::negative_ten_thousand': conversion_factor_negative_ten_thousand_pair
            'conversion_factor_fraction_indicator::negative_hundred_thousand': conversion_factor_negative_hundred_thousand_pair
            'conversion_factor_fraction_indicator::negative_million': conversion_factor_negative_million_pair
            _: conversion_factor_numeric_pair
    instances:
      peek_coupon_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: coupon_fraction_indicator
      peek_conversion_factor_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: conversion_factor_fraction_indicator
  coupon_negative_whole_pair:
    seq:
      - id: raw_coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  coupon_negative_ten_pair:
    seq:
      - id: raw_coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  coupon_negative_hundred_pair:
    seq:
      - id: raw_coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  coupon_negative_thousand_pair:
    seq:
      - id: raw_coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  coupon_negative_ten_thousand_pair:
    seq:
      - id: raw_coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  coupon_negative_hundred_thousand_pair:
    seq:
      - id: raw_coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  coupon_negative_million_pair:
    seq:
      - id: raw_coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  coupon_numeric_pair:
    seq:
      - id: coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
        doc: 'Coupon rate decimal indicator'
  conversion_factor_negative_whole_pair:
    seq:
      - id: raw_conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  conversion_factor_negative_ten_pair:
    seq:
      - id: raw_conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  conversion_factor_negative_hundred_pair:
    seq:
      - id: raw_conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  conversion_factor_negative_thousand_pair:
    seq:
      - id: raw_conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  conversion_factor_negative_ten_thousand_pair:
    seq:
      - id: raw_conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  conversion_factor_negative_hundred_thousand_pair:
    seq:
      - id: raw_conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  conversion_factor_negative_million_pair:
    seq:
      - id: raw_conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  conversion_factor_numeric_pair:
    seq:
      - id: conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: u1
        enum: conversion_factor_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bulletins_message:
    seq:
      - id: reserved
        size: 1
        doc: 'Reserved for future use'
      - id: bulletin_type
        type: u1
        enum: bulletin_type
        doc: 'Bulletin Type'
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
        doc: 'Bulletin in textual form'
      - id: continue_marker
        type: u1
        enum: continue_marker
        doc: 'Continue Marker'
  special_text_bulletin:
    seq:
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
      - id: special_bulletin_contents
        type: str
        size: 49
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bulletin in textual form'
      - id: continue_marker
        type: u1
        enum: continue_marker
        doc: 'Continue Marker'
  end_of_sales_message:
    seq:
      - id: reserved
        size: 1
        doc: 'Reserved for future use'
      - id: time
        type: hhmmss_ascii_time
        doc: 'Time at which the message is transmitted. HHMMSS'
  tick_table_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: tick_table_name
        type: str
        size: 50
        encoding: ASCII
        doc: 'Tick Table name'
      - id: tick_table_short_name
        type: str
        size: 2
        encoding: ASCII
        doc: 'Tick Table short name'
      - id: num_tick_entry
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates the number of entries in the table (from 1 to 30)'
      - id: tick_entry
        type: tick_entry
        repeat: expr
        repeat-expr: num_tick_entry.to_i
        doc: 'Tick Entry'
  tick_entry:
    seq:
      - id: min_price_fraction_pair
        type:
          switch-on: peek_min_price_fraction_indicator
          cases:
            'min_price_fraction_indicator::negative_whole': min_price_negative_whole_pair
            'min_price_fraction_indicator::negative_ten': min_price_negative_ten_pair
            'min_price_fraction_indicator::negative_hundred': min_price_negative_hundred_pair
            'min_price_fraction_indicator::negative_thousand': min_price_negative_thousand_pair
            'min_price_fraction_indicator::negative_ten_thousand': min_price_negative_ten_thousand_pair
            'min_price_fraction_indicator::negative_hundred_thousand': min_price_negative_hundred_thousand_pair
            'min_price_fraction_indicator::negative_million': min_price_negative_million_pair
            _: min_price_numeric_pair
      - id: tick_price_fraction_pair
        type:
          switch-on: peek_tick_price_fraction_indicator
          cases:
            'tick_price_fraction_indicator::negative_whole': tick_price_negative_whole_pair
            'tick_price_fraction_indicator::negative_ten': tick_price_negative_ten_pair
            'tick_price_fraction_indicator::negative_hundred': tick_price_negative_hundred_pair
            'tick_price_fraction_indicator::negative_thousand': tick_price_negative_thousand_pair
            'tick_price_fraction_indicator::negative_ten_thousand': tick_price_negative_ten_thousand_pair
            'tick_price_fraction_indicator::negative_hundred_thousand': tick_price_negative_hundred_thousand_pair
            'tick_price_fraction_indicator::negative_million': tick_price_negative_million_pair
            _: tick_price_numeric_pair
    instances:
      peek_min_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: min_price_fraction_indicator
      peek_tick_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: tick_price_fraction_indicator
  min_price_negative_whole_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  min_price_negative_ten_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  min_price_negative_hundred_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  min_price_negative_thousand_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  min_price_negative_ten_thousand_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  min_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  min_price_negative_million_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  min_price_numeric_pair:
    seq:
      - id: min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_negative_whole_pair:
    seq:
      - id: raw_tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_negative_ten_pair:
    seq:
      - id: raw_tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_negative_hundred_pair:
    seq:
      - id: raw_tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_negative_thousand_pair:
    seq:
      - id: raw_tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_negative_ten_thousand_pair:
    seq:
      - id: raw_tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_negative_hundred_thousand_pair:
    seq:
      - id: raw_tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_negative_million_pair:
    seq:
      - id: raw_tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  tick_price_numeric_pair:
    seq:
      - id: tick_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  end_of_transmission_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: time
        type: hhmmss_ascii_time
        doc: 'Time at which the message is transmitted. HHMMSS'
  circuit_assurance_message:
    seq:
      - id: time
        type: hhmmss_ascii_time
        doc: 'Time at which the message is transmitted. HHMMSS'
  start_of_day_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: business_date
        type: yyyymmdd_ascii_date
        doc: 'Current business date'
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
  yyyymmddhhmmss_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 14
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i
      hour:
        value: text.substring(8, 10).to_i
      minute:
        value: text.substring(10, 12).to_i
      second:
        value: text.substring(12, 14).to_i
  yymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 6
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 2).to_i
      month:
        value: text.substring(2, 4).to_i
      day:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
  strategy_type:
    0x43:
      id: 'classic'
      doc: 'Classic'
    0x53:
      id: 'strip'
      doc: 'Strip'
    0x56:
      id: 'covered_regular'
      doc: 'Covered Regular'
    0x52:
      id: 'covered_reference_fixed'
      doc: 'Covered Reference Fixed'
    0x55:
      id: 'covered_with_stock'
      doc: 'Covered With Stock'
  leg_ratio_or_delta_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
  leg_price_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
  initial_order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  initial_order_price_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
  closing_price_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
  previous_closing_price_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  order_price_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
  order_type:
    0x41:
      id: 'initial_order'
      doc: 'Initial Order'
    0x42:
      id: 'improvement_order'
      doc: 'Improvement Order'
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
  coupon_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
  conversion_factor_fraction_indicator:
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'
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
    0x5a:
      id: 'times_ten'
      doc: '10'
    0x59:
      id: 'times_hundred'
      doc: '100'
    0x58:
      id: 'times_thousand'
      doc: '1,000'
    0x57:
      id: 'times_ten_thousand'
      doc: '10,000'
    0x56:
      id: 'times_hundred_thousand'
      doc: '100,000'
    0x55:
      id: 'times_million'
      doc: '1,000,000'
    0x20:
      id: 'empty'
      doc: 'Empty'

