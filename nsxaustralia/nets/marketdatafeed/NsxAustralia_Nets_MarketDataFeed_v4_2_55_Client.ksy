# ---------------------------------------------------------------------
# Kaitai struct definition for: NsxAustralia Nets MarketDataFeed Itch v4.2.55
#
# Protocol:
#   Organization: Nation Stock Exchange of Australia
#   Protocol: NSX Market Data Feed
#   Encoding: Itch
#   Version: 4.2.55
#   Date: 4/6/2026
#   Specification: Unknown
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
  id: nsxaustralia_nets_marketdatafeed_itch_v4_2_55_client
  title: NsxAustralia Nets MarketDataFeed Itch v4.2.55
  license: GPL-3.0
  endian: be

doc: 'Nation Stock Exchange of Australia NETS Trading System NSX Market Data Feed Itch v4.2.55'
doc-ref: https://docs.nsx.com.au/ncd/nsx-itch-specification

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
  sequenced_message_type:
    0x54:
      id: 'timestamp_message'
      doc: 'This message is sent to provide the time since Epoch. It should be used in combination with the Timestamp field of individual messages to determine the exact time for each message.'
    0x53:
      id: 'system_event_message'
      doc: 'This message will be sent to provide information about events that are scheduled or triggered by the system. Events may occur at Orderbook, Board, Board+Product or System level.'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'This message provides the price ticks (steps) for the orderbooks in the system. It should be used as a lookup from Orderbook Directory [R] messages.'
    0x4d:
      id: 'quantity_tick_size_message'
      doc: 'This message provides the quantity ticks (steps) for the orderbooks in the system. It should be used as a lookup from Orderbook Directory [R] messages.'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook Directory Messages are transmitted during the reference data spin. Static data messages are sent at the beginning of the feed and contain exchange reference information.'
    0x48:
      id: 'orderbook_trading_action_message'
      doc: 'This message indicates the current trading state of an orderbook.'
    0x58:
      id: 'orderbook_attribute_message'
      doc: 'This message provides dynamic reference values for an orderbook.'
    0x46:
      id: 'firm_directory_message'
      doc: 'This message provides reference information about system participants.'
    0x41:
      id: 'add_order_message'
      doc: 'This message is sent when an order is added to the orderbook.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent when an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent when an order on the book is executed in whole or in part at a negotiated price different from the order price.'
    0x42:
      id: 'broken_trade_message'
      doc: 'This message is sent when a trade is cancelled.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message indicates when an order has been removed from the orderbook.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message indicates when an order in the orderbook has been modified.'
    0x49:
      id: 'indicative_price_quantity_message'
      doc: 'This message provides auction information including the theoretical opening price and quantity.'
    0x50:
      id: 'trade_message'
      doc: 'This message is sent to provide information about off-book matching.'
    0x4e:
      id: 'news_message'
      doc: 'This message disseminates exchange news.'
    0x59:
      id: 'index_member_directory_message'
      doc: 'This message provides details about index members and their respective weightings within an index.'
    0x5a:
      id: 'index_value_message'
      doc: 'This message disseminates index values to market participants.'
  event_status:
    0x53:
      id: 'scheduled'
      doc: 'Scheduled'
    0x43:
      id: 'canceled'
      doc: 'Canceled'
    0x54:
      id: 'triggered'
      doc: 'Triggered'
  asset_type:
    0x44:
      id: 'debt'
      doc: 'Debt'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x49:
      id: 'index'
      doc: 'Index'
  trading_state:
    0x54:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  reason:
    0x4e:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x48:
      id: 'halted_due_to_extreme_trade_range'
      doc: 'Halted Due To Extreme Trade Range'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory'
  attribute_type:
    0x52:
      id: 'previous_day_close'
      doc: 'Previous Day Close'
    0x43:
      id: 'close_price'
      doc: 'Close Price'
    0x44:
      id: 'etr_upper_limit_percentage'
      doc: 'Etr Upper Limit Percentage'
    0x64:
      id: 'etr_lower_limit_percentage'
      doc: 'Etr Lower Limit Percentage'
    0x50:
      id: 'aot_upper_limit_percentage'
      doc: 'Aot Upper Limit Percentage'
    0x70:
      id: 'aot_lower_limit_percentage'
      doc: 'Aot Lower Limit Percentage'
    0x41:
      id: 'aot_reference_price'
      doc: 'Aot Reference Price'
    0x42:
      id: 'etr_reference_price'
      doc: 'Etr Reference Price'
  order_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  printable:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  cross_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x49:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
  trade_indicator:
    0x42:
      id: 'block_special'
      doc: 'Block Special'
  trade_source:
    0x41:
      id: 'autotrade'
      doc: 'Autotrade'
    0x42:
      id: 'best_execution'
      doc: 'Best Execution'
    0x43:
      id: 'off_market_automatic_crossing'
      doc: 'Off Market Automatic Crossing'
    0x44:
      id: 'directed_reporting_or_off_market_trades_crossing'
      doc: 'Directed Reporting Or Off Market Trades Crossing'
    0x45:
      id: 'special_crossing_less_than_a_marketable_parcel'
      doc: 'Special Crossing Less Than A Marketable Parcel'
    0x46:
      id: 'forward_delivery'
      doc: 'Forward Delivery'
    0x49:
      id: 'approved_index_crossing'
      doc: 'Approved Index Crossing'
    0x4b:
      id: 'buy_back_sales'
      doc: 'Buy Back Sales'
    0x4d:
      id: 'marriage_crossing'
      doc: 'Marriage Crossing'
    0x4e:
      id: 'trades_including_crossings_outside_of_market_hours'
      doc: 'Trades Including Crossings Outside Of Market Hours'
    0x4f:
      id: 'foreign_residents_or_recognised_overseas_exchange'
      doc: 'Foreign Residents Or Recognised Overseas Exchange'
    0x50:
      id: 'block_special_crossing_or_loan_securities'
      doc: 'Block Special Crossing Or Loan Securities'
    0x51:
      id: 'special_crossing_less_than_a_marketable_parcel_x51'
      doc: 'Special Crossing Less Than A Marketable Parcel'
    0x52:
      id: 'strategy'
      doc: 'Strategy'
    0x53:
      id: 'short_sales'
      doc: 'Short Sales'
    0x55:
      id: 'for_foreign_to_foreign_securities'
      doc: 'For Foreign To Foreign Securities'
    0x56:
      id: 'book_value_switch_sales'
      doc: 'Book Value Switch Sales'
    0x58:
      id: 'portfolio_special_crossing'
      doc: 'Portfolio Special Crossing'
    0x59:
      id: 'special'
      doc: 'Special'
    0x5a:
      id: 'special_crossing_underwriting_disposal_or_exchange_approval'
      doc: 'Special Crossing Underwriting Disposal Or Exchange Approval'

