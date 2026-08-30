# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq MrxOptions DepthOfMarket Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Depth Of Market
#   Encoding: Itch
#   Version: 2.1
#   Date: 02/13/2026
#   Specification: Options_Depth_of_Market_Feed_2.1.pdf
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
  id: nasdaq_mrxoptions_depthofmarket_itch_v2_1_clienttcp
  title: Nasdaq MrxOptions DepthOfMarket Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq MRX Depth Of Market Itch v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_tcp_packet_header
        type: client_tcp_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_tcp_payload
        size: client_tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_tcp_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_tcp_packet_header:
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
      - id: text
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
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_tcp_packet_header.packet_length - 2
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
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x6d:
      id: 'derivative_directory_message'
      doc: 'Derivative Directory Message for active options symbols.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x72:
      id: 'add_order_short_form_message'
      doc: 'An Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6f:
      id: 'add_order_long_form_message'
      doc: 'An Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6a:
      id: 'add_quote_short_form_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted and was added to the displayable book.'
    0x4a:
      id: 'add_quote_long_form_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted and was added to the displayable book.'
    0x65:
      id: 'single_side_executed_message'
      doc: 'This message is sent whenever a Side order is executed in whole or in part.'
    0x63:
      id: 'single_side_executed_with_price_message'
      doc: 'This message is sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_short_form_message'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced.'
    0x55:
      id: 'single_side_replace_long_form_message'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_update_message'
      doc: 'This message is sent whenever an order or a side of a quote is being updated for price and (or) contracts.'
    0x6b:
      id: 'quote_replace_short_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x4b:
      id: 'quote_replace_long_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x59:
      id: 'quote_delete_message'
      doc: 'The message is sent when a single quote is being cancelled.'
    0x71:
      id: 'trade_message'
      doc: 'This Options Trade Message is designed to provide execution details for normal match events involving non-displayable order types.'
    0x4f:
      id: 'net_order_imbalance_message'
      doc: 'This message is used to announce opening and re-opening auctions only.'
    0x4d:
      id: 'end_of_replay_sequence_message'
      doc: 'The End of replay Sequence message reflects the sequence number at the time replay of existing messages is complete.'
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
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Not Tradable'
  mpv:
    0x45:
      id: 'penny_everywhere'
      doc: 'Penny Everywhere'
    0x53:
      id: 'scaled'
      doc: 'Scaled'
    0x50:
      id: 'penny_pilot'
      doc: 'Penny Pilot'
  current_trading_state:
    0x42:
      id: 'buy_side_suspended'
      doc: 'Buy Side Suspended'
    0x53:
      id: 'sell_side_suspended'
      doc: 'Sell Side Suspended'
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x49:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 're_opening'
      doc: 'Re Opening'
    0x58:
      id: 'closed'
      doc: 'Closed'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x4d:
      id: 'buy_implied'
      doc: 'Buy Implied'
    0x4e:
      id: 'sell_implied'
      doc: 'Sell Implied'
  order_capacity:
    0x43:
      id: 'customer_order'
      doc: 'Customer Order'
    0x46:
      id: 'firm_order'
      doc: 'Firm Order'
    0x4d:
      id: 'market_maker_order'
      doc: 'Market Maker Order'
    0x42:
      id: 'broker_dealer_order'
      doc: 'Broker Dealer Order'
    0x50:
      id: 'professional_order'
      doc: 'Professional Order'
    0x4f:
      id: 'other_exchange_market_maker_order'
      doc: 'Other Exchange Market Maker Order'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office'
    0x20:
      id: 'na'
      doc: 'Na'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  change_reason:
    0x55:
      id: 'user'
      doc: 'User'
    0x52:
      id: 'reprice'
      doc: 'Reprice'
    0x53:
      id: 'suspend'
      doc: 'Suspend'
  cross_type:
    0x42:
      id: 'block_auction'
      doc: 'Block Auction'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 're_opening_auction'
      doc: 'Re Opening Auction'
    0x50:
      id: 'price_improvement_auction'
      doc: 'Price Improvement Auction'
    0x43:
      id: 'facilitation'
      doc: 'Facilitation'
    0x53:
      id: 'solicitation'
      doc: 'Solicitation'
    0x58:
      id: 'flex_auction'
      doc: 'Flex Auction'
    0x4e:
      id: 'none'
      doc: 'None'
    0x45:
      id: 'complex_exposure_auction'
      doc: 'Complex Exposure Auction'
  trade_type:
    0x45:
      id: 'electronic_trade'
      doc: 'Electronic Trade'
  auction_type:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x50:
      id: 'price_improvement_auction'
      doc: 'Price Improvement Auction'
    0x49:
      id: 'order_exposure'
      doc: 'Order Exposure'
    0x42:
      id: 'block_auction'
      doc: 'Block Auction'
  side_imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x6d:
      id: 'derivative_directory_message'
      doc: 'Derivative Directory Message for active options symbols.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x72:
      id: 'add_order_short_form_message'
      doc: 'An Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6f:
      id: 'add_order_long_form_message'
      doc: 'An Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6a:
      id: 'add_quote_short_form_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted and was added to the displayable book.'
    0x4a:
      id: 'add_quote_long_form_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted and was added to the displayable book.'
    0x65:
      id: 'single_side_executed_message'
      doc: 'This message is sent whenever a Side order is executed in whole or in part.'
    0x63:
      id: 'single_side_executed_with_price_message'
      doc: 'This message is sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_short_form_message'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced.'
    0x55:
      id: 'single_side_replace_long_form_message'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_update_message'
      doc: 'This message is sent whenever an order or a side of a quote is being updated for price and (or) contracts.'
    0x6b:
      id: 'quote_replace_short_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x4b:
      id: 'quote_replace_long_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x59:
      id: 'quote_delete_message'
      doc: 'The message is sent when a single quote is being cancelled.'
    0x71:
      id: 'trade_message'
      doc: 'This Options Trade Message is designed to provide execution details for normal match events involving non-displayable order types.'
    0x4f:
      id: 'net_order_imbalance_message'
      doc: 'This message is used to announce opening and re-opening auctions only.'

