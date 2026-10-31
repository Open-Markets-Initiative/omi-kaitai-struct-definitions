# ---------------------------------------------------------------------
# Kaitai struct definition for: A2X Rtmdf Amd v2.5
#
# Protocol:
#   Organization: A2X Markets
#   Protocol: Real Time Market Data Feed
#   Encoding: A2X Market Data
#   Version: 2.5
#   Date: 8/1/2026
#   Specification: A2X Market Data Technical Specification v2.5.pdf
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
  id: a2x_a2xequities_rtmdf_amd_v2_5
  title: A2X Rtmdf Amd v2.5
  license: GPL-3.0
  endian: le

doc: 'A2X Markets A2X Equities Real Time Market Data Feed Amd v2.5'
doc-ref: https://www.a2x.co.za/?page_id=531

seq:
  - id: num_message
    type: u1
    doc: 'number of messages in this packet'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: num_message
    doc: 'A2X Amd Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'A2X message header'
      - id: payload
        size: message_header.msg_length - 6
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::order_add_message': order_add_message
            'msg_type::order_cancel_message': order_cancel_message
            'msg_type::order_modify_message': order_modify_message
            'msg_type::trade_message': trade_message
            'msg_type::trade_bust_message': trade_bust_message
            'msg_type::tick_table_data_message': tick_table_data_message
            'msg_type::security_definition_message': security_definition_message
            'msg_type::security_status_message': security_status_message
            'msg_type::mac_update_message': mac_update_message
            'msg_type::aod_update_message': aod_update_message
  message_header:
    seq:
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Message type identifier'
      - id: msg_length
        type: u1
        doc: 'Length of market data message, including header'
      - id: seq_no
        type: u4
        doc: 'Sequence number of this message in the market data stream for the current trading day'
  order_add_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: order_ref
        type: u4_nullable
        doc: 'Order reference number. Nullable, No Value = 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  md_flags:
    meta:
      bit-endian: le
    seq:
      - id: unrestricted_liquidity
        type: b1
        doc: 'Flag to indicate whether there is unrestricted liquidity available at the top of the book. For order messages: refers to the side indicated in the order'
      - id: unused_7
        type: b7
        doc: 'Reserved'
  order_cancel_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: order_ref
        type: u4_nullable
        doc: 'Order reference number. Nullable, No Value = 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  order_modify_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: order_ref
        type: u4_nullable
        doc: 'Order reference number. Nullable, No Value = 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  trade_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Code identifying type of trade'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: order_ref
        type: u4_nullable
        doc: 'Order reference number. Nullable, No Value = 0'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  trade_bust_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  tick_table_data_message:
    seq:
      - id: tick_table_id
        type: u1
        doc: 'Numeric identifier for this tick table or static tick'
      - id: name
        type: str
        size: 10
        encoding: ASCII
        doc: 'Short name'
      - id: threshold
        type: decimal_u8_5
        doc: 'The price threshold at which this tick data applies. Implied decimal with scale 1e-5'
      - id: tick_size
        type: decimal_u8_5
        doc: 'The tick size (price increment). Implied decimal with scale 1e-5'
  security_definition_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: umtf
        type: str
        size: 6
        encoding: ASCII
        doc: 'Uniform MTF code for the security'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'ISIN for the security'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trading currency for the security'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'MIC for the security''s market of listing'
      - id: tick_table_id
        type: u1
        doc: 'Numeric identifier for this tick table or static tick'
      - id: flags
        type: flags
        doc: 'Security flags'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: mac_enabled
        type: b1
        doc: 'Security is enabled for the MaC'
      - id: test_stock
        type: b1
        doc: 'Security is a test stock'
      - id: illiquid
        type: b1
        doc: 'Security is illiquid'
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: aod_enabled
        type: b1
        doc: 'Security is enabled for the AoD'
      - id: unused_11
        type: b11
        doc: 'Reserved'
  security_status_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status of the security'
      - id: market_flags
        type: market_flags
        doc: 'Market flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  market_flags:
    meta:
      bit-endian: le
    seq:
      - id: trading
        type: b1
        doc: 'Continuous trading open or closed'
      - id: mac_open
        type: b1
        doc: 'MaC open or closed'
      - id: mac_run
        type: b1
        doc: 'MaC locked down or not'
      - id: unused_5
        type: b5
        doc: 'Reserved'
  mac_update_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: indicative_price
        type: decimal_u8_5
        doc: 'Indicative auction price. Implied decimal with scale 1e-5'
      - id: closing_buy_qty
        type: u4_nullable
        doc: 'Total order quantity on the buy side during the closing market. Nullable, No Value = 0'
      - id: closing_sell_qty
        type: u4_nullable
        doc: 'Total order quantity on the sell side during the closing market. Nullable, No Value = 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  aod_update_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: indicative_price
        type: decimal_u8_5
        doc: 'Indicative auction price. Implied decimal with scale 1e-5'
      - id: match_vol
        type: u4
        doc: 'Indicative matched volume'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  decimal_u8_5:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000.0
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

enums:
  msg_type:
    1:
      id: 'heartbeat_message'
      doc: 'The Heartbeat message carries no data; it is simply a message header with msgType of 1.'
    2:
      id: 'order_add_message'
      doc: 'The Order Add message is published when order quantity is posted to the order book for a particular security.'
    3:
      id: 'order_cancel_message'
      doc: 'The Order Cancel message is published when a visible order is removed from the book.'
    4:
      id: 'order_modify_message'
      doc: 'The Order Modify message is published when a visible order is modified by the client (change of price and/or quantity).'
    5:
      id: 'trade_message'
      doc: 'Whenever an order trades, partially or fully, a Trade message is published.'
    6:
      id: 'trade_bust_message'
      doc: 'If a trade has been declared erroneous by A2X then a Trade Bust message is published.'
    7:
      id: 'tick_table_data_message'
      doc: 'A series of Tick Table Data messages are published pre-market to specify the dynamic tick tables and static ticks that apply to the securities traded on A2X.'
    8:
      id: 'security_definition_message'
      doc: 'A series of Security Definition messages are published pre-market to identify the securities traded on A2X (those relevant to the particular feed).'
    9:
      id: 'security_status_message'
      doc: 'The Security Status message is published when the trading status of a security changes or when there is a change to the status of the market on A2X to which the security belongs.'
    16:
      id: 'mac_update_message'
      doc: 'During the MaC this message is used to publish the indicative price from the buy and sell order totals.'
    17:
      id: 'aod_update_message'
      doc: 'During the AoD this message is used to publish the indicative price and indicative matched volume.'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  unrestricted_liquidity:
    0:
      id: 'restricted_liquidity_only'
      doc: 'Restricted Liquidity Only'
    1:
      id: 'unrestricted_liquidity_available'
      doc: 'Unrestricted Liquidity Available'
  trade_type:
    1:
      id: 'visible'
      doc: 'A trade against visible order quantity in the continuous trading order book'
    2:
      id: 'hidden_or_reserve'
      doc: 'A trade against hidden or reserve quantity in the continuous trading order book'
    3:
      id: 'market_at_close_trade'
      doc: 'Market at Close (MaC) Trade'
    4:
      id: 'large_in_scale_cross_trade'
      doc: 'Large In Scale (LIS) Cross Trade'
    5:
      id: 'benchmark_cross_trade'
      doc: 'Benchmark Cross Trade'
    6:
      id: 'auction_on_demand_trade'
      doc: 'Auction on Demand (AoD) Trade'
  trading_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'halted'
      doc: 'Halted'
    3:
      id: 'suspended'
      doc: 'Suspended'
    8:
      id: 'aod_start'
      doc: 'AoD Start'
    24:
      id: 'aod_end'
      doc: 'AoD End'
  trading:
    0:
      id: 'continuous_trading_closed'
      doc: 'Continuous Trading Closed'
    1:
      id: 'continuous_trading_open'
      doc: 'Continuous Trading Open'
  mac_open:
    0:
      id: 'mac_is_closed'
      doc: 'MaC is Closed'
    1:
      id: 'mac_is_open'
      doc: 'MaC is Open'
  mac_run:
    0:
      id: 'mac_is_not_locked_down'
      doc: 'MaC is not locked down'
    1:
      id: 'mac_is_locked_down'
      doc: 'MaC is locked down'

