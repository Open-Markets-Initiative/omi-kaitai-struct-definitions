# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PhlxOptions Orders Itch v1.92
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: PHLX Orders
#   Encoding: Itch
#   Version: 1.92
#   Date: 04/25/2025
#   Specification: topoplusorders - TCP Update.pdf
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
  id: nasdaq_phlxoptions_orders_itch_v1_92_client
  title: Nasdaq PhlxOptions Orders Itch v1.92
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PHLX PHLX Orders Itch v1.92'
doc-ref: https://www.nasdaqtrader.com/Trader.aspx?id=DPSpecs

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
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x44:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, PHLX disseminates directory messages for all symbols trading on the PHLX option system.'
    0x52:
      id: 'complex_order_strategy_message'
      doc: 'Whenever a complex order is added in the system for an underlying, the order is normalized and results in either the creation of a new complex strategy or is added to an existing strategy. A Complex Order Strategy Message containing the strategy definition will be sent.'
    0x48:
      id: 'security_trading_action_message'
      doc: 'PHLX uses this administrative message to indicate the current trading status of an index or equity option within the PHLX Options Market.'
    0x49:
      id: 'complex_trading_action_message'
      doc: 'PHLX uses this administrative message to indicate the current trading status of a strategy within the PHLX Options Market.'
    0x50:
      id: 'security_open_closed_message'
      doc: 'PHLX uses this administrative message to indicate when an option has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x51:
      id: 'strategy_open_closed_message'
      doc: 'PHLX uses this administrative message to indicate when a strategy has completed the opening process or when the strategy has closed and is no longer available for auto execution.'
    0x4f:
      id: 'simple_order_message'
      doc: 'When a Single Order is received or any change is made to an order, an Order message containing the current order status will be sent.'
    0x58:
      id: 'complex_order_message'
      doc: 'When a Complex Order is received or any change is made to a complex order for an underlying, a Complex Order Message containing the order information will be sent.'
    0x41:
      id: 'auction_notification_message'
      doc: 'When a symbol goes into an auction, an Auction Notification Message is sent. Also if any auction parameters change during the auction, size for example, a new Auction Notification message will be sent for that symbol.'
    0x43:
      id: 'complex_auction_notification_message'
      doc: 'When a Complex Order Live Auction (COLA) or PIXL/Solicitation auction starts for a strategy of an underlying, a COLA/PIXL/Solicitation notification message containing the auction information will be sent.'
    0x4d:
      id: 'end_of_replay_sequence_message'
      doc: 'The End of replay Sequence message reflects the sequence number at the time replay of existing messages is complete. The firms can then use this sequence number to resume on the real time Mold channel. Only for SoupBINTCP.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process'
    0x4e:
      id: 'start_of_normal_hours_closing_process'
      doc: 'Start Of Normal Hours Closing Process'
    0x4c:
      id: 'start_of_late_hours_closing_process'
      doc: 'Start Of Late Hours Closing Process'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
    0x57:
      id: 'end_of_wco_early_closing'
      doc: 'End Of Wco Early Closing'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
    0x20:
      id: 'stock'
      doc: 'Stock'
  option_closing_type:
    0x4e:
      id: 'normal'
      doc: 'Normal Hours'
    0x4c:
      id: 'late'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing At 1200 Noon'
  phlx_tradable:
    0x59:
      id: 'tradable'
      doc: 'Option Is Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Option Is Not Tradable'
  action:
    0x41:
      id: 'add'
      doc: 'Add'
    0x44:
      id: 'delete_field'
      doc: 'Delete'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x2a:
      id: 'hidden'
      doc: 'Side Is Hidden'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'phlx_trading_resumed'
      doc: 'Phlx Trading Resumed'
  open_state:
    0x59:
      id: 'open_for_auto_execution'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed_for_auto_execution'
      doc: 'Closed For Auto Execution'
  order_status:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x46:
      id: 'filled'
      doc: 'Filled'
    0x43:
      id: 'cancelled'
      doc: 'Cancelled'
    0x52:
      id: 'renotification'
      doc: 'Renotification'
  order_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4c:
      id: 'limit'
      doc: 'Limit'
    0x2a:
      id: 'anonymous'
      doc: 'Anonymous'
  market_qualifier:
    0x4f:
      id: 'opening_order'
      doc: 'Opening Order'
    0x49:
      id: 'implied_order'
      doc: 'Implied Order'
    0x20:
      id: 'na'
      doc: 'Na'
  all_or_none:
    0x59:
      id: 'all_or_none_order'
      doc: 'All Or None Order'
    0x4e:
      id: 'not_all_or_none_order'
      doc: 'Not All Or None Order'
  time_in_force:
    0x44:
      id: 'day_order'
      doc: 'Day Order'
    0x47:
      id: 'gtc'
      doc: 'Good Till Cancelled'
    0x49:
      id: 'ioc'
      doc: 'Immediate Or Cancel'
  customer_firm_indicator:
    0x43:
      id: 'customer_order'
      doc: 'Customer Order'
    0x46:
      id: 'firm_order'
      doc: 'Firm Order'
    0x4d:
      id: 'onfloor_market_maker'
      doc: 'Onfloor Market Maker'
    0x42:
      id: 'broker_dealer_order'
      doc: 'Broker Dealer Order'
    0x50:
      id: 'professional_order'
      doc: 'Professional Order'
    0x20:
      id: 'na_for_implied_order'
      doc: 'Na For Implied Order'
  open_close_indicator:
    0x4f:
      id: 'opens_position'
      doc: 'Opens Position'
    0x43:
      id: 'closes_position'
      doc: 'Closes Position'
    0x20:
      id: 'na'
      doc: 'Na For Implied Order'
  debit_or_credit:
    0x44:
      id: 'net_debit'
      doc: 'Net Debit'
    0x43:
      id: 'net_credit'
      doc: 'Net Credit'
    0x20:
      id: 'even_or_market_order'
      doc: 'Even Or Market Order'
    0x2a:
      id: 'anonymous'
      doc: 'Anonymous'
  leg_open_close_indicator:
    0x4f:
      id: 'opens_position'
      doc: 'Opens Position'
    0x43:
      id: 'closes_position'
      doc: 'Closes Position'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  auction_type:
    0x43:
      id: 'cola'
      doc: 'Cola'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x50:
      id: 'pixl'
      doc: 'Pixl'
    0x53:
      id: 'solicitation'
      doc: 'Solicitation'
    0x49:
      id: 'order_exposure'
      doc: 'Order Exposure'
  auction_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x2a:
      id: 'solicitation_auction'
      doc: 'Solicitation Auction'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x44:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, PHLX disseminates directory messages for all symbols trading on the PHLX option system.'
    0x52:
      id: 'complex_order_strategy_message'
      doc: 'Whenever a complex order is added in the system for an underlying, the order is normalized and results in either the creation of a new complex strategy or is added to an existing strategy. A Complex Order Strategy Message containing the strategy definition will be sent.'
    0x48:
      id: 'security_trading_action_message'
      doc: 'PHLX uses this administrative message to indicate the current trading status of an index or equity option within the PHLX Options Market.'
    0x49:
      id: 'complex_trading_action_message'
      doc: 'PHLX uses this administrative message to indicate the current trading status of a strategy within the PHLX Options Market.'
    0x50:
      id: 'security_open_closed_message'
      doc: 'PHLX uses this administrative message to indicate when an option has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x51:
      id: 'strategy_open_closed_message'
      doc: 'PHLX uses this administrative message to indicate when a strategy has completed the opening process or when the strategy has closed and is no longer available for auto execution.'
    0x4f:
      id: 'simple_order_message'
      doc: 'When a Single Order is received or any change is made to an order, an Order message containing the current order status will be sent.'
    0x58:
      id: 'complex_order_message'
      doc: 'When a Complex Order is received or any change is made to a complex order for an underlying, a Complex Order Message containing the order information will be sent.'
    0x41:
      id: 'auction_notification_message'
      doc: 'When a symbol goes into an auction, an Auction Notification Message is sent. Also if any auction parameters change during the auction, size for example, a new Auction Notification message will be sent for that symbol.'
    0x43:
      id: 'complex_auction_notification_message'
      doc: 'When a Complex Order Live Auction (COLA) or PIXL/Solicitation auction starts for a strategy of an underlying, a COLA/PIXL/Solicitation notification message containing the auction information will be sent.'

