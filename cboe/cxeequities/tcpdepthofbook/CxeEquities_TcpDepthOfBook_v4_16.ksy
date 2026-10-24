# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CxeEquities TcpDepthOfBook AsciiPitch v4.16
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Tcp Depth Of Book
#   Encoding: Ascii Pitch
#   Version: 4.16
#   Date: 08/31/2018
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
  id: cboe_cxeequities_tcpdepthofbook_asciipitch_v4_16
  title: Cboe CxeEquities TcpDepthOfBook AsciiPitch v4.16
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe CXE Tcp Depth Of Book AsciiPitch v4.16'
doc-ref: https://www.cboe.com/europe/equities/support/technical

seq:
  - id: frame
    type: frame_struct
    repeat: eos
    doc: 'Soup 2.0 Lf terminated record'

types:
  frame_struct:
    seq:
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
      - id: payload
        type:
          switch-on: packet_type
          cases:
            'packet_type::debug_packet': debug_packet
            'packet_type::login_accepted_packet': login_accepted_packet
            'packet_type::login_rejected_packet': login_rejected_packet
            'packet_type::sequenced_data_packet': sequenced_data_packet
            'packet_type::login_request_packet': login_request_packet
            'packet_type::unsequenced_data_packet': unsequenced_data_packet
      - id: soup_lf
        type: u1
        doc: 'Terminating line feed character'
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
        doc: 'Cboe Europe ASCII Soup sequenced message header'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.sequenced_message_type
          cases:
            'sequenced_message_type::symbol_clear_message': symbol_clear_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::add_order_message_long_form': add_order_message_long_form
            'sequenced_message_type::add_order_expanded': add_order_expanded
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
        type: millisecond_ascii_timestamp
        doc: 'Milliseconds past midnight London time, ASCII numeric, left-padded. Milliseconds since Midnight epoch'
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
        doc: 'Symbol, right padded with spaces'
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
        doc: 'B = Buy S = Sell'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
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
        doc: 'Always "Y". Maintained for compatibility reasons'
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
        doc: 'B = Buy S = Sell'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
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
        doc: 'Always "Y". Maintained for compatibility reasons'
  add_order_expanded:
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
        doc: 'B = Buy S = Sell'
      - id: quantity
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares applicable to this quote'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: type_field
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributed order type indicator. Currently defined values: S - ''SI'' Quote'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributes this quote to a particular participant'
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
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also reference in the Trade Break Message'
      - id: execution_flags
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT v3.04 standard'
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
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also reference in the Trade Break Message'
      - id: execution_flags
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT v3.04 standard'
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
        doc: 'B = Buy S = Sell'
      - id: shares_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
      - id: price_short
        type: str
        size: 10
        encoding: ASCII
        doc: 'Order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also reference in the Trade Break Message'
      - id: trade_flags
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT v3.04 standard'
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
        doc: 'B = Buy S = Sell'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution ID is also reference in the Trade Break Message'
      - id: trade_flags
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on MMT v3.04 standard'
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
        doc: 'Symbol, right padded with spaces'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: trade_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Cboe generated identifier of this trade. This identifier is guaranteed to be unique for at least 7 calendar days'
      - id: trade_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date on which the trade occurred, in the form YYYYMMDD'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time at which the trade occurred, encoded as the number of milliseconds since midnight, on the day represented by Trade date, London time'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The venue on which the trade executed, when applicable. This will contain the MIC representing the venue on which the trade occurred, where applicable. e.g. for Cboe NT trades, this shall be the segment MIC BATF for BXE off-book trades, CHIO for CXE off-book trades and BARO for REGM off-book trades. This will contain SINT if the trade occurred on a Systematic Internaliser or XOFF if OTC. Cboe LIS trades have the value LISX'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: cboe_trade_timing_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '''1'' The trade was reported to Cboe ''late'', ''2'' The trade was reported to Cboe out of the Main Session, ''3'' The trade was reported to Cboe late and out of the Main Session, ''-'' otherwise'
      - id: extended_trade_flags
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on the MMT v3.04 standard'
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
        doc: 'Cboe generated identifier of this trade. This identifier is guaranteed to be unique for at least 7 calendar days'
      - id: trade_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date on which the trade occurred, in the form YYYYMMDD'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time at which the trade occurred, encoded as the number of milliseconds since midnight, on the day represented by Trade date, London time'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The venue on which the trade executed, when applicable. This will contain the MIC representing the venue on which the trade occurred, where applicable. e.g. for Cboe NT trades, this shall be the segment MIC BATF for BXE off-book trades, CHIO for CXE off-book trades and BARO for REGM off-book trades. This will contain SINT if the trade occurred on a Systematic Internaliser or XOFF if OTC. Cboe LIS trades have the value LISX'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: cboe_trade_timing_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '''1'' The trade was reported to Cboe ''late'', ''2'' The trade was reported to Cboe out of the Main Session, ''3'' The trade was reported to Cboe late and out of the Main Session, ''-'' otherwise'
      - id: extended_trade_flags
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type flags based on the MMT v3.04 standard'
  trading_status_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
      - id: status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"T" = Trading "R" = Off-Book Reporting "C" = Closed "S" = Suspended "N" = No Reference Price "V" = Volatility Interruption "O" = Opening Auction "E" = Closing Auction "H" = Halt "M" = Market Order Imbalance "P" = Price Monitoring Extension'
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
        doc: 'Symbol, right padded with spaces'
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
        doc: '"C" = Closing Price "H" = High Price "L" = Low Price "O" = Opening Price "P" = Previous Closing Price'
      - id: price_determination
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"0" = Normal "1" = Manual (Price override by Market Supervision)'
  auction_update_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"O" = Opening Auction "C" = Closing Auction "H" = Halt Auction "V" = Volatility Auction "P" = Periodic Auction'
      - id: reference_price
        type: str
        size: 19
        encoding: ASCII
        doc: 'Reference price used in tie-breaker situations. Implied decimal with scale 1e-6'
      - id: indicative_price
        type: str
        size: 19
        encoding: ASCII
        doc: 'Price at which the auction would match if executed at the time of the message. Implied decimal with scale 1e-6'
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
        doc: 'Indicates whether the price on this update is outside the Cboe EBBO collar: "O" = Outside tolerance "I" = Inside tolerance "-" = Not specified'
      - id: includes_primary
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates whether the Cboe EBBO used to collar this update includes the Primary Market quotes: "P" = Includes Primary "N" = Excludes Primary "-" = Not specified'
  auction_summary_message:
    seq:
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol, right padded with spaces'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"O" = Opening Auction "C" = Closing Auction "H" = Halt Auction "V" = Volatility Auction "P" = Periodic Auction'
      - id: price_long
        type: str
        size: 19
        encoding: ASCII
        doc: 'Order price (long format). Implied decimal with scale 1e-6'
      - id: shares_long
        type: str
        size: 10
        encoding: ASCII
        doc: 'Number of shares being added to the book (may be less than the number of shares entered)'
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
  millisecond_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      hour:
        value: text.to_i / 3600000 % 24
      minute:
        value: text.to_i / 60000 % 60
      second:
        value: text.to_i / 1000 % 60
      millisecond:
        value: text.to_i % 1000

enums:
  packet_type:
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
      doc: 'The Symbol Clear message instructs feed recipients to clear all orders for the Cboe book in the specified symbol. This message will be sent at startup each day.'
    0x41:
      id: 'add_order_message'
      doc: 'An add order message represents a newly accepted visible order on the Cboe book. It includes a day-specific Order ID assigned by Cboe to the order.'
    0x63:
      id: 'add_order_message_long_form'
      doc: 'Only used on the Cboe European platform. As Add Order Message above, but with longer fields for Shares, Price and Symbol.'
    0x74:
      id: 'add_order_expanded'
      doc: 'The Expanded Add Order is used on the Cboe Europe TRF platform to provide visibility of Systematic Internalizer quotes. (SI Quotes are not executable via the TRF platform.)'
    0x45: 'order_executed_message'
    0x65:
      id: 'order_executed_message_long_form'
      doc: 'Only used on the Cboe European platform. As Order Executed Message above, but with a longer field for Executed Shares.'
    0x58:
      id: 'order_cancel_message'
      doc: 'Order Cancel Messages are sent when a visible order on the Cboe book is cancelled in whole or in part.'
    0x78:
      id: 'order_cancel_message_long_form'
      doc: 'Only used on the Cboe European platform. As Order Cancel Message above, but with a longer field for Cancelled Shares.'
    0x50: 'trade_message'
    0x71:
      id: 'trade_message_long_form'
      doc: 'Only used on the Cboe European platform. As Trade Message above, but with longer fields for Shares and Price.'
    0x4f:
      id: 'trade_message_extended_form'
      doc: 'Only used on the Cboe European platform. This provides extended details of trades reported to or executed by Cboe.'
    0x6b:
      id: 'trade_message_unknown_symbol'
      doc: 'Only used on the Cboe European Trade Reporting Facility. This provides details of trades reported to Cboe, but traded on a symbol not currently known to Cboe.'
    0x48:
      id: 'trading_status_message'
      doc: 'The Trading Status Message is used to indicate the current trading status of a security. A Trading Status Message will be sent whenever a security''s trading status changes.'
    0x5a:
      id: 'statistics_message'
      doc: 'Only used on the Cboe European platform. The Statistics Message is used to disseminate the statistics prices: opening, closing, high, low.'
    0x6c:
      id: 'auction_update_message'
      doc: 'Auction Update messages are used to disseminate indicative price and size information during auctions for Cboe auction eligible securities. For Opening and Closing auctions, Auction Update messages are published periodically during the call and extension phases of the auction process.'
    0x6a:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction in a Cboe auction eligible security.'

