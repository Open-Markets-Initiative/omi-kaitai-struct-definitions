# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions SpreadDepthOfMarket Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Phlx Options Spread Depth
#   Encoding: Itch
#   Version: 2.1
#   Date: 09/15/2025
#   Specification: Options_Spread_Feed_2.1.pdf
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
  id: nasdaq_iseoptions_spreaddepthofmarket_itch_v2_1_clienttcp
  title: Nasdaq IseOptions SpreadDepthOfMarket Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Phlx Options Spread Depth Itch v2.1'
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
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Strategy Directory Message containing the strategy definition will be sent whenever a complex order is added in the system.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x72:
      id: 'add_order_short_form_message'
      doc: 'A Complex Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6f:
      id: 'add_order_long_form_message'
      doc: 'A Complex Add Order Message indicates that a new order has been accepted and was added to the displayable book. Long form.'
    0x74:
      id: 'single_side_executed_message'
      doc: 'This message is sent whenever a Side order is executed in whole or in part.'
    0x54:
      id: 'single_side_executed_with_price_message'
      doc: 'This message is sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price.'
    0x69:
      id: 'single_side_replace_short_form_message'
      doc: 'This message is sent whenever an order on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number.'
    0x49:
      id: 'single_side_replace_long_form_message'
      doc: 'This message is sent whenever an order on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. Long form.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x50:
      id: 'single_side_update_message'
      doc: 'This message is sent whenever an order is being updated for price and (or) contracts. The reference number associated with the order is unchanged.'
    0x71:
      id: 'complex_strategy_trade_message'
      doc: 'This Options Trade Message is designed to provide execution details for normal match events involving non-display able order types.'
    0x61:
      id: 'complex_strategy_auction_message'
      doc: 'This message is used to announce strategy auctions. The start of auction is announced, followed by possible updates on the auction, and announcing the end of the auction.'
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
  strategy_type:
    0x56:
      id: 'vertical_spread'
      doc: 'Vertical Spread'
    0x54:
      id: 'time_spread'
      doc: 'Time Spread'
    0x44:
      id: 'diagonal_spread'
      doc: 'Diagonal Spread'
    0x53:
      id: 'straddle'
      doc: 'Straddle'
    0x47:
      id: 'strangle'
      doc: 'Strangle'
    0x43:
      id: 'combo'
      doc: 'Combo'
    0x52:
      id: 'risk_reversal'
      doc: 'Risk Reversal'
    0x41:
      id: 'ratio_spread'
      doc: 'Ratio Spread'
    0x42:
      id: 'box_spread'
      doc: 'Box Spread'
    0x46:
      id: 'butterfly_spread'
      doc: 'Butterfly Spread'
    0x55:
      id: 'custom'
      doc: 'Custom'
  option_type:
    0x43:
      id: 'call_option'
      doc: 'Call Option'
    0x50:
      id: 'put_option'
      doc: 'Put Option'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  current_trading_state:
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
  depth_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x4f:
      id: 'buy_market'
      doc: 'Buy Market'
    0x50:
      id: 'sell_market'
      doc: 'Sell Market'
  depth_order_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'nasdaq_registered_market_maker'
      doc: 'Nasdaq Registered Market Maker'
    0x42:
      id: 'broker_dealer_order'
      doc: 'Broker Dealer Order'
    0x50:
      id: 'professional_order'
      doc: 'Professional Order'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker'
    0x4a:
      id: 'jbo_joint_back_office_only_phlx'
      doc: 'Jbo Joint Back Office Only Phlx'
  scope:
    0x4c:
      id: 'local'
      doc: 'Local'
    0x4e:
      id: 'national'
      doc: 'National'
  order_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4c:
      id: 'limit'
      doc: 'Limit'
  change_reason:
    0x55:
      id: 'user'
      doc: 'User'
  cross_type:
    0x45:
      id: 'complex_exposure_auction'
      doc: 'Complex Exposure Auction'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 'reopening_auction'
      doc: 'Reopening Auction'
    0x50:
      id: 'price_improvement_pim_auction'
      doc: 'Price Improvement Pim Auction'
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
  trade_type:
    0x45:
      id: 'electronic_trade'
      doc: 'Electronic Trade'
  auction_type:
    0x45:
      id: 'complex_exposure'
      doc: 'Complex Exposure'
    0x50:
      id: 'price_improvement_pim_auction'
      doc: 'Price Improvement Pim Auction'
    0x43:
      id: 'facilitation'
      doc: 'Facilitation'
    0x53:
      id: 'solicitation'
      doc: 'Solicitation'
    0x58:
      id: 'flex_auction'
      doc: 'Flex Auction'
  auction_event:
    0x53:
      id: 'start'
      doc: 'Start'
    0x55:
      id: 'auction_update'
      doc: 'Auction Update'
    0x45:
      id: 'end_of_auction'
      doc: 'End Of Auction'
  exec_flag:
    0x4e:
      id: 'none'
      doc: 'None'
    0x41:
      id: 'aon'
      doc: 'Aon'
  order_capacity:
    0x43:
      id: 'customer_order'
      doc: 'Customer Order'
    0x46:
      id: 'firm_order'
      doc: 'Firm Order'
    0x4d:
      id: 'nasdaq_registered_market_maker'
      doc: 'Nasdaq Registered Market Maker'
    0x42:
      id: 'broker_dealer_oder'
      doc: 'Broker Dealer Oder'
    0x50:
      id: 'professional_order'
      doc: 'Professional Order'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker'
    0x4a:
      id: 'jbo_joint_back_office_only_phlx'
      doc: 'Jbo Joint Back Office Only Phlx'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Strategy Directory Message containing the strategy definition will be sent whenever a complex order is added in the system.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x72:
      id: 'add_order_short_form_message'
      doc: 'A Complex Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6f:
      id: 'add_order_long_form_message'
      doc: 'A Complex Add Order Message indicates that a new order has been accepted and was added to the displayable book. Long form.'
    0x74:
      id: 'single_side_executed_message'
      doc: 'This message is sent whenever a Side order is executed in whole or in part.'
    0x54:
      id: 'single_side_executed_with_price_message'
      doc: 'This message is sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price.'
    0x69:
      id: 'single_side_replace_short_form_message'
      doc: 'This message is sent whenever an order on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number.'
    0x49:
      id: 'single_side_replace_long_form_message'
      doc: 'This message is sent whenever an order on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. Long form.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x50:
      id: 'single_side_update_message'
      doc: 'This message is sent whenever an order is being updated for price and (or) contracts. The reference number associated with the order is unchanged.'
    0x71:
      id: 'complex_strategy_trade_message'
      doc: 'This Options Trade Message is designed to provide execution details for normal match events involving non-display able order types.'
    0x61:
      id: 'complex_strategy_auction_message'
      doc: 'This message is used to announce strategy auctions. The start of auction is announced, followed by possible updates on the auction, and announcing the end of the auction.'

