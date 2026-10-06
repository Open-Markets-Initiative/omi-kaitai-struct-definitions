# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NtxOptions Cti Itch v1.3
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Clearing Trade Interface
#   Encoding: Itch
#   Version: 1.3
#   Date: 11/19/2018
#   Specification: Options_CTI.pdf
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
  id: nasdaq_ntxoptions_cti_itch_v1_3_client
  title: Nasdaq NtxOptions Cti Itch v1.3
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Texas Options Clearing Trade Interface Itch v1.3'
doc-ref:
  - https://www.nasdaqtrader.com/content/technicalsupport/specifications/tradingproducts/Options_CTI.pdf
  - https://www.nasdaq.com/docs/ClearingTradeInterface.pdf

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
      doc: 'The system event message is used to signal a ring wide event. 11 bytes.'
    0x44:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, the exchange disseminates directory messages for all symbols trading on a given ring. Sent once per symbol, typically before the Start of System Hours System Event; intra-day updates are sent as they occur. 42 bytes.'
    0x48:
      id: 'security_trading_action_message'
      doc: 'Indicates the current trading status of an option within the exchange. A T (Trading resumed) message is sent for all options eligible for trading at the start of system hours; a security absent from the pre-opening spin should be treated as halted. 26 bytes.'
    0x54:
      id: 'trade_message'
      doc: 'Clearing trades and trade corrections, with contra side clearing information (trade cancels too when a firm and connection block is configured for extended cancels, Transaction Type Z). 310 bytes. Contra side clearing fields carry a Contra prefix.'
    0x56:
      id: 'cancel_trade_message'
      doc: 'By default CTI sends trade cancels using this message; alternatively a firm and connection block can be configured to send extended cancels with all the trade information using the Trade message with Transaction Type Z. 50 bytes.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages Always The First Message Sent In Any Trading Day After 200 Am'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours The Exchange Is Ready To Start Accepting Orders 700 Am'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process The Exchange Has Started Its Opening Process 93000 Am'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End Of Normal Hours Processing No New Orders Or Changes To Existing Orders For Options That Trade During Normal Hours 40000 Pm'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End Of Late Hours Processing No New Orders Or Changes To Existing Orders For Options That Trade During Extended Hours 41500 Pm'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours The System Is Now Closed 530 Pm'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages Always The Last Message Sent In Any Trading Day 535 Pm'
  option_kind:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  option_closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
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
      doc: 'Penny Everywhere All Prices Are In Penny Increments'
    0x53:
      id: 'scaled'
      doc: 'Scaled Prices Below 3.00 Are In Increments Of 0.05 Prices Above 3.00 Are In Increments Of 0.10'
    0x50:
      id: 'penny_pilot'
      doc: 'Penny Pilot Prices Below 3.00 Are In Increments Of 0.01 Prices Above 3.00 Are In Increments Of 0.05'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'trading_resumed'
      doc: 'Trading Resumed'
  send_type:
    0x53:
      id: 'send'
      doc: 'Send Original Transmission'
    0x50:
      id: 'possible_duplicate'
      doc: 'Possible Duplicate Unsolicited Retransmission'
  transaction_type:
    0x58:
      id: 'new_trade'
      doc: 'New Trade'
    0x59:
      id: 'trade_correction'
      doc: 'Trade Correction'
    0x5a:
      id: 'trade_cancel'
      doc: 'Trade Cancel If Trade Cancel Messages Are To Be Sent Using This Message'
  liquidity:
    0x41:
      id: 'add'
      doc: 'Add'
    0x52:
      id: 'remove'
      doc: 'Remove'
    0x4a:
      id: 'order_exposure_alerted'
      doc: 'Order Exposure Alerted Flash Order'
    0x4b:
      id: 'executed_against_a_flash_order'
      doc: 'Executed Against A Flash Order'
    0x46:
      id: 'opening_trade_customer_to_customer'
      doc: 'Opening Trade Customer To Customer Not Available On Phlx Xl'
    0x4f:
      id: 'opening_trade'
      doc: 'Opening Trade Not Available On Phlx Xl'
    0x4e:
      id: 'none'
      doc: 'None Not Applicable'
  auction_type:
    0x50:
      id: 'simple_order_pixl_prism'
      doc: 'Simple Order Pixlprism'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x45:
      id: 'market_exhaust'
      doc: 'Market Exhaust'
    0x20:
      id: 'no_auction'
      doc: 'No Auction'
  execution_type:
    0x41:
      id: 'automatic'
      doc: 'Automatic'
    0x4d:
      id: 'manual'
      doc: 'Manual'
  execution_market:
    0x41:
      id: 'amex'
      doc: 'Amex'
    0x42:
      id: 'box_field'
      doc: 'Box'
    0x43:
      id: 'cboe'
      doc: 'Cboe'
    0x49:
      id: 'ise'
      doc: 'Ise'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x57:
      id: 'c_2'
      doc: 'C 2'
    0x5a:
      id: 'bats'
      doc: 'Bats'
    0x58:
      id: 'phlx'
      doc: 'Phlx'
    0x54:
      id: 'bx_options'
      doc: 'Bx Options'
    0x4d:
      id: 'miax'
      doc: 'Miax'
    0x48:
      id: 'ise_gemini'
      doc: 'Ise Gemini'
    0x45:
      id: 'bats_edgx'
      doc: 'Bats Edgx'
    0x4a:
      id: 'ise_mercury'
      doc: 'Ise Mercury'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x20:
      id: 'not_away_trade'
      doc: 'Not Away Trade'
  trade_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  side_changed:
    0x59:
      id: 'yes_field'
      doc: 'New Trades And Corrections That Affected This Side Of The Trade'
    0x4e:
      id: 'no_field'
      doc: 'Corrections That Affected Only Contra Side'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x59:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'market_maker'
      doc: 'On Floor Specialist Sqt Or Rot Phlx Or Nombx Options Market Maker Nombx Options'
    0x4f:
      id: 'non_registered_market_maker'
      doc: 'Non Phlx Registered Market Maker Phlx Or Non Nombx Options Registered Market Maker Nombx Options'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo'
  origin_market:
    0x41:
      id: 'amex'
      doc: 'Amex'
    0x42:
      id: 'box_field'
      doc: 'Box'
    0x43:
      id: 'cboe'
      doc: 'Cboe'
    0x49:
      id: 'ise'
      doc: 'Ise'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x57:
      id: 'c_2'
      doc: 'C 2'
    0x5a:
      id: 'bats'
      doc: 'Bats'
    0x58:
      id: 'phlx'
      doc: 'Phlx'
    0x54:
      id: 'bx_options'
      doc: 'Bx Options'
    0x4d:
      id: 'miax'
      doc: 'Miax'
    0x48:
      id: 'ise_gemini'
      doc: 'Ise Gemini'
    0x45:
      id: 'bats_edgx'
      doc: 'Bats Edgx'
    0x4a:
      id: 'ise_mercury'
      doc: 'Ise Mercury'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable The Capacity Of This Side Of Trade Is Not O Or A'
  contra_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x59:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'market_maker'
      doc: 'On Floor Specialist Sqt Or Rot Phlx Or Nombx Options Market Maker Nombx Options'
    0x4f:
      id: 'non_registered_market_maker'
      doc: 'Non Phlx Registered Market Maker Phlx Or Non Nombx Options Registered Market Maker Nombx Options'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Stock Leg Execution Or Routed Away Execution'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo'
  short_sell:
    0x59:
      id: 'short_sale'
      doc: 'Short Sale'
    0x4e:
      id: 'not_a_short_sale'
      doc: 'Not A Short Sale'
    0x45:
      id: 'short_sale_exempt'
      doc: 'Short Sale Exempt'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Not A Stock Leg'
  principal_agent:
    0x41:
      id: 'agency'
      doc: 'Agency Order'
    0x50:
      id: 'principal'
      doc: 'Principle'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principle'
    0x20:
      id: 'not_a_stock_leg'
      doc: 'Not A Stock Leg'
  origin_type:
    0x4f:
      id: 'fix_order'
      doc: 'Fix Order'
    0x54:
      id: 'otto_quo_order'
      doc: 'Ottoquo Order'
    0x45:
      id: 'otto_sweep'
      doc: 'Otto Sweep'
    0x51:
      id: 'sqf_quote'
      doc: 'Sqf Quote'
    0x57:
      id: 'sqf_sweep'
      doc: 'Sqf Sweep'
    0x47:
      id: 'pixl_prism_primary_fix_order'
      doc: 'Pixlprism Primary Fix Order'
    0x48:
      id: 'pixl_prism_contra_fix_order'
      doc: 'Pixlprism Contra Fix Order'
    0x49:
      id: 'pixl_prism_response_fix_order'
      doc: 'Pixlprism Response Fix Order'
    0x4a:
      id: 'pixl_prism_response_sqf_sweep'
      doc: 'Pixlprism Response Sqf Sweep'
    0x20:
      id: 'others'
      doc: 'Others'
  tif:
    0x49:
      id: 'ioc'
      doc: 'Ioc'
    0x44:
      id: 'day'
      doc: 'Day'
    0x47:
      id: 'gtc'
      doc: 'Gtc'
    0x4f:
      id: 'opg'
      doc: 'Opg'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Quotes Manual Trades Trade Cancels And Corrections'

