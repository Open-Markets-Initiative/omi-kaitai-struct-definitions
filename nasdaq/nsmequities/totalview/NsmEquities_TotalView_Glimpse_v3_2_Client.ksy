# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Glimpse v3.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Glimpse
#   Version: 3.2
#   Date: 01/09/2013
#   Specification: Nasdaq Glimpse.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: nasdaq_nsmequities_totalview_glimpse_v3_2_client
  title: Nasdaq NsmEquities TotalView Glimpse v3.2
  license: MIT-0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Glimpse v3.2'

seq:
  - id: client_frame
    type: client_frame_struct
    repeat: eos
    doc: 'One SoupTcp packet sent by the client, closed by a line feed'

types:
  client_frame_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'SoupTcp Packet Header sent by the client'
      - id: client_payload
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
      - id: soup_lf
        type: u1
        doc: 'Terminating line feed character'
  client_packet_header:
    seq:
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type'
  debug_packet:
    seq:
      - id: text
        type: str
        size-eos: true
        encoding: ASCII
        doc: 'Free form human readable text'
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
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message
        size-eos: true
        doc: 'Raw unsequenced message bytes'

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SoupTcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupTcp Server Heartbeat Packet'
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'This message is sent every second for which at least one NASDAQ GLIMPSE 3.2 / NASDAQ TotalView-ITCH 3.2 message is being generated.'
    0x4d:
      id: 'milliseconds_message'
      doc: 'This message is sent every millisecond for which at least one NASDAQ GLIMPSE 3.2 / NASDAQ TotalView-ITCH 3.2 message is being generated.'
    0x53:
      id: 'system_event_message'
      doc: 'NASDAQ GLIMPSE product is designed to support the same system event messages as the NASDAQ TotalView-ITCH feed. On GLIMPSE, NASDAQ will send out system event messages for those events that occurred up to the time of the GLIMPSE snapshot request.'
    0x41:
      id: 'add_order_message'
      doc: 'Add Order - No MPID Attribution Message. This message will be generated for unattributed orders accepted by the NASDAQ system.'
    0x46:
      id: 'add_order_mpid_attribution_message'
      doc: 'Add Order - MPID Attribution Message. This message will be generated for attributed orders and quotations accepted by the NASDAQ system.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each GLIMPSE transmission, NASDAQ will disseminate stock directory messages for all symbols in NASDAQ execution system for the current trading day. Please note that the Symbol Directory spin may include halted issues. Firms must process the Trading Action message for current trading state information.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'NASDAQ uses this administrative message to indicate the current trading status of a security to the trading community. In the GLIMPSE transmission, NASDAQ will send out a Stock Trading Action message for only those issues that were eligible for trading during the current trading session.'
    0x59:
      id: 'reg_sho_restriction_message'
      doc: 'Reg SHO Short Sale Price Test Restricted Indicator. NASDAQ will process orders based on the most Reg SHO Restriction status value.'
    0x4e:
      id: 'retail_price_improvement_indicator_message'
      doc: 'Identifies a retail interest indication of the Bid, Ask or both the Bid and Ask for NASDAQ-listed securities.'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'The Snapshot message reflects the NASDAQ TotalView-ITCH 3.2 sequence number at the time that the GLIMPSE 3.2 spin was requested.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside of time stamp messages, the start of day message is the first message sent in any trading day.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This message indicates that NASDAQ is open and ready to start accepting orders.'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are available for execution.'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are no longer available for execution.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It indicates that NASDAQ is now closed and will not accept any new orders today. It is still possible to receive Broken Trade messages and Order Delete messages after the End of Day.'
    0x43:
      id: 'end_of_messages'
      doc: 'This is always the last message sent in any trading day.'
    0x41:
      id: 'emergency_market_condition_halt'
      doc: 'This message is sent to inform NASDAQ market participants that the EMC is in effect. No trading is allowed during the EMC.'
    0x52:
      id: 'emergency_market_condition_quote_only_period'
      doc: 'This message is sent to inform NASDAQ market participants that the EMC quotation only period is in effect.'
    0x42:
      id: 'emergency_market_condition_resumption'
      doc: 'This message is sent to inform NASDAQ market participants that EMC is no longer in effect.'
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy order.'
    0x53:
      id: 'sell_order'
      doc: 'Sell order.'
  market_category:
    0x4e:
      id: 'new_york_stock_exchange'
      doc: 'New York Stock Exchange (NYSE)'
    0x41:
      id: 'nyse_amex'
      doc: 'NYSE Amex'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'NASDAQ Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'NASDAQ Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'NASDAQ Capital Market'
    0x5a:
      id: 'bats_bzx_exchange'
      doc: 'BATS BZX Exchange'
  financial_status_indicator:
    0x44:
      id: 'deficient'
      doc: 'Deficient'
    0x45:
      id: 'delinquent'
      doc: 'Delinquent'
    0x51:
      id: 'bankrupt'
      doc: 'Bankrupt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x47:
      id: 'deficient_and_bankrupt'
      doc: 'Deficient and Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient and Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent and Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient, Delinquent and Bankrupt'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Only round lots are accepted in this stock.'
    0x4e:
      id: 'odd_and_mixed_lots_allowed'
      doc: 'Odd/mixed lots are allowed.'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted across all U.S. equity markets / SROs'
    0x50:
      id: 'paused'
      doc: 'Paused across all U.S. equity markets / SROs (NASDAQ-listed securities only)'
    0x51:
      id: 'quotation_only_period'
      doc: 'Quotation only period for cross-SRO halt or pause'
    0x54:
      id: 'trading'
      doc: 'Trading on NASDAQ'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No price test in place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg SHO Short Sale Price Test Restriction in effect due to an intra-day price drop in security'
    0x32:
      id: 'restriction_remains_in_effect'
      doc: 'Reg SHO Short Sale Price Test Restriction remains in effect'
  interest_flag:
    0x42:
      id: 'rpi_buy'
      doc: 'RPI orders available on the buy side'
    0x53:
      id: 'rpi_sell'
      doc: 'RPI orders available on the sell side'
    0x41:
      id: 'rpi_both'
      doc: 'RPI orders available on both sides (buy and sell)'
    0x4e:
      id: 'no_rpi'
      doc: 'No RPI orders available'

