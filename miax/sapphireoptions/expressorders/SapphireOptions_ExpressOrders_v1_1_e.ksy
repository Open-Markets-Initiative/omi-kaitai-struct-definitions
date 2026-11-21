# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax SapphireOptions ExpressOrders Meo v1.1.e
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Express Orders
#   Encoding: Miax Express Orders
#   Version: 1.1.e
#   Date: 8/13/2024
#   Specification: Sapphire MIAX Express Orders MEO v1.1e_0.pdf
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: miax_sapphireoptions_expressorders_meo_v1_1_e
  title: Miax SapphireOptions ExpressOrders Meo v1.1.e
  license: MIT-0
  endian: le

doc: 'Miami International Holdings MIAX Sapphire Options Express Orders Meo v1.1.e'
doc-ref: https://www.miaxglobal.com/markets/us-options/sapphire-options/interface-specifications

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
            '"CR"': complex_binary_order_response
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
            '"SC"': complex_strategy_definition_notification
            '"CS"': stock_leg_execution_notification
  series_update:
    seq:
      - id: product_add_update_time
        type: nanosecond_timestamp
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u4
        doc: 'Sapphire Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'Expressed in HH:MM:SS format. e.g.: 09:30:00'
      - id: closing_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. e.g.: 16:15:00'
      - id: restricted_option
        type: u1
        enum: restricted_option
        doc: 'Restricted option'
      - id: long_term_option
        type: u1
        enum: long_term_option
        doc: 'Long term option'
      - id: active_on_sapphire
        type: u1
        enum: active_on_sapphire
        doc: 'Indicates if this symbol is tradable on Sapphire in the current session'
      - id: sapphire_bbo_posting_increment_indicator
        type: u1
        enum: sapphire_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by Sapphire'
      - id: order_acceptance_increment_indicator
        type: u1
        enum: order_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Order acceptance as per Sapphire rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
  complex_binary_order_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
      - id: order_id
        type: u8
        doc: 'Sapphire assigned ID for complex binary order if accepted; Zero if complex binary order was rejected'
      - id: status
        type: u1
        enum: status
        doc: 'Status'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  system_state_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: meo_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: MEOX.X (where X.X is MEO version)'
      - id: session_id
        type: u1
        doc: 'Sapphire assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status'
  underlying_trading_status_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
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
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
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
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: allowable_engagement_percentage
        type: u4
        doc: 'Percentage of order size at which the Member wants Sapphire to trigger ARM protection for this underlying. Minimum value is 1 (1%). Maximum is 65,535 (65,535%)'
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
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
      - id: security_id_scope
        type: u1
        enum: security_id_scope
        doc: 'Defines type of security specified in Security ID field'
      - id: security_id
        type: u4
        doc: 'Sapphire Option Product ID if Security ID Scope is P. Sapphire Complex Strategy ID if Security ID Scope is S. If set to zero, will apply reset for both sides of every option or every strategy for the MPID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of complex binary order'
      - id: triggering_client_message_id
        type: u4
        doc: 'Client Message ID supplied by the firm in the Bulk order message that triggered the Single Side Liquidity Protection'
      - id: triggering_bulk_order_index
        type: u1
        doc: 'Bulk Order Index assigned by Sapphire to each Order in Bulk Liquidity (order position in the Bulk liquidity) that triggered Single Side Liquidity Protection'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
  arm_2_underlying_level_protection_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
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
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
      - id: security_id_scope
        type: u1
        enum: security_id_scope
        doc: 'Defines type of security specified in Security ID field'
      - id: security_id
        type: u4
        doc: 'Sapphire Option Product ID if Security ID Scope is P. Sapphire Complex Strategy ID if Security ID Scope is S. If set to zero, will apply reset for both sides of every option or every strategy for the MPID'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: client_order_id
        type: u4
        doc: 'Client order ID in Simple Binary Order. Set to zero for Complex Binary order'
      - id: bulk_order_index
        type: u1
        doc: 'Bulk Liquidity Index assigned by Sapphire to each Order in bulk Liquidity (order position in the bulk liquidity). Set to zero for Complex binary order'
      - id: side
        type: u1
        enum: side
        doc: 'Side of complex binary order'
      - id: size
        type: u4
        doc: 'Number of times to execute the specified strategy'
      - id: engine_sequence_number
        type: u8
        doc: 'Sapphire Engine sequence number of this cancel'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Cancel reason'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  execution_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity type'
      - id: product_id
        type: u4
        doc: 'Sapphire Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: client_order_id
        type: u4
        doc: 'Client order ID in Simple Binary Order. Set to zero for Complex Binary order'
      - id: bulk_order_index
        type: u1
        doc: 'Bulk Liquidity Index assigned by Sapphire to each Order in bulk Liquidity (order position in the bulk liquidity). Set to zero for Complex binary order'
      - id: trade_id
        type: u4
        doc: 'Sapphire Trade ID'
      - id: execution_id
        type: u8
        doc: 'Sapphire execution ID'
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
        doc: 'Side of complex binary order'
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
  complex_strategy_definition_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day. ID is not unique between Series Product ID'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: active_on_sapphire
        type: u1
        enum: active_on_sapphire
        doc: 'Indicates if this symbol is tradable on Sapphire in the current session'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: update_reason
        type: u1
        enum: update_reason
        doc: 'Update reason'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
      - id: num_legs
        type: u1
        doc: 'Number of Legs. Valid values: 2 to 12 (for Options only), 2 to 13 (for Stock-tied)'
      - id: legs
        type: legs
        repeat: expr
        repeat-expr: num_legs
        doc: '2 to 13 legs'
  legs:
    seq:
      - id: product_id
        type: u4
        doc: 'Sapphire Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: leg_ratio_qty
        type: u4
        doc: 'The ratio of this individual leg. Number of option contracts or Number of stock shares for this leg is: LegRatioQty * Size'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of this individual leg'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  stock_leg_execution_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: trade_id
        type: u4
        doc: 'Sapphire Trade ID'
      - id: execution_id
        type: u8
        doc: 'Sapphire execution ID'
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
        doc: 'Side of complex binary order'
      - id: stock_sell_short_indicator
        type: u1
        enum: stock_sell_short_indicator
        doc: 'Sell Short indicator if this complex binary order sells the stock leg of the strategy'
      - id: last_size
        type: u4
        doc: 'Number of contracts executed (not cumulative)'
      - id: reserved_16
        size: 16
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
            '"lm"': simple_bulk_liquidity_message
            '"LR"': simple_bulk_liquidity_message_response
            '"CO"': complex_binary_order_request
            '"xq"': liquidity_mass_cancel_request
            '"XR"': liquidity_mass_cancel_response
            '"PX"': liquidity_protection_reset_request
            '"PR"': liquidity_protection_reset_response
            '"SS"': single_side_liquidity_protection_reset_request
            '"ST"': single_side_liquidity_protection_reset_response
            '"QP"': liquidity_protection_trigger_notification
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Percentage of order size at which the Member wants Sapphire to trigger ARM protection for this underlying. Minimum value is 1 (1%). Maximum is 65,535 (65,535%)'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID of the Member'
      - id: product_id
        type: u4
        doc: 'Sapphire Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'Sapphire assigned ID of the Member'
      - id: assignment_settings_status
        type: u1
        enum: assignment_settings_status
        doc: 'Assignment settings status'
  simple_bulk_liquidity_message:
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
        size: 40
        doc: 'Can contain 1 AutoReplace Order, Standard Order, Standard Order Cancel or Standard Order Replace in each unit. Number of units should match the count specified in the count field'
  simple_bulk_liquidity_message_response:
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
        doc: 'Time at which Sapphire engine generated this response. Nanoseconds since Midnight epoch'
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
        doc: 'Sapphire Engine sequence number of this cancel'
      - id: engine_transaction_time
        type: nanosecond_timestamp
        doc: 'Unique timestamp, assigned by the Sapphire Matching Engine, for orders processed successfully and zero if rejected. Nanoseconds since Midnight epoch'
      - id: open_size
        type: u4
        doc: 'Indicates the remaining size open after processing the new order, cancel/replace or cancel. Zero for rejected orders'
  complex_binary_order_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm''s send time for the Liquidities. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day. ID is not unique between Series Product ID'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in Force for complex binary order'
      - id: net_price
        type: decimal_s8_4
        doc: 'The net limit price for the strategy. If Side is B, a positive number represents net debit and a negative number net credit; if Side is A, a positive number represents net credit and a negative number a net debit. Price of zero is net neutral transaction for either side. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of times to execute the specified strategy'
      - id: side
        type: u1
        enum: side
        doc: 'Side of complex binary order'
      - id: stock_sell_short_indicator
        type: u1
        enum: stock_sell_short_indicator
        doc: 'Sell Short indicator if this complex binary order sells the stock leg of the strategy'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID of the Member'
      - id: security_id_scope
        type: u1
        enum: security_id_scope
        doc: 'Defines type of security specified in Security ID field'
      - id: security_id
        type: u4
        doc: 'Sapphire Option Product ID if Security ID Scope is P. Sapphire Complex Strategy ID if Security ID Scope is S. If set to zero, will apply reset for both sides of every option or every strategy for the MPID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of complex binary order'
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
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Time at which this was generated by Sapphire system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sapphire assigned ID of the Member'
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
        doc: 'Sapphire assigned ID for the current trading session'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
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
      id: 'sapphire_will_accept_position_closing_orders_only'
      doc: 'Sapphire Will Accept Position Closing Orders Only'
    0x4e:
      id: 'sapphire_will_accept_open_and_close_positions'
      doc: 'Sapphire Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'far_month_expiration_as_defined_by_sapphire_rules'
      doc: 'Far Month Expiration As Defined By Sapphire Rules'
    0x4e:
      id: 'near_month_expiration_as_defined_by_sapphire_rules'
      doc: 'Near Month Expiration As Defined By Sapphire Rules'
  active_on_sapphire:
    0x41:
      id: 'active_tradable_on_sapphire'
      doc: 'Active Tradable On Sapphire'
    0x49:
      id: 'inactive_not_tradable_on_sapphire'
      doc: 'Inactive Not Tradable On Sapphire'
  sapphire_bbo_posting_increment_indicator:
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
    0x48:
      id: 'miax_pearl_equities'
      doc: 'Miax Pearl Equities'
    0x49:
      id: 'international_securities_exchange'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'edga_exchange_inc'
      doc: 'Edga Exchange Inc'
    0x4b:
      id: 'edgx_exchange_inc'
      doc: 'Edgx Exchange Inc'
    0x4c:
      id: 'ltse'
      doc: 'Ltse'
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
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x57:
      id: 'cboe_stock_exchange_cbsx'
      doc: 'Cboe Stock Exchange Cbsx'
    0x58:
      id: 'nasdaq_omx_phlx'
      doc: 'Nasdaq Omx Phlx'
    0x59:
      id: 'bats_y_exchange_inc'
      doc: 'Bats Y Exchange Inc'
    0x5a:
      id: 'bats_exchange_inc'
      doc: 'Bats Exchange Inc'
  status:
    0x20:
      id: 'successful'
      doc: 'Request accepted successfully; Cancel successful; Order Protection reset successful; Single Side Protection Reset Request successful'
    0x41:
      id: 'arm_2_underlying_level_protection_is_in_effect'
      doc: 'Liquidity Protection Reset Response; Invalid Security ID scope in the Single Side Liquidity Protection Reset Response'
    0x43:
      id: 'cannot_cancel_while_not_in_low'
      doc: 'Liquidity Mass Cancel Response; Cannot reset while not in LOW in the Liquidity Protection Reset Response; Invalid Security ID in the Single Side Liquidity Protection Reset Response; Sapphire closed for trading of this strategy (request cannot be completed) in the Complex Binary Order Response'
    0x45:
      id: 'single_side_protection_is_not_enabled_for_the_specified_mpid'
      doc: 'Single Side Liquidity Protection Reset Response'
    0x46:
      id: 'arm_2_firm_level_protection_is_in_effect'
      doc: 'Liquidity Protection Reset Response'
    0x47:
      id: 'complex_feature_disabled'
      doc: 'Complex Binary Order Response'
    0x49:
      id: 'invalid_strategy_id'
      doc: 'Complex Binary Order Response'
    0x4a:
      id: 'mass_cancel_scope_contains_invalid_value'
      doc: 'Liquidity Mass Cancel Response; Outside Price Range for Strategy in the Complex Binary Order Response'
    0x4b:
      id: 'not_in_low'
      doc: 'Complex Binary Order Response'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x4e:
      id: 'all_orders_have_already_been_canceled'
      doc: 'Liquidity Mass Cancel Response'
    0x50:
      id: 'invalid_price'
      doc: 'Complex Binary Order Response'
    0x52:
      id: 'rejected_due_to_order_protection'
      doc: 'Complex Binary Order Response'
    0x53:
      id: 'invalid_side'
      doc: 'Single Side Liquidity Protection Reset Response and Complex Binary Order Response'
    0x54:
      id: 'invalid_time_in_force'
      doc: 'Complex Binary Order Response'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x56:
      id: 'invalid_size'
      doc: 'Complex Binary Order Response'
    0x58:
      id: 'request_is_not_permitted'
      doc: 'Complex Binary Order Response'
    0x59:
      id: 'rejected_due_to_single_side_liquidity_protection_in_effect'
      doc: 'Complex Binary Order Response'
    0x62:
      id: 'blocked_by_occ_kill_switch'
      doc: 'Complex Binary Order Response'
    0x37:
      id: 'rejected_due_to_stock_clearing_account_underlying_mpid_or_dtc_account_number_not_configured'
      doc: 'Complex Binary Order Response'
    0x38:
      id: 'invalid_sell_short_indicator'
      doc: 'Complex Binary Order Response'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
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
      id: 'sapphire_has_halted_trading_for_this_underlying_symbol'
      doc: 'Sapphire Has Halted Trading For This Underlying Symbol'
    0x52:
      id: 'sapphire_will_resume_trading_reopen_for_this_underlying_symbol'
      doc: 'Sapphire Will Resume Trading Reopen For This Underlying Symbol'
    0x4f:
      id: 'sapphire_will_open_trading_for_this_underlying_symbol'
      doc: 'Sapphire Will Open Trading For This Underlying Symbol'
  event_reason:
    0x41:
      id: 'this_event_resulted_from_automaticmarket_driven_event'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'sapphire_manually_initiated_this_event'
      doc: 'Sapphire Manually Initiated This Event'
  action:
    0x53:
      id: 'set'
      doc: 'Set (add or update) ARM or ARM2 settings'
    0x44:
      id: 'delete_field'
      doc: 'Delete ARM settings'
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
  security_id_scope:
    0x50:
      id: 'security_id_specifies_sapphire_option_product_id'
      doc: 'Security Id Specifies Sapphire Option Product Id'
    0x53:
      id: 'security_id_specifies_sapphire_complex_strategy_id'
      doc: 'Security Id Specifies Sapphire Complex Strategy Id'
    0x4f:
      id: 'simple_binary_order'
      doc: 'AR or Standard; Cancel Notification'
    0x58:
      id: 'complex_binary_order'
      doc: 'Cancel Notification'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy, Bid or Bought'
    0x53:
      id: 'sell'
      doc: 'Sell, Ask or Sold'
    0x4e:
      id: 'not_applicable'
      doc: 'When Security ID is zero'
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
  cancel_reason:
    0x42:
      id: 'sapphire_help_desk_initiated_cancel'
      doc: 'Individual order cancel'
    0x47:
      id: 'auto_replace_order_canceled_due_to_reject_of_the_replacement_request'
      doc: 'Auto Replace Order Canceled Due To Reject Of The Replacement Request'
    0x4b:
      id: 'complex_strategy_leg_has_wide_mbbo'
      doc: 'Only applicable to Complex Binary Orders'
    0x41:
      id: 'price_protection_canceled'
      doc: 'Price Protection Canceled'
    0x43:
      id: 'cancel_of_resting_order_crossed_by_opposite_side_order_of_same_mpid_or_firm'
      doc: 'Cancel Of Resting Order Crossed By Opposite Side Order Of Same Mpid Or Firm'
    0x44:
      id: 'luld_canceled'
      doc: 'Luld Canceled'
    0x45:
      id: 'strategy_is_not_open_for_trading'
      doc: 'Only applicable to IOC Complex Binary Order'
    0x4a:
      id: 'standard_order_is_canceled_as_a_result_of_cancel_replace_request'
      doc: 'Standard Order Is Canceled As A Result Of Cancel Replace Request'
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
  liquidity_type:
    0x4f:
      id: 'simple_binary_order'
      doc: 'AR or Standard'
    0x58:
      id: 'complex_binary_order'
      doc: 'Complex Binary Order'
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
      doc: 'Not applicable; e.g.: Opening'
    0x2a:
      id: 'downgraded_for_older_version'
      doc: 'Downgraded For Older Version'
  update_reason:
    0x4e:
      id: 'new_strategy_created'
      doc: 'New Strategy Created'
    0x55:
      id: 'strategy_definition_updated'
      doc: 'Strategy Definition Updated'
    0x2a:
      id: 'downgraded_for_older_version'
      doc: 'Downgraded For Older Version'
  leg_side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
  stock_sell_short_indicator:
    0x4e:
      id: 'not_short'
      doc: 'Not Short'
    0x59:
      id: 'short_field'
      doc: 'Short'
    0x45:
      id: 'short_exempt'
      doc: 'Short Exempt'
    0x20:
      id: 'na'
      doc: 'Not applicable'
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
    0x43:
      id: 'sapphire_closed_for_trading_of_this_product'
      doc: 'Request cannot be completed'
    0x46:
      id: 'buy_sell_limit_too_aggressive'
      doc: 'Buy Sell Limit Too Aggressive'
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
    0x32:
      id: 'invalid_tif'
      doc: 'Invalid Tif'
    0x34:
      id: 'non_tradable_option'
      doc: 'Non Tradable Option'
    0x35:
      id: 'incompatible_order_type'
      doc: 'Incompatible Order Type'
    0x37:
      id: 'invalid_order_instruction'
      doc: 'Invalid Order Instruction'
    0x30:
      id: 'invalid_mvp_ticks'
      doc: 'Invalid Mvp Ticks'
    0x62:
      id: 'blocked_by_occ_kill_switch'
      doc: 'Blocked By Occ Kill Switch'
    0x65:
      id: 'duplicate_client_order_id'
      doc: 'Duplicate Client Order Id'
    0x67:
      id: 'invalid_liquidity_unit_type'
      doc: 'Invalid Liquidity Unit Type'
    0x73:
      id: 'rejected_due_to_single_side_liquidity_protection_in_effect'
      doc: 'Rejected Due To Single Side Liquidity Protection In Effect'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  time_in_force:
    0x49:
      id: 'ioc'
      doc: 'Immediate match or cancel'
  mass_cancel_scope:
    0x41:
      id: 'mass_cancel_all_open_simple_binary_orders_ar_and_standard_binary_day_and_block_all_subsequent_simple_and_complex_binary_orders'
      doc: 'Mass-Cancel all open Simple Binary Orders (AR and Standard Binary DAY) and block all subsequent Simple and Complex Binary Orders (including immediate orders)'
    0x44:
      id: 'mass_cancel_all_open_simple_binary_orders'
      doc: 'Mass-Cancel all open Simple Binary Orders. All subsequent Simple Binary Orders will be blocked, however immediate orders (Standard and Complex Binary) will not be blocked'
  trigger_reason:
    0x4c:
      id: 'line_disconnect_triggered_protection'
      doc: 'Line Disconnect Triggered Protection'
    0x42:
      id: 'sapphire_help_desk_triggered_protection'
      doc: 'Sapphire Help Desk Triggered Protection'
    0x55:
      id: 'firm_initiated_mass_cancel'
      doc: 'Firm Initiated Mass Cancel'
    0x52:
      id: 'arm_triggered_protection'
      doc: 'Arm Triggered Protection'
    0x46:
      id: 'arm_2_firm_level_protection_initiated_mass_cancel'
      doc: 'Arm 2 Firm Level Protection Initiated Mass Cancel'
    0x4a:
      id: 'undefined_reason'
      doc: 'Undefined Reason'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
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

