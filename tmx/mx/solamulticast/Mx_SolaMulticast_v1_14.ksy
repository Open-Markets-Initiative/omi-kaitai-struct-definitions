# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaMulticast Hsvf v1.14
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Multicast
#   Encoding: High Speed Vender Feed
#   Version: 1.14
#   Date: 2/5/2024
#   Specification: hsvf-mx-005e-mx-sola-hsvf-multicast-specifications-guide-v1-14.pdf
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
  id: tmx_mx_solamulticast_hsvf_v1_14
  title: Tmx Mx SolaMulticast Hsvf v1.14
  license: GPL-3.0
  endian: be

doc: 'TMX Group Montreal Exchange Sola Multicast Hsvf v1.14'
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

types:
  message_header_struct:
    seq:
      - id: sequence_number
        type: str
        size: 10
        encoding: ASCII
        doc: 'Sequence numbers will range from ascii decimal 000000001 to 999999999'
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
        doc: 'System timestamp'
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
      - id: trade_price
        type: str
        size: 7
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
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
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
  option_symbol:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        doc: 'Option base symbol (symbol of the underlying)'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Contract expiry month from the first expiring leg'
      - id: strike_price
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
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
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
  future_option_symbol:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        doc: 'Option base symbol (symbol of the underlying)'
      - id: symbol_month
        type: str
        size: 1
        encoding: ASCII
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
      - id: strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: trade_price
        type: str
        size: 7
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
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
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
  future_product:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        doc: 'Option base symbol (symbol of the underlying)'
      - id: symbol_month
        type: str
        size: 1
        encoding: ASCII
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
  strategy_trade_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
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
        size: 7
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
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
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
  instrument_schedule_notice_option_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the status change is scheduled. HHMMSS'
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
        type: str
        size: 6
        encoding: ASCII
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
        type: str
        size: 6
        encoding: ASCII
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
        doc: 'Identification of the strategy. The legs (underlying) are defined in message type NS'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'Series status of the trading instrument'
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the status change is scheduled. HHMMSS'
  option_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: bid_price_quote
        type: str
        size: 7
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
        size: 7
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
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
  future_options_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: bid_price_quote
        type: str
        size: 7
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
        size: 7
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
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
  futures_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: bid_price_quote
        type: str
        size: 7
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
        size: 7
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
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
  strategy_quote_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
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
        size: 7
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
        size: 7
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
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote
        type: str
        size: 7
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
        size: 7
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
  strategy_market_depth_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: symbol_strategy
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the strategy. The legs (underlying) are defined in message type NS. Alphanumeric with ".", "+", "-"'
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
        size: 7
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
        size: 7
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
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  strategy_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
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
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 7
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
      - id: tick_value
        type: str
        size: 7
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
      - id: last_trading_datetime
        type: str
        size: 14
        encoding: ASCII
        doc: 'Indicates when the instrument stops trading'
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
        type: str
        size: 6
        encoding: ASCII
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
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 7
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
        size: 7
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
      - id: underlying_root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Root symbol of the underlying future'
      - id: underlying_symbol_month
        type: str
        size: 1
        encoding: ASCII
        doc: 'Symbol month of the underlying futures contract'
      - id: underlying_symbol_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last 2 digits of the symbol yearof the underlying futures contract'
      - id: last_trading_datetime
        type: str
        size: 14
        encoding: ASCII
        doc: 'Indicates when the instrument stops trading'
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
        type: str
        size: 6
        encoding: ASCII
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
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_instrument
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 7
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
        size: 7
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
        type: str
        size: 14
        encoding: ASCII
        doc: 'Indicates when the instrument stops trading'
  associated_product:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        doc: 'Option base symbol (symbol of the underlying)'
      - id: symbol_month
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Last two digits of the option expiry year'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Contract expiry month from the first expiring leg'
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
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_strategy
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 7
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
        type: str
        size: 14
        encoding: ASCII
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
      - id: leg_ratio_or_delta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Quantity (bought or sold) on underlying in the strategy'
      - id: leg_ratio_or_delta_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
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
      - id: initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: initial_order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Indicates the price of the initial order'
      - id: initial_order_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
  option_summary_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
      - id: bid_price_summary
        type: str
        size: 7
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
        size: 7
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
        size: 7
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
      - id: open_interest_date
        type: str
        size: 6
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 7
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
      - id: closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: closing_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: previous_closing_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_closing_price_fraction_indicator
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
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'Option on future symbology'
      - id: bid_price_summary
        type: str
        size: 7
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
        size: 7
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
        size: 7
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
      - id: open_interest_date
        type: str
        size: 6
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: previous_settlement_price
        type: str
        size: 7
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
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: future_product
        type: future_product
        doc: 'Future product symbology'
      - id: bid_price_summary
        type: str
        size: 7
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
        size: 7
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
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
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
        size: 7
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
        size: 7
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
      - id: open_interest_date
        type: str
        size: 6
        encoding: ASCII
        doc: 'Open interest date'
      - id: reason
        type: u1
        enum: reason
        doc: 'Indicates the reason of the summary message'
      - id: external_price_at_source
        type: str
        size: 7
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
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
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
        size: 7
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
        size: 7
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
        size: 7
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
        size: 7
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
        size: 7
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
        size: 7
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
        size: 7
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
      - id: order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: order_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'For a buy order, represents the highest price that the order issuer is willing to pay or for a sell order, represents the lowest price at which the order issuer is willing to sell'
      - id: order_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: trade_price
        type: str
        size: 7
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
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
  group_status_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: root
        type: str
        size: 6
        encoding: ASCII
        doc: 'Option base symbol (symbol of the underlying)'
      - id: group_status
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
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
      - id: coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Coupon rate decimal indicator'
      - id: outstanding_bond_value
        type: str
        size: 8
        encoding: ASCII
        doc: 'Outstanding amount'
      - id: conversion_factor
        type: str
        size: 7
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: conversion_factor_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
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
      - id: min_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Starting price for this tick entry'
      - id: min_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: tick_price
        type: str
        size: 7
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
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
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
  start_of_day_message:
    seq:
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'Exchange on which the trade occurred'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Current business date'

enums:
  exchange_id:
    0x51:
      id: 'montreal'
      doc: 'Montreal'
  expiry_month:
    0x41:
      id: 'january'
      doc: 'January'
    0x42:
      id: 'february'
      doc: 'February'
    0x43:
      id: 'march'
      doc: 'March'
    0x44:
      id: 'april'
      doc: 'April'
    0x45:
      id: 'may'
      doc: 'May'
    0x46:
      id: 'june'
      doc: 'June'
    0x47:
      id: 'july'
      doc: 'July'
    0x48:
      id: 'august'
      doc: 'August'
    0x49:
      id: 'september'
      doc: 'September'
    0x4a:
      id: 'october'
      doc: 'October'
    0x4b:
      id: 'november'
      doc: 'November'
    0x4c:
      id: 'december'
      doc: 'December'
  price_indicator_marker:
    0x41:
      id: 'asof_trade'
      doc: 'Asof Trade'
    0x42:
      id: 'block_trade'
      doc: 'Block Trade'
    0x20:
      id: 'transaction'
      doc: 'Transaction'
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
    0x50:
      id: 'strategy_reporting'
      doc: 'Strategy Reporting'
    0x52:
      id: 'efr_reporting'
      doc: 'Efr Reporting'
    0x53:
      id: 'reference_price'
      doc: 'Reference Price'
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
      doc: 'Goes Into A State As Preopening Where Orders Can Be Sent Modified Or Canceled'
    0x53:
      id: 'suspended'
      doc: 'Goes Into A State As Preopening Where Orders Can Be Sent Modified Or Cancelled'
    0x41:
      id: 'surveillance_intervention'
      doc: 'Consultation Phase'
    0x43:
      id: 'endof_day_inquiries'
      doc: 'Endof Day Inquiries'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
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
      doc: 'Goes Into A State As Preopening Where Orders Can Be Sent Modified Or Canceled'
    0x53:
      id: 'suspended'
      doc: 'Goes Into A State As Preopening Where Orders Can Be Sent Modified Or Cancelled'
    0x41:
      id: 'surveillance_intervention'
      doc: 'Consultation Phase'
    0x43:
      id: 'endof_day_inquiries'
      doc: 'Endof Day Inquiries'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
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
  initial_order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
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
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  order_type:
    0x41:
      id: 'initial_order'
      doc: 'Initial Order'
    0x42:
      id: 'improvement_order'
      doc: 'Improvement Order'
  bulletin_type:
    0x31:
      id: 'regular_text_bulletin'
      doc: 'Regular Text Bulletin'
    0x32:
      id: 'special_text_bulletin'
      doc: 'Special Text Bulletin'

