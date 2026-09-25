# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Itch v4.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Itch
#   Version: 4.1
#   Date: 06/12/2014
#   Specification: NQTV-ITCH-V4_1.pdf
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
  id: nasdaq_nsmequities_totalview_itch_v4_1_client
  title: Nasdaq NsmEquities TotalView Itch v4.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Itch v4.1'
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
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders Today It Is Still Possible To Receive Broken Trade Messages And Order Delete Messages After The End Of Day'
    0x43:
      id: 'end_of_messages'
      doc: 'This Is Always The Last Message Sent In Any Trading Day'
    0x41:
      id: 'emergency_market_condition_halt'
      doc: 'This Message Is Sent To Inform Nasdaq Market Participants That The Emc Is In Effect No Trading Is Allowed During The Emc'
    0x52:
      id: 'emergency_market_condition_quote_only_period'
      doc: 'This Message Is Sent To Inform Nasdaq Market Participants That The Emc Quotation Only Period Is In Effect'
    0x42:
      id: 'emergency_market_condition_resumption'
      doc: 'This Message Is Sent To Inform Nasdaq Market Participants That Emc Is No Longer In Effect'
  market_category:
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x41:
      id: 'amex'
      doc: 'New York Stock Exchange Amex'
    0x50:
      id: 'arca'
      doc: 'New York Stock Exchange Arca'
    0x51:
      id: 'nasdaq_gsm'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_gm'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_cm'
      doc: 'Nasdaq Capital Market'
    0x5a:
      id: 'bats'
      doc: 'Bats Bzx Exchange'
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
    0x20:
      id: 'in_compliance'
      doc: 'Company Is In Compliance If Nasda Qlisted Issue'
  round_lots_only:
    0x59:
      id: 'yes_field'
      doc: 'Only Round Lots Are Accepted In This Stock'
    0x4e:
      id: 'no_field'
      doc: 'Oddmixed Lots Are Allowed'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasda Qlisted Securities Only'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'reg_sho_short_sale_price_test'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  primary_market_maker:
    0x59:
      id: 'primary'
      doc: 'Primary Market Maker'
    0x4e:
      id: 'non_primary'
      doc: 'Nonprimary Market Maker'
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
      doc: 'Presyndicate'
    0x4c:
      id: 'penalty'
      doc: 'Penalty'
  market_participant_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x45:
      id: 'excused_withdrawn'
      doc: 'Excused Withdrawn'
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
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  cross_type:
    0x4f:
      id: 'opening'
      doc: 'Nasdaq Opening Cross'
    0x43:
      id: 'closing'
      doc: 'Nasdaq Closing Cross'
    0x48:
      id: 'cross_for_ipo_and_halted'
      doc: 'Cross For Ipo And Halted Paused Securities'
    0x49:
      id: 'nasdaq_cross_network'
      doc: 'Nasdaq Cross Network Intraday Cross And Post Close Cross'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'no_field'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders'
      doc: 'Insufficient Orders To Calculate'
  price_variation_indicator:
    0x4c:
      id: 'less'
      doc: 'Less Than 1%'
    0x31:
      id: 'one_to_one_point_nine_nine_percent'
      doc: '1 To 1.99%'
    0x32:
      id: 'two_to_two_point_nine_nine_percent'
      doc: '2 To 2.99%'
    0x33:
      id: 'three_to_three_point_nine_nine_percent'
      doc: '3 To 3.99%'
    0x34:
      id: 'four_to_four_point_nine_nine_percent'
      doc: '4 To 4.99%'
    0x35:
      id: 'five_to_five_point_nine_nine_percent'
      doc: '5 To 5.99%'
    0x36:
      id: 'six_to_six_point_nine_nine_percent'
      doc: '6 To 6.99%'
    0x37:
      id: 'seven_to_seven_point_nine_nine_percent'
      doc: '7 To 7.99%'
    0x38:
      id: 'eight_to_eight_point_nine_nine_percent'
      doc: '8 To 8.99%'
    0x39:
      id: 'nine_to_nine_point_nine_nine_percent'
      doc: '9 To 9.99%'
    0x41:
      id: 'ten_to_nineteen_point_nine_nine_percent'
      doc: '10 To 19.99%'
    0x42:
      id: 'twenty_to_twenty_nine_point_nine_nine_percent'
      doc: '20 To 29.99%'
    0x43:
      id: 'thirty_percent_or_greater'
      doc: '30% Or Greater'
    0x20:
      id: 'no_calculation'
      doc: 'Cannot Be Calculated'
  interest_flag:
    0x42:
      id: 'rpi_buy'
      doc: 'Rpi Orders Available On The Buy Side'
    0x53:
      id: 'rpi_sell'
      doc: 'Rpi Orders Available On The Sell Side'
    0x41:
      id: 'rpi_both'
      doc: 'Rpi Orders Available On Both Sides Buy And Sell'
    0x4e:
      id: 'no_rpi'
      doc: 'No Rpi Orders Available'
  message_type:
    0x54:
      id: 'timestamp_message'
      doc: 'Reflects the number of seconds past midnight that the Timestamp message was generated.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event. The format is as follows:'
    0x52:
      id: 'stock_directory_message'
      doc: 'Market data redistributors should process this message to populate the Financial Status Indicator (required display field) and the Market Category (recommended display field) for NASDAQ-listed issues.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'NASDAQ uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'For NASDAQ-listed issues, NASDAQ will support a full pre-opening spin of Reg SHO Short Sale Price Test Restricted Indicator messages indicating the Rule 201 status for all active issues.'
    0x4c:
      id: 'market_participant_position_message'
      doc: 'NASDAQ will send out this message only if NASDAQ Operations changes the status of a market participant firm in an issue.'
    0x41:
      id: 'add_order_message'
      doc: 'This message will be generated for unattributed orders accepted by the NASDAQ system.'
    0x46:
      id: 'add_order_with_mpid_message'
      doc: 'This message will be generated for attributed orders and quotations accepted by the NASDAQ system.'
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
      doc: 'This message is sent whenever an order on the book is being canceled.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancel-replaced.'
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
      doc: 'NASDAQ disseminates NOII data at 5-second intervals in the minutes leading up to the NASDAQ Opening Cross and NASDAQ Closing Cross'
    0x4e:
      id: 'retail_price_improvement_indicator_message'
      doc: 'Identifies a retail interest indication of the Bid, Ask or both the Bid and Ask for NASDAQ-listed securities.'

