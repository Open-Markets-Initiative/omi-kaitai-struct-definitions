# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax OnyxFutures DepthOfMarketRetransmission SesM v1.3.a
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Depth Of Market Retransmission
#   Encoding: Session Management
#   Version: 1.3.a
#   Date: 7/31/2026
#   Specification: ONYX DoM Feed v1.3a.pdf
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
  id: miax_onyxfutures_depthofmarketretransmission_sesm_v1_3_a
  title: Miax OnyxFutures DepthOfMarketRetransmission SesM v1.3.a
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Futures Onyx Depth Of Market Retransmission SesM v1.3.a'
doc-ref: https://www.miaxglobal.com/markets/futures/miax-futures/onyx-interface-specifications

seq:
  - id: sesm_tcp_packet
    type: sesm_tcp_packet_struct
    repeat: eos
    doc: 'SesM Tcp Packet'

types:
  sesm_tcp_packet_struct:
    seq:
      - id: sesm_packet_header
        type: sesm_packet_header
        doc: 'SesM packet header'
      - id: sesm_payload
        size: sesm_packet_header.sesm_packet_length + 2 - 3
        type:
          switch-on: sesm_packet_header.sesm_packet_type
          cases:
            'sesm_packet_type::sequenced_data_packet': sequenced_data_packet
            'sesm_packet_type::unsequenced_data_packet': unsequenced_data_packet
            'sesm_packet_type::login_request': login_request
            'sesm_packet_type::login_response': login_response
            'sesm_packet_type::retransmission_request': retransmission_request
            'sesm_packet_type::logout_request': logout_request
            'sesm_packet_type::goodbye_packet': goodbye_packet
  sesm_packet_header:
    seq:
      - id: sesm_packet_length
        type: u2
        doc: 'The length of rest of the packet'
      - id: sesm_packet_type
        type: u1
        enum: sesm_packet_type
        doc: 'Code identifying this packet type'
  sequenced_data_packet:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.sesm_packet_header.sesm_packet_length - 1 - 9
        type:
          switch-on: message_type
          cases:
            'message_type::simple_instrument_definition_message': simple_instrument_definition_message
            'message_type::complex_instrument_definition_message': complex_instrument_definition_message
            'message_type::complex_instrument_definition_deprecated_message': complex_instrument_definition_deprecated_message
            'message_type::system_state_message': system_state_message
            'message_type::instrument_trading_status_notification_message': instrument_trading_status_notification_message
            'message_type::anticipated_opening_price_message': anticipated_opening_price_message
            'message_type::settlement_price_update_message': settlement_price_update_message
            'message_type::open_interest_update_message': open_interest_update_message
            'message_type::total_volume_update_message': total_volume_update_message
            'message_type::instrument_clear_message': instrument_clear_message
            'message_type::add_order_message': add_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::order_execution_message': order_execution_message
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
      - id: underlying_asset_alphanumeric_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Code'
      - id: product_group_code_alphanumeric_6
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
      - id: instrument_listing_status
        type: u1
        enum: instrument_listing_status
      - id: reserved_3
        size: 3
        doc: 'Currently reserved for future use'
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
        type: decimal_s8_9_nullable
        doc: 'The Upper Band of the Daily Trading Limit of a Futures Product. Implied decimal with scale 1e-9. Nullable, No Limit = 999999999999999999'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'The Lower Band of the Daily Trading Limit of a Futures Product. Implied decimal with scale 1e-9. Nullable, No Limit = -999999999999999999'
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
        type: u2
        doc: 'Maturity Date is the expiration date of a Simple Instrument'
      - id: valuation_date
        type: u2
        doc: 'The date that the Final Settlement Price will be calculated for purposes of Simple Instrument expiration'
      - id: first_trade_date
        type: u2
        doc: 'First Trade Date will be the Trading Date that the Simple Instrument is initially made available for Trading on MIAX Futures Onyx'
      - id: last_trade_date
        type: u2
        doc: 'Last Trade Date will be the Maturity Date of the Simple Instrument'
      - id: first_notice_date
        type: u2
        doc: 'Last business date of the month preceding the month of the Maturity Date of the Simple Instrument'
      - id: last_notice_date
        type: u2
        doc: 'Last Notice Date will be the business day preceding the Last Delivery Date of the Simple Instrument'
      - id: first_delivery_date
        type: u2
        doc: 'First Delivery Date will be the first business day of the month of the Maturity Date of the Simple Instrument'
      - id: last_delivery_date
        type: u2
        doc: 'Last Delivery Date will be the seventh business day following the Last Trading Date of the Simple Instrument'
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
        doc: 'The Instrument ID of the Futures Instrument that is the Underlying Asset of the Options on Futures , TAS, or BTIC, Instrument Value of 0 when Instrument Type is'
  complex_instrument_definition_message:
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
      - id: underlying_asset_alphanumeric_9
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Code'
      - id: product_group_code_alphanumeric_13
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product Group Code: e.g.: MWE for Hard Red Spring Wheat Standard Deliverable (5000 Bushels) Cross Product Spread example: XXX-YYY'
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
      - id: settlement_price
        type: decimal_s8_9
        doc: 'The previous day. Implied decimal with scale 1e-9'
      - id: settlement_price_type_calc_method
        type: u1
        enum: settlement_price_type_calc_method
        doc: 'Actual or Theoretical Settlement Price Indicator'
      - id: trading_collar_variation_type
        type: u1
        enum: trading_collar_variation_type
      - id: trading_collar_variation
        type: decimal_s8_9
        doc: 'The Dollar Value or Percentage Value used in the calculation of the Trading Collar. Implied decimal with scale 1e-9'
      - id: instrument_listing_status
        type: u1
        enum: instrument_listing_status
      - id: first_trade_date
        type: u2
        doc: 'First Trade Date will be the Trading Date that the Simple Instrument is initially made available for Trading on MIAX Futures Onyx'
      - id: reserved_64
        size: 64
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
      - id: maturity_date
        type: u2
        doc: 'Maturity Date is the expiration date of a Simple Instrument'
      - id: reserved_32
        size: 32
        doc: 'Currently reserved for future use'
  complex_instrument_definition_deprecated_message:
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
      - id: underlying_asset_alphanumeric_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Code'
      - id: product_group_code_alphanumeric_6
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
      - id: num_deprecated_instrument_leg
        type: u1
        doc: 'Number of strategy legs'
      - id: deprecated_instrument_leg
        type: deprecated_instrument_leg
        repeat: expr
        repeat-expr: num_deprecated_instrument_leg
        doc: 'Complex Strategy Number of Legs'
  deprecated_instrument_leg:
    seq:
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: leg_ratio_and_side
        type: s4
        doc: 'Leg ratio for the specified instrument Positive indicates Buy Negative indicates Sell'
      - id: reserved_4
        size: 4
        doc: 'Previously was Maturity Month-Year field; replaced by the Maturity Date field below'
      - id: maturity_date
        type: u2
        doc: 'Maturity Date is the expiration date of a Simple Instrument'
      - id: reserved_6
        size: 6
        doc: 'Reserved for future use'
  system_state_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: do_m_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'e.g.: DoM1.0'
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
  anticipated_opening_price_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: anticipated_opening_price
        type: decimal_s8_9_nullable
        doc: 'Anticipated Opening Price. Implied decimal with scale 1e-9. Nullable, No Opening Price = 999999999999999999'
      - id: opening_match_quantity
        type: u4
        doc: 'Opening Matched Quantity'
      - id: instrument_type
        type: u1
        enum: instrument_type
  settlement_price_update_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: settlement_price
        type: decimal_s8_9
        doc: 'The previous day. Implied decimal with scale 1e-9'
      - id: settlement_price_type
        type: u1
        enum: settlement_price_type
        doc: 'Daily or Final Settlement Price Indicator'
      - id: settlement_price_type_calc_method
        type: u1
        enum: settlement_price_type_calc_method
        doc: 'Actual or Theoretical Settlement Price Indicator'
  open_interest_update_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: open_interest_quantity
        type: u4
        doc: 'The amount of aggregate open contracts in a Simple Instrument'
  total_volume_update_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: total_volume
        type: u4
        doc: 'The aggregate amount of volume that has traded from the prior Trading Day'
  instrument_clear_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
  add_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order type'
      - id: order_id
        type: u8
        doc: 'Matching engine assigned Order ID'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Side of order'
      - id: price
        type: decimal_s8_9
        doc: 'Order price. Implied decimal with scale 1e-9'
      - id: size
        type: u4
        doc: 'Open order size'
      - id: instrument_type
        type: u1
        enum: instrument_type
  modify_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: order_id
        type: u8
        doc: 'Matching engine assigned Order ID'
      - id: price
        type: decimal_s8_9
        doc: 'Order price. Implied decimal with scale 1e-9'
      - id: size_flags
        type: u4
        doc: 'Open order size after this modify'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Side of order'
      - id: instrument_type
        type: u1
        enum: instrument_type
  delete_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: order_id
        type: u8
        doc: 'Matching engine assigned Order ID'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Side of order'
      - id: instrument_type
        type: u1
        enum: instrument_type
  order_execution_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Matching Engine time. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date'
      - id: instrument_id
        type: u4
        doc: 'Unique numeric ID assigned by MIAX Futures Onyx for a Simple instrument and is permanent for the life of a Simple instrument'
      - id: buy_order_id
        type: u8
        doc: 'Provided in the Add Order message'
      - id: sell_order_id
        type: u8
        doc: 'Provided in the Add Order message'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Side of the trade that was the Aggressor:'
      - id: trade_id
        type: u8
        doc: 'Unique ID assigned by the Matching Engine'
      - id: correction_number
        type: u1
        doc: 'Trade correction number'
      - id: price
        type: decimal_s8_9
        doc: 'Order price. Implied decimal with scale 1e-9'
      - id: size
        type: u4
        doc: 'Open order size'
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
        type: u2
        doc: 'Trade Date'
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
        doc: 'Order price. Implied decimal with scale 1e-9'
      - id: size
        type: u4
        doc: 'Open order size'
      - id: instrument_type
        type: u1
        enum: instrument_type
  unsequenced_data_packet:
    seq:
      - id: refresh_type
        type: u1
        enum: refresh_type
        doc: 'Request or response type of this unsequenced packet'
      - id: refresh_payload
        size: _parent.sesm_packet_header.sesm_packet_length - 1 - 1
        type:
          switch-on: refresh_type
          cases:
            'refresh_type::refresh_request': refresh_request
            'refresh_type::refresh_response': refresh_response
            'refresh_type::end_of_request': end_of_refresh
  refresh_request:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Category of data being refreshed'
  refresh_response:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent._parent.sesm_packet_header.sesm_packet_length - 2 - 9
        type:
          switch-on: message_type
          cases:
            'message_type::simple_instrument_definition_message': simple_instrument_definition_message
            'message_type::complex_instrument_definition_message': complex_instrument_definition_message
            'message_type::complex_instrument_definition_deprecated_message': complex_instrument_definition_deprecated_message
            'message_type::system_state_message': system_state_message
            'message_type::instrument_trading_status_notification_message': instrument_trading_status_notification_message
            'message_type::anticipated_opening_price_message': anticipated_opening_price_message
            'message_type::settlement_price_update_message': settlement_price_update_message
            'message_type::open_interest_update_message': open_interest_update_message
            'message_type::total_volume_update_message': total_volume_update_message
            'message_type::instrument_clear_message': instrument_clear_message
            'message_type::add_order_message': add_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::order_execution_message': order_execution_message
            'message_type::trade_cancel_message': trade_cancel_message
  end_of_refresh:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Category of data being refreshed'
  login_request:
    seq:
      - id: sesm_version
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: username
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX Futures Exchange during initial setup'
      - id: computer_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX Futures Exchange during initial setup'
      - id: application_protocol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Miax Application Protocol'
      - id: requested_session
        type: u1
        doc: 'Specifies the session the client would like to log into, or zero to log into the currently active session'
      - id: requested_sequence_number
        type: u8
        doc: 'Specifies client requested sequence number'
  login_response:
    seq:
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Login Status'
      - id: session_id
        type: u1
        doc: 'Current trading session identifier'
      - id: highest_sequence_number
        type: u8
        doc: 'the highest sequence number that the server currently has for the client'
  retransmission_request:
    seq:
      - id: start_sequence_number
        type: u8
        doc: 'Sequence number of the first packet to be retransmitted'
      - id: end_sequence_number
        type: u8
        doc: 'Sequence number of the last packet to be retransmitted'
  logout_request:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  goodbye_packet:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
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
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
    instances:
      is_null:
        value: value.mantissa == 999999999999999999

enums:
  sesm_packet_type:
    0x53:
      id: 'sequenced_data_packet'
      doc: 'SesM sequenced data packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SesM unsequenced data packet'
    0x4c:
      id: 'login_request'
      doc: 'SesM Login Request'
    0x52:
      id: 'login_response'
      doc: 'SesM Login Response'
    0x43:
      id: 'synchronization_complete'
      doc: 'SesM Synchronization Complete'
    0x41:
      id: 'retransmission_request'
      doc: 'SesM Retransmission Request'
    0x58:
      id: 'logout_request'
      doc: 'SesM Logout Request'
    0x47:
      id: 'goodbye_packet'
      doc: 'SesM Logout Request'
    0x45:
      id: 'end_of_session'
      doc: 'SesM End of Session'
    0x30:
      id: 'server_heartbeat'
      doc: 'SesM Server Heartbeat'
    0x31:
      id: 'client_heartbeat'
      doc: 'SesM Client Heartbeat'
  message_type:
    1:
      id: 'simple_instrument_definition_message'
      doc: 'Simple Instrument Definition'
    17:
      id: 'complex_instrument_definition_message'
      doc: 'Complex Instrument Definition'
    2:
      id: 'complex_instrument_definition_deprecated_message'
      doc: 'Complex Instrument Definition (deprecated)'
    3:
      id: 'system_state_message'
      doc: 'System State'
    4:
      id: 'instrument_trading_status_notification_message'
      doc: 'Instrument Trading Status Notification'
    5:
      id: 'anticipated_opening_price_message'
      doc: 'Anticipated Opening Price'
    6:
      id: 'settlement_price_update_message'
      doc: 'Settlement Price Update'
    7:
      id: 'open_interest_update_message'
      doc: 'Open Interest Update'
    8:
      id: 'total_volume_update_message'
      doc: 'Total Volume Update'
    9:
      id: 'instrument_clear_message'
      doc: 'Instrument Clear Message'
    10:
      id: 'add_order_message'
      doc: 'Add Order Message'
    11:
      id: 'modify_order_message'
      doc: 'Modify Order Message'
    12:
      id: 'delete_order_message'
      doc: 'Delete Order Message'
    13:
      id: 'order_execution_message'
      doc: 'Order Execution Message'
    14:
      id: 'trade_cancel_message'
      doc: 'Trade Cancel Message'
  underlying_asset_type:
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x41:
      id: 'commodity_agriculture'
      doc: 'Commodity Agriculture'
    0x46:
      id: 'futures'
      doc: 'Futures'
    0x4e:
      id: 'not_field'
      doc: 'Not'
  instrument_id_source:
    0x45:
      id: 'exchange'
      doc: 'Exchange'
  instrument_type:
    0x46:
      id: 'futures'
      doc: 'Futures'
    0x4f:
      id: 'options_on'
      doc: 'Options On'
    0x54:
      id: 'trade_at'
      doc: 'Trade At'
    0x42:
      id: 'basis'
      doc: 'Basis'
  instrument_listing_status:
    0x41:
      id: 'active'
      doc: 'Active'
    0x49:
      id: 'inactive'
      doc: 'Inactive'
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
      id: 'product'
      doc: 'Product'
    0x50:
      id: 'product_x50'
      doc: 'Product'
    0x4e:
      id: 'not_field'
      doc: 'Not'
  option_strike_currency:
    0x55:
      id: 'us_dollar'
      doc: 'Us Dollar'
    0x4e:
      id: 'na_when'
      doc: 'Na When'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x4e:
      id: 'na_when'
      doc: 'Na When'
  option_expiration_type:
    0x41:
      id: 'american_style'
      doc: 'American Style'
    0x45:
      id: 'european_style'
      doc: 'European Style'
    0x4e:
      id: 'na_when'
      doc: 'Na When'
  spread_type:
    0x53:
      id: 'standard'
      doc: 'Standard'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x42:
      id: 'butterfly'
      doc: 'Butterfly'
    0x43:
      id: 'cross'
      doc: 'Cross'
  system_status:
    0x53:
      id: 'start_of'
      doc: 'Start Of'
    0x43:
      id: 'end_of'
      doc: 'End Of'
    0x31:
      id: 'start_of_x31'
      doc: 'Start Of'
    0x32:
      id: 'end_of_x32'
      doc: 'End Of'
  settlement_price_type:
    0x44:
      id: 'daily'
      doc: 'Daily'
    0x46:
      id: 'final_field'
      doc: 'Final'
  order_type:
    0x53:
      id: 'simple'
      doc: 'Simple'
    0x43:
      id: 'complex'
      doc: 'Complex'
    0x44:
      id: 'derived'
      doc: 'Derived'
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  aggressor_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x4e:
      id: 'not_field'
      doc: 'Not'
  trade_type:
    0x4f:
      id: 'outright'
      doc: 'Outright'
    0x53:
      id: 'strategy'
      doc: 'Strategy'
    0x4d:
      id: 'strategy_x4d'
      doc: 'Strategy'
    0x43:
      id: 'complex'
      doc: 'Complex'
    0x4c:
      id: 'complex_x4c'
      doc: 'Complex'
    0x41:
      id: 'adjusted_late'
      doc: 'Adjusted Late'
  refresh_type:
    0x52:
      id: 'refresh_request'
      doc: 'Last value refresh request'
    0x72:
      id: 'refresh_response'
      doc: 'Last value refresh response'
    0x45:
      id: 'end_of_request'
      doc: 'Refresh of the requested message type is complete'
  refresh_message_type:
    0x49:
      id: 'simple_complex_instrument_definition_refresh'
      doc: 'Refresh of all simple and complex instrument definitions'
    0x54:
      id: 'instrument_trading_status_refresh'
      doc: 'Refresh of the trading status of every instrument'
    0x53:
      id: 'system_state_refresh'
      doc: 'Refresh of the current system state'
    0x4f:
      id: 'order_book_refresh'
      doc: 'Ordered replay of every message needed to rebuild the book'
  login_status:
    0x20:
      id: 'successful'
      doc: 'Successful'
    0x58:
      id: 'rejected'
      doc: 'Invalid Username/Computer ID combination'
    0x53:
      id: 'requested_session_is_not_available'
      doc: 'Requested session is not available'
    0x4e:
      id: 'invalid_start_sequence_number_requested'
      doc: 'Invalid start sequence number requested'
    0x49:
      id: 'incompatible_session_protocol_version'
      doc: 'Incompatible Session protocol version'
    0x41:
      id: 'incompatible_application_protocol_version'
      doc: 'Incompatible application protocol version'
    0x4c:
      id: 'request_rejected_because_client_already_logged_in'
      doc: 'Request rejected because client already logged in'
  logout_reason:
    0x20:
      id: 'graceful_logout'
      doc: 'Graceful Logout'
    0x42:
      id: 'bad_packet'
      doc: 'Bad SesM packet'
    0x4c:
      id: 'timed_out'
      doc: 'Timed out waiting for Login Packet'
    0x41:
      id: 'application_terminating_connection'
      doc: 'Application terminating connection'

