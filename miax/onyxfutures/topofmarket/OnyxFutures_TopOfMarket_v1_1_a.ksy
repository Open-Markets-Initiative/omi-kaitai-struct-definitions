# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax OnyxFutures TopOfMarket Mach v1.1.a
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Top Of Market
#   Encoding: Mach
#   Version: 1.1.a
#   Date: 9/19/2025
#   Specification: ONYX ToM Feed v1.1a.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: miax_onyxfutures_topofmarket_mach_v1_1_a
  title: Miax OnyxFutures TopOfMarket Mach v1.1.a
  license: MIT-0
  endian: le

doc: 'Miami International Holdings MIAX Futures Onyx Top Of Market Mach v1.1.a'
doc-ref: https://www.miaxglobal.com/markets/futures/miax-futures/onyx-interface-specifications

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: mach_packet_header
        type: mach_packet_header
        doc: 'Mach packet header (12 bytes)'
      - id: payload
        size: mach_packet_header.packet_length - 12
        type:
          switch-on: mach_packet_header.packet_type
          cases:
            'packet_type::application_message': application_message
  mach_packet_header:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Sequence number of this data packet'
      - id: packet_length
        type: u2
        doc: 'Length of the packet, including the header and application data'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Mach protocol packet type'
      - id: session_number
        type: u1
        doc: 'The Session this packet was generated from'
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.mach_packet_header.packet_length - 12 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::simple_instrument_definition_message': simple_instrument_definition_message
            'message_type::complex_instrument_definition_message': complex_instrument_definition_message
            'message_type::system_state_message': system_state_message
            'message_type::instrument_trading_status_notification_message': instrument_trading_status_notification_message
            'message_type::best_bid_and_offer_message': best_bid_and_offer_message
            'message_type::last_sale_message': last_sale_message
            'message_type::trade_cancel_message': trade_cancel_message
  simple_instrument_definition_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: underlying_asset_type
        type: u1
        enum: underlying_asset_type
        doc: 'Underlying Asset Type of this instrument:'
      - id: underlying_asset
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Code'
      - id: product_group_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product Group Code: e.g.: MWE for Hard Red Spring Wheat Standard Deliverable (5000 Bushels)'
      - id: exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: instrument_id_source
        type: u1
        enum: instrument_id_source
        doc: 'Indicates whether the Instrument ID has been assigned by the exchange or from an external industry source'
      - id: instrument_type
        type: u1
        enum: instrument_type
      - id: reserved_4
        size: 4
        doc: 'Previously was Maturity Month-Year field; replaced by the Maturity Date field below. Currently reserved for future use'
      - id: currency
        type: u1
        enum: currency
        doc: 'The currency in which all Futures Instruments of the Futures Product will trade'
      - id: settlement_currency
        type: u1
        enum: settlement_currency
        doc: 'The Currency in which the Product settles'
      - id: match_algorithm
        type: u1
        enum: match_algorithm
        doc: 'The allocation model used by the MIAX Futures Onyx Trading Platform for the Product'
      - id: minimum_size
        type: u4
        doc: 'Minimum Order Size'
      - id: maximum_size
        type: u4
        doc: 'Maximum Order Size'
      - id: tick
        type: decimal_s8_9
        doc: 'Order Entry Price Tick of the Product. Implied decimal with scale 1e-9'
      - id: unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Individual unit of the Deliverable of the Underlying Asset associated with the Futures Contract'
      - id: unit_of_measure_quantity
        type: u4
        doc: 'The quantity of the Underlying Asset that is required for the Deliverable associated with the Futures Contract'
      - id: settlement_price
        type: decimal_s8_9
        doc: 'The previous day. Implied decimal with scale 1e-9'
      - id: settlement_price_type_calc_method
        type: u1
        enum: settlement_price_type_calc_method
        doc: 'Actual or Theoretical Settlement Price Indicator'
      - id: total_volume
        type: u4
        doc: 'The aggregate amount of volume that has traded from the prior Trading Day'
      - id: open_interest_quantity
        type: u4
        doc: 'The amount of aggregate open contracts in a Simple Instrument'
      - id: high_limit_price
        type: decimal_s8_9
        doc: 'The Upper Band of the Daily Trading Limit of a Futures Product. Implied decimal with scale 1e-9'
      - id: low_limit_price
        type: decimal_s8_9
        doc: 'The Lower Band of the Daily Trading Limit of a Futures Product. Implied decimal with scale 1e-9'
      - id: trading_collar_variation_type
        type: u1
        enum: trading_collar_variation_type
      - id: trading_collar_variation
        type: decimal_s8_9
        doc: 'The Dollar Value or Percentage Value used in the calculation of the Trading Collar. Implied decimal with scale 1e-9'
      - id: contract_date
        type: u4
        doc: 'The Contract Date will be assigned to each Simple Instrument'
      - id: maturity_date
        type: epoch_date
        doc: 'Maturity Date is the expiration date of a Simple Instrument. Days since Unix epoch'
      - id: valuation_date
        type: epoch_date
        doc: 'The date that the Final Settlement Price will be calculated for purposes of Simple Instrument expiration. Days since Unix epoch'
      - id: first_trade_date
        type: epoch_date
        doc: 'First Trade Date will be the Trading Date that the Simple Instrument is initially made available for Trading on MIAX Futures Onyx. Days since Unix epoch'
      - id: last_trade_date
        type: epoch_date
        doc: 'Last Trade Date will be the Maturity Date of the Simple Instrument. Days since Unix epoch'
      - id: first_notice_date
        type: epoch_date
        doc: 'Last business date of the month preceding the month of the Maturity Date of the Simple Instrument. Days since Unix epoch'
      - id: last_notice_date
        type: epoch_date
        doc: 'Last Notice Date will be the business day preceding the Last Delivery Date of the Simple Instrument. Days since Unix epoch'
      - id: first_delivery_date
        type: epoch_date
        doc: 'First Delivery Date will be the first business day of the month of the Maturity Date of the Simple Instrument. Days since Unix epoch'
      - id: last_delivery_date
        type: epoch_date
        doc: 'Last Delivery Date will be the seventh business day following the Last Trading Date of the Simple Instrument. Days since Unix epoch'
      - id: option_strike_price
        type: decimal_s8_9_nullable
        doc: 'NULL when Instrument Type not equal to. Implied decimal with scale 1e-9. Nullable, Not An Option = 999999999999999999'
      - id: option_strike_currency
        type: u1
        enum: option_strike_currency
      - id: option_type
        type: u1
        enum: option_type
      - id: option_expiration_type
        type: u1
        enum: option_expiration_type
      - id: underlying_future_instrument_id
        type: u4
        doc: 'The Instrument ID of the Futures Instrument that is the Underlying Asset of the Options on Futures Instrument Value of 0 when Instrument Type not equal to ''O'''
  complex_instrument_definition_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id_formerly_known_as_strategy_id
        type: u4
        doc: 'Unique ID assigned by MIAX Futures Onyx for a Complex instrument and is permanent for the life of an instrument'
      - id: underlying_asset_type
        type: u1
        enum: underlying_asset_type
        doc: 'Underlying Asset Type of this instrument:'
      - id: underlying_asset
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Code'
      - id: product_group_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product Group Code: e.g.: MWE for Hard Red Spring Wheat Standard Deliverable (5000 Bushels)'
      - id: spread_type
        type: u1
        enum: spread_type
        doc: 'Spread Type'
      - id: exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: instrument_id_source
        type: u1
        enum: instrument_id_source
        doc: 'Indicates whether the Instrument ID has been assigned by the exchange or from an external industry source'
      - id: instrument_type
        type: u1
        enum: instrument_type
      - id: currency
        type: u1
        enum: currency
        doc: 'The currency in which all Futures Instruments of the Futures Product will trade'
      - id: settlement_currency
        type: u1
        enum: settlement_currency
        doc: 'The Currency in which the Product settles'
      - id: match_algorithm
        type: u1
        enum: match_algorithm
        doc: 'The allocation model used by the MIAX Futures Onyx Trading Platform for the Product'
      - id: minimum_size
        type: u4
        doc: 'Minimum Order Size'
      - id: maximum_size
        type: u4
        doc: 'Maximum Order Size'
      - id: tick
        type: decimal_s8_9
        doc: 'Order Entry Price Tick of the Product. Implied decimal with scale 1e-9'
      - id: unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Individual unit of the Deliverable of the Underlying Asset associated with the Futures Contract'
      - id: unit_of_measure_quantity
        type: u4
        doc: 'The quantity of the Underlying Asset that is required for the Deliverable associated with the Futures Contract'
      - id: trading_collar_variation_type
        type: u1
        enum: trading_collar_variation_type
      - id: trading_collar_variation
        type: decimal_s8_9
        doc: 'The Dollar Value or Percentage Value used in the calculation of the Trading Collar. Implied decimal with scale 1e-9'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
      - id: num_instrument_leg
        type: u1
        doc: 'Number of strategy legs'
      - id: instrument_leg
        type: instrument_leg
        repeat: expr
        repeat-expr: num_instrument_leg
        doc: 'Complex Strategy Number of Legs'
  instrument_leg:
    seq:
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: leg_ratio_and_side
        type: s4
        doc: 'Leg ratio for the specified instrument Positive indicates Buy Negative indicates Sell'
      - id: reserved_4
        size: 4
        doc: 'Previously was Maturity Month-Year field; replaced by the Maturity Date field below. Currently reserved for future use'
      - id: maturity_date
        type: epoch_date
        doc: 'Maturity Date is the expiration date of a Simple Instrument. Days since Unix epoch'
      - id: reserved_6
        size: 6
        doc: 'Reserved for future use'
  system_state_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: to_m_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'E.g'
      - id: session_id
        type: u1
        doc: 'Current trading session identifier'
      - id: system_status
        type: u1
        enum: system_status
  instrument_trading_status_notification_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: trading_status
        type: u1
        doc: '1 - Pre-Open 2 - Opening Freeze 3 - Trading 4 - Halt 5 - Operational Halt 6 - Closed'
      - id: market_state
        type: u1
        doc: '1 - Pre-Opening 2 - Extended 1 Trading Session 3 - Regular Trading Session 4 - Extended 2 Trading Session'
  best_bid_and_offer_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: mbb_price
        type: decimal_s8_9_nullable
        doc: 'Will be provided for updates as a result of any changes to the prices or sizes of the MBBO for a Simple Instrument or a Complex Instrument. Implied decimal with scale 1e-9. Nullable, No Interest = -999999999999999999'
      - id: mbb_size
        type: u4
        doc: 'Aggregate size in contracts at the displayed of f er price'
      - id: mbo_price
        type: decimal_s8_9_nullable
        doc: 'Will be provided for updates as a result of any changes to the prices or sizes of the MBBO for a Simple Instrument or a Complex Instrument. Implied decimal with scale 1e-9. Nullable, No Interest = 999999999999999999'
      - id: mbo_size
        type: u4
        doc: 'Aggregate size in contracts at the displayed of f er price'
  last_sale_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: trade_date
        type: epoch_date
        doc: 'Business Trade Date. Days since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: trade_id
        type: u8
        doc: 'Unique ID assigned by the Matching Engine'
      - id: correction_number
        type: u1
        doc: 'Trade correction number'
      - id: price
        type: decimal_s8_9
        doc: 'Execution price. Implied decimal with scale 1e-9'
      - id: size
        type: u4
        doc: 'Number of shares executed'
      - id: trade_type
        type: u1
        enum: trade_type
      - id: complex_trade_id
        type: u8
        doc: 'For Trade Type'
      - id: instrument_type
        type: u1
        enum: instrument_type
  trade_cancel_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: trade_date
        type: epoch_date
        doc: 'Business Trade Date. Days since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: trade_id
        type: u8
        doc: 'Unique ID assigned by the Matching Engine'
      - id: correction_number
        type: u1
        doc: 'Trade correction number'
      - id: price
        type: decimal_s8_9
        doc: 'Execution price. Implied decimal with scale 1e-9'
      - id: size
        type: u4
        doc: 'Number of shares executed'
      - id: instrument_type
        type: u1
        enum: instrument_type
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
  decimal_s8_9:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000.0
  epoch_date:
    seq:
      - id: days
        type: u2
    instances:
      unix_seconds:
        value: days * 86400
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
    instances:
      is_null:
        value: value.mantissa == 999999999999999999

enums:
  packet_type:
    0:
      id: 'heartbeat'
      doc: 'Mach Heartbeat Message'
    1:
      id: 'start_of_session'
      doc: 'Mach Start Of Session Message'
    2:
      id: 'end_of_session'
      doc: 'Mach end of session Message'
    3:
      id: 'application_message'
      doc: 'Mach Application Message'
  message_type:
    1:
      id: 'simple_instrument_definition_message'
      doc: 'Simple Instrument Definition'
    2:
      id: 'complex_instrument_definition_message'
      doc: 'Complex Instrument Definition'
    3:
      id: 'system_state_message'
      doc: 'System State'
    4:
      id: 'instrument_trading_status_notification_message'
      doc: 'Instrument Trading Status Notification'
    15:
      id: 'best_bid_and_offer_message'
      doc: 'Top of Market (Best Bid and Offer) Message'
    16:
      id: 'last_sale_message'
      doc: 'Last Sale (Trade) Message'
    14:
      id: 'trade_cancel_message'
      doc: 'Trade Cancel Message'
  underlying_asset_type:
    0x45:
      id: 'equity_index'
      doc: 'Equity Index'
    0x41:
      id: 'commodity_agriculture'
      doc: 'Commodity Agriculture'
    0x46:
      id: 'futures_contract'
      doc: 'Futures Contract'
  instrument_id_source:
    0x45:
      id: 'exchange'
      doc: 'Exchange'
  instrument_type:
    0x46:
      id: 'futures'
      doc: 'Futures'
    0x4f:
      id: 'options_on_futures'
      doc: 'Options On Futures'
  currency:
    0x55:
      id: 'usd'
      doc: 'Usd'
  settlement_currency:
    0x55:
      id: 'usd'
      doc: 'Usd'
  match_algorithm:
    0x50:
      id: 'price_time'
      doc: 'Price Time'
  settlement_price_type_calc_method:
    0x41:
      id: 'actual'
      doc: 'Actual'
    0x54:
      id: 'theoretical'
      doc: 'Theoretical'
  trading_collar_variation_type:
    0x44:
      id: 'product_dollar_collar_value'
      doc: 'Product Dollar Collar Value'
    0x50:
      id: 'product_collar_percentage_value'
      doc: 'Product Collar Percentage Value'
  option_strike_currency:
    0x55:
      id: 'us_dollar'
      doc: 'Us Dollar'
    0x4e:
      id: 'na_when_instrument_type_not_equal_to_o'
      doc: 'Na When Instrument Type Not Equal To O'
  option_type:
    0x43:
      id: 'call_options'
      doc: 'Call Options'
    0x50:
      id: 'put_options'
      doc: 'Put Options'
    0x4e:
      id: 'na_when_instrument_type_not_equal_to_o'
      doc: 'Na When Instrument Type Not Equal To O'
  option_expiration_type:
    0x41:
      id: 'american_style_options'
      doc: 'American Style Options'
    0x45:
      id: 'european_style_options'
      doc: 'European Style Options'
    0x4e:
      id: 'na_when_instrument_type_not_equal_to_o'
      doc: 'Na When Instrument Type Not Equal To O'
  spread_type:
    0x53:
      id: 'standard_calendar_spread'
      doc: 'Standard Calendar Spread'
    0x45:
      id: 'equity_calendar_spread'
      doc: 'Equity Calendar Spread'
    0x42:
      id: 'butterfly_spread'
      doc: 'Butterfly Spread'
  system_status:
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x43:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x31:
      id: 'start_of_test_session_sent_before_tests'
      doc: 'Start Of Test Session Sent Before Tests'
    0x32:
      id: 'end_of_test_session'
      doc: 'End Of Test Session'
  trade_type:
    0x4f:
      id: 'outright_trade_between_two_simple_orders'
      doc: 'Outright Trade Between Two Simple Orders'
    0x53:
      id: 'strategy_match_net_level_trade'
      doc: 'Strategy Match Net Level Trade'
    0x4d:
      id: 'strategy_match_component_leg_trade'
      doc: 'Strategy Match Component Leg Trade'
    0x43:
      id: 'complex_legging_derived_net_level_trade'
      doc: 'Complex Legging Derived Net Level Trade'
    0x4c:
      id: 'complex_legging_derived_component_leg_trade'
      doc: 'Complex Legging Derived Component Leg Trade'
    0x41:
      id: 'adjusted_late_manual_trade'
      doc: 'Adjusted Late Manual Trade'

