# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx TsxAlpha QuantumFeedLevel2 Xmt v2.2
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Quantum Feed Level 2
#   Encoding: eXtreme Message Transfer
#   Version: 2.2
#   Date: 4/17/2023
#   Specification: alpha_level_2_tmx_quantumfeed_business_message_specifications-v2-2-0.pdf
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
  id: tmx_tsxalpha_quantumfeedlevel2_xmt_v2_2
  title: Tmx TsxAlpha QuantumFeedLevel2 Xmt v2.2
  license: GPL-3.0
  endian: le

doc: 'TMX Group TSX Alpha Exchange Quantum Feed Level 2 Xmt v2.2'
doc-ref: https://www.tmxwebstore.com/

seq:
  - id: frame_header
    type: frame_header_struct
    doc: 'Xmt Udp Packet Frame Header'
  - id: body
    type: body_struct
    repeat: expr
    repeat-expr: frame_header.num_body
    doc: 'Xmt Body'

types:
  frame_header_struct:
    seq:
      - id: start_of_frame
        type: u1
        enum: start_of_frame
        doc: 'Start of Frame'
      - id: protocol_name
        type: u1
        enum: protocol_name
        doc: 'Protocol Name'
      - id: protocol_version
        type: str
        size: 1
        encoding: ASCII
        doc: 'Start of Frame'
      - id: message_length
        type: u2
        doc: 'Length of message from Header to Body inclusive'
      - id: session_id
        type: u4
        doc: 'Constant Session Id'
      - id: ack_required_poss_dup
        type: u1
        enum: ack_required_poss_dup
        doc: 'Ack Required Poss Dup'
      - id: num_body
        type: u1
        doc: 'Num Body'
  body_struct:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: body_message
        type: body_message
        size: body_header.msg_length - 3
        doc: 'Xmt Body Header'
  body_header:
    seq:
      - id: msg_length
        type: u2
        doc: 'Length of this message'
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Length of this message'
  body_message:
    seq:
      - id: business_header
        type: business_header
        doc: 'Xmt Business Header'
      - id: business_message
        size: _parent.body_header.msg_length - 3 - 9
        type:
          switch-on: _parent.body_header.msg_type
          cases:
            'msg_type::symbol_status_message': symbol_status_message
            'msg_type::order_book_message': order_book_message
            'msg_type::market_state_update_message': market_state_update_message
            'msg_type::order_booked_message': order_booked_message
            'msg_type::order_cancelled_message': order_cancelled_message
            'msg_type::order_price_time_assigned_message': order_price_time_assigned_message
            'msg_type::stock_status_message': stock_status_message
            'msg_type::trade_report_message': trade_report_message
            'msg_type::trade_report_terms_message': trade_report_terms_message
            'msg_type::trade_cancelled_message': trade_cancelled_message
            'msg_type::trade_cancelled_terms_message': trade_cancelled_terms_message
            'msg_type::trade_correction_message': trade_correction_message
            'msg_type::trade_correction_terms_message': trade_correction_terms_message
  business_header:
    seq:
      - id: msg_version
        type: u1
        doc: 'Message version number'
      - id: source_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Source Id of the Business message'
      - id: stream_id
        type: u2
        doc: 'Stream Id per Source Id of the Business message'
      - id: sequence_0
        type: u1
        doc: 'Reserved for future expansion, Value is 0'
      - id: sequence_1
        type: u4
        doc: 'Sequence per Stream Id of the Business message'
  symbol_status_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: stock_group
        type: u1
        doc: 'An Identifier Of The Stock Group'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The Market On Which A Security Is Listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The Product Type For A Symbol'
      - id: cusip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing And Settlement Registration Number'
      - id: board_lot
        type: u2
        doc: 'Contains The Board Lot Size'
      - id: currency
        type: u1
        enum: currency
        doc: 'The Currency Associated With A Reported Price'
      - id: face_value
        type: decimal_u8_6
        doc: 'The Face Value Of A Debenture. Implied decimal with scale 1e-6'
      - id: last_sale
        type: decimal_u8_6
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6'
      - id: min_po_qty
        type: u4
        doc: 'The Minimum Volume Required For Post Only Orders'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The State Of The Stock'
      - id: test_symbol
        type: u1
        enum: test_symbol
        doc: 'Indicates The Symbol Is A Test Symbol'
  order_book_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Participating Organization'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: priority_time_stamp
        type: microsecond_timestamp
        doc: 'Timestamp Assigned By The Trading Engine To Specify Time Priority Of An Order. Microseconds since Unix epoch'
  market_state_update_message:
    seq:
      - id: market_state
        type: u1
        enum: market_state
        doc: 'Indicates The Current Market State'
      - id: stock_group
        type: u1
        doc: 'An Identifier Of The Stock Group'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  order_booked_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Participating Organization'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: priority_time_stamp
        type: microsecond_timestamp
        doc: 'Timestamp Assigned By The Trading Engine To Specify Time Priority Of An Order. Microseconds since Unix epoch'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  order_cancelled_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Participating Organization'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  order_price_time_assigned_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Participating Organization'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: priority_time_stamp
        type: microsecond_timestamp
        doc: 'Timestamp Assigned By The Trading Engine To Specify Time Priority Of An Order. Microseconds since Unix epoch'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  stock_status_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: comment
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Text Field Corresponding To A Reason Code Entered When A Stock Is Halted Or The Initiator Of A Delayed Opening On A Stock Or When There Is A Change To The Oddlot Trader On A Stock'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The State Of The Stock'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  trade_report_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: buy_broker_number
        type: u2
        doc: 'An Exchangeassigned Public Number Uniquely Identifying A Participating Organization Associated With A Buy Order'
      - id: buy_order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To The Buy Order By The Trading System'
      - id: buy_display_volume
        type: u4
        doc: 'Public Remaining Display Volume For The Buy Order'
      - id: sell_broker_number
        type: u2
        doc: 'An Exchangeassigned Number Uniquely Identifying A Participating Organization Associated With A Sell Order'
      - id: sell_order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To A Sell Order By The Trading System'
      - id: sell_display_volume
        type: u4
        doc: 'Public Remaining Volume For The Sell Order'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An Indicator For Bypass Crosses Which Can Be Printed Outside Of The Protected Nbbo And Are Not Subject To Cross Interference'
      - id: trade_time_stamp
        type: u4
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: is_dark
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates At Least One Side Of The Trade Is Dark'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  trade_report_terms_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: buy_broker_number
        type: u2
        doc: 'An Exchangeassigned Public Number Uniquely Identifying A Participating Organization Associated With A Buy Order'
      - id: buy_order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To The Buy Order By The Trading System'
      - id: buy_display_volume
        type: u4
        doc: 'Public Remaining Display Volume For The Buy Order'
      - id: sell_broker_number
        type: u2
        doc: 'An Exchangeassigned Number Uniquely Identifying A Participating Organization Associated With A Sell Order'
      - id: sell_order_id
        type: u8
        doc: 'Public Numeric Identifier Assigned To A Sell Order By The Trading System'
      - id: sell_display_volume
        type: u4
        doc: 'Public Remaining Volume For The Sell Order'
      - id: trade_time_stamp
        type: u4
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: settlement_date
        type: u4
        doc: 'Settlement Date Associated With The Order'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  trade_cancelled_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  trade_cancelled_terms_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  trade_correction_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: buy_broker_number
        type: u2
        doc: 'An Exchangeassigned Public Number Uniquely Identifying A Participating Organization Associated With A Buy Order'
      - id: sell_broker_number
        type: u2
        doc: 'An Exchangeassigned Number Uniquely Identifying A Participating Organization Associated With A Sell Order'
      - id: initiated_by
        type: u1
        enum: initiated_by
        doc: 'Indicates Which Side Initiated The Trade Correction'
      - id: orig_trade_number
        type: u4
        doc: 'Used With Trade Corrections To Reference Previously Reported Executions'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An Indicator For Bypass Crosses Which Can Be Printed Outside Of The Protected Nbbo And Are Not Subject To Cross Interference'
      - id: trade_time_stamp
        type: u4
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: is_dark
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates At Least One Side Of The Trade Is Dark'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  trade_correction_terms_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: buy_broker_number
        type: u2
        doc: 'An Exchangeassigned Public Number Uniquely Identifying A Participating Organization Associated With A Buy Order'
      - id: sell_broker_number
        type: u2
        doc: 'An Exchangeassigned Number Uniquely Identifying A Participating Organization Associated With A Sell Order'
      - id: initiated_by
        type: u1
        enum: initiated_by
        doc: 'Indicates Which Side Initiated The Trade Correction'
      - id: orig_trade_number
        type: u4
        doc: 'Used With Trade Corrections To Reference Previously Reported Executions'
      - id: trade_time_stamp
        type: u4
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: settlement_date
        type: u4
        doc: 'Settlement Date Associated With The Order'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch'
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  microsecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000 % 24
      minute:
        value: time / 60000000 % 60
      second:
        value: time / 1000000 % 60
      millisecond:
        value: time / 1000 % 1000
      microsecond:
        value: time % 1000
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
  start_of_frame:
    2:
      id: 'new_frame'
      doc: 'Xmt start of frame'
  protocol_name:
    0x58:
      id: 'xmt'
      doc: 'Xmt'
  ack_required_poss_dup:
    0x30:
      id: 'unused'
      doc: 'None'
  msg_type:
    0x4a:
      id: 'symbol_status_message'
      doc: 'Symbol Status messages contain information regarding equity, debenture, or trading Instruments for the current trading day for the Alpha market. One message is disseminated for each valid symbol at the beginning of each trading day.'
    0x47:
      id: 'order_book_message'
      doc: 'An Order Book message provides public information for all open non-terms orders in the market at the start of day. One message is disseminated for each valid non-terms order at the beginning of each trading day'
    0x45:
      id: 'market_state_update_message'
      doc: 'A Market State Update message is disseminated each time a notice of a market state change or a trading session change is sent from the Trading Engine'
    0x50:
      id: 'order_booked_message'
      doc: 'An Order Booked message is disseminated in response to a new non-terms order being entered into the trading system'
    0x51:
      id: 'order_cancelled_message'
      doc: 'An Order Cancelled message is disseminated if a non-terms order is cancelled'
    0x52:
      id: 'order_price_time_assigned_message'
      doc: 'An Order Price-Time Assigned message is disseminated when a new Price or Time is assigned to a non-terms order'
    0x49:
      id: 'stock_status_message'
      doc: 'A Stock Status notification is disseminated in response to a change in stock status from the Trading Engine'
    0x53:
      id: 'trade_report_message'
      doc: 'A Trade Report is produced when a trade occurs that has no settlement terms'
    0x70:
      id: 'trade_report_terms_message'
      doc: 'A Trade Report – Terms is produced when a trade occurs that and has settlement terms and has Non-Resident participation with or without settlement terms'
    0x54:
      id: 'trade_cancelled_message'
      doc: 'A Trade Cancelled message is produced when a trade with no settlement terms is cancelled.'
    0x71:
      id: 'trade_cancelled_terms_message'
      doc: 'A Trade Cancelled – Terms message is produced when a trade with settlement terms is cancelled.'
    0x55:
      id: 'trade_correction_message'
      doc: 'A Trade Correction message is produced when a trade with no settlement terms is corrected'
    0x72:
      id: 'trade_correction_terms_message'
      doc: 'A Trade Correction – Terms message is produced when a trade with settlement terms is corrected'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'tsxv'
      doc: 'Tsxv'
  product_type:
    0x42:
      id: 'debenture'
      doc: 'Debenture'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x4d:
      id: 'mutual_fund'
      doc: 'Mutual Fund'
    0x46:
      id: 'etf'
      doc: 'Etf'
  currency:
    0x55:
      id: 'usd'
      doc: 'Usd'
    0x43:
      id: 'cad'
      doc: 'Cad'
  test_symbol:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  market_state:
    0x50:
      id: 'preopen'
      doc: 'Preopen'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x52:
      id: 'extended_hours_open'
      doc: 'Extended Hours Open'
    0x46:
      id: 'extended_hours_close'
      doc: 'Extended Hours Close'
    0x4e:
      id: 'extended_hours_cxls'
      doc: 'Extended Hours Cxls'
    0x4d:
      id: 'moc_imbalance'
      doc: 'Moc Imbalance'
    0x41:
      id: 'ccp_determination'
      doc: 'Ccp Determination'
    0x45:
      id: 'price_movement_extension'
      doc: 'Price Movement Extension'
    0x4c:
      id: 'closing'
      doc: 'Closing'
  bypass:
    0x59:
      id: 'yes_field'
      doc: 'The Order Is A Bypass'
    0x4e:
      id: 'no_field'
      doc: 'The Order Is Not A Bypass'
  cross_type:
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x56:
      id: 'volume_weighted_average_price'
      doc: 'Volume Weighted Average Price'
    0x20:
      id: 'default_field'
      doc: 'Trade Was Not A Cross'
  settlement_terms:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'nn'
      doc: 'Nn'
    0x4d:
      id: 'ms'
      doc: 'Ms'
    0x54:
      id: 'ct'
      doc: 'Ct'
    0x44:
      id: 'xalid_settlement_date'
      doc: 'Xalid Settlement Date'
    0x20:
      id: 'no_settlement_terms'
      doc: 'No Settlement Terms'
  initiated_by:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
    0x43:
      id: 'both_sides'
      doc: 'Both Sides'

