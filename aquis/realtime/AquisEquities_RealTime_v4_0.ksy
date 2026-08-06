# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis AquisEquities RealTime Amd v4.0
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Real Time Market Data Feed
#   Encoding: Aquis Market Data Protocol
#   Version: 4.0
#   Date: 8/1/2025
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: aquisequities_realtime_v4_0
  title: Aquis AquisEquities RealTime Amd v4.0
  license: GPL-3.0
  endian: be

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
        doc: 'Number of messages in this packet'
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
            'msg_type::order_add': order_add
            'msg_type::order_cancel': order_cancel
            'msg_type::order_modify': order_modify
            'msg_type::trade': trade
            'msg_type::trade_bust_message': trade_bust_message
            'msg_type::tick_table_data_message': tick_table_data_message
            'msg_type::security_definition_message': security_definition_message
            'msg_type::security_status_message': security_status_message
            'msg_type::ao_d_update_message': ao_d_update_message
            'msg_type::ma_c_update_message': ma_c_update_message
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
  order_add:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: quantity
        type: u4le
        doc: 'Number of shares being added to the book'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Unique order reference number for the day'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  md_flags:
    seq:
      - id: unrestricted_liquidity_indicator
        type: b1
        doc: 'Indicates whether unrestricted liquidity is available at the top of the book'
      - id: reserved_7
        type: b7
        doc: 'Reserved'
  order_cancel:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: order_ref
        type: u4le
        doc: 'Unique order reference number for the day'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  order_modify:
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
        doc: 'Unique order reference number for the day'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  trade:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Code identifying type of trade'
      - id: quantity
        type: u4le
        doc: 'Number of shares being added to the book'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Unique order reference number for the day'
      - id: trade_ref
        type: u4le
        doc: 'Trade reference number'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
      - id: binary_mmt
        type: binary_mmt
        doc: 'Post-trade regulatory flags (MMT)'
      - id: md_flags
        type: md_flags
        doc: 'Market data flags'
  binary_mmt:
    seq:
      - id: market_mechanism
        type: b3
        enum: market_mechanism
        doc: 'Market mechanism'
      - id: trading_mode
        type: b4
        enum: trading_mode
        doc: 'Trading mode'
      - id: transaction_category
        type: b3
        enum: transaction_category
        doc: 'Transaction category'
      - id: negotiation_indicator_or_pre_trade_transparency_waiver
        type: b3
        enum: negotiation_indicator_or_pre_trade_transparency_waiver
        doc: 'Negotiation indicator or pre-trade transparency waiver'
      - id: crossing_trade
        type: b1
        enum: crossing_trade
        doc: 'Crossing trade'
      - id: modification_indicator
        type: b2
        enum: modification_indicator
        doc: 'Modification indicator'
      - id: benchmark_reference_price_indicator
        type: b2
        enum: benchmark_reference_price_indicator
        doc: 'Benchmark or reference price indicator'
      - id: dividend
        type: b1
        enum: dividend
        doc: 'Dividend'
      - id: off_book_automation
        type: b2
        enum: off_book_automation
        doc: 'Off book automation'
      - id: price_formation_discovery_process
        type: b3
        enum: price_formation_discovery_process
        doc: 'Price formation or discovery process'
      - id: algorithmic_indicator
        type: b1
        enum: algorithmic_indicator
        doc: 'Algorithmic indicator'
      - id: publication_mode_post_trade_deferral
        type: b3
        enum: publication_mode_post_trade_deferral
        doc: 'Publication mode or post-trade deferral'
      - id: deferral_type
        type: b1
        doc: 'Deferral type'
      - id: duplicative_indicator
        type: b1
        enum: duplicative_indicator
        doc: 'Duplicative indicator'
      - id: spare
        type: b2
        doc: 'Spare'
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
        type: u8le
        doc: 'The price threshold at which this tick data applies'
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
      - id: security_definition_flags
        type: security_definition_flags
        doc: 'Security definition flags'
      - id: reserved_char_2020
        type: str
        size: 20
        encoding: ASCII
        doc: 'Reserved'
      - id: lot_size
        type: u8le
        doc: 'Lot size for the security; always set to 1,000,000,000 to represent a lot size of 1'
      - id: lot_size_decimal
        type: u1
        doc: 'Number of decimals implied in lotSize; always set to 9'
  security_definition_flags:
    seq:
      - id: mac_enabled
        type: b1
        doc: '0 = Not enabled for MaC, 1 = Enabled for MaC'
      - id: test_stock
        type: b1
        doc: '0 = Not a test stock, 1 = Test stock'
      - id: illiquid
        type: b1
        doc: '0 = Liquid, 1 = Illiquid'
      - id: reserved_1
        type: b1
        doc: 'Reserved'
      - id: aod_enabled
        type: b1
        doc: '0 = Not enabled for AoD, 1 = Enabled for AoD'
      - id: reserved_2
        type: b2
        doc: 'Reserved'
      - id: avx_enabled
        type: b1
        doc: '0 = Not enabled for AVM, 1 = Enabled for AVM'
      - id: reserved_8
        type: b8
        doc: 'Reserved'
  security_status_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status of the security'
      - id: market_flags
        type: market_flags
        doc: 'Market status flags'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'
      - id: trading_phase
        type: u1
        enum: trading_phase
        doc: 'Trading phase of the security'
  market_flags:
    seq:
      - id: trading
        type: b1
        doc: 'Continuous trading status; 0 = Closed, 1 = Open'
      - id: mac_open
        type: b1
        doc: 'MaC status; 0 = Closed, 1 = Open'
      - id: mac_run
        type: b1
        doc: 'MaC lockdown status; 0 = Not locked down, 1 = Locked down'
      - id: reserved_5
        type: b5
        doc: 'Reserved'
  ao_d_update_message:
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
  ma_c_update_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: indicative_price
        type: u8le
        doc: 'Indicative auction price'
      - id: closing_buy_qty
        type: u4le
        doc: 'Total order quantity on the buy side during the closing market; otherwise set to 0'
      - id: closing_sell_qty
        type: u4le
        doc: 'Total order quantity on the sell side during the closing market; otherwise set to 0'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this market data event'

enums:
  msg_type:
    2:
      id: 'order_add'
      doc: 'The Order Add message is published when order quantity is posted to the order book for a particular security.'
    3:
      id: 'order_cancel'
      doc: 'Published when a visible order is removed from the book.'
    4:
      id: 'order_modify'
      doc: 'Published when a visible order is modified by the client.'
    5:
      id: 'trade'
      doc: 'Published whenever an order trades, partially or fully.'
    6:
      id: 'trade_bust_message'
      doc: 'Published when a trade has been declared erroneous by Aquis.'
    7:
      id: 'tick_table_data_message'
      doc: 'Published pre-market to specify dynamic tick tables and static ticks controlling valid price increments for securities on the order book.'
    8:
      id: 'security_definition_message'
      doc: 'Published pre-market to identify securities traded on Aquis, associating securityID with a particular security.'
    9:
      id: 'security_status_message'
      doc: 'Published when the trading status of a security or its market changes.'
    17:
      id: 'ao_d_update_message'
      doc: 'Published during AoD to provide the indicative price and matched volume.'
    16:
      id: 'ma_c_update_message'
      doc: 'During the MaC this message is used to publish the indicative price from the buy and sell order totals.'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  trade_type:
    1:
      id: 'visible_order'
      doc: 'Visible Order'
    2:
      id: 'hidden_order'
      doc: 'Hidden Order'
    3:
      id: 'market_at_close'
      doc: 'Market At Close'
    4:
      id: 'lis_cross'
      doc: 'Lis Cross'
    5:
      id: 'benchmark_cross'
      doc: 'Benchmark Cross'
    6:
      id: 'auction_on_demand'
      doc: 'Auction On Demand'
    12:
      id: 'aquis_vwap_match'
      doc: 'Aquis Vwap Match'
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
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
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
      id: 'no_benchmark_or_reference_price'
      doc: 'No Benchmark Or Reference Price'
  dividend:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
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
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
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
      doc: 'Lrgs'
    4:
      id: 'ilqd'
      doc: 'Ilqd'
    5:
      id: 'size'
      doc: 'Size'
    6:
      id: 'ilqd_and_size'
      doc: 'Ilqd And Size'
    7:
      id: 'ilqd_and_lrgs'
      doc: 'Ilqd And Lrgs'
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
      id: 'ao_d_start'
      doc: 'Ao D Start'
    24:
      id: 'ao_d_end'
      doc: 'Ao D End'
  trading_phase:
    0:
      id: 'closed'
      doc: 'Closed'
    1:
      id: 'continuous'
      doc: 'Continuous'

