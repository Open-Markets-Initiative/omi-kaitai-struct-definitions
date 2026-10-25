# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CxaEquities BinaryOrderEntry Boe3 v1.0.20
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.0.20
#   Date: 05/22/2026
#   Specification: CXA Equities BOEv3 Specification.pdf
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
  id: cboe_cxaequities_binaryorderentry_boe3_v1_0_20_firm
  title: Cboe CxaEquities BinaryOrderEntry Boe3 v1.0.20
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Australia Binary Order Entry Boe3 v1.0.20'
doc-ref: https://www.cboe.com/au/equities/support/technical/

seq:
  - id: firm_message_header
    type: firm_message_header_struct
    doc: 'Message header of a packet sent by the firm'
  - id: firm_message
    type:
      switch-on: firm_message_header.firm_message_type
      cases:
        'firm_message_type::login_request_message': login_request_message
        'firm_message_type::new_order_au_equities_v_1': new_order_au_equities_v_1
        'firm_message_type::new_order_au_equities_v_2': new_order_au_equities_v_2
        'firm_message_type::modify_order_au_equities_v_1': modify_order_au_equities_v_1
        'firm_message_type::modify_order_au_equities_v_2': modify_order_au_equities_v_2
        'firm_message_type::cancel_order_au_equities_v_1': cancel_order_au_equities_v_1
        'firm_message_type::purge_orders_au_equities_v_1': purge_orders_au_equities_v_1

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
  new_order_au_equities_v_1:
    seq:
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Used by a trading participant to provide a broker cross reference'
      - id: trading_participant_id
        type: u2
        doc: 'The (4 digit) trading participant identifier'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id chosen by the participant'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'All values not defined below are rejected. Ignored if blank (0x00)'
      - id: order_qty
        type: u4
        doc: 'Order quantity. System limit is 999,999,999'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: price
        type: decimal_s8_4
        doc: 'Price of the order. Implied decimal with scale 1e-4'
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
        size: 6
        encoding: ASCII
        doc: 'Instrument symbol (upper case alphanumeric)'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: min_qty
        type: u4
        doc: 'Minimum fill quantity for orders'
      - id: max_floor
        type: u4
        doc: 'Portion of OrderQty to display. Used for iceberg orders and hidden orders'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required for GTD order (TimeInForce = 6), ExpireTime specifies the date-time (in UTC) when the order expires. Nanoseconds since Unix epoch'
      - id: clearing_participant_id
        type: u4
        doc: 'The CHESS clearing participant identifier. Must be a valid 5-digit CHESS PID'
      - id: clearing_account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Supplemental identifier'
      - id: undisclosed
        type: u1
        enum: undisclosed
        doc: 'If true, indicates an undisclosed order'
      - id: client_cross_ref
        type: str
        size: 15
        encoding: ASCII
        doc: 'Can be used to provide additional participant-side cross reference information'
      - id: short_sell_naked_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is naked'
      - id: short_sell_covered_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is covered'
      - id: short_sell_long_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is owned by the participant who placed the order'
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
      - id: meqse
        type: u1
        enum: meqse
        doc: 'If true, then any single fill will be for at least MinQty shares'
      - id: origin_of_trans
        type: str
        size: 20
        encoding: ASCII
        doc: 'Market Integrity Rule defined field for Origin of Order (ex. ACN, ABN, CHESS HIN)'
      - id: intermediary_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market Integrity Rule defined field for Intermediary Identifier'
      - id: directed_wholesale_indicator
        type: u1
        enum: directed_wholesale_indicator
        doc: 'Market Integrity Rule defined field to identify wholesale participant'
      - id: remove_crossing_from_clearing
        type: u1
        enum: remove_crossing_from_clearing
        doc: 'If Y, instructs Cboe Australia on how to process crossed trades with CHESS'
      - id: broker_preferencing
        type: u1
        enum: broker_preferencing
        doc: 'Broker preferencing instruction. Nullable, Apply Port Default = 0'
  new_order_au_equities_v_2:
    seq:
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Used by a trading participant to provide a broker cross reference'
      - id: trading_participant_id
        type: u2
        doc: 'The (4 digit) trading participant identifier'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id chosen by the participant'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'All values not defined below are rejected. Ignored if blank (0x00)'
      - id: order_qty
        type: u4
        doc: 'Order quantity. System limit is 999,999,999'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: price
        type: decimal_s8_4
        doc: 'Price of the order. Implied decimal with scale 1e-4'
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
        size: 6
        encoding: ASCII
        doc: 'Instrument symbol (upper case alphanumeric)'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: min_qty
        type: u4
        doc: 'Minimum fill quantity for orders'
      - id: max_floor
        type: u4
        doc: 'Portion of OrderQty to display. Used for iceberg orders and hidden orders'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required for GTD order (TimeInForce = 6), ExpireTime specifies the date-time (in UTC) when the order expires. Nanoseconds since Unix epoch'
      - id: clearing_participant_id
        type: u4
        doc: 'The CHESS clearing participant identifier. Must be a valid 5-digit CHESS PID'
      - id: clearing_account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Supplemental identifier'
      - id: undisclosed
        type: u1
        enum: undisclosed
        doc: 'If true, indicates an undisclosed order'
      - id: client_cross_ref
        type: str
        size: 15
        encoding: ASCII
        doc: 'Can be used to provide additional participant-side cross reference information'
      - id: short_sell_naked_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is naked'
      - id: short_sell_covered_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is covered'
      - id: short_sell_long_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is owned by the participant who placed the order'
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
      - id: meqse
        type: u1
        enum: meqse
        doc: 'If true, then any single fill will be for at least MinQty shares'
      - id: origin_of_trans
        type: str
        size: 20
        encoding: ASCII
        doc: 'Market Integrity Rule defined field for Origin of Order (ex. ACN, ABN, CHESS HIN)'
      - id: intermediary_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Market Integrity Rule defined field for Intermediary Identifier'
      - id: directed_wholesale_indicator
        type: u1
        enum: directed_wholesale_indicator
        doc: 'Market Integrity Rule defined field to identify wholesale participant'
      - id: remove_crossing_from_clearing
        type: u1
        enum: remove_crossing_from_clearing
        doc: 'If Y, instructs Cboe Australia on how to process crossed trades with CHESS'
      - id: broker_preferencing
        type: u1
        enum: broker_preferencing
        doc: 'Broker preferencing instruction. Nullable, Apply Port Default = 0'
      - id: routing_inst
        type: u1
        enum: routing_inst
        doc: 'Indicates the order is a Post Only order'
      - id: display_indicator
        type: u1
        enum: display_indicator
        doc: 'Treatment of Post Only orders on entry if creating a locked NBBO'
      - id: expire_date
        type: u4
        doc: 'Only applicable for TimeInForce (59) = 6 (GTD) orders. Specifies the date on which a GTD order will expire'
  modify_order_au_equities_v_1:
    seq:
      - id: trading_participant_id
        type: u2
        doc: 'The (4 digit) trading participant identifier'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id chosen by the participant'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'All values not defined below are rejected. Ignored if blank (0x00)'
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
        doc: 'Price of the order. Implied decimal with scale 1e-4'
      - id: min_qty
        type: u4
        doc: 'Minimum fill quantity for orders'
      - id: max_floor
        type: u4
        doc: 'Portion of OrderQty to display. Used for iceberg orders and hidden orders'
      - id: short_sell_naked_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is naked'
      - id: short_sell_covered_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is covered'
      - id: short_sell_long_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is owned by the participant who placed the order'
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        doc: 'Cancel original order if modification fails. Nullable, Apply Port Default = 0'
  modify_order_au_equities_v_2:
    seq:
      - id: trading_participant_id
        type: u2
        doc: 'The (4 digit) trading participant identifier'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id chosen by the participant'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'All values not defined below are rejected. Ignored if blank (0x00)'
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
        doc: 'Price of the order. Implied decimal with scale 1e-4'
      - id: min_qty
        type: u4
        doc: 'Minimum fill quantity for orders'
      - id: max_floor
        type: u4
        doc: 'Portion of OrderQty to display. Used for iceberg orders and hidden orders'
      - id: short_sell_naked_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is naked'
      - id: short_sell_covered_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is covered'
      - id: short_sell_long_qty
        type: u4
        doc: 'Defines the portion of OrderQty (38) that is owned by the participant who placed the order'
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        doc: 'Cancel original order if modification fails. Nullable, Apply Port Default = 0'
      - id: expire_date
        type: u4
        doc: 'Only applicable for TimeInForce (59) = 6 (GTD) orders. Specifies the date on which a GTD order will expire'
  cancel_order_au_equities_v_1:
    seq:
      - id: trading_participant_id
        type: u2
        doc: 'The (4 digit) trading participant identifier'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ClOrdID of the original order'
  purge_orders_au_equities_v_1:
    seq:
      - id: trading_participant_id
        type: u2
        doc: 'The (4 digit) trading participant identifier'
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        doc: 'At least one character must be provided (PID Filter)'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'User-defined identifier of the mass cancel or purge request'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Instrument symbol (upper case alphanumeric)'
      - id: target_matching_unit
        type: u1
        doc: 'Matching unit to which the purge should be restricted. Zero is considered all matching engines'
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
    3001:
      id: 'new_order_au_equities_v_1'
      doc: 'Submission of a new order to Cboe Australia'
    3005:
      id: 'new_order_au_equities_v_2'
      doc: 'Submission of a new order to Cboe Australia, with Post Only and multi-day order fields'
    3002:
      id: 'modify_order_au_equities_v_1'
      doc: 'Request to modify an order'
    3006:
      id: 'modify_order_au_equities_v_2'
      doc: 'Request to modify an order, with ExpireDate for multi-day orders'
    3003:
      id: 'cancel_order_au_equities_v_1'
      doc: 'Request to cancel a single order'
    3004:
      id: 'purge_orders_au_equities_v_1'
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
  exec_inst:
    0x50:
      id: 'market_peg'
      doc: 'peg Buy [Sell] to NBBO Offer [Bid], one tick within NBBO'
    0x52:
      id: 'primary_peg'
      doc: 'peg Buy [Sell] to NBBO Bid [Offer], one tick within NBBO'
    0x4d:
      id: 'midpoint'
      doc: 'peg to NBBO Midpoint'
    0x6a:
      id: 'best_x_order'
      doc: 'insert the limit order at the best visible price on same side. Not applicable to IOC or FOK.'
    0x6b:
      id: 'market_x_order'
      doc: 'insert the limit order against the best visible price on opposite side'
  ord_type:
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x35:
      id: 'market_on_close_moc'
      doc: 'Market On Close Moc'
    0x50:
      id: 'pegged'
      doc: 'Pegged'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x58:
      id: 'mixed'
      doc: 'Mixed'
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
  time_in_force:
    0x30:
      id: 'day_default'
      doc: 'Day Default'
    0x31:
      id: 'gtc_good_till_cancel'
      doc: 'Gtc Good Till Cancel'
    0x33:
      id: 'ioc'
      doc: 'portion not filled immediately is cancelled.'
    0x34:
      id: 'fok'
      doc: 'an IOC where the entire size must be filled immediately, otherwise the order will be cancelled back.'
    0x36:
      id: 'gtd'
      doc: 'Expires at the specified ExpireTime or end of day, or ExpireDate for multi-day orders.'
  undisclosed:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_field'
      doc: 'False'
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
    0x58:
      id: 'booking_purpose_trade'
      doc: 'the resultant trade is reported to CHESS as a booking purpose trade and as a cancel on public market data feeds.'
  meqse:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_field'
      doc: 'False'
  directed_wholesale_indicator:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_field'
      doc: 'False'
  remove_crossing_from_clearing:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_field'
      doc: 'False'
  broker_preferencing:
    0x59:
      id: 'match_with_other_orders_using_broker_preferencing_when_possible'
      doc: 'Match With Other Orders Using Broker Preferencing When Possible'
    0x4e:
      id: 'do_not_apply_broker_preferencing'
      doc: 'Do Not Apply Broker Preferencing'
  routing_inst:
    0x50:
      id: 'post_only_never_take_liquidity'
      doc: 'Post Only Never Take Liquidity'
    0x46:
      id: 'focused_nearpoint'
      doc: 'only eligible to trade with opposing Farpoint'
  display_indicator:
    0x56:
      id: 'post_only_orders_which_would_lock_the_nbbo_on_entry_are_allowed_to_do_so'
      doc: 'Default'
    0x52:
      id: 'cancel_back_a_post_only_order_on_entry_if_it_were_to_create_a_locked_nbbo'
      doc: 'Cancel Back A Post Only Order On Entry If It Were To Create A Locked Nbbo'
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
    3501:
      id: 'order_acknowledgement_au_equities_v_1'
      doc: 'Order Acknowledgement messages are sent in response to a New Order message'
    3502:
      id: 'order_rejected_au_equities_v_1'
      doc: 'Order Rejected messages are sent in response to a New Order which must be rejected'
    3503:
      id: 'order_modified_au_equities_v_1'
      doc: 'Order Modified messages are sent in response to a Modify Order to indicate that the order has been successfully modified'
    3504:
      id: 'modify_rejected_au_equities_v_1'
      doc: 'Modify Rejected messages are sent in response to a Modify Order for an order which cannot be modified'
    3505:
      id: 'order_restated_au_equities_v_1'
      doc: 'Order restatement for an iceberg reload or a Self-Trade Protection reduction or cancellation'
    3506:
      id: 'order_execution_au_equities_v_1'
      doc: 'An Order Execution is sent for each fill on an order'
    3507:
      id: 'order_cancelled_au_equities_v_1'
      doc: 'Order Cancelled message'
    3508:
      id: 'cancel_rejected_au_equities_v_1'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur'
    3509:
      id: 'execution_restatement_au_equities_v_1'
      doc: 'Order Execution Restated messages will be issued for all (unbroken) fills of MOC orders after the closing price has been determined'
    3510:
      id: 'purge_acknowledgement_au_equities_v_1'
      doc: 'A Purge Acknowledgment is an unsequenced message sent when a Purge Orders message requesting an order purge has completed cancelling all individual orders'
    3511:
      id: 'purge_rejected_au_equities_v_1'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur'
    3512:
      id: 'trade_cancel_correct_au_equities_v_1'
      doc: 'Used to provide notification that a trade has been cancelled (busted) or corrected (price change only)'
    3513:
      id: 'order_modified_au_equities_v_2'
      doc: 'Order Modified messages are sent in response to a Modify Order, with ExpireDate for multi-day orders'
    3514:
      id: 'carried_restatement_au_equities_v_1'
      doc: 'The Carried Restatement message is used to indicate the restoration of a multi-day GTC or GTD orders at the start of a new business day'
    3515:
      id: 'done_for_day_au_equities_v_1'
      doc: 'Done For Day messages represent orders persisted during the current day session to carry over to the next session'
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
    0x43:
      id: 'auction_uncrossing'
      doc: 'Auction Uncrossing'
  sub_liquidity_indicator:
    0x49:
      id: 'added_hidden_liquidity_that_was_price_improved'
      doc: 'Added Hidden Liquidity That Was Price Improved'
    0x4a:
      id: 'added_liquidity_nbbo_joiner'
      doc: 'Added Liquidity Nbbo Joiner'
    0x4b:
      id: 'added_liquidity_from_the_hidden_reserve_portion_of_an_iceberg_order'
      doc: 'Added Liquidity From The Hidden Reserve Portion Of An Iceberg Order'
    0x53:
      id: 'added_liquidity_nbbo_setter'
      doc: 'Added Liquidity Nbbo Setter'
    0x4f:
      id: 'opening_auction_or_intraday_auction_trade'
      doc: 'Opening Auction Or Intraday Auction Trade'
    0x65:
      id: 'closing_auction_trade'
      doc: 'Closing Auction Trade'
    0x68:
      id: 'halt_auction_re_opening'
      doc: 'Halt Auction Re Opening'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Australia will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_centre'
      doc: 'Message directed to the DR data centre'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
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
      id: 'order_received_by_cboe_australia_during_replay'
      doc: 'Order Received By Cboe Australia During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Australia will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_centre'
      doc: 'Message directed to the DR data centre'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
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
      id: 'order_received_by_cboe_australia_during_replay'
      doc: 'Order Received By Cboe Australia During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  restatement_reason:
    0x72:
      id: 'iceberg_order_reload'
      doc: 'Iceberg Order Reload'
    0x57:
      id: 'would_have_selftraded'
      doc: 'Would Have Selftraded'
    0x52:
      id: 'replaced_by_another_port_ie_purge_amend_port'
      doc: 'Replaced By Another Port Ie Purge Amend Port'
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
    0x35:
      id: 'mixed'
      doc: 'Mixed'
    0x36:
      id: 'cross_as_mixed'
      doc: 'Cross As Mixed'
  on_market_cross_type:
    0x42:
      id: 'trade_was_the_result_of_a_broker_preferenced_crossing'
      doc: 'Trade Was The Result Of A Broker Preferenced Crossing'
  trade_report_type:
    0x58:
      id: 'booking_purpose_trade'
      doc: 'Booking Purpose Trade'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Australia will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_centre'
      doc: 'Message directed to the DR data centre'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
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
      id: 'order_received_by_cboe_australia_during_replay'
      doc: 'Order Received By Cboe Australia During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Australia will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_centre'
      doc: 'Message directed to the DR data centre'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
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
      id: 'order_received_by_cboe_australia_during_replay'
      doc: 'Order Received By Cboe Australia During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  exec_restatement_reason:
    0x52:
      id: 'market_on_close_repricing'
      doc: 'Market On Close Repricing'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Most rejects due to field validation errors will be reported with a reason of Admin.'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate ClOrdID detected. Note that Cboe Australia will not detect every possible occurrence of a duplicate by a participant.'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_centre'
      doc: 'Message directed to the DR data centre'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
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
      id: 'order_received_by_cboe_australia_during_replay'
      doc: 'Order Received By Cboe Australia During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'

