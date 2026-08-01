# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions SpreadTradeFeed Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Phlx Options Spread Trade Feed
#   Encoding: Itch
#   Version: 2.1
#   Date: 02/13/2026
#   Specification: Options_Spread_Feed_2.1.pdf
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------

meta:
  id: iseoptions_spreadtradefeed_v2_1
  title: Nasdaq IseOptions SpreadTradeFeed Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Phlx Options Spread Trade Feed Itch v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

seq:
  - id: soup_bin_tcp_packet
    type: soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet'

types:
  soup_bin_tcp_packet_struct:
    seq:
      - id: tcp_packet_header
        type: tcp_packet_header
      - id: tcp_payload
        size: tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: tcp_packet_header.packet_type
          cases:
            'packet_type::debug_packet': debug_packet
            'packet_type::login_accepted_packet': login_accepted_packet
            'packet_type::login_rejected_packet': login_rejected_packet
            'packet_type::sequenced_data_packet': sequenced_data_packet
            'packet_type::login_request_packet': login_request_packet
            'packet_type::unsequenced_data_packet': unsequenced_data_packet
  tcp_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.tcp_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::complex_strategy_directory_message': complex_strategy_directory_message
            'sequenced_message_type::strategy_trading_action_message': strategy_trading_action_message
            'sequenced_message_type::complex_strategy_trade_report': complex_strategy_trade_report
            'sequenced_message_type::end_of_replay_sequence_message': end_of_replay_sequence_message
  system_event_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Refer to System Event Codes below'
  complex_strategy_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: strategy_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Strategy Type'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: num_leg_information
        type: u1
        doc: 'Number of legs in the strategy Legs NOTE: Leg field offsets below are an equation, where "n" is the zero based leg number (0, 1, ...)'
      - id: leg_information
        type: leg_information
        repeat: expr
        repeat-expr: num_leg_information
        doc: 'Leg information'
  leg_information:
    seq:
      - id: option_id
        type: u4
        doc: 'Option ID for this leg, valid for the trading day'
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
        doc: 'Explicit strike price. Refer to Data Types for field processing notes. Zero (0) for Stock Leg. Implied decimal with scale 1e-4'
      - id: option_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option Type'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the side of the leg'
      - id: leg_ratio
        type: u4
        doc: 'Leg Ratio'
  strategy_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: current_trading_state
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Current Trading State'
  complex_strategy_trade_report:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: cross_id
        type: u4
        doc: 'Indicates the internal control number (cross id) associated with the given options trade transaction'
      - id: trade_condition
        type: u1
        doc: 'The Trade Condition is the same as defined in the OPRA specification (OPRA terminology is either "Last Sale" or "Transaction"). Always refer to the www.opraplan.com website to ensure the possible Trade Conditions sent out by this feed, which are consistent with the Trade Conditions defined by OPRA'
      - id: price
        type: u4
        doc: 'Reflects the transaction (premium) price on the execution. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'Current number of contracts traded for an option in one trade'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  end_of_replay_sequence_message:
    seq:
      - id: end_of_replay_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sequence number once the replay is complete'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
  mold_udp_64_packet:
    seq:
      - id: udp_packet_header
        type: udp_packet_header_struct
        doc: 'Itch Mold Udp 64 Packet Header'
      - id: messages
        repeat: expr
        repeat-expr: udp_packet_header.message_count
        type:
          switch-on: udp_packet_header.message_count
          cases:
            _: message
  udp_packet_header_struct:
    seq:
      - id: udp_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: udp_sequence_number
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
      - id: udp_payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::complex_strategy_directory_message': complex_strategy_directory_message
            'message_type::strategy_trading_action_message': strategy_trading_action_message
            'message_type::complex_strategy_trade_report': complex_strategy_trade_report
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'

enums:
  packet_type:
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
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
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
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Order Strategy Message containing the strategy definition will be sent whenever a complex order is added in the system for an underlying.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x52:
      id: 'complex_strategy_trade_report'
      doc: 'The Complex Strategy Trade Report message is used to publish real-time trade information for complex strategies.'
    0x4d:
      id: 'end_of_replay_sequence_message'
      doc: 'The End of replay Sequence message reflects the sequence number at the time replay of existing messages is complete.'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Order Strategy Message containing the strategy definition will be sent whenever a complex order is added in the system for an underlying.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x52:
      id: 'complex_strategy_trade_report'
      doc: 'The Complex Strategy Trade Report message is used to publish real-time trade information for complex strategies.'

