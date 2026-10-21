# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaTcpRetransmission Hsvf v1.13
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Tcp Retransmission
#   Encoding: High Speed Vendor Feed
#   Version: 1.13
#   Date: 10/5/2022
#   Specification: MX SOLA HSVF Multicast Specifications Guide (1.13.3).pdf
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
  id: tmx_mx_solatcpretransmission_hsvf_v1_13_server
  title: Tmx Mx SolaTcpRetransmission Hsvf v1.13
  license: GPL-3.0
  endian: be

doc: 'TMX Group Montreal Exchange Sola Tcp Retransmission Hsvf v1.13'
doc-ref: https://www.tmxwebstore.com

seq:
  - id: server_frame
    type: server_frame_struct
    terminator: 3
    repeat: eos
    doc: 'One Hsvf record, from STX through ETX'

types:
  server_frame_struct:
    seq:
      - id: hsvf_stx
        type: u1
        doc: 'Start of Hsvf message'
      - id: message_header
        type: message_header
        doc: 'Standard Hsvf message header'
      - id: server_message
        size-eos: true
        type:
          switch-on: message_header.message_type
          cases:
            '"ER"': error_message
            _: retransmitted_message
      - id: hsvf_etx
        type: u1
        doc: 'End of Hsvf message'
  message_header:
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
  error_message:
    seq:
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Error Code'
      - id: error_msg
        type: str
        size: 80
        encoding: ASCII
        doc: 'Error Message'
  retransmitted_message:
    seq:
      - id: message_timestamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'System timestamp, YYYYMMDDHHMMSSmmmuuu'
      - id: message_body
        type:
          switch-on: _parent.message_header.message_type
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
            '"KF"': future_deliverables_message
            '"L"': bulletins_message
            '"S"': end_of_sales_message
            '"TT"': tick_table_message
            '"U"': end_of_transmission_message
            '"V"': circuit_assurance_message
            '"SD"': start_of_day_message
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
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
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
        doc: 'Option expiry month code'
      - id: strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
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
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
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
      - id: strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
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
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
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
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price - previous close'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
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
        type: str
        size: 6
        encoding: ASCII
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
        doc: 'Option expiry month code'
      - id: strike_price_schedule_notice
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike price of the option in full'
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
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
        doc: 'Identifies the strategy The legs are defined in message type JS'
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
        doc: 'Exchange on which the quote occurred Q = Montreal'
      - id: option_symbol
        type: option_symbol
        doc: 'Option symbology'
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
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
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
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
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
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
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
      - id: bid_price_quote_futures_quote_message
        type:
          switch-on: bid_price_quote_futures_quote_message.bid_price_quote_futures_quote_message_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_futures_quote_message_opening_pair
            '"0"': bid_price_quote_futures_quote_message_opening_pair
            _: bid_price_quote_futures_quote_message_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of futures contracts represented by the Bid Price If size is greater than 99999, the 5th character becomes an exponent Refer to Indicator Code'
      - id: ask_price_quote_futures_quote_message
        type:
          switch-on: ask_price_quote_futures_quote_message.ask_price_quote_futures_quote_message_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_futures_quote_message_opening_pair
            '"0"': ask_price_quote_futures_quote_message_opening_pair
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
      - id: bid_price_quote_strategy_quote_message
        type:
          switch-on: bid_price_quote_strategy_quote_message.bid_price_quote_strategy_quote_message_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_strategy_quote_message_opening_pair
            '"0"': bid_price_quote_strategy_quote_message_opening_pair
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
          switch-on: ask_price_quote_strategy_quote_message.ask_price_quote_strategy_quote_message_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_strategy_quote_message_opening_pair
            '"0"': ask_price_quote_strategy_quote_message_opening_pair
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
  bid_price_quote_strategy_quote_message_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
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
        size: 7
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
        size: 7
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
        size: 7
        encoding: ASCII
        doc: 'Ask price for the future contract'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: num_option_market_depth_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument. 1 to 5'
      - id: option_market_depth_level
        type: option_market_depth_level
        repeat: expr
        repeat-expr: num_option_market_depth_level.to_i
        doc: 'Option Market Depth'
  option_market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote_option_market_depth_level
        type:
          switch-on: bid_price_quote_option_market_depth_level.bid_price_quote_option_market_depth_level_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_option_market_depth_level_opening_pair
            '"0"': bid_price_quote_option_market_depth_level_opening_pair
            _: bid_price_quote_option_market_depth_level_numeric_pair
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
      - id: ask_price_quote_option_market_depth_level
        type:
          switch-on: ask_price_quote_option_market_depth_level.ask_price_quote_option_market_depth_level_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_option_market_depth_level_opening_pair
            '"0"': ask_price_quote_option_market_depth_level_opening_pair
            _: ask_price_quote_option_market_depth_level_numeric_pair
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
  bid_price_quote_option_market_depth_level_opening_pair:
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
  bid_price_quote_option_market_depth_level_numeric_pair:
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
  ask_price_quote_option_market_depth_level_opening_pair:
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
  ask_price_quote_option_market_depth_level_numeric_pair:
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
  future_options_market_depth_trading_instrument:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth. 1 to 5 and A (Implied)'
      - id: bid_price_quote_future_options_market_depth_trading_instrument
        type:
          switch-on: bid_price_quote_future_options_market_depth_trading_instrument.bid_price_quote_future_options_market_depth_trading_instrument_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_future_options_market_depth_trading_instrument_opening_pair
            '"0"': bid_price_quote_future_options_market_depth_trading_instrument_opening_pair
            _: bid_price_quote_future_options_market_depth_trading_instrument_numeric_pair
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
      - id: ask_price_quote_future_options_market_depth_trading_instrument
        type:
          switch-on: ask_price_quote_future_options_market_depth_trading_instrument.ask_price_quote_future_options_market_depth_trading_instrument_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_future_options_market_depth_trading_instrument_opening_pair
            '"0"': ask_price_quote_future_options_market_depth_trading_instrument_opening_pair
            _: ask_price_quote_future_options_market_depth_trading_instrument_numeric_pair
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
  bid_price_quote_future_options_market_depth_trading_instrument_opening_pair:
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
  bid_price_quote_future_options_market_depth_trading_instrument_numeric_pair:
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
  ask_price_quote_future_options_market_depth_trading_instrument_opening_pair:
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
  ask_price_quote_future_options_market_depth_trading_instrument_numeric_pair:
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
          switch-on: bid_price_quote_futures_market_depth_trading_instrument.bid_price_quote_futures_market_depth_trading_instrument_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_futures_market_depth_trading_instrument_opening_pair
            '"0"': bid_price_quote_futures_market_depth_trading_instrument_opening_pair
            _: bid_price_quote_futures_market_depth_trading_instrument_numeric_pair
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
      - id: ask_price_futures_depth_futures_market_depth_trading_instrument
        type:
          switch-on: ask_price_futures_depth_futures_market_depth_trading_instrument.ask_price_futures_depth_futures_market_depth_trading_instrument_opening_pair.ask_price_futures_depth_opening
          cases:
            '"OUV"': ask_price_futures_depth_futures_market_depth_trading_instrument_opening_pair
            '"0"': ask_price_futures_depth_futures_market_depth_trading_instrument_opening_pair
            _: ask_price_futures_depth_futures_market_depth_trading_instrument_numeric_pair
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
  bid_price_quote_futures_market_depth_trading_instrument_opening_pair:
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
  bid_price_quote_futures_market_depth_trading_instrument_numeric_pair:
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
  ask_price_futures_depth_futures_market_depth_trading_instrument_opening_pair:
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
  ask_price_futures_depth_futures_market_depth_trading_instrument_numeric_pair:
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
      - id: bid_price_quote_strategy_market_depth_trading_instrument
        type:
          switch-on: bid_price_quote_strategy_market_depth_trading_instrument.bid_price_quote_strategy_market_depth_trading_instrument_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_strategy_market_depth_trading_instrument_opening_pair
            '"0"': bid_price_quote_strategy_market_depth_trading_instrument_opening_pair
            _: bid_price_quote_strategy_market_depth_trading_instrument_numeric_pair
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
      - id: ask_price_quote_strategy_market_depth_trading_instrument
        type:
          switch-on: ask_price_quote_strategy_market_depth_trading_instrument.ask_price_quote_strategy_market_depth_trading_instrument_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_strategy_market_depth_trading_instrument_opening_pair
            '"0"': ask_price_quote_strategy_market_depth_trading_instrument_opening_pair
            _: ask_price_quote_strategy_market_depth_trading_instrument_numeric_pair
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
  bid_price_quote_strategy_market_depth_trading_instrument_opening_pair:
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
  bid_price_quote_strategy_market_depth_trading_instrument_numeric_pair:
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
  ask_price_quote_strategy_market_depth_trading_instrument_opening_pair:
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
  ask_price_quote_strategy_market_depth_trading_instrument_numeric_pair:
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
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
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
        type: u1
        enum: price_fraction_indicator
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
        type: u1
        enum: trade_price_fraction_indicator
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
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price at which the transaction took place'
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Unique Trade Number for this instrument'
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
      - id: maximum_threshold_price_options
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_options
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
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
        doc: 'Expiry Date, YYMMDD'
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
      - id: maximum_threshold_price_options
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_options
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
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
        type: u1
        enum: underlying_symbol_month
        doc: 'Symbol month of the underlying futures contract'
      - id: underlying_symbol_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last 2digits of the symbol yearof the underlying futures contract'
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
        doc: 'Expiry Date, YYMMDD'
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
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
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
      - id: tick_value
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exchange premium multiplier for derivatives with a contract size equal to 1. All derivatives with a contract size > 1 will have a tick value defaulted to 1'
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
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
        doc: 'Contract expiry month from the first expiring leg'
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
      - id: maximum_threshold_price_options
        type: str
        size: 7
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price_options
        type: str
        size: 7
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
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
        type: str
        size: 14
        encoding: ASCII
        doc: 'Indicates when the instrument stops trading'
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
        type: u1
        enum: leg_ratio_or_delta_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: leg_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Significant if the leg is a fixed leg of a covered strategy'
      - id: leg_price_fraction_indicator
        type: u1
        enum: leg_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
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
        type: u1
        enum: bid_price_fraction_indicator
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
        type: u1
        enum: ask_price_fraction_indicator
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
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'This field contains current outstanding number of contracts in the series Updated on a trade by trade basis Refer to Indicator Code'
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
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price Net change will be zero if the option did not trade on the last business day or did not trade today'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: option_marker
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Refer to Options Markers'
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
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
        type: u1
        enum: bid_price_fraction_indicator
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
        type: u1
        enum: ask_price_fraction_indicator
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
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Outstanding number of contracts in the series as of the previous day'
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
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
        doc: 'Fraction indicator for the net change'
      - id: opening_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Opening price of the option series for the day'
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous Settlement Price'
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
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
        type: u1
        enum: bid_price_fraction_indicator
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
        type: u1
        enum: ask_price_fraction_indicator
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
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last Trade Price – previous Settlement Price If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
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
        type: u1
        enum: previous_settlement_fraction_indicator
        doc: 'Fraction indicator for the previous Settlement Price'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Previous day’s outstanding number of contracts in the series Refer to Indicator Code'
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
      - id: bid_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent bid price'
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Bid Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price_summary
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent ask price'
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by the Ask Price. If size is greater than 99999, the 5th character becomes an exponent'
      - id: last_price_sign
        type: u1
        enum: last_price_sign
        doc: 'For the Last Price field'
      - id: last_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Closing or most recent trade price'
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: open_price_sign
        type: u1
        enum: open_price_sign
        doc: 'For the Open Price field'
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price of the first trade of the day'
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: high_price_sign
        type: u1
        enum: high_price_sign
        doc: 'For the High Price field'
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Highest trade price of the day or current high price if sent after a cancellation'
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: low_price_sign
        type: u1
        enum: low_price_sign
        doc: 'For the Low Price field'
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Lowest trade price of the day or current low price if sent after a cancellation'
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous close If no previous settlement price (new series) then net change is zero'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
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
        type: u1
        enum: trade_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
      - id: net_change_sign
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change = last trade price – previous settlement price'
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
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
      - id: coupon
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond Coupon rate'
      - id: coupon_fraction_indicator
        type: u1
        enum: coupon_fraction_indicator
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
        type: u1
        enum: min_price_fraction_indicator
        doc: 'Defines number of decimal places or fraction positions'
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
        doc: 'Current Business date, YYYYMMDD'

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

