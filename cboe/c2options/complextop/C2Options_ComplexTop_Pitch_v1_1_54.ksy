# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C2Options ComplexTop Pitch v1.1.54
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Complex Top
#   Encoding: Pitch
#   Version: 1.1.54
#   Date: 04/01/2026
#   Specification: US_OPTIONS_COMPLEX_MULTICAST_TOP_SPECIFICATION.pdf
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
  id: cboe_c2options_complextop_pitch_v1_1_54
  title: Cboe C2Options ComplexTop Pitch v1.1.54
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C2 Options Complex Top Pitch v1.1.54'
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
            'message_type::time_message': time_message
            'message_type::unit_clear_message': unit_clear_message
            'message_type::complex_instrument_definition_expanded_message': complex_instrument_definition_expanded_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::single_side_update_expanded_short_message': single_side_update_expanded_short_message
            'message_type::single_side_update_expanded_long_message': single_side_update_expanded_long_message
            'message_type::two_side_update_expanded_short_message': two_side_update_expanded_short_message
            'message_type::two_side_update_expanded_long_message': two_side_update_expanded_long_message
            'message_type::top_trade_message': top_trade_message
            'message_type::options_auction_update_message': options_auction_update_message
            'message_type::auction_summary_message': auction_summary_message
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
  time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day, derived by converting the current Eastern wall clock time (HH:MM:SS) to seconds. Seconds since Midnight epoch'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  complex_instrument_definition_expanded_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: complex_instrument_underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Underlying right padded with spaces'
      - id: complex_instrument_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Character field; each field describes a characteristic. Character 1: Complex Option Type. Characters 2-4: Reserved'
      - id: num_complex_leg
        type: u1
        doc: 'The number of legs in the complex instrument. The maximum number of legs is 16'
      - id: complex_leg
        type: complex_leg
        repeat: expr
        repeat-expr: num_complex_leg
        doc: 'Repeating leg definition group inside the Complex Instrument Definition Expanded message. Repeats Leg Count times'
  complex_leg:
    seq:
      - id: leg_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option or Equity Symbol of leg, right padded with spaces'
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for buy-side, negative for sell-side). For options this is the number of contracts, for equities this is the number of shares'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'O = Leg is an Option instrument, E = Leg is an Equity instrument'
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
        doc: 'N = Normal, C = Closing Only'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
  single_side_update_expanded_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: side
        type: u1
        enum: side
        doc: 'B = Bid Side, S = Ask Side'
      - id: bit_fields
        type: bit_fields
        doc: 'Reserved bit field used in Single Side Update and Two Side Update messages. All 8 bits are reserved for Complex Multicast TOP'
      - id: price_short
        type: decimal_u2_2
        doc: 'Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-2'
      - id: quantity_short
        type: u2
        doc: 'Total number of contracts on the inside book (customer and non-customer). A zero value denotes there is no Bid/Ask'
      - id: customer_quantity_short
        type: u2
        doc: 'Number of customer contracts on the inside book. A zero value denotes that there are no customer contracts at the inside price'
  bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: reserved_bits
        type: b8
        doc: 'Bits 0-7 - Reserved. There are no Bit Fields for Complex Multicast TOP'
  single_side_update_expanded_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: side
        type: u1
        enum: side
        doc: 'B = Bid Side, S = Ask Side'
      - id: bit_fields
        type: bit_fields
        doc: 'Reserved bit field used in Single Side Update and Two Side Update messages. All 8 bits are reserved for Complex Multicast TOP'
      - id: price_long
        type: decimal_u8_4
        doc: 'Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Total number of contracts on the inside book (customer and non-customer). A zero value denotes there is no Bid/Ask'
      - id: customer_quantity_long
        type: u4
        doc: 'Number of customer contracts on the inside book. A zero value denotes that there are no customer contracts at the inside price'
  two_side_update_expanded_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: bit_fields
        type: bit_fields
        doc: 'Reserved bit field used in Single Side Update and Two Side Update messages. All 8 bits are reserved for Complex Multicast TOP'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Bid Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-2'
      - id: bid_quantity_short
        type: u2
        doc: 'Total number of contracts on the inside bid (customer and non-customer). A zero value denotes there is no bid'
      - id: bid_customer_quantity_short
        type: u2
        doc: 'Number of customer contracts on the inside bid. A zero value denotes that there are no customer contracts at the inside price'
      - id: ask_price_short
        type: decimal_u2_2
        doc: 'Ask Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-2'
      - id: ask_quantity_short
        type: u2
        doc: 'Total number of contracts on the inside ask (customer and non-customer). A zero value denotes there is no ask'
      - id: ask_customer_quantity_short
        type: u2
        doc: 'Number of customer contracts on the inside ask. A zero value denotes that there are no customer contracts at the inside price'
  two_side_update_expanded_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: bit_fields
        type: bit_fields
        doc: 'Reserved bit field used in Single Side Update and Two Side Update messages. All 8 bits are reserved for Complex Multicast TOP'
      - id: bid_price_long
        type: decimal_u8_4
        doc: 'Bid Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-4'
      - id: bid_quantity_long
        type: u4
        doc: 'Total number of contracts on the inside bid (customer and non-customer). A zero value denotes there is no bid'
      - id: bid_customer_quantity_long
        type: u4
        doc: 'Number of customer contracts on the inside bid. A zero value denotes that there are no customer contracts at the inside price'
      - id: ask_price_long
        type: decimal_u8_4
        doc: 'Ask Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-4'
      - id: ask_quantity_long
        type: u4
        doc: 'Total number of contracts on the inside ask (customer and non-customer). A zero value denotes there is no ask'
      - id: ask_customer_quantity_long
        type: u4
        doc: 'Number of customer contracts on the inside ask. A zero value denotes that there are no customer contracts at the inside price'
  top_trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: quantity_long
        type: u4
        doc: 'Total number of contracts on the inside book (customer and non-customer). A zero value denotes there is no Bid/Ask'
      - id: price_long
        type: decimal_u8_4
        doc: 'Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this trade. Execution Id is also referenced in the Trade Break message'
      - id: total_volume
        type: u4
        doc: 'Total quantity traded on the current business day (may decrease if the Trade Condition field indicates a cancelled trade)'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'See Options Trade Condition Codes for details'
  options_auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'G = GTH Opening (C1 Only), O = RTH Opening (C1 Only), H = Halt Re-Opening'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Not used for complex series. Will contain zero value. Implied decimal with scale 1e-4'
      - id: buy_contracts
        type: u4
        doc: 'Cumulative Buy interest at the Indicative Price'
      - id: sell_contracts
        type: u4
        doc: 'Cumulative Sell interest at the Indicative Price'
      - id: indicative_price
        type: decimal_s8_4
        doc: 'SNBBO Collared Volume Maximizing Imbalance Minimizing Price computed on combined Auction-Only and Continuous Book (if any). Implied decimal with scale 1e-4'
      - id: auction_only_price
        type: decimal_s8_4
        doc: 'Not used for complex series. Will contain zero value. Implied decimal with scale 1e-4'
      - id: opening_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used for Complex series. Will contain zero value'
      - id: composite_market_bid_price
        type: decimal_s8_4
        doc: 'Not used for Complex series. Will contain zero value. Implied decimal with scale 1e-4'
      - id: composite_market_offer_price
        type: decimal_s8_4
        doc: 'Not used for Complex series. Will contain zero value. Implied decimal with scale 1e-4'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'G = GTH Opening (C1 Only), O = RTH Opening (C1 Only), H = Halt Re-Opening'
      - id: price_long
        type: decimal_u8_4
        doc: 'Price (may be a zero or negative price for some instruments). Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Total number of contracts on the inside book (customer and non-customer). A zero value denotes there is no Bid/Ask'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'H = Halted, L = Curb Trading (C1 Only), Q = Quote-Only, T = RTH Trading'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: gth_trading_status
        size: 1
        doc: 'Reserved. C1 only field — unused on BzxOptions, C2Options, and EdgxOptions'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  end_of_session_message:
    seq:
      - id: timestamp
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a Top event for a given clock second. If there is no Top event for a given clock second, then no Time message is sent for that second. All subsequent time offset fields for the same unit will use the new Time value as the base until another Time message is received for the same unit.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all Cboe complex books in the unit specified in the Sequenced Unit Header. This message will be sent at startup each day. It would also be distributed in certain recovery events such as a data center fail-over.'
    0x9a:
      id: 'complex_instrument_definition_expanded_message'
      doc: 'A Complex Instrument Definition Expanded message represents a complex instrument that is available to place orders. It is sent as a sequenced message. Complex Instrument Definition Expanded messages will be sent in a continuous loop through the day at variable rates as bandwidth allows. The Complex Instrument Definition Expanded message will contain two or more repeating groups of leg definitions. There is a limit of 16 leg definitions.'
    0x2f:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character simple instrument multicast feed symbol field to an OSI symbol and Underlying. These messages are not sequenced (sequence = 0) and are sent continuously through the day at variable rates as bandwidth allows.'
    0xd4:
      id: 'single_side_update_expanded_short_message'
      doc: 'Single Side Update messages provide an updated price and size for a single side of a Complex Instrument ID. The side is denoted by the Side field. One Single Side Update message may reflect one or more updates to the inside book that were processed at the same time, but will only be done so in a way that can be arbitrated between A/B feeds. The Single Side Update Expanded (Short) message is used whenever possible.'
    0xd5:
      id: 'single_side_update_expanded_long_message'
      doc: 'Single Side Update messages provide an updated price and size for a single side of a Complex Instrument ID. The Single Side Update Expanded (Long) message is used when the Price cannot be represented by a Binary Short Price or the Quantity cannot be represented by an unsigned 16-bit integer.'
    0xd6:
      id: 'two_side_update_expanded_short_message'
      doc: 'Two Side Update messages provide an updated price and size for both sides of a Complex Instrument ID. One Two Side Update message may reflect one or more updates to the inside book that were processed at the same time, but will only be done so in a way that can be arbitrated between A/B feeds. The Two Side Update Expanded (Short) message is used whenever possible.'
    0xd7:
      id: 'two_side_update_expanded_long_message'
      doc: 'Two Side Update messages provide an updated price and size for both sides of a Complex Instrument ID. The Two Side Update Expanded (Long) message is used when the Price cannot be represented by a Binary Short Price or the Quantity cannot be represented by an unsigned 16-bit integer.'
    0xb8:
      id: 'top_trade_message'
      doc: 'The TOP Trade message provides information about executions of complex orders. TOP Trade messages are necessary to calculate Cboe execution-based data. TOP Trade messages do not alter the complex book. One or more Single Side Update Expanded or Two Side Update Expanded messages will follow a TOP Trade message to reflect the updated complex book. The TOP Trade message sends the trade price, trade quantity, and trade condition of a trade as well as the cumulative volume for the business day.'
    0xd1:
      id: 'options_auction_update_message'
      doc: 'Options Auction Update messages are used to disseminate price and size information during Opening and Re-Opening (halt) auctions for complex instruments. The Options Auction Update messages are sent every five seconds during an opening period.'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction of a complex instrument. An Opening or Re-Opening Auction Summary message for each complex instrument is sent at the conclusion of its Opening or Re-Opening auction and represents the Cboe opening price.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a complex instrument. A Trading Status message will be sent whenever a complex instrument trading status changes. The Trading Status field will be used to represent the status of the RTH (9:30 a.m. ET - 4:15 p.m. ET) session.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  leg_security_type:
    0x4f:
      id: 'leg_is_an_option_instrument'
      doc: 'Leg Is An Option Instrument'
    0x45:
      id: 'leg_is_an_equity_instrument'
      doc: 'Leg Is An Equity Instrument'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
  side:
    0x42:
      id: 'bid_side'
      doc: 'Bid Side'
    0x53:
      id: 'ask_side'
      doc: 'Ask Side'
  trade_condition:
    0x66:
      id: 'complex_to_complex_electronic_trade_cboe_auction_type_is_coa'
      doc: 'Complex To Complex Electronic Trade Cboe Auction Type Is Coa'
    0x67:
      id: 'complex_auction_trade_cboe_order_types_include_caim_csam'
      doc: 'Complex Auction Trade Cboe Order Types Include Caim Csam'
    0x68:
      id: 'complex_cross_cboe_auction_types_include_cust_to_cust_caim_cqcc'
      doc: 'Complex Cross Cboe Auction Types Include Cust To Cust Caim Cqcc'
    0x6a:
      id: 'complex_electronic_trade_against_single_legs'
      doc: 'Complex Electronic Trade Against Single Legs'
    0x6b:
      id: 'complex_with_stock_options_auction_trade_cboe_auction_types_include_caim_w_stock_csam_w_stock'
      doc: 'Complex With Stock Options Auction Trade Cboe Auction Types Include Caim W Stock Csam W Stock'
    0x6d:
      id: 'complex_floor_trade_against_single_legs_all_complex_floor_executions_are_reported_as_condition_m'
      doc: 'Complex Floor Trade Against Single Legs All Complex Floor Executions Are Reported As Condition M'
    0x6e:
      id: 'complex_with_stock_electronic_trade_includes_coa_auctions_done_electronically'
      doc: 'Complex With Stock Electronic Trade Includes Coa Auctions Done Electronically'
    0x6f:
      id: 'complex_with_stock_cross_cboe_auction_types_include_cqcc_w_stock'
      doc: 'Complex With Stock Cross Cboe Auction Types Include Cqcc W Stock'
    0x70:
      id: 'complex_with_stock_floor_trade'
      doc: 'Complex With Stock Floor Trade'
    0x74:
      id: 'complex_floor_trade_of_proprietary_products_marked_as_combo_order'
      doc: 'Complex Floor Trade Of Proprietary Products Marked As Combo Order'
    0x76:
      id: 'extended_hours_trade_transaction_represents_a_trade_executed_during_the_curb_session'
      doc: 'Extended Hours Trade Transaction Represents A Trade Executed During The Curb Session'
    0x6c:
      id: 'electronic_trade'
      doc: 'Electronic Trade'
    0x4f:
      id: 'opening_trade'
      doc: 'Opening Trade'
  auction_type:
    0x47:
      id: 'gth_opening'
      doc: 'Gth Opening'
    0x4f:
      id: 'rth_opening'
      doc: 'Rth Opening'
    0x48:
      id: 'halt_re_opening'
      doc: 'Halt Re Opening'
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

