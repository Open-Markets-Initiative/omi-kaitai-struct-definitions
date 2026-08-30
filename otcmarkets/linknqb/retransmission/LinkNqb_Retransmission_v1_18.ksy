# ---------------------------------------------------------------------
# Kaitai struct definition for: OtcMarkets LinkNqb Retransmission Link v1.18
#
# Protocol:
#   Organization: OTC Markets Group
#   Protocol: OTC Retransmission
#   Encoding: Otc Link
#   Version: 1.18
#   Date: 5/1/2026
#   Specification: OTC-Link-NQB-MD-Specification.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: otcmarkets_linknqb_retransmission_link_v1_18
  title: OtcMarkets LinkNqb Retransmission Link v1.18
  license: GPL-3.0
  endian: be

doc: 'OTC Markets Group OTC Link NQB OTC Retransmission Link v1.18'
doc-ref: https://www.otcmarkets.com/market-data/technical-and-user-documentation

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'MoonAts Tcp Recovery Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'MoonAts Tcp Message Header'
      - id: payload
        size: message_header.message_size - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::start_of_spin_message': start_of_spin_message
            'message_type::end_of_spin_message': end_of_spin_message
            'message_type::trading_session_message': trading_session_message
            'message_type::security_message': security_message
            'message_type::order_add_message': order_add_message
            'message_type::order_update_message': order_update_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_execution_message': order_execution_message
            'message_type::order_execution_with_price_message': order_execution_with_price_message
            'message_type::trade_message': trade_message
            'message_type::top_of_book_message': top_of_book_message
            'message_type::imbalance_message': imbalance_message
            'message_type::system_recovery_event_message': system_recovery_event_message
            'message_type::login_request_message': login_request_message
            'message_type::login_response_message': login_response_message
            'message_type::retransmission_request_message': retransmission_request_message
            'message_type::retransmission_response_message': retransmission_response_message
            'message_type::spin_request_message': spin_request_message
            'message_type::spin_response_message': spin_response_message
            'message_type::enhanced_spin_request_message': enhanced_spin_request_message
            'message_type::enhanced_spin_response_message': enhanced_spin_response_message
            'message_type::heartbeat_message': heartbeat_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Size of message plus header size in bytes'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  start_of_spin_message:
    seq:
      - id: spin_type
        type: u1
        enum: spin_type
        doc: 'Spin type'
      - id: spin_start_time_milli
        type: millisecond_timestamp
        doc: 'Milliseconds since UTC epoch. Milliseconds since Unix epoch'
      - id: spin_last_seq_num
        type: u4
        doc: 'Ignore, not used'
  end_of_spin_message:
    seq:
      - id: spin_type
        type: u1
        enum: spin_type
        doc: 'Spin type'
      - id: spin_msg_ct
        type: u4
        doc: 'Total messages in spin'
      - id: spin_end_time_milli
        type: millisecond_timestamp
        doc: 'Milliseconds since UTC epoch. Milliseconds since Unix epoch'
      - id: spin_last_seq_num
        type: u4
        doc: 'Ignore, not used'
  trading_session_message:
    seq:
      - id: session_time
        type: millisecond_timestamp
        doc: '"Time" in the PDF, renamed to disambiguate from the 4-byte midnight "Time" field used in other messages. Milliseconds since UTC epoch. Milliseconds since Unix epoch'
      - id: trading_session
        type: u1
        enum: trading_session
        doc: 'Trading session indicator'
  security_message:
    seq:
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ticker symbol'
      - id: last_update_milli
        type: millisecond_timestamp
        doc: 'Milliseconds from UTC epoch. Milliseconds since Unix epoch'
      - id: security_action
        type: u1
        enum: security_action
        doc: 'Security action'
      - id: asset_class
        type: u1
        enum: asset_class
        doc: 'Asset class'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: security_flags
        type: security_flags
        doc: 'This flag notes security level attributes and is only included in the Security Message'
      - id: tier
        type: u1
        enum: tier
        doc: 'The market tier assigned by OTC Markets Group'
      - id: reporting_status
        type: u1
        enum: reporting_status
        doc: 'Reporting status of the security'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Security trading status'
  security_flags:
    seq:
      - id: piggyback_flag
        type: b1
        doc: '15c2-11 "PiggyBack" exempt security status flag'
      - id: caveat_flag
        type: b1
        doc: 'Indicates whether a Caveat Emptor warning has been applied to the security'
      - id: qib_only_144_a
        type: b1
        doc: '"144A QIB Only" in the PDF. Indicates that the security may only be purchased or sold by Qualified Institutional Buyers (QIBs) or agents acting on behalf of QIBs'
      - id: unsolicited_only_flag
        type: b1
        doc: 'Indicates if a security may only be quoted Unsolicited'
      - id: closing_cross_auction
        type: b1
        doc: 'Indicates if security participates in the OTC Link Closing Cross Auction'
      - id: reserved_11
        type: b11
        doc: 'Reserved'
  order_add_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: order_id
        type: str
        size: 14
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order. The Order ID consists of 14 alphanumeric characters; use the first 12 characters and convert them from base-36 to a 64-bit integer'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order, "S" = Sell Order'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ticker symbol'
      - id: price
        type: decimal_u8_6
        doc: 'The limit order price. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm''s MPID'
      - id: unsolicited
        type: u1
        enum: unsolicited
        doc: '"Y" = Unsolicited, "N" = Not Unsolicited'
      - id: order_flags
        type: u2
        doc: 'TBD'
  order_update_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: order_id
        type: str
        size: 14
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order. The Order ID consists of 14 alphanumeric characters; use the first 12 characters and convert them from base-36 to a 64-bit integer'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_6
        doc: 'The limit order price. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: order_flags
        type: u2
        doc: 'TBD'
  order_delete_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: order_id
        type: str
        size: 14
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order. The Order ID consists of 14 alphanumeric characters; use the first 12 characters and convert them from base-36 to a 64-bit integer'
  order_execution_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: order_id
        type: str
        size: 14
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order. The Order ID consists of 14 alphanumeric characters; use the first 12 characters and convert them from base-36 to a 64-bit integer'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares executed'
      - id: remaining_quantity
        type: u4
        doc: 'Number of shares remaining after the execution. Will be zero if fully filled'
      - id: execution_id
        type: u8
        doc: 'System generated day-unique execution identifier of this execution'
  order_execution_with_price_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: order_id
        type: str
        size: 14
        encoding: ASCII
        doc: 'Day-specific identifier assigned to this order. The Order ID consists of 14 alphanumeric characters; use the first 12 characters and convert them from base-36 to a 64-bit integer'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares executed'
      - id: remaining_quantity
        type: u4
        doc: 'Number of shares remaining after the execution. Will be zero if fully filled'
      - id: execution_id
        type: u8
        doc: 'System generated day-unique execution identifier of this execution'
      - id: price
        type: decimal_u8_6
        doc: 'The limit order price. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
  trade_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order, "S" = Sell Order'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ticker symbol'
      - id: price
        type: decimal_u8_6
        doc: 'The limit order price. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: execution_id
        type: u8
        doc: 'System generated day-unique execution identifier of this execution'
      - id: reserved_binary_long_8
        type: u8
        doc: 'Reserved'
  top_of_book_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ticker symbol'
      - id: ask_price
        type: decimal_u8_6
        doc: 'Best Ask Price. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: ask_volume
        type: u4
        doc: 'Aggregate size at Ask Price'
      - id: bid_price
        type: decimal_u8_6
        doc: 'Best Bid Price. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: bid_volume
        type: u4
        doc: 'Aggregate size at Bid Price'
      - id: unsolicited
        type: u1
        enum: unsolicited
        doc: '"Y" = Unsolicited, "N" = Not Unsolicited'
  imbalance_message:
    seq:
      - id: time
        type: millisecond_timestamp
        doc: 'Milliseconds from midnight. Milliseconds since Midnight epoch'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Ticker symbol'
      - id: current_inside_paired_shares
        type: u4
        doc: 'Number of OC and IO shares that would be matched at the Current Inside Closing Price'
      - id: current_inside_closing_price
        type: decimal_u8_6
        doc: 'The calculated closing price without Day / extended Day orders, bounded by the inside. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: current_inside_imbalance_quantity
        type: u4
        doc: 'Number of marketable OC and IO shares that would be left unmatched at the Current Inside Closing Price'
      - id: current_inside_imbalance_side
        type: u1
        enum: current_inside_imbalance_side
        doc: 'Buy or sell side of the Current Inside Imbalance Quantity'
      - id: full_closing_price
        type: decimal_u8_6
        doc: 'The calculated closing price. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: ocio_only_closing_price
        type: decimal_u8_6
        doc: 'The calculated closing price without Day / extended Day orders. The long value represents the price scaled by 1,000,000 (6 decimal places). Implied decimal with scale 1e6'
      - id: moc_shares_unmatched
        type: u1
        enum: moc_shares_unmatched
        doc: 'Indicates if any MOC shares are left unmatched'
  system_recovery_event_message:
    seq:
      - id: deprecated
        type: u4
        doc: 'Deprecated'
      - id: recovery_type
        type: u1
        enum: recovery_type
        doc: 'Recovery event type'
      - id: next_sequence_number
        type: u4
        doc: 'Sequence Number that you should use when recovery starts. If set to 0, sequence number will not reset. Only set when Recovery Type is ''S'''
      - id: recovery_start_time
        type: millisecond_timestamp
        doc: 'Expected time recovery spin will start. Milliseconds since Unix epoch'
  login_request_message:
    seq:
      - id: user_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'User id assigned by system'
      - id: password
        type: str
        size: 16
        encoding: ASCII
        doc: 'Password assigned by system'
  login_response_message:
    seq:
      - id: user_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'User id assigned by system'
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Always "Y". If it is an invalid userid, system will close socket after 5 seconds without sending back a login response. Field renamed from "Status" in the PDF to disambiguate from sibling Status fields'
  retransmission_request_message:
    seq:
      - id: start_sequence
        type: u4
        doc: 'Start sequence number'
      - id: number_of_messages
        type: u4
        doc: 'Number of messages requested. -1 to indicate all messages up to date'
      - id: retran_via_tcp
        type: u1
        enum: retran_via_tcp
        doc: '"Y" - sent back on the same TCP channel'
  retransmission_response_message:
    seq:
      - id: start_sequence
        type: u4
        doc: 'Start sequence number'
      - id: number_of_messages
        type: u4
        doc: 'Number of messages requested. -1 to indicate all messages up to date'
      - id: retransmission_status
        type: u1
        enum: retransmission_status
        doc: '"Y" - retransmission will follow as requested. "N" - request ignored. Field renamed from "Status" in the PDF to disambiguate from sibling Status fields'
  spin_request_message:
    seq:
      - id: client_identifier
        type: u4
        doc: 'Optional client identifier'
  spin_response_message:
    seq:
      - id: client_identifier
        type: u4
        doc: 'Optional client identifier'
      - id: spin_status
        type: u1
        enum: spin_status
        doc: '"S" Start of Spin or "E" End of Spin. Field renamed from "Status" in the PDF to disambiguate from sibling Status fields'
  enhanced_spin_request_message:
    seq:
      - id: client_identifier
        type: u4
        doc: 'Optional client identifier'
  enhanced_spin_response_message:
    seq:
      - id: client_identifier
        type: u4
        doc: 'Optional client identifier'
      - id: enhanced_spin_status
        type: u1
        enum: enhanced_spin_status
        doc: '"S" Start of Spin or "E" End of Spin. Field renamed from "Status" in the PDF to disambiguate from sibling Status fields'
      - id: last_seq_num
        type: u4
        doc: 'Snapshot last sequence number to sync up with real time data. Start processing real time data from LastSeqNum + 1'
  heartbeat_message:
    seq:
      - id: client_identifier
        type: u4
        doc: 'Optional client identifier'
  millisecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  message_type:
    11:
      id: 'start_of_spin_message'
      doc: 'Appears within the TCP spin response cycle (between Spin Response ''S'' and ''E'') and also on the UDP multicast feeds at the daily spin-out. Indicates the beginning of a spin message cycle.'
    12:
      id: 'end_of_spin_message'
      doc: 'Appears within the TCP spin response cycle (between Spin Response ''S'' and ''E'') and also on the UDP multicast feeds at the daily spin-out. Indicates the end of a spin message cycle.'
    20:
      id: 'trading_session_message'
      doc: 'Appears in the TCP spin response payload (and on all UDP channels). Sent at the start of each NQB IDQS trading session: Order Acceptance at 6 AM, Pre-Market Open at 8 AM, Market Open at 9:30 AM, After Hours at 4 PM, Market Close at 5 PM.'
    9:
      id: 'security_message'
      doc: 'Appears in the TCP spin response payload (and on all UDP channels). Provides basic security attribute information for all OTC equity securities.'
    21:
      id: 'order_add_message'
      doc: 'Appears in the TCP spin response payload during DOB replay. Indicates a new order added to the book.'
    22:
      id: 'order_update_message'
      doc: 'Appears in the TCP spin response payload during DOB replay. Indicates an existing order has been modified.'
    23:
      id: 'order_delete_message'
      doc: 'Appears in the TCP spin response payload during DOB replay. Indicates an existing order has been deleted from the book.'
    24:
      id: 'order_execution_message'
      doc: 'Appears in the TCP spin response payload during DOB replay. Published when all or some of the displayed quantity of a previously published order executes at the published price.'
    25:
      id: 'order_execution_with_price_message'
      doc: 'Appears in the TCP spin response payload during DOB replay. Published when all or some of the displayed quantity of a previously published order executes at a price different than the published price.'
    26:
      id: 'trade_message'
      doc: 'Appears in the TCP spin response payload during DOB replay. Published when non-displayed quantity of a previously published reserve order executes or when an order executes that is less than Min Quote Size and does not currently have an active Order Add message.'
    27:
      id: 'top_of_book_message'
      doc: 'Appears in the TCP spin response payload during TOB replay. Provides best bid and offer aggregated top-of-book.'
    28:
      id: 'imbalance_message'
      doc: 'Appears in the TCP spin response payload.'
    74:
      id: 'system_recovery_event_message'
      doc: 'System Recovery event. The first event (type ''S'') instructs clients to prepare and reset caches; clients must clean all cached state. A second event (type ''B'') indicates recovery begins, after which the system performs a spin for all symbols and open orders.'
    108:
      id: 'login_request_message'
      doc: '"l" (lowercase L). Logon message is the first message required to send to the server once a connection is established. At minimum, the firm and user id should be provided.'
    97:
      id: 'login_response_message'
      doc: '"a". The Login Response Message is sent to a client''s response to a TCP/IP Login Message. The status field is used to reflect an accepted login or the reason the session was not accepted. If login fails, the TCP/IP connection will be dropped.'
    114:
      id: 'retransmission_request_message'
      doc: '"r". Request retransmission of a range of messages.'
    98:
      id: 'retransmission_response_message'
      doc: '"b". Response to a Retransmission Request. The replay server sends a heartbeat message every second. If the server replay response to a request takes too much time, then it is up to the client to either wait for a few heartbeats, or arbitrary time, then disconnect and send another replay request.'
    115:
      id: 'spin_request_message'
      doc: '"s". Request a refresh spin of state from the server.'
    99:
      id: 'spin_response_message'
      doc: '"c". The server will send a Spin Response ("c") with status Start of Spin ("S"). It will then transmit Trading Session, Security, Orders or TOB, etc., followed by another Spin Response ("c") with status End of Spin ("E"). Ignore any Heartbeat messages. Spin messages are always returned to the same TCP socket from where they originated.'
    116:
      id: 'enhanced_spin_request_message'
      doc: '"t". Request an enhanced spin which includes a last-sequence-number marker for syncing real time data.'
    100:
      id: 'enhanced_spin_response_message'
      doc: '"d". The server will send an Enhanced Spin Response ("d") with status Start of Spin ("S"). It will then transmit Trading Session, Security, Orders or TOB, etc., followed by another Enhanced Spin Response ("d") with status End of Spin ("E"). Ignore any Heartbeat messages. Spin messages are always returned to the same TCP socket from where they originated.'
    104:
      id: 'heartbeat_message'
      doc: '"h". After login successful, FI will send a client a heartbeat once every 60 seconds. If there is no heartbeat from client for more than 5 minutes, system will disconnect.'
  spin_type:
    1:
      id: 'reference'
      doc: 'Reference'
  trading_session:
    1:
      id: 'order_acceptance'
      doc: 'Order Acceptance 6 Am'
    2:
      id: 'pre_market_open'
      doc: 'Pre Market Open 8 Am Extended Day Orders Become Active For Publication And Trading'
    3:
      id: 'market_open'
      doc: 'Market Open 930 Am Regular Day Orders Become Active For Publication And Trading'
    4:
      id: 'after_hours'
      doc: 'After Hours 4 Pm Regular Day Orders Expire Extended Day Orders Continue To Be Active'
    5:
      id: 'market_close'
      doc: 'Market Close 5 Pm Extended Day Orders Expire'
  security_action:
    1:
      id: 'update'
      doc: 'Update'
    2:
      id: 'add'
      doc: 'Add'
    3:
      id: 'delete_field'
      doc: 'Delete'
    4:
      id: 'spin'
      doc: 'Spin'
  asset_class:
    1:
      id: 'equity'
      doc: 'Equity'
    2:
      id: 'fixed_income'
      doc: 'Fixed Income'
  tier:
    0:
      id: 'no_tier'
      doc: 'No Tier'
    2:
      id: 'otcqx_us'
      doc: 'Otcqx Us'
    6:
      id: 'otcqx_international'
      doc: 'Otcqx International'
    10:
      id: 'otcqb'
      doc: 'Otcqb'
    20:
      id: 'otcid'
      doc: 'Otcid'
    21:
      id: 'pink_limited'
      doc: 'Pink Limited'
    30:
      id: 'grey_market'
      doc: 'Grey Market'
    40:
      id: 'expert_market'
      doc: 'Expert Market'
    50:
      id: 'otc_bonds'
      doc: 'Otc Bonds'
  reporting_status:
    0x41:
      id: 'alternative_reporting_standard'
      doc: 'Alternative Reporting Standard'
    0x42:
      id: 'bank_thrift'
      doc: 'Bank Thrift'
    0x46:
      id: 'sec_reporting'
      doc: 'Sec Reporting'
    0x47:
      id: 'international_reporting'
      doc: 'International Reporting'
    0x49:
      id: 'insurance_company'
      doc: 'Insurance Company'
    0x4e:
      id: 'no_reporting'
      doc: 'No Reporting'
    0x4f:
      id: 'other_reporting_standard'
      doc: 'Other Reporting Standard'
    0x52:
      id: 'finra_reporting'
      doc: 'Finra Reporting'
    0x56:
      id: 'sec_reporting_investment_company'
      doc: 'Sec Reporting Investment Company'
    0x57:
      id: 'sec_reporting_reg_a'
      doc: 'Sec Reporting Reg A'
  security_status:
    0x41:
      id: 'active'
      doc: 'Active'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'internal_halt'
      doc: 'Internal Halt'
    0x52:
      id: 'revoked'
      doc: 'Revoked'
    0x44:
      id: 'deleted'
      doc: 'Deleted'
    0x58:
      id: 'removed_from_idqs'
      doc: 'Removed From Idqs'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  unsolicited:
    0x59:
      id: 'unsolicited'
      doc: 'Unsolicited'
    0x4e:
      id: 'not_unsolicited'
      doc: 'Not Unsolicited'
  current_inside_imbalance_side:
    0x42:
      id: 'buy_side'
      doc: 'Imbalance Is On Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Imbalance Is On Sell Side'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'no_marketable_orders'
      doc: 'No Marketable Orders'
  moc_shares_unmatched:
    0x42:
      id: 'buy_moc_not_matched'
      doc: 'Buy Moc Shares Not Matched'
    0x53:
      id: 'sell_moc_not_matched'
      doc: 'Sell Moc Shares Not Matched'
    0x4f:
      id: 'no_moc_unmatched'
      doc: 'No Moc Shares Not Matched'
  recovery_type:
    83:
      id: 'scheduling_start'
      doc: 'S Scheduling Of Start Of Recovery Event'
    66:
      id: 'recovery_begins'
      doc: 'B Recovery Begins'
  login_status:
    89:
      id: 'accepted'
      doc: 'Y Login Accepted'
  retran_via_tcp:
    89:
      id: 'same_tcp_channel'
      doc: 'Y Sent Back On The Same Tcp Channel'
  retransmission_status:
    89:
      id: 'will_follow'
      doc: 'Y Retransmission Will Follow As Requested'
    78:
      id: 'request_ignored'
      doc: 'N Request Ignored'
  spin_status:
    83:
      id: 'start_of_spin'
      doc: 'S Start Of Spin'
    69:
      id: 'end_of_spin'
      doc: 'E End Of Spin'
  enhanced_spin_status:
    83:
      id: 'start_of_spin'
      doc: 'S Start Of Spin'
    69:
      id: 'end_of_spin'
      doc: 'E End Of Spin'

