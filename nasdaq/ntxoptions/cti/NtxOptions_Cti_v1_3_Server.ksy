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
  id: nasdaq_ntxoptions_cti_itch_v1_3_server
  title: Nasdaq NtxOptions Cti Itch v1.3
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Texas Options Clearing Trade Interface Itch v1.3'
doc-ref:
  - https://www.nasdaqtrader.com/content/technicalsupport/specifications/tradingproducts/Options_CTI.pdf
  - https://www.nasdaq.com/docs/ClearingTradeInterface.pdf

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::options_directory_message': options_directory_message
            'sequenced_message_type::security_trading_action_message': security_trading_action_message
            'sequenced_message_type::trade_message': trade_message
            'sequenced_message_type::cancel_trade_message': cancel_trade_message
  system_event_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of timestamp: whole seconds after midnight US Eastern Time (0 to 86400)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of timestamp (0 to 999999999)'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes'
      - id: version
        type: u1
        doc: 'CTI version (currently set to 12, as printed)'
  options_directory_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of timestamp: whole seconds after midnight US Eastern Time (0 to 86400)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of timestamp (0 to 999999999)'
      - id: option_id
        type: u4
        doc: 'Option id assigned by exchange daily'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option root symbol'
      - id: expiration
        type: expiration
        doc: 'Expiration date of the option packed into 2 bytes: Bits 0-6 = Year (0-99), Bits 7-10 = Month (1-12), Bits 11-15 = Day (1-31); bit 15 is the least significant bit'
      - id: strike_price
        type: decimal_u4_4
        doc: 'Strike price of the option: fixed point with 4 decimal digits. Implied decimal with scale 1e-4'
      - id: option_kind
        type: u1
        enum: option_kind
        doc: 'C = Call, P = Put'
      - id: source
        type: u1
        doc: 'Connection source: 0 = Away trade Connection, 1-N = Local trade connection'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying stock symbol (left justified, space filled)'
      - id: option_closing_type
        type: u1
        enum: option_closing_type
        doc: 'N = Normal hours, L = Late hours, W = WCO Early Closing at 12:00 Noon (PHLX Only)'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Y = Option is tradable, N = Option is not tradable'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option: E = penny Everywhere, S = Scaled, P = penny Pilot'
  expiration:
    seq:
      - id: expiration_year
        type: b7
        doc: 'Year (0-99): document bits 0-6'
      - id: expiration_month
        type: b4
        doc: 'Month (1-12): document bits 7-10'
      - id: expiration_day
        type: b5
        doc: 'Day (1-31): document bits 11-15'
  security_trading_action_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of timestamp: whole seconds after midnight US Eastern Time (0 to 86400)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of timestamp (0 to 999999999)'
      - id: option_id
        type: u4
        doc: 'Option id assigned by exchange daily'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option root symbol'
      - id: expiration
        type: expiration
        doc: 'Expiration date of the option packed into 2 bytes: Bits 0-6 = Year (0-99), Bits 7-10 = Month (1-12), Bits 11-15 = Day (1-31); bit 15 is the least significant bit'
      - id: strike_price
        type: decimal_u4_4
        doc: 'Strike price of the option: fixed point with 4 decimal digits. Implied decimal with scale 1e-4'
      - id: option_kind
        type: u1
        enum: option_kind
        doc: 'C = Call, P = Put'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Current trading state for the option on the exchange: H = Halt in effect, T = Trading resumed'
  trade_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of timestamp: whole seconds after midnight US Eastern Time (0 to 86400)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of timestamp (0 to 999999999)'
      - id: send_type
        type: u1
        enum: send_type
        doc: 'S = Send (original transmission), P = Possible duplicate (unsolicited retransmission)'
      - id: option_id
        type: u4
        doc: 'Option id assigned by exchange daily'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying stock symbol (left justified, space filled)'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option root symbol'
      - id: expiration
        type: expiration
        doc: 'Expiration date of the option packed into 2 bytes: Bits 0-6 = Year (0-99), Bits 7-10 = Month (1-12), Bits 11-15 = Day (1-31); bit 15 is the least significant bit'
      - id: strike_price
        type: decimal_u4_4
        doc: 'Strike price of the option: fixed point with 4 decimal digits. Implied decimal with scale 1e-4'
      - id: option_kind
        type: u1
        enum: option_kind
        doc: 'C = Call, P = Put'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade message symbol flags (2 bytes); bit 15 is the least significant bit. When available, only one of Bits 3, 4 and 5 will be set to 1 for an option'
      - id: transaction_type
        type: u1
        enum: transaction_type
        doc: 'X = new trade, Y = trade correction, Z = trade cancel (if trade cancel messages are to be sent using this message)'
      - id: liquidity
        type: u1
        enum: liquidity
        doc: 'Liquidity indicator. Additional alphanumeric values may be added in the future and should be considered as potential valid values'
      - id: trade_id
        type: u4
        doc: 'Clearing trade Id. Coupled with correction number and trade side uniquely identifies a clearing trade for a given day'
      - id: correction_number
        type: u2
        doc: 'Trade correction number. 0 for new trades. Used to identify version of the trade being corrected; increments by 1 for each subsequent correction'
      - id: cross_id
        type: u4
        doc: 'Trade Group Id. Ties together all clearing trades of a given atomic transaction in the matching engine. 0 if cross id is not available'
      - id: match_id
        type: u4
        doc: 'Execution Id (0 for manual trades). Uniquely identifies an execution for a given day; can be used to match executions sent on SQF or other feeds'
      - id: auction_id
        type: u4
        doc: 'Auction id for trades resulting from an auction (e.g. Complex Order Live Auction (COLA), PIXL/PRISM Auction) or 0 if none'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type for trades resulting from an auction. Blank for Manual Trades, Trade Corrections and Cancels'
      - id: ref_trade_id
        type: u4
        doc: 'For corrected trades, trade id of prior trade. 0 if never corrected'
      - id: ref_correction_number
        type: u2
        doc: 'For corrected trades, correction number of prior trade. 0 if never corrected'
      - id: execution_type
        type: u1
        enum: execution_type
        doc: 'A = automatic, M = manual. A trade is automatic when it is assigned by the electronic matching engine'
      - id: execution_market
        type: u1
        enum: execution_market
        doc: 'Away execution market id, space for trades that are not away'
      - id: trade_side
        type: u1
        enum: trade_side
        doc: 'B = Buy, S = Sell'
      - id: trade_price
        type: decimal_u4_4
        doc: 'Trade price: fixed point with 4 decimal digits. Implied decimal with scale 1e-4'
      - id: trade_contracts
        type: u4
        doc: 'Trade contracts'
      - id: side_changed
        type: u1
        enum: side_changed
        doc: 'Y = new trades and corrections that affected this side of the trade, N = corrections that affected only contra side'
      - id: strategy_id
        type: u4
        doc: 'Complex order strategy id which this trade is associated with. Populated if either side of the trade involves a Complex Order, otherwise 0'
      - id: strategy_leg
        type: u2
        doc: 'Leg reference (leg index starting from 0 in the Complex Order Strategy message) if either side of the trade involves a complex order or sweep'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future extension'
      - id: occ_clearing_number
        type: u4
        doc: 'Same side: OCC clearing number or CMTA provided by firm'
      - id: give_up_occ_clearing_number
        type: u4
        doc: 'Same side: OCC clearing number of the giving-up firm if OCC clearing number above is CMTA, otherwise 0'
      - id: exchange_clearing_number
        type: u4
        doc: 'Same side: Exchange assigned clearing number'
      - id: exchange_house
        type: u4
        doc: 'Same side: Exchange assigned house number'
      - id: exchange_suffix
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Same side: Exchange assigned house suffix for market makers (badge suffix)'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Same side capacity'
      - id: multi_account
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Same side: Sub or multi account if provided in the order (FIX tag 440 Clearing Account)'
      - id: broker
        type: u4
        doc: 'Same side: Floor broker number'
      - id: second_broker
        type: u4
        doc: 'Same side: 2nd floor broker number'
      - id: origin_market
        type: u1
        enum: origin_market
        doc: 'Originating market of the order for market makers (FIX tag 207 Security Exchange); space when the capacity of this side of the trade is not O or A'
      - id: account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account as specified in the order (FIX tag 1 Account)'
      - id: nscc
        type: u4
        doc: 'Same side: NSCC clearing number for a stock leg'
      - id: mpid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Same side: NASDAQ assigned MPID number for a stock leg'
      - id: clearing_flags
        type: clearing_flags
        doc: 'Same side clearing flags (2 bytes). Only Bit 0 is defined; numbered, as in the other 2 byte flag fields of this message, with bit 15 the least significant bit'
      - id: reserved_6
        size: 6
        doc: 'Reserved for future extension'
      - id: contra_occ_clearing_number
        type: u4
        doc: 'Contra side: OCC clearing number or CMTA provided by firm'
      - id: contra_give_up_occ_clearing_number
        type: u4
        doc: 'Contra side: OCC clearing number of the giving-up firm if OCC clearing number above is CMTA, otherwise 0'
      - id: contra_exchange_clearing_number
        type: u4
        doc: 'Contra side: Exchange assigned clearing number'
      - id: contra_exchange_house
        type: u4
        doc: 'Contra side: Exchange assigned house number'
      - id: contra_capacity
        type: u1
        enum: contra_capacity
        doc: 'Contra side capacity'
      - id: contra_broker
        type: u4
        doc: 'Contra side: Floor broker number'
      - id: contra_second_broker
        type: u4
        doc: 'Contra side: 2nd floor broker number'
      - id: contra_nscc
        type: u4
        doc: 'Contra side: NSCC clearing number for a stock leg'
      - id: contra_mpid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contra side: NASDAQ assigned MPID number for a stock leg'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future extension'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm for FIX/OTTO orders or spaces'
      - id: order_date
        type: order_date
        doc: 'Date when a FIX order is received, packed into 2 bytes: Bits 0-6 = Year (0-99), Bits 7-10 = Month (1-12), Bits 11-15 = Day (1-31); bit 15 is the least significant bit. 0 if the order is not a FIX order'
      - id: order_id
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Right padded FIX/OTTO order id or spaces'
      - id: quote_id
        type: u8
        doc: 'Quote id for quotes with ids (from SQF feed v6 and higher). Right padded 1 for quotes without ids, spaces if this side of the trade is not a quote. Binary'
      - id: sweep_id
        type: u8
        doc: 'Sweep id for order sweeps with ids (from SQF feed v6 and higher). Right padded 1 for sweeps without ids, spaces if this side of the trade is not a sweep. Binary'
      - id: open_close_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open/Close indicator from FIX/OTTO orders. Space for stock leg'
      - id: customer_strategy_leg
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Leg reference id of a complex order as sent by the customer or spaces'
      - id: short_sell
        type: u1
        enum: short_sell
        doc: 'Short sell for a stock leg: Y = Short Sale, N = Not a Short Sale, E = Short Sale Exempt, space = Not Applicable (Not a Stock Leg)'
      - id: principal_agent
        type: u1
        enum: principal_agent
        doc: 'Capacity for a stock leg: A = Agency Order, P = Principle, R = Riskless Principle, space = Not a stock leg'
      - id: supplementary_id
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Supplementary Id from FIX orders (FIX tag 58 Text)'
      - id: order_indicators
        type: order_indicators
        doc: 'Same side order indicators (2 bytes); bit 15 is the least significant bit. Directed, Post Only and MKT Order indicators are not available for Manual Trades, Trade Correction and Cancels'
      - id: origin_type
        type: u1
        enum: origin_type
        doc: 'Origin of this side of the trade'
      - id: order_size
        type: u4
        doc: 'Size of the order/quote/sweep or 0 for manual trades, trade corrections and cancels'
      - id: order_price
        type: decimal_u4_4
        doc: 'Price of the order/quote/sweep: fixed point with 4 decimal digits. 0 for MKT Orders (indicated by the MKT bit in Order Indicators) and for manual trades, trade corrections and cancels. Implied decimal with scale 1e-4'
      - id: tif
        type: u1
        enum: tif
        doc: 'Time In Force for the order/quote/sweep'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future extension'
  trade_flags:
    seq:
      - id: penny_pilot
        type: b1
        doc: 'Bit 0: Symbol in Penny Pilot (0=no, 1=yes)'
      - id: make_take_program
        type: b1
        doc: 'Bit 1: Symbol In Make/Take Program (0=no, 1=yes)'
      - id: single_listed
        type: b1
        doc: 'Bit 2: Single Listed (0=no, 1=yes). Will be available at a future date'
      - id: weekly_expiration
        type: b1
        doc: 'Bit 3: Weekly Expiration (0=no, 1=yes). Will be available at a future date'
      - id: monthly_expiration
        type: b1
        doc: 'Bit 4: Monthly Expiration (0=no, 1=yes). Will be available at a future date'
      - id: quarterly_expiration
        type: b1
        doc: 'Bit 5: Quarterly Expiration (0=no, 1=yes). Will be available at a future date'
      - id: reserved_trade_flags
        type: b10
        doc: 'Bits 6-15: Not Used'
  clearing_flags:
    seq:
      - id: priority_market_maker
        type: b1
        doc: 'Bit 0: Priority Market Maker (0=no, 1=yes)'
      - id: reserved_clearing_flags
        type: b15
        doc: 'Bits 1-15: Not Used'
  order_date:
    seq:
      - id: order_date_year
        type: b7
        doc: 'Year (0-99): document bits 0-6'
      - id: order_date_month
        type: b4
        doc: 'Month (1-12): document bits 7-10'
      - id: order_date_day
        type: b5
        doc: 'Day (1-31): document bits 11-15'
  order_indicators:
    seq:
      - id: fbms_order
        type: b1
        doc: 'Bit 0: FBMS order (0-no, 1-yes)'
      - id: directed
        type: b1
        doc: 'Bit 1: Directed (0-no, 1-yes)'
      - id: post_only
        type: b1
        doc: 'Bit 2: Post Only (0-no, 1-yes). Will be available at a future date'
      - id: mkt_order
        type: b1
        doc: 'Bit 3: MKT Order (0-no, 1-yes)'
      - id: reserved_order_indicators
        type: b12
        doc: 'Bits 4-15: not used'
  cancel_trade_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of timestamp: whole seconds after midnight US Eastern Time (0 to 86400)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of timestamp (0 to 999999999)'
      - id: send_type
        type: u1
        enum: send_type
        doc: 'S = Send (original transmission), P = Possible duplicate (unsolicited retransmission)'
      - id: option_id
        type: u4
        doc: 'Option id assigned by exchange daily'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying stock symbol (left justified, space filled)'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option root symbol'
      - id: expiration
        type: expiration
        doc: 'Expiration date of the option packed into 2 bytes: Bits 0-6 = Year (0-99), Bits 7-10 = Month (1-12), Bits 11-15 = Day (1-31); bit 15 is the least significant bit'
      - id: strike_price
        type: decimal_u4_4
        doc: 'Strike price of the option: fixed point with 4 decimal digits. Implied decimal with scale 1e-4'
      - id: option_kind
        type: u1
        enum: option_kind
        doc: 'C = Call, P = Put'
      - id: trade_id
        type: u4
        doc: 'Clearing trade Id. Coupled with correction number and trade side uniquely identifies a clearing trade for a given day'
      - id: correction_number
        type: u2
        doc: 'Trade correction number. 0 for new trades. Used to identify version of the trade being corrected; increments by 1 for each subsequent correction'
      - id: cross_id
        type: u4
        doc: 'Trade Group Id. Ties together all clearing trades of a given atomic transaction in the matching engine. 0 if cross id is not available'
      - id: trade_side
        type: u1
        enum: trade_side
        doc: 'B = Buy, S = Sell'
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

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

