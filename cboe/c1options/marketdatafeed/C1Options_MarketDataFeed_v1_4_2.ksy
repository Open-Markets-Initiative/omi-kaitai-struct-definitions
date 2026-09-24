# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options MarketDataFeed Csm v1.4.2
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Market Data Feed
#   Encoding: Csm
#   Version: 1.4.2
#   Date: 5/8/2018
#   Specification: cboestreamingbookdepthv1.0.pdf
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
  id: cboe_c1options_marketdatafeed_csm_v1_4_2
  title: Cboe C1Options MarketDataFeed Csm v1.4.2
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe C1 Options Market Data Feed Csm v1.4.2'
doc-ref: https://systems.cboe.com/Auth/CFN.aspx

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count

types:
  packet_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'The version associated with the contents and format of this header. Currently, this will be a constant value of 1'
      - id: packet_length
        type: u2
        doc: 'Length of the packet including this length field and the version'
      - id: sending_time
        type: u8
        doc: 'The time that this packet was sent. It applies to all messages in this packet'
      - id: message_count
        type: u1
        doc: 'The number of messages in this packet'
      - id: first_msg_seq_num
        type: u4
        doc: 'The sequence number on the first message in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::security_definition_message': security_definition_message
            'template_id::current_market_refresh_message': current_market_refresh_message
            'template_id::market_data_refresh_message': market_data_refresh_message
            'template_id::current_market_update_message': current_market_update_message
            'template_id::recap_update_message': recap_update_message
            'template_id::ticker_message': ticker_message
            'template_id::expected_opening_price_and_size_message': expected_opening_price_and_size_message
            'template_id::index_value_message': index_value_message
            'template_id::settlement_value_message': settlement_value_message
            'template_id::summary_message': summary_message
            'template_id::market_data_control_message': market_data_control_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message in bytes'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'The Template ID is for decoding the message'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Code identifying this message type'
      - id: msg_seq_num
        type: u4
        doc: 'Message Sequence Number'
  security_definition_message:
    seq:
      - id: security_type
        type: security_type
      - id: security_exchange
        type: u1
        enum: security_exchange
      - id: symbol
        type: symbol
      - id: target_location_id
        type: target_location_id
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: maturity_date
        type: u8
        doc: 'Expiration date: Format is “YYYYMMDD”. This field is required for options and futures'
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: strike_price
        type: strike_price
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'This field is required for options'
      - id: minimum_strike_price_fraction
        type: minimum_strike_price_fraction
      - id: max_strike_price
        type: max_strike_price
      - id: premium_break_point
        type: premium_break_point
      - id: minimum_above_premium_fraction
        type: minimum_above_premium_fraction
      - id: minimum_below_premium_fraction
        type: minimum_below_premium_fraction
      - id: exercise_style
        type: u1
        enum: exercise_style
      - id: currency_code
        type: currency_code
      - id: underlying_symbol
        type: underlying_symbol
      - id: underlying_type
        type: underlying_type
      - id: contract_size
        type: u4
        doc: 'The number of contracts per unit of size'
      - id: num_security_definition_leg
        type: u1
        doc: 'Num. of Legs in a strategy product. Only used for products that contain legs such as strategies. Will not exceed 255'
      - id: security_definition_leg
        type: security_definition_leg
        repeat: expr
        repeat-expr: num_security_definition_leg
        doc: 'Security Definition Leg'
  security_type:
    seq:
      - id: len_security_type_text
        type: u1
      - id: security_type_text
        type: str
        size: len_security_type_text
        encoding: ASCII
  symbol:
    seq:
      - id: len_symbol_text
        type: u1
        doc: 'Symbol of the class'
      - id: symbol_text
        type: str
        size: len_symbol_text
        encoding: ASCII
        doc: 'Symbol of the class'
  target_location_id:
    seq:
      - id: len_target_location_id_text
        type: u1
      - id: target_location_id_text
        type: str
        size: len_target_location_id_text
        encoding: ASCII
  strike_price:
    seq:
      - id: strike_price_exponent
        type: s1
        doc: 'First byte is the exponent, last 4 bytes are the mantissa. This field is required for options'
      - id: strike_price_mantissa
        type: s4
        doc: 'First byte is the exponent, last 4 bytes are the mantissa. This field is required for options'
  minimum_strike_price_fraction:
    seq:
      - id: minimum_strike_price_fraction_exponent
        type: s1
        doc: 'The multiple by which the strike price can be'
      - id: minimum_strike_price_fraction_mantissa
        type: s4
        doc: 'The multiple by which the strike price can be'
  max_strike_price:
    seq:
      - id: max_strike_price_exponent
        type: s1
        doc: 'The maximum allowable strike price'
      - id: max_strike_price_mantissa
        type: s4
        doc: 'The maximum allowable strike price'
  premium_break_point:
    seq:
      - id: premium_break_point_exponent
        type: s1
        doc: 'The premium price where above and below fractions take effect'
      - id: premium_break_point_mantissa
        type: s4
        doc: 'The premium price where above and below fractions take effect'
  minimum_above_premium_fraction:
    seq:
      - id: minimum_above_premium_fraction_exponent
        type: s1
        doc: 'The multiple that premium can be when above the break point'
      - id: minimum_above_premium_fraction_mantissa
        type: s4
        doc: 'The multiple that premium can be when above the break point'
  minimum_below_premium_fraction:
    seq:
      - id: minimum_below_premium_fraction_exponent
        type: s1
        doc: 'The multiple that premium can be when below the break point'
      - id: minimum_below_premium_fraction_mantissa
        type: s4
        doc: 'The multiple that premium can be when below the break point'
  currency_code:
    seq:
      - id: len_currency_code_text
        type: u1
        doc: 'Not used'
      - id: currency_code_text
        type: str
        size: len_currency_code_text
        encoding: ASCII
        doc: 'Not used'
  underlying_symbol:
    seq:
      - id: len_underlying_symbol_text
        type: u1
        doc: 'The underlying symbol'
      - id: underlying_symbol_text
        type: str
        size: len_underlying_symbol_text
        encoding: ASCII
        doc: 'The underlying symbol'
  underlying_type:
    seq:
      - id: len_underlying_type_text
        type: u1
      - id: underlying_type_text
        type: str
        size: len_underlying_type_text
        encoding: ASCII
  security_definition_leg:
    seq:
      - id: leg_ratio_qty
        type: u4
        doc: 'Leg ratio'
      - id: leg_security_id
        type: u4
        doc: 'SecurityID of the leg'
      - id: leg_side
        type: u1
        enum: leg_side
  current_market_refresh_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: appl_seq_num
        type: u4
        doc: 'Sequence number for Refresh message, will be set per line and reset to 1 (one) when refresh is completed'
      - id: num_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entry
        type: md_entry
        repeat: expr
        repeat-expr: num_md_entry
        doc: 'MDEntry'
  md_entry:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_entry_px
        type: md_entry_px
      - id: md_entry_size
        type: u4
        doc: 'Quote Quantity'
      - id: md_volume_type
        type: u1
        enum: md_volume_type
        doc: 'Volume Types'
  md_entry_px:
    seq:
      - id: md_entry_px_exponent
        type: s1
        doc: 'Price at this level and side of book'
      - id: md_entry_px_mantissa
        type: s4
        doc: 'Price at this level and side of book'
  market_data_refresh_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: appl_seq_num
        type: u4
        doc: 'Sequence number for Refresh message, will be set per line and reset to 1 (one) when refresh is completed'
      - id: prev_close_px
        type: prev_close_px
      - id: trade_volume
        type: u4
        doc: 'Total trade volume for security'
      - id: num_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entry
        type: md_entry
        repeat: expr
        repeat-expr: num_md_entry
        doc: 'MDEntry'
  prev_close_px:
    seq:
      - id: prev_close_px_exponent
        type: s1
        doc: 'Previous day’s close price for security'
      - id: prev_close_px_mantissa
        type: s4
        doc: 'Previous day’s close price for security'
  current_market_update_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: num_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entry
        type: md_entry
        repeat: expr
        repeat-expr: num_md_entry
        doc: 'MDEntry'
  recap_update_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: prev_close_px
        type: prev_close_px
      - id: trade_volume
        type: u4
        doc: 'Total trade volume for security'
      - id: num_recap_update_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: recap_update_md_entry
        type: recap_update_md_entry
        repeat: expr
        repeat-expr: num_recap_update_md_entry
        doc: 'MDEntry indicating market data'
  recap_update_md_entry:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_entry_px
        type: md_entry_px
      - id: md_entry_size
        type: u4
        doc: 'Quote Quantity'
  ticker_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: num_ticker_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: ticker_md_entry
        type: ticker_md_entry
        repeat: expr
        repeat-expr: num_ticker_md_entry
        doc: 'Volume Entry for this price level'
  ticker_md_entry:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_entry_px
        type: md_entry_px
      - id: md_entry_size
        type: u4
        doc: 'Quote Quantity'
      - id: trade_condition
        type: trade_condition
  trade_condition:
    seq:
      - id: len_trade_condition_text
        type: u1
      - id: trade_condition_text
        type: str
        size: len_trade_condition_text
        encoding: ASCII
  expected_opening_price_and_size_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: eop
        type: eop
      - id: eos
        type: u4
        doc: 'The expected opening size'
      - id: eop_type
        type: u1
        enum: eop_type
      - id: legal_market
        type: u1
        enum: legal_market
  eop:
    seq:
      - id: eop_exponent
        type: s1
        doc: 'The expected opening price'
      - id: eop_mantissa
        type: s4
        doc: 'The expected opening price'
  index_value_message:
    seq:
      - id: symbol
        type: symbol
      - id: num_index_value_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: index_value_md_entry
        type: index_value_md_entry
        repeat: expr
        repeat-expr: num_index_value_md_entry
        doc: 'Market data associated with the index'
  index_value_md_entry:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_entry_px
        type: md_entry_px
  settlement_value_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: num_settlement_value_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: settlement_value_md_entry
        type: settlement_value_md_entry
        repeat: expr
        repeat-expr: num_settlement_value_md_entry
        doc: 'The settlement price'
  settlement_value_md_entry:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_entry_px
        type: md_entry_px
  summary_message:
    seq:
      - id: class_key
        type: u4
        doc: 'Class key'
      - id: security_id
        type: u4
        doc: 'Product key'
      - id: price_type
        type: u1
        doc: 'Specifies how to interpret the value in the StrikePrice field'
      - id: trade_volume
        type: u4
        doc: 'Total trade volume for security'
      - id: open_interest
        type: u4
        doc: 'Open Interest'
      - id: net_chg_prev_day
        type: net_chg_prev_day
      - id: underlying_px
        type: underlying_px
      - id: num_summary_md_entry
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: summary_md_entry
        type: summary_md_entry
        repeat: expr
        repeat-expr: num_summary_md_entry
        doc: 'Summary market data'
  net_chg_prev_day:
    seq:
      - id: net_chg_prev_day_exponent
        type: s1
        doc: 'Net change of last sale price relative to previous close price. Sign of this value implies direction of change'
      - id: net_chg_prev_day_mantissa
        type: s4
        doc: 'Net change of last sale price relative to previous close price. Sign of this value implies direction of change'
  underlying_px:
    seq:
      - id: underlying_px_exponent
        type: s1
        doc: 'Price of underlying security'
      - id: underlying_px_mantissa
        type: s4
        doc: 'Price of underlying security'
  summary_md_entry:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Side of book for this entry'
      - id: md_entry_px
        type: md_entry_px
  market_data_control_message:
    seq:
      - id: md_control_type
        type: u1
        enum: md_control_type

enums:
  template_id:
    13:
      id: 'security_definition_message'
      doc: 'Security definitions describe an exchange’s products by name and trading parameters and associates those products with a product security ID.'
    11:
      id: 'current_market_refresh_message'
      doc: 'The Current Market Refresh message contains a snapshot of the current market information for one security along with the quantities and volume types for that particular security.'
    20:
      id: 'market_data_refresh_message'
      doc: 'The Market Data Refresh message contains a snapshot / refresh of the Current Market and Recap information (Last Sale, Last Sale Size, Open, High, Low, Previous Close Price) for one product.'
    12:
      id: 'current_market_update_message'
      doc: 'The Current Market Update message contains real-time top of book market updates for a security.'
    21:
      id: 'recap_update_message'
      doc: 'The Recap Update message contains the latest Last Sale price, Last Sale size, Total Volume, Open price, High price, Low price, and Previous close price. It is sent as a result of a trade or cancel.'
    14:
      id: 'ticker_message'
      doc: 'A Ticker message indicates that a trade or cancel has occurred.'
    15:
      id: 'expected_opening_price_and_size_message'
      doc: 'The EOP message contains expected opening price and size information for a security.'
    22:
      id: 'index_value_message'
      doc: 'Index value messages contain the values associated with a calculated index. They are transmitted when an index is calculated.'
    23:
      id: 'settlement_value_message'
      doc: 'Index value messages contain the values associated with a calculated index. They are transmitted when an index is calculated.'
    24:
      id: 'summary_message'
      doc: 'Summary messages contain the end of session market data for each product.'
    25:
      id: 'market_data_control_message'
      doc: 'Market Data Control messages mark the start and end of the end of session Summary and the end of session Settlement data transmissions.'
    16:
      id: 'heartbeat_message'
      doc: 'This message contains only a standard header. The heartbeat will repeat at a regular interval'
  security_exchange:
    0x43:
      id: 'cboe'
      doc: 'Cboe'
    0x4f:
      id: 'one_chicago_not_supported'
      doc: 'One Chicago Not Supported'
    0x57:
      id: 'cbsx_not_supported'
      doc: 'Cbsx Not Supported'
    0x46:
      id: 'cfecof'
      doc: 'Cfecof'
    0x32:
      id: 'cboe_2_options'
      doc: 'Cboe 2 Options'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'
  exercise_style:
    0:
      id: 'american'
      doc: 'American'
    1:
      id: 'european'
      doc: 'European'
  leg_side:
    0x42:
      id: 'buy_bid'
      doc: 'Buy Bid'
    0x53:
      id: 'sell_ask'
      doc: 'Sell Ask'
  security_trading_status:
    2:
      id: 'halted'
      doc: 'Market Halted'
    17:
      id: 'open'
      doc: 'Market Open'
    18:
      id: 'closed'
      doc: 'Market Closed'
    21:
      id: 'pre_open'
      doc: 'Pre Open'
    22:
      id: 'opening_rotation'
      doc: 'Market In Opening Rotation'
    23:
      id: 'fast_market'
      doc: 'Fast Market'
    24:
      id: 'strategy_market_in_opening_rotation'
      doc: 'Strategy Market In Opening Rotation'
    25:
      id: 'strategy_market_quotes_non_firm'
      doc: 'Strategy Market Quotes Non Firm'
    26:
      id: 'suspended'
      doc: 'Market Suspended Quotes Are Not Firm'
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'ask'
      doc: 'Ask'
    0x32:
      id: 'trade'
      doc: 'Trade Last Sale'
    0x33:
      id: 'index_value'
      doc: 'Index Value Used Only In Index Value Messages'
    0x34:
      id: 'opening_price'
      doc: 'Opening Price'
    0x36:
      id: 'settlement_value'
      doc: 'Settlement Value Used Only In Settlement Messages'
    0x37:
      id: 'high'
      doc: 'High Trading Session High Price'
    0x38:
      id: 'low'
      doc: 'Low Trading Session Low Price'
  md_volume_type:
    0:
      id: 'total_limit'
      doc: 'Total Limit'
    1:
      id: 'customer_limit'
      doc: 'Customer Limit'
    2:
      id: 'total_contingency_all_or_none'
      doc: 'Total Contingency All Or None'
    3:
      id: 'customer_contingency_all_or_none'
      doc: 'Customer Contingency All Or None'
  eop_type:
    0:
      id: 'undefined'
      doc: 'Undefined Not Used'
    1:
      id: 'opening_price'
      doc: 'Opening Price'
    2:
      id: 'need_more_sellers'
      doc: 'Need More Sellers'
    3:
      id: 'need_more_buyers'
      doc: 'Need More Buyers'
    4:
      id: 'no_opening_trades'
      doc: 'No Opening Trades'
    5:
      id: 'multiple_opening_prices'
      doc: 'Multiple Opening Prices'
    6:
      id: 'need_quote_to_open'
      doc: 'Need Quote To Open'
    7:
      id: 'price_not_in_quote_range'
      doc: 'Price Not In Quote Range'
    8:
      id: 'need_dpm_quote_to_open'
      doc: 'Need Dpm Quote To Open'
    9:
      id: 'dpm_quote_invalid'
      doc: 'Dpm Quote Invalid'
    10:
      id: 'price_not_in_botr_range'
      doc: 'Price Not In Botr Range'
  legal_market:
    0:
      id: 'not_a_legal_market'
      doc: 'Not A Legal Market'
    1:
      id: 'legal_market'
      doc: 'Legal Market'
  md_control_type:
    0:
      id: 'start_of_summary'
      doc: 'Start Of Summary'
    1:
      id: 'end_of_summary'
      doc: 'End Of Summary'
    2:
      id: 'start_of_settlement'
      doc: 'Start Of Settlement'
    3:
      id: 'end_of_settlement'
      doc: 'End Of Settlement'

