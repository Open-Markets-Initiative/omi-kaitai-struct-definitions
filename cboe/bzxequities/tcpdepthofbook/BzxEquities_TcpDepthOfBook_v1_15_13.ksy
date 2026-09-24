# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxEquities TcpDepthOfBook AsciiPitch v1.15.13
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Tcp Depth Of Book
#   Encoding: Ascii Pitch
#   Version: 1.15.13
#   Date: 04/21/2025
#   Specification: Cboe_US_Equities_TCP_PITCH_Specification.pdf
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
  id: cboe_bzxequities_tcpdepthofbook_asciipitch_v1_15_13
  title: Cboe BzxEquities TcpDepthOfBook AsciiPitch v1.15.13
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe Bzx Equities Tcp Depth Of Book AsciiPitch v1.15.13'
doc-ref: http://markets.cboe.com/us/equities/support/technical

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
            'sequenced_message_type::symbol_clear_message': symbol_clear_message
            'sequenced_message_type::add_order_short_message': add_order_short_message
            'sequenced_message_type::add_order_long_message': add_order_long_message
            'sequenced_message_type::add_order_extended_message': add_order_extended_message
            'sequenced_message_type::order_executed_message': order_executed_message
            'sequenced_message_type::order_cancel_message': order_cancel_message
            'sequenced_message_type::trade_short_message': trade_short_message
            'sequenced_message_type::trade_long_message': trade_long_message
            'sequenced_message_type::trade_extended_message': trade_extended_message
            'sequenced_message_type::trade_break_message': trade_break_message
            'sequenced_message_type::trading_status_message': trading_status_message
            'sequenced_message_type::auction_update_message': auction_update_message
            'sequenced_message_type::extended_auction_update_message': extended_auction_update_message
            'sequenced_message_type::auction_summary_message': auction_summary_message
            'sequenced_message_type::extended_auction_summary_message': extended_auction_summary_message
            'sequenced_message_type::retail_price_improvement_message': retail_price_improvement_message
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
        doc: 'Sequenced Message Type'
  symbol_clear_message:
    seq:
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
  add_order_short_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side Indicator'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock_symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Set to ''Y'''
  add_order_long_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side Indicator'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Set to ''Y'''
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, MPID or ''RTAL'' for retail specified orders (equities) of firm attributed to this quote. Space filled otherwise'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: '(EDGX Only), space filled on other Cboe Equities Exchanges'
  add_order_extended_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side Indicator'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-6'
      - id: display
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y = The order is aggregated in the Cboe SIP quote'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, MPID or ''RTAL'' for retail specified orders (equities) of firm attributed to this quote. Space filled otherwise'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: '(EDGX Only), space filled on other Cboe Equities Exchanges'
  order_executed_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_shares
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also referenced in the Trade Break message'
  order_cancel_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_shares
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares canceled'
  trade_short_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side Indicator'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock_symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also referenced in the Trade Break message'
  trade_long_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side Indicator'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also referenced in the Trade Break message'
  trade_extended_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side Indicator'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-6'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also referenced in the Trade Break message'
  trade_break_message:
    seq:
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also referenced in the Trade Break message'
  trading_status_message:
    seq:
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: halt_status
        type: u1
        enum: halt_status
        doc: 'Trading Status'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reserved_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  auction_update_message:
    seq:
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: reference_price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'BBO Collared auction price. Implied decimal with scale 1e-4'
      - id: buy_shares
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares on buy side at the Reference Price. Shares matched for Cboe Market Close'
      - id: sell_shares
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares on sell side at the Reference Price. Shares matched for Cboe Market Close'
      - id: indicative_price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price at which the auction book and the continuous book would match. Implied decimal with scale 1e-4'
      - id: auction_only_price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price at which the auction book would match using only Eligible Auction Orders. Implied decimal with scale 1e-4'
  extended_auction_update_message:
    seq:
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: reference_price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'BBO Collared auction price. Implied decimal with scale 1e-6'
      - id: buy_shares
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares on buy side at the Reference Price. Shares matched for Cboe Market Close'
      - id: sell_shares
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares on sell side at the Reference Price. Shares matched for Cboe Market Close'
      - id: indicative_price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'Price at which the auction book and the continuous book would match. Implied decimal with scale 1e-6'
      - id: auction_only_price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'Price at which the auction book would match using only Eligible Auction Orders. Implied decimal with scale 1e-6'
  auction_summary_message:
    seq:
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Cumulative number of shares executed during the auction. Shares executed in the CMC match'
  extended_auction_summary_message:
    seq:
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: price_long
        type: str
        size: 14
        encoding: ASCII
        doc: 'The limit order price. Implied decimal with scale 1e-6'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Cumulative number of shares executed during the auction. Shares executed in the CMC match'
  retail_price_improvement_message:
    seq:
      - id: stock_symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: retail_price_improvement
        type: u1
        enum: retail_price_improvement
        doc: 'Retail Price Improvement'
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
    0x73:
      id: 'symbol_clear_message'
      doc: 'The Symbol Clear message instructs feed recipients to clear all orders for the Cboe book in the specified symbol.'
    0x41:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book.'
    0x64:
      id: 'add_order_long_message'
      doc: 'The long version of the Add Order message accommodates larger symbol sizes possible through the ISRA plan.'
    0x31:
      id: 'add_order_extended_message'
      doc: 'The extended version of the Add Order message accommodates larger prices.'
    0x45:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cboe book is executed in whole or in part.'
    0x58:
      id: 'order_cancel_message'
      doc: 'Order Cancel messages are sent when a visible order on the Cboe book is canceled in whole or in part.'
    0x50:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders or shares on the Cboe book and routed orders.'
    0x72:
      id: 'trade_long_message'
      doc: 'The long version of the Trade message accommodates larger symbol sizes possible through the ISRA plan.'
    0x32:
      id: 'trade_extended_message'
      doc: 'The extended version of the Trade message accommodates larger prices.'
    0x42:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cboe is broken.'
    0x48:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a security.'
    0x49:
      id: 'auction_update_message'
      doc: 'Auction Update messages are used to disseminate Cboe price and size information during auctions for Cboe listed securities on BZX, and for Periodic Auctions on BYX.'
    0x33:
      id: 'extended_auction_update_message'
      doc: 'The extended version of the BZX Auction Update message accommodates larger prices.'
    0x4a:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction of a Cboe listed security on BZX, and for Periodic Auctions on BYX.'
    0x34:
      id: 'extended_auction_summary_message'
      doc: 'The extended version of the Auction Summary message accommodates larger prices.'
    0x52:
      id: 'retail_price_improvement_message'
      doc: 'The Retail Price Improvement message is only available on the BYX Exchange. This message is a Retail Liquidity Indicator (RLI) that includes symbol and side, but not price and size.'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  customer_indicator:
    0x52:
      id: 'retail'
      doc: 'Retail'
  halt_status:
    0x41:
      id: 'accepting_orders_for_queuing'
      doc: 'Accepting Orders For Queuing'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only_cboe_listings'
      doc: 'Quote Only Cboe Listings'
    0x53:
      id: 'exchange_specific_suspension'
      doc: 'Exchange Specific Suspension'
    0x54:
      id: 'trading'
      doc: 'Trading'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_price_test_restriction_in_effect'
      doc: 'Reg Sho Price Test Restriction In Effect'
  auction_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x48:
      id: 'halt_auction'
      doc: 'Halt Auction'
    0x49:
      id: 'ipo_auction'
      doc: 'Ipo Auction'
    0x4d:
      id: 'cboe_market_close'
      doc: 'Cboe Market Close'
    0x50:
      id: 'periodic_auction_byx_only'
      doc: 'Periodic Auction Byx Only'
  retail_price_improvement:
    0x42:
      id: 'buy_side_rpi'
      doc: 'Buy Side Rpi'
    0x53:
      id: 'sell_side_rpi'
      doc: 'Sell Side Rpi'
    0x41:
      id: 'buy_and_sell_rpi'
      doc: 'Buy And Sell Rpi'
    0x4e:
      id: 'no_rpi'
      doc: 'No Rpi'

