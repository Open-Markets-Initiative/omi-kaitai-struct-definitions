# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaMulticast Hsvf v1.11
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Multicast
#   Encoding: High Speed Vendor Feed
#   Version: 1.11
#   Date: 01/23/2019
#   Specification: MX SOLA HSVF Multicast Specifications Guide (1.11).pdf
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
  id: tmx_mx_solamulticast_hsvf_v1_11
  title: Tmx Mx SolaMulticast Hsvf v1.11
  license: GPL-3.0
  endian: be

doc: 'TMX Group Montreal Exchange Sola Multicast Hsvf v1.11'
doc-ref: https://www.tmxwebstore.com/products/mx-market-data

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
            '"CW"': swap_future_trade_message
            '"D"': option_rfq_message
            '"DB"': future_options_rfq_message
            '"DF"': futures_rfq_message
            '"DS"': strategy_rfq_message
            '"DW"': swap_future_rfq_message
            '"E"': instrument_schedule_notice_option_message
            '"EB"': instrument_schedule_notice_futures_option_message
            '"EF"': instrument_schedule_notice_future_message
            '"ES"': instrument_schedule_notice_strategy_message
            '"EW"': instrument_schedule_notice_swap_future_message
            '"F"': option_quote_message
            '"FB"': future_options_quote_message
            '"FF"': futures_quote_message
            '"FS"': strategy_quote_message
            '"FW"': swap_future_quote_message
            '"H"': option_market_depth_message
            '"HB"': future_options_market_depth_message
            '"HF"': futures_market_depth_message
            '"HS"': strategy_market_depth_message
            '"HW"': swap_future_market_depth_message
            '"I"': option_trade_cancellation_message
            '"IB"': future_options_trade_cancellation_message
            '"IF"': futures_trade_cancellation_message
            '"IS"': strategy_trade_cancellation_message
            '"IW"': swap_future_trade_cancellation_message
            '"J"': option_instrument_keys_message
            '"JB"': future_options_instrument_keys_message
            '"JE"': underlying_instrument_keys_message
            '"JF"': futures_instrument_keys_message
            '"JS"': strategy_instrument_keys_message
            '"JW"': swap_future_instrument_keys_message
            '"N"': option_summary_message
            '"NB"': future_options_summary_message
            '"NF"': futures_summary_message
            '"NS"': strategy_summary_message
            '"NW"': swap_future_summary_message
            '"Q"': beginning_of_options_summary_message
            '"QB"': beginning_of_future_options_summary_message
            '"QF"': beginning_of_futures_summary_message
            '"QS"': beginning_of_strategy_summary_message
            '"QW"': swap_future_beginning_of_summary_message
            '"X"': option_trade_correction_message
            '"XB"': future_options_trade_correction_message
            '"XF"': futures_trade_correction_message
            '"XS"': strategy_trade_correction_message
            '"XW"': swap_future_trade_correction_message
            '"GR"': group_status_message
            '"GS"': group_status_strategies_message
            '"L"': bulletins_message
            '"S"': end_of_sales_message
            '"TT"': tick_table_message
            '"U"': end_of_transmission_message
            '"V"': circuit_assurance_message
            '"Z"': timebeat_message
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
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series Updated on a trade by trade basis Refer to Indicator Code'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
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
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  strike_price_instrument_negative_whole_pair:
    seq:
      - id: raw_strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_instrument_negative_ten_pair:
    seq:
      - id: raw_strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_instrument_negative_hundred_pair:
    seq:
      - id: raw_strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_instrument_negative_thousand_pair:
    seq:
      - id: raw_strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_instrument_negative_ten_thousand_pair:
    seq:
      - id: raw_strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_instrument_negative_hundred_thousand_pair:
    seq:
      - id: raw_strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_instrument_negative_million_pair:
    seq:
      - id: raw_strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strike_price_instrument_numeric_pair:
    seq:
      - id: strike_price_instrument
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Outstanding number of contracts in the series as of previous day Refer to Indicator Code'
      - id: filler_2
        size: 2
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  net_change_future_options_trade_message_negative_whole_pair:
    seq:
      - id: raw_net_change_future_options_trade_message
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Futures series symbol'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
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
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  net_change_futures_trade_message_negative_whole_pair:
    seq:
      - id: raw_net_change_futures_trade_message
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
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
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  swap_future_trade_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol_swap_future
        type: str
        size: 6
        encoding: ASCII
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
      - id: trade_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Total number of contracts traded'
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
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
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
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  fixed_rate_negative_whole_pair:
    seq:
      - id: raw_fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  fixed_rate_negative_ten_pair:
    seq:
      - id: raw_fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  fixed_rate_negative_hundred_pair:
    seq:
      - id: raw_fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  fixed_rate_negative_thousand_pair:
    seq:
      - id: raw_fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  fixed_rate_negative_ten_thousand_pair:
    seq:
      - id: raw_fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  fixed_rate_negative_hundred_thousand_pair:
    seq:
      - id: raw_fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  fixed_rate_negative_million_pair:
    seq:
      - id: raw_fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  fixed_rate_numeric_pair:
    seq:
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: u1
        enum: fixed_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  option_rfq_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  future_options_rfq_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  futures_rfq_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol for the Future series'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
  strategy_rfq_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
  swap_future_rfq_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol_swap_future
        type: str
        size: 6
        encoding: ASCII
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
    instances:
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
  instrument_schedule_notice_option_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
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
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
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
        doc: 'Strike Price of the option in full'
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
        doc: 'Strike Price of the option in full'
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
        doc: 'Strike Price of the option in full'
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
        doc: 'Strike Price of the option in full'
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
        doc: 'Strike Price of the option in full'
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
        doc: 'Strike Price of the option in full'
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
        doc: 'Strike Price of the option in full'
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
        doc: 'Strike Price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  instrument_schedule_notice_futures_option_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  instrument_schedule_notice_future_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol for the Future Series'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
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
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
  instrument_schedule_notice_swap_future_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: hhmmss_ascii_time
        doc: 'Time at which the status change is scheduled. HHMMSS'
    instances:
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
  option_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  bid_price_quote_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: filler_1
        size: 1
        doc: 'Filler'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  futures_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol for the Future series'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
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
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  bid_price_quote_futures_quote_message_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
      - id: bid_price_sign
        type: u1
        enum: bid_price_sign
        doc: 'For Bid Price field'
      - id: bid_price_quote_strategy_quote_message
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_strategy_quote_message_opening_pair
            '"0"': bid_price_quote_strategy_quote_message_opening_pair
            '"A"': bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_whole_pair
            '"B"': bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_ten_pair
            '"C"': bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_hundred_pair
            '"D"': bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_thousand_pair
            '"E"': bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_million_pair
            _: bid_price_quote_strategy_quote_message_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of futures contracts represented by the Bid Price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price_quote_strategy_quote_message
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_strategy_quote_message_opening_pair
            '"0"': ask_price_quote_strategy_quote_message_opening_pair
            '"A"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_whole_pair
            '"B"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_ten_pair
            '"C"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_hundred_pair
            '"D"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_thousand_pair
            '"E"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_million_pair
            _: ask_price_quote_strategy_quote_message_numeric_pair
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
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  bid_price_quote_strategy_quote_message_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_strategy_quote_message_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid Price for the future contract'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_strategy_quote_message_opening_pair:
    seq:
      - id: ask_price_quote_opening
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_million_pair:
    seq:
      - id: raw_ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_quote_strategy_quote_message_numeric_pair:
    seq:
      - id: ask_price_quote_numeric
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  swap_future_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol_swap_future
        type: str
        size: 6
        encoding: ASCII
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
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
      - id: ask_price_quote_strategy_quote_message
        type:
          switch-on: peek_ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_strategy_quote_message_opening_pair
            '"0"': ask_price_quote_strategy_quote_message_opening_pair
            '"A"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_whole_pair
            '"B"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_ten_pair
            '"C"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_hundred_pair
            '"D"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_thousand_pair
            '"E"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_ten_thousand_pair
            '"F"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_hundred_thousand_pair
            '"G"': ask_price_quote_numeric_ask_price_quote_strategy_quote_message_numeric_pair_negative_million_pair
            _: ask_price_quote_strategy_quote_message_numeric_pair
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
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  option_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_option_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: option_market_depth_trading_instrument
        type: option_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_option_market_depth_trading_instrument.to_i
        doc: 'Option Market Depth Trading instrument'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  option_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
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
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
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
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  future_options_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_future_options_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: future_options_market_depth_trading_instrument
        type: future_options_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_future_options_market_depth_trading_instrument.to_i
        doc: 'Future Options Market Depth Trading instrument'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
  future_options_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
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
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
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
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  futures_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol for the Future series'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_futures_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: futures_market_depth_trading_instrument
        type: futures_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_futures_market_depth_trading_instrument.to_i
        doc: 'Futures Market Depth Trading instrument'
  futures_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote_futures_market_depth_trading_instrument
        type:
          switch-on: peek_bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_futures_market_depth_trading_instrument_opening_pair
            '"0"': bid_price_quote_futures_market_depth_trading_instrument_opening_pair
            '"A"': bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_whole_pair
            '"B"': bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_ten_pair
            '"C"': bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_hundred_pair
            '"D"': bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_thousand_pair
            '"E"': bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_ten_thousand_pair
            '"F"': bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_hundred_thousand_pair
            '"G"': bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_million_pair
            _: bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
      - id: ask_price_futures_depth_futures_market_depth_trading_instrument
        type:
          switch-on: peek_ask_price_futures_depth_opening
          cases:
            '"OUV"': ask_price_futures_depth_futures_market_depth_trading_instrument_opening_pair
            '"0"': ask_price_futures_depth_futures_market_depth_trading_instrument_opening_pair
            '"A"': ask_price_futures_depth_numeric_negative_whole_pair
            '"B"': ask_price_futures_depth_numeric_negative_ten_pair
            '"C"': ask_price_futures_depth_numeric_negative_hundred_pair
            '"D"': ask_price_futures_depth_numeric_negative_thousand_pair
            '"E"': ask_price_futures_depth_numeric_negative_ten_thousand_pair
            '"F"': ask_price_futures_depth_numeric_negative_hundred_thousand_pair
            '"G"': ask_price_futures_depth_numeric_negative_million_pair
            _: ask_price_futures_depth_futures_market_depth_trading_instrument_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_futures_depth_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  bid_price_quote_futures_market_depth_trading_instrument_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_whole_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_ten_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_hundred_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_ten_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_hundred_thousand_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair_negative_million_pair:
    seq:
      - id: raw_bid_price_quote_numeric_bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  bid_price_quote_futures_market_depth_trading_instrument_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the future contract For Implied, it represents the best (1st limit) indicative implied bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_futures_market_depth_trading_instrument_opening_pair:
    seq:
      - id: ask_price_futures_depth_opening
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
        encoding: ASCII
        doc: 'Ask Price for the future contract For Implied, it represents the best (1st limit) indicative implied ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  ask_price_futures_depth_futures_market_depth_trading_instrument_numeric_pair:
    seq:
      - id: ask_price_futures_depth_numeric
        type: str
        size: 6
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
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_strategy_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: strategy_market_depth_trading_instrument
        type: strategy_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_strategy_market_depth_trading_instrument.to_i
        doc: 'Strategy Market Depth Trading instrument'
  strategy_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
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
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
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
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  swap_future_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol_swap_future
        type: str
        size: 6
        encoding: ASCII
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_swap_future_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: swap_future_market_depth_trading_instrument
        type: swap_future_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_swap_future_market_depth_trading_instrument.to_i
        doc: 'Swap Future Market Depth Trading instrument'
    instances:
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
  swap_future_market_depth_trading_instrument:
    seq:
      - id: level
        type: u1
        enum: level
        doc: 'Level of market depth. 1 - 5 and A (Implied)'
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
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied bid orders making up the implied bid size at that implied bid price. If greater than 99-> the 2nd character becomes an exponent'
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
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book. For Implied, it represents the indicative number of implied ask orders making up the implied ask size at that implied ask price. If greater than 99, the 2nd character becomes an exponent'
    instances:
      peek_bid_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
      peek_ask_price_quote_opening:
        pos: _io.pos
        type: str
        size: 6
        encoding: ASCII
  option_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of cancellation transaction HHMMSSmmm'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Open long position of the option series, as of the trade Refer to Indicator Code'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
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
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
  future_options_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: price_fraction_pair
        type:
          switch-on: peek_price_fraction_indicator
          cases:
            'price_fraction_indicator::negative_whole': price_negative_whole_pair
            'price_fraction_indicator::negative_ten': price_negative_ten_pair
            'price_fraction_indicator::negative_hundred': price_negative_hundred_pair
            'price_fraction_indicator::negative_thousand': price_negative_thousand_pair
            'price_fraction_indicator::negative_ten_thousand': price_negative_ten_thousand_pair
            'price_fraction_indicator::negative_hundred_thousand': price_negative_hundred_thousand_pair
            'price_fraction_indicator::negative_million': price_negative_million_pair
            _: price_numeric_pair
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of cancellation transaction HHMMSSmmm'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Outstanding number of contracts in the series as of the previous day Refer to Indicator Code'
      - id: filler_2
        size: 2
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: price_fraction_indicator
  price_negative_whole_pair:
    seq:
      - id: raw_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_negative_ten_pair:
    seq:
      - id: raw_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_negative_hundred_pair:
    seq:
      - id: raw_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_negative_thousand_pair:
    seq:
      - id: raw_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_negative_ten_thousand_pair:
    seq:
      - id: raw_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_negative_hundred_thousand_pair:
    seq:
      - id: raw_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_negative_million_pair:
    seq:
      - id: raw_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_numeric_pair:
    seq:
      - id: price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  futures_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Futures series symbol'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of cancellation transaction HHMMSSmmm'
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
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
  strategy_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of cancellation transaction HHMMSSmmm'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
    instances:
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
  swap_future_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol_swap_future
        type: str
        size: 6
        encoding: ASCII
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
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
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of cancellation transaction HHMMSSmmm'
      - id: market_price_indicator
        type: u1
        enum: market_price_indicator
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
    instances:
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
  option_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency used for the Option Strike Price'
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
      - id: maximum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_options_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_options_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_options_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_options_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_options_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_options_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_options_negative_million_pair
            _: maximum_threshold_price_options_numeric_pair
      - id: minimum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_options_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_options_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_options_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_options_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_options_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_options_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_options_negative_million_pair
            _: minimum_threshold_price_options_numeric_pair
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
      - id: underlying_symbol_root_options
        type: str
        size: 10
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
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_increment_fraction_indicator
      peek_tick_value_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_value_fraction_indicator
  maximum_threshold_price_options_negative_whole_pair:
    seq:
      - id: raw_maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_options_negative_ten_pair:
    seq:
      - id: raw_maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_options_negative_hundred_pair:
    seq:
      - id: raw_maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_options_negative_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_options_negative_ten_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_options_negative_hundred_thousand_pair:
    seq:
      - id: raw_maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_options_negative_million_pair:
    seq:
      - id: raw_maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  maximum_threshold_price_options_numeric_pair:
    seq:
      - id: maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_negative_whole_pair:
    seq:
      - id: raw_minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_negative_ten_pair:
    seq:
      - id: raw_minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_negative_hundred_pair:
    seq:
      - id: raw_minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_negative_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_negative_ten_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_negative_hundred_thousand_pair:
    seq:
      - id: raw_minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_negative_million_pair:
    seq:
      - id: raw_minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  minimum_threshold_price_options_numeric_pair:
    seq:
      - id: minimum_threshold_price_options
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency used for the Option Strike Price'
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
      - id: maximum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_options_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_options_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_options_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_options_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_options_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_options_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_options_negative_million_pair
            _: maximum_threshold_price_options_numeric_pair
      - id: minimum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_options_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_options_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_options_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_options_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_options_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_options_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_options_negative_million_pair
            _: minimum_threshold_price_options_numeric_pair
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
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_increment_fraction_indicator
      peek_tick_value_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_value_fraction_indicator
  underlying_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
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
  futures_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Futures series symbol'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the contract The Expiry Day for the S&P/TSX futures contracts (SXA/SXB/SXH/SXF & SXY) is set up as the third Friday of the month in our system. But the real last trading day for these instruments is the day before the 3rd Friday of the month (the 3rd Thursday)'
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
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol root for the underlying security'
      - id: delivery_type
        type: u1
        enum: delivery_type
        doc: 'Indicates the delivery type of the instrument'
      - id: associated_product_root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Associated product’s class symbol'
      - id: associated_product_delivery_month
        type: u1
        enum: associated_product_delivery_month
        doc: 'Delivery month for the contract'
      - id: associated_product_delivery_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: associated_product_expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the option'
    instances:
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_increment_fraction_indicator
      peek_tick_value_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_value_fraction_indicator
  maximum_threshold_price_futures_negative_whole_pair:
    seq:
      - id: raw_maximum_threshold_price_futures
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  strategy_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
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
        doc: 'Last two digits of the option expiry year'
      - id: delivery_month_strategy
        type: str
        size: 1
        encoding: ASCII
        doc: 'Delivery month for the contract Refer to Month Codes'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the option'
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
      - id: maximum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_options_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_options_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_options_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_options_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_options_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_options_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_options_negative_million_pair
            _: maximum_threshold_price_options_numeric_pair
      - id: minimum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_options_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_options_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_options_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_options_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_options_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_options_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_options_negative_million_pair
            _: minimum_threshold_price_options_numeric_pair
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
    instances:
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_increment_fraction_indicator
  swap_future_instrument_keys_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
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
      - id: maximum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_maximum_threshold_price_fraction_indicator
          cases:
            'maximum_threshold_price_fraction_indicator::negative_whole': maximum_threshold_price_options_negative_whole_pair
            'maximum_threshold_price_fraction_indicator::negative_ten': maximum_threshold_price_options_negative_ten_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred': maximum_threshold_price_options_negative_hundred_pair
            'maximum_threshold_price_fraction_indicator::negative_thousand': maximum_threshold_price_options_negative_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_ten_thousand': maximum_threshold_price_options_negative_ten_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_hundred_thousand': maximum_threshold_price_options_negative_hundred_thousand_pair
            'maximum_threshold_price_fraction_indicator::negative_million': maximum_threshold_price_options_negative_million_pair
            _: maximum_threshold_price_options_numeric_pair
      - id: minimum_threshold_price_options_fraction_pair
        type:
          switch-on: peek_minimum_threshold_price_fraction_indicator
          cases:
            'minimum_threshold_price_fraction_indicator::negative_whole': minimum_threshold_price_options_negative_whole_pair
            'minimum_threshold_price_fraction_indicator::negative_ten': minimum_threshold_price_options_negative_ten_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred': minimum_threshold_price_options_negative_hundred_pair
            'minimum_threshold_price_fraction_indicator::negative_thousand': minimum_threshold_price_options_negative_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_ten_thousand': minimum_threshold_price_options_negative_ten_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_hundred_thousand': minimum_threshold_price_options_negative_hundred_thousand_pair
            'minimum_threshold_price_fraction_indicator::negative_million': minimum_threshold_price_options_negative_million_pair
            _: minimum_threshold_price_options_numeric_pair
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
            _: tick_increment_raw_pair
      - id: market_flow
        type: str
        size: 2
        encoding: ASCII
        doc: 'Defines the type of instruments'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: instrument_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument'
      - id: external_symbol
        type: str
        size: 30
        encoding: ASCII
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
      - id: effective_date
        type: yymmdd_ascii_date
        doc: 'The date when the swap contract becomes effective (YYMMDD)'
      - id: initial_effective_date
        type: yymmdd_ascii_date
        doc: 'The third Wednesday of the effective months (March, June, September, and December) (Quarterly IMM Dates (International Monetary Market Dates)). This date will be different from the Effective Date if it falls on a non-business date (YYMMDD)'
      - id: cash_flow_alignment_date
        type: yymmdd_ascii_date
        doc: 'The date used to set up the Payment and Reset Dates of the contract (YYMMDD)'
      - id: payment_frequency
        type: str
        size: 2
        encoding: ASCII
        doc: 'Frequency on which Payment Dates are defined'
      - id: reset_frequency
        type: str
        size: 2
        encoding: ASCII
        doc: 'Frequency on which Reset Dates are defined'
      - id: notional_principal_amount_fraction_pair
        type:
          switch-on: peek_notional_principal_amount_faction_indicator
          cases:
            'notional_principal_amount_faction_indicator::negative_whole': notional_principal_amount_negative_whole_pair
            'notional_principal_amount_faction_indicator::negative_ten': notional_principal_amount_negative_ten_pair
            'notional_principal_amount_faction_indicator::negative_hundred': notional_principal_amount_negative_hundred_pair
            'notional_principal_amount_faction_indicator::negative_thousand': notional_principal_amount_negative_thousand_pair
            'notional_principal_amount_faction_indicator::negative_ten_thousand': notional_principal_amount_negative_ten_thousand_pair
            'notional_principal_amount_faction_indicator::negative_hundred_thousand': notional_principal_amount_negative_hundred_thousand_pair
            'notional_principal_amount_faction_indicator::negative_million': notional_principal_amount_negative_million_pair
            _: notional_principal_amount_numeric_pair
      - id: day_count_convention
        type: u1
        enum: day_count_convention
        doc: 'Convention used in the swap future contract settlement price calculations:'
      - id: first_payment_date
        type: yymmdd_ascii_date
        doc: 'The date when the first payment is made (YYMMDD)'
      - id: next_payment_date
        type: yymmdd_ascii_date
        doc: 'The date when the next payment will be made (YYMMDD)'
      - id: first_reset_date
        type: yymmdd_ascii_date
        doc: 'The date when the floating rate is set for the first time (YYMMDD)'
      - id: next_reset_date
        type: yymmdd_ascii_date
        doc: 'The date when the next floating rate will be set (YYMMDD)'
      - id: previous_reset_date
        type: yymmdd_ascii_date
        doc: 'The date when the previous floating rate was set. When the current date is a Reset Date, the previous Reset Date will be the current date (YYMMDD)'
      - id: delivery_type
        type: u1
        enum: delivery_type
        doc: 'Indicates the delivery type of the instrument'
    instances:
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
      peek_maximum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      peek_minimum_threshold_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      peek_tick_increment_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_increment_fraction_indicator
      peek_tick_value_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_value_fraction_indicator
      peek_notional_principal_amount_faction_indicator:
        pos: _io.pos + 8
        type: u1
        enum: notional_principal_amount_faction_indicator
  notional_principal_amount_negative_whole_pair:
    seq:
      - id: raw_notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  notional_principal_amount_negative_ten_pair:
    seq:
      - id: raw_notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  notional_principal_amount_negative_hundred_pair:
    seq:
      - id: raw_notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  notional_principal_amount_negative_thousand_pair:
    seq:
      - id: raw_notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  notional_principal_amount_negative_ten_thousand_pair:
    seq:
      - id: raw_notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  notional_principal_amount_negative_hundred_thousand_pair:
    seq:
      - id: raw_notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  notional_principal_amount_negative_million_pair:
    seq:
      - id: raw_notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  notional_principal_amount_numeric_pair:
    seq:
      - id: notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: u1
        enum: notional_principal_amount_faction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  option_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
        doc: 'This field contains current outstanding number of contracts in the series. Updated on a trade by trade basis. Refer to Indicator Code'
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
      - id: underlying_symbol_root_options
        type: str
        size: 10
        encoding: ASCII
        doc: 'Symbol root for the underlying security'
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
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: last_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
      peek_open_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: open_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: low_price_fraction_indicator
      peek_settlement_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: settlement_price_fraction_indicator
      peek_previous_settlement_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: previous_settlement_price_fraction_indicator
  bid_price_summary_negative_whole_pair:
    seq:
      - id: raw_bid_price_summary
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  open_price_negative_whole_pair:
    seq:
      - id: raw_open_price
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_negative_whole_pair:
    seq:
      - id: raw_settlement_price
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  future_options_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: last_price_future_options_summary_message_fraction_pair
        type:
          switch-on: peek_last_price_fraction_indicator
          cases:
            'last_price_fraction_indicator::negative_whole': last_price_future_options_summary_message_negative_whole_pair
            'last_price_fraction_indicator::negative_ten': last_price_future_options_summary_message_negative_ten_pair
            'last_price_fraction_indicator::negative_hundred': last_price_future_options_summary_message_negative_hundred_pair
            'last_price_fraction_indicator::negative_thousand': last_price_future_options_summary_message_negative_thousand_pair
            'last_price_fraction_indicator::negative_ten_thousand': last_price_future_options_summary_message_negative_ten_thousand_pair
            'last_price_fraction_indicator::negative_hundred_thousand': last_price_future_options_summary_message_negative_hundred_thousand_pair
            'last_price_fraction_indicator::negative_million': last_price_future_options_summary_message_negative_million_pair
            _: last_price_future_options_summary_message_numeric_pair
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Outstanding number of contracts in the series as of the previous day'
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
      - id: filler_2
        size: 2
        doc: 'Filler'
      - id: underlying_symbol_root_future_options
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Base symbol of the underlying future'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_underlying
        type: str
        size: 1
        encoding: ASCII
        doc: 'Last digit of the delivery year of the underlying futures contract'
      - id: settlement_price_future_options_summary_message_fraction_pair
        type:
          switch-on: peek_settlement_price_fraction_indicator
          cases:
            'settlement_price_fraction_indicator::negative_whole': settlement_price_future_options_summary_message_negative_whole_pair
            'settlement_price_fraction_indicator::negative_ten': settlement_price_future_options_summary_message_negative_ten_pair
            'settlement_price_fraction_indicator::negative_hundred': settlement_price_future_options_summary_message_negative_hundred_pair
            'settlement_price_fraction_indicator::negative_thousand': settlement_price_future_options_summary_message_negative_thousand_pair
            'settlement_price_fraction_indicator::negative_ten_thousand': settlement_price_future_options_summary_message_negative_ten_thousand_pair
            'settlement_price_fraction_indicator::negative_hundred_thousand': settlement_price_future_options_summary_message_negative_hundred_thousand_pair
            'settlement_price_fraction_indicator::negative_million': settlement_price_future_options_summary_message_negative_million_pair
            _: settlement_price_future_options_summary_message_numeric_pair
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
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: last_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
      peek_opening_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: opening_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: low_price_fraction_indicator
      peek_settlement_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: settlement_price_fraction_indicator
      peek_previous_settlement_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: previous_settlement_price_fraction_indicator
  last_price_future_options_summary_message_negative_whole_pair:
    seq:
      - id: raw_last_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_future_options_summary_message_negative_ten_pair:
    seq:
      - id: raw_last_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_future_options_summary_message_negative_hundred_pair:
    seq:
      - id: raw_last_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_future_options_summary_message_negative_thousand_pair:
    seq:
      - id: raw_last_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_future_options_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_last_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_future_options_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_last_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_future_options_summary_message_negative_million_pair:
    seq:
      - id: raw_last_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  last_price_future_options_summary_message_numeric_pair:
    seq:
      - id: last_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_change_future_options_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_future_options_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  opening_price_negative_whole_pair:
    seq:
      - id: raw_opening_price
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_negative_whole_pair:
    seq:
      - id: raw_settlement_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_negative_ten_pair:
    seq:
      - id: raw_settlement_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_negative_hundred_pair:
    seq:
      - id: raw_settlement_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_negative_thousand_pair:
    seq:
      - id: raw_settlement_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_settlement_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_settlement_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_negative_million_pair:
    seq:
      - id: raw_settlement_price_future_options_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  settlement_price_future_options_summary_message_numeric_pair:
    seq:
      - id: settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  futures_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol for the Future Series'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
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
      - id: settlement_price_future_options_summary_message_fraction_pair
        type:
          switch-on: peek_settlement_price_fraction_indicator
          cases:
            'settlement_price_fraction_indicator::negative_whole': settlement_price_future_options_summary_message_negative_whole_pair
            'settlement_price_fraction_indicator::negative_ten': settlement_price_future_options_summary_message_negative_ten_pair
            'settlement_price_fraction_indicator::negative_hundred': settlement_price_future_options_summary_message_negative_hundred_pair
            'settlement_price_fraction_indicator::negative_thousand': settlement_price_future_options_summary_message_negative_thousand_pair
            'settlement_price_fraction_indicator::negative_ten_thousand': settlement_price_future_options_summary_message_negative_ten_thousand_pair
            'settlement_price_fraction_indicator::negative_hundred_thousand': settlement_price_future_options_summary_message_negative_hundred_thousand_pair
            'settlement_price_fraction_indicator::negative_million': settlement_price_future_options_summary_message_negative_million_pair
            _: settlement_price_future_options_summary_message_numeric_pair
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
        doc: 'Previous day''s outstanding number of contracts in the series Refer to Indicator Code'
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
        pos: _io.pos + 6
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: last_price_fraction_indicator
      peek_open_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: open_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: low_price_fraction_indicator
      peek_settlement_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: settlement_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
      peek_previous_settlement_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: previous_settlement_fraction_indicator
      peek_external_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: external_price_fraction_indicator
  net_change_futures_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_futures_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_futures_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last Trade Price - previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  previous_settlement_negative_whole_pair:
    seq:
      - id: raw_previous_settlement
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
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
      - id: num_strategy_summary_strategy_leg
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of legs in the strategy. 2 to 20'
      - id: strategy_summary_strategy_leg
        type: strategy_summary_strategy_leg
        repeat: expr
        repeat-expr: num_strategy_summary_strategy_leg.to_i
        doc: 'Strategy Summary Strategy Leg'
    instances:
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: last_price_fraction_indicator
      peek_open_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: open_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: low_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  net_change_strategy_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_strategy_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_strategy_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  strategy_summary_strategy_leg:
    seq:
      - id: leg_ratio_sign
        type: u1
        enum: leg_ratio_sign
        doc: 'Identification of the transaction in the strategy (buy or sell of the underlying)'
      - id: leg_ratio
        type: str
        size: 2
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy. 1 to 20'
      - id: leg_symbol
        type: str
        size: 30
        encoding: ASCII
        doc: 'Identification of the underlying (also referred to as HSVF Symbol)'
  swap_future_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
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
      - id: settlement_price_future_options_summary_message_fraction_pair
        type:
          switch-on: peek_settlement_price_fraction_indicator
          cases:
            'settlement_price_fraction_indicator::negative_whole': settlement_price_future_options_summary_message_negative_whole_pair
            'settlement_price_fraction_indicator::negative_ten': settlement_price_future_options_summary_message_negative_ten_pair
            'settlement_price_fraction_indicator::negative_hundred': settlement_price_future_options_summary_message_negative_hundred_pair
            'settlement_price_fraction_indicator::negative_thousand': settlement_price_future_options_summary_message_negative_thousand_pair
            'settlement_price_fraction_indicator::negative_ten_thousand': settlement_price_future_options_summary_message_negative_ten_thousand_pair
            'settlement_price_fraction_indicator::negative_hundred_thousand': settlement_price_future_options_summary_message_negative_hundred_thousand_pair
            'settlement_price_fraction_indicator::negative_million': settlement_price_future_options_summary_message_negative_million_pair
            _: settlement_price_future_options_summary_message_numeric_pair
      - id: net_present_value_a_fraction_pair
        type:
          switch-on: peek_net_present_value_fraction_indicator
          cases:
            'net_present_value_fraction_indicator::negative_whole': net_present_value_a_negative_whole_pair
            'net_present_value_fraction_indicator::negative_ten': net_present_value_a_negative_ten_pair
            'net_present_value_fraction_indicator::negative_hundred': net_present_value_a_negative_hundred_pair
            'net_present_value_fraction_indicator::negative_thousand': net_present_value_a_negative_thousand_pair
            'net_present_value_fraction_indicator::negative_ten_thousand': net_present_value_a_negative_ten_thousand_pair
            'net_present_value_fraction_indicator::negative_hundred_thousand': net_present_value_a_negative_hundred_thousand_pair
            'net_present_value_fraction_indicator::negative_million': net_present_value_a_negative_million_pair
            _: net_present_value_a_numeric_pair
      - id: historical_coupon_b_fraction_pair
        type:
          switch-on: peek_historical_coupon_fraction_indicator
          cases:
            'historical_coupon_fraction_indicator::negative_whole': historical_coupon_b_negative_whole_pair
            'historical_coupon_fraction_indicator::negative_ten': historical_coupon_b_negative_ten_pair
            'historical_coupon_fraction_indicator::negative_hundred': historical_coupon_b_negative_hundred_pair
            'historical_coupon_fraction_indicator::negative_thousand': historical_coupon_b_negative_thousand_pair
            'historical_coupon_fraction_indicator::negative_ten_thousand': historical_coupon_b_negative_ten_thousand_pair
            'historical_coupon_fraction_indicator::negative_hundred_thousand': historical_coupon_b_negative_hundred_thousand_pair
            'historical_coupon_fraction_indicator::negative_million': historical_coupon_b_negative_million_pair
            _: historical_coupon_b_numeric_pair
      - id: price_alignment_interest_c_fraction_pair
        type:
          switch-on: peek_price_alignment_interest_fraction_indicator
          cases:
            'price_alignment_interest_fraction_indicator::negative_whole': price_alignment_interest_c_negative_whole_pair
            'price_alignment_interest_fraction_indicator::negative_ten': price_alignment_interest_c_negative_ten_pair
            'price_alignment_interest_fraction_indicator::negative_hundred': price_alignment_interest_c_negative_hundred_pair
            'price_alignment_interest_fraction_indicator::negative_thousand': price_alignment_interest_c_negative_thousand_pair
            'price_alignment_interest_fraction_indicator::negative_ten_thousand': price_alignment_interest_c_negative_ten_thousand_pair
            'price_alignment_interest_fraction_indicator::negative_hundred_thousand': price_alignment_interest_c_negative_hundred_thousand_pair
            'price_alignment_interest_fraction_indicator::negative_million': price_alignment_interest_c_negative_million_pair
            _: price_alignment_interest_c_numeric_pair
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change_swap_future_summary_message_fraction_pair
        type:
          switch-on: peek_net_change_fraction_indicator
          cases:
            'net_change_fraction_indicator::negative_whole': net_change_swap_future_summary_message_negative_whole_pair
            'net_change_fraction_indicator::negative_ten': net_change_swap_future_summary_message_negative_ten_pair
            'net_change_fraction_indicator::negative_hundred': net_change_swap_future_summary_message_negative_hundred_pair
            'net_change_fraction_indicator::negative_thousand': net_change_swap_future_summary_message_negative_thousand_pair
            'net_change_fraction_indicator::negative_ten_thousand': net_change_swap_future_summary_message_negative_ten_thousand_pair
            'net_change_fraction_indicator::negative_hundred_thousand': net_change_swap_future_summary_message_negative_hundred_thousand_pair
            'net_change_fraction_indicator::negative_million': net_change_swap_future_summary_message_negative_million_pair
            _: net_change_swap_future_summary_message_numeric_pair
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
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
      - id: previous_reset_rate_fraction_pair
        type:
          switch-on: peek_previous_reset_rate_fraction_indicator
          cases:
            'previous_reset_rate_fraction_indicator::negative_whole': previous_reset_rate_negative_whole_pair
            'previous_reset_rate_fraction_indicator::negative_ten': previous_reset_rate_negative_ten_pair
            'previous_reset_rate_fraction_indicator::negative_hundred': previous_reset_rate_negative_hundred_pair
            'previous_reset_rate_fraction_indicator::negative_thousand': previous_reset_rate_negative_thousand_pair
            'previous_reset_rate_fraction_indicator::negative_ten_thousand': previous_reset_rate_negative_ten_thousand_pair
            'previous_reset_rate_fraction_indicator::negative_hundred_thousand': previous_reset_rate_negative_hundred_thousand_pair
            'previous_reset_rate_fraction_indicator::negative_million': previous_reset_rate_negative_million_pair
            _: previous_reset_rate_numeric_pair
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the swap Updated on a trade by trade basis Refer to Indicator Code'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
    instances:
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
      peek_bid_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: bid_price_fraction_indicator
      peek_ask_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: ask_price_fraction_indicator
      peek_last_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: last_price_fraction_indicator
      peek_open_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: open_price_fraction_indicator
      peek_high_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: high_price_fraction_indicator
      peek_low_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: low_price_fraction_indicator
      peek_settlement_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: settlement_price_fraction_indicator
      peek_net_present_value_fraction_indicator:
        pos: _io.pos + 11
        type: u1
        enum: net_present_value_fraction_indicator
      peek_historical_coupon_fraction_indicator:
        pos: _io.pos + 11
        type: u1
        enum: historical_coupon_fraction_indicator
      peek_price_alignment_interest_fraction_indicator:
        pos: _io.pos + 11
        type: u1
        enum: price_alignment_interest_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
      peek_previous_settlement_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: previous_settlement_price_fraction_indicator
      peek_previous_reset_rate_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: previous_reset_rate_fraction_indicator
  net_present_value_a_negative_whole_pair:
    seq:
      - id: raw_net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_present_value_a_negative_ten_pair:
    seq:
      - id: raw_net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_present_value_a_negative_hundred_pair:
    seq:
      - id: raw_net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_present_value_a_negative_thousand_pair:
    seq:
      - id: raw_net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_present_value_a_negative_ten_thousand_pair:
    seq:
      - id: raw_net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_present_value_a_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_present_value_a_negative_million_pair:
    seq:
      - id: raw_net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_present_value_a_numeric_pair:
    seq:
      - id: net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: u1
        enum: net_present_value_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_negative_whole_pair:
    seq:
      - id: raw_historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_negative_ten_pair:
    seq:
      - id: raw_historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_negative_hundred_pair:
    seq:
      - id: raw_historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_negative_thousand_pair:
    seq:
      - id: raw_historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_negative_ten_thousand_pair:
    seq:
      - id: raw_historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_negative_hundred_thousand_pair:
    seq:
      - id: raw_historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_negative_million_pair:
    seq:
      - id: raw_historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  historical_coupon_b_numeric_pair:
    seq:
      - id: historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: u1
        enum: historical_coupon_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_negative_whole_pair:
    seq:
      - id: raw_price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_negative_ten_pair:
    seq:
      - id: raw_price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_negative_hundred_pair:
    seq:
      - id: raw_price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_negative_thousand_pair:
    seq:
      - id: raw_price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_negative_ten_thousand_pair:
    seq:
      - id: raw_price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_negative_hundred_thousand_pair:
    seq:
      - id: raw_price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_negative_million_pair:
    seq:
      - id: raw_price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  price_alignment_interest_c_numeric_pair:
    seq:
      - id: price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: u1
        enum: price_alignment_interest_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  net_change_swap_future_summary_message_negative_whole_pair:
    seq:
      - id: raw_net_change_swap_future_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_swap_future_summary_message_negative_ten_pair:
    seq:
      - id: raw_net_change_swap_future_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_swap_future_summary_message_negative_hundred_pair:
    seq:
      - id: raw_net_change_swap_future_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_swap_future_summary_message_negative_thousand_pair:
    seq:
      - id: raw_net_change_swap_future_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_swap_future_summary_message_negative_ten_thousand_pair:
    seq:
      - id: raw_net_change_swap_future_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_swap_future_summary_message_negative_hundred_thousand_pair:
    seq:
      - id: raw_net_change_swap_future_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_swap_future_summary_message_negative_million_pair:
    seq:
      - id: raw_net_change_swap_future_summary_message
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  net_change_swap_future_summary_message_numeric_pair:
    seq:
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close Expiry month code of the swap future If no previous settlement price, then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
  previous_reset_rate_negative_whole_pair:
    seq:
      - id: raw_previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_reset_rate_negative_ten_pair:
    seq:
      - id: raw_previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_reset_rate_negative_hundred_pair:
    seq:
      - id: raw_previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_reset_rate_negative_thousand_pair:
    seq:
      - id: raw_previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_reset_rate_negative_ten_thousand_pair:
    seq:
      - id: raw_previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_reset_rate_negative_hundred_thousand_pair:
    seq:
      - id: raw_previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_reset_rate_negative_million_pair:
    seq:
      - id: raw_previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  previous_reset_rate_numeric_pair:
    seq:
      - id: previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: u1
        enum: previous_reset_rate_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
  beginning_of_options_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
  beginning_of_future_options_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
  beginning_of_futures_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
  beginning_of_strategy_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
  swap_future_beginning_of_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
  option_trade_correction_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series Updated on a trade by trade basis Refer to Indicator Code'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
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
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  future_options_trade_correction_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option base symbol (symbol of the underlying)'
      - id: contract_month_code
        type: u1
        enum: contract_month_code
        doc: 'Option month code'
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
      - id: call_put_code
        type: u1
        enum: call_put_code
        doc: 'C = Call, P = Put'
      - id: strike_price_instrument_fraction_pair
        type:
          switch-on: peek_strike_price_fraction_indicator
          cases:
            'strike_price_fraction_indicator::negative_whole': strike_price_instrument_negative_whole_pair
            'strike_price_fraction_indicator::negative_ten': strike_price_instrument_negative_ten_pair
            'strike_price_fraction_indicator::negative_hundred': strike_price_instrument_negative_hundred_pair
            'strike_price_fraction_indicator::negative_thousand': strike_price_instrument_negative_thousand_pair
            'strike_price_fraction_indicator::negative_ten_thousand': strike_price_instrument_negative_ten_thousand_pair
            'strike_price_fraction_indicator::negative_hundred_thousand': strike_price_instrument_negative_hundred_thousand_pair
            'strike_price_fraction_indicator::negative_million': strike_price_instrument_negative_million_pair
            _: strike_price_instrument_numeric_pair
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Outstanding number of contracts in the series as of previous day Refer to Indicator Code'
      - id: filler_2
        size: 2
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
    instances:
      peek_strike_price_fraction_indicator:
        pos: _io.pos + 7
        type: u1
        enum: strike_price_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  futures_trade_correction_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Futures series symbol'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month for the contract'
      - id: delivery_year_futures
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two last digits of the delivery year of the future series'
      - id: delivery_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Delivery day of the future series'
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
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
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  strategy_trade_correction_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
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
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
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
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  swap_future_trade_correction_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol_swap_future
        type: str
        size: 6
        encoding: ASCII
        doc: 'Swap future base symbol'
      - id: expiry_month_swap_future
        type: u1
        enum: expiry_month_swap_future
        doc: 'Expiry month code of the swap future Refer to Month Codes'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the expiry year of the swap future'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the swap future'
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate_fraction_pair
        type:
          switch-on: peek_fixed_rate_fraction_indicator
          cases:
            'fixed_rate_fraction_indicator::negative_whole': fixed_rate_negative_whole_pair
            'fixed_rate_fraction_indicator::negative_ten': fixed_rate_negative_ten_pair
            'fixed_rate_fraction_indicator::negative_hundred': fixed_rate_negative_hundred_pair
            'fixed_rate_fraction_indicator::negative_thousand': fixed_rate_negative_thousand_pair
            'fixed_rate_fraction_indicator::negative_ten_thousand': fixed_rate_negative_ten_thousand_pair
            'fixed_rate_fraction_indicator::negative_hundred_thousand': fixed_rate_negative_hundred_thousand_pair
            'fixed_rate_fraction_indicator::negative_million': fixed_rate_negative_million_pair
            _: fixed_rate_numeric_pair
      - id: trade_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Total number of contracts traded'
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
      - id: timestamp
        type: hhmmssmmm_ascii_time
        doc: 'Time of transaction (HHMMSSmmm)'
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
      peek_fixed_rate_fraction_indicator:
        pos: _io.pos + 5
        type: u1
        enum: fixed_rate_fraction_indicator
      peek_trade_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: trade_price_fraction_indicator
      peek_net_change_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: net_change_fraction_indicator
  group_status_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: root_symbol_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Root of the instrument group'
      - id: group_status
        type: u1
        enum: group_status
        doc: 'group status of the trading instrument'
  group_status_strategies_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: group_status
        type: u1
        enum: group_status
        doc: 'group status of the trading instrument'
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
        doc: 'Exchange on which the trade occurred Q = Montreal'
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
      - id: num_tick_entry_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates the number of entries in the table (from 1 to 30)'
      - id: tick_entry_group
        type: tick_entry_group
        repeat: expr
        repeat-expr: num_tick_entry_group.to_i
        doc: 'Tick Entry Group'
  tick_entry_group:
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
        pos: _io.pos + 6
        type: u1
        enum: min_price_fraction_indicator
      peek_tick_price_fraction_indicator:
        pos: _io.pos + 6
        type: u1
        enum: tick_price_fraction_indicator
  min_price_negative_whole_pair:
    seq:
      - id: raw_min_price
        type: str
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        size: 6
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
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: time
        type: hhmmss_ascii_time
        doc: 'Time at which the message is transmitted. HHMMSS'
  circuit_assurance_message:
    seq:
      - id: time
        type: hhmmss_ascii_time
        doc: 'Time at which the message is transmitted. HHMMSS'
  timebeat_message:
    seq:
      - id: time_with_milliseconds
        type: hhmmssmmm_ascii_time
        doc: 'Time at which the message is transmitted HHMMSSmmm'
  hhmmssmmm_ascii_time:
    seq:
      - id: text
        type: str
        size: 9
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
      millisecond:
        value: text.substring(6, 9).to_i
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
      id: 'asoftrade'
      doc: 'Asoftrade'
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
      doc: 'Reference price (volume field zero filled)'
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
  contract_month_code:
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
  delivery_month:
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
  trade_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  expiry_month_swap_future:
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
  fixed_rate_fraction_indicator:
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
      id: 'preopening_phase'
      doc: 'Preopening Phase'
    0x4f:
      id: 'opening_phase'
      doc: 'Opening Phase'
    0x54:
      id: 'opened_for_trading'
      doc: 'Opened For Trading'
    0x46:
      id: 'forbidden_phase'
      doc: 'Forbidden Phase'
    0x45:
      id: 'intervention_before_opening'
      doc: 'Intervention Before Opening'
    0x48:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x52:
      id: 'reserved_phase'
      doc: 'Reserved phase (goes into a state as pre-opening where orders can be sent, modified, or canceled)'
    0x53:
      id: 'suspended_phase'
      doc: 'Suspended phase (goes into a state as pre-opening where orders can be sent, modified, or cancelled)'
    0x5a:
      id: 'frozen'
      doc: 'Frozen. No longer in use.'
    0x41:
      id: 'surveillance_intervention_phase'
      doc: 'Surveillance Intervention phase (Consultation phase)'
    0x43:
      id: 'endof_day_inquiries_phase'
      doc: 'Endof Day Inquiries Phase'
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
      id: 'preopening_phase'
      doc: 'Preopening Phase'
    0x4f:
      id: 'opening_phase'
      doc: 'Opening Phase'
    0x54:
      id: 'opened_for_trading'
      doc: 'Opened For Trading'
    0x46:
      id: 'forbidden_phase'
      doc: 'Forbidden Phase'
    0x45:
      id: 'intervention_before_opening'
      doc: 'Intervention Before Opening'
    0x48:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x52:
      id: 'reserved_phase'
      doc: 'Reserved phase (goes into a state as pre-opening where orders can be sent, modified, or canceled)'
    0x53:
      id: 'suspended_phase'
      doc: 'Suspended phase (goes into a state as pre-opening where orders can be sent, modified, or cancelled)'
    0x5a:
      id: 'frozen'
      doc: 'Frozen. No longer in use.'
    0x41:
      id: 'surveillance_intervention_phase'
      doc: 'Surveillance Intervention phase (Consultation phase)'
    0x43:
      id: 'endof_day_inquiries_phase'
      doc: 'Endof Day Inquiries Phase'
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
  level:
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
  market_price_indicator:
    0x41:
      id: 'asoftrade'
      doc: 'Asoftrade'
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
      doc: 'Reference price (volume field zero filled)'
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
  associated_product_delivery_month:
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
  notional_principal_amount_faction_indicator:
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
  day_count_convention:
    0x41:
      id: 'act_365'
      doc: 'Act 365'
    0x42:
      id: 'act_360'
      doc: 'Act 360'
    0x43:
      id: 'thirty_360'
      doc: 'Thirty 360'
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
  leg_ratio_sign:
    0x2b:
      id: 'buy_of_the_underlying'
      doc: 'Buy Of The Underlying'
    0x2d:
      id: 'sell_of_the_underlying'
      doc: 'Sell Of The Underlying'
  net_present_value_fraction_indicator:
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
  historical_coupon_fraction_indicator:
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
  price_alignment_interest_fraction_indicator:
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
  previous_reset_rate_fraction_indicator:
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
  group_status:
    0x59:
      id: 'preopening_phase'
      doc: 'Preopening Phase'
    0x4f:
      id: 'opening_phase'
      doc: 'Opening Phase'
    0x54:
      id: 'opened_for_trading'
      doc: 'Opened For Trading'
    0x46:
      id: 'forbidden_phase'
      doc: 'Forbidden Phase'
    0x45:
      id: 'intervention_before_opening'
      doc: 'Intervention Before Opening'
    0x48:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x41:
      id: 'surveillance_intervention_phase'
      doc: 'Surveillance Intervention phase (Consultation phase)'
    0x43:
      id: 'endof_day_inquiries_phase'
      doc: 'Endof Day Inquiries Phase'
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

