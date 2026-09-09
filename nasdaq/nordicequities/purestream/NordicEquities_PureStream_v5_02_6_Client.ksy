# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicEquities PureStream Ouch v5.02.6
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nordic Ouch 5 PureStream
#   Encoding: Ouch
#   Version: 5.02.6
#   Date: 11/12/2025
#   Specification: Nasdaq Nordic INET OUCH5 PureStream (5.02.6).pdf
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
  id: nasdaq_nordicequities_purestream_ouch_v5_02_6_client
  title: Nasdaq NordicEquities PureStream Ouch v5.02.6
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Equities Nordic Ouch 5 PureStream Ouch v5.02.6'
doc-ref: https://www.nasdaq.com/solutions/technical-information-inet-nordic-trading-platform

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
        type: u1
        enum: unsequenced_message_type
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::enter_order_message': enter_order_message
            'unsequenced_message_type::replace_order_message': replace_order_message
            'unsequenced_message_type::cancel_order_message': cancel_order_message
            'unsequenced_message_type::mmi_notification_request_message': mmi_notification_request_message
  enter_order_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'Sequence number, unique and strictly increasing for the day'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being entered'
      - id: quantity
        type: u4
        doc: 'Total quantity entered'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: price
        type: decimal_u4_4
        doc: 'The limit price of the order. Implied decimal with scale 1e-4'
      - id: user
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of responsible trader'
      - id: execution_within_firm
        type: u4
        doc: 'Short code for the execution decision maker'
      - id: investment_decision_within_firm_short_code
        type: u4
        doc: 'Short code for the investment decision maker'
      - id: client_identifier
        type: u4
        doc: 'Short code representing the client behind the order'
      - id: party_role_qualifier
        type: party_role_qualifier
        doc: 'Packed qualifier bits'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Trading capacity of the order'
      - id: algo_indicator
        type: u1
        enum: algo_indicator
        doc: 'Whether the order resulted from algorithmic trading'
      - id: appendage_length
        type: u2
        doc: 'Remaining length of the TagValue element'
      - id: tagvalue
        type: tagvalue
        repeat: eos
        doc: 'Additional appendage tag value'
  party_role_qualifier:
    seq:
      - id: client_identification
        type: b2
      - id: investment_decision_within_firm
        type: b2
      - id: execution_decision_within_firm
        type: b2
      - id: reserved_78
        type: b2
  tagvalue:
    seq:
      - id: length
        type: u1
        doc: 'Remaining length of this tag value element, the tag plus its value'
      - id: tag
        type: u1
        doc: 'Identifies the appendage carried by this element'
      - id: value_payload
        size: length + 1 - 2
        type:
          switch-on: tag
          cases:
            1: clearing_account
            2: clearing_account_type
            3: clearing_firm
            4: client_reference
            5: cross_type
            6: dea_indicator
            7: display
            8: display_price
            9: display_quantity
            10: expire_time
            11: firm
            12: liquidity_provision_indicator
            13: max_floor
            14: minimum_quantity
            15: order_reference
            16: original_order_entry_date
            17: original_order_reference_number
            18: peg_difference
            19: peg_type
            20: random_reserve
            21: secondary_order_reference_number
            22: stp_action
            23: stp_level
            24: stp_trader_group
            25: time_in_force
            26: trading_at_closing_price
            27: order_condition
            28: cumulative_quantity
            29: customer_order_capacity
            30: target_strategy
            31: min_rate
            32: max_rate
            33: conditional_type
            34: firm_up_id
  clearing_account:
    seq:
      - id: clearing_account_value
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Supplemental accounting information forwarded to the Ccp'
  clearing_account_type:
    seq:
      - id: clearing_account_type_value
        type: u1
        enum: clearing_account_type_value
        doc: 'Account type used for the order when submitted to clearing'
  clearing_firm:
    seq:
      - id: clearing_firm_value
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'User supplied clearing firm, pass through field'
  client_reference:
    seq:
      - id: client_reference_value
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'User supplied client reference, returned unchanged'
  cross_type:
    seq:
      - id: cross_type_value
        type: u1
        enum: cross_type_value
        doc: 'The cross the order is intended for'
  dea_indicator:
    seq:
      - id: dea_indicator_value
        type: u1
        enum: dea_indicator_value
        doc: 'Origin of the order for direct electronic access reporting'
  display:
    seq:
      - id: display_value
        type: u1
        enum: display_value
        doc: 'How the order is displayed'
  display_price:
    seq:
      - id: display_price_value
        type: decimal_u4_4
        doc: 'Price of restated child order. Implied decimal with scale 1e-4'
  display_quantity:
    seq:
      - id: display_quantity_value
        type: u4
        doc: 'Quantity of restated child order'
  expire_time:
    seq:
      - id: expire_time_value
        type: u2
        doc: 'Seconds the order should live before being cancelled'
  firm:
    seq:
      - id: firm_value
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The accepted firm for the order'
  liquidity_provision_indicator:
    seq:
      - id: liquidity_provision_indicator_value
        type: u1
        enum: liquidity_provision_indicator_value
        doc: 'Whether the order relates to liquidity provision activity'
  max_floor:
    seq:
      - id: max_floor_value
        type: u4
        doc: 'Displayed quantity for an iceberg order'
  minimum_quantity:
    seq:
      - id: minimum_quantity_value
        type: u4
        doc: 'Minimum quantity that could be traded'
  order_reference:
    seq:
      - id: order_reference_value
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'User supplied order reference, returned unchanged'
  original_order_entry_date:
    seq:
      - id: original_order_entry_date_value
        type: yyyymmdd_date
        doc: 'Original order entry date for a good till cancel order'
  original_order_reference_number:
    seq:
      - id: original_order_reference_number_value
        type: u8
        doc: 'Original order reference number for a good till cancel order'
  peg_difference:
    seq:
      - id: peg_difference_value
        type: s4
        doc: 'Ticks to offset the price from the peg target'
  peg_type:
    seq:
      - id: peg_type_value
        type: u1
        enum: peg_type_value
        doc: 'The peg target, valid for any peggable order'
  random_reserve:
    seq:
      - id: random_reserve_value
        type: u4
        doc: 'Range the display size is randomized by on refresh'
  secondary_order_reference_number:
    seq:
      - id: secondary_order_reference_number_value
        type: u8
        doc: 'Alternative order reference used on the market data feeds'
  stp_action:
    seq:
      - id: stp_action_value
        type: u1
        enum: stp_action_value
        doc: 'Action taken when self trade prevention triggers'
  stp_level:
    seq:
      - id: stp_level_value
        type: u1
        enum: stp_level_value
        doc: 'Scope of self trade prevention for the order'
  stp_trader_group:
    seq:
      - id: stp_trader_group_value
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client defined trader group for self trade prevention'
  time_in_force:
    seq:
      - id: time_in_force_value
        type: u1
        enum: time_in_force_value
        doc: 'How long the order remains live'
  trading_at_closing_price:
    seq:
      - id: trading_at_closing_price_value
        type: u1
        enum: trading_at_closing_price_value
        doc: 'Whether the order participates in trading at closing price'
  order_condition:
    seq:
      - id: order_condition_value
        type: u1
        enum: order_condition_value
        doc: 'Condition changing the behaviour of the order'
  cumulative_quantity:
    seq:
      - id: cumulative_quantity_value
        type: u4
        doc: 'Previously executed quantity of the good till cancel order'
  customer_order_capacity:
    seq:
      - id: customer_order_capacity_value
        type: u1
        enum: customer_order_capacity_value
        doc: 'Whether the order originates from a retail customer'
  target_strategy:
    seq:
      - id: target_strategy_value
        type: u1
        enum: target_strategy_value
        doc: 'The target strategy of the PureStream order'
  min_rate:
    seq:
      - id: min_rate_value
        type: u2
        doc: 'PureStream minimum rate in the 1-500% range'
  max_rate:
    seq:
      - id: max_rate_value
        type: u2
        doc: 'PureStream maximum rate in the 1-500% range'
  conditional_type:
    seq:
      - id: conditional_type_value
        type: u1
        enum: conditional_type_value
        doc: 'PureStream order type'
  firm_up_id:
    seq:
      - id: firm_up_id_value
        type: u4
        doc: 'UserRefNum of the Ioi that received a firm up request'
  replace_order_message:
    seq:
      - id: orig_user_ref_num
        type: u4
        doc: 'Sequence number of the order being replaced'
      - id: new_user_ref_num
        type: u4
        doc: 'New sequence number for the replacement'
      - id: quantity
        type: u4
        doc: 'Total quantity entered'
      - id: price
        type: decimal_u4_4
        doc: 'The limit price of the order. Implied decimal with scale 1e-4'
      - id: user
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of responsible trader'
      - id: appendage_length
        type: u2
        doc: 'Remaining length of the TagValue element'
      - id: tagvalue
        type: tagvalue
        repeat: eos
        doc: 'Additional appendage tag value'
  cancel_order_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'Sequence number, unique and strictly increasing for the day'
      - id: quantity
        type: u4
        doc: 'Total quantity entered'
      - id: user
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of responsible trader'
  mmi_notification_request_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'Sequence number, unique and strictly increasing for the day'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: instruction
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Notification reason'
      - id: add_or_remove
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the instruction is added or removed'
      - id: firm
        type: firm
        doc: 'Firm'
      - id: user
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of responsible trader'
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100

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
    0x4f:
      id: 'enter_order_message'
      doc: 'Enters a new order into Nasdaq Nordic'
    0x55:
      id: 'replace_order_message'
      doc: 'Alters attributes of a live order in a single message'
    0x58:
      id: 'cancel_order_message'
      doc: 'Requests that an order be cancelled or reduced'
    0x51:
      id: 'account_query_message'
      doc: 'Requests the next available UserRefNum when recovering state'
    0x4d:
      id: 'mmi_notification_request_message'
      doc: 'Requests a market making instruction notification'
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  client_identification:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'lei_firm'
      doc: 'Lei Firm'
    3:
      id: 'natural_person'
      doc: 'Natural Person'
  investment_decision_within_firm:
    0:
      id: 'none'
      doc: 'None'
    2:
      id: 'algo'
      doc: 'Algo'
    3:
      id: 'natural_person'
      doc: 'Natural Person'
  execution_decision_within_firm:
    0:
      id: 'none'
      doc: 'None'
    2:
      id: 'algo'
      doc: 'Algo'
    3:
      id: 'natural_person'
      doc: 'Natural Person'
  capacity:
    0x31:
      id: 'client'
      doc: 'Client'
    0x32:
      id: 'own_account'
      doc: 'Own Account'
    0x33:
      id: 'market_maker'
      doc: 'Market Maker'
    0x34:
      id: 'issuer_holding'
      doc: 'Issuer Holding'
    0x36:
      id: 'issue_price_stabilizing'
      doc: 'Issue Price Stabilizing'
    0x37:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
    0x38:
      id: 'issuer_holding_deal'
      doc: 'Issuer Holding Deal'
    0x39:
      id: 'issue_price_stabilizing_deal'
      doc: 'Issue Price Stabilizing Deal'
  algo_indicator:
    0x2d:
      id: 'no_algo'
      doc: 'No Algo'
    0x48:
      id: 'algo'
      doc: 'Algo'
  clearing_account_type_value:
    0x31:
      id: 'customer_client'
      doc: 'Customer Client'
    0x32:
      id: 'firm_house'
      doc: 'Firm House'
  cross_type_value:
    0x43:
      id: 'closing_cross'
      doc: 'Closing Cross'
    0x4f:
      id: 'opening_cross'
      doc: 'Opening Cross'
    0x49:
      id: 'scheduled_intraday_cross'
      doc: 'Scheduled Intraday Cross'
    0x48:
      id: 'halt_cross'
      doc: 'Halt Cross'
    0x41:
      id: 'auction_on_demand'
      doc: 'Auction On Demand'
  dea_indicator_value:
    0x31:
      id: 'order_received_from_a_customer'
      doc: 'Order Received From A Customer'
    0x32:
      id: 'order_received_from_within_the_firm'
      doc: 'Order Received From Within The Firm'
    0x33:
      id: 'order_received_from_another_broker_dealer'
      doc: 'Order Received From Another Broker Dealer'
    0x34:
      id: 'order_received_from_a_customer_or_originated_with_the_firm'
      doc: 'Order Received From A Customer Or Originated With The Firm'
    0x35:
      id: 'order_received_from_a_direct_access_or_sponsored_access_customer'
      doc: 'Order Received From A Direct Access Or Sponsored Access Customer'
  display_value:
    0x59:
      id: 'display'
      doc: 'Display'
    0x4e:
      id: 'non_display'
      doc: 'Non Display'
    0x41:
      id: 'auction_on_demand'
      doc: 'Auction On Demand'
    0x4d:
      id: 'nordic_mid'
      doc: 'Nordic Mid'
    0x53:
      id: 'pure_stream'
      doc: 'Pure Stream'
  liquidity_provision_indicator_value:
    0x4e:
      id: 'no_liquidity_provision'
      doc: 'No Liquidity Provision'
    0x59:
      id: 'liquidity_provision'
      doc: 'Liquidity Provision'
  peg_type_value:
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint'
    0x50:
      id: 'market'
      doc: 'Market'
    0x52:
      id: 'primary'
      doc: 'Primary'
  stp_action_value:
    0x31:
      id: 'cancel_passive_order'
      doc: 'Cancel Passive Order'
    0x32:
      id: 'cancel_aggressive_order'
      doc: 'Cancel Aggressive Order'
    0x33:
      id: 'cancel_both_orders'
      doc: 'Cancel Both Orders'
    0x34:
      id: 'create_a_transfer_transaction'
      doc: 'Create A Transfer Transaction'
  stp_level_value:
    0x31:
      id: 'mpid_and_trader'
      doc: 'Mpid And Trader'
    0x32:
      id: 'mpid'
      doc: 'Mpid'
    0x33:
      id: 'specified_trader_group'
      doc: 'Specified Trader Group'
  time_in_force_value:
    0x30:
      id: 'day'
      doc: 'Day'
    0x31:
      id: 'gtc_good_till_cancelled'
      doc: 'Gtc Good Till Cancelled'
    0x33:
      id: 'ioc_immediate_or_cancel'
      doc: 'Ioc Immediate Or Cancel'
    0x36:
      id: 'gtt_good_till_time'
      doc: 'Gtt Good Till Time'
    0x42:
      id: 'gfa_good_for_auction'
      doc: 'Gfa Good For Auction'
  trading_at_closing_price_value:
    0x59:
      id: 'participate_in_trading_at_closing_price'
      doc: 'Participate In Trading At Closing Price'
    0x4e:
      id: 'do_not_participate_in_trading_at_closing_price'
      doc: 'Do Not Participate In Trading At Closing Price'
  order_condition_value:
    0x57:
      id: 'market_maker_order'
      doc: 'Market Maker Order'
    0x55:
      id: 'market_maker_order_refresh'
      doc: 'Market Maker Order Refresh'
    0x50:
      id: 'topof_book'
      doc: 'Topof Book'
    0x51:
      id: 'darklit_sweep'
      doc: 'Darklit Sweep'
    0x54:
      id: 'trade_now'
      doc: 'Trade Now'
  customer_order_capacity_value:
    0x35:
      id: 'retail_customer'
      doc: 'Retail Customer'
  target_strategy_value:
    0x30:
      id: 'rate_5_to_15_percent'
      doc: 'Rate 5 To 15 Percent'
    0x31:
      id: 'rate_5_to_30_percent'
      doc: 'Rate 5 To 30 Percent'
    0x35:
      id: 'rate_10_to_200_percent'
      doc: 'Rate 10 To 200 Percent'
    0x43:
      id: 'custom'
      doc: 'Custom'
  conditional_type_value:
    0x43:
      id: 'conditional_order'
      doc: 'Conditional Order'
    0x46:
      id: 'firm_up_order'
      doc: 'Firm Up Order'
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
      doc: 'Signals an event affecting the entire Nasdaq Nordic system'
    0x41:
      id: 'order_accepted_message'
      doc: 'Acknowledges receipt and acceptance of a valid Enter Order'
    0x55:
      id: 'order_replaced_message'
      doc: 'Confirms that an order has been replaced'
    0x43:
      id: 'cancelled_order_message'
      doc: 'An order has been reduced or cancelled'
    0x50:
      id: 'cancel_pending_message'
      doc: 'A cancel request cannot be applied immediately'
    0x4e:
      id: 'replace_pending_message'
      doc: 'A replace request cannot be applied immediately'
    0x45:
      id: 'executed_order_message'
      doc: 'An order has been executed in whole or in part'
    0x42:
      id: 'broken_trade_message'
      doc: 'An execution has been broken and cannot be reinstated'
    0x4a:
      id: 'rejected_order_message'
      doc: 'An order has been rejected'
    0x49:
      id: 'cancel_rejected_message'
      doc: 'A cancel request has been rejected'
    0x54:
      id: 'order_restated_message'
      doc: 'An order has been restated by the system'
    0x57:
      id: 'mmo_refresh_request_message'
      doc: 'Requests a market maker order refresh'
    0x51:
      id: 'account_query_response_message'
      doc: 'Indicates the next available UserRefNum'
    0x47:
      id: 'gtc_cancelled_message'
      doc: 'A Gtc order could not be restated in the morning'
    0x52:
      id: 'response_to_mmi_notification_message'
      doc: 'Response to a market making instruction notification'
    0x4d:
      id: 'pending_order_message'
      doc: 'An order is pending while the system processes it'
    0x44:
      id: 'stream_status_message'
      doc: 'Sent whenever an indication of interest changes its streaming'
  event_code:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day'
  cancel_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'User Requested Cancel'
    0x49:
      id: 'immediate_or_cancel_order'
      doc: 'Immediate Or Cancel Order'
    0x54:
      id: 'timeout'
      doc: 'Timeout'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory'
    0x51:
      id: 'self_match_prevention'
      doc: 'Self Match Prevention'
    0x4c:
      id: 'hidden_peg_not_lis'
      doc: 'Hidden Peg Not Lis'
    0x4e:
      id: 'bad_quote'
      doc: 'Bad Quote'
    0x52:
      id: 'state_management'
      doc: 'State Management'
  cancel_pending_reason:
    0x41:
      id: 'cancel_pending_completion_of_auction_on_demand'
      doc: 'Cancel Pending Completion Of Auction On Demand'
  trading_mode:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x49:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    0x55:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At Market Close Trading'
    0x50:
      id: 'on_demand_auction'
      doc: 'On Demand Auction'
  transaction_category:
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
    0x2d:
      id: 'none_apply'
      doc: 'None Apply'
  transaction_type_algo_indicator:
    0x48:
      id: 'algorithmic_trade'
      doc: 'Algorithmic Trade'
    0x2d:
      id: 'no_algorithmic_trade'
      doc: 'No Algorithmic Trade'
  liquidity_indicator:
    0:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    1:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    2:
      id: 'auction_liquidity'
      doc: 'Auction Liquidity'
    3:
      id: 'reserved'
      doc: 'Reserved'
  liquidity_internalized:
    0:
      id: 'not_internalized'
      doc: 'Not Internalized'
    1:
      id: 'internalized'
      doc: 'Internalized'
  liquidity_top_of_book:
    0:
      id: 'not_top_of_book'
      doc: 'Not Top Of Book'
    1:
      id: 'top_of_book'
      doc: 'Top Of Book'
  liquidity_self_trade:
    0:
      id: 'non_self_trade'
      doc: 'Non Self Trade'
    1:
      id: 'self_trade'
      doc: 'Self Trade'
  broken_trade_reason:
    0x45:
      id: 'erroneous'
      doc: 'Erroneous'
    0x43:
      id: 'consent'
      doc: 'Consent'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory'
  restate_reason:
    0x52:
      id: 'refresh_of_display'
      doc: 'Refresh Of Display'
    0x50:
      id: 'update_of_displayed_price'
      doc: 'Update Of Displayed Price'
  pending_order_reason:
    0x53:
      id: 'system_processing'
      doc: 'System Processing'
  status:
    0x4f:
      id: 'stream_on'
      doc: 'Stream On'
    0x58:
      id: 'stream_off'
      doc: 'Stream Off'

