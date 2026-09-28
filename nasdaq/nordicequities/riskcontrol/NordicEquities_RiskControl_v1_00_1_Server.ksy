# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicEquities RiskControl Binary v1.00.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nordic Pre-Trade Risk Management
#   Encoding: Binary
#   Version: 1.00.1
#   Date: 02/10/2026
#   Specification: Nasdaq-Nordic---PRM-v.1.00.1.pdf
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
  id: nasdaq_nordicequities_riskcontrol_binary_v1_00_1_server
  title: Nasdaq NordicEquities RiskControl Binary v1.00.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Equities Nordic Pre-Trade Risk Management Binary v1.00.1'
doc-ref: https://www.nasdaq.com/solutions/pre-trade-risk-management

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
            'sequenced_message_type::account_query_response_message': account_query_response_message
            'sequenced_message_type::account_settings_response_message': account_settings_response_message
            'sequenced_message_type::order_book_restriction_response_message': order_book_restriction_response_message
            'sequenced_message_type::market_segment_restriction_response_message': market_segment_restriction_response_message
            'sequenced_message_type::limit_settings_response_message': limit_settings_response_message
            'sequenced_message_type::account_currency_setting_response_message': account_currency_setting_response_message
            'sequenced_message_type::reject_message': reject_message
            'sequenced_message_type::api_port_rate_breach_message': api_port_rate_breach_message
            'sequenced_message_type::account_rate_breach_message': account_rate_breach_message
            'sequenced_message_type::accumulated_values_message': accumulated_values_message
  account_query_response_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'A unique sequential number starting from 1 at start of day'
  account_settings_response_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'A unique sequential number starting from 1 at start of day'
      - id: prm_account
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRM Account in which the settings apply'
      - id: repeated_order_generation
        type: s4
        doc: 'Maximum allowed number of consecutive identical orders, previous value kept if -1'
      - id: trigger_restrict_symbol_on_repeated_order_generation
        type: u1
        enum: trigger_restrict_symbol_on_repeated_order_generation
        doc: 'Restrict symbol when order repetition limit is breached, previous value kept if ?'
      - id: in_auction_market_order_prevention
        type: u1
        enum: in_auction_market_order_prevention
        doc: 'Enable market order prevention, previous value kept if ?'
      - id: in_auction_fat_finger_protection
        type: u1
        enum: in_auction_fat_finger_protection
        doc: 'Enable fat finger protection, previous value kept if ?'
      - id: in_auction_market_order_protection
        type: u1
        enum: in_auction_market_order_protection
        doc: 'Enable market order protection, previous value kept if ?'
      - id: block_and_cancel
        type: u1
        enum: block_and_cancel
        doc: 'Block, unblock or cancel open orders of this PRM Account, previous value kept if ?'
  order_book_restriction_response_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'A unique sequential number starting from 1 at start of day'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight in UTC. Nanoseconds since Midnight epoch'
      - id: prm_account
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRM Account in which the settings apply'
      - id: order_book
        type: u4
        doc: 'Order Book to be restricted'
      - id: state
        type: u1
        enum: state
        doc: 'Describes whether the restriction is currently active, previous value kept if ?'
  market_segment_restriction_response_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'A unique sequential number starting from 1 at start of day'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight in UTC. Nanoseconds since Midnight epoch'
      - id: prm_account
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRM Account in which the settings apply'
      - id: market_segment
        type: u2
        doc: 'Market Segment to be restricted'
      - id: state
        type: u1
        enum: state
        doc: 'Describes whether the restriction is currently active, previous value kept if ?'
  limit_settings_response_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'A unique sequential number starting from 1 at start of day'
      - id: prm_account
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRM Account in which the settings apply'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency in which the settings apply'
      - id: max_quantity
        type: s8
        doc: 'Maximum number of shares allowed on a per order basis, previous value kept if -1'
      - id: max_value
        type: decimal_s8_4
        doc: 'Maximum order value (price * quantity) allowed on a per order basis, previous value kept if -1. Implied decimal with scale 1e-4'
      - id: unused
        type: u8
        doc: 'Field reserved for future use'
      - id: total_risk_value
        type: decimal_s8_4
        doc: 'Total risk value (open orders plus trades), previous value kept if -1. Implied decimal with scale 1e-4'
      - id: trade_buy_value
        type: decimal_s8_4
        doc: 'Trades buy value, previous value kept if -1. Implied decimal with scale 1e-4'
      - id: trade_sell_value
        type: decimal_s8_4
        doc: 'Trades sell value, previous value kept if -1. Implied decimal with scale 1e-4'
      - id: trade_net_value
        type: decimal_s8_4
        doc: 'Trades net value, previous value kept if -1. Implied decimal with scale 1e-4'
      - id: open_order_buy_value
        type: decimal_s8_4
        doc: 'Open orders buy value, previous value kept if -1. Implied decimal with scale 1e-4'
      - id: open_order_sell_value
        type: decimal_s8_4
        doc: 'Open orders sell value, previous value kept if -1. Implied decimal with scale 1e-4'
      - id: open_order_net_value
        type: decimal_s8_4
        doc: 'Open orders net value, previous value kept if -1. Implied decimal with scale 1e-4'
      - id: max_quantity_auction
        type: s8
        doc: 'Maximum number of shares allowed on a per order basis specific to auctions, previous value kept if -1'
      - id: max_value_auction
        type: decimal_s8_4
        doc: 'Maximum order value (price * quantity) allowed on a per order basis specific to auctions, previous value kept if -1. Implied decimal with scale 1e-4'
  account_currency_setting_response_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'A unique sequential number starting from 1 at start of day'
      - id: prm_account
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRM Account in which the settings apply'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency in which the settings apply'
      - id: reject_all_flag
        type: u1
        enum: reject_all_flag
        doc: 'Reject all orders, previous value kept if ?'
      - id: blow_through_protection
        type: u1
        enum: blow_through_protection
        doc: 'Enable blow through protection, previous value kept if ?'
  reject_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'A unique sequential number starting from 1 at start of day'
      - id: reason
        type: u1
        enum: reason
        doc: 'The reason the PRM change request was rejected'
  api_port_rate_breach_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight in UTC. Nanoseconds since Midnight epoch'
  account_rate_breach_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight in UTC. Nanoseconds since Midnight epoch'
      - id: state
        type: u1
        enum: state
        doc: 'Describes whether the restriction is currently active, previous value kept if ?'
      - id: prm_account
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRM Account in which the settings apply'
  accumulated_values_message:
    seq:
      - id: prm_account
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRM Account in which the settings apply'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency in which the settings apply'
      - id: last_update_time
        type: u8
        doc: 'Last update time'
      - id: risk_total_value
        type: u8
        doc: 'Risk total value'
      - id: trades_buy_value
        type: u8
        doc: 'Trades buy value'
      - id: trades_sell_value
        type: u8
        doc: 'Trades sell value'
      - id: trades_total_value
        type: u8
        doc: 'Trades total value'
      - id: orders_buy_value
        type: u8
        doc: 'Orders buy value'
      - id: orders_sell_value
        type: u8
        doc: 'Orders sell value'
      - id: orders_total_value
        type: u8
        doc: 'Orders total value'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
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
  unsequenced_message_type:
    0x51:
      id: 'account_query_message'
      doc: 'Returns the PRM API port''s next expected user reference number'
    0x43:
      id: 'modify_account_settings_message'
      doc: 'Updates the settings for a given PRM Account'
    0x52:
      id: 'modify_order_book_restriction_message'
      doc: 'Marks an Order Book as restricted or non-restricted for a given PRM Account'
    0x53:
      id: 'modify_market_segment_restriction_message'
      doc: 'Marks a Market Segment as restricted or non-restricted for a given PRM Account'
    0x4c:
      id: 'modify_limit_settings_message'
      doc: 'Updates the Limit settings for a given PRM Account and Currency'
    0x46:
      id: 'modify_account_currency_setting_message'
      doc: 'Updates the settings for a given PRM Account''s currency'
  trigger_restrict_symbol_on_repeated_order_generation:
    0x59:
      id: 'enabled'
      doc: 'Enabled'
    0x4e:
      id: 'disabled'
      doc: 'Disabled'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
  in_auction_market_order_prevention:
    0x59:
      id: 'enabled'
      doc: 'Enabled'
    0x4e:
      id: 'disabled'
      doc: 'Disabled'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
  in_auction_fat_finger_protection:
    0x59:
      id: 'enabled'
      doc: 'Enabled'
    0x4e:
      id: 'disabled'
      doc: 'Disabled'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
  in_auction_market_order_protection:
    0x59:
      id: 'enabled'
      doc: 'Enabled'
    0x4e:
      id: 'disabled'
      doc: 'Disabled'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
  block_and_cancel:
    0x42:
      id: 'block'
      doc: 'Block'
    0x55:
      id: 'unblock'
      doc: 'Unblock'
    0x43:
      id: 'block_and_cancel'
      doc: 'Block And Cancel'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
  state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x49:
      id: 'inactive'
      doc: 'Inactive'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
  reject_all_flag:
    0x59:
      id: 'enabled'
      doc: 'Enabled'
    0x4e:
      id: 'disabled'
      doc: 'Disabled'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
  blow_through_protection:
    0x59:
      id: 'enabled'
      doc: 'Enabled'
    0x4e:
      id: 'disabled'
      doc: 'Disabled'
    0x3f:
      id: 'previous_value_kept'
      doc: 'Previous Value Kept'
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
    0x51:
      id: 'account_query_response_message'
      doc: 'Provides the PRM API port''s next expected user reference number'
    0x43:
      id: 'account_settings_response_message'
      doc: 'Indicates that the settings for a given PRM Account have been updated'
    0x52:
      id: 'order_book_restriction_response_message'
      doc: 'Indicates that an Order Book has been restricted or non-restricted for a given PRM Account'
    0x53:
      id: 'market_segment_restriction_response_message'
      doc: 'Indicates that a Market Segment has been restricted or non-restricted for a given PRM Account'
    0x4c:
      id: 'limit_settings_response_message'
      doc: 'Indicates that the Limit settings for a given PRM Account and Currency have been updated'
    0x46:
      id: 'account_currency_setting_response_message'
      doc: 'Indicates that the settings for a given PRM Account''s currency have been updated'
    0x4a:
      id: 'reject_message'
      doc: 'Indicates that an inbound message has been rejected'
    0x50:
      id: 'api_port_rate_breach_message'
      doc: 'Indicates that the port''s rate limit has been breached'
    0x42:
      id: 'account_rate_breach_message'
      doc: 'Indicates that a PRM Account''s rate limit has been breached'
    0x56:
      id: 'accumulated_values_message'
      doc: 'Indicates the current Accumulated Values for a PRM Account and Currency, sent after order or trade updates'
  reason:
    0x43:
      id: 'invalid_currency'
      doc: 'Invalid Currency'
    0x41:
      id: 'invalid_prm_account'
      doc: 'Invalid Prm Account'
    0x4e:
      id: 'no_setting_present'
      doc: 'No Setting Present'
    0x55:
      id: 'unauthorized'
      doc: 'Unauthorized'

