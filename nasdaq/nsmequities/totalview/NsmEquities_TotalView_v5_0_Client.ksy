# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Glimpse v5.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Glimpse
#   Version: 5.0
#   Date: 2/13/2026
#   Specification: NQGlimpse_Spec_2-13-26.pdf
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
  id: nasdaq_nsmequities_totalview_glimpse_v5_0_client
  title: Nasdaq NsmEquities TotalView Glimpse v5.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Glimpse v5.0'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

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
        size: 1
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
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x41:
      id: 'add_order_message'
      doc: 'Add Order - No MPID Attribution Message.'
    0x46:
      id: 'add_order_mpid_attribution_message'
      doc: 'Add Order - No MPID Attribution Message.'
    0x52:
      id: 'stock_directory_message'
      doc: 'Stock Directory Message'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Stock Trading Action Message.'
    0x59:
      id: 'reg_sho_restriction_message'
      doc: 'Reg SHO Short Sale Price Test Restricted Indicator'
    0x4e:
      id: 'retail_interest_message'
      doc: 'Retail Interest message'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'End of Snapshot message'
    0x68:
      id: 'operational_halt_message'
      doc: 'Operational Halt'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Start Of Market Hours'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'End Of Market Hours'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
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
      id: 'new_york_stock_exchange_nyse'
      doc: 'New York Stock Exchange Nyse'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x5a:
      id: 'bats_z_exchange'
      doc: 'Bats Z Exchange'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors Exchange Llc'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
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
      doc: 'Deficient And Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient And Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent And Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient Delinquent And Bankrupt'
    0x43:
      id: 'creations_andor_redemptions_suspended_for_exchange_traded_product'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
  trading_state:
    0x48:
      id: 'halted_across_all_us_equity_markets_sr_os'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused_across_all_us_equity_markets_sr_os'
      doc: 'Paused Across All Us Equity Markets Sr Os'
    0x51:
      id: 'quotation_only_period_for_cross_sro_halt_or_pause'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading_on_nasdaq'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect'
    0x32:
      id: 'reg_sho_short_sale_price_test_restriction_remains_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  interest_flag:
    0x42:
      id: 'rpi_orders_available_on_the_buy_side'
      doc: 'Rpi Orders Available On The Buy Side'
    0x53:
      id: 'rpi_orders_available_on_the_sell_side'
      doc: 'Rpi Orders Available On The Sell Side'
    0x41:
      id: 'rpi_orders_available_on_both_sides_buy_and_sell'
      doc: 'Rpi Orders Available On Both Sides Buy And Sell'
    0x4e:
      id: 'no_rpi_orders_available'
      doc: 'No Rpi Orders Available'
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x58:
      id: 'psx'
      doc: 'Psx'
  operational_halt_action:
    0x48:
      id: 'operationally_halted_on_the_identified_market'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'operational_halt_has_been_lifted_and_trading_resumed'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'

