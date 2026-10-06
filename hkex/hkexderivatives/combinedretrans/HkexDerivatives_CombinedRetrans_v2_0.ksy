# ---------------------------------------------------------------------
# Kaitai struct definition for: Hkex HkexDerivatives CombinedRetrans Omd v2.0
#
# Protocol:
#   Organization: Hong Kong Exchanges and Clearing
#   Protocol: Orion Market Data Derivatives Combined Retransmission
#   Encoding: Orion Market Data
#   Version: 2.0
#   Date: 9/16/2025
#   Specification: HKEX_OMD_Derivatives_Binary_Interface_Specifications_v2.0.pdf
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
  id: hkex_hkexderivatives_combinedretrans_omd_v2_0
  title: Hkex HkexDerivatives CombinedRetrans Omd v2.0
  license: GPL-3.0
  endian: le

doc: 'Hong Kong Exchanges and Clearing Hkex Derivatives Market Orion Market Data Derivatives Combined Retransmission Omd v2.0'
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
            'msg_type::add_order': add_order
            'msg_type::aggregate_implied_order': aggregate_implied_order
            'msg_type::aggregate_order_book_update_message': aggregate_order_book_update_message
            'msg_type::calculated_opening_price_message': calculated_opening_price_message
            'msg_type::sequence_reset': sequence_reset
            'msg_type::disaster_recovery_signal_message': disaster_recovery_signal_message
            'msg_type::delete_order': delete_order
            'msg_type::implied_volatility_message': implied_volatility_message
            'msg_type::market_alert_message': market_alert_message
            'msg_type::modify_order': modify_order
            'msg_type::open_interest_message': open_interest_message
            'msg_type::orderbook_clear_message': orderbook_clear_message
            'msg_type::quote_request': quote_request
            'msg_type::commodity_definition': commodity_definition
            'msg_type::class_definition': class_definition
            'msg_type::instrument_definition': instrument_definition
            'msg_type::combination_definition': combination_definition
            'msg_type::refresh_complete': refresh_complete
            'msg_type::logon': logon
            'msg_type::logon_response': logon_response
            'msg_type::retransmission_request': retransmission_request
            'msg_type::retransmission_response': retransmission_response
            'msg_type::market_status': market_status
            'msg_type::instrument_status': instrument_status
            'msg_type::commodity_and_class_status': commodity_and_class_status
            'msg_type::vcm_trigger': vcm_trigger
            'msg_type::vcm_end': vcm_end
            'msg_type::thm_trigger': thm_trigger
            'msg_type::trade': trade
            'msg_type::trade_amendment_message': trade_amendment_message
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
        type: s8
        doc: 'Price'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  aggregate_implied_order:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: implied_price
        type: s8
        doc: 'Implied Price. Decimal places determined from Class Definition field “DecimalInPrice”. Null means N/A'
      - id: implied_quantity
        type: u8
        doc: 'Aggregated Implied Volume at Implied Price'
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
  aggregate_order_book_update_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
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
        type: s8
        doc: 'Price'
      - id: number_of_orders
        type: u4
        doc: 'Number of orders'
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
        type: s8
        doc: 'Calculated Opening Price'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: calculated_opening_quantity
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
  delete_order:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: order_id
        type: u8
        doc: 'Unique identifier per instrument and side for each order'
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
  implied_volatility_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: implied_volatility
        type: u4
        doc: 'Implied Volatility'
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
        doc: 'Market Alert Content'
  modify_order:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: order_id
        type: u8
        doc: 'Unique identifier per instrument and side for each order'
      - id: price
        type: s8
        doc: 'Price'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Additional order attributes'
      - id: order_book_position
        type: u4
        doc: 'Order rank information for the order position within the order book'
  open_interest_message:
    seq:
      - id: day_indicator
        type: u2
        enum: day_indicator
        doc: 'Session indicator used to'
      - id: filler_6
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: settlement_price
        type: s4
        doc: '‘DecimalInPremium’'
      - id: gross_oi
        type: s4
        doc: 'If DayIndicator = 1,'
      - id: net_oi
        type: s4
        doc: 'If DayIndicator =1,'
  orderbook_clear_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
  quote_request:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: quote_quantity
        type: s4
        doc: 'Quantity'
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
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
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
        doc: 'Market Code'
      - id: instrument_group
        type: u2
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
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
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
        doc: 'Market Code'
      - id: instrument_group
        type: u2
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
        type: u8
        doc: 'The last trading time of the instrument'
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
        type: u8
        doc: 'The first trading time (UTC timestamp)'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
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
  market_status:
    seq:
      - id: state_level
        type: u1
        enum: state_level
        doc: 'Indicates the level which a state applies to'
      - id: status_market
        type: u4
        doc: 'Market Code'
      - id: instrument_type_key
        type: u4
        doc: 'A short-cut key of the Instrument Type'
      - id: instrument_class_key
        type: u4
        doc: 'A short-cut key of the Instrument Class'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: actual_start_time
        type: u8
        doc: 'Actual start time'
      - id: planned_start_time
        type: u8
        doc: 'Next planned time'
      - id: state
        type: u2
        doc: 'Numeric identification of the State Type'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  vcm_trigger:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: cooling_off_start_time
        type: u8
        doc: 'Time when the cooling off period starts (UTC timestamp)'
      - id: cooling_off_end_time
        type: u8
        doc: 'Time when the cooling off period ends (UTC timestamp)'
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
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  vcm_end:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: cooling_off_start_time
        type: u8
        doc: 'Time when the cooling off period starts (UTC timestamp)'
      - id: cooling_off_end_time
        type: u8
        doc: 'Time when the cooling off period ends (UTC timestamp)'
  thm_trigger:
    seq:
      - id: instrument_class_key
        type: u4
        doc: 'A short-cut key of the Instrument Class'
      - id: filler_10
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  trade:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: order_id
        type: u8
        doc: 'Unique identifier per instrument and side for each order'
      - id: price
        type: s8
        doc: 'Price'
      - id: trade_id
        type: u8
        doc: 'Unique trade identification'
      - id: match_id
        type: u8
        doc: 'An identifier that links all trade which are executed as part of a single execution operation involving an aggressing order'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: trade_sub_type
        type: u1
        enum: trade_sub_type
        doc: 'Trade Sub Type'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'The condition in which a trade was executed'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: trade_time
        type: u8
        doc: 'Date and time of the last'
  trade_amendment_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: trade_id
        type: u8
        doc: 'Unique trade identification'
      - id: price
        type: s8
        doc: 'Price'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: amendment_execution_time
        type: u8
        doc: 'Date and time of the trade amendment execution'
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
  trade_statistics_message:
    seq:
      - id: orderbook_id
        type: u4
        doc: 'Uniquely identifies an instrument available for trading'
      - id: last_price
        type: s8
        doc: 'Last Traded Price'
      - id: session
        type: u1
        enum: session
        doc: 'Session indicator used to distinguish between the T and T+1 sessions'
      - id: open_price
        type: s8
        doc: 'Price of the first committed'
      - id: high_price
        type: s8
        doc: 'Highest price of normal trades in'
      - id: low_price
        type: s8
        doc: 'Lowest price of normal trades in'
      - id: trade_report_volume
        type: u8
        doc: 'Total volume of reported trades for the respective Session'
      - id: turnover
        type: u8
        doc: 'Cumulative volume for the respective Session'
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
    100:
      id: 'sequence_reset'
      doc: 'The Sequence Reset message is sent on each multicast channel at start of day'
    105:
      id: 'disaster_recovery_signal_message'
      doc: 'The Disaster Recovery Signal message is sent on a dedicated multicast channel whenever a site failover scenario is triggered'
    332:
      id: 'delete_order'
      doc: 'Generated when an existing order is deleted.'
    367:
      id: 'implied_volatility_message'
      doc: 'Contains implied volitility'
    323:
      id: 'market_alert_message'
      doc: 'The Market Alert message is generated periodically to relay market announcements and alerts'
    331:
      id: 'modify_order'
      doc: 'Generated when an existing order identified by the OrderID is modified.'
    366:
      id: 'open_interest_message'
      doc: 'Issued to show the Previous Day settlement price and open interest'
    335:
      id: 'orderbook_clear_message'
      doc: 'The Orderbook Clear message is used to inform clients that all existing orders should be removed from both the bid and ask sides of the specified orderbook'
    336:
      id: 'quote_request'
      doc: 'The Quote Request message is generated whenever market participants request a new quotation'
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
    350:
      id: 'trade'
      doc: 'The trade message is generated each time a trade has been performed'
    356:
      id: 'trade_amendment_message'
      doc: 'Represents a trade amendment or cancellation'
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
  dr_status:
    1:
      id: 'dr_in_progress'
      doc: 'Dr In Progress'
    2:
      id: 'dr_completed'
      doc: 'Dr Completed'
  source:
    0x48:
      id: 'trading_system'
      doc: 'Market Alerts Sent Through The Trading System'
  last_fragment:
    0x59:
      id: 'complete'
      doc: 'Complete'
    0x4d:
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
  trade_sub_type:
    0:
      id: 'continuous_match'
      doc: 'Continuous Match'
    1:
      id: 'opening_uncross'
      doc: 'Opening Uncross'
    2:
      id: 'block_trade'
      doc: 'Block Trade'
  trade_condition:
    0:
      id: 'na'
      doc: 'Na'
    1:
      id: 'explicit_order_vs_explicit_order'
      doc: 'Explicit Order Vs Explicit Order'
    2:
      id: 'explicit_order_vs_implied_order'
      doc: 'Explicit Order Vs Implied Order'
    3:
      id: 'implied_order_vs_explicit_order'
      doc: 'Implied Order Vs Explicit Order'
    4:
      id: 'implied_order_vs_implied_order'
      doc: 'Implied Order Vs Implied Order'
    5:
      id: 'exchange_reported_on_behalf_trade'
      doc: 'Exchange Reported On Behalf Trade'
  trade_state:
    1:
      id: 'cancelled'
      doc: 'Cancelled'
    2:
      id: 'amended'
      doc: 'Amended'
  session:
    0:
      id: 't_session'
      doc: 'T Session'
    1:
      id: 't_plus_one_session'
      doc: 'T Plus One Session'

