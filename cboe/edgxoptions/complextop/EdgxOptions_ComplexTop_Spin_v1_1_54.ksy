# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgxOptions ComplexTop Spin v1.1.54
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Complex Top
#   Encoding: Spin
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
  id: cboe_edgxoptions_complextop_spin_v1_1_54
  title: Cboe EdgxOptions ComplexTop Spin v1.1.54
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edgx Options Complex Top Spin v1.1.54'
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
        doc: 'Spin is available which is current through this sequence number'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_message': login_message
            'message_type::login_response_message': login_response_message
            'message_type::spin_image_available_message': spin_image_available_message
            'message_type::spin_request_message': spin_request_message
            'message_type::spin_response_message': spin_response_message
            'message_type::spin_finished_message': spin_finished_message
            'message_type::instrument_definition_request_message': instrument_definition_request_message
            'message_type::instrument_definition_response_message': instrument_definition_response_message
            'message_type::time_message': time_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::complex_instrument_definition_expanded_message': complex_instrument_definition_expanded_message
            'message_type::single_side_update_expanded_short_message': single_side_update_expanded_short_message
            'message_type::single_side_update_expanded_long_message': single_side_update_expanded_long_message
            'message_type::two_side_update_expanded_short_message': two_side_update_expanded_short_message
            'message_type::two_side_update_expanded_long_message': two_side_update_expanded_long_message
            'message_type::top_trade_message': top_trade_message
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
  login_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'SessionSubId supplied by Cboe'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username supplied by Cboe'
      - id: filler
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '(space filled)'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password supplied by Cboe'
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted or reason for reject'
  spin_image_available_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: order_count
        type: u4
        doc: 'Always zero'
      - id: spin_response_status
        type: u1
        enum: spin_response_status
        doc: 'Accepted or reason for reject. All non-A status codes should be interpreted as a reject'
  spin_finished_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: instrument_count
        type: u4
        doc: 'Number of Symbol Mapping and Complex Instrument Definition Expanded (if applicable) messages which will be contained in this spin'
      - id: instrument_definition_response_status
        type: u1
        enum: instrument_definition_response_status
        doc: 'Accepted or reason for reject'
  time_message:
    seq:
      - id: time
        type: u4
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day, derived by converting the current Eastern wall clock time (HH:MM:SS) to seconds'
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
  complex_instrument_definition_expanded_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
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
  single_side_update_expanded_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
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
  trading_status_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
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

enums:
  message_type:
    0x01:
      id: 'login_message'
      doc: 'The Login message is the first message sent to the Spin Server by a user''s process after the connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. The format of the Login message for the Spin Server is identical to that of the GRP.'
    0x02:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by the Spin Server to a user''s process in response to a Login message. The status field is used to reflect an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'The Spin Image Available message is sent once per second and indicates through what sequence number a spin is available.'
    0x81:
      id: 'spin_request_message'
      doc: 'The Spin Request message is used by a user''s process to request transmission of a spin of the unit''s order book.'
    0x82:
      id: 'spin_response_message'
      doc: 'The Spin Response message is sent in response to a user''s Spin Request message indicating whether a spin will be sent.'
    0x83:
      id: 'spin_finished_message'
      doc: 'The Spin Finished message is sent to indicate that all messages for the spin requested have been sent. A Spin Finished message is only sent if a Spin Request was not rejected. Upon receipt of a Spin Finished message, any buffered multicast messages should be applied to the customer''s copy of the book to make it current.'
    0x84:
      id: 'instrument_definition_request_message'
      doc: 'The Instrument Definition Request message is used by a user''s process to request transmission of this unit''s Symbol Mappings and Complex Instrument Definitions. All Symbol Mapping messages will be sent before Complex Instrument Definition Expanded and Exchange Designated Complex Instrument Definition messages.'
    0x85:
      id: 'instrument_definition_response_message'
      doc: 'The Instrument Definition Response message is sent in response to a user''s Instrument Definition Request message indicating whether a spin will be sent.'
    0x86:
      id: 'instrument_definition_finished_message'
      doc: 'The Instrument Definition Finished message is sent to indicate that all Symbol Mapping and Complex Instrument Definition Expanded messages for this unit have been sent. An Instrument Definition Finished message is only sent if an Instrument Definition Request was not rejected.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a Top event for a given clock second. If there is no Top event for a given clock second, then no Time message is sent for that second. All subsequent time offset fields for the same unit will use the new Time value as the base until another Time message is received for the same unit.'
    0x2f:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character simple instrument multicast feed symbol field to an OSI symbol and Underlying. These messages are not sequenced (sequence = 0) and are sent continuously through the day at variable rates as bandwidth allows.'
    0x9a:
      id: 'complex_instrument_definition_expanded_message'
      doc: 'A Complex Instrument Definition Expanded message represents a complex instrument that is available to place orders. It is sent as a sequenced message. Complex Instrument Definition Expanded messages will be sent in a continuous loop through the day at variable rates as bandwidth allows. The Complex Instrument Definition Expanded message will contain two or more repeating groups of leg definitions. There is a limit of 16 leg definitions.'
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
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a complex instrument. A Trading Status message will be sent whenever a complex instrument trading status changes. The Trading Status field will be used to represent the status of the RTH (9:30 a.m. ET - 4:15 p.m. ET) session.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized_invalid_username_password'
      doc: 'Not Authorized Invalid Username Password'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
  spin_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_requested_is_greater_than_sequence_available_by_the_next_spin'
      doc: 'Out Of Range Sequence Requested Is Greater Than Sequence Available By The Next Spin'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  instrument_definition_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_must_be_0'
      doc: 'Out Of Range Sequence Must Be 0'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
  leg_security_type:
    0x4f:
      id: 'leg_is_an_option_instrument'
      doc: 'Leg Is An Option Instrument'
    0x45:
      id: 'leg_is_an_equity_instrument'
      doc: 'Leg Is An Equity Instrument'
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

