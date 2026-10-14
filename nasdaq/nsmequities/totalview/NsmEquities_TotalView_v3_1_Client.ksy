# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView AsciiItch v3.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Ascii Itch
#   Version: 3.1
#   Date: 10/06/2010
#   Specification: Nasdaq TotalView ITCH (3.1).pdf
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
  id: nasdaq_nsmequities_totalview_asciiitch_v3_1_client
  title: Nasdaq NsmEquities TotalView AsciiItch v3.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch AsciiItch v3.1'
doc-ref: https://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

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
      doc: 'This message is sent every second for which at least one TotalView-ITCH 3.1 message is being generated.'
    0x4d:
      id: 'milliseconds_message'
      doc: 'This message is sent every millisecond for which at least one TotalView-ITCH 3.1 message is being generated.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, NASDAQ disseminates stock directory messages for all active symbols in Single Book.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'NASDAQ uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x4c:
      id: 'market_participant_position_message'
      doc: 'At the start of each trading day, NASDAQ disseminates a spin of market participant position messages. Throughout the day, NASDAQ will send out this message only if NASDAQ Operations changes the status of a market participant firm in an issue.'
    0x41:
      id: 'add_order_message'
      doc: 'An Add Order Message indicates that a new order has been accepted by the NASDAQ system and was added to the displayable book. The message includes a day-unique Order Reference Number used by NASDAQ to track the order. This message will be generated for unattributed orders in the NASDAQ Single Book system.'
    0x46:
      id: 'add_order_with_mpid_message'
      doc: 'This message will be generated for attributed orders and quotations entered into the NASDAQ Single Book system.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part at a price different from the initial display price.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being cancelled. All remaining shares are no longer accessible so the order should be removed from the book.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancel and replaced. All remaining shares from the original order are no longer accessible, and must be removed. The new order details are provided for the replacement, along with a new order reference number which will be used henceforth. The side, stock, and attribution (if any) remain the same as the original order, so they are not given in this message.'
    0x50:
      id: 'trade_message'
      doc: 'The Trade Message is designed to provide execution details for normal match events involving non-displayable order types.'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross Trade message indicates that NASDAQ has completed its cross process for a specific security.'
    0x42:
      id: 'broken_trade_message'
      doc: 'The Broken Trade Message is sent whenever an execution on NASDAQ is broken.'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'NASDAQ disseminates NOII data at 5-second intervals in the minutes leading up to the NASDAQ Opening Cross, NASDAQ Closing Cross and NASDAQ IPO/Halt Cross.'
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
  market_category:
    0x54:
      id: 'cqs'
      doc: 'CQS (NYSE, Amex or regional exchange)'
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'NASDAQ Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'NASDAQ Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'NASDAQ Capital Market'
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
    0x20:
      id: 'in_compliance'
      doc: 'Company is in compliance, if NASDAQ-listed issue. For CQS issues, this field will also be space-filled.'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Only round lots are accepted in this stock'
    0x4e:
      id: 'odd_and_mixed_lots_allowed'
      doc: 'Odd/mixed lots are allowed'
  trading_state:
    0x48:
      id: 'halted_or_paused_all_markets'
      doc: 'Halted or paused across all U.S. equity markets / SROs'
    0x56:
      id: 'halted_or_paused_nasdaq_only'
      doc: 'Halted or paused on NASDAQ only'
    0x51:
      id: 'quotation_only_cross_sro'
      doc: 'Quotation only period for cross-SRO halt or pause'
    0x52:
      id: 'quotation_only_nasdaq_only'
      doc: 'Quotation only period for NASDAQ only halt or pause'
    0x54:
      id: 'trading'
      doc: 'Trading on NASDAQ'
  primary_market_maker:
    0x59:
      id: 'primary'
      doc: 'Primary market maker'
    0x4e:
      id: 'non_primary'
      doc: 'Non-primary market maker'
  market_maker_mode:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x50:
      id: 'passive'
      doc: 'Passive'
    0x53:
      id: 'syndicate'
      doc: 'Syndicate'
    0x52:
      id: 'pre_syndicate'
      doc: 'Pre-syndicate'
    0x4c:
      id: 'penalty'
      doc: 'Penalty'
  market_participant_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x45:
      id: 'excused'
      doc: 'Excused/Withdrawn'
    0x57:
      id: 'withdrawn'
      doc: 'Withdrawn'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x44:
      id: 'deleted'
      doc: 'Deleted'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy order.'
    0x53:
      id: 'sell'
      doc: 'Sell order.'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non-printable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  cross_type:
    0x4f:
      id: 'opening_cross'
      doc: 'NASDAQ Opening Cross'
    0x43:
      id: 'closing_cross'
      doc: 'NASDAQ Closing Cross'
    0x48:
      id: 'ipo_and_halted_cross'
      doc: 'Cross for IPO and halted / paused securities'
    0x49:
      id: 'cross_network'
      doc: 'NASDAQ Cross Network: Intraday Cross and Post-Close Cross. Cross Trade Message only.'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy imbalance'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No imbalance'
    0x4f:
      id: 'insufficient_orders'
      doc: 'Insufficient orders to calculate'
  price_variation_indicator:
    0x4c:
      id: 'less_than_one_percent'
      doc: 'Less than 1%'
    0x31:
      id: 'one_to_one_point_nine_nine_percent'
      doc: '1 to 1.99%'
    0x32:
      id: 'two_to_two_point_nine_nine_percent'
      doc: '2 to 2.99%'
    0x33:
      id: 'three_to_three_point_nine_nine_percent'
      doc: '3 to 3.99%'
    0x34:
      id: 'four_to_four_point_nine_nine_percent'
      doc: '4 to 4.99%'
    0x35:
      id: 'five_to_five_point_nine_nine_percent'
      doc: '5 to 5.99%'
    0x36:
      id: 'six_to_six_point_nine_nine_percent'
      doc: '6 to 6.99%'
    0x37:
      id: 'seven_to_seven_point_nine_nine_percent'
      doc: '7 to 7.99%'
    0x38:
      id: 'eight_to_eight_point_nine_nine_percent'
      doc: '8 to 8.99%'
    0x39:
      id: 'nine_to_nine_point_nine_nine_percent'
      doc: '9 to 9.99%'
    0x41:
      id: 'ten_to_nineteen_point_nine_nine_percent'
      doc: '10 to 19.99%'
    0x42:
      id: 'twenty_to_twenty_nine_point_nine_nine_percent'
      doc: '20 to 29.99%'
    0x43:
      id: 'thirty_percent_or_greater'
      doc: '30% or greater'
    0x20:
      id: 'cannot_be_calculated'
      doc: 'Cannot be calculated'

