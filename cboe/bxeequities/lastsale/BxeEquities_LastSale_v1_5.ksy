# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BxeEquities LastSale AsciiPitch v1.5
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Last Sale
#   Encoding: Ascii Pitch
#   Version: 1.5
#   Date: 5/31/2019
#   Specification: BATS Europe Last Sale Specification (2020-05-28).pdf
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
  id: cboe_bxeequities_lastsale_asciipitch_v1_5
  title: Cboe BxeEquities LastSale AsciiPitch v1.5
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe BXE Last Sale AsciiPitch v1.5'
doc-ref: https://www.cboe.com/europe/equities/support/technical

seq:
  - id: frame
    type: frame_struct
    repeat: eos
    doc: 'Soup 2.0 Lf terminated record'

types:
  frame_struct:
    seq:
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
      - id: payload
        type:
          switch-on: packet_type
          cases:
            'packet_type::debug_packet': debug_packet
            'packet_type::login_accepted_packet': login_accepted_packet
            'packet_type::login_rejected_packet': login_rejected_packet
            'packet_type::sequenced_data_packet': sequenced_data_packet
            'packet_type::login_request_packet': login_request_packet
            'packet_type::unsequenced_data_packet': unsequenced_data_packet
      - id: soup_lf
        type: u1
        doc: 'Terminating line feed character'
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
            'sequenced_message_type::last_sale_europe_message': last_sale_europe_message
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
        doc: 'Alphanumeric'
  last_sale_europe_message:
    seq:
      - id: trading_date_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time the trade occured'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code that identifies the financial instrument'
      - id: price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Price of the trade. This may be zero if the price is pending, as denoted by the “Price Discovery Process” field'
      - id: price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISO 3-letter Currency code'
      - id: executed_shares
        type: str
        size: 12
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISO 10383 segment MIC, and SINT for Systematic internalisers, XOFF for OTC trades'
      - id: publication_date_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time the trade was published'
      - id: trade_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution/trade identifier. Left padded with zeroes'
      - id: transaction_category
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.1 “RPRI” = Trade that has Received Price Improvement “TPAC” = Package Trade “XFPH” = Exchange For Physical Trade'
      - id: negotiation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.2 “NLIQ” = Negotiated Trade in Liquid Instruments “OILQ” = Negotiated Trade in Illiquid Instruments “PRIC” = Negotiated Trade Subject to Conditions Other Than The Current Market Price “ILQD” = Pre-Trade Transparency Waiver for Illiquid Instrument on an SI “SIZE” = Pre-Trade Transparency Waiver for Above Standard Size on an SI If the Pre-Trade Transparency Waivers of “ILQD” and “SIZE” both apply to the trade, “SIZE” will be published in this field'
      - id: agency_cross_trade
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.3 “ACTX” = Agency Cross Trade'
      - id: modification_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.4 “CANC” = Trade Cancellation “AMND” = Trade Amendment'
      - id: benchmark_reference_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.5 “BENC” = Benchmark Trade “RFPT” = Reference Price Trade'
      - id: special_dividend
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.6 “SDIV” = Special Dividend Trade'
      - id: price_discovery_process
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.8 “NPFT” = Non-Price Forming Trade “TNCP” = Trade not Contributing to the Price Discovery Process “PNDG” = Price is Pending'
      - id: algorithmic_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.9 “ALGO” = Algorithmic Trade'
      - id: post_trade_deferral_reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 4.1 “LRGS” = Deferral for “Large in Scale” “ILQD” = Deferral for “Illiquid Instrument” “SIZE” = Deferral for “Size Specific” If the Post-Trade Deferral Reasons of “ILQD” and “SIZE” or “ILQD” and “LRGS” both apply to the trade, “ILQD” will be published in this field'
      - id: duplicative_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 5 “DUPL” = Duplicative Trade Report'
      - id: jurisdiction
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to venue where the trade was executed “EU” = Trade executed on an EU regulated venue” “UK” = Trade executed on a non-EU regulated venue”'
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
  packet_type:
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
    0x75:
      id: 'last_sale_europe_message'
      doc: 'Last Sale Europe Messages are sent when an order on a Cboe order book is executed in whole or in part, or when a reported trade is submitted to Cboe'

