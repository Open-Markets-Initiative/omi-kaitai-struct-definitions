# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Tsx QuantumFeedLevel2Recovery Xmt v3.6
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Quantum Feed Level 2 Recovery
#   Encoding: eXtreme Message Transfer
#   Version: 3.6
#   Date: 8/10/2021
#   Specification: TSX TSXV Level 2 QuantumFeed Business Message Specification (3.6.0).pdf
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
  id: tmx_tsx_quantumfeedlevel2recovery_xmt_v3_6_client
  title: Tmx Tsx QuantumFeedLevel2Recovery Xmt v3.6
  license: GPL-3.0
  endian: le

doc: 'TMX Group Toronto Stock Exchange Quantum Feed Level 2 Recovery Xmt v3.6'
doc-ref: https://www.tmxwebstore.com/products/binary-feeds-quantumfeeds

seq:
  - id: client_frame
    type: client_frame_struct
    repeat: eos
    doc: 'One XMT frame with no trailer'

types:
  client_frame_struct:
    seq:
      - id: frame_header
        type: frame_header
        doc: 'XMT frame prefix and outer header'
      - id: client_body
        size: frame_header.message_length + 5 - 11
        type:
          switch-on: peek_msg_type
          cases:
            'msg_type::heartbeat': heartbeat_body
            'msg_type::login_request': login_request
            'msg_type::logout': logout
            'msg_type::replay_request': replay_request
    instances:
      peek_msg_type:
        pos: _io.pos + 2
        type: u1
        enum: msg_type
  frame_header:
    seq:
      - id: start_of_frame
        type: u1
        doc: 'Start of Frame'
      - id: protocol_name
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol Name'
      - id: protocol_version
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol major version number'
      - id: message_length
        type: u2
        doc: 'Length of message from Header to Body inclusive'
      - id: session_id
        type: u4
        doc: 'Constant Session Id'
      - id: ack_required_poss_dup
        type: u1
        enum: ack_required_poss_dup
        doc: 'Ack Required Poss Dup'
      - id: num_body
        type: u1
        doc: 'Num Body'
  heartbeat_body:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
      - id: hb_interval
        type: u2
        doc: 'Heartbeat interval in milliseconds (1 to 65536)'
      - id: admin_body
        type: admin_body
        repeat: expr
        repeat-expr: _parent.frame_header.num_body
  body_header:
    seq:
      - id: msg_length
        type: u2
        doc: 'Length of this message'
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Msg Type'
  admin_body:
    seq:
      - id: source_id
        type: u1
        enum: source_id
        doc: 'Source Id of the Business message'
      - id: stream_id
        type: u2
        doc: 'Stream Id per Source Id of the Business message'
      - id: sequence_0
        type: u1
        doc: 'Reserved for future expansion, Value is 0'
      - id: sequence_1
        type: u4
        doc: 'Sequence per Stream Id of the Business message'
  login_request:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
      - id: hb_interval
        type: u2
        doc: 'Heartbeat interval in milliseconds (1 to 65536)'
      - id: replay_win_size
        type: u2
        doc: 'Maximum number of messages, in thousands, allowed in the replay window'
      - id: replay_win_num
        type: u2
        doc: 'Maximum number of replay requests allowed in the window'
      - id: credits
        type: u2
        doc: 'Reserved for future use. Value is 0'
  logout:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
  replay_request:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
      - id: replay_session_id
        type: u4
        doc: 'Session ID of the source to replay the message'
      - id: replay_range
        type: replay_range
        repeat: expr
        repeat-expr: _parent.frame_header.num_body
  replay_range:
    seq:
      - id: source_id
        type: u1
        enum: source_id
        doc: 'Source Id of the Business message'
      - id: stream_id
        type: u2
        doc: 'Stream Id per Source Id of the Business message'
      - id: sequence_0
        type: u1
        doc: 'Reserved for future expansion, Value is 0'
      - id: sequence_1_start
        type: u4
        doc: 'Starting sequence per stream ID'
      - id: sequence_1_end
        type: u4
        doc: 'Ending sequence per stream ID'

enums:
  ack_required_poss_dup:
    0x41:
      id: 'ack_required'
      doc: 'Receiver needs to ack'
    0x44:
      id: 'poss_dup'
      doc: 'Possible duplicates'
  msg_type:
    0x30:
      id: 'heartbeat'
      doc: 'The Heartbeat message is sent by either side during idle periods for the opposite side to detect whether the session is still alive.'
    0x31:
      id: 'login_request'
      doc: 'Login Request is used to establish a connection-oriented session for exchanging messages.'
    0x32:
      id: 'login_response'
      doc: 'A successful login results in a Login Response to send back to the originator of the request.'
    0x33:
      id: 'logout'
      doc: 'A Logout message is sent to notify the other side that the sending side is leaving the session.'
    0x34:
      id: 'ack'
      doc: 'Ack message is typically used when the implementation of the protocol requires acknowledgements or responses of requests/messages; for example, Replay Request or a synchronous transaction.'
    0x35:
      id: 'replay_request'
      doc: 'A request to replay the transmission of previously sent messages.'
    0x36:
      id: 'sequence_jump'
      doc: 'Sequence Jump is used to advance the sequence number from the current to the new sequence to indicate that certain messages are to be resent, are no longer available, or are not deterministic in a failure or disaster situation.'
    0x39:
      id: 'reject'
      doc: 'Reject is used in response to the request message, when it fails validation or is not allowed in certain states.'
    0x4a:
      id: 'symbol_status_message'
      doc: 'Symbol Status messages contain information regarding equity, debenture, mutual fund, or trading Instruments for the current trading day for both TSX and TSXV markets. One message is disseminated for each valid symbol at the beginning of each trading day.'
    0x47:
      id: 'order_book_message'
      doc: 'An Order Book message provides public information for all open non-terms orders in the market at the start of day. One message is disseminated for each valid non-terms order at the beginning of each trading day. Feed clients can use the Order Book message to initialize their order book for the current trading day.'
    0x6a:
      id: 'order_book_terms_message'
      doc: 'An Order Book – Terms Message provides public information for all open terms orders in the market at the start of day. One message is disseminated for each valid non-terms order at the beginning of each trading day. Feed clients can use the Order Book – Terms message to initialize their order book for the current trading day.'
    0x41:
      id: 'assign_cop_orders_message'
      doc: 'An Assign COP – Orders message specifies the calculated opening price (COP) for a security and the participating orders that are priced at the COP. Each Assign COP – Orders message can contain up to 15 orders priced at COP, and the orders are positional. All the orders reported on a single Assign COP – Orders message always belong to the same market side. Note: This message is produced only if one or more orders are repriced to the COP.'
    0x42:
      id: 'assign_cop_no_orders_message'
      doc: 'An Assign COP – No Order message specifies the calculated opening price for a security when there are no orders that are to be repriced to the COP. Note: This message is produced only if the COP is changing, but no orders are being repriced to the COP.'
    0x43:
      id: 'assign_limit_message'
      doc: 'An Assign Limit message is disseminated when former better-priced-limit orders are reset to their true limits. Each Assign Limit message can contain up to 15 orders along with their prices, and the orders are positional. All the orders reported on a single Assign Limit message always belong to the same market side.'
    0x45:
      id: 'market_state_update_message'
      doc: 'A Market State Update message is disseminated each time a notice of a market state change or a trading session change is sent from the Trading Engine'
    0x46:
      id: 'moc_imbalance_message'
      doc: 'The MOC Imbalance message is disseminated for MOC-eligible symbols every 10 seconds starting from the beginning of the MOC Imbalance trading session at 3:50 p.m., or as notified by TSX Equities Trading. The message will be disseminated at 4:00 p.m. for closing delayed stocks. The imbalance reference price at that time is the last sale price of the symbol.'
    0x50:
      id: 'order_booked_message'
      doc: 'An Order Booked message is disseminated in response to a new non-terms order being entered into the trading system'
    0x6d:
      id: 'order_booked_terms_message'
      doc: 'An Order Booked - Terms message is disseminated in response to a new terms order being entered into the trading system'
    0x51:
      id: 'order_cancelled_message'
      doc: 'An Order Cancelled message is disseminated if a non-terms order is cancelled'
    0x6e:
      id: 'order_cancelled_terms_message'
      doc: 'An Order Cancelled – Terms message is disseminated if a terms order is cancelled'
    0x52:
      id: 'order_price_time_assigned_message'
      doc: 'An Order Price-Time Assigned message is disseminated when a new Price or Time is assigned to a non-terms order'
    0x6f:
      id: 'order_price_time_assigned_terms_message'
      doc: 'An Order Price-Time Assigned – Terms message is disseminated if a new Price or Time is assigned to a terms order'
    0x49:
      id: 'stock_status_message'
      doc: 'A Stock Status notification is disseminated in response to a change in stock status from the Trading Engine'
    0x53:
      id: 'trade_report_message'
      doc: 'A Trade Report is produced when a trade occurs that has no settlement terms'
    0x70:
      id: 'trade_report_terms_message'
      doc: 'A Trade Report – Terms is produced when a trade occurs that: Has settlement terms. Has Non-Resident participation with or without settlement terms.'
    0x54:
      id: 'trade_cancelled_message'
      doc: 'A Trade Cancelled message is produced when a trade with no settlement terms is cancelled.'
    0x71:
      id: 'trade_cancelled_terms_message'
      doc: 'A Trade Cancelled – Terms message is produced when a trade with settlement terms is cancelled.'
    0x55:
      id: 'trade_correction_message'
      doc: 'A Trade Correction message is produced when a trade with no settlement terms is corrected'
    0x72:
      id: 'trade_correction_terms_message'
      doc: 'A Trade Correction – Terms message is produced when a trade with settlement terms is corrected'
  source_id:
    0x30:
      id: 'non_source_related'
      doc: '“0” for non-source-related.'
    0x51:
      id: 'tsx'
      doc: 'Q for TSX'
    0x56:
      id: 'tsx_venture'
      doc: 'V for TSX Venture'
    0x41:
      id: 'alpha'
      doc: 'A for Alpha'
  currency:
    0x55:
      id: 'usd'
      doc: 'Usd'
    0x43:
      id: 'cad'
      doc: 'Cad'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'tsx_venture'
      doc: 'Tsx Venture'
    0x4e:
      id: 'tsx_na_vex'
      doc: 'Tsx Na Vex'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x53:
      id: 'nyse'
      doc: 'Nyse'
    0x4d:
      id: 'nyse_mkt'
      doc: 'Nyse Mkt'
    0x58:
      id: 'no_market'
      doc: 'No Market'
  product_type:
    0x42:
      id: 'debenture'
      doc: 'Debenture'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x4d:
      id: 'mutual_fund'
      doc: 'Mutual Fund'
    0x46:
      id: 'etf'
      doc: 'Etf'
    0x55:
      id: 'us_equity'
      doc: 'Us Equity'
    0x4f:
      id: 'bond'
      doc: 'Bond'
  test_symbol:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  moc_eligible:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  non_resident:
    0x59:
      id: 'yes_field'
      doc: 'Participant Is Not A Canadian Resident'
    0x4e:
      id: 'no_field'
      doc: 'Participant Is A Canadian Resident'
  settlement_terms:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'nn'
      doc: 'Nn'
    0x4d:
      id: 'ms'
      doc: 'Ms'
    0x54:
      id: 'ct'
      doc: 'Ct'
    0x44:
      id: 'valid_settlement_date'
      doc: 'Valid Settlement Date'
    0x20:
      id: 'no_settlement_terms'
      doc: 'No Settlement Terms'
  market_state:
    0x50:
      id: 'preopen'
      doc: 'Preopen'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'open'
      doc: 'Open'
    0x4d:
      id: 'moc_imbalance'
      doc: 'Moc Imbalance'
    0x54:
      id: 'moc_freeze'
      doc: 'Moc Freeze'
    0x41:
      id: 'ccp_determination'
      doc: 'Ccp Determination'
    0x45:
      id: 'price_movement_extension'
      doc: 'Price Movement Extension'
    0x4c:
      id: 'closing'
      doc: 'Closing'
    0x4e:
      id: 'extended_hours_cxls'
      doc: 'Extended Hours Cxls'
    0x52:
      id: 'extended_hours_open'
      doc: 'Extended Hours Open'
    0x46:
      id: 'extended_hours_close'
      doc: 'Extended Hours Close'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x4a:
      id: 'nav_ex_closed'
      doc: 'Nav Ex Closed'
    0x47:
      id: 'nav_ex_order_entry'
      doc: 'Nav Ex Order Entry'
    0x48:
      id: 'nav_ex_order_entry_close'
      doc: 'Nav Ex Order Entry Close'
    0x4b:
      id: 'nav_ex_am_execution'
      doc: 'Nav Ex Am Execution'
    0x58:
      id: 'nav_ex_pm_execution'
      doc: 'Nav Ex Pm Execution'
    0x59:
      id: 'nav_ex_close'
      doc: 'Nav Ex Close'
  imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'no_imbalance_exists'
      doc: 'No Imbalance Exists'
  market_order_imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'no_imbalance_exists'
      doc: 'No Imbalance Exists'
  bypass:
    0x59:
      id: 'the_order_is_a_bypass'
      doc: 'The Order Is A Bypass'
    0x4e:
      id: 'the_order_is_not_a_bypass'
      doc: 'The Order Is Not A Bypass'
  cross_type:
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x53:
      id: 'special_trading_session'
      doc: 'Special Trading Session'
    0x56:
      id: 'volume_weighted_average_price'
      doc: 'Volume Weighted Average Price'
    0x20:
      id: 'default_trade_was_not_a_cross'
      doc: 'Default Trade Was Not A Cross'
  is_mid_only:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  is_dark:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  is_conditional:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  initiated_by:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x43:
      id: 'both'
      doc: 'Both'
  reason_code:
    1:
      id: 'do_not_resend'
      doc: 'Do not resend.'
    2:
      id: 'no_longer_available'
      doc: 'No longer available.'
    3:
      id: 'disaster'
      doc: 'Disaster.'
  reject_code:
    0:
      id: 'information'
      doc: 'Information.'
    1:
      id: 'warning'
      doc: 'Warning.'
    2:
      id: 'critical'
      doc: 'Critical.'
    3:
      id: 'fatal'
      doc: 'Fatal.'
  reject_subcode:
    1:
      id: 'invalid_syntax'
      doc: 'Invalid syntax.'
    2:
      id: 'invalid_session_states_or_conditions'
      doc: 'Invalid session states/conditions.'
    3:
      id: 'invalid_values'
      doc: 'Invalid values.'
    4:
      id: 'function_not_implemented'
      doc: 'Function not implemented.'
    5:
      id: 'function_not_allowed'
      doc: 'Function not allowed.'
    6:
      id: 'function_temporarily_not_available_but_retryable'
      doc: 'Function temporarily not available, but retryable.'
    7:
      id: 'message_temporarily_not_available_but_retryable'
      doc: 'Message temporarily not available, but retryable.'
    8:
      id: 'duplicate_request_or_message'
      doc: 'Duplicate request/message.'
    9:
      id: 'others_see_message'
      doc: 'Others, see Message.'

