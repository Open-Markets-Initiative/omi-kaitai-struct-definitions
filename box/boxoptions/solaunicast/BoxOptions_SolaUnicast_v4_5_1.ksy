# ---------------------------------------------------------------------
# Kaitai struct definition for: Box BoxOptions SolaUnicast Hsvf v4.5.1
#
# Protocol:
#   Organization: Box Options Market
#   Protocol: Sola Unicast
#   Encoding: High Speed Vender Feed
#   Version: 4.5.1
#   Date: 03/15/2021
#   Specification: HSVF-BX-001E-BOX-SOLA-HSVF-Unicast-Specifications-Guide-v4.51.pdf
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
  id: box_boxoptions_solaunicast_hsvf_v4_5_1
  title: Box BoxOptions SolaUnicast Hsvf v4.5.1
  license: GPL-3.0
  endian: be

doc: 'Box Options Market BOX Options Exchange Sola Unicast Hsvf v4.5.1'

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
        '"RS"': connection_message
        '"U"': end_of_transmission_message
        '"V"': circuit_assurance_message
        '"W"': gap_sequence_message
        '"Z"': system_timestamp_message
        '"C"': option_trade_message
        '"CS"': complex_order_instrument_trade_message
        '"D"': option_request_for_quote_message
        '"F"': option_quote_message
        '"FS"': complex_order_quote_message
        '"H"': option_market_depth_message
        '"HS"': complex_order_market_depth_message
        '"I"': option_trade_cancellation_message
        '"IS"': complex_order_trade_cancellation_message
        '"J"': option_instrument_keys_message
        '"JS"': complex_order_instrument_keys_message
        '"N"': option_summary_message
        '"NS"': complex_order_summary_message
        '"Q"': beginning_of_options_summary_message
        '"QS"': beginning_of_complex_order_summary_message
        '"GC"': group_opening_time_message
        '"GR"': group_status_message
        '"GS"': complex_order_group_status_message
        '"L"': bulletins_message
        '"S"': end_of_sales_message
        '"M"': option_improvement_process_beginning_message
        '"MS"': complex_order_improvement_process_beginning_message_message
        '"O"': market_sheet_initial_and_improvement_order_message
        '"OS"': complex_order_market_sheet_initial_and_improvement_order_message
        '"T"': initial_and_improvement_order_message
        '"TS"': complex_order_initial_and_improvement_order_message
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
  connection_message:
    seq:
      - id: reset_sequence
        type: str
        size: 10
        encoding: ASCII
        doc: 'Indicates the last message received'
      - id: system_default
        type: str
        size: 1
        encoding: ASCII
        doc: 'Y'
      - id: system_value
        type: str
        size: 1
        encoding: ASCII
        doc: 'N'
      - id: type_of_market_data
        type: u1
        enum: type_of_market_data
        doc: 'Market Data Type'
      - id: complex_order
        type: str
        size: 1
        encoding: ASCII
        doc: 'Client wants to receive messages on option instruments'
      - id: market_summaries
        type: u1
        enum: market_summaries
        doc: 'Client wants to receive the market summaries and the Instrument key messages'
      - id: gap_control
        type: u1
        enum: gap_control
        doc: 'Receive GAP messages. Applicable only if ''Number of options classes requested'' is greater than 000'
      - id: hsvf_protocol
        type: str
        size: 2
        encoding: ASCII
        doc: 'Current HSVF Protocol version (C7)'
      - id: num_option_classes_requested
        type: str
        size: 3
        encoding: ASCII
        doc: '000: Client wants to receive messages on all option classes, 001 to 999: Client wants to receive messages on XXX (between 001 to 999) option classes'
      - id: option_classes_requested
        type: option_classes_requested
        repeat: expr
        repeat-expr: num_option_classes_requested.to_i
        doc: 'Option classes the client asks for, none when the count is 000'
  option_classes_requested:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Root of the instrument group'
  end_of_transmission_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the message is transmitted'
  circuit_assurance_message:
    seq:
      - id: time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time at which the message is transmitted'
  gap_sequence_message:
    seq:
      - id: sequence_numbers_skipped
        type: str
        size: 9
        encoding: ASCII
        doc: 'Sequence numbers skipped'
  system_timestamp_message:
    seq:
      - id: trading_engine_timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time stamp generated by the SOLA Trading Engine (HHMMSSmmm)'
  option_trade_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
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
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change equals last trade price minus previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change price'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time of transaction:HHMMSS'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the outstanding number of contracts in the series'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
  instrument_description:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Root of the instrument group'
      - id: expiry_month_code
        type: u1
        enum: expiry_month_code
        doc: 'Delivery month for the contract'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: strike_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Strike Price of the option in full'
      - id: strike_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines the number of decimal places or fraction positions'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiration year of the leg of the Complex Order Instrument expiring first. Format is YY'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the leg of the Complex Order Instrument expiring first'
  complex_order_instrument_trade_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
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
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change equals last trade price minus previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change price'
      - id: filler_6
        size: 6
        doc: 'Filler'
      - id: timestamp
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time of transaction:HHMMSS'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
  option_request_for_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
        doc: 'Size of the market requested'
  option_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: bid_price
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
        doc: 'Number of option contracts represented by the Bid Price'
      - id: ask_price
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
        doc: 'Number of option contracts represented by the Ask Price'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: public_customer_bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by Public Customer orders on the bid side'
      - id: public_customer_ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by Public Customer orders on the ask side'
  complex_order_quote_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Bid Price field'
      - id: bid_price
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
        doc: 'Number of option contracts represented by the Bid Price'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price
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
        doc: 'Number of option contracts represented by the Ask Price'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: public_customer_bid_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by Public Customer orders on the bid side'
      - id: public_customer_ask_size
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of option contracts represented by Public Customer orders on the ask side'
  option_market_depth_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_market_depth_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument'
      - id: market_depth_level
        type: market_depth_level
        repeat: expr
        repeat-expr: num_market_depth_level.to_i
        doc: 'Market Depth Level'
  market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth'
      - id: bid_price
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
        doc: 'Number of option contracts represented by the Bid Price'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book'
      - id: ask_price
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
        doc: 'Number of option contracts represented by the Ask Price'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book'
  complex_order_market_depth_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
        doc: 'Indicates instrument status'
      - id: num_complex_market_depth_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of level for the trading instrument'
      - id: complex_market_depth_level
        type: complex_market_depth_level
        repeat: expr
        repeat-expr: num_complex_market_depth_level.to_i
        doc: 'Complex Market Depth Level'
  complex_market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
        doc: 'Level of market depth'
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Bid Price field'
      - id: bid_price
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
        doc: 'Number of option contracts represented by the Bid Price'
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of bid orders, present at a given moment, in the order book'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price
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
        doc: 'Number of option contracts represented by the Ask Price'
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of Ask Orders, present at a given moment, in the order book'
  option_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
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
        size: 6
        encoding: ASCII
        doc: 'Time of transaction:HHMMSS'
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
        doc: 'Contains the outstanding number of contracts in the series'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
  complex_order_trade_cancellation_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
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
        size: 6
        encoding: ASCII
        doc: 'Time of transaction:HHMMSS'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
        doc: 'Identifies the type of transaction'
  option_instrument_keys_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
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
      - id: maximum_threshold_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: maximum_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: minimum_threshold_price
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
        doc: 'Precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Type of option'
      - id: market_flow_indicator
        type: market_flow_indicator
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group of the instrument'
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
        type: option_marker
      - id: underlying_symbol_root
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol root for the underlying security'
  market_flow_indicator:
    seq:
      - id: type_of_instrument
        type: u1
        enum: type_of_instrument
        doc: 'Type Of Instrument'
      - id: type_of_underlying
        type: u1
        enum: type_of_underlying
        doc: 'Type Of Underlying'
  option_marker:
    seq:
      - id: type_of_market
        type: str
        size: 1
        encoding: ASCII
        doc: 'Type Of Market'
      - id: type_of_options
        type: u1
        enum: type_of_options
        doc: 'Type Of Options'
  complex_order_instrument_keys_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiration year of the leg of the Complex Order Instrument expiring first. Format is YY'
      - id: delivery_month
        type: u1
        enum: delivery_month
        doc: 'Delivery month code of the leg of the Complex Order Instrument expiring first'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Expiry day of the leg of the Complex Order Instrument expiring first'
      - id: max_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum authorized number of contract per order'
      - id: min_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum authorized number of contract per order'
      - id: max_threshold_price_sign
        type: u1
        enum: max_threshold_price_sign
        doc: '+ or - sign'
      - id: max_threshold_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Maximum threshold price authorized for an option contract'
      - id: max_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of decimal places or fraction positions'
      - id: min_threshold_price_sign
        type: u1
        enum: min_threshold_price_sign
        doc: '+ or - sign'
      - id: min_threshold_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum threshold price authorized for an option contract'
      - id: min_threshold_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of decimal places or fraction positions'
      - id: tick_increment
        type: str
        size: 6
        encoding: ASCII
        doc: 'Precision with which the price of an order limit can be expressed'
      - id: tick_increment_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Defines number of decimal places or fraction positions'
      - id: filler_2
        size: 2
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group of the instrument'
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
      - id: complex_order_instrument_allow_implied
        type: u1
        enum: complex_order_instrument_allow_implied
        doc: 'Complex Order Instrument support of Implied Price'
      - id: num_instrument_leg
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of legs in the Complex Order Instrument'
      - id: instrument_leg
        type: instrument_leg
        repeat: expr
        repeat-expr: num_instrument_leg.to_i
        doc: 'Instrument Leg Repeating Group'
  instrument_leg:
    seq:
      - id: leg_ratio_sign
        type: u1
        enum: leg_ratio_sign
        doc: '+ : Buy the leg'
      - id: leg_ratio
        type: str
        size: 8
        encoding: ASCII
        doc: 'Quantity (bought or sold)'
      - id: leg_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading symbol of the leg'
  option_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: bid_price
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
        doc: 'Number of option contracts represented by the Bid Price'
      - id: ask_price
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
        doc: 'Number of option contracts represented by the Ask Price'
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
        doc: 'Contains the outstanding number of contracts in the series'
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
        size: 6
        encoding: ASCII
        doc: 'Net change equals last trade price minus previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change price'
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
        type: option_marker
      - id: underlying_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol root for the underlying security'
      - id: reference_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reference Price of the Option'
      - id: reference_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of decimal places or fraction positions'
  complex_order_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For Bid Price field'
      - id: bid_price
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
        doc: 'Number of option contracts represented by the Bid Price'
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
        doc: 'For Ask Price field'
      - id: ask_price
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
        doc: 'Number of option contracts represented by the Ask Price'
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
        type: u1
        enum: open_price_sign
        doc: '+ or - sign'
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
        type: u1
        enum: high_price_sign
        doc: '+ or - sign'
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
        type: u1
        enum: low_price_sign
        doc: '+ or - sign'
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
        type: u1
        enum: net_change_sign
        doc: 'For the net change field'
      - id: net_change
        type: str
        size: 6
        encoding: ASCII
        doc: 'Net change equals last trade price minus previous close'
      - id: net_change_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction indicator for the net change price'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts for the trade'
  beginning_of_options_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
  beginning_of_complex_order_summary_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
  group_opening_time_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Root of the instrument group'
      - id: group_status
        type: u1
        enum: group_status
        doc: 'Value is O'
      - id: scheduled_time
        type: str
        size: 6
        encoding: ASCII
        doc: 'Opening time of the instrument group (HHMMSS)'
  group_status_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Root of the instrument group'
      - id: group_status
        type: u1
        enum: group_status
        doc: 'Value is O'
  complex_order_group_status_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: group_of_the_complex_order_instrument
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group of the Complex Order Instrument'
      - id: group_status
        type: u1
        enum: group_status
        doc: 'Value is O'
  bulletins_message:
    seq:
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: bulletin_type
        type: u1
        enum: bulletin_type
        doc: 'Bulletin Type'
      - id: bulletin_contents
        type: str
        size: 79
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bulletin in textual format. Left justified and blank filled'
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
        doc: 'Time at which the message is transmitted'
  option_improvement_process_beginning_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: improvement_phase_sequential_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the number of an Improvement Phase. Sequential number unique per Instrument and per trading day'
      - id: initial_order_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the price of the Initial Order'
      - id: initial_order_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction Indicator Code'
      - id: initial_order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the Initial Order'
      - id: initial_order_side
        type: u1
        enum: initial_order_side
        doc: 'Indicates the dealer side of the Initial Order'
      - id: improvement_phase_expiry_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the expiry time of the Improvement Phase (value is in HHMMSSCC)'
      - id: improvement_process_expiry_duration
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicates the expiry duration of the Improvement Phase (value is in SSCC)'
      - id: minimum_quantity_for_improvement_order
        type: str
        size: 8
        encoding: ASCII
        doc: 'Enables market makers to know the minimum quantity for an Improvement Order during the Improvement Phase'
      - id: percentage_assured_to_initial_order
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the Initial Order assured to the dealer side of the IO in case of the Initial Order price is the best limit Ex: 00040.00 stands for 40.00 %'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Indicating the auction type'
      - id: filler_1
        size: 1
        doc: 'Filler'
  complex_order_improvement_process_beginning_message_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
      - id: improvement_phase_sequential_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the number of an Improvement Phase. Sequential number unique per Instrument and per trading day'
      - id: initial_order_price_sign
        type: u1
        enum: initial_order_price_sign
        doc: '+ or - sign'
      - id: initial_order_price
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the price of the Initial Order'
      - id: initial_order_price_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction Indicator Code'
      - id: initial_order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the Initial Order'
      - id: initial_order_side
        type: u1
        enum: initial_order_side
        doc: 'Indicates the dealer side of the Initial Order'
      - id: improvement_phase_expiry_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the expiry time of the Improvement Phase (value is in HHMMSSCC)'
      - id: improvement_process_expiry_duration
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicates the expiry duration of the Improvement Phase (value is in SSCC)'
      - id: minimum_quantity_for_improvement_order
        type: str
        size: 8
        encoding: ASCII
        doc: 'Enables market makers to know the minimum quantity for an Improvement Order during the Improvement Phase'
      - id: percentage_assured_to_initial_order
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicates the quantity of the Initial Order assured to the dealer side of the IO in case of the Initial Order price is the best limit Ex: 00040.00 stands for 40.00 %'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Indicating the auction type'
  market_sheet_initial_and_improvement_order_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: order_side
        type: u1
        enum: order_side
        doc: 'The must be filled side'
      - id: type_of_order
        type: u1
        enum: type_of_order
        doc: 'Type of limit entered'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: limit_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction Indicator Code'
      - id: order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicator Code'
      - id: order_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Allocated by the Central trading engine at each valid order entry'
      - id: improvement_phase_sequential_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the number of an Improvement Phase. Sequential number unique per Instrument and per trading day'
      - id: type_of_clearing_account
        type: u1
        enum: type_of_clearing_account
        doc: 'Indicates the account type for which an order was entered using the clearing house member''s account typology'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: end_of_the_exposition
        type: str
        size: 8
        encoding: ASCII
        doc: 'HHMMSSCC - ''0'' filled for PIP messages'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Indicating the auction type'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicates the FirmId'
      - id: cmta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicates the CMTA'
  complex_order_market_sheet_initial_and_improvement_order_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'The must be filled side'
      - id: type_of_order
        type: u1
        enum: type_of_order
        doc: 'Type of limit entered'
      - id: limit_entered_for_an_order_sign
        type: u1
        enum: limit_entered_for_an_order_sign
        doc: '+ or - sign'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: limit_fraction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Fraction Indicator Code'
      - id: order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Indicator Code'
      - id: order_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Allocated by the Central trading engine at each valid order entry'
      - id: improvement_phase_sequential_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the number of an Improvement Phase. Sequential number unique per Instrument and per trading day'
      - id: type_of_clearing_account
        type: u1
        enum: type_of_clearing_account
        doc: 'Indicates the account type for which an order was entered using the clearing house member''s account typology'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: end_of_the_exposition
        type: str
        size: 8
        encoding: ASCII
        doc: 'HHMMSSCC - ''0'' filled for PIP messages'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Indicating the auction type'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicates the FirmId'
      - id: cmta
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicates the CMTA'
  initial_and_improvement_order_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: instrument_description
        type: instrument_description
      - id: deletion_type
        type: u1
        enum: deletion_type
        doc: 'Deletion Type'
      - id: order_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Allocated by the Central trading engine at each valid order entry'
      - id: improvement_order_side
        type: u1
        enum: improvement_order_side
        doc: 'Side'
      - id: improvement_phase_sequential_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the number of an Improvement Phase. Sequential number unique per Instrument and per trading day'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Indicating the auction type'
  complex_order_initial_and_improvement_order_message:
    seq:
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q by default'
      - id: complex_order_instrument_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Order Instrument symbol. The individual legs are defined in message type JS'
      - id: deletion_type
        type: u1
        enum: deletion_type
        doc: 'Deletion Type'
      - id: order_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Allocated by the Central trading engine at each valid order entry'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'The must be filled side'
      - id: improvement_phase_sequential_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates the number of an Improvement Phase. Sequential number unique per Instrument and per trading day'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Indicating the auction type'

enums:
  type_of_market_data:
    0x59:
      id: 'market_depth_messages_on_the_top_5_bidsasks_for_the_type_of_trading_instruments_chosen'
      doc: 'Market Depth Messages On The Top 5 Bidsasks For The Type Of Trading Instruments Chosen'
    0x4e:
      id: 'best'
      doc: 'The Best Bidask Message'
    0x54:
      id: 'trade'
      doc: 'Trade Messages Without Quotes Or Market Depth Messages'
    0x50:
      id: 'price_improvement_and_exposed_order_messages'
      doc: 'Price Improvement And Exposed Order Messages'
    0x49:
      id: 'market_depth_messages_on_the_top_5_and_the_calculated_implied_best_limit'
      doc: 'Market Depth Messages On The Top 5 And The Calculated Implied Best Limit'
    0x47:
      id: 'quote_message_on_the_first_level_and_the_calculated_implied_best_limit'
      doc: 'Quote Message On The First Level And The Calculated Implied Best Limit'
  market_summaries:
    0x59:
      id: 'yes_field'
      doc: 'Only The Market Summaries And The Instrument Key Messages'
    0x4e:
      id: 'no_field'
      doc: 'Regular Market Messages With The Summaries And The Instrument Key Messages'
  gap_control:
    0x30:
      id: 'will_receive_gap_messages'
      doc: 'Will Receive Gap Messages'
    0x31:
      id: 'will_not_receive_gap_messages'
      doc: 'Will Not Receive Gap Messages'
  expiry_month_code:
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
  net_change_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  price_indicator_marker:
    0x41:
      id: 'as_of_trade'
      doc: 'As Of Trade'
    0x43:
      id: 'trades_performed_at_the_end_of_a_pip_allocation_phase'
      doc: 'Trades Performed At The End Of A Pip Allocation Phase'
    0x4c:
      id: 'late_trade'
      doc: 'Late Trade'
    0x4f:
      id: 'trades_performed_during_the_opening'
      doc: 'Trades Performed During The Opening'
    0x53:
      id: 'reference_price'
      doc: 'Reference Price'
    0x57:
      id: 'trades_resulting_from_the_transmission_of_an_iso_inbound_order'
      doc: 'Trades Resulting From The Transmission Of An Iso Inbound Order'
    0x58:
      id: 'trades_performed_when_the_market_is_crossed'
      doc: 'Trades Performed When The Market Is Crossed'
    0x47:
      id: 'contingent_trade_price_of_the_trade_was_not_controlled_against_the_nbbo'
      doc: 'Contingent Trade Price Of The Trade Was Not Controlled Against The Nbbo'
    0x49:
      id: 'trade_involving_an_implied_order_or_leg_trade_of_a_complex_order_instrument'
      doc: 'Trade Involving An Implied Order Or Leg Trade Of A Complex Order Instrument'
    0x50:
      id: 'trade_done_on_a_complex_order_instrument'
      doc: 'Trade Done On A Complex Order Instrument'
    0x20:
      id: 'actual_transaction_took_place'
      doc: 'Actual Transaction Took Place'
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
    0x48:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x52:
      id: 'reserved_phase'
      doc: 'Reserved Phase'
    0x53:
      id: 'suspended_phase'
      doc: 'Suspended Phase'
    0x5a:
      id: 'frozen'
      doc: 'Frozen'
    0x41:
      id: 'surveillance_intervention_phase'
      doc: 'Surveillance Intervention Phase'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x42:
      id: 'beginning_of_day_inquiries'
      doc: 'Beginning Of Day Inquiries'
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
    0x36:
      id: 'level_6'
      doc: 'Level 6'
    0x41:
      id: 'implied_price'
      doc: 'Implied Price'
    0x50:
      id: 'public_customer_volume'
      doc: 'Public Customer Volume'
  option_type:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
  type_of_instrument:
    0x4f:
      id: 'options'
      doc: 'Options'
    0x4c:
      id: 'long_term'
      doc: 'Long Term'
  type_of_underlying:
    0x58:
      id: 'index'
      doc: 'Index'
    0x45:
      id: 'equities'
      doc: 'Equities'
  type_of_options:
    0x20:
      id: 'regular'
      doc: 'Regular'
  delivery_month:
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
  max_threshold_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  min_threshold_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  complex_order_instrument_allow_implied:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x43:
      id: 'continuous_implied'
      doc: 'Continuous Implied'
    0x53:
      id: 'snapshot_implied'
      doc: 'Snapshot Implied'
  leg_ratio_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  tick:
    0x2b:
      id: 'uptick'
      doc: 'Uptick'
    0x2d:
      id: 'downtick'
      doc: 'Downtick'
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
    0x48:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x41:
      id: 'surveillance_intervention_phase'
      doc: 'Surveillance Intervention Phase'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x42:
      id: 'beginning_of_day_inquiries'
      doc: 'Beginning Of Day Inquiries'
  bulletin_type:
    0x31:
      id: 'regular'
      doc: 'Regular'
    0x32:
      id: 'special'
      doc: 'Special'
  continue_marker:
    0x30:
      id: 'bulletin_continues_in_next_record'
      doc: 'Bulletin Continues In Next Record'
    0x31:
      id: 'bulletin_ended'
      doc: 'Bulletin Ended'
  initial_order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  auction_type:
    0x47:
      id: 'regular_pip'
      doc: 'Regular Pip'
    0x42:
      id: 'solicitation'
      doc: 'Solicitation'
    0x43:
      id: 'facilitation'
      doc: 'Facilitation'
    0x46:
      id: 'exposed_order'
      doc: 'Exposed Order'
  initial_order_price_sign:
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
  type_of_order:
    0x41:
      id: 'initial_order'
      doc: 'Initial Order'
    0x50:
      id: 'exposed_order'
      doc: 'Exposed Order'
  type_of_clearing_account:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
  limit_entered_for_an_order_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  deletion_type:
    0x31:
      id: 'precise_order'
      doc: 'Precise Order'
    0x32:
      id: 'all_previous_orders_in_the_specified_side'
      doc: 'All Previous Orders In The Specified Side'
    0x33:
      id: 'all_orders'
      doc: 'All Orders'
  improvement_order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'all'
      doc: 'All'

