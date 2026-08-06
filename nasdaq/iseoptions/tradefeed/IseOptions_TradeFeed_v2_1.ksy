# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions TradeFeed Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Trade Feed
#   Encoding: Itch
#   Version: 2.1
#   Date: 02/13/2026
#   Specification: Options_Trade_Feed_2.1.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: iseoptions_tradefeed_v2_1
  title: Nasdaq IseOptions TradeFeed Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Trade Feed Itch v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

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
            'message_type::derivative_directory_message': derivative_directory_message
            'message_type::trading_action_message': trading_action_message
            'message_type::trade_message': trade_message
            'message_type::broken_trade_report_message': broken_trade_report_message
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
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
  derivative_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: security_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option root symbol (security symbol)'
      - id: expiration_year
        type: u1
        doc: 'Last two digits of the year of the option expiration'
      - id: expiration_month
        type: u1
        doc: 'Expiration Month of the option (1-12)'
      - id: expiration_day
        type: u1
        doc: 'Day of the Month of expiration (1-31)'
      - id: explicit_strike_price
        type: u4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Call, Put, or Not Applicable'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique symbol assigned to the underlying security within the Exchange System'
      - id: closing_type
        type: u1
        enum: closing_type
        doc: 'Denotes which System Event is used to determine when trading ceases in this symbol'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Denotes whether or not this option is tradable at the exchange'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the options security in the options market'
  trade_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: cross_id
        type: u4
        doc: 'Indicates the internal control number (cross id) associated with the given options trade transaction'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Trade Condition is the same as defined in the OPRA specification'
      - id: price
        type: u4
        doc: 'Reflects the transaction (premium) price on the execution'
      - id: volume
        type: u4
        doc: 'Current number of contracts traded for an option in one trade'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  broken_trade_report_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: original_cross_id
        type: u4
        doc: 'Indicates the internal control number (cross id) associated with the given options trade transaction'
      - id: original_price
        type: u4
        doc: 'Reported Premium Price of an option contract in the original trade report message on this feed'
      - id: original_volume
        type: u4
        doc: 'Reported number of contracts in the original trade report message on this feed'
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

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x6d:
      id: 'derivative_directory_message'
      doc: 'Derivative Directory Message for active options symbols.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x52:
      id: 'trade_message'
      doc: 'The Trade Report message will be used to relay execution system transactions that are reported during the current business day.'
    0x58:
      id: 'broken_trade_report_message'
      doc: 'The Broken Trade Report message is used in the event that an options trade transaction is broken on the same business day that it is reported.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process'
    0x4e:
      id: 'start_of_normal_hours_closing_process'
      doc: 'Start Of Normal Hours Closing Process'
    0x4c:
      id: 'start_of_late_hours_closing_process'
      doc: 'Start Of Late Hours Closing Process'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
    0x57:
      id: 'end_of_wco_early_closing'
      doc: 'End Of Wco Early Closing'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Not Tradable'
  mpv:
    0x45:
      id: 'penny_everywhere'
      doc: 'Penny Everywhere'
    0x53:
      id: 'scaled'
      doc: 'Scaled'
    0x50:
      id: 'penny_pilot'
      doc: 'Penny Pilot'
  current_trading_state:
    0x42:
      id: 'buy_side_suspended'
      doc: 'Buy Side Suspended'
    0x53:
      id: 'sell_side_suspended'
      doc: 'Sell Side Suspended'
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x49:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 're_opening'
      doc: 'Re Opening'
    0x58:
      id: 'closed'
      doc: 'Closed'

