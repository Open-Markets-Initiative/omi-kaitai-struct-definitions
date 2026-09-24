# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxEquities SummaryDepth Pitch v1.0.4
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Summary Depth
#   Encoding: Pitch
#   Version: 1.0.4
#   Date: 7/26/2021
#   Specification: Cboe_US_Equities_Summary_Depth_Feed_Specification.pdf
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
  id: cboe_bzxequities_summarydepth_pitch_v1_0_4
  title: Cboe BzxEquities SummaryDepth Pitch v1.0.4
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Bzx Equities Summary Depth Pitch v1.0.4'
doc-ref: http://markets.cboe.com/us/equities/support/technical

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
            'message_type::clear_quote_message': clear_quote_message
            'message_type::cboe_market_status_message': cboe_market_status_message
            'message_type::adap_message': adap_message
            'message_type::rpi_message': rpi_message
            'message_type::trade_message': trade_message
            'message_type::trade_break_message': trade_break_message
            'message_type::trading_status_message': trading_status_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  clear_quote_message:
    seq:
      - id: last_update_timestamp
        type: u8
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe Summary Depth server''s cache'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  cboe_market_status_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp of when the Market Status changed, encoded as the number of nanoseconds since midnight'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: market_status
        type: u1
        enum: market_status
        doc: 'Market Status'
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator'
  adap_message:
    seq:
      - id: last_update_timestamp
        type: u8
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe Summary Depth server''s cache'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: adap_flags
        type: adap_flags
        doc: 'Adap Flags'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: num_adap_block
        type: u1
        doc: 'Number of ADAP Blocks to follow'
      - id: adap_block
        type: adap_block
        repeat: expr
        repeat-expr: num_adap_block
        doc: 'Adap Block'
  adap_flags:
    meta:
      bit-endian: le
    seq:
      - id: clear
        type: b1
        doc: 'Update ADAP Blocks to follow'
      - id: complete
        type: b1
        doc: 'Update ADAP Blocks to follow'
      - id: block_type
        type: b1
        doc: 'Update ADAP Blocks to follow'
      - id: unused_5
        type: b5
        doc: 'Reserved 2-7 Bits'
  adap_block:
    seq:
      - id: adap_block_size
        type: u1
        doc: 'Size of each ADAP Block'
      - id: adap_update
        type:
          switch-on: adap_block_size
          cases:
            10: short_update_adap_block
            18: long_update_adap_block
  short_update_adap_block:
    seq:
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side'
      - id: price_short
        type: decimal_u4_4
        doc: 'Price level to add/update in the ADAP book. Implied decimal with scale 1e-4'
      - id: quantity_short
        type: u4
        doc: 'Quantity of shares at this price level in the ADAP book'
  long_update_adap_block:
    seq:
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side'
      - id: price_long
        type: decimal_u8_4
        doc: 'Price level to add/update in the ADAP book. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u8
        doc: 'Quantity of shares at this price level in the ADAP book'
  rpi_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp of when the Market Status changed, encoded as the number of nanoseconds since midnight'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: retail_price_improvement
        type: u1
        enum: retail_price_improvement
        doc: 'Retail Price Improvement'
  trade_message:
    seq:
      - id: transaction_time
        type: u8
        doc: 'The time the trade occurred, encoded as the number of nanoseconds since midnight'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: execution_id
        type: u8
        doc: 'Execution identifier of this trade'
      - id: last_price
        type: decimal_u8_4
        doc: 'Last trade price. Implied decimal with scale 1e-4'
      - id: last_quantity
        type: u8
        doc: 'Last trade quantity'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today'
      - id: reserved_8
        type: u8
        doc: 'Reserved'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: lastsale_eligible
        type: b1
        doc: 'last-sale eligible'
      - id: unused_6
        type: b6
        doc: 'Reserved 2-7 Bits'
  trade_break_message:
    seq:
      - id: transaction_time
        type: u8
        doc: 'The time the trade occurred, encoded as the number of nanoseconds since midnight'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: execution_id
        type: u8
        doc: 'Execution identifier of this trade'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today'
      - id: reserved_8
        type: u8
        doc: 'Reserved'
      - id: trade_break_flags
        type: u1
        doc: 'Reserved'
  trading_status_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp of when the Market Status changed, encoded as the number of nanoseconds since midnight'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: halt_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Halt Status'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action'
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0xa2:
      id: 'clear_quote_message'
      doc: 'The Clear Quote message instructs feed recipients to clear all quotes and ADAP information for the specified symbol'
    0xa6:
      id: 'cboe_market_status_message'
      doc: 'The Cboe Market Status message is disseminated to reflect a change in the status of the market'
    0xa7:
      id: 'adap_message'
      doc: 'Each ADAP message delivers one or more updates for a Symbol''s ADAP book.'
    0xa8:
      id: 'rpi_message'
      doc: 'RPI Message'
    0xa9:
      id: 'trade_message'
      doc: 'Trade Message'
    0xaa:
      id: 'trade_break_message'
      doc: 'Trade Break Message'
    0xab:
      id: 'trading_status_message'
      doc: 'Trading Status Message'
  market_status:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x45:
      id: 'excluded_from_adap_updates'
      doc: 'Excluded From Adap Updates'
    0x49:
      id: 'incomplete'
      doc: 'Incomplete'
  session_indicator:
    0x52:
      id: 'regular_trading_session'
      doc: 'Regular Trading Session'
    0x50:
      id: 'pre_or_post_market_session'
      doc: 'Pre Or Post Market Session'
  retail_price_improvement:
    0x42:
      id: 'buy_side_rpi'
      doc: 'Buy Side Rpi'
    0x53:
      id: 'sell_side_rpi'
      doc: 'Sell Side Rpi'
    0x41:
      id: 'buy_and_sell_rpi'
      doc: 'Buy And Sell Rpi'
    0x4e:
      id: 'no_rpi'
      doc: 'No Rpi'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_price_test_restriction_in_effect'
      doc: 'Reg Sho Price Test Restriction In Effect'

