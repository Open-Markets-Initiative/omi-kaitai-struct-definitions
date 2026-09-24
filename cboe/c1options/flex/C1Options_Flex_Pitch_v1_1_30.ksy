# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options Flex Pitch v1.1.30
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Flex
#   Encoding: Pitch
#   Version: 1.1.30
#   Date: 04/01/2026
#   Specification: US_Options_FLEX_Specification.pdf
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
  id: cboe_c1options_flex_pitch_v1_1_30
  title: Cboe C1Options Flex Pitch v1.1.30
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C1 Options Flex Pitch v1.1.30'
doc-ref: http://markets.cboe.com/us/options/support/technical/

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
            'message_type::time_reference_message': time_reference_message
            'message_type::time_message': time_message
            'message_type::flex_instrument_definition_message': flex_instrument_definition_message
            'message_type::complex_flex_instrument_definition_message': complex_flex_instrument_definition_message
            'message_type::auction_notification_message': auction_notification_message
            'message_type::dac_auction_notification_message': dac_auction_notification_message
            'message_type::auction_cancel_message': auction_cancel_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::trade_long_message': trade_long_message
            'message_type::trade_short_message': trade_short_message
            'message_type::dac_trade_message': dac_trade_message
            'message_type::trade_break_message': trade_break_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::trading_status_message': trading_status_message
            'message_type::end_of_session_message': end_of_session_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_reference_message:
    seq:
      - id: midnight_reference
        type: second_timestamp
        doc: 'Midnight Eastern Time reference time for subsequent Time messages, expressed as number of whole seconds since the Epoch (midnight January 1, 1970 UTC). Seconds since Unix epoch'
      - id: time_reference
        type: u4
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day'
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
  time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day. Seconds since Midnight epoch'
      - id: epoch_time
        type: u4
        doc: 'Number of whole seconds since the Epoch (midnight January 1, 1970 UTC)'
  flex_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_root
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Root right padded with spaces'
      - id: year
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit year'
      - id: month
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit month'
      - id: day
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit day'
      - id: call_put_indicator
        type: u1
        enum: call_put_indicator
        doc: 'Call/Put indicator'
      - id: dollar_strike
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Dollar strike (if not percentage) left padded with zero. If percentage, field is space padded'
      - id: decimal_strike
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Decimal strike (if not percentage) left padded with zero. If percentage, field is space padded'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: 'Symbol condition indicator'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Exercise style indicator'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type indicator'
      - id: percentage
        type: u4
        doc: 'Percentage when strike and price is percentage based (implied 4 decimal places). Otherwise zero'
      - id: observation_day
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit observation day of month. Valid only for Asian and Cliquet options, otherwise space padded'
      - id: return_cap_percentage
        type: u4
        doc: 'Return cap percentage (implied 2 decimal places). Valid only for Cliquet, otherwise zero'
      - id: creation_day
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit creation day of the month. Valid only for Cliquet, otherwise space padded'
      - id: bit_fields
        type: bit_fields
  bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: percentage_1
        type: b1
      - id: reserved_7
        type: b7
  complex_flex_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument ID right padded with spaces'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
      - id: complex_instrument_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '4 character field. Character 1: Complex Option Type. Characters 2-4: Reserved'
      - id: leg_count
        type: u1
        doc: 'The number of legs in the complex instrument. The maximum number of legs is 100'
      - id: message_count
        type: u1
        doc: 'Number of messages required to define the complex instrument'
      - id: message_number
        type: u1
        doc: 'Message number of the message count, e.g. 1 of 5'
      - id: num_complex_flex_leg
        type: u1
        doc: 'The number of legs in this message'
      - id: complex_flex_leg
        type: complex_flex_leg
        repeat: expr
        repeat-expr: num_complex_flex_leg
        doc: 'Repeating leg definition for complex FLEX instruments. Repeats Message Leg Count times'
  complex_flex_leg:
    seq:
      - id: leg_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Symbol, right padded with spaces'
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for buy-side, negative for sell-side)'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'The instrument type of this leg'
  auction_notification_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: flex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Instrument ID right padded with spaces'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type indicator'
      - id: side
        type: u1
        enum: side
        doc: 'Side indicator'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'Auction price. Price will be zero for Auction Type = B and F. Price will be included for Auction Type = S. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'Customer indicator'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Executing Broker (optional) of firm attributed to this auction'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'User defined identifier for quote attribution'
  dac_auction_notification_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: flex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Instrument ID right padded with spaces'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type indicator'
      - id: side
        type: u1
        enum: side
        doc: 'Side indicator'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'Auction price. Price will be zero for Auction Type = B and F. Price will be included for Auction Type = S. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'Customer indicator'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Executing Broker (optional) of firm attributed to this auction'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'User defined identifier for quote attribution'
      - id: dac_reference_price
        type: decimal_s8_4
        doc: 'Value used as the initial reference price for a delta adjust at close auction. Implied decimal with scale 1e-4'
      - id: num_dac_delta
        type: u1
        doc: 'Number of delta values for this auction'
      - id: dac_delta
        type: dac_delta
        repeat: expr
        repeat-expr: num_dac_delta
        doc: 'Repeating delta value for DAC auctions. Repeats DAC Delta Count times'
  dac_delta:
    seq:
      - id: delta_value
        type: s2
        doc: 'Delta value, from -1.0000 to 1.0000 (four implied decimal places)'
  auction_cancel_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
  auction_trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: execution_id
        type: u8
        doc: 'Day specific identifier assigned to this execution'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'Auction price. Price will be zero for Auction Type = B and F. Price will be included for Auction Type = S. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity'
  trade_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Order ID of the executed order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Always "B"'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity'
      - id: flex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Instrument ID right padded with spaces'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'Auction price. Price will be zero for Auction Type = B and F. Price will be included for Auction Type = S. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Day specific identifier assigned to this execution'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Options Trade Condition code'
  trade_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Order ID of the executed order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Always "B"'
      - id: quantity_short
        type: u2
        doc: 'Instrument quantity traded'
      - id: flex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Instrument ID right padded with spaces'
      - id: signed_price_short
        type: decimal_s2_2
        doc: 'Trade price. If instrument trades in percentage terms, then this represents the traded percentage with two implied decimals. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'Day specific identifier assigned to this execution'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Options Trade Condition code'
  dac_trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Order ID of the executed order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Always "B"'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity'
      - id: flex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Instrument ID right padded with spaces'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'Auction price. Price will be zero for Auction Type = B and F. Price will be included for Auction Type = S. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Day specific identifier assigned to this execution'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Options Trade Condition code'
      - id: dac_reference_price
        type: decimal_s8_4
        doc: 'Value used as the initial reference price for a delta adjust at close auction. Implied decimal with scale 1e-4'
      - id: dac_closing_price
        type: decimal_s8_4
        doc: 'Price used as the closing price for DAC trade repricing. $0 unless repricing a DAC trade after the close. Implied decimal with scale 1e-4'
      - id: dac_delta_value
        type: s2
        doc: 'The delta value applied to this DAC trade (within the range -1.0000 through 1.0000; 0 if a complex instrument)'
  trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'Day specific identifier assigned to this execution'
  symbol_mapping_message:
    seq:
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_symbol
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Symbol'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: 'Symbol condition indicator'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status indicator'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: gth_trading_status
        type: u1
        enum: gth_trading_status
        doc: 'GTH Trading Status indicator'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  end_of_session_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s2_2:
    seq:
      - id: mantissa
        type: s2
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0xb1:
      id: 'time_reference_message'
      doc: 'The Time Reference message is used to provide a midnight reference point for recipients of the feed.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a FLEX event for a given clock second.'
    0x9c:
      id: 'flex_instrument_definition_message'
      doc: 'A FLEX Instrument Definition message represents an instrument that is available to place orders.'
    0x9b:
      id: 'complex_flex_instrument_definition_message'
      doc: 'A Complex FLEX Instrument Definition message represents a complex instrument that is available to place orders.'
    0xad:
      id: 'auction_notification_message'
      doc: 'Auction Notification messages are used to disseminate order details of a FLEX Auction.'
    0xdd:
      id: 'dac_auction_notification_message'
      doc: 'DAC Auction Notification messages are used to disseminate order details of a DAC FLEX Auction.'
    0xae:
      id: 'auction_cancel_message'
      doc: 'Auction Cancel messages are used to disseminate the cancellation of an earlier Auction Notification message.'
    0xaf:
      id: 'auction_trade_message'
      doc: 'Auction Trade messages are used to disseminate executions resulting from an auction.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions of FLEX orders on the Cboe Options trading floor.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade (short) message provides information about executions of FLEX orders on the Cboe Options trading floor.'
    0x36:
      id: 'dac_trade_message'
      doc: 'The DAC Trade message provides information about executions of Delta Adjusted at Close (DAC) FLEX orders on the Cboe Options trading floor.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever a FLEX options execution on Cboe is broken.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol and Underlying.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a FLEX options instrument.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down.'
  call_put_indicator:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
  exercise_style:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
  settlement_type:
    0x41:
      id: 'am'
      doc: 'Am'
    0x50:
      id: 'pm'
      doc: 'Pm'
    0x53:
      id: 'asian'
      doc: 'Asian'
    0x51:
      id: 'cliquet'
      doc: 'Cliquet'
  leg_security_type:
    0x58:
      id: 'flex_option'
      doc: 'Flex Option'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x4f:
      id: 'listed_option'
      doc: 'Listed Option'
  auction_type:
    0x42:
      id: 'aim'
      doc: 'Aim'
    0x46:
      id: 'flex_auction'
      doc: 'Flex Auction'
    0x53:
      id: 'solicitation_auction_mechanism'
      doc: 'Solicitation Auction Mechanism'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  customer_indicator:
    0x4e:
      id: 'non_customer'
      doc: 'Non Customer'
    0x43:
      id: 'customer'
      doc: 'Customer'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x4c:
      id: 'curb_trading'
      doc: 'Curb Trading'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x54:
      id: 'rth_trading'
      doc: 'Rth Trading'
  gth_trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x54:
      id: 'trading'
      doc: 'Trading'

