# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PhlxOptions Quoting Sqf v9.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Specialized Quote Interface
#   Encoding: Specialized Quote Interface
#   Version: 9.0
#   Date: 09/22/2026
#   Specification: Options_ETH_SQF.pdf
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
  id: nasdaq_phlxoptions_quoting_sqf_v9_0_server
  title: Nasdaq PhlxOptions Quoting Sqf v9.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PHLX Specialized Quote Interface Sqf v9.0'
doc-ref:
  - https://www.nasdaq.com/products/north-american-markets/resources/options-specifications-and-resources-hub
  - https://www.nasdaq.com/Options_ETH_SQF
  - https://www.nasdaq.com/Options_SQF

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
            'server_packet_type::unsequenced_data_packet': server_unsequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size-eos: true
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two character SQF Message Type (Type/Subtype) of the sequenced message'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 3
        type:
          switch-on: sequenced_message_type
          cases:
            '"SA"': msar_accept_message
            '"SR"': msar_reject_message
            '"SY"': complex_msar_accept_message
            '"SN"': complex_msar_reject_message
            '"AP"': underlying_permission_notification_message
            '"AJ"': mm_parameter_definition_notification_message
            '"Af"': rapid_fire_config_notification_message
            '"AK"': active_qp_self_replenishment_parameter_definition_notification_message
            '"AS"': system_event_message
            '"AD"': simple_instrument_directory_message
            '"AR"': complex_instrument_directory_message
            '"AH"': simple_instrument_trading_action_message
            '"AI"': complex_instrument_trading_action_message
            '"NE"': simple_quote_execution_notification_message
            '"NV"': complex_quote_execution_notification_message
            '"NW"': complex_quote_leg_execution_notification_message
            '"NS"': simple_msar_notification_message
            '"NL"': complex_msar_leg_notification_message
            '"NX"': complex_msar_notification_message
            '"AM"': opening_rotation_quote_spread_multiplier_notification_message
  msar_accept_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: msar_type
        type: u1
        enum: msar_type
        doc: 'A=Auction Response, M=SQF Market Sweep'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which to sweep. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
  msar_reject_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
  complex_msar_accept_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: msar_type
        type: u1
        enum: msar_type
        doc: 'A=Auction Response, M=SQF Market Sweep'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which to sweep. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
      - id: price_protection
        type: u1
        enum: price_protection
        doc: 'L=Local Market, N=National Market'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future enhancements'
  complex_msar_reject_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
  underlying_permission_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: underlying
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Stock Symbol'
      - id: permitted
        type: u1
        enum: permitted
        doc: 'Y=Permitted, N=Not Permitted'
  mm_parameter_definition_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'S=Simple Instruments, C=Complex Instruments'
      - id: underlying
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Stock Symbol'
      - id: interval
        type: u2
        doc: 'Time interval (in milliseconds) 100 <= n <= 30,000'
      - id: percentage
        type: u2
        doc: 'Displayed size percentage 1 <= n <= MAX INT'
      - id: cum_qty
        type: u4
        doc: 'Total execution volume that will trigger a rapid fire within the interval 1 <= n <= MAX_INT'
      - id: delta
        type: u4
        doc: '1 <= n <= MAX_INT'
      - id: vega
        type: u4
        doc: '1 <= n <= MAX_INT'
      - id: reserved_32
        size: 32
        doc: 'Reserved for future enhancements'
  rapid_fire_config_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: underlying
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Stock Symbol'
      - id: percentage
        type: u2
        doc: 'Displayed size percentage 1 <= n <= MAX INT'
      - id: interval
        type: u2
        doc: 'Time interval (in milliseconds) 100 <= n <= 30,000'
      - id: volume
        type: u4
        doc: 'Total execution volume that will trigger a rapid fire interval within the interval'
  active_qp_self_replenishment_parameter_definition_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: underlying
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Stock Symbol'
      - id: set_contract_limit
        type: u4
        doc: 'Current Set Contract limit for triggering purge'
      - id: reserved_32
        size: 32
        doc: 'Reserved for future enhancements'
  system_event_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Codes'
      - id: version
        type: u1
        doc: 'Version of the SQF Quote Interface. Currently set to 9'
      - id: subversion
        type: u1
        doc: 'Sub-version of the SQF Quote Interface. Currently set to 0'
  simple_instrument_directory_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: security_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Industry assigned security symbol for the option contract'
      - id: expiration
        type: u2
        doc: 'Expiration Field: year (bits 0-6, 0-99), month (bits 7-10) and day (bits 11-15) encoded into a 2 byte integer; bit 15 is the least significant bit'
      - id: strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'C=Call, P=Put'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique underlying stock symbol for the option symbol. Normally matches the stock symbol'
      - id: closing_type
        type: u1
        enum: closing_type
        doc: 'N=Normal Hours, L=Late Hours, W=WCO Early Closing 12:00 Noon, E=Extended Close (extended trading hours edition)'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Y=Option is tradable, N=Option is not tradable'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'See MPV'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  complex_instrument_directory_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique underlying stock symbol for the option symbol. Normally matches the stock symbol'
      - id: reserved_1
        size: 1
        doc: 'Reserved field with value zero'
      - id: num_complex_legs
        type: u1
        doc: 'Number of legs in the combo'
      - id: complex_legs
        type: complex_legs
        repeat: expr
        repeat-expr: num_complex_legs
        doc: 'Leg Definitions, Repeated Number Of Legs times'
  complex_legs:
    seq:
      - id: leg_instrument_id
        type: u4
        doc: 'Leg Instrument ID, 0 (zero) for stock leg'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'B=Buy side sweep (Leg), S=Sell side sweep (Leg)'
      - id: leg_ratio
        type: u4
        doc: 'Strategy Leg Ratio'
  simple_instrument_trading_action_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'H=Halt in effect, T=Trading Resumed'
  complex_instrument_trading_action_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'H=Halt in effect, T=Trading Resumed'
  simple_quote_execution_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which to sweep. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Liquidity Indicator'
      - id: cross_id
        type: u4
        doc: 'Identifies the execution. Can be matched with the Cross Id in the Clearing Trade Interface (CTI) messages'
      - id: match_id
        type: u4
        doc: 'Identifies the component of an execution'
  complex_quote_execution_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price_6
        type: decimal_s8_6
        doc: 'Execution Price (6.6 format). Implied decimal with scale 1e-6'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Liquidity Indicator'
      - id: cross_id
        type: u4
        doc: 'Identifies the execution. Can be matched with the Cross Id in the Clearing Trade Interface (CTI) messages'
      - id: match_id
        type: u4
        doc: 'Identifies the component of an execution'
  complex_quote_leg_execution_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: leg_instrument_id
        type: u4
        doc: 'Leg Instrument ID, 0 (zero) for stock leg'
      - id: leg_id
        type: u1
        doc: 'Leg reference of the strategy involved in the execution: the index of the leg, starting at zero, in the Complex Instrument Directory message'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price_6
        type: decimal_s8_6
        doc: 'Execution Price (6.6 format). Implied decimal with scale 1e-6'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Liquidity Indicator'
      - id: cross_id
        type: u4
        doc: 'Identifies the execution. Can be matched with the Cross Id in the Clearing Trade Interface (CTI) messages'
      - id: match_id
        type: u4
        doc: 'Identifies the component of an execution'
  simple_msar_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: notification_type
        type: u1
        enum: notification_type
        doc: 'E=Executed, C=Cancelled'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which to sweep. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Liquidity Indicator'
      - id: cross_id
        type: u4
        doc: 'Identifies the execution. Can be matched with the Cross Id in the Clearing Trade Interface (CTI) messages'
      - id: match_id
        type: u4
        doc: 'Identifies the component of an execution'
  complex_msar_leg_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: leg_id
        type: u1
        doc: 'Leg reference of the strategy involved in the execution: the index of the leg, starting at zero, in the Complex Instrument Directory message'
      - id: leg_instrument_id
        type: u4
        doc: 'Leg Instrument ID, 0 (zero) for stock leg'
      - id: notification_type
        type: u1
        enum: notification_type
        doc: 'E=Executed, C=Cancelled'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which to sweep. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'B=Buy side sweep (Leg), S=Sell side sweep (Leg)'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Liquidity Indicator'
      - id: cross_id
        type: u4
        doc: 'Identifies the execution. Can be matched with the Cross Id in the Clearing Trade Interface (CTI) messages'
      - id: match_id
        type: u4
        doc: 'Identifies the component of an execution'
      - id: price_6
        type: decimal_s8_6
        doc: 'Execution Price (6.6 format). Implied decimal with scale 1e-6'
  complex_msar_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: notification_type
        type: u1
        enum: notification_type
        doc: 'E=Executed, C=Cancelled'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which to sweep. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: contracts
        type: u4
        doc: 'Volume of contracts to sweep'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Liquidity Indicator'
      - id: cross_id
        type: u4
        doc: 'Identifies the execution. Can be matched with the Cross Id in the Clearing Trade Interface (CTI) messages'
      - id: match_id
        type: u4
        doc: 'Identifies the component of an execution'
      - id: price_6
        type: decimal_s8_6
        doc: 'Execution Price (6.6 format). Implied decimal with scale 1e-6'
  opening_rotation_quote_spread_multiplier_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique underlying stock symbol for the option symbol. Normally matches the stock symbol'
      - id: multiplier
        type: u1
        doc: 'Spread Multiplier'
  server_unsequenced_data_packet:
    seq:
      - id: server_unsequenced_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Two character SQF Message Type (Type/Subtype) of the unsequenced message sent by the server'
      - id: server_unsequenced_message
        size: _parent.server_packet_header.packet_length - 3
        type:
          switch-on: server_unsequenced_message_type
          cases:
            '"Ab"': notification_subscription_reply_message
            '"Ac"': add_complex_instrument_reply_message
            '"Ae"': mm_parameter_definition_reply_message
            '"Ag"': active_qp_self_replenishment_set_limit_reply_message
            '"AA"': rapid_fire_config_reply_message
            '"QS"': quote_block_reply_message
            '"Qs"': detailed_quote_block_reply_message
            '"Pr"': underlying_purge_reply_message
            '"RR"': market_reentry_reply_message
            '"Rg"': active_qp_self_replenishment_request_reentry_reply_message
            '"NA"': auction_notification_message
            '"ND"': instrument_purge_notification_message
            '"NU"': underlying_purge_notification_message
            '"NR"': market_reentry_notification_message
  notification_subscription_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
  add_complex_instrument_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
  mm_parameter_definition_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
  active_qp_self_replenishment_set_limit_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique underlying stock symbol for the option symbol. Normally matches the stock symbol'
      - id: set_value
        type: u4
        doc: 'Absolute value of new contract limit for self-replenishment purge'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
  rapid_fire_config_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
  quote_block_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: sent_timestamp
        type: u8
        doc: 'UNIX epoch time in nanoseconds. Time the message is sent to the Exchange; passed to CAT'
      - id: block_status_code
        type: u1
        enum: block_status_code
        doc: 'See Status Code Appendix'
      - id: quote_count
        type: u2
        doc: 'Number of quotes in the message (1 to 200)'
      - id: num_quote_responses
        type: u2
        doc: 'The number of valid quotes in the submitted quote block. A valid quote is a quote or purge (0 x 0 quote) that has a Quote Status Code of space'
      - id: quote_responses
        type: quote_responses
        repeat: expr
        repeat-expr: num_quote_responses
        doc: '1-200 quote responses of a Quote Block Reply, one per quote of the submitted block'
  quote_responses:
    seq:
      - id: quote_status_code
        type: u1
        enum: quote_status_code
        doc: 'See Status Code Appendix'
      - id: sequence
        type: u8
        doc: 'Relative sequence of the underlying purge processed by the matching engine. Quotes/purges with higher sequence number occur after quotes/purges with lower sequence number'
  detailed_quote_block_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: sent_timestamp
        type: u8
        doc: 'UNIX epoch time in nanoseconds. Time the message is sent to the Exchange; passed to CAT'
      - id: block_status_code
        type: u1
        enum: block_status_code
        doc: 'See Status Code Appendix'
      - id: quote_count
        type: u2
        doc: 'Number of quotes in the message (1 to 200)'
      - id: num_detailed_quote_responses
        type: u2
        doc: 'The number of valid quotes in the submitted quote block. A valid quote is a quote or purge (0 x 0 quote) that has a Quote Status Code of space'
      - id: detailed_quote_responses
        type: detailed_quote_responses
        repeat: expr
        repeat-expr: num_detailed_quote_responses
        doc: '1-200 quote responses of a Detailed Quote Block Reply, one per quote of the submitted block'
  detailed_quote_responses:
    seq:
      - id: quote_status_code
        type: u1
        enum: quote_status_code
        doc: 'See Status Code Appendix'
      - id: sequence
        type: u8
        doc: 'Relative sequence of the underlying purge processed by the matching engine. Quotes/purges with higher sequence number occur after quotes/purges with lower sequence number'
      - id: bid_sequence
        type: u8
        doc: 'Day-unique order reference number assigned by NASDAQ to the Bid side of the quote'
      - id: ask_sequence
        type: u8
        doc: 'Day-unique order reference number assigned by NASDAQ to the Sell side of the quote'
  underlying_purge_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: sent_timestamp
        type: u8
        doc: 'UNIX epoch time in nanoseconds. Time the message is sent to the Exchange; passed to CAT'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
      - id: sequence
        type: u8
        doc: 'Relative sequence of the underlying purge processed by the matching engine. Quotes/purges with higher sequence number occur after quotes/purges with lower sequence number'
  market_reentry_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
      - id: reserved_8
        size: 8
        doc: 'Unused'
  active_qp_self_replenishment_request_reentry_reply_message:
    seq:
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique underlying stock symbol for the option symbol. Normally matches the stock symbol'
      - id: status_code
        type: u1
        enum: status_code
        doc: 'See Status Code Appendix'
      - id: requested_replenishment_value
        type: u4
        doc: 'Echo requested replenishment value'
      - id: active_counter_value
        type: u4
        doc: 'Risk counter value after processing replenishment request'
      - id: set_contract_limit
        type: u4
        doc: 'Current Set Contract limit for triggering purge'
  auction_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'S=Simple Instruments, C=Complex Instruments'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: auction_id
        type: u4
        doc: 'The exchange assigned Auction ID as provided in the Auction Notification message if applicable'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'L=Limit, M=Market, N=Not Disclosed'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy side sweep, S=Sell side sweep'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which to sweep. Implied decimal with scale 1e-4'
      - id: matched_volume
        type: u4
        doc: 'For Opening Auction indicates matched volume at the specified price; for all other auction types set to 0'
      - id: volume
        type: u4
        doc: 'Total execution volume that will trigger a rapid fire interval within the interval'
      - id: exec_flag
        type: u1
        enum: exec_flag
        doc: '0=None, 1=AON'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Capacity Indicator. Not displayed for NOM and NTX Options'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spaces when auction not flagged Attributable'
      - id: occ_account
        type: u4
        doc: 'Account number used for clearing give up. 0 when auction not flagged Attributable'
      - id: cmta
        type: u4
        doc: '0 when auction not flagged Attributable'
      - id: auction_event
        type: u1
        enum: auction_event
        doc: 'S=Start, U=Auction Update, E=End of Auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type Field'
      - id: auction_duration
        type: u4
        doc: 'Duration of the auction'
      - id: best_response_price
        type: decimal_s4_4
        doc: 'Best response price; 0 if not disclosed. Implied decimal with scale 1e-4'
      - id: best_response_size
        type: u4
        doc: 'Aggregated quantity at best response price; 0 if not disclosed'
      - id: reserved_9
        size: 9
        doc: 'Reserved for future use'
      - id: num_flex_dac_legs
        type: u1
        doc: 'To be used in future to support Delta-Adjusted at Close functionality on Flex'
      - id: flex_dac_legs
        type: flex_dac_legs
        repeat: expr
        repeat-expr: num_flex_dac_legs
        doc: 'Auction Notification leg definitions, to be used in future to support Delta-Adjusted at Close functionality on Flex'
  flex_dac_legs:
    seq:
      - id: reserved_8
        size: 8
        doc: 'Unused'
  instrument_purge_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: instrument_id
        type: u4
        doc: 'Simple Instrument ID'
      - id: purge_reason
        type: u1
        enum: purge_reason
        doc: 'S=System initiated, Q=Anti-Internalize'
      - id: sequence
        type: u8
        doc: 'Relative sequence of the underlying purge processed by the matching engine. Quotes/purges with higher sequence number occur after quotes/purges with lower sequence number'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  underlying_purge_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: underlying
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Stock Symbol'
      - id: purge_reason
        type: u1
        enum: purge_reason
        doc: 'S=System initiated, Q=Anti-Internalize'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: sequence
        type: u8
        doc: 'Relative sequence of the underlying purge processed by the matching engine. Quotes/purges with higher sequence number occur after quotes/purges with lower sequence number'
  market_reentry_notification_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of the timestamp: whole seconds after midnight, US Eastern Time (0 to 86399)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp (0 to 999999999)'
      - id: badge
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique underlying stock symbol for the option symbol. Normally matches the stock symbol'
      - id: reentry_scope
        type: u1
        enum: reentry_scope
        doc: 'N=User requested (Simple Instruments), n=User requested (Complex Instruments), K=Post-Killswitch (All Instruments)'
      - id: message_id
        type: u8
        doc: 'Message ID. Binary data type: any combination of bits'
      - id: reserved_8
        size: 8
        doc: 'Unused'
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  leg_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  instrument_type:
    0x53:
      id: 'simple_instruments'
      doc: 'Simple Instruments'
    0x43:
      id: 'complex_instruments'
      doc: 'Complex Instruments'
    0x4f:
      id: 'simple_instrument'
      doc: 'Simple Instrument Underlying Purge And Market Reentry Requests'
  reentry_indicator:
    0x4e:
      id: 'normal'
      doc: 'Normal Not Applicable On Complex Quotes'
    0x52:
      id: 'reentry'
      doc: 'Reentry'
  stock_leg_short_sale:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x48:
      id: 'sell_short'
      doc: 'Sell Short'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  msar_type:
    0x41:
      id: 'auction_response'
      doc: 'Auction Response'
    0x4d:
      id: 'market_sweep'
      doc: 'Sqf Market Sweep'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Side Bought On Quote Executions'
    0x53:
      id: 'sell'
      doc: 'Sell Side Sold On Quote Executions'
    0x2a:
      id: 'not_disclosed'
      doc: 'Not Disclosed Auction Notification'
    0x54:
      id: 'buy_short'
      doc: 'Buy Book Side Short'
    0x58:
      id: 'buy_short_exempt'
      doc: 'Buy Book Side Short Exempt'
    0x59:
      id: 'sell_short'
      doc: 'Sell Book Side Short'
    0x5a:
      id: 'sell_short_exempt'
      doc: 'Sell Book Side Short Exempt'
  debit_credit:
    0x44:
      id: 'debit'
      doc: 'Sweep Price Is Debit'
    0x43:
      id: 'credit'
      doc: 'Sweep Price Is Credit'
    0x20:
      id: 'zero'
      doc: 'Sweep Price Is 0.0'
  price_protection:
    0x4c:
      id: 'local'
      doc: 'Local Market'
    0x4e:
      id: 'national'
      doc: 'National Market'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SoupbinTcp Unsequenced Data Packet sent by the server'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  status_code:
    0x20:
      id: 'valid_request'
      doc: 'Valid Request'
    0x41:
      id: 'invalid_badge'
      doc: 'Invalid Badge'
    0x42:
      id: 'invalid_instrument_underlying'
      doc: 'Invalid Instrument Underlying'
    0x43:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x44:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x45:
      id: 'invalid_size'
      doc: 'Invalid Size'
    0x46:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x47:
      id: 'invalid_spread'
      doc: 'Invalid Spread'
    0x48:
      id: 'invalid_indicator_attribute'
      doc: 'Invalid Indicator Attribute'
    0x49:
      id: 'reentry_required'
      doc: 'Reentry Required'
    0x4a:
      id: 'opening_rotation_in_progress'
      doc: 'Opening Rotation In Progress'
    0x4b:
      id: 'kill_switch_reentry_required'
      doc: 'Kill Switch Reentry Required'
    0x4c:
      id: 'full_replenishment_required'
      doc: 'Full Replenishment Required'
    0x4d:
      id: 'active_counter_exceeded'
      doc: 'Active Counter Exceeded'
    0x4e:
      id: 'too_late_to_act'
      doc: 'Too Late To Act'
    0x50:
      id: 'not_in_free_trading'
      doc: 'Not In Free Trading'
    0x51:
      id: 'invalid_auction_information'
      doc: 'Invalid Auction Information'
    0x52:
      id: 'market_closed'
      doc: 'Market Closed'
    0x53:
      id: 'post_only_reprice'
      doc: 'Post Only Reprice'
    0x54:
      id: 'request_pending'
      doc: 'Request Pending'
    0x59:
      id: 'invalid_format_bad_block'
      doc: 'Invalid Format Bad Block'
    0x5a:
      id: 'system_error'
      doc: 'System Error'
  permitted:
    0x59:
      id: 'permitted'
      doc: 'Permitted'
    0x4e:
      id: 'not_permitted'
      doc: 'Not Permitted'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages This Is Always The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours The System Is Up And Ready To Start Accepting Orders'
    0x42:
      id: 'start_of_quote'
      doc: 'Start Of Quote Quotes Sent To The System Will Now Be Added To The Book And Considered For Execution When Trading Starts On This Option'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process'
    0x57:
      id: 'end_of_wco_early_closing'
      doc: 'End Of Wco Early Closing No New Orders Or Changes To Existing Orders On Last Trading Date Of Wco Options'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End Of Normal Hours Processing'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End Of Late Hours Processing'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours The System Is Now Closed'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages This Is Always The Last Message Sent In Any Trading Day'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing 1200 Noon'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Option Is Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Option Is Not Tradable'
  mpv:
    0x45:
      id: 'penny_everywhere'
      doc: 'All Prices Are In Penny Increments'
    0x53:
      id: 'scaled'
      doc: 'Prices Below 3.00 Are In Increments Of 0.05 Prices Above 3.00 In Increments Of 0.10'
    0x50:
      id: 'penny_pilot'
      doc: 'Prices Below 3.00 Are In Increments Of 0.01 Prices Above 3.00 In Increments Of 0.05'
  trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'trading_resumed'
      doc: 'Trading Resumed'
  liquidity_indicator:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'maker'
      doc: 'Maker'
    2:
      id: 'taker'
      doc: 'Taker'
    4:
      id: 'response'
      doc: 'Response'
    5:
      id: 'hidden'
      doc: 'Hidden'
    6:
      id: 'opening_rotation'
      doc: 'Opening Rotation'
    7:
      id: 'cross'
      doc: 'Cross'
    8:
      id: 'flashed_order'
      doc: 'Flashed Order'
    9:
      id: 'flash_response'
      doc: 'Flash Response'
    10:
      id: 'routed_out'
      doc: 'Routed Out'
    11:
      id: 'trade_report'
      doc: 'Trade Report'
    12:
      id: 'combo_maker_against_combo'
      doc: 'Combo Maker Against Combo'
    13:
      id: 'combo_taker_against_combo'
      doc: 'Combo Taker Against Combo'
    14:
      id: 'combo_response_against_combo'
      doc: 'Combo Response Against Combo'
    15:
      id: 'combo_hidden_against_combo'
      doc: 'Combo Hidden Against Combo'
    16:
      id: 'combo_opening_rotation'
      doc: 'Combo Opening Rotation'
    17:
      id: 'combo_cross'
      doc: 'Combo Cross'
    18:
      id: 'combo_taker_against_regular'
      doc: 'Combo Taker Against Regular'
    19:
      id: 'regular_maker_against_combo'
      doc: 'Regular Maker Against Combo'
    20:
      id: 'combo_taker_against_io'
      doc: 'Combo Taker Against Io'
    21:
      id: 'regular_incl_pim_taker_against_io'
      doc: 'Regular Incl Pim Taker Against Io'
    22:
      id: 'io_maker_against_combo'
      doc: 'Io Maker Against Combo'
    23:
      id: 'io_maker_against_regular'
      doc: 'Io Maker Against Regular'
    24:
      id: 'regular_maker_against_io_participant'
      doc: 'Regular Maker Against Io Participant'
    25:
      id: 'io_participant_taker_against_regular'
      doc: 'Io Participant Taker Against Regular'
    26:
      id: 'broken_price_improvement'
      doc: 'Broken Price Improvement'
    27:
      id: 'broken_facilitation'
      doc: 'Broken Facilitation'
    28:
      id: 'broken_solicitation'
      doc: 'Broken Solicitation'
    29:
      id: 'combo_broken_price_improvement'
      doc: 'Combo Broken Price Improvement'
    30:
      id: 'combo_broken_facilitation'
      doc: 'Combo Broken Facilitation'
    31:
      id: 'combo_broken_solicitation'
      doc: 'Combo Broken Solicitation'
    32:
      id: 'block'
      doc: 'Block'
    33:
      id: 'block_response'
      doc: 'Block Response'
    34:
      id: 'directed_response'
      doc: 'Directed Response'
    35:
      id: 'facilitation'
      doc: 'Facilitation'
    36:
      id: 'facilitation_response'
      doc: 'Facilitation Response'
    37:
      id: 'price_improvement'
      doc: 'Price Improvement'
    38:
      id: 'price_improvement_response'
      doc: 'Price Improvement Response'
    39:
      id: 'solicitation'
      doc: 'Solicitation'
    40:
      id: 'solicitation_response'
      doc: 'Solicitation Response'
    41:
      id: 'qualified_contingent_cross'
      doc: 'Qualified Contingent Cross'
    42:
      id: 'customer_to_customer'
      doc: 'Customer To Customer'
    43:
      id: 'combo_facilitation'
      doc: 'Combo Facilitation'
    44:
      id: 'combo_facilitation_response'
      doc: 'Combo Facilitation Response'
    45:
      id: 'combo_price_improvement'
      doc: 'Combo Price Improvement'
    46:
      id: 'combo_price_improvement_response'
      doc: 'Combo Price Improvement Response'
    47:
      id: 'combo_solicitation'
      doc: 'Combo Solicitation'
    48:
      id: 'combo_solicitation_response'
      doc: 'Combo Solicitation Response'
    49:
      id: 'combo_qualified_contingent_cross'
      doc: 'Combo Qualified Contingent Cross'
    50:
      id: 'combo_customer_to_customer'
      doc: 'Combo Customer To Customer'
    51:
      id: 'sweep_routed_out'
      doc: 'Sweep Routed Out'
    52:
      id: 'sweep_trade_report'
      doc: 'Sweep Trade Report'
    53:
      id: 'combo_taker_against_regular_thru_nbbo'
      doc: 'Combo Taker Against Regular Thru Nbbo'
    54:
      id: 'combo_taker_against_io_thru_nbbo'
      doc: 'Combo Taker Against Io Thru Nbbo'
    55:
      id: 'simple_exposure_order_upon_receipt'
      doc: 'Simple Exposure Order Upon Receipt'
    56:
      id: 'simple_exposure_order_subsequent'
      doc: 'Simple Exposure Order Subsequent'
    57:
      id: 'simple_exposure_order_responder'
      doc: 'Simple Exposure Order Responder'
    58:
      id: 'flex_auction'
      doc: 'Flex Auction'
    59:
      id: 'flex_auction_responder'
      doc: 'Flex Auction Responder'
    60:
      id: 'flex_price_improvement'
      doc: 'Flex Price Improvement'
    61:
      id: 'flex_price_improvement_responder'
      doc: 'Flex Price Improvement Responder'
    62:
      id: 'flex_broken_price_improvement'
      doc: 'Flex Broken Price Improvement'
    63:
      id: 'flex_solicitation'
      doc: 'Flex Solicitation'
    64:
      id: 'flex_solicitation_responder'
      doc: 'Flex Solicitation Responder'
    65:
      id: 'flex_broken_solicitation'
      doc: 'Flex Broken Solicitation'
    66:
      id: 'combo_flex_auction'
      doc: 'Combo Flex Auction'
    67:
      id: 'combo_flex_auction_responder'
      doc: 'Combo Flex Auction Responder'
    68:
      id: 'combo_flex_price_improvement'
      doc: 'Combo Flex Price Improvement'
    69:
      id: 'combo_flex_price_improvement_responder'
      doc: 'Combo Flex Price Improvement Responder'
    70:
      id: 'combo_flex_broken_price_improvement'
      doc: 'Combo Flex Broken Price Improvement'
    71:
      id: 'combo_flex_solicitation'
      doc: 'Combo Flex Solicitation'
    72:
      id: 'combo_flex_solicitation_responder'
      doc: 'Combo Flex Solicitation Responder'
    73:
      id: 'combo_flex_broken_solicitation'
      doc: 'Combo Flex Broken Solicitation'
  notification_type:
    0x45:
      id: 'executed'
      doc: 'Executed'
    0x43:
      id: 'cancelled'
      doc: 'Cancelled'
  block_status_code:
    0x20:
      id: 'valid_request'
      doc: 'Valid Request'
    0x41:
      id: 'invalid_badge'
      doc: 'Invalid Badge'
    0x42:
      id: 'invalid_instrument_underlying'
      doc: 'Invalid Instrument Underlying'
    0x43:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x44:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x45:
      id: 'invalid_size'
      doc: 'Invalid Size'
    0x46:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x47:
      id: 'invalid_spread'
      doc: 'Invalid Spread'
    0x48:
      id: 'invalid_indicator_attribute'
      doc: 'Invalid Indicator Attribute'
    0x49:
      id: 'reentry_required'
      doc: 'Reentry Required'
    0x4a:
      id: 'opening_rotation_in_progress'
      doc: 'Opening Rotation In Progress'
    0x4b:
      id: 'kill_switch_reentry_required'
      doc: 'Kill Switch Reentry Required'
    0x4c:
      id: 'full_replenishment_required'
      doc: 'Full Replenishment Required'
    0x4d:
      id: 'active_counter_exceeded'
      doc: 'Active Counter Exceeded'
    0x4e:
      id: 'too_late_to_act'
      doc: 'Too Late To Act'
    0x50:
      id: 'not_in_free_trading'
      doc: 'Not In Free Trading'
    0x51:
      id: 'invalid_auction_information'
      doc: 'Invalid Auction Information'
    0x52:
      id: 'market_closed'
      doc: 'Market Closed'
    0x53:
      id: 'post_only_reprice'
      doc: 'Post Only Reprice'
    0x54:
      id: 'request_pending'
      doc: 'Request Pending'
    0x59:
      id: 'invalid_format_bad_block'
      doc: 'Invalid Format Bad Block'
    0x5a:
      id: 'system_error'
      doc: 'System Error'
  quote_status_code:
    0x20:
      id: 'valid_request'
      doc: 'Valid Request'
    0x41:
      id: 'invalid_badge'
      doc: 'Invalid Badge'
    0x42:
      id: 'invalid_instrument_underlying'
      doc: 'Invalid Instrument Underlying'
    0x43:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x44:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x45:
      id: 'invalid_size'
      doc: 'Invalid Size'
    0x46:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x47:
      id: 'invalid_spread'
      doc: 'Invalid Spread'
    0x48:
      id: 'invalid_indicator_attribute'
      doc: 'Invalid Indicator Attribute'
    0x49:
      id: 'reentry_required'
      doc: 'Reentry Required'
    0x4a:
      id: 'opening_rotation_in_progress'
      doc: 'Opening Rotation In Progress'
    0x4b:
      id: 'kill_switch_reentry_required'
      doc: 'Kill Switch Reentry Required'
    0x4c:
      id: 'full_replenishment_required'
      doc: 'Full Replenishment Required'
    0x4d:
      id: 'active_counter_exceeded'
      doc: 'Active Counter Exceeded'
    0x4e:
      id: 'too_late_to_act'
      doc: 'Too Late To Act'
    0x50:
      id: 'not_in_free_trading'
      doc: 'Not In Free Trading'
    0x51:
      id: 'invalid_auction_information'
      doc: 'Invalid Auction Information'
    0x52:
      id: 'market_closed'
      doc: 'Market Closed'
    0x53:
      id: 'post_only_reprice'
      doc: 'Post Only Reprice'
    0x54:
      id: 'request_pending'
      doc: 'Request Pending'
    0x59:
      id: 'invalid_format_bad_block'
      doc: 'Invalid Format Bad Block'
    0x5a:
      id: 'system_error'
      doc: 'System Error'
  order_type:
    0x4c:
      id: 'limit'
      doc: 'Limit'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4e:
      id: 'not_disclosed'
      doc: 'Not Disclosed'
  exec_flag:
    0x30:
      id: 'none'
      doc: 'None'
    0x31:
      id: 'aon'
      doc: 'Aon'
  order_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker Dealer Customer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo'
    0x20:
      id: 'not_applicable'
      doc: 'Na'
  auction_event:
    0x53:
      id: 'start'
      doc: 'Start'
    0x55:
      id: 'auction_update'
      doc: 'Auction Update'
    0x45:
      id: 'end_of_auction'
      doc: 'End Of Auction'
  auction_type:
    0x42:
      id: 'block_order_auction'
      doc: 'Block Order Auction'
    0x43:
      id: 'combo_exposure_auction'
      doc: 'Combo Exposure Auction Aka Cola'
    0x49:
      id: 'order_exposure'
      doc: 'Order Exposure'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x50:
      id: 'pim_auction'
      doc: 'Pim Auction Pixl'
    0x48:
      id: 'facilitation_auction'
      doc: 'Facilitation Auction'
    0x53:
      id: 'solicitation_auction'
      doc: 'Solicitation Auction'
  purge_reason:
    0x55:
      id: 'user_requested_simple'
      doc: 'User Requested Simple'
    0x53:
      id: 'system_initiated'
      doc: 'System Initiated Simple'
    0x4b:
      id: 'auto_killswitch'
      doc: 'Auto Killswitch Initiated All Instruments'
    0x4d:
      id: 'manual_killswitch'
      doc: 'Manual Killswitch Initiated All Instruments'
    0x50:
      id: 'purge_on_disconnect'
      doc: 'Purge On Disconnect All Instruments'
    0x75:
      id: 'user_requested_complex'
      doc: 'User Requested Complex'
    0x73:
      id: 'system_initiated_complex'
      doc: 'System Initiated Complex'
    0x51:
      id: 'anti_internalize'
      doc: 'Anti Internalize Instrument Purge Notification'
  reentry_scope:
    0x4e:
      id: 'user_requested_simple'
      doc: 'User Requested Simple Instruments'
    0x6e:
      id: 'user_requested_complex'
      doc: 'User Requested Complex Instruments'
    0x4b:
      id: 'post_killswitch'
      doc: 'Post Killswitch All Instruments'

