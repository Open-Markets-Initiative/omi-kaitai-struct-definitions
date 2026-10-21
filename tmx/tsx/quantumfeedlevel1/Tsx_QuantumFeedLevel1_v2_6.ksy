# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Tsx QuantumFeedLevel1 Xmt v2.6
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Quantum Feed Level 1
#   Encoding: eXtreme Message Transfer
#   Version: 2.6
#   Date: 8/10/2021
#   Specification: TSX TSXV Level 1 QuantumFeed Business Message Specification (2.6.0).pdf
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
  id: tmx_tsx_quantumfeedlevel1_xmt_v2_6
  title: Tmx Tsx QuantumFeedLevel1 Xmt v2.6
  license: GPL-3.0
  endian: le

doc: 'TMX Group Toronto Stock Exchange Quantum Feed Level 1 Xmt v2.6'
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
          switch-on: packet_body.heartbeat_body.body_header.msg_type
          cases:
            'msg_type::heartbeat': heartbeat_body
            _: business_bodies
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
            'msg_type::trade_report_message': trade_report_message
            'msg_type::trade_cancelled_message': trade_cancelled_message
            'msg_type::moc_imbalance_message': moc_imbalance_message
            'msg_type::stock_status_message': stock_status_message
            'msg_type::quote_message': quote_message
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
      - id: last_sale_price
        type: decimal_u8_6_nullable
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The Market On Which A Security Is Listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The Product Type For A Symbol'
      - id: buy_maximum_quantity
        type: u4_nullable
        doc: 'The Maximum Quantity Of A Mutual Fund Allowed To Purchase. Nullable, No Value = 0'
      - id: buy_minimum_quantity
        type: u4_nullable
        doc: 'The Minimum Quantity Of A Mutual Fund Required To Purchase. Nullable, No Value = 0'
      - id: sell_maximum_quantity
        type: u4_nullable
        doc: 'The Maximum Quantity Of A Mutual Fund Allowed To Sell. Nullable, No Value = 0'
      - id: sell_minimum_quantity
        type: u4_nullable
        doc: 'The Minimum Quantity Of A Mutual Fund Required To Sell. Nullable, No Value = 0'
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
      - id: moc_eligible
        type: u1
        enum: moc_eligible
        doc: 'Identifies Whether The Stock Is Eligible To Trade In The Market On Close Session Each Trading Day'
  trade_report_message:
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
        type: hhmmss_time_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: last_sale_price
        type: decimal_u8_6_nullable
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: opening_trade
        type: u1
        enum: opening_trade
        doc: 'Indicates Whether The Trade Occurred At The Opening Or Was The First Board Lot Trade Of The Day Note That This Field Is Set To Y On Auction Trades That Occur When A Symbol Is Unhalted And On Closing Trades'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The Market On Which A Security Is Listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The Product Type For A Symbol'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: trade_date
        type: yyyymmdd_date_nullable
        doc: 'Effective Date Of The Trade Will Be Filled Only When The Effective Date Is Different From The Current Date. Nullable, No Value = 0'
      - id: is_mid_only
        type: u1
        enum: is_mid_only
        doc: 'Indicates A Dark Contra Midpoint Only Plus To Contra Midpoint Only Plus Execution'
      - id: is_dark
        type: u1
        enum: is_dark
        doc: 'Indicates The Passive Side Of The Trade Is Dark'
      - id: is_conditional
        type: u1
        enum: is_conditional
        doc: 'Indicates A Firmup Conditional To Firmup Conditional Execution'
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
        type: hhmmss_time_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: last_sale_price
        type: decimal_u8_6_nullable
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The Market On Which A Security Is Listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The Product Type For A Symbol'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: trade_date
        type: yyyymmdd_date_nullable
        doc: 'Effective Date Of The Trade Will Be Filled Only When The Effective Date Is Different From The Current Date. Nullable, No Value = 0'
  moc_imbalance_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'Indicates Which Side Has An Imbalance Volume For Market On Close'
      - id: imbalance_volume
        type: u4_nullable
        doc: 'Identifies The Volume Of Shares Of The Imbalance Side For Market On Close. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: imbalance_reference_price
        type: decimal_u8_6_nullable
        doc: 'The Price That Establishes If A Given Limitpriced Market On Close Loc Order Can Contribute To The Moc Imbalance All Loc Orders That Are Priced Equal To Or More Aggressively Than This Price Will Contribute To The Moc Imbalance. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: paired_volume
        type: u4_nullable
        doc: 'The Number Of Moc And Loc Shares That Can Be Matched At The Reference Price. Nullable, No Value = 0'
      - id: market_order_imbalance_volume
        type: u4_nullable
        doc: 'Indicates The Share Imbalance When Considering Moc Orders Only Note This Will Not Change From Freeze Period As Moc Orders Are Not Allowed After This Time. Nullable, No Value = 0'
      - id: market_order_imbalance_side
        type: u1
        enum: market_order_imbalance_side
        doc: 'Side Buy Or Sell Of The Market Order Imbalance Volume'
      - id: near_indicative_closing_price
        type: decimal_u8_6_nullable
        doc: 'The Calculated Closing Price That Will Maximize The Number Of Shares Matched Based On Onclose Orders Moc Loc And Visible Continuous Market Orders Effectively This Is The Price At Which The Closing Print Would Occur At The Time Of Publication. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: far_indicative_closing_price
        type: decimal_u8_6_nullable
        doc: 'The Calculated Closing Price That Will Maximize The Number Of Shares Matched Based On Closing Interest Only Moc Loc This Calculation Excludes Continuous Market Orders. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: price_variation
        type: decimal_u4_2_nullable
        doc: 'This Field Indicates The Absolute Value Of The Percentage Of Deviation Of The Near Indicative Closing Price From The Reference Price. Implied decimal with scale 1e-2. Nullable, No Value = 0'
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
        doc: 'A Text Field Corresponding To A Reason Code Entered When A Stock Is Halted Or The Initiator Of A Delayed Opening On A Stock Or When There Is A Change To The Rt Oddlot Trader On A Stock As Well This Is A Systemproduced Text Field To Describe The Disabling Of The Moc Session By Tsx Trading Services'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The State Of The Stock'
      - id: trading_system_time_stamp
        type: nanosecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: calculated_closing_price
        type: decimal_u8_6_nullable
        doc: 'The Price At Which Moc Orders Will Trade At Closing It Is Published Only When Outside Acceptable Limits Set By The Exchange Triggering An Extension To The Moc Limit Order Entry Session. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: vwap
        type: decimal_u8_6_nullable
        doc: 'Volume Weighted Average Price Based On Trades Occurring In The Continuous Market For Moc. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: resume_trade_time
        type: u4_nullable
        doc: 'The Time At Which A Halted Stock Will Resume Trading. Nullable, No Value = 0'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The Market On Which A Security Is Listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The Product Type For A Symbol'
  quote_message:
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
  hhmmss_time:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 10000 % 100
      minute:
        value: time / 100 % 100
      second:
        value: time % 100
  hhmmss_time_nullable:
    seq:
      - id: value
        type: hhmmss_time
    instances:
      is_null:
        value: value.time == 0
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  yyyymmdd_date_nullable:
    seq:
      - id: value
        type: yyyymmdd_date
    instances:
      is_null:
        value: value.packed == 0
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
  decimal_u4_2:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 100.0
  decimal_u4_2_nullable:
    seq:
      - id: value
        type: decimal_u4_2
    instances:
      is_null:
        value: value.mantissa == 0

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
      doc: 'Symbol Status messages contain information regarding equity, debenture, mutual fund, or trading Instruments for the current trading day for both TSX and TSXV markets. One message is disseminated for each valid symbol at the beginning of each trading day.'
    0x73:
      id: 'trade_report_message'
      doc: 'A trade message is produced each time a trade occurs'
    0x74:
      id: 'trade_cancelled_message'
      doc: 'A Trade Cancelled message is produced each time a trade is cancelled.'
    0x75:
      id: 'moc_imbalance_message'
      doc: 'A MOC Imbalance message is disseminated for every MOC-eligible stock every 10 seconds starting from the beginning of the MOC Imbalance session at 3:50 p.m., or as notified by TSX Equities Trading. The message will also be disseminated at 4:00 p.m. for closing delayed stocks.'
    0x76:
      id: 'stock_status_message'
      doc: 'A Stock Status message is disseminated in response to a change in stock status from the Trading Engine. It contains information regarding the current state of the stock, MOC Price movement delays, and so on.'
    0x77:
      id: 'quote_message'
      doc: 'A Quote message contains the latest Bid and Ask information for a symbol.'
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
  currency:
    0x55:
      id: 'usd'
      doc: 'Usd'
    0x43:
      id: 'cad'
      doc: 'Cad'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'tsx_venture'
      doc: 'Tsx Venture'
    0x4e:
      id: 'tsx_na_vex'
      doc: 'Tsx Na Vex'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x53:
      id: 'nyse'
      doc: 'Nyse'
    0x4d:
      id: 'nyse_mkt'
      doc: 'Nyse Mkt'
    0x58:
      id: 'no_market'
      doc: 'No Market'
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
    0x55:
      id: 'us_equity'
      doc: 'Us Equity'
    0x4f:
      id: 'bond'
      doc: 'Bond'
  test_symbol:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  moc_eligible:
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
      id: 'ms'
      doc: 'Ms'
    0x54:
      id: 'ct'
      doc: 'Ct'
    0x44:
      id: 'valid_settlement_date'
      doc: 'Valid Settlement Date'
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
    0x53:
      id: 'special_trading_session'
      doc: 'Special Trading Session'
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
  is_mid_only:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  is_dark:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  is_conditional:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'no_imbalance_exists'
      doc: 'No Imbalance Exists'
  market_order_imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'no_imbalance_exists'
      doc: 'No Imbalance Exists'

