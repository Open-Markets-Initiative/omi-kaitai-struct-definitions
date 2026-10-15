# ---------------------------------------------------------------------
# Kaitai struct definition for: 24X Memo Sbe v2.0
#
# Protocol:
#   Organization: 24 National Exchange
#   Protocol: Members Orders
#   Encoding: Simple Binary Encoding
#   Version: 2.0
#   Date: 9/25/2026
#   Specification: MEMO SBE-v2.0.pdf
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
  id: n24x_24xequities_memo_sbe_v2_0_server
  title: 24X Memo Sbe v2.0
  license: GPL-3.0
  endian: be

doc: '24 National Exchange 24X Equities Members Orders Sbe v2.0'
doc-ref: https://equities.24exchange.com/technical-resources

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Tcp Common Header'
  - id: server_data
    size: common_header.message_length
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::login_accepted': login_accepted_message
        'message_type::login_rejected': login_rejected_message
        'message_type::start_of_session': start_of_session_message
        'message_type::replay_begin': replay_begin_message
        'message_type::replay_rejected': replay_rejected_message
        'message_type::replay_complete': replay_complete_message
        'message_type::stream_begin': stream_begin_message
        'message_type::stream_rejected': stream_rejected_message
        'message_type::stream_complete': stream_complete_message
        'message_type::sequenced_message': sequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: message_length
        type: u2
        doc: 'Total bytes following the header (does not include this header)'
  login_accepted_message:
    seq:
      - id: supported_request_mode
        type: u1
        enum: supported_request_mode
        doc: 'The request mode that this connection supports'
  login_rejected_message:
    seq:
      - id: login_reject_code
        type: u1
        enum: login_reject_code
        doc: 'The code for the rejection type'
  start_of_session_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
  replay_begin_message:
    seq:
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
      - id: pending_message_count
        type: u4
        doc: 'The number of messages to be delivered in this replay'
  replay_rejected_message:
    seq:
      - id: replay_reject_code
        type: u1
        enum: replay_reject_code
        doc: 'The code for the rejection type'
  replay_complete_message:
    seq:
      - id: message_count
        type: u8
        doc: 'The number of messages which were sent in the replay'
  stream_begin_message:
    seq:
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
      - id: max_sequence_number
        type: u8
        doc: 'The maximum sequence number currently published on this stream'
  stream_rejected_message:
    seq:
      - id: stream_reject_code
        type: u1
        enum: stream_reject_code
        doc: 'The code for the rejection type'
  stream_complete_message:
    seq:
      - id: total_sequence_count
        type: u8
        doc: 'The count of messages that were sent on this stream'
  sequenced_message:
    seq:
      - id: server_sbe_message
        type: server_sbe_message
        doc: 'Sbe message sent by 24X to the firm'
  server_sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: server_payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::execution_report_new_message': execution_report_new_message
            'template_id::execution_report_rejected_message': execution_report_rejected_message
            'template_id::execution_report_trade_message': execution_report_trade_message
            'template_id::execution_report_pending_cancel_message': execution_report_pending_cancel_message
            'template_id::pending_mass_cancel_message': pending_mass_cancel_message
            'template_id::execution_report_canceled_message': execution_report_canceled_message
            'template_id::mass_cancel_done_message': mass_cancel_done_message
            'template_id::execution_report_pending_replace_message': execution_report_pending_replace_message
            'template_id::execution_report_replaced_message': execution_report_replaced_message
            'template_id::execution_report_trade_correction_message': execution_report_trade_correction_message
            'template_id::execution_report_trade_break_message': execution_report_trade_break_message
            'template_id::execution_report_restatement_message': execution_report_restatement_message
            'template_id::order_cancel_reject_message': order_cancel_reject_message
            'template_id::mass_cancel_reject_message': mass_cancel_reject_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Memx Udp Message Type'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'T8 Identifier of the message template'
      - id: schema_id
        type: u1
        doc: 'The identifier of a message schema'
      - id: version
        type: u2
        doc: 'The version number of the message schema that was used to encode a message'
      - id: num_groups
        type: u1
        doc: 'A count of repeating groups at the root level of the message'
  execution_report_new_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'SymbolSfx. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'OrdType'
      - id: order_qty
        type: u4
        doc: 'OrderQty'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'TimeInForce'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'OrderCapacity'
      - id: cust_order_capacity
        type: u1
        enum: cust_order_capacity
        doc: 'CustOrderCapacity'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: extended_exec_inst
        type: extended_exec_inst
        doc: 'ExtendedExecInstType bit set'
      - id: peg_offset_value
        type: decimal_s8_6_nullable
        doc: 'PegOffsetValue. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: peg_price_type
        type: u1_nullable
        doc: 'PegPriceType. Nullable, No Value = 255'
      - id: expire_time
        type: u8_nullable
        doc: 'ExpireTime. Nullable, No Value = 18446744073709551615'
      - id: min_qty
        type: u4_nullable
        doc: 'MinQty. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'DisplayQty. Nullable, No Value = 4294967295'
      - id: display_method
        type: u1
        enum: display_method
        doc: 'DisplayMethod. Nullable, No Value = 0'
      - id: reserve_replenish_timing
        type: u1_nullable
        doc: 'ReserveReplenishTiming. Nullable, No Value = 255'
      - id: display_min_incr
        type: u4_nullable
        doc: 'DisplayMinIncr. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'LocateReqd. Nullable, No Value = 0'
      - id: reprice_frequency
        type: u1_nullable
        doc: 'RepriceFrequency. Nullable, No Value = 255'
      - id: reprice_behavior
        type: u1_nullable
        doc: 'RepriceBehavior. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupID. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'StpGroupID. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'SelfTradePrevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'LocateBroker. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  exec_inst:
    seq:
      - id: reserved_13
        type: b13
        doc: '13 reserved bits'
      - id: external_routing_not_allowed
        type: b1
        doc: 'ExternalRoutingNotAllowed'
      - id: intermarket_sweep
        type: b1
        doc: 'IntermarketSweep'
      - id: participate_do_not_initiate
        type: b1
        doc: 'ParticipateDoNotInitiate'
  extended_exec_inst:
    seq:
      - id: reserved_14
        type: b14
        doc: '14 reserved bits'
      - id: non_attested_retail
        type: b1
        doc: 'NonAttestedRetail'
      - id: late_auction
        type: b1
        doc: 'LateAuction'
  parties_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'RepeatingGroupDimensions'
      - id: parties_group
        type: parties_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'Parties'
  repeating_group_dimensions:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  parties_group:
    seq:
      - id: party_id_new_order_single_party_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'PartyID'
      - id: party_id_source
        type: str
        size: 1
        encoding: ASCII
        doc: 'PartyIDSource'
      - id: party_role
        type: u1
        enum: party_role
        doc: 'PartyRole'
  execution_report_rejected_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'SymbolSfx. Nullable, No Value = 0'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'RejectReason'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  execution_report_trade_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: last_qty
        type: u4
        doc: 'LastQty'
      - id: last_px
        type: decimal_s8_6
        doc: 'LastPx. Implied decimal with scale 1e-6'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: last_liquidity_ind
        type: u1
        enum: last_liquidity_ind
        doc: 'LastLiquidityInd'
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        doc: 'LastMkt'
      - id: trd_matching_id
        type: u8
        doc: 'TrdMatchingID'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: security_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'SecurityGroup'
      - id: execution_details
        type: execution_details
        doc: 'ExecutionDetailsType bit set'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'AuctionType. Nullable, No Value = 0'
      - id: auction_id
        type: u8
        doc: 'AuctionId'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  execution_details:
    seq:
      - id: reserved_4
        type: b4
        doc: '4 reserved bits'
      - id: traded_against_hidden
        type: b1
        doc: 'TradedAgainstHidden'
      - id: traded_against_retail
        type: b1
        doc: 'TradedAgainstRetail'
      - id: price_improvement
        type: b1
        doc: 'PriceImprovement'
      - id: traded_at_midpoint
        type: b1
        doc: 'TradedAtMidpoint'
      - id: retail_order
        type: b1
        doc: 'RetailOrder'
      - id: immediate_order
        type: b1
        doc: 'ImmediateOrder'
      - id: midpoint_order
        type: b1
        doc: 'MidpointOrder'
      - id: displayed_quantity
        type: b1
        doc: 'DisplayedQuantity'
      - id: hidden_quantity
        type: b1
        doc: 'HiddenQuantity'
      - id: nbbo_setter
        type: b1
        doc: 'NBBOSetter'
      - id: nbbo_joiner
        type: b1
        doc: 'NBBOJoiner'
      - id: on_entry
        type: b1
        doc: 'OnEntry'
  execution_report_pending_cancel_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'OrigClOrdID. Nullable, No Value = 0'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'SymbolSfx. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  pending_mass_cancel_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'SymbolSfx. Nullable, No Value = 0'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'Side. Nullable, No Value = 0'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'LowerThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'HigherThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupID. Nullable, No Value = 65535'
  execution_report_canceled_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'OrigClOrdID. Nullable, No Value = 0'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: cancel_reason
        type: u1_nullable
        doc: 'CancelReason. Nullable, No Value = 255'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  mass_cancel_done_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
  execution_report_pending_replace_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'OrigClOrdID. Nullable, No Value = 0'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'SymbolSfx. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_qty
        type: u4
        doc: 'OrderQty'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'OrdType'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: display_qty
        type: u4_nullable
        doc: 'DisplayQty. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'LocateReqd. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'LocateBroker. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  execution_report_replaced_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'OrigClOrdID. Nullable, No Value = 0'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'SymbolSfx. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_qty
        type: u4
        doc: 'OrderQty'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'OrdType'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: display_qty
        type: u4_nullable
        doc: 'DisplayQty. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'LocateReqd. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'LocateBroker. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  execution_report_trade_correction_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: exec_ref_id
        type: u8
        doc: 'ExecRefID'
      - id: trd_match_id
        type: u8
        doc: 'TrdMatchID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: last_px
        type: decimal_s8_6
        doc: 'LastPx. Implied decimal with scale 1e-6'
      - id: last_qty_optional
        type: u4_nullable
        doc: 'LastQty. Nullable, No Value = 4294967295'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: security_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'SecurityGroup'
      - id: execution_details
        type: execution_details
        doc: 'ExecutionDetailsType bit set'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'AuctionType. Nullable, No Value = 0'
      - id: auction_id
        type: u8
        doc: 'AuctionId'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  execution_report_trade_break_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: exec_ref_id
        type: u8
        doc: 'ExecRefID'
      - id: trd_match_id
        type: u8
        doc: 'TrdMatchID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: security_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'SecurityGroup'
      - id: execution_details
        type: execution_details
        doc: 'ExecutionDetailsType bit set'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'AuctionType. Nullable, No Value = 0'
      - id: auction_id
        type: u8
        doc: 'AuctionId'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  execution_report_restatement_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'OrdStatus'
      - id: last_px_optional
        type: decimal_s8_6_nullable
        doc: 'LastPx. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: last_qty_optional
        type: u4_nullable
        doc: 'LastQty. Nullable, No Value = 4294967295'
      - id: exec_restatement_reason
        type: u1
        enum: exec_restatement_reason
        doc: 'ExecRestatementReason'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: extended_restatement_reason
        type: u1_nullable
        doc: 'ExtendedRestatementReason. Nullable, No Value = 255'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  order_cancel_reject_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: cxl_rej_response_to
        type: u1
        enum: cxl_rej_response_to
        doc: 'CxlRejResponseTo'
      - id: cxl_rej_reason
        type: u1
        enum: cxl_rej_reason
        doc: 'CxlRejReason'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'LnkID. Nullable, No Value = 0'
  mass_cancel_reject_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'SymbolSfx. Nullable, No Value = 0'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'Side. Nullable, No Value = 0'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'LowerThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'HigherThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupID. Nullable, No Value = 65535'
      - id: mass_cancel_reject_reason
        type: u1
        enum: mass_cancel_reject_reason
        doc: 'RejectReason'
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
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_s8_6_nullable:
    seq:
      - id: value
        type: decimal_s8_6
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  str_1_nullable:
    seq:
      - id: value
        size: 1
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_16_nullable:
    seq:
      - id: value
        size: 16
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0

enums:
  message_type:
    0:
      id: 'heartbeat'
      doc: '24X Tcp Heartbeat'
    100:
      id: 'login_request'
      doc: '24X Tcp Login Request'
    101:
      id: 'replay_request'
      doc: '24X Tcp Replay Request'
    102:
      id: 'replay_all_request'
      doc: '24X Tcp Replay All Request'
    103:
      id: 'stream_request'
      doc: '24X Tcp Stream Request'
    104:
      id: 'unsequenced_message'
      doc: '24X Tcp Unsequenced Message'
    1:
      id: 'login_accepted'
      doc: '24X Tcp Login Accepted Message'
    2:
      id: 'login_rejected'
      doc: '24X Tcp Login Rejected Message'
    3:
      id: 'start_of_session'
      doc: '24X Tcp Start of Session Message'
    4:
      id: 'end_of_session'
      doc: '24X Tcp End of Session Message'
    5:
      id: 'replay_begin'
      doc: '24X Tcp Replay Begin Message'
    6:
      id: 'replay_rejected'
      doc: '24X Tcp Replay Rejected Message'
    7:
      id: 'replay_complete'
      doc: '24X Tcp Replay Complete Message'
    8:
      id: 'stream_begin'
      doc: '24X Tcp Stream Begin Message'
    9:
      id: 'stream_rejected'
      doc: '24X Tcp Stream Rejected Message'
    10:
      id: 'stream_complete'
      doc: '24X Tcp Stream Complete Message'
    11:
      id: 'sequenced_message'
      doc: '24X Tcp Sequenced Message'
  template_id:
    1:
      id: 'new_order_single_message'
      doc: 'NewOrderSingleMessage'
    2:
      id: 'order_cancel_replace_request_message'
      doc: 'OrderCancelReplaceRequestMessage'
    3:
      id: 'order_cancel_request_message'
      doc: 'OrderCancelRequestMessage'
    4:
      id: 'mass_cancel_request_message'
      doc: 'MassCancelRequestMessage'
    6:
      id: 'execution_report_new_message'
      doc: 'ExecutionReport_NewMessage'
    7:
      id: 'execution_report_rejected_message'
      doc: 'ExecutionReport_RejectedMessage'
    8:
      id: 'execution_report_trade_message'
      doc: 'ExecutionReport_TradeMessage'
    9:
      id: 'execution_report_pending_cancel_message'
      doc: 'ExecutionReport_PendingCancelMessage'
    10:
      id: 'pending_mass_cancel_message'
      doc: 'PendingMassCancelMessage'
    11:
      id: 'execution_report_canceled_message'
      doc: 'ExecutionReport_CanceledMessage'
    12:
      id: 'mass_cancel_done_message'
      doc: 'MassCancelDoneMessage'
    13:
      id: 'execution_report_pending_replace_message'
      doc: 'ExecutionReport_PendingReplaceMessage'
    14:
      id: 'execution_report_replaced_message'
      doc: 'ExecutionReport_ReplacedMessage'
    15:
      id: 'execution_report_trade_correction_message'
      doc: 'ExecutionReport_TradeCorrectionMessage'
    16:
      id: 'execution_report_trade_break_message'
      doc: 'ExecutionReport_TradeBreakMessage'
    17:
      id: 'execution_report_restatement_message'
      doc: 'ExecutionReport_RestatementMessage'
    18:
      id: 'order_cancel_reject_message'
      doc: 'OrderCancelRejectMessage'
    20:
      id: 'mass_cancel_reject_message'
      doc: 'MassCancelRejectMessage'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x35:
      id: 'sell_short'
      doc: 'SellShort'
    0x36:
      id: 'sell_short_exempt'
      doc: 'SellShortExempt'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x50:
      id: 'pegged'
      doc: 'Pegged'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x32:
      id: 'at_the_open'
      doc: 'AtTheOpen'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'ImmediateOrCancel'
    0x34:
      id: 'fill_or_kill'
      doc: 'FillOrKill'
    0x37:
      id: 'at_the_close'
      doc: 'AtTheClose'
    0x41:
      id: 'good_for_time'
      doc: 'GoodForTime'
    0x46:
      id: 'regular_hours_only'
      doc: 'RegularHoursOnly'
  order_capacity:
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x52:
      id: 'riskless_principal'
      doc: 'RisklessPrincipal'
  cust_order_capacity_optional:
    1:
      id: 'member_trading_on_their_own_account'
      doc: 'MemberTradingOnTheirOwnAccount'
    5:
      id: 'retail_customer'
      doc: 'RetailCustomer'
    255:
      id: 'null_value'
      doc: 'NullValue'
  peg_price_type:
    2:
      id: 'mid_price_peg'
      doc: 'MidPricePeg'
    5:
      id: 'primary_peg'
      doc: 'PrimaryPeg'
    255:
      id: 'null_value'
      doc: 'NullValue'
  display_method:
    0x31:
      id: 'initial'
      doc: 'Initial'
    0x33:
      id: 'random'
      doc: 'Random'
    0x34:
      id: 'undisclosed'
      doc: 'Undisclosed'
  reserve_replenish_timing:
    1:
      id: 'immediate'
      doc: 'Immediate'
    2:
      id: 'random'
      doc: 'Random'
    255:
      id: 'null_value'
      doc: 'NullValue'
  reprice_frequency:
    0:
      id: 'single_reprice'
      doc: 'SingleReprice'
    1:
      id: 'continuous_reprice'
      doc: 'ContinuousReprice'
    2:
      id: 'none'
      doc: 'None'
    255:
      id: 'null_value'
      doc: 'NullValue'
  reprice_behavior:
    1:
      id: 'reprice_lock_cancel_cross'
      doc: 'RepriceLockCancelCross'
    2:
      id: 'reprice_lock_reprice_cross'
      doc: 'RepriceLockRepriceCross'
    255:
      id: 'null_value'
      doc: 'NullValue'
  self_trade_prevention:
    0:
      id: 'cancel_newest'
      doc: 'CancelNewest'
    1:
      id: 'cancel_oldest'
      doc: 'CancelOldest'
    2:
      id: 'decrement_and_cancel'
      doc: 'DecrementAndCancel'
    3:
      id: 'cancel_both'
      doc: 'CancelBoth'
    4:
      id: 'cancel_smallest'
      doc: 'CancelSmallest'
    255:
      id: 'null_value'
      doc: 'NullValue'
  party_role:
    1:
      id: 'executing_firm'
      doc: 'ExecutingFirm'
  side_optional:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x35:
      id: 'sell_short'
      doc: 'SellShort'
    0x36:
      id: 'sell_short_exempt'
      doc: 'SellShortExempt'
  supported_request_mode:
    0x53:
      id: 'stream'
      doc: 'Stream Mode'
    0x52:
      id: 'replay'
      doc: 'Replay Mode'
    0x54:
      id: 'snapshot_mode'
      doc: 'Snapshot Mode'
  login_reject_code:
    0x54:
      id: 'malformed_token'
      doc: 'Malformed Token'
    0x55:
      id: 'token_type_unsupported'
      doc: 'Token type unsupported by this server'
    0x56:
      id: 'token_type_invalid'
      doc: 'Token type invalid on any server'
    0x41:
      id: 'authorization_failed'
      doc: 'Authorization failed'
  replay_reject_code:
    0x52:
      id: 'replay_requests_are_not_allowed'
      doc: 'Stream requests are not allowed by this server. Must use replay requests to receive data'
    0x41:
      id: 'replay_all_requests_are_not_allowed'
      doc: 'Replay all requests are not allowed by this server'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session ID on the request is not the active session'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'Start sequence number out of range'
  stream_reject_code:
    0x52:
      id: 'stream_requests_are_not_allowed'
      doc: 'Stream requests are not allowed by this server. Must use replay requests to receive data'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session ID on the request is not the active session'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'Start sequence number out of range'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x31:
      id: 'partial_filled'
      doc: 'PartialFilled'
    0x32:
      id: 'filled'
      doc: 'Filled'
    0x34:
      id: 'canceled'
      doc: 'Canceled'
    0x36:
      id: 'pending_cancel'
      doc: 'PendingCancel'
    0x38:
      id: 'rejected'
      doc: 'Rejected'
    0x43:
      id: 'expired'
      doc: 'Expired'
    0x45:
      id: 'pending_replace'
      doc: 'PendingReplace'
  cust_order_capacity:
    1:
      id: 'member_trading_on_their_own_account'
      doc: 'MemberTradingOnTheirOwnAccount'
    5:
      id: 'retail_customer'
      doc: 'RetailCustomer'
    255:
      id: 'null_value'
      doc: 'NullValue'
  order_reject_reason:
    1:
      id: 'invalid_symbol'
      doc: 'InvalidSymbol'
    2:
      id: 'exchange_closed'
      doc: 'ExchangeClosed'
    3:
      id: 'order_size_exceeds_limit'
      doc: 'OrderSizeExceedsLimit'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    18:
      id: 'invalid_limit_price_increment'
      doc: 'InvalidLimitPriceIncrement'
    19:
      id: 'no_nbbo_available'
      doc: 'NoNBBOAvailable'
    20:
      id: 'order_notional_exceeds_limit'
      doc: 'OrderNotionalExceedsLimit'
    22:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'BlockSellShortRiskRuleViolated'
    23:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'HardToBorrowSecurityRiskRuleViolated'
    27:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'MaxNotionalValuePerOrderRiskRuleBreach'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'missing_symbol'
      doc: 'MissingSymbol'
    101:
      id: 'missing_locate_reqd'
      doc: 'MissingLocateReqd'
    102:
      id: 'invalid_locate_reqd'
      doc: 'InvalidLocateReqd'
    103:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdId'
    104:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdId'
    105:
      id: 'missing_side'
      doc: 'MissingSide'
    106:
      id: 'invalid_side'
      doc: 'InvalidSide'
    107:
      id: 'missing_order_quantity'
      doc: 'MissingOrderQuantity'
    108:
      id: 'invalid_order_quantity'
      doc: 'InvalidOrderQuantity'
    109:
      id: 'missing_order_type'
      doc: 'MissingOrderType'
    110:
      id: 'invalid_order_type'
      doc: 'InvalidOrderType'
    111:
      id: 'missing_time_in_force'
      doc: 'MissingTimeInForce'
    112:
      id: 'invalid_time_in_force'
      doc: 'InvalidTimeInForce'
    113:
      id: 'missing_order_capacity'
      doc: 'MissingOrderCapacity'
    114:
      id: 'invalid_order_capacity'
      doc: 'InvalidOrderCapacity'
    115:
      id: 'missing_exec_inst'
      doc: 'MissingExecInst'
    116:
      id: 'missing_limit_price'
      doc: 'MissingLimitPrice'
    117:
      id: 'invalid_limit_price'
      doc: 'InvalidLimitPrice'
    118:
      id: 'missing_max_floor'
      doc: 'MissingMaxFloor'
    119:
      id: 'invalid_max_floor'
      doc: 'InvalidMaxFloor'
    120:
      id: 'missing_reserve_replenish_amount_type'
      doc: 'MissingReserveReplenishAmountType'
    121:
      id: 'invalid_reserve_replenish_amount_type'
      doc: 'InvalidReserveReplenishAmountType'
    122:
      id: 'missing_reserve_replenish_time_type'
      doc: 'MissingReserveReplenishTimeType'
    123:
      id: 'invalid_reserve_replenish_time_type'
      doc: 'InvalidReserveReplenishTimeType'
    124:
      id: 'missing_random_replenish_value'
      doc: 'MissingRandomReplenishValue'
    125:
      id: 'invalid_random_replenish_value'
      doc: 'InvalidRandomReplenishValue'
    126:
      id: 'invalid_random_replenish_value_for_reserve_type'
      doc: 'InvalidRandomReplenishValueForReserveType'
    127:
      id: 'missing_reprice_frequency_type'
      doc: 'MissingRepriceFrequencyType'
    128:
      id: 'invalid_reprice_frequency_type'
      doc: 'InvalidRepriceFrequencyType'
    129:
      id: 'missing_reprice_behavior_type'
      doc: 'MissingRepriceBehaviorType'
    130:
      id: 'invalid_reprice_behavior_type'
      doc: 'InvalidRepriceBehaviorType'
    131:
      id: 'invalid_reprice_behavior_for_reprice_frequency'
      doc: 'InvalidRepriceBehaviorForRepriceFrequency'
    132:
      id: 'missing_customer_capacity_type'
      doc: 'MissingCustomerCapacityType'
    133:
      id: 'invalid_customer_capacity_type'
      doc: 'InvalidCustomerCapacityType'
    134:
      id: 'missing_expire_time'
      doc: 'MissingExpireTime'
    135:
      id: 'invalid_expire_time'
      doc: 'InvalidExpireTime'
    136:
      id: 'missing_peg_type'
      doc: 'MissingPegType'
    137:
      id: 'invalid_peg_type'
      doc: 'InvalidPegType'
    138:
      id: 'invalid_modifier_for_order_type'
      doc: 'InvalidModifierForOrderType'
    139:
      id: 'invalid_modifiers_combination'
      doc: 'InvalidModifiersCombination'
    140:
      id: 'invalid_trading_session_for_order_type'
      doc: 'InvalidTradingSessionForOrderType'
    141:
      id: 'invalid_time_in_force_for_order_type'
      doc: 'InvalidTimeInForceForOrderType'
    142:
      id: 'invalid_modifier_for_peg_type'
      doc: 'InvalidModifierForPegType'
    143:
      id: 'invalid_min_quantity'
      doc: 'InvalidMinQuantity'
    144:
      id: 'invalid_exec_inst'
      doc: 'InvalidExecInst'
    145:
      id: 'invalid_mpid'
      doc: 'InvalidMPID'
    146:
      id: 'symbol_halted_or_paused'
      doc: 'SymbolHaltedOrPaused'
    147:
      id: 'block_iso_risk_rule_violated'
      doc: 'BlockISORiskRuleViolated'
    148:
      id: 'block_session_risk_rule_violated'
      doc: 'BlockSessionRiskRuleViolated'
    149:
      id: 'block_non_test_symbols_risk_rule_violated'
      doc: 'BlockNonTestSymbolsRiskRuleViolated'
    150:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'MaxSharesPerOrderRiskRuleBreach'
    151:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'PricePercentCollarRiskRuleViolated'
    152:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'PriceValueCollarRiskRuleViolated'
    153:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'MaxADVPercentPerOrderRiskRuleBreach'
    154:
      id: 'daily_gross_notional_exposure_risk_rule_breach'
      doc: 'DailyGrossNotionalExposureRiskRuleBreach'
    155:
      id: 'daily_net_notional_exposure_risk_rule_breach'
      doc: 'DailyNetNotionalExposureRiskRuleBreach'
    156:
      id: 'max_num_duplicate_orders_risk_rule_breach'
      doc: 'MaxNumDuplicateOrdersRiskRuleBreach'
    157:
      id: 'max_order_rate_risk_rule_breach'
      doc: 'MaxOrderRateRiskRuleBreach'
    158:
      id: 'restricted_security_risk_rule_violated'
      doc: 'RestrictedSecurityRiskRuleViolated'
    159:
      id: 'invalid_self_trade_prevention_configuration'
      doc: 'InvalidSelfTradePreventionConfiguration'
    160:
      id: 'invalid_self_trade_prevention_type'
      doc: 'InvalidSelfTradePreventionType'
    161:
      id: 'invalid_risk_group_id'
      doc: 'InvalidRiskGroupId'
    162:
      id: 'firm_disabled'
      doc: 'FirmDisabled'
    163:
      id: 'mpid_disabled'
      doc: 'MPIDDisabled'
    164:
      id: 'account_disabled'
      doc: 'AccountDisabled'
    165:
      id: 'cannot_trade_non_test_symbol'
      doc: 'CannotTradeNonTestSymbol'
    166:
      id: 'missing_firm'
      doc: 'MissingFirm'
    167:
      id: 'missing_account'
      doc: 'MissingAccount'
    168:
      id: 'missing_mpid'
      doc: 'MissingMPID'
    169:
      id: 'missing_risk_group'
      doc: 'MissingRiskGroup'
    170:
      id: 'daily_market_order_gross_notional_exposure_risk_rule_breach'
      doc: 'DailyMarketOrderGrossNotionalExposureRiskRuleBreach'
    171:
      id: 'daily_market_order_net_notional_exposure_risk_rule_breach'
      doc: 'DailyMarketOrderNetNotionalExposureRiskRuleBreach'
    172:
      id: 'missing_disp_method_type'
      doc: 'MissingDispMethodType'
    173:
      id: 'missing_firm_risk_setting'
      doc: 'MissingFirmRiskSetting'
    174:
      id: 'invalid_account_mpid_to_firm'
      doc: 'InvalidAccountMPIDToFirm'
    175:
      id: 'invalid_peg_offset_value'
      doc: 'InvalidPegOffsetValue'
    176:
      id: 'invalid_disp_method_type'
      doc: 'InvalidDispMethodType'
    177:
      id: 'missing_cancel_group_id'
      doc: 'MissingCancelGroupId'
    178:
      id: 'invalid_cancel_group_id'
      doc: 'InvalidCancelGroupId'
    179:
      id: 'missing_stp_group_id'
      doc: 'MissingSTPGroupId'
    180:
      id: 'invalid_stp_group_id'
      doc: 'InvalidSTPGroupId'
    181:
      id: 'invalid_lnk_id'
      doc: 'InvalidLnkId'
    182:
      id: 'missing_locate_broker'
      doc: 'MissingLocateBroker'
    183:
      id: 'invalid_locate_broker'
      doc: 'InvalidLocateBroker'
    184:
      id: 'invalid_extended_exec_inst'
      doc: 'InvalidExtendedExecInst'
    255:
      id: 'null_value'
      doc: 'NullValue'
  last_liquidity_ind:
    1:
      id: 'add'
      doc: 'Add'
    2:
      id: 'removed'
      doc: 'Removed'
    3:
      id: 'routed'
      doc: 'Routed'
    4:
      id: 'auction'
      doc: 'Auction'
    255:
      id: 'null_value'
      doc: 'NullValue'
  auction_type:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x49:
      id: 'ipo'
      doc: 'IPO'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x50:
      id: 'volatility_pause'
      doc: 'VolatilityPause'
  cancel_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'user_requested_cancel'
      doc: 'UserRequestedCancel'
    4:
      id: 'end_of_trading'
      doc: 'EndOfTrading'
    5:
      id: 'limit_up_limit_down'
      doc: 'LimitUpLimitDown'
    6:
      id: 'halted'
      doc: 'Halted'
    7:
      id: 'exchange_supervisory'
      doc: 'ExchangeSupervisory'
    8:
      id: 'order_expired'
      doc: 'OrderExpired'
    9:
      id: 'lock_or_cross_book'
      doc: 'LockOrCrossBook'
    10:
      id: 'self_trade_prevention'
      doc: 'SelfTradePrevention'
    11:
      id: 'insufficient_quotes'
      doc: 'InsufficientQuotes'
    12:
      id: 'non_compliant_reg_nms_price'
      doc: 'NonCompliantRegNmsPrice'
    13:
      id: 'participant_disconnect'
      doc: 'ParticipantDisconnect'
    14:
      id: 'order_not_bookable'
      doc: 'OrderNotBookable'
    15:
      id: 'trade_protection_limits'
      doc: 'TradeProtectionLimits'
    16:
      id: 'unable_to_route'
      doc: 'UnableToRoute'
    17:
      id: 'firm_disabled'
      doc: 'FirmDisabled'
    18:
      id: 'mpid_disabled'
      doc: 'MPIDDisabled'
    19:
      id: 'account_disabled'
      doc: 'AccountDisabled'
    20:
      id: 'notional_exposure_risk_breached'
      doc: 'NotionalExposureRiskBreached'
    21:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdId'
    22:
      id: 'no_contra_liquidity'
      doc: 'NoContraLiquidity'
    23:
      id: 'outside_collar_price_range'
      doc: 'OutsideCollarPriceRange'
    24:
      id: 'non_compliant_reg_sho_price'
      doc: 'NonCompliantRegShoPrice'
    255:
      id: 'null_value'
      doc: 'NullValue'
  exec_restatement_reason:
    3:
      id: 'order_reprice'
      doc: 'OrderReprice'
    5:
      id: 'self_trade_prevention'
      doc: 'SelfTradePrevention'
    99:
      id: 'other'
      doc: 'Other'
    255:
      id: 'null_value'
      doc: 'NullValue'
  extended_restatement_reason:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'set_nbbo'
      doc: 'SetNBBO'
    2:
      id: 'joined_nbbo'
      doc: 'JoinedNBBO'
    3:
      id: 'self_trade_cancel_newest'
      doc: 'SelfTradeCancelNewest'
    4:
      id: 'self_trade_cancel_oldest'
      doc: 'SelfTradeCancelOldest'
    5:
      id: 'self_trade_decrement_and_cancel'
      doc: 'SelfTradeDecrementAndCancel'
    6:
      id: 'self_trade_cancel_both'
      doc: 'SelfTradeCancelBoth'
    7:
      id: 'self_trade_cancel_smallest'
      doc: 'SelfTradeCancelSmallest'
    255:
      id: 'null_value'
      doc: 'NullValue'
  cxl_rej_response_to:
    0x31:
      id: 'order_cancel_request'
      doc: 'OrderCancelRequest'
    0x32:
      id: 'order_cancel_replace_request'
      doc: 'OrderCancelReplaceRequest'
  cxl_rej_reason:
    0:
      id: 'too_late_to_cancel'
      doc: 'TooLateToCancel'
    1:
      id: 'unknown_orig_order'
      doc: 'UnknownOrigOrder'
    3:
      id: 'order_in_pending_state'
      doc: 'OrderInPendingState'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    18:
      id: 'invalid_limit_price_increment'
      doc: 'InvalidLimitPriceIncrement'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'missing_symbol'
      doc: 'MissingSymbol'
    101:
      id: 'missing_locate'
      doc: 'MissingLocate'
    102:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdId'
    103:
      id: 'invalid_order_quantity'
      doc: 'InvalidOrderQuantity'
    104:
      id: 'invalid_symbol'
      doc: 'InvalidSymbol'
    105:
      id: 'invalid_limit_price'
      doc: 'InvalidLimitPrice'
    107:
      id: 'symbol_halted_or_paused'
      doc: 'SymbolHaltedOrPaused'
    108:
      id: 'order_size_exceeds_limit'
      doc: 'OrderSizeExceedsLimit'
    109:
      id: 'exceeded_max_notional_order_amt'
      doc: 'ExceededMaxNotionalOrderAmt'
    110:
      id: 'missing_orig_order_identifiers'
      doc: 'MissingOrigOrderIdentifiers'
    111:
      id: 'ambiguous_orig_order_identifiers'
      doc: 'AmbiguousOrigOrderIdentifiers'
    112:
      id: 'orig_order_symbol_not_matching_request_symbol'
      doc: 'OrigOrderSymbolNotMatchingRequestSymbol'
    113:
      id: 'unsupported_display_quantity_change'
      doc: 'UnsupportedDisplayQuantityChange'
    114:
      id: 'unsupported_ord_type_change'
      doc: 'UnsupportedOrdTypeChange'
    115:
      id: 'unsupported_side_change'
      doc: 'UnsupportedSideChange'
    116:
      id: 'unsupported_quantity_change'
      doc: 'UnsupportedQuantityChange'
    117:
      id: 'invalid_locate'
      doc: 'InvalidLocate'
    118:
      id: 'exchange_closed'
      doc: 'ExchangeClosed'
    119:
      id: 'block_session_risk_rule_violated'
      doc: 'BlockSessionRiskRuleViolated'
    120:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'BlockSellShortRiskRuleViolated'
    121:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'MaxSharesPerOrderRiskRuleBreach'
    122:
      id: 'no_nbbo_available'
      doc: 'NoNBBOAvailable'
    123:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'MaxNotionalValuePerOrderRiskRuleBreach'
    124:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'MaxADVPercentPerOrderRiskRuleBreach'
    125:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'PricePercentCollarRiskRuleViolated'
    126:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'PriceValueCollarRiskRuleViolated'
    127:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'HardToBorrowSecurityRiskRuleViolated'
    128:
      id: 'invalid_side'
      doc: 'InvalidSide'
    129:
      id: 'invalid_ord_type'
      doc: 'InvalidOrdType'
    130:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdId'
    131:
      id: 'invalid_lnk_id'
      doc: 'InvalidLnkId'
    132:
      id: 'missing_locate_broker'
      doc: 'MissingLocateBroker'
    133:
      id: 'invalid_locate_broker'
      doc: 'InvalidLocateBroker'
    255:
      id: 'null_value'
      doc: 'NullValue'
  mass_cancel_reject_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'unknown_product'
      doc: 'UnknownProduct'
    2:
      id: 'unknown_side'
      doc: 'UnknownSide'
    3:
      id: 'unknown_group_id'
      doc: 'UnknownGroupId'
    4:
      id: 'higher_price_lower_or_equal_to_lower_price'
      doc: 'HigherPriceLowerOrEqualToLowerPrice'
    5:
      id: 'product_missing_for_price_restriction'
      doc: 'ProductMissingForPriceRestriction'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    7:
      id: 'malformed_request_missing_cl_ord_id_field'
      doc: 'MalformedRequestMissingClOrdIdField'
    8:
      id: 'invalid_cancel_group_id'
      doc: 'InvalidCancelGroupId'
    9:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdId'
    10:
      id: 'invalid_lower_price'
      doc: 'InvalidLowerPrice'
    11:
      id: 'invalid_higher_price'
      doc: 'InvalidHigherPrice'
    255:
      id: 'null_value'
      doc: 'NullValue'

