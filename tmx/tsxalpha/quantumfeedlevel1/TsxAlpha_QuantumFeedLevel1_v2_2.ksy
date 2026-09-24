# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx TsxAlpha QuantumFeedLevel1 Xmt v2.2
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Quantum Feed Level 1
#   Encoding: eXtreme Message Transfer
#   Version: 2.2
#   Date: 4/17/2023
#   Specification: alpha_level_1_quantumfeed_business_message_specification-v2-2-0.pdf
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
  id: tmx_tsxalpha_quantumfeedlevel1_xmt_v2_2
  title: Tmx TsxAlpha QuantumFeedLevel1 Xmt v2.2
  license: GPL-3.0
  endian: le

doc: 'TMX Group TSX Alpha Exchange Quantum Feed Level 1 Xmt v2.2'
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
            'msg_type::trade_message': trade_message
            'msg_type::trade_cancelled_message': trade_cancelled_message
            'msg_type::stock_status_message': stock_status_message
            'msg_type::equity_quote_message': equity_quote_message
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
  trade_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
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
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An Indicator For Bypass Crosses Which Can Be Printed Outside Of The Protected Nbbo And Are Not Subject To Cross Interference'
      - id: trade_time_stamp
        type: u4
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: last_sale
        type: decimal_u8_6
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6'
      - id: opening_trade
        type: u1
        enum: opening_trade
        doc: 'Indicates Whether The Trade Occurred At The Opening Or Was The First Board Lot Trade Of The Day'
      - id: is_dark
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates At Least One Side Of The Trade Is Dark'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
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
      - id: volume
        type: u4
        doc: 'The Quantity Of Shares For An Order Or Trade'
      - id: price
        type: decimal_u8_6
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6'
      - id: buy_broker_number
        type: u2
        doc: 'An Exchangeassigned Public Number Uniquely Identifying A Participating Organization Associated With A Buy Order'
      - id: sell_broker_number
        type: u2
        doc: 'An Exchangeassigned Number Uniquely Identifying A Participating Organization Associated With A Sell Order'
      - id: trade_time_stamp
        type: u4
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added'
      - id: last_sale
        type: decimal_u8_6
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6'
      - id: trade_number
        type: u4
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade'
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
      - id: resume_trade_time
        type: u4
        doc: 'The Time At Which A Halted Stock Will Resume Trading'
  equity_quote_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: bid_price
        type: decimal_u8_6
        doc: 'Contains The Bid Price For The Symbol. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Contains The Bid Size Volume For The Symbol'
      - id: ask_price
        type: decimal_u8_6
        doc: 'Contains The Ask Price For The Symbol. Implied decimal with scale 1e-6'
      - id: ask_size
        type: u4
        doc: 'Contains The Ask Size Volume For The Symbol'
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
    0x73:
      id: 'trade_message'
      doc: 'A Trade message is generated each time a trade occurs.'
    0x74:
      id: 'trade_cancelled_message'
      doc: 'A Trade Cancelled message is generated each time a trade is cancelled.'
    0x76:
      id: 'stock_status_message'
      doc: 'A Stock Status message is disseminated in response to a change in stock status from the Trading Engine. It contains information regarding the current state of the stock.'
    0x77:
      id: 'equity_quote_message'
      doc: 'An Equity Quote message contains the latest Bid and Ask information for a symbol.'
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
  bypass:
    0x59:
      id: 'the_order_is_a_bypass'
      doc: 'The Order Is A Bypass'
    0x4e:
      id: 'the_order_is_not_a_bypass'
      doc: 'The Order Is Not A Bypass'
  settlement_terms:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'nn'
      doc: 'Nn'
    0x4d:
      id: 'ms_derivativesrelated_contingent_equity_trade'
      doc: 'Ms Derivativesrelated Contingent Equity Trade'
    0x54:
      id: 'ct_cash_today'
      doc: 'Ct Cash Today'
    0x44:
      id: 'if_there_is_a_valid_settlement_date_associated_with_the_order'
      doc: 'If There Is A Valid Settlement Date Associated With The Order'
    0x20:
      id: 'no_settlement_terms'
      doc: 'No Settlement Terms'
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
      id: 'default_trade_was_not_a_cross'
      doc: 'Default Trade Was Not A Cross'
  opening_trade:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'

