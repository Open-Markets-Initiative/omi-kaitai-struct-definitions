# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgxOptions ComplexAuction Pitch v2.2.41
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Complex Auction
#   Encoding: Pitch
#   Version: 2.2.41
#   Date: 04/01/2026
#   Specification: US_OPTIONS_COMPLEX_AUCTION_MULTICAST_PITCH_SPECIFICATION.pdf
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
  id: cboe_edgxoptions_complexauction_pitch_v2_2_41
  title: Cboe EdgxOptions ComplexAuction Pitch v2.2.41
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edgx Options Complex Auction Pitch v2.2.41'
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
            'message_type::complex_instrument_definition_expanded_message': complex_instrument_definition_expanded_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::auction_notification_message': auction_notification_message
            'message_type::auction_cancel_message': auction_cancel_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::options_auction_update_message': options_auction_update_message
            'message_type::auction_summary_message': auction_summary_message
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
        doc: '4 character field; each field describes a characteristic. Character 1: Complex Option Type. O = All legs are options, E = One leg is an equity leg. Characters 2-4: Reserved'
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
  auction_notification_message:
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
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_notification_auction_type
        type: u1
        enum: auction_notification_auction_type
        doc: 'C = Complex Order Auction (COA) (or Stop Complex Order Auction (SCOA) effective TBD), S = Complex Solicitation Auction Mechanism, B = Complex AIM, O = COA All or None'
      - id: side
        type: u1
        enum: side
        doc: 'B = Buy, S = Sell'
      - id: price
        type: decimal_s8_4
        doc: 'Auction price. The price field will be populated for all Auctions on EDGX Options, and for Complex SAM Auctions on C1. This field will reflect the auction start price for SPX and SPXW Complex AIMs on C1. For all other Complex AIMs on C1, this field will be set to zero. This field will be set to zero for COA on C1, C2, and BZX. Implied decimal with scale 1e-4'
      - id: quantity
        type: u4
        doc: 'Instrument quantity'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'N = Non-Customer, C = Customer'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Executing Broker (optional) of firm attributed to this quote'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional user specified value attributed to this quote'
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
      - id: price
        type: decimal_s8_4
        doc: 'Auction price. The price field will be populated for all Auctions on EDGX Options, and for Complex SAM Auctions on C1. This field will reflect the auction start price for SPX and SPXW Complex AIMs on C1. For all other Complex AIMs on C1, this field will be set to zero. This field will be set to zero for COA on C1, C2, and BZX. Implied decimal with scale 1e-4'
      - id: quantity
        type: u4
        doc: 'Instrument quantity'
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
      - id: options_auction_update_auction_type
        type: u1
        enum: options_auction_update_auction_type
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
        doc: 'Not used for complex series. Will contain zero value. Implied decimal with scale 1e-4'
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
      - id: auction_summary_auction_type
        type: u1
        enum: auction_summary_auction_type
        doc: 'G = GTH Opening (C1 Only), O = RTH Opening (C1 Only), H = Halt Re-Opening'
      - id: price
        type: decimal_s8_4
        doc: 'Auction price. The price field will be populated for all Auctions on EDGX Options, and for Complex SAM Auctions on C1. This field will reflect the auction start price for SPX and SPXW Complex AIMs on C1. For all other Complex AIMs on C1, this field will be set to zero. This field will be set to zero for COA on C1, C2, and BZX. Implied decimal with scale 1e-4'
      - id: quantity
        type: u4
        doc: 'Instrument quantity'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
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
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second. If there is no PITCH event for a given clock second, then no Time message is sent for that second. All subsequent time offset fields for the same unit will use the new Time value as the base until another Time message is received for the same unit.'
    0x9a:
      id: 'complex_instrument_definition_expanded_message'
      doc: 'A Complex Instrument Definition Expanded message represents a complex instrument that is available to place orders. This message is unsequenced (sequence = 0) and is sent just prior to every Auction Notification message. Complex Instrument Definition Expanded messages will also be sent in a continuous loop through the day at variable rates as bandwidth allows. The Time offset field should be ignored on Complex Instrument Definition Expanded messages. The Complex Instrument Definition Expanded message will contain two or more repeating groups of leg definitions. There is a limit of 16 leg definitions.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character simple instrument multicast feed symbol field to an OSI symbol and Underlying. These messages are not sequenced (sequence = 0) and are sent continuously through the day at variable rates as bandwidth allows.'
    0xad:
      id: 'auction_notification_message'
      doc: 'Auction Notification messages are used to disseminate order details of a complex auction. Auctions will be available for a defined period of time known as the exposure period.'
    0xae:
      id: 'auction_cancel_message'
      doc: 'Auction Cancel messages are used to disseminate the cancellation of an earlier Auction Notification message as a result of a user cancellation of the original complex auction, a user modification request to change the complex auction price or increase the original complex auction quantity, a fading of the NBBO or to cancel any remaining complex auction quantity from the original Auction Notification following the complex auction termination. A user request to modify the complex auction price or to increase the original complex auction quantity will result in a cancellation of the complex auction followed by a new Auction Notification message. Auction Cancel messages will not be issued for complex auction quantity decrements.'
    0xaf:
      id: 'auction_trade_message'
      doc: 'Auction Trade messages are used to disseminate executions resulting from a complex auction.'
    0xd1:
      id: 'options_auction_update_message'
      doc: 'Options Auction Update messages are used to disseminate price and size information during the Opening and Re-Opening (halt) process for complex instruments. The Options Auction Update messages are sent every five seconds during an opening period. Refer to the Cboe Options Complex Book Process specification for more information.'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of the Opening and Re-Opening process of a complex instrument. An Opening or Re-Opening Auction Summary message for each complex instrument is sent at the conclusion of the Opening or Re-Opening process and represents the Cboe opening price. Refer to the Cboe Options Complex Book Process specification for more information.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more auction messages will be delivered for this unit, but heartbeats from the unit may be received.'
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
  auction_notification_auction_type:
    0x43:
      id: 'complex_order_auction_coa_or_stop_complex_order_auction_scoa_effective_tbd'
      doc: 'Complex Order Auction Coa Or Stop Complex Order Auction Scoa Effective Tbd'
    0x53:
      id: 'complex_solicitation_auction_mechanism'
      doc: 'Complex Solicitation Auction Mechanism'
    0x42:
      id: 'complex_aim'
      doc: 'Complex Aim'
    0x4f:
      id: 'coa_all_or_none'
      doc: 'Coa All Or None'
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
  options_auction_update_auction_type:
    0x47:
      id: 'gth_opening'
      doc: 'Gth Opening'
    0x4f:
      id: 'rth_opening'
      doc: 'Rth Opening'
    0x48:
      id: 'halt_re_opening'
      doc: 'Halt Re Opening'
  auction_summary_auction_type:
    0x47:
      id: 'gth_opening'
      doc: 'Gth Opening'
    0x4f:
      id: 'rth_opening'
      doc: 'Rth Opening'
    0x48:
      id: 'halt_re_opening'
      doc: 'Halt Re Opening'

