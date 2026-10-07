# ---------------------------------------------------------------------
# Kaitai struct definition for: BruceAts DepthOfBook Itch v3.3
#
# Protocol:
#   Organization: Bruce ATS
#   Protocol: Depth Of Book
#   Encoding: Itch
#   Version: 3.3
#   Date: 08/11/2026
#   Specification: Bruce ATS ITCH Specification v3.3.pdf
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
  id: bruceats_bruceequities_depthofbook_itch_v3_3
  title: BruceAts DepthOfBook Itch v3.3
  license: GPL-3.0
  endian: be

doc: 'Bruce ATS Bruce ATS Equities Depth Of Book Itch v3.3'

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
            'message_type::stock_directory_message': stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::add_order_message': add_order_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_replace_message': order_replace_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::trade_break_message': trade_break_message
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
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: event_code
        type: u1
        enum: event_code
  stock_directory_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: round_lot_size
        type: u4
        doc: 'Denotes the number of shares that represent a round lot for the issue'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Flags whether an issue is treated by Bruce ATS as a live/production symbol or a test symbol'
  stock_trading_action_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Indicates the current trading state for the stock'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  add_order_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: price
        type: decimal_u8_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
  order_executed_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u8
        doc: 'The Bruce ATS generated day unique Match Number of this execution'
  order_cancel_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
      - id: cancelled_shares
        type: u4
        doc: 'The number of shares being removed from the order'
  order_delete_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order at the time of receipt'
  order_replace_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: original_order_reference_number
        type: u8
        doc: 'The original order reference number of the order being replaced'
      - id: new_order_reference_number
        type: u8
        doc: 'The new reference number for this order at time of replacement'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: price
        type: decimal_u8_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
  trade_correction_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_number
        type: u8
        doc: 'The Bruce ATS generated day unique Match Number of this execution'
      - id: new_match_number
        type: u8
        doc: 'The Bruce ATS match number assigned to the adjusted execution'
      - id: shares
        type: u4
        doc: 'The total number of shares associated with the order being added to the book'
      - id: price
        type: decimal_u8_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
  trade_break_message:
    seq:
      - id: stock_locate
        type: u2
        doc: 'Always 0'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_number
        type: u8
        doc: 'The Bruce ATS generated day unique Match Number of this execution'
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
      doc: 'The System Event message is used to communicate key market or data feed handler events.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading session, Bruce ATS disseminates stock directory messages for all active symbols in its trading system.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Bruce ATS uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'For all issues, Bruce ATS relays the Reg SHO Short Sale Price Test Restricted Indicator message when it receives an update from the primary listing exchange.'
    0x41:
      id: 'add_order_message'
      doc: 'This message will be generated for orders accepted by the Bruce ATS system and added to the book.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being cancelled.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancel-replaced.'
    0x43:
      id: 'trade_correction_message'
      doc: 'In the rare case that an adjustment to previously communicated trade / order execution, the Trade Correction Message will be used to communicate the required updates.'
    0x42:
      id: 'trade_break_message'
      doc: 'The Broken Trade Message is sent whenever an execution on Bruce ATS is broken.'
  event_code:
    0x4f:
      id: 'start_of_transmission'
      doc: 'Denotes That Total View Itch Has Started Its Daily Transmission Schedule'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Denotes That Bruce Ats Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Denotes The Start Of Bruce Ats Market Hours And Orders Are Now Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'Denotes The End Of Bruce Ats Market Hours And Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Denotes That Bruce Ats Is Now Closed And Will Not Accept Any New Orders'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes That Total View Itch Has Completed Its Daily Transmission Schedule'
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
      doc: 'Halted Paused On Bruce Ats'
    0x54:
      id: 'trading'
      doc: 'Trading On Nasdaq'
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
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'

