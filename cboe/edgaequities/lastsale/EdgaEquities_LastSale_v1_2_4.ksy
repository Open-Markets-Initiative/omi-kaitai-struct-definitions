# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgaEquities LastSale AsciiPitch v1.2.4
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Last Sale
#   Encoding: Ascii Pitch
#   Version: 1.2.4
#   Date: 01/15/2025
#   Specification: Cboe_US_Equities_Last_Sale_Specification.pdf
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
  id: cboe_edgaequities_lastsale_asciipitch_v1_2_4
  title: Cboe EdgaEquities LastSale AsciiPitch v1.2.4
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe Edga Equities Last Sale AsciiPitch v1.2.4'
doc-ref: http://markets.cboe.com/us/equities/support/technical

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
        doc: 'Sequenced Message Header'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.sequenced_message_type
          cases:
            'sequenced_message_type::last_sale_message': last_sale_message
            'sequenced_message_type::last_sale_extended_message': last_sale_extended_message
            'sequenced_message_type::trade_break_message': trade_break_message
  sequenced_message_header:
    seq:
      - id: timestamp
        type: str
        size: 8
        encoding: ASCII
        doc: 'Timestamp'
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Sequenced Message Type'
  last_sale_message:
    seq:
      - id: executed_shares
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: stock_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'The execution price of the order'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  last_sale_extended_message:
    seq:
      - id: executed_shares
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: stock_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'The execution price of the order. Implied decimal with scale 1e-6'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  trade_break_message:
    seq:
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
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
    0x4c:
      id: 'last_sale_message'
      doc: 'Last Sale messages are sent when an order on the Cboe book is executed in whole or in part.'
    0x35:
      id: 'last_sale_extended_message'
      doc: 'The extended version of the Last Sale message accommodates larger prices.'
    0x42:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cboe is broken. Trade breaks are rare and only affect applications that rely upon Cboe execution-based data.'

