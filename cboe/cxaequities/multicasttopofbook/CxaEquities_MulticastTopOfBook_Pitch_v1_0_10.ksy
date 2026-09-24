# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CxaEquities MulticastTopOfBook Pitch v1.0.10
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Top Of Book
#   Encoding: Pitch
#   Version: 1.0.10
#   Date: 03/21/2025
#   Specification: CXA_Multicast_TOP_Specification.pdf
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
  id: cboe_cxaequities_multicasttopofbook_pitch_v1_0_10
  title: Cboe CxaEquities MulticastTopOfBook Pitch v1.0.10
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Australia Multicast Top Of Book Pitch v1.0.10'
doc-ref: https://www.cboe.com/market_data_services/document_library

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Hdr Count messages to follow'
      - id: count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::unit_clear_message': unit_clear_message
            'message_type::trading_status_message': trading_status_message
            'message_type::single_side_update_message': single_side_update_message
            'message_type::two_side_update_message': two_side_update_message
            'message_type::top_trade_message': top_trade_message
            'message_type::calculated_value_message': calculated_value_message
            'message_type::end_of_session_message': end_of_session_message
            'message_type::auction_update_message': auction_update_message
            'message_type::auction_summary_message': auction_summary_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  unit_clear_message:
    seq:
      - id: reserved_4
        type: u4
        doc: 'Reserved (undefined)'
  trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status of the session for the symbol'
      - id: market_id_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code (right padded with spaces)'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  single_side_update_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the update'
      - id: price
        type: decimal_u8_7
        doc: 'Price of the update. Implied decimal with scale 1e-7'
      - id: quantity
        type: u4
        doc: 'Number of shares on the inside book. May be zero if only undisclosed orders exist on the inside book'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  two_side_update_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: bid_price
        type: decimal_u8_7
        doc: 'Bid price. Implied decimal with scale 1e-7'
      - id: bid_quantity
        type: u4
        doc: 'Number of shares on the bid side of the inside book. May be zero if only undisclosed orders exist on the inside book'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
      - id: ask_price
        type: decimal_u8_7
        doc: 'Ask price. Implied decimal with scale 1e-7'
      - id: ask_quantity
        type: u4
        doc: 'Number of shares on the ask side of the inside book. May be zero if only undisclosed orders exist on the inside book'
      - id: second_reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  top_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: quantity
        type: u4
        doc: 'Number of shares on the inside book. May be zero if only undisclosed orders exist on the inside book'
      - id: price
        type: decimal_u8_7
        doc: 'Price of the update. Implied decimal with scale 1e-7'
      - id: execution_id
        type: u8
        doc: 'CXA generated day-unique execution identifier of this trade. Execution Id is also referenced in trade breaks'
      - id: total_volume
        type: u4
        doc: 'Total number of shares executed on the CXA book, or off-exchange reported trades, for the symbol on the current business day (may decrease if the Flags field indicates a trade break)'
      - id: pid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID (right padded with spaces). Blank (spaces) if not attributed'
      - id: contra_pid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contra Participant ID (right padded with spaces). Blank (spaces) if not attributed'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade type'
      - id: trade_designation
        type: u1
        enum: trade_designation
        doc: 'Trade designation. Valid only for on-exchange executions, space otherwise'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type. Valid only for off-exchange trade reports, space otherwise'
      - id: trade_transaction_time
        type: u8
        doc: 'Nanosecond timestamp of the off-exchange trade as specified in the Trade Report submitted by the trading participant. Valid only for off-exchange trade reports, zero otherwise'
      - id: flags
        type: flags
        doc: 'Trade flags'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: trade_break
        type: b1
        doc: '0 = Normal trade, 1 = Trade break'
      - id: trade_from_converted_order
        type: b1
        doc: '0 = Normal trade, 1 = Trade from converted order'
      - id: unused_6
        type: b6
        doc: 'Unused'
  calculated_value_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: value_category
        type: u1
        enum: value_category
        doc: 'Category of the calculated value'
      - id: value_field
        type: decimal_u8_7
        doc: 'The calculated value. Implied decimal with scale 1e-7'
      - id: value_timestamp
        type: u8
        doc: 'Timestamp when the calculated value was generated in nanoseconds since epoch'
  end_of_session_message:
    seq:
      - id: reserved_4
        type: u4
        doc: 'Reserved (undefined)'
  auction_update_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type'
      - id: buy_shares
        type: u4
        doc: 'Number of shares on buy side eligible to trade at the auction indicative price'
      - id: sell_shares
        type: u4
        doc: 'Number of shares on sell side eligible to trade at the auction indicative price'
      - id: indicative_price
        type: decimal_u8_7
        doc: 'Indicative Auction Price at which the continuous book would match. Implied decimal with scale 1e-7'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  auction_summary_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type'
      - id: price
        type: decimal_u8_7
        doc: 'Price of the update. Implied decimal with scale 1e-7'
      - id: shares
        type: u4
        doc: 'Cumulative number of shares executed during the auction'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
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
  decimal_u8_7:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000000.0

enums:
  message_type:
    0x97:
      id: 'unit_clear_message'
      doc: 'Instructs feed recipients to clear all data for the CXA book in the unit specified in the Sequenced Unit Header. Distributed in rare recovery events such as a datacentre fail-over.'
    0x3b:
      id: 'trading_status_message'
      doc: 'Indicates the current trading status of a security. A Trading Status message will be sent whenever trading status changes for a security.'
    0xe4:
      id: 'single_side_update_message'
      doc: 'Provides an updated price and size for a single side of a Symbol. The side is denoted by the Side field. One Single Side Update message may reflect one or more updates to the inside book that were processed at the same time but will only be done so in a way that can be arbitrated between A/B feeds.'
    0xe5:
      id: 'two_side_update_message'
      doc: 'Provides an updated price and size for both sides of a Symbol. One Two Side Update message may reflect one or more updates to the inside book that were processed at the same time but will only be done so in a way that can be arbitrated between A/B feeds.'
    0xe6:
      id: 'top_trade_message'
      doc: 'Provides information about executions of orders on the CXA book or executions that occur off-exchange and reported to CXA. TOP Trade messages for on-exchange electronic executions are necessary to calculate CXA execution-based data. TOP Trade messages do not alter the book. A TOP Trade message is also sent whenever an execution or trade report is broken with the Flags field value indicating trade break.'
    0xe3:
      id: 'calculated_value_message'
      doc: 'Sent when CXA calculates market values for a specified symbol or when a calculated market value is reported to CXA. The specified symbol may not trade on CXA, but instead could represent index or iNAV values reported to CXA from third parties as indicated by the Value Category field. The index values will be reported on each of the unitised CXA TOP feeds and are not specific to an individual unit. Calculated Value messages will be included in a spin response.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'Sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
    0x95:
      id: 'auction_update_message'
      doc: 'Sent during Pre-Open and Pre-Close trading states when a symbol has an order update which relates to an overlapping order book (where the best bid price is greater than or equal to the best ask price). Includes the potential number of shares and the indicative auction price if the symbol were to undergo an auction now. Only sent if there are updates to the Buy Shares, Sell Shares, or Indicative Price fields.'
    0x96:
      id: 'auction_summary_message'
      doc: 'Sent at the completion of the Auction per symbol and includes the Auction Price and Shares traded. If there is no overlapping order book at the time of the auction, no auction trades will result, however the Auction Summary message will still be disseminated and contain zeroes in the Price and Shares fields.'
  trading_status:
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x41:
      id: 'premarket'
      doc: 'Premarket'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x4d:
      id: 'moc_trading'
      doc: 'Moc Trading'
    0x50:
      id: 'postmarket'
      doc: 'Postmarket'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x53:
      id: 'trading_suspended'
      doc: 'Trading Suspended'
    0x4f:
      id: 'pre_open'
      doc: 'Pre Open'
    0x45:
      id: 'pre_close'
      doc: 'Pre Close'
  side:
    0x42:
      id: 'bid_side'
      doc: 'Bid Side'
    0x53:
      id: 'ask_side'
      doc: 'Ask Side'
  trade_type:
    0x42:
      id: 'broker_preferred_trade'
      doc: 'Broker Preferred Trade'
    0x4e:
      id: 'trade_resulting_from_normal_matching_logic'
      doc: 'Trade Resulting From Normal Matching Logic'
    0x4f:
      id: 'opening_auction_trade_or_intraday_auction_trade'
      doc: 'Opening Auction Trade Or Intraday Auction Trade'
    0x43:
      id: 'closing_auction_trade'
      doc: 'Closing Auction Trade'
    0x48:
      id: 'halt_auction_re_opening'
      doc: 'Halt Auction Re Opening'
    0x20:
      id: 'offexchange_trade_report'
      doc: 'Offexchange Trade Report'
  trade_designation:
    0x43:
      id: 'cxac_limit'
      doc: 'Cxac Limit'
    0x50:
      id: 'cxap_mid_point'
      doc: 'Cxap Mid Point'
    0x4e:
      id: 'cxan_near_point'
      doc: 'Cxan Near Point'
    0x46:
      id: 'cxaf_far_point'
      doc: 'Cxaf Far Point'
    0x4d:
      id: 'cxam_moc'
      doc: 'Cxam Moc'
    0x20:
      id: 'not_applicable_offexchange'
      doc: 'Not Applicable Offexchange'
  trade_report_type:
    0x42:
      id: 'block_trade'
      doc: 'Block Trade'
    0x50:
      id: 'large_portfolio_trade'
      doc: 'Large Portfolio Trade'
    0x54:
      id: 'large_principal_transaction'
      doc: 'Large Principal Transaction'
    0x53:
      id: 'trades_with_price_improvement'
      doc: 'Trades With Price Improvement'
    0x4c:
      id: 'permitted_trade_during_post_trading_hours_period'
      doc: 'Permitted Trade During Post Trading Hours Period'
    0x4d:
      id: 'permitted_trade_during_pre_trading_hours_period'
      doc: 'Permitted Trade During Pre Trading Hours Period'
    0x45:
      id: 'out_of_hours_trade'
      doc: 'Out Of Hours Trade'
    0x46:
      id: 'etf_trade_report_for_unit_creations_or_redemptions'
      doc: 'Etf Trade Report For Unit Creations Or Redemptions'
    0x20:
      id: 'not_applicable_onexchange'
      doc: 'Not Applicable Onexchange'
  value_category:
    0x31:
      id: 'closing_price'
      doc: 'Closing Price'
    0x32:
      id: 'i_nav_values_etf'
      doc: 'I Nav Values Etf'
    0x33:
      id: 'index_values'
      doc: 'Index Values'
    0x34:
      id: 'eod_nav_from_issuer'
      doc: 'Eod Nav From Issuer'
  auction_type:
    0x4f:
      id: 'opening_intraday_auction'
      doc: 'Opening Intraday Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x48:
      id: 'halt_auction_re_opening'
      doc: 'Halt Auction Re Opening'

