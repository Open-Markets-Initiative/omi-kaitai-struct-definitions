# ---------------------------------------------------------------------
# Kaitai struct definition for: Txse TxseEquities Seed Rake v1.0
#
# Protocol:
#   Organization: Texas Stock Exchange
#   Protocol: Session Enabled Entry Daemon
#   Encoding: RAKE Session and Framing Layer
#   Version: 1.0
#   Date: 6/12/2026
#   Specification: SEED.pdf
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
  id: txse_txseequities_seed_rake_v1_0
  title: Txse TxseEquities Seed Rake v1.0
  license: GPL-3.0
  endian: le

doc: 'Texas Stock Exchange Txse Equities Session Enabled Entry Daemon Rake v1.0'
doc-ref: https://www.txse.com

seq:
  - id: rake_tcp_message
    type: rake_tcp_message_struct
    repeat: eos
    doc: 'Rake Tcp Message'

types:
  rake_tcp_message_struct:
    seq:
      - id: rake_message_header
        type: rake_message_header
        doc: 'Rake Tcp per-message header carrying the frame length and packet-level dispatch byte'
      - id: payload
        size: rake_message_header.message_length + 2 - 3
        type:
          switch-on: rake_message_header.packet_type
          cases:
            'packet_type::logon_request_packet': logon_request_packet
            'packet_type::tcp_unsequenced_message': tcp_unsequenced_message
            'packet_type::debug_message': debug_message
            'packet_type::logon_response_message': logon_response_message
            'packet_type::tcp_sequenced_message': tcp_sequenced_message
  rake_message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of rake message not including this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
  logon_request_packet:
    seq:
      - id: session
        type: u8
        doc: 'The currently active trading session'
      - id: sender_comp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique id of the sender, assigned by exchange'
      - id: token
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Assigned by exchange'
      - id: next_sequence_number
        type: u8
        doc: '1-based numbering. Use 0 to skip currently stored messages; use 1 to replay all messages; otherwise send the next sequence number expected to receive from the Exchange to recover from a disconnection'
  tcp_unsequenced_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Higher-level protocol message type code identifying the payload that follows. Interpretation is protocol-specific'
      - id: unsequenced_message
        size: _parent.rake_message_header.message_length - 2
        type:
          switch-on: message_type
          cases:
            'message_type::limit_order_message': limit_order_message
            'message_type::market_order_message': market_order_message
            'message_type::cancel_order_message': cancel_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::replace_order_message': replace_order_message
            'message_type::mass_cancel_message': mass_cancel_message
  limit_order_message:
    seq:
      - id: limit_order_presence_bits
        type: limit_order_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: order_qty
        type: s4
        doc: 'Order quantity'
      - id: limit_order_bit_fields
        type: limit_order_bit_fields
        doc: 'Bitfield used in LimitOrder, LimitOrderAccepted, and LimitOrderRejected messages'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price. Implied decimal with scale 1e-8'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: limit_order_self_match_instruction
        type: s1
        enum: limit_order_self_match_instruction
        if: limit_order_presence_bits.has_limit_order_self_match_instruction == 1
        doc: 'Enum LimitOrderSelfMatchInstruction. Determines the behavior when orders from the same entity would match'
      - id: limit_order_price_slide_instruction
        type: s1
        enum: limit_order_price_slide_instruction
        if: limit_order_presence_bits.has_limit_order_price_slide_instruction == 1
        doc: 'Enum LimitOrderPriceSlideInstruction'
      - id: limit_order_min_qty
        type: s4
        if: limit_order_presence_bits.has_limit_order_min_qty == 1
        doc: 'Number of shares that must be executed to execute any shares'
      - id: limit_order_max_floor_qty
        type: s4
        if: limit_order_presence_bits.has_limit_order_max_floor_qty == 1
        doc: 'Quantity to be displayed at one time with remaining quantity not displayed on the book'
      - id: limit_order_max_replenish_qty_range
        type: s4
        if: limit_order_presence_bits.has_limit_order_max_replenish_qty_range == 1
        doc: 'Defines the maximum range to be used when calculating a random refresh quantity'
      - id: limit_order_max_replenish_time_range
        type: s8
        if: limit_order_presence_bits.has_limit_order_max_replenish_time_range == 1
        doc: 'Defines the maximum range to be used when calculating a random refresh time, in nanoseconds'
      - id: limit_order_reference_price_target
        type: s2
        if: limit_order_presence_bits.has_limit_order_reference_price_target == 1
        doc: 'The target relative to the reference base price in basis points of the NBBO spread'
      - id: limit_order_expire_time
        type: nanosecond_timestamp
        if: limit_order_presence_bits.has_limit_order_expire_time == 1
        doc: 'Timestamp at which the order''s open quantity will be canceled, valid only with GTT time in force. Nanoseconds since Unix epoch'
      - id: limit_order_user_data
        type: s8
        if: limit_order_presence_bits.has_limit_order_user_data == 1
        doc: 'Pass-through field for use by clients, not used by the Exchange'
      - id: limit_order_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_presence_bits.has_limit_order_mpid == 1
        doc: 'Market Participant Identifier. Upper-case alpha only'
      - id: limit_order_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_presence_bits.has_limit_order_member_group == 1
        doc: 'Member supplied grouping'
      - id: limit_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_presence_bits.has_limit_order_locate_broker == 1
        doc: 'Identifies the broker that has loaned the stock to settle the short sale'
  limit_order_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_limit_order_self_match_instruction
        type: b1
        doc: 'Set when limitOrderSelfMatchInstruction is present'
      - id: has_limit_order_price_slide_instruction
        type: b1
        doc: 'Set when limitOrderPriceSlideInstruction is present'
      - id: has_limit_order_min_qty
        type: b1
        doc: 'Set when limitOrderMinQty is present'
      - id: has_limit_order_max_floor_qty
        type: b1
        doc: 'Set when limitOrderMaxFloorQty is present'
      - id: has_limit_order_max_replenish_qty_range
        type: b1
        doc: 'Set when limitOrderMaxReplenishQtyRange is present'
      - id: has_limit_order_max_replenish_time_range
        type: b1
        doc: 'Set when limitOrderMaxReplenishTimeRange is present'
      - id: has_limit_order_reference_price_target
        type: b1
        doc: 'Set when limitOrderReferencePriceTarget is present'
      - id: has_limit_order_expire_time
        type: b1
        doc: 'Set when limitOrderExpireTime is present'
      - id: has_limit_order_user_data
        type: b1
        doc: 'Set when limitOrderUserData is present'
      - id: has_limit_order_mpid
        type: b1
        doc: 'Set when limitOrderMpid is present'
      - id: has_limit_order_member_group
        type: b1
        doc: 'Set when limitOrderMemberGroup is present'
      - id: has_limit_order_locate_broker
        type: b1
        doc: 'Set when limitOrderLocateBroker is present'
      - id: reserved_19
        type: b19
        doc: 'Reserved for future use'
  limit_order_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: time_in_force
        type: b4
        doc: 'Enum TimeInForce'
      - id: order_capacity
        type: b3
        doc: 'Enum OrderCapacity'
      - id: is_iso
        type: b1
        doc: 'True for Reg NMS Intermarket sweep orders, false otherwise'
      - id: is_hidden
        type: b1
        doc: 'True if any of the order quantity is hidden, false for order quantity to be displayed'
      - id: is_post_only
        type: b1
        doc: 'True to only add the order to the book if it would be added as a resting order with no quantity executed'
      - id: cancel_at_entry_if_crossed
        type: b1
        doc: 'True to cancel the order at entry if market conditions are crossed'
      - id: reserved_17
        type: b17
        doc: 'Reserved for the future'
  market_order_message:
    seq:
      - id: market_order_presence_bits
        type: market_order_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: order_qty
        type: s4
        doc: 'Order quantity'
      - id: market_order_bit_fields
        type: market_order_bit_fields
        doc: 'Bitfield used in MarketOrder, MarketOrderAccepted, and MarketOrderRejected messages'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: market_order_self_match_instruction
        type: s1
        enum: market_order_self_match_instruction
        if: market_order_presence_bits.has_market_order_self_match_instruction == 1
        doc: 'Enum MarketOrderSelfMatchInstruction'
      - id: market_order_user_data
        type: s8
        if: market_order_presence_bits.has_market_order_user_data == 1
        doc: 'Pass-through field for use by clients, not used by the Exchange'
      - id: market_order_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_presence_bits.has_market_order_mpid == 1
        doc: 'Market Participant Identifier'
      - id: market_order_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: market_order_presence_bits.has_market_order_member_group == 1
        doc: 'Member supplied grouping'
      - id: market_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_presence_bits.has_market_order_locate_broker == 1
        doc: 'Identifies the broker that has loaned the stock to settle the short sale'
  market_order_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_market_order_self_match_instruction
        type: b1
        doc: 'Set when marketOrderSelfMatchInstruction is present'
      - id: has_market_order_user_data
        type: b1
        doc: 'Set when marketOrderUserData is present'
      - id: has_market_order_mpid
        type: b1
        doc: 'Set when marketOrderMpid is present'
      - id: has_market_order_member_group
        type: b1
        doc: 'Set when marketOrderMemberGroup is present'
      - id: has_market_order_locate_broker
        type: b1
        doc: 'Set when marketOrderLocateBroker is present'
      - id: reserved_10
        type: b10
        doc: 'Reserved for future use'
  market_order_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: time_in_force
        type: b4
        doc: 'Enum TimeInForce'
      - id: order_capacity
        type: b3
        doc: 'Enum OrderCapacity'
      - id: reserved_5
        type: b5
        doc: 'Reserved for the future'
  cancel_order_message:
    seq:
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
  modify_order_message:
    seq:
      - id: modify_order_presence_bits
        type: modify_order_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: modify_order_order_qty
        type: s4
        if: modify_order_presence_bits.has_modify_order_order_qty == 1
        doc: 'Quantity can remain the same or decrease. Quantity cannot increase'
      - id: modify_order_bit_fields
        type: modify_order_bit_fields
        doc: 'Bitfield used in ModifyOrder, OrderModified, and ModifyRejected messages'
      - id: modify_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: modify_order_presence_bits.has_modify_order_locate_broker == 1
        doc: 'Identifies the broker that has loaned the stock to settle the short sale'
  modify_order_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_modify_order_order_qty
        type: b1
        doc: 'Set when modifyOrderOrderQty is present'
      - id: has_modify_order_bit_fields
        type: b1
        doc: 'Set when modifyOrderBitFields is present'
      - id: has_modify_order_locate_broker
        type: b1
        doc: 'Set when modifyOrderLocateBroker is present'
      - id: reserved_5
        type: b5
        doc: 'Reserved for the future'
  modify_order_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: reserved_4
        type: b4
        doc: 'Reserved for the future'
  replace_order_message:
    seq:
      - id: replace_order_presence_bits
        type: replace_order_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: replace_order_bit_fields
        type: replace_order_bit_fields
        doc: 'Bitfield used in ReplaceOrder, OrderReplaced, and ReplaceRejected messages'
      - id: replace_order_price
        type: decimal_s8_8
        if: replace_order_presence_bits.has_replace_order_price == 1
        doc: 'New limit price. Implied decimal with scale 1e-8'
      - id: replace_order_order_qty
        type: s4
        if: replace_order_presence_bits.has_replace_order_order_qty == 1
        doc: 'Quantity can remain the same, decrease or increase'
      - id: replace_order_max_floor_qty
        type: s4
        if: replace_order_presence_bits.has_replace_order_max_floor_qty == 1
        doc: 'Quantity to be displayed at one time with remaining quantity not displayed on the book'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: replace_order_self_match_instruction
        type: s1
        enum: replace_order_self_match_instruction
        if: replace_order_presence_bits.has_replace_order_self_match_instruction == 1
        doc: 'Enum ReplaceOrderSelfMatchInstruction'
      - id: replace_order_price_slide_instruction
        type: s1
        enum: replace_order_price_slide_instruction
        if: replace_order_presence_bits.has_replace_order_price_slide_instruction == 1
        doc: 'Enum ReplaceOrderPriceSlideInstruction'
      - id: replace_order_reference_price_target
        type: s2
        if: replace_order_presence_bits.has_replace_order_reference_price_target == 1
        doc: 'The target relative to the reference base price in basis points of the NBBO spread'
      - id: replace_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: replace_order_presence_bits.has_replace_order_locate_broker == 1
        doc: 'Identifies the broker that has loaned the stock to settle the short sale'
  replace_order_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_replace_order_price
        type: b1
        doc: 'Set when replaceOrderPrice is present'
      - id: has_replace_order_order_qty
        type: b1
        doc: 'Set when replaceOrderOrderQty is present'
      - id: has_replace_order_max_floor_qty
        type: b1
        doc: 'Set when replaceOrderMaxFloorQty is present'
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_replace_order_self_match_instruction
        type: b1
        doc: 'Set when replaceOrderSelfMatchInstruction is present'
      - id: has_replace_order_price_slide_instruction
        type: b1
        doc: 'Set when replaceOrderPriceSlideInstruction is present'
      - id: has_replace_order_reference_price_target
        type: b1
        doc: 'Set when replaceOrderReferencePriceTarget is present'
      - id: has_replace_order_locate_broker
        type: b1
        doc: 'Set when replaceOrderLocateBroker is present'
      - id: reserved_8
        type: b8
        doc: 'Reserved for future use'
  replace_order_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: is_iso
        type: b1
        doc: 'True for Reg NMS Intermarket sweep orders, false otherwise'
      - id: is_post_only
        type: b1
        doc: 'True to only add the order to the book if it would be added as a resting order with no quantity executed'
      - id: cancel_at_entry_if_crossed
        type: b1
        doc: 'True to cancel the order at entry if market conditions are crossed'
      - id: reserved_9
        type: b9
        doc: 'Reserved for future use'
  mass_cancel_message:
    seq:
      - id: mass_cancel_presence_bits
        type: mass_cancel_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: mass_cancel_request_id
        type: s8
        doc: 'Unique identifier assigned by the Member for this mass cancel request'
      - id: mass_cancel_scope
        type: s1
        enum: mass_cancel_scope
        doc: 'Enum MassCancelScope'
      - id: mass_cancel_bit_fields
        type: mass_cancel_bit_fields
        doc: 'Bitfield used in MassCancel, MassCancelAccepted, and MassCancelRejected messages'
      - id: mass_cancel_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_presence_bits.has_mass_cancel_mpid == 1
        doc: 'Market Participant Identifier'
      - id: mass_cancel_sender_comp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_presence_bits.has_mass_cancel_sender_comp == 1
        doc: 'Narrows the cancel to orders entered on the specified order entry port (SenderComp)'
      - id: mass_cancel_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_presence_bits.has_mass_cancel_member_group == 1
        doc: 'Member supplied grouping'
      - id: mass_cancel_cl_ord_id
        type: s8
        if: mass_cancel_presence_bits.has_mass_cancel_cl_ord_id == 1
        doc: 'Scopes the mass cancel to this specific order. SenderComp is required when ClOrdId is supplied'
  mass_cancel_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_mass_cancel_mpid
        type: b1
        doc: 'Set when massCancelMpid is present'
      - id: has_mass_cancel_sender_comp
        type: b1
        doc: 'Set when massCancelSenderComp is present'
      - id: has_mass_cancel_member_group
        type: b1
        doc: 'Set when massCancelMemberGroup is present'
      - id: has_mass_cancel_cl_ord_id
        type: b1
        doc: 'Set when massCancelClOrdId is present'
      - id: reserved_4
        type: b4
        doc: 'Reserved for the future'
  mass_cancel_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: exclude_auction_orders
        type: b1
        doc: 'When set, auction orders are excluded from the mass cancel scope'
      - id: reserved_7
        type: b7
        doc: 'Reserved for future use'
  debug_message:
    seq:
      - id: text
        type: str
        size: _parent.rake_message_header.message_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
  logon_response_message:
    seq:
      - id: session
        type: u8
        doc: 'The currently active trading session'
      - id: next_sequence_number
        type: u8
        doc: '1-based numbering. Use 0 to skip currently stored messages; use 1 to replay all messages; otherwise send the next sequence number expected to receive from the Exchange to recover from a disconnection'
      - id: highest_known_sequence_number
        type: u8
        doc: 'The highest sequence number the server knows at the time of logon'
      - id: logon_response_code
        type: u1
        enum: logon_response_code
        doc: 'Success or failure code from a Logon Request'
      - id: number_stream_ids
        type: u1
        doc: 'The total number of stream ids that will be used in this trading session'
      - id: instance
        type: u4
        doc: 'Informational only. A unique ID for this RAKE server instance. Differs between primary and backup; a change on successive intra-day connections indicates the server has been restarted'
  tcp_sequenced_message:
    seq:
      - id: stream_id
        type: u1
        doc: 'The internal exchange stream id that created this message'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Higher-level protocol message type code identifying the payload that follows. Interpretation is protocol-specific'
      - id: sequenced_message
        size: _parent.rake_message_header.message_length - 3
        type:
          switch-on: message_type
          cases:
            'message_type::trading_session_status_message': trading_session_status_message
            'message_type::define_symbol_message': define_symbol_message
            'message_type::symbol_status_message': symbol_status_message
            'message_type::limit_order_accepted_message': limit_order_accepted_message
            'message_type::limit_order_rejected_message': limit_order_rejected_message
            'message_type::market_order_accepted_message': market_order_accepted_message
            'message_type::market_order_rejected_message': market_order_rejected_message
            'message_type::order_canceled_message': order_canceled_message
            'message_type::cancel_rejected_message': cancel_rejected_message
            'message_type::order_modified_message': order_modified_message
            'message_type::modify_rejected_message': modify_rejected_message
            'message_type::order_replaced_message': order_replaced_message
            'message_type::replace_rejected_message': replace_rejected_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_restated_message': order_restated_message
            'message_type::self_match_prevented_message': self_match_prevented_message
            'message_type::mass_cancel_accepted_message': mass_cancel_accepted_message
            'message_type::mass_cancel_rejected_message': mass_cancel_rejected_message
            'message_type::mass_cancel_result_message': mass_cancel_result_message
  trading_session_status_message:
    seq:
      - id: trading_session_status_presence_bits
        type: trading_session_status_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: market_hours_state
        type: s1
        enum: market_hours_state
        doc: 'Enum MarketHoursState'
      - id: session_trading_state
        type: s1
        enum: session_trading_state
        doc: 'Enum SessionTradingState'
      - id: trading_session_status_operational_halt_reason
        type: s1
        enum: trading_session_status_operational_halt_reason
        if: trading_session_status_presence_bits.has_trading_session_status_operational_halt_reason == 1
        doc: 'Enum TradingSessionStatusOperationalHaltReason'
      - id: trading_session_status_regulatory_halt_reason
        type: s1
        enum: trading_session_status_regulatory_halt_reason
        if: trading_session_status_presence_bits.has_trading_session_status_regulatory_halt_reason == 1
        doc: 'Enum TradingSessionStatusRegulatoryHaltReason'
  trading_session_status_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_trading_session_status_operational_halt_reason
        type: b1
        doc: 'Set when tradingSessionStatusOperationalHaltReason is present'
      - id: has_trading_session_status_regulatory_halt_reason
        type: b1
        doc: 'Set when tradingSessionStatusRegulatoryHaltReason is present'
      - id: reserved_6
        type: b6
        doc: 'Reserved for future use'
  define_symbol_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier root represented in CMS format'
      - id: suffix
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier suffix represented in CMS format'
      - id: matching_engine_id
        type: s1
        doc: 'The matching engine to which this symbol is assigned for the trading session'
      - id: define_symbol_bit_fields
        type: define_symbol_bit_fields
        doc: 'Bitfield used in DefineSymbol message'
      - id: lot_size
        type: s4
        doc: 'The number of shares constituting one round lot'
      - id: listing_market
        type: s1
        enum: listing_market
        doc: 'Enum ListingMarket'
  define_symbol_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: is_test
        type: b1
        doc: 'Test symbol flag'
      - id: reserved_7
        type: b7
        doc: 'Reserved for future use'
  symbol_status_message:
    seq:
      - id: symbol_status_presence_bits
        type: symbol_status_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: symbol_trading_state
        type: s1
        enum: symbol_trading_state
        doc: 'Enum SymbolTradingState'
      - id: short_sale_restriction_state
        type: s1
        enum: short_sale_restriction_state
        doc: 'Enum ShortSaleRestrictionState'
      - id: symbol_status_operational_halt_reason
        type: s1
        enum: symbol_status_operational_halt_reason
        if: symbol_status_presence_bits.has_symbol_status_operational_halt_reason == 1
        doc: 'Enum SymbolStatusOperationalHaltReason'
      - id: symbol_status_regulatory_halt_reason
        type: s1
        enum: symbol_status_regulatory_halt_reason
        if: symbol_status_presence_bits.has_symbol_status_regulatory_halt_reason == 1
        doc: 'Enum SymbolStatusRegulatoryHaltReason'
  symbol_status_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_symbol_status_operational_halt_reason
        type: b1
        doc: 'Set when symbolStatusOperationalHaltReason is present'
      - id: has_symbol_status_regulatory_halt_reason
        type: b1
        doc: 'Set when symbolStatusRegulatoryHaltReason is present'
      - id: reserved_6
        type: b6
        doc: 'Reserved for future use'
  limit_order_accepted_message:
    seq:
      - id: limit_order_accepted_presence_bits
        type: limit_order_accepted_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: order_qty
        type: s4
        doc: 'Order quantity'
      - id: limit_order_accepted_bit_fields
        type: limit_order_accepted_bit_fields
        doc: 'Bitfield used in LimitOrder, LimitOrderAccepted, and LimitOrderRejected messages'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price. Implied decimal with scale 1e-8'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: limit_order_accepted_self_match_instruction
        type: s1
        enum: limit_order_accepted_self_match_instruction
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_self_match_instruction == 1
        doc: 'Enum LimitOrderAcceptedSelfMatchInstruction'
      - id: limit_order_accepted_price_slide_instruction
        type: s1
        enum: limit_order_accepted_price_slide_instruction
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_price_slide_instruction == 1
        doc: 'Enum LimitOrderAcceptedPriceSlideInstruction'
      - id: limit_order_accepted_min_qty
        type: s4
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_min_qty == 1
        doc: 'Number of shares that must be executed to execute any shares'
      - id: limit_order_accepted_max_floor_qty
        type: s4
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_max_floor_qty == 1
        doc: 'Quantity to be displayed at one time with remaining quantity not displayed on the book'
      - id: limit_order_accepted_max_replenish_qty_range
        type: s4
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_max_replenish_qty_range == 1
        doc: 'Defines the maximum range to be used when calculating a random refresh quantity'
      - id: limit_order_accepted_max_replenish_time_range
        type: s8
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_max_replenish_time_range == 1
        doc: 'Defines the maximum range to be used when calculating a random refresh time, in nanoseconds'
      - id: limit_order_accepted_reference_price_target
        type: s2
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_reference_price_target == 1
        doc: 'The target relative to the reference base price in basis points of the NBBO spread'
      - id: limit_order_accepted_expire_time
        type: nanosecond_timestamp
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_expire_time == 1
        doc: 'Timestamp at which the order''s open quantity will be canceled, valid only with GTT time in force. Nanoseconds since Unix epoch'
      - id: limit_order_accepted_user_data
        type: s8
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_user_data == 1
        doc: 'Pass-through field for use by clients, not used by the Exchange'
      - id: limit_order_accepted_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_mpid == 1
        doc: 'Market Participant Identifier'
      - id: limit_order_accepted_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_member_group == 1
        doc: 'Member supplied grouping'
      - id: limit_order_accepted_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_locate_broker == 1
        doc: 'Identifies the broker that has loaned the stock to settle the short sale'
      - id: limit_order_accepted_rank_price
        type: decimal_s8_8
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_rank_price == 1
        doc: 'Optional rank price, when different from limit price. Implied decimal with scale 1e-8'
      - id: limit_order_accepted_display_price
        type: decimal_s8_8
        if: limit_order_accepted_presence_bits.has_limit_order_accepted_display_price == 1
        doc: 'Optional display price, when different from limit price. Implied decimal with scale 1e-8'
  limit_order_accepted_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_limit_order_accepted_self_match_scope
        type: b1
        doc: 'Set when limitOrderAcceptedSelfMatchScope is present'
      - id: has_limit_order_accepted_self_match_instruction
        type: b1
        doc: 'Set when limitOrderAcceptedSelfMatchInstruction is present'
      - id: has_limit_order_accepted_price_slide_instruction
        type: b1
        doc: 'Set when limitOrderAcceptedPriceSlideInstruction is present'
      - id: has_limit_order_accepted_min_qty
        type: b1
        doc: 'Set when limitOrderAcceptedMinQty is present'
      - id: has_limit_order_accepted_max_floor_qty
        type: b1
        doc: 'Set when limitOrderAcceptedMaxFloorQty is present'
      - id: has_limit_order_accepted_max_replenish_qty_range
        type: b1
        doc: 'Set when limitOrderAcceptedMaxReplenishQtyRange is present'
      - id: has_limit_order_accepted_max_replenish_time_range
        type: b1
        doc: 'Set when limitOrderAcceptedMaxReplenishTimeRange is present'
      - id: has_limit_order_accepted_reference_price_target
        type: b1
        doc: 'Set when limitOrderAcceptedReferencePriceTarget is present'
      - id: has_limit_order_accepted_expire_time
        type: b1
        doc: 'Set when limitOrderAcceptedExpireTime is present'
      - id: has_limit_order_accepted_user_data
        type: b1
        doc: 'Set when limitOrderAcceptedUserData is present'
      - id: has_limit_order_accepted_mpid
        type: b1
        doc: 'Set when limitOrderAcceptedMpid is present'
      - id: has_limit_order_accepted_member_group
        type: b1
        doc: 'Set when limitOrderAcceptedMemberGroup is present'
      - id: has_limit_order_accepted_locate_broker
        type: b1
        doc: 'Set when limitOrderAcceptedLocateBroker is present'
      - id: has_limit_order_accepted_rank_price
        type: b1
        doc: 'Set when limitOrderAcceptedRankPrice is present'
      - id: has_limit_order_accepted_display_price
        type: b1
        doc: 'Set when limitOrderAcceptedDisplayPrice is present'
      - id: reserved_17
        type: b17
        doc: 'Reserved for the future'
  limit_order_accepted_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: time_in_force
        type: b4
        doc: 'Enum TimeInForce'
      - id: order_capacity
        type: b3
        doc: 'Enum OrderCapacity'
      - id: is_iso
        type: b1
        doc: 'True for Reg NMS Intermarket sweep orders, false otherwise'
      - id: is_hidden
        type: b1
        doc: 'True if any of the order quantity is hidden, false for order quantity to be displayed'
      - id: is_post_only
        type: b1
        doc: 'True to only add the order to the book if it would be added as a resting order with no quantity executed'
      - id: cancel_at_entry_if_crossed
        type: b1
        doc: 'True to cancel the order at entry if market conditions are crossed'
      - id: reserved_17
        type: b17
        doc: 'Reserved for the future'
  limit_order_rejected_message:
    seq:
      - id: limit_order_rejected_presence_bits
        type: limit_order_rejected_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: order_qty
        type: s4
        doc: 'Order quantity'
      - id: limit_order_rejected_bit_fields
        type: limit_order_rejected_bit_fields
        doc: 'Bitfield used in LimitOrder, LimitOrderAccepted, and LimitOrderRejected messages'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price. Implied decimal with scale 1e-8'
      - id: limit_order_rejected_reason
        type: s1
        enum: limit_order_rejected_reason
        doc: 'Enum LimitOrderRejectedReason'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: limit_order_rejected_self_match_instruction
        type: s1
        enum: limit_order_rejected_self_match_instruction
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_self_match_instruction == 1
        doc: 'Enum LimitOrderRejectedSelfMatchInstruction'
      - id: limit_order_rejected_price_slide_instruction
        type: s1
        enum: limit_order_rejected_price_slide_instruction
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_price_slide_instruction == 1
        doc: 'Enum LimitOrderRejectedPriceSlideInstruction'
      - id: limit_order_rejected_min_qty
        type: s4
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_min_qty == 1
        doc: 'Minimum quantity to execute'
      - id: limit_order_rejected_max_floor_qty
        type: s4
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_max_floor_qty == 1
        doc: 'Quantity to be displayed at one time'
      - id: limit_order_rejected_max_replenish_qty_range
        type: s4
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_max_replenish_qty_range == 1
        doc: 'Maximum range for random refresh quantity'
      - id: limit_order_rejected_max_replenish_time_range
        type: s8
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_max_replenish_time_range == 1
        doc: 'Maximum range for random refresh time'
      - id: limit_order_rejected_reference_price_target
        type: s2
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_reference_price_target == 1
        doc: 'Basis points relative to the NBBO spread'
      - id: limit_order_rejected_expire_time
        type: nanosecond_timestamp
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_expire_time == 1
        doc: 'Timestamp at which the order will be canceled. Nanoseconds since Unix epoch'
      - id: limit_order_rejected_user_data
        type: s8
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_user_data == 1
        doc: 'Pass-through field'
      - id: limit_order_rejected_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_mpid == 1
        doc: 'Market Participant Identifier'
      - id: limit_order_rejected_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_member_group == 1
        doc: 'Member supplied grouping'
      - id: limit_order_rejected_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_rejected_presence_bits.has_limit_order_rejected_locate_broker == 1
        doc: 'Locate broker'
  limit_order_rejected_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_limit_order_rejected_self_match_instruction
        type: b1
        doc: 'Set when limitOrderRejectedSelfMatchInstruction is present'
      - id: has_limit_order_rejected_price_slide_instruction
        type: b1
        doc: 'Set when limitOrderRejectedPriceSlideInstruction is present'
      - id: has_limit_order_rejected_min_qty
        type: b1
        doc: 'Set when limitOrderRejectedMinQty is present'
      - id: has_limit_order_rejected_max_floor_qty
        type: b1
        doc: 'Set when limitOrderRejectedMaxFloorQty is present'
      - id: has_limit_order_rejected_max_replenish_qty_range
        type: b1
        doc: 'Set when limitOrderRejectedMaxReplenishQtyRange is present'
      - id: has_limit_order_rejected_max_replenish_time_range
        type: b1
        doc: 'Set when limitOrderRejectedMaxReplenishTimeRange is present'
      - id: has_limit_order_rejected_reference_price_target
        type: b1
        doc: 'Set when limitOrderRejectedReferencePriceTarget is present'
      - id: has_limit_order_rejected_expire_time
        type: b1
        doc: 'Set when limitOrderRejectedExpireTime is present'
      - id: has_limit_order_rejected_user_data
        type: b1
        doc: 'Set when limitOrderRejectedUserData is present'
      - id: has_limit_order_rejected_mpid
        type: b1
        doc: 'Set when limitOrderRejectedMpid is present'
      - id: has_limit_order_rejected_member_group
        type: b1
        doc: 'Set when limitOrderRejectedMemberGroup is present'
      - id: has_limit_order_rejected_locate_broker
        type: b1
        doc: 'Set when limitOrderRejectedLocateBroker is present'
      - id: reserved_19
        type: b19
        doc: 'Reserved for future use'
  limit_order_rejected_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: time_in_force
        type: b4
        doc: 'Enum TimeInForce'
      - id: order_capacity
        type: b3
        doc: 'Enum OrderCapacity'
      - id: is_iso
        type: b1
        doc: 'True for Reg NMS Intermarket sweep orders, false otherwise'
      - id: is_hidden
        type: b1
        doc: 'True if any of the order quantity is hidden, false for order quantity to be displayed'
      - id: is_post_only
        type: b1
        doc: 'True to only add the order to the book if it would be added as a resting order with no quantity executed'
      - id: cancel_at_entry_if_crossed
        type: b1
        doc: 'True to cancel the order at entry if market conditions are crossed'
      - id: reserved_17
        type: b17
        doc: 'Reserved for the future'
  market_order_accepted_message:
    seq:
      - id: market_order_accepted_presence_bits
        type: market_order_accepted_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: order_qty
        type: s4
        doc: 'Order quantity'
      - id: market_order_accepted_bit_fields
        type: market_order_accepted_bit_fields
        doc: 'Bitfield used in MarketOrder, MarketOrderAccepted, and MarketOrderRejected messages'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: market_order_accepted_self_match_instruction
        type: s1
        enum: market_order_accepted_self_match_instruction
        if: market_order_accepted_presence_bits.has_market_order_accepted_self_match_instruction == 1
        doc: 'Enum MarketOrderAcceptedSelfMatchInstruction'
      - id: market_order_accepted_user_data
        type: s8
        if: market_order_accepted_presence_bits.has_market_order_accepted_user_data == 1
        doc: 'Pass-through field'
      - id: market_order_accepted_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_accepted_presence_bits.has_market_order_accepted_mpid == 1
        doc: 'Market Participant Identifier'
      - id: market_order_accepted_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: market_order_accepted_presence_bits.has_market_order_accepted_member_group == 1
        doc: 'Member supplied grouping'
      - id: market_order_accepted_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_accepted_presence_bits.has_market_order_accepted_locate_broker == 1
        doc: 'Locate broker'
  market_order_accepted_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_market_order_accepted_self_match_instruction
        type: b1
        doc: 'Set when marketOrderAcceptedSelfMatchInstruction is present'
      - id: has_market_order_accepted_user_data
        type: b1
        doc: 'Set when marketOrderAcceptedUserData is present'
      - id: has_market_order_accepted_mpid
        type: b1
        doc: 'Set when marketOrderAcceptedMpid is present'
      - id: has_market_order_accepted_member_group
        type: b1
        doc: 'Set when marketOrderAcceptedMemberGroup is present'
      - id: has_market_order_accepted_locate_broker
        type: b1
        doc: 'Set when marketOrderAcceptedLocateBroker is present'
      - id: reserved_10
        type: b10
        doc: 'Reserved for future use'
  market_order_accepted_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: time_in_force
        type: b4
        doc: 'Enum TimeInForce'
      - id: order_capacity
        type: b3
        doc: 'Enum OrderCapacity'
      - id: reserved_5
        type: b5
        doc: 'Reserved for the future'
  market_order_rejected_message:
    seq:
      - id: market_order_rejected_presence_bits
        type: market_order_rejected_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: order_qty
        type: s4
        doc: 'Order quantity'
      - id: market_order_rejected_bit_fields
        type: market_order_rejected_bit_fields
        doc: 'Bitfield used in MarketOrder, MarketOrderAccepted, and MarketOrderRejected messages'
      - id: symbol_id
        type: s2
        doc: 'Symbol identifier'
      - id: market_order_rejected_reason
        type: s1
        enum: market_order_rejected_reason
        doc: 'Enum MarketOrderRejectedReason'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: market_order_rejected_self_match_instruction
        type: s1
        enum: market_order_rejected_self_match_instruction
        if: market_order_rejected_presence_bits.has_market_order_rejected_self_match_instruction == 1
        doc: 'Enum MarketOrderRejectedSelfMatchInstruction'
      - id: market_order_rejected_user_data
        type: s8
        if: market_order_rejected_presence_bits.has_market_order_rejected_user_data == 1
        doc: 'Pass-through field'
      - id: market_order_rejected_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_rejected_presence_bits.has_market_order_rejected_mpid == 1
        doc: 'Market Participant Identifier'
      - id: market_order_rejected_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: market_order_rejected_presence_bits.has_market_order_rejected_member_group == 1
        doc: 'Member supplied grouping'
      - id: market_order_rejected_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_rejected_presence_bits.has_market_order_rejected_locate_broker == 1
        doc: 'Locate broker'
  market_order_rejected_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_market_order_rejected_self_match_instruction
        type: b1
        doc: 'Set when marketOrderRejectedSelfMatchInstruction is present'
      - id: has_market_order_rejected_user_data
        type: b1
        doc: 'Set when marketOrderRejectedUserData is present'
      - id: has_market_order_rejected_mpid
        type: b1
        doc: 'Set when marketOrderRejectedMpid is present'
      - id: has_market_order_rejected_member_group
        type: b1
        doc: 'Set when marketOrderRejectedMemberGroup is present'
      - id: has_market_order_rejected_locate_broker
        type: b1
        doc: 'Set when marketOrderRejectedLocateBroker is present'
      - id: reserved_10
        type: b10
        doc: 'Reserved for future use'
  market_order_rejected_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: time_in_force
        type: b4
        doc: 'Enum TimeInForce'
      - id: order_capacity
        type: b3
        doc: 'Enum OrderCapacity'
      - id: reserved_5
        type: b5
        doc: 'Reserved for the future'
  order_canceled_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: cancel_reason
        type: s1
        enum: cancel_reason
        doc: 'Enum CancelReason'
  cancel_rejected_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: cancel_rejected_reason
        type: s1
        enum: cancel_rejected_reason
        doc: 'Enum CancelRejectedReason'
  order_modified_message:
    seq:
      - id: order_modified_presence_bits
        type: order_modified_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: leaves_qty
        type: s4
        doc: 'Number of shares that were still available to execute after the modify'
      - id: order_modified_order_qty
        type: s4
        if: order_modified_presence_bits.has_order_modified_order_qty == 1
        doc: 'Quantity can remain the same or decrease'
      - id: order_modified_bit_fields
        type: order_modified_bit_fields
        doc: 'Bitfield used in ModifyOrder, OrderModified, and ModifyRejected messages'
      - id: order_modified_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: order_modified_presence_bits.has_order_modified_locate_broker == 1
        doc: 'Locate broker'
  order_modified_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_order_modified_order_qty
        type: b1
        doc: 'Set when orderModifiedOrderQty is present'
      - id: has_order_modified_bit_fields
        type: b1
        doc: 'Set when orderModifiedBitFields is present'
      - id: has_order_modified_locate_broker
        type: b1
        doc: 'Set when orderModifiedLocateBroker is present'
      - id: reserved_5
        type: b5
        doc: 'Reserved for the future'
  order_modified_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: reserved_4
        type: b4
        doc: 'Reserved for the future'
  modify_rejected_message:
    seq:
      - id: modify_rejected_presence_bits
        type: modify_rejected_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: modify_rejected_reason
        type: s1
        enum: modify_rejected_reason
        doc: 'Enum ModifyRejectedReason'
      - id: modify_rejected_order_qty
        type: s4
        if: modify_rejected_presence_bits.has_modify_rejected_order_qty == 1
        doc: 'Quantity can remain the same or decrease'
      - id: modify_rejected_bit_fields
        type: modify_rejected_bit_fields
        doc: 'Bitfield used in ModifyOrder, OrderModified, and ModifyRejected messages'
      - id: modify_rejected_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: modify_rejected_presence_bits.has_modify_rejected_locate_broker == 1
        doc: 'Locate broker'
  modify_rejected_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_modify_rejected_order_qty
        type: b1
        doc: 'Set when modifyRejectedOrderQty is present'
      - id: has_modify_rejected_bit_fields
        type: b1
        doc: 'Set when modifyRejectedBitFields is present'
      - id: has_modify_rejected_locate_broker
        type: b1
        doc: 'Set when modifyRejectedLocateBroker is present'
      - id: reserved_5
        type: b5
        doc: 'Reserved for the future'
  modify_rejected_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: reserved_4
        type: b4
        doc: 'Reserved for the future'
  order_replaced_message:
    seq:
      - id: order_replaced_presence_bits
        type: order_replaced_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: order_replaced_bit_fields
        type: order_replaced_bit_fields
        doc: 'Bitfield used in ReplaceOrder, OrderReplaced, and ReplaceRejected messages'
      - id: leaves_qty
        type: s4
        doc: 'Number of shares that were still available to execute after the modify'
      - id: order_replaced_price
        type: decimal_s8_8
        if: order_replaced_presence_bits.has_order_replaced_price == 1
        doc: 'New limit price. Implied decimal with scale 1e-8'
      - id: order_replaced_order_qty
        type: s4
        if: order_replaced_presence_bits.has_order_replaced_order_qty == 1
        doc: 'Quantity can remain the same, decrease or increase'
      - id: order_replaced_max_floor_qty
        type: s4
        if: order_replaced_presence_bits.has_order_replaced_max_floor_qty == 1
        doc: 'Quantity to be displayed at one time'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: order_replaced_self_match_instruction
        type: s1
        enum: order_replaced_self_match_instruction
        if: order_replaced_presence_bits.has_order_replaced_self_match_instruction == 1
        doc: 'Enum OrderReplacedSelfMatchInstruction'
      - id: order_replaced_price_slide_instruction
        type: s1
        enum: order_replaced_price_slide_instruction
        if: order_replaced_presence_bits.has_order_replaced_price_slide_instruction == 1
        doc: 'Enum OrderReplacedPriceSlideInstruction'
      - id: order_replaced_reference_price_target
        type: s2
        if: order_replaced_presence_bits.has_order_replaced_reference_price_target == 1
        doc: 'Basis points relative to the NBBO spread'
      - id: order_replaced_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: order_replaced_presence_bits.has_order_replaced_locate_broker == 1
        doc: 'Locate broker'
      - id: order_replaced_rank_price
        type: decimal_s8_8
        if: order_replaced_presence_bits.has_order_replaced_rank_price == 1
        doc: 'Optional rank price, when different from limit price. Implied decimal with scale 1e-8'
      - id: order_replaced_display_price
        type: decimal_s8_8
        if: order_replaced_presence_bits.has_order_replaced_display_price == 1
        doc: 'Optional display price, when different from limit price. Implied decimal with scale 1e-8'
  order_replaced_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_order_replaced_price
        type: b1
        doc: 'Set when orderReplacedPrice is present'
      - id: has_order_replaced_order_qty
        type: b1
        doc: 'Set when orderReplacedOrderQty is present'
      - id: has_order_replaced_max_floor_qty
        type: b1
        doc: 'Set when orderReplacedMaxFloorQty is present'
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_order_replaced_self_match_instruction
        type: b1
        doc: 'Set when orderReplacedSelfMatchInstruction is present'
      - id: has_order_replaced_price_slide_instruction
        type: b1
        doc: 'Set when orderReplacedPriceSlideInstruction is present'
      - id: has_order_replaced_reference_price_target
        type: b1
        doc: 'Set when orderReplacedReferencePriceTarget is present'
      - id: has_order_replaced_locate_broker
        type: b1
        doc: 'Set when orderReplacedLocateBroker is present'
      - id: has_order_replaced_rank_price
        type: b1
        doc: 'Set when orderReplacedRankPrice is present'
      - id: has_order_replaced_display_price
        type: b1
        doc: 'Set when orderReplacedDisplayPrice is present'
      - id: reserved_6
        type: b6
        doc: 'Reserved for future use'
  order_replaced_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: is_iso
        type: b1
        doc: 'True for Reg NMS Intermarket sweep orders, false otherwise'
      - id: is_post_only
        type: b1
        doc: 'True to only add the order to the book if it would be added as a resting order with no quantity executed'
      - id: cancel_at_entry_if_crossed
        type: b1
        doc: 'True to cancel the order at entry if market conditions are crossed'
      - id: reserved_9
        type: b9
        doc: 'Reserved for future use'
  replace_rejected_message:
    seq:
      - id: replace_rejected_presence_bits
        type: replace_rejected_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: orig_cl_ord_id
        type: s8
        doc: 'The ClOrdId of the order to be canceled'
      - id: replace_rejected_bit_fields
        type: replace_rejected_bit_fields
        doc: 'Bitfield used in ReplaceOrder, OrderReplaced, and ReplaceRejected messages'
      - id: replace_rejected_reason
        type: s1
        enum: replace_rejected_reason
        doc: 'Enum ReplaceRejectedReason'
      - id: replace_rejected_price
        type: decimal_s8_8
        if: replace_rejected_presence_bits.has_replace_rejected_price == 1
        doc: 'New limit price. Implied decimal with scale 1e-8'
      - id: replace_rejected_order_qty
        type: s4
        if: replace_rejected_presence_bits.has_replace_rejected_order_qty == 1
        doc: 'Quantity'
      - id: replace_rejected_max_floor_qty
        type: s4
        if: replace_rejected_presence_bits.has_replace_rejected_max_floor_qty == 1
        doc: 'Quantity to be displayed at one time'
      - id: self_match_scope
        type: s1
        enum: self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: replace_rejected_self_match_instruction
        type: s1
        enum: replace_rejected_self_match_instruction
        if: replace_rejected_presence_bits.has_replace_rejected_self_match_instruction == 1
        doc: 'Enum ReplaceRejectedSelfMatchInstruction'
      - id: replace_rejected_price_slide_instruction
        type: s1
        enum: replace_rejected_price_slide_instruction
        if: replace_rejected_presence_bits.has_replace_rejected_price_slide_instruction == 1
        doc: 'Enum ReplaceRejectedPriceSlideInstruction'
      - id: replace_rejected_reference_price_target
        type: s2
        if: replace_rejected_presence_bits.has_replace_rejected_reference_price_target == 1
        doc: 'Basis points relative to the NBBO spread'
      - id: replace_rejected_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: replace_rejected_presence_bits.has_replace_rejected_locate_broker == 1
        doc: 'Locate broker'
  replace_rejected_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_replace_rejected_price
        type: b1
        doc: 'Set when replaceRejectedPrice is present'
      - id: has_replace_rejected_order_qty
        type: b1
        doc: 'Set when replaceRejectedOrderQty is present'
      - id: has_replace_rejected_max_floor_qty
        type: b1
        doc: 'Set when replaceRejectedMaxFloorQty is present'
      - id: scope
        type: b1
        doc: 'Set when limitOrderSelfMatchScope is present'
      - id: has_replace_rejected_self_match_instruction
        type: b1
        doc: 'Set when replaceRejectedSelfMatchInstruction is present'
      - id: has_replace_rejected_price_slide_instruction
        type: b1
        doc: 'Set when replaceRejectedPriceSlideInstruction is present'
      - id: has_replace_rejected_reference_price_target
        type: b1
        doc: 'Set when replaceRejectedReferencePriceTarget is present'
      - id: has_replace_rejected_locate_broker
        type: b1
        doc: 'Set when replaceRejectedLocateBroker is present'
      - id: reserved_8
        type: b8
        doc: 'Reserved for future use'
  replace_rejected_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: side
        type: b3
        doc: 'Enum Side'
      - id: is_locate_required
        type: b1
        doc: 'True if a locate is required for short-sale, false otherwise'
      - id: is_iso
        type: b1
        doc: 'True for Reg NMS Intermarket sweep orders, false otherwise'
      - id: is_post_only
        type: b1
        doc: 'True to only add the order to the book if it would be added as a resting order with no quantity executed'
      - id: cancel_at_entry_if_crossed
        type: b1
        doc: 'True to cancel the order at entry if market conditions are crossed'
      - id: reserved_9
        type: b9
        doc: 'Reserved for future use'
  order_executed_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: exec_price
        type: decimal_s8_8
        doc: 'The price at which these shares were executed. Implied decimal with scale 1e-8'
      - id: exec_id
        type: s8
        doc: 'Execution identifier'
      - id: exec_qty
        type: s4
        doc: 'Number of shares that were executed'
      - id: leaves_qty
        type: s4
        doc: 'Number of shares that were still available to execute after the modify'
      - id: liquidity_indicator
        type: s1
        enum: liquidity_indicator
        doc: 'Enum LiquidityIndicator'
  order_restated_message:
    seq:
      - id: order_restated_presence_bits
        type: order_restated_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: restatement_reason
        type: s1
        enum: restatement_reason
        doc: 'Enum RestatementReason'
      - id: order_restated_rank_price
        type: decimal_s8_8
        if: order_restated_presence_bits.has_order_restated_rank_price == 1
        doc: 'The rank price. Only present on re-priced orders. Implied decimal with scale 1e-8'
      - id: order_restated_display_price
        type: decimal_s8_8
        if: order_restated_presence_bits.has_order_restated_display_price == 1
        doc: 'The display price, when different from rank price. Only present on re-priced orders. Implied decimal with scale 1e-8'
      - id: display_qty
        type: s4
        doc: 'The quantity of the displayed replenished reserve order. Only present on reserve orders'
  order_restated_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_order_restated_rank_price
        type: b1
        doc: 'Set when orderRestatedRankPrice is present'
      - id: has_order_restated_display_price
        type: b1
        doc: 'Set when orderRestatedDisplayPrice is present'
      - id: has_display_qty
        type: b1
        doc: 'Set when displayQty is present'
      - id: reserved_5
        type: b5
        doc: 'Reserved for the future'
  self_match_prevented_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'Exchange-assigned order identifier'
      - id: cl_ord_id
        type: s8
        doc: 'Client-specified order identifier that must increase with each new order'
      - id: exec_price
        type: decimal_s8_8
        doc: 'The price at which these shares were executed. Implied decimal with scale 1e-8'
      - id: exec_id
        type: s8
        doc: 'Execution identifier'
      - id: exec_qty
        type: s4
        doc: 'Number of shares that were executed'
      - id: canceled_qty
        type: s4
        doc: 'The quantity that was decremented or canceled from this order as a result of the self-match prevention instruction'
      - id: leaves_qty
        type: s4
        doc: 'Number of shares that were still available to execute after the modify'
      - id: liquidity_indicator
        type: s1
        enum: liquidity_indicator
        doc: 'Enum LiquidityIndicator'
  mass_cancel_accepted_message:
    seq:
      - id: mass_cancel_accepted_presence_bits
        type: mass_cancel_accepted_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: mass_cancel_request_id
        type: s8
        doc: 'Unique identifier assigned by the Member for this mass cancel request'
      - id: mass_cancel_accepted_scope
        type: s1
        enum: mass_cancel_accepted_scope
        doc: 'Enum MassCancelAcceptedScope'
      - id: mass_cancel_accepted_bit_fields
        type: mass_cancel_accepted_bit_fields
        doc: 'Bitfield used in MassCancel, MassCancelAccepted, and MassCancelRejected messages'
      - id: mass_cancel_id
        type: s8
        doc: 'An identifier assigned by the Exchange for this Mass Cancel request'
      - id: mass_cancel_accepted_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_accepted_presence_bits.has_mass_cancel_accepted_mpid == 1
        doc: 'Market Participant Identifier'
      - id: mass_cancel_accepted_sender_comp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_accepted_presence_bits.has_mass_cancel_accepted_sender_comp == 1
        doc: 'Narrows the cancel to orders entered on the specified order entry port'
      - id: mass_cancel_accepted_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_accepted_presence_bits.has_mass_cancel_accepted_member_group == 1
        doc: 'Member supplied grouping'
      - id: mass_cancel_accepted_cl_ord_id
        type: s8
        if: mass_cancel_accepted_presence_bits.has_mass_cancel_accepted_cl_ord_id == 1
        doc: 'Scopes the mass cancel to this specific order'
  mass_cancel_accepted_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_mass_cancel_accepted_mpid
        type: b1
        doc: 'Set when massCancelAcceptedMpid is present'
      - id: has_mass_cancel_accepted_sender_comp
        type: b1
        doc: 'Set when massCancelAcceptedSenderComp is present'
      - id: has_mass_cancel_accepted_member_group
        type: b1
        doc: 'Set when massCancelAcceptedMemberGroup is present'
      - id: has_mass_cancel_accepted_cl_ord_id
        type: b1
        doc: 'Set when massCancelAcceptedClOrdId is present'
      - id: reserved_4
        type: b4
        doc: 'Reserved for the future'
  mass_cancel_accepted_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: exclude_auction_orders
        type: b1
        doc: 'When set, auction orders are excluded from the mass cancel scope'
      - id: reserved_7
        type: b7
        doc: 'Reserved for future use'
  mass_cancel_rejected_message:
    seq:
      - id: mass_cancel_rejected_presence_bits
        type: mass_cancel_rejected_presence_bits
        doc: 'Presence bit flags for optional fields in the enclosing message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: mass_cancel_request_id
        type: s8
        doc: 'Unique identifier assigned by the Member for this mass cancel request'
      - id: mass_cancel_rejected_scope
        type: s1
        enum: mass_cancel_rejected_scope
        doc: 'Enum MassCancelRejectedScope'
      - id: mass_cancel_rejected_bit_fields
        type: mass_cancel_rejected_bit_fields
        doc: 'Bitfield used in MassCancel, MassCancelAccepted, and MassCancelRejected messages'
      - id: mass_cancel_rejected_reason
        type: s1
        enum: mass_cancel_rejected_reason
        doc: 'Enum MassCancelRejectedReason'
      - id: mass_cancel_rejected_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_rejected_presence_bits.has_mass_cancel_rejected_mpid == 1
        doc: 'Market Participant Identifier'
      - id: mass_cancel_rejected_sender_comp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_rejected_presence_bits.has_mass_cancel_rejected_sender_comp == 1
        doc: 'Narrows the cancel to orders entered on the specified order entry port'
      - id: mass_cancel_rejected_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_rejected_presence_bits.has_mass_cancel_rejected_member_group == 1
        doc: 'Member supplied grouping'
      - id: mass_cancel_rejected_cl_ord_id
        type: s8
        if: mass_cancel_rejected_presence_bits.has_mass_cancel_rejected_cl_ord_id == 1
        doc: 'Scopes the mass cancel to this specific order'
  mass_cancel_rejected_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_mass_cancel_rejected_mpid
        type: b1
        doc: 'Set when massCancelRejectedMpid is present'
      - id: has_mass_cancel_rejected_sender_comp
        type: b1
        doc: 'Set when massCancelRejectedSenderComp is present'
      - id: has_mass_cancel_rejected_member_group
        type: b1
        doc: 'Set when massCancelRejectedMemberGroup is present'
      - id: has_mass_cancel_rejected_cl_ord_id
        type: b1
        doc: 'Set when massCancelRejectedClOrdId is present'
      - id: reserved_4
        type: b4
        doc: 'Reserved for the future'
  mass_cancel_rejected_bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: exclude_auction_orders
        type: b1
        doc: 'When set, auction orders are excluded from the mass cancel scope'
      - id: reserved_7
        type: b7
        doc: 'Reserved for future use'
  mass_cancel_result_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction time. Nanoseconds since Unix epoch'
      - id: mass_cancel_request_id
        type: s8
        doc: 'Unique identifier assigned by the Member for this mass cancel request'
      - id: mass_cancel_id
        type: s8
        doc: 'An identifier assigned by the Exchange for this Mass Cancel request'
      - id: canceled_count
        type: s4
        doc: 'The number of orders canceled from the request'
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
  packet_type:
    53:
      id: 'logon_request_packet'
      doc: 'Rake Tcp Logon Request Message'
    55:
      id: 'member_heartbeat_packet'
      doc: 'Rake Tcp Client Heartbeat Packet'
    54:
      id: 'tcp_unsequenced_message'
      doc: 'Rake Tcp Unsequenced Message'
    48:
      id: 'debug_message'
      doc: 'Rake Tcp Debug Packet'
    52:
      id: 'end_of_session_message'
      doc: 'Rake Tcp End Of Session Message'
    49:
      id: 'logon_response_message'
      doc: 'Rake Tcp Logon Response Message'
    51:
      id: 'server_heartbeat_message'
      doc: 'Rake Tcp Server Heartbeat Message'
    50:
      id: 'tcp_sequenced_message'
      doc: 'Rake Tcp Sequenced Message'
  message_type:
    76:
      id: 'limit_order_message'
      doc: 'Client-specified limit order.'
    65:
      id: 'market_order_message'
      doc: 'Client-specified market order.'
    67:
      id: 'cancel_order_message'
      doc: 'Cancel all outstanding shares of an order.'
    77:
      id: 'modify_order_message'
      doc: 'Request to modify an existing order without losing book priority.'
    82:
      id: 'replace_order_message'
      doc: 'Replace an existing order with a new order, always losing priority.'
    86:
      id: 'mass_cancel_message'
      doc: 'Cancels all resting orders matching the specified scope and optional filters.'
    105:
      id: 'trading_session_status_message'
      doc: 'Market-wide status representing the overall state of the trading session.'
    115:
      id: 'define_symbol_message'
      doc: 'Symbol definition containing instrument details and trading parameters. A DefineSymbol will be followed by a SymbolStatus message establishing the initial trading state for the symbol. Clients must treat a symbol as operationally HALTED while awaiting the accompanying SymbolStatus.'
    121:
      id: 'symbol_status_message'
      doc: 'Symbol-specific trading status representing the current state and restrictions for an individual security. A SymbolStatus is sent for every symbol, including those that open in the TRADING state. Clients must treat a symbol as operationally HALTED while awaiting the first SymbolStatus. Subsequent SymbolStatus messages are sent whenever the trading state or short-sale restriction changes.'
    73:
      id: 'limit_order_accepted_message'
      doc: 'Acknowledges acceptance of a submitted LimitOrder.'
    85:
      id: 'limit_order_rejected_message'
      doc: 'The submitted limit order has been rejected by the Exchange.'
    68:
      id: 'market_order_accepted_message'
      doc: 'Acknowledges acceptance of a submitted MarketOrder.'
    84:
      id: 'market_order_rejected_message'
      doc: 'The submitted market order has been rejected by the Exchange.'
    88:
      id: 'order_canceled_message'
      doc: 'This order has been canceled. No shares are left on the Exchange. The Member will receive this message in response to a CancelOrder message, as well as unsolicited messages from the Exchange for various reasons.'
    87:
      id: 'cancel_rejected_message'
      doc: 'The requested CancelOrder has been rejected.'
    89:
      id: 'order_modified_message'
      doc: 'An order has been modified.'
    78:
      id: 'modify_rejected_message'
      doc: 'The requested ModifyOrder has been rejected.'
    74:
      id: 'order_replaced_message'
      doc: 'Replace an existing order with a new order.'
    75:
      id: 'replace_rejected_message'
      doc: 'The requested ReplaceOrder has been rejected.'
    69:
      id: 'order_executed_message'
      doc: 'An order has executed.'
    70:
      id: 'order_restated_message'
      doc: 'Informational message from the Exchange. Sent when the Exchange performs work on the Member''s order, such as repricing after entry or a reserve replenishment. For a replenishment, the OrderId refers to the new displayed portion of the order. For a repricing, the OrderId is the new OrderId for the entire order. This message is informational.'
    90:
      id: 'self_match_prevented_message'
      doc: 'Notification that a self-match was detected and prevented according to the order''s self-match prevention instructions. The message reports the quantity that would have executed, the quantity that was canceled, and the remaining quantity still active on the book.'
    79:
      id: 'mass_cancel_accepted_message'
      doc: 'The Mass Cancel has been accepted and is being processed.'
    80:
      id: 'mass_cancel_rejected_message'
      doc: 'The Mass Cancel has been rejected.'
    81:
      id: 'mass_cancel_result_message'
      doc: 'Confirms sweep completion. Sent after all affected orders have been canceled.'
  side:
    0:
      id: 'buy'
      doc: 'Order Is A Buy Order'
    1:
      id: 'long_sell'
      doc: 'Sell Order Of Existing Inventory'
    2:
      id: 'short_sell'
      doc: 'Sell Order Of Borrowed Shares'
    3:
      id: 'short_exempt'
      doc: 'Sell Order Of Borrowed Shares Exempt From Certain Regulations Of Regulation Sho'
  time_in_force:
    1:
      id: 'sys'
      doc: 'Accepted During Any Session'
    2:
      id: 'ioc'
      doc: 'Similar To Sys But Canceled Immediately After Trading With Resting Liquidity On The Exchange'
    3:
      id: 'gtt'
      doc: 'Similar To Sys But Canceled After The Requested Time Has Passed Or The End Of The After Hours Session Whichever Comes First'
    4:
      id: 'day'
      doc: 'Accepted During The Early And Regular Sessions Rejected During The After Hours Session'
    5:
      id: 'rho'
      doc: 'Regular Hours Only Limit Order'
    6:
      id: 'at_the_open'
      doc: 'Auctiononly Tif For The Opening Auction Cross'
    7:
      id: 'at_the_close'
      doc: 'Auctiononly Tif For The Closing Auction Cross'
  order_capacity:
    1:
      id: 'agency'
      doc: 'Acting On Behalf Of Clients'
    2:
      id: 'principal'
      doc: 'Acting On Behalf Of Broker Dealer'
    3:
      id: 'riskless_principal'
      doc: 'Order To Offset Client Order'
  self_match_scope:
    0:
      id: 'by_member'
      doc: 'Match Prevention Applies To All Orders From The Same Member'
    1:
      id: 'by_mpid'
      doc: 'Match Prevention Applies To Orders From The Same Member With The Same Mpid'
    2:
      id: 'by_member_group'
      doc: 'Match Prevention Applies To Orders From The Same Member Within The Same Member Group'
    3:
      id: 'by_mpid_and_member_group'
      doc: 'Match Prevention Applies To Orders From The Same Member With The Same Mpid And Member Group'
  limit_order_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  limit_order_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display Price Slide Instruction'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single Price Slide Applied To Both Locking And Crossing Quotations'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple Price Slides Applied To Both Locking And Crossing Quotations'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single Price Slide Applied Only To Locking Quotations'
  market_order_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  replace_order_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  replace_order_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display Price Slide Instruction'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single Price Slide Applied To Both Locking And Crossing Quotations'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple Price Slides Applied To Both Locking And Crossing Quotations'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single Price Slide Applied Only To Locking Quotations'
  mass_cancel_scope:
    0:
      id: 'by_member_owned_sender_comps'
      doc: 'By Member Owned Sender Comps'
    1:
      id: 'by_member_owned_mpids'
      doc: 'By Member Owned Mpids'
  logon_response_code:
    0:
      id: 'success'
      doc: 'Logon Success'
    1:
      id: 'incorrect_sender_comp'
      doc: 'Incorrect Sender Comp Id'
    2:
      id: 'incorrect_session'
      doc: 'Incorrect Session Id'
    3:
      id: 'invalid_next_sequence'
      doc: 'The sequence number requested is larger than the largest known sequence, or is less than 0'
    4:
      id: 'invalid_configuration'
      doc: 'The RAKE server is configured incorrectly for the login request specified'
    5:
      id: 'incorrect_token'
      doc: 'Incorrect security token'
  market_hours_state:
    0:
      id: 'closed_before_hours'
      doc: 'Markets Are Closed Before Trading Hours'
    1:
      id: 'early_session'
      doc: 'Early Trading Session Is Active Premarket'
    2:
      id: 'regular_session'
      doc: 'Regular Trading Session Is Active'
    3:
      id: 'after_hours_session'
      doc: 'Afterhours Trading Session Is Active Postmarket'
    4:
      id: 'closed_after_hours'
      doc: 'Markets Are Closed After Trading Hours'
  session_trading_state:
    0:
      id: 'closed'
      doc: 'Market Session Is Closed Outside Of Trading Hours Or Not Yet Opened'
    1:
      id: 'trading'
      doc: 'Market Session Is Open And Trading Is Active'
    2:
      id: 'halted'
      doc: 'Marketwide Trading Halt'
  trading_session_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative Or Technical Halt Initiated By The Exchange'
  trading_session_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason Not Available Or Not Applicable Cta Space Utp Space'
    1:
      id: 'news_pending'
      doc: 'Trading Halted Pending Release Of Material News Cta P Utp T 1'
    2:
      id: 'news_dissemination'
      doc: 'Trading Halted For Dissemination Of Material News Cta D Utp T 2'
    3:
      id: 'info_requested'
      doc: 'Additional Information Requested By The Listing Exchange Cta A Utp T 12'
    4:
      id: 'order_imbalance'
      doc: 'Order Imbalance Cta I'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary Market Activity Utp T 6'
    6:
      id: 'luld_pause'
      doc: 'Limit Up Limit Down Pause Cta M Utp Ludp'
    7:
      id: 'non_compliance'
      doc: 'Noncompliance With Listing Standards Utp H 4'
    8:
      id: 'filings_not_current'
      doc: 'Required Filings Not Current Utp H 9'
    9:
      id: 'sec_suspension'
      doc: 'Sec Trading Suspension Utp H 10'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory Concern From Other Markets Cta C Utp H 11'
    11:
      id: 'sub_penny_trading'
      doc: 'Subpenny Trading Violation Cta Y'
    12:
      id: 'etf'
      doc: 'Et Fspecific Halt Cta F Utp T 8'
    13:
      id: 'ipo_not_trading'
      doc: 'Ipo Not Yet Trading Utp Ipo 1'
    14:
      id: 'corporate_action'
      doc: 'Corporate Action In Progress Cta N Utp M 1'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Marketwide Circuit Breaker Level 1 Cta 1 Utp Mwc 1'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Marketwide Circuit Breaker Level 2 Cta 2 Utp Mwc 2'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Marketwide Circuit Breaker Level 3 Cta 3 Utp Mwc 3'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Marketwide Circuit Breaker Halt Carried Over From Previous Trading Day Utp Mwc 0'
    19:
      id: 'merger_effective'
      doc: 'Merger Effective Cta E'
    20:
      id: 'new_security_offering'
      doc: 'New Security Offering Cta O'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday Indicative Value Not Available Cta V'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation Not Available Utp M 2'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single Stock Trading Pause Utp T 5'
    24:
      id: 'operational'
      doc: 'Nonregulatory Halt Due To Technical Or Operational Reasons Cta X Utp O 1'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up Limit Down Volatility Pause Straddle Condition Bidoffer Crosses A Band Utp Luds'
    26:
      id: 'news_resumption_times'
      doc: 'News And Resumption Times Announced Utp T 3'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single Stock Trading Pause Utp T 7'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications Issues Reviewedresolved Quotationstrading To Resume Utp R 4'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing Requirements Satisfiedresolved Quotationstrading To Resume Utp R 9'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer News Not Forthcoming Quotationstrading To Resume Utp C 3'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications Halt Ended Maintenance Requirements Met Resume Utp C 4'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications Halt Concluded Filings Met Quotestrades To Resume Utp C 9'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade Halt Concluded By Other Regulatory Authority Quotestrades To Resume Utp C 11'
    34:
      id: 'new_issue_available'
      doc: 'New Issue Available Utp R 1'
    35:
      id: 'issue_available'
      doc: 'Issue Available Utp R 2'
    36:
      id: 'ipo_quotation_released'
      doc: 'Ipo Security Released For Quotation Utp Ipoq'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'Ipo Security Positioning Window Extension Utp Ipoe'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Marketwide Circuit Breaker Quotation Resumption Utp Mwcq'
  listing_market:
    0:
      id: 'not_available'
      doc: 'Txse Is Not The Listing Market For This Symbol'
    70:
      id: 'txse'
      doc: 'Texas Stock Exchange Llc'
  symbol_trading_state:
    1:
      id: 'trading'
      doc: 'Symbol Is Open And Available For Trading'
    2:
      id: 'halted'
      doc: 'Trading Suspended'
    3:
      id: 'resume_pending'
      doc: 'Applies Only When A Symbol Is In A Nontrading State With An Auction Cross Pending To Bring It Back Into Trading'
  short_sale_restriction_state:
    0:
      id: 'none'
      doc: 'No Short Sale Restriction In Effect Cta Space Utp 0'
    1:
      id: 'activated'
      doc: 'Restriction Activated Intraday Cta A Utp 1'
    2:
      id: 'continued'
      doc: 'Restriction Carried Over From Previous Trading Day Cta C Utp 2'
    3:
      id: 'deactivated'
      doc: 'Restriction Deactivated Intraday Cta D'
    4:
      id: 'in_effect'
      doc: 'Restriction In Effect Status Unchanged From Previous Close Cta E'
  symbol_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative Or Technical Halt Initiated By The Exchange'
  symbol_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason Not Available Or Not Applicable Cta Space Utp Space'
    1:
      id: 'news_pending'
      doc: 'Trading Halted Pending Release Of Material News Cta P Utp T 1'
    2:
      id: 'news_dissemination'
      doc: 'Trading Halted For Dissemination Of Material News Cta D Utp T 2'
    3:
      id: 'info_requested'
      doc: 'Additional Information Requested By The Listing Exchange Cta A Utp T 12'
    4:
      id: 'order_imbalance'
      doc: 'Order Imbalance Cta I'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary Market Activity Utp T 6'
    6:
      id: 'luld_pause'
      doc: 'Limit Up Limit Down Pause Cta M Utp Ludp'
    7:
      id: 'non_compliance'
      doc: 'Noncompliance With Listing Standards Utp H 4'
    8:
      id: 'filings_not_current'
      doc: 'Required Filings Not Current Utp H 9'
    9:
      id: 'sec_suspension'
      doc: 'Sec Trading Suspension Utp H 10'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory Concern From Other Markets Cta C Utp H 11'
    11:
      id: 'sub_penny_trading'
      doc: 'Subpenny Trading Violation Cta Y'
    12:
      id: 'etf'
      doc: 'Et Fspecific Halt Cta F Utp T 8'
    13:
      id: 'ipo_not_trading'
      doc: 'Ipo Not Yet Trading Utp Ipo 1'
    14:
      id: 'corporate_action'
      doc: 'Corporate Action In Progress Cta N Utp M 1'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Marketwide Circuit Breaker Level 1 Cta 1 Utp Mwc 1'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Marketwide Circuit Breaker Level 2 Cta 2 Utp Mwc 2'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Marketwide Circuit Breaker Level 3 Cta 3 Utp Mwc 3'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Marketwide Circuit Breaker Halt Carried Over From Previous Trading Day Utp Mwc 0'
    19:
      id: 'merger_effective'
      doc: 'Merger Effective Cta E'
    20:
      id: 'new_security_offering'
      doc: 'New Security Offering Cta O'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday Indicative Value Not Available Cta V'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation Not Available Utp M 2'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single Stock Trading Pause Utp T 5'
    24:
      id: 'operational'
      doc: 'Nonregulatory Halt Due To Technical Or Operational Reasons Cta X Utp O 1'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up Limit Down Volatility Pause Straddle Condition Bidoffer Crosses A Band Utp Luds'
    26:
      id: 'news_resumption_times'
      doc: 'News And Resumption Times Announced Utp T 3'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single Stock Trading Pause Utp T 7'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications Issues Reviewedresolved Quotationstrading To Resume Utp R 4'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing Requirements Satisfiedresolved Quotationstrading To Resume Utp R 9'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer News Not Forthcoming Quotationstrading To Resume Utp C 3'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications Halt Ended Maintenance Requirements Met Resume Utp C 4'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications Halt Concluded Filings Met Quotestrades To Resume Utp C 9'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade Halt Concluded By Other Regulatory Authority Quotestrades To Resume Utp C 11'
    34:
      id: 'new_issue_available'
      doc: 'New Issue Available Utp R 1'
    35:
      id: 'issue_available'
      doc: 'Issue Available Utp R 2'
    36:
      id: 'ipo_quotation_released'
      doc: 'Ipo Security Released For Quotation Utp Ipoq'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'Ipo Security Positioning Window Extension Utp Ipoe'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Marketwide Circuit Breaker Quotation Resumption Utp Mwcq'
  limit_order_accepted_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  limit_order_accepted_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display Price Slide Instruction'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single Price Slide Applied To Both Locking And Crossing Quotations'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple Price Slides Applied To Both Locking And Crossing Quotations'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single Price Slide Applied Only To Locking Quotations'
  limit_order_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id Is Invalid'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id Has Already Been Used For The Current Session On This Port'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt To Modify Or Replace A Client Order That Was Not Found For The Current Session On This Port'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt To Modify Replace Or Cancel An Order That Has Already Canceled Or Fully Executed'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol Id Is Not Valid For The Current Session'
    6:
      id: 'invalid_price'
      doc: 'Invalid Limit Price'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid Reference Price Target Related To The Order Attributes'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid Is Hidden Flag Related To The Order Attributes'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type Related To The Order Attributes'
    11:
      id: 'invalid_side'
      doc: 'Invalid Side'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid Max Floor Quantity Related To The Order Attributes'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid Maximum Replenish Quantity Range'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid Maximum Replenish Time Range'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid Locaterequired Flag Related To The Order Attributes'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    18:
      id: 'modification_not_permitted'
      doc: 'Order Modification Not Permitted'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid Market Participant Identifier'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid Sender Comp'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid Is Post Only Flag Related To The Order Attributes'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not Permitted During The Current Trading Session'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not Permitted During The Current Trading Status'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not Permitted During The Current Symbol Status'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid Is Iso Flag Related To The Order Attributes Iso Intermarket Sweep Order'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading Is Disabled For The Mpid On This Port Based On Port Mpid Settings Configuration'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading Is Restricted To Test Symbols Only Based On Port Settings Configuration'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading Is Disabled For The Specified Order Capacity Based On Port Settings Configuration'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'Iso Intermarket Sweep Order Trading Is Disabled Based On Port Settings Configuration'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order Quantity Exceeds The Maximum Shares Limit Configured In Port Settings'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit Price Exceeds The Maximum Acceptable Price For The Exchange'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order Notional Value Exceeds The Maximum Notional Limit Configured In Port Settings'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id Is Invalid'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol Is On The Restricted List For This Port Mpid Based On Port Settings Configuration'
    36:
      id: 'luld_band_breached'
      doc: 'Order Limit Price Is Outside Luld Limit Up Limit Down Bands And Port Settings Require Rejection'
    37:
      id: 'invalid_price_increment'
      doc: 'Price Does Not Conform To The Minimum Price Variation Tick Size'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction Only Orders For The Open And Close Cannot Be Cancelled Modified Or Replaced Once The Band Window Begins'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order Property Is Incompatible With An Auctionclassed Order'
  limit_order_rejected_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  limit_order_rejected_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display Price Slide Instruction'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single Price Slide Applied To Both Locking And Crossing Quotations'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple Price Slides Applied To Both Locking And Crossing Quotations'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single Price Slide Applied Only To Locking Quotations'
  market_order_accepted_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  market_order_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id Is Invalid'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id Has Already Been Used For The Current Session On This Port'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt To Modify Or Replace A Client Order That Was Not Found For The Current Session On This Port'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt To Modify Replace Or Cancel An Order That Has Already Canceled Or Fully Executed'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol Id Is Not Valid For The Current Session'
    6:
      id: 'invalid_price'
      doc: 'Invalid Limit Price'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid Reference Price Target Related To The Order Attributes'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid Is Hidden Flag Related To The Order Attributes'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type Related To The Order Attributes'
    11:
      id: 'invalid_side'
      doc: 'Invalid Side'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid Max Floor Quantity Related To The Order Attributes'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid Maximum Replenish Quantity Range'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid Maximum Replenish Time Range'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid Locaterequired Flag Related To The Order Attributes'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    18:
      id: 'modification_not_permitted'
      doc: 'Order Modification Not Permitted'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid Market Participant Identifier'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid Sender Comp'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid Is Post Only Flag Related To The Order Attributes'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not Permitted During The Current Trading Session'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not Permitted During The Current Trading Status'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not Permitted During The Current Symbol Status'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid Is Iso Flag Related To The Order Attributes Iso Intermarket Sweep Order'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading Is Disabled For The Mpid On This Port Based On Port Mpid Settings Configuration'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading Is Restricted To Test Symbols Only Based On Port Settings Configuration'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading Is Disabled For The Specified Order Capacity Based On Port Settings Configuration'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'Iso Intermarket Sweep Order Trading Is Disabled Based On Port Settings Configuration'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order Quantity Exceeds The Maximum Shares Limit Configured In Port Settings'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit Price Exceeds The Maximum Acceptable Price For The Exchange'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order Notional Value Exceeds The Maximum Notional Limit Configured In Port Settings'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id Is Invalid'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol Is On The Restricted List For This Port Mpid Based On Port Settings Configuration'
    36:
      id: 'luld_band_breached'
      doc: 'Order Limit Price Is Outside Luld Limit Up Limit Down Bands And Port Settings Require Rejection'
    37:
      id: 'invalid_price_increment'
      doc: 'Price Does Not Conform To The Minimum Price Variation Tick Size'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction Only Orders For The Open And Close Cannot Be Cancelled Modified Or Replaced Once The Band Window Begins'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order Property Is Incompatible With An Auctionclassed Order'
  market_order_rejected_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  cancel_reason:
    1:
      id: 'requested_by_user'
      doc: 'Cancel Due To Request By Client'
    2:
      id: 'related_to_time_in_force'
      doc: 'Cancel Due To Time In Force Expiration'
    3:
      id: 'related_to_min_qty'
      doc: 'Cancel Due To Inability To Meet Minimum Quantity'
    4:
      id: 'reg_nms_violation_no_slide'
      doc: 'Canceled As Order Would Violate Regulation Nms Rule 610 D By Creating A Locked Or Crossed Market And Price Sliding Was Either Not Selected Or Not Applicable'
    5:
      id: 'marketable_reserve'
      doc: 'Reserve Orders Will Be Canceled When Deemed Marketable At Another Exchange Either At New Order Entry Or Replenishment'
    6:
      id: 'self_match_prevention'
      doc: 'Cancel Due To Selfmatch Prevention Instructions'
    7:
      id: 'replenishment_canceled_due_to_reserve'
      doc: 'Replenishment Canceled Related To The Reserve Order Being Canceled Or Replaced'
    8:
      id: 'related_to_order_type'
      doc: 'Cancel Due To Order Type Eg'
    9:
      id: 'canceled_due_to_crossed_markets'
      doc: 'Cancel Due To Client Instruction On Crossed Markets'
    10:
      id: 'canceled_due_to_mass_cancel_request'
      doc: 'Cancel Due To A Mass Cancel Request'
    11:
      id: 'exchange_locked_or_crossed_no_slide'
      doc: 'Canceled As Order Would Lock Or Cross The Exchange Book And Price Sliding Was Either Not Selected Or Not Applicable'
    12:
      id: 'reg_sho_violation_no_slide'
      doc: 'Canceled As Order Would Violate Regulation Sho Rule 201 By Display At Or Below The National Best Bid During A Short Sale Price Test Restriction And Price Sliding Was Either Not Selected Or Not Applicable'
    13:
      id: 'luld_breached_no_slide'
      doc: 'Canceled As Order Would Violate Luld Limit Up Limit Down Price Bands Per Sec Rule 608 And Price Sliding Was Either Not Selected Or Not Applicable'
    14:
      id: 'canceled_as_price_breached_luld'
      doc: 'Canceled As The Orders Limit Price Is Now Outside Luld Limit Up Limit Down Price Bands After Bands Narrowed'
    15:
      id: 'canceled_on_disconnect'
      doc: 'Cancel Due To Client Disconnect From A Port With Cancelondisconnect Instructions'
    16:
      id: 'auction_order_post_cross'
      doc: 'Auction Order Is Canceled Because The Auction It Was Eligible For Has Concluded'
    17:
      id: 'peg_reference_price_breaches_limit_price'
      doc: 'Pegged Order Canceled Because Its Calculated Reference Price Moved Beyond The Orders Limit Price The Limit Price Collared The Peg'
    18:
      id: 'odd_lot_not_executable'
      doc: 'Canceled As The Order Is Of Odd Lot Size And Could Not Be Executed Against The Contraside Liquidity On The Txse Book'
  cancel_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id Is Invalid'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id Has Already Been Used For The Current Session On This Port'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt To Modify Or Replace A Client Order That Was Not Found For The Current Session On This Port'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt To Modify Replace Or Cancel An Order That Has Already Canceled Or Fully Executed'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol Id Is Not Valid For The Current Session'
    6:
      id: 'invalid_price'
      doc: 'Invalid Limit Price'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid Reference Price Target Related To The Order Attributes'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid Is Hidden Flag Related To The Order Attributes'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type Related To The Order Attributes'
    11:
      id: 'invalid_side'
      doc: 'Invalid Side'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid Max Floor Quantity Related To The Order Attributes'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid Maximum Replenish Quantity Range'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid Maximum Replenish Time Range'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid Locaterequired Flag Related To The Order Attributes'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    18:
      id: 'modification_not_permitted'
      doc: 'Order Modification Not Permitted'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid Market Participant Identifier'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid Sender Comp'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid Is Post Only Flag Related To The Order Attributes'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not Permitted During The Current Trading Session'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not Permitted During The Current Trading Status'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not Permitted During The Current Symbol Status'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid Is Iso Flag Related To The Order Attributes Iso Intermarket Sweep Order'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading Is Disabled For The Mpid On This Port Based On Port Mpid Settings Configuration'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading Is Restricted To Test Symbols Only Based On Port Settings Configuration'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading Is Disabled For The Specified Order Capacity Based On Port Settings Configuration'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'Iso Intermarket Sweep Order Trading Is Disabled Based On Port Settings Configuration'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order Quantity Exceeds The Maximum Shares Limit Configured In Port Settings'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit Price Exceeds The Maximum Acceptable Price For The Exchange'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order Notional Value Exceeds The Maximum Notional Limit Configured In Port Settings'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id Is Invalid'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol Is On The Restricted List For This Port Mpid Based On Port Settings Configuration'
    36:
      id: 'luld_band_breached'
      doc: 'Order Limit Price Is Outside Luld Limit Up Limit Down Bands And Port Settings Require Rejection'
    37:
      id: 'invalid_price_increment'
      doc: 'Price Does Not Conform To The Minimum Price Variation Tick Size'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction Only Orders For The Open And Close Cannot Be Cancelled Modified Or Replaced Once The Band Window Begins'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order Property Is Incompatible With An Auctionclassed Order'
  modify_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id Is Invalid'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id Has Already Been Used For The Current Session On This Port'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt To Modify Or Replace A Client Order That Was Not Found For The Current Session On This Port'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt To Modify Replace Or Cancel An Order That Has Already Canceled Or Fully Executed'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol Id Is Not Valid For The Current Session'
    6:
      id: 'invalid_price'
      doc: 'Invalid Limit Price'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid Reference Price Target Related To The Order Attributes'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid Is Hidden Flag Related To The Order Attributes'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type Related To The Order Attributes'
    11:
      id: 'invalid_side'
      doc: 'Invalid Side'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid Max Floor Quantity Related To The Order Attributes'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid Maximum Replenish Quantity Range'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid Maximum Replenish Time Range'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid Locaterequired Flag Related To The Order Attributes'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    18:
      id: 'modification_not_permitted'
      doc: 'Order Modification Not Permitted'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid Market Participant Identifier'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid Sender Comp'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid Is Post Only Flag Related To The Order Attributes'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not Permitted During The Current Trading Session'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not Permitted During The Current Trading Status'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not Permitted During The Current Symbol Status'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid Is Iso Flag Related To The Order Attributes Iso Intermarket Sweep Order'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading Is Disabled For The Mpid On This Port Based On Port Mpid Settings Configuration'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading Is Restricted To Test Symbols Only Based On Port Settings Configuration'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading Is Disabled For The Specified Order Capacity Based On Port Settings Configuration'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'Iso Intermarket Sweep Order Trading Is Disabled Based On Port Settings Configuration'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order Quantity Exceeds The Maximum Shares Limit Configured In Port Settings'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit Price Exceeds The Maximum Acceptable Price For The Exchange'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order Notional Value Exceeds The Maximum Notional Limit Configured In Port Settings'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id Is Invalid'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol Is On The Restricted List For This Port Mpid Based On Port Settings Configuration'
    36:
      id: 'luld_band_breached'
      doc: 'Order Limit Price Is Outside Luld Limit Up Limit Down Bands And Port Settings Require Rejection'
    37:
      id: 'invalid_price_increment'
      doc: 'Price Does Not Conform To The Minimum Price Variation Tick Size'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction Only Orders For The Open And Close Cannot Be Cancelled Modified Or Replaced Once The Band Window Begins'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order Property Is Incompatible With An Auctionclassed Order'
  order_replaced_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  order_replaced_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display Price Slide Instruction'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single Price Slide Applied To Both Locking And Crossing Quotations'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple Price Slides Applied To Both Locking And Crossing Quotations'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single Price Slide Applied Only To Locking Quotations'
  replace_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id Is Invalid'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id Has Already Been Used For The Current Session On This Port'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt To Modify Or Replace A Client Order That Was Not Found For The Current Session On This Port'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt To Modify Replace Or Cancel An Order That Has Already Canceled Or Fully Executed'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol Id Is Not Valid For The Current Session'
    6:
      id: 'invalid_price'
      doc: 'Invalid Limit Price'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid Reference Price Target Related To The Order Attributes'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid Is Hidden Flag Related To The Order Attributes'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type Related To The Order Attributes'
    11:
      id: 'invalid_side'
      doc: 'Invalid Side'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid Max Floor Quantity Related To The Order Attributes'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid Maximum Replenish Quantity Range'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid Maximum Replenish Time Range'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid Locaterequired Flag Related To The Order Attributes'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    18:
      id: 'modification_not_permitted'
      doc: 'Order Modification Not Permitted'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid Market Participant Identifier'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid Sender Comp'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid Is Post Only Flag Related To The Order Attributes'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not Permitted During The Current Trading Session'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not Permitted During The Current Trading Status'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not Permitted During The Current Symbol Status'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid Is Iso Flag Related To The Order Attributes Iso Intermarket Sweep Order'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading Is Disabled For The Mpid On This Port Based On Port Mpid Settings Configuration'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading Is Restricted To Test Symbols Only Based On Port Settings Configuration'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading Is Disabled For The Specified Order Capacity Based On Port Settings Configuration'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'Iso Intermarket Sweep Order Trading Is Disabled Based On Port Settings Configuration'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order Quantity Exceeds The Maximum Shares Limit Configured In Port Settings'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit Price Exceeds The Maximum Acceptable Price For The Exchange'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order Notional Value Exceeds The Maximum Notional Limit Configured In Port Settings'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id Is Invalid'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol Is On The Restricted List For This Port Mpid Based On Port Settings Configuration'
    36:
      id: 'luld_band_breached'
      doc: 'Order Limit Price Is Outside Luld Limit Up Limit Down Bands And Port Settings Require Rejection'
    37:
      id: 'invalid_price_increment'
      doc: 'Price Does Not Conform To The Minimum Price Variation Tick Size'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction Only Orders For The Open And Close Cannot Be Cancelled Modified Or Replaced Once The Band Window Begins'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order Property Is Incompatible With An Auctionclassed Order'
  replace_rejected_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Selfmatch Prevention Is Disabled'
    1:
      id: 'cancel_newest'
      doc: 'Cancels The Incoming Order'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels The Resting Order'
    3:
      id: 'cancel_both'
      doc: 'Cancels Both Orders Entirely Regardless Of Size'
    4:
      id: 'cancel_smallest'
      doc: 'If Orders Are Equal Size Cancels Both'
    5:
      id: 'decrement_and_cancel'
      doc: 'If Orders Are Equal Size Cancels Both'
  replace_rejected_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display Price Slide Instruction'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single Price Slide Applied To Both Locking And Crossing Quotations'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple Price Slides Applied To Both Locking And Crossing Quotations'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single Price Slide Applied Only To Locking Quotations'
  liquidity_indicator:
    0:
      id: 'removed_hidden_liquidity'
      doc: 'Removed Hidden Liquidity'
    1:
      id: 'removed_displayed_liquidity'
      doc: 'Removed Displayed Liquidity'
    2:
      id: 'added_hidden_liquidity'
      doc: 'Added Hidden Liquidity'
    3:
      id: 'added_displayed_liquidity'
      doc: 'Added Displayed Liquidity'
    4:
      id: 'auction'
      doc: 'Execution From An Auction Cross'
  restatement_reason:
    1:
      id: 'reserve_replenished'
      doc: 'A New Displayed Slice Of A Reserve Order Has Been Added To The Displayed Book'
    2:
      id: 'repriced'
      doc: 'A Repriceeligible Order Has Been Repriced To A New Price'
    3:
      id: 'post_auction'
      doc: 'Orders Staged Awaiting The Result Of The Auction With Unfilled Residual Have Been Reinstated Into Continuous Book'
  mass_cancel_accepted_scope:
    0:
      id: 'by_member_owned_sender_comps'
      doc: 'By Member Owned Sender Comps'
    1:
      id: 'by_member_owned_mpids'
      doc: 'By Member Owned Mpids'
  mass_cancel_rejected_scope:
    0:
      id: 'by_member_owned_sender_comps'
      doc: 'By Member Owned Sender Comps'
    1:
      id: 'by_member_owned_mpids'
      doc: 'By Member Owned Mpids'
  mass_cancel_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id Is Invalid'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id Has Already Been Used For The Current Session On This Port'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt To Modify Or Replace A Client Order That Was Not Found For The Current Session On This Port'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt To Modify Replace Or Cancel An Order That Has Already Canceled Or Fully Executed'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol Id Is Not Valid For The Current Session'
    6:
      id: 'invalid_price'
      doc: 'Invalid Limit Price'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid Reference Price Target Related To The Order Attributes'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid Is Hidden Flag Related To The Order Attributes'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type Related To The Order Attributes'
    11:
      id: 'invalid_side'
      doc: 'Invalid Side'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid Max Floor Quantity Related To The Order Attributes'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid Maximum Replenish Quantity Range'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid Maximum Replenish Time Range'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid Locaterequired Flag Related To The Order Attributes'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    18:
      id: 'modification_not_permitted'
      doc: 'Order Modification Not Permitted'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid Market Participant Identifier'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid Sender Comp'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid Is Post Only Flag Related To The Order Attributes'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not Permitted During The Current Trading Session'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not Permitted During The Current Trading Status'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not Permitted During The Current Symbol Status'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid Is Iso Flag Related To The Order Attributes Iso Intermarket Sweep Order'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading Is Disabled For The Mpid On This Port Based On Port Mpid Settings Configuration'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading Is Restricted To Test Symbols Only Based On Port Settings Configuration'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading Is Disabled For The Specified Order Capacity Based On Port Settings Configuration'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'Iso Intermarket Sweep Order Trading Is Disabled Based On Port Settings Configuration'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order Quantity Exceeds The Maximum Shares Limit Configured In Port Settings'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit Price Exceeds The Maximum Acceptable Price For The Exchange'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order Notional Value Exceeds The Maximum Notional Limit Configured In Port Settings'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id Is Invalid'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol Is On The Restricted List For This Port Mpid Based On Port Settings Configuration'
    36:
      id: 'luld_band_breached'
      doc: 'Order Limit Price Is Outside Luld Limit Up Limit Down Bands And Port Settings Require Rejection'
    37:
      id: 'invalid_price_increment'
      doc: 'Price Does Not Conform To The Minimum Price Variation Tick Size'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction Only Orders For The Open And Close Cannot Be Cancelled Modified Or Replaced Once The Band Window Begins'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order Property Is Incompatible With An Auctionclassed Order'

