# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax EmeraldOptions ExpressInterface Mei v2.1.b
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Express Interface
#   Encoding: Miax Express Interface
#   Version: 2.1.b
#   Date: 10/02/2020
#   Specification: MIAX_Emerald_MIAX_Express_Interface_MEI_v2.1b_re.pdf
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
  id: miax_emeraldoptions_expressinterface_mei_v2_1_b
  title: Miax EmeraldOptions ExpressInterface Mei v2.1.b
  license: MIT-0
  endian: le

doc: 'Miami International Holdings MIAX Emerald Options Express Interface Mei v2.1.b'
doc-ref: https://www.miaxglobal.com/markets/us-options/emerald-options/interface-specifications

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
            '"SU"': simple_series_update
            '"QW"': valid_quote_width_for_opening
            '"ER"': simple_enhanced_quote_e_quote_response
            '"CR"': complex_enhanced_quote_e_quote_response
            '"SN"': system_state_notification
            '"TN"': product_trading_status_notification
            '"UN"': underlying_trading_status_notification
            '"QN"': quote_width_relief_notification
            '"AN"': simple_arm_protection_settings_notification
            '"A2"': arm_2_underlying_level_protection_settings_notification
            '"QX"': single_side_liquidity_protection_trigger_notification
            '"UP"': arm_2_underlying_level_protection_notification
            '"FP"': arm_2_firm_level_protection_notification
            '"SC"': complex_strategy_definition_notification
            '"XN"': cancel_notification
            '"EN"': option_execution_notification
            '"ST"': stock_leg_execution_notification
  simple_series_update:
    seq:
      - id: product_add_update_time
        type: nanosecond_timestamp
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        type: yyyymmdd_ascii_date
        doc: 'Expiration date of the option in YYYYMMDD format'
      - id: strike_price
        type: decimal_u4_4
        doc: 'Explicit strike price of the option. Refer to data types for field processing notes. Implied decimal with scale 1e-4'
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
        doc: 'Restricted Option'
      - id: long_term_option
        type: u1
        enum: long_term_option
        doc: 'Long Term Option'
      - id: active_on_emerald
        type: u1
        enum: active_on_emerald
        doc: 'Indicates if this symbol is tradable on Emerald in the current session'
      - id: emerald_bbo_posting_increment_indicator
        type: u1
        enum: emerald_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by Emerald'
      - id: quote_acceptance_increment_indicator
        type: u1
        enum: quote_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Quote acceptance as per Emerald rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market'
      - id: priority_quote_width
        type: decimal_u4_4
        doc: 'Maximum allowable width for a quote for this Option during regular trading in order to be considered as Priority Quote. 0 when Priority Quote Width is not applicable. Implied decimal with scale 1e-4'
      - id: reserved_8
        size: 8
        doc: '** Reserved for future use **'
  valid_quote_width_for_opening:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpv_class
        type: u1
        enum: mpv_class
        doc: 'This valid width record is applicable for Options in this MPV class'
      - id: low_end_of_applicable_range
        type: decimal_u4_4
        doc: 'Low end of the price range for which this valid width is applicable. The high end of the price range is up to, but not including the low end of next row or infinity for last row. Implied decimal with scale 1e-4'
      - id: maximum_quote_width
        type: decimal_u4_4
        doc: 'Quote width applicable for this range for Options that are not Long Term Options. Implied decimal with scale 1e-4'
      - id: long_term_option_multiplier
        type: decimal_u4_4
        doc: 'Multiplier of the maximum quote width (specified in the previous field) for this range applicable for Long Term Options. Implied decimal with scale 1e-4'
  simple_enhanced_quote_e_quote_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: e_quote_id
        type: u8
        doc: 'Emerald assigned ID for eQuote if accepted; Zero if eQuote was rejected. Replaced eQuote will have the same eQuote ID as original'
      - id: e_quote_request_status
        type: u1
        enum: e_quote_request_status
        doc: 'eQuote Request Status'
  complex_enhanced_quote_e_quote_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: e_quote_id
        type: u8
        doc: 'Emerald assigned ID for eQuote if accepted; Zero if eQuote was rejected. Replaced eQuote will have the same eQuote ID as original'
      - id: e_quote_request_status
        type: u1
        enum: e_quote_request_status
        doc: 'eQuote Request Status'
  system_state_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mei_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: MEIX.X (where is ‘X’ is MEI version i.e.1.1 or 1.6)'
      - id: session_id
        type: u1
        doc: 'Emerald assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'System Status'
  product_trading_status_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: expected_event_time
        type: nanosecond_timestamp
        doc: 'Expected time of start of the event as specified below: When trading status =”C”, this will be the time at which Closing rotation will start for this Product When trading status = “R”, this will be the time at which the reopening process will start for this Product. Nanoseconds since Midnight epoch'
  underlying_trading_status_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: event_reason
        type: u1
        enum: event_reason
        doc: 'Event Reason'
      - id: expected_event_time
        type: nanosecond_timestamp
        doc: 'Expected time of start of the event as specified below: When trading status =”C”, this will be the time at which Closing rotation will start for this Product When trading status = “R”, this will be the time at which the reopening process will start for this Product. Nanoseconds since Midnight epoch'
  quote_width_relief_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: relief_multiplier
        type: decimal_u4_4
        doc: 'Relief is the multiplier times the regular acceptable quote width. Eg: For a series with quote width of $0.25, a relief multiplier of 2 implies that the acceptable quote width is $0.50. Implied decimal with scale 1e-4'
  simple_arm_protection_settings_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: allowable_engagement_percentage
        type: u4
        doc: 'Percentage of quote size at which the Market Maker wants Emerald to trigger ARM protection for this underlying. Please refer to the rules for details of ARM. Maximum value is 65,535 (65,535%). See note below on minimum value'
      - id: counting_period_binary_u_2
        type: u2
        doc: 'Duration (in number of milliseconds) in which Engagement percentage is calculated in order to determine if the MPID should be put on ARM protection for this underlying. Allowable Range: 100 to 15,000 milliseconds Must be a multiple of 100 milliseconds'
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
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
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
      - id: arm_threshold_count_binary_u_4
        type: u4
        doc: 'Number of ARM triggers for the Counting Period for the specified underlying that will trigger ARM2 Underlying level protection. Minimum: 3 Maximum: 99'
      - id: counting_period_binary_u_4
        type: u4
        doc: 'Duration (in number of milliseconds) for which ARM triggers are counted in order to determine if they don’t exceed the specified ARM2 Threshold. Allowable Range: 1000 to 24,300,000 milliseconds Must be a multiple of 1,000 milliseconds'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  single_side_liquidity_protection_trigger_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: security_id_scope
        type: u1
        enum: security_id_scope
        doc: 'Defines type of security specified in “Security ID” field'
      - id: security_id
        type: u4
        doc: 'Option Product ID if Security ID Scope = “P” Complex Strategy ID if Security ID Scope = “S” If set to zero, will apply reset for both sides of every option or every strategy for the MPID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
      - id: triggering_client_message_id
        type: u4
        doc: 'Client Message ID supplied by the firm for the liquidity that triggered Single Side Liquidity Protection'
      - id: triggering_bulk_quote_index
        type: u1
        doc: 'Simple Bulk Quote Index assigned by Emerald to each quote in bulk quote when triggering liquidity is a Standard Quote'
      - id: reserved_4
        size: 4
        doc: '* Reserved for future use. *'
  arm_2_underlying_level_protection_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: notification_type
        type: u1
        enum: notification_type
        doc: 'Notification Type'
      - id: arm_threshold_count_binary_u_4
        type: u4
        doc: 'Number of ARM triggers for the Counting Period for the specified underlying that will trigger ARM2 Underlying level protection. Minimum: 3 Maximum: 99'
      - id: counting_period_binary_u_4
        type: u4
        doc: 'Duration (in number of milliseconds) for which ARM triggers are counted in order to determine if they don’t exceed the specified ARM2 Threshold. Allowable Range: 1000 to 24,300,000 milliseconds Must be a multiple of 1,000 milliseconds'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  arm_2_firm_level_protection_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: arm_threshold_count_binary_4u_4
        type: u4
        doc: 'Number of unique ARM triggers for the Counting Period that will trigger ARM2 Firm Level protection'
      - id: counting_period_binary_4u_4
        type: u4
        doc: 'Counting Period in milliseconds in which the number of unique ARM triggers cannot exceed the configured ARM Threshold Count specified for ARM2 protection'
      - id: notification_type
        type: u1
        enum: notification_type
        doc: 'Notification Type'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  complex_strategy_definition_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Emerald Strategy ID is assigned per trading day and is valid only for that day. ID is not unique between Series Product ID'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: active_on_emerald
        type: u1
        enum: active_on_emerald
        doc: 'Indicates if this symbol is tradable on Emerald in the current session'
      - id: reserved_1
        size: 1
        doc: '** Reserved for future use **'
      - id: update_reason
        type: u1
        enum: update_reason
        doc: 'Update Reason'
      - id: reserved_10
        size: 10
        doc: '** Reserved for future use **'
      - id: num_leg
        type: u1
        doc: 'Number of Legs. Variable from 2 to 8'
      - id: leg
        type: leg
        repeat: expr
        repeat-expr: num_leg
        doc: '2 to 8 legs'
  leg:
    seq:
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: leg_ratio_qty
        type: u2
        doc: 'The ratio of this individual leg. Number of option contracts or Number of stock shares for this leg is: LegRatioQty * OrderQty'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of this individual leg'
      - id: reserved_8
        size: 8
        doc: '** Reserved for future use **'
  cancel_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: product_id_or_strategy_id
        type: u4
        doc: 'Emerald Product ID for Liquidity Types “Q” and “E”, and Emerald Strategy ID for Liquidity Type “C” and “X”'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity Type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: bulk_quote_index
        type: u1
        doc: 'Simple Bulk Quote Index assigned by Emerald to each simple quote in bulk quote (quote position in the simple bulk quote); 0 if status is not for a bulk quote'
      - id: quotee_quote_side
        type: u1
        enum: quotee_quote_side
        doc: 'This is the side of the liquidity that is being canceled'
      - id: size
        type: u4
        doc: 'Number of contracts. Max Size: 999,999 This can be changed in a replacement eQuote. Not applicable for eQuote cancel because eQuote cancel request will result in entire remaining size to be canceled'
      - id: engine_sequence_number
        type: u8
        doc: 'Emerald Engine sequence number of this cancel'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Cancel Reason'
  option_execution_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity Type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: bulk_quote_index
        type: u1
        doc: 'Simple Bulk Quote Index assigned by Emerald to each simple quote in bulk quote (quote position in the simple bulk quote); 0 if status is not for a bulk quote'
      - id: event_id
        type: u4
        doc: 'When eQuote Type = “O” or “P”: - Event ID must be zero. Otherwise, eQuote will be rejected. When eQuote Type = “A”: - For Opening event, Event ID must be zero. Otherwise, eQuote will be rejected. - For other Auction/Timer events, Event ID must match the Event ID of the event in progress (Emerald Event ID that was published in the Liquidity seeking event notification) When eQuote Type = “I”, “F” or “S”: Emerald will ignore Event ID. Firms can send an Event ID of zero. This can be changed in a replacement eQuote'
      - id: trade_id
        type: u4
        doc: 'Emerald Trade ID'
      - id: execution_id
        type: u8
        doc: 'Emerald execution ID'
      - id: reserved_1
        size: 1
        doc: '** Reserved for future use **'
      - id: trade_status
        type: u1
        enum: trade_status
        doc: 'Trade Status'
      - id: last_price
        type: decimal_u4_4
        doc: 'Price of this execution. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
      - id: last_size
        type: u4
        doc: 'Number of contracts executed (not cumulative)'
  stock_leg_execution_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity Type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: event_id
        type: u4
        doc: 'When eQuote Type = “O” or “P”: - Event ID must be zero. Otherwise, eQuote will be rejected. When eQuote Type = “A”: - For Opening event, Event ID must be zero. Otherwise, eQuote will be rejected. - For other Auction/Timer events, Event ID must match the Event ID of the event in progress (Emerald Event ID that was published in the Liquidity seeking event notification) When eQuote Type = “I”, “F” or “S”: Emerald will ignore Event ID. Firms can send an Event ID of zero. This can be changed in a replacement eQuote'
      - id: trade_id
        type: u4
        doc: 'Emerald Trade ID'
      - id: execution_id
        type: u8
        doc: 'Emerald execution ID'
      - id: trade_status
        type: u1
        enum: trade_status
        doc: 'Trade Status'
      - id: last_price
        type: decimal_u4_4
        doc: 'Price of this execution. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
      - id: stock_sell_short_indicator
        type: u1
        enum: stock_sell_short_indicator
        doc: 'Sell Short indicator if this complex eQuote sells the stock leg of the strategy'
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
            '"AS"': simple_arm_settings_update_request
            '"AA"': simple_arm_settings_update_response
            '"2S"': arm_2_underlying_level_protection_settings_update_request
            '"2R"': arm_2_underlying_level_protection_settings_update_response
            '"qq"': simple_bulk_quote_message
            '"QR"': simple_bulk_quote_response
            '"eq"': simple_enhanced_quote_e_quote_message
            '"ce"': complex_enhanced_quote_e_quote_message
            '"xq"': simple_mass_quote_cancel_request
            '"XR"': simple_mass_quote_cancel_response
            '"xk"': mass_liquidity_cancel_request_simple_and_complex
            '"XP"': mass_liquidity_cancel_response
            '"PX"': simple_quote_protection_reset_request
            '"PR"': simple_quote_protection_reset_response
            '"PC"': liquidity_protection_reset_request
            '"PK"': liquidity_protection_reset_response
            '"SS"': single_side_liquidity_protection_reset_request
            '"SR"': single_side_liquidity_protection_reset_response
            '"QP"': simple_quote_protection_trigger_notification
            '"QC"': complex_liquidity_protection_trigger_notification
            '"XN"': cancel_notification
  simple_arm_settings_update_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
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
        doc: 'Percentage of quote size at which the Market Maker wants Emerald to trigger ARM protection for this underlying. Please refer to the rules for details of ARM. Maximum value is 65,535 (65,535%). See note below on minimum value'
      - id: counting_period_binary_u_2
        type: u2
        doc: 'Duration (in number of milliseconds) in which Engagement percentage is calculated in order to determine if the MPID should be put on ARM protection for this underlying. Allowable Range: 100 to 15,000 milliseconds Must be a multiple of 100 milliseconds'
  simple_arm_settings_update_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: arm_settings_update_status
        type: u1
        enum: arm_settings_update_status
        doc: 'ARM Settings Update Status'
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
        doc: 'Emerald assigned ID of the Market Maker'
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
      - id: arm_threshold_count_binary_u_4
        type: u4
        doc: 'Number of ARM triggers for the Counting Period for the specified underlying that will trigger ARM2 Underlying level protection. Minimum: 3 Maximum: 99'
      - id: counting_period_binary_u_4
        type: u4
        doc: 'Duration (in number of milliseconds) for which ARM triggers are counted in order to determine if they don’t exceed the specified ARM2 Threshold. Allowable Range: 1000 to 24,300,000 milliseconds Must be a multiple of 1,000 milliseconds'
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
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: arm_settings_update_status
        type: u1
        enum: arm_settings_update_status
        doc: 'ARM Settings Update Status'
  simple_bulk_quote_message:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm’s send time for the Quotes. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: num_single_side_quote
        type: u1
        doc: 'Number of quotes in this bulk quote message'
      - id: reserved_32
        size: 32
        doc: '* Reserved for future use. *'
      - id: single_side_quote
        type: single_side_quote
        repeat: expr
        repeat-expr: num_single_side_quote
        doc: '1 to 50 single-side quotes'
  single_side_quote:
    seq:
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: quote_parameters
        type: u1
        doc: 'Bits 0-1: Quote Handling Instruction 00 - Regular 01 - Post Only 10 - Reserved for future use 11 - Reserved for future use This cannot be changed in a replacement Quote. Bits 2-7: Reserved for future use NOTE: Bit 0 is LSB (Least Significant Bit)'
      - id: price_binary_prc_4u_4
        type: decimal_u4_4
        doc: 'Price up to which the Market Maker is willing to match. Max Price: Defined in Technical Circular This can be changed in a replacement eQuote. This is ignored for eQuote cancels. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of contracts. Max Size: 999,999 This can be changed in a replacement eQuote. Not applicable for eQuote cancel because eQuote cancel request will result in entire remaining size to be canceled'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
      - id: reserved_2
        size: 2
        doc: '* Reserved for future use. *'
  simple_bulk_quote_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: bulk_quote_status
        type: u1
        enum: bulk_quote_status
        doc: 'Bulk Quote Status'
      - id: quote_count
        type: u1
        doc: 'Number of quotes in this bulk quote message'
      - id: num_single_side_quote_response
        type: u1
        doc: 'Number of quotes that were rejected (quotes with a status other than “ “)'
      - id: quote_ack_time
        type: nanosecond_timestamp
        doc: 'Time at which Emerald engine generated this response. Nanoseconds since Midnight epoch'
      - id: single_side_quote_response
        type: single_side_quote_response
        repeat: expr
        repeat-expr: num_single_side_quote_response
        doc: '1 to 50 single-side quote responses'
  single_side_quote_response:
    seq:
      - id: quote_status
        type: u1
        enum: quote_status
        doc: 'Quote status'
      - id: engine_sequence_number
        type: u8
        doc: 'Emerald Engine sequence number of this cancel'
  simple_enhanced_quote_e_quote_message:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm’s send time for the Quotes. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: e_quote_action
        type: u1
        enum: e_quote_action
        doc: 'eQuote Action'
      - id: e_quote_type
        type: u1
        enum: e_quote_type
        doc: 'Type of eQuote'
      - id: event_id
        type: u4
        doc: 'When eQuote Type = “O” or “P”: - Event ID must be zero. Otherwise, eQuote will be rejected. When eQuote Type = “A”: - For Opening event, Event ID must be zero. Otherwise, eQuote will be rejected. - For other Auction/Timer events, Event ID must match the Event ID of the event in progress (Emerald Event ID that was published in the Liquidity seeking event notification) When eQuote Type = “I”, “F” or “S”: Emerald will ignore Event ID. Firms can send an Event ID of zero. This can be changed in a replacement eQuote'
      - id: target_message_id
        type: u4
        doc: 'Zero if this is a new request. Otherwise, Client Message ID of the pending eQuote that is being replaced'
      - id: price_binary_prc_4u_4
        type: decimal_u4_4
        doc: 'Price up to which the Market Maker is willing to match. Max Price: Defined in Technical Circular This can be changed in a replacement eQuote. This is ignored for eQuote cancels. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of contracts. Max Size: 999,999 This can be changed in a replacement eQuote. Not applicable for eQuote cancel because eQuote cancel request will result in entire remaining size to be canceled'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
      - id: reserved_4
        size: 4
        doc: '* Reserved for future use. *'
  complex_enhanced_quote_e_quote_message:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm’s send time for the Quotes. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: strategy_id
        type: u4
        doc: 'Emerald Strategy ID is assigned per trading day and is valid only for that day. ID is not unique between Series Product ID'
      - id: e_quote_action
        type: u1
        enum: e_quote_action
        doc: 'eQuote Action'
      - id: e_quote_type
        type: u1
        enum: e_quote_type
        doc: 'Type of eQuote'
      - id: complex_event_id
        type: u4
        doc: 'When complex eQuote Type = “A”: For Auction events, Event ID must match the Event ID of the event in progress (Emerald Event ID that was published in the Complex Liquidity seeking event notification) When complex eQuote Type is other than “A”: Emerald will ignore Event ID. Firms can send an Event ID of zero'
      - id: target_message_id
        type: u4
        doc: 'Zero if this is a new request. Otherwise, Client Message ID of the pending eQuote that is being replaced'
      - id: price_binary_prc_4s_8
        type: decimal_s8_4
        doc: 'The net limit price for the strategy If Side is “B”: • Positive number represents net debit • Negative number represents net credit If Side is “A”: • Positive number represents net credit • Negative number represents a net debit Price of zero is net neutral transaction for either side. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of contracts. Max Size: 999,999 This can be changed in a replacement eQuote. Not applicable for eQuote cancel because eQuote cancel request will result in entire remaining size to be canceled'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
      - id: stock_sell_short_indicator
        type: u1
        enum: stock_sell_short_indicator
        doc: 'Sell Short indicator if this complex eQuote sells the stock leg of the strategy'
      - id: reserved_15
        size: 15
        doc: 'Reserved'
  simple_mass_quote_cancel_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm’s send time for the Quotes. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: reserved_4
        size: 4
        doc: '* Reserved for future use. *'
  simple_mass_quote_cancel_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: simple_mass_quote_cancel_status
        type: u1
        enum: simple_mass_quote_cancel_status
        doc: 'Simple Mass Quote Cancel Status'
  mass_liquidity_cancel_request_simple_and_complex:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: client_send_time
        type: nanosecond_timestamp
        doc: 'Firm’s send time for the Quotes. Nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: simple_mass_cancel
        type: u1
        enum: simple_mass_cancel
        doc: 'Request to Mass Cancel all Simple liquidities'
      - id: complex_mass_cancel
        type: u1
        enum: complex_mass_cancel
        doc: 'Request to mass cancel all complex liquidities'
      - id: reserved_8
        size: 8
        doc: '** Reserved for future use **'
  mass_liquidity_cancel_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: simple_mass_liquidity_cancel_status
        type: u1
        enum: simple_mass_liquidity_cancel_status
        doc: 'Simple Mass Liquidity Cancel Status'
      - id: complex_mass_liquidity_cancel_status
        type: u1
        enum: complex_mass_liquidity_cancel_status
        doc: 'Complex Mass Liquidity Cancel Status'
  simple_quote_protection_reset_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
  simple_quote_protection_reset_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: quote_protection_reset_status
        type: u1
        enum: quote_protection_reset_status
        doc: 'Quote Protection Reset Status'
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
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: simple_liquidity_reset
        type: u1
        enum: simple_liquidity_reset
        doc: 'Request to reset simple liquidities protection'
      - id: complex_liquidity_reset
        type: u1
        enum: complex_liquidity_reset
        doc: 'Request to reset complex liquidities'
      - id: reserved_8
        size: 8
        doc: '** Reserved for future use **'
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
        doc: 'Emerald assigned ID of the Market Maker'
      - id: simple_liquidity_protection_reset_status
        type: u1
        enum: simple_liquidity_protection_reset_status
        doc: 'Simple Liquidity Protection Reset Status'
      - id: complex_liquidity_protection_reset_status
        type: u1
        enum: complex_liquidity_protection_reset_status
        doc: 'Complex Liquidity Protection Reset Status'
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
        doc: 'Emerald assigned ID of the Market Maker'
      - id: security_id_scope
        type: u1
        enum: security_id_scope
        doc: 'Defines type of security specified in “Security ID” field'
      - id: security_id
        type: u4
        doc: 'Option Product ID if Security ID Scope = “P” Complex Strategy ID if Security ID Scope = “S” If set to zero, will apply reset for both sides of every option or every strategy for the MPID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
      - id: reserved_4
        size: 4
        doc: '* Reserved for future use. *'
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
        doc: 'Emerald assigned ID of the Market Maker'
      - id: reserved_4
        size: 4
        doc: '* Reserved for future use. *'
      - id: status
        type: u1
        enum: status
        doc: 'Status'
  simple_quote_protection_trigger_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: trigger_reason
        type: u1
        enum: trigger_reason
        doc: 'Trigger Reason'
  complex_liquidity_protection_trigger_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by Emerald system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emerald assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: trigger_reason
        type: u1
        enum: trigger_reason
        doc: 'Trigger Reason'
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
        doc: 'Emerald assigned ID for the current trading session'
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
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i
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
      id: 'emerald_will_accept_position_closing_orders_only'
      doc: 'Emerald Will Accept Position Closing Orders Only'
    0x4e:
      id: 'emerald_will_accept_open_and_close_positions'
      doc: 'Emerald Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'far_month_expiration_as_defined_by_emerald_rules'
      doc: 'Far Month Expiration As Defined By Emerald Rules'
    0x4e:
      id: 'near_month_expiration_as_defined_by_emerald_rules'
      doc: 'Near Month Expiration As Defined By Emerald Rules'
  active_on_emerald:
    0x41:
      id: 'active_tradable_on_emerald'
      doc: 'Active Tradable On Emerald'
    0x49:
      id: 'inactive_not_tradable_on_emerald'
      doc: 'Inactive Not Tradable On Emerald'
  emerald_bbo_posting_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Penny (0.01)'
    0x4e:
      id: 'penny_nickel'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Nickel (0.05)'
    0x44:
      id: 'nickel_dime'
      doc: 'Price <= $3: Nickel (0.05); Price > $3: Dime (0.10)'
  quote_acceptance_increment_indicator:
    0x50:
      id: 'penny'
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
      id: 'market_independent_any_market_that_opens_first'
      doc: 'Market Independent Any Market That Opens First'
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
  mpv_class:
    0x50:
      id: 'penny'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Penny (0.01)'
    0x4e:
      id: 'penny_nickel'
      doc: 'Price <= $3: Penny (0.01); Price > $3: Nickel (0.05)'
    0x44:
      id: 'nickel_dime'
      doc: 'Price <= $3: Nickel (0.05); Price > $3: Dime (0.10)'
  e_quote_request_status:
    0x20:
      id: 'request_accepted_successfully'
      doc: 'Request Accepted Successfully'
    0x49:
      id: 'invalid_product_id'
      doc: 'Invalid Product ID / Invalid Strategy ID'
    0x41:
      id: 'no_event_with_such_event_id'
      doc: 'No Event With Such Event Id'
    0x42:
      id: 'invalid_e_quote_action'
      doc: 'Invalid eQuote Action / Invalid complex eQuote Action'
    0x56:
      id: 'invalid_size'
      doc: 'Invalid Size'
    0x4d:
      id: 'e_quote_size_minimum_required_size'
      doc: 'E Quote Size Minimum Required Size'
    0x50:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x54:
      id: 'invalid_e_quote_type'
      doc: 'Invalid eQuote Type / Invalid complex eQuote Type'
    0x53:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x31:
      id: 'e_quote_not_permitted_for_this_price'
      doc: 'E Quote Not Permitted For This Price'
    0x32:
      id: 'e_quote_not_permitted_for_this_side'
      doc: 'eQuote not permitted for this side / Complex eQuote not permitted for this side'
    0x33:
      id: 'e_quote_represented_by_target_message_id_was_not_found'
      doc: 'eQuote represented by target message ID was not found / Complex eQuote represented by target message ID was not found'
    0x34:
      id: 'client_message_id_not_unique'
      doc: 'Client Message Id Not Unique'
    0x55:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x35:
      id: 'rejected_due_to_quote_protection'
      doc: 'Rejected Due To Quote Protection'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x4b:
      id: 'test_e_quote_successfully_accepted_prior_to_lqw_but_not_placed_on_emerald_book'
      doc: 'Test eQuote successfully accepted prior to LQW, but not placed on Emerald book / Test complex eQuote successfully accepted prior to LQW, but not placed on Emerald book'
    0x43:
      id: 'emerald_closed_for_trading_of_this_product_request_cannot_be_completed'
      doc: 'Emerald closed for trading of this product; request cannot be completed / Emerald closed for trading of this strategy; request cannot be completed'
    0x44:
      id: 'rejected_due_to_self_crossing_prime_agency_order'
      doc: 'Rejected due to self-crossing PRIME agency order / Rejected due to self-crossing cPRIME agency order'
    0x59:
      id: 'rejected_due_to_single_side_liquidity_protection_in_effect'
      doc: 'Rejected Due To Single Side Liquidity Protection In Effect'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
    0x4a:
      id: 'outside_price_range_for_strategy'
      doc: 'Outside Price Range For Strategy'
    0x47:
      id: 'complex_feature_is_disabled'
      doc: 'Complex Feature Is Disabled'
    0x37:
      id: 'rejected_due_to_stock_clearing_account_underlying_mpid_or_dtc_account_number_not_configured'
      doc: 'Rejected due to stock clearing account (Underlying MPID or DTC account number) not configured.'
    0x38:
      id: 'invalid_sell_short_indicator'
      doc: 'Invalid Sell Short Indicator'
  system_status:
    0x53:
      id: 'firm_interface_start_up_time_ready_to_accept_application_messages'
      doc: 'Firm Interface Start Up Time Ready To Accept Application Messages'
    0x50:
      id: 'lqw_ready_to_accept_official_quotes'
      doc: 'Lqw Ready To Accept Official Quotes'
    0x43:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x4c:
      id: 'pre_lqw_not_ready_to_accept_official_quotes'
      doc: 'Pre Lqw Not Ready To Accept Official Quotes'
    0x58:
      id: 'system_currently_not_accepting_messages'
      doc: 'System Currently Not Accepting Messages'
    0x31:
      id: 'start_of_test_session_sent_before_tests'
      doc: 'Start of Test Session (sent before tests).'
    0x32:
      id: 'end_of_test_session'
      doc: 'End of Test Session.'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Emerald has halted trading for this Underlying Symbol'
    0x43:
      id: 'closing'
      doc: 'Emerald has initiated Closing rotation for this Product ID'
    0x52:
      id: 'resume'
      doc: 'Emerald will resume trading (reopen) for this Product ID / Underlying Symbol'
    0x4f:
      id: 'open'
      doc: 'Emerald will open trading for this Underlying Symbol'
  event_reason:
    0x41:
      id: 'this_event_resulted_from_automaticmarket_driven_event'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'emerald_manually_initiated_this_event'
      doc: 'Emerald Manually Initiated This Event'
  action:
    0x53:
      id: 'set_add_or_update_arm_settings'
      doc: 'Set (add or update) ARM settings / Set (add or update) ARM2 settings / Set (added or updated) ARM settings'
    0x44:
      id: 'delete_arm_settings'
      doc: 'Delete ARM settings / Deleted ARM settings'
  source:
    0x54:
      id: 'changes_carried_out_by_the_firm_via_mei'
      doc: 'Changes Carried Out By The Firm Via Mei'
    0x45:
      id: 'changes_carried_out_by_the_exchange_global_default_changes_or_firm_requested_settings_applied_manually'
      doc: 'Changes Carried Out By The Exchange Global Default Changes Or Firm Requested Settings Applied Manually'
  security_id_scope:
    0x50:
      id: 'security_id_specifies_option_product_id'
      doc: 'Security Id Specifies Option Product Id'
    0x53:
      id: 'security_id_specifies_complex_strategy_id'
      doc: 'Security Id Specifies Complex Strategy Id'
  side:
    0x42:
      id: 'bid'
      doc: 'Bid (Buy); “B” = Bought in the execution notifications'
    0x41:
      id: 'ask'
      doc: 'Ask (Sell)'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable (Single Side Liquidity Protection Reset Request when Security ID is 0)'
    0x53:
      id: 'sold'
      doc: 'Sold (execution notifications)'
  notification_type:
    0x54:
      id: 'arm_2_underlying_level_protection_triggered'
      doc: 'ARM2 Underlying Level protection Triggered / ARM2 Firm Level protection Triggered'
    0x52:
      id: 'arm_2_underlying_level_protection_reset'
      doc: 'ARM2 Underlying Level protection Reset / ARM2 Firm Level protection Reset'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
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
  liquidity_type:
    0x51:
      id: 'simple_quote'
      doc: 'Simple Quote'
    0x45:
      id: 'simple_e_quote'
      doc: 'Simple E Quote'
    0x43:
      id: 'complex_e_quote'
      doc: 'Complex E Quote'
    0x58:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
  quotee_quote_side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
  cancel_reason:
    0x53:
      id: 'cancel_for_unexecuted_part_of_simplecomplex_e_quote'
      doc: 'Cancel For Unexecuted Part Of Simplecomplex E Quote'
    0x57:
      id: 'cancel_for_quote_unused_in_opening_reopening_or_closing'
      doc: 'Cancel For Quote Unused In Opening Reopening Or Closing'
    0x43:
      id: 'cancel_of_resting_simple_quote_crossed_by_opposite_side_quote_of_same_mpid'
      doc: 'Cancel Of Resting Simple Quote Crossed By Opposite Side Quote Of Same Mpid'
    0x4b:
      id: 'complex_strategy_leg_has_wide_mbbo_only_applicable_to_complex_e_quotes'
      doc: 'Complex Strategy leg has wide MBBO. Only applicable to Complex eQuotes.'
    0x4c:
      id: 'complex_strategy_leg_has_prime_auction'
      doc: 'Complex Strategy leg has PRIME Auction. Only applicable to Complex eQuotes'
    0x4d:
      id: 'complex_strategy_leg_has_route_timer'
      doc: 'Complex Strategy leg has Route Timer. Only applicable to Complex eQuotes.'
    0x4e:
      id: 'complex_strategy_leg_has_liquidity_refresh_timer'
      doc: 'Complex Strategy leg has Liquidity Refresh Timer. Only applicable to Complex eQuotes.'
    0x4a:
      id: 'complex_strategy_auction_in_progress'
      doc: 'Complex Strategy Auction in progress. Only applicable to Complex eQuotes.'
    0x52:
      id: 'complex_strategy_leg_has_liquidity_exposure_timer'
      doc: 'Complex Strategy leg has Liquidity Exposure Timer. Only applicable to Complex eQuotes'
    0x51:
      id: 'strategy_is_not_open_for_trading'
      doc: 'Strategy is not open for trading. Only applicable to IOC Complex eQuotes.'
    0x42:
      id: 'canceled_due_to_single_side_liquidity_protection_trigger'
      doc: 'Canceled due to Single Side Liquidity Protection trigger.'
    0x50:
      id: 'post_only_canceled_due_to_locking_or_crossing_managed_interest_on_the_opposite_side'
      doc: 'Post Only Canceled Due To Locking Or Crossing Managed Interest On The Opposite Side'
  trade_status:
    0x45:
      id: 'new_execution'
      doc: 'New Execution'
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
      id: 'not_applicable'
      doc: '(space) = N/A (Not applicable)'
  arm_settings_update_status:
    0x20:
      id: 'settings_applied_successfully'
      doc: 'Settings Applied Successfully'
    0x41:
      id: 'invalid_action'
      doc: 'Invalid Action'
    0x50:
      id: 'invalid_allowable_engagement_percentage'
      doc: 'Invalid Allowable Engagement Percentage / Invalid ARM Threshold'
    0x44:
      id: 'invalid_counting_period'
      doc: 'Invalid Counting Period'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x4e:
      id: 'no_such_arm_settings'
      doc: 'No such ARM settings / No such ARM2 setting'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x45:
      id: 'feature_not_supported'
      doc: 'Feature Not Supported'
  bulk_quote_status:
    0x20:
      id: 'bulk_quote_block_is_valid'
      doc: 'Bulk Quote Block Is Valid'
    0x52:
      id: 'invalid_bulk_quote_block'
      doc: 'Invalid Bulk Quote Block'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
  quote_status:
    0x20:
      id: 'quote_successfully_accepted'
      doc: 'Quote Successfully Accepted'
    0x54:
      id: 'test_quote_successfully_accepted_prior_to_lqw_but_not_placed_on_emerald_book'
      doc: 'Test Quote Successfully Accepted Prior To Lqw But Not Placed On Emerald Book'
    0x43:
      id: 'emerald_closed_for_trading_of_this_product_request_cannot_be_completed'
      doc: 'Emerald Closed For Trading Of This Product Request Cannot Be Completed'
    0x4f:
      id: 'invalid_product_id'
      doc: 'Invalid Product Id'
    0x50:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x51:
      id: 'invalid_size'
      doc: 'Invalid Size'
    0x53:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x55:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x4d:
      id: 'quote_size_minimum_required_size'
      doc: 'Quote Size Minimum Required Size'
    0x52:
      id: 'rejected_due_to_quote_protection'
      doc: 'Rejected Due To Quote Protection'
    0x44:
      id: 'rejected_due_to_self_crossing_prime_agency_order'
      doc: 'Rejected Due To Self Crossing Prime Agency Order'
    0x59:
      id: 'rejected_due_to_single_side_liquidity_protection_in_effect'
      doc: 'Rejected Due To Single Side Liquidity Protection In Effect'
    0x41:
      id: 'invalid_to_change'
      doc: 'Invalid To Change'
    0x42:
      id: 'invalid_quote_handling_instruction'
      doc: 'Invalid Quote Handling Instruction'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
  e_quote_action:
    0x4e:
      id: 'new_e_quote'
      doc: 'New eQuote / New complex eQuote'
    0x43:
      id: 'cancel_e_quote'
      doc: 'Cancel eQuote / Cancel pending complex eQuote'
    0x52:
      id: 'replace_e_quote'
      doc: 'Replace eQuote / Replace complex eQuote'
  e_quote_type:
    0x4f:
      id: 'opg'
      doc: 'OPG (good for Opening transaction only)'
    0x41:
      id: 'aoc'
      doc: 'AOC (good for specified Event only)'
    0x49:
      id: 'ioc'
      doc: 'IOC (Immediate match or cancel)'
    0x46:
      id: 'fok'
      doc: 'FOK (Fill-Or-Kill; IOC+All-or-None)'
    0x53:
      id: 'iso'
      doc: 'ISO (IOC; Ignore ABBO and match)'
    0x50:
      id: 'future_use'
      doc: 'n/a (Future use)'
  simple_mass_quote_cancel_status:
    0x20:
      id: 'cancel_successful'
      doc: 'Cancel Successful'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x49:
      id: 'mass_quote_cancel_still_in_progress'
      doc: 'Mass Quote Cancel Still In Progress'
    0x48:
      id: 'halt_triggered_cleanup_of_quotes_still_in_progress'
      doc: 'Halt Triggered Cleanup Of Quotes Still In Progress'
    0x4e:
      id: 'all_quote_have_already_been_canceled'
      doc: 'All Quote Have Already Been Canceled'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x43:
      id: 'emerald_closed_request_cannot_be_completed'
      doc: 'Emerald Closed Request Cannot Be Completed'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
  simple_mass_cancel:
    0x59:
      id: 'mass_cancel_simple_quotes_and_e_quotes'
      doc: 'Mass Cancel Simple Quotes And E Quotes'
    0x4e:
      id: 'do_not_mass_cancel_simple_quotes_and_e_quotes'
      doc: 'Do Not Mass Cancel Simple Quotes And E Quotes'
    0x51:
      id: 'mass_cancel_simple_quotes_only_underlying_symbol_must_be_filled_with_valid_underlying_for_this_option'
      doc: 'Mass Cancel Simple Quotes only (Underlying symbol must be filled with valid underlying for this option). eQuotes are not cancelled and do not require reset to send new ones.'
  complex_mass_cancel:
    0x59:
      id: 'mass_cancel_complex_e_quotes_only'
      doc: 'Mass Cancel Complex E Quotes Only'
    0x4e:
      id: 'do_not_mass_cancel_complex_liquidities'
      doc: 'Do Not Mass Cancel Complex Liquidities'
  simple_mass_liquidity_cancel_status:
    0x20:
      id: 'simple_mass_liquidity_cancel_successful'
      doc: 'Simple Mass Liquidity Cancel Successful'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x49:
      id: 'simple_mass_liquidity_cancel_still_in_progress'
      doc: 'Simple Mass Liquidity Cancel Still In Progress'
    0x48:
      id: 'halt_triggered_cleanup_of_liquidities_still_in_progress'
      doc: 'Halt Triggered Cleanup Of Liquidities Still In Progress'
    0x4e:
      id: 'all_liquidities_have_already_been_canceled'
      doc: 'All Liquidities Have Already Been Canceled'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x43:
      id: 'emerald_closed_request_cannot_be_completed'
      doc: 'Emerald Closed Request Cannot Be Completed'
    0x4a:
      id: 'invalid_request'
      doc: 'Invalid Request'
    0x45:
      id: 'feature_not_supported'
      doc: 'Feature Not Supported'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x51:
      id: 'not_requested'
      doc: 'Not Requested'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  complex_mass_liquidity_cancel_status:
    0x20:
      id: 'complex_mass_liquidity_cancel_successful'
      doc: 'Complex Mass Liquidity Cancel Successful'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x49:
      id: 'complex_mass_liquidity_cancel_still_in_progress'
      doc: 'Complex Mass Liquidity Cancel Still In Progress'
    0x48:
      id: 'halt_triggered_cleanup_of_liquidities_still_in_progress'
      doc: 'Halt Triggered Cleanup Of Liquidities Still In Progress'
    0x4e:
      id: 'all_liquidities_have_already_been_canceled'
      doc: 'All Liquidities Have Already Been Canceled'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x43:
      id: 'emerald_closed_request_cannot_be_completed'
      doc: 'Emerald Closed Request Cannot Be Completed'
    0x4a:
      id: 'invalid_request'
      doc: 'Invalid Request'
    0x45:
      id: 'feature_not_supported'
      doc: 'Feature Not Supported'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x51:
      id: 'not_requested'
      doc: 'Not Requested'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  quote_protection_reset_status:
    0x20:
      id: 'quote_protection_reset_successful'
      doc: 'Quote Protection Reset Successful'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x49:
      id: 'mass_quote_cancel_still_in_progress'
      doc: 'Mass Quote Cancel Still In Progress'
    0x48:
      id: 'halt_triggered_cleanup_of_quotes_still_in_progress'
      doc: 'Halt Triggered Cleanup Of Quotes Still In Progress'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x43:
      id: 'emerald_closed_request_cannot_be_completed'
      doc: 'Emerald Closed Request Cannot Be Completed'
    0x41:
      id: 'arm_2_underlying_level_protection_is_in_effect'
      doc: 'Arm 2 Underlying Level Protection Is In Effect'
    0x46:
      id: 'arm_2_firm_level_protection_is_in_effect'
      doc: 'Arm 2 Firm Level Protection Is In Effect'
    0x4b:
      id: 'kill_switch_protection_is_in_effect'
      doc: 'Kill Switch Protection Is In Effect'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  simple_liquidity_reset:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  complex_liquidity_reset:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  simple_liquidity_protection_reset_status:
    0x20:
      id: 'simple_liquidity_protection_reset_successful'
      doc: 'Simple Liquidity Protection Reset Successful'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x49:
      id: 'simple_mass_liquidity_cancel_still_in_progress'
      doc: 'Simple Mass Liquidity Cancel Still In Progress'
    0x48:
      id: 'halt_triggered_cleanup_of_liquidates_still_in_progress'
      doc: 'Halt Triggered Cleanup Of Liquidates Still In Progress'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x43:
      id: 'emerald_closed_request_cannot_be_completed'
      doc: 'Emerald Closed Request Cannot Be Completed'
    0x41:
      id: 'arm_2_underlying_level_protection_is_in_effect'
      doc: 'Arm 2 Underlying Level Protection Is In Effect'
    0x46:
      id: 'arm_2_firm_level_protection_is_in_effect'
      doc: 'Arm 2 Firm Level Protection Is In Effect'
    0x4b:
      id: 'kill_switch_protection_is_in_effect'
      doc: 'Kill Switch Protection Is In Effect'
    0x45:
      id: 'feature_not_supported'
      doc: 'Feature Not Supported'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x4a:
      id: 'invalid_request'
      doc: 'Invalid Request'
    0x51:
      id: 'not_requested'
      doc: 'Not Requested'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  complex_liquidity_protection_reset_status:
    0x20:
      id: 'complex_liquidity_protection_reset_successful'
      doc: 'Complex Liquidity Protection Reset Successful'
    0x55:
      id: 'invalid_underlying'
      doc: 'Invalid Underlying'
    0x49:
      id: 'complex_mass_liquidity_cancel_still_in_progress'
      doc: 'Complex Mass Liquidity Cancel Still In Progress'
    0x48:
      id: 'halt_triggered_cleanup_of_liquidities_still_in_progress'
      doc: 'Halt Triggered Cleanup Of Liquidities Still In Progress'
    0x4d:
      id: 'unknown_mpid'
      doc: 'Unknown Mpid'
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x43:
      id: 'emerald_closed_request_cannot_be_completed'
      doc: 'Emerald Closed Request Cannot Be Completed'
    0x41:
      id: 'arm_2_underlying_level_protection_is_in_effect'
      doc: 'Arm 2 Underlying Level Protection Is In Effect'
    0x46:
      id: 'arm_2_firm_level_protection_is_in_effect'
      doc: 'Arm 2 Firm Level Protection Is In Effect'
    0x4b:
      id: 'kill_switch_protection_is_in_effect'
      doc: 'Kill Switch Protection Is In Effect'
    0x45:
      id: 'feature_not_supported'
      doc: 'Feature Not Supported'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x4a:
      id: 'invalid_request'
      doc: 'Invalid Request'
    0x51:
      id: 'not_requested'
      doc: 'Not Requested'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  status:
    0x20:
      id: 'single_side_protection_reset_request_successful'
      doc: 'Single Side Protection Reset Request Successful'
    0x4d:
      id: 'invalid_mpid'
      doc: 'Invalid Mpid'
    0x43:
      id: 'invalid_security_id_scope'
      doc: 'Invalid Security Id Scope'
    0x49:
      id: 'invalid_security_id'
      doc: 'Invalid Security Id'
    0x53:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x45:
      id: 'feature_not_enabled'
      doc: 'Feature Not Enabled'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
    0x2a:
      id: 'downgraded_from_older_version'
      doc: 'Downgraded From Older Version'
  trigger_reason:
    0x45:
      id: 'exchange_initiated_mass_quote_cancel'
      doc: 'Exchange initiated mass quote cancel / Exchange initiated mass liquidity cancel'
    0x55:
      id: 'firm_initiated_mass_quote_cancel'
      doc: 'Firm initiated mass quote cancel / Firm initiated mass liquidity cancel'
    0x52:
      id: 'arm_triggered_protection'
      doc: 'ARM triggered protection / Reserved for future use'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x4b:
      id: 'kill_switch_protection_is_in_effect_future_use'
      doc: 'Kill Switch Protection is in effect (Future Use) / Kill Switch Protection is in effect'
    0x46:
      id: 'arm_2_firm_level_protection_initiated_mass_quote_cancel'
      doc: 'ARM2 Firm level protection initiated mass quote cancel / ARM2 Firm-level protection-initiated mass liquidity cancel'
    0x4a:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
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

