# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax OnyxFutures TopOfMarket Mach v1.0.b
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Top Of Market
#   Encoding: Mach
#   Version: 1.0.b
#   Date: 3/25/2025
#   Specification: onyx_tom_feed_v1.0b.pdf
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
  id: miax_onyxfutures_topofmarket_mach_v1_0_b
  title: Miax OnyxFutures TopOfMarket Mach v1.0.b
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Futures Onyx Top Of Market Mach v1.0.b'
doc-ref: https://www.miaxglobal.com/markets/futures/miax-futures/onyx-interface-specifications

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Sequence number of this data packet'
      - id: packet_length
        type: u2
        doc: 'Length of the packet. This includes the header and application data'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'protocol packet type'
      - id: session_number
        type: u1
        doc: 'The Session this packet was generated from'
      - id: payload
        type:
          switch-on: packet_type
          cases:
            'packet_type::application_message': application_message
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.packet_length - 12 - 1
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
        doc: 'Unique ID assigned by MIAX Futures Onyx'
      - id: underlying_asset_type
        type: u1
        enum: underlying_asset_type
        doc: 'Underlying Asset Type of this instrument'
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
        doc: 'Product Group Code'
      - id: exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange'
      - id: instrument_id_source
        type: u1
        enum: instrument_id_source
        doc: 'Indicates whether the Instrument ID has been assigned by the exchange or from an external industry source'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: '‘F’ = Futures'
      - id: maturity_month_year
        type: u4
        doc: 'Maturity Month-Year is the expiration date of a Simple Instrument'
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
        doc: 'The previous day’s Settlement Price. Implied decimal with scale 1e-9'
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
        doc: 'Trading Collar Variation Type'
      - id: trading_collar_variation
        type: decimal_s8_9
        doc: 'The Dollar Value or Percentage Value used in the calculation of theTrading Collar. Implied decimal with scale 1e-9'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  complex_instrument_definition_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: strategy_id
        type: u4
        doc: 'Unique ID assigned by MIAX Futures Onyx for a Complex instrument and is permanent for the life of an instrument'
      - id: underlying_asset_type
        type: u1
        enum: underlying_asset_type
        doc: 'Underlying Asset Type of this instrument'
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
        doc: 'Product Group Code'
      - id: spread_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spread Type'
      - id: exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange'
      - id: instrument_id_source
        type: u1
        enum: instrument_id_source
        doc: 'Indicates whether the Instrument ID has been assigned by the exchange or from an external industry source'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: '‘F’ = Futures'
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
        doc: 'Trading Collar Variation Type'
      - id: trading_collar_variation
        type: decimal_s8_9
        doc: 'The Dollar Value or Percentage Value used in the calculation of theTrading Collar. Implied decimal with scale 1e-9'
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
        doc: 'Unique ID assigned by MIAX Futures Onyx'
      - id: leg_ratio_and_side
        type: s4
        doc: 'Leg ratio for the specified instrument'
      - id: maturity_month_year
        type: u4
        doc: 'Maturity Month-Year is the expiration date of a Simple Instrument'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  system_state_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: tom_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Protocol Version'
      - id: session_id
        type: u1
        doc: 'Current trading session identifier'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'System Status'
  instrument_trading_status_notification_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique ID assigned by MIAX Futures Onyx'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'Market State'
  best_bid_and_offer_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique ID assigned by MIAX Futures Onyx'
      - id: mbb_price
        type: decimal_s8_9
        doc: 'Will be provided for updates as a result of any changes to the prices or sizes of the MBBO for an Simple Instrument or a Complex Instrument. Implied decimal with scale 1e-9'
      - id: mbb_size
        type: u4
        doc: 'Aggregate size in contracts at the displayed offer price'
      - id: mbo_price
        type: decimal_s8_9
        doc: 'Will be provided for updates as a result of any changes to the prices or sizes of the MBBO for an Simple Instrument or a Complex Instrumen. Implied decimal with scale 1e-9'
      - id: mbo_size
        type: u4
        doc: 'Aggregate size in contracts at the displayed offer price'
  last_sale_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique ID assigned by MIAX Futures Onyx'
      - id: trade_id
        type: u8
        doc: 'Unique ID assigned by the Matching Engine'
      - id: price
        type: decimal_s8_9
        doc: 'Execution price. Implied decimal with scale 1e-9'
      - id: size
        type: u4
        doc: 'Number of shares executed'
  trade_cancel_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2
        doc: 'Business Trade Date'
      - id: instrument_id
        type: u4
        doc: 'Unique ID assigned by MIAX Futures Onyx'
      - id: trade_id
        type: u8
        doc: 'Unique ID assigned by the Matching Engine'
      - id: correction_number
        type: u1
        doc: 'The latest correction number of the given Trade id'
      - id: price
        type: decimal_s8_9
        doc: 'Execution price. Implied decimal with scale 1e-9'
      - id: size
        type: u4
        doc: 'Number of shares executed'
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
      doc: 'used to disseminate all Simple Instruments traded on MIAX FuturesOnyx for the current trading session'
    2:
      id: 'complex_instrument_definition_message'
      doc: 'Used to disseminate all Complex Instruments traded on MIAX Futures Onyx for the current trading session'
    3: 'system_state_message'
    4:
      id: 'instrument_trading_status_notification_message'
      doc: 'Used to notify firms of changes to the trading status of a particular Simple or Complex instrument'
    15:
      id: 'best_bid_and_offer_message'
      doc: 'used to publish MIAX Futures Onyx Best Bid and Offer (MBBO) of a Simple Instrument or Complex Instrument'
    16:
      id: 'last_sale_message'
      doc: 'used to disseminate trades that are resulting from executions on MIAX Futures Onyx during the current trading session'
    14:
      id: 'trade_cancel_message'
      doc: 'used to publish cancellation of a Simple Instrument trade which was previously published via an Order Execution Message'
  underlying_asset_type:
    0x45:
      id: 'equity_index'
      doc: 'Equity Index'
    0x41:
      id: 'commodity_agriculture'
      doc: 'Commodity Agriculture'
  instrument_id_source:
    0x45:
      id: 'exchange'
      doc: 'Exchange'
  instrument_type:
    0x46:
      id: 'futures'
      doc: 'Futures'
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
      id: 'price_then_time'
      doc: 'Price Then Time'
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
      id: 'start_of_test_session'
      doc: 'Start Of Test Session'
    0x32:
      id: 'end_of_test_session'
      doc: 'End Of Test Session'
  trading_status:
    1:
      id: 'pre_open'
      doc: 'Pre Open'
    2:
      id: 'opening_freeze'
      doc: 'Opening Freeze'
    3:
      id: 'trading'
      doc: 'Trading'
    4:
      id: 'halt'
      doc: 'Halt'
    5:
      id: 'operational_halt'
      doc: 'Operational Halt'
    6:
      id: 'closed'
      doc: 'Closed'
  market_state:
    1:
      id: 'pre_opening'
      doc: 'Pre Opening'
    2:
      id: 'extended_1_trading_session'
      doc: 'Extended 1 Trading Session'
    3:
      id: 'regular_trading_session'
      doc: 'Regular Trading Session'
    4:
      id: 'extended_2_trading_session'
      doc: 'Extended 2 Trading Session'

