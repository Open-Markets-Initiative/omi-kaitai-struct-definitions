# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NtxOptions Cti Itch v3.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Clearing Trade Interface
#   Encoding: Itch
#   Version: 3.0
#   Date: 08/03/2026
#   Specification: Options_ETH_CTI.pdf
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
  id: nasdaq_ntxoptions_cti_itch_v3_0_server
  title: Nasdaq NtxOptions Cti Itch v3.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Texas Options Clearing Trade Interface Itch v3.0'
doc-ref:
  - https://www.nasdaq.com/products/north-american-markets/resources/options-specifications-and-resources-hub
  - https://www.nasdaq.com/Options_ETH_CTI
  - https://www.nasdaq.com/Options_CTI

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
      - id: version
        type: u1
        doc: 'CTI version, decoded as Mn (major, minor): currently set to 30'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes'
  options_directory_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of timestamp: whole seconds after midnight US Eastern Time (0 to 86400)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of timestamp (0 to 999999999)'
      - id: version
        type: u1
        doc: 'CTI version, decoded as Mn (major, minor): currently set to 30'
      - id: option_id
        type: u4
        doc: 'Option id assigned by exchange daily'
      - id: security_symbol
        type: str
        size: 8
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
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying stock symbol (left justified, space filled). The document types this field Integer'
      - id: option_closing_type
        type: u1
        enum: option_closing_type
        doc: 'N = Normal hours, L = Late hours, W = WCO Early Closing at 12:00 Noon (PHLX only), E = Extended Close (ETH edition)'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Y = Tradable, N = Non-Tradable'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option: E = penny Everywhere, S = Scaled, P = penny Pilot'
      - id: closing_only
        type: u1
        enum: closing_only
        doc: 'Y = Option is Closing Position Only (only MM origin orders can have open position in the series), N = Option is not Closing Position Only'
      - id: contract_size
        type: u4
        doc: 'Underlying Deliverable size'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
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
      - id: version
        type: u1
        doc: 'CTI version, decoded as Mn (major, minor): currently set to 30'
      - id: option_id
        type: u4
        doc: 'Option id assigned by exchange daily'
      - id: security_symbol
        type: str
        size: 8
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
      - id: version
        type: u1
        doc: 'CTI version, decoded as Mn (major, minor): currently set to 30'
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
        doc: 'Underlying stock symbol (left justified, space filled). The document types this field Integer'
      - id: security_symbol
        type: str
        size: 8
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
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: transaction_type
        type: u1
        enum: transaction_type
        doc: 'X = new trade, Y = trade correction, Z = trade cancel (if trade cancel messages are to be sent using this message)'
      - id: liquidity
        type: u1
        enum: liquidity
        doc: 'See Liquidity Codes'
      - id: trade_id
        type: u4
        doc: 'Clearing trade Id. Coupled with correction number and trade side uniquely identifies a clearing trade for a given day'
      - id: correction_number
        type: u2
        doc: 'Trade correction number. 0 for new trades. Used to identify version of the trade being corrected'
      - id: cross_id
        type: u4
        doc: 'Trade Group Id. Ties together all clearing trades of a given atomic transaction in the matching engine. 0 if cross id is not available'
      - id: match_id
        type: u4
        doc: 'Execution Id of the trade'
      - id: auction_id
        type: u4
        doc: 'Auction id for trades resulting from an auction (e.g. Complex Order Live Auction (Exposure/COLA), PIXL/PRISM/PIM Auction) or 0 if none'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type for trades resulting from an auction. Blank for Manual Trades'
      - id: ref_trade_id
        type: u4
        doc: 'For corrected trades, trade id of prior trade. 0 if never corrected'
      - id: ref_correction_number
        type: u2
        doc: 'For corrected trades, correction number of prior trade. 0 if never corrected'
      - id: ref_match_id
        type: u4
        doc: 'For corrected trades, Execution Id of the prior trade'
      - id: execution_type
        type: u1
        enum: execution_type
        doc: 'A = automatic, M = manual. A trade is automatic when it is assigned by the electronic matching engine; order bookings and QCCs originating from the Phlx floor are marked automatic'
      - id: execution_market
        type: u1
        enum: execution_market
        doc: 'Away execution market id for options, space for stock legs on PHLX/ISE/MRX and for trades that are not away. The document types this field Integer; its values are characters'
      - id: trade_side
        type: u1
        enum: trade_side
        doc: 'B = Buy, S = Sell'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Trade price: long, fixed point with 6 decimal digits. Implied decimal with scale 1e-6'
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
        doc: 'Reserved for future use'
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
        doc: 'Same side: Sub or multi account. Stores the Market Maker badge (house + suffix) for On-Floor Market Maker orders with CMTA'
      - id: broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Same side: Floor broker number/Executing Broker'
      - id: second_broker
        type: u4
        doc: 'Same side: 2nd floor broker number'
      - id: origin_market
        type: u1
        enum: origin_market
        doc: 'Originating market of the order for market makers (FIX tag 207 Security Exchange); space when the capacity of this side of the trade is not O'
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
        doc: 'Same side: MPID for the Stock Leg'
      - id: clearing_flags
        type: clearing_flags
        doc: 'Same side clearing flags (2 bytes). Only Bit 0 is defined; numbered, as in the other 2 byte flag fields of this message, with bit 15 the least significant bit'
      - id: executing_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Executing Broker'
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
        doc: 'Contra side: NASDAQ assigned MPID for a stock leg'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm Identifier for the order or Quote'
      - id: order_date
        type: order_date
        doc: 'Date when a FIX order is entered, packed into 2 bytes: Bits 0-6 = Year (0-99), Bits 7-10 = Month (1-12), Bits 11-15 = Day (1-31); bit 15 is the least significant bit. 0 if the order is not a GTC or GTD order'
      - id: order_id
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Right padded FIX/OTTO order id or spaces. Populated with CLOrderID. Not populated when the origin source is FBMS FIX'
      - id: quote_id
        type: u8
        doc: 'Quote id for quotes with ids (from SQF feed v6 and higher). Right padded 1 for quotes without ids, spaces if this side of the trade is not a quote. Binary'
      - id: sqf_sweep_id
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
        size: 10
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
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Supplementary Id from FIX orders (FIX tag 58 Text)'
      - id: order_indicators
        type: order_indicators
        doc: 'Same side order indicators (2 bytes); bit 15 is the least significant bit. Directed/Preferenced, Post Only, ISE Directed and MKT Order indicators are not available for Manual Trades, Trade Correction and Cancels'
      - id: origin_type
        type: u1
        enum: origin_type
        doc: 'Origin of this side of the trade'
      - id: order_size
        type: u4
        doc: 'Size of the order/quote/sweep or 0 for manual trades'
      - id: order_price
        type: decimal_u4_4
        doc: 'Price of the order/quote/sweep: fixed point with 4 decimal digits. 0 for MKT Orders (indicated by the MKT bit in Order Indicators) and for manual trades. Implied decimal with scale 1e-4'
      - id: tif
        type: u1
        enum: tif
        doc: 'Time In Force for the order/quote/sweep. FOK orders are returned with TIF = IOC'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future use'
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
      - id: directed_preferenced
        type: b1
        doc: 'Bit 1: Directed/Preferenced (0-no, 1-yes)'
      - id: post_only_alo
        type: b1
        doc: 'Bit 2: Post Only/ALO (0-no, 1-yes)'
      - id: mkt_order
        type: b1
        doc: 'Bit 3: MKT Order (0-no, 1-yes)'
      - id: ise_directed_order
        type: b1
        doc: 'Bit 4: ISE Directed Order'
      - id: reserved_order_indicators
        type: b11
        doc: 'Bits 5-15: not used'
  cancel_trade_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds portion of timestamp: whole seconds after midnight US Eastern Time (0 to 86400)'
      - id: nanoseconds
        type: u4
        doc: 'Nanoseconds portion of timestamp (0 to 999999999)'
      - id: version
        type: u1
        doc: 'CTI version, decoded as Mn (major, minor): currently set to 30'
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
        doc: 'Underlying stock symbol (left justified, space filled). The document types this field Integer'
      - id: security_symbol
        type: str
        size: 8
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
        doc: 'Trade correction number. 0 for new trades. Used to identify version of the trade being corrected'
      - id: cross_id
        type: u4
        doc: 'Trade Group Id. Ties together all clearing trades of a given atomic transaction in the matching engine. 0 if cross id is not available'
      - id: trade_side
        type: u1
        enum: trade_side
        doc: 'B = Buy, S = Sell'
      - id: match_id
        type: u4
        doc: 'Execution Id of the trade'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

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
      doc: 'The system event message is used to signal a ring wide event.'
    0x44:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, the exchange disseminates directory messages for all symbols trading on a given ring. Sent once per symbol, typically before the Start of System Hours System Event; intra-day updates are sent as they occur.'
    0x48:
      id: 'security_trading_action_message'
      doc: 'Indicates the current trading status of an option within the exchange. A T (Trading resumed) message is sent for all options eligible for trading at the start of system hours; a security absent from the pre-opening spin should be treated as halted.'
    0x54:
      id: 'trade_message'
      doc: 'Clearing trades and trade corrections, with contra side clearing information (trade cancels too when a firm and connection block is configured for extended cancels, Transaction Type Z). 337 bytes. Contra side clearing fields carry a Contra prefix.'
    0x56:
      id: 'cancel_trade_message'
      doc: 'By default CTI sends trade cancels using this message; alternatively a firm and connection block can be configured to send extended cancels with all the trade information using the Trade message with Transaction Type Z. 66 bytes.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages Always The First Message Sent In Any Trading Day After 400 Am'
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
      doc: 'Tradable'
    0x4e:
      id: 'non_tradable'
      doc: 'Non Tradable'
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
  closing_only:
    0x59:
      id: 'closing_position_only'
      doc: 'Option Is Closing Position Only Only Mm Origin Orders Can Have Open Position In The Series'
    0x4e:
      id: 'not_closing_position_only'
      doc: 'Option Is Not Closing Position Only'
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
    1:
      id: 'add_maker'
      doc: 'Add Maker'
    2:
      id: 'remove_taker'
      doc: 'Remove Taker'
    4:
      id: 'response'
      doc: 'Response'
    5:
      id: 'hidden'
      doc: 'Hidden'
    6:
      id: 'opening_trade'
      doc: 'Opening Trade'
    7:
      id: 'cross'
      doc: 'Cross'
    8:
      id: 'flashed_order'
      doc: 'Flashed Order'
    9:
      id: 'flash_response'
      doc: 'Flash Response'
    10:
      id: 'routed_out'
      doc: 'Routed Out'
    11:
      id: 'trade_report'
      doc: 'Trade Report'
    12:
      id: 'combo_maker_against_combo'
      doc: 'Combo Maker Against Combo'
    13:
      id: 'combo_taker_against_combo'
      doc: 'Combo Taker Against Combo'
    14:
      id: 'combo_response_against_combo'
      doc: 'Combo Response Against Combo'
    15:
      id: 'combo_hidden_against_combo'
      doc: 'Combo Hidden Against Combo'
    16:
      id: 'combo_opening_rotation'
      doc: 'Combo Opening Rotation'
    17:
      id: 'combo_cross'
      doc: 'Combo Cross'
    18:
      id: 'combo_taker_against_regular'
      doc: 'Combo Taker Against Regular'
    19:
      id: 'regular_maker_against_combo'
      doc: 'Regular Maker Against Combo'
    20:
      id: 'combo_taker_against_io'
      doc: 'Combo Taker Against Io'
    21:
      id: 'regular_taker_against_io'
      doc: 'Regular Taker Against Io Incl Pim'
    23:
      id: 'io_maker_against_regular'
      doc: 'Io Maker Against Regular'
    24:
      id: 'regular_maker_against_io_participant'
      doc: 'Regular Maker Against Io Participant'
    25:
      id: 'io_participant_taker_against_regular'
      doc: 'Io Participant Taker Against Regular'
    26:
      id: 'broken_price_improvement'
      doc: 'Broken Price Improvement'
    27:
      id: 'broken_facilitation'
      doc: 'Broken Facilitation'
    28:
      id: 'broken_solicitation'
      doc: 'Broken Solicitation'
    29:
      id: 'combo_broken_price_improvement'
      doc: 'Combo Broken Price Improvement'
    30:
      id: 'combo_broken_facilitation'
      doc: 'Combo Broken Facilitation'
    31:
      id: 'combo_broken_solicitation'
      doc: 'Combo Broken Solicitation'
    32:
      id: 'block'
      doc: 'Block'
    33:
      id: 'block_response'
      doc: 'Block Response'
    34:
      id: 'directed_response'
      doc: 'Directed Response'
    35:
      id: 'facilitation'
      doc: 'Facilitation'
    36:
      id: 'facilitation_response'
      doc: 'Facilitation Response'
    37:
      id: 'price_improvement'
      doc: 'Price Improvement'
    38:
      id: 'price_improvement_response'
      doc: 'Price Improvement Response'
    39:
      id: 'solicitation'
      doc: 'Solicitation'
    40:
      id: 'solicitation_response'
      doc: 'Solicitation Response'
    41:
      id: 'qualified_contingent_cross'
      doc: 'Qualified Contingent Cross'
    42:
      id: 'customer_to_customer'
      doc: 'Customer To Customer'
    43:
      id: 'combo_facilitation'
      doc: 'Combo Facilitation'
    44:
      id: 'combo_facilitation_response'
      doc: 'Combo Facilitation Response'
    45:
      id: 'combo_price_improvement'
      doc: 'Combo Price Improvement'
    46:
      id: 'combo_price_improvement_response'
      doc: 'Combo Price Improvement Response'
    47:
      id: 'combo_solicitation'
      doc: 'Combo Solicitation'
    48:
      id: 'combo_solicitation_response'
      doc: 'Combo Solicitation Response'
    49:
      id: 'combo_qualified_contingent_cross'
      doc: 'Combo Qualified Contingent Cross'
    50:
      id: 'combo_customer_to_customer'
      doc: 'Combo Customer To Customer'
    51:
      id: 'sweep_routed_out'
      doc: 'Sweep Routed Out'
    52:
      id: 'sweep_trade_report'
      doc: 'Sweep Trade Report'
    53:
      id: 'combo_taker_against_regular_thru_nbbo'
      doc: 'Combo Taker Against Regular Thru Nbbo'
    55:
      id: 'simple_exposure_order_upon_receipt'
      doc: 'Simple Exposure Order Upon Receipt'
    57:
      id: 'simple_exposure_order_responder'
      doc: 'Simple Exposure Order Responder'
    58:
      id: 'flex_auction'
      doc: 'Flex Auction'
    59:
      id: 'flex_auction_responder'
      doc: 'Flex Auction Responder'
    60:
      id: 'flex_price_improvement'
      doc: 'Flex Price Improvement'
    61:
      id: 'flex_price_improvement_responder'
      doc: 'Flex Price Improvement Responder'
    62:
      id: 'flex_broken_price_improvement'
      doc: 'Flex Broken Price Improvement'
    63:
      id: 'flex_solicitation'
      doc: 'Flex Solicitation'
    64:
      id: 'flex_solicitation_responder'
      doc: 'Flex Solicitation Responder'
    65:
      id: 'flex_broken_solicitation'
      doc: 'Flex Broken Solicitation'
    66:
      id: 'combo_flex_auction'
      doc: 'Combo Flex Auction'
    67:
      id: 'combo_flex_auction_responder'
      doc: 'Combo Flex Auction Responder'
    68:
      id: 'combo_flex_price_improvement'
      doc: 'Combo Flex Price Improvement'
    69:
      id: 'combo_flex_price_improvement_responder'
      doc: 'Combo Flex Price Improvement Responder'
    70:
      id: 'combo_flex_broken_price_improvement'
      doc: 'Combo Flex Broken Price Improvement'
    71:
      id: 'combo_flex_solicitation'
      doc: 'Combo Flex Solicitation'
    72:
      id: 'combo_flex_solicitation_responder'
      doc: 'Combo Flex Solicitation Responder'
    73:
      id: 'combo_flex_broken_solicitation'
      doc: 'Combo Flex Broken Solicitation'
  auction_type:
    0x50:
      id: 'simple_order_pixl_prism_pim'
      doc: 'Simple Order Pixlprismpim'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'simple_order_solicitation'
      doc: 'Simple Order Solicitation'
    0x46:
      id: 'simple_facilitation'
      doc: 'Simple Facilitation'
    0x42:
      id: 'block'
      doc: 'Block'
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
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
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
      id: 'ntx_options'
      doc: 'Ntx Options'
    0x4d:
      id: 'miax'
      doc: 'Miax'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x48:
      id: 'gemx'
      doc: 'Gemx'
    0x45:
      id: 'bats_edgx'
      doc: 'Bats Edgx'
    0x4a:
      id: 'mrx'
      doc: 'Mrx'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x53:
      id: 'miax_sapphire'
      doc: 'Miax Sapphire'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x47:
      id: 'mx_2'
      doc: 'Mx 2'
    0x20:
      id: 'not_away_trade'
      doc: 'Not Away Trade Stock Legs On Phlxisemrx'
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
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker Dealer Customer'
    0x4d:
      id: 'exchange_registered_market_maker'
      doc: 'Exchange Registered Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Stock Leg Execution Or Routed Away Execution'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo'
    0x46:
      id: 'firm'
      doc: 'Firm'
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
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
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
    0x58:
      id: 'phlx'
      doc: 'Phlx'
    0x54:
      id: 'ntx_options'
      doc: 'Ntx Options'
    0x4d:
      id: 'miax'
      doc: 'Miax'
    0x48:
      id: 'gemx'
      doc: 'Gemx'
    0x45:
      id: 'bats_edgx'
      doc: 'Bats Edgx'
    0x4a:
      id: 'mrx'
      doc: 'Mrx'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x53:
      id: 'miax_sapphire'
      doc: 'Miax Sapphire'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x47:
      id: 'mx_2'
      doc: 'Mx 2'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable The Capacity Of This Side Of Trade Is Not O'
  contra_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x45:
      id: 'proprietary_customer'
      doc: 'Proprietary Customer'
    0x52:
      id: 'retail_customer'
      doc: 'Retail Customer'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker Dealer Customer'
    0x4d:
      id: 'exchange_registered_market_maker'
      doc: 'Exchange Registered Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Stock Leg Execution Or Routed Away Execution'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x66:
      id: 'proprietary_firm'
      doc: 'Proprietary Firm'
    0x4b:
      id: 'broker_dealer_firm'
      doc: 'Broker Dealer Firm'
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
      id: 'otto_order'
      doc: 'Otto Order'
    0x51:
      id: 'sqf_quote'
      doc: 'Sqf Quote'
    0x57:
      id: 'sqf_sweep'
      doc: 'Sqf Sweep'
    0x50:
      id: 'block_order'
      doc: 'Block Order'
    0x58:
      id: 'block_response'
      doc: 'Block Response'
    0x47:
      id: 'pim_primary_order'
      doc: 'Pixlprismpim Primary Order'
    0x48:
      id: 'pim_contra_order'
      doc: 'Pixlprismpim Contra Order'
    0x49:
      id: 'pim_response_order'
      doc: 'Pixlprismpim Response Order'
    0x4a:
      id: 'pim_response_sqf_sweep'
      doc: 'Pixlprismpim Response Sqf Sweep'
    0x42:
      id: 'fbms_floor_trade'
      doc: 'Fbms Floor Trade'
    0x4b:
      id: 'qcc_primary'
      doc: 'Qcc Primary'
    0x4c:
      id: 'qcc_contra'
      doc: 'Qcc Contra'
    0x4d:
      id: 'solicitation_primary_order'
      doc: 'Solicitation Primary Order'
    0x4e:
      id: 'solicitation_contra_order'
      doc: 'Solicitation Contra Order'
    0x55:
      id: 'solicitation_response_order'
      doc: 'Solicitation Response Order'
    0x56:
      id: 'solicitation_response_sqf_sweep'
      doc: 'Solicitation Response Sqf Sweep'
    0x46:
      id: 'facilitation_primary_order'
      doc: 'Facilitation Primary Order'
    0x41:
      id: 'facilitation_contra_order'
      doc: 'Facilitation Contra Order'
    0x44:
      id: 'facilitation_response_order'
      doc: 'Facilitation Response Order'
    0x59:
      id: 'facilitation_response_sqf_sweep'
      doc: 'Facilitation Response Sqf Sweep'
    0x20:
      id: 'others'
      doc: 'Others'
  tif:
    0x49:
      id: 'ioc_or_fok'
      doc: 'Ioc Or Fok'
    0x44:
      id: 'day'
      doc: 'Day'
    0x47:
      id: 'gtc'
      doc: 'Gtc'
    0x4f:
      id: 'opg'
      doc: 'Opg'
    0x54:
      id: 'gtd'
      doc: 'Gtd'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable Quotes Manual Trades'

