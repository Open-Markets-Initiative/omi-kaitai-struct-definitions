# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CxjEquities BinaryOrderEntry Boe3 v1.0.12
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.0.12
#   Date: 06/09/2025
#   Specification: CXJ Equities BOEv3 Specification.pdf
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
  id: cboe_cxjequities_binaryorderentry_boe3_v1_0_12_firm
  title: Cboe CxjEquities BinaryOrderEntry Boe3 v1.0.12
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Japan Binary Order Entry Boe3 v1.0.12'
doc-ref: https://www.cboe.com/jp/equities/support/technical/

seq:
  - id: firm_message_header
    type: firm_message_header_struct
    doc: 'Message header of a packet sent by the firm'
  - id: firm_message
    type:
      switch-on: firm_message_header.firm_message_type
      cases:
        'firm_message_type::login_request_message': login_request_message
        'firm_message_type::new_order_jp_equities_v_1': new_order_jp_equities_v_1
        'firm_message_type::modify_order_jp_equities_v_1': modify_order_jp_equities_v_1
        'firm_message_type::cancel_order_jp_equities_v_1': cancel_order_jp_equities_v_1
        'firm_message_type::purge_orders_jp_equities_v_1': purge_orders_jp_equities_v_1

types:
  firm_message_header_struct:
    seq:
      - id: start_of_message
        type: u2
        doc: 'B0 E3 (58288)'
      - id: message_length
        type: u2
        doc: 'Number of bytes for the message, including this field but not including the two bytes of the StartOfMessage field'
      - id: firm_message_type
        type: u2
        enum: firm_message_type
        doc: 'type of message'
      - id: matching_unit
        type: u1
        doc: 'The matching unit which created this message. Matching units in BOE correspond to matching units on Multicast PITCH'
      - id: reserved_field
        type: u1
        doc: 'Reserved header field'
      - id: sequence_number
        type: u4
        doc: 'Last Received Sequence number for the unit'
  login_request_message:
    seq:
      - id: session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Session Id as supplied by CFE'
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Session Sub Id as supplied by CFE'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'The password associated with the SessionId and SessionSubId'
      - id: replay_unspecified_unit
        type: u1
        enum: replay_unspecified_unit
        doc: 'Controls replay behavior for unknown units'
      - id: num_unit_sequence
        type: u1
        doc: 'The number (possibly 0) of unit/sequence pairs to follow, one per unit from which the TPH has received messages over this port. The value must be 0 or 1 since all BOEv3 ports are associated to a single unit'
      - id: unit_sequence
        type: unit_sequence
        repeat: expr
        repeat-expr: num_unit_sequence
        doc: 'Unit Sequence'
  unit_sequence:
    seq:
      - id: unit_number
        type: u1
        doc: 'A unit number'
      - id: sequence_number
        type: u4
        doc: 'Last Received Sequence number for the unit'
  new_order_jp_equities_v_1:
    seq:
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Used by a trading participant to provide a broker cross reference'
      - id: trading_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'The four-character identifier of the trading firm'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id chosen by the participant'
      - id: order_qty
        type: u4
        doc: 'Order quantity. System limit is 999,999,999'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: price
        type: decimal_s8_4
        doc: 'Price must be an applicable minimum trading increment. Implied decimal with scale 1e-4'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity for the order. Required on all orders'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Instrument symbol (QUICK symbology)'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required for GTD order (TimeInForce = 6), ExpireTime specifies the date-time (in UTC) when the order expires. Nanoseconds since Unix epoch'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Indicates the type of cash or margin order'
      - id: risk_group_id
        type: u2
        doc: 'Used to group orders for use in order purges where multiple orders can be cancelled by specifying a list of RiskGroupIDs'
      - id: no_trade_feat
        type: u1
        enum: no_trade_feat
        doc: 'Ignored if NoTradeKey is not set. Declares the handling of self-trading. Nullable, Apply The Port Default = 0'
      - id: no_trade_key
        type: str
        size: 10
        encoding: ASCII
        doc: 'Interactions of orders from the same participant with the same NoTradeKey value will be managed by the newer order''s NoTradeFeat instruction'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'Posting instruction. Nullable, Allow Taking = 0'
      - id: order_classification
        type: u1
        enum: order_classification
        doc: 'Specify the order classification. Nullable, Not Specified = 0'
      - id: margin_transaction_type
        type: u1
        enum: margin_transaction_type
        doc: 'Specifies if a margin order is a Negotiable or a Standardized. Nullable, None = 0'
      - id: company_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Up to 4 alphanumeric characters to identify the order entry firm. This field is not validated'
  modify_order_jp_equities_v_1:
    seq:
      - id: trading_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'The four-character identifier of the trading firm'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id chosen by the participant'
      - id: order_qty
        type: u4
        doc: 'Order quantity. System limit is 999,999,999'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ClOrdID of the original order'
      - id: price
        type: decimal_s8_4
        doc: 'Price must be an applicable minimum trading increment. Implied decimal with scale 1e-4'
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        doc: 'Cancel original order if modification fails. Nullable, Apply Port Default = 0'
  cancel_order_jp_equities_v_1:
    seq:
      - id: trading_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'The four-character identifier of the trading firm'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ClOrdID of the original order'
  purge_orders_jp_equities_v_1:
    seq:
      - id: trading_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'The four-character identifier of the trading firm'
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        doc: 'At least one character must be provided (Firm Filter)'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'User-defined identifier of the mass cancel or purge request'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Instrument symbol (QUICK symbology)'
      - id: num_risk_group_id
        type: u1
        doc: 'Number of repeating RiskGroupID included in this message. Value 0 to 10'
      - id: risk_group_id
        type: u2
        doc: 'Used to group orders for use in order purges where multiple orders can be cancelled by specifying a list of RiskGroupIDs'
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
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

enums:
  firm_message_type:
    1:
      id: 'login_request_message'
      doc: 'A Login Request message must be sent as the first message upon connection'
    2:
      id: 'logout_request_message'
      doc: 'A Login Request message must be sent as the first message upon connection'
    3:
      id: 'client_heartbeat_message'
      doc: 'Client Heartbeat'
    5001:
      id: 'new_order_jp_equities_v_1'
      doc: 'Submission of a new order to Cboe Japan'
    5002:
      id: 'modify_order_jp_equities_v_1'
      doc: 'Request to modify an order. Only Price and OrderQty may be adjusted'
    5003:
      id: 'cancel_order_jp_equities_v_1'
      doc: 'Request to cancel a single order'
    5004:
      id: 'purge_orders_jp_equities_v_1'
      doc: 'Request to cancel a group of orders across all of the participant''s sessions'
  replay_unspecified_unit:
    0x46:
      id: 'fail_if_unit_not_specified'
      doc: 'Fail If Unit Not Specified'
    0x52:
      id: 'replay_any_unspecified_unit_from_zero'
      doc: 'Replay Any Unspecified Unit From Zero'
    0x53:
      id: 'skip_replay_of_unspecified_units'
      doc: 'Skip Replay Of Unspecified Units'
  ord_type:
    0x32:
      id: 'limit'
      doc: 'Limit'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x35:
      id: 'sell_short'
      doc: 'Sell Short'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  time_in_force:
    0x30:
      id: 'day_default'
      doc: 'Day Default'
    0x33:
      id: 'ioc'
      doc: 'portion not filled immediately is cancelled.'
    0x34:
      id: 'fok'
      doc: 'an IOC where the entire size must be filled immediately, otherwise the order will be cancelled back.'
    0x36:
      id: 'gtd'
      doc: 'expires at earlier of specified ExpireTime or end of day.'
  cash_margin:
    0x31:
      id: 'cash'
      doc: 'Cash'
    0x32:
      id: 'margin_open'
      doc: 'Margin Open'
    0x33:
      id: 'margin_close'
      doc: 'Margin Close'
  no_trade_feat:
    0x55:
      id: 'no_self_trade_protection'
      doc: 'No Self Trade Protection'
    0x4e:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    0x4f:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    0x42:
      id: 'cancel_both'
      doc: 'Cancel Both'
    0x53:
      id: 'cancel_smallest'
      doc: 'Cancel Smallest'
    0x44:
      id: 'decrement_larger_cancel_smaller'
      doc: 'Decrement Larger Cancel Smaller'
    0x64:
      id: 'same_as_d_above_but_only_decrement_leaves_qty'
      doc: 'Do not restate OrderQty.'
  posting_instruction:
    0x50:
      id: 'post_only_never_take_liquidity'
      doc: 'Post Only Never Take Liquidity'
  order_classification:
    0x31:
      id: 'non_low_latency_trading_auto'
      doc: 'Non Low Latency Trading Auto'
    0x32:
      id: 'non_low_latency_trading_manual'
      doc: 'Non Low Latency Trading Manual'
    0x33:
      id: 'market_making_strategy'
      doc: 'Market Making Strategy'
    0x34:
      id: 'arbitrage_strategy'
      doc: 'Arbitrage Strategy'
    0x35:
      id: 'directional_strategy'
      doc: 'Directional Strategy'
    0x36:
      id: 'other_strategy'
      doc: 'Other Strategy'
  margin_transaction_type:
    0x31:
      id: 'negotiable'
      doc: 'Negotiable'
    0x32:
      id: 'standardized'
      doc: 'Standardized'
  cancel_orig_on_reject:
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
  exchange_message_type:
    501:
      id: 'login_response_message'
      doc: 'A Login Response message is sent in response to a Login Request message'
    502:
      id: 'replay_complete_message'
      doc: 'Replay Complete'
    503:
      id: 'logout_response_message'
      doc: 'A Logout Response is usually sent in response to a Logout Request'
    504:
      id: 'server_heartbeat_message'
      doc: 'Server Heartbeat'
    5501:
      id: 'order_acknowledgement_jp_equities_v_1'
      doc: 'Order Acknowledgement messages are sent in response to a New Order message'
    5502:
      id: 'order_rejected_jp_equities_v_1'
      doc: 'Order Rejected messages are sent in response to a New Order which must be rejected'
    5503:
      id: 'order_modified_jp_equities_v_1'
      doc: 'Order Modified messages are sent in response to a Modify Order to indicate that the order has been successfully modified'
    5504:
      id: 'modify_rejected_jp_equities_v_1'
      doc: 'Modify Rejected messages are sent in response to a Modify Order for an order which cannot be modified'
    5505:
      id: 'order_restated_jp_equities_v_1'
      doc: 'If an order is cancelled or reduced due to Self-Trade Protection instructions, the order will be restated with reductions to OrderQty and/or LeavesQty'
    5506:
      id: 'order_execution_jp_equities_v_1'
      doc: 'An Order Execution is sent for each fill on an order'
    5507:
      id: 'order_cancelled_jp_equities_v_1'
      doc: 'Order Cancelled message'
    5508:
      id: 'cancel_rejected_jp_equities_v_1'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur'
    5510:
      id: 'purge_acknowledgement_jp_equities_v_1'
      doc: 'A Purge Acknowledgment is an unsequenced message sent when a Purge Orders message requesting an order purge has completed cancelling all individual orders'
    5511:
      id: 'purge_rejected_jp_equities_v_1'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur'
  login_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x44:
      id: 'disabled'
      doc: 'Disabled'
    0x49:
      id: 'invalid_unit'
      doc: 'Invalid Unit'
    0x4d:
      id: 'invalid_message'
      doc: 'Invalid Message'
    0x4e:
      id: 'not_authorized'
      doc: 'Not Authorized'
    0x51:
      id: 'sequence_ahead'
      doc: 'Sequence Ahead'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
  logout_reason:
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x41:
      id: 'administrative'
      doc: 'Administrative'
    0x21:
      id: 'protocol_violation'
      doc: 'Protocol Violation'
  base_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Japan will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Message directed to the DR data center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Cancel reason for the unexecuted size of an IOC/FOK order.'
    0x4f:
      id: 'cl_ord_id_does_not_match_a_known_order'
      doc: 'Cl Ord Id Does Not Match A Known Order'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Cancellation of an expired GTD order'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x79:
      id: 'order_received_by_cboe_japan_during_replay'
      doc: 'Order Received By Cboe Japan During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Japan will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Message directed to the DR data center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Cancel reason for the unexecuted size of an IOC/FOK order.'
    0x4f:
      id: 'cl_ord_id_does_not_match_a_known_order'
      doc: 'Cl Ord Id Does Not Match A Known Order'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Cancellation of an expired GTD order'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x79:
      id: 'order_received_by_cboe_japan_during_replay'
      doc: 'Order Received By Cboe Japan During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  restatement_reason:
    0x57:
      id: 'would_have_selftraded'
      doc: 'Would Have Selftraded'
  last_capacity:
    0x31:
      id: 'agent'
      doc: 'Agent'
    0x32:
      id: 'cross_as_agent'
      doc: 'Cross As Agent'
    0x33:
      id: 'cross_as_principal'
      doc: 'Cross As Principal'
    0x34:
      id: 'principal'
      doc: 'Principal'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Japan will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Message directed to the DR data center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Cancel reason for the unexecuted size of an IOC/FOK order.'
    0x4f:
      id: 'cl_ord_id_does_not_match_a_known_order'
      doc: 'Cl Ord Id Does Not Match A Known Order'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Cancellation of an expired GTD order'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x79:
      id: 'order_received_by_cboe_japan_during_replay'
      doc: 'Order Received By Cboe Japan During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Japan will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Message directed to the DR data center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Cancel reason for the unexecuted size of an IOC/FOK order.'
    0x4f:
      id: 'cl_ord_id_does_not_match_a_known_order'
      doc: 'Cl Ord Id Does Not Match A Known Order'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Cancellation of an expired GTD order'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x79:
      id: 'order_received_by_cboe_japan_during_replay'
      doc: 'Order Received By Cboe Japan During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Japan will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Message directed to the DR data center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Cancel reason for the unexecuted size of an IOC/FOK order.'
    0x4f:
      id: 'cl_ord_id_does_not_match_a_known_order'
      doc: 'Cl Ord Id Does Not Match A Known Order'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Cancellation of an expired GTD order'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x79:
      id: 'order_received_by_cboe_japan_during_replay'
      doc: 'Order Received By Cboe Japan During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'

