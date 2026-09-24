# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgxOptions AuctionFeed Pitch v1.1.39
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Auction Feed
#   Encoding: Pitch
#   Version: 1.1.39
#   Date: 04/01/2026
#   Specification: US_Options_Auction_Feed_Specification.pdf
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
  id: cboe_edgxoptions_auctionfeed_pitch_v1_1_39
  title: Cboe EdgxOptions AuctionFeed Pitch v1.1.39
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edgx Options Auction Feed Pitch v1.1.39'
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
            'message_type::auction_notification_message': auction_notification_message
            'message_type::auction_cancel_message': auction_cancel_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::options_auction_update_message': options_auction_update_message
            'message_type::auction_summary_message': auction_summary_message
            'message_type::width_update_message': width_update_message
            'message_type::symbol_mapping_message': symbol_mapping_message
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
  auction_notification_message:
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
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'B = AIM, S = Solicitation Auction Mechanism, T = Step Up Mechanism (SUM), A = SUM All or None'
      - id: side
        type: u1
        enum: side
        doc: 'B = Buy Side, S = Sell Side'
      - id: price
        type: decimal_u8_4
        doc: 'For SUM this will reflect the NBBO price of the opposite side of the auction at the time of entry. For AIM on EDGX, Price will be the auction start price. For SPX/SPXW AIM on C1, Price will be the auction start price, otherwise 0. For SAM, this will reflect the limit price specified on the order. Implied decimal with scale 1e-4'
      - id: contracts
        type: u4
        doc: 'Number of contracts available in the auction'
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
        type: decimal_u8_4
        doc: 'For SUM this will reflect the NBBO price of the opposite side of the auction at the time of entry. For AIM on EDGX, Price will be the auction start price. For SPX/SPXW AIM on C1, Price will be the auction start price, otherwise 0. For SAM, this will reflect the limit price specified on the order. Implied decimal with scale 1e-4'
      - id: contracts
        type: u4
        doc: 'Number of contracts available in the auction'
  options_auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: expanded_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'B = AIM, S = Solicitation Auction Mechanism, T = Step Up Mechanism (SUM), A = SUM All or None'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Collared VMIM price computed on the queuing book only. Implied decimal with scale 1e-4'
      - id: buy_contracts
        type: u4
        doc: 'Cumulative Buy contracts at the Reference Price and above'
      - id: sell_contracts
        type: u4
        doc: 'Cumulative Sell contracts at the Reference Price and below'
      - id: indicative_price
        type: decimal_u8_4
        doc: 'Collared VMIM price computed on the combined queueing book and the continuous book. Equal to Reference Price for options that do not have a GTH trading session. Implied decimal with scale 1e-4'
      - id: auction_only_price
        type: decimal_u8_4
        doc: 'Uncollared VMIM price computed on the queuing book only. Implied decimal with scale 1e-4'
      - id: opening_condition
        type: u1
        enum: opening_condition
        doc: 'O = Would open, Q = Need quote to open, B = Need more buyers (C1 Only), S = Need more sellers (C1 Only), C = Crossed Composite Market'
      - id: composite_market_bid_price
        type: decimal_u8_4
        doc: 'Bid Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
      - id: composite_market_offer_price
        type: decimal_u8_4
        doc: 'Offer Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: expanded_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'B = AIM, S = Solicitation Auction Mechanism, T = Step Up Mechanism (SUM), A = SUM All or None'
      - id: price
        type: decimal_u8_4
        doc: 'For SUM this will reflect the NBBO price of the opposite side of the auction at the time of entry. For AIM on EDGX, Price will be the auction start price. For SPX/SPXW AIM on C1, Price will be the auction start price, otherwise 0. For SAM, this will reflect the limit price specified on the order. Implied decimal with scale 1e-4'
      - id: quantity
        type: u4
        doc: 'Cumulative number of contracts executed during the auction'
  width_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying instrument right padded with spaces'
      - id: width_type
        type: u1
        enum: width_type
        doc: 'R = Regular, V = Volatility'
      - id: multiplier
        type: decimal_u4_1
        doc: 'Width multiplier. Implied decimal with scale 1e-1'
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
        doc: 'Symbol of underlying instrument right padded with spaces'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u4_1:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10.0

enums:
  message_type:
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is an Auction event for a given clock second. If there is no Auction event for a given clock second, then no Time message is sent for that second. All subsequent time offset fields for the same unit will use the new Time value as the base until another Time message is received for the same unit.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header. This message will be sent at startup each day. It would also be distributed in certain recovery events such as a data center fail-over.'
    0xad:
      id: 'auction_notification_message'
      doc: 'Auction Notification messages are used to disseminate order details of an auction. Auctions will be available for a defined period of time known as the exposure period.'
    0xae:
      id: 'auction_cancel_message'
      doc: 'Auction Cancel messages are used to disseminate the cancellation of an earlier Auction Notification message as a result of a user cancellation of the original order, a user modification request to change the price or increase the original order quantity, or a fading of the NBBO. A user request to modify the order price or to increase the original order quantity will result in a cancellation of the auction followed by a new Auction Notification message. Auction Cancel messages will not be issued for order quantity decrements.'
    0xaf:
      id: 'auction_trade_message'
      doc: 'Auction Trade messages are used to disseminate executions resulting from an options auction.'
    0xd1:
      id: 'options_auction_update_message'
      doc: 'Options Auction Update messages are used to disseminate price and size information and Composite Market bid and offer prices during Opening and Re-Opening (halt) auctions on the Cboe Options Exchange. Options Auction Update messages are sent every five seconds during an opening period provided that one of the field values has changed. When no values have changed, a message is sent once every 60 seconds.'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of the Opening and Re-Opening process. An Opening or Re-Opening Auction Summary message for each symbol is sent at the conclusion of the Opening or Re-Opening process and represents the Cboe opening price.'
    0xd2:
      id: 'width_update_message'
      doc: 'The Width Update message is used to communicate opening quote width multiplier. This message will be sent in the event that the exchange decides to change the quote width multiplier on a per underlying basis.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol. These messages are sent continuously through the day at variable rates as bandwidth allows. Members who consume the Options Auction feed will be able to receive the full list of symbols in approximately 30 minutes.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more auction messages will be delivered for this unit, but heartbeats from the unit may be received.'
  auction_type:
    0x42:
      id: 'aim'
      doc: 'Aim'
    0x53:
      id: 'solicitation_auction_mechanism'
      doc: 'Solicitation Auction Mechanism'
    0x54:
      id: 'step_up_mechanism_sum'
      doc: 'Step Up Mechanism Sum'
    0x41:
      id: 'sum_all_or_none'
      doc: 'Sum All Or None'
    0x47:
      id: 'gth_opening'
      doc: 'Gth Opening'
    0x4f:
      id: 'rth_opening'
      doc: 'Rth Opening'
    0x48:
      id: 'halt_re_opening'
      doc: 'Halt Re Opening'
    0x56:
      id: 'volatility_opening'
      doc: 'Volatility Opening'
  side:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
  customer_indicator:
    0x4e:
      id: 'non_customer'
      doc: 'Non Customer'
    0x43:
      id: 'customer'
      doc: 'Customer'
  opening_condition:
    0x4f:
      id: 'would_open'
      doc: 'Would Open'
    0x51:
      id: 'need_quote_to_open'
      doc: 'Need Quote To Open'
    0x42:
      id: 'need_more_buyers'
      doc: 'Need More Buyers'
    0x53:
      id: 'need_more_sellers'
      doc: 'Need More Sellers'
    0x43:
      id: 'crossed_composite_market'
      doc: 'Crossed Composite Market'
  width_type:
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x56:
      id: 'volatility'
      doc: 'Volatility'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'

