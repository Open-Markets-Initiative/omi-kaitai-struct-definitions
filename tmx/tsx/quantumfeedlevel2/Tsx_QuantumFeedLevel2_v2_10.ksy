# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Tsx QuantumFeedLevel2 Xmt v2.10
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Quantum Feed Level 2
#   Encoding: eXtreme Message Transfer
#   Version: 2.10
#   Date: 6/26/2014
#   Specification: Unknown
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
  id: tmx_tsx_quantumfeedlevel2_xmt_v2_10
  title: Tmx Tsx QuantumFeedLevel2 Xmt v2.10
  license: GPL-3.0
  endian: le

doc: 'TMX Group Toronto Stock Exchange Quantum Feed Level 2 Xmt v2.10'
doc-ref:
  - https://github.com/zkutch/xmt_protocol_parser
  - https://www.tmxwebstore.com/

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
            'msg_type::order_book_message': order_book_message
            'msg_type::order_book_terms_message': order_book_terms_message
            'msg_type::assign_cop_orders_message': assign_cop_orders_message
            'msg_type::assign_cop_no_orders_message': assign_cop_no_orders_message
            'msg_type::assign_limit_message': assign_limit_message
            'msg_type::market_state_update_message': market_state_update_message
            'msg_type::moc_imbalance_message': moc_imbalance_message
            'msg_type::order_booked_message': order_booked_message
            'msg_type::order_booked_terms_message': order_booked_terms_message
            'msg_type::order_cancelled_message': order_cancelled_message
            'msg_type::order_cancelled_terms_message': order_cancelled_terms_message
            'msg_type::order_price_time_assigned_message': order_price_time_assigned_message
            'msg_type::order_price_time_assigned_terms_message': order_price_time_assigned_terms_message
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
        size: 9
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
      - id: last_sale
        type: decimal_u8_6_nullable
        doc: 'Last Sale Price Of A Stock. Implied decimal with scale 1e-6. Nullable, No Value = 0'
  order_book_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: priority_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'Time Stamp Assigned By The Trading Engine To Specify Time Priority Of An Order Orders Are Sequenced In The Order Book Based On Symbol Price And Priority Time Stamp. Microseconds since Unix epoch. Nullable, No Value = 0'
  order_book_terms_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: non_resident
        type: u1
        enum: non_resident
        doc: 'A Terms Marker Indicating That Trade Participant Is Not A Canadian Resident'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: settlement_date
        type: u4_nullable
        doc: 'Settlement Date Associated With The Order. Nullable, No Value = 0'
      - id: priority_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'Time Stamp Assigned By The Trading Engine To Specify Time Priority Of An Order Orders Are Sequenced In The Order Book Based On Symbol Price And Priority Time Stamp. Microseconds since Unix epoch. Nullable, No Value = 0'
  assign_cop_orders_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: calculated_opening_price
        type: decimal_u8_6_nullable
        doc: 'The Price At Which Orders Will Trade At The Open. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: cop_order
        type: cop_order
        repeat: expr
        repeat-expr: 15
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  cop_order:
    seq:
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
  assign_cop_no_orders_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: calculated_opening_price
        type: decimal_u8_6_nullable
        doc: 'The Price At Which Orders Will Trade At The Open. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  assign_limit_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: calculated_opening_price
        type: decimal_u8_6_nullable
        doc: 'The Price At Which Orders Will Trade At The Open. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: cop_limit
        type: cop_limit
        repeat: expr
        repeat-expr: 15
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  cop_limit:
    seq:
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
  market_state_update_message:
    seq:
      - id: market_state
        type: u1
        enum: market_state
        doc: 'Indicates The Current Market State'
      - id: stock_group
        type: u1_nullable
        doc: 'An Identifier Of The Stock Group. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  moc_imbalance_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'Marker To Indicate Which Side Has An Imbalance Volume For Market On Close'
      - id: imbalance_volume
        type: u4_nullable
        doc: 'Identifies The Volume Of Shares Of The Imbalance Side For Market On Close. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
      - id: imbalance_reference_price
        type: decimal_u8_6_nullable
        doc: 'The Price That Determines If A Given Limit Priced Market On Close Loc Order Can Contribute To The Moc Imbalance All Loc Orders That Are Priced Equal To Or More Aggressively Than This Price Will Contribute To The Moc Imbalance. Implied decimal with scale 1e-6. Nullable, No Value = 0'
  order_booked_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: priority_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'Time Stamp Assigned By The Trading Engine To Specify Time Priority Of An Order Orders Are Sequenced In The Order Book Based On Symbol Price And Priority Time Stamp. Microseconds since Unix epoch. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  order_booked_terms_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: non_resident
        type: u1
        enum: non_resident
        doc: 'A Terms Marker Indicating That Trade Participant Is Not A Canadian Resident'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: settlement_date
        type: u4_nullable
        doc: 'Settlement Date Associated With The Order. Nullable, No Value = 0'
      - id: priority_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'Time Stamp Assigned By The Trading Engine To Specify Time Priority Of An Order Orders Are Sequenced In The Order Book Based On Symbol Price And Priority Time Stamp. Microseconds since Unix epoch. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  order_cancelled_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  order_cancelled_terms_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  order_price_time_assigned_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: priority_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'Time Stamp Assigned By The Trading Engine To Specify Time Priority Of An Order Orders Are Sequenced In The Order Book Based On Symbol Price And Priority Time Stamp. Microseconds since Unix epoch. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  order_price_time_assigned_terms_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization. Nullable, No Value = 0'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Market Side Of An Order'
      - id: order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To An Order By The Trading System. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: priority_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'Time Stamp Assigned By The Trading Engine To Specify Time Priority Of An Order Orders Are Sequenced In The Order Book Based On Symbol Price And Priority Time Stamp. Microseconds since Unix epoch. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  stock_status_message:
    seq:
      - id: symbol
        type: str
        size: 9
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
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  trade_report_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: buy_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization Associated With A Buy Order. Nullable, No Value = 0'
      - id: buy_order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To The Buy Order By The Trading System. Nullable, No Value = 0'
      - id: buy_display_volume
        type: u4_nullable
        doc: 'Public Remaining Display Volume For The Buy Order. Nullable, No Value = 0'
      - id: sell_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Number Uniquely Identifying A Partici Pating Organization Associated With A Sell Order. Nullable, No Value = 0'
      - id: sell_order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To A Sell Order By The Trading System. Nullable, No Value = 0'
      - id: sell_display_volume
        type: u4_nullable
        doc: 'Public Remaining Volume For The Sell Order. Nullable, No Value = 0'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An Indicator For Bypass Crosses Which Can Be Printed Outside Of The Protected Nbbo And Are Not Subject To Cross Interference'
      - id: trade_time_stamp
        type: hhmmss_time_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  trade_report_terms_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: buy_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization Associated With A Buy Order. Nullable, No Value = 0'
      - id: buy_order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To The Buy Order By The Trading System. Nullable, No Value = 0'
      - id: buy_display_volume
        type: u4_nullable
        doc: 'Public Remaining Display Volume For The Buy Order. Nullable, No Value = 0'
      - id: sell_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Number Uniquely Identifying A Partici Pating Organization Associated With A Sell Order. Nullable, No Value = 0'
      - id: sell_order_id
        type: u8_nullable
        doc: 'Public Numeric Identifier Assigned To A Sell Order By The Trading System. Nullable, No Value = 0'
      - id: sell_display_volume
        type: u4_nullable
        doc: 'Public Remaining Volume For The Sell Order. Nullable, No Value = 0'
      - id: trade_time_stamp
        type: hhmmss_time_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: non_resident
        type: u1
        enum: non_resident
        doc: 'A Terms Marker Indicating That Trade Participant Is Not A Canadian Resident'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: settlement_date
        type: u4_nullable
        doc: 'Settlement Date Associated With The Order. Nullable, No Value = 0'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  trade_cancelled_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  trade_cancelled_terms_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  trade_correction_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: buy_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization Associated With A Buy Order. Nullable, No Value = 0'
      - id: sell_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Number Uniquely Identifying A Partici Pating Organization Associated With A Sell Order. Nullable, No Value = 0'
      - id: initiated_by
        type: u1
        enum: initiated_by
        doc: 'Indicates Which Side Began The Trade Correction'
      - id: orig_trade_number
        type: u4_nullable
        doc: 'Used With Trade Corrections To Reference Previously Reported Executions. Nullable, No Value = 0'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An Indicator For Bypass Crosses Which Can Be Printed Outside Of The Protected Nbbo And Are Not Subject To Cross Interference'
      - id: trade_time_stamp
        type: hhmmss_time_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
  trade_correction_terms_message:
    seq:
      - id: symbol
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Unique Alphanumeric Identifier For A Security'
      - id: trade_number
        type: u4_nullable
        doc: 'A Unique Identifier Per Stock Assigned To Each Trade. Nullable, No Value = 0'
      - id: price
        type: decimal_u8_6_nullable
        doc: 'The Price In A Valid Currency. Implied decimal with scale 1e-6. Nullable, No Value = 0'
      - id: volume
        type: u4_nullable
        doc: 'The Quantity Of Shares For An Order Or Trade. Nullable, No Value = 0'
      - id: buy_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Public Number Uniquely Identifying A Partici Pating Organization Associated With A Buy Order. Nullable, No Value = 0'
      - id: sell_broker_number
        type: u2_nullable
        doc: 'An Exchange Assigned Number Uniquely Identifying A Partici Pating Organization Associated With A Sell Order. Nullable, No Value = 0'
      - id: initiated_by
        type: u1
        enum: initiated_by
        doc: 'Indicates Which Side Began The Trade Correction'
      - id: orig_trade_number
        type: u4_nullable
        doc: 'Used With Trade Corrections To Reference Previously Reported Executions. Nullable, No Value = 0'
      - id: trade_time_stamp
        type: hhmmss_time_nullable
        doc: 'The Time At Which The Trade Occurred Manually Set When A Trade Is Added. Nullable, No Value = 0'
      - id: non_resident
        type: u1
        enum: non_resident
        doc: 'A Terms Marker Indicating That Trade Participant Is Not A Canadian Resident'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement Terms Associated With The Order'
      - id: settlement_date
        type: u4_nullable
        doc: 'Settlement Date Associated With The Order. Nullable, No Value = 0'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Crosses Originating From A Participating Organization Between Managed Accounts That Have The Same Manager'
      - id: trading_system_time_stamp
        type: microsecond_timestamp_nullable
        doc: 'The Time At Which The Event Being Reported Occurred In The Trading Engine. Microseconds since Unix epoch. Nullable, No Value = 0'
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
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0
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
  microsecond_timestamp_nullable:
    seq:
      - id: value
        type: microsecond_timestamp
    instances:
      is_null:
        value: value.time == 0
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
      doc: 'Symbol Status messages contain information regarding equity, debenture, or trading Instruments for the current trading day for both TSX and TSXV markets. One message is disseminated for each valid symbol at the beginning of each trading day.'
    0x47:
      id: 'order_book_message'
      doc: 'An Order Book message provides public information for all open non-terms orders in the market at the start of day. One message is disseminated for each valid non-terms order at the beginning of each trading day. Feed clients can use the Order Book message to initialize their order book for the current trading day.'
    0x6a:
      id: 'order_book_terms_message'
      doc: 'An Order Book – Terms message provides public information for all open terms orders in the market at the start of day. One message is disseminated for each valid non-terms order at the beginning of each trading day. Feed clients can use the Order Book – Terms message to initialize their order book for the current trading day.'
    0x41:
      id: 'assign_cop_orders_message'
      doc: 'An Assign COP – Orders message specifies the calculated opening price (COP) for a security and the participating orders that are priced at the COP. Each Assign COP – Orders message can contain up to 15 orders priced at COP, and the orders are positional. All the orders reported on a single Assign COP – Orders message always belong to the same market side. Note: This message is generated only if one or more orders are repriced to the COP.'
    0x42:
      id: 'assign_cop_no_orders_message'
      doc: 'An Assign COP – No Order message specifies the calculated opening price for a security when there are no orders that are to be repriced to the COP. Note: This message is generated only if the COP is changing, but no orders are being repriced to the COP.'
    0x43:
      id: 'assign_limit_message'
      doc: 'An Assign Limit message is disseminated when former better-priced-limit orders are reset to their true limits. Each Assign Limit message can contain up to 15 orders along with their prices, and the orders are positional. All the orders reported on a single Assign Limit message always belong to the same market side.'
    0x45:
      id: 'market_state_update_message'
      doc: 'A Market State Update message is disseminated each time a notice of a market state change or a trading session change is sent from the Trading Engine.'
    0x46:
      id: 'moc_imbalance_message'
      doc: 'A MOC Imbalance message is disseminated for every MOC-eligible stock. The MOC Imbalance message is disseminated once per MOC-eligible stock at the beginning of the MOC Imbalance trading session.'
    0x50:
      id: 'order_booked_message'
      doc: 'An Order Booked message is disseminated in response to a new non-terms order being entered into the trading system.'
    0x6d:
      id: 'order_booked_terms_message'
      doc: 'An Order Booked - Terms message is disseminated in response to a new terms order being entered into the trading system.'
    0x51:
      id: 'order_cancelled_message'
      doc: 'An Order Cancelled message is disseminated if a non-terms order is cancelled.'
    0x6e:
      id: 'order_cancelled_terms_message'
      doc: 'An Order Cancelled – Terms message is disseminated if a terms order is cancelled.'
    0x52:
      id: 'order_price_time_assigned_message'
      doc: 'An Order Price-Time Assigned message is disseminated when a new Price or Time is assigned to a non-terms order.'
    0x6f:
      id: 'order_price_time_assigned_terms_message'
      doc: 'An Order Price-Time Assigned – Terms message is disseminated if a new Price or Time is assigned to a terms order.'
    0x49:
      id: 'stock_status_message'
      doc: 'A Stock Status notification is disseminated in response to a change in stock status from the Trading Engine.'
    0x53:
      id: 'trade_report_message'
      doc: 'A Trade Report is generated when a trade occurs that has no settlement terms.'
    0x70:
      id: 'trade_report_terms_message'
      doc: 'A Trade Report – Terms is generated when a trade occurs that has settlement terms.'
    0x54:
      id: 'trade_cancelled_message'
      doc: 'A Trade Cancelled message is generated when a trade with no settlement terms is cancelled.'
    0x71:
      id: 'trade_cancelled_terms_message'
      doc: 'A Trade Cancelled – Terms message is generated when a trade with settlement terms is cancelled.'
    0x55:
      id: 'trade_correction_message'
      doc: 'A Trade Correction message is generated when a trade with no settlement terms is corrected'
    0x72:
      id: 'trade_correction_terms_message'
      doc: 'A Trade Correction – Terms message is generated when a trade with settlement terms is corrected.'
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
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  non_resident:
    0x59:
      id: 'yes_field'
      doc: 'Participant Is Not A Canadian Resident'
    0x4e:
      id: 'no_field'
      doc: 'Participant Is A Canadian Resident'
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
  market_state:
    0x50:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'open'
      doc: 'Open'
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
    0x4e:
      id: 'extended_hours_cxls'
      doc: 'Extended Hours Cxls'
    0x52:
      id: 'extended_hours_open'
      doc: 'Extended Hours Open'
    0x46:
      id: 'extended_hours_close'
      doc: 'Extended Hours Close'
    0x43:
      id: 'closed'
      doc: 'Closed'
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
  bypass:
    0x59:
      id: 'the_order_is_a_bypass'
      doc: 'The Order Is A Bypass'
    0x4e:
      id: 'the_order_is_not_a_bypass'
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
      doc: 'Tsx Only'
    0x53:
      id: 'special_trading_session'
      doc: 'Tsx Only'
    0x56:
      id: 'volume_weighted_average_price'
      doc: 'Tsx Only'
  initiated_by:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x43:
      id: 'both'
      doc: 'Both'

