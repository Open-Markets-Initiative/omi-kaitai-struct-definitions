# ---------------------------------------------------------------------
# Kaitai struct definition for: Hkex HkexDerivatives FullTickRetrans Omd v1.47
#
# Protocol:
#   Organization: Hong Kong Exchanges and Clearing
#   Protocol: Orion Market Data Derivatives FullTick Retransmission
#   Encoding: Orion Market Data
#   Version: 1.47
#   Date: 10/14/2025
#   Specification: HKEX_OMD_Derivatives_Binary_Interface_Specifications_v1 47.pdf
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
  id: hkex_hkexderivatives_fulltickretrans_omd_v1_47
  title: Hkex HkexDerivatives FullTickRetrans Omd v1.47
  license: GPL-3.0
  endian: le

doc: 'Hong Kong Exchanges and Clearing Hkex Derivatives Market Orion Market Data Derivatives FullTick Retransmission Omd v1.47'
doc-ref: https://www.hkex.com.hk/Mutual-Market/Stock-Connect/Reference-Materials/Technical-Documents

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Omd packet header (byte-identical to the Udp form; SeqNum and SendTime set to 0 on Tcp per §3.5)'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.msg_count

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'Size of the packet including this field'
      - id: msg_count
        type: u1
        doc: 'Number of messages included in the packet'
      - id: compression_mode
        type: u1
        doc: 'Indicates if compression is applied on messages in the packet'
      - id: seq_num
        type: u4
        doc: 'Sequence number field — set to 0 on Tcp retrans per §3.5'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time field — set to 0 on Tcp retrans per §3.5. Nanoseconds since Unix epoch'
  message_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Omd message header'
      - id: payload
        size: msg_header.msg_size - 4
        type:
          switch-on: msg_header.msg_type
          cases:
            'msg_type::calculated_opening_price_message': calculated_opening_price_message
            'msg_type::sequence_reset': sequence_reset
            'msg_type::disaster_recovery_signal_message': disaster_recovery_signal_message
            'msg_type::market_alert_message': market_alert_message
            'msg_type::add_order_message': add_order_message
            'msg_type::modify_order_message': modify_order_message
            'msg_type::delete_order_message': delete_order_message
            'msg_type::orderbook_clear_message': orderbook_clear_message
            'msg_type::quote_request': quote_request
            'msg_type::commodity_definition_message': commodity_definition_message
            'msg_type::class_definition_message': class_definition_message
            'msg_type::series_definition_base_message': series_definition_base_message
            'msg_type::series_definition_extended_message': series_definition_extended_message
            'msg_type::combination_definition_message': combination_definition_message
            'msg_type::refresh_complete': refresh_complete
            'msg_type::logon': logon
            'msg_type::logon_response': logon_response
            'msg_type::retransmission_request': retransmission_request
            'msg_type::retransmission_response': retransmission_response
            'msg_type::market_status_message': market_status_message
            'msg_type::series_status_message': series_status_message
            'msg_type::commodity_status_message': commodity_status_message
            'msg_type::trade_message': trade_message
            'msg_type::trade_amendment_message': trade_amendment_message
  msg_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'Length of the message'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Code identifying this message type'
  calculated_opening_price_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: calculated_opening_price
        type: s4
        doc: 'Calculated Opening Price'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: quantity
        type: u8
        doc: 'Shows the quantity available at Calculated Opening Price'
  sequence_reset:
    seq:
      - id: new_seq_no
        type: u4
        doc: 'New sequence number'
  disaster_recovery_signal_message:
    seq:
      - id: dr_status
        type: u4
        enum: dr_status
        doc: 'Status during site failover'
  market_alert_message:
    seq:
      - id: alert_id
        type: u2
        doc: 'The reference ID for this alert,'
      - id: source
        type: u1
        enum: source
        doc: 'Source ID for this alert message'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: header
        size: 320
        doc: 'Header'
      - id: last_fragment
        type: u1
        enum: last_fragment
        doc: 'Indicates whether this message is'
      - id: info_type
        type: u1
        enum: info_type
        doc: 'Information Type'
      - id: priority
        type: u1
        enum: priority
        doc: 'Priority'
      - id: num_content
        type: u1
        doc: 'Maximum 3 lines'
      - id: content
        size: 320
        doc: 'Market Alert Content'
  add_order_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: order_id
        type: u8
        doc: 'Unique identifier per series'
      - id: price
        type: s4
        doc: 'Price'
      - id: order_quantity
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: lot_type
        type: u1
        doc: 'Lot Type'
      - id: order_type
        type: order_type
        doc: 'Order type bitmap'
      - id: order_book_position
        type: u4
        doc: 'Order rank information for the'
  order_type:
    meta:
      bit-endian: le
    seq:
      - id: force
        type: b1
        doc: 'Force'
      - id: short_sell
        type: b1
        doc: 'Short Sell'
      - id: market_bid
        type: b1
        doc: 'Market Bid'
      - id: price_stabilization
        type: b1
        doc: 'Price Stabilization'
      - id: override_crossing
        type: b1
        doc: 'Override Crossing'
      - id: undisclosed
        type: b1
        doc: 'Undisclosed'
      - id: unused_order_type_bit_7
        type: b1
        doc: 'Reserved'
      - id: unused_order_type_bit_8
        type: b1
        doc: 'Reserved'
      - id: unused_order_type_bit_9
        type: b1
        doc: 'Reserved'
      - id: unused_order_type_bit_10
        type: b1
        doc: 'Reserved'
      - id: fill_and_kill_immediately
        type: b1
        doc: 'Fill-and-kill immediately'
      - id: firm_color_disabled
        type: b1
        doc: 'Firm color disabled'
      - id: convert_to_aggressive
        type: b1
        doc: 'Convert to aggressive'
      - id: bait_or_implied_order
        type: b1
        doc: 'Bait or implied order'
      - id: unused_order_type_bit_15
        type: b1
        doc: 'Reserved'
      - id: unused_order_type_bit_16
        type: b1
        doc: 'Reserved'
  modify_order_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: order_id
        type: u8
        doc: 'Unique identifier per series'
      - id: price
        type: s4
        doc: 'Price'
      - id: order_quantity
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: order_type
        type: order_type
        doc: 'Order type bitmap'
      - id: order_book_position
        type: u4
        doc: 'Order rank information for the'
  delete_order_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: order_id
        type: u8
        doc: 'Unique identifier per series'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  orderbook_clear_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
  quote_request:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: number_of_lots
        type: s4
        doc: 'Number of Lots'
      - id: bid_ask_flag
        type: u1
        enum: bid_ask_flag
        doc: 'Indicates if the quote request is for a Bid or Ask or both'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  commodity_definition_message:
    seq:
      - id: commodity_code
        type: u2
        doc: 'Numerical identifier of the Underlying This'
      - id: decimal_in_underlying_price
        type: u2
        doc: 'Number of implicit decimals in the underlying'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code which uniquely identifies a specific'
      - id: base_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'underlying The representation of the'
      - id: underlying_price_unit
        type: u1
        enum: underlying_price_unit
        doc: 'The price unit for the underlying'
      - id: commodity_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Descriptive Name of the underlying'
      - id: nominal_value
        type: s8
        doc: 'Nominal Value of the Commodity'
      - id: underlying_code
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Code of the Commodity'
      - id: underlying_type
        type: u1
        enum: underlying_type
        doc: 'Type of the underlying'
      - id: effective_tomorrow
        type: u1
        enum: effective_tomorrow
        doc: 'This declaration is for series to be traded the'
      - id: commodity_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Commodity ID of the underlying'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  class_definition_message:
    seq:
      - id: country
        type: u1
        doc: 'Country Identifier'
      - id: market
        type: u1
        enum: market
        doc: 'Market Code'
      - id: instrument_group
        type: u1
        enum: instrument_group
        doc: 'Instrument Group This field'
      - id: modifier
        type: u1
        doc: 'Expiration date modified'
      - id: commodity_code
        type: u2
        doc: 'Numerical identifier of the Underlying This'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: price_quotation_factor
        type: s4
        doc: 'Implies the contracted value'
      - id: contract_size
        type: u4
        doc: 'Number of Underlying'
      - id: decimal_in_strike_price
        type: u2
        doc: 'Number of implicit decimals'
      - id: decimal_in_contract_size
        type: u2
        doc: 'in the Contract Size and the'
      - id: decimal_in_premium
        type: u2
        doc: 'The number of decimals'
      - id: ranking_type
        type: u2
        enum: ranking_type
        doc: 'This identifies how the instrument is ranked'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Defines if the instrument is a'
      - id: premium_unit_4_price
        type: u1
        enum: premium_unit_4_price
        doc: 'The premium unit that describes the price unit in the order'
      - id: base_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'underlying The representation of the'
      - id: instrument_class_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ASCII representation of'
      - id: instrument_class_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The full ASCII representation'
      - id: is_fractions
        type: u1
        enum: is_fractions
        doc: 'Is the premium internally'
      - id: settlement_currency_id
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Full descriptive name of the'
      - id: effective_tomorrow
        type: u1
        enum: effective_tomorrow
        doc: 'This declaration is for series to be traded the'
      - id: tick_step_size
        type: s4
        doc: 'Minimum Fluctuation of the'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  series_definition_base_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short Name'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Financial Product'
      - id: number_of_decimals_price
        type: u2
        doc: 'The number of decimals used in'
      - id: number_of_legs
        type: u1
        doc: 'Number of legs in the series'
      - id: strike_price
        type: s4
        doc: 'In general, it is the price at which a'
      - id: expiration_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expiry date of the series'
      - id: decimal_in_strike_price
        type: u2
        doc: 'Number of implicit decimals'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Identifies whether the series is a put or call type'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  series_definition_extended_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short Name'
      - id: country
        type: u1
        doc: 'Country Identifier'
      - id: market
        type: u1
        enum: market
        doc: 'Market Code'
      - id: instrument_group
        type: u1
        enum: instrument_group
        doc: 'Instrument Group This field'
      - id: modifier
        type: u1
        doc: 'Expiration date modified'
      - id: commodity_code
        type: u2
        doc: 'Numerical identifier of the Underlying This'
      - id: expiry_date
        type: u2
        doc: 'Expiry date of the series'
      - id: strike_price
        type: s4
        doc: 'In general, it is the price at which a'
      - id: contract_size_extended
        type: s8
        doc: 'Number of Underlying entities per contract'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code which uniquely identifies a specific'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'The actual status of the series'
      - id: effective_tomorrow
        type: u1
        enum: effective_tomorrow
        doc: 'This declaration is for series to be traded the'
      - id: price_quotation_factor
        type: s4
        doc: 'Implies the contracted value'
      - id: price_method
        type: u1
        enum: price_method
        doc: 'Specifics the pricing method used for the combo series'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: effective_exp_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The effective expiration date is the'
      - id: date_time_last_trading
        type: s8
        doc: 'The last trading date/time of the'
      - id: date_time_first_trading
        type: s8
        doc: 'The first trading date/time of the'
  combination_definition_message:
    seq:
      - id: combo_orderbook_id
        type: u4
        doc: 'Numerical identifier of the'
      - id: leg_orderbook_id
        type: u4
        doc: 'This is the orderbook identification'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Identifies whether the leg within'
      - id: leg_ratio
        type: s4
        doc: 'Relative numbers of bid and ask'
  refresh_complete:
    seq:
      - id: last_seq_num
        type: u4
        doc: 'Sequence number with which the refresh is synchronized'
  logon:
    seq:
      - id: username
        type: str
        size: 12
        encoding: ASCII
        doc: 'Username to log on, padded'
  logon_response:
    seq:
      - id: session_status
        type: u1
        enum: session_status
        doc: 'Status of the session'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  retransmission_request:
    seq:
      - id: channel_id
        type: u2
        doc: 'Multicast Channel ID to which'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: begin_seq_num
        type: u4
        doc: 'Beginning of sequence'
      - id: end_seq_num
        type: u4
        doc: 'Message sequence number of'
  retransmission_response:
    seq:
      - id: channel_id
        type: u2
        doc: 'Multicast Channel ID to which'
      - id: retrans_status
        type: u1
        enum: retrans_status
        doc: 'Status of the Retransmission response'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: begin_seq_num
        type: u4
        doc: 'Beginning of sequence'
      - id: end_seq_num
        type: u4
        doc: 'Message sequence number of'
  market_status_message:
    seq:
      - id: state_level
        type: u2
        enum: state_level
        doc: 'Indicates the level which a state applies'
      - id: market
        type: u1
        enum: market
        doc: 'Market Code'
      - id: instrument
        type: u1
        doc: 'Instrument Group'
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: commodity_code
        type: u2
        doc: 'Numerical identifier of the Underlying This'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: actual_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'UTC Start Date'
      - id: actual_start_time
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'UTC Start Time If specified it is a'
      - id: planned_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'UTC next planned Date'
      - id: planned_start_time
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'UTC next planned time'
      - id: seconds_to_state_change
        type: u2
        doc: 'Number of seconds to the next'
      - id: state
        type: u2
        enum: state
        doc: 'Numeric identification of the State Type'
      - id: priority
        type: u1
        enum: priority
        doc: 'Priority'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  series_status_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: suspension_indicator
        type: u1
        enum: suspension_indicator
        doc: 'Indicates if the series is suspended'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'The actual status of the series'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  commodity_status_message:
    seq:
      - id: commodity_code
        type: u2
        doc: 'Numerical identifier of the Underlying This'
      - id: suspended
        type: u1
        enum: suspended
        doc: 'Defines if the commodity is'
      - id: locked
        type: u1
        enum: locked
        doc: 'Specifics if the underlying is locked'
  trade_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Order book ID'
      - id: order_id
        type: u8
        doc: 'Unique identifier per series'
      - id: price
        type: s4
        doc: 'Price'
      - id: trade_id
        type: u8
        doc: 'Unique trade identification'
      - id: combo_group_id
        type: u4
        doc: 'Used to group combo and'
      - id: trade_side
        type: u1
        enum: trade_side
        doc: 'Side of Orderbook ID'
      - id: deal_type
        type: deal_type
        doc: 'Deal type bitmap'
      - id: trade_condition
        type: trade_condition
        doc: 'Trade condition bitmap'
      - id: deal_info
        type: deal_info
        doc: 'Trade condition bitmap'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: quantity
        type: u8
        doc: 'Shows the quantity available at Calculated Opening Price'
      - id: trade_time
        type: u8
        doc: 'Date and time of the last'
  deal_type:
    meta:
      bit-endian: le
    seq:
      - id: printable
        type: b1
        doc: 'Printable'
      - id: occurred_at_cross
        type: b1
        doc: 'Occurred at Cross'
      - id: reported_trade
        type: b1
        doc: 'Reported Trade'
      - id: unused_5
        type: b5
        doc: 'Reserved'
  trade_condition:
    meta:
      bit-endian: le
    seq:
      - id: late_trade
        type: b1
        doc: 'Late Trade'
      - id: internal_trade_or_cross
        type: b1
        doc: 'Internal Trade / Crossing'
      - id: buy_write
        type: b1
        doc: 'Buy Write'
      - id: off_market
        type: b1
        doc: 'Off Market'
      - id: unused_12
        type: b12
        doc: 'Reserved'
  deal_info:
    meta:
      bit-endian: le
    seq:
      - id: reported_trade
        type: b1
        doc: 'Reported Trade'
      - id: unused_15
        type: b15
        doc: 'Reserved'
  trade_amendment_message:
    seq:
      - id: trade_id
        type: u8
        doc: 'Unique trade identification'
      - id: combo_group_id
        type: u4
        doc: 'Used to group combo and'
      - id: price
        type: s4
        doc: 'Price'
      - id: quantity
        type: u8
        doc: 'Shows the quantity available at Calculated Opening Price'
      - id: trade_time
        type: u8
        doc: 'Date and time of the last'
      - id: trade_state
        type: u1
        enum: trade_state
        doc: 'Trade State'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
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

enums:
  msg_type:
    364:
      id: 'calculated_opening_price_message'
      doc: 'The Calculated Opening Price (COP) message indicates an instrument''s theoretical opening price during the pre-opening phases of the market prior to an auction'
    100:
      id: 'sequence_reset'
      doc: 'The Sequence Reset message is sent on each multicast channel at start of day'
    105:
      id: 'disaster_recovery_signal_message'
      doc: 'The Disaster Recovery Signal message is sent on a dedicated multicast channel whenever a site failover scenario is triggered'
    323:
      id: 'market_alert_message'
      doc: 'The Market Alert message is generated periodically to relay market announcements and alerts'
    330:
      id: 'add_order_message'
      doc: 'The Add Order message is generated when a new order is inserted into the order book'
    331:
      id: 'modify_order_message'
      doc: 'The Modify Order message is generated when an existing order identified by the OrderID is modified'
    332:
      id: 'delete_order_message'
      doc: 'The Delete Order message is generated when an existing order identified by the OrderBookID, OrderID and Side is deleted'
    335:
      id: 'orderbook_clear_message'
      doc: 'The Orderbook Clear message is used to inform clients that all existing orders should be removed from both the bid and ask sides of the specified orderbook'
    336:
      id: 'quote_request'
      doc: 'The Quote Request message is generated whenever market participants request a new quotation'
    301:
      id: 'commodity_definition_message'
      doc: 'Describes individual commodities available from the OMD-D system'
    302:
      id: 'class_definition_message'
      doc: 'Describes individual instrument classes available from the OMD-D system'
    303:
      id: 'series_definition_base_message'
      doc: 'Describes basic series information'
    304:
      id: 'series_definition_extended_message'
      doc: 'Describes series static data'
    305:
      id: 'combination_definition_message'
      doc: 'Describes a combination orderbook'
    203:
      id: 'refresh_complete'
      doc: 'This message is published to mark the end of a refresh cycle'
    101:
      id: 'logon'
      doc: 'Logon'
    102:
      id: 'logon_response'
      doc: 'LogonResponse'
    201:
      id: 'retransmission_request'
      doc: 'RetransmissionRequest'
    202:
      id: 'retransmission_response'
      doc: 'RetransmissionResponse'
    320:
      id: 'market_status_message'
      doc: 'The Market Status message can be used to derive the active state of a series'
    321:
      id: 'series_status_message'
      doc: 'The Series Status message is generated whenever there is a change to suspension indicator or series status, or when the date/time of last trading is changed'
    322:
      id: 'commodity_status_message'
      doc: 'The Commodity Status message is generated whenever a commodity status changes'
    350:
      id: 'trade_message'
      doc: 'The trade message is generated each time a trade has been performed'
    356:
      id: 'trade_amendment_message'
      doc: 'Represents a trade amendment or cancellation'
  dr_status:
    1:
      id: 'in_progress'
      doc: 'In Progress'
    2:
      id: 'completed'
      doc: 'Completed'
  source:
    0x48:
      id: 'trading_system'
      doc: 'Market Alerts Sent Through The Trading System'
    0x4d:
      id: 'other_market_alerts'
      doc: 'Other Market Alerts'
  last_fragment:
    0x59:
      id: 'complete'
      doc: 'Complete'
    0x4d:
      id: 'not_complete'
      doc: 'Not Complete'
  info_type:
    0:
      id: 'not_specified'
      doc: 'Not Specified'
    1:
      id: 'company_announcement'
      doc: 'Company Announcement'
    2:
      id: 'market_message'
      doc: 'Market Message'
    3:
      id: 'static_line'
      doc: 'Static Line'
    4:
      id: 'notice_received'
      doc: 'Notice Received'
  priority:
    0:
      id: 'not_specified'
      doc: 'Not Specified'
    1:
      id: 'low'
      doc: 'Low'
    2:
      id: 'medium'
      doc: 'Medium'
    3:
      id: 'high'
      doc: 'High'
    4:
      id: 'critical'
      doc: 'Critical'
  side:
    0:
      id: 'bid'
      doc: 'Bid'
    1:
      id: 'offer'
      doc: 'Offer'
  bid_ask_flag:
    0:
      id: 'bid'
      doc: 'Bid'
    1:
      id: 'ask'
      doc: 'Ask'
    2:
      id: 'both'
      doc: 'Bid And Ask'
  underlying_price_unit:
    1:
      id: 'price'
      doc: 'Price'
    2:
      id: 'yield_field'
      doc: 'Yield'
    3:
      id: 'points'
      doc: 'Points'
    4:
      id: 'yield_diff'
      doc: 'Yield Diff'
    5:
      id: 'imm_index'
      doc: 'Imm Index'
    6:
      id: 'basis_points'
      doc: 'Basis Points'
    7:
      id: 'inverted_yield'
      doc: 'Inverted Yield'
    8:
      id: 'percentage_of_nominal'
      doc: 'Percentage Of Nominal'
    9:
      id: 'dirty_price'
      doc: 'Dirty Price'
  underlying_type:
    1:
      id: 'stock'
      doc: 'Stock'
    2:
      id: 'currency'
      doc: 'Currency'
    3:
      id: 'interest_rate'
      doc: 'Interest Rate'
    4:
      id: 'energy'
      doc: 'Energy'
    5:
      id: 'soft_and_agrics'
      doc: 'Soft And Agrics'
    6:
      id: 'metal'
      doc: 'Metal'
    7:
      id: 'stock_index'
      doc: 'Stock Index'
    8:
      id: 'currency_index'
      doc: 'Currency Index'
    9:
      id: 'interest_rate_index'
      doc: 'Interest Rate Index'
    10:
      id: 'energy_index'
      doc: 'Energy Index'
    11:
      id: 'softs_and_agrics_index'
      doc: 'Softs And Agrics Index'
    12:
      id: 'metal_index'
      doc: 'Metal Index'
  effective_tomorrow:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  market:
    1:
      id: 'cesc_index_futures_and_options'
      doc: 'Cesc Index Futures And Options'
    2:
      id: 'stock_futures_in_omdd_partition_1'
      doc: 'Stock Futures In Omdd Partition 1'
    3:
      id: 'three_year_exchange_fund_note_futures'
      doc: 'Three Year Exchange Fund Note Futures'
    16:
      id: 'mini_hang_seng_index_futures_and_options'
      doc: 'Mini Hang Seng Index Futures And Options'
    18:
      id: 'weekly_stock_options_in_omdd_partition_1'
      doc: 'Weekly Stock Options In Omdd Partition 1'
    20:
      id: 'stock_options_in_omdd_partition_1'
      doc: 'Stock Options In Omdd Partition 1'
    24:
      id: 'hibor'
      doc: 'Hibor'
    27:
      id: 'dividend_futures'
      doc: 'Dividend Futures'
    32:
      id: 'physically_settled_options_on_futures_contracts_on_hang_seng_index_futures'
      doc: 'Physically Settled Options On Futures Contracts On Hang Seng Index Futures'
    34:
      id: 'hang_seng_index_futures_and_options'
      doc: 'Hang Seng Index Futures And Options'
    35:
      id: 'flexible_hang_seng_index_options'
      doc: 'Flexible Hang Seng Index Options'
    37:
      id: 'flexible_hang_seng_china_enterprises_index_options'
      doc: 'Flexible Hang Seng China Enterprises Index Options'
    38:
      id: 'hang_seng_china_enterprises_index_futures_and_options'
      doc: 'Hang Seng China Enterprises Index Futures And Options'
    39:
      id: 'weekly_hang_seng_index_options'
      doc: 'Weekly Hang Seng Index Options'
    40:
      id: 'physically_settled_options_on_futures_contracts_on_hang_seng_china_enterprises_index_futures'
      doc: 'Physically Settled Options On Futures Contracts On Hang Seng China Enterprises Index Futures'
    51:
      id: 'hsi_volatility_index_futures'
      doc: 'Hsi Volatility Index Futures'
    60:
      id: 'sector_index_futures'
      doc: 'Sector Index Futures'
    70:
      id: 'renminbi_currency_futures_and_options'
      doc: 'Renminbi Currency Futures And Options'
    80:
      id: 'hang_seng_biotech_index_futures'
      doc: 'Hang Seng Biotech Index Futures'
    83:
      id: 'physically_settled_options_on_futures_contracts_on_hang_seng_tech_index_futures_options'
      doc: 'Physically Settled Options On Futures Contracts On Hang Seng Tech Index Futures Options'
    84:
      id: 'weekly_hang_seng_tech_index_options'
      doc: 'Weekly Hang Seng Tech Index Options'
    86:
      id: 'hang_seng_tech_index_futures_and_options'
      doc: 'Hang Seng Tech Index Futures And Options'
    87:
      id: 'hang_seng_index_and_hang_seng_china_enterprises_index_gross_and_net_total_return_index_futures'
      doc: 'Hang Seng Index And Hang Seng China Enterprises Index Gross And Net Total Return Index Futures'
    93:
      id: 'weekly_hang_seng_china_enterprises_index_options'
      doc: 'Weekly Hang Seng China Enterprises Index Options'
    96:
      id: 'ibovespa_index_futures'
      doc: 'Ibovespa Index Futures'
    99:
      id: 'sp_bse_sensex_index_futures'
      doc: 'Sp Bse Sensex Index Futures'
    102:
      id: 'ftse_and_jse_top_40_index_futures'
      doc: 'Ftse And Jse Top 40 Index Futures'
    108:
      id: 'micex_index_futures'
      doc: 'Micex Index Futures'
    111:
      id: 'msci_ax_j_futures_ntr'
      doc: 'Msci Ax J Futures Ntr'
    112:
      id: 'physically_settled_usd_silver_futures'
      doc: 'Physically Settled Usd Silver Futures'
    115:
      id: 'physically_settled_cnh_silver_futures'
      doc: 'Physically Settled Cnh Silver Futures'
    116:
      id: 'physically_settled_cnh_gold_futures'
      doc: 'Physically Settled Cnh Gold Futures'
    117:
      id: 'physically_settled_usd_gold_futures'
      doc: 'Physically Settled Usd Gold Futures'
    118:
      id: 'mof_t_bond_futures'
      doc: 'Mof T Bond Futures'
    120:
      id: 'usd_base_and_ferrous_futures'
      doc: 'Usd Base And Ferrous Futures'
    122:
      id: 'cnh_london_metal_mini_futures'
      doc: 'Cnh London Metal Mini Futures'
    125:
      id: 'cash_settled_rmb_currency_futures'
      doc: 'Cash Settled Rmb Currency Futures'
    153:
      id: 'msci_china_a_50_connect_index_futures'
      doc: 'Msci China A 50 Connect Index Futures'
    160:
      id: 'msci_jpy_index_futures_price_and_ntr'
      doc: 'Msci Jpy Index Futures Price And Ntr'
    161:
      id: 'msci_usd_index_futures_ntr'
      doc: 'Msci Usd Index Futures Ntr'
    163:
      id: 'msci_usd_index_futures_and_options_price_1'
      doc: 'Msci Usd Index Futures And Options Price 1'
    164:
      id: 'msci_usd_index_futures_and_options_price_2'
      doc: 'Msci Usd Index Futures And Options Price 2'
    166:
      id: 'msci_usd_index_futures_and_options_price_3'
      doc: 'Msci Usd Index Futures And Options Price 3'
    168:
      id: 'msci_usd_index_futures_and_options_price_4'
      doc: 'Msci Usd Index Futures And Options Price 4'
    170:
      id: 'msci_sgd_index_futures_price'
      doc: 'Msci Sgd Index Futures Price'
  instrument_group:
    4:
      id: 'futures'
      doc: 'Futures'
    6:
      id: 'american_style_call'
      doc: 'American Style Call'
    7:
      id: 'american_style_put'
      doc: 'American Style Put'
    22:
      id: 'european_style_call'
      doc: 'European Style Call'
    23:
      id: 'european_style_put'
      doc: 'European Style Put'
    170:
      id: 'options_straddle'
      doc: 'Options Straddle'
    171:
      id: 'options_strangle'
      doc: 'Options Strangle'
    172:
      id: 'synthetic_futures'
      doc: 'Standard Combo Series For Stock Options Market'
    201:
      id: 'time_spread_level_1'
      doc: 'Time Spread Level 1'
    202:
      id: 'time_spread_level_2'
      doc: 'Time Spread Level 2'
    203:
      id: 'time_spread_level_3'
      doc: 'Time Spread Level 3'
    204:
      id: 'time_spread_level_4'
      doc: 'Time Spread Level 4'
    205:
      id: 'time_spread_level_5'
      doc: 'Time Spread Level 5'
    206:
      id: 'time_spread_level_6'
      doc: 'Time Spread Level 6'
    207:
      id: 'time_spread_level_7'
      doc: 'Time Spread Level 7'
    208:
      id: 'time_spread_level_8'
      doc: 'Time Spread Level 8'
    209:
      id: 'time_spread_level_9'
      doc: 'Time Spread Level 9'
    210:
      id: 'time_spread_level_10'
      doc: 'Time Spread Level 10'
    211:
      id: 'time_spread_level_11'
      doc: 'Time Spread Level 11'
    212:
      id: 'time_spread_level_12'
      doc: 'Time Spread Level 12'
    213:
      id: 'time_spread_level_13'
      doc: 'Time Spread Level 13'
    214:
      id: 'time_spread_level_14'
      doc: 'Time Spread Level 14'
    215:
      id: 'time_spread_level_15'
      doc: 'Time Spread Level 15'
    216:
      id: 'time_spread_level_16'
      doc: 'Time Spread Level 16'
    217:
      id: 'time_spread_level_17'
      doc: 'Time Spread Level 17'
    218:
      id: 'time_spread_level_18'
      doc: 'Time Spread Level 18'
    219:
      id: 'time_spread_level_19'
      doc: 'Time Spread Level 19'
    220:
      id: 'time_spread_level_20'
      doc: 'Time Spread Level 20'
    221:
      id: 'time_spread_level_21'
      doc: 'Time Spread Level 21'
    222:
      id: 'time_spread_level_22'
      doc: 'Time Spread Level 22'
    223:
      id: 'time_spread_level_23'
      doc: 'Time Spread Level 23'
    250:
      id: 'tailor_made_combination'
      doc: 'Tailor Made Combination'
    254:
      id: 'exchange_rate'
      doc: 'Exchange Rate'
    255:
      id: 'payment_currency'
      doc: 'Payment Currency'
  ranking_type:
    1:
      id: 'price_then_time'
      doc: 'Price Then Time'
    2:
      id: 'inverted_price_then_time'
      doc: 'Inverted Price Then Time'
    3:
      id: 'price_then_traders_then_time'
      doc: 'Price Traders Before Mm Time'
    4:
      id: 'inverted_price_then_traders_then_time'
      doc: 'Inverted Price Traders Before Mm Time'
    5:
      id: 'price_then_market_makers_then_time'
      doc: 'Price Mm Before Traders Time'
    6:
      id: 'inverted_price_then_market_makers_then_time'
      doc: 'Inverted Price Mm Before Traders Time'
    7:
      id: 'price_then_baits_then_time'
      doc: 'Price Baits Before Normal Orders Time'
    8:
      id: 'inverted_price_then_baits_then_time'
      doc: 'Inverted Price Baits Before Normal Orders Time'
    11:
      id: 'price_then_own_orders_then_time'
      doc: 'Price Own Orders Time'
    12:
      id: 'inverted_price_then_own_orders_then_time'
      doc: 'Inverted Price Own Orders Time'
  tradable:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  premium_unit_4_price:
    1:
      id: 'price'
      doc: 'Price'
    2:
      id: 'yield_field'
      doc: 'Yield'
    3:
      id: 'points'
      doc: 'Points'
    4:
      id: 'yield_diff'
      doc: 'Yield Diff'
    5:
      id: 'imm_index'
      doc: 'Imm Index'
    6:
      id: 'basis_points'
      doc: 'Basis Points'
    7:
      id: 'inverted_yield'
      doc: 'Inverted Yield'
    8:
      id: 'percentage_of_nominal'
      doc: 'Percentage Of Nominal'
    9:
      id: 'dirty_price'
      doc: 'Dirty Price'
  is_fractions:
    0x31:
      id: 'yes_field'
      doc: 'Yes'
    0x32:
      id: 'no_field'
      doc: 'No'
  financial_product:
    1:
      id: 'option'
      doc: 'Option'
    2:
      id: 'forward'
      doc: 'Forward'
    3:
      id: 'future'
      doc: 'Future'
    4:
      id: 'fra'
      doc: 'Fra'
    5:
      id: 'cash'
      doc: 'Cash'
    6:
      id: 'payment'
      doc: 'Payment'
    7:
      id: 'exchange_rate'
      doc: 'Exchange Rate'
    8:
      id: 'interest_rate_swap'
      doc: 'Interest Rate Swap'
    9:
      id: 'repo'
      doc: 'Repo'
    10:
      id: 'synthetic_box_leg_reference'
      doc: 'Synthetic Box Leg Reference'
    11:
      id: 'standard_combination'
      doc: 'Standard Combination'
    12:
      id: 'guarantee'
      doc: 'Guarantee'
    13:
      id: 'otc_general'
      doc: 'Otc General'
    14:
      id: 'equity_warrant'
      doc: 'Equity Warrant'
    15:
      id: 'security_lending'
      doc: 'Security Lending'
  put_or_call:
    0:
      id: 'undefined'
      doc: 'Undefined'
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  series_status:
    0:
      id: 'not_available'
      doc: 'Not Available'
    1:
      id: 'active'
      doc: 'Both Expired And Not Expired'
    2:
      id: 'suspended'
      doc: 'Suspended'
    3:
      id: 'issued'
      doc: 'Issued'
    4:
      id: 'delisted'
      doc: 'Delisted'
    5:
      id: 'locked'
      doc: 'Suspended For Trading And Posttrade Operations'
  price_method:
    0:
      id: 'not_available'
      doc: 'Not Available'
    1:
      id: 'net_price'
      doc: 'Net Price'
    2:
      id: 'net_value'
      doc: 'Net Value'
  leg_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
    0x32:
      id: 'net_value'
      doc: 'Net Value'
  session_status:
    0:
      id: 'session_active'
      doc: 'Session Active'
    5:
      id: 'invalid_username_or_ip_address'
      doc: 'Invalid Username Or Ip Address'
    100:
      id: 'user_already_connected'
      doc: 'User Already Connected'
  retrans_status:
    0:
      id: 'request_accepted'
      doc: 'Request Accepted'
    1:
      id: 'unkown_unauthorized_channel_id'
      doc: 'Unkown Unauthorized Channel Id'
    2:
      id: 'messages_not_available'
      doc: 'Messages Not Available'
    100:
      id: 'exceeds_maximum_sequence_range'
      doc: 'Exceeds Maximum Sequence Range'
    101:
      id: 'exceeds_maximum_requests_in_a_day'
      doc: 'Exceeds Maximum Requests In A Day'
  state_level:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'instrument_type'
      doc: 'Instrument Type'
    3:
      id: 'instrument_class'
      doc: 'Instrument Class'
    4:
      id: 'instrument_series'
      doc: 'Instrument Series'
    5:
      id: 'underlying'
      doc: 'Underlying'
    99:
      id: 'end_of_business_day'
      doc: 'End Of Business Day'
  state:
    1:
      id: 'open_allocation'
      doc: 'Open Allocation'
    2:
      id: 'market_closed'
      doc: 'Market Closed'
    3:
      id: 'market_open'
      doc: 'Market Open'
    4:
      id: 'preopen_session'
      doc: 'Preopen Session'
    5:
      id: 'preopen_allocation_session'
      doc: 'Preopen Allocation Session'
    6:
      id: 'market_pause'
      doc: 'Market Pause'
    7:
      id: 'premarket_activities'
      doc: 'Premarket Activities'
    8:
      id: 'clearing_session_started'
      doc: 'Clearing Session Started'
    9:
      id: 'clearing_session_closed'
      doc: 'Clearing Session Closed'
    10:
      id: 'ahft_market_closed'
      doc: 'Ahft Market Closed'
    11:
      id: 'ahft_reset_price_information'
      doc: 'Ahft Reset Price Information'
    12:
      id: 'ahft_inactive_non_order'
      doc: 'Ahft Inactive Non Order'
    13:
      id: 'ahft_reset_price_information_for_next_business_day'
      doc: 'Ahft Reset Price Information For Next Business Day'
    14:
      id: 'ahft_market_open'
      doc: 'Ahft Market Open'
    15:
      id: 'ahft_market_open_price_limit'
      doc: 'Ahft Market Open Price Limit'
    16:
      id: 'ahft_premarket_activities'
      doc: 'Ahft Premarket Activities'
    17:
      id: 'market_open_with_price_controls'
      doc: 'Market Open With Price Controls'
    18:
      id: 'market_closed_today'
      doc: 'Market Closed Today'
    19:
      id: 'market_open_with_dynamic_price_banding_mechanism'
      doc: 'Market Open With Dynamic Price Banding Mechanism'
    20:
      id: 'site_failover'
      doc: 'Site Failover'
    21:
      id: 'market_closed_today_e'
      doc: 'Market Closed Today E'
    22:
      id: 'ahft_market_closed_e'
      doc: 'Ahft Market Closed E'
    23:
      id: 'market_open_with_dpbm_and_vcm'
      doc: 'Market Open With Dpbm And Vcm'
    24:
      id: 'market_open_with_vcm'
      doc: 'Market Open With Vcm'
    25:
      id: 'vcm_cool_off_status_with_dynamic_price_banding_mechansim'
      doc: 'Vcm Cool Off Status With Dynamic Price Banding Mechansim'
    26:
      id: 'vcm_cool_off_status'
      doc: 'Vcm Cool Off Status'
    27:
      id: 'reset_counter_for_vcm'
      doc: 'Reset Counter For Vcm'
    28:
      id: 'halt'
      doc: 'Halt'
    29:
      id: 'reset_price_information'
      doc: 'Reset Price Information'
    30:
      id: 'block_trade_only'
      doc: 'Block Trade Only'
  suspension_indicator:
    1:
      id: 'suspended_for_trading'
      doc: 'Suspended For Trading'
    2:
      id: 'not_suspended'
      doc: 'Not Suspended'
    3:
      id: 'locked'
      doc: 'Suspended For Trading And Posttrade Operations'
  suspended:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  locked:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  trade_side:
    0:
      id: 'not_available'
      doc: 'Not Available'
    1:
      id: 'not_defined'
      doc: 'Not Defined'
    2:
      id: 'buy_order'
      doc: 'Buy Order'
    3:
      id: 'sell_order'
      doc: 'Sell Order'
  trade_state:
    1:
      id: 'given_up_trade'
      doc: 'The Trade Has Been Deleted'
    2:
      id: 'rectified'
      doc: 'The Trade Has Been Rectified'
    3:
      id: 'deleted'
      doc: 'Normal'

