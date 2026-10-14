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
  id: txse_txseequities_seed_rake_v1_0_client
  title: Txse TxseEquities Seed Rake v1.0
  license: GPL-3.0
  endian: le

doc: 'Texas Stock Exchange Txse Equities Session Enabled Entry Daemon Rake v1.0'
doc-ref: https://www.txse.com

seq:
  - id: client_rake_tcp_message
    type: client_rake_tcp_message_struct
    repeat: eos
    doc: 'Rake Tcp Message sent by the Member to the Exchange'

types:
  client_rake_tcp_message_struct:
    seq:
      - id: rake_message_header
        type: rake_message_header
        doc: 'Rake Tcp per-message header carrying the frame length and packet-level dispatch byte'
      - id: client_payload
        size: rake_message_header.message_length + 2 - 3
        type:
          switch-on: rake_message_header.packet_type
          cases:
            'packet_type::logon_request_packet': logon_request_packet
            'packet_type::tcp_unsequenced_message': tcp_unsequenced_message
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
      - id: limit_order_self_match_scope
        type: s1
        if: limit_order_presence_bits.has_limit_order_self_match_scope
        doc: 'Enum SelfMatchScope. Determines the scope for self-match prevention'
      - id: limit_order_self_match_instruction
        type: s1
        enum: limit_order_self_match_instruction
        if: limit_order_presence_bits.has_limit_order_self_match_instruction
        doc: 'Enum LimitOrderSelfMatchInstruction. Determines the behavior when orders from the same entity would match'
      - id: limit_order_price_slide_instruction
        type: s1
        enum: limit_order_price_slide_instruction
        if: limit_order_presence_bits.has_limit_order_price_slide_instruction
        doc: 'Enum LimitOrderPriceSlideInstruction'
      - id: limit_order_min_qty
        type: s4
        if: limit_order_presence_bits.has_limit_order_min_qty
        doc: 'Number of shares that must be executed to execute any shares'
      - id: limit_order_max_floor_qty
        type: s4
        if: limit_order_presence_bits.has_limit_order_max_floor_qty
        doc: 'Quantity to be displayed at one time with remaining quantity not displayed on the book'
      - id: limit_order_max_replenish_qty_range
        type: s4
        if: limit_order_presence_bits.has_limit_order_max_replenish_qty_range
        doc: 'Defines the maximum range to be used when calculating a random refresh quantity'
      - id: limit_order_max_replenish_time_range
        type: s8
        if: limit_order_presence_bits.has_limit_order_max_replenish_time_range
        doc: 'Defines the maximum range to be used when calculating a random refresh time, in nanoseconds'
      - id: limit_order_reference_price_target
        type: s2
        if: limit_order_presence_bits.has_limit_order_reference_price_target
        doc: 'The target relative to the reference base price in basis points of the NBBO spread'
      - id: limit_order_expire_time
        type: nanosecond_timestamp
        if: limit_order_presence_bits.has_limit_order_expire_time
        doc: 'Timestamp at which the order''s open quantity will be canceled, valid only with GTT time in force. Nanoseconds since Unix epoch'
      - id: limit_order_user_data
        type: s8
        if: limit_order_presence_bits.has_limit_order_user_data
        doc: 'Pass-through field for use by clients, not used by the Exchange'
      - id: limit_order_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_presence_bits.has_limit_order_mpid
        doc: 'Market Participant Identifier. Upper-case alpha only'
      - id: limit_order_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_presence_bits.has_limit_order_member_group
        doc: 'Member supplied grouping'
      - id: limit_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: limit_order_presence_bits.has_limit_order_locate_broker
        doc: 'Identifies the broker that has loaned the stock to settle the short sale'
  limit_order_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_limit_order_self_match_scope
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
      - id: market_order_self_match_scope
        type: s1
        if: market_order_presence_bits.has_market_order_self_match_scope
        doc: 'Enum SelfMatchScope'
      - id: market_order_self_match_instruction
        type: s1
        enum: market_order_self_match_instruction
        if: market_order_presence_bits.has_market_order_self_match_instruction
        doc: 'Enum MarketOrderSelfMatchInstruction'
      - id: market_order_user_data
        type: s8
        if: market_order_presence_bits.has_market_order_user_data
        doc: 'Pass-through field for use by clients, not used by the Exchange'
      - id: market_order_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_presence_bits.has_market_order_mpid
        doc: 'Market Participant Identifier'
      - id: market_order_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: market_order_presence_bits.has_market_order_member_group
        doc: 'Member supplied grouping'
      - id: market_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: market_order_presence_bits.has_market_order_locate_broker
        doc: 'Identifies the broker that has loaned the stock to settle the short sale'
  market_order_presence_bits:
    meta:
      bit-endian: le
    seq:
      - id: has_market_order_self_match_scope
        type: b1
        doc: 'Set when marketOrderSelfMatchScope is present'
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
        if: modify_order_presence_bits.has_modify_order_order_qty
        doc: 'Quantity can remain the same or decrease. Quantity cannot increase'
      - id: modify_order_bit_fields
        type: modify_order_bit_fields
        if: modify_order_presence_bits.has_modify_order_bit_fields
        doc: 'Bitfield used in ModifyOrder, OrderModified, and ModifyRejected messages'
      - id: modify_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: modify_order_presence_bits.has_modify_order_locate_broker
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
        if: replace_order_presence_bits.has_replace_order_price
        doc: 'New limit price. Implied decimal with scale 1e-8'
      - id: replace_order_order_qty
        type: s4
        if: replace_order_presence_bits.has_replace_order_order_qty
        doc: 'Quantity can remain the same, decrease or increase'
      - id: replace_order_max_floor_qty
        type: s4
        if: replace_order_presence_bits.has_replace_order_max_floor_qty
        doc: 'Quantity to be displayed at one time with remaining quantity not displayed on the book'
      - id: replace_order_self_match_scope
        type: s1
        if: replace_order_presence_bits.has_replace_order_self_match_scope
        doc: 'Enum SelfMatchScope'
      - id: replace_order_self_match_instruction
        type: s1
        enum: replace_order_self_match_instruction
        if: replace_order_presence_bits.has_replace_order_self_match_instruction
        doc: 'Enum ReplaceOrderSelfMatchInstruction'
      - id: replace_order_price_slide_instruction
        type: s1
        enum: replace_order_price_slide_instruction
        if: replace_order_presence_bits.has_replace_order_price_slide_instruction
        doc: 'Enum ReplaceOrderPriceSlideInstruction'
      - id: replace_order_reference_price_target
        type: s2
        if: replace_order_presence_bits.has_replace_order_reference_price_target
        doc: 'The target relative to the reference base price in basis points of the NBBO spread'
      - id: replace_order_locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        if: replace_order_presence_bits.has_replace_order_locate_broker
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
      - id: has_replace_order_self_match_scope
        type: b1
        doc: 'Set when replaceOrderSelfMatchScope is present'
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
        if: mass_cancel_presence_bits.has_mass_cancel_mpid
        doc: 'Market Participant Identifier'
      - id: mass_cancel_sender_comp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_presence_bits.has_mass_cancel_sender_comp
        doc: 'Narrows the cancel to orders entered on the specified order entry port (SenderComp)'
      - id: mass_cancel_member_group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        if: mass_cancel_presence_bits.has_mass_cancel_member_group
        doc: 'Member supplied grouping'
      - id: mass_cancel_cl_ord_id
        type: s8
        if: mass_cancel_presence_bits.has_mass_cancel_cl_ord_id
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
      doc: 'Order is a buy order.'
    1:
      id: 'long_sell'
      doc: 'Sell order of existing inventory.'
    2:
      id: 'short_sell'
      doc: 'Sell order of borrowed shares.'
    3:
      id: 'short_exempt'
      doc: 'Sell order of borrowed shares exempt from certain regulations of Regulation SHO.'
  time_in_force:
    1:
      id: 'sys'
      doc: 'Accepted during any session.'
    2:
      id: 'ioc'
      doc: 'Similar to SYS, but canceled immediately, after trading with resting liquidity on the Exchange.'
    3:
      id: 'gtt'
      doc: 'Similar to SYS, but canceled after the requested time has passed or the end of the After Hours Session, whichever comes first.'
    4:
      id: 'day'
      doc: 'Accepted during the Early and Regular Sessions; rejected during the After Hours Session.'
    5:
      id: 'rho'
      doc: 'Regular-Hours-Only limit order.'
    6:
      id: 'at_the_open'
      doc: 'Auction-only TIF for the Opening Auction cross.'
    7:
      id: 'at_the_close'
      doc: 'Auction-only TIF for the Closing Auction cross.'
  order_capacity:
    1:
      id: 'agency'
      doc: 'Acting on behalf of clients.'
    2:
      id: 'principal'
      doc: 'Acting on behalf of Broker-Dealer.'
    3:
      id: 'riskless_principal'
      doc: 'Order to offset client order.'
  limit_order_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  limit_order_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display-Price Slide instruction.'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single price slide applied to both locking and crossing quotations.'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple price slides applied to both locking and crossing quotations.'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single price slide applied only to locking quotations.'
  market_order_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  replace_order_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  replace_order_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display-Price Slide instruction.'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single price slide applied to both locking and crossing quotations.'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple price slides applied to both locking and crossing quotations.'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single price slide applied only to locking quotations.'
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
      doc: 'Markets are closed before trading hours.'
    1:
      id: 'early_session'
      doc: 'Early trading session is active (pre-market).'
    2:
      id: 'regular_session'
      doc: 'Regular trading session is active.'
    3:
      id: 'after_hours_session'
      doc: 'After-hours trading session is active (post-market).'
    4:
      id: 'closed_after_hours'
      doc: 'Markets are closed after trading hours.'
  session_trading_state:
    0:
      id: 'closed'
      doc: 'Market session is closed, outside of trading hours or not yet opened.'
    1:
      id: 'trading'
      doc: 'Market session is open and trading is active.'
    2:
      id: 'halted'
      doc: 'Market-wide trading halt.'
  trading_session_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative or technical halt initiated by the Exchange.'
  trading_session_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason not available or not applicable (CTA: Space, UTP: Space).'
    1:
      id: 'news_pending'
      doc: 'Trading halted pending release of material news (CTA: P, UTP: T1).'
    2:
      id: 'news_dissemination'
      doc: 'Trading halted for dissemination of material news (CTA: D, UTP: T2).'
    3:
      id: 'info_requested'
      doc: 'Additional information requested by the listing exchange (CTA: A, UTP: T12).'
    4:
      id: 'order_imbalance'
      doc: 'Order imbalance (CTA: I).'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary market activity (UTP: T6).'
    6:
      id: 'luld_pause'
      doc: 'Limit Up-Limit Down pause (CTA: M, UTP: LUDP).'
    7:
      id: 'non_compliance'
      doc: 'Non-compliance with listing standards (UTP: H4).'
    8:
      id: 'filings_not_current'
      doc: 'Required filings not current (UTP: H9).'
    9:
      id: 'sec_suspension'
      doc: 'SEC trading suspension (UTP: H10).'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory concern from other markets (CTA: C, UTP: H11).'
    11:
      id: 'sub_penny_trading'
      doc: 'Sub-penny trading violation (CTA: Y).'
    12:
      id: 'etf'
      doc: 'ETF-specific halt (CTA: F, UTP: T8).'
    13:
      id: 'ipo_not_trading'
      doc: 'IPO not yet trading (UTP: IPO1).'
    14:
      id: 'corporate_action'
      doc: 'Corporate action in progress (CTA: N, UTP: M1).'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Market-wide circuit breaker Level 1 (CTA: 1, UTP: MWC1).'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Market-wide circuit breaker Level 2 (CTA: 2, UTP: MWC2).'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Market-wide circuit breaker Level 3 (CTA: 3, UTP: MWC3).'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Market-wide circuit breaker halt carried over from previous trading day (UTP: MWC0).'
    19:
      id: 'merger_effective'
      doc: 'Merger effective (CTA: E).'
    20:
      id: 'new_security_offering'
      doc: 'New security offering (CTA: O).'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday indicative value not available (CTA: V).'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation not available (UTP: M2).'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single stock trading pause (UTP: T5).'
    24:
      id: 'operational'
      doc: 'Non-regulatory halt due to technical or operational reasons (CTA: X, UTP: O1).'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up-Limit Down volatility pause - straddle condition (bid/offer crosses a band) (UTP: LUDS).'
    26:
      id: 'news_resumption_times'
      doc: 'News and resumption times announced (UTP: T3).'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single stock trading pause (UTP: T7).'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications issues reviewed/resolved; quotations/trading to resume (UTP: R4).'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing requirements satisfied/resolved; quotations/trading to resume (UTP: R9).'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer news not forthcoming; quotations/trading to resume (UTP: C3).'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications halt ended; maintenance requirements met; resume (UTP: C4).'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications halt concluded; filings met; quotes/trades to resume (UTP: C9).'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade halt concluded by other regulatory authority; quotes/trades to resume (UTP: C11).'
    34:
      id: 'new_issue_available'
      doc: 'New issue available (UTP: R1).'
    35:
      id: 'issue_available'
      doc: 'Issue available (UTP: R2).'
    36:
      id: 'ipo_quotation_released'
      doc: 'IPO security released for quotation (UTP: IPOQ).'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'IPO security - positioning window extension (UTP: IPOE).'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Market-wide circuit breaker quotation resumption (UTP: MWCQ).'
  listing_market:
    0:
      id: 'not_available'
      doc: 'TXSE is not the listing market for this symbol.'
    70:
      id: 'txse'
      doc: 'Texas Stock Exchange, LLC.'
  symbol_trading_state:
    1:
      id: 'trading'
      doc: 'Symbol is open and available for trading.'
    2:
      id: 'halted'
      doc: 'Trading suspended.'
    3:
      id: 'resume_pending'
      doc: 'Applies only when a symbol is in a non-trading state with an auction cross pending to bring it back into trading.'
  short_sale_restriction_state:
    0:
      id: 'none'
      doc: 'No short sale restriction in effect (CTA: Space, UTP: 0).'
    1:
      id: 'activated'
      doc: 'Restriction activated intra-day (CTA: A, UTP: 1).'
    2:
      id: 'continued'
      doc: 'Restriction carried over from previous trading day (CTA: C, UTP: 2).'
    3:
      id: 'deactivated'
      doc: 'Restriction deactivated intra-day (CTA: D).'
    4:
      id: 'in_effect'
      doc: 'Restriction in effect, status unchanged from previous close (CTA: E).'
  symbol_status_operational_halt_reason:
    0:
      id: 'administrative'
      doc: 'Administrative or technical halt initiated by the Exchange.'
  symbol_status_regulatory_halt_reason:
    0:
      id: 'reason_not_available'
      doc: 'Reason not available or not applicable (CTA: Space, UTP: Space).'
    1:
      id: 'news_pending'
      doc: 'Trading halted pending release of material news (CTA: P, UTP: T1).'
    2:
      id: 'news_dissemination'
      doc: 'Trading halted for dissemination of material news (CTA: D, UTP: T2).'
    3:
      id: 'info_requested'
      doc: 'Additional information requested by the listing exchange (CTA: A, UTP: T12).'
    4:
      id: 'order_imbalance'
      doc: 'Order imbalance (CTA: I).'
    5:
      id: 'extraordinary_market_activity'
      doc: 'Extraordinary market activity (UTP: T6).'
    6:
      id: 'luld_pause'
      doc: 'Limit Up-Limit Down pause (CTA: M, UTP: LUDP).'
    7:
      id: 'non_compliance'
      doc: 'Non-compliance with listing standards (UTP: H4).'
    8:
      id: 'filings_not_current'
      doc: 'Required filings not current (UTP: H9).'
    9:
      id: 'sec_suspension'
      doc: 'SEC trading suspension (UTP: H10).'
    10:
      id: 'regulatory_concern'
      doc: 'Regulatory concern from other markets (CTA: C, UTP: H11).'
    11:
      id: 'sub_penny_trading'
      doc: 'Sub-penny trading violation (CTA: Y).'
    12:
      id: 'etf'
      doc: 'ETF-specific halt (CTA: F, UTP: T8).'
    13:
      id: 'ipo_not_trading'
      doc: 'IPO not yet trading (UTP: IPO1).'
    14:
      id: 'corporate_action'
      doc: 'Corporate action in progress (CTA: N, UTP: M1).'
    15:
      id: 'circuit_breaker_l_1'
      doc: 'Market-wide circuit breaker Level 1 (CTA: 1, UTP: MWC1).'
    16:
      id: 'circuit_breaker_l_2'
      doc: 'Market-wide circuit breaker Level 2 (CTA: 2, UTP: MWC2).'
    17:
      id: 'circuit_breaker_l_3'
      doc: 'Market-wide circuit breaker Level 3 (CTA: 3, UTP: MWC3).'
    18:
      id: 'circuit_breaker_carryover'
      doc: 'Market-wide circuit breaker halt carried over from previous trading day (UTP: MWC0).'
    19:
      id: 'merger_effective'
      doc: 'Merger effective (CTA: E).'
    20:
      id: 'new_security_offering'
      doc: 'New security offering (CTA: O).'
    21:
      id: 'indicative_value_not_available'
      doc: 'Intraday indicative value not available (CTA: V).'
    22:
      id: 'quotation_not_available'
      doc: 'Quotation not available (UTP: M2).'
    23:
      id: 'single_stock_trading_pause'
      doc: 'Single stock trading pause (UTP: T5).'
    24:
      id: 'operational'
      doc: 'Non-regulatory halt due to technical or operational reasons (CTA: X, UTP: O1).'
    25:
      id: 'luld_pause_straddle'
      doc: 'Limit Up-Limit Down volatility pause - straddle condition (bid/offer crosses a band) (UTP: LUDS).'
    26:
      id: 'news_resumption_times'
      doc: 'News and resumption times announced (UTP: T3).'
    27:
      id: 'single_stock_trading_pause_quoting'
      doc: 'Single stock trading pause (UTP: T7).'
    28:
      id: 'qualifications_issues_resolved'
      doc: 'Qualifications issues reviewed/resolved; quotations/trading to resume (UTP: R4).'
    29:
      id: 'filing_requirements_satisfied'
      doc: 'Filing requirements satisfied/resolved; quotations/trading to resume (UTP: R9).'
    30:
      id: 'issuer_news_not_forthcoming'
      doc: 'Issuer news not forthcoming; quotations/trading to resume (UTP: C3).'
    31:
      id: 'qualifications_halt_ended'
      doc: 'Qualifications halt ended; maintenance requirements met; resume (UTP: C4).'
    32:
      id: 'qualifications_halt_concluded'
      doc: 'Qualifications halt concluded; filings met; quotes/trades to resume (UTP: C9).'
    33:
      id: 'regulatory_authority_halt_concluded'
      doc: 'Trade halt concluded by other regulatory authority; quotes/trades to resume (UTP: C11).'
    34:
      id: 'new_issue_available'
      doc: 'New issue available (UTP: R1).'
    35:
      id: 'issue_available'
      doc: 'Issue available (UTP: R2).'
    36:
      id: 'ipo_quotation_released'
      doc: 'IPO security released for quotation (UTP: IPOQ).'
    37:
      id: 'ipo_positioning_window_extension'
      doc: 'IPO security - positioning window extension (UTP: IPOE).'
    38:
      id: 'circuit_breaker_quotation_resumption'
      doc: 'Market-wide circuit breaker quotation resumption (UTP: MWCQ).'
  limit_order_accepted_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  limit_order_accepted_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display-Price Slide instruction.'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single price slide applied to both locking and crossing quotations.'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple price slides applied to both locking and crossing quotations.'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single price slide applied only to locking quotations.'
  limit_order_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id is invalid.'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id has already been used for the current session on this port.'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt to modify or replace a client order that was not found for the current session on this port.'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt to modify, replace, or cancel an order that has already canceled or fully executed.'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol ID is not valid for the current session.'
    6:
      id: 'invalid_price'
      doc: 'Invalid limit price.'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid order quantity.'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid reference price target related to the order attributes.'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid ''Is Hidden'' flag related to the order attributes.'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid order type related to the order attributes.'
    11:
      id: 'invalid_side'
      doc: 'Invalid side.'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid max floor quantity related to the order attributes.'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid maximum replenish quantity range.'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid maximum replenish time range.'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid minimum quantity.'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid locate-required flag related to the order attributes.'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid time in force.'
    18:
      id: 'modification_not_permitted'
      doc: 'Order modification not permitted.'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid market participant identifier.'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid sender comp.'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid ''Is Post Only'' flag related to the order attributes.'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid expire time.'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not permitted during the current trading session.'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not permitted during the current trading status.'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not permitted during the current symbol status.'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid ''Is ISO'' flag related to the order attributes (ISO = Intermarket Sweep Order).'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading is disabled for the MPID on this port based on port MPID settings configuration.'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading is restricted to test symbols only based on port settings configuration.'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading is disabled for the specified order capacity based on port settings configuration.'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'ISO (Intermarket Sweep Order) trading is disabled based on port settings configuration.'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order quantity exceeds the maximum shares limit configured in port settings.'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit price exceeds the maximum acceptable price for the Exchange.'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order notional value exceeds the maximum notional limit configured in port settings.'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id is invalid.'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol is on the restricted list for this port/MPID based on port settings configuration.'
    36:
      id: 'luld_band_breached'
      doc: 'Order limit price is outside LULD (Limit Up-Limit Down) bands and port settings require rejection.'
    37:
      id: 'invalid_price_increment'
      doc: 'Price does not conform to the minimum price variation (tick size).'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction-Only orders for the Open and Close cannot be cancelled, modified, or replaced once the Band Window begins.'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order property is incompatible with an auction-classed order.'
  limit_order_rejected_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  limit_order_rejected_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display-Price Slide instruction.'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single price slide applied to both locking and crossing quotations.'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple price slides applied to both locking and crossing quotations.'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single price slide applied only to locking quotations.'
  market_order_accepted_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  market_order_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id is invalid.'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id has already been used for the current session on this port.'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt to modify or replace a client order that was not found for the current session on this port.'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt to modify, replace, or cancel an order that has already canceled or fully executed.'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol ID is not valid for the current session.'
    6:
      id: 'invalid_price'
      doc: 'Invalid limit price.'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid order quantity.'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid reference price target related to the order attributes.'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid ''Is Hidden'' flag related to the order attributes.'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid order type related to the order attributes.'
    11:
      id: 'invalid_side'
      doc: 'Invalid side.'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid max floor quantity related to the order attributes.'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid maximum replenish quantity range.'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid maximum replenish time range.'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid minimum quantity.'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid locate-required flag related to the order attributes.'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid time in force.'
    18:
      id: 'modification_not_permitted'
      doc: 'Order modification not permitted.'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid market participant identifier.'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid sender comp.'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid ''Is Post Only'' flag related to the order attributes.'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid expire time.'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not permitted during the current trading session.'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not permitted during the current trading status.'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not permitted during the current symbol status.'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid ''Is ISO'' flag related to the order attributes (ISO = Intermarket Sweep Order).'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading is disabled for the MPID on this port based on port MPID settings configuration.'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading is restricted to test symbols only based on port settings configuration.'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading is disabled for the specified order capacity based on port settings configuration.'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'ISO (Intermarket Sweep Order) trading is disabled based on port settings configuration.'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order quantity exceeds the maximum shares limit configured in port settings.'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit price exceeds the maximum acceptable price for the Exchange.'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order notional value exceeds the maximum notional limit configured in port settings.'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id is invalid.'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol is on the restricted list for this port/MPID based on port settings configuration.'
    36:
      id: 'luld_band_breached'
      doc: 'Order limit price is outside LULD (Limit Up-Limit Down) bands and port settings require rejection.'
    37:
      id: 'invalid_price_increment'
      doc: 'Price does not conform to the minimum price variation (tick size).'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction-Only orders for the Open and Close cannot be cancelled, modified, or replaced once the Band Window begins.'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order property is incompatible with an auction-classed order.'
  market_order_rejected_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  cancel_reason:
    1:
      id: 'requested_by_user'
      doc: 'Cancel due to request by client.'
    2:
      id: 'related_to_time_in_force'
      doc: 'Cancel due to time in force expiration.'
    3:
      id: 'related_to_min_qty'
      doc: 'Cancel due to inability to meet minimum quantity.'
    4:
      id: 'reg_nms_violation_no_slide'
      doc: 'Canceled as order would violate Regulation NMS Rule 610(d) by creating a locked or crossed market, and price sliding was either not selected or not applicable.'
    5:
      id: 'marketable_reserve'
      doc: 'Reserve orders will be canceled when deemed marketable at another exchange either at new order entry or replenishment.'
    6:
      id: 'self_match_prevention'
      doc: 'Cancel due to self-match prevention instructions.'
    7:
      id: 'replenishment_canceled_due_to_reserve'
      doc: 'Replenishment canceled related to the Reserve order being canceled or replaced.'
    8:
      id: 'related_to_order_type'
      doc: 'Cancel due to order type e.g.'
    9:
      id: 'canceled_due_to_crossed_markets'
      doc: 'Cancel due to client instruction on crossed markets.'
    10:
      id: 'canceled_due_to_mass_cancel_request'
      doc: 'Cancel due to a mass cancel request.'
    11:
      id: 'exchange_locked_or_crossed_no_slide'
      doc: 'Canceled as order would lock or cross the Exchange book, and price sliding was either not selected or not applicable.'
    12:
      id: 'reg_sho_violation_no_slide'
      doc: 'Canceled as order would violate Regulation SHO Rule 201 by display at or below the National Best Bid during a short sale price test restriction, and price sliding was either not selected or not applicable.'
    13:
      id: 'luld_breached_no_slide'
      doc: 'Canceled as order would violate LULD (Limit Up-Limit Down) price bands per SEC Rule 608, and price sliding was either not selected or not applicable.'
    14:
      id: 'canceled_as_price_breached_luld'
      doc: 'Canceled as the order''s limit price is now outside LULD (Limit Up-Limit Down) price bands after bands narrowed.'
    15:
      id: 'canceled_on_disconnect'
      doc: 'Cancel due to client disconnect from a port with cancel-on-disconnect instructions.'
    16:
      id: 'auction_order_post_cross'
      doc: 'Auction order is canceled because the auction it was eligible for has concluded.'
    17:
      id: 'peg_reference_price_breaches_limit_price'
      doc: 'Pegged order canceled because its calculated reference price moved beyond the order''s limit price (the limit price collared the peg).'
    18:
      id: 'odd_lot_not_executable'
      doc: 'Canceled as the order is of odd lot size and could not be executed against the contra-side liquidity on the TXSE Book.'
  cancel_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id is invalid.'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id has already been used for the current session on this port.'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt to modify or replace a client order that was not found for the current session on this port.'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt to modify, replace, or cancel an order that has already canceled or fully executed.'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol ID is not valid for the current session.'
    6:
      id: 'invalid_price'
      doc: 'Invalid limit price.'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid order quantity.'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid reference price target related to the order attributes.'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid ''Is Hidden'' flag related to the order attributes.'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid order type related to the order attributes.'
    11:
      id: 'invalid_side'
      doc: 'Invalid side.'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid max floor quantity related to the order attributes.'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid maximum replenish quantity range.'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid maximum replenish time range.'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid minimum quantity.'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid locate-required flag related to the order attributes.'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid time in force.'
    18:
      id: 'modification_not_permitted'
      doc: 'Order modification not permitted.'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid market participant identifier.'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid sender comp.'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid ''Is Post Only'' flag related to the order attributes.'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid expire time.'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not permitted during the current trading session.'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not permitted during the current trading status.'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not permitted during the current symbol status.'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid ''Is ISO'' flag related to the order attributes (ISO = Intermarket Sweep Order).'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading is disabled for the MPID on this port based on port MPID settings configuration.'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading is restricted to test symbols only based on port settings configuration.'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading is disabled for the specified order capacity based on port settings configuration.'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'ISO (Intermarket Sweep Order) trading is disabled based on port settings configuration.'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order quantity exceeds the maximum shares limit configured in port settings.'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit price exceeds the maximum acceptable price for the Exchange.'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order notional value exceeds the maximum notional limit configured in port settings.'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id is invalid.'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol is on the restricted list for this port/MPID based on port settings configuration.'
    36:
      id: 'luld_band_breached'
      doc: 'Order limit price is outside LULD (Limit Up-Limit Down) bands and port settings require rejection.'
    37:
      id: 'invalid_price_increment'
      doc: 'Price does not conform to the minimum price variation (tick size).'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction-Only orders for the Open and Close cannot be cancelled, modified, or replaced once the Band Window begins.'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order property is incompatible with an auction-classed order.'
  modify_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id is invalid.'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id has already been used for the current session on this port.'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt to modify or replace a client order that was not found for the current session on this port.'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt to modify, replace, or cancel an order that has already canceled or fully executed.'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol ID is not valid for the current session.'
    6:
      id: 'invalid_price'
      doc: 'Invalid limit price.'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid order quantity.'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid reference price target related to the order attributes.'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid ''Is Hidden'' flag related to the order attributes.'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid order type related to the order attributes.'
    11:
      id: 'invalid_side'
      doc: 'Invalid side.'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid max floor quantity related to the order attributes.'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid maximum replenish quantity range.'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid maximum replenish time range.'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid minimum quantity.'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid locate-required flag related to the order attributes.'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid time in force.'
    18:
      id: 'modification_not_permitted'
      doc: 'Order modification not permitted.'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid market participant identifier.'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid sender comp.'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid ''Is Post Only'' flag related to the order attributes.'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid expire time.'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not permitted during the current trading session.'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not permitted during the current trading status.'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not permitted during the current symbol status.'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid ''Is ISO'' flag related to the order attributes (ISO = Intermarket Sweep Order).'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading is disabled for the MPID on this port based on port MPID settings configuration.'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading is restricted to test symbols only based on port settings configuration.'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading is disabled for the specified order capacity based on port settings configuration.'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'ISO (Intermarket Sweep Order) trading is disabled based on port settings configuration.'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order quantity exceeds the maximum shares limit configured in port settings.'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit price exceeds the maximum acceptable price for the Exchange.'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order notional value exceeds the maximum notional limit configured in port settings.'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id is invalid.'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol is on the restricted list for this port/MPID based on port settings configuration.'
    36:
      id: 'luld_band_breached'
      doc: 'Order limit price is outside LULD (Limit Up-Limit Down) bands and port settings require rejection.'
    37:
      id: 'invalid_price_increment'
      doc: 'Price does not conform to the minimum price variation (tick size).'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction-Only orders for the Open and Close cannot be cancelled, modified, or replaced once the Band Window begins.'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order property is incompatible with an auction-classed order.'
  order_replaced_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  order_replaced_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display-Price Slide instruction.'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single price slide applied to both locking and crossing quotations.'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple price slides applied to both locking and crossing quotations.'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single price slide applied only to locking quotations.'
  replace_rejected_reason:
    1:
      id: 'invalid_client_order_id'
      doc: 'Client Order Id is invalid.'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id has already been used for the current session on this port.'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt to modify or replace a client order that was not found for the current session on this port.'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt to modify, replace, or cancel an order that has already canceled or fully executed.'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol ID is not valid for the current session.'
    6:
      id: 'invalid_price'
      doc: 'Invalid limit price.'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid order quantity.'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid reference price target related to the order attributes.'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid ''Is Hidden'' flag related to the order attributes.'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid order type related to the order attributes.'
    11:
      id: 'invalid_side'
      doc: 'Invalid side.'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid max floor quantity related to the order attributes.'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid maximum replenish quantity range.'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid maximum replenish time range.'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid minimum quantity.'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid locate-required flag related to the order attributes.'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid time in force.'
    18:
      id: 'modification_not_permitted'
      doc: 'Order modification not permitted.'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid market participant identifier.'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid sender comp.'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid ''Is Post Only'' flag related to the order attributes.'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid expire time.'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not permitted during the current trading session.'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not permitted during the current trading status.'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not permitted during the current symbol status.'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid ''Is ISO'' flag related to the order attributes (ISO = Intermarket Sweep Order).'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading is disabled for the MPID on this port based on port MPID settings configuration.'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading is restricted to test symbols only based on port settings configuration.'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading is disabled for the specified order capacity based on port settings configuration.'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'ISO (Intermarket Sweep Order) trading is disabled based on port settings configuration.'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order quantity exceeds the maximum shares limit configured in port settings.'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit price exceeds the maximum acceptable price for the Exchange.'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order notional value exceeds the maximum notional limit configured in port settings.'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id is invalid.'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol is on the restricted list for this port/MPID based on port settings configuration.'
    36:
      id: 'luld_band_breached'
      doc: 'Order limit price is outside LULD (Limit Up-Limit Down) bands and port settings require rejection.'
    37:
      id: 'invalid_price_increment'
      doc: 'Price does not conform to the minimum price variation (tick size).'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction-Only orders for the Open and Close cannot be cancelled, modified, or replaced once the Band Window begins.'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order property is incompatible with an auction-classed order.'
  replace_rejected_self_match_instruction:
    0:
      id: 'no_self_match_prevention'
      doc: 'Self-match prevention is disabled.'
    1:
      id: 'cancel_newest'
      doc: 'Cancels the incoming order.'
    2:
      id: 'cancel_oldest'
      doc: 'Cancels the resting order.'
    3:
      id: 'cancel_both'
      doc: 'Cancels both orders entirely regardless of size.'
    4:
      id: 'cancel_smallest'
      doc: 'If orders are equal size: cancels both.'
    5:
      id: 'decrement_and_cancel'
      doc: 'If orders are equal size: cancels both.'
  replace_rejected_price_slide_instruction:
    0:
      id: 'no_price_slide'
      doc: 'No Display-Price Slide instruction.'
    1:
      id: 'single_price_slide_on_lock_and_cross'
      doc: 'Single price slide applied to both locking and crossing quotations.'
    2:
      id: 'multiple_price_slides_on_lock_and_cross'
      doc: 'Multiple price slides applied to both locking and crossing quotations.'
    3:
      id: 'single_price_slide_lock_only'
      doc: 'Single price slide applied only to locking quotations.'
  liquidity_indicator:
    0:
      id: 'removed_hidden_liquidity'
      doc: 'Removed hidden liquidity.'
    1:
      id: 'removed_displayed_liquidity'
      doc: 'Removed displayed liquidity.'
    2:
      id: 'added_hidden_liquidity'
      doc: 'Added hidden liquidity.'
    3:
      id: 'added_displayed_liquidity'
      doc: 'Added displayed liquidity.'
    4:
      id: 'auction'
      doc: 'Execution from an auction cross.'
  restatement_reason:
    1:
      id: 'reserve_replenished'
      doc: 'A new displayed slice of a reserve order has been added to the displayed book.'
    2:
      id: 'repriced'
      doc: 'A reprice-eligible order has been repriced to a new price.'
    3:
      id: 'post_auction'
      doc: 'Orders staged awaiting the result of the auction with unfilled residual have been reinstated into continuous book.'
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
      doc: 'Client Order Id is invalid.'
    2:
      id: 'duplicate_client_order_id'
      doc: 'Client Order Id has already been used for the current session on this port.'
    3:
      id: 'unknown_original_client_order_id'
      doc: 'Attempt to modify or replace a client order that was not found for the current session on this port.'
    4:
      id: 'no_longer_on_book'
      doc: 'Attempt to modify, replace, or cancel an order that has already canceled or fully executed.'
    5:
      id: 'invalid_symbol'
      doc: 'Symbol ID is not valid for the current session.'
    6:
      id: 'invalid_price'
      doc: 'Invalid limit price.'
    7:
      id: 'invalid_order_quantity'
      doc: 'Invalid order quantity.'
    8:
      id: 'invalid_reference_price_target'
      doc: 'Invalid reference price target related to the order attributes.'
    9:
      id: 'invalid_is_hidden_flag'
      doc: 'Invalid ''Is Hidden'' flag related to the order attributes.'
    10:
      id: 'invalid_order_type'
      doc: 'Invalid order type related to the order attributes.'
    11:
      id: 'invalid_side'
      doc: 'Invalid side.'
    12:
      id: 'invalid_max_floor_quantity'
      doc: 'Invalid max floor quantity related to the order attributes.'
    13:
      id: 'invalid_max_replenish_quantity_range'
      doc: 'Invalid maximum replenish quantity range.'
    14:
      id: 'invalid_max_replenish_time_range'
      doc: 'Invalid maximum replenish time range.'
    15:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid minimum quantity.'
    16:
      id: 'invalid_locate_required_flag'
      doc: 'Invalid locate-required flag related to the order attributes.'
    17:
      id: 'invalid_time_in_force'
      doc: 'Invalid time in force.'
    18:
      id: 'modification_not_permitted'
      doc: 'Order modification not permitted.'
    19:
      id: 'invalid_mpid'
      doc: 'Invalid market participant identifier.'
    20:
      id: 'invalid_sender_comp'
      doc: 'Invalid sender comp.'
    21:
      id: 'invalid_is_post_only_flag'
      doc: 'Invalid ''Is Post Only'' flag related to the order attributes.'
    22:
      id: 'invalid_expire_time'
      doc: 'Invalid expire time.'
    23:
      id: 'invalid_for_trading_session'
      doc: 'Not permitted during the current trading session.'
    24:
      id: 'invalid_for_trading_status'
      doc: 'Not permitted during the current trading status.'
    25:
      id: 'invalid_for_symbol_status'
      doc: 'Not permitted during the current symbol status.'
    26:
      id: 'invalid_is_iso_flag'
      doc: 'Invalid ''Is ISO'' flag related to the order attributes (ISO = Intermarket Sweep Order).'
    27:
      id: 'trading_disabled_for_mpid_on_port'
      doc: 'Trading is disabled for the MPID on this port based on port MPID settings configuration.'
    28:
      id: 'trading_disabled_for_non_test_symbols'
      doc: 'Trading is restricted to test symbols only based on port settings configuration.'
    29:
      id: 'trading_disabled_for_order_capacity'
      doc: 'Trading is disabled for the specified order capacity based on port settings configuration.'
    30:
      id: 'trading_disabled_for_iso'
      doc: 'ISO (Intermarket Sweep Order) trading is disabled based on port settings configuration.'
    31:
      id: 'maximum_order_quantity_breached'
      doc: 'Order quantity exceeds the maximum shares limit configured in port settings.'
    32:
      id: 'maximum_price_breached'
      doc: 'Limit price exceeds the maximum acceptable price for the Exchange.'
    33:
      id: 'maximum_notional_breached'
      doc: 'Order notional value exceeds the maximum notional limit configured in port settings.'
    34:
      id: 'invalid_mass_cancel_request_id'
      doc: 'Mass Cancel Request Id is invalid.'
    35:
      id: 'symbol_on_restricted_list'
      doc: 'Symbol is on the restricted list for this port/MPID based on port settings configuration.'
    36:
      id: 'luld_band_breached'
      doc: 'Order limit price is outside LULD (Limit Up-Limit Down) bands and port settings require rejection.'
    37:
      id: 'invalid_price_increment'
      doc: 'Price does not conform to the minimum price variation (tick size).'
    38:
      id: 'auction_order_not_cancelable'
      doc: 'Auction-Only orders for the Open and Close cannot be cancelled, modified, or replaced once the Band Window begins.'
    39:
      id: 'invalid_for_auction_order'
      doc: 'Order property is incompatible with an auction-classed order.'

