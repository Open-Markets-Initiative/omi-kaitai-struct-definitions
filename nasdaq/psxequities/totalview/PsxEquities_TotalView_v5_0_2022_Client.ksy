# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PsxEquities TotalView Glimpse v5.0.2022
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Glimpse
#   Version: 5.0.2022
#   Date: 07/15/2022
#   Specification: PSXGLIMPSESpecification.pdf
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
  id: nasdaq_psxequities_totalview_glimpse_v5_0_2022_client
  title: Nasdaq PsxEquities TotalView Glimpse v5.0.2022
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PSX TotalView Itch Glimpse v5.0.2022'
doc-ref: https://www.nasdaqtrader.com/content/technicalsupport/specifications/dataproducts/PSXGLIMPSESpecification.pdf

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type sent by the client'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: _parent.client_packet_header.packet_length - 1
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
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        doc: 'The unsequenced (client to server) message carried by the packet, opaque bytes unless an application source dispatches it'

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
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'PSX GLIMPSE product is designed to support the same system event messages as the PSX TotalView-ITCH feed. On PSX GLIMPSE, PSX will send out system event messages for those events that occurred up to the time of the PSX GLIMPSE snapshot request.'
    0x41:
      id: 'add_order_message'
      doc: 'Add Order - No MPID Attribution Message. This message will be generated for unattributed orders accepted by the Nasdaq PSX system. (Note: If a firm wants to display a MPID for unattributed orders, Nasdaq PSX recommends that it use the MPID of "NSDQ".)'
    0x46:
      id: 'add_order_mpid_attribution_message'
      doc: 'Add Order with MPID Attribution Message. This message will be generated for attributed orders and quotations accepted by the Nasdaq PSX system.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each PSX GLIMPSE transmission, Nasdaq PSX will disseminate stock directory messages for all symbols in Nasdaq PSX execution system for the current trading day. Please note that the Symbol Directory spin may include halted issues. Firms must process the Trading Action message for current trading state information.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'In the PSX GLIMPSE transmission, Nasdaq PSX will send out a Stock Trading Action message for only those Nasdaq, NYSE, and other regional exchanges issues that were eligible for trading during the current trading session.'
    0x59:
      id: 'reg_sho_restriction_message'
      doc: 'Reg SHO Short Sale Price Test Restricted Indicator'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'The Snapshot message reflects the Nasdaq PSX TotalView-ITCH sequence number at the time that the Nasdaq PSX GLIMPSE spin was requested.'
    0x68:
      id: 'operational_halt_message'
      doc: 'The Exchange uses this message to indicate the current Operational Status of a security to the trading community. An Operational Halt means that there has been an interruption of service on the identified security impacting only the designated Market Center. PSX GLIMPSE will distribute the Operational Halt message on a last seen basis.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside of time stamp messages, the start of day message is the first message sent in any trading day.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This message indicates that Nasdaq PSX is open and ready to start accepting orders.'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are available for execution.'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are no longer available for execution.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It indicates that Nasdaq PSX is now closed and will not accept any new orders today. It is still possible to receive Broken Trade messages and Order Delete messages after the End of Day.'
    0x43:
      id: 'end_of_messages'
      doc: 'This is always the last message sent in any trading day.'
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  market_category:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
    0x4e:
      id: 'new_york_stock_exchange'
      doc: 'New York Stock Exchange (NYSE)'
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x5a:
      id: 'bats_z_exchange'
      doc: 'BATS Z Exchange'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors'' Exchange, LLC'
    0x20:
      id: 'not_available'
      doc: 'Not available'
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
    0x43:
      id: 'creations_andor_redemptions_suspended_for_exchange_traded_product'
      doc: 'Creations and/or Redemptions Suspended for Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Normal (Default): Issuer Is NOT Deficient, Delinquent, or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Not available. Firms should refer to SIAC feeds for code if needed.'
  round_lots_only:
    0x59:
      id: 'only_round_lots_accepted'
      doc: 'Nasdaq PSX system only accepts round lots'
    0x4e:
      id: 'odd_and_mixed_lots_allowed'
      doc: 'Nasdaq PSX system does not have any order size restrictions for this security. Odd and mixed lot orders are allowed.'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live/Production'
    0x54:
      id: 'test'
      doc: 'Test'
  short_sale_threshold_indicator:
    0x59:
      id: 'restricted'
      doc: 'Issue is restricted under SEC Rule 203(b)(3)'
    0x4e:
      id: 'not_restricted'
      doc: 'Issue is not restricted'
    0x20:
      id: 'not_available'
      doc: 'Threshold Indicator not available'
  ipo_flag:
    0x59:
      id: 'new_ipo_security'
      doc: 'Nasdaq listed instrument is set up as a new IPO security'
    0x4e:
      id: 'not_a_new_ipo_security'
      doc: 'Nasdaq listed instrument is not set up as a new IPO security'
    0x20:
      id: 'not_available'
      doc: 'Not available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1_nms_stocks_and_select_et_ps'
      doc: 'Tier 1 NMS Stocks and select ETPs'
    0x32:
      id: 'tier_2_nms_stocks'
      doc: 'Tier 2 NMS Stocks'
    0x20:
      id: 'not_available'
      doc: 'Not available'
  etp_flag:
    0x59:
      id: 'instrument_is_an_etp'
      doc: 'Instrument is an ETP'
    0x4e:
      id: 'instrument_is_not_an_etp'
      doc: 'Instrument is not an ETP'
    0x20:
      id: 'not_available'
      doc: 'Not available'
  inverse_indicator:
    0x59:
      id: 'etp_is_an_inverse_etp'
      doc: 'ETP is an Inverse ETP'
    0x4e:
      id: 'etp_is_not_an_inverse_etp'
      doc: 'ETP is not an Inverse ETP'
  trading_state:
    0x48:
      id: 'halted_across_all_us_equity_markets_sr_os'
      doc: 'Halted across all U.S. equity markets / SROs'
    0x50:
      id: 'paused_across_all_us_equity_markets_sr_os'
      doc: 'Paused across all U.S. equity markets / SROs (Nasdaq-listed securities only)'
    0x51:
      id: 'quotation_only_period_for_cross_sro_halt_or_pause'
      doc: 'Quotation only period for cross-SRO halt or pause'
    0x54:
      id: 'trading_on_nasdaq_psx'
      doc: 'Trading on Nasdaq PSX'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_place'
      doc: 'No price test in place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg SHO Short Sale Price Test Restriction in effect due to an intra-day price drop in security'
    0x32:
      id: 'restriction_remains_in_effect'
      doc: 'Reg SHO Short Sale Price Test Restriction remains in effect'
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'bx'
      doc: 'BX'
    0x58:
      id: 'psx'
      doc: 'PSX'
  operational_halt_action:
    0x48:
      id: 'operationally_halted_on_the_identified_market'
      doc: 'Operationally Halted on the identified Market'
    0x54:
      id: 'operational_halt_has_been_lifted_and_trading_resumed'
      doc: 'Operational Halt has been lifted and Trading resumed'

