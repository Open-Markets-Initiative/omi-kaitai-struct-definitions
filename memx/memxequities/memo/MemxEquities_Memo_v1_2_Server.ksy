# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxEquities Memo Sbe v1.2
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Members Orders
#   Encoding: Simple Binary Encoding
#   Version: 1.2
#   Date: 9/23/2020
#   Specification: MEMO SBE-v1_1.pdf
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
  id: memx_memxequities_memo_sbe_v1_2_server
  title: Memx MemxEquities Memo Sbe v1.2
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Equities Members Orders Sbe v1.2'
doc-ref: https://www.memxtrading.com/specs

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
        doc: 'Sbe message sent by Memx to the firm'
  server_sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: server_payload
        type:
          switch-on: sbe_header.template_id
          cases:
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
  execution_report_pending_new_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order. MEMO SBE v1.12 COPYRIGHT MEMX LLC 2023. ALL RIGHTS RESERVED. 25 Field Offset Length Type Tag Ref Num Req''d Description'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered. This represents the number of shares. Number of shares may not exceed 1MM. The notional value of an order may not exceed $30MM'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity (e.g. per share). Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: cust_order_capacity
        type: u1
        enum: cust_order_capacity
        doc: 'Capacity of the customer placing the order'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: peg_offset_value
        type: decimal_s8_6_nullable
        doc: 'Amount(signed) added to the peg for a pegged order. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: peg_price_type
        type: u1_nullable
        doc: 'Defines the type of peg. Nullable, No Value = 255'
      - id: expire_time
        type: u8_nullable
        doc: 'The expiration time of a GoodForTime TimeInForce order. Expiration time must be at least a 1 millisecond in the future. If omitted, expiration time will be set to the end of the MEMX post-market trading session. Specified in UTC timestamp since unix epoch in nanoseconds. Nullable, No Value = 18446744073709551615'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: display_method
        type: u1_nullable
        doc: 'Defines the replenishment size behavior for a reserve order. This should be MEMO SBE v1.12 COPYRIGHT MEMX LLC 2023. ALL RIGHTS RESERVED. 26 Field Offset Length Type Tag Ref Num Req''d Description null for a fully displayed order. Nullable, No Value = 255'
      - id: reserve_replenish_timing
        type: u1_nullable
        doc: 'Defines the replenishment timing behavior for a reserve order. Nullable, No Value = 255'
      - id: display_min_incr
        type: u4_nullable
        doc: 'Defines the minimum increment to be used when calculating a random refresh of DisplayQty. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders only. Only acceptable value is ''N'' which indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: reprice_frequency
        type: u1_nullable
        doc: 'Defines the frequency of a reprice. If this tag is not sent then the order will not be repriced. Nullable, No Value = 255'
      - id: reprice_behavior
        type: u1_nullable
        doc: 'Defines the reprice behavior when market is locked or crossed. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'StpGroupId. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'Defines the desired behavior in the event of a wash. The UINT8 Null (0xFF) value disables self trade prevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupId. Nullable, No Value = 65535'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: block_extension
        size: _parent.sbe_header.block_length - 125
        doc: 'Bytes the stated block holds beyond the 125 this version reads'
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
  execution_report_new_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order. MEMO SBE v1.12 COPYRIGHT MEMX LLC 2023. ALL RIGHTS RESERVED. 25 Field Offset Length Type Tag Ref Num Req''d Description'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered. This represents the number of shares. Number of shares may not exceed 1MM. The notional value of an order may not exceed $30MM'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity (e.g. per share). Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: cust_order_capacity
        type: u1
        enum: cust_order_capacity
        doc: 'Capacity of the customer placing the order'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: peg_offset_value
        type: decimal_s8_6_nullable
        doc: 'Amount(signed) added to the peg for a pegged order. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: peg_price_type
        type: u1_nullable
        doc: 'Defines the type of peg. Nullable, No Value = 255'
      - id: expire_time
        type: u8_nullable
        doc: 'The expiration time of a GoodForTime TimeInForce order. Expiration time must be at least a 1 millisecond in the future. If omitted, expiration time will be set to the end of the MEMX post-market trading session. Specified in UTC timestamp since unix epoch in nanoseconds. Nullable, No Value = 18446744073709551615'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: display_method
        type: u1_nullable
        doc: 'Defines the replenishment size behavior for a reserve order. This should be MEMO SBE v1.12 COPYRIGHT MEMX LLC 2023. ALL RIGHTS RESERVED. 26 Field Offset Length Type Tag Ref Num Req''d Description null for a fully displayed order. Nullable, No Value = 255'
      - id: reserve_replenish_timing
        type: u1_nullable
        doc: 'Defines the replenishment timing behavior for a reserve order. Nullable, No Value = 255'
      - id: display_min_incr
        type: u4_nullable
        doc: 'Defines the minimum increment to be used when calculating a random refresh of DisplayQty. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders only. Only acceptable value is ''N'' which indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: reprice_frequency
        type: u1_nullable
        doc: 'Defines the frequency of a reprice. If this tag is not sent then the order will not be repriced. Nullable, No Value = 255'
      - id: reprice_behavior
        type: u1_nullable
        doc: 'Defines the reprice behavior when market is locked or crossed. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'StpGroupId. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'Defines the desired behavior in the event of a wash. The UINT8 Null (0xFF) value disables self trade prevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupId. Nullable, No Value = 65535'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred. UTC timestamp since epoch with nanosecond precision'
      - id: block_extension
        size: _parent.sbe_header.block_length - 133
        doc: 'Bytes the stated block holds beyond the 133 this version reads'
  execution_report_rejected_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason code for order rejection'
      - id: block_extension
        size: _parent.sbe_header.block_length - 54
        doc: 'Bytes the stated block holds beyond the 54 this version reads'
  execution_report_trade_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: last_qty
        type: u4
        doc: 'Quantity (e.g. shares) bought/sold on this (last) fill'
      - id: last_px
        type: decimal_s8_6
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-6'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred. UTC timestamp since epoch with nanosecond precision'
      - id: last_liquidity_ind
        type: u1
        enum: last_liquidity_ind
        doc: 'Indicator denoting whether the referenced order removed liquidity from or added MEMO SBE v1.12 COPYRIGHT MEMX LLC 2023. ALL RIGHTS RESERVED. 37 Field Offset Length Type Tag Ref Num Req''d Description liquidity to the MEMX book'
      - id: last_mkt
        type: u1
        enum: last_mkt
        doc: 'Market of execution for last fill, or an indication of the market where an order was routed'
      - id: trd_matching_id
        type: u8
        doc: 'TrdMatchingID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 79
        doc: 'Bytes the stated block holds beyond the 79 this version reads'
  execution_report_pending_cancel_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID (11) of the previous order (NOT the initial order of the day)'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: block_extension
        size: _parent.sbe_header.block_length - 77
        doc: 'Bytes the stated block holds beyond the 77 this version reads'
  pending_mass_cancel_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: side_optional
        type: u1_nullable
        doc: 'Side of order. Nullable, No Value = 255'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'For Mass Cancel scenario, Any order with a lower or equal limit price would be included in the cancel filter. This filter can only be used in conjunction with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'For Mass Cancel scenario, Any order with a higher or equal limit price would be included in the cancel filter. This filter can only be used in conjunction with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: block_extension
        size: _parent.sbe_header.block_length - 55
        doc: 'Bytes the stated block holds beyond the 55 this version reads'
  execution_report_canceled_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID (11) of the previous order (NOT the initial order of the day)'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: cancel_reason
        type: u1_nullable
        doc: 'Reason code for order cancellation. Nullable, No Value = 255'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred. UTC timestamp since epoch with nanosecond precision'
      - id: block_extension
        size: _parent.sbe_header.block_length - 74
        doc: 'Bytes the stated block holds beyond the 74 this version reads'
  mass_cancel_done_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 24
        doc: 'Bytes the stated block holds beyond the 24 this version reads'
  execution_report_pending_replace_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID (11) of the previous order (NOT the initial order of the day)'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered. This represents the number of shares. Number of shares may not exceed 1MM. The notional value of an order may not exceed $30MM'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order. MEMO SBE v1.12 COPYRIGHT MEMX LLC 2023. ALL RIGHTS RESERVED. 25 Field Offset Length Type Tag Ref Num Req''d Description'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity (e.g. per share). Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders only. Only acceptable value is ''N'' which indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: block_extension
        size: _parent.sbe_header.block_length - 96
        doc: 'Bytes the stated block holds beyond the 96 this version reads'
  execution_report_replaced_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID (11) of the previous order (NOT the initial order of the day)'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered. This represents the number of shares. Number of shares may not exceed 1MM. The notional value of an order may not exceed $30MM'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order. MEMO SBE v1.12 COPYRIGHT MEMX LLC 2023. ALL RIGHTS RESERVED. 25 Field Offset Length Type Tag Ref Num Req''d Description'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity (e.g. per share). Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders only. Only acceptable value is ''N'' which indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred. UTC timestamp since epoch with nanosecond precision'
      - id: block_extension
        size: _parent.sbe_header.block_length - 104
        doc: 'Bytes the stated block holds beyond the 104 this version reads'
  execution_report_trade_correction_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: exec_ref_id
        type: u8
        doc: 'The ExecID of the trade being corrected'
      - id: trd_match_id
        type: u8
        doc: 'Identifier assigned to the Trade by the matching system. In case of executions on orders routed to another exchange, the TrdMatchID field will be filled on a best-effort basis'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: last_px
        type: decimal_s8_6
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-6'
      - id: last_qty_optional
        type: u4_nullable
        doc: 'Quantity (e.g. shares) bought/sold on this (last) fill. Nullable, No Value = 4294967295'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: block_extension
        size: _parent.sbe_header.block_length - 77
        doc: 'Bytes the stated block holds beyond the 77 this version reads'
  execution_report_trade_break_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: exec_ref_id
        type: u8
        doc: 'The ExecID of the trade being corrected'
      - id: trd_match_id
        type: u8
        doc: 'Identifier assigned to the Trade by the matching system. In case of executions on orders routed to another exchange, the TrdMatchID field will be filled on a best-effort basis'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: block_extension
        size: _parent.sbe_header.block_length - 65
        doc: 'Bytes the stated block holds beyond the 65 this version reads'
  execution_report_restatement_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'OrderID as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of execution message as assigned by the exchange. Uniqueness is guaranteed within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: last_px_optional
        type: decimal_s8_6_nullable
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity (e.g. number of shares) filled'
      - id: last_shares
        type: u4
        doc: 'ExecRestatementType(5): The number of shares that would have matched if this order had not been prevented from executing due to STP restrictions'
      - id: exec_restatement_reason
        type: u1
        enum: exec_restatement_reason
        doc: 'The reason for the restatement'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred. UTC timestamp since epoch with nanosecond precision'
      - id: block_extension
        size: _parent.sbe_header.block_length - 70
        doc: 'Bytes the stated block holds beyond the 70 this version reads'
  order_cancel_reject_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: cxl_rej_response_to
        type: u1
        enum: cxl_rej_response_to
        doc: 'Identifies the request that this cancel reject is responding to'
      - id: cxl_rej_reason
        type: u1
        enum: cxl_rej_reason
        doc: 'Code to identify reason for cancel rejection'
      - id: block_extension
        size: _parent.sbe_header.block_length - 26
        doc: 'Bytes the stated block holds beyond the 26 this version reads'
  mass_cancel_reject_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the ExecutionReport was sent. UTC timestamp since unix epoch with nanosecond precision. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'ClOrdID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'CMS symbol suffix. Additional information about the security (e.g. preferred, warrants, etc.)'
      - id: side_optional
        type: u1_nullable
        doc: 'Side of order. Nullable, No Value = 255'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'For Mass Cancel scenario, Any order with a lower or equal limit price would be included in the cancel filter. This filter can only be used in conjunction with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'For Mass Cancel scenario, Any order with a higher or equal limit price would be included in the cancel filter. This filter can only be used in conjunction with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'CancelGroupId. Nullable, No Value = 65535'
      - id: mass_cancel_reject_reason
        type: u1
        enum: mass_cancel_reject_reason
        doc: 'Reason code for order rejection'
      - id: block_extension
        size: _parent.sbe_header.block_length - 56
        doc: 'Bytes the stated block holds beyond the 56 this version reads'
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

enums:
  message_type:
    0:
      id: 'heartbeat'
      doc: 'Memx Tcp Heartbeat'
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
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'sell_short'
      doc: 'SellShort'
    4:
      id: 'sell_short_exempt'
      doc: 'SellShortExempt'
    255:
      id: 'null_value'
      doc: 'NullValue'
  ord_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'pegged'
      doc: 'Pegged'
    255:
      id: 'null_value'
      doc: 'NullValue'
  time_in_force:
    1:
      id: 'day'
      doc: 'Day'
    2:
      id: 'immediate_or_cancel'
      doc: 'ImmediateOrCancel'
    3:
      id: 'fill_or_kill'
      doc: 'FillOrKill'
    4:
      id: 'good_for_time'
      doc: 'GoodForTime'
    5:
      id: 'regular_hours_only'
      doc: 'RegularHoursOnly'
    255:
      id: 'null_value'
      doc: 'NullValue'
  order_capacity:
    1:
      id: 'agency'
      doc: 'Agency'
    2:
      id: 'principal'
      doc: 'Principal'
    3:
      id: 'riskless_principal'
      doc: 'RisklessPrincipal'
    255:
      id: 'null_value'
      doc: 'NullValue'
  cust_order_capacity:
    1:
      id: 'member_trading_on_their_own_account'
      doc: 'MemberTradingOnTheirOwnAccount'
    255:
      id: 'null_value'
      doc: 'NullValue'
  peg_price_type:
    1:
      id: 'mid_price_peg'
      doc: 'MidPricePeg'
    2:
      id: 'primary_peg'
      doc: 'PrimaryPeg'
    255:
      id: 'null_value'
      doc: 'NullValue'
  display_method:
    1:
      id: 'initial'
      doc: 'Initial'
    2:
      id: 'random'
      doc: 'Random'
    3:
      id: 'undisclosed'
      doc: 'Undisclosed'
    255:
      id: 'null_value'
      doc: 'NullValue'
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
    1:
      id: 'single_reprice'
      doc: 'SingleReprice'
    2:
      id: 'continuous_reprice'
      doc: 'ContinuousReprice'
    3:
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
    1:
      id: 'cancel_newest'
      doc: 'CancelNewest'
    2:
      id: 'cancel_oldest'
      doc: 'CancelOldest'
    3:
      id: 'decrement_and_cancel'
      doc: 'DecrementAndCancel'
    4:
      id: 'cancel_both'
      doc: 'CancelBoth'
    5:
      id: 'cancel_smallest'
      doc: 'CancelSmallest'
    255:
      id: 'null_value'
      doc: 'NullValue'
  side_optional:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'sell_short'
      doc: 'SellShort'
    4:
      id: 'sell_short_exempt'
      doc: 'SellShortExempt'
    255:
      id: 'null_value'
      doc: 'NullValue'
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
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'partial_filled'
      doc: 'PartialFilled'
    3:
      id: 'filled'
      doc: 'Filled'
    4:
      id: 'canceled'
      doc: 'Canceled'
    5:
      id: 'pending_cancel'
      doc: 'PendingCancel'
    6:
      id: 'rejected'
      doc: 'Rejected'
    7:
      id: 'pending_new'
      doc: 'PendingNew'
    8:
      id: 'pending_replace'
      doc: 'PendingReplace'
    9:
      id: 'expired'
      doc: 'Expired'
    255:
      id: 'null_value'
      doc: 'NullValue'
  order_reject_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'missing_symbol'
      doc: 'MissingSymbol'
    2:
      id: 'missing_locate'
      doc: 'MissingLocate'
    3:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdId'
    4:
      id: 'missing_side'
      doc: 'MissingSide'
    5:
      id: 'missing_order_quantity'
      doc: 'MissingOrderQuantity'
    6:
      id: 'missing_order_type'
      doc: 'MissingOrderType'
    7:
      id: 'missing_time_in_force'
      doc: 'MissingTimeInForce'
    8:
      id: 'missing_order_capacity'
      doc: 'MissingOrderCapacity'
    9:
      id: 'missing_exec_inst'
      doc: 'MissingExecInst'
    10:
      id: 'missing_limit_price'
      doc: 'MissingLimitPrice'
    11:
      id: 'missing_max_floor'
      doc: 'MissingMaxFloor'
    12:
      id: 'missing_reserve_replenish_amount_type'
      doc: 'MissingReserveReplenishAmountType'
    13:
      id: 'missing_reserve_replenish_time_type'
      doc: 'MissingReserveReplenishTimeType'
    14:
      id: 'missing_random_replenish_value'
      doc: 'MissingRandomReplenishValue'
    15:
      id: 'missing_reprice_frequency_type'
      doc: 'MissingRepriceFrequencyType'
    16:
      id: 'missing_reprice_behavior_type'
      doc: 'MissingRepriceBehaviorType'
    17:
      id: 'missing_customer_capacity_type'
      doc: 'MissingCustomerCapacityType'
    18:
      id: 'missing_expire_time'
      doc: 'MissingExpireTime'
    19:
      id: 'missing_peg_type'
      doc: 'MissingPegType'
    20:
      id: 'invalid_modifier_for_order_type'
      doc: 'InvalidModifierForOrderType'
    21:
      id: 'invalid_modifiers_combination'
      doc: 'InvalidModifiersCombination'
    22:
      id: 'invalid_trading_session_for_order_type'
      doc: 'InvalidTradingSessionForOrderType'
    23:
      id: 'invalid_time_in_force_for_order_type'
      doc: 'InvalidTimeInForceForOrderType'
    24:
      id: 'invalid_min_quantity'
      doc: 'InvalidMinQuantity'
    25:
      id: 'invalid_order_quantity'
      doc: 'InvalidOrderQuantity'
    26:
      id: 'invalid_side'
      doc: 'InvalidSide'
    27:
      id: 'invalid_order_type'
      doc: 'InvalidOrderType'
    28:
      id: 'invalid_time_in_force'
      doc: 'InvalidTimeInForce'
    29:
      id: 'invalid_order_capacity'
      doc: 'InvalidOrderCapacity'
    30:
      id: 'invalid_customer_capacity'
      doc: 'InvalidCustomerCapacity'
    31:
      id: 'invalid_symbol'
      doc: 'InvalidSymbol'
    32:
      id: 'invalid_expire_time'
      doc: 'InvalidExpireTime'
    33:
      id: 'invalid_limit_price'
      doc: 'InvalidLimitPrice'
    34:
      id: 'invalid_limit_price_increment'
      doc: 'InvalidLimitPriceIncrement'
    35:
      id: 'invalid_max_floor'
      doc: 'InvalidMaxFloor'
    36:
      id: 'invalid_random_replenish_value'
      doc: 'InvalidRandomReplenishValue'
    37:
      id: 'invalid_random_replenish_value_for_reserve_type'
      doc: 'InvalidRandomReplenishValueForReserveType'
    38:
      id: 'invalid_reserve_replenish_amount_type'
      doc: 'InvalidReserveReplenishAmountType'
    39:
      id: 'invalid_reserve_replenish_time_type'
      doc: 'InvalidReserveReplenishTimeType'
    40:
      id: 'invalid_reprice_frequency_type'
      doc: 'InvalidRepriceFrequencyType'
    41:
      id: 'invalid_reprice_behavior_type'
      doc: 'InvalidRepriceBehaviorType'
    42:
      id: 'invalid_reprice_behavior_for_reprice_frequency'
      doc: 'InvalidRepriceBehaviorForRepriceFrequency'
    43:
      id: 'invalid_mpid_value'
      doc: 'InvalidMPIDValue'
    44:
      id: 'invalid_peg_type'
      doc: 'InvalidPegType'
    45:
      id: 'invalid_modifier_for_peg_type'
      doc: 'InvalidModifierForPegType'
    46:
      id: 'invalid_locate'
      doc: 'InvalidLocate'
    47:
      id: 'symbol_halted_or_paused'
      doc: 'SymbolHaltedOrPaused'
    48:
      id: 'exchange_closed'
      doc: 'ExchangeClosed'
    49:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    50:
      id: 'order_size_exceeds_limit'
      doc: 'OrderSizeExceedsLimit'
    51:
      id: 'order_notional_exceeds_limit'
      doc: 'OrderNotionalExceedsLimit'
    52:
      id: 'block_iso_risk_rule_violated'
      doc: 'BlockISORiskRuleViolated'
    53:
      id: 'block_session_risk_rule_violated'
      doc: 'BlockSessionRiskRuleViolated'
    54:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'BlockSellShortRiskRuleViolated'
    55:
      id: 'block_non_test_symbols_risk_rule_violated'
      doc: 'BlockNonTestSymbolsRiskRuleViolated'
    56:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'MaxSharesPerOrderRiskRuleBreach'
    57:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'MaxNotionalValuePerOrderRiskRuleBreach'
    58:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'PricePercentCollarRiskRuleViolated'
    59:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'PriceValueCollarRiskRuleViolated'
    60:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'MaxADVPercentPerOrderRiskRuleBreach'
    61:
      id: 'daily_gross_notional_exposure_risk_rule_breach'
      doc: 'DailyGrossNotionalExposureRiskRuleBreach'
    62:
      id: 'daily_net_notional_exposure_risk_rule_breach'
      doc: 'DailyNetNotionalExposureRiskRuleBreach'
    63:
      id: 'max_num_duplicate_orders_risk_rule_breach'
      doc: 'MaxNumDuplicateOrdersRiskRuleBreach'
    64:
      id: 'max_order_rate_risk_rule_breach'
      doc: 'MaxOrderRateRiskRuleBreach'
    65:
      id: 'restricted_security_risk_rule_violated'
      doc: 'RestrictedSecurityRiskRuleViolated'
    66:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'HardToBorrowSecurityRiskRuleViolated'
    67:
      id: 'invalid_self_trade_prevention_configuration'
      doc: 'InvalidSelfTradePreventionConfiguration'
    68:
      id: 'invalid_self_trade_prevention_type'
      doc: 'InvalidSelfTradePreventionType'
    69:
      id: 'invalid_risk_group_id'
      doc: 'InvalidRiskGroupId'
    70:
      id: 'firm_disabled'
      doc: 'FirmDisabled'
    71:
      id: 'mpid_disabled'
      doc: 'MPIDDisabled'
    72:
      id: 'account_disabled'
      doc: 'AccountDisabled'
    73:
      id: 'no_nbbo_available'
      doc: 'NoNBBOAvailable'
    74:
      id: 'cannot_trade_non_test_symbol'
      doc: 'CannotTradeNonTestSymbol'
    75:
      id: 'missing_firm'
      doc: 'MissingFirm'
    76:
      id: 'missing_account'
      doc: 'MissingAccount'
    77:
      id: 'missing_mpid'
      doc: 'MissingMPID'
    78:
      id: 'missing_risk_group'
      doc: 'MissingRiskGroup'
    79:
      id: 'daily_market_order_gross_notional_exposure_risk_rule_breach'
      doc: 'DailyMarketOrderGrossNotionalExposureRiskRuleBreach'
    80:
      id: 'daily_market_order_net_notional_exposure_risk_rule_breach'
      doc: 'DailyMarketOrderNetNotionalExposureRiskRuleBreach'
    81:
      id: 'missing_disp_method_type'
      doc: 'MissingDispMethodType'
    82:
      id: 'missing_firm_risk_setting'
      doc: 'MissingFirmRiskSetting'
    83:
      id: 'invalid_account_mpid_to_firm'
      doc: 'InvalidAccountMPIDToFirm'
    84:
      id: 'invalid_peg_offset_value'
      doc: 'InvalidPegOffsetValue'
    255:
      id: 'null_value'
      doc: 'NullValue'
  last_liquidity_ind:
    1:
      id: 'add_displayed'
      doc: 'AddDisplayed'
    2:
      id: 'removed'
      doc: 'Removed'
    3:
      id: 'routed'
      doc: 'Routed'
    4:
      id: 'cross'
      doc: 'Cross'
    5:
      id: 'add_hidden'
      doc: 'AddHidden'
    6:
      id: 'add_midpoint_peg'
      doc: 'AddMidpointPeg'
    7:
      id: 'add_displayed_nbbo_improve'
      doc: 'AddDisplayedNbboImprove'
    255:
      id: 'null_value'
      doc: 'NullValue'
  last_mkt:
    0x55:
      id: 'memx'
      doc: 'MEMX'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'nasdaq_bx'
      doc: 'NasdaqBX'
    0x58:
      id: 'nasdaq_psx'
      doc: 'NasdaqPSX'
    0x4e:
      id: 'nyse'
      doc: 'NYSE'
    0x50:
      id: 'arca'
      doc: 'ARCA'
    0x41:
      id: 'nyse_american'
      doc: 'NYSEAmerican'
    0x4d:
      id: 'nyse_chicago'
      doc: 'NYSEChicago'
    0x43:
      id: 'nyse_national'
      doc: 'NYSENational'
    0x4b:
      id: 'edgx'
      doc: 'EDGX'
    0x4a:
      id: 'edga'
      doc: 'EDGA'
    0x5a:
      id: 'bats'
      doc: 'BATS'
    0x59:
      id: 'batsy'
      doc: 'BATSY'
    0x56:
      id: 'iex'
      doc: 'IEX'
    0x4c:
      id: 'ltse'
      doc: 'LTSE'
    0x48:
      id: 'eprl'
      doc: 'EPRL'
    0x20:
      id: 'null_value'
      doc: 'NullValue'
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
      id: 'non_compliant_price'
      doc: 'NonCompliantPrice'
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
    255:
      id: 'null_value'
      doc: 'NullValue'
  exec_restatement_reason:
    1:
      id: 'order_reprice'
      doc: 'OrderReprice'
    2:
      id: 'self_trade_prevention'
      doc: 'SelfTradePrevention'
    255:
      id: 'null_value'
      doc: 'NullValue'
  cxl_rej_response_to:
    1:
      id: 'order_cancel_request'
      doc: 'OrderCancelRequest'
    2:
      id: 'order_cancel_replace_request'
      doc: 'OrderCancelReplaceRequest'
    255:
      id: 'null_value'
      doc: 'NullValue'
  cxl_rej_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'missing_symbol'
      doc: 'MissingSymbol'
    2:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdId'
    3:
      id: 'missing_orig_order_identifiers'
      doc: 'MissingOrigOrderIdentifiers'
    4:
      id: 'ambiguous_orig_order_identifiers'
      doc: 'AmbiguousOrigOrderIdentifiers'
    5:
      id: 'unknown_orig_order'
      doc: 'UnknownOrigOrder'
    6:
      id: 'orig_order_symbol_not_matching_request_symbol'
      doc: 'OrigOrderSymbolNotMatchingRequestSymbol'
    7:
      id: 'missing_locate'
      doc: 'MissingLocate'
    8:
      id: 'invalid_order_quantity'
      doc: 'InvalidOrderQuantity'
    9:
      id: 'invalid_symbol'
      doc: 'InvalidSymbol'
    10:
      id: 'invalid_limit_price'
      doc: 'InvalidLimitPrice'
    11:
      id: 'invalid_limit_price_increment'
      doc: 'InvalidLimitPriceIncrement'
    12:
      id: 'invalid_locate'
      doc: 'InvalidLocate'
    13:
      id: 'symbol_halted_or_paused'
      doc: 'SymbolHaltedOrPaused'
    14:
      id: 'exchange_closed'
      doc: 'ExchangeClosed'
    15:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    16:
      id: 'order_size_exceeds_limit'
      doc: 'OrderSizeExceedsLimit'
    17:
      id: 'exceeded_max_notional_order_amt'
      doc: 'ExceededMaxNotionalOrderAmt'
    18:
      id: 'unsupported_display_quantity_change'
      doc: 'UnsupportedDisplayQuantityChange'
    19:
      id: 'unsupported_ord_type_change'
      doc: 'UnsupportedOrdTypeChange'
    20:
      id: 'unsupported_side_change'
      doc: 'UnsupportedSideChange'
    21:
      id: 'unsupported_quantity_change'
      doc: 'UnsupportedQuantityChange'
    22:
      id: 'order_in_pending_state'
      doc: 'OrderInPendingState'
    23:
      id: 'block_session_risk_rule_violated'
      doc: 'BlockSessionRiskRuleViolated'
    24:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'BlockSellShortRiskRuleViolated'
    25:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'MaxSharesPerOrderRiskRuleBreach'
    26:
      id: 'no_nbbo_available'
      doc: 'NoNBBOAvailable'
    27:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'MaxNotionalValuePerOrderRiskRuleBreach'
    28:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'MaxADVPercentPerOrderRiskRuleBreach'
    29:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'PricePercentCollarRiskRuleViolated'
    30:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'PriceValueCollarRiskRuleViolated'
    31:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'HardToBorrowSecurityRiskRuleViolated'
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
    255:
      id: 'null_value'
      doc: 'NullValue'

