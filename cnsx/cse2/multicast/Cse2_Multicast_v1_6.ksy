# ---------------------------------------------------------------------
# Kaitai struct definition for: Cnsx Cse2 Multicast Mmd v1.6
#
# Protocol:
#   Organization: Canadian Securities Exchange
#   Protocol: CSE2 Multicast Market Data Feed
#   Encoding: Multicast Market Data Feed
#   Version: 1.6
#   Date: 11/07/2025
#   Specification: CSE2_Multicast_Market_Data_Programmers_Guide_1.6.pdf
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
  id: cnsx_cse2_multicast_mmd_v1_6
  title: Cnsx Cse2 Multicast Mmd v1.6
  license: GPL-3.0
  endian: be

doc: 'Canadian Securities Exchange CSE2 CSE2 Multicast Market Data Feed Mmd v1.6'
doc-ref: https://thecse.com/trading/market-data/

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Prefix of a block of messages, carrying the unique information to identify and route them'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: block_header.block_number_of_messages
    doc: 'Cnsx Mmd sub message: a two byte sub header and a payload the message type selects'

types:
  block_header_struct:
    seq:
      - id: block_length
        type: u2
        doc: 'Length of entire block of messages including this header'
      - id: block_number_of_messages
        type: u1
        doc: 'Number of messages to follow this header'
      - id: block_start_sequence
        type: u4
        doc: 'Sequence of first message to follow this header'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Two byte sub header prefixing every message, carrying its length and its type'
      - id: payload
        size: message_header.sub_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::time_message': time_message
            'message_type::system_event_message': system_event_message
            'message_type::symbol_directory_message': symbol_directory_message
            'message_type::symbol_dynamics_message': symbol_dynamics_message
            'message_type::trading_action_message': trading_action_message
            'message_type::add_order_message': add_order_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::trade_message': trade_message
            'message_type::broken_trade_message': broken_trade_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_replace_message': order_replace_message
            'message_type::best_bid_offer_message': best_bid_offer_message
            'message_type::closing_price_message': closing_price_message
            'message_type::general_message': general_message
  message_header:
    seq:
      - id: sub_length
        type: u1
        doc: 'Message length including this field. The exchange may append fields to a message, so this and not a table total bounds it'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Message type'
  time_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Number of seconds since midnight (Eastern Time) of the first day of the system cycle. Seconds since Midnight epoch'
      - id: millisecond
        type: u2
        doc: 'Millisecond portion of the time when this time message was generated'
  system_event_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: group
        type: u8
        doc: 'ID for symbol grouping. 0: System Level event'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event Code (see System Event Codes)'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  symbol_directory_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: cusip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'CUSIP code'
      - id: sec_name
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short security name'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: stock_group
        type: u8
        enum: stock_group
        doc: 'Stock Group'
      - id: listing
        type: yyyymmdd_date_nullable
        doc: 'YYYYMMDD. 0 represents no listing date. Nullable, None = 0'
      - id: expiry
        type: yyyymmdd_date_nullable
        doc: 'YYYYMMDD. 0 represents no expiry date. Nullable, None = 0'
      - id: lot_size
        type: u4
        doc: 'Lot size for the Symbol. Based on Reference price, lot size will be calculated at Start of Day'
      - id: settlement_term
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Override Settlement Term. "T" = Cash Today (T+0), "N" = Non-Net, "R" = Non-Resident, or a Special Settlement Date in YYYYMMDD format. Left blank " " if default settlement'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'Listing market of the security'
      - id: previous_closing_price
        type: decimal_u4_4
        doc: 'Adjusted previous closing price. Implied decimal with scale 1e-4'
      - id: listing_tier
        type: u1
        enum: listing_tier
        doc: 'Listing tier of the security'
      - id: market_maker_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Maker name'
      - id: market_maker_phone_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Maker phone number'
      - id: full_sec_name
        type: str
        size: 75
        encoding: ASCII
        pad-right: 0x20
        doc: 'Long security name'
  symbol_dynamics_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: settlement_term
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Override Settlement Term. "T" = Cash Today (T+0), "N" = Non-Net, "R" = Non-Resident, or a Special Settlement Date in YYYYMMDD format. Left blank " " if default settlement'
      - id: gmf_setting
        type: u1
        enum: gmf_setting
        doc: '"Y" for GMF enabled, "N" for GMF disabled'
      - id: gmf_volume
        type: u8
        doc: 'Volume of GMF order'
      - id: anonymous_setting
        type: u1
        enum: anonymous_setting
        doc: '"Y" for Anonymous enabled, "N" for Anonymous disabled'
      - id: moc_eligible
        type: u1
        enum: moc_eligible
        doc: '"N" = Not MOC Eligible'
  trading_action_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Current trading state for symbol (see Trading Action)'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  add_order_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: order_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique reference number assigned to the new order'
      - id: order_verb
        type: u1
        enum: order_verb
        doc: '"B" Buy, "S" Sell'
      - id: quantity
        type: u4
        doc: 'Total quantity of the order being added to the book'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
        type: decimal_u4_4
        doc: 'Price of the new order. Implied decimal with scale 1e-4'
      - id: firm_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '3 digit integer FirmId. "001" means anonymous'
      - id: settlement_term
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Override Settlement Term. "T" = Cash Today (T+0), "N" = Non-Net, "R" = Non-Resident, or a Special Settlement Date in YYYYMMDD format. Left blank " " if default settlement'
      - id: odd_lot_flag
        type: u1
        enum: odd_lot_flag
        doc: '"Y" = Odd lot order, "N" = Not an odd lot'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
      - id: priority_timestamp
        type: millisecond_timestamp
        doc: 'Priority timestamp. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  order_executed_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: order_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique reference number assigned to the new order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares executed'
      - id: match_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique match identifier'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  order_executed_with_price_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: order_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique reference number assigned to the new order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares executed'
      - id: match_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique match identifier'
      - id: execution_price
        type: decimal_u4_4
        doc: 'Price at which the execution occurred. Implied decimal with scale 1e-4'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares executed'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: execution_price
        type: decimal_u4_4
        doc: 'Price at which the execution occurred. Implied decimal with scale 1e-4'
      - id: match_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique match identifier'
      - id: firm_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '3 digit integer FirmId. "001" means anonymous'
      - id: contra_firm_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '3 digit integer FirmId. "001" means anonymous'
      - id: settlement_term
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Override Settlement Term. "T" = Cash Today (T+0), "N" = Non-Net, "R" = Non-Resident, or a Special Settlement Date in YYYYMMDD format. Left blank " " if default settlement'
      - id: trade_attribute
        type: u1
        enum: trade_attribute
        doc: '"B" for ByPass order, " " default'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type of cross the trade resulted from'
      - id: odd_lot_flag
        type: u1
        enum: odd_lot_flag
        doc: '"Y" = Odd lot order, "N" = Not an odd lot'
      - id: sets_the_last_price
        type: u1
        enum: sets_the_last_price
        doc: '"Y" = Last sale, "N" = Not last sale'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
      - id: opening_trade
        type: u1
        enum: opening_trade
        doc: '"Y" = Opening Trade, "N" = Not Opening Trade'
      - id: ccp_session_trade
        type: u1
        enum: ccp_session_trade
        doc: '"Y" = CCP Session Trade, "N" = Not CCP Session Trade'
      - id: moc_trade_marker
        type: u1
        enum: moc_trade_marker
        doc: 'To indicate which trades are MOC or LOC trades. "Y" = MOC or LOC trade, "N" = Not MOC or LOC trade'
  broken_trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: match_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique match identifier'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason the trade was broken (see Broken Trade Reasons)'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  order_delete_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: order_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique reference number assigned to the new order'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  order_replace_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: order_number
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique reference number assigned to the new order'
      - id: quantity
        type: u4
        doc: 'Total quantity of the order being added to the book'
      - id: price
        type: decimal_u4_4
        doc: 'Price of the new order. Implied decimal with scale 1e-4'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  best_bid_offer_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: best_bid
        type: decimal_u4_4
        doc: 'Best buy price. Implied decimal with scale 1e-4'
      - id: best_bid_size
        type: u4
        doc: 'Total quantity at the best buy price'
      - id: best_offer
        type: decimal_u4_4
        doc: 'Best sell price. Implied decimal with scale 1e-4'
      - id: best_offer_size
        type: u4
        doc: 'Total quantity at the best sell price'
      - id: exchange_timestamp
        type: millisecond_timestamp
        doc: 'Official exchange time. Milliseconds since EPOCH (Jan 1, 0:0:0, 1970). Milliseconds since Unix epoch'
  closing_price_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
        type: decimal_u4_4
        doc: 'Price of the new order. Implied decimal with scale 1e-4'
  general_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanoseconds since last Timestamp-Seconds message. Nanoseconds since Second epoch'
      - id: message_text
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Message Text'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
  millisecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000
  yyyymmdd_date:
    seq:
      - id: packed
        type: s8
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x54:
      id: 'time_message'
      doc: 'Anchors the feed clock. Every following message states its own time as nanoseconds elapsed since this message.'
    0x53:
      id: 'system_event_message'
      doc: 'Signals a market or data feed handler event, either for the system as a whole or for one symbol group.'
    0x52:
      id: 'symbol_directory_message'
      doc: 'Static properties of a symbol. Sent for every symbol in the morning, and again during the day if a symbol changes.'
    0x4f:
      id: 'symbol_dynamics_message'
      doc: 'Values and rules for a symbol that can be updated intra-day. Sent for every symbol in the morning, and again during the day if a symbol changes.'
    0x48:
      id: 'trading_action_message'
      doc: 'Current trading state for a symbol. A symbol suspended intra-day with "V" is unsuspended with "N".'
    0x41:
      id: 'add_order_message'
      doc: 'A new order added to the displayed book.'
    0x45:
      id: 'order_executed_message'
      doc: 'An order on the book executed in whole or in part at the price it was displayed at.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'An order on the book executed in whole or in part at a price other than the one it was displayed at.'
    0x50:
      id: 'trade_message'
      doc: 'A trade that does not change the displayed book, carrying the full attribution and classification of the execution.'
    0x42:
      id: 'broken_trade_message'
      doc: 'A previously transmitted execution that has been broken, naming the match number it cancels.'
    0x44:
      id: 'order_delete_message'
      doc: 'An order cancelled and removed from the displayed book.'
    0x55:
      id: 'order_replace_message'
      doc: 'An order on the book replaced with a new quantity and price, keeping its order number.'
    0x51:
      id: 'best_bid_offer_message'
      doc: 'The best bid and offer for a symbol with the quantity at each. During an auction with an indicative price set, the indicative price overwrites both sides.'
    0x46:
      id: 'closing_price_message'
      doc: 'The closing price for a symbol.'
    0x47:
      id: 'general_message'
      doc: 'Free text bulletin from the exchange.'
  event_code:
    0x4f:
      id: 'start_of_messages_the_first_message_is_sent'
      doc: 'Start Of Messages The First Message Is Sent'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x48:
      id: 'trading_halted_orders_can_be_cancelled_but_no_new_orders_can_be_entered'
      doc: 'Trading Halted Orders Can Be Cancelled But No New Orders Can Be Entered'
    0x51:
      id: 'start_of_market_hours_the_pre_open_auction_is_concluded_and_continuous_trading_begins'
      doc: 'Start Of Market Hours The Pre Open Auction Is Concluded And Continuous Trading Begins'
    0x4d:
      id: 'end_of_market_hours_indicates_the_end_of_continuous_trading'
      doc: 'End Of Market Hours Indicates The End Of Continuous Trading'
    0x45:
      id: 'end_of_system_hours_indicates_the_exchange_is_closed'
      doc: 'End Of System Hours Indicates The Exchange Is Closed'
    0x43:
      id: 'end_of_messages_the_last_message_sent'
      doc: 'End Of Messages The Last Message Sent'
    0x5a:
      id: 'failover_event'
      doc: 'Failover Event'
  stock_group:
    1:
      id: 'cse_listed_securities'
      doc: 'Stock Group.'
    2:
      id: 'other_canadian_listed_securities'
      doc: 'Stock Group.'
  listing_market:
    0x43:
      id: 'cse'
      doc: 'Cse'
    0x54:
      id: 'tse'
      doc: 'Tse'
    0x56:
      id: 'tsxv'
      doc: 'Tsxv'
    0x41:
      id: 'alpha'
      doc: 'Alpha'
    0x4e:
      id: 'cboe_canada'
      doc: 'Cboe Canada'
  listing_tier:
    0:
      id: 'no_tier'
      doc: 'No Tier'
    1:
      id: 'senior_tier'
      doc: 'Senior Tier'
    2:
      id: 'venture_tier'
      doc: 'Venture Tier'
  gmf_setting:
    0x59:
      id: 'gmf_enabled'
      doc: 'Gmf Enabled'
    0x4e:
      id: 'gmf_disabled'
      doc: 'Gmf Disabled'
  anonymous_setting:
    0x59:
      id: 'anonymous_enabled'
      doc: 'Anonymous Enabled'
    0x4e:
      id: 'anonymous_disabled'
      doc: 'Anonymous Disabled'
  moc_eligible:
    0x4e:
      id: 'not_moc_eligible'
      doc: 'Not Moc Eligible'
  trading_state:
    0x4e:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x56:
      id: 'suspend_trading'
      doc: 'Suspend Trading'
    0x48:
      id: 'halt'
      doc: 'Halt'
  order_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  odd_lot_flag:
    0x59:
      id: 'odd_lot_order'
      doc: 'Odd Lot Order'
    0x4e:
      id: 'not_an_odd_lot'
      doc: 'Not An Odd Lot'
  trade_attribute:
    0x42:
      id: 'by_pass_order'
      doc: 'By Pass Order'
    0x20:
      id: 'default_field'
      doc: 'Default'
  cross_type:
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x56:
      id: 'vwap'
      doc: 'Vwap'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
    0x20:
      id: 'otherwise_empty_string_not_specified'
      doc: 'Otherwise Empty String Not Specified'
    0x53:
      id: 'ccp_closing_price'
      doc: 'Ccp Closing Price'
    0x4e:
      id: 'net_asset_value_nav'
      doc: 'Net Asset Value Nav'
  sets_the_last_price:
    0x59:
      id: 'last_sale'
      doc: 'Last Sale'
    0x4e:
      id: 'not_last_sale'
      doc: 'Not Last Sale'
  opening_trade:
    0x59:
      id: 'opening_trade'
      doc: 'Opening Trade'
    0x4e:
      id: 'not_opening_trade'
      doc: 'Not Opening Trade'
  ccp_session_trade:
    0x59:
      id: 'ccp_session_trade'
      doc: 'Ccp Session Trade'
    0x4e:
      id: 'not_ccp_session_trade'
      doc: 'Not Ccp Session Trade'
  moc_trade_marker:
    0x59:
      id: 'moc_or_loc_trade'
      doc: 'Moc Or Loc Trade'
    0x4e:
      id: 'not_moc_or_loc_trade'
      doc: 'Not Moc Or Loc Trade'
  reason:
    0x53:
      id: 'supervisory_the_trade_was_manually_broken_by_the_exchange'
      doc: 'Supervisory The Trade Was Manually Broken By The Exchange'
    0x41:
      id: 'amended'
      doc: 'Amended'

