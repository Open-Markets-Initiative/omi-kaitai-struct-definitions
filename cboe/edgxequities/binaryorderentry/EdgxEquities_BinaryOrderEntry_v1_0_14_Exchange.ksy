# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgxEquities BinaryOrderEntry Boe3 v1.0.14
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.0.14
#   Date: 09/23/2026
#   Specification: technical-specifications-cboe-titanium-u-s-equities-boev3-specification.pdf
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
  id: cboe_edgxequities_binaryorderentry_boe3_v1_0_14_exchange
  title: Cboe EdgxEquities BinaryOrderEntry Boe3 v1.0.14
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edgx Equities Binary Order Entry Boe3 v1.0.14'
doc-ref: https://www.cboe.com/us/equities/support/technical/

seq:
  - id: exchange_message_header
    type: exchange_message_header_struct
    doc: 'Message header of a packet sent by the exchange'
  - id: exchange_message
    type:
      switch-on: exchange_message_header.exchange_message_type
      cases:
        'exchange_message_type::login_response_message': login_response_message
        'exchange_message_type::logout_response_message': logout_response_message
        'exchange_message_type::order_acknowledgement_us_equities_v_1': order_acknowledgement_us_equities_v_1
        'exchange_message_type::order_rejected_us_equities_v_1': order_rejected_us_equities_v_1
        'exchange_message_type::order_modified_us_equities_v_1': order_modified_us_equities_v_1
        'exchange_message_type::order_restated_us_equities_v_1': order_restated_us_equities_v_1
        'exchange_message_type::modify_rejected_us_equities_v_1': modify_rejected_us_equities_v_1
        'exchange_message_type::order_cancelled_us_equities_v_1': order_cancelled_us_equities_v_1
        'exchange_message_type::cancel_rejected_us_equities_v_1': cancel_rejected_us_equities_v_1
        'exchange_message_type::order_execution_us_equities_v_1': order_execution_us_equities_v_1
        'exchange_message_type::trade_cancel_correct_us_equities_v_1': trade_cancel_correct_us_equities_v_1
        'exchange_message_type::purge_rejected_us_equities_v_1': purge_rejected_us_equities_v_1
        'exchange_message_type::reset_risk_acknowledgement_us_equities_v_1': reset_risk_acknowledgement_us_equities_v_1
        'exchange_message_type::purge_acknowledgement_us_equities_v_1': purge_acknowledgement_us_equities_v_1

types:
  exchange_message_header_struct:
    seq:
      - id: start_of_message
        type: u2
        doc: 'B0 E3 (58288)'
      - id: message_length
        type: u2
        doc: 'Number of bytes for the message, including this field but not including the two bytes of the StartOfMessage field'
      - id: exchange_message_type
        type: u2
        enum: exchange_message_type
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
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted, or the reason for the rejection'
      - id: login_response_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional information about the reason for rejection. ASCII NUL (0x00) filled on the right, if necessary'
      - id: client_sequence
        type: u4
        doc: 'Last inbound (TPH to CFE) message sequence number processed by CFE on this port'
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
  logout_response_message:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'reason for the logout'
      - id: logout_reason_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional information about the reason for logout'
  order_acknowledgement_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: display_price
        type: decimal_s8_6
        doc: 'Only present when order is fully or partially booked. Implied decimal with scale 1e-6'
      - id: working_price
        type: decimal_s8_6
        doc: 'If price had to be adjusted to a less aggressive value for some reason, then the adjusted price will be reported here, otherwise equals Price. Implied decimal with scale 1e-6'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional information about an execution. Nullable, No Additional Information = 0'
  order_rejected_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Single character code for an order rejection reason'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
  order_modified_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: max_floor
        type: u4
        doc: 'Portion of OrderQty to display'
      - id: order_qty
        type: u4
        doc: 'Order quantity'
      - id: stop_px
        type: decimal_s8_6
        doc: 'Stop price. Implied decimal with scale 1e-6'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: display_price
        type: decimal_s8_6
        doc: 'Only present when order is fully or partially booked. Implied decimal with scale 1e-6'
      - id: working_price
        type: decimal_s8_6
        doc: 'If price had to be adjusted to a less aggressive value for some reason, then the adjusted price will be reported here, otherwise equals Price. Implied decimal with scale 1e-6'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: secondary_order_id
        type: u8
        doc: 'Denotes an alternative OrderID which is present on Cboe market data feeds'
  order_restated_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format'
      - id: order_restatement_reason
        type: u1
        enum: order_restatement_reason
        doc: 'The reason for this Order Restated message'
      - id: order_qty
        type: u4
        doc: 'Order quantity'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: display_price
        type: decimal_s8_6
        doc: 'Only present when order is fully or partially booked. Implied decimal with scale 1e-6'
      - id: working_price
        type: decimal_s8_6
        doc: 'If price had to be adjusted to a less aggressive value for some reason, then the adjusted price will be reported here, otherwise equals Price. Implied decimal with scale 1e-6'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: secondary_order_id
        type: u8
        doc: 'Denotes an alternative OrderID which is present on Cboe market data feeds'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_6
        doc: 'Price of this fill. Implied decimal with scale 1e-6'
      - id: cmc_match_qty
        type: u4
        doc: 'Matched size for CMC matching session'
  modify_rejected_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Single character code for the Modify Rejection reason'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
  order_cancelled_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Single character code for the cancellation reason'
  cancel_rejected_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Single character code for the cancellation Rejection reason'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
  order_execution_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: exec_id
        type: u8
        doc: 'Execution ID. Unique across all matching units on a given day'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_6
        doc: 'Price of this fill. Implied decimal with scale 1e-6'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional information about an execution. Nullable, No Additional Information = 0'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'All externally matched (routed) executions will identify the away exchange'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates fee associated with an execution'
      - id: access_fee
        type: decimal_s8_5
        doc: 'Transaction fee or rebate, inclusive of earned tiers, for the trade. Implied decimal with scale 1e-5'
  trade_cancel_correct_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: exec_ref_id
        type: u8
        doc: 'Refers to the ExecID of the fill being cancelled or corrected'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional information about an execution. Nullable, No Additional Information = 0'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID that will clear the trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Supplemental identifier'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_6
        doc: 'Price of this fill. Implied decimal with scale 1e-6'
      - id: corrected_price
        type: decimal_s8_6
        doc: 'For trade corrections, this is the new trade price. Implied decimal with scale 1e-6'
      - id: orig_time
        type: nanosecond_timestamp
        doc: 'The date and time of the original trade, in GMT. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Order capacity'
  purge_rejected_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Copied from the MassCancelID passed on the original Purge Orders message'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Single character code for a purge rejection reason'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
  reset_risk_acknowledgement_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'User defined identifier of a Reset Risk message'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: 'Result of a Reset Risk message'
  purge_acknowledgement_us_equities_v_1:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages received by the order handler which have not yet been acknowledged by the matching engine'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction Time. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Copied from the MassCancelID passed on the original Purge Orders message'
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled'
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
  decimal_s8_5:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000.0

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
    0x0fa1:
      id: 'new_order_us_equities_v_1'
      doc: 'Submission of a new order to Cboe'
    0x0fa6:
      id: 'new_order_short_us_equities_v_1'
      doc: 'Submission of a new order to Cboe'
    0x0fa3:
      id: 'cancel_order_us_equities_v_1'
      doc: 'Request to cancel a single order'
    0x0fa2:
      id: 'modify_order_us_equities_v_1'
      doc: 'Request to modify an order'
    0x0fa5:
      id: 'purge_orders_us_equities_v_1'
      doc: 'Request to cancel a group of orders across all of the firm''s sessions'
    0x0fa4:
      id: 'reset_risk_us_equities_v_1'
      doc: 'Reset or release Firm, Symbol, or Risk Group ID level lockout conditions resulting from risk profile trips or self-imposed lockouts issued via Purge Orders messages'
  replay_instruction:
    0x46:
      id: 'fail_if_unit_not_specified'
      doc: 'Fail If Unit Not Specified'
    0x52:
      id: 'replay_any_unspecified_unit_from_zero'
      doc: 'Replay Any Unspecified Unit From Zero'
    0x53:
      id: 'skip_replay_of_unspecified_units'
      doc: 'Skip Replay Of Unspecified Units'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x35:
      id: 'sell_short_client_affirms_ability_to_borrow'
      doc: 'Sell Short Client Affirms Ability To Borrow'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  exec_inst:
    0x66:
      id: 'intermarket_sweep_directed_or_book_post_only'
      doc: 'Intermarket Sweep Directed Or Book Post Only'
    0x50:
      id: 'market_peg_peg_buy_sell_to_nbbo_offer_bid'
      doc: 'Market Peg Peg Buy Sell To Nbbo Offer Bid'
    0x51:
      id: 'market_maker_peg'
      doc: 'See Cboe Titanium U.S. Equities Market Maker Specification'
    0x52:
      id: 'primary_peg_peg_buy_sell_to_nbb_bid_offer'
      doc: 'Primary Peg Peg Buy Sell To Nbb Bid Offer'
    0x55:
      id: 'supplemental_peg_order'
      doc: 'Supplemental Peg Order'
    0x4d:
      id: 'midpoint_peg_to_nbbo_midpoint'
      doc: 'Midpoint Peg To Nbbo Midpoint'
    0x6d:
      id: 'midpoint_peg_to_nbbo_midpoint_but_do_not_match_when_nbbo_is_locked'
      doc: 'Midpoint Peg To Nbbo Midpoint But Do Not Match When Nbbo Is Locked'
    0x4c:
      id: 'alternate_midpoint_less_aggressive_of_midpoint_and_1_tick_inside_nbbo'
      doc: 'Alternate Midpoint Less Aggressive Of Midpoint And 1 Tick Inside Nbbo'
    0x64:
      id: 'midpoint_discretionary_order'
      doc: 'EDGA and EDGX'
    0x65:
      id: 'midpoint_discretionary_order_with_quote_depletion_protection'
      doc: 'EDGA and EDGX'
    0x72:
      id: 'late_for_use_with_auction_only_orders'
      doc: 'BZX; see the Cboe Titanium U.S. Equities Auction Process Specification'
    0x6f:
      id: 'listing_market_opening_for_rooc_rout_strategy_only'
      doc: 'BZX and EDGX'
    0x63:
      id: 'listing_market_close_for_rooc_rout_strategy_only'
      doc: 'BZX and EDGX'
    0x61:
      id: 'both_listing_market_open_and_close'
      doc: 'BZX and EDGX; for ROOC RoutStrategy strategy only; also eligible for participation in halt auctions'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit_default'
      doc: 'Limit Default'
    0x33:
      id: 'stop'
      doc: 'Stop'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit'
    0x50:
      id: 'pegged'
      doc: 'Pegged'
  time_in_force:
    0x30:
      id: 'day_default'
      doc: 'Early Trading Session until end of Regular Session (EDGX only effective 12/07/26: Overnight Trading Session until end of Regular Session)'
    0x31:
      id: 'gtc_allowed_but_treated_as_day'
      doc: 'Gtc Allowed But Treated As Day'
    0x32:
      id: 'at_the_open_bzx_only_and_cboe_listed_securities_only'
      doc: 'At The Open Bzx Only And Cboe Listed Securities Only'
    0x33:
      id: 'ioc_portion_not_filled_immediately_is_cancelled'
      doc: 'Ioc Portion Not Filled Immediately Is Cancelled'
    0x34:
      id: 'fok'
      doc: 'An IOC where the entire size must be filled, else the order will be cancelled back'
    0x35:
      id: 'gtx'
      doc: 'Early Trading Session until end of Post-Market Session (EDGX only effective 12/07/26: Overnight Trading Session until end of Post-Market Session)'
    0x36:
      id: 'gtd'
      doc: 'Early Trading Session; expires at earlier of ExpireTime or end of Post-Market Session (EDGX only effective 12/07/26: expires at earlier of specified ExpireTime or end of Post-Market Session)'
    0x37:
      id: 'at_the_close'
      doc: 'BZX only and applicable to Cboe Listed securities and Cboe Market Close symbols'
    0x45:
      id: 'pre_pre_market_trading_session_until_end_of_regular_session'
      doc: 'Pre Pre Market Trading Session Until End Of Regular Session'
    0x50:
      id: 'rtp_regular_hours_and_post_market_session'
      doc: 'Effective 10/09/26'
    0x52:
      id: 'rho_regular_hours_session_only'
      doc: 'Rho Regular Hours Session Only'
    0x54:
      id: 'ptd'
      doc: 'Pre-Market Trading Session; expires at earlier of specified ExpireTime or end of Post-Market Session'
    0x58:
      id: 'ptx_pre_market_trading_session_until_end_of_post_market_session'
      doc: 'Ptx Pre Market Trading Session Until End Of Post Market Session'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
  display_indicator:
    0x56:
      id: 'default_field'
      doc: 'As determined by port level setting (defaults to S)'
    0x50:
      id: 'price_adjust'
      doc: 'Price Adjust'
    0x6d:
      id: 'multiple_price_adjust'
      doc: 'Multiple Price Adjust'
    0x52:
      id: 'cancel_back_the_order_if_it_cannot_be_booked_and_displayed_without_adjustment'
      doc: 'Cancel Back The Order If It Cannot Be Booked And Displayed Without Adjustment'
    0x72:
      id: 'hidden_cancel_back_the_order_if_it_cannot_be_booked_without_adjustment'
      doc: 'Hidden Cancel Back The Order If It Cannot Be Booked Without Adjustment'
    0x53:
      id: 'display_price_sliding'
      doc: 'This is to override an opt-out of Display Price Siding at the port level'
    0x4c:
      id: 'display_price_sliding_but_cancel_back_if_order_crosses_the_nbbo_on_entry'
      doc: 'Display Price Sliding But Cancel Back If Order Crosses The Nbbo On Entry'
    0x4d:
      id: 'multiple_display_price_sliding'
      doc: 'Multiple Display Price Sliding'
    0x68:
      id: 'hidden_multiple_price_slide'
      doc: 'Hidden Multiple Price Slide'
    0x76:
      id: 'visible'
      doc: 'For visible peg orders only; others will be rejected'
    0x49:
      id: 'invisible'
      doc: 'Implied for Midpoint Peg orders'
    0x4e:
      id: 'no_rescrape_at_limit'
      doc: 'Applicable only to fully routable, IOC orders (RoutingInst = R and TimeInForce = 3). After walking the price to the limit, there will be no final scrape at Cboe and the cancel reason code will state X (Expired) rather than N (No Liquidity).'
  locate_reqd:
    0x4e:
      id: 'client_affirms_ability_to_borrow_default'
      doc: 'Client Affirms Ability To Borrow Default'
    0x59:
      id: 'client_does_not_affirm_ability_to_borrow_results_in_reject'
      doc: 'Client Does Not Affirm Ability To Borrow Results In Reject'
  attributed_quote:
    0x4e:
      id: 'do_not_attribute_firm_mpid_to_this_order'
      doc: 'Do Not Attribute Firm Mpid To This Order'
    0x59:
      id: 'attribute_firm_mpid_to_this_order'
      doc: 'Attribute Firm Mpid To This Order'
    0x52:
      id: 'attribute_rtal_to_this_order'
      doc: 'Attribute Rtal To This Order'
  ext_exec_inst:
    0x4e:
      id: 'none'
      doc: 'None'
    0x52:
      id: 'retail_order_eligible_for_retail_rebate'
      doc: 'Retail Order Eligible For Retail Rebate'
    0x50:
      id: 'retail_order_price_improvement_only'
      doc: 'BYX and EDGX'
    0x54:
      id: 'retail_price_improving_order'
      doc: 'BYX and EDGX'
    0x58:
      id: 'retail_priority_order_eligible_for_retail_priority_and_retail_rebate_rate'
      doc: 'EDGX'
  ex_destination:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x46:
      id: 'texas_stock_exchange'
      doc: 'Texas Stock Exchange'
    0x47:
      id: 'n24x'
      doc: '24 X'
    0x48:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x49:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x4a:
      id: 'edga'
      doc: 'Edga'
    0x4b:
      id: 'edgx'
      doc: 'Edgx'
    0x4c:
      id: 'long_term_stock_exchange'
      doc: 'Long Term Stock Exchange'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x54:
      id: 'intelligent_cross_pending_approval'
      doc: 'Intelligent Cross Pending Approval'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx'
    0x59:
      id: 'byx'
      doc: 'Byx'
    0x5a:
      id: 'bzx'
      doc: 'Bzx'
  cross_trade_flag:
    0x30:
      id: 'none_to_override_port_setting_as_necessary'
      doc: 'None To Override Port Setting As Necessary'
    0x31:
      id: 'periodic_auction_only'
      doc: 'Periodic Auction Only'
    0x32:
      id: 'periodic_auction_eligible'
      doc: 'Periodic Auction Eligible'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
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
    0x1195:
      id: 'order_acknowledgement_us_equities_v_1'
      doc: 'Order Acknowledgment messages are sent in response to New Order messages'
    0x1196:
      id: 'order_rejected_us_equities_v_1'
      doc: 'Order Rejected messages are sent in response to a New Order message which must be rejected'
    0x1197:
      id: 'order_modified_us_equities_v_1'
      doc: 'Order Modified messages are sent in response to a Modify Request message to indicate that the order has been successfully modified'
    0x1199:
      id: 'order_restated_us_equities_v_1'
      doc: 'Order Restated messages are sent to inform the Member that an order has been asynchronously modified for some reason without an explicit Modify Order message request having been sent'
    0x1198:
      id: 'modify_rejected_us_equities_v_1'
      doc: 'User Modify Rejected messages are sent in response to a Modify Order message for an order which cannot be modified'
    0x119a:
      id: 'order_cancelled_us_equities_v_1'
      doc: 'This message indicates an order has been cancelled'
    0x119b:
      id: 'cancel_rejected_us_equities_v_1'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur'
    0x119c:
      id: 'order_execution_us_equities_v_1'
      doc: 'An Order Execution message is sent for each fill on an order'
    0x119d:
      id: 'trade_cancel_correct_us_equities_v_1'
      doc: 'Used to relay a trade which has been cancelled (busted) or corrected (price change only)'
    0x11a0:
      id: 'purge_rejected_us_equities_v_1'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur'
    0x119e:
      id: 'reset_risk_acknowledgement_us_equities_v_1'
      doc: 'Response to a Reset Risk message request'
    0x119f:
      id: 'purge_acknowledgement_us_equities_v_1'
      doc: 'A Purge Acknowledgment message is an unsequenced message sent when a Purge Orders message requesting an order purge has completed canceling all individual orders'
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
    0x58:
      id: 'invalid_replay_instruction'
      doc: 'Invalid Replay Instruction'
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
    0x58:
      id: 'routed_to_another_market'
      doc: 'Routed To Another Market'
    0x43:
      id: 'auction_uncrossing'
      doc: 'Auction Uncrossing'
    0x57:
      id: 'waiting_for_execution_at_pre_market_time'
      doc: 'Waiting for execution at pre-market time as dictated by TimeInForce value and "Hold Early to 7am" port setting. Only applied on the initial order acknowledgment.'
  sub_liquidity_indicator:
    0x45:
      id: 'trade_added_rpi_liquidity_byx_and_edgx_only'
      doc: 'Trade Added Rpi Liquidity Byx And Edgx Only'
    0x48:
      id: 'trade_added_hidden_liquidity'
      doc: 'Trade Added Hidden Liquidity'
    0x49:
      id: 'trade_added_hidden_liquidity_that_was_price_improved'
      doc: 'Trade Added Hidden Liquidity That Was Price Improved'
    0x4a:
      id: 'execution_from_first_order_to_join_the_nbbo'
      doc: 'Execution From First Order To Join The Nbbo'
    0x50:
      id: 'periodic_auction_byx_only'
      doc: 'Periodic Auction Byx Only'
    0x53:
      id: 'nbbo_setter_fee_eligible'
      doc: 'Nbbo Setter Fee Eligible'
    0x56:
      id: 'visible_liquidity_add_trade_that_was_price_improved'
      doc: 'Visible Liquidity Add Trade That Was Price Improved'
    0x6d:
      id: 'midpoint_peg_order'
      doc: 'Midpoint Peg Order'
    0x73:
      id: 'order_set_the_nbbo_but_is_not_fee_eligible'
      doc: 'Order Set The Nbbo But Is Not Fee Eligible'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down_luld'
      doc: 'Limit Up Limit Down Luld'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  order_restatement_reason:
    0x43:
      id: 'cboe_market_close_cmc'
      doc: 'Cboe Market Close Cmc'
    0x4c:
      id: 'reload'
      doc: 'Reload'
    0x50:
      id: 'peg_or_price_sliding_reprice'
      doc: 'Peg Or Price Sliding Reprice'
    0x51:
      id: 'liquidity_updated'
      doc: 'Liquidity Updated'
    0x52:
      id: 'reroute'
      doc: 'Reroute'
    0x53:
      id: 'reduction_of_order_qty_due_to_swp'
      doc: 'Reduction Of Order Qty Due To Swp'
    0x57:
      id: 'wash_or_mtp_decrement'
      doc: 'Wash Or Mtp Decrement'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down_luld'
      doc: 'Limit Up Limit Down Luld'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down_luld'
      doc: 'Limit Up Limit Down Luld'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down_luld'
      doc: 'Limit Up Limit Down Luld'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down_luld'
      doc: 'Limit Up Limit Down Luld'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  risk_reset_result:
    0x20:
      id: 'ignored_exceeds_1_reset_per_100_milliseconds'
      doc: 'Ignored Exceeds 1 Reset Per 100 Milliseconds'
    0x43:
      id: 'rejected_exceeds_risk_group_id_limit'
      doc: 'Rejected Exceeds Risk Group Id Limit'
    0x44:
      id: 'rejected_automatic_risk_resets_are_disabled'
      doc: 'Rejected Automatic Risk Resets Are Disabled'
    0x45:
      id: 'rejected_empty_reset_risk_field'
      doc: 'Rejected Empty Reset Risk Field'
    0x46:
      id: 'rejected_exceeds_firm_reset_limit'
      doc: 'Rejected Exceeds Firm Reset Limit'
    0x49:
      id: 'rejected_incorrect_data_center'
      doc: 'Rejected Incorrect Data Center'
    0x4d:
      id: 'rejected_invalid_matching_unit'
      doc: 'Rejected Invalid Matching Unit'
    0x53:
      id: 'rejected_exceeds_symbol_reset_limit'
      doc: 'Rejected Exceeds Symbol Reset Limit'
    0x55:
      id: 'rejected_invalid_symbol'
      doc: 'Rejected Invalid Symbol'
    0x59:
      id: 'success'
      doc: 'Success'
    0x63:
      id: 'rejected_invalid_clearing_firm'
      doc: 'Rejected Invalid Clearing Firm'
    0x79:
      id: 'rejected_in_replay'
      doc: 'Rejected In Replay'

