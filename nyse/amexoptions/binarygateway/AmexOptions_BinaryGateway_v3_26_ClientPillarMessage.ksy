# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse AmexOptions BinaryGateway PillarStream v3.26
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Binary Gateway
#   Encoding: Pillar Stream Protocol
#   Version: 3.26
#   Date: 3/9/2026
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
  id: nyse_amexoptions_binarygateway_pillarstream_v3_26_clientpillarmessage
  title: Nyse AmexOptions BinaryGateway PillarStream v3.26
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Amex Options Binary Gateway PillarStream v3.26'
doc-ref: https://www.nyse.com/connectivity/specs

seq:
  - id: client_message
    type:
      switch-on: peek_msg_type
      cases:
        'msg_type::login': login_message
        'msg_type::heartbeat': heartbeat
        'msg_type::open': open
        'msg_type::close': close
        'msg_type::seq_msg': client_seq_msg

instances:
  peek_msg_type:
    pos: 0
    type: u2
    enum: msg_type

types:
  login_message:
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
  heartbeat:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
  open:
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
  stream_id:
    seq:
      - id: sess
        type: u4
        doc: '32 bit session id (env_id[31:24], sess_num[23:0])'
      - id: value_field
        type: u4
        doc: 'Stream identifier value (stream_type[31:24], user_id[23:8], sub_id[7:0])'
  close:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
  client_seq_msg:
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
        type: nanosecond_timestamp
        doc: 'Message timestamp. Nanoseconds since Unix epoch'
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: client_sequenced_message
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
        type: decimal_s8_8
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
        if: _parent.seq_msg_header.seq_msg_length != 100
        doc: 'OptionalOrderAddOn'
  optional_order_add_on:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: stop_px
        type: decimal_s8_8
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
        enum: side_u_81
        doc: 'Optional side change; zero indicates no change'
      - id: locate_reqd_u_81
        type: u1
        enum: locate_reqd_u_81
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
        enum: self_trade_type_u_81
        doc: 'Self-trade prevention setting applied to all quotes in the message'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: mm_sent_time
        type: nanosecond_timestamp
        doc: 'Customer-provided sending time in nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: quote_request_group
        type: quote_request_group
        repeat: eos
        doc: 'Repeating group containing one to twenty single-sided market maker quotes'
  quote_request_group:
    seq:
      - id: series_index
        type: u4
        doc: 'Options series index used for order entry'
      - id: bitfield_quote_inst
        type: bitfield_quote_inst
        doc: 'Quote instructions, attributes, and modifiers for market maker quotes'
      - id: price
        type: decimal_s8_8
        doc: 'Order price; net limit price for complex orders. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: 'Total order quantity'
  bitfield_quote_inst:
    meta:
      bit-endian: le
    seq:
      - id: side_2
        type: b2
        doc: 'Quote side'
      - id: mm_quote_type
        type: b3
        doc: 'Market maker quote type'
      - id: unused_3
        type: b3
        doc: 'Reserved for future use'
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
        enum: self_trade_type_u_81
        doc: 'Self-trade prevention setting applied to all quotes in the message'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group applied to all quotes in the message'
      - id: mm_sent_time
        type: nanosecond_timestamp
        doc: 'Customer-provided sending time in nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: quote_request_group
        type: quote_request_group
        repeat: eos
        doc: 'Repeating group containing one to twenty single-sided market maker quotes'
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
        type: decimal_s8_8
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
        if: _parent._parent.seq_msg_header.seq_msg_length != 100
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
        type: decimal_s8_8
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
        if: _parent._parent.seq_msg_header.seq_msg_length != 100
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
        type: nanosecond_timestamp
        doc: 'Customer-provided sending time in nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: side_u_81
        type: u1
        enum: side_u_81
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
        enum: side_u_81
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0

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
  seq_msg_type:
    0x0220:
      id: 'session_configuration_request_message'
      doc: 'Request to update gateway session configuration settings'
    0x0282:
      id: 'sequenced_filler_message'
      doc: 'This message type is used to increase the next expected sequence number of a TG stream by 1 on a given gateway session.'
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
      doc: 'Enable cancel on disconnect for day orders only, with standard exclusions'
    2:
      id: 'cancel_all_orders'
      doc: 'Enable cancel on disconnect for all orders in the session'
  throttle_preference:
    0:
      id: 'queue_when_throttled'
      doc: 'Queue orders when throttled'
    1:
      id: 'reject_when_throttled'
      doc: 'Reject orders when throttled'
  self_trade_prevention:
    1:
      id: 'no_self_trade_prevention'
      doc: 'No self trade prevention'
    2:
      id: 'cancel_newest'
      doc: 'Cancel newest order'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel oldest order'
    4:
      id: 'cancel_both'
      doc: 'Cancel both orders'
  order_priority_update_ack_subscription:
    0:
      id: 'not_subscribed'
      doc: 'No unsolicited order priority update or repricing acknowledgements'
    1:
      id: 'order_priority_update_only'
      doc: 'Receive unsolicited order priority update acknowledgements'
    2:
      id: 'order_priority_update_and_repricing'
      doc: 'Receive unsolicited order priority update and repricing acknowledgements'
  bold_designation:
    0:
      id: 'not_applicable'
      doc: 'Not applicable or do not change default'
    4:
      id: 'expose_order_info_only'
      doc: 'BOLD expose order information only'
    5:
      id: 'expose_order_info_and_capacity'
      doc: 'BOLD expose order information and capacity'
    6:
      id: 'expose_order_info_and_participant_id'
      doc: 'BOLD expose order information and participant ID'
    7:
      id: 'expose_order_info_capacity_and_participant_id'
      doc: 'BOLD expose order information, capacity, and participant ID'
    8:
      id: 'no_bold_defaulting'
      doc: 'No BOLD designation defaulting'
  leg_open_close:
    0:
      id: 'open'
      doc: 'Open'
    1:
      id: 'close'
      doc: 'Close'
  side_u_81:
    0:
      id: 'no_change_in_side'
      doc: 'no change in Side'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  locate_reqd_u_81:
    0:
      id: 'no_locate_reqd'
      doc: 'No locate required'
  self_trade_type_u_81:
    0:
      id: 'use_session_configuration'
      doc: 'Use session configuration self-trade prevention setting'
    1:
      id: 'no_self_trade_prevention'
      doc: 'No self-trade prevention'
    2:
      id: 'cancel_newest'
      doc: 'Cancel newest order'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel oldest order'
    4:
      id: 'cancel_both'
      doc: 'Cancel both orders'
  mm_quote_type:
    0:
      id: 'standard'
      doc: 'Standard market maker quote'
    1:
      id: 'repricing'
      doc: 'Repricing quote'
  bulk_action:
    0:
      id: 'not_applicable'
      doc: 'No bulk action specified'
    1:
      id: 'cancel_single_leg_only'
      doc: 'Cancel single-leg orders only'
    2:
      id: 'cancel_complex_only'
      doc: 'Cancel complex orders only'
    3:
      id: 'cancel_single_and_complex'
      doc: 'Cancel both single-leg and complex orders'
    4:
      id: 'block_and_cancel'
      doc: 'Block future quotes and cancel existing ones (Market Maker sessions only)'
    5:
      id: 'unblock'
      doc: 'Unblock previously blocked quotes (Market Maker sessions only)'
  cancel_scope:
    0:
      id: 'orders_only'
      doc: 'Cancel orders only'
    1:
      id: 'quotes_only'
      doc: 'Cancel options market maker quotes only'
    2:
      id: 'orders_and_quotes'
      doc: 'Cancel both orders and market maker quotes'
  risk_user_type:
    0x45:
      id: 'entering_firm'
      doc: 'Entering firm owns the risk control'
    0x43:
      id: 'clearing_firm'
      doc: 'Clearing firm owns the risk control'
    0x4f:
      id: 'options_market_maker_firm'
      doc: 'Options market maker firm owns the risk control'
  risk_control_type:
    0:
      id: 'not_applicable'
      doc: 'Not applicable'
    1:
      id: 'single_order_max_qty'
      doc: 'Single order maximum quantity'
    2:
      id: 'single_order_max_notional'
      doc: 'Single order maximum notional value'
    3:
      id: 'gross_credit_executed'
      doc: 'Gross credit executed'
    4:
      id: 'gross_credit_open'
      doc: 'Gross credit open'
    5:
      id: 'gross_credit_open_and_executed'
      doc: 'Gross credit open plus executed'
    6:
      id: 'maximum_duplicative_orders'
      doc: 'Maximum duplicative orders'
    8:
      id: 'activity_rolling_transaction'
      doc: 'Activity-based rolling transaction limit'
    9:
      id: 'activity_rolling_volume'
      doc: 'Activity-based rolling volume limit'
    10:
      id: 'activity_rolling_percentage'
      doc: 'Activity-based rolling percentage limit'
    11:
      id: 'global_risk_mitigation_protection'
      doc: 'Global risk mitigation protection'
    13:
      id: 'reject_market_orders'
      doc: 'Reject market orders except MOO and MOC'
    14:
      id: 'reject_moo_and_moc'
      doc: 'Reject MOO and MOC orders'
    19:
      id: 'reject_restricted_symbol'
      doc: 'Reject orders for restricted symbol'
    26:
      id: 'limit_order_price_protection_options_single_leg'
      doc: 'Limit order price protection options single-leg custom limits'
    27:
      id: 'limit_order_price_protection_options_complex'
      doc: 'Limit order price protection options complex custom limits'
    29:
      id: 'order_rate_threshold'
      doc: 'Order rate threshold across all symbols'
    30:
      id: 'reject_isoioc'
      doc: 'Reject ISO IOC orders'
    31:
      id: 'reject_iso_day'
      doc: 'Reject ISO Day orders'
  risk_control_activation:
    0:
      id: 'off_field'
      doc: 'Risk control turned off'
    1:
      id: 'on_field'
      doc: 'Risk control turned on'
  breach_action_request:
    0:
      id: 'not_applicable'
      doc: 'No breach action'
    1:
      id: 'notifications_only'
      doc: 'Send notifications only'
    2:
      id: 'cancel_and_block'
      doc: 'Cancel non-auction orders and block further activity'
    3:
      id: 'block_only'
      doc: 'Block further activity only'
  ioc_attribution:
    0:
      id: 'not_applicable'
      doc: 'Not applicable'
    1:
      id: 'include_ioc'
      doc: 'Include IOC orders in activity-based calculations'
    2:
      id: 'exclude_ioc'
      doc: 'Exclude IOC orders from activity-based calculations'
  price_scale:
    0:
      id: 'no_decimals'
      doc: 'Value interpreted as integer'
    2:
      id: 'two_decimals'
      doc: 'Value interpreted with two decimal places'
  risk_action_type:
    0:
      id: 'not_applicable'
      doc: 'No action specified'
    1:
      id: 'query'
      doc: 'Query risk entity for current risk control configuration, calculations, and status'
    2:
      id: 'kill_switch_block'
      doc: 'Invoke kill switch block action'
    3:
      id: 'kill_switch_unblock'
      doc: 'Invoke kill switch unblock action'
    4:
      id: 'kill_switch_cancel_auction_orders'
      doc: 'Cancel auction orders via kill switch'
    5:
      id: 'kill_switch_cancel_non_auction_orders'
      doc: 'Cancel non-auction orders via kill switch'
    6:
      id: 'kill_switch_cancel_gtc_orders'
      doc: 'Cancel good-til-cancel orders via kill switch'
    7:
      id: 'approve_reinstatement'
      doc: 'Approve reinstatement following a block breach'
    8:
      id: 'risk_entity_reinstated'
      doc: 'All reinstatement approvals received and processed'
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  status:
    0:
      id: 'request_processed_successfully'
      doc: 'Request processed successfully'
    18:
      id: 'not_logged_in'
      doc: 'Not logged in'
    24:
      id: 'invalid_login_details'
      doc: 'Invalid login details'
    27:
      id: 'already_logged_in'
      doc: 'Already logged in'
    28:
      id: 'heartbeat_timeout'
      doc: 'Heartbeat timeout'
    29:
      id: 'login_timed_out'
      doc: 'Login timed out'
    33:
      id: 'invalid_message'
      doc: 'Invalid message'
    54:
      id: 'no_stream_permission'
      doc: 'No stream permission'
    81:
      id: 'invalid_protocol_version'
      doc: 'Invalid protocol version'
    82:
      id: 'message_out_of_sequence'
      doc: 'Message out of sequence'
    84:
      id: 'invalid_stream'
      doc: 'Invalid stream'
    85:
      id: 'stream_not_open'
      doc: 'Stream not open'
    86:
      id: 'invalid_timestamp'
      doc: 'Invalid timestamp'
    89:
      id: 'denial_of_service'
      doc: 'Denial of service'
    90:
      id: 'write_permission_revoked'
      doc: 'Write permission revoked'
    93:
      id: 'invalid_multimessage'
      doc: 'Invalid Multi-message'
  underlying_type:
    0x41:
      id: 'adr'
      doc: 'American Depositary Receipt'
    0x43:
      id: 'common_stock'
      doc: 'Common stock'
    0x44:
      id: 'debentures'
      doc: 'Debentures'
    0x45:
      id: 'etf'
      doc: 'Exchange traded fund'
    0x46:
      id: 'foreign'
      doc: 'Foreign security'
    0x48:
      id: 'ads'
      doc: 'American Depositary Shares'
    0x49:
      id: 'units'
      doc: 'Units'
    0x4d:
      id: 'miscellaneous'
      doc: 'Miscellaneous others'
    0x4c:
      id: 'index_linked_notes'
      doc: 'Index linked notes'
    0x4e:
      id: 'bonds'
      doc: 'Bonds'
    0x4f:
      id: 'ordinary_shares'
      doc: 'Ordinary shares'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred stock'
    0x52:
      id: 'rights'
      doc: 'Rights'
    0x53:
      id: 'beneficiary_interest'
      doc: 'Beneficiary interest'
    0x54:
      id: 'structured_notes'
      doc: 'Structured notes'
    0x55:
      id: 'closed_end_fund'
      doc: 'Closed end fund'
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
      doc: 'Production symbol'
    1:
      id: 'test'
      doc: 'Test symbol'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put option'
    1:
      id: 'call'
      doc: 'Call option'
  series_type:
    0:
      id: 'standard'
      doc: 'Standard option series'
  closing_only_indicator:
    0:
      id: 'standard_series'
      doc: 'Standard series'
    1:
      id: 'closing_only_series'
      doc: 'Closing-only series'
  mpid_status:
    1:
      id: 'active'
      doc: 'MPID is active'
    2:
      id: 'inactive'
      doc: 'MPID is inactive'
    3:
      id: 'prospect'
      doc: 'MPID is in prospect status'
  mm_type:
    1:
      id: 'nyse_american_options_market_maker'
      doc: 'NYSE American Options Market Maker'
    2:
      id: 'nyse_american_options_specialist'
      doc: 'NYSE American Options Specialist'
    3:
      id: 'nyse_american_optionse_specialist'
      doc: 'NYSE American Options e-Specialist'
    4:
      id: 'nyse_american_options_domm'
      doc: 'NYSE American Options DOMM'
    5:
      id: 'nyse_american_options_specialist_and_domm'
      doc: 'NYSE American Options Specialist and DOMM'
    6:
      id: 'nyse_american_optionse_specialist_and_domm'
      doc: 'NYSE American Options e-Specialist and DOMM'
  appointment_status:
    0:
      id: 'not_appointed'
      doc: 'Not appointed for the underlying symbol'
    1:
      id: 'appointed'
      doc: 'Appointed for the underlying symbol'
  user_session_type:
    1:
      id: 'customer'
      doc: 'Customer and/or Equities Market Maker session'
    2:
      id: 'service_bureau'
      doc: 'Service Bureau session'
    4:
      id: 'options_market_maker'
      doc: 'Options Market Maker session'
    12:
      id: 'risk_admin'
      doc: 'Risk Administrator session'
  user_session_status:
    1:
      id: 'active'
      doc: 'Permission to open read/write streams'
    2:
      id: 'inactive'
      doc: 'Permission to open read-only streams'
    3:
      id: 'prospect'
      doc: 'Prospect status with read-only access'
  symbol_eligibility:
    1:
      id: 'all_symbols'
      doc: 'Production and Test symbols allowed'
    2:
      id: 'test_symbols_only'
      doc: 'Only Test symbols allowed'
  ack_status:
    0:
      id: 'unsolicited'
      doc: 'Start-of-day or unsolicited acknowledgement'
    1:
      id: 'user_request_valid'
      doc: 'User request accepted'
    2:
      id: 'user_request_invalid'
      doc: 'User request rejected'
  working_away_from_display:
    0:
      id: 'equal_to_display_price'
      doc: 'Working price equals display price'
    1:
      id: 'away_from_display_price'
      doc: 'Working price differs from display price'
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
      id: 'system_full_meng_rate_exceeded'
      doc: 'System Full Meng Rate Exceeded'
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
      id: 'system_full_cg_rate_exceeded'
      doc: 'System Full Cg Rate Exceeded'
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
      doc: 'New Interest acknowledgement'
    2:
      id: 'order_priority_update_new_order_id'
      doc: 'Order priority update with new OrderID'
    3:
      id: 'order_priority_update_same_order_id'
      doc: 'Order priority update with same OrderID'
    4:
      id: 'bulk_cancel_ack'
      doc: 'Bulk cancel acknowledgement'
    5:
      id: 'pending_cancel'
      doc: 'Cancel request is pending'
    6:
      id: 'pending_replace'
      doc: 'Cancel/Replace request is pending'
    7:
      id: 'pending_modify'
      doc: 'Modify request is pending'
    8:
      id: 'replaced'
      doc: 'Order successfully replaced'
    9:
      id: 'modified'
      doc: 'Order successfully modified'
    11:
      id: 'canceled'
      doc: 'Order canceled'
    12:
      id: 'done_for_day'
      doc: 'Order done for day'
    17:
      id: 'gtc_renewal_or_restatement'
      doc: 'GTC renewal or restatement'
    18:
      id: 'individual_market_maker_quote_reject'
      doc: 'individual Market Maker quote Reject'
  throttled:
    0:
      id: 'not_throttled'
      doc: 'Inbound message was not throttled'
    1:
      id: 'throttled'
      doc: 'Inbound message was throttled'
  multileg_reporting_type:
    1:
      id: 'single_leg_security'
      doc: 'Single-leg security'
    2:
      id: 'individual_leg_of_multi_leg_security'
      doc: 'Individual leg of a multi-leg security'
    3:
      id: 'multi_leg_security'
      doc: 'Multi-leg security'
  participant_type:
    0:
      id: 'not_applicable'
      doc: 'Not applicable'
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
      doc: 'Prof customer'
  contra_cross_type:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    5:
      id: 'price_improvement_cube'
      doc: 'Price Improvement CUBE'
    7:
      id: 'aoncube_solicitation'
      doc: 'AON CUBE (Solicitation)'
    10:
      id: 'qcc'
      doc: 'QCC'
    11:
      id: 'customer_to_customer_cross'
      doc: 'Customer to Customer Cross'
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
  open_close_u_81:
    0:
      id: 'not_applicable'
      doc: 'Not applicable'
    1:
      id: 'open'
      doc: 'Open position'
    2:
      id: 'close'
      doc: 'Close position'
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
      doc: 'Cancel Non-Auction Orders and Block'
    3:
      id: 'block'
      doc: 'Block'
  blocked_by_breach_indicator:
    0:
      id: 'not_blocked_by_breach'
      doc: 'Not Blocked by Breach'
    1:
      id: 'blocked_by_breach'
      doc: 'Blocked by Breach'
    2:
      id: 'blocked_by_arbitrage_check'
      doc: 'Blocked by Arbitrage Check (Options Market Maker only)'
    3:
      id: 'blocked_by_intrinsic_value_check'
      doc: 'Blocked by Intrinsic Value Check (Options Market Maker only)'
  blocked_by_kill_switch_indicator:
    0:
      id: 'not_blocked_by_kill_switch'
      doc: 'Not Blocked by Kill Switch'
    1:
      id: 'blocked_by_kill_switch'
      doc: 'Blocked by Kill Switch'
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

