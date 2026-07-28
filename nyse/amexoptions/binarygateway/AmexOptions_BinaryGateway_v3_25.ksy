# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Nyse AmexOptions BinaryGateway v3.25
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: amexoptions_binarygateway_v3_25
  title: Nyse AmexOptions BinaryGateway PillarStream v3.25
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Amex Options Binary Gateway PillarStream v3.25'
doc-ref: https://www.nyse.com/connectivity/specs

seq:
  - id: login_message
    type: login_message_struct
    doc: 'Client must send Login before any other message'
  - id: login_response
    type: login_response_struct
    doc: 'Pillar Stream Login Response Message Branch'
  - id: stream_avail
    type: stream_avail_struct
    doc: 'The message contains stream ID and sequence of next message on stream'
  - id: heartbeat
    type: heartbeat_struct
    doc: 'Heartbeat must be sent once a second'
  - id: open
    type: open_struct
    doc: 'Request open a stream for reading or writing'
  - id: open_response
    type: open_response_struct
    doc: 'Response to Open'
  - id: close
    type: close_struct
    doc: 'Request close stream'
  - id: close_response
    type: close_response_struct
    doc: 'Response to Close Message'
  - id: seq_msg
    type: seq_msg_struct
    doc: 'Used to transmit a stream message'

types:
  login_message_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Gateway session identifier (SenderCompID)'
      - id: password
        type: str
        size: 32
        encoding: ASCII
        doc: 'User password in plain text'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code of the connected market'
      - id: version
        type: str
        size: 20
        encoding: ASCII
        doc: 'Protocol version, should be 1.1'
  msg_header:
    seq:
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Pillar stream message type'
      - id: msg_length
        type: u2
        doc: 'Total message length, including this header'
  login_response_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Gateway session identifier (SenderCompID)'
      - id: status
        type: u1
        enum: status
        doc: 'Pillar Status Code'
  stream_avail_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: next_seq
        type: u8
        doc: 'Next sequence number'
      - id: access
        type: u1
        doc: 'Available access on the stream'
  stream_id:
    seq:
      - id: sess
        type: u4
        doc: '32 bit session id'
      - id: user
        type: u4
        doc: 'Id of stream within session'
  heartbeat_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
  open_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: start_seq
        type: u8
        doc: 'Start sequence number'
      - id: end_seq
        type: u8
        doc: 'End sequence (ignored for write request)'
      - id: access
        type: u1
        doc: 'Available access on the stream'
      - id: mode
        type: u1
        doc: 'Mode requested'
  open_response_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Pillar Status Code'
      - id: access
        type: u1
        doc: 'Available access on the stream'
  close_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
  close_response_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Pillar Status Code'
  seq_msg_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: seq_msg_id
        type: seq_msg_id
        doc: 'Pillar Stream Sequenced Message Identifier'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: timestamp
        type: u8
        doc: 'Message timestamp'
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: sequenced_message
        size: msg_header.msg_length - 36
        type:
          switch-on: seq_msg_header.seq_msg_type
          cases:
            'seq_msg_type::session_configuration_request_message': session_configuration_request_message
            'seq_msg_type::new_order_message': new_order_message
            'seq_msg_type::order_cancel_request_message': order_cancel_request_message
            'seq_msg_type::order_modify_request_message': order_modify_request_message
            'seq_msg_type::new_bulk_quote_type_243_message': new_bulk_quote_type_243_message
            'seq_msg_type::new_bulk_quote_type_259_message': new_bulk_quote_type_259_message
            'seq_msg_type::new_order_cross_message': new_order_cross_message
            'seq_msg_type::bulk_cancel_request_type_223_message': bulk_cancel_request_type_223_message
            'seq_msg_type::bulk_cancel_request_type_224_message': bulk_cancel_request_type_224_message
            'seq_msg_type::risk_limit_update_request_message': risk_limit_update_request_message
            'seq_msg_type::risk_action_request_message': risk_action_request_message
            'seq_msg_type::new_complex_series_request_message': new_complex_series_request_message
            'seq_msg_type::underlying_symbol_reference_data_message': underlying_symbol_reference_data_message
            'seq_msg_type::series_reference_data_message': series_reference_data_message
            'seq_msg_type::minimum_price_variant_class_reference_data_message': minimum_price_variant_class_reference_data_message
            'seq_msg_type::minimum_price_variant_level_reference_data_message': minimum_price_variant_level_reference_data_message
            'seq_msg_type::mpid_configuration_message': mpid_configuration_message
            'seq_msg_type::options_market_maker_symbol_appointment_reference_data_message': options_market_maker_symbol_appointment_reference_data_message
            'seq_msg_type::session_configuration_acknowledgement_message': session_configuration_acknowledgement_message
            'seq_msg_type::order_and_cancel_replace_acknowledgement_message': order_and_cancel_replace_acknowledgement_message
            'seq_msg_type::bulk_quote_acknowledgment_type_294_message': bulk_quote_acknowledgment_type_294_message
            'seq_msg_type::bulk_quote_acknowledgment_message': bulk_quote_acknowledgment_message
            'seq_msg_type::order_single_complex_modify_cancel_request_acknowledgment_and_urout_message': order_single_complex_modify_cancel_request_acknowledgment_and_urout_message
            'seq_msg_type::order_priority_update_acknowledgment_message': order_priority_update_acknowledgment_message
            'seq_msg_type::execution_report_message': execution_report_message
            'seq_msg_type::trade_bust_correct_message': trade_bust_correct_message
            'seq_msg_type::application_layer_reject_message': application_layer_reject_message
            'seq_msg_type::risk_control_acknowledgement_message': risk_control_acknowledgement_message
            'seq_msg_type::risk_control_alert_message': risk_control_alert_message
            'seq_msg_type::complex_series_request_acknowledgement_message': complex_series_request_acknowledgement_message
  seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Sequence number, starting from 1'
  seq_msg_header:
    seq:
      - id: seq_msg_type
        type: u2
        enum: seq_msg_type
        doc: 'Code identifying this message type'
      - id: seq_msg_length
        type: u2
        doc: 'Length of sequenced data message including this field'
  session_configuration_request_message:
    seq:
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Gateway session identifier (SenderCompID)'
      - id: cancel_on_disconnect
        type: u1
        enum: cancel_on_disconnect
        doc: 'Cancel on disconnect behavior for the session'
      - id: throttle_preference
        type: u1
        enum: throttle_preference
        doc: 'Queue or reject orders when throttled'
      - id: self_trade_prevention
        type: u1
        enum: self_trade_prevention
        doc: 'Session-level default self-trade prevention setting'
      - id: order_priority_update_ack_subscription
        type: u1
        enum: order_priority_update_ack_subscription
        doc: 'Subscription for unsolicited order priority update and repricing acknowledgements'
      - id: bold_designation
        type: u1
        enum: bold_designation
        doc: 'Session-level default BOLD designation'
      - id: reserved_49
        size: 49
        doc: 'Reserved for future use'
  new_order_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Original client order ID for cancel/replace; zero for new orders'
      - id: bitfield_order_instructions
        size: 16
        doc: 'Bitfield containing order attributes and modifiers'
      - id: price
        type: s8
        doc: 'Order price; net limit price for complex orders. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
      - id: min_qty
        type: u4
        doc: 'Minimum execution quantity; must be zero for complex orders'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Per-leg open or close indicators for complex orders only'
      - id: auction_id
        type: u8
        doc: 'CUBE auction identifier for GTX responses; zero if not used'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
  optional_order_add_on:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: stop_px
        type: s8
        doc: 'Trigger price for stop and stop limit orders; must be zero for complex orders. Implied decimal with scale 1e-8'
      - id: max_floor
        type: u4
        doc: 'Maximum floor quantity; must be zero for complex orders'
      - id: deliver_to_comp_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'Market maker MPID for directed or PFOF orders, or override default routing'
      - id: clearing_firm
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing number of CMTA'
      - id: optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'Customer-defined clearing optional data with restricted ASCII characters'
      - id: clearing_account
        type: str
        size: 5
        encoding: ASCII
        doc: 'OCC clearing account number if non-default is required'
  sub_msg_header:
    seq:
      - id: sub_msg_type
        type: u2
        doc: 'Code identifying sub message type'
      - id: sub_msg_length
        type: u2
        doc: 'Length of sub message including this field'
  order_cancel_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Original client order ID for cancel/replace; zero for new orders'
  order_modify_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Original client order ID for cancel/replace; zero for new orders'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
      - id: side_u_81
        type: u1
        doc: 'Optional side change; zero indicates no change'
      - id: locate_reqd_u_81
        type: u1
        doc: 'Locate requirement indicator'
  new_bulk_quote_type_243_message:
    seq:
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined sub-identifier applied to all repeating group entries for STP'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: self_trade_type_u_81
        type: u1
        doc: 'Self-trade prevention setting applied to all quotes in the message'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: mm_sent_time
        type: u8
        doc: 'Customer-provided sending time in nanoseconds since epoch. Nanoseconds since Unix epoch'
  new_bulk_quote_type_259_message:
    seq:
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined sub-identifier applied to all repeating group entries for STP'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: self_trade_type_u_81
        type: u1
        doc: 'Self-trade prevention setting applied to all quotes in the message'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: mm_sent_time
        type: u8
        doc: 'Customer-provided sending time in nanoseconds since epoch. Nanoseconds since Unix epoch'
  new_order_cross_message:
    seq:
      - id: cross_id
        type: u8
        doc: 'Client-assigned identifier for the cross order'
      - id: allocation_pct
        type: u1
        doc: 'Percentage allocation the covered order is willing to surrender'
      - id: clearing_firm_exposed
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing firm of the exposed side of the cross'
      - id: clearing_account_exposed
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing account of the exposed side if non-default'
      - id: optional_data_exposed
        type: str
        size: 16
        encoding: ASCII
        doc: 'Customer-defined clearing optional data for the exposed side'
      - id: clearing_firm_covered
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing firm of the covered side of the cross'
      - id: clearing_account_covered
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing account of the covered side if non-default'
      - id: optional_data_covered
        type: str
        size: 16
        encoding: ASCII
        doc: 'Customer-defined clearing optional data for the covered side'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
      - id: exposed
        type: exposed
        doc: 'Exposed'
      - id: covered
        type: covered
        doc: 'Covered'
  exposed:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Original client order ID for cancel/replace; zero for new orders'
      - id: bitfield_order_instructions
        size: 16
        doc: 'Bitfield containing order attributes and modifiers'
      - id: price
        type: s8
        doc: 'Order price; net limit price for complex orders. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
      - id: min_qty
        type: u4
        doc: 'Minimum execution quantity; must be zero for complex orders'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Per-leg open or close indicators for complex orders only'
      - id: auction_id
        type: u8
        doc: 'CUBE auction identifier for GTX responses; zero if not used'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
  covered:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Original client order ID for cancel/replace; zero for new orders'
      - id: bitfield_order_instructions
        size: 16
        doc: 'Bitfield containing order attributes and modifiers'
      - id: price
        type: s8
        doc: 'Order price; net limit price for complex orders. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
      - id: min_qty
        type: u4
        doc: 'Minimum execution quantity; must be zero for complex orders'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Per-leg open or close indicators for complex orders only'
      - id: auction_id
        type: u8
        doc: 'CUBE auction identifier for GTX responses; zero if not used'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
  bulk_cancel_request_type_223_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: mm_sent_time
        type: u8
        doc: 'Customer-provided sending time in nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: side_u_81
        type: u1
        doc: 'Optional side change; zero indicates no change'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: target_cancel_username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional username to scope cancellations to a specific session'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'Specifies cancel, block and cancel, or unblock action'
      - id: cancel_scope
        type: u1
        enum: cancel_scope
        doc: 'Specifies whether orders, quotes, or both are affected'
      - id: target_cancel_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Optional MPID to scope cancellations to a specific firm'
  bulk_cancel_request_type_224_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: side_u_81
        type: u1
        doc: 'Optional side change; zero indicates no change'
      - id: target_cancel_username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional username to scope cancellations to a specific session'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'Specifies cancel, block and cancel, or unblock action'
      - id: target_cancel_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Optional MPID to scope cancellations to a specific firm'
      - id: reserved_20
        size: 20
        doc: 'Reserved for future use'
  risk_limit_update_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Risk entity clearing number associated with the MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: risk_user_crd
        type: u4
        doc: 'CRD of the firm that owns the risk control'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Type of firm that owns the risk control'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Specifies the type of risk control being configured'
      - id: risk_control_activation
        type: u1
        enum: risk_control_activation
        doc: 'Indicates whether the risk control is enabled or disabled'
      - id: usd_limit
        type: s8
        doc: 'Dollar-based limit value for applicable risk control types'
      - id: time_limit
        type: s4
        doc: 'Rolling time window in microseconds for activity-based risk controls'
      - id: percentage_limit
        type: s4
        doc: 'Percentage-based limit for applicable risk control types'
      - id: count_limit
        type: s4
        doc: 'Count-based limit for applicable risk control types'
      - id: breach_action_request
        type: u1
        enum: breach_action_request
        doc: 'Action to take when a risk limit breach occurs'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'Controls inclusion or exclusion of IOC orders in activity-based calculations'
      - id: risk_range_id
        type: u1
        doc: 'Quantity or price range identifier for the risk limit'
      - id: risk_minimum_value
        type: s8
        doc: 'Minimum value threshold for applying the risk control'
      - id: price_scale
        type: u1
        enum: price_scale
        doc: 'Decimal scale applied to USD-based limits'
      - id: reserved_190
        size: 190
        doc: 'Reserved for future use'
  risk_action_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Risk entity clearing number associated with the MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: risk_user_crd
        type: u4
        doc: 'CRD of the firm that owns the risk control'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Type of firm that owns the risk control'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Specifies the type of risk control being configured'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: 'Specifies the risk action to perform'
      - id: risk_range_id
        type: u1
        doc: 'Quantity or price range identifier for the risk limit'
      - id: reserved_199
        size: 199
        doc: 'Reserved for future use'
  new_complex_series_request_message:
    seq:
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: complex_series_leg_group
        type: complex_series_leg_group
        repeat: eos
        doc: 'Repeating group defining each leg of the complex series'
  complex_series_leg_group:
    seq:
      - id: leg_symbol_id
        type: u4
        doc: 'Identifier of the leg security'
      - id: leg_ratio_qty
        type: u2
        doc: 'Quantity ratio for the leg used to derive leg order quantity'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Side of the leg'
  underlying_symbol_reference_data_message:
    seq:
      - id: transact_time_u_648
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: nyse_symbol
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pillar market data symbology'
      - id: listed_mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Identifier Code of the primary market'
      - id: underlying_type
        type: u1
        enum: underlying_type
        doc: 'Type of the underlying security'
      - id: max_order_price
        type: s8
        doc: 'Maximum allowable order entry price. Implied decimal with scale 1e-8'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number of the MPV class'
      - id: test_symbol_indicator
        type: u1
        enum: test_symbol_indicator
        doc: 'Indicates whether the symbol is a production or test symbol'
      - id: channel_id
        type: u1
        doc: 'Transaction channel identifier of the underlying'
      - id: legal_width_multiplier
        type: u1
        doc: 'Multiplier applied to standard legal width auctions and quoting obligations'
  series_reference_data_message:
    seq:
      - id: transact_time_u_648
        type: u8
        doc: 'Exchange application time'
      - id: series_index
        type: u4
        doc: 'Options series index used for order entry'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: occ_symbol_root
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'OCC root symbol for the option series'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Indicates whether the option is a put or a call'
      - id: strike_price
        type: u8
        doc: 'Strike price of the option series. Implied decimal with scale 1e-8'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity date of the option in YYYYMMDD format'
      - id: contract_multiplier
        type: u4
        doc: 'Number of underlying shares per option contract'
      - id: series_type
        type: u1
        enum: series_type
        doc: 'Indicates whether the series is standard or another type'
      - id: closing_only_indicator
        type: u1
        enum: closing_only_indicator
        doc: 'Indicates whether the series is closing-only'
  minimum_price_variant_class_reference_data_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpv_class_name
        type: str
        size: 20
        encoding: ASCII
        doc: 'Name of the minimum price variant class'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number of the MPV class'
  minimum_price_variant_level_reference_data_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpv_level_definition
        type: mpv_level_definition
        repeat: eos
        doc: 'Defines a single minimum price variant level within an MPV class'
  mpv_level_definition:
    seq:
      - id: mpv_level_name
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the minimum price variant level'
      - id: order_entry_limit_price
        type: u8
        doc: 'Order entry limit price range for this MPV level. Implied decimal with scale 1e-8'
      - id: quoting_mpv
        type: u8
        doc: 'Quoting minimum price variation for this MPV level. Implied decimal with scale 1e-8'
      - id: trading_mpv
        type: u8
        doc: 'Trading minimum price variation for this MPV level. Implied decimal with scale 1e-8'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number of the MPV class'
  mpid_configuration_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpid_status
        type: u1
        enum: mpid_status
        doc: 'Status of the MPID'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Gateway session identifier (SenderCompID)'
      - id: reserved_50
        size: 50
        doc: 'Reserved for future use'
  options_market_maker_symbol_appointment_reference_data_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: nyse_symbol
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pillar market data symbology'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: mm_type
        type: u1
        enum: mm_type
        doc: 'Market maker role/type for the appointed symbol'
      - id: appointment_status
        type: u1
        enum: appointment_status
        doc: 'Indicates whether the market maker is appointed for the underlying symbol'
      - id: reserved_50
        size: 50
        doc: 'Reserved for future use'
  session_configuration_acknowledgement_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: user_session_type
        type: u1
        enum: user_session_type
        doc: 'Permission type assigned to the gateway session'
      - id: user_session_status
        type: u1
        enum: user_session_status
        doc: 'Status of the gateway session'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Gateway session identifier (SenderCompID)'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code of the connected market'
      - id: cancel_on_disconnect
        type: u1
        enum: cancel_on_disconnect
        doc: 'Cancel on disconnect behavior for the session'
      - id: throttle_preference
        type: u1
        enum: throttle_preference
        doc: 'Queue or reject orders when throttled'
      - id: throttle_window
        type: u2
        doc: 'Time window in milliseconds over which throttling is enforced'
      - id: throttle_threshold
        type: u2
        doc: 'Maximum number of inbound messages allowed in the throttle window'
      - id: symbol_eligibility
        type: u1
        enum: symbol_eligibility
        doc: 'Session-level permission controlling eligible symbol types'
      - id: max_order_quantity
        type: u4
        doc: 'Maximum allowable order quantity for the session'
      - id: self_trade_prevention
        type: u1
        enum: self_trade_prevention
        doc: 'Session-level default self-trade prevention setting'
      - id: order_priority_update_ack_subscription
        type: u1
        enum: order_priority_update_ack_subscription
        doc: 'Subscription for unsolicited order priority update and repricing acknowledgements'
      - id: ack_status
        type: u1
        enum: ack_status
        doc: 'Status of the session configuration acknowledgement'
      - id: bold_designation
        type: u1
        enum: bold_designation
        doc: 'Session-level default BOLD designation'
      - id: reserved_49
        size: 49
        doc: 'Reserved for future use'
  order_and_cancel_replace_acknowledgement_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Original client order ID for cancel/replace; zero for new orders'
      - id: bitfield_order_instructions
        size: 16
        doc: 'Bitfield containing order attributes and modifiers'
      - id: price
        type: s8
        doc: 'Order price; net limit price for complex orders. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
      - id: min_qty
        type: u4
        doc: 'Minimum execution quantity; must be zero for complex orders'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Exchange-assigned identifier of the most recent order'
      - id: leaves_qty
        type: u4
        doc: 'Remaining quantity open on the order'
      - id: working_price
        type: s8
        doc: 'Current working price, which may differ from display price. Implied decimal with scale 1e-8'
      - id: working_away_from_display
        type: u1
        enum: working_away_from_display
        doc: 'Indicates whether working price differs from display price'
      - id: pre_liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Pre-liquidity status indicator'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'Acknowledgement event type'
      - id: bitfield_flow_indicator
        type: bitfield_flow_indicator
        doc: 'Indicates whether the inbound message was throttled'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Per-leg open or close indicators for complex orders only'
      - id: auction_id
        type: u8
        doc: 'CUBE auction identifier for GTX responses; zero if not used'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
  bitfield_flow_indicator:
    seq:
      - id: throttled
        type: b1
        enum: throttled
        doc: 'Indicates if inbound message was throttled'
      - id: unused_7
        type: b7
        doc: 'Reserved for future use'
  bulk_quote_acknowledgment_type_294_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined sub-identifier applied to all repeating group entries for STP'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: bitfield_flow_indicator
        type: bitfield_flow_indicator
        doc: 'Indicates whether the inbound message was throttled'
      - id: self_trade_type_u_81
        type: u1
        doc: 'Self-trade prevention setting applied to all quotes in the message'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: repeating_groups
        type: u1
        doc: 'Number of repeating quote acknowledgement groups included'
  bulk_quote_acknowledgment_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined sub-identifier applied to all repeating group entries for STP'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: bitfield_flow_indicator
        type: bitfield_flow_indicator
        doc: 'Indicates whether the inbound message was throttled'
      - id: self_trade_type_u_81
        type: u1
        doc: 'Self-trade prevention setting applied to all quotes in the message'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: repeating_groups
        type: u1
        doc: 'Number of repeating quote acknowledgement groups included'
  order_single_complex_modify_cancel_request_acknowledgment_and_urout_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: order_id
        type: u8
        doc: 'Exchange-assigned identifier of the most recent order'
      - id: ref_cl_ord_id
        type: u8
        doc: 'Client-assigned identifier referencing the incoming modify, cancel, or bulk cancel request'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Original client order ID for cancel/replace; zero for new orders'
      - id: price
        type: s8
        doc: 'Order price; net limit price for complex orders. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
      - id: leaves_qty
        type: u4
        doc: 'Remaining quantity open on the order'
      - id: side_u_81
        type: u1
        doc: 'Optional side change; zero indicates no change'
      - id: locate_reqd_u_81
        type: u1
        doc: 'Locate requirement indicator'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'Acknowledgement event type'
      - id: bitfield_flow_indicator
        type: bitfield_flow_indicator
        doc: 'Indicates whether the inbound message was throttled'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: target_cancel_username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional username to scope cancellations to a specific session'
      - id: target_cancel_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Optional MPID to scope cancellations to a specific firm'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'Specifies cancel, block and cancel, or unblock action'
      - id: cancel_scope
        type: u1
        enum: cancel_scope
        doc: 'Specifies whether orders, quotes, or both are affected'
  order_priority_update_acknowledgment_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: order_id
        type: u8
        doc: 'Exchange-assigned identifier of the most recent order'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: working_price
        type: s8
        doc: 'Current working price, which may differ from display price. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
      - id: working_away_from_display
        type: u1
        enum: working_away_from_display
        doc: 'Indicates whether working price differs from display price'
      - id: pre_liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Pre-liquidity status indicator'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'Acknowledgement event type'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
  execution_report_message:
    seq:
      - id: transact_time_u_648
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: order_id
        type: u8
        doc: 'Exchange-assigned identifier of the most recent order'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: deal_id
        type: u8
        doc: 'Exchange-assigned transaction identifier for both sides of a trade'
      - id: last_px
        type: s8
        doc: 'Price of the current fill or partial fill. Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u4
        doc: 'Remaining quantity open on the order'
      - id: cum_qty
        type: u4
        doc: 'Total executed quantity for the order'
      - id: last_qty
        type: u4
        doc: 'Quantity executed in this execution event'
      - id: liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Liquidity indicator for the execution'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Indicates single-leg, multi-leg, or individual leg execution'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
      - id: locate_reqd_u_81
        type: u1
        doc: 'Locate requirement indicator'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Participant classification'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: side_u_81
        type: u1
        doc: 'Optional side change; zero indicates no change'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: contra_market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Contra party Market Maker identifier'
      - id: contra_clearing_firm
        type: str
        size: 5
        encoding: ASCII
        doc: 'Contra party clearing firm number'
      - id: contra_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contra party MPID'
      - id: contra_open_close
        type: u1
        enum: contra_open_close
        doc: 'Contra side open/close indicator'
      - id: contra_customer_or_firm
        type: u1
        enum: contra_customer_or_firm
        doc: 'Contra side capacity'
      - id: contra_clearing_account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Contra party clearing account'
      - id: contra_cross_type
        type: u2
        enum: contra_cross_type
        doc: 'Cross type of the contra side'
      - id: contra_covered_or_uncovered
        type: u1
        enum: contra_covered_or_uncovered
        doc: 'Identifies exposed or covered side for contra'
      - id: covered_or_uncovered
        type: u1
        enum: covered_or_uncovered
        doc: 'Identifies exposed or covered side of this order'
      - id: cross_id
        type: u8
        doc: 'Client-assigned identifier for the cross order'
      - id: open_close_u_81
        type: u1
        doc: 'Sender’s open/close position'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
  trade_bust_correct_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: order_id
        type: u8
        doc: 'Exchange-assigned identifier of the most recent order'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: ref_seq_msg_id
        type: ref_seq_msg_id
        doc: 'Pillar reference sequenced message identifier'
      - id: deal_id
        type: u8
        doc: 'Exchange-assigned transaction identifier for both sides of a trade'
      - id: last_px
        type: s8
        doc: 'Price of the current fill or partial fill. Implied decimal with scale 1e-8'
      - id: last_qty
        type: u4
        doc: 'Quantity executed in this execution event'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: bust_correct_indicator
        type: u1
        enum: bust_correct_indicator
        doc: 'BustCorrectIndicator enum'
  ref_seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Sequence number, starting from 1'
  application_layer_reject_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event'
      - id: reject_type
        type: u1
        enum: reject_type
        doc: 'Identifies the type of request message that was rejected'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer-defined free text with restricted ASCII characters'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
  risk_control_acknowledgement_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Risk entity clearing number associated with the MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: risk_ack_type
        type: u1
        doc: 'RiskAckType enum'
      - id: risk_user_crd
        type: u4
        doc: 'CRD of the firm that owns the risk control'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Type of firm that owns the risk control'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Specifies the type of risk control being configured'
      - id: risk_control_activation
        type: u1
        enum: risk_control_activation
        doc: 'Indicates whether the risk control is enabled or disabled'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: 'Specifies the risk action to perform'
      - id: usd_limit
        type: s8
        doc: 'Dollar-based limit value for applicable risk control types'
      - id: time_limit
        type: s4
        doc: 'Rolling time window in microseconds for activity-based risk controls'
      - id: percentage_limit
        type: s4
        doc: 'Percentage-based limit for applicable risk control types'
      - id: count_limit
        type: s4
        doc: 'Count-based limit for applicable risk control types'
      - id: breach_action_response
        type: u1
        enum: breach_action_response
        doc: 'Breach handling action applied'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'Controls inclusion or exclusion of IOC orders in activity-based calculations'
      - id: usd_calculation_1
        type: s8
        doc: 'USD calculation – Open ALL orders'
      - id: usd_calculation_2
        type: s8
        doc: 'USD calculation – Open auction orders'
      - id: usd_calculation_3
        type: s8
        doc: 'USD calculation – Executed ALL orders'
      - id: usd_calculation_4
        type: s8
        doc: 'USD calculation – Executed auction orders'
      - id: count_calculation
        type: u4
        doc: 'Current calculated count value'
      - id: blocked_by_breach_indicator
        type: u1
        enum: blocked_by_breach_indicator
        doc: 'Indicates breach-based blocking status'
      - id: blocked_by_kill_switch_indicator
        type: u1
        enum: blocked_by_kill_switch_indicator
        doc: 'Indicates kill-switch blocking status'
      - id: reinstatement_required_by_self
        type: u1
        enum: reinstatement_required_by_self
        doc: 'Indicates whether self reinstatement approval is required'
      - id: reinstatement_required_by_other
        type: u1
        enum: reinstatement_required_by_other
        doc: 'Indicates whether other Risk User approval is required'
      - id: risk_range_id
        type: u1
        doc: 'Quantity or price range identifier for the risk limit'
      - id: risk_minimum_value
        type: s8
        doc: 'Minimum value threshold for applying the risk control'
      - id: price_scale
        type: u1
        enum: price_scale
        doc: 'Decimal scale applied to USD-based limits'
      - id: reserved_190
        size: 190
        doc: 'Reserved for future use'
  risk_control_alert_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm identifier; must match original order on cancel/replace'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market maker identifier required for market maker capacity'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer-defined trading desk or entity identifier'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Risk entity clearing number associated with the MPID'
      - id: risk_user_crd
        type: u4
        doc: 'CRD of the firm that owns the risk control'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Type of firm that owns the risk control'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Specifies the type of risk control being configured'
      - id: usd_limit
        type: s8
        doc: 'Dollar-based limit value for applicable risk control types'
      - id: time_limit
        type: s4
        doc: 'Rolling time window in microseconds for activity-based risk controls'
      - id: percentage_limit
        type: s4
        doc: 'Percentage-based limit for applicable risk control types'
      - id: count_limit
        type: s4
        doc: 'Count-based limit for applicable risk control types'
      - id: breach_action_response
        type: u1
        enum: breach_action_response
        doc: 'Breach handling action applied'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'Controls inclusion or exclusion of IOC orders in activity-based calculations'
      - id: usd_calculation_1
        type: s8
        doc: 'USD calculation – Open ALL orders'
      - id: usd_calculation_2
        type: s8
        doc: 'USD calculation – Open auction orders'
      - id: usd_calculation_3
        type: s8
        doc: 'USD calculation – Executed ALL orders'
      - id: usd_calculation_4
        type: s8
        doc: 'USD calculation – Executed auction orders'
      - id: count_calculation
        type: u4
        doc: 'Current calculated count value'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: 'Specifies the risk action to perform'
      - id: threshold_breach_level
        type: u1
        enum: threshold_breach_level
        doc: 'Threshold level that was breached'
      - id: blocked_by_breach_indicator
        type: u1
        enum: blocked_by_breach_indicator
        doc: 'Indicates breach-based blocking status'
      - id: blocked_by_kill_switch_indicator
        type: u1
        enum: blocked_by_kill_switch_indicator
        doc: 'Indicates kill-switch blocking status'
      - id: reinstatement_required_by_self
        type: u1
        enum: reinstatement_required_by_self
        doc: 'Indicates whether self reinstatement approval is required'
      - id: reinstatement_required_by_other
        type: u1
        enum: reinstatement_required_by_other
        doc: 'Indicates whether other Risk User approval is required'
      - id: reserved_200
        size: 200
        doc: 'Reserved for future use'
  complex_series_request_acknowledgement_message:
    seq:
      - id: transact_time_timestamp_8
        type: u8
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: u8
        doc: 'Client order identifier unique per Username and MPID'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event'
      - id: symbol_id
        type: u4
        doc: 'Identifier of the security; both sides of a cross must match'
      - id: side_u_81
        type: u1
        doc: 'Optional side change; zero indicates no change'
      - id: repeating_groups
        type: u1
        doc: 'Number of repeating quote acknowledgement groups included'
      - id: leg_group
        type: leg_group
        repeat: expr
        repeat-expr: repeating_groups
        doc: 'Complex Series Request Acknowledgement repeating groups'
  leg_group:
    seq:
      - id: leg_symbol_id
        type: u4
        doc: 'Identifier of the leg security'
      - id: leg_ratio_qty
        type: u2
        doc: 'Quantity ratio for the leg used to derive leg order quantity'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Side of the leg'

enums:
  msg_type:
    0x0201:
      id: 'login'
      doc: 'Login'
    0x0202:
      id: 'login_response'
      doc: 'Login Response'
    0x0203:
      id: 'stream_avail'
      doc: 'Stream Avail'
    0x0204:
      id: 'heartbeat'
      doc: 'Heartbeat'
    0x0205:
      id: 'open'
      doc: 'Open'
    0x0206:
      id: 'open_response'
      doc: 'Open Response'
    0x0207:
      id: 'close'
      doc: 'Close'
    0x0208:
      id: 'close_response'
      doc: 'Close Response'
    0x0905:
      id: 'seq_msg'
      doc: 'Sequenced Message'
  status:
    0:
      id: 'request_processed_successfully'
      doc: 'Request processed successfully'
    18:
      id: 'not_logged_in'
      doc: 'Not logged in'
  seq_msg_type:
    0x0220:
      id: 'session_configuration_request_message'
      doc: 'Request to update gateway session configuration settings'
    0x0282:
      id: 'sequenced_filler_message'
      doc: 'This message type is used to increase the next expected sequence number of a TG stream by 1 on a given gateway
        session.'
    0x0248:
      id: 'new_order_message'
      doc: 'Used to submit new single-leg or complex option orders and cancel/replace requests'
    0x0250:
      id: 'order_cancel_request_message'
      doc: 'Request to cancel a single targeted single-leg or complex order'
    0x0251:
      id: 'order_modify_request_message'
      doc: 'Request to reduce order quantity while preserving order ranking and original OrderID'
    0x0243:
      id: 'new_bulk_quote_type_243_message'
      doc: 'Allows a market maker to submit up to 20 single-sided quotes for the same underlying in a single message'
    0x0259:
      id: 'new_bulk_quote_type_259_message'
      doc: 'Allows a market maker to submit up to 20 single-sided quotes for the same underlying in a single message'
    0x0222:
      id: 'new_order_cross_message'
      doc: 'Used to submit cross orders for single-leg or complex options'
    0x0223:
      id: 'bulk_cancel_request_type_223_message'
      doc: 'Request to cancel orders and/or market maker quotes in bulk based on specified criteria'
    0x0224:
      id: 'bulk_cancel_request_type_224_message'
      doc: 'Request to cancel orders in bulk based on symbol, side, and user or firm criteria'
    0x0330:
      id: 'risk_limit_update_request_message'
      doc: 'Request to create, update, activate, or deactivate Pillar risk control limits for entitled risk entities'
    0x0331:
      id: 'risk_action_request_message'
      doc: 'Request to query risk entities, invoke kill switch actions, or approve reinstatement for Pillar risk controls'
    0x0357:
      id: 'new_complex_series_request_message'
      doc: 'Request to create a new complex options series with up to twelve legs'
    0x0233:
      id: 'underlying_symbol_reference_data_message'
      doc: 'Publishes reference data for each underlying symbol configured for trading'
    0x0234:
      id: 'series_reference_data_message'
      doc: 'Publishes reference data for each options series, including series index and symbology required for order entry'
    0x0230:
      id: 'minimum_price_variant_class_reference_data_message'
      doc: 'Defines a minimum price variant class and its identifying attributes'
    0x0231:
      id: 'minimum_price_variant_level_reference_data_message'
      doc: 'Defines one or more minimum price variant levels within a single MPV class'
    0x0272:
      id: 'mpid_configuration_message'
      doc: 'Publishes the current configuration and status of each MPID configured on a gateway session'
    0x0833:
      id: 'options_market_maker_symbol_appointment_reference_data_message'
      doc: 'Publishes appointment information for market makers for each appointed underlying symbol'
    0x0221:
      id: 'session_configuration_acknowledgement_message'
      doc: 'Provides the current configured session settings and acknowledgement status for a session configuration request'
    0x0269:
      id: 'order_and_cancel_replace_acknowledgement_message'
      doc: 'Order and Cancel/Replace Acknowledgement Message'
    0x0294:
      id: 'bulk_quote_acknowledgment_type_294_message'
      doc: 'Bulk Quote Acknowledgment Message'
    0x0308:
      id: 'bulk_quote_acknowledgment_message'
      doc: 'Bulk Quote Acknowledgment Message'
    0x0278:
      id: 'order_single_complex_modify_cancel_request_acknowledgment_and_urout_message'
      doc: 'Order Single/Complex Modify/Cancel Request Acknowledgment and UROUT Message'
    0x0268:
      id: 'order_priority_update_acknowledgment_message'
      doc: 'Order Priority Update Acknowledgment Message'
    0x0295:
      id: 'execution_report_message'
      doc: 'Execution Report Message'
    0x0293:
      id: 'trade_bust_correct_message'
      doc: 'Trade Bust/Correct Message'
    0x0267:
      id: 'application_layer_reject_message'
      doc: 'Application Layer Reject Message'
    0x0332:
      id: 'risk_control_acknowledgement_message'
      doc: 'Risk Control Acknowledgement Message'
    0x0333:
      id: 'risk_control_alert_message'
      doc: 'Risk Control Alert Message'
    0x0358:
      id: 'complex_series_request_acknowledgement_message'
      doc: 'Complex Series Request Acknowledgement Message'
  cancel_on_disconnect:
    1:
      id: 'cancel_day_orders'
      doc: 'Enable Cancel On Disconnect For Day Orders Only With Standard Exclusions'
    2:
      id: 'cancel_all_orders'
      doc: 'Enable Cancel On Disconnect For All Orders In The Session'
  throttle_preference:
    0:
      id: 'queue_when_throttled'
      doc: 'Queue Orders When Throttled'
    1:
      id: 'reject_when_throttled'
      doc: 'Reject Orders When Throttled'
  self_trade_prevention:
    1:
      id: 'no_self_trade_prevention'
      doc: 'No Self Trade Prevention'
    2:
      id: 'cancel_newest'
      doc: 'Cancel Newest Order'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest Order'
    4:
      id: 'cancel_both'
      doc: 'Cancel Both Orders'
  order_priority_update_ack_subscription:
    0:
      id: 'not_subscribed'
      doc: 'No Unsolicited Order Priority Update Or Repricing Acknowledgements'
    1:
      id: 'order_priority_update_only'
      doc: 'Receive Unsolicited Order Priority Update Acknowledgements'
    2:
      id: 'order_priority_update_and_repricing'
      doc: 'Receive Unsolicited Order Priority Update And Repricing Acknowledgements'
  bold_designation:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable Or Do Not Change Default'
    4:
      id: 'expose_order_info_only'
      doc: 'Bold Expose Order Information Only'
    5:
      id: 'expose_order_info_and_capacity'
      doc: 'Bold Expose Order Information And Capacity'
    6:
      id: 'expose_order_info_and_participant_id'
      doc: 'Bold Expose Order Information And Participant Id'
    7:
      id: 'expose_order_info_capacity_and_participant_id'
      doc: 'Bold Expose Order Information Capacity And Participant Id'
    8:
      id: 'no_bold_defaulting'
      doc: 'No Bold Designation Defaulting'
  leg_open_close:
    0:
      id: 'open'
      doc: 'Open'
    1:
      id: 'close'
      doc: 'Close'
  bulk_action:
    0:
      id: 'not_applicable'
      doc: 'No Bulk Action Specified'
    1:
      id: 'cancel_single_leg_only'
      doc: 'Cancel Singleleg Orders Only'
    2:
      id: 'cancel_complex_only'
      doc: 'Cancel Complex Orders Only'
    3:
      id: 'cancel_single_and_complex'
      doc: 'Cancel Both Singleleg And Complex Orders'
    4:
      id: 'block_and_cancel'
      doc: 'Block Future Quotes And Cancel Existing Ones Market Maker Sessions Only'
    5:
      id: 'unblock'
      doc: 'Unblock Previously Blocked Quotes Market Maker Sessions Only'
  cancel_scope:
    0:
      id: 'orders_only'
      doc: 'Cancel Orders Only'
    1:
      id: 'quotes_only'
      doc: 'Cancel Options Market Maker Quotes Only'
    2:
      id: 'orders_and_quotes'
      doc: 'Cancel Both Orders And Market Maker Quotes'
  risk_user_type:
    0x45:
      id: 'entering_firm'
      doc: 'Entering Firm Owns The Risk Control'
    0x43:
      id: 'clearing_firm'
      doc: 'Clearing Firm Owns The Risk Control'
    0x4f:
      id: 'options_market_maker_firm'
      doc: 'Options Market Maker Firm Owns The Risk Control'
  risk_control_type:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'single_order_max_qty'
      doc: 'Single Order Maximum Quantity'
    2:
      id: 'single_order_max_notional'
      doc: 'Single Order Maximum Notional Value'
    3:
      id: 'gross_credit_executed'
      doc: 'Gross Credit Executed'
    4:
      id: 'gross_credit_open'
      doc: 'Gross Credit Open'
    5:
      id: 'gross_credit_open_and_executed'
      doc: 'Gross Credit Open Plus Executed'
    6:
      id: 'maximum_duplicative_orders'
      doc: 'Maximum Duplicative Orders'
    8:
      id: 'activity_rolling_transaction'
      doc: 'Activitybased Rolling Transaction Limit'
    9:
      id: 'activity_rolling_volume'
      doc: 'Activitybased Rolling Volume Limit'
    10:
      id: 'activity_rolling_percentage'
      doc: 'Activitybased Rolling Percentage Limit'
    11:
      id: 'global_risk_mitigation_protection'
      doc: 'Global Risk Mitigation Protection'
    13:
      id: 'reject_market_orders'
      doc: 'Reject Market Orders Except Moo And Moc'
    14:
      id: 'reject_moo_and_moc'
      doc: 'Reject Moo And Moc Orders'
    19:
      id: 'reject_restricted_symbol'
      doc: 'Reject Orders For Restricted Symbol'
    26:
      id: 'limit_order_price_protection_options_single_leg'
      doc: 'Limit Order Price Protection Options Singleleg Custom Limits'
    27:
      id: 'limit_order_price_protection_options_complex'
      doc: 'Limit Order Price Protection Options Complex Custom Limits'
    29:
      id: 'order_rate_threshold'
      doc: 'Order Rate Threshold Across All Symbols'
    30:
      id: 'reject_isoioc'
      doc: 'Reject Iso Ioc Orders'
    31:
      id: 'reject_iso_day'
      doc: 'Reject Iso Day Orders'
  risk_control_activation:
    0:
      id: 'off'
      doc: 'Risk Control Turned Off'
    1:
      id: 'on'
      doc: 'Risk Control Turned On'
  breach_action_request:
    0:
      id: 'not_applicable'
      doc: 'No Breach Action'
    1:
      id: 'notifications_only'
      doc: 'Send Notifications Only'
    2:
      id: 'cancel_and_block'
      doc: 'Cancel Nonauction Orders And Block Further Activity'
    3:
      id: 'block_only'
      doc: 'Block Further Activity Only'
  ioc_attribution:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'include_ioc'
      doc: 'Include Ioc Orders In Activitybased Calculations'
    2:
      id: 'exclude_ioc'
      doc: 'Exclude Ioc Orders From Activitybased Calculations'
  price_scale:
    0:
      id: 'no_decimals'
      doc: 'Value Interpreted As Integer'
    2:
      id: 'two_decimals'
      doc: 'Value Interpreted With Two Decimal Places'
  risk_action_type:
    0:
      id: 'not_applicable'
      doc: 'No Action Specified'
    1:
      id: 'query'
      doc: 'Query Risk Entity For Current Risk Control Configuration Calculations And Status'
    2:
      id: 'kill_switch_block'
      doc: 'Invoke Kill Switch Block Action'
    3:
      id: 'kill_switch_unblock'
      doc: 'Invoke Kill Switch Unblock Action'
    4:
      id: 'kill_switch_cancel_auction_orders'
      doc: 'Cancel Auction Orders Via Kill Switch'
    5:
      id: 'kill_switch_cancel_non_auction_orders'
      doc: 'Cancel Nonauction Orders Via Kill Switch'
    6:
      id: 'kill_switch_cancel_gtc_orders'
      doc: 'Cancel Goodtilcancel Orders Via Kill Switch'
    7:
      id: 'approve_reinstatement'
      doc: 'Approve Reinstatement Following A Block Breach'
    8:
      id: 'risk_entity_reinstated'
      doc: 'All Reinstatement Approvals Received And Processed'
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  underlying_type:
    0x41:
      id: 'adr'
      doc: 'American Depositary Receipt'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x44:
      id: 'debentures'
      doc: 'Debentures'
    0x45:
      id: 'etf'
      doc: 'Exchange Traded Fund'
    0x46:
      id: 'foreign'
      doc: 'Foreign Security'
    0x48:
      id: 'ads'
      doc: 'American Depositary Shares'
    0x49:
      id: 'units'
      doc: 'Units'
    0x4d:
      id: 'miscellaneous'
      doc: 'Miscellaneous Others'
    0x4c:
      id: 'index_linked_notes'
      doc: 'Index Linked Notes'
    0x4e:
      id: 'bonds'
      doc: 'Bonds'
    0x4f:
      id: 'ordinary_shares'
      doc: 'Ordinary Shares'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x52:
      id: 'rights'
      doc: 'Rights'
    0x53:
      id: 'beneficiary_interest'
      doc: 'Beneficiary Interest'
    0x54:
      id: 'structured_notes'
      doc: 'Structured Notes'
    0x55:
      id: 'closed_end_fund'
      doc: 'Closed End Fund'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
    0x58:
      id: 'index'
      doc: 'Index'
    0x5a:
      id: 'options'
      doc: 'Options'
  test_symbol_indicator:
    0:
      id: 'production'
      doc: 'Production Symbol'
    1:
      id: 'test'
      doc: 'Test Symbol'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put Option'
    1:
      id: 'call'
      doc: 'Call Option'
  series_type:
    0:
      id: 'standard'
      doc: 'Standard Option Series'
  closing_only_indicator:
    0:
      id: 'standard_series'
      doc: 'Standard Series'
    1:
      id: 'closing_only_series'
      doc: 'Closingonly Series'
  mpid_status:
    1:
      id: 'active'
      doc: 'Mpid Is Active'
    2:
      id: 'inactive'
      doc: 'Mpid Is Inactive'
    3:
      id: 'prospect'
      doc: 'Mpid Is In Prospect Status'
  mm_type:
    1:
      id: 'nyse_arca_options_lead_market_maker'
      doc: 'Nyse Arca Options Lead Market Maker'
    2:
      id: 'nyse_arca_options_market_maker'
      doc: 'Nyse Arca Options Market Maker'
    3:
      id: 'nyse_american_optionse_specialist'
      doc: 'Nyse American Options E Specialist'
    4:
      id: 'nyse_american_options_domm'
      doc: 'Nyse American Options Domm'
    5:
      id: 'nyse_american_options_specialist_and_domm'
      doc: 'Nyse American Options Specialist And Domm'
    6:
      id: 'nyse_american_optionse_specialist_and_domm'
      doc: 'Nyse American Options E Specialist And Domm'
  appointment_status:
    0:
      id: 'not_appointed'
      doc: 'Not Appointed For The Underlying Symbol'
    1:
      id: 'appointed'
      doc: 'Appointed For The Underlying Symbol'
  user_session_type:
    1:
      id: 'customer'
      doc: 'Customer Andor Equities Market Maker Session'
    2:
      id: 'service_bureau'
      doc: 'Service Bureau Session'
    4:
      id: 'options_market_maker'
      doc: 'Options Market Maker Session'
    12:
      id: 'risk_admin'
      doc: 'Risk Administrator Session'
  user_session_status:
    1:
      id: 'active'
      doc: 'Permission To Open Readwrite Streams'
    2:
      id: 'inactive'
      doc: 'Permission To Open Readonly Streams'
    3:
      id: 'prospect'
      doc: 'Prospect Status With Readonly Access'
  symbol_eligibility:
    1:
      id: 'all_symbols'
      doc: 'Production And Test Symbols Allowed'
    2:
      id: 'test_symbols_only'
      doc: 'Only Test Symbols Allowed'
  ack_status:
    0:
      id: 'unsolicited'
      doc: 'Startofday Or Unsolicited Acknowledgement'
    1:
      id: 'user_request_valid'
      doc: 'User Request Accepted'
    2:
      id: 'user_request_invalid'
      doc: 'User Request Rejected'
  working_away_from_display:
    0:
      id: 'equal_to_display_price'
      doc: 'Working Price Equals Display Price'
    1:
      id: 'away_from_display_price'
      doc: 'Working Price Differs From Display Price'
  reason_code:
    0:
      id: 'ok'
      doc: 'Ok'
    1:
      id: 'invalid_sender_comp_id'
      doc: 'Invalid Sender Comp Id'
    2:
      id: 'invalid_sender_sub_id'
      doc: 'Invalid Sender Sub Id'
    3:
      id: 'invalid_sending_time'
      doc: 'Invalid Sending Time'
    4:
      id: 'invalid_target_comp_id'
      doc: 'Invalid Target Comp Id'
    5:
      id: 'invalid_target_sub_id'
      doc: 'Invalid Target Sub Id'
    6:
      id: 'invalid_on_behalf_of_comp_id'
      doc: 'Invalid On Behalf Of Comp Id'
    7:
      id: 'invalid_on_behalf_of_sub_id'
      doc: 'Invalid On Behalf Of Sub Id'
    8:
      id: 'invalid_deliver_to_comp_id'
      doc: 'Invalid Deliver To Comp Id'
    9:
      id: 'invalid_deliver_to_sub_id'
      doc: 'Invalid Deliver To Sub Id'
    10:
      id: 'invalid_account'
      doc: 'Invalid Account'
    11:
      id: 'invalid_cl_ord_id'
      doc: 'Invalid Cl Ord Id'
    12:
      id: 'invalid_exec_inst'
      doc: 'Invalid Exec Inst'
    13:
      id: 'invalid_id_source'
      doc: 'Invalid Id Source'
    14:
      id: 'invalid_order_qty'
      doc: 'Invalid Order Qty'
    15:
      id: 'invalid_ord_type'
      doc: 'Invalid Ord Type'
    16:
      id: 'invalid_price'
      doc: 'Invalid Price'
    17:
      id: 'invalid_order_capacity'
      doc: 'Invalid Order Capacity'
    18:
      id: 'invalid_security_id'
      doc: 'Invalid Security Id'
    19:
      id: 'invalid_side'
      doc: 'Invalid Side'
    20:
      id: 'invalid_symbol_series'
      doc: 'Invalid Symbol Series'
    21:
      id: 'invalid_text'
      doc: 'Invalid Text'
    22:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    23:
      id: 'invalid_settlement_type'
      doc: 'Invalid Settlement Type'
    24:
      id: 'invalid_fut_sett_date'
      doc: 'Invalid Fut Sett Date'
    25:
      id: 'invalid_symbol_sfx'
      doc: 'Invalid Symbol Sfx'
    26:
      id: 'invalid_open_close'
      doc: 'Invalid Open Close'
    27:
      id: 'invalid_stop_px'
      doc: 'Invalid Stop Px'
    28:
      id: 'invalid_client_id'
      doc: 'Invalid Client Id'
    29:
      id: 'invalid_min_qty'
      doc: 'Invalid Min Qty'
    30:
      id: 'invalid_max_floor'
      doc: 'Invalid Max Floor'
    31:
      id: 'invalid_locate_reqd'
      doc: 'Invalid Locate Reqd'
    32:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    33:
      id: 'invalid_security_type'
      doc: 'Invalid Security Type'
    34:
      id: 'invalid_maturity_month_year'
      doc: 'Invalid Maturity Month Year'
    35:
      id: 'invalid_put_or_call'
      doc: 'Invalid Put Or Call'
    36:
      id: 'invalid_strike_price'
      doc: 'Invalid Strike Price'
    37:
      id: 'invalid_covered_or_uncovered'
      doc: 'Invalid Covered Or Uncovered'
    38:
      id: 'invalid_customer_or_firm'
      doc: 'Invalid Customer Or Firm'
    39:
      id: 'invalid_maturity_day'
      doc: 'Invalid Maturity Day'
    40:
      id: 'invalid_peg_difference'
      doc: 'Invalid Peg Difference'
    41:
      id: 'invalid_sellers_days'
      doc: 'Invalid Sellers Days'
    42:
      id: 'invalid_trading_session_id'
      doc: 'Invalid Trading Session Id'
    43:
      id: 'invalid_no_trading_sessions'
      doc: 'Invalid No Trading Sessions'
    44:
      id: 'invalid_discretion_inst'
      doc: 'Invalid Discretion Inst'
    45:
      id: 'invalid_discretion_offset'
      doc: 'Invalid Discretion Offset'
    46:
      id: 'invalid_price_type'
      doc: 'Invalid Price Type'
    47:
      id: 'invalid_clearing_firm'
      doc: 'Invalid Clearing Firm'
    48:
      id: 'invalid_clearing_account'
      doc: 'Invalid Clearing Account'
    49:
      id: 'invalid_party_id'
      doc: 'Invalid Party Id'
    50:
      id: 'invalid_optional_data'
      doc: 'Invalid Optional Data'
    51:
      id: 'invalid_cross_id'
      doc: 'Invalid Cross Id'
    52:
      id: 'invalid_strategy_indicator'
      doc: 'Invalid Strategy Indicator'
    53:
      id: 'invalid_trade_id'
      doc: 'Invalid Trade Id'
    54:
      id: 'invalid_no_self_trade'
      doc: 'Invalid No Self Trade'
    55:
      id: 'invalid_cap_strategy'
      doc: 'Invalid Cap Strategy'
    56:
      id: 'invalid_special_ord_type'
      doc: 'Invalid Special Ord Type'
    57:
      id: 'invalid_routing_inst'
      doc: 'Invalid Routing Inst'
    58:
      id: 'invalid_offset_price'
      doc: 'Invalid Offset Price'
    59:
      id: 'invalid_extended_exec_inst'
      doc: 'Invalid Extended Exec Inst'
    60:
      id: 'invalid_introducing_badge_id'
      doc: 'Invalid Introducing Badge Id'
    61:
      id: 'invalid_bill_to'
      doc: 'Invalid Bill To'
    62:
      id: 'invalid_parent_firm_cl_ord_id'
      doc: 'Invalid Parent Firm Cl Ord Id'
    63:
      id: 'invalid_parent_firm_exchange_ord_id'
      doc: 'Invalid Parent Firm Exchange Ord Id'
    64:
      id: 'invalid_parent_firm'
      doc: 'Invalid Parent Firm'
    65:
      id: 'invalid_interest_type'
      doc: 'Invalid Interest Type'
    66:
      id: 'invalid_display_ind'
      doc: 'Invalid Display Ind'
    67:
      id: 'invalid_peg_ind'
      doc: 'Invalid Peg Ind'
    68:
      id: 'invalid_ceiling_floor_price'
      doc: 'Invalid Ceiling Floor Price'
    69:
      id: 'invalid_min_peg_qty'
      doc: 'Invalid Min Peg Qty'
    70:
      id: 'invalid_d_order_auction_price'
      doc: 'Invalid D Order Auction Price'
    71:
      id: 'invalid_disc_max_vol'
      doc: 'Invalid Disc Max Vol'
    72:
      id: 'invalid_dics_route_ind'
      doc: 'Invalid Dics Route Ind'
    73:
      id: 'invalid_minimum_trigger_vol_mtv'
      doc: 'Invalid Minimum Trigger Vol Mtv'
    74:
      id: 'invalid_attributed_quote'
      doc: 'Invalid Attributed Quote'
    75:
      id: 'invalid_proactive_if_locked'
      doc: 'Invalid Proactive If Locked'
    76:
      id: 'system_not_available'
      doc: 'System Not Available'
    77:
      id: 'system_full_mengrateexceeded'
      doc: 'System Full Mengrateexceeded'
    78:
      id: 'throttle_reject'
      doc: 'Throttle Reject'
    79:
      id: 'symbol_series_halted'
      doc: 'Symbol Series Halted'
    80:
      id: 'no_symbolseries_permission'
      doc: 'No Symbolseries Permission'
    81:
      id: 'price_too_far_outside'
      doc: 'Price Too Far Outside'
    82:
      id: 'mwcb_halt'
      doc: 'Mwcb Halt'
    83:
      id: 'market_closed'
      doc: 'Market Closed'
    84:
      id: 'symbolseries_closed'
      doc: 'Symbolseries Closed'
    85:
      id: 'luld_cancel_instruction'
      doc: 'Luld Cancel Instruction'
    86:
      id: 'no_price_slide_inst_during_ssr'
      doc: 'No Price Slide Inst During Ssr'
    87:
      id: 'invalid_stock_leg_give_up'
      doc: 'Invalid Stock Leg Give Up'
    88:
      id: 'invalid_no_legs'
      doc: 'Invalid No Legs'
    89:
      id: 'invalid_leg_position_effect'
      doc: 'Invalid Leg Position Effect'
    90:
      id: 'invalid_leg_symbol'
      doc: 'Invalid Leg Symbol'
    91:
      id: 'invalid_leg_cfi_code'
      doc: 'Invalid Leg Cfi Code'
    92:
      id: 'invalid_leg_maturity_date'
      doc: 'Invalid Leg Maturity Date'
    93:
      id: 'invalid_leg_strike_price'
      doc: 'Invalid Leg Strike Price'
    94:
      id: 'invalid_leg_contract_multiplier'
      doc: 'Invalid Leg Contract Multiplier'
    95:
      id: 'invalid_leg_ratio_qty'
      doc: 'Invalid Leg Ratio Qty'
    96:
      id: 'invalid_leg_side'
      doc: 'Invalid Leg Side'
    97:
      id: 'invalid_leg_ref_id'
      doc: 'Invalid Leg Ref Id'
    98:
      id: 'unsupported_order_type'
      doc: 'Unsupported Order Type'
    99:
      id: 'urout'
      doc: 'Urout'
    100:
      id: 'primary_market_not_available'
      doc: 'Primary Market Not Available'
    101:
      id: 'no_nbbopbbo_for_peg'
      doc: 'No Nbbopbbo For Peg'
    102:
      id: 'no_market_for_market_order'
      doc: 'No Market For Market Order'
    103:
      id: 'marketable_price'
      doc: 'Marketable Price'
    104:
      id: 'done_for_day'
      doc: 'Done For Day'
    105:
      id: 'credit_limit_violation'
      doc: 'Credit Limit Violation'
    106:
      id: 'cancel_remaining_ioc'
      doc: 'Cancel Remaining Ioc'
    107:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    108:
      id: 'invalid_poss_resend'
      doc: 'Invalid Poss Resend'
    109:
      id: 'cancel_pending'
      doc: 'Cancel Pending'
    110:
      id: 'symbol_series_already_opened'
      doc: 'Symbol Series Already Opened'
    111:
      id: 'firm_bulk_cancel'
      doc: 'Firm Bulk Cancel'
    112:
      id: 'on_behalf_of_comp_id_blocked'
      doc: 'On Behalf Of Comp Id Blocked'
    113:
      id: 'clearing_firm_blocked'
      doc: 'Clearing Firm Blocked'
    114:
      id: 'cancel_replace_pending'
      doc: 'Cancel Replace Pending'
    115:
      id: 'modify_pending'
      doc: 'Modify Pending'
    116:
      id: 'cannot_flip_imbalance'
      doc: 'Cannot Flip Imbalance'
    117:
      id: 'cannot_increase_imbalance'
      doc: 'Cannot Increase Imbalance'
    118:
      id: 'pending_cancel_imbalance_freeze'
      doc: 'Pending Cancel Imbalance Freeze'
    119:
      id: 'pending_replace_imbalance_freeze'
      doc: 'Pending Replace Imbalance Freeze'
    120:
      id: 'pending_modify_imbalance_freeze'
      doc: 'Pending Modify Imbalance Freeze'
    121:
      id: 'pending_cancel_routed_interest'
      doc: 'Pending Cancel Routed Interest'
    122:
      id: 'pending_replace_routed_interest'
      doc: 'Pending Replace Routed Interest'
    123:
      id: 'pending_modify_routed_interest'
      doc: 'Pending Modify Routed Interest'
    124:
      id: 'pending_auction_running'
      doc: 'Pending Auction Running'
    125:
      id: 'duplicative_order_check'
      doc: 'Duplicative Order Check'
    126:
      id: 'cancelled_by_exchange'
      doc: 'Cancelled By Exchange'
    127:
      id: 'new_order'
      doc: 'New Order'
    128:
      id: 'fill'
      doc: 'Fill'
    129:
      id: 'partial_fill'
      doc: 'Partial Fill'
    130:
      id: 'reduced'
      doc: 'Reduced'
    131:
      id: 'replaced'
      doc: 'Replaced'
    132:
      id: 'no_market_for_cross'
      doc: 'No Market For Cross'
    133:
      id: 'stp_cancel'
      doc: 'Stp Cancel'
    134:
      id: 'invalid_poss_dupe'
      doc: 'Invalid Poss Dupe'
    135:
      id: 'tpid_blocked'
      doc: 'Tpid Blocked'
    136:
      id: 'invalid_bulk_cancel'
      doc: 'Invalid Bulk Cancel'
    137:
      id: 'pending_bulk_cancel'
      doc: 'Pending Bulk Cancel'
    138:
      id: 'symbol_series_not_open'
      doc: 'Symbol Series Not Open'
    139:
      id: 'symbol_series_suspended'
      doc: 'Symbol Series Suspended'
    140:
      id: 'symbol_ipo_halt'
      doc: 'Symbol Ipo Halt'
    141:
      id: 'invld_inst_during_imbalance_freeze'
      doc: 'Invld Inst During Imbalance Freeze'
    142:
      id: 'invld_inst_after_cutoff_time'
      doc: 'Invld Inst After Cutoff Time'
    143:
      id: 'cancelled_by_primary_market'
      doc: 'Cancelled By Primary Market'
    144:
      id: 'pending_imbalance_freeze'
      doc: 'Pending Imbalance Freeze'
    145:
      id: 'no_rlp_permission'
      doc: 'No Rlp Permission'
    146:
      id: 'invalid_instruction_for_io_cs'
      doc: 'Invalid Instruction For Io Cs'
    147:
      id: 'system_full_cgrateexceeded'
      doc: 'System Full Cgrateexceeded'
    148:
      id: 'pending_cancel_auction_running'
      doc: 'Pending Cancel Auction Running'
    149:
      id: 'pending_modify_auction_running'
      doc: 'Pending Modify Auction Running'
    150:
      id: 'pending_replace_auction_running'
      doc: 'Pending Replace Auction Running'
    151:
      id: 'invld_inst_for_pending_order'
      doc: 'Invld Inst For Pending Order'
    152:
      id: 'ssh_price_below_nbb_on_iso'
      doc: 'Ssh Price Below Nbb On Iso'
    153:
      id: 'ioc_received_while_auction_running'
      doc: 'Ioc Received While Auction Running'
    154:
      id: 'pending_session_transition'
      doc: 'Pending Session Transition'
    155:
      id: 'pending_cancel_session_transition'
      doc: 'Pending Cancel Session Transition'
    156:
      id: 'pending_modify_session_transition'
      doc: 'Pending Modify Session Transition'
    157:
      id: 'pending_replace_session_transition'
      doc: 'Pending Replace Session Transition'
    158:
      id: 'invalid_for_tick_pilot'
      doc: 'Invalid For Tick Pilot'
    159:
      id: 'invalid_mmid'
      doc: 'Invalid Mmid'
    160:
      id: 'invalid_mpid'
      doc: 'Invalid Mpid'
    161:
      id: 'invalid_cancel_instead_of_reprice'
      doc: 'Invalid Cancel Instead Of Reprice'
    162:
      id: 'invalid_retail_indicator'
      doc: 'Invalid Retail Indicator'
    163:
      id: 'sender_comp_id_not_active'
      doc: 'Sender Comp Id Not Active'
    164:
      id: 'mpid_blocked'
      doc: 'Mpid Blocked'
    165:
      id: 'invalid_timestamp'
      doc: 'Invalid Timestamp'
    166:
      id: 'invalid_permission_for_sender_comp_id'
      doc: 'Invalid Permission For Sender Comp Id'
    167:
      id: 'invalid_user_data'
      doc: 'Invalid User Data'
    168:
      id: 'pillar_risk_mitigation'
      doc: 'Pillar Risk Mitigation'
    169:
      id: 'no_last_sale_for_peg'
      doc: 'No Last Sale For Peg'
    170:
      id: 'symbol_pending_closing_auction'
      doc: 'Symbol Pending Closing Auction'
    171:
      id: 'extreme_closing_order_imbalance'
      doc: 'Extreme Closing Order Imbalance'
    172:
      id: 'invalid_multi_message'
      doc: 'Invalid Multi Message'
    173:
      id: 'invalid_request_targeting_manual_sender_comp_id'
      doc: 'Invalid Request Targeting Manual Sender Comp Id'
    174:
      id: 'invalid_dmm_reject_reason'
      doc: 'Invalid Dmm Reject Reason'
    175:
      id: 'pending_pending_auction_state'
      doc: 'Pending Pending Auction State'
    176:
      id: 'pending_cancel_pending_auction_state'
      doc: 'Pending Cancel Pending Auction State'
    177:
      id: 'pending_modify_pending_auction_state'
      doc: 'Pending Modify Pending Auction State'
    178:
      id: 'pending_replace_pending_auction_state'
      doc: 'Pending Replace Pending Auction State'
    179:
      id: 'cancelled_dmm_manual_order_reprice'
      doc: 'Cancelled Dmm Manual Order Reprice'
    180:
      id: 'too_early_to_open'
      doc: 'Too Early To Open'
    181:
      id: 'too_early_to_close'
      doc: 'Too Early To Close'
    182:
      id: 'symbol_not_frozen_by_auction_request'
      doc: 'Symbol Not Frozen By Auction Request'
    183:
      id: 'symbol_is_frozen_by_dbk_gui'
      doc: 'Symbol Is Frozen By Dbk Gui'
    184:
      id: 'too_late_auction_running'
      doc: 'Too Late Auction Running'
    185:
      id: 'too_late_symbol_transition'
      doc: 'Too Late Symbol Transition'
    186:
      id: 'no_eligible_crossing_interest'
      doc: 'No Eligible Crossing Interest'
    187:
      id: 'book_is_lockedcrossed'
      doc: 'Book Is Lockedcrossed'
    188:
      id: 'no_interest_exists'
      doc: 'No Interest Exists'
    189:
      id: 'imbalance_too_large'
      doc: 'Imbalance Too Large'
    190:
      id: 'ssh_price_below_ssr_filing_price'
      doc: 'Ssh Price Below Ssr Filing Price'
    191:
      id: 'symbol_already_closed'
      doc: 'Symbol Already Closed'
    192:
      id: 'opening_template_opened'
      doc: 'Opening Template Opened'
    193:
      id: 'closing_template_opened'
      doc: 'Closing Template Opened'
    194:
      id: 'prin_entered_on_auction_template'
      doc: 'Prin Entered On Auction Template'
    195:
      id: 'mandatory_indication_submitted'
      doc: 'Mandatory Indication Submitted'
    196:
      id: 'pending_crowd_exists'
      doc: 'Pending Crowd Exists'
    197:
      id: 'no_consolidated_last_sale'
      doc: 'No Consolidated Last Sale'
    198:
      id: 'paired_qty_exceeds_max_trade_parameter'
      doc: 'Paired Qty Exceeds Max Trade Parameter'
    199:
      id: 'luld_or_mwcb_timer_running'
      doc: 'Luld Or Mwcb Timer Running'
    200:
      id: 'locking_crossing_away_quote'
      doc: 'Locking Crossing Away Quote'
    201:
      id: 'cross_not_eligible'
      doc: 'Cross Not Eligible'
    202:
      id: 'reserved_for_future_use_202'
      doc: 'Reserved For Future Use 202'
    203:
      id: 'pending_acceptance_for_ack_on_order_arrival'
      doc: 'Pending Acceptance For Ack On Order Arrival'
    204:
      id: 'rejected_cancel_by_dmm'
      doc: 'Rejected Cancel By Dmm'
    205:
      id: 'cancelled_by_dmm'
      doc: 'Cancelled By Dmm'
    206:
      id: 'price_is_outside_allowable_range'
      doc: 'Price Is Outside Allowable Range'
    207:
      id: 'auction_validation_in_progress'
      doc: 'Auction Validation In Progress'
    208:
      id: 'invalid_manual_action_id'
      doc: 'Invalid Manual Action Id'
    209:
      id: 'invalid_auction_sell_indicator'
      doc: 'Invalid Auction Sell Indicator'
    210:
      id: 'invalid_intraday_sell_short_qty'
      doc: 'Invalid Intraday Sell Short Qty'
    211:
      id: 'indication_template_is_open'
      doc: 'Indication Template Is Open'
    212:
      id: 'no_prev_closing_price'
      doc: 'No Prev Closing Price'
    213:
      id: 'cancelled_due_to_trading_collars'
      doc: 'Cancelled Due To Trading Collars'
    214:
      id: 'underlying_is_in_luld_state'
      doc: 'Underlying Is In Luld State'
    215:
      id: 'invalid_manual_response_type'
      doc: 'Invalid Manual Response Type'
    216:
      id: 'no_nyse_last_sale'
      doc: 'No Nyse Last Sale'
    217:
      id: 'symbol_direct_listing_state'
      doc: 'Symbol Direct Listing State'
    218:
      id: 'dmm_gui_reduction_in_manual_order_qty'
      doc: 'Dmm Gui Reduction In Manual Order Qty'
    219:
      id: 'cross_eligible'
      doc: 'Cross Eligible'
    220:
      id: 'dry_run'
      doc: 'Dry Run'
    221:
      id: 'unsupported_by_broker_plex'
      doc: 'Unsupported By Broker Plex'
    222:
      id: 'cross_blocked_by_bbopbbo'
      doc: 'Cross Blocked By Bbopbbo'
    223:
      id: 'risk_single_ord_max_qty'
      doc: 'Risk Single Ord Max Qty'
    224:
      id: 'risk_single_ord_max_notional'
      doc: 'Risk Single Ord Max Notional'
    225:
      id: 'risk_gross_credit_breach'
      doc: 'Risk Gross Credit Breach'
    226:
      id: 'risk_kill_switch'
      doc: 'Risk Kill Switch'
    227:
      id: 'invalid_route_to_broker'
      doc: 'Invalid Route To Broker'
    228:
      id: 'spread_too_wide'
      doc: 'Spread Too Wide'
    229:
      id: 'expire_fok'
      doc: 'Expire Fok'
    230:
      id: 'locks_displayed_interest'
      doc: 'Locks Displayed Interest'
    231:
      id: 'mm_quote_price_lockcross_contra_side_nbbo'
      doc: 'Mm Quote Price Lockcross Contra Side Nbbo'
    232:
      id: 'invalid_leg_symbols'
      doc: 'Invalid Leg Symbols'
    233:
      id: 'duplicate_leg_symbol'
      doc: 'Duplicate Leg Symbol'
    234:
      id: 'symbol_not_in_underlying'
      doc: 'Symbol Not In Underlying'
    235:
      id: 'leg_ratios_not_in_the_most_reduced_form'
      doc: 'Leg Ratios Not In The Most Reduced Form'
    236:
      id: 'option_leg_ratio_too_high'
      doc: 'Option Leg Ratio Too High'
    237:
      id: 'stock_leg_ratio_too_low'
      doc: 'Stock Leg Ratio Too Low'
    238:
      id: 'complex_series_already_exists'
      doc: 'Complex Series Already Exists'
    239:
      id: 'number_of_legs_incorrect'
      doc: 'Number Of Legs Incorrect'
    240:
      id: 'cancel_does_not_set_nbbo_inst'
      doc: 'Cancel Does Not Set Nbbo Inst'
    241:
      id: 'cancel_avoid_reprice_inst'
      doc: 'Cancel Avoid Reprice Inst'
    242:
      id: 'allow_reprice_once_then_cancel_inst'
      doc: 'Allow Reprice Once Then Cancel Inst'
    243:
      id: 'invalid_allocation_pct'
      doc: 'Invalid Allocation Pct'
    244:
      id: 'invalid_mm_quote_type'
      doc: 'Invalid Mm Quote Type'
    245:
      id: 'invalid_mm_sent_time'
      doc: 'Invalid Mm Sent Time'
    246:
      id: 'series_expired'
      doc: 'Series Expired'
    247:
      id: 'invalid_give_up_mmid'
      doc: 'Invalid Give Up Mmid'
    248:
      id: 'invalid_no_sides'
      doc: 'Invalid No Sides'
    249:
      id: 'pending_to_acceptance'
      doc: 'Pending To Acceptance'
    250:
      id: 'reserved_for_future_use_250'
      doc: 'Reserved For Future Use 250'
    251:
      id: 'invalid_bulk_action'
      doc: 'Invalid Bulk Action'
    252:
      id: 'invalid_cancel_scope'
      doc: 'Invalid Cancel Scope'
    253:
      id: 'no_legal_width_spread'
      doc: 'No Legal Width Spread'
    254:
      id: 'invalid_target_cancel_mpid'
      doc: 'Invalid Target Cancel Mpid'
    255:
      id: 'invalid_target_cancel_sender_comp_id'
      doc: 'Invalid Target Cancel Sender Comp Id'
    256:
      id: 'clear_the_book_prev_entered'
      doc: 'Clear The Book Prev Entered'
    257:
      id: 'timer_expired_api_allocation'
      doc: 'Timer Expired Api Allocation'
    258:
      id: 'invalid_number_of_quotes'
      doc: 'Invalid Number Of Quotes'
    259:
      id: 'invalid_order_id'
      doc: 'Invalid Order Id'
    260:
      id: 'risk_control_event'
      doc: 'Risk Control Event'
    261:
      id: 'to_rejected'
      doc: 'To Rejected'
    262:
      id: 'cancelled_corporate_action'
      doc: 'Cancelled Corporate Action'
    263:
      id: 'too_late_to_replace'
      doc: 'Too Late To Replace'
    264:
      id: 'invalid_ref_delta'
      doc: 'Invalid Ref Delta'
    265:
      id: 'invalid_stock_price'
      doc: 'Invalid Stock Price'
    266:
      id: 'reserved_for_future_use_266'
      doc: 'Reserved For Future Use 266'
    267:
      id: 'invalid_tied_to_stock'
      doc: 'Invalid Tied To Stock'
    268:
      id: 'too_late_to_allocate'
      doc: 'Too Late To Allocate'
    269:
      id: 'customer_interest_on_bbo'
      doc: 'Customer Interest On Bbo'
    270:
      id: 'ido_cannot_be_modified'
      doc: 'Ido Cannot Be Modified'
    271:
      id: 'cross_outside_bbo'
      doc: 'Cross Outside Bbo'
    272:
      id: 'pending_to_approval'
      doc: 'Pending To Approval'
    273:
      id: 'invalid_leg_open_close'
      doc: 'Invalid Leg Open Close'
    274:
      id: 'invalid_risk_control_type'
      doc: 'Invalid Risk Control Type'
    275:
      id: 'invalid_risk_control_activation'
      doc: 'Invalid Risk Control Activation'
    276:
      id: 'invalid_breach_action_request'
      doc: 'Invalid Breach Action Request'
    277:
      id: 'invalid_ioc_attribution'
      doc: 'Invalid Ioc Attribution'
    278:
      id: 'invalid_risk_action_type'
      doc: 'Invalid Risk Action Type'
    279:
      id: 'invalid_usd_limit'
      doc: 'Invalid Usd Limit'
    280:
      id: 'ido_already_exists'
      doc: 'Ido Already Exists'
    281:
      id: 'invalid_time_limit'
      doc: 'Invalid Time Limit'
    282:
      id: 'invalid_percentage_limit'
      doc: 'Invalid Percentage Limit'
    283:
      id: 'invalid_count_limit'
      doc: 'Invalid Count Limit'
    284:
      id: 'risk_roll_transact_breach'
      doc: 'Risk Roll Transact Breach'
    285:
      id: 'risk_roll_vol_breach'
      doc: 'Risk Roll Vol Breach'
    286:
      id: 'risk_roll_pct_breach'
      doc: 'Risk Roll Pct Breach'
    287:
      id: 'risk_roll_grmp_breach'
      doc: 'Risk Roll Grmp Breach'
    288:
      id: 'risk_mm_arbitrage_breach'
      doc: 'Risk Mm Arbitrage Breach'
    289:
      id: 'risk_mm_intrinsic_breach'
      doc: 'Risk Mm Intrinsic Breach'
    290:
      id: 'ido_must_exist'
      doc: 'Ido Must Exist'
    291:
      id: 'invalid_allocation_tag'
      doc: 'Invalid Allocation Tag'
    292:
      id: 'invalid_trade_tag'
      doc: 'Invalid Trade Tag'
    293:
      id: 'arbitrage_check'
      doc: 'Arbitrage Check'
    294:
      id: 'intrinsic_value_check'
      doc: 'Intrinsic Value Check'
    295:
      id: 'credit_debit_check'
      doc: 'Credit Debit Check'
    296:
      id: 'invalid_risk_user'
      doc: 'Invalid Risk User'
    297:
      id: 'invalid_risk_entity'
      doc: 'Invalid Risk Entity'
    298:
      id: 'invalid_flex_series_already_exists'
      doc: 'Invalid Flex Series Already Exists'
    299:
      id: 'invalid_flex_series_key'
      doc: 'Invalid Flex Series Key'
    300:
      id: 'invalid_clear_the_book'
      doc: 'Invalid Clear The Book'
    301:
      id: 'invalid_stock_qty'
      doc: 'Invalid Stock Qty'
    302:
      id: 'invalid_package_link_id'
      doc: 'Invalid Package Link Id'
    303:
      id: 'complex_max_series_breach'
      doc: 'Complex Max Series Breach'
    304:
      id: 'invalid_flex_eod_tag'
      doc: 'Invalid Flex Eod Tag'
    305:
      id: 'invalid_percentage_price'
      doc: 'Invalid Percentage Price'
    999:
      id: 'unknown_issue_encountered'
      doc: 'Unknown Issue Encountered'
  ack_type:
    1:
      id: 'new_interest'
      doc: 'New Interest Acknowledgement'
    2:
      id: 'order_priority_update_new_order_id'
      doc: 'Order Priority Update With New Order Id'
    3:
      id: 'order_priority_update_same_order_id'
      doc: 'Order Priority Update With Same Order Id'
    4:
      id: 'bulk_cancel_ack'
      doc: 'Bulk Cancel Acknowledgement'
    5:
      id: 'pending_cancel'
      doc: 'Cancel Request Is Pending'
    6:
      id: 'pending_replace'
      doc: 'Cancel Replace Request Is Pending'
    7:
      id: 'pending_modify'
      doc: 'Modify Request Is Pending'
    8:
      id: 'replaced'
      doc: 'Order Successfully Replaced'
    9:
      id: 'modified'
      doc: 'Order Successfully Modified'
    11:
      id: 'canceled'
      doc: 'Order Canceled'
    12:
      id: 'done_for_day'
      doc: 'Order Done For Day'
    17:
      id: 'gtc_renewal_or_restatement'
      doc: 'Gtc Renewal Or Restatement'
    18:
      id: 'individual_market_maker_quote_reject'
      doc: 'Individual Market Maker Quote Reject'
  throttled:
    0:
      id: 'not_throttled'
      doc: 'Inbound Message Was Not Throttled'
    1:
      id: 'throttled'
      doc: 'Inbound Message Was Throttled'
  multileg_reporting_type:
    1:
      id: 'single_leg_security'
      doc: 'Singleleg Security'
    2:
      id: 'individual_leg_of_multi_leg_security'
      doc: 'Individual Leg Of A Multileg Security'
    3:
      id: 'multi_leg_security'
      doc: 'Multileg Security'
  participant_type:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
  contra_open_close:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'close'
      doc: 'Close'
  contra_customer_or_firm:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'customer'
      doc: 'Customer'
    2:
      id: 'firm'
      doc: 'Firm'
    3:
      id: 'broker'
      doc: 'Broker'
    4:
      id: 'market_maker'
      doc: 'Market Maker'
    5:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    6:
      id: 'prof_customer'
      doc: 'Prof Customer'
  contra_cross_type:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    5:
      id: 'price_improvement_cube'
      doc: 'Price Improvement Cube'
    7:
      id: 'aoncube_solicitation'
      doc: 'Aon Cube Solicitation'
    10:
      id: 'qcc'
      doc: 'Qcc'
    11:
      id: 'customer_to_customer_cross'
      doc: 'Customer To Customer Cross'
  contra_covered_or_uncovered:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'exposed'
      doc: 'Exposed'
    2:
      id: 'covered'
      doc: 'Covered'
  covered_or_uncovered:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'exposed'
      doc: 'Exposed'
    2:
      id: 'covered'
      doc: 'Covered'
  bust_correct_indicator:
    0:
      id: 'trade_bust'
      doc: 'Trade Bust'
    1:
      id: 'trade_correction'
      doc: 'Trade Correction'
  reject_type:
    1:
      id: 'order_or_cancel_replace_reject'
      doc: 'Order Or Cancel Replace Reject'
    2:
      id: 'modify_request_reject'
      doc: 'Modify Request Reject'
    3:
      id: 'cancel_request_reject'
      doc: 'Cancel Request Reject'
    5:
      id: 'new_bulk_quote_reject'
      doc: 'New Bulk Quote Reject'
    7:
      id: 'risk_limit_update_request_reject'
      doc: 'Risk Limit Update Request Reject'
    8:
      id: 'bulk_cancel_request_reject_options'
      doc: 'Bulk Cancel Request Reject Options'
    9:
      id: 'cross_order_reject'
      doc: 'Cross Order Reject'
    10:
      id: 'new_complex_series_request_reject'
      doc: 'New Complex Series Request Reject'
    11:
      id: 'risk_action_request_reject'
      doc: 'Risk Action Request Reject'
  breach_action_response:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'notifications_only'
      doc: 'Notifications Only'
    2:
      id: 'cancel_non_auction_orders_and_block'
      doc: 'Cancel Non Auction Orders And Block'
    3:
      id: 'block'
      doc: 'Block'
  blocked_by_breach_indicator:
    0:
      id: 'not_blocked_by_breach'
      doc: 'Not Blocked By Breach'
    1:
      id: 'blocked_by_breach'
      doc: 'Blocked By Breach'
    2:
      id: 'blocked_by_arbitrage_check'
      doc: 'Blocked By Arbitrage Check Options Market Maker Only'
    3:
      id: 'blocked_by_intrinsic_value_check'
      doc: 'Blocked By Intrinsic Value Check Options Market Maker Only'
  blocked_by_kill_switch_indicator:
    0:
      id: 'not_blocked_by_kill_switch'
      doc: 'Not Blocked By Kill Switch'
    1:
      id: 'blocked_by_kill_switch'
      doc: 'Blocked By Kill Switch'
  reinstatement_required_by_self:
    0:
      id: 'not_required'
      doc: 'Not Required'
    1:
      id: 'required'
      doc: 'Required'
  reinstatement_required_by_other:
    0:
      id: 'not_required'
      doc: 'Not Required'
    1:
      id: 'required'
      doc: 'Required'
  threshold_breach_level:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    4:
      id: 'greater_than_100_percent'
      doc: 'Greater Than 100 Percent'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: New York Stock Exchange
#   Version: 3.25
#   Date: 10/17/2025
#   Specification: NYSE_Pillar_Options_Gateway_Binary_Protocol_Specification.pdf
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------
