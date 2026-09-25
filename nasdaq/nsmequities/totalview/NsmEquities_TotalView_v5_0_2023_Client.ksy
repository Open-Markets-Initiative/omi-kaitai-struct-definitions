# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Itch v5.0.2023
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Itch
#   Version: 5.0.2023
#   Date: 04/28/2023
#   Specification: NQTVITCHSpecification.pdf
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
  id: nasdaq_nsmequities_totalview_itch_v5_0_2023_client
  title: Nasdaq NsmEquities TotalView Itch v5.0.2023
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Itch v5.0.2023'
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
      doc: 'Nasdaq Is Now Closed And Will Not Accept Any New Orders Today'
    0x43:
      id: 'end_of_messages'
      doc: 'Always The Last Message Sent In Any Trading Day'
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
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x5a:
      id: 'bats_z'
      doc: 'Bats Z Exchange'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
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
      id: 'creations_and_redemptions_suspended'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Firms Should Refer To Siac Feeds For Code If Needed'
  round_lots_only:
    0x59:
      id: 'yes_field'
      doc: 'Nasdaq System Only Accepts Round Lot Orders For This Security'
    0x4e:
      id: 'no_field'
      doc: 'Nasdaq System Does Not Have Any Order Size Restrictions For This Security'
  issue_classification:
    0x41:
      id: 'american_depositary_share'
      doc: 'American Depositary Share'
    0x42:
      id: 'bond'
      doc: 'Bond'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x46:
      id: 'depository_receipt'
      doc: 'Depository Receipt'
    0x49:
      id: 'sec_144_a'
      doc: 'Sec 144 A'
    0x4c:
      id: 'limited_partnership'
      doc: 'Limited Partnership'
    0x4e:
      id: 'notes'
      doc: 'Notes'
    0x4f:
      id: 'ordinary_share'
      doc: 'Ordinary Share'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x51:
      id: 'other_securities'
      doc: 'Other Securities'
    0x52:
      id: 'right'
      doc: 'Right'
    0x53:
      id: 'shares_of_beneficial_interest'
      doc: 'Shares Of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_of_beneficial_interest'
      doc: 'Units Of Beneficial Interest'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
  short_sale_threshold_indicator:
    0x59:
      id: 'restricted'
      doc: 'Issue Is Restricted Under Sec Rule 203 B 3'
    0x4e:
      id: 'not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'not_available'
      doc: 'Threshold Indicator Not Available'
  ipo_flag:
    0x59:
      id: 'set_up_for_ipo_release'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'not_set_up_for_ipo_release'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1'
      doc: 'Tier 1 Nms Stocks And Select Et Ps'
    0x32:
      id: 'tier_2'
      doc: 'Tier 2 Nms Stocks'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Instrument Is An Etp'
    0x4e:
      id: 'not_etp'
      doc: 'Instrument Is Not An Etp'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'Etp Is Not An Inverse Etp'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasda Qlisted Securities Only'
    0x51:
      id: 'quotation_only_period'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'test_restriction_remains'
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
      doc: 'Pre Syndicate'
    0x4c:
      id: 'penalty'
      doc: 'Penalty'
  market_participant_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x45:
      id: 'excused'
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
  breached_level:
    0x31:
      id: 'level_1'
      doc: 'Level 1'
    0x32:
      id: 'level_2'
      doc: 'Level 2'
    0x33:
      id: 'level_3'
      doc: 'Level 3'
  ipo_quotation_release_qualifier:
    0x41:
      id: 'anticipated_quotation_release_time'
      doc: 'Used When Nasdaq Market Operations Initially Enters The Ipo Instrument For Release'
    0x43:
      id: 'ipo_release_canceled_or_postponed'
      doc: 'Used When Nasdaq Market Operations Cancels Or Postpones The Release Of The New Ipo Instrument'
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'bx'
      doc: 'Bx'
    0x58:
      id: 'psx'
      doc: 'Psx'
  operational_halt_action:
    0x48:
      id: 'halted'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'trading_resumed'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  printable:
    0x4e:
      id: 'no_field'
      doc: 'Nonprintable'
    0x59:
      id: 'yes_field'
      doc: 'Printable'
  cross_type:
    0x4f:
      id: 'opening'
      doc: 'Nasdaq Opening Cross'
    0x43:
      id: 'closing'
      doc: 'Nasdaq Closing Cross'
    0x48:
      id: 'halted_or_paused'
      doc: 'Cross For Ipo And Halted Paused Securities'
    0x41:
      id: 'extended_close'
      doc: 'Extended Trading Close'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'none'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders'
      doc: 'Insufficient Orders To Calculate'
    0x50:
      id: 'paused'
      doc: 'Paused'
  price_variation_indicator:
    0x4c:
      id: 'less_than_1_percent'
      doc: 'Less Than 1%'
    0x31:
      id: 'less_than_2_percent'
      doc: '1 To 1.99%'
    0x32:
      id: 'less_than_3_percent'
      doc: '2 To 2.99%'
    0x33:
      id: 'less_than_4_percent'
      doc: '3 To 3.99%'
    0x34:
      id: 'less_than_5_percent'
      doc: '4 To 4.99%'
    0x35:
      id: 'less_than_6_percent'
      doc: '5 To 5.99%'
    0x36:
      id: 'less_than_7_percent'
      doc: '6 To 6.99%'
    0x37:
      id: 'less_than_8_percent'
      doc: '7 To 7.99%'
    0x38:
      id: 'less_than_9_percent'
      doc: '8 To 8.99%'
    0x39:
      id: 'less_than_10_percent'
      doc: '9 To 9.99%'
    0x41:
      id: 'less_than_20_percent'
      doc: '10 To 19.99%'
    0x42:
      id: 'less_than_30_percent'
      doc: '20 To 29.99%'
    0x43:
      id: 'more_than_30_percent'
      doc: '30% Or Greater'
    0x20:
      id: 'not_available'
      doc: 'Cannot Be Calculated'
  interest_flag:
    0x42:
      id: 'buy_side'
      doc: 'Rpi Orders Available On The Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Rpi Orders Available On The Sell Side'
    0x41:
      id: 'both_sides'
      doc: 'Rpi Orders Available On Both Sides Buy And Sell'
    0x4e:
      id: 'no_rpi_orders_available'
      doc: 'No Rpi Orders Available'
  open_eligibility_status:
    0x4e:
      id: 'not_eligible'
      doc: 'Not Eligible'
    0x59:
      id: 'eligible'
      doc: 'Eligible'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event'
    0x52:
      id: 'stock_directory_message'
      doc: 'Market data redistributors should process this message to populate the Financial Status Indicator (required display field) and the Market Category (recommended display field) for NASDAQ-listed issues.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Nasaq processes orders based on the most Reg SHO Restriction status value'
    0x4c:
      id: 'market_participant_position_message'
      doc: 'Nasdaq will send out this message only if Nasdaq Operations changes the status of a market participant firm in an issue'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_status_level_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x4b:
      id: 'ipo_quoting_period_update'
      doc: 'Indicates the anticipated IPO quotation release time of a security.'
    0x4a:
      id: 'luld_auction_collar_message'
      doc: 'Indicates the auction collar thresholds within which a paused security can reopen following a LULD trading pause'
    0x68:
      id: 'operational_halt_message'
      doc: 'An Operational Halt means that there has been an interruption of service on the identified security impacting only the designated Market Center'
    0x41:
      id: 'add_order_no_mpid_attribution_message'
      doc: 'This message will be generated for unattributed orders accepted by the Nasdaq system'
    0x46:
      id: 'add_order_with_mpid_attribution_message'
      doc: 'This message will be generated for attributed orders and quotations accepted by the Nasdaq system'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part at a price different from the initial display price'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being cancelled'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancel-replaced'
    0x50:
      id: 'non_cross_trade_message'
      doc: 'Trade Messages should be included in NASDAQ time-and-sales displays as well as volume and other market statistics'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross Trade message indicates that Nasdaq has completed its cross process for a specific security'
    0x42:
      id: 'broken_trade_message'
      doc: 'The Broken Trade Message is sent whenever an execution on Nasdaq is broken'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'NASDAQ disseminates NOII data'
    0x4e:
      id: 'retail_price_improvement_indicator_message'
      doc: 'Identifies a retail interest indication of the Bid, Ask or both the Bid and Ask for NASDAQ-listed securities.'
    0x4f:
      id: 'direct_listing_with_capital_raise_price_discovery_message'
      doc: 'This message is disseminated only for Direct Listing with Capital Raise (DLCR) securities'

