# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx TsxAlpha QuantumFeedLevel1 Xmt v2.2
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Quantum Feed Level 1
#   Encoding: eXtreme Message Transfer
#   Version: 2.2
#   Date: 4/17/2023
#   Specification: Alpha Level 1 QuantumFeed Business Message Specification (2.2.0).pdf
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
  - id: packet
    type: packet_struct
    repeat: eos
    doc: 'Xmt Udp Packet'

types:
  packet_struct:
    seq:
      - id: frame_header
        type: frame_header_struct
        doc: 'Xmt Udp Packet Frame Header'
      - id: packet_body
        size: frame_header.message_length + 5 - 11
        type:
          switch-on: peek_msg_type
          cases:
            'msg_type::heartbeat': heartbeat_body
            _: business_bodies
    instances:
      peek_msg_type:
        pos: _io.pos + 2
        type: u1
        enum: msg_type
  frame_header_struct:
    seq:
      - id: start_of_frame
        type: u1
        doc: 'Start of Frame'
      - id: protocol_name
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol Name'
      - id: protocol_version
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol major version number'
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
  heartbeat_body:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
      - id: hb_interval
        type: u2
        doc: 'Heartbeat interval in milliseconds (1 to 65536)'
      - id: admin_body
        type: admin_body
        repeat: expr
        repeat-expr: _parent.frame_header.num_body
  body_header:
    seq:
      - id: msg_length
        type: u2
        doc: 'Length of this message'
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Msg Type'
  admin_body:
    seq:
      - id: source_id
        type: u1
        enum: source_id
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
  business_bodies:
    seq:
      - id: body
        type: body
        repeat: expr
        repeat-expr: _parent.frame_header.num_body
        doc: 'Xmt Body'
  body:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: body_message
        type: body_message
        size: body_header.msg_length - 3
        doc: 'Xmt Body Header'
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
        type: u1
        enum: source_id
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
        type: u1_nullable
        doc: 'An Identifier Of The Stock Group. Nullable, No Value = 0'
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
        type: u2_nullable
        doc: 'Contains The Board Lot Size. Nullable, No Value = 0'
      - id: currency
        type: u1
        enum: currency
        doc: 'The Currency Associated With A Reported Price'
      - id: face_value
        type: decimal_u8_6_nullable
        doc: 'The Face Value Of A Debenture. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: last_sale
        type: decimal_u8_6_nullable
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: min_po_qty
        type: u4_nullable
        doc: 'The Minimum Volume Required For Post Only Orders. Nullable, No Value = 0'
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
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: buy_broker_number
        type: u2_nullable
        doc: 'An Exchangeassigned Public Number Uniquely Identifying A Participating Organization Associated With A Buy Order. Nullable, No Value = 0'
      - id: sell_broker_number
        type: u2_nullable
        doc: 'An Exchangeassigned Number Uniquely Identifying A Participating Organization Associated With A Sell Order. Nullable, No Value = 0'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An Indicator For Bypass Crosses Which Can Be Printed Outside Of The Protected Nbbo And Are Not Subject To Cross Interference'
      - id: trade_time_stamp
        type: u4_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: last_sale
        type: decimal_u8_6_nullable
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6. Nullable, No Value = 0'
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
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch. Nullable, No Value = 0'
  trade_cancelled_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: buy_broker_number
        type: u2_nullable
        doc: 'An Exchangeassigned Public Number Uniquely Identifying A Participating Organization Associated With A Buy Order. Nullable, No Value = 0'
      - id: sell_broker_number
        type: u2_nullable
        doc: 'An Exchangeassigned Number Uniquely Identifying A Participating Organization Associated With A Sell Order. Nullable, No Value = 0'
      - id: trade_time_stamp
        type: u4_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: last_sale
        type: decimal_u8_6_nullable
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch. Nullable, No Value = 0'
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
        type: nanosecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: resume_trade_time
        type: u4_nullable
        doc: 'The Time At Which A Halted Stock Will Resume Trading. Nullable, No Value = 0'
  equity_quote_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: bid_price
        type: decimal_u8_6_nullable
        doc: 'Contains The Bid Price For The Symbol. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: bid_size
        type: u4_nullable
        doc: 'Contains The Bid Size Volume For The Symbol. Nullable, No Value = 0'
      - id: ask_price
        type: decimal_u8_6_nullable
        doc: 'Contains The Ask Price For The Symbol. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: ask_size
        type: u4_nullable
        doc: 'Contains The Ask Size Volume For The Symbol. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch. Nullable, No Value = 0'
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 0
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_u8_6_nullable:
    seq:
      - id: value
        type: decimal_u8_6
    instances:
      is_null:
        value: value.mantissa == 0
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0
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
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == 0

enums:
  ack_required_poss_dup:
    0x30:
      id: 'unused'
      doc: 'None'
    0x41:
      id: 'ack_required'
      doc: 'Receiver needs to ack'
    0x44:
      id: 'poss_dup'
      doc: 'Possible duplicates'
  msg_type:
    0x30:
      id: 'heartbeat'
      doc: 'The Heartbeat message is sent by either side during idle periods for the opposite side to detect whether the session is still alive.'
    0x4a:
      id: 'symbol_status_message'
      doc: 'Symbol Status messages contain information regarding equity, debenture, or trading Instruments for the current trading day for the Alpha and Alpha X/ DRK market. One message is disseminated for each valid symbol at the beginning of each trading day.'
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
  source_id:
    0x30:
      id: 'non_source_related'
      doc: '“0” for non-source-related.'
    0x51:
      id: 'tsx'
      doc: 'Q for TSX'
    0x56:
      id: 'tsx_venture'
      doc: 'V for TSX Venture'
    0x41:
      id: 'alpha'
      doc: 'A for Alpha'
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

