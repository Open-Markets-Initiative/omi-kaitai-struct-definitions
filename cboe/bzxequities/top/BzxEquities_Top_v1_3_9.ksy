# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxEquities Top AsciiPitch v1.3.9
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Top
#   Encoding: Ascii Pitch
#   Version: 1.3.9
#   Date: 01/15/2025
#   Specification: Cboe_US_Equities_Summary_Depth_Feed_Specification.pdf
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
  id: cboe_bzxequities_top_asciipitch_v1_3_9
  title: Cboe BzxEquities Top AsciiPitch v1.3.9
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe Bzx Equities Top AsciiPitch v1.3.9'
doc-ref: http://markets.cboe.com/us/equities/support/technical

seq:
  - id: message_type
    type: u1
    enum: message_type_enum
    doc: 'Single ASCII byte identifying this packet type'
  - id: payload
    type:
      switch-on: message_type
      cases:
        'message_type_enum::logon_message': logon_message
        'message_type_enum::logon_rejected_message': logon_rejected_message
        'message_type_enum::seconds_message': seconds_message
        'message_type_enum::milliseconds_message': milliseconds_message
        'message_type_enum::expanded_spin_message': expanded_spin_message
        'message_type_enum::extended_spin_message': extended_spin_message
        'message_type_enum::expanded_bid_update_message': expanded_bid_update_message
        'message_type_enum::long_bid_update_message': long_bid_update_message
        'message_type_enum::short_bid_update_message': short_bid_update_message
        'message_type_enum::extended_bid_update_message': extended_bid_update_message
        'message_type_enum::expanded_ask_update_message': expanded_ask_update_message
        'message_type_enum::long_ask_update_message': long_ask_update_message
        'message_type_enum::short_ask_update_message': short_ask_update_message
        'message_type_enum::extended_ask_update_message': extended_ask_update_message
        'message_type_enum::expanded_two_sided_update_message': expanded_two_sided_update_message
        'message_type_enum::long_two_sided_update_message': long_two_sided_update_message
        'message_type_enum::short_two_sided_update_message': short_two_sided_update_message
        'message_type_enum::extended_two_sided_update_message': extended_two_sided_update_message
        'message_type_enum::expanded_trade_message': expanded_trade_message
        'message_type_enum::long_trade_message': long_trade_message
        'message_type_enum::short_trade_message': short_trade_message
        'message_type_enum::extended_trade_message': extended_trade_message
        'message_type_enum::trading_status_message': trading_status_message
  - id: top_lf
    type: u1
    doc: 'Terminating line feed character (0x0A)'

types:
  logon_message:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username, assigned by Cboe'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password, assigned by Cboe'
      - id: spin_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'If "Y", spin current top of book'
  logon_rejected_message:
    seq:
      - id: reject_reason
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"A" = Authentication or authorization problem (currently the only reason sent)'
  seconds_message:
    seq:
      - id: seconds
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of seconds since midnight; e.g,. 32400 = 9:00am'
  milliseconds_message:
    seq:
      - id: milliseconds
        type: str
        size: 3
        encoding: ASCII
        doc: 'Number of milliseconds since last Second message'
  expanded_spin_message:
    seq:
      - id: timestamp
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time of top of book update; milliseconds since midnight, Eastern time'
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-4'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
      - id: ask_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-4'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
      - id: last_trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time of last trade; milliseconds since midnight, Eastern time'
      - id: last_trade_price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'Last trade price; 0 if no trades. Implied decimal with scale 1e-4'
      - id: last_trade_size
        type: str
        size: 6
        encoding: ASCII
        doc: 'Last trade size; 0 if no trades'
      - id: cumulative_volume_long
        type: str
        size: 9
        encoding: ASCII
        doc: 'Cumulative volume executed today; 0 if no trades'
      - id: halt_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Halt Status'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reserved_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  extended_spin_message:
    seq:
      - id: timestamp
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time of top of book update; milliseconds since midnight, Eastern time'
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_extended
        type: str
        size: 14
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-2'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
      - id: ask_price_extended
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-2'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
      - id: last_trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time of last trade; milliseconds since midnight, Eastern time'
      - id: last_trade_price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'Last trade price; 0 if no trades. Implied decimal with scale 1e-2'
      - id: last_trade_size
        type: str
        size: 6
        encoding: ASCII
        doc: 'Last trade size; 0 if no trades'
      - id: cumulative_volume_long
        type: str
        size: 9
        encoding: ASCII
        doc: 'Cumulative volume executed today; 0 if no trades'
      - id: halt_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Halt Status'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reserved_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  expanded_bid_update_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-4'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
  long_bid_update_message:
    seq:
      - id: symbol_long
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-4'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
  short_bid_update_message:
    seq:
      - id: symbol_short
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-2'
      - id: bid_quantity_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid size; 0 if no bids'
  extended_bid_update_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_extended
        type: str
        size: 14
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-2'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
  expanded_ask_update_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: ask_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-4'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
  long_ask_update_message:
    seq:
      - id: symbol_long
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: ask_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-4'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
  short_ask_update_message:
    seq:
      - id: symbol_short
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: ask_price_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-2'
      - id: ask_quantity_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask size; 0 if no offers'
  extended_ask_update_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: ask_price_extended
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-2'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
  expanded_two_sided_update_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-4'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
      - id: ask_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-4'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
  long_two_sided_update_message:
    seq:
      - id: symbol_long
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-4'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
      - id: ask_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-4'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
  short_two_sided_update_message:
    seq:
      - id: symbol_short
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-2'
      - id: bid_quantity_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid size; 0 if no bids'
      - id: ask_price_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-2'
      - id: ask_quantity_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask size; 0 if no offers'
  extended_two_sided_update_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: bid_price_extended
        type: str
        size: 14
        encoding: ASCII
        doc: 'Bid price; 0 if no bids. Implied decimal with scale 1e-2'
      - id: bid_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Bid quantity; 0 if no bids'
      - id: ask_price_extended
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ask price; 0 if no offers. Implied decimal with scale 1e-2'
      - id: ask_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Ask quantity; 0 if no offers'
  expanded_trade_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: last_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Last trade price. Implied decimal with scale 1e-4'
      - id: last_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Last trade quantity'
      - id: cumulative_volume_long
        type: str
        size: 9
        encoding: ASCII
        doc: 'Cumulative volume executed today; 0 if no trades'
  long_trade_message:
    seq:
      - id: symbol_long
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: last_price_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Last trade price. Implied decimal with scale 1e-4'
      - id: last_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Last trade quantity'
      - id: cumulative_volume_long
        type: str
        size: 9
        encoding: ASCII
        doc: 'Cumulative volume executed today; 0 if no trades'
  short_trade_message:
    seq:
      - id: symbol_short
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: last_price_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Last trade price. Implied decimal with scale 1e-2'
      - id: last_quantity_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Last trade quantity'
      - id: cumulative_volume_short
        type: str
        size: 7
        encoding: ASCII
        doc: 'Cumulative number of shares traded today'
  extended_trade_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: last_price_extended
        type: str
        size: 14
        encoding: ASCII
        doc: 'Last trade price. Implied decimal with scale 1e-2'
      - id: last_quantity_long
        type: str
        size: 6
        encoding: ASCII
        doc: 'Last trade quantity'
      - id: cumulative_volume_long
        type: str
        size: 9
        encoding: ASCII
        doc: 'Cumulative volume executed today; 0 if no trades'
  trading_status_message:
    seq:
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: halt_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Halt Status'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reserved_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'

enums:
  message_type_enum:
    0x4c:
      id: 'logon_message'
      doc: 'Logon Message'
    0x4a:
      id: 'logon_rejected_message'
      doc: 'Logon Rejected Message'
    0x54:
      id: 'seconds_message'
      doc: 'Sent for every second for which at least one message is being generated.'
    0x4d:
      id: 'milliseconds_message'
      doc: 'Sent for every millisecond for which at least one message is being generated.'
    0x43:
      id: 'logon_accepted_message'
      doc: 'Logon Accepted Message'
    0x73:
      id: 'expanded_spin_message'
      doc: 'Expanded Spin Message'
    0x53:
      id: 'extended_spin_message'
      doc: 'Extended Spin Message'
    0x44:
      id: 'spin_done_message'
      doc: 'Spin Done Message'
    0x48:
      id: 'server_heartbeat_message'
      doc: 'Server Heartbeat Message'
    0x52:
      id: 'client_heartbeat_message'
      doc: 'Client Heartbeat Message'
    0x45:
      id: 'expanded_bid_update_message'
      doc: 'Expanded Bid Update Message'
    0x42:
      id: 'long_bid_update_message'
      doc: 'Long Bid Update Message'
    0x62:
      id: 'short_bid_update_message'
      doc: 'Short Bid Update Message'
    0x4e:
      id: 'extended_bid_update_message'
      doc: 'Extended Bid Update Message'
    0x65:
      id: 'expanded_ask_update_message'
      doc: 'Expanded Ask Update Message'
    0x41:
      id: 'long_ask_update_message'
      doc: 'Long Ask Update Message'
    0x61:
      id: 'short_ask_update_message'
      doc: 'Short Ask Update Message'
    0x6e:
      id: 'extended_ask_update_message'
      doc: 'Extended Ask Update Message'
    0x46:
      id: 'expanded_two_sided_update_message'
      doc: 'Expanded Two-Sided Update Message'
    0x55:
      id: 'long_two_sided_update_message'
      doc: 'Long Two-Sided Update Message'
    0x75:
      id: 'short_two_sided_update_message'
      doc: 'Short Two-Sided Update Message'
    0x64:
      id: 'extended_two_sided_update_message'
      doc: 'Extended Two-Sided Update Message'
    0x66:
      id: 'expanded_trade_message'
      doc: 'Expanded Trade Message'
    0x56:
      id: 'long_trade_message'
      doc: 'Long Trade Message'
    0x76:
      id: 'short_trade_message'
      doc: 'Short Trade Message'
    0x72:
      id: 'extended_trade_message'
      doc: 'Extended Trade Message'
    0x74:
      id: 'trading_status_message'
      doc: 'The Trading Status Message is used to indicate the current trading status of a security.'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_price_test_restriction_in_effect'
      doc: 'Reg Sho Price Test Restriction In Effect'

