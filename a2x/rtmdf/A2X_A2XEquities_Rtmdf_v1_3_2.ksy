# ---------------------------------------------------------------------
# Kaitai struct definition for: A2X A2XEquities Rtmdf Amd v1.3.2
#
# Protocol:
#   Organization: A2X Markets
#   Protocol: Real Time Market Data Feed
#   Encoding: A2X Market Data
#   Version: 1.3.2
#   Date: 9/15/2022
#   Specification: A2X712-Market-Data-Techincal-Specification-v1.3.2.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: a2x_a2xequities_rtmdf_amd_v1_3_2
  title: A2X A2XEquities Rtmdf Amd v1.3.2
  license: GPL-3.0
  endian: be

doc: 'A2X Markets A2X Equities Real Time Market Data Feed Amd v1.3.2'
doc-ref: https://www.a2x.co.za/?page_id=531

seq:
  - id: num_message
    type: u1
    doc: 'number of messages in this packet'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: num_message

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
            'msg_type::auction_on_demand_message': auction_on_demand_message
            'msg_type::market_at_close': market_at_close
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
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: side
        type: u1
        enum: side
        doc: 'Order Side'
      - id: quantity
        type: u4le
        doc: 'Number of shares being added to the book'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Order reference number'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
  order_cancel_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: order_ref
        type: u4le
        doc: 'Order reference number'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
  order_modify_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: quantity
        type: u4le
        doc: 'Number of shares being added to the book'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Order reference number'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
  trade_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Code identifying type of trade (see below)'
      - id: quantity
        type: u4le
        doc: 'Number of shares being added to the book'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Order reference number'
      - id: trade_ref
        type: u4le
        doc: 'Trade reference number'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
  trade_bust_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: quantity
        type: u4le
        doc: 'Number of shares being added to the book'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: trade_ref
        type: u4le
        doc: 'Trade reference number'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
  tick_table_data_message:
    seq:
      - id: tick_table_id
        type: u1
        doc: 'Numeric identifier for this tick table or'
      - id: name
        type: str
        size: 10
        encoding: ASCII
        doc: 'Short name'
      - id: threshold
        type: u8le
        doc: 'The price threshold at which this tick'
      - id: tick_size
        type: u8le
        doc: 'The tick size (price increment)'
  security_definition_message:
    seq:
      - id: security_id
        type: u2le
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
        doc: 'Numeric identifier for this tick table or'
      - id: security_flags
        type: security_flags
        doc: 'Security Flags'
  security_flags:
    seq:
      - id: unused_10
        type: b10
        doc: 'Reserved for future use'
      - id: aod_enabled
        type: b1
        doc: 'Security is not enabled for the AoD'
      - id: unused_1
        type: b1
        doc: 'Reserved for future use'
      - id: illiquid
        type: b1
        doc: 'Security is illiquid'
      - id: test_stock
        type: b2
        doc: 'Test Stock'
      - id: mac_enabled
        type: b1
        doc: 'Mac Enabled'
  security_status_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: market_flags
        type: market_flags
        doc: 'Market Flagss'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
  market_flags:
    seq:
      - id: unused_5
        type: b5
        doc: 'Reserved for future use'
      - id: mac_run
        type: b1
        doc: 'Locked'
      - id: mac_open
        type: b1
        doc: 'Open'
      - id: trading
        type: b1
        doc: 'Continuous Trading'
  auction_on_demand_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: indicative_price
        type: u8le
        doc: 'Indicative auction price'
      - id: match_vol
        type: u4le
        doc: 'Indicative matched volume'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
  market_at_close:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: indicative_price
        type: u8le
        doc: 'Indicative auction price'
      - id: closing_buy_qty
        type: u4le
        doc: 'Total order quantity on the buy side during'
      - id: closing_sell_qty
        type: u4le
        doc: 'Total order quantity on the sell side during'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'

enums:
  msg_type:
    1:
      id: 'heartbeat_message'
      doc: 'The Heartbeat message carries no data'
    2:
      id: 'order_add_message'
      doc: 'The Order Add message is published when order quantity is posted to the order book for a particular security'
    3:
      id: 'order_cancel_message'
      doc: 'The Order Cancel message is published when a visible order is removed from the book'
    4:
      id: 'order_modify_message'
      doc: 'The Order Modify message is published when a visible order is modified by the client'
    5:
      id: 'trade_message'
      doc: 'Whenever an order trades, partially or fully, a Trade message is published'
    6:
      id: 'trade_bust_message'
      doc: 'If a trade has been declared erroneous by A2X then a Trade Bust message is published'
    7:
      id: 'tick_table_data_message'
      doc: 'A series of Tick Table Data messages are published pre-market to specify the dynamic tick tables and static ticks that apply to the securities traded on A2X'
    8:
      id: 'security_definition_message'
      doc: 'A series of Security Definition messages are published pre-market to identify the securities traded on A2X'
    9:
      id: 'security_status_message'
      doc: 'The Security Status message is published when the trading status of a security changes or when there is a change to the status of the market on A2X to which the security belongs'
    17:
      id: 'auction_on_demand_message'
      doc: 'During the AoD this message is used to publish the indicative price and indicative matched volume'
    16:
      id: 'market_at_close'
      doc: 'During the MaC this message is used to publish the indicative price from the buy and sell order totals'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  trade_type:
    1:
      id: 'visible'
      doc: 'A Trade Against Visible Order Quantity In The Continuous Trading Order Book'
    2:
      id: 'hidden_or_reserve'
      doc: 'A Trade Against Hidden Or Reserve Quantity In The Continuous Trading Order Book'
    3:
      id: 'market_at_close'
      doc: 'Market At Close'
    4:
      id: 'large_in_scale_cross'
      doc: 'Large In Scale Cross'
    5:
      id: 'benchmark_cross'
      doc: 'Benchmark Cross'
    6:
      id: 'auction_on_demand'
      doc: 'Auction On Demand'
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
      doc: 'Aod Start'
    24:
      id: 'aod_end'
      doc: 'Aod End'

