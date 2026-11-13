# ---------------------------------------------------------------------
# Kaitai struct definition for: Hkex HkexDerivatives LiteRefresh Omd v2.0
#
# Protocol:
#   Organization: Hong Kong Exchanges and Clearing
#   Protocol: Orion Market Data Derivatives Lite Refresh
#   Encoding: Orion Market Data
#   Version: 2.0
#   Date: 9/16/2025
#   Specification: HKEX_OMD_Derivatives_Binary_Interface_Specifications_v2.0.pdf
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
  id: hkex_hkexderivatives_literefresh_omd_v2_0
  title: Hkex HkexDerivatives LiteRefresh Omd v2.0
  license: MIT-0
  endian: le

doc: 'Hong Kong Exchanges and Clearing Hkex Derivatives Market Orion Market Data Derivatives Lite Refresh Omd v2.0'
doc-ref: https://www.hkex.com.hk/Mutual-Market/Stock-Connect/Reference-Materials/Technical-Documents

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Omd packet header (byte 3 is Compression Mode indicator)'
  - id: message_buffer
    type: message_buffer_struct
    size-eos: true
    doc: 'The packet''s message area: the messages it counts, or one ZliB block holding them'

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
        enum: compression_mode
        doc: 'Indicates if compression is applied on messages in the packet'
      - id: seq_num
        type: u4
        doc: 'Sequence number of the first message in the packet'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time of segment. Nanoseconds since Unix epoch'
  message_buffer_struct:
    seq:
      - id: message
        type: message
        repeat: expr
        repeat-expr: _root.packet_header.msg_count
  message:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Omd message header'
      - id: payload
        size: msg_header.msg_size - 4
        type:
          switch-on: msg_header.msg_type
          cases:
            'msg_type::add_order': add_order
            'msg_type::aggregate_implied_order': aggregate_implied_order
            'msg_type::aggregate_order_book_update_message': aggregate_order_book_update_message
            'msg_type::calculated_opening_price_message': calculated_opening_price_message
            'msg_type::market_alert_message': market_alert_message
            'msg_type::open_interest_message': open_interest_message
            'msg_type::commodity_definition': commodity_definition
            'msg_type::class_definition': class_definition
            'msg_type::instrument_definition': instrument_definition
            'msg_type::combination_definition': combination_definition
            'msg_type::refresh_complete': refresh_complete
            'msg_type::market_status': market_status
            'msg_type::instrument_status': instrument_status
            'msg_type::commodity_and_class_status': commodity_and_class_status
            'msg_type::vcm_trigger': vcm_trigger
            'msg_type::vcm_end': vcm_end
            'msg_type::thm_trigger': thm_trigger
            'msg_type::trade_statistics_message': trade_statistics_message
  msg_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'Length of the message'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Code identifying this message type'
  add_order:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: order_id
        type: u8
        doc: 'Unique identifier per instrument and side for each order'
      - id: price
        type: s8_nullable
        doc: 'Price. Nullable, No Value = -9223372036854775808'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Additional order attributes'
      - id: order_book_position
        type: u4
        doc: 'Order rank information for the order position within the order book'
      - id: filler_1
        size: 1
        doc: 'Padding'
  aggregate_implied_order:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: implied_price
        type: s8_nullable
        doc: 'Implied Price. Decimal places determined from Class Definition field “DecimalInPrice”. Null means N/A. Nullable, No Value = -9223372036854775808'
      - id: implied_quantity
        type: u8
        doc: 'Aggregated Implied Volume at Implied Price'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: filler_1
        size: 1
        doc: 'Padding'
  aggregate_order_book_update_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: filler_3
        size: 3
        doc: 'Padding'
      - id: num_book_entry
        type: u1
        doc: 'Number of book entries within'
      - id: book_entry
        type: book_entry
        repeat: expr
        repeat-expr: num_book_entry
        doc: 'The aggregate order book is sent whenever there is a orderbook change'
  book_entry:
    seq:
      - id: aggregate_quantity
        type: u8
        doc: 'Aggregated number of shares'
      - id: price
        type: s8_nullable
        doc: 'Price. Nullable, No Value = -9223372036854775808'
      - id: number_of_orders
        type: u4
        doc: 'Number of orders'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: filler_1
        size: 1
        doc: 'Padding'
      - id: price_level
        type: u1
        doc: 'Indicates the price level (within'
      - id: update_action
        type: u1
        enum: update_action
        doc: 'Type of market data update action'
  calculated_opening_price_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: calculated_opening_price
        type: s8_nullable
        doc: 'Calculated Opening Price. Nullable, No Value = -9223372036854775808'
      - id: filler_4
        size: 4
        doc: 'Padding'
      - id: calculated_opening_quantity
        type: u8
        doc: 'Shows the quantity available at Calculated Opening Price'
  market_alert_message:
    seq:
      - id: alert_id
        type: u8
        doc: 'The reference ID for this alert, unique for any given day'
      - id: source
        type: u1
        enum: source
        doc: 'Source ID for this alert message'
      - id: header
        size: 320
        doc: 'Header'
      - id: last_fragment
        type: u1
        enum: last_fragment
        doc: 'Indicates whether this message is the last in a sequence of message'
      - id: priority
        type: u1
        enum: priority
        doc: 'Priority'
      - id: num_content
        type: u1
        doc: 'Maximum 3 lines'
      - id: content
        size: 320
        repeat: expr
        repeat-expr: num_content
        doc: 'Market Alert Content'
  open_interest_message:
    seq:
      - id: day_indicator
        type: u2
        enum: day_indicator
        doc: 'Session indicator used to'
      - id: filler_6
        size: 6
        doc: 'Padding'
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: settlement_price
        type: s4_nullable
        doc: '‘DecimalInPrice’. Nullable, No Value = -2147483648'
      - id: gross_oi
        type: s4_nullable
        doc: 'If DayIndicator = 1,. Nullable, No Value = -2147483648'
      - id: net_oi
        type: s4_nullable
        doc: 'If DayIndicator =1,. Nullable, No Value = -2147483648'
  commodity_definition:
    seq:
      - id: commodity_code
        type: u4
        doc: 'Numerical identifier of the Underlying'
      - id: commodity_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Descriptive Name of the underlying'
      - id: commodity_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Commodity ID of the underlying'
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
      - id: decimal_in_underlying_price
        type: u2
        doc: 'Number of implicit decimals in the underlying price'
      - id: base_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the trading currency'
      - id: effective_tomorrow
        type: u1
        enum: effective_tomorrow
        doc: 'Declaration for instrument to be traded the next day'
      - id: filler_5
        size: 5
        doc: 'Padding'
  class_definition:
    seq:
      - id: instrument_class_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ASCII representation of the instrument class'
      - id: instrument_class_key
        type: u4
        doc: 'A short-cut key of the Instrument Class'
      - id: key_type
        type: u1
        enum: key_type
        doc: 'A indicator of the type of the Class'
      - id: instrument_class_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'The full ASCII representation'
      - id: exchange
        type: u2
        doc: 'Exchange Identifier'
      - id: market
        type: u2
        enum: market
        doc: 'Market Code'
      - id: instrument_group
        type: u2
        enum: instrument_group
        doc: 'Instrument Group'
      - id: commodity_code
        type: u4
        doc: 'Numerical identifier of the Underlying'
      - id: instrument_type_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'This identifies the instrument type ID'
      - id: instrument_type_key
        type: u4
        doc: 'A short-cut key of the Instrument Type'
      - id: filler_3
        size: 3
        doc: 'Padding'
      - id: price_quotation_factor
        type: u4
        doc: 'Implies the contracted value of the product'
      - id: contract_size
        type: u4
        doc: 'Number of Underlying entities per contract'
      - id: decimal_in_contract_size
        type: u2
        doc: 'Implicit decimals in Contract Size and Price Quotation Factor'
      - id: decimal_in_strike_price
        type: u2
        doc: 'Number of implicit decimals in the Strike Price'
      - id: decimal_in_price
        type: u2
        doc: 'Number of implicit decimals in Price fields and Tick Size'
      - id: tick_size
        type: s8
        doc: 'Minimum Fluctuation of the product'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Defines if the instrument is a tradable instrument'
      - id: base_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the trading currency'
      - id: settlement_currency_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Full descriptive name of the Settlement Currency'
      - id: effective_tomorrow
        type: u1
        enum: effective_tomorrow
        doc: 'Declaration for instrument to be traded the next day'
      - id: filler_2
        size: 2
        doc: 'Padding'
  instrument_definition:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: instrument_class_key
        type: u4
        doc: 'A short-cut key of the Instrument Class'
      - id: market
        type: u2
        enum: market
        doc: 'Market Code'
      - id: instrument_group
        type: u2
        enum: instrument_group
        doc: 'Instrument Group'
      - id: modifier
        type: u2
        doc: 'Value is incremented by one each time the instrument is involved in an issue'
      - id: commodity_code
        type: u4
        doc: 'Numerical identifier of the Underlying'
      - id: last_trading_date
        type: u4
        doc: 'Last trading date of the instrument'
      - id: last_trading_time
        type: nanosecond_timestamp
        doc: 'The last trading time of the instrument. Nanoseconds since Unix epoch'
      - id: strike_price
        type: s8
        doc: 'Price at which a specific options instrument can be exercised'
      - id: effective_last_trading_date
        type: u4
        doc: 'Sets the effective last trading date'
      - id: first_trading_date
        type: u4
        doc: 'The first trading date'
      - id: first_trading_time
        type: nanosecond_timestamp
        doc: 'The first trading time (UTC timestamp). Nanoseconds since Unix epoch'
      - id: filler_3
        size: 3
        doc: 'Padding'
      - id: instrument_status_code
        type: u1
        enum: instrument_status_code
        doc: 'The actual status of the instrument'
      - id: instrument_contract_size
        type: s4
        doc: 'Number of Underlying entities per contract'
      - id: instrument_price_quotation_factor
        type: s4
        doc: 'Implies the contracted value of the product'
      - id: number_of_legs
        type: u1
        doc: 'Number of legs in the instrument'
      - id: vcm_flag
        type: u1
        enum: vcm_flag
        doc: 'Indicate whether Volatility Control Mechanism (VCM) is applicable'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'International Securities Identification Number'
      - id: effective_tomorrow
        type: u1
        enum: effective_tomorrow
        doc: 'Declaration for instrument to be traded the next day'
      - id: second_filler_3
        size: 3
        doc: 'Padding'
  combination_definition:
    seq:
      - id: combo_orderbook_id
        type: u4
        doc: 'Uniquely identifies a combination instrument'
      - id: leg_orderbook_id
        type: u4
        doc: 'Uniquely identifies a leg instrument'
      - id: filler_3
        size: 3
        doc: 'Padding'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Identifies the leg side within the combination'
      - id: leg_ratio
        type: s4
        doc: 'Relative numbers of bid and ask contracts between legs'
  refresh_complete:
    seq:
      - id: last_seq_num
        type: u4
        doc: 'Sequence number with which'
  market_status:
    seq:
      - id: state_level
        type: u1
        enum: state_level
        doc: 'Indicates the level which a state applies to'
      - id: status_market
        type: u4
        enum: status_market
        doc: 'Market Code'
      - id: instrument_type_key
        type: u4
        doc: 'A short-cut key of the Instrument Type'
      - id: instrument_class_key
        type: u4
        doc: 'A short-cut key of the Instrument Class'
      - id: filler_4
        size: 4
        doc: 'Padding'
      - id: actual_start_time
        type: nanosecond_timestamp
        doc: 'Actual start time. Nanoseconds since Unix epoch'
      - id: planned_start_time
        type: nanosecond_timestamp
        doc: 'Next planned time. Nanoseconds since Unix epoch'
      - id: state
        type: u2
        doc: 'Numeric identification of the State Type'
      - id: filler_1
        size: 1
        doc: 'Padding'
  instrument_status:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: suspension_indicator
        type: u1
        enum: suspension_indicator
        doc: 'Indicates if the instrument is suspended or not'
      - id: instrument_status_code
        type: u1
        enum: instrument_status_code
        doc: 'The actual status of the instrument'
      - id: filler_2
        size: 2
        doc: 'Padding'
  commodity_and_class_status:
    seq:
      - id: commodity_code
        type: u4
        doc: 'Numerical identifier of the Underlying'
      - id: instrument_class_key
        type: u4
        doc: 'A short-cut key of the Instrument Class'
      - id: suspended
        type: u1
        enum: suspended
        doc: 'Defines if the commodity or instrument class is suspended or not'
      - id: filler_1
        size: 1
        doc: 'Padding'
  vcm_trigger:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: cooling_off_start_time
        type: nanosecond_timestamp
        doc: 'Time when the cooling off period starts (UTC timestamp). Nanoseconds since Unix epoch'
      - id: cooling_off_end_time
        type: nanosecond_timestamp
        doc: 'Time when the cooling off period ends (UTC timestamp). Nanoseconds since Unix epoch'
      - id: vcm_reference_price
        type: s8
        doc: 'Reference Price'
      - id: vcm_lower_price
        type: s8
        doc: 'Lower price in the price band allowed during the cooling off period'
      - id: vcm_upper_price
        type: s8
        doc: 'Upper price in the price band allowed during the cooling off period'
      - id: filler_2
        size: 2
        doc: 'Padding'
  vcm_end:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: cooling_off_start_time
        type: nanosecond_timestamp
        doc: 'Time when the cooling off period starts (UTC timestamp). Nanoseconds since Unix epoch'
      - id: cooling_off_end_time
        type: nanosecond_timestamp
        doc: 'Time when the cooling off period ends (UTC timestamp). Nanoseconds since Unix epoch'
  thm_trigger:
    seq:
      - id: instrument_class_key
        type: u4
        doc: 'A short-cut key of the Instrument Class'
      - id: filler_10
        size: 10
        doc: 'Padding'
  trade_statistics_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: last_price
        type: s8_nullable
        doc: 'Last Traded Price. Nullable, No Value = -9223372036854775808'
      - id: session
        type: u1
        enum: session
        doc: 'Session indicator used to distinguish between the T and T+1 sessions'
      - id: open_price
        type: s8_nullable
        doc: 'Price of the first committed. Nullable, No Value = -9223372036854775808'
      - id: high_price
        type: s8_nullable
        doc: 'Highest price of normal trades in. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: s8_nullable
        doc: 'Lowest price of normal trades in. Nullable, No Value = -9223372036854775808'
      - id: trade_report_volume
        type: u8
        doc: 'Total volume of reported trades for the respective Session'
      - id: turnover
        type: u8
        doc: 'Cumulative volume for the respective Session'
      - id: filler_3
        size: 3
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
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648

enums:
  compression_mode:
    0:
      id: 'no_compression_applied'
      doc: 'No compression applied on messages in the packet'
    1:
      id: 'compression_applied'
      doc: 'Compression applied on messages in the packet'
  msg_type:
    330:
      id: 'add_order'
      doc: 'Generated when a new order is inserted into the order book.'
    337:
      id: 'aggregate_implied_order'
      doc: 'Generated whenever there is an update on implied order at the given implied price.'
    353:
      id: 'aggregate_order_book_update_message'
      doc: 'The aggregate order book is sent whenever there is a orderbook change'
    364:
      id: 'calculated_opening_price_message'
      doc: 'The Calculated Opening Price (COP) message indicates an instrument''s theoretical opening price during the pre-opening phases of the market prior to an auction'
    323:
      id: 'market_alert_message'
      doc: 'The Market Alert message is generated periodically to relay market announcements and alerts'
    366:
      id: 'open_interest_message'
      doc: 'Issued to show the Previous Day settlement price and open interest'
    301:
      id: 'commodity_definition'
      doc: 'Describes individual commodities available from the OMD-D system'
    302:
      id: 'class_definition'
      doc: 'Describes individual instrument classes available from the OMD-D system.'
    304:
      id: 'instrument_definition'
      doc: 'Describes instrument static data.'
    305:
      id: 'combination_definition'
      doc: 'Describes the composition of a combination instrument.'
    203:
      id: 'refresh_complete'
      doc: 'RefreshComplete'
    320:
      id: 'market_status'
      doc: 'Indicates the state of the Exchange, Market, Instrument Type, or Class.'
    321:
      id: 'instrument_status'
      doc: 'Generated whenever there is a change to suspension indicator or instrument status.'
    322:
      id: 'commodity_and_class_status'
      doc: 'Generated whenever a commodity and / or instrument class status changes.'
    324:
      id: 'vcm_trigger'
      doc: 'Generated when VCM is triggered on a particular instrument.'
    325:
      id: 'vcm_end'
      doc: 'Generated when VCM is ended on a particular instrument.'
    326:
      id: 'thm_trigger'
      doc: 'Generated when trading halt is triggered on a particular instrument class.'
    360:
      id: 'trade_statistics_message'
      doc: 'Trade information for completed deals'
  side:
    0:
      id: 'bid'
      doc: 'Bid'
    1:
      id: 'offer'
      doc: 'Offer'
  lot_type:
    2:
      id: 'round_lot'
      doc: 'Round Lot'
  order_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'market_to_limit'
      doc: 'Market To Limit'
  update_action:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'change'
      doc: 'Change'
    2:
      id: 'delete_field'
      doc: 'Delete'
    74:
      id: 'clear'
      doc: 'Clear'
  source:
    0x48:
      id: 'trading_system'
      doc: 'Market Alerts sent through the Trading System'
  last_fragment:
    0x59:
      id: 'complete'
      doc: 'Complete'
    0x4e:
      id: 'not_complete'
      doc: 'Not Complete'
  priority:
    0:
      id: 'critical'
      doc: 'Critical'
    1:
      id: 'important'
      doc: 'Important'
    2:
      id: 'normal'
      doc: 'Normal'
  day_indicator:
    0:
      id: 'current_trading_day'
      doc: 'Current Trading Day'
    1:
      id: 'previous_trading_day'
      doc: 'Previous Trading Day'
  underlying_type:
    0x53:
      id: 'stock'
      doc: 'Stock'
    0x43:
      id: 'currency'
      doc: 'Currency'
    0x49:
      id: 'fixed_income'
      doc: 'Fixed Income'
    0x45:
      id: 'energy_power'
      doc: 'Energy Power'
    0x41:
      id: 'commodity'
      doc: 'Commodity'
    0x4d:
      id: 'metal'
      doc: 'Metal'
  effective_tomorrow:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  key_type:
    0x30:
      id: 'instrument_class'
      doc: 'Instrument Class'
    0x31:
      id: 'combo_class'
      doc: 'Combo Class'
  market:
    1:
      id: 'cesc_index_futures_options'
      doc: 'CESC Index Futures / Options (Non-SOM)'
    2:
      id: 'stock_futures'
      doc: 'Stock Futures (Non-SOM)'
    3:
      id: 'three_year_exchange_fund_note_futures'
      doc: 'Three-Year Exchange Fund Note Futures (Non-SOM)'
    16:
      id: 'mini_hang_seng_index_futures_options'
      doc: 'Mini Hang Seng Index Futures / Options (Non-SOM)'
    20:
      id: 'stock_options'
      doc: 'Stock Options (SOM)'
    24:
      id: 'hibor'
      doc: 'HIBOR (Non-SOM)'
    27:
      id: 'dividend_futures'
      doc: 'Dividend Futures (Non-SOM)'
    32:
      id: 'physically_settled_options_on_futures_contracts_on_hang_seng_index_futures'
      doc: 'Physically Settled Options on Futures Contracts on Hang Seng Index Futures (Non-SOM)'
    34:
      id: 'hang_seng_index_futures_options'
      doc: 'Hang Seng Index Futures / Options (Non-SOM)'
    35:
      id: 'flexible_hang_seng_index_options'
      doc: 'Flexible Hang Seng Index Options (Non-SOM)'
    37:
      id: 'flexible_hang_seng_china_enterprises_index_options'
      doc: 'Flexible Hang Seng China Enterprises Index Options (Non-SOM)'
    38:
      id: 'hang_seng_china_enterprises_index_futures_options'
      doc: 'Hang Seng China Enterprises Index Futures / Options (Non-SOM)'
    39:
      id: 'weekly_hang_seng_index_options'
      doc: 'Weekly Hang Seng Index Options (Non-SOM)'
    40:
      id: 'physically_settled_options_on_futures_contracts_on_hang_seng_china_enterprises_index_futures'
      doc: 'Physically Settled Options on Futures Contracts on Hang Seng China Enterprises Index Futures (Non-SOM)'
    51:
      id: 'hsi_volatility_index_futures'
      doc: 'HSI Volatility Index Futures (Non-SOM)'
    60:
      id: 'sector_index_futures'
      doc: 'Sector Index Futures (Non-SOM)'
    70:
      id: 'renminbi_currency_futures_options'
      doc: 'Renminbi Currency Futures / Options (Non-SOM)'
    86:
      id: 'hang_seng_tech_index_futures_options_hang_seng_index_hang_seng_china_enterprises_index_gross_net_total_return_index_futures'
      doc: 'Hang Seng TECH Index Futures & Options & Hang Seng Index / Hang Seng China Enterprises Index (Gross / Net Total Return Index) Futures (Non-SOM)'
    87:
      id: 'weekly_hang_seng_china_enterprises_index_options'
      doc: 'Weekly Hang Seng China Enterprises Index Options (Non-SOM)'
    93:
      id: 'ibovespa_index_futures'
      doc: 'IBOVESPA Index Futures (Non-SOM)'
    96:
      id: 'sp_bse_sensex_index_futures'
      doc: 'S&P BSE Sensex Index Futures (Non-SOM)'
    99:
      id: 'ftsejse_top_40_index_futures'
      doc: 'FTSE/JSE Top 40 Index Futures (Non-SOM)'
    102:
      id: 'micex_index_futures'
      doc: 'MICEX Index Futures (Non-SOM)'
    108:
      id: 'msci_ax_j_futures_ntr'
      doc: 'MSCI AxJ Futures (NTR) (Non-SOM)'
    111:
      id: 'physically_settled_usd_silver_futures'
      doc: 'Physically settled USD Silver Futures (Non-SOM)'
    112:
      id: 'physically_settled_cnh_silver_futures'
      doc: 'Physically settled CNH Silver Futures (Non-SOM)'
    115:
      id: 'physically_settled_cnh_gold_futures'
      doc: 'Physically Settled CNH Gold Futures (Non-SOM)'
    116:
      id: 'physically_settled_usd_gold_futures'
      doc: 'Physically Settled USD Gold Futures (Non-SOM)'
    117:
      id: 'mof_t_bond_futures'
      doc: 'MOF T-Bond Futures (Non-SOM)'
    118:
      id: 'usd_base_and_ferrous_futures'
      doc: 'USD Base and Ferrous Futures (Non-SOM)'
    120:
      id: 'cnh_london_metal_mini_futures'
      doc: 'CNH London Metal Mini Futures (Non-SOM)'
    122:
      id: 'cash_settled_rmb_currency_futures'
      doc: 'Cash-Settled RMB Currency Futures (Non-SOM)'
    125:
      id: 'cash_settled_cnhusd_futures'
      doc: 'Cash-Settled CNHUSD Futures (Non-SOM)'
    153:
      id: 'msci_china_a_50_connect_index_futures'
      doc: 'MSCI China A 50 Connect Index Futures (Non-SOM)'
    160:
      id: 'msci_jpy_index_futures_price_ntr'
      doc: 'MSCI JPY Index Futures (Price & NTR) (Non-SOM)'
    161:
      id: 'msci_usd_index_futures_ntr'
      doc: 'MSCI USD Index Futures (NTR) (Non-SOM)'
    163:
      id: 'msci_usd_index_futures_options_price_market_163'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    164:
      id: 'msci_usd_index_futures_options_price_market_164'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    166:
      id: 'msci_usd_index_futures_options_price_market_166'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    168:
      id: 'msci_usd_index_futures_options_price_market_168'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    170:
      id: 'msci_sgd_index_futures_price'
      doc: 'MSCI SGD Index Futures (Price) (Non-SOM)'
  instrument_group:
    4:
      id: 'futures'
      doc: 'Futures'
    6:
      id: 'call_american_style'
      doc: 'Call (American style)'
    7:
      id: 'put_american_style'
      doc: 'Put (American style)'
    22:
      id: 'call_european_style'
      doc: 'Call (European style)'
    23:
      id: 'put_european_style'
      doc: 'Put (European style)'
    170:
      id: 'options_straddle'
      doc: 'Options Straddle'
    171:
      id: 'options_strangle'
      doc: 'Options Strangle'
    172:
      id: 'standard_combination_instrument_for_stock_options_market_som_synthetic_futures'
      doc: 'Standard Combination Instrument for Stock Options Market (SOM) – Synthetic Futures'
    201:
      id: 'time_spread_level_01'
      doc: 'Time Spread (level = 01)'
    202:
      id: 'time_spread_level_02'
      doc: 'Time Spread (level = 02)'
    203:
      id: 'time_spread_level_03'
      doc: 'Time Spread (level = 03)'
    204:
      id: 'time_spread_level_04'
      doc: 'Time Spread (level = 04)'
    205:
      id: 'time_spread_level_05'
      doc: 'Time Spread (level = 05)'
    206:
      id: 'time_spread_level_06'
      doc: 'Time Spread (level = 06)'
    207:
      id: 'time_spread_level_07'
      doc: 'Time Spread (level = 07)'
    208:
      id: 'time_spread_level_08'
      doc: 'Time Spread (level = 08)'
    209:
      id: 'time_spread_level_09'
      doc: 'Time Spread (level = 09)'
    210:
      id: 'time_spread_level_10'
      doc: 'Time Spread (level = 10)'
    211:
      id: 'time_spread_level_11'
      doc: 'Time Spread (level = 11)'
    212:
      id: 'time_spread_level_12'
      doc: 'Time Spread (level = 12)'
    213:
      id: 'time_spread_level_13'
      doc: 'Time Spread (level = 13)'
    214:
      id: 'time_spread_level_14'
      doc: 'Time Spread (level = 14)'
    215:
      id: 'time_spread_level_15'
      doc: 'Time Spread (level = 15)'
    216:
      id: 'time_spread_level_16'
      doc: 'Time Spread (level = 16)'
    217:
      id: 'time_spread_level_17'
      doc: 'Time Spread (level = 17)'
    218:
      id: 'time_spread_level_18'
      doc: 'Time Spread (level = 18)'
    219:
      id: 'time_spread_level_19'
      doc: 'Time Spread (level = 19)'
    220:
      id: 'time_spread_level_20'
      doc: 'Time Spread (level = 20)'
    221:
      id: 'time_spread_level_21'
      doc: 'Time Spread (level = 21)'
    222:
      id: 'time_spread_level_22'
      doc: 'Time Spread (level = 22)'
    223:
      id: 'time_spread_level_23'
      doc: 'Time Spread (level = 23)'
    250:
      id: 'tailor_made_combination'
      doc: 'Tailor-made combination'
    254:
      id: 'exchange_rate'
      doc: 'Exchange Rate'
    255:
      id: 'payment_currency'
      doc: 'Payment Currency'
  tradable:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  instrument_status_code:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'suspended'
      doc: 'Suspended'
    4:
      id: 'delisted'
      doc: 'Delisted'
  vcm_flag:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'applicable'
      doc: 'Applicable'
  leg_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  state_level:
    0x45:
      id: 'exchange'
      doc: 'Exchange'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x54:
      id: 'instrument_type'
      doc: 'Instrument Type'
    0x74:
      id: 'combo_type'
      doc: 'Combo Type'
    0x43:
      id: 'instrument_class'
      doc: 'Instrument Class'
    0x63:
      id: 'combo_class'
      doc: 'Combo Class'
  status_market:
    0:
      id: 'if_not_available'
      doc: 'If Not Available'
    1:
      id: 'cesc_index_futures_options'
      doc: 'CESC Index Futures / Options (Non-SOM)'
    2:
      id: 'stock_futures'
      doc: 'Stock Futures (Non-SOM)'
    3:
      id: 'three_year_exchange_fund_note_futures'
      doc: 'Three-Year Exchange Fund Note Futures (Non-SOM)'
    16:
      id: 'mini_hang_seng_index_futures_options'
      doc: 'Mini Hang Seng Index Futures / Options (Non-SOM)'
    20:
      id: 'stock_options'
      doc: 'Stock Options (SOM)'
    24:
      id: 'hibor'
      doc: 'HIBOR (Non-SOM)'
    27:
      id: 'dividend_futures'
      doc: 'Dividend Futures (Non-SOM)'
    32:
      id: 'physically_settled_options_on_futures_contracts_on_hang_seng_index_futures'
      doc: 'Physically Settled Options on Futures Contracts on Hang Seng Index Futures (Non-SOM)'
    34:
      id: 'hang_seng_index_futures_options'
      doc: 'Hang Seng Index Futures / Options (Non-SOM)'
    35:
      id: 'flexible_hang_seng_index_options'
      doc: 'Flexible Hang Seng Index Options (Non-SOM)'
    37:
      id: 'flexible_hang_seng_china_enterprises_index_options'
      doc: 'Flexible Hang Seng China Enterprises Index Options (Non-SOM)'
    38:
      id: 'hang_seng_china_enterprises_index_futures_options'
      doc: 'Hang Seng China Enterprises Index Futures / Options (Non-SOM)'
    39:
      id: 'weekly_hang_seng_index_options'
      doc: 'Weekly Hang Seng Index Options (Non-SOM)'
    40:
      id: 'physically_settled_options_on_futures_contracts_on_hang_seng_china_enterprises_index_futures'
      doc: 'Physically Settled Options on Futures Contracts on Hang Seng China Enterprises Index Futures (Non-SOM)'
    51:
      id: 'hsi_volatility_index_futures'
      doc: 'HSI Volatility Index Futures (Non-SOM)'
    60:
      id: 'sector_index_futures'
      doc: 'Sector Index Futures (Non-SOM)'
    70:
      id: 'renminbi_currency_futures_options'
      doc: 'Renminbi Currency Futures / Options (Non-SOM)'
    86:
      id: 'hang_seng_tech_index_futures_options_hang_seng_index_hang_seng_china_enterprises_index_gross_net_total_return_index_futures'
      doc: 'Hang Seng TECH Index Futures & Options & Hang Seng Index / Hang Seng China Enterprises Index (Gross / Net Total Return Index) Futures (Non-SOM)'
    87:
      id: 'weekly_hang_seng_china_enterprises_index_options'
      doc: 'Weekly Hang Seng China Enterprises Index Options (Non-SOM)'
    93:
      id: 'ibovespa_index_futures'
      doc: 'IBOVESPA Index Futures (Non-SOM)'
    96:
      id: 'sp_bse_sensex_index_futures'
      doc: 'S&P BSE Sensex Index Futures (Non-SOM)'
    99:
      id: 'ftsejse_top_40_index_futures'
      doc: 'FTSE/JSE Top 40 Index Futures (Non-SOM)'
    102:
      id: 'micex_index_futures'
      doc: 'MICEX Index Futures (Non-SOM)'
    108:
      id: 'msci_ax_j_futures_ntr'
      doc: 'MSCI AxJ Futures (NTR) (Non-SOM)'
    111:
      id: 'physically_settled_usd_silver_futures'
      doc: 'Physically settled USD Silver Futures (Non-SOM)'
    112:
      id: 'physically_settled_cnh_silver_futures'
      doc: 'Physically settled CNH Silver Futures (Non-SOM)'
    115:
      id: 'physically_settled_cnh_gold_futures'
      doc: 'Physically Settled CNH Gold Futures (Non-SOM)'
    116:
      id: 'physically_settled_usd_gold_futures'
      doc: 'Physically Settled USD Gold Futures (Non-SOM)'
    117:
      id: 'mof_t_bond_futures'
      doc: 'MOF T-Bond Futures (Non-SOM)'
    118:
      id: 'usd_base_and_ferrous_futures'
      doc: 'USD Base and Ferrous Futures (Non-SOM)'
    120:
      id: 'cnh_london_metal_mini_futures'
      doc: 'CNH London Metal Mini Futures (Non-SOM)'
    122:
      id: 'cash_settled_rmb_currency_futures'
      doc: 'Cash-Settled RMB Currency Futures (Non-SOM)'
    125:
      id: 'cash_settled_cnhusd_futures'
      doc: 'Cash-Settled CNHUSD Futures (Non-SOM)'
    153:
      id: 'msci_china_a_50_connect_index_futures'
      doc: 'MSCI China A 50 Connect Index Futures (Non-SOM)'
    160:
      id: 'msci_jpy_index_futures_price_ntr'
      doc: 'MSCI JPY Index Futures (Price & NTR) (Non-SOM)'
    161:
      id: 'msci_usd_index_futures_ntr'
      doc: 'MSCI USD Index Futures (NTR) (Non-SOM)'
    163:
      id: 'msci_usd_index_futures_options_price_market_163'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    164:
      id: 'msci_usd_index_futures_options_price_market_164'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    166:
      id: 'msci_usd_index_futures_options_price_market_166'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    168:
      id: 'msci_usd_index_futures_options_price_market_168'
      doc: 'MSCI USD Index Futures & Options (Price) (Non-SOM)'
    170:
      id: 'msci_sgd_index_futures_price'
      doc: 'MSCI SGD Index Futures (Price) (Non-SOM)'
  suspension_indicator:
    1:
      id: 'suspended_for_trading'
      doc: 'Suspended For Trading'
    2:
      id: 'not_suspended'
      doc: 'Not Suspended'
  suspended:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  session:
    0:
      id: 't_session'
      doc: 'T Session'
    1:
      id: 't_plus_one_session'
      doc: 'T Plus One Session'

