# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe TitaniumConsolidated MulticastOneEquities Pitch v1.4.13
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast One Equities
#   Encoding: Pitch
#   Version: 1.4.13
#   Date: 03/16/2026
#   Specification: Cboe_Equities_One_Feed_Specification.pdf
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
  id: cboe_titaniumconsolidated_multicastoneequities_pitch_v1_4_13
  title: Cboe TitaniumConsolidated MulticastOneEquities Pitch v1.4.13
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Titanium Consolidated Multicast One Equities Pitch v1.4.13'
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
            'message_type::expanded_clear_quote_message': expanded_clear_quote_message
            'message_type::fractional_symbol_summary_message': fractional_symbol_summary_message
            'message_type::expanded_fractional_symbol_summary_message': expanded_fractional_symbol_summary_message
            'message_type::best_quote_update_message': best_quote_update_message
            'message_type::expanded_best_quote_update_message': expanded_best_quote_update_message
            'message_type::cboe_market_status_message': cboe_market_status_message
            'message_type::adap_message': adap_message
            'message_type::expanded_adap_message': expanded_adap_message
            'message_type::rpi_message': rpi_message
            'message_type::fractional_trade_message': fractional_trade_message
            'message_type::expanded_fractional_trade_message': expanded_fractional_trade_message
            'message_type::fractional_trade_break_message': fractional_trade_break_message
            'message_type::expanded_fractional_trade_break_message': expanded_fractional_trade_break_message
            'message_type::trading_status_message': trading_status_message
            'message_type::expanded_trading_status_message': expanded_trading_status_message
            'message_type::opening_closing_price_message': opening_closing_price_message
            'message_type::expanded_opening_closing_price_message': expanded_opening_closing_price_message
            'message_type::fractional_end_of_day_summary_message': fractional_end_of_day_summary_message
            'message_type::expanded_fractional_end_of_day_summary_message': expanded_fractional_end_of_day_summary_message
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
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
  expanded_clear_quote_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
  fractional_symbol_summary_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: consolidated_best_bid_price
        type: decimal_u8_4
        doc: 'Titanium Equities best bid price. Implied decimal with scale 1e-4'
      - id: consolidated_best_bid_quantity
        type: u8
        doc: 'Titanium Equities number of buy-side shares available for this symbol'
      - id: consolidated_best_ask_price
        type: decimal_u8_4
        doc: 'Titanium Equities best ask price. Implied decimal with scale 1e-4'
      - id: consolidated_best_ask_quantity
        type: u8
        doc: 'Titanium Equities number of sell-side shares available for this symbol'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: fractional_symbol_summary_flags
        type: fractional_symbol_summary_flags
  fractional_symbol_summary_flags:
    meta:
      bit-endian: le
    seq:
      - id: national_volume_status
        type: b1
      - id: unused_7
        type: b7
  expanded_fractional_symbol_summary_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: consolidated_best_bid_price
        type: decimal_u8_4
        doc: 'Titanium Equities best bid price. Implied decimal with scale 1e-4'
      - id: consolidated_best_bid_quantity
        type: u8
        doc: 'Titanium Equities number of buy-side shares available for this symbol'
      - id: consolidated_best_ask_price
        type: decimal_u8_4
        doc: 'Titanium Equities best ask price. Implied decimal with scale 1e-4'
      - id: consolidated_best_ask_quantity
        type: u8
        doc: 'Titanium Equities number of sell-side shares available for this symbol'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: reserved_1
        type: u1
        doc: 'Reserved'
  best_quote_update_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side of the quote update'
      - id: consolidated_best_quote_price
        type: decimal_u8_4
        doc: 'Titanium Equities best price. Implied decimal with scale 1e-4'
      - id: consolidated_quote_quantity
        type: u8
        doc: 'Titanium Equities number of shares available for this symbol'
  expanded_best_quote_update_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side of the quote update'
      - id: consolidated_best_quote_price
        type: decimal_u8_4
        doc: 'Titanium Equities best price. Implied decimal with scale 1e-4'
      - id: consolidated_quote_quantity
        type: u8
        doc: 'Titanium Equities number of shares available for this symbol'
  cboe_market_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: market_status
        type: u1
        enum: market_status
        doc: 'Market status indicator'
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session indicator'
  adap_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: adap_flags
        type: adap_flags
      - id: reserved_1
        type: u1
        doc: 'Reserved'
      - id: num_adap_block
        type: u1
        doc: 'Number of ADAP Block messages to follow'
      - id: adap_block_size
        type: u1
        doc: 'Size of each ADAP Block message'
      - id: adap_block
        type: adap_block
        repeat: expr
        repeat-expr: num_adap_block
        doc: 'ADAP Block'
  adap_flags:
    meta:
      bit-endian: le
    seq:
      - id: clear_adap
        type: b1
      - id: adap_complete
        type: b1
      - id: short_long_blocks
        type: b1
      - id: unused_5
        type: b5
  adap_block:
    seq:
      - id: adap_update
        type:
          switch-on: _parent.adap_block_size
          cases:
            10: short_update_adap_block
            18: long_update_adap_block
  short_update_adap_block:
    seq:
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side indicator'
      - id: price_short
        type: decimal_u4_4
        doc: 'Price level to add/update for Market Center''s ADAP book. Implied decimal with scale 1e-4'
      - id: quantity_short
        type: u4
        doc: 'Quantity of shares at this price level in the Market Center''s ADAP book. A value of zero implies deletion of this ADAP level'
  long_update_adap_block:
    seq:
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side indicator'
      - id: price_long
        type: decimal_u8_4
        doc: 'Opening/Closing Price. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u8
        doc: 'Quantity of shares at this price level in the Market Center''s ADAP book. A value of zero implies deletion of this ADAP level'
  expanded_adap_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: adap_flags
        type: adap_flags
      - id: reserved_1
        type: u1
        doc: 'Reserved'
      - id: num_adap_block
        type: u1
        doc: 'Number of ADAP Block messages to follow'
      - id: adap_block_size
        type: u1
        doc: 'Size of each ADAP Block message'
      - id: adap_block
        type: adap_block
        repeat: expr
        repeat-expr: num_adap_block
        doc: 'ADAP Block'
  rpi_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: retail_price_improvement
        type: u1
        enum: retail_price_improvement
        doc: 'Retail Price Improvement indicator'
  fractional_trade_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: last_price
        type: decimal_u8_4
        doc: 'Last trade price. Implied decimal with scale 1e-4'
      - id: last_quantity
        type: u8
        doc: 'Last trade quantity'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: fractional_trade_flags
        type: fractional_trade_flags
  fractional_trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: national_volume_status
        type: b1
      - id: last_sale_eligible
        type: b1
      - id: unused_6
        type: b6
  expanded_fractional_trade_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: last_price
        type: decimal_u8_4
        doc: 'Last trade price. Implied decimal with scale 1e-4'
      - id: last_quantity
        type: u8
        doc: 'Last trade quantity'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: reserved_1
        type: u1
        doc: 'Reserved'
  fractional_trade_break_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: fractional_trade_break_flags
        type: fractional_trade_break_flags
  fractional_trade_break_flags:
    meta:
      bit-endian: le
    seq:
      - id: sip_volume_status
        type: b1
      - id: unused_7
        type: b7
  expanded_fractional_trade_break_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: reserved_1
        type: u1
        doc: 'Reserved'
  trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status indicator'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action indicator'
  expanded_trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status indicator'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action indicator'
  opening_closing_price_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: open_close_indicator
        type: u1
        enum: open_close_indicator
        doc: 'Open/Close indicator'
      - id: price_long
        type: decimal_u8_4
        doc: 'Opening/Closing Price. Implied decimal with scale 1e-4'
  expanded_opening_closing_price_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: 'All Cboe Markets for this feed'
      - id: open_close_indicator
        type: u1
        enum: open_close_indicator
        doc: 'Open/Close indicator'
      - id: price_long
        type: decimal_u8_4
        doc: 'Opening/Closing Price. Implied decimal with scale 1e-4'
  fractional_end_of_day_summary_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: data_source
        type: u1
        enum: data_source
        doc: 'Data source indicator'
      - id: opening_price
        type: decimal_u8_4
        doc: 'Opening Price. 0 if the system has not received an opening price for the security. Implied decimal with scale 1e-4'
      - id: closing_price
        type: decimal_u8_4
        doc: 'Closing Price. Implied decimal with scale 1e-4'
      - id: high_price
        type: decimal_u8_4
        doc: 'Highest trade price of the day. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'Lowest trade price of the day. Implied decimal with scale 1e-4'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
  expanded_fractional_end_of_day_summary_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: symbol_long
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: data_source
        type: u1
        enum: data_source
        doc: 'Data source indicator'
      - id: opening_price
        type: decimal_u8_4
        doc: 'Opening Price. 0 if the system has not received an opening price for the security. Implied decimal with scale 1e-4'
      - id: closing_price
        type: decimal_u8_4
        doc: 'Closing Price. Implied decimal with scale 1e-4'
      - id: high_price
        type: decimal_u8_4
        doc: 'Highest trade price of the day. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'Lowest trade price of the day. Implied decimal with scale 1e-4'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'In the US, cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0xa2:
      id: 'clear_quote_message'
      doc: 'The Clear Quote message instructs feed recipients to clear all quotes and Summary and/or ADAP information for the specified symbol on the specified market(s).'
    0xf0:
      id: 'expanded_clear_quote_message'
      doc: 'The Expanded Clear Quote message instructs feed recipients to clear all quotes and Summary and/or ADAP information for the specified symbol on the specified market(s). Used when the symbol exceeds eight characters.'
    0xe7:
      id: 'fractional_symbol_summary_message'
      doc: 'The Fractional Symbol Summary message delivers the Cboe consolidated best bid/offer and total executed volume across all applicable Cboe One US and Cboe One Canada books.'
    0xeb:
      id: 'expanded_fractional_symbol_summary_message'
      doc: 'The Expanded Fractional Symbol Summary message delivers the Cboe consolidated best bid/offer and total executed volume across all applicable Cboe One Canada books. Used when the symbol exceeds eight characters.'
    0xa5:
      id: 'best_quote_update_message'
      doc: 'The Best Quote Update message is used to update one side of the Cboe consolidated quote information for a symbol.'
    0xf2:
      id: 'expanded_best_quote_update_message'
      doc: 'The Expanded Best Quote Update message is used to update one side of the Cboe consolidated quote information for a symbol. Used when the symbol exceeds eight characters.'
    0xa6:
      id: 'cboe_market_status_message'
      doc: 'The Cboe Market Status message is disseminated to reflect a change in the status of a market.'
    0xa7:
      id: 'adap_message'
      doc: 'Each ADAP message delivers one or more updates for a Symbol''s ADAP book. Each ADAP message contains one or more ADAP Block messages.'
    0xf3:
      id: 'expanded_adap_message'
      doc: 'The Expanded ADAP message is identical to the ADAP message described previously, except for the length of the Symbol field which is expanded from 8 to 14.'
    0xa8:
      id: 'rpi_message'
      doc: 'The Retail Price Improvement (RPI) message is a retail liquidity indicator that includes symbol and side, but not price and size. US Only.'
    0xe8:
      id: 'fractional_trade_message'
      doc: 'Fractional Trade messages are sent when an order is executed in whole or in part on a Cboe exchange.'
    0xec:
      id: 'expanded_fractional_trade_message'
      doc: 'The Expanded Fractional Trade message is identical to the Fractional Trade message described previously, except for the length of the Symbol field which is expanded from 8 to 14.'
    0xe9:
      id: 'fractional_trade_break_message'
      doc: 'The Fractional Trade Break message is sent whenever an execution on a Cboe exchange is broken.'
    0xed:
      id: 'expanded_fractional_trade_break_message'
      doc: 'The Expanded Fractional Trade Break message is sent whenever an execution on a Cboe exchange is broken. Used when the symbol exceeds eight characters.'
    0xab:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a security on a Cboe exchange.'
    0xf6:
      id: 'expanded_trading_status_message'
      doc: 'The Expanded Trading Status message is identical to the Trading Status message described previously, except for the length of the Symbol field which is expanded from 8 to 14. Canada Only.'
    0xb0:
      id: 'opening_closing_price_message'
      doc: 'The Opening/Closing Price message is used to indicate the Opening or Closing price of a security on any of the Cboe markets and the primary listing market.'
    0xf7:
      id: 'expanded_opening_closing_price_message'
      doc: 'The Expanded Opening/Closing Price message is identical to the Opening/Closing Price message described previously, except for the length of the Symbol field which is expanded from 8 to 14. Canada Only.'
    0xea:
      id: 'fractional_end_of_day_summary_message'
      doc: 'The Fractional End of Day Summary message is used to give a consolidated, high-level overview of a security for the day.'
    0xef:
      id: 'expanded_fractional_end_of_day_summary_message'
      doc: 'The Expanded Fractional End of Day Summary message is identical to the Fractional End of Day Summary message described previously, except for the length of the Symbol field which is expanded from 8 to 14. Canada Only.'
  market_center:
    0x2a:
      id: 'all_cboe_markets'
      doc: 'All Cboe Markets For This Feed'
    0x59:
      id: 'byx'
      doc: 'Byx'
    0x5a:
      id: 'bzx'
      doc: 'Bzx'
    0x41:
      id: 'edga'
      doc: 'Edga'
    0x58:
      id: 'edgx'
      doc: 'Edgx'
    0x4c:
      id: 'neol'
      doc: 'Neol'
    0x4e:
      id: 'neon'
      doc: 'Neon'
    0x44:
      id: 'neod'
      doc: 'Neod'
    0x4d:
      id: 'match_now'
      doc: 'Match Now'
    0x72:
      id: 'neo_cross'
      doc: 'Neo Cross'
    0x74:
      id: 'neosst'
      doc: 'Neosst'
  side_indicator:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
  market_status:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x45:
      id: 'excluded_from_symbol_summary_and_adap_updates'
      doc: 'Excluded From Symbol Summary And Adap Updates'
    0x49:
      id: 'incomplete'
      doc: 'Incomplete'
  session_indicator:
    0x52:
      id: 'regular_trading_session'
      doc: 'Regular Trading Session'
    0x50:
      id: 'pre_or_postmarket_session'
      doc: 'Pre Or Postmarket Session'
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
  trading_status:
    0x41:
      id: 'accepting_orders_for_queuing'
      doc: 'Accepting Orders For Queuing'
    0x46:
      id: 'halted_full'
      doc: 'Halted Full'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x4d:
      id: 'delayed_closing'
      doc: 'Delayed Closing'
    0x4f:
      id: 'preclose'
      doc: 'Preclose'
    0x50:
      id: 'postclose'
      doc: 'Postclose'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x53:
      id: 'exchange_specific_suspension'
      doc: 'Exchange Specific Suspension'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x58:
      id: 'extended_trading'
      doc: 'Extended Trading'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_price_test_restriction_in_effect'
      doc: 'Reg Sho Price Test Restriction In Effect'
  open_close_indicator:
    0x4f:
      id: 'opening_price'
      doc: 'Opening Price'
    0x43:
      id: 'closing_price'
      doc: 'Closing Price'
  data_source:
    0x43:
      id: 'cta'
      doc: 'Cta'
    0x55:
      id: 'utp'
      doc: 'Utp'
    0x69:
      id: 'indicative_value'
      doc: 'Indicative Value'
    0x63:
      id: 'calculated_value_from_tmx_ip'
      doc: 'Calculated Value From Tmx Ip'

