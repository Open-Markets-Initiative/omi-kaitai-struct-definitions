# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax PearlOptions ExpressOrders Meo v2.0
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Express Orders
#   Encoding: Miax Express Orders
#   Version: 2.0
#   Date: 10/29/2019
#   Specification: MIAX_Express_Orders_MEO_v2.0.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: miax_pearloptions_expressorders_meo_v2_0
  title: Miax PearlOptions ExpressOrders Meo v2.0
  license: MIT-0
  endian: le

doc: 'Miami International Holdings MIAX Pearl Options Express Orders Meo v2.0'
doc-ref: https://www.miaxglobal.com/markets/us-options/pearl-options/interface-specifications

seq:
  - id: sesm_tcp_packet
    type: sesm_tcp_packet_struct
    repeat: eos
    doc: 'SesM Tcp Packet'

types:
  sesm_tcp_packet_struct:
    seq:
      - id: sesm_packet_header
        type: sesm_packet_header
        doc: 'SesM packet header'
      - id: sesm_payload
        size: sesm_packet_header.sesm_packet_length + 2 - 3
        type:
          switch-on: sesm_packet_header.sesm_packet_type
          cases:
            'sesm_packet_type::sequenced_data_packet': sequenced_data_packet
            'sesm_packet_type::unsequenced_data_packet': unsequenced_data_packet
            'sesm_packet_type::login_request': login_request
            'sesm_packet_type::login_response': login_response
            'sesm_packet_type::retransmission_request': retransmission_request
            'sesm_packet_type::logout_request': logout_request
            'sesm_packet_type::goodbye_packet': goodbye_packet
            'sesm_packet_type::test_packet': test_packet
  sesm_packet_header:
    seq:
      - id: sesm_packet_length
        type: u2
        doc: 'The length of rest of the packet'
      - id: sesm_packet_type
        type: u1
        enum: sesm_packet_type
        doc: 'SesM protocol packet type'
  sequenced_data_packet:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Sequence number of this sequenced data packet'
      - id: sequenced_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Message type of the application message the sequenced data packet carries'
      - id: sequenced_message
        size: _parent.sesm_packet_header.sesm_packet_length - 1 - 10
        type:
          switch-on: sequenced_message_type
          cases:
            '"SU"': series_update
            '"SN"': system_state_notification
            '"UN"': underlying_trading_status_notification
            '"QN"': opening_width_relief_notification
            '"AN"': arm_protection_settings_notification
            '"A2"': arm_2_underlying_level_protection_settings_notification
            '"QX"': single_side_liquidity_protection_trigger_notification
            '"UP"': arm_2_underlying_level_protection_notification
            '"FP"': arm_2_firm_level_protection_notification
            '"XN"': cancel_notification
            '"EN"': execution_notification
  series_update:
    seq:
      - id: product_add_update_time
        type: nanosecond_timestamp
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option Security Symbol'
      - id: expiration_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expiration date of the option in YYYYMMDD format'
      - id: strike_price
        type: decimal_u4_4
        doc: 'Explicit strike price of the option. Implied decimal with scale 1e-4'
      - id: call_or_put
        type: u1
        enum: call_or_put
        doc: 'Option Type'
      - id: opening_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. Eg: 09:30:00'
      - id: closing_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. Eg: 16:15:00'
      - id: restricted_option
        type: u1
        enum: restricted_option
        doc: 'Restricted option'
      - id: long_term_option
        type: u1
        enum: long_term_option
        doc: 'Long term option'
      - id: active_on_pearl
        type: u1
        enum: active_on_pearl
        doc: 'Indicates if this symbol is tradable on PEARL in the current session'
      - id: pearl_bbo_posting_increment_indicator
        type: u1
        enum: pearl_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by PEARL'
      - id: order_acceptance_increment_indicator
        type: u1
        enum: order_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Order acceptance as per PEARL rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
  system_state_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: meo_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: MEOX.X (where X.X is MEO version)'
      - id: session_id
        type: u1
        doc: 'PEARL assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status'
  underlying_trading_status_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status'
      - id: event_reason
        type: u1
        enum: event_reason
        doc: 'Event reason'
      - id: expected_event_time
        type: nanosecond_timestamp
        doc: 'Expected time of start of the event. When underlying trading status is H, this will be 0 (zero). When underlying trading status is R or O, this will be the time at which the opening/reopening process will start for this Underlying Symbol. Nanoseconds since Midnight epoch'
  opening_width_relief_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: relief_multiplier
        type: decimal_u4_4
        doc: 'Relief is the multiplier times the regular acceptable Exchange Opening width (Opening BBO width). Implied decimal with scale 1e-4'
  arm_protection_settings_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: allowable_engagement_percentage
        type: u4
        doc: 'Percentage of order size at which the Member wants PEARL to trigger ARM protection for this underlying. Minimum value is 1 (1%). Maximum is 65,535 (65,535%)'
      - id: counting_period
        type: u2
        doc: 'Duration (in number of milliseconds) in which Engagement percentage is calculated in order to determine if the MPID should be put on ARM protection for this underlying. Allowable Range: 100 to 15,000 milliseconds'
      - id: action
        type: u1
        enum: action
        doc: 'Action'
      - id: source
        type: u1
        enum: source
        doc: 'Source'
  arm_2_underlying_level_protection_settings_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: action
        type: u1
        enum: action
        doc: 'Action'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: arm_threshold_count
        type: u4
        doc: 'Number of unique ARM triggers for the Counting Period that will trigger ARM2 Firm Level protection'
      - id: arm_2_counting_period
        type: u4
        doc: 'Counting Period in milliseconds in which the number of unique ARM triggers cannot exceed the configured ARM Threshold Count specified for ARM2 protection'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  single_side_liquidity_protection_trigger_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: side
        type: u1
        enum: side
        doc: 'The side of Product ID to reset'
      - id: triggering_client_message_id
        type: u4
        doc: 'Client Message ID supplied by the firm in the Bulk order message that triggered the Single Side Liquidity Protection'
      - id: triggering_bulk_order_index
        type: u1
        doc: 'Bulk Order Index assigned by PEARL to each Order in Bulk Liquidity (order position in the Bulk liquidity) that triggered Single Side Liquidity Protection'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
  arm_2_underlying_level_protection_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: notification_type
        type: u1
        enum: notification_type
        doc: 'Notification type'
      - id: arm_threshold_count
        type: u4
        doc: 'Number of unique ARM triggers for the Counting Period that will trigger ARM2 Firm Level protection'
      - id: arm_2_counting_period
        type: u4
        doc: 'Counting Period in milliseconds in which the number of unique ARM triggers cannot exceed the configured ARM Threshold Count specified for ARM2 protection'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  arm_2_firm_level_protection_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: arm_threshold_count
        type: u4
        doc: 'Number of unique ARM triggers for the Counting Period that will trigger ARM2 Firm Level protection'
      - id: arm_2_counting_period
        type: u4
        doc: 'Counting Period in milliseconds in which the number of unique ARM triggers cannot exceed the configured ARM Threshold Count specified for ARM2 protection'
      - id: notification_type
        type: u1
        enum: notification_type
        doc: 'Notification type'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  cancel_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: client_order_id
        type: u4
        doc: 'Client order ID'
      - id: bulk_order_index
        type: u1
        doc: 'Bulk Liquidity Index assigned by PEARL to each Order in bulk Liquidity (order position in the bulk liquidity)'
      - id: side
        type: u1
        enum: side
        doc: 'The side of Product ID to reset'
      - id: size
        type: u4
        doc: 'Number of contracts'
      - id: engine_sequence_number
        type: u8
        doc: 'PEARL Engine sequence number of this cancel'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Cancel reason'
  execution_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: client_order_id
        type: u4
        doc: 'Client order ID'
      - id: bulk_order_index
        type: u1
        doc: 'Bulk Liquidity Index assigned by PEARL to each Order in bulk Liquidity (order position in the bulk liquidity)'
      - id: trade_id
        type: u4
        doc: 'PEARL Trade ID'
      - id: execution_id
        type: u8
        doc: 'PEARL execution ID'
      - id: trade_status
        type: u1
        enum: trade_status
        doc: 'Trade status'
      - id: last_price
        type: decimal_u4_4
        doc: 'Price of this execution. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'The side of Product ID to reset'
      - id: last_size
        type: u4
        doc: 'Number of contracts executed (not cumulative)'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Order Traded as specified in this billing field'
      - id: reserved_15
        size: 15
        doc: 'Reserved for future use'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Message type of the application message the unsequenced data packet carries'
      - id: unsequenced_message
        size: _parent.sesm_packet_header.sesm_packet_length - 1 - 2
        type:
          switch-on: unsequenced_message_type
          cases:
            '"AS"': arm_settings_update_request
            '"AA"': arm_settings_update_response
            '"2S"': arm_2_underlying_level_protection_settings_update_request
            '"2R"': arm_2_underlying_level_protection_settings_update_response
            '"SA"': series_assignment_request
            '"AR"': series_assignment_response
            '"SP"': self_trade_protection_designation_request
            '"SR"': self_trade_protection_designation_response
            '"lm"': bulk_liquidity_message
            '"LR"': bulk_liquidity_message_response
            '"xq"': liquidity_mass_cancel_request
            '"XR"': liquidity_mass_cancel_response
            '"PX"': liquidity_protection_reset_request
            '"PR"': liquidity_protection_reset_response
            '"SS"': single_side_liquidity_protection_reset_request
            '"ST"': single_side_liquidity_protection_reset_response
            '"QP"': liquidity_protection_trigger_notification
            '"ON"': order_notification
            '"DD"': done_for_the_day_notification
            '"XN"': cancel_notification
  arm_settings_update_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: action
        type: u1
        enum: action
        doc: 'Action'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: allowable_engagement_percentage
        type: u4
        doc: 'Percentage of order size at which the Member wants PEARL to trigger ARM protection for this underlying. Minimum value is 1 (1%). Maximum is 65,535 (65,535%)'
      - id: counting_period
        type: u2
        doc: 'Duration (in number of milliseconds) in which Engagement percentage is calculated in order to determine if the MPID should be put on ARM protection for this underlying. Allowable Range: 100 to 15,000 milliseconds'
  arm_settings_update_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: arm_settings_update_status
        type: u1
        enum: arm_settings_update_status
        doc: 'ARM settings update status'
  arm_2_underlying_level_protection_settings_update_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: action
        type: u1
        enum: action
        doc: 'Action'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: arm_threshold_count
        type: u4
        doc: 'Number of unique ARM triggers for the Counting Period that will trigger ARM2 Firm Level protection'
      - id: arm_2_counting_period
        type: u4
        doc: 'Counting Period in milliseconds in which the number of unique ARM triggers cannot exceed the configured ARM Threshold Count specified for ARM2 protection'
  arm_2_underlying_level_protection_settings_update_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: arm_2_settings_update_status
        type: u1
        enum: arm_2_settings_update_status
        doc: 'ARM2 settings update status'
  series_assignment_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: action
        type: u1
        enum: action
        doc: 'Action'
  series_assignment_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: assignment_settings_status
        type: u1
        enum: assignment_settings_status
        doc: 'Assignment settings status'
  self_trade_protection_designation_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: action
        type: u1
        enum: action
        doc: 'Action'
  self_trade_protection_designation_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: self_trade_protection_status
        type: u1
        enum: self_trade_protection_status
        doc: 'Self-trade protection status'
  bulk_liquidity_message:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm''s send time for the Liquidities. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: num_liquidity_units
        type: u1
        doc: 'Number of Orders, Cancels, Replaces in this bulk message'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: liquidity_units
        type: liquidity_units
        repeat: expr
        repeat-expr: num_liquidity_units
        doc: '1 to 25 single-side Order, cancel or replace'
  liquidity_units:
    seq:
      - id: liquidity_unit
        size: 57
        doc: 'Can contain 1 AutoReplace Order, Standard Order, Standard Order Cancel or Standard Order Replace in each unit. Number of units should match the count specified in the count field'
  bulk_liquidity_message_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: bulk_order_status
        type: u1
        enum: bulk_order_status
        doc: 'Bulk order status'
      - id: order_count
        type: u1
        doc: 'Number of orders that were submitted in the Bulk liquidity block'
      - id: num_order_response
        type: u1
        doc: 'Number of orders that were rejected (orders with status other than space)'
      - id: order_ack_time
        type: nanosecond_timestamp
        doc: 'Time at which PEARL engine generated this response. Nanoseconds since Midnight epoch'
      - id: order_response
        type: order_response
        repeat: expr
        repeat-expr: num_order_response
        doc: '1 to N single-side order responses'
  order_response:
    seq:
      - id: order_status
        type: u1
        enum: order_status
        doc: 'Order status'
      - id: engine_sequence_number
        type: u8
        doc: 'PEARL Engine sequence number of this cancel'
      - id: open_size
        type: u4
        doc: 'Indicates the remaining size open after processing the new order, cancel/replace or cancel. Zero for rejected orders'
  liquidity_mass_cancel_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm''s send time for the Liquidities. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: mass_cancel_scope
        type: u1
        enum: mass_cancel_scope
        doc: 'Mass cancel scope'
      - id: reserved_7
        size: 7
        doc: 'For future use'
  liquidity_mass_cancel_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: status
        type: u1
        enum: status
        doc: 'Status'
  liquidity_protection_reset_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
  liquidity_protection_reset_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: status
        type: u1
        enum: status
        doc: 'Status'
  single_side_liquidity_protection_reset_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: side
        type: u1
        enum: side
        doc: 'The side of Product ID to reset'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
  single_side_liquidity_protection_reset_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: status
        type: u1
        enum: status
        doc: 'Status'
  liquidity_protection_trigger_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: trigger_reason
        type: u1
        enum: trigger_reason
        doc: 'Trigger reason'
  order_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: client_order_id
        type: u4
        doc: 'Client order ID'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: bulk_order_index
        type: u1
        doc: 'Bulk Liquidity Index assigned by PEARL to each Order in bulk Liquidity (order position in the bulk liquidity)'
      - id: target_client_order_id
        type: u4
        doc: 'Target Client Order of the order that was replaced'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: time_in_force_tif
        type: u1
        enum: time_in_force_tif
        doc: 'Time in force'
      - id: order_instruction
        type: u1
        enum: order_instruction
        doc: 'Order instruction'
      - id: origin
        type: u1
        enum: origin
        doc: 'Specifies the order origin type'
      - id: mvp
        type: s1
        doc: 'Number or price levels up to which the order will trade from the initial market price at time of arrival. Negative value indicates MEO to use Exchange default value'
      - id: price
        type: decimal_u4_4
        doc: 'Price that was sent in the Order. 0 for market orders. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: 'The side of Product ID to reset'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Open or close'
      - id: covered_uncovered
        type: u1
        enum: covered_uncovered
        doc: 'Covered or uncovered'
      - id: clearing_account
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OCC Sub account (Multi-account) for non-MM orders or MM MPID for EEMs sending MM orders (in which case MPID field above becomes Executing MPID)'
      - id: cmta
        type: u4
        doc: 'CMTA sent in the order'
      - id: account
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer ID defined by the firms'
  done_for_the_day_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by PEARL system. Nanoseconds since Midnight epoch'
      - id: client_order_id
        type: u4
        doc: 'Client order ID'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: bulk_order_index
        type: u1
        doc: 'Bulk Liquidity Index assigned by PEARL to each Order in bulk Liquidity (order position in the bulk liquidity)'
      - id: target_client_order_id
        type: u4
        doc: 'Target Client Order of the order that was replaced'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PEARL assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: time_in_force_tif
        type: u1
        enum: time_in_force_tif
        doc: 'Time in force'
      - id: order_instruction
        type: u1
        enum: order_instruction
        doc: 'Order instruction'
      - id: origin
        type: u1
        enum: origin
        doc: 'Specifies the order origin type'
      - id: mvp
        type: s1
        doc: 'Number or price levels up to which the order will trade from the initial market price at time of arrival. Negative value indicates MEO to use Exchange default value'
      - id: price
        type: decimal_u4_4
        doc: 'Price that was sent in the Order. 0 for market orders. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: 'The side of Product ID to reset'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Open or close'
      - id: covered_uncovered
        type: u1
        enum: covered_uncovered
        doc: 'Covered or uncovered'
      - id: clearing_account
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'OCC Sub account (Multi-account) for non-MM orders or MM MPID for EEMs sending MM orders (in which case MPID field above becomes Executing MPID)'
      - id: cmta
        type: u4
        doc: 'CMTA sent in the order'
      - id: account
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer ID defined by the firms'
  login_request:
    seq:
      - id: sesm_version
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: '1.1 (right padded with spaces)'
      - id: username
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username issued by MIAX during initial setup'
      - id: computer_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'ID issued by MIAX during initial setup'
      - id: application_protocol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: MEI1.0 (right padded with spaces)'
      - id: requested_session
        type: u1
        doc: 'Specifies the session the client would like to log into, or zero to log into the currently active session'
      - id: requested_sequence_number
        type: u8
        doc: 'Specifies client requested sequence number: next sequence number the client wants to receive upon connection, or 0 to start receiving only new messages without any replay of old messages'
  login_response:
    seq:
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Login Status'
      - id: session_id
        type: u1
        doc: 'PEARL assigned ID for the current trading session'
      - id: highest_sequence_number
        type: u8
        doc: 'The highest sequence number that the server currently has for the client'
  retransmission_request:
    seq:
      - id: start_sequence_number
        type: u8
        doc: 'Sequence number of the first packet to be retransmitted'
      - id: end_sequence_number
        type: u8
        doc: 'Sequence number of the last packet to be retransmitted'
  logout_request:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Reason'
      - id: logout_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text to provide more details beyond the reasons mentioned above'
  goodbye_packet:
    seq:
      - id: goodbye_reason
        type: u1
        enum: goodbye_reason
        doc: 'Reason'
      - id: logout_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text to provide more details beyond the reasons mentioned above'
  test_packet:
    seq:
      - id: test_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  sesm_packet_type:
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced data packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Unsequenced data packet'
    0x4c:
      id: 'login_request'
      doc: 'Login request packet'
    0x52:
      id: 'login_response'
      doc: 'Login response packet'
    0x43:
      id: 'synchronization_complete'
      doc: 'Synchronization complete packet'
    0x41:
      id: 'retransmission_request'
      doc: 'Retransmission request packet'
    0x58:
      id: 'logout_request'
      doc: 'Logout request packet'
    0x47:
      id: 'goodbye_packet'
      doc: 'GoodBye packet'
    0x45:
      id: 'end_of_session'
      doc: 'End of Session packet'
    0x30:
      id: 'server_heartbeat'
      doc: 'Server Heartbeat packet'
    0x31:
      id: 'client_heartbeat'
      doc: 'Client Heartbeat packet'
    0x54:
      id: 'test_packet'
      doc: 'Test packet'
  call_or_put:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  restricted_option:
    0x59:
      id: 'pearl_will_accept_position_closing_orders_only'
      doc: 'Pearl Will Accept Position Closing Orders Only'
    0x4e:
      id: 'pearl_will_accept_open_and_close_positions'
      doc: 'Pearl Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'far_month_expiration_as_defined_by_pearl_rules'
      doc: 'Far Month Expiration As Defined By Pearl Rules'
    0x4e:
      id: 'near_month_expiration_as_defined_by_pearl_rules'
      doc: 'Near Month Expiration As Defined By Pearl Rules'
  active_on_pearl:
    0x41:
      id: 'active_tradable_on_pearl'
      doc: 'Active Tradable On Pearl'
    0x49:
      id: 'inactive_not_tradable_on_pearl'
      doc: 'Inactive Not Tradable On Pearl'
  pearl_bbo_posting_increment_indicator:
    0x50:
      id: 'penny_penny'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Penny (0.01)'
    0x4e:
      id: 'penny_nickel'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Nickel (0.05)'
    0x44:
      id: 'nickel_dime'
      doc: 'Price <= $3: Nickel (0.05); Price > $3: Dime (0.10)'
  order_acceptance_increment_indicator:
    0x50:
      id: 'penny_penny'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Penny (0.01)'
    0x4e:
      id: 'penny_nickel'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Nickel (0.05)'
    0x44:
      id: 'nickel_dime'
      doc: 'Price <= $3: Nickel (0.05); Price > $3: Dime (0.10)'
  opening_underlying_market_code:
    0x41:
      id: 'nyse_amex'
      doc: 'Nyse Amex'
    0x42:
      id: 'nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'national_stock_exchange'
      doc: 'National Stock Exchange'
    0x44:
      id: 'finra_adf'
      doc: 'Finra Adf'
    0x45:
      id: 'market_independent'
      doc: 'Any market that opens first'
    0x49:
      id: 'international_securities_exchange'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'edga_exchange_inc'
      doc: 'Edga Exchange Inc'
    0x4b:
      id: 'edgx_exchange_inc'
      doc: 'Edgx Exchange Inc'
    0x4d:
      id: 'chicago_stock_exchange'
      doc: 'Chicago Stock Exchange'
    0x4e:
      id: 'nyse_euronext'
      doc: 'Nyse Euronext'
    0x50:
      id: 'nyse_arca_exchange'
      doc: 'Nyse Arca Exchange'
    0x51:
      id: 'nasdaq_omx_via_utp_feed'
      doc: 'Nasdaq Omx Via Utp Feed'
    0x54:
      id: 'nasdaq_omx_via_cta_feed'
      doc: 'Nasdaq Omx Via Cta Feed'
    0x57:
      id: 'chicago_board_options_exchange'
      doc: 'Chicago Board Options Exchange'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x58:
      id: 'nasdaq_omx_phlx'
      doc: 'Nasdaq Omx Phlx'
    0x59:
      id: 'bats_y_exchange_inc'
      doc: 'Bats Y Exchange Inc'
    0x5a:
      id: 'bats_exchange_inc'
      doc: 'Bats Exchange Inc'
  system_status:
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x43:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x50:
      id: 'low'
      doc: 'Ready to accept Orders'
    0x4c:
      id: 'not_in_low'
      doc: 'Not Ready to accept application messages including Orders'
    0x4d:
      id: 'mpid_product_assignment_window_open'
      doc: 'Mpid Product Assignment Window Open'
    0x45:
      id: 'mpid_product_assignment_window_closed'
      doc: 'Mpid Product Assignment Window Closed'
    0x31:
      id: 'start_of_test_session'
      doc: 'Sent before tests'
    0x32:
      id: 'end_of_test_session'
      doc: 'End Of Test Session'
  trading_status:
    0x48:
      id: 'pearl_has_halted_trading_for_this_underlying_symbol'
      doc: 'Pearl Has Halted Trading For This Underlying Symbol'
    0x52:
      id: 'pearl_will_resume_trading_reopen_for_this_underlying_symbol'
      doc: 'Pearl Will Resume Trading Reopen For This Underlying Symbol'
    0x4f:
      id: 'pearl_will_open_trading_for_this_underlying_symbol'
      doc: 'Pearl Will Open Trading For This Underlying Symbol'
  event_reason:
    0x41:
      id: 'this_event_resulted_from_automaticmarket_driven_event'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'pearl_manually_initiated_this_event'
      doc: 'Pearl Manually Initiated This Event'
  action:
    0x53:
      id: 'set'
      doc: 'Set (add or update) ARM or ARM2 settings'
    0x44:
      id: 'delete_field'
      doc: 'Delete ARM settings; in the Self-Trade Protection Designation Request, Designate MPID for self-trade protection'
    0x41:
      id: 'assign'
      doc: 'Assign/Reassign an MPID to be an MM in a Product'
    0x55:
      id: 'unassign'
      doc: 'Unassign'
  source:
    0x54:
      id: 'changes_carried_out_by_the_firm_via_meo'
      doc: 'Changes Carried Out By The Firm Via Meo'
    0x45:
      id: 'changes_carried_out_by_the_exchange'
      doc: 'Global default changes or firm requested settings applied manually'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy, Bid or Bought'
    0x53:
      id: 'sell'
      doc: 'Sell, Ask or Sold'
    0x4e:
      id: 'not_applicable'
      doc: 'When Product ID is zero'
  notification_type:
    0x54:
      id: 'triggered'
      doc: 'ARM2 Underlying Level or Firm Level protection Triggered'
    0x52:
      id: 'reset'
      doc: 'ARM2 Underlying Level or Firm Level protection Reset'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  liquidity_type:
    0x4f:
      id: 'binary_order'
      doc: 'AR or Standard'
    0x58:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
  cancel_reason:
    0x4c:
      id: 'line_disconnect_triggered_protection_mass_cancel'
      doc: 'Line Disconnect Triggered Protection Mass Cancel'
    0x42:
      id: 'pearl_help_desk_initiated_cancel'
      doc: 'Individual order cancel or Mass Cancel'
    0x55:
      id: 'firm_initiated_mass_cancel'
      doc: 'Firm Initiated Mass Cancel'
    0x52:
      id: 'pearl_initiated_mass_cancel_due_to_arm_protection'
      doc: 'Pearl Initiated Mass Cancel Due To Arm Protection'
    0x4f:
      id: 'rpm_binary_order_rate_protection_trigger_mass_cancel'
      doc: 'Rpm Binary Order Rate Protection Trigger Mass Cancel'
    0x54:
      id: 'rpm_binary_order_executed_contracts_rate_protection_trigger_mass_cancel'
      doc: 'Rpm Binary Order Executed Contracts Rate Protection Trigger Mass Cancel'
    0x46:
      id: 'arm_2_firm_level_protection_initiated_mass_cancel'
      doc: 'Arm 2 Firm Level Protection Initiated Mass Cancel'
    0x41:
      id: 'price_protection_canceled'
      doc: 'Price Protection Canceled'
    0x43:
      id: 'cancel_of_resting_order_crossed_by_opposite_side_order_of_same_mpid_or_firm'
      doc: 'Cancel Of Resting Order Crossed By Opposite Side Order Of Same Mpid Or Firm'
    0x44:
      id: 'luld_canceled'
      doc: 'Luld Canceled'
    0x4a:
      id: 'canceled_by_user_with_cancel_or_replace_request'
      doc: 'Canceled By User With Cancel Or Replace Request'
    0x4d:
      id: 'canceled_due_to_replace_request_while_blocked_by_rpm_protection'
      doc: 'Canceled Due To Replace Request While Blocked By Rpm Protection'
    0x50:
      id: 'post_only_canceled_due_to_locking_or_crossing_managed_interest_on_the_opposite_side'
      doc: 'Post Only Canceled Due To Locking Or Crossing Managed Interest On The Opposite Side'
    0x53:
      id: 'cancel_for_unexecuted_part_of_order'
      doc: 'Cancel For Unexecuted Part Of Order'
    0x51:
      id: 'canceled_due_to_single_side_liquidity_protection_trigger'
      doc: 'Canceled Due To Single Side Liquidity Protection Trigger'
    0x5a:
      id: 'undefined_reason'
      doc: 'Undefined Reason'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  trade_status:
    0x45:
      id: 'new_execution'
      doc: 'New Execution'
  liquidity_indicator:
    0x4d:
      id: 'maker'
      doc: 'Maker'
    0x54:
      id: 'taker'
      doc: 'Taker'
    0x20:
      id: 'na'
      doc: 'Not applicable; eg: Opening'
    0x2a:
      id: 'downgraded_for_older_version'
      doc: 'Downgraded For Older Version'
  arm_settings_update_status:
    0x20:
      id: 'settings_applied_successfully'
      doc: 'Settings Applied Successfully'
    0x41:
      id: 'invalid_action'
      doc: 'Invalid Action'
    0x50:
      id: 'invalid_allowable_engagement_percentage'
      doc: 'Invalid Allowable Engagement Percentage'
    0x44:
      id: 'invalid_counting_period'
      doc: 'Invalid Counting Period'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x4e:
      id: 'no_such_arm_settings'
      doc: 'No Such Arm Settings'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  arm_2_settings_update_status:
    0x20:
      id: 'settings_applied_successfully'
      doc: 'Settings Applied Successfully'
    0x41:
      id: 'invalid_action'
      doc: 'Invalid Action'
    0x50:
      id: 'invalid_arm_threshold'
      doc: 'Invalid Arm Threshold'
    0x44:
      id: 'invalid_counting_period'
      doc: 'Invalid Counting Period'
    0x49:
      id: 'invalid_for_eem_mpid'
      doc: 'Invalid For Eem Mpid'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x4e:
      id: 'no_such_arm_2_setting'
      doc: 'No Such Arm 2 Setting'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  assignment_settings_status:
    0x20:
      id: 'settings_applied_successfully'
      doc: 'Settings Applied Successfully'
    0x41:
      id: 'invalid_action'
      doc: 'Invalid Action'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x45:
      id: 'invalid_request_for_eem_mpid'
      doc: 'Invalid Request For Eem Mpid'
    0x54:
      id: 'settings_not_permitted'
      doc: 'Only allowed during settings window'
    0x49:
      id: 'invalid_product_code'
      doc: 'Invalid Product Code'
    0x50:
      id: 'assignment_cannot_be_for_put_options'
      doc: 'Assign in Call Options assigns for entire series'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  self_trade_protection_status:
    0x20:
      id: 'settings_applied_successfully'
      doc: 'Settings Applied Successfully'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x45:
      id: 'invalid_for_mm_mpid'
      doc: 'Invalid For Mm Mpid'
    0x41:
      id: 'invalid_action'
      doc: 'Invalid Action'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  bulk_order_status:
    0x20:
      id: 'bulk_liquidity_block_is_valid'
      doc: 'Bulk Liquidity Block Is Valid'
    0x52:
      id: 'invalid_bulk_liquidity_block'
      doc: 'Invalid Bulk Liquidity Block'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
  order_status:
    0x20:
      id: 'successfully_accepted'
      doc: 'Successfully Accepted'
    0x41:
      id: 'market_order_not_accepted_during_luld'
      doc: 'Market Order Not Accepted During Luld'
    0x42:
      id: 'too_wide_for_sell_market_zero_bid'
      doc: 'Too Wide For Sell Market Zero Bid'
    0x43:
      id: 'pearl_closed_for_trading_of_this_product'
      doc: 'Request cannot be completed'
    0x45:
      id: 'market_too_wide_to_accept_market_order'
      doc: 'Market Too Wide To Accept Market Order'
    0x46:
      id: 'buy_sell_limit_too_aggressive'
      doc: 'Buy Sell Limit Too Aggressive'
    0x47:
      id: 'max_open_orders_exceeded'
      doc: 'Max Open Orders Exceeded'
    0x48:
      id: 'max_open_contracts_exceeded'
      doc: 'Max Open Contracts Exceeded'
    0x49:
      id: 'invalid_tif_when_option_not_trading'
      doc: 'Invalid Tif When Option Not Trading'
    0x4a:
      id: 'invalid_order_instruction_when_option_not_trading'
      doc: 'Invalid Order Instruction When Option Not Trading'
    0x4b:
      id: 'no_a_r_order_to_cancel'
      doc: 'No A R Order To Cancel'
    0x4c:
      id: 'order_received_while_not_in_low'
      doc: 'Order Received While Not In Low'
    0x4e:
      id: 'invalid_client_order_id'
      doc: 'Invalid Client Order Id'
    0x4f:
      id: 'invalid_product_id'
      doc: 'Invalid Product Id'
    0x50:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x51:
      id: 'invalid_size'
      doc: 'Invalid Size'
    0x52:
      id: 'rejected_due_to_order_protection'
      doc: 'Rejected Due To Order Protection'
    0x53:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x54:
      id: 'invalid_target_client_order_id'
      doc: 'Invalid Target Client Order Id'
    0x55:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x56:
      id: 'invalid_to_change'
      doc: 'Invalid To Change'
    0x57:
      id: 'invalid_cancel_request'
      doc: 'When product mismatches'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x59:
      id: 'invalid_for_mpid'
      doc: 'Invalid For Mpid'
    0x31:
      id: 'invalid_origin'
      doc: 'Invalid Origin'
    0x32:
      id: 'invalid_tif'
      doc: 'Invalid Tif'
    0x33:
      id: 'restricted_option'
      doc: 'Opening position not allowed'
    0x34:
      id: 'non_tradable_option'
      doc: 'Non Tradable Option'
    0x35:
      id: 'incompatible_order_type'
      doc: 'Incompatible Order Type'
    0x36:
      id: 'incompatible_tif'
      doc: 'Incompatible Tif'
    0x37:
      id: 'invalid_order_instruction'
      doc: 'Invalid Order Instruction'
    0x38:
      id: 'invalid_open_close'
      doc: 'Invalid Open Close'
    0x39:
      id: 'invalid_covered_un_covered'
      doc: 'Invalid Covered Un Covered'
    0x30:
      id: 'invalid_mvp_ticks'
      doc: 'Invalid Mvp Ticks'
    0x61:
      id: 'invalid_clearing_account'
      doc: 'Invalid Clearing Account'
    0x62:
      id: 'blocked_by_occ_kill_switch'
      doc: 'Blocked By Occ Kill Switch'
    0x63:
      id: 'blocked_by_rpm'
      doc: 'Blocked By Rpm'
    0x65:
      id: 'duplicate_client_order_id'
      doc: 'Duplicate Client Order Id'
    0x66:
      id: 'invalid_account'
      doc: 'Invalid Account'
    0x67:
      id: 'invalid_liquidity_unit_type'
      doc: 'Invalid Liquidity Unit Type'
    0x68:
      id: 'invalid_cmta_specified'
      doc: 'Invalid Cmta Specified'
    0x73:
      id: 'rejected_due_to_single_side_liquidity_protection_in_effect'
      doc: 'Rejected Due To Single Side Liquidity Protection In Effect'
    0x74:
      id: 'invalid_additional_text'
      doc: 'Invalid Additional Text'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  mass_cancel_scope:
    0x41:
      id: 'mass_cancel_all_open_binary_orders_and_block_all_subsequent_binary_orders'
      doc: 'Mass-Cancel all open Binary Orders and block all subsequent Binary Orders (including immediate orders)'
    0x44:
      id: 'mass_cancel_all_open_binary_orders'
      doc: 'Mass-Cancel all open Binary Orders. All subsequent Binary Orders will be blocked except immediate orders'
  status:
    0x20:
      id: 'successful'
      doc: 'Cancel successful; Order Protection reset successful; Single Side Protection Reset Request successful'
    0x41:
      id: 'arm_2_underlying_level_protection_is_in_effect'
      doc: 'Liquidity Protection Reset Response'
    0x43:
      id: 'cannot_cancel_while_not_in_low'
      doc: 'Liquidity Mass Cancel Response; Cannot reset while not in LOW in the Liquidity Protection Reset Response; Invalid Product ID in the Single Side Liquidity Protection Reset Response'
    0x45:
      id: 'feature_not_enabled'
      doc: 'Single Side Liquidity Protection Reset Response'
    0x46:
      id: 'arm_2_firm_level_protection_is_in_effect'
      doc: 'Liquidity Protection Reset Response'
    0x4a:
      id: 'mass_cancel_scope_contains_invalid_value'
      doc: 'Liquidity Mass Cancel Response'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x4e:
      id: 'all_orders_have_already_been_canceled'
      doc: 'Liquidity Mass Cancel Response'
    0x53:
      id: 'invalid_side'
      doc: 'Single Side Liquidity Protection Reset Response'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  trigger_reason:
    0x4c:
      id: 'line_disconnect_triggered_protection'
      doc: 'Line Disconnect Triggered Protection'
    0x42:
      id: 'pearl_help_desk_triggered_protection'
      doc: 'Pearl Help Desk Triggered Protection'
    0x55:
      id: 'firm_initiated_mass_cancel'
      doc: 'Firm Initiated Mass Cancel'
    0x52:
      id: 'arm_triggered_protection'
      doc: 'Arm Triggered Protection'
    0x4f:
      id: 'rpm_binary_order_rate_protection_trigger'
      doc: 'Rpm Binary Order Rate Protection Trigger'
    0x54:
      id: 'rpm_binary_order_executed_contracts_rate_protection_trigger'
      doc: 'Rpm Binary Order Executed Contracts Rate Protection Trigger'
    0x46:
      id: 'arm_2_firm_level_protection_initiated_mass_cancel'
      doc: 'Arm 2 Firm Level Protection Initiated Mass Cancel'
    0x4a:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  time_in_force_tif:
    0x44:
      id: 'day'
      doc: 'Day'
    0x49:
      id: 'ioc'
      doc: 'Ioc'
  order_instruction:
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x53:
      id: 'iso'
      doc: 'Iso'
    0x50:
      id: 'post_only'
      doc: 'Post Only'
  origin:
    0x30:
      id: 'priority_customer'
      doc: 'Priority Customer'
    0x31:
      id: 'firm'
      doc: 'Firm'
    0x32:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x34:
      id: 'market_maker'
      doc: 'Market Maker (PEARL MM)'
    0x35:
      id: 'non_member_market_maker'
      doc: 'Non-Member Market Maker (Away MM)'
    0x38:
      id: 'non_priority_customer'
      doc: 'Non Priority Customer'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'na'
      doc: 'For MMs Origin 4 or 5'
  covered_uncovered:
    0x43:
      id: 'covered'
      doc: 'Covered'
    0x55:
      id: 'uncovered'
      doc: 'Uncovered'
    0x4e:
      id: 'na'
      doc: 'For MMs'
  login_status:
    0x20:
      id: 'login_successful'
      doc: 'Login successful'
    0x58:
      id: 'rejected'
      doc: 'Rejected: Invalid Username/Computer ID combination'
    0x53:
      id: 'requested_session_is_not_available'
      doc: 'Requested session is not available'
    0x4e:
      id: 'invalid_start_sequence_number_requested'
      doc: 'Invalid start sequence number requested'
    0x49:
      id: 'incompatible_session_protocol_version'
      doc: 'Incompatible Session protocol version'
    0x41:
      id: 'incompatible_application_protocol_version'
      doc: 'Incompatible Application protocol version'
    0x4c:
      id: 'request_rejected_because_client_already_logged_in'
      doc: 'Request rejected because client already logged in'
  logout_reason:
    0x20:
      id: 'graceful_logout'
      doc: 'Graceful Logout (Done for now)'
    0x42:
      id: 'bad_sesm_packet'
      doc: 'Bad SesM Packet'
    0x4c:
      id: 'timed_out_waiting_for_login_packet'
      doc: 'Timed out waiting for Login Packet'
    0x41:
      id: 'application_terminating_connection'
      doc: 'Application terminating connection'
  goodbye_reason:
    0x42:
      id: 'bad_sesm_packet'
      doc: 'Bad SesM Packet'
    0x4c:
      id: 'timed_out_waiting_for_login_packet'
      doc: 'Timed out waiting for Login Packet'
    0x41:
      id: 'application_terminating_connection'
      doc: 'Application terminating connection'

