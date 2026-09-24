# ---------------------------------------------------------------------
# Kaitai struct definition for: BruceAts BestBidAndOffer Itch v1.0
#
# Protocol:
#   Organization: Bruce ATS
#   Protocol: Best Bid And Offer
#   Encoding: Itch
#   Version: 1.0
#   Date: 03/01/2025
#   Specification: Bruce_Best_Bid_And_Offer.pdf
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
  id: bruceats_bruceequities_bestbidandoffer_itch_v1_0
  title: BruceAts BestBidAndOffer Itch v1.0
  license: GPL-3.0
  endian: be

doc: 'Bruce ATS Bruce ATS Equities Best Bid And Offer Itch v1.0'

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory': stock_directory
            'message_type::stock_trading_action': stock_trading_action
            'message_type::reg_sho_short_sale_price_test_restricted_indicator': reg_sho_short_sale_price_test_restricted_indicator
            'message_type::quotation_message': quotation_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Alway 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The system time when the outbound message was generated. Nanoseconds since Unix epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Denotes the type of event for which the message is being generated'
  stock_directory:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Alway 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The system time when the outbound message was generated. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market for the issue'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the number of shares that represent a round lot for the issue'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Flags whether the issue is treated by the Bruce ATS as a live/production symbol or a test symbol'
  stock_trading_action:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Alway 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The system time when the outbound message was generated. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'The current trading state for the issue'
  reg_sho_short_sale_price_test_restricted_indicator:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Alway 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The system time when the outbound message was generated. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  quotation_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Alway 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The system time when the outbound message was generated. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the execution system'
      - id: best_bid_price
        type: decimal_u8_4
        doc: 'The current best bid price for the buy orders posted in the Bruce ATS. Implied decimal with scale 1e-4'
      - id: best_bid_size
        type: u4
        doc: 'Aggregated number of shares available for buy orders posted on the Bruce ATS Best Bid Price'
      - id: best_offer_price
        type: decimal_u8_4
        doc: 'The current best offer price for the sell orders posted in the Bruce ATS. Implied decimal with scale 1e-4'
      - id: best_offer_size
        type: u4
        doc: 'Aggregated number of shares available for sell orders posted on the Bruce ATS Best Offer Price'
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

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The System Event message is used to communicate key market or data feed control events.'
    0x52:
      id: 'stock_directory'
      doc: 'At the start of each trading day, Bruce disseminates stock directory messages for all active symbols in its trading system.'
    0x48:
      id: 'stock_trading_action'
      doc: 'Bruce uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator'
      doc: 'For all exchange-listed issues, Bruce relays the Reg SHO Short Sale Price Test Restricted Indicator message when it receives an update from the primary listing exchange.'
    0x51:
      id: 'quotation_message'
      doc: 'BBBO will broadcast a real-time update every time that the system''s best bid and offer quote is updated during the trading day.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes That Bruce Last Sale Has Started Its Daily Transmission Schedule'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Denotes That Bruce Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Denotes That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'Denotes That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Denotes That Bruce Is Now Closed And Will Not Accept Any New Orders Today'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes That Bruce Last Sale Has Completed Its Daily Transmission Schedule'
  market_category:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors Exchange Llc'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx Exchange'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Paused In The Bruce Ats'
    0x54:
      id: 'trading'
      doc: 'Trading On The Bruce Ats'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_restriction_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'reg_sho_restriction_remains_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'

