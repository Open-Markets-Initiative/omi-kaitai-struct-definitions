# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BxeEquities AuctionFeed AsciiPitch v1.4
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Auction Feed
#   Encoding: Ascii Pitch
#   Version: 1.4
#   Date: 02/06/2025
#   Specification: BATS_Europe_Auction_Feed_Specification.pdf
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
  id: cboe_bxeequities_auctionfeed_asciipitch_v1_4
  title: Cboe BxeEquities AuctionFeed AsciiPitch v1.4
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe BXE Auction Feed AsciiPitch v1.4'
doc-ref: https://www.cboe.com/europe/equities/support/technical

seq:
  - id: packet_type
    type: u1
    enum: packet_type_enum
    doc: 'Code identifying this packet type'
  - id: payload
    type:
      switch-on: packet_type
      cases:
        'packet_type_enum::debug_packet': debug_packet
        'packet_type_enum::login_accepted_packet': login_accepted_packet
        'packet_type_enum::login_rejected_packet': login_rejected_packet
        'packet_type_enum::sequenced_data_packet': sequenced_data_packet
        'packet_type_enum::login_request_packet': login_request_packet
        'packet_type_enum::unsequenced_data_packet': unsequenced_data_packet
  - id: soup_lf
    type: u1
    doc: 'Terminating line feed character'

types:
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
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
      - id: sequenced_message_header
        type: sequenced_message_header
        doc: 'Cboe Europe ASCII Soup sequenced message header'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.sequenced_message_type
          cases:
            'sequenced_message_type::auction_update_message': auction_update_message
            'sequenced_message_type::auction_summary_message': auction_summary_message
  sequenced_message_header:
    seq:
      - id: timestamp
        type: millisecond_ascii_timestamp
        doc: 'Milliseconds past midnight London time, ASCII numeric, left-padded. Milliseconds since Midnight epoch'
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Single ASCII character identifying the sequenced message type'
  auction_update_message:
    seq:
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'O=Opening C=Closing H=Halt V=Volatility P=Periodic U=Cboe Closing Cross'
      - id: reference_price
        type: str
        size: 19
        encoding: ASCII
        doc: 'Reference price used in tie-breaker situations. Implied decimal with scale 1e-6'
      - id: indicative_price
        type: str
        size: 19
        encoding: ASCII
        doc: 'Price at which the auction would match if executed now. Implied decimal with scale 1e-6'
      - id: indicative_shares
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares at the Indicative Price'
      - id: outside_tolerance
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'O=Outside tolerance I=Inside tolerance -=Not specified'
      - id: includes_primary
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'P=Includes Primary N=Excludes Primary -=Not specified'
  auction_summary_message:
    seq:
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'O=Opening C=Closing H=Halt V=Volatility P=Periodic U=Cboe Closing Cross'
      - id: price
        type: str
        size: 19
        encoding: ASCII
        doc: 'Auction price. Implied decimal with scale 1e-6'
      - id: shares
        type: str
        size: 10
        encoding: ASCII
        doc: 'Cumulative number of shares executed during the auction'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message
        size-eos: true
        doc: 'Raw unsequenced message bytes'
  millisecond_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      hour:
        value: text.to_i / 3600000 % 24
      minute:
        value: text.to_i / 60000 % 60
      second:
        value: text.to_i / 1000 % 60
      millisecond:
        value: text.to_i % 1000

enums:
  packet_type_enum:
    0x2b:
      id: 'debug_packet'
      doc: 'Soup 2.0 Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'Soup 2.0 Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'Soup 2.0 Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'Soup 2.0 Server Heartbeat Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'Soup 2.0 Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soup 2.0 Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'Soup 2.0 Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'Soup 2.0 Logout Request Packet'
  sequenced_message_type:
    0x6c:
      id: 'auction_update_message'
      doc: 'Disseminates indicative price and size information during auctions for Cboe auction-eligible securities.'
    0x6a:
      id: 'auction_summary_message'
      doc: 'Disseminates the results of an auction in a Cboe auction-eligible security.'

