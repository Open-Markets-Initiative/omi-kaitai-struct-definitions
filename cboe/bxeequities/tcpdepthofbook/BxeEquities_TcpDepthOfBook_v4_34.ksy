# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BxeEquities TcpDepthOfBook AsciiPitch v4.34
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Tcp Depth Of Book
#   Encoding: Ascii Pitch
#   Version: 4.34
#   Date: 01/30/2026
#   Specification: BATS_Europe_PITCH_Specification.pdf
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
  id: cboe_bxeequities_tcpdepthofbook_asciipitch_v4_34
  title: Cboe BxeEquities TcpDepthOfBook AsciiPitch v4.34
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe BXE Tcp Depth Of Book AsciiPitch v4.34'
doc-ref: https://www.cboe.com/europe/equities/support/technical

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
        doc: 'Cboe Europe ASCII Soup sequenced message header (microsecond timestamp)'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.sequenced_message_type
          cases:
            'sequenced_message_type::symbol_clear_message': symbol_clear_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::add_order_message_long_form': add_order_message_long_form
            'sequenced_message_type::order_executed_message': order_executed_message
            'sequenced_message_type::order_executed_message_long_form': order_executed_message_long_form
            'sequenced_message_type::order_cancel_message': order_cancel_message
            'sequenced_message_type::order_cancel_message_long_form': order_cancel_message_long_form
            'sequenced_message_type::trade_message': trade_message
            'sequenced_message_type::trade_message_long_form': trade_message_long_form
            'sequenced_message_type::trade_message_extended_form': trade_message_extended_form
            'sequenced_message_type::trade_message_unknown_symbol': trade_message_unknown_symbol
            'sequenced_message_type::trading_status_message': trading_status_message
            'sequenced_message_type::statistics_message': statistics_message
            'sequenced_message_type::auction_update_message': auction_update_message
            'sequenced_message_type::auction_summary_message': auction_summary_message
  sequenced_message_header:
    seq:
      - id: timestamp
        type: microsecond_ascii_timestamp
        doc: 'Microseconds past midnight London time, ASCII numeric, left-padded. Microseconds since Midnight epoch'
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Single ASCII character identifying the sequenced message type'
  symbol_clear_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
  add_order_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'B = Buy, S = Sell'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'Order price. Implied decimal with scale 1e-4'
      - id: display
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Always Y. Maintained for compatibility reasons'
  add_order_message_long_form:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'B = Buy, S = Sell'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares being added to the book'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: display
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Always Y. Maintained for compatibility reasons'
  order_executed_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier'
      - id: execution_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT standard'
  order_executed_message_long_form:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier'
      - id: execution_flags
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT standard'
  order_cancel_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: cancelled_shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares cancelled'
  order_cancel_message_long_form:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: cancelled_shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares cancelled'
  trade_message:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'B = Buy, S = Sell'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'Order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier'
      - id: trade_flags
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT standard'
  trade_message_long_form:
    seq:
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'B = Buy, S = Sell'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares being added to the book'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier'
      - id: trade_flags
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT standard'
  trade_message_extended_form:
    seq:
      - id: shares_extended
        type: str
        size: 12
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: trade_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated identifier, unique for at least 7 calendar days'
      - id: trade_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date the trade occurred, YYYYMMDD'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Milliseconds since midnight London time on Trade Date'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIC of the venue on which the trade executed (LISX/LISZ/XWAP/VWAP/SINT/XOFF...)'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: cboe_trade_flags
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cboe trade timing / regulated entity flags'
      - id: extended_trade_flags
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on the MMT standard'
  trade_message_unknown_symbol:
    seq:
      - id: shares_extended
        type: str
        size: 12
        encoding: ASCII
        doc: 'Number of shares executed'
      - id: symbol_extended
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol in ISIN'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: trade_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated identifier, unique for at least 7 calendar days'
      - id: trade_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date the trade occurred, YYYYMMDD'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Milliseconds since midnight London time on Trade Date'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIC of the venue on which the trade executed (LISX/LISZ/XWAP/VWAP/SINT/XOFF...)'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: cboe_trade_flags
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cboe trade timing / regulated entity flags'
      - id: extended_trade_flags
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on the MMT standard'
  trading_status_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'T=Trading R=Off-Book Reporting C=Closed S=Suspended N=No Reference Price V=Volatility(Static Collar) I=Volatility Auction O=Opening Auction E=Closing Auction H=Halt M=Market Order Imbalance P=Price Monitoring Extension U=Cboe Closing Cross Y=Halt Auction'
      - id: reserved
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  statistics_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: statistic_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'C=Closing H=High L=Low O=Opening P=Previous Closing Price'
      - id: price_determination
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0=Normal 1=Manual (price override by Market Supervision)'
  auction_update_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'O=Opening C=Closing H=Halt V=Volatility P=Periodic U=Cboe Closing Cross'
      - id: reference_price
        type: str
        size: 19
        encoding: ASCII
        doc: 'Reference price used in tie-breaker situations. Implied decimal with scale 1e-6'
      - id: indicative_price
        type: str
        size: 19
        encoding: ASCII
        doc: 'Price at which the auction would match if executed now. Implied decimal with scale 1e-6'
      - id: indicative_shares
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares at the Indicative Price'
      - id: outside_tolerance
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'O=Outside tolerance I=Inside tolerance -=Not specified'
      - id: includes_primary
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'P=Includes Primary N=Excludes Primary -=Not specified'
  auction_summary_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'O=Opening C=Closing H=Halt V=Volatility P=Periodic U=Cboe Closing Cross'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares being added to the book'
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
  microsecond_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 11
        encoding: ASCII
    instances:
      hour:
        value: text.to_i / 3600000000 % 24
      minute:
        value: text.to_i / 60000000 % 60
      second:
        value: text.to_i / 1000000 % 60
      millisecond:
        value: text.to_i / 1000 % 1000
      microsecond:
        value: text.to_i % 1000

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
    0x68:
      id: 'symbol_clear_message'
      doc: 'Instructs feed recipients to clear all orders for the Cboe book in the specified symbol; sent in recovery events such as a data centre fail-over.'
    0x4b:
      id: 'add_order_message'
      doc: 'Represents a newly accepted visible order on the Cboe book with a day-specific Order ID.'
    0x4d:
      id: 'add_order_message_long_form'
      doc: 'Cboe European platform only. As Add Order Message but with longer Shares, Symbol and Price fields.'
    0x4e:
      id: 'order_executed_message'
      doc: 'Sent when a visible order on the Cboe book is executed in whole or in part at the original Add Order price.'
    0x67:
      id: 'order_executed_message_long_form'
      doc: 'Cboe European platform only. As Order Executed Message but with a longer Executed Shares field.'
    0x46:
      id: 'order_cancel_message'
      doc: 'Sent when a visible order on the Cboe book is cancelled in whole or in part.'
    0x47:
      id: 'order_cancel_message_long_form'
      doc: 'Cboe European platform only. As Order Cancel Message but with a longer Cancelled Shares field.'
    0x56:
      id: 'trade_message'
      doc: 'Provides information about executions of non-displayed orders/shares and negotiated trades. Does not alter the book.'
    0x57:
      id: 'trade_message_long_form'
      doc: 'Cboe European platform only. As Trade Message but with longer Shares and Price fields.'
    0x76:
      id: 'trade_message_extended_form'
      doc: 'Cboe European platform only. Extended details of trades reported to or executed by Cboe (e.g. privately negotiated trades brought on-exchange).'
    0x77:
      id: 'trade_message_unknown_symbol'
      doc: 'Cboe European Trade Reporting Facility only. Trades reported to Cboe on a symbol not currently known, identified by ISIN and currency.'
    0x61:
      id: 'trading_status_message'
      doc: 'Indicates the current trading status of a security; sent whenever the status changes and for all Suspended securities before trading hours.'
    0x59:
      id: 'statistics_message'
      doc: 'Cboe European platform only. Disseminates statistics prices: opening, closing, high, low, previous close.'
    0x62:
      id: 'auction_update_message'
      doc: 'Disseminates indicative price and size information during auctions for Cboe auction-eligible securities.'
    0x66:
      id: 'auction_summary_message'
      doc: 'Disseminates the results of an auction in a Cboe auction-eligible security.'

