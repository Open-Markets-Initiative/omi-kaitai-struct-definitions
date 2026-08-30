# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxEquities Memo Sbe v1.9
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Members Orders
#   Encoding: Simple Binary Encoding
#   Version: 1.9
#   Date: 5/25/22
#   Specification: MEMO SBE-v1_9.pdf
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
  id: memx_memxequities_memo_sbe_v1_9
  title: Memx MemxEquities Memo Sbe v1.9
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Equities Members Orders Sbe v1.9'
doc-ref: https://memxtrading.com/

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Tcp Common Header'
  - id: data
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::login_request': login_request_message
        'message_type::replay_request': replay_request_message
        'message_type::replay_all_request': replay_all_request_message
        'message_type::stream_request': stream_request_message
        'message_type::unsequenced_message': unsequenced_message
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
  login_request_message:
    seq:
      - id: token_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Token type'
      - id: token
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Token'
  replay_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
      - id: count
        type: u4
        doc: 'Total number of messages to include in the replay'
  replay_all_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
  stream_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
  unsequenced_message:
    seq:
      - id: sbe_message
        type: sbe_message
        doc: 'Sbe Message'
  sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::new_order_single_message': new_order_single_message
            'template_id::order_cancel_replace_request_message': order_cancel_replace_request_message
            'template_id::order_cancel_request_message': order_cancel_request_message
            'template_id::mass_cancel_request_message': mass_cancel_request_message
            'template_id::execution_report_pending_new_message': execution_report_pending_new_message
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
  new_order_single_message:
    seq:
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
        type: u1_nullable
        doc: 'DisplayMethod. Nullable, No Value = 255'
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
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'StpGroupId. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'SelfTradePrevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupId. Nullable, No Value = 65535'
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
  exec_inst:
    seq:
      - id: participate_do_not_initiate
        type: b1
        doc: 'ParticipateDoNotInitiate'
      - id: intermarket_sweep
        type: b1
        doc: 'IntermarketSweep'
      - id: external_routing_not_allowed
        type: b1
        doc: 'ExternalRoutingNotAllowed'
      - id: reserved_13
        type: b13
        doc: '13 reserved bits'
  order_cancel_replace_request_message:
    seq:
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'OrigClOrdID'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
  order_cancel_request_message:
    seq:
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'OrigClOrdID'
      - id: order_id_optional
        type: u8_nullable
        doc: 'OrderID. Nullable, No Value = 18446744073709551615'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
  mass_cancel_request_message:
    seq:
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
      - id: side_optional
        type: u1_nullable
        doc: 'Side. Nullable, No Value = 255'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'LowerThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'HigherThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupId. Nullable, No Value = 65535'
  execution_report_pending_new_message:
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
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
        type: u1_nullable
        doc: 'DisplayMethod. Nullable, No Value = 255'
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
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'StpGroupId. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'SelfTradePrevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupId. Nullable, No Value = 65535'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
        type: u1_nullable
        doc: 'DisplayMethod. Nullable, No Value = 255'
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
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'StpGroupId. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'SelfTradePrevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupId. Nullable, No Value = 65535'
      - id: leaves_qty
        type: u4
        doc: 'LeavesQty'
      - id: cum_qty
        type: u4
        doc: 'CumQty'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
        type: u1
        enum: last_mkt
        doc: 'LastMkt'
      - id: trd_matching_id
        type: u8
        doc: 'TrdMatchingID'
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'OrigClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
      - id: side_optional
        type: u1_nullable
        doc: 'Side. Nullable, No Value = 255'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'LowerThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'HigherThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupId. Nullable, No Value = 65535'
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
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'OrigClOrdID'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'OrigClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'OrigClOrdID'
      - id: exec_id
        type: u8
        doc: 'ExecID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: last_shares
        type: u4_nullable
        doc: 'LastShares. Nullable, No Value = 4294967295'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
      - id: link_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'LnkId'
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
      - id: side_optional
        type: u1_nullable
        doc: 'Side. Nullable, No Value = 255'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'LowerThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'HigherThanPrice. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: mass_cancel_reject_reason
        type: u1
        enum: mass_cancel_reject_reason
        doc: 'RejectReason'
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
      - id: sbe_message
        type: sbe_message
        doc: 'Sbe Message'
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
  message_type:
    100:
      id: 'login_request'
      doc: 'Memx Tcp Login Request'
    101:
      id: 'replay_request'
      doc: 'Memx Tcp Replay Request'
    102:
      id: 'replay_all_request'
      doc: 'Memx Tcp Replay All Request'
    103:
      id: 'stream_request'
      doc: 'Memx Tcp Stream Request'
    104:
      id: 'unsequenced_message'
      doc: 'Memx Tcp Unsequenced Message'
    1:
      id: 'login_accepted'
      doc: 'Memx Tcp Login Accepted Message'
    2:
      id: 'login_rejected'
      doc: 'Memx Tcp Login Rejected Message'
    3:
      id: 'start_of_session'
      doc: 'Memx Tcp Start of Session Message'
    4:
      id: 'end_of_session'
      doc: 'Memx Tcp End of Session Message'
    5:
      id: 'replay_begin'
      doc: 'Memx Tcp Replay Begin Message'
    6:
      id: 'replay_rejected'
      doc: 'Memx Tcp Replay Rejected Message'
    7:
      id: 'replay_complete'
      doc: 'Memx Tcp Replay Complete Message'
    8:
      id: 'stream_begin'
      doc: 'Memx Tcp Stream Begin Message'
    9:
      id: 'stream_rejected'
      doc: 'Memx Tcp Stream Rejected Message'
    10:
      id: 'stream_complete'
      doc: 'Memx Tcp Stream Complete Message'
    11:
      id: 'sequenced_message'
      doc: 'Memx Tcp Sequenced Message'
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
    5:
      id: 'execution_report_pending_new_message'
      doc: 'ExecutionReport_PendingNewMessage'
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
    1:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'sell_short'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'sell_short_exempt'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_type:
    1:
      id: 'market'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'limit'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'pegged'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force:
    1:
      id: 'day'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'immediate_or_cancel'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'fill_or_kill'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'good_for_time'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'regular_hours_only'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_capacity:
    1:
      id: 'agency'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'principal'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'riskless_principal'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cust_order_capacity:
    1:
      id: 'member_trading_on_their_own_account'
      doc: 'CustOrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'retail_customer'
      doc: 'CustOrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CustOrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  peg_price_type:
    1:
      id: 'mid_price_peg'
      doc: 'PegType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'primary_peg'
      doc: 'PegType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'PegType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  display_method:
    1:
      id: 'initial'
      doc: 'DispMethodType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'random'
      doc: 'DispMethodType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'undisclosed'
      doc: 'DispMethodType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'DispMethodType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reserve_replenish_timing:
    1:
      id: 'immediate'
      doc: 'ReserveReplenishTimingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'random'
      doc: 'ReserveReplenishTimingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ReserveReplenishTimingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reprice_frequency:
    1:
      id: 'single_reprice'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'continuous_reprice'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'none'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reprice_behavior:
    1:
      id: 'reprice_lock_cancel_cross'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'reprice_lock_reprice_cross'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  self_trade_prevention:
    1:
      id: 'cancel_newest'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancel_oldest'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'decrement_and_cancel'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cancel_both'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'cancel_smallest'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side_optional:
    1:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'sell_short'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'sell_short_exempt'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_status:
    1:
      id: 'new_field'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'partial_filled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'filled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'canceled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'pending_cancel'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'rejected'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'pending_new'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'pending_replace'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'expired'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_reject_reason:
    0:
      id: 'other'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'missing_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'missing_locate'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'missing_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'missing_side'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'missing_order_quantity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'missing_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'missing_time_in_force'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'missing_order_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'missing_exec_inst'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'missing_limit_price'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'missing_max_floor'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'missing_reserve_replenish_amount_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'missing_reserve_replenish_time_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'missing_random_replenish_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'missing_reprice_frequency_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'missing_reprice_behavior_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'missing_customer_capacity_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'missing_expire_time'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'missing_peg_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'invalid_modifier_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'invalid_modifiers_combination'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'invalid_trading_session_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'invalid_time_in_force_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'invalid_min_quantity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'invalid_order_quantity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'invalid_side'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'invalid_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'invalid_time_in_force'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'invalid_order_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'invalid_customer_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'invalid_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'invalid_expire_time'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'invalid_limit_price'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'invalid_limit_price_increment'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'invalid_max_floor'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'invalid_random_replenish_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'invalid_random_replenish_value_for_reserve_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'invalid_reserve_replenish_amount_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'invalid_reserve_replenish_time_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'invalid_reprice_frequency_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'invalid_reprice_behavior_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    42:
      id: 'invalid_reprice_behavior_for_reprice_frequency'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    43:
      id: 'invalid_mpid_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    44:
      id: 'invalid_peg_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    45:
      id: 'invalid_modifier_for_peg_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    46:
      id: 'invalid_locate'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    47:
      id: 'symbol_halted_or_paused'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    48:
      id: 'exchange_closed'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    49:
      id: 'duplicate_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    50:
      id: 'order_size_exceeds_limit'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    51:
      id: 'order_notional_exceeds_limit'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    52:
      id: 'block_iso_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    53:
      id: 'block_session_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    54:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    55:
      id: 'block_non_test_symbols_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    56:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    57:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    58:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    59:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    60:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    61:
      id: 'daily_gross_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    62:
      id: 'daily_net_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    63:
      id: 'max_num_duplicate_orders_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    64:
      id: 'max_order_rate_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65:
      id: 'restricted_security_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    66:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    67:
      id: 'invalid_self_trade_prevention_configuration'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    68:
      id: 'invalid_self_trade_prevention_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    69:
      id: 'invalid_risk_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    70:
      id: 'firm_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    71:
      id: 'mpid_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    72:
      id: 'account_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    73:
      id: 'no_nbbo_available'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    74:
      id: 'cannot_trade_non_test_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    75:
      id: 'missing_firm'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    76:
      id: 'missing_account'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    77:
      id: 'missing_mpid'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    78:
      id: 'missing_risk_group'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    79:
      id: 'daily_market_order_gross_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    80:
      id: 'daily_market_order_net_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    81:
      id: 'missing_disp_method_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    82:
      id: 'missing_firm_risk_setting'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    83:
      id: 'invalid_account_mpid_to_firm'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    84:
      id: 'invalid_peg_offset_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    85:
      id: 'invalid_disp_method_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    86:
      id: 'missing_cancel_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    87:
      id: 'invalid_cancel_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    88:
      id: 'missing_stp_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    89:
      id: 'invalid_stp_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    90:
      id: 'invalid_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    91:
      id: 'invalid_lnk_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  last_liquidity_ind:
    1:
      id: 'add_displayed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'removed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'routed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cross'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'add_hidden'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'add_midpoint_peg'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'add_displayed_nbbo_improve'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'add_displayed_nbbo_join'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'retail_add_displayed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'retail_removed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'retail_routed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'retail_cross'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'retail_add_hidden'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'retail_add_midpoint_peg'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'retail_add_displayed_nbbo_improve'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'retail_add_displayed_nbbo_join'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'retail_removed_on_entry'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  last_mkt:
    0x55:
      id: 'memx'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x51:
      id: 'nasdaq'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'nasdaq_bx'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'nasdaq_psx'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'nyse'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'arca'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'nyse_american'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4d:
      id: 'nyse_chicago'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'nyse_national'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'edgx'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4a:
      id: 'edga'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x5a:
      id: 'bats'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x59:
      id: 'batsy'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x56:
      id: 'iex'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4c:
      id: 'ltse'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'eprl'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'null_value'
      doc: 'ExchangeCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_reason:
    0:
      id: 'other'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'user_requested_cancel'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'end_of_trading'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'limit_up_limit_down'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'halted'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'exchange_supervisory'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'order_expired'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'lock_or_cross_book'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'self_trade_prevention'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'insufficient_quotes'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'non_compliant_price'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'participant_disconnect'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'order_not_bookable'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'trade_protection_limits'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'unable_to_route'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'firm_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'mpid_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'account_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'notional_exposure_risk_breached'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exec_restatement_reason:
    1:
      id: 'order_reprice'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'self_trade_prevention'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  extended_restatement_reason:
    0:
      id: 'none'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'set_nbbo'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'joined_nbbo'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cxl_rej_response_to:
    1:
      id: 'order_cancel_request'
      doc: 'CxlRejResponseToType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'order_cancel_replace_request'
      doc: 'CxlRejResponseToType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CxlRejResponseToType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cxl_rej_reason:
    0:
      id: 'other'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'missing_symbol'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'missing_cl_ord_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'missing_orig_order_identifiers'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ambiguous_orig_order_identifiers'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'unknown_orig_order'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'orig_order_symbol_not_matching_request_symbol'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'missing_locate'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_order_quantity'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_symbol'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'invalid_limit_price'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'invalid_limit_price_increment'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'invalid_locate'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'symbol_halted_or_paused'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'exchange_closed'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'duplicate_cl_ord_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'order_size_exceeds_limit'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'exceeded_max_notional_order_amt'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'unsupported_display_quantity_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'unsupported_ord_type_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'unsupported_side_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'unsupported_quantity_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'order_in_pending_state'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'block_session_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'no_nbbo_available'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'invalid_side'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'invalid_ord_type'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'invalid_cl_ord_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'invalid_lnk_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_cancel_reject_reason:
    0:
      id: 'other'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'unknown_product'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'unknown_side'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'unknown_group_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'higher_price_lower_or_equal_to_lower_price'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'product_missing_for_price_restriction'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'malformed_request_missing_cl_ord_id_field'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_cancel_group_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_cl_ord_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'invalid_lower_price'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'invalid_higher_price'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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

