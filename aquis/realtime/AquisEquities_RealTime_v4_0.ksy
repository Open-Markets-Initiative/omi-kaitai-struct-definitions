# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis RealTime Amd v4.0
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Real Time Market Data Feed
#   Encoding: Aquis Market Data Protocol
#   Version: 4.0
#   Date: 8/15/2025
#   Specification: Aquis Market Data Technical Specification v4.0.pdf
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
  id: aquis_aquisequities_realtime_amd_v4_0
  title: Aquis RealTime Amd v4.0
  license: GPL-3.0
  endian: le

doc: 'Aquis Exchange Aquis Equities Real Time Market Data Feed Amd v4.0'
doc-ref: https://www.aquis.eu/markets/documents

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Aquis udp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count
    doc: 'Aquis Amd Message'

types:
  packet_header_struct:
    seq:
      - id: message_count
        type: u1
        doc: 'number of messages (n) in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Aquis market data message header'
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
            'msg_type::aod_update_message': aod_update_message
            'msg_type::mac_update_message': mac_update_message
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
        doc: 'Unique order reference number for the day. Nullable, No Value = 0'
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
        doc: 'Flag to indicate whether there is unrestricted liquidity available at the top of the book. For order messages: Refers to the side indicated in the order. For trade messages: Refers to the passive side of the trade'
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
        doc: 'Unique order reference number for the day. Nullable, No Value = 0'
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
        doc: 'Unique order reference number for the day. Nullable, No Value = 0'
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
        doc: 'Code identifying type of trade (see below)'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: order_ref
        type: u4_nullable
        doc: 'Unique order reference number for the day. Nullable, No Value = 0'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
      - id: binary_mmt
        type: binary_mmt
        doc: 'Post-trade regulatory flags (MMT)'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  binary_mmt:
    meta:
      bit-endian: le
    seq:
      - id: market_mechanism
        type: b3
        doc: 'Market mechanism'
      - id: trading_mode
        type: b4
        doc: 'Trading mode'
      - id: transaction_category
        type: b3
        doc: 'Transaction category'
      - id: negotiation_indicator_or_pre_trade_transparency_waiver
        type: b3
        doc: 'Negotiation indicator or pre-trade transparency waiver'
      - id: crossing_trade
        type: b1
        doc: 'Crossing trade'
      - id: modification_indicator
        type: b2
        doc: 'Modification indicator'
      - id: benchmark_reference_price_indicator
        type: b2
        doc: 'Benchmark or reference price indicator'
      - id: dividend
        type: b1
        doc: 'Dividend'
      - id: off_book_automation
        type: b2
        doc: 'Off book automation'
      - id: price_formation_discovery_process
        type: b3
        doc: 'Price formation or discovery process'
      - id: algorithmic_indicator
        type: b1
        doc: 'Algorithmic indicator'
      - id: publication_mode_post_trade_deferral
        type: b3
        doc: 'Publication mode or post-trade deferral'
      - id: deferral_type
        type: b1
        doc: 'Deferral type'
      - id: duplicative_indicator
        type: b1
        doc: 'Duplicative indicator'
      - id: unused_2
        type: b2
        doc: 'Spare'
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
      - id: binary_mmt
        type: binary_mmt
        doc: 'Post-trade regulatory flags (MMT)'
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
        doc: 'Uniform UMTF code for the security'
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
      - id: reserved
        type: str
        size: 20
        encoding: ASCII
        doc: 'Reserved'
      - id: lot_size_composite
        type: lot_size_composite
        doc: 'Lot size scaled at runtime by lotSizeDecimal'
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
      - id: unused_2
        type: b2
        doc: 'Spare'
      - id: avx_enabled
        type: b1
        doc: 'Security is enabled for AVM'
      - id: unused_8
        type: b8
        doc: 'Reserved'
  lot_size_composite:
    seq:
      - id: lot_size
        type: u8
        doc: 'Lot size for the security. This will always be set to 1,000,000,000 to represent a lot size of 1'
      - id: lot_size_decimal
        type: u1
        doc: 'Number of decimals implied in lotSize Will always be set to 9'
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
        doc: 'Market status flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
      - id: trading_phase
        type: u1
        enum: trading_phase
        doc: 'Trading phase of the security'
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
      doc: 'If a trade has been declared erroneous by Aquis then a Trade Bust message is published.'
    7:
      id: 'tick_table_data_message'
      doc: 'A series of Tick Table Data messages are published pre-market to specify the dynamic tick tables and static ticks that apply to the securities traded on Aquis.'
    8:
      id: 'security_definition_message'
      doc: 'A series of Security Definition messages are published pre-market to identify the securities traded on Aquis (those relevant to the particular feed e.g. Euronext securities).'
    9:
      id: 'security_status_message'
      doc: 'The Security Status message is published when the trading status of a security changes or when there is a change to the status of the market on Aquis to which the security belongs.'
    17:
      id: 'aod_update_message'
      doc: 'During the AoD this message is used to publish the indicative price and indicative matched volume.'
    16:
      id: 'mac_update_message'
      doc: 'During the MaC this message is used to publish the indicative price from the buy and sell order totals.'
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
      doc: 'Market at Close (MaC) trade'
    4:
      id: 'lis_cross_trade'
      doc: 'LIS Cross trade'
    5:
      id: 'benchmark_cross_trade'
      doc: 'Benchmark Cross trade'
    6:
      id: 'auction_on_demand_trade'
      doc: 'Auction on Demand (AoD) trade'
    12:
      id: 'aquis_vwap_match_trade'
      doc: 'Aquis VWAP Match (AVM) trade'
  market_mechanism:
    1:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    2:
      id: 'quote_driven_market'
      doc: 'Quote Driven Market'
    3:
      id: 'dark_order_book'
      doc: 'Dark Order Book'
    4:
      id: 'off_book'
      doc: 'Off Book'
    5:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    6:
      id: 'rfq'
      doc: 'Rfq'
    7:
      id: 'other'
      doc: 'Other'
  trading_mode:
    1:
      id: 'undefined_auction'
      doc: 'Undefined Auction'
    2:
      id: 'opening_auction'
      doc: 'Opening Auction'
    3:
      id: 'closing_auction'
      doc: 'Closing Auction'
    4:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
    5:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
    6:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    7:
      id: 'at_market_close'
      doc: 'At Market Close'
    8:
      id: 'out_of_main_session'
      doc: 'Out Of Main Session'
    9:
      id: 'on_exchange_trade_reporting'
      doc: 'On Exchange Trade Reporting'
    10:
      id: 'off_exchange_trade_reporting'
      doc: 'Off Exchange Trade Reporting'
    11:
      id: 'systematic_internalizer_trade_reporting'
      doc: 'Systematic Internalizer Trade Reporting'
  transaction_category:
    1:
      id: 'dark_trade'
      doc: 'Dark Trade'
    2:
      id: 'trade_that_has_received_price_improvement'
      doc: 'Trade That Has Received Price Improvement'
    3:
      id: 'package_trade'
      doc: 'Package Trade'
    4:
      id: 'exchange_for_physicals'
      doc: 'Exchange For Physicals'
    5:
      id: 'none_apply'
      doc: 'None Apply'
  negotiation_indicator_or_pre_trade_transparency_waiver:
    0:
      id: 'negotiated_trade'
      doc: 'Negotiated Trade'
    1:
      id: 'negotiated_trade_in_liquid_instruments'
      doc: 'Negotiated Trade In Liquid Instruments'
    2:
      id: 'negotiated_trade_in_illiquid_instruments'
      doc: 'Negotiated Trade In Illiquid Instruments'
    3:
      id: 'negotiated_trade_other_than_current_market_price'
      doc: 'Negotiated Trade Other Than Current Market Price'
    4:
      id: 'no_negotiated_trade'
      doc: 'No Negotiated Trade'
    5:
      id: 'si_illiquid_instruments'
      doc: 'Si Illiquid Instruments'
    6:
      id: 'si_above_standard_market_size'
      doc: 'Si Above Standard Market Size'
    7:
      id: 'ilqd_and_size'
      doc: 'Ilqd And Size'
  crossing_trade:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  modification_indicator:
    1:
      id: 'trade_cancelation'
      doc: 'Trade Cancelation'
    2:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    3:
      id: 'new_trade'
      doc: 'New Trade'
  benchmark_reference_price_indicator:
    1:
      id: 'benchmark_trade'
      doc: 'Benchmark Trade'
    2:
      id: 'reference_price_trade'
      doc: 'Reference Price Trade'
    3:
      id: 'no_benchmark_or_ref_price'
      doc: 'No Benchmark Or Ref Price'
  dividend:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  off_book_automation:
    1:
      id: 'unspecified'
      doc: 'Unspecified'
    2:
      id: 'off_book_non_automated'
      doc: 'Off Book Non Automated'
    3:
      id: 'off_book_automated'
      doc: 'Off Book Automated'
  price_formation_discovery_process:
    1:
      id: 'plain_vanilla'
      doc: 'Plain Vanilla'
    2:
      id: 'non_price_forming'
      doc: 'Non Price Forming'
    3:
      id: 'trade_not_contributing_to_price_discovery'
      doc: 'Trade Not Contributing To Price Discovery'
    4:
      id: 'price_not_currently_available_but_pending'
      doc: 'Price Not Currently Available But Pending'
  algorithmic_indicator:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  publication_mode_post_trade_deferral:
    1:
      id: 'immediate_publication'
      doc: 'Immediate Publication'
    2:
      id: 'non_immediate_publication'
      doc: 'Non Immediate Publication'
    3:
      id: 'lrgs'
      doc: 'LRGS (Large in Scale)'
    4:
      id: 'ilqd'
      doc: 'ILQD (Illiquid Instrument)'
    5:
      id: 'size'
      doc: 'SIZE (Size Specific)'
    6:
      id: 'ilqd_and_size'
      doc: 'Ilqd And Size'
    7:
      id: 'ilqd_and_lrgs'
      doc: 'Ilqd And Lrgs'
  deferral_type:
    0:
      id: 'none_apply'
      doc: 'None Apply'
  duplicative_indicator:
    0:
      id: 'unique'
      doc: 'Unique'
    1:
      id: 'duplicative'
      doc: 'Duplicative'
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
      doc: 'MaC is closed'
    1:
      id: 'mac_is_open'
      doc: 'MaC is open'
  mac_run:
    0:
      id: 'mac_is_not_locked_down'
      doc: 'MaC is not locked down'
    1:
      id: 'mac_is_locked_down'
      doc: 'MaC is locked down'
  trading_phase:
    0:
      id: 'closed'
      doc: 'Closed'
    1:
      id: 'continuous'
      doc: 'Continuous'

