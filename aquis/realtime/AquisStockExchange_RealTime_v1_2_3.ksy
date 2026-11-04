# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis RealTime Amd v1.2.3
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Real Time Market Data Feed
#   Encoding: Aquis Market Data Protocol
#   Version: 1.2.3
#   Date: 4/23/2024
#   Specification: Aquis Stock Exchange Multicast Market Data Specification v1.2.3 (2024).pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: aquis_aquisstockexchange_realtime_amd_v1_2_3
  title: Aquis RealTime Amd v1.2.3
  license: MIT-0
  endian: le

doc: 'Aquis Exchange Aquis Stock Exchange Real Time Market Data Feed Amd v1.2.3'
doc-ref: https://www.aquisexchange.com/aquis-stock-exchange

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
            'msg_type::quote_add_replace_message': quote_add_replace_message
            'msg_type::quote_cancel_message': quote_cancel_message
            'msg_type::trade_message': trade_message
            'msg_type::trade_report_message': trade_report_message
            'msg_type::trade_report_modify_message': trade_report_modify_message
            'msg_type::trade_report_cancel_message': trade_report_cancel_message
            'msg_type::trade_bust_message': trade_bust_message
            'msg_type::security_statistics_message': security_statistics_message
            'msg_type::trader_definition_message': trader_definition_message
            'msg_type::tick_table_data_message': tick_table_data_message
            'msg_type::security_definition_message': security_definition_message
            'msg_type::security_status_message': security_status_message
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
        doc: 'Unique order reference number for the day. Nullable, No Value = 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
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
  order_modify_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: remaining_quantity
        type: u4
        doc: 'Number of shares remaining in the book'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: order_ref
        type: u4_nullable
        doc: 'Unique order reference number for the day. Nullable, No Value = 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  quote_add_replace_message:
    seq:
      - id: trader_id
        type: u2
        doc: 'Numeric identifier of the market maker quoting'
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: bid_quantity
        type: u4
        doc: 'Number of available bid shares'
      - id: bid_price
        type: decimal_u8_5
        doc: 'The price of the bid shares. Implied decimal with scale 1e-5'
      - id: offer_quantity
        type: u4
        doc: 'Number of available offer shares'
      - id: offer_price
        type: decimal_u8_5
        doc: 'The price of the offer shares. Implied decimal with scale 1e-5'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  quote_cancel_message:
    seq:
      - id: trader_id
        type: u2
        doc: 'Numeric identifier of the market maker quoting'
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  trade_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Code identifying type of trade'
      - id: traded_quantity
        type: u4
        doc: 'Number of shares traded'
      - id: execution_price
        type: decimal_u8_5
        doc: 'The execution price. Implied decimal with scale 1e-5'
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
        doc: '4-byte field representing the applicable MMT flags on Trade messages'
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
  trade_report_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Code identifying type of trade'
      - id: traded_quantity
        type: u4
        doc: 'Number of shares traded'
      - id: execution_price
        type: decimal_u8_5
        doc: 'The execution price. Implied decimal with scale 1e-5'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: received_timestamp
        type: nanosecond_timestamp
        doc: 'System received timestamp. Nanoseconds since Unix epoch'
      - id: binary_mmt
        type: binary_mmt
        doc: '4-byte field representing the applicable MMT flags on Trade messages'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Date and time when the transaction occurred. Nanoseconds since Unix epoch'
  trade_report_modify_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Code identifying type of trade'
      - id: traded_quantity
        type: u4
        doc: 'Number of shares traded'
      - id: execution_price
        type: decimal_u8_5
        doc: 'The execution price. Implied decimal with scale 1e-5'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: received_timestamp
        type: nanosecond_timestamp
        doc: 'System received timestamp. Nanoseconds since Unix epoch'
      - id: binary_mmt
        type: binary_mmt
        doc: '4-byte field representing the applicable MMT flags on Trade messages'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Date and time when the transaction occurred. Nanoseconds since Unix epoch'
      - id: orig_trade_ref
        type: u4
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) reference number'
      - id: orig_timestamp
        type: nanosecond_timestamp
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) timestamp of market data event. Nanoseconds since Unix epoch'
  trade_report_cancel_message:
    seq:
      - id: orig_security_id
        type: u2
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) numeric identifier of the relevant security'
      - id: orig_trade_type
        type: u1
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) code identifying type of trade, see section 3.6.2 for values'
      - id: orig_quantity
        type: u4
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) number of shares traded'
      - id: orig_price
        type: decimal_u8_5
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) execution price. Implied decimal with scale 1e-5'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: received_timestamp
        type: nanosecond_timestamp
        doc: 'System received timestamp. Nanoseconds since Unix epoch'
      - id: binary_mmt
        type: binary_mmt
        doc: '4-byte field representing the applicable MMT flags on Trade messages'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Date and time when the transaction occurred. Nanoseconds since Unix epoch'
      - id: orig_trade_ref
        type: u4
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) reference number'
      - id: orig_timestamp
        type: nanosecond_timestamp
        doc: 'Previous accepted trade report message (not necessarily the initial trade report message) timestamp of market data event. Nanoseconds since Unix epoch'
      - id: orig_transact_time
        type: nanosecond_timestamp
        doc: 'Date and time when the original transaction occurred. Nanoseconds since Unix epoch'
  trade_bust_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: traded_quantity
        type: u4
        doc: 'Number of shares traded'
      - id: execution_price
        type: decimal_u8_5
        doc: 'The execution price. Implied decimal with scale 1e-5'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
      - id: binary_mmt
        type: binary_mmt
        doc: '4-byte field representing the applicable MMT flags on Trade messages'
  security_statistics_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: statistics_price
        type: decimal_u8_5
        doc: 'Price of security. Implied decimal with scale 1e-5'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Whether the price is the opening or the closing price'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this market data event. Nanoseconds since Unix epoch'
  trader_definition_message:
    seq:
      - id: trader_id
        type: u2
        doc: 'Numeric identifier of the market maker quoting'
      - id: sender_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'SenderID of the trader'
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
        doc: 'This field is not applicable to AQSE'
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
  market_flags:
    meta:
      bit-endian: le
    seq:
      - id: trading
        type: b1
        doc: 'Continuous trading open or closed, which also states whether AoD is available'
      - id: unused_2
        type: b2
        doc: 'Spare'
      - id: pre_open_close
        type: b1
        doc: 'Pre-open or pre-close market phase, read with the trading bit: pre-open when trading is closed, pre-close when it is open'
      - id: unused_4
        type: b4
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
      doc: 'The Order Add message is published when order quantity is posted to the order book for a particular security. This message is only applicable to continuous trading.'
    3:
      id: 'order_cancel_message'
      doc: 'The Order Cancel message is published when a visible order is removed from the book. This message is only applicable to continuous trading.'
    4:
      id: 'order_modify_message'
      doc: 'The Order Modify message is published when a visible order is modified by the client (change of price and/or quantity). The order reference number remains the same on order modification. This message is only applicable to continuous trading.'
    20:
      id: 'quote_add_replace_message'
      doc: 'The Quote Add/Replace message is published when a quote is available for a particular security.'
    21:
      id: 'quote_cancel_message'
      doc: 'The Quote Cancel message is published when a quote is removed for a particular security. The quote may have been cancelled by the trading Member or by the Aquis support team or the market may have closed.'
    5:
      id: 'trade_message'
      doc: 'Whenever an order trades, partially or fully, a Trade message is published.'
    25:
      id: 'trade_report_message'
      doc: 'Whenever a new trade report is submitted to AQSE, a Trade Report message is published.'
    26:
      id: 'trade_report_modify_message'
      doc: 'Whenever a previously published trade report is modified, a Trade Report Modify message is published. Members can modify trades for up to five business days from the day on which the trade was reported.'
    27:
      id: 'trade_report_cancel_message'
      doc: 'Whenever a previously published trade report is cancelled, a Trade Report Cancel message is published. Members can cancel trades for up to five business days from the day on which the trade was reported.'
    6:
      id: 'trade_bust_message'
      doc: 'If a trade has been declared erroneous by AQSE then a Trade Bust message is published. This message is only applicable to order generated trades.'
    22:
      id: 'security_statistics_message'
      doc: 'The Security Statistics message is published to disseminate the opening and closing prices of a security.'
    23:
      id: 'trader_definition_message'
      doc: 'A series of Trader Definition messages are published pre-market to identify the quote originators.'
    7:
      id: 'tick_table_data_message'
      doc: 'A series of Tick Table Data messages are published pre-market to specify the dynamic tick tables and static ticks that apply to the securities traded on AQSE.'
    8:
      id: 'security_definition_message'
      doc: 'A series of Security Definition messages are published pre-market to identify the securities traded on AQSE (those relevant to the particular feed e.g. Euronext securities).'
    9:
      id: 'security_status_message'
      doc: 'The Security Status message is published when the trading status of a security changes or when there is a change to the status of the market on AQSE to which the security belongs.'
    17:
      id: 'aod_update_message'
      doc: 'During the AoD this message is used to publish the indicative price and indicative matched volume. The first AoD update message signals the start of an auction.'
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
      doc: 'A trade against visible order quantity in the continuous trading order book'
    2:
      id: 'hidden_or_reserve'
      doc: 'A trade against hidden or reserve quantity in the continuous trading order book'
    6:
      id: 'auction_on_demand_trade'
      doc: 'Auction on Demand (AoD) trade'
    8:
      id: 'trade_capture_report_trade'
      doc: 'Trade Capture Report trade'
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
  price_type:
    2:
      id: 'opening_price'
      doc: 'Opening Price'
    5:
      id: 'closing_price'
      doc: 'Closing Price'
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
  trading:
    0:
      id: 'continuous_trading_closed'
      doc: 'Continuous Trading Closed (AoD unavailable)'
    1:
      id: 'continuous_trading_open'
      doc: 'Continuous Trading Open (AoD available)'
  pre_open_close:
    0:
      id: 'not_a_pre_phase'
      doc: 'Not a pre phase'
    1:
      id: 'pre_phase'
      doc: 'Pre phase'

