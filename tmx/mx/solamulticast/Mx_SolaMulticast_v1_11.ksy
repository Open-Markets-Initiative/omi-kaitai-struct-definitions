# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaMulticast Hsvf v1.11
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Multicast
#   Encoding: High Speed Vender Feed
#   Version: 1.11
#   Date: 01/23/2019
#   Specification: hsvf-mx-005e-mx-sola-hsvf-multicast-specifications-guide-v1-11d5.pdf
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
doc-ref: https://www.tmxwebstore.com/

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
        '"GS"': strategies_message
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
  option_trade_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  future_options_trade_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: filler_2
        size: 2
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  futures_trade_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  strategy_trade_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol_strategy
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Trade Price field (sign)'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  swap_future_trade_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: trade_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Total number of contracts traded'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  option_rfq_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  future_options_rfq_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
      - id: requested_market_side
        type: u1
        enum: requested_market_side
        doc: 'Requested quote side'
  futures_rfq_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol_strategy
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike Price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the status change is scheduled. HHMMSS'
  instrument_schedule_notice_futures_option_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: series_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the status change is scheduled. HHMMSS'
  instrument_schedule_notice_future_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the status change is scheduled. HHMMSS'
  instrument_schedule_notice_strategy_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: series_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the status change is scheduled. HHMMSS'
  instrument_schedule_notice_swap_future_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: series_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the status change is scheduled. HHMMSS'
  option_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
  future_options_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
      - id: filler_1
        size: 1
        doc: 'Filler'
  futures_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
  strategy_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol_strategy
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Bid Price field'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Ask Price field'
      - id: ask_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
  swap_future_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
  option_market_depth_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
      - id: num_option_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: option_market_depth_trading_instrument
        type: option_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_option_market_depth_trading_instrument
        doc: 'Option Market Depth Trading instrument'
  option_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: str
        size: 1
        encoding: ASCII
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  future_options_market_depth_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
      - id: num_future_options_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: future_options_market_depth_trading_instrument
        type: future_options_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_future_options_market_depth_trading_instrument
        doc: 'Future Options Market Depth Trading instrument'
  future_options_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: str
        size: 1
        encoding: ASCII
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  futures_market_depth_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
      - id: num_futures_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: futures_market_depth_trading_instrument
        type: futures_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_futures_market_depth_trading_instrument
        doc: 'Futures Market Depth Trading instrument'
  futures_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: str
        size: 1
        encoding: ASCII
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  strategy_market_depth_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol_strategy
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
      - id: num_strategy_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: strategy_market_depth_trading_instrument
        type: strategy_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_strategy_market_depth_trading_instrument
        doc: 'Strategy Market Depth Trading instrument'
  strategy_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: str
        size: 1
        encoding: ASCII
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Bid Price field'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Ask Price field'
      - id: ask_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  swap_future_market_depth_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates instrument status'
      - id: num_swap_future_market_depth_trading_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: swap_future_market_depth_trading_instrument
        type: swap_future_market_depth_trading_instrument
        repeat: expr
        repeat-expr: num_swap_future_market_depth_trading_instrument
        doc: 'Swap Future Market Depth Trading instrument'
  swap_future_market_depth_trading_instrument:
    seq:
      - id: level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Level of market depth. 1 - 5 and A (Implied)'
      - id: bid_price_quote
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid price for the option series'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask price for the option series'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  option_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  future_options_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: filler_2
        size: 2
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  futures_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  strategy_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol_strategy
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Trade Price field (sign)'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  swap_future_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: market_price_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  option_instrument_keys_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 6
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
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
      - id: tick_value
        type: str
        size: 6
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  future_options_instrument_keys_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 6
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
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
      - id: tick_value
        type: str
        size: 6
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  underlying_instrument_keys_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
      - id: maximum_threshold_price_futures
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_futures
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 6
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
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
      - id: tick_value
        type: str
        size: 6
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        doc: 'Option symbol'
      - id: associated_product_delivery_month
        type: str
        size: 1
        encoding: ASCII
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
  strategy_instrument_keys_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
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
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Delivery month for the contract'
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
      - id: maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 6
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
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
  swap_future_instrument_keys_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: maximum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_options
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 6
        encoding: ASCII
        doc: 'Contains the Tick Table Short Name if available. If so, field starts with TT=. Otherwise, indicates precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'If Tick Increment starts with TT= (Table Name available), Fraction Indicator is blank. Otherwise, defines number of decimal places or fraction positions'
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
      - id: tick_value
        type: str
        size: 6
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the currency of an underlying'
      - id: effective_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the swap contract becomes effective (YYMMDD)'
      - id: initial_effective_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The third Wednesday of the effective months (March, June, September, and December) (Quarterly IMM Dates (International Monetary Market Dates)). This date will be different from the Effective Date if it falls on a non-business date (YYMMDD)'
      - id: cash_flow_alignment_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
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
      - id: notional_principal_amount
        type: str
        size: 8
        encoding: ASCII
        doc: 'Value of the contract'
      - id: notional_principal_amount_faction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: day_count_convention
        type: u1
        enum: day_count_convention
        doc: 'Convention used in the swap future contract settlement price calculations:'
      - id: first_payment_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the first payment is made (YYMMDD)'
      - id: next_payment_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the next payment will be made (YYMMDD)'
      - id: first_reset_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the floating rate is set for the first time (YYMMDD)'
      - id: next_reset_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the next floating rate will be set (YYMMDD)'
      - id: previous_reset_date
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the previous floating rate was set. When the current date is a Reset Date, the previous Reset Date will be the current date (YYMMDD)'
      - id: delivery_type
        type: u1
        enum: delivery_type
        doc: 'Indicates the delivery type of the instrument'
  option_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: bid_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: open_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator_options
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: previous_settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
  future_options_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: opening_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Delivery month for the contract'
      - id: delivery_year_underlying
        type: str
        size: 1
        encoding: ASCII
        doc: 'Last digit of the delivery year of the underlying futures contract'
      - id: settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator_futures
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: previous_settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
  futures_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
      - id: bid_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator_futures
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: previous_settlement
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price for the previous day'
      - id: previous_settlement_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the previous Settlement Price'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
      - id: external_price_at_source
        type: str
        size: 6
        encoding: ASCII
        doc: 'Last price obtained from an external pricing source'
      - id: external_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for last price obtained from external pricing source'
  strategy_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Bid Price field'
      - id: bid_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Ask Price field'
      - id: ask_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the Last Price field'
      - id: last_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the Open Price field'
      - id: open_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the High Price field'
      - id: high_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the Low Price field'
      - id: low_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
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
        repeat-expr: num_strategy_summary_strategy_leg
        doc: 'Strategy Summary Strategy Leg'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_summary
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator_futures
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_present_value_a
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the future (Floating cash flow - Fixed cash flow)'
      - id: net_present_value_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: historical_coupon_b
        type: str
        size: 11
        encoding: ASCII
        doc: 'Net present value of all cash flows in the past (Floating cash flow - Fixed cash flow)'
      - id: historical_coupon_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: price_alignment_interest_c
        type: str
        size: 11
        encoding: ASCII
        doc: 'Cumulative daily interest adjustment'
      - id: price_alignment_interest_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: previous_settlement_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: previous_reset_rate
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reset rate at the previous reset date'
      - id: previous_reset_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
  beginning_of_options_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
  beginning_of_future_options_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
  beginning_of_futures_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
  beginning_of_strategy_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
  swap_future_beginning_of_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
  option_trade_correction_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  future_options_trade_correction_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: contract_month_code
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains the outstanding number of contracts in the series'
      - id: filler_2
        size: 2
        doc: 'Filler'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  futures_trade_correction_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: delivery_month
        type: str
        size: 1
        encoding: ASCII
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
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  strategy_trade_correction_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: symbol_strategy
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Trade Price field (sign)'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  swap_future_trade_correction_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Expiry month code of the option'
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
      - id: tenor
        type: str
        size: 2
        encoding: ASCII
        doc: 'The tenor of the swap future'
      - id: fixed_rate
        type: str
        size: 5
        encoding: ASCII
        doc: 'The swap fixed rate'
      - id: fixed_rate_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: trade_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Total number of contracts traded'
      - id: trade_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of transaction (HHMMSSmmm)'
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  group_status_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol'
      - id: group_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'group status of the trading instrument'
  strategies_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'group of the instrument'
      - id: group_status
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Bulletin in textual form'
      - id: continue_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Continue Marker'
  special_text_bulletin:
    seq:
      - id: symbol_bulletin
        type: str
        size: 30
        encoding: ASCII
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
      - id: special_bulletin_contents
        type: str
        size: 49
        encoding: ASCII
        doc: 'Bulletin in textual form'
      - id: continue_marker
        type: str
        size: 1
        encoding: ASCII
        doc: 'Continue Marker'
  end_of_sales_message:
    seq:
      - id: reserved
        size: 1
        doc: 'Reserved for future use'
      - id: time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the message is transmitted. HHMMSS'
  tick_table_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
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
        repeat-expr: num_tick_entry_group
        doc: 'Tick Entry Group'
  tick_entry_group:
    seq:
      - id: min_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Used for this instrument if the price is higher than Min Price'
      - id: tick_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
  end_of_transmission_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Exchange on which the trade occurred Q = Montreal'
      - id: time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the message is transmitted. HHMMSS'
  circuit_assurance_message:
    seq:
      - id: time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the message is transmitted. HHMMSS'

enums:
  call_put_code:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
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
  option_type:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
  delivery_type:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x50:
      id: 'physical'
      doc: 'Physical'
  strategy_allow_implied:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
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
  tick:
    0x2b:
      id: 'uptick'
      doc: 'Uptick'
    0x2d:
      id: 'downtick'
      doc: 'Downtick'
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
  leg_ratio_sign:
    0x2b:
      id: 'buy_of_the_underlying'
      doc: 'Buy Of The Underlying'
    0x2d:
      id: 'sell_of_the_underlying'
      doc: 'Sell Of The Underlying'
  bulletin_type:
    0x31:
      id: 'regular_text_bulletin'
      doc: 'Regular Text Bulletin'
    0x32:
      id: 'special_text_bulletin'
      doc: 'Special Text Bulletin'

