# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe TitaniumConsolidated OneOptions Pitch v1.0.10
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: One Options
#   Encoding: Pitch
#   Version: 1.0.10
#   Date: 04/01/2026
#   Specification: Cboe_Options_One_Feed_Specification.pdf
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
  id: cboe_titaniumconsolidated_oneoptions_pitch_v1_0_10
  title: Cboe TitaniumConsolidated OneOptions Pitch v1.0.10
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Titanium Consolidated One Options Pitch v1.0.10'
doc-ref: http://markets.cboe.com/us/options/support/technical

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
            'message_type::short_symbol_summary_message': short_symbol_summary_message
            'message_type::long_symbol_summary_message': long_symbol_summary_message
            'message_type::best_quote_update_message': best_quote_update_message
            'message_type::cboe_market_status_message': cboe_market_status_message
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
  short_symbol_summary_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One Options server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: cboe_cumulative_executed_volume_short
        type: u4
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: consolidated_best_bid_price_short
        type: decimal_u4_4
        doc: 'Titanium Options best bid price. Implied decimal with scale 1e-4'
      - id: consolidated_best_bid_quantity_short
        type: u4
        doc: 'Titanium Options number of buy-side shares available for this symbol'
      - id: consolidated_best_ask_price_short
        type: decimal_u4_4
        doc: 'Titanium Options best ask price. Implied decimal with scale 1e-4'
      - id: consolidated_best_ask_quantity_short
        type: u4
        doc: 'Titanium Options number of sell-side shares available for this symbol'
      - id: reserved_5
        size: 5
        doc: 'Reserved'
  long_symbol_summary_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One Options server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: cboe_cumulative_executed_volume_long
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: consolidated_best_bid_price_long
        type: decimal_u8_4
        doc: 'Titanium Options best bid price. Implied decimal with scale 1e-4'
      - id: consolidated_best_bid_quantity_long
        type: u8
        doc: 'Titanium Options number of buy-side shares available for this symbol'
      - id: consolidated_best_ask_price_long
        type: decimal_u8_4
        doc: 'Titanium Options best ask price. Implied decimal with scale 1e-4'
      - id: consolidated_best_ask_quantity_long
        type: u8
        doc: 'Titanium Options number of sell-side shares available for this symbol'
      - id: reserved_9
        size: 9
        doc: 'Reserved'
  best_quote_update_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One Options server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side indicator'
      - id: consolidated_best_quote_price
        type: decimal_u8_4
        doc: 'Titanium Options best price. Implied decimal with scale 1e-4'
      - id: consolidated_quote_quantity
        type: u8
        doc: 'Titanium Options number of shares available for this symbol'
  cboe_market_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'Market Center identifier'
      - id: market_status
        type: u1
        enum: market_status
        doc: 'Market status indicator'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
  trade_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'Market Center identifier'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: last_price
        type: decimal_u8_4
        doc: 'Last trade price. Implied decimal with scale 1e-4'
      - id: last_quantity
        type: u8
        doc: 'Last trade quantity'
      - id: cboe_cumulative_executed_volume_long
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options trade condition code'
      - id: reserved_8
        size: 8
        doc: 'Reserved'
  trade_break_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'Market Center identifier'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: cboe_cumulative_executed_volume_long
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: reserved_9
        size: 9
        doc: 'Reserved'
  trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'Market Center identifier'
      - id: halt_status
        type: u1
        enum: halt_status
        doc: 'Trading halt status indicator'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
    0xa4:
      id: 'short_symbol_summary_message'
      doc: 'The Short Symbol Summary message delivers the Cboe consolidated best bid/offer and total executed volume across all applicable Cboe One Options books.'
    0xa3:
      id: 'long_symbol_summary_message'
      doc: 'The Long Symbol Summary message delivers the Cboe consolidated best bid/offer and total executed volume across all applicable Cboe One Options books.'
    0xa5:
      id: 'best_quote_update_message'
      doc: 'The Best Quote Update message is used to update one side of the Cboe consolidated quote information for a symbol. Since the message only updates one side of the quote, the previous value for the other side of the quote remains in effect. This message does not affect the executed volume of the symbol.'
    0xa6:
      id: 'cboe_market_status_message'
      doc: 'The Cboe Market Status message is disseminated to reflect a change in the status of a market. All markets should be assumed to be Normal unless otherwise indicated by a Cboe Market Status message.'
    0xa9:
      id: 'trade_message'
      doc: 'Trade messages are sent when an order is executed in whole or in part on a Cboe exchange.'
    0xaa:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on a Cboe exchange is broken. Trade breaks are rare and only affect applications that rely upon Cboe execution based data.'
    0xab:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of an options contract on a Cboe exchange.'
  side_indicator:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
  market_center:
    0x42:
      id: 'c_1'
      doc: 'C 1'
    0x57:
      id: 'c_2'
      doc: 'C 2'
    0x58:
      id: 'edgx'
      doc: 'Edgx'
    0x5a:
      id: 'bzx'
      doc: 'Bzx'
  market_status:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x45:
      id: 'excluded_from_symbol_summary_updates'
      doc: 'Excluded From Symbol Summary Updates'
    0x49:
      id: 'incomplete'
      doc: 'Incomplete'
  trade_condition:
    0x61:
      id: 'single_leg_auction_non_iso'
      doc: 'Single Leg Auction Non Iso'
    0x62:
      id: 'single_leg_auction_iso'
      doc: 'Single Leg Auction Iso'
    0x63:
      id: 'single_leg_cross_non_iso'
      doc: 'Single Leg Cross Non Iso'
    0x64:
      id: 'single_leg_cross_iso'
      doc: 'Single Leg Cross Iso'
    0x65:
      id: 'single_leg_floor_trade'
      doc: 'Single Leg Floor Trade'
    0x66:
      id: 'complex_to_complex_electronic_trade'
      doc: 'Complex To Complex Electronic Trade'
    0x67:
      id: 'complex_auction_trade'
      doc: 'Complex Auction Trade'
    0x68:
      id: 'complex_cross'
      doc: 'Complex Cross'
    0x69:
      id: 'complex_floor_trade'
      doc: 'Complex Floor Trade'
    0x6a:
      id: 'complex_electronic_trade_against_single_legs'
      doc: 'Complex Electronic Trade Against Single Legs'
    0x6b:
      id: 'complex_with_stock_options_auction_trade'
      doc: 'Complex With Stock Options Auction Trade'
    0x6d:
      id: 'complex_floor_trade_against_single_legs'
      doc: 'Complex Floor Trade Against Single Legs'
    0x6e:
      id: 'complex_with_stock_electronic_trade'
      doc: 'Complex With Stock Electronic Trade'
    0x6f:
      id: 'complex_with_stock_cross'
      doc: 'Complex With Stock Cross'
    0x70:
      id: 'complex_with_stock_floor_trade'
      doc: 'Complex With Stock Floor Trade'
    0x74:
      id: 'complex_floor_trade_of_proprietary_products_marked_as_combo_order'
      doc: 'Complex Floor Trade Of Proprietary Products Marked As Combo Order'
    0x75:
      id: 'multilateral_compression_trade_of_proprietary_products'
      doc: 'Multilateral Compression Trade Of Proprietary Products'
    0x76:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x6c:
      id: 'electronic_trade'
      doc: 'Electronic Trade'
    0x4b:
      id: 'cabinet_order'
      doc: 'Cabinet Order'
    0x4f:
      id: 'opening_trade'
      doc: 'Opening Trade'
    0x53:
      id: 'iso'
      doc: 'Iso'
  halt_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x52:
      id: 'opening_rotation'
      doc: 'Opening Rotation'
    0x54:
      id: 'trading'
      doc: 'Trading'

