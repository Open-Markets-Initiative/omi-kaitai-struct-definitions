# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax MiaxOptions ExpressInterface Mei v1.4
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Express Interface
#   Encoding: Miax Express Interface
#   Version: 1.4
#   Date: 03/28/2013
#   Specification: MIAX_Express_Interface_MEI_v1_4.pdf
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
  id: miax_miaxoptions_expressinterface_mei_v1_4
  title: Miax MiaxOptions ExpressInterface Mei v1.4
  license: MIT-0
  endian: le

doc: 'Miami International Holdings MIAX Options Express Interface Mei v1.4'
doc-ref: https://www.miaxglobal.com/markets/us-options/miax-options/interface-specifications

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
            '"QW"': valid_quote_width_for_opening
            '"ER"': enhanced_quote_e_quote_response
            '"SN"': system_state_notification
            '"TN"': trading_status_notification
            '"QN"': quote_width_relief_notification
            '"AN"': arm_protection_settings_notification
            '"XN"': cancel_notification
            '"EN"': execution_notification
  series_update:
    seq:
      - id: product_add_update_time
        type: nanosecond_timestamp
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
      - id: active_on_miax
        type: u1
        enum: active_on_miax
        doc: 'Indicates if this symbol is tradable on MIAX in the current session'
      - id: miax_bbo_posting_increment_indicator
        type: u1
        enum: miax_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by MIAX'
      - id: quote_acceptance_increment_indicator
        type: u1
        enum: quote_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Quote acceptance as per MIAX rules'
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
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
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
  enhanced_quote_e_quote_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: e_quote_id
        type: u8
        doc: 'MIAX assigned ID for eQuote if accepted; Zero if eQuote was rejected. Replaced eQuote will have the same eQuote ID as original'
      - id: e_quote_request_status
        type: u1
        enum: e_quote_request_status
        doc: 'eQuote Request Status'
  system_state_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: mei_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg:MEI1.02'
      - id: session_id
        type: u1
        doc: 'MIAX assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'System Status'
  trading_status_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: expected_event_time
        type: nanosecond_timestamp
        doc: 'Expected time of start of the event as specified below: When trading status=”H”, this will be 0 (zero). When trading status =”C”, this will be the time at which Closing rotation will start for this Product When trading status = “R”, this will be the time at which the reopening process will start for this Product. Nanoseconds since Midnight epoch'
  quote_width_relief_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: relief_multiplier
        type: decimal_u4_4
        doc: 'Relief is the multiplier times the regular acceptable quote width. Eg: For a series with quote width of $0.25, a relief multiplier of 2 implies that the acceptable quote width is $0.50. Implied decimal with scale 1e-4'
  arm_protection_settings_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: allowable_engagement_percentage
        type: u4
        doc: 'Percentage of quote size at which the Market Maker wants MIAX to trigger ARM protection for this underlying. Please refer to the rules for details of ARM. Minimum value is 100 (100%). Maximum is 65,535 (65,535%)'
      - id: counting_period
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
  cancel_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity Type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: bulk_quote_index
        type: u1
        doc: 'Bulk Quote Index assigned by MIAX to each quote in bulk quote (quote position in the bulk quote); 0 if status is not for a bulk quote'
      - id: quotee_quote_side
        type: u1
        enum: quotee_quote_side
        doc: 'This is the side of the liquidity that is being canceled'
      - id: size
        type: u4
        doc: 'Number of contracts. Max Size: 999,999 This can be changed in a replacement eQuote. Not applicable for eQuote cancel because eQuote cancel request will result in entire remaining size to be canceled'
      - id: engine_sequence_number
        type: u8
        doc: 'MIAX Engine sequence number of this cancel'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Cancel Reason'
  execution_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: liquidity_type
        type: u1
        enum: liquidity_type
        doc: 'Liquidity Type'
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: bulk_quote_index
        type: u1
        doc: 'Bulk Quote Index assigned by MIAX to each quote in bulk quote (quote position in the bulk quote); 0 if status is not for a bulk quote'
      - id: event_id
        type: u4
        doc: 'When eQuote Type = “A”: - For Opening event, Event ID must be zero. Otherwise, eQuote will be rejected. - For other Auction/Timer events, Event ID must match the Event ID of the event in progress (MIAX Event ID that was published in the Liquidity seeking event notification) When eQuote Type is other than “A”: MIAX will ignore Event ID. Firms can send an Event ID of zero. This can be changed in a replacement eQuote'
      - id: trade_id
        type: u4
        doc: 'MIAX Trade ID'
      - id: execution_id
        type: u8
        doc: 'MIAX execution ID'
      - id: reserved_1
        size: 1
        doc: '* Reserved for future use *'
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
            '"QM"': bulk_quote_message
            '"QR"': bulk_quote_response
            '"EQ"': enhanced_quote_e_quote_message
            '"XQ"': mass_quote_cancel_request
            '"XR"': mass_quote_cancel_response
            '"PX"': quote_protection_reset_request
            '"PR"': quote_protection_reset_response
            '"QP"': quote_protection_trigger_notification
            '"LN"': liquidity_seeking_event_notification
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
        doc: 'MIAX assigned ID of the Market Maker'
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
        doc: 'Percentage of quote size at which the Market Maker wants MIAX to trigger ARM protection for this underlying. Please refer to the rules for details of ARM. Minimum value is 100 (100%). Maximum is 65,535 (65,535%)'
      - id: counting_period
        type: u2
        doc: 'Duration (in number of milliseconds) in which Engagement percentage is calculated in order to determine if the MPID should be put on ARM protection for this underlying. Allowable Range: 100 to 15,000 milliseconds Must be a multiple of 100 milliseconds'
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
        doc: 'MIAX assigned ID of the Market Maker'
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
  bulk_quote_message:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: num_single_side_quote
        type: u1
        doc: 'Number of quotes in this bulk quote message'
      - id: single_side_quote
        type: single_side_quote
        repeat: expr
        repeat-expr: num_single_side_quote
        doc: '1 to 50 single-side quotes'
  single_side_quote:
    seq:
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: price
        type: decimal_u4_4
        doc: 'Price up to which the Market Maker is willing to match. Max Price: 99,999.999 This can be changed in a replacement eQuote. This is ignored for eQuote cancels. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of contracts. Max Size: 999,999 This can be changed in a replacement eQuote. Not applicable for eQuote cancel because eQuote cancel request will result in entire remaining size to be canceled'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
  bulk_quote_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: bulk_quote_status
        type: u1
        enum: bulk_quote_status
        doc: 'Bulk Quote Status'
      - id: quote_count
        type: u1
        doc: 'Number of quotes in this bulk quote message'
      - id: num_single_side_quote_response
        type: u1
        doc: 'Number of quotes that were rejected (quotes with status other than “ “)'
      - id: quote_ack_time
        type: nanosecond_timestamp
        doc: 'Time at which MIAX engine generated this response. Nanoseconds since Midnight epoch'
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
        doc: 'MIAX Engine sequence number of this cancel'
  enhanced_quote_e_quote_message:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'When eQuote Type = “A”: - For Opening event, Event ID must be zero. Otherwise, eQuote will be rejected. - For other Auction/Timer events, Event ID must match the Event ID of the event in progress (MIAX Event ID that was published in the Liquidity seeking event notification) When eQuote Type is other than “A”: MIAX will ignore Event ID. Firms can send an Event ID of zero. This can be changed in a replacement eQuote'
      - id: target_message_id
        type: u4
        doc: 'Zero if this is a new request. Otherwise, Client Message ID of the pending eQuote that is being replaced'
      - id: price
        type: decimal_u4_4
        doc: 'Price up to which the Market Maker is willing to match. Max Price: 99,999.999 This can be changed in a replacement eQuote. This is ignored for eQuote cancels. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Number of contracts. Max Size: 999,999 This can be changed in a replacement eQuote. Not applicable for eQuote cancel because eQuote cancel request will result in entire remaining size to be canceled'
      - id: side
        type: u1
        enum: side
        doc: 'Side of this eQuote'
  mass_quote_cancel_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
  mass_quote_cancel_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: mass_quote_cancel_status
        type: u1
        enum: mass_quote_cancel_status
        doc: 'Mass Quote Cancel Status'
  quote_protection_reset_request:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
  quote_protection_reset_response:
    seq:
      - id: client_message_id
        type: u4
        doc: 'Unique message ID assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
      - id: quote_protection_reset_status
        type: u1
        enum: quote_protection_reset_status
        doc: 'Quote Protection Reset Status'
  quote_protection_trigger_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned ID of the Market Maker'
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
  liquidity_seeking_event_notification:
    seq:
      - id: notification_time
        type: nanosecond_timestamp
        doc: 'Time at which this was generated by MIAX system. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: event_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of Event: ‘L’: Liquidity Refresh Mechanism ‘O’: Opening/Reopening Imbalance Mechanism ‘R’: Route Mechanism'
      - id: event_id
        type: u4
        doc: 'When eQuote Type = “A”: - For Opening event, Event ID must be zero. Otherwise, eQuote will be rejected. - For other Auction/Timer events, Event ID must match the Event ID of the event in progress (MIAX Event ID that was published in the Liquidity seeking event notification) When eQuote Type is other than “A”: MIAX will ignore Event ID. Firms can send an Event ID of zero. This can be changed in a replacement eQuote'
      - id: price
        type: decimal_u4_4
        doc: 'Price up to which the Market Maker is willing to match. Max Price: 99,999.999 This can be changed in a replacement eQuote. This is ignored for eQuote cancels. Implied decimal with scale 1e-4'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'This is the side of the excess liquidity that is waiting to get matched. Usage: When Event Type is ‘O’: Imbalance Side. When Event Type is ‘R’: Side that will be routed. When Event Type is ‘L’: Side of oversized order initiating liquidity refresh. Please refer to Appendix D for details'
      - id: quantity_1
        type: u4
        doc: 'Usage: When Event Type is ‘O’, ‘L’ or ‘R’: MatchQty - Number of contracts ready to be matched (both buyers and sellers already present). Other Event Types: 0 (zero) Please refer to Appendix D for details'
      - id: quantity_2
        type: u4
        doc: 'Usage: When Event Type is ‘O’, ‘L’ or ‘R’: Routable Quantity. Number of contracts that may be routed. Other Event Types: 0 (zero) Please refer to Appendix D for details'
      - id: quantity_3
        type: u4
        doc: 'Usage: When Event Type is ‘O’,‘L’ or ‘R’: Imbalance Quantity. Number of contracts on the Imbalance Side that cannot be matched. Other Event Types: 0 (zero) Please refer to Appendix D for details'
      - id: quantity_4
        type: u4
        doc: 'Usage: When Event Type is ‘O’, ‘L’ or ‘R’: Must Fill Quantity. Number of contracts, on the provided Side, that must be matched at the provided Price. These contracts are crossing the provided Price and MIAX is seeking liquidity for these contracts. Other Event Types: 0 (zero) Please refer to Appendix D for details'
      - id: attributable_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned Attributable ID (Executing Broker MPID) of an Order. Otherwise, it is space filled'
      - id: reserved_8
        size: 8
        doc: '** Reserved for future use **'
  login_request:
    seq:
      - id: sesm_version
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: '1.0 (right padded with spaces)'
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
        doc: 'MIAX assigned ID for the current trading session'
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
      id: 'miax_will_accept_position_closing_orders_only'
      doc: 'Miax Will Accept Position Closing Orders Only'
    0x4e:
      id: 'miax_will_accept_open_and_close_positions'
      doc: 'Miax Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'far_month_expiration_as_defined_by_miax_rules'
      doc: 'Far Month Expiration As Defined By Miax Rules'
    0x4e:
      id: 'near_month_expiration_as_defined_by_miax_rules'
      doc: 'Near Month Expiration As Defined By Miax Rules'
  active_on_miax:
    0x41:
      id: 'active_tradable_on_miax'
      doc: 'Active Tradable On Miax'
    0x49:
      id: 'inactive_not_tradable_on_miax'
      doc: 'Inactive Not Tradable On Miax'
  miax_bbo_posting_increment_indicator:
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
      doc: 'Invalid Product Id'
    0x41:
      id: 'no_event_with_such_event_id'
      doc: 'No Event With Such Event Id'
    0x42:
      id: 'invalid_e_quote_action'
      doc: 'Invalid E Quote Action'
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
      doc: 'Invalid E Quote Type'
    0x53:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x31:
      id: 'e_quote_not_permitted_for_this_price'
      doc: 'E Quote Not Permitted For This Price'
    0x32:
      id: 'e_quote_not_permitted_for_this_side'
      doc: 'E Quote Not Permitted For This Side'
    0x33:
      id: 'e_quote_represented_by_target_message_id_was_not_found'
      doc: 'E Quote Represented By Target Message Id Was Not Found'
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
      id: 'test_e_quote_successfully_accepted_prior_to_lqw_but_not_placed_on_miax_book'
      doc: 'Test E Quote Successfully Accepted Prior To Lqw But Not Placed On Miax Book'
    0x43:
      id: 'miax_closed_for_trading_of_this_product_request_cannot_be_completed'
      doc: 'Miax Closed For Trading Of This Product Request Cannot Be Completed'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
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
      doc: 'MIAX has halted trading for this Product ID'
    0x43:
      id: 'closing'
      doc: 'MIAX has initiated Closing rotation for this Product ID'
    0x52:
      id: 'resume'
      doc: 'MIAX will resume trading (reopen) for this product ID'
  action:
    0x53:
      id: 'set_add_or_update_arm_settings'
      doc: 'Set (add or update) ARM settings / Set (added or updated) ARM settings'
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
  liquidity_type:
    0x51:
      id: 'quote'
      doc: 'Quote'
    0x45:
      id: 'e_quote'
      doc: 'E Quote'
  quotee_quote_side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
  cancel_reason:
    0x45:
      id: 'exchange_initiated_cancel'
      doc: 'Exchange Initiated Cancel'
    0x55:
      id: 'firm_initiated_cancel'
      doc: 'Firm Initiated Cancel'
    0x49:
      id: 'canceled_due_to_inactivation_of_option'
      doc: 'Canceled Due To Inactivation Of Option'
    0x52:
      id: 'canceled_due_to_arm_protection'
      doc: 'Canceled Due To Arm Protection'
    0x53:
      id: 'cancel_for_unexecuted_part_of_e_quote'
      doc: 'Cancel For Unexecuted Part Of E Quote'
    0x57:
      id: 'cancel_for_quote_unused_in_opening_reopening_or_closing'
      doc: 'Cancel For Quote Unused In Opening Reopening Or Closing'
    0x43:
      id: 'cancel_of_resting_quote_crossed_by_opposite_side_quote_of_same_mpid'
      doc: 'Cancel Of Resting Quote Crossed By Opposite Side Quote Of Same Mpid'
    0x4d:
      id: 'canceled_due_to_deletion_of_mpid'
      doc: 'Canceled Due To Deletion Of Mpid'
    0x50:
      id: 'canceled_due_to_deletion_of_mpid_underlying_permission'
      doc: 'Canceled Due To Deletion Of Mpid Underlying Permission'
    0x54:
      id: 'canceled_due_to_trading_halt'
      doc: 'Canceled Due To Trading Halt'
  trade_status:
    0x45:
      id: 'new_execution'
      doc: 'New Execution'
  side:
    0x42:
      id: 'bid'
      doc: 'Bid (Buy); “B” = Bought in the execution notifications'
    0x41:
      id: 'ask'
      doc: 'Ask (Sell)'
    0x53:
      id: 'sold'
      doc: 'Sold (execution notifications)'
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
    0x58:
      id: 'not_permitted'
      doc: 'Not Permitted'
    0x4e:
      id: 'no_such_arm_settings'
      doc: 'No Such Arm Settings'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
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
      id: 'test_quote_successfully_accepted_prior_to_lqw_but_not_placed_on_miax_book'
      doc: 'Test Quote Successfully Accepted Prior To Lqw But Not Placed On Miax Book'
    0x43:
      id: 'miax_closed_for_trading_of_this_product_request_cannot_be_completed'
      doc: 'Miax Closed For Trading Of This Product Request Cannot Be Completed'
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
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
  e_quote_action:
    0x4e:
      id: 'new_e_quote'
      doc: 'New E Quote'
    0x43:
      id: 'cancel_e_quote'
      doc: 'Cancel E Quote'
    0x52:
      id: 'replace_e_quote'
      doc: 'Replace E Quote'
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
  mass_quote_cancel_status:
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
      id: 'miax_closed_request_cannot_be_completed'
      doc: 'Miax Closed Request Cannot Be Completed'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
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
      id: 'miax_closed_request_cannot_be_completed'
      doc: 'Miax Closed Request Cannot Be Completed'
    0x5a:
      id: 'undefined_error'
      doc: 'Undefined Error'
  trigger_reason:
    0x45:
      id: 'exchange_initiated_mass_quote_cancel'
      doc: 'Exchange Initiated Mass Quote Cancel'
    0x55:
      id: 'firm_initiated_mass_quote_cancel'
      doc: 'Firm Initiated Mass Quote Cancel'
    0x52:
      id: 'arm_triggered_protection'
      doc: 'Arm Triggered Protection'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  imbalance_side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
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

