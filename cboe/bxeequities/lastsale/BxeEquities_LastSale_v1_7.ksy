# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BxeEquities LastSale Apf v1.7
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Last Sale
#   Encoding: Apf
#   Version: 1.7
#   Date: 10/2/2023
#   Specification: BATS_Europe_Last_Sale_Specification.pdf
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
  id: cboe_bxeequities_lastsale_apf_v1_7
  title: Cboe BxeEquities LastSale Apf v1.7
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe BXE Last Sale Apf v1.7'
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
        doc: 'Sequenced Message Header'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.sequenced_message_type
          cases:
            'sequenced_message_type::last_sale_europe_message': last_sale_europe_message
            'sequenced_message_type::last_sale_europe_message_new': last_sale_europe_message_new
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
        doc: 'Date and time the trade occurred'
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
        doc: 'Cboe generated day-unique execution/trade identifier'
      - id: transaction_category
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.1'
      - id: negotiation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.2'
      - id: agency_cross_trade
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.3'
      - id: modification_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.4'
      - id: benchmark_reference_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.5'
      - id: special_dividend
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.6'
      - id: price_discovery_process
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.8'
      - id: algorithmic_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.9'
      - id: post_trade_deferral_reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 4.1'
      - id: duplicative_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 5'
      - id: jurisdiction
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to venue where the trade was executed'
  last_sale_europe_message_new:
    seq:
      - id: trading_date_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time the trade occurred'
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
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price Notation'
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
      - id: notional_amount
        type: str
        size: 18
        encoding: ASCII
        doc: 'Value of the trade, in the major currency. Price times Executed Shares'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISO 3-letter Currency code representing the major currency in which the notional amount is denominated'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISO 10383 segment MIC, and SINT for Systematic internalisers, XOFF for OTC trades'
      - id: third_country_trading_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'When populated, indicates the trade was executed on a venue not deemed equivalent under ESMA Opinion on determining third-country trading venues for the purpose of transparency under Mifid II/Mifir. The column contains the venue MIC, and the execution venue will contain the value ”XOFF”. Not applicable to reports from Cboe’s UK APA'
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
        doc: 'Cboe generated day-unique execution/trade identifier'
      - id: market_mechanism
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 1 “LB” = Central Limit Order Book “QB” = Quote Driven Market “DB” = Dark Order Book “OB” = Oﬀ Book (including Voice or Messaging Trading) “PA” = Periodic Auction “RQ” = Request for Quotes “AH” = Any Other, Including Hybrid (original ESMA definition in RTSs 1 and 2) “HS” = Hybrid System (revised ESMA definition, replacing ’Any Other, Including Hybrid’) “AO” = Any Other, Excluding Hybrid (revised ESMA definition, replacing ’Any Other, Including Hybrid’)'
      - id: trading_mode
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 2'
      - id: transaction_category
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.1'
      - id: negotiation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.2'
      - id: agency_cross_trade
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.3'
      - id: modification_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.4'
      - id: benchmark_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 3.5'
      - id: special_dividend
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.6'
      - id: off_book_automated
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 3.7'
      - id: price_discovery_process
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.8'
      - id: algorithmic_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.9'
      - id: pre_trade_transparency_waiver
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.10'
      - id: portfolio_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.11'
      - id: contingent_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.12'
      - id: giveup_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 3.13'
      - id: post_trade_deferral_reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v3 Level 4.1'
      - id: deferral_or_enrichment_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 4.2'
      - id: deferral_illiquid_instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 4.3'
      - id: deferral_size_specific
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 4.4'
      - id: duplicative_within_jurisdiction
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 5.1'
      - id: duplicative_across_jurisdiction
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 5.2'
      - id: intra_group_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to MMT v4.1 Level 5.3'
      - id: jurisdiction
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corresponds to venue where the trade was executed'
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
    0x75:
      id: 'last_sale_europe_message'
      doc: 'Last Sale Europe Messages are sent when an order on a Cboe order book is executed in whole or in part, or when a reported trade is submitted to Cboe'
    0x37:
      id: 'last_sale_europe_message_new'
      doc: 'Last Sale Europe Messages are sent when an order on a Cboe order book is executed in whole or in part, or when a reported trade is submitted to Cboe'

