# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseEquities BinaryGateway PillarStream v5.17
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Binary Gateway
#   Encoding: Pillar Stream Protocol
#   Version: 5.17
#   Date: 10/17/2025
#   Specification: NYSE_Pillar_Gateway_Binary_Protocol_Specification.pdf
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
  id: nyseequities_binarygateway_v5_17
  title: Nyse NyseEquities BinaryGateway PillarStream v5.17
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Equities Binary Gateway PillarStream v5.17'
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
        doc: 'Unique identifier of the gateway session – SenderCompID'
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
        doc: 'Unique identifier of the gateway session – SenderCompID'
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
        doc: '32 bit session id (env_id[31:24], sess_num[23:0])'
      - id: value_field
        type: u4
        doc: 'Stream identifier value (stream_type[31:24], user_id[23:8], sub_id[7:0])'
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
        doc: 'Bytes reserved for future use'
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
            'seq_msg_type::new_order_single_and_cancel_replace_request_message': new_order_single_and_cancel_replace_request_message
            'seq_msg_type::order_cancel_request_message': order_cancel_request_message
            'seq_msg_type::order_modify_request_message': order_modify_request_message
            'seq_msg_type::bulk_cancel_request_message': bulk_cancel_request_message
            'seq_msg_type::symbol_subscription_request_message': symbol_subscription_request_message
            'seq_msg_type::manual_action_response_message': manual_action_response_message
            'seq_msg_type::risk_limit_update_request_message': risk_limit_update_request_message
            'seq_msg_type::risk_action_request_message': risk_action_request_message
            'seq_msg_type::equities_symbol_reference_data_message': equities_symbol_reference_data_message
            'seq_msg_type::dmm_symbol_reference_data_message': dmm_symbol_reference_data_message
            'seq_msg_type::minimum_price_variant_class_reference_data_message': minimum_price_variant_class_reference_data_message
            'seq_msg_type::minimum_price_variant_level_reference_data_message': minimum_price_variant_level_reference_data_message
            'seq_msg_type::mpid_configuration_message': mpid_configuration_message
            'seq_msg_type::mmid_configuration_message': mmid_configuration_message
            'seq_msg_type::session_configuration_acknowledgement_message': session_configuration_acknowledgement_message
            'seq_msg_type::order_and_cancel_replace_acknowledgement_message': order_and_cancel_replace_acknowledgement_message
            'seq_msg_type::order_modify_cancel_request_acknowledgment_and_urout_message': order_modify_cancel_request_acknowledgment_and_urout_message
            'seq_msg_type::order_priority_update_acknowledgment_message': order_priority_update_acknowledgment_message
            'seq_msg_type::execution_report_message': execution_report_message
            'seq_msg_type::trade_bust_correct_message': trade_bust_correct_message
            'seq_msg_type::application_layer_reject_message': application_layer_reject_message
            'seq_msg_type::symbol_subscription_acknowledgement_message': symbol_subscription_acknowledgement_message
            'seq_msg_type::gt_begin_message': gt_begin_message
            'seq_msg_type::gt_end_message': gt_end_message
            'seq_msg_type::auction_price_data_message': auction_price_data_message
            'seq_msg_type::auction_request_message': auction_request_message
            'seq_msg_type::manual_action_request_message': manual_action_request_message
            'seq_msg_type::risk_control_acknowledgement_message': risk_control_acknowledgement_message
            'seq_msg_type::risk_control_alert_message': risk_control_alert_message
  seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Message sequence number'
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
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: cancel_on_disconnect
        type: u1
        enum: cancel_on_disconnect
        doc: 'CancelOnDisconnect enum'
      - id: throttle_preference
        type: u1
        enum: throttle_preference
        doc: 'ThrottlePreference enum'
      - id: self_trade_prevention
        type: u1
        enum: self_trade_prevention
        doc: 'SelfTradePrevention enum'
      - id: order_priority_update_ack_subscription
        type: u1
        enum: order_priority_update_ack_subscription
        doc: 'OrderPriorityUpdateAckSubscription enum'
      - id: bold_designation
        type: u1
        doc: 'NYSE American Options - Session level default for the BOLD setting on all Order and Cancel/Replace requests entered on the session. For all other markets - this field will be treated as filler. Any value specified will not be processed'
      - id: reserved_49
        size: 49
        doc: 'Bytes reserved for future use'
  new_order_single_and_cancel_replace_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: mmid
        type: u4
        doc: 'This value represents the integer representation of a Market Maker, LMM, SLP, SLMM or DMM, agreed upon between the firm and the Exchange'
      - id: mpsubid_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: bitfield_order_instructions
        type: bitfield_order_instructions
        doc: 'BitfieldOrderInstructions is a data structure defining a number of order instructions, attributes, and modifiers'
      - id: price
        type: decimal_s8_8
        doc: '0.000001-999999.999999. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999,999'
      - id: min_qty
        type: u4
        doc: '0 = no MinQty Otherwise, Must be ≥ Round Lot and ≤ OrderQty'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
      - id: optional_routing_strategy_add_on
        type: optional_routing_strategy_add_on
        doc: 'OptionalRoutingStrategyAddOn'
  bitfield_order_instructions:
    seq:
      - id: unused_12
        type: b12
        doc: 'Bits reserved for future use'
      - id: sub_id_indicator
        type: b1
        enum: sub_id_indicator
        doc: 'When populating both MPSubID and SelfTradeType on an order, allows the firm to specify whether the MPSubID should be used or ignored for Self-Trade Prevention (STP) evaluation. See “Self-Trade Prevention” section of this spec for more details'
      - id: special_ord_type
        type: b4
        enum: special_ord_type
        doc: 'SpecialOrdType'
      - id: locate_reqd
        type: b1
        enum: locate_reqd
        doc: '0 = No LocateReqd'
      - id: retail_indicator
        type: b1
        enum: retail_indicator
        doc: 'RetailIndicator'
      - id: attributed_quote
        type: b3
        enum: attributed_quote
        doc: '0 = Not Attributed'
      - id: order_capacity
        type: b3
        enum: order_capacity
        doc: 'OrderCapacity'
      - id: interest_type
        type: b3
        enum: interest_type
        doc: 'InterestType'
      - id: trading_session_id
        type: b3
        enum: trading_session_id
        doc: 'TradingSessionID'
      - id: time_in_force
        type: b3
        enum: time_in_force
        doc: 'TimeInForce'
      - id: proactive_if_locked
        type: b3
        enum: proactive_if_locked
        doc: 'ProactiveIfLocked'
      - id: self_trade_type
        type: b3
        enum: self_trade_type
        doc: 'SelfTradeType'
      - id: cancel_instead_of_reprice
        type: b4
        enum: cancel_instead_of_reprice
        doc: 'CancelInsteadOfReprice'
      - id: routing_inst
        type: b4
        enum: routing_inst
        doc: 'RoutingInst'
      - id: extended_exec_inst
        type: b4
        enum: extended_exec_inst
        doc: 'ExtendedExecInst'
      - id: exec_inst
        type: b4
        enum: exec_inst
        doc: 'ExecInst'
      - id: ord_type
        type: b4
        enum: ord_type
        doc: 'OrdType'
      - id: side_bits
        type: b4
        doc: 'Side'
  optional_order_add_on:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: stop_px
        type: decimal_s8_8
        doc: 'Trigger price for Stop and Stop Limit orders. Implied decimal with scale 1e-8'
      - id: deliver_to_comp_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'Not applicable'
      - id: max_floor
        type: u4
        doc: '0 = No MaxFloor'
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'For orders with Side of Sell Short, Sell Short Exempt, Cross Short, and Cross Short Exempt, identifies which broker has loaned the stock to settle the short sale'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: offset_price
        type: decimal_s8_8
        doc: '0 = No OffsetPrice. Otherwise, value must be: - For Market Peg order - equal to or multiple of 0.01 - For Retail Price Improvement order (optional modifier on NYSE only) - equal to or multiple of 0.001. Implied decimal with scale 1e-8'
      - id: effective_time
        type: nanosecond_timestamp
        doc: 'Reserved for future use. Nanoseconds since Unix epoch'
  sub_msg_header:
    seq:
      - id: sub_msg_type
        type: u2
        doc: 'Code identifying sub message type'
      - id: sub_msg_length
        type: u2
        doc: 'Length of sub message including this field'
  optional_routing_strategy_add_on:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: routing_strategy
        type: u1
        enum: routing_strategy
        doc: 'Routing strategy'
      - id: reserved_27
        size: 27
        doc: 'Reserved for future use'
  order_cancel_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
  order_modify_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: order_qty
        type: u4
        doc: '1 - 999,999,999'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: locate_reqd_u_81
        type: u1
        doc: '0 = No LocateReqd or not applicable. Orders with Side of Sell Short, Sell Short Exempt, Cross Short, or Cross Short Exempt must be entered with LocateReqd = 0 or will be rejected'
  bulk_cancel_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: mmid
        type: u4
        doc: 'This value represents the integer representation of a Market Maker, LMM, SLP, SLMM or DMM, agreed upon between the firm and the Exchange'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: deliver_to_comp_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'Not applicable'
      - id: bulk_cancel_type
        type: u1
        enum: bulk_cancel_type
        doc: 'Cancellation scope and behavior code'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
  symbol_subscription_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
  manual_action_response_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: manual_action_id
        type: manual_action_id
        doc: 'ManualActionID'
      - id: sell_indicator
        type: u1
        doc: 'Sets the side for DMM requested quantity: 0=Not applicable, 2=Sell, 3=Sell Short, 4=Sell Short Exempt. Applicability depends on ManualActionType and request side'
      - id: intraday_sell_short_qty
        type: u4
        doc: 'Number of shares to mark as Sell Short for applicable ManualActionTypes. Populate 0 when not applicable'
      - id: mpsubid_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: locate_reqd_u_81
        type: u1
        doc: '0 = No LocateReqd or not applicable. Orders with Side of Sell Short, Sell Short Exempt, Cross Short, or Cross Short Exempt must be entered with LocateReqd = 0 or will be rejected'
      - id: self_trade_type_bits
        type: u1
        doc: 'Self-trade prevention setting: 0=Use default/Cancel Newest, 1=No STP, 2=Cancel Newest, 3=Cancel Oldest, 4=Cancel Both, 5=Cancel Decrement'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: manual_response_type
        type: u1
        enum: manual_response_type
        doc: 'Response type: 1=Approve Manual Action Request, 2=Reject Manual Action Request'
      - id: dmm_reject_reason
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional reject reason displayed on DBK GUI when ManualResponseType=2. Printable ASCII only'
  manual_action_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Message sequence number'
  risk_limit_update_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker_nul
        type: str
        size: 10
        encoding: ASCII
        doc: 'Risk Entity. Options Market Maker identifier – alphanumeric MMID associated with the specified MPID. Populate if applicable'
      - id: mpsubid_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Risk Entity – SubID associated with the specified MPID. Populate if applicable'
      - id: reserved_4
        size: 4
        doc: 'Bytes reserved for future use'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use. Risk Entity – Clearing Number associated with the specified MPID. Populate if applicable'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message. E = Entering Firm, C = Clearing Firm, O = Options Market Maker Firm'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Risk Control Type enum'
      - id: risk_control_activation
        type: u1
        enum: risk_control_activation
        doc: 'Risk Control Activation enum'
      - id: usd_limit
        type: s8
        doc: 'US Dollar limit. Must be specified for RiskControlTypes: Single Order Max Notional Value; Gross Credit – Executed/Open/Open+Executed; Limit Order Price Protection – Custom Limits. For other RiskControlTypes set to 0'
      - id: time_limit
        type: s4
        doc: 'Microsecond time period. Must be specified for RiskControlTypes: Activity-based Rolling Transaction/Volume/Percentage; Activity-based Global Risk Mitigation Protection; Max Duplicative Orders; Order Rate Threshold – Max Orders across All Symbols. For other RiskControlTypes set to 0'
      - id: percentage_limit
        type: s4
        doc: 'Percentage (%). Must be specified for RiskControlTypes: Activity-based – Percentage; Limit Order Price Protection – Custom Limits; Single Order Maximum Quantity as Percentage of Symbol ADV. For other RiskControlTypes set to 0'
      - id: count_limit
        type: s4
        doc: 'Count'
      - id: breach_action_request
        type: u1
        enum: breach_action_request
        doc: 'Breach Action Request enum'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'IOC Attribution enum'
      - id: risk_range_id
        type: u1
        doc: 'Quantity or price range to which the risk limit is applied. 0=Not Applicable/Optional per RiskControlType, 1..10=[see below]. Range meanings depend on RiskControlType (e.g., ADV buckets for RiskControlType 22; price buckets for RiskControlType 23)'
      - id: risk_minimum_value
        type: s8
        doc: 'Minimum value for which to apply the risk control. For RiskControlType 22 may specify minimum Symbol ADV threshold; for other RiskControlTypes set to 0'
      - id: price_scale
        type: u1
        enum: price_scale
        doc: '0=no decimals; interpret as integer. 2=two decimals; interpret with two decimals (e.g., USDLimit=25 with PriceScale=2 represents $0.25). Must be specified for Limit Order Price Protection - Custom Limits and applied to USDLimit; otherwise set to 0'
      - id: reserved_190
        size: 190
        doc: 'Bytes reserved for future use'
  risk_action_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker_nul
        type: str
        size: 10
        encoding: ASCII
        doc: 'Risk Entity. Options Market Maker identifier – alphanumeric MMID associated with the specified MPID. Populate if applicable'
      - id: mpsubid_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Risk Entity – SubID associated with the specified MPID. Populate if applicable'
      - id: reserved_4
        size: 4
        doc: 'Bytes reserved for future use'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use. Risk Entity – Clearing Number associated with the specified MPID. Populate if applicable'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message. E = Entering Firm, C = Clearing Firm, O = Options Market Maker Firm'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Risk Control Type enum'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: 'Risk action to perform, including query, kill switch actions, reinstatement, and symbol-level entity management'
      - id: risk_range_id
        type: u1
        doc: 'Quantity or price range to which the risk limit is applied. 0=Not Applicable/Optional per RiskControlType, 1..10=[see below]. Range meanings depend on RiskControlType (e.g., ADV buckets for RiskControlType 22; price buckets for RiskControlType 23)'
      - id: reserved_199
        size: 199
        doc: 'Reserved for future use'
  equities_symbol_reference_data_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: nyse_symbol
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'NYSE/XDP Market Data symbology'
      - id: listed_mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code (MIC) of primary market'
      - id: round_lot_size
        type: u1
        doc: 'Round lot size'
      - id: adv_risk_range_id
        type: u1
        doc: 'ADV risk range identifier used for the Single Order Maximum Quantity as Percentage of Symbol ADV risk control'
      - id: reserved_7
        size: 7
        doc: 'Bytes reserved for future use'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number assigned to the MPV class'
      - id: test_symbol_indicator
        type: u1
        enum: test_symbol_indicator
        doc: 'Test Symbol Indicator enum'
  dmm_symbol_reference_data_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: nyse_symbol
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'NYSE/XDP Market Data symbology'
      - id: book
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book Name'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: dmm_unit_num
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'DMM Unit Identification Number'
      - id: post
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'NYSE Trading Floor Location'
      - id: median_volume
        type: u8
        doc: 'Depth Guidelines - the symbol’s median adjusted volume for Trailing Period; minimum is 1 round lot'
      - id: rd_seq
        type: u8
        doc: 'Depth Guidelines - the symbol’s Relevant Depth Sequence size for the trade date'
      - id: ridge_price
        type: decimal_s8_8
        doc: 'Depth Guidelines - the symbol’s Relevant Individual Depth Guideline for the trade date. Implied decimal with scale 1e-8'
      - id: ppp_1
        type: decimal_s8_8
        doc: 'Depth Guidelines - the symbol’s Price Participation Point 1 for the trade date. Implied decimal with scale 1e-8'
      - id: ppp_2
        type: decimal_s8_8
        doc: 'Depth Guidelines - the symbol’s Price Participation Point 2 for the trade date. Implied decimal with scale 1e-8'
      - id: ppp_3
        type: decimal_s8_8
        doc: 'Depth Guidelines - the symbol’s Price Participation Point 3 for the trade date. Implied decimal with scale 1e-8'
      - id: open_on_trade_max_qty
        type: u8
        doc: 'Maximum print quantity for electronic Opening/Re-opening Auction represented in number of shares'
      - id: close_on_trade_max_qty
        type: u8
        doc: 'Maximum print quantity for electronic Closing Auction represented in number of shares'
      - id: lmocp
        type: decimal_s8_8
        doc: 'Listing Market Official Closing Price. Implied decimal with scale 1e-8'
  minimum_price_variant_class_reference_data_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpv_class_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the Minimum Price Variant (MPV) Class'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number assigned to the MPV class'
      - id: rpimpv
        type: decimal_s8_8
        doc: 'Numeric value of the Minimum Price Variation for Retail Price Improvement (RPI) orders for securities belonging to the MPVClass. Implied decimal with scale 1e-8'
      - id: luldmpv
        type: decimal_s8_8
        doc: 'Numeric value of the Minimum Price Variation for LULD bands for securities belonging to the MPVClass. Implied decimal with scale 1e-8'
  minimum_price_variant_level_reference_data_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpv_level_definition
        type: mpv_level_definition
        repeat: eos
        doc: 'MPVLevelDefinition'
  mpv_level_definition:
    seq:
      - id: mpv_level_name
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the Minimum Price Variant (MPV) Level. Naming convention includes the MPVClassName'
      - id: price
        type: decimal_s8_8
        doc: '0.000001-999999.999999. Implied decimal with scale 1e-8'
      - id: quoting_mpv
        type: decimal_s8_8
        doc: 'Numeric value of the Quoting Minimum Price Variation for the MPVLevel and Price defined in this message. Implied decimal with scale 1e-8'
      - id: trading_mpv
        type: decimal_s8_8
        doc: 'Numeric value of the Trading Minimum Price Variation for the MPVLevel and Price defined in this message. Implied decimal with scale 1e-8'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number assigned to the MPV class'
  mpid_configuration_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: mpid_status
        type: u1
        enum: mpid_status
        doc: 'Indicates the status of the MPID'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: reserved_50
        size: 50
        doc: 'Bytes reserved for future use'
  mmid_configuration_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Character representation of the market maker'
      - id: mmid
        type: u4
        doc: 'This value represents the integer representation of a Market Maker, LMM, SLP, SLMM or DMM, agreed upon between the firm and the Exchange'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: reserved_100
        size: 100
        doc: 'Bytes reserved for future use'
  session_configuration_acknowledgement_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: user_session_type
        type: u1
        enum: user_session_type
        doc: 'Defines the permission type assigned to the gateway session'
      - id: user_session_status
        type: u1
        enum: user_session_status
        doc: 'Indicates the status of the gateway session'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code of the connected market'
      - id: cancel_on_disconnect
        type: u1
        enum: cancel_on_disconnect
        doc: 'CancelOnDisconnect enum'
      - id: throttle_preference
        type: u1
        enum: throttle_preference
        doc: 'ThrottlePreference enum'
      - id: throttle_window
        type: u2
        doc: 'Time period over which the throttle threshold is enforced'
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
        doc: 'SelfTradePrevention enum'
      - id: order_priority_update_ack_subscription
        type: u1
        enum: order_priority_update_ack_subscription
        doc: 'OrderPriorityUpdateAckSubscription enum'
      - id: ack_status
        type: u1
        enum: ack_status
        doc: 'Acknowledgement status of the session configuration'
      - id: bold_designation
        type: u1
        doc: 'NYSE American Options - Session level default for the BOLD setting on all Order and Cancel/Replace requests entered on the session. For all other markets - this field will be treated as filler. Any value specified will not be processed'
      - id: reserved_49
        size: 49
        doc: 'Bytes reserved for future use'
  order_and_cancel_replace_acknowledgement_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: mmid
        type: u4
        doc: 'This value represents the integer representation of a Market Maker, LMM, SLP, SLMM or DMM, agreed upon between the firm and the Exchange'
      - id: mpsubid_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: bitfield_order_instructions
        type: bitfield_order_instructions
        doc: 'BitfieldOrderInstructions is a data structure defining a number of order instructions, attributes, and modifiers'
      - id: price
        type: decimal_s8_8
        doc: '0.000001-999999.999999. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999,999'
      - id: min_qty
        type: u4
        doc: '0 = no MinQty Otherwise, Must be ≥ Round Lot and ≤ OrderQty'
      - id: order_id
        type: u8
        doc: 'Unique order identifier assigned by the Exchange'
      - id: leaves_qty
        type: u4
        doc: 'Remaining quantity open on the order'
      - id: working_price
        type: decimal_s8_8
        doc: 'Working price in the range 0.000001 to 999999.999999. Implied decimal with scale 1e-8'
      - id: working_away_from_display
        type: u1
        enum: working_away_from_display
        doc: 'Indicates whether the working price differs from the display price'
      - id: pre_liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicator describing the order’s potential to establish or join a displayed market'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event that produced the message'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'Acknowledgement type indicating the result or status of the order action'
      - id: bitfield_flow_indicator
        type: bitfield_flow_indicator
        doc: 'BitfieldFlowIndicator is a data structure defining whether the inbound message was throttled'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
  bitfield_flow_indicator:
    seq:
      - id: throttled
        type: b1
        enum: throttled
        doc: 'Throttled'
      - id: unused_7
        type: b7
        doc: 'Bits reserved for future use'
  order_modify_cancel_request_acknowledgment_and_urout_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique order identifier assigned by the Exchange'
      - id: ref_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of the incoming Modify, Cancel, or Bulk Cancel Request, or context-specific value for UROUTs'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: price
        type: decimal_s8_8
        doc: '0.000001-999999.999999. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999,999'
      - id: leaves_qty
        type: u4
        doc: 'Remaining quantity open on the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: locate_reqd_u_81
        type: u1
        doc: '0 = No LocateReqd or not applicable. Orders with Side of Sell Short, Sell Short Exempt, Cross Short, or Cross Short Exempt must be entered with LocateReqd = 0 or will be rejected'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event that produced the message'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'Acknowledgement type indicating the result or status of the order action'
      - id: bitfield_flow_indicator
        type: bitfield_flow_indicator
        doc: 'BitfieldFlowIndicator is a data structure defining whether the inbound message was throttled'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
  order_priority_update_acknowledgment_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique order identifier assigned by the Exchange'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: working_price
        type: decimal_s8_8
        doc: 'Working price in the range 0.000001 to 999999.999999. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999,999'
      - id: working_away_from_display
        type: u1
        enum: working_away_from_display
        doc: 'Indicates whether the working price differs from the display price'
      - id: pre_liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Indicator describing the order’s potential to establish or join a displayed market'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'Acknowledgement type indicating the result or status of the order action'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
  execution_report_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique order identifier assigned by the Exchange'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: deal_id
        type: u8
        doc: 'Unique identifier of a transaction assigned by the Exchange'
      - id: last_px
        type: decimal_s8_8
        doc: 'Price of current partial fill or fill message. Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u4
        doc: 'Remaining quantity open on the order'
      - id: cum_qty
        type: u4
        doc: 'Cumulative quantity executed for the order'
      - id: last_qty
        type: u4
        doc: 'Quantity of the current partial fill or fill'
      - id: liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Liquidity indicator for partial fills and fills'
      - id: displayed_liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Displayed liquidity indicator'
      - id: locate_reqd_u_81
        type: u1
        doc: '0 = No LocateReqd or not applicable. Orders with Side of Sell Short, Sell Short Exempt, Cross Short, or Cross Short Exempt must be entered with LocateReqd = 0 or will be rejected'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Identifies the participant type'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event that produced the message'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: optional_order_add_on
        type: optional_order_add_on
        doc: 'OptionalOrderAddOn'
      - id: optional_routing_strategy_add_on
        type: optional_routing_strategy_add_on
        doc: 'OptionalRoutingStrategyAddOn'
  trade_bust_correct_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique order identifier assigned by the Exchange'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: ref_seq_msg_id
        type: ref_seq_msg_id
        doc: 'Pillar reference sequenced message identifier'
      - id: deal_id
        type: u8
        doc: 'Unique identifier of a transaction assigned by the Exchange'
      - id: last_px
        type: decimal_s8_8
        doc: 'Price of current partial fill or fill message. Implied decimal with scale 1e-8'
      - id: last_qty
        type: u4
        doc: 'Quantity of the current partial fill or fill'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event that produced the message'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
  ref_seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Message sequence number'
  application_layer_reject_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'Matching engine reason code qualifying the event that produced the message'
      - id: reject_type
        type: u1
        enum: reject_type
        doc: 'Reject type indicating which request was rejected'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: reserved_4
        size: 4
        doc: 'Bytes reserved for future use'
  symbol_subscription_acknowledgement_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: subscription_status
        type: u1
        enum: subscription_status
        doc: 'Subscription status enum'
  gt_begin_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
  gt_end_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
  auction_price_data_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'Imbalance side enum'
      - id: side_of_unpaired_qty
        type: u1
        enum: side_of_unpaired_qty
        doc: 'SideOfUnpairedQty enum'
      - id: imbalance_volume
        type: u4
        doc: 'Unpaired better-priced shares relative to Price, excluding DMM'
      - id: price
        type: decimal_s8_8
        doc: '0.000001-999999.999999. Implied decimal with scale 1e-8'
      - id: paired_qty
        type: u4
        doc: 'Paired shares at the specified Price, excluding DMM'
      - id: unpaired_qty
        type: u4
        doc: 'Unpaired at- and better-priced shares relative to Price, excluding DMM'
      - id: buy_dmm_available_qty
        type: u4
        doc: 'All buy DMM shares priced at and higher than the specified Price'
      - id: sell_dmm_available_qty
        type: u4
        doc: 'All sell DMM shares priced at and lower than the specified Price'
  auction_request_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'AuctionType enum'
      - id: ssr_filing_price
        type: decimal_s8_8
        doc: 'Sell Short Restriction Filing Price used for the auction; set to 0 if not available. Implied decimal with scale 1e-8'
  manual_action_request_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Exchange application time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: introducing_badge_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'NYSE Floor DMM supervisor badge when ManualOverride is 1 or 2'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: mmid
        type: u4
        doc: 'This value represents the integer representation of a Market Maker, LMM, SLP, SLMM or DMM, agreed upon between the firm and the Exchange'
      - id: manual_action_id
        type: manual_action_id
        doc: 'ManualActionID'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: price
        type: decimal_s8_8
        doc: '0.000001-999999.999999. Implied decimal with scale 1e-8'
      - id: dmm_requested_qty
        type: u4
        doc: 'Requested quantity associated with the manual action'
      - id: dmm_available_qty
        type: u4
        doc: 'DMM available quantity for auction-related actions'
      - id: dmm_allocated_qty
        type: u4
        doc: 'Allocated quantity for the auction trade'
      - id: ssr_filing_price
        type: decimal_s8_8
        doc: 'Sell Short Restriction Filing Price used for the auction; set to 0 if not available. Implied decimal with scale 1e-8'
      - id: manual_override
        type: u1
        enum: manual_override
        doc: 'Indicates whether a DBK GUI manual override occurred'
      - id: manual_override_reason
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional reason provided for a manual override'
      - id: manual_action_type
        type: u1
        enum: manual_action_type
        doc: 'Type of manual action performed by the DMM'
  risk_control_acknowledgement_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker_nul
        type: str
        size: 10
        encoding: ASCII
        doc: 'Risk Entity. Options Market Maker identifier – alphanumeric MMID associated with the specified MPID. Populate if applicable'
      - id: mpsubid_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Risk Entity – SubID associated with the specified MPID. Populate if applicable'
      - id: reserved_4
        size: 4
        doc: 'Bytes reserved for future use'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use. Risk Entity – Clearing Number associated with the specified MPID. Populate if applicable'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: risk_ack_type
        type: u1
        enum: risk_ack_type
        doc: 'Indicates whether the acknowledgement is solicited or unsolicited'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message. E = Entering Firm, C = Clearing Firm, O = Options Market Maker Firm'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Risk Control Type enum'
      - id: risk_control_activation
        type: u1
        enum: risk_control_activation
        doc: 'Risk Control Activation enum'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: 'Risk action to perform, including query, kill switch actions, reinstatement, and symbol-level entity management'
      - id: usd_limit
        type: s8
        doc: 'US Dollar limit. Must be specified for RiskControlTypes: Single Order Max Notional Value; Gross Credit – Executed/Open/Open+Executed; Limit Order Price Protection – Custom Limits. For other RiskControlTypes set to 0'
      - id: time_limit
        type: s4
        doc: 'Microsecond time period. Must be specified for RiskControlTypes: Activity-based Rolling Transaction/Volume/Percentage; Activity-based Global Risk Mitigation Protection; Max Duplicative Orders; Order Rate Threshold – Max Orders across All Symbols. For other RiskControlTypes set to 0'
      - id: percentage_limit
        type: s4
        doc: 'Percentage (%). Must be specified for RiskControlTypes: Activity-based – Percentage; Limit Order Price Protection – Custom Limits; Single Order Maximum Quantity as Percentage of Symbol ADV. For other RiskControlTypes set to 0'
      - id: count_limit
        type: s4
        doc: 'Count'
      - id: breach_action_response
        type: u1
        enum: breach_action_response
        doc: 'Action taken when a risk breach occurs'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'IOC Attribution enum'
      - id: usd_calculation_1
        type: s8
        doc: 'Gross Credit calculation for open orders'
      - id: usd_calculation_2
        type: s8
        doc: 'Gross Credit calculation for auction orders'
      - id: usd_calculation_3
        type: s8
        doc: 'Gross Credit calculation for executed orders'
      - id: usd_calculation_4
        type: s8
        doc: 'Gross Credit calculation for executed auction orders'
      - id: count_calculation
        type: u4
        doc: 'Current calculated count for applicable risk controls'
      - id: blocked_by_breach_indicator
        type: u1
        enum: blocked_by_breach_indicator
        doc: 'Indicates whether the entity is blocked due to a breach'
      - id: blocked_by_kill_switch_indicator
        type: u1
        enum: blocked_by_kill_switch_indicator
        doc: 'Indicates whether the entity is blocked by a kill switch'
      - id: reinstatement_required_by_self
        type: u1
        enum: reinstatement_required_by_self
        doc: 'Indicates whether reinstatement approval is required from the receiving risk user'
      - id: reinstatement_required_by_other
        type: u1
        enum: reinstatement_required_by_other
        doc: 'Indicates whether reinstatement approval is required from other risk users'
      - id: risk_range_id
        type: u1
        doc: 'Quantity or price range to which the risk limit is applied. 0=Not Applicable/Optional per RiskControlType, 1..10=[see below]. Range meanings depend on RiskControlType (e.g., ADV buckets for RiskControlType 22; price buckets for RiskControlType 23)'
      - id: risk_minimum_value
        type: s8
        doc: 'Minimum value for which to apply the risk control. For RiskControlType 22 may specify minimum Symbol ADV threshold; for other RiskControlTypes set to 0'
      - id: price_scale
        type: u1
        enum: price_scale
        doc: '0=no decimals; interpret as integer. 2=two decimals; interpret with two decimals (e.g., USDLimit=25 with PriceScale=2 represents $0.25). Must be specified for Limit Order Price Protection - Custom Limits and applied to USDLimit; otherwise set to 0'
      - id: reserved_190
        size: 190
        doc: 'Bytes reserved for future use'
  risk_control_alert_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker_nul
        type: str
        size: 10
        encoding: ASCII
        doc: 'Risk Entity. Options Market Maker identifier – alphanumeric MMID associated with the specified MPID. Populate if applicable'
      - id: mpsubid_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Risk Entity – SubID associated with the specified MPID. Populate if applicable'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use. Risk Entity – Clearing Number associated with the specified MPID. Populate if applicable'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message. E = Entering Firm, C = Clearing Firm, O = Options Market Maker Firm'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'Risk Control Type enum'
      - id: usd_limit
        type: s8
        doc: 'US Dollar limit. Must be specified for RiskControlTypes: Single Order Max Notional Value; Gross Credit – Executed/Open/Open+Executed; Limit Order Price Protection – Custom Limits. For other RiskControlTypes set to 0'
      - id: time_limit
        type: s4
        doc: 'Microsecond time period. Must be specified for RiskControlTypes: Activity-based Rolling Transaction/Volume/Percentage; Activity-based Global Risk Mitigation Protection; Max Duplicative Orders; Order Rate Threshold – Max Orders across All Symbols. For other RiskControlTypes set to 0'
      - id: percentage_limit
        type: s4
        doc: 'Percentage (%). Must be specified for RiskControlTypes: Activity-based – Percentage; Limit Order Price Protection – Custom Limits; Single Order Maximum Quantity as Percentage of Symbol ADV. For other RiskControlTypes set to 0'
      - id: count_limit
        type: s4
        doc: 'Count'
      - id: breach_action_response
        type: u1
        enum: breach_action_response
        doc: 'Action taken when a risk breach occurs'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'IOC Attribution enum'
      - id: usd_calculation_1
        type: s8
        doc: 'Gross Credit calculation for open orders'
      - id: usd_calculation_2
        type: s8
        doc: 'Gross Credit calculation for auction orders'
      - id: usd_calculation_3
        type: s8
        doc: 'Gross Credit calculation for executed orders'
      - id: usd_calculation_4
        type: s8
        doc: 'Gross Credit calculation for executed auction orders'
      - id: count_calculation
        type: u4
        doc: 'Current calculated count for applicable risk controls'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: 'Risk action to perform, including query, kill switch actions, reinstatement, and symbol-level entity management'
      - id: threshold_breach_level
        type: u1
        enum: threshold_breach_level
        doc: 'Percentage level at which the threshold breach occurred'
      - id: blocked_by_breach_indicator
        type: u1
        enum: blocked_by_breach_indicator
        doc: 'Indicates whether the entity is blocked due to a breach'
      - id: blocked_by_kill_switch_indicator
        type: u1
        enum: blocked_by_kill_switch_indicator
        doc: 'Indicates whether the entity is blocked by a kill switch'
      - id: reinstatement_required_by_self
        type: u1
        enum: reinstatement_required_by_self
        doc: 'Indicates whether reinstatement approval is required from the receiving risk user'
      - id: reinstatement_required_by_other
        type: u1
        enum: reinstatement_required_by_other
        doc: 'Indicates whether reinstatement approval is required from other risk users'
      - id: reserved_200
        size: 200
        doc: 'Reserved for future use'
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
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
  seq_msg_type:
    0x0220:
      id: 'session_configuration_request_message'
      doc: 'This message may be sent by the firm to change their configuration settings for a given gateway session, as defined by its Username). If accepted by the gateway, the updated settings will be applied on a go forward basis only.'
    0x0282:
      id: 'sequenced_filler_message'
      doc: 'This message type is used to increase the next expected sequence number of a TG stream by 1 on a given gateway session.'
    0x0240:
      id: 'new_order_single_and_cancel_replace_request_message'
      doc: 'This message type is used as both a New Order message or a Cancel/Replacement message'
    0x0280:
      id: 'order_cancel_request_message'
      doc: 'This message is used to cancel a single targeted order. Populate the field OrigClOrdID with the ClOrdID of the order intended for cancellation.'
    0x0270:
      id: 'order_modify_request_message'
      doc: 'This message is used to reduce the total order quantity or change the side of an existing order between Sell, Sell Short, and Sell Short Exempt while preserving the order’s ranking and original OrderID. The modified order receives a new ClOrdID equal to the ClOrdID of the Modify Request. Reducing the total quantity to 0 will cancel the order.'
    0x0281:
      id: 'bulk_cancel_request_message'
      doc: 'This message is used to bulk cancel multiple orders based on the specified combination of criteria. MPID must be valid for the session. Depending on BulkCancelType, cancellation may apply at the session or MPID level. Certain order types are always excluded from bulk cancellation.'
    0x0346:
      id: 'symbol_subscription_request_message'
      doc: 'This message is sent by a NYSE Designated Market Maker to designate a gateway session to receive auction price data, auction requests, manual action requests, and echo messages of DMM manual order activity for a specified symbol.'
    0x0343:
      id: 'tg_begin_message'
      doc: 'This is used to define the beginning boundary of a multi-message originating from the firm, which is a sequence of messages that is intended to be read and processed atomically by Pillar.'
    0x0344:
      id: 'tg_end_message'
      doc: 'This is used to define the ending boundary of a multi-message, which is a set of messages originating from the firm that is intended to be read and processed atomically by Pillar.'
    0x0354:
      id: 'manual_action_response_message'
      doc: 'Response message used by a DMM to approve or reject a Manual Action Request. Depending on the ManualResponseType, this message may result in order creation or rejection with an optional reject reason.'
    0x0330:
      id: 'risk_limit_update_request_message'
      doc: 'Risk limit update request used by Risk Admin to configure or update risk controls for a specified risk entity. Field applicability depends on RiskControlType; non-applicable fields should be set to 0 or ignored as documented.'
    0x0331:
      id: 'risk_action_request_message'
      doc: 'Risk Action Request Message'
    0x0232:
      id: 'equities_symbol_reference_data_message'
      doc: 'This message is published for each security traded on the market for which a gateway session is configured to trade and provides the information needed to enter orders for those securities.'
    0x0832:
      id: 'dmm_symbol_reference_data_message'
      doc: 'DMM Symbol Reference Data'
    0x0230:
      id: 'minimum_price_variant_class_reference_data_message'
      doc: 'Defines a single Minimum Price Variant (MPV) Class by name and identification number and provides attributes belonging to that class.'
    0x0231:
      id: 'minimum_price_variant_level_reference_data_message'
      doc: 'Defines one or more Minimum Price Variant (MPV) Levels within a single MPV Class. Each embedded MPVLevelDefinition structure defines a single MPV Level.'
    0x0272:
      id: 'mpid_configuration_message'
      doc: 'This message is published for each MPID configured on a gateway session and indicates the current status of the MPID.'
    0x0273:
      id: 'mmid_configuration_message'
      doc: 'This message is published for each MMID configured on a gateway session and provides the character representation of a Market Maker and the integer MMID value assigned to it.'
    0x0221:
      id: 'session_configuration_acknowledgement_message'
      doc: 'Indicates the current configured settings for the gateway session.'
    0x0260:
      id: 'order_and_cancel_replace_acknowledgement_message'
      doc: 'Exchange acknowledgement in response to an Order or Cancel/Replace request.'
    0x0271:
      id: 'order_modify_cancel_request_acknowledgment_and_urout_message'
      doc: 'Used as a Modify Request Acknowledgement, Cancel Request Acknowledgement, UROUT, and Billable Cancel, distinguished by AckType.'
    0x0262:
      id: 'order_priority_update_acknowledgment_message'
      doc: 'Unsolicited message sent by the Exchange to notify the firm of a Reserve Order replenishment event. The displayed portion of a Reserve Order has been replenished according to MaxFloor and assigned a new OrderID.'
    0x0290:
      id: 'execution_report_message'
      doc: 'Returned on executions for Orders and indicates whether an order has been partially or entirely filled.'
    0x0292:
      id: 'trade_bust_correct_message'
      doc: 'This message is sent as a result of a report bust or correction (NYSE Texas only).'
    0x0263:
      id: 'application_layer_reject_message'
      doc: 'This message informs the firm that a New Order, Cancel, Cancel/Replace, or Modify request has been rejected. For NYSE DMM sessions it is also used to reject TG Action and Manual Action Response.'
    0x0347:
      id: 'symbol_subscription_acknowledgement_message'
      doc: 'Response to a Symbol Subscription Request indicating whether the DMM session is subscribed to the symbol.'
    0x0349:
      id: 'gt_begin_message'
      doc: 'Defines the beginning boundary of a multi-message sequence originating from Pillar that must be processed atomically by the firm.'
    0x0350:
      id: 'gt_end_message'
      doc: 'Defines the ending boundary of a multi-message sequence originating from Pillar that must be processed atomically by the firm.'
    0x0352:
      id: 'auction_price_data_message'
      doc: 'Provides opening, re-opening, and closing auction imbalance and DMM interest information at each eligible auction price point. Sent as part of a multi-message between GT Begin and GT End.'
    0x0348:
      id: 'auction_request_message'
      doc: 'Request from Pillar to open, re-open, or close a symbol with an auction trade.'
    0x0353:
      id: 'manual_action_request_message'
      doc: 'Manual action details initiated by a DMM on the NYSE Trading Floor via DBK GUI.'
    0x0332:
      id: 'risk_control_acknowledgement_message'
      doc: 'Provides current configurations and calculations of a Risk Entity for Pillar Risk Controls.'
    0x0333:
      id: 'risk_control_alert_message'
      doc: 'Provides notification of threshold or breach events, reinstatement events, and kill switch actions for firms using Pillar Risk Controls.'
  cancel_on_disconnect:
    0:
      id: 'disabled'
      doc: 'Cancel On Disconnect Disabled'
    1:
      id: 'enable_day'
      doc: 'Enable Cancel On Disconnect Day'
    2:
      id: 'enable_all'
      doc: 'Enable Cancel On Disconnect All'
  throttle_preference:
    0:
      id: 'queue_orders'
      doc: 'Queue Orders When Throttled'
    1:
      id: 'reject_orders'
      doc: 'Reject Orders When Throttled'
  self_trade_prevention:
    1:
      id: 'no_self_trade_prevention'
      doc: 'No Self Trade Prevention'
    2:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    4:
      id: 'cancel_both'
      doc: 'Cancel Both'
    5:
      id: 'cancel_decrement'
      doc: 'Cancel Decrement'
  order_priority_update_ack_subscription:
    0:
      id: 'not_subscribed'
      doc: 'Not Subscribed To Receive The Unsolicited Order Priority Update Ack Message On The Session'
    1:
      id: 'receive_unsolicited_ack'
      doc: 'Receive Unsolicited Order Priority Update Ack Message On The Session'
  sub_id_indicator:
    0:
      id: 'use_mp_sub_id'
      doc: 'Use Mp Sub Id For Stp Evaluation'
    1:
      id: 'ignore_on_behalf_of_sub_id'
      doc: 'Ignore The On Behalf Of Sub Id For Stp'
  special_ord_type:
    0:
      id: 'no_special_ord_type'
      doc: 'No Special Ord Type'
    1:
      id: 'dmm_auction_aoc'
      doc: 'Dmm Open Reopen Close With Or Without Auction Aoc'
    2:
      id: 'dmm_preauction'
      doc: 'Dmm Preauction'
    3:
      id: 'dmm_afterauction'
      doc: 'Dmm Afterauction'
    4:
      id: 'qct'
      doc: 'Qct'
    8:
      id: 'reserved'
      doc: 'Reserved For Future Use'
  locate_reqd:
    0:
      id: 'no_locate_reqd'
      doc: 'No Locate Reqd'
    1:
      id: 'locate_reqd_for_ssh_orders'
      doc: 'Locate Reqd For Ssh Orders'
  retail_indicator:
    0:
      id: 'not_retail'
      doc: 'Not Retail'
    1:
      id: 'retail_order'
      doc: 'Retail Order'
  attributed_quote:
    0:
      id: 'not_attributed'
      doc: 'Not Attributed'
    1:
      id: 'market_data_feeds'
      doc: 'Attributed For Market Data Feeds'
    2:
      id: 'broker_volume'
      doc: 'Include In Broker Volume'
    3:
      id: 'market_data_feeds_and_broker_volume'
      doc: 'Attributed For Market Data Feeds And Include In Broker Volume'
  order_capacity:
    1:
      id: 'agency'
      doc: 'Agency'
    2:
      id: 'principal'
      doc: 'Principal'
    3:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
    4:
      id: 'error_account'
      doc: 'Error Account Nyse Floor Broker Only'
  interest_type:
    0:
      id: 'no_interest_type'
      doc: 'No Interest Type'
    5:
      id: 'cco'
      doc: 'Capital Commitment Order Cco'
    6:
      id: 'cco_partial_fill_contraside'
      doc: 'Capital Commitment Order Cco Partial Fill Contraside'
  trading_session_id:
    1:
      id: 'early_trading_session'
      doc: 'Early Trading Session'
    2:
      id: 'core_trading_session'
      doc: 'Core Trading Session'
    3:
      id: 'late_trading_session'
      doc: 'Late Trading Session'
    4:
      id: 'early_and_core_trading_sessions'
      doc: 'Early And Core Trading Sessions'
    5:
      id: 'core_and_late_trading_sessions'
      doc: 'Core And Late Trading Sessions'
    6:
      id: 'early_core_and_late_trading_sessions'
      doc: 'Early Core And Late Trading Sessions'
  time_in_force:
    1:
      id: 'day'
      doc: 'Day'
    2:
      id: 'ioc'
      doc: 'Ioc'
    3:
      id: 'at_the_opening'
      doc: 'At The Opening'
    4:
      id: 'on_close'
      doc: 'On Close'
  proactive_if_locked:
    0:
      id: 'no_proactive_if_locked'
      doc: 'No Proactive If Locked'
    1:
      id: 'proactive_route'
      doc: 'Proactive Route'
    2:
      id: 'proactive_trade_non_display'
      doc: 'Proactive Trade Non Display'
  self_trade_type:
    0:
      id: 'default_cancel_newest'
      doc: 'Use Default For All Dbk Gui Streams Cancel Newest'
    1:
      id: 'no_self_trade_prevention'
      doc: 'No Self Trade Prevention'
    2:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    4:
      id: 'cancel_both'
      doc: 'Cancel Both'
    5:
      id: 'cancel_decrement'
      doc: 'Cancel Decrement'
  cancel_instead_of_reprice:
    0:
      id: 'not_applicable'
      doc: 'Follow Default Order Behavior'
    1:
      id: 'cancel_instead_of_repricing_luld_only'
      doc: 'Cancel Order Instead Of Repricing For Luld Only'
    3:
      id: 'cancel_instead_of_repricing_any_reason'
      doc: 'Cancel Order Instead Of Repricing For Any Reason'
  routing_inst:
    0:
      id: 'none'
      doc: 'No Routing Instruction'
    1:
      id: 'non_routable'
      doc: 'Order Is Not Routable'
    2:
      id: 'routable'
      doc: 'Order May Be Routed'
    3:
      id: 'directed_primary'
      doc: 'Directed To Primary Market Only'
    4:
      id: 'directed_routable'
      doc: 'Directed To Primary Market With Routing Allowed Pos'
    5:
      id: 'primary_until_0945'
      doc: 'Route To Primary Market Until 945'
    6:
      id: 'primary_after_1555'
      doc: 'Route To Primary Market After 355'
    7:
      id: 'primary_time_windows'
      doc: 'Route To Primary Market Until 945 And After 355'
    8:
      id: 'minimum_fill'
      doc: 'Minimum Fill Routing Requires Min Qty Field Populated With A Nonzero Value'
    10:
      id: 'route_to_ats'
      doc: 'Route Order To Ats'
  extended_exec_inst:
    0:
      id: 'none'
      doc: 'No Extended Execution Instructions'
    1:
      id: 'alo'
      doc: 'Add Liquidity Only Order Will Not Remove Liquidity'
    3:
      id: 'no_ioi_route'
      doc: 'Order Will Not Route To Ioi Destinations'
    5:
      id: 'retail_type_1'
      doc: 'Retail Order Type 1'
    6:
      id: 'retail_type_2'
      doc: 'Retail Order Type 2'
    7:
      id: 'retail_provider'
      doc: 'Retail Liquidity Provider Designation'
    8:
      id: 'imbalance_offset'
      doc: 'Order Participates As An Imbalance Offset'
    9:
      id: 'discretionary_peg'
      doc: 'Order Uses Discretionary Peg Pricing Logic'
    10:
      id: 'dark_primary_peg'
      doc: 'Nondisplayed Order Pegged To The Primary Market'
    14:
      id: 'ido'
      doc: 'Issuer Direct Offering Order'
  exec_inst:
    0:
      id: 'none'
      doc: 'No Execution Instruction'
    1:
      id: 'reserved_1'
      doc: 'Reserved For Future Use'
    2:
      id: 'reserved_2'
      doc: 'Reserved For Future Use'
    3:
      id: 'tracking'
      doc: 'Tracking Order'
    4:
      id: 'iso'
      doc: 'Intermarket Sweep Order'
    5:
      id: 'primary_peg'
      doc: 'Order Pegged To The Primary Market Price'
    6:
      id: 'market_peg'
      doc: 'Order Pegged To The Market Price'
    7:
      id: 'midpoint'
      doc: 'Midpoint Liquidity Order'
    8:
      id: 'non_displayed'
      doc: 'Nondisplayed Order Including Retail Price Improvement And Limit Non Displayed Orders'
    9:
      id: 'trade_at_iso'
      doc: 'Tradeat Intermarket Sweep Order'
    10:
      id: 'last_sale_peg'
      doc: 'Order Pegged To The Last Sale Price'
  ord_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'inside_limit'
      doc: 'Inside Limit'
    4:
      id: 'pegged'
      doc: 'Pegged'
  routing_strategy:
    1:
      id: 'midpoint_ping'
      doc: 'Midpoint Ping'
    2:
      id: 'retail_price_improvement_seeking'
      doc: 'Retail Price Improvement Seeking'
    3:
      id: 'retail_midpoint_ping'
      doc: 'Retail Midpoint Ping'
  side:
    0:
      id: 'no_change_in_side'
      doc: 'No Change In Side'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'sell_short'
      doc: 'Sell Short'
    4:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
    5:
      id: 'cross'
      doc: 'Cross'
    6:
      id: 'cross_short'
      doc: 'Cross Short'
    7:
      id: 'cross_short_exempt'
      doc: 'Cross Short Exempt'
  bulk_cancel_type:
    1:
      id: 'session_day_directed'
      doc: 'Cancel Orders For The Individual Gateway Session Only Cancel Day Directed Orders'
    2:
      id: 'session_all_orders'
      doc: 'Cancel Orders For The Individual Gateway Session Only Cancel All Orders'
    3:
      id: 'session_opening_day_directed'
      doc: 'Cancel Orders For The Individual Gateway Session Only Cancel At The Opening Day Directed Orders'
    4:
      id: 'mpid_opening_day_directed'
      doc: 'Cancel Orders For The Mpid Cancel At The Opening Day Directed Orders'
    5:
      id: 'mpid_day_directed'
      doc: 'Cancel Orders For The Mpid Cancel Day Directed Orders'
    6:
      id: 'mpid_gtc'
      doc: 'Cancel Orders For The Mpid Cancel Gtc Orders Nyse Arca American Options Only'
    7:
      id: 'mpid_opening_close'
      doc: 'Cancel Orders For The Mpid Cancel At The Opening And On Close Orders'
    8:
      id: 'mpid_day_orders'
      doc: 'Cancel Orders For The Mpid Cancel Day Orders'
    9:
      id: 'mpid_cancel_block_new'
      doc: 'Cancel Orders For The Mpid And Block All New'
    10:
      id: 'mpid_block_new'
      doc: 'Block All New Order Entry For The Mpid'
    11:
      id: 'mpid_unblock_new'
      doc: 'Unblock New Order Entry For The Mpid'
    12:
      id: 'mpid_directed_orders'
      doc: 'Cancel Orders For The Mpid Cancel Directed Orders'
    13:
      id: 'mpid_capital_commitment'
      doc: 'Cancel Orders For The Mpid Cancel Capital Commitment Orders'
  manual_response_type:
    1:
      id: 'approve_manual_action_request'
      doc: 'Approve Manual Action Request'
    2:
      id: 'reject_manual_action_request'
      doc: 'Reject Manual Action Request'
  risk_user_type:
    0x45:
      id: 'entering_firm'
      doc: 'Entering Firm'
    0x43:
      id: 'clearing_firm'
      doc: 'Clearing Firm'
  risk_control_type:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'single_order_max_qty'
      doc: 'Single Order Max Qty'
    2:
      id: 'single_order_max_notional_value'
      doc: 'Single Order Max Notional Value'
    3:
      id: 'gross_credit_executed'
      doc: 'Gross Credit Executed'
    4:
      id: 'gross_credit_open'
      doc: 'Gross Credit Open'
    5:
      id: 'gross_credit_open_plus_executed'
      doc: 'Gross Credit Open Executed'
    6:
      id: 'maximum_duplicative_orders'
      doc: 'Maximum Duplicative Orders'
    7:
      id: 'reserved'
      doc: 'Reserved For Future Use'
    8:
      id: 'activity_rolling_transaction'
      doc: 'Activitybased Rolling Transaction'
    9:
      id: 'activity_rolling_volume'
      doc: 'Activitybased Rolling Volume'
    10:
      id: 'activity_rolling_percentage'
      doc: 'Activitybased Rolling Percentage'
    11:
      id: 'activity_global_risk_mitigation'
      doc: 'Activitybased Global Risk Mitigation Protection For Transaction Volume Percentage'
    12:
      id: 'reserved_2'
      doc: 'Reserved For Future Use'
    13:
      id: 'reject_market_orders'
      doc: 'Reject Market Orders Except Moo Moc'
    14:
      id: 'reject_moo_and_moc'
      doc: 'Reject Moo Moc'
    15:
      id: 'not_available_15'
      doc: 'Not Available'
    16:
      id: 'not_available_16'
      doc: 'Not Available'
    17:
      id: 'reject_early_trading_session'
      doc: 'Reject Early Trading Session Designation'
    18:
      id: 'reject_late_trading_session'
      doc: 'Reject Late Trading Session Designation'
    19:
      id: 'reject_restricted_symbol'
      doc: 'Reject Restricted Symbol'
    20:
      id: 'reject_sell_short_for_symbol'
      doc: 'Reject Sell Short For Symbol'
    21:
      id: 'reject_sell_short_exempt_for_symbol'
      doc: 'Reject Sell Short Exempt For Symbol'
    22:
      id: 'single_order_max_qty_pct_adv'
      doc: 'Single Order Maximum Quantity As Percentage Of Symbol Adv'
    23:
      id: 'lopp_equities_custom_limits'
      doc: 'Limit Order Price Protection Equities Custom Limits'
    24:
      id: 'lopp_equities_early_late_multiplier'
      doc: 'Limit Order Price Protection Equities Early Late Trading Multiplier'
    25:
      id: 'lopp_equities_closing_only_multiplier'
      doc: 'Limit Order Price Protection Equities Closing Only Multiplier'
    26:
      id: 'lopp_options_single_leg_custom_limits'
      doc: 'Limit Order Price Protection Options Single Leg Custom Limits'
    27:
      id: 'lopp_options_complex_custom_limits'
      doc: 'Limit Order Price Protection Options Complex Custom Limits'
    28:
      id: 'require_locate_broker'
      doc: 'Require Locate Broker On Sell Short And Sell Short Exempt Orders'
    29:
      id: 'order_rate_threshold'
      doc: 'Order Rate Threshold Max Orders Across All Symbols'
    30:
      id: 'reject_isoioc'
      doc: 'Reject Iso Ioc'
    31:
      id: 'reject_iso_day'
      doc: 'Reject Iso Day'
  risk_control_activation:
    0:
      id: 'risk_control_turned_off'
      doc: 'Risk Control Turned Off'
    1:
      id: 'risk_control_turned_on'
      doc: 'Risk Control Turned On'
  breach_action_request:
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
      id: 'block_only'
      doc: 'Block Only'
  ioc_attribution:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'include_ioc_orders'
      doc: 'Include Ioc Orders In Activitybased Calculations'
    2:
      id: 'exclude_ioc_orders'
      doc: 'Exclude Ioc Orders From Activitybased Calculations'
  price_scale:
    0:
      id: 'no_decimals'
      doc: 'No Decimals'
    2:
      id: 'two_decimals'
      doc: 'Two Decimals'
  risk_action_type:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'query_risk_entity'
      doc: 'Query Risk Entity For Current Risk Control Configurations Calculations And Status'
    2:
      id: 'kill_switch_block'
      doc: 'Kill Switch Block'
    3:
      id: 'kill_switch_unblock'
      doc: 'Kill Switch Unblock'
    4:
      id: 'kill_switch_cancel_auction_orders'
      doc: 'Kill Switch Cancel Auction Orders'
    5:
      id: 'kill_switch_cancel_non_auction_orders'
      doc: 'Kill Switch Cancel Nonauction Orders'
    6:
      id: 'kill_switch_cancel_gtc_orders'
      doc: 'Kill Switch Cancel Gtc Orders'
    7:
      id: 'approve_reinstatement'
      doc: 'Approve Reinstatement'
    8:
      id: 'risk_entity_reinstated'
      doc: 'Risk Entity Reinstated After All Required Approvals Are Received And Processed'
    9:
      id: 'add_symbol_level_risk_entity'
      doc: 'Add Symbollevel Risk Entity'
    10:
      id: 'remove_symbol_level_risk_entity'
      doc: 'Remove Symbollevel Risk Entity'
  test_symbol_indicator:
    0:
      id: 'production_symbol'
      doc: 'Production Symbol'
    1:
      id: 'test_symbol'
      doc: 'Test Symbol'
  mpid_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'inactive'
      doc: 'Inactive'
    3:
      id: 'prospect'
      doc: 'Prospect'
  user_session_type:
    1:
      id: 'customer'
      doc: 'Customer All Asset Classes Andor Equities Market Maker'
    2:
      id: 'service_bureau'
      doc: 'Service Bureau'
    3:
      id: 'designated_market_maker'
      doc: 'Designated Market Maker Dmm'
    4:
      id: 'options_market_maker'
      doc: 'Options Market Maker'
    12:
      id: 'risk_admin'
      doc: 'Risk Admin'
  user_session_status:
    1:
      id: 'active'
      doc: 'Permission To Open Streams For Reading And Writing'
    2:
      id: 'inactive'
      doc: 'Permission To Open Readonly Streams'
    3:
      id: 'prospect'
      doc: 'Permission To Open Readonly Streams'
  symbol_eligibility:
    1:
      id: 'all_symbols'
      doc: 'All Symbols Production And Test Symbols'
    2:
      id: 'test_symbols_only'
      doc: 'Test Symbols Only'
  ack_status:
    0:
      id: 'unsolicited'
      doc: 'Unsolicited Start Of Day'
    1:
      id: 'user_request_valid'
      doc: 'User Request Valid'
    2:
      id: 'user_request_invalid'
      doc: 'User Request Invalid Rejected'
  working_away_from_display:
    0:
      id: 'same_as_display'
      doc: 'Working Price Is Equal To Display Price'
    1:
      id: 'different_from_display'
      doc: 'Working Price Is Different From Display Price'
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
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
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
      id: 'invalid_leg_symbol_232'
      doc: 'Invalid Leg Symbol'
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
      doc: 'Reserved For Future Use'
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
      doc: 'Reserved For Future Use'
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
      id: 'order_priority_update_new_id'
      doc: 'Order Priority Update With A New Order Id'
    3:
      id: 'order_priority_update_same_id'
      doc: 'Order Priority Update With The Same Order Id'
    4:
      id: 'bulk_cancel_ack'
      doc: 'Acknowledgement Of A Bulk Cancel Request'
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
      doc: 'Order Has Been Replaced'
    9:
      id: 'modified'
      doc: 'Order Has Been Modified'
    10:
      id: 'eligible_for_cross'
      doc: 'Order Is Eligible For Cross'
    11:
      id: 'canceled'
      doc: 'Order Has Been Canceled'
    12:
      id: 'done_for_day'
      doc: 'Order Is Done For The Trading Day'
    13:
      id: 'billable_cancel_add_liquidity'
      doc: 'Billable Cancel While Adding Liquidity'
    14:
      id: 'billable_cancel_remove_liquidity'
      doc: 'Billable Cancel While Removing Liquidity'
    15:
      id: 'billable_cancel_sub_dollar_add'
      doc: 'Billable Cancel Adding Subdollar Liquidity'
    16:
      id: 'billable_cancel_sub_dollar_remove'
      doc: 'Billable Cancel Removing Subdollar Liquidity'
  throttled:
    0:
      id: 'not_throttled'
      doc: 'Inbound Message Was Not Throttled'
    1:
      id: 'throttled'
      doc: 'Inbound Message Was Throttled'
  participant_type:
    1:
      id: 'customer'
      doc: 'Customer'
    2:
      id: 'market_maker'
      doc: 'Market Maker Lmm'
    3:
      id: 'dmm'
      doc: 'Designated Market Maker'
    4:
      id: 'slp'
      doc: 'Supplemental Liquidity Provider'
    5:
      id: 'floor_broker'
      doc: 'Nyse Floor Broker Nyse Texas Ib'
  reject_type:
    1:
      id: 'order_cancel_replace'
      doc: 'Order Cancel Replace Reject'
    2:
      id: 'modify_request'
      doc: 'Modify Request Reject'
    3:
      id: 'cancel_request'
      doc: 'Cancel Request Reject'
    4:
      id: 'bulk_cancel_request'
      doc: 'Bulk Cancel Request Reject'
    5:
      id: 'reserved'
      doc: 'Reserved For Future Use'
    6:
      id: 'manual_action_response'
      doc: 'Manual Action Response Reject'
    7:
      id: 'risk_limit_update_request'
      doc: 'Risk Limit Update Request Reject'
    8:
      id: 'not_applicable_equities'
      doc: 'Not Applicable For Equities Markets'
    9:
      id: 'reserved_future'
      doc: 'Reserved For Future Use'
    10:
      id: 'not_applicable_equities_alt'
      doc: 'Not Applicable For Equities Markets'
    11:
      id: 'risk_action_request'
      doc: 'Risk Action Request Reject'
  subscription_status:
    1:
      id: 'subscribed'
      doc: 'Subscribed'
    2:
      id: 'not_subscribed'
      doc: 'Not Subscribed Rejected'
  imbalance_side:
    0:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    1:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    2:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
  side_of_unpaired_qty:
    0:
      id: 'paired'
      doc: 'Paired'
    1:
      id: 'buy_not_paired'
      doc: 'Buy Side Not Paired'
    2:
      id: 'sell_not_paired'
      doc: 'Sell Side Not Paired'
  auction_type:
    0:
      id: 'opening_auction'
      doc: 'Opening Auction'
    1:
      id: 'reopening_auction'
      doc: 'Reopening Auction'
    2:
      id: 'closing_auction'
      doc: 'Closing Auction'
  manual_override:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'alert'
      doc: 'Alert For Dbk Gui Manual Override'
    2:
      id: 'position_marking'
      doc: 'Position Marking For Dmm Manual Override'
  manual_action_type:
    1:
      id: 'new_manual_dmm_order'
      doc: 'New Manual Dmm Order Entered Via Dmm Interest Template'
    2:
      id: 'reduce_manual_dmm_qty'
      doc: 'Aggregate Reduction In Manual Dmm Orders Quantity Via Dmm Interest Template'
    3:
      id: 'opening_auction'
      doc: 'Opening Auction Via Opening Template'
    4:
      id: 'reopening_auction'
      doc: 'Reopening Auction Via Opening Template'
    5:
      id: 'closing_auction'
      doc: 'Closing Auction Via Closing Template'
    6:
      id: 'manual_cross'
      doc: 'Manual Cross Dmm Against Nyse Floor Broker Via G Key Template'
    7:
      id: 'cancel_all_manual_orders'
      doc: 'Cancel All Manual Dmm Orders Per Side Via Dmm Interest Template'
  risk_ack_type:
    0:
      id: 'solicited'
      doc: 'Solicited Acknowledgement'
    1:
      id: 'unsolicited'
      doc: 'Unsolicited Acknowledgement'
  breach_action_response:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'notify_only'
      doc: 'Notifications Only'
    2:
      id: 'cancel_and_block'
      doc: 'Cancel Non Auction Orders And Block'
    3:
      id: 'block'
      doc: 'Block'
  blocked_by_breach_indicator:
    0:
      id: 'not_blocked'
      doc: 'Not Blocked By Breach'
    1:
      id: 'blocked_by_breach'
      doc: 'Blocked By Breach'
    2:
      id: 'blocked_by_arb_check'
      doc: 'Blocked By Arbitrage Check Options Market Maker Only'
    3:
      id: 'blocked_by_intrinsic'
      doc: 'Blocked By Intrinsic Value Check Options Market Maker Only'
  blocked_by_kill_switch_indicator:
    0:
      id: 'not_blocked'
      doc: 'Not Blocked By Kill Switch'
    1:
      id: 'blocked'
      doc: 'Blocked By Kill Switch'
  reinstatement_required_by_self:
    0:
      id: 'not_required'
      doc: 'Reinstatement Approval From Self Is Not Required'
    1:
      id: 'required'
      doc: 'Reinstatement Approval From Self Is Required'
  reinstatement_required_by_other:
    0:
      id: 'not_required'
      doc: 'Reinstatement Approval From Other Risk Users Is Not Required'
    1:
      id: 'required'
      doc: 'Reinstatement Approval From Other Risk Users Is Required'
  threshold_breach_level:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'greater_than_50_percent'
      doc: 'Greater Than 50 Percent'
    2:
      id: 'greater_than_75_percent'
      doc: 'Greater Than 75 Percent'
    3:
      id: 'greater_than_90_percent'
      doc: 'Greater Than 90 Percent'
    4:
      id: 'greater_than_100_percent'
      doc: 'Greater Than 100 Percent'

