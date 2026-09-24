# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgxOptions BinaryOrderEntry Boe3 v1.0.10
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.0.10
#   Date: 1/23/2025
#   Specification: US_Options_BOE3_Specification.pdf
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
  id: cboe_edgxoptions_binaryorderentry_boe3_v1_0_10_firm
  title: Cboe EdgxOptions BinaryOrderEntry Boe3 v1.0.10
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edgx Options Binary Order Entry Boe3 v1.0.10'
doc-ref: https://www.cboe.com/us/options/support/technical

seq:
  - id: firm_message_header
    type: firm_message_header_struct
    doc: 'Message header of a packet sent by the firm'
  - id: firm_message
    type:
      switch-on: firm_message_header.firm_message_type
      cases:
        'firm_message_type::login_request_message': login_request_message
        'firm_message_type::new_order_message': new_order_message
        'firm_message_type::new_order_short_message': new_order_short_message
        'firm_message_type::new_order_cross_message': new_order_cross_message
        'firm_message_type::new_complex_instrument_message': new_complex_instrument_message
        'firm_message_type::new_complex_order_message': new_complex_order_message
        'firm_message_type::new_complex_order_short_message': new_complex_order_short_message
        'firm_message_type::new_order_cross_multileg_message': new_order_cross_multileg_message
        'firm_message_type::cancel_order_message': cancel_order_message
        'firm_message_type::mass_cancel_order_message': mass_cancel_order_message
        'firm_message_type::modify_order_message': modify_order_message
        'firm_message_type::quote_update_message': quote_update_message
        'firm_message_type::quote_update_short_message': quote_update_short_message
        'firm_message_type::purge_orders_message': purge_orders_message
        'firm_message_type::reset_risk_message': reset_risk_message

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
  new_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds To On Behalf Of Sub Id 116 And Clearing Account 440 In'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Exec Inst'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Ord Type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force'
      - id: min_qty
        type: u4
        doc: 'Minimum Fill Quantity For Ioc Orders Which Only Interact With Liquidity'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The Capacity Of The Order'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        doc: 'Routing Instruction'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: display_indicator
        type: u1
        enum: display_indicator
        doc: 'Display Indicator'
      - id: prevent_match
        type: prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required For Time In Force 6 Orders Specifies The Datetime In Utc. Nanoseconds since Unix epoch'
      - id: maturity_date
        type: u4
        doc: 'When Sending Cboe Native Symbology Set Maturity Date To Zero'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Strike Price For Option. Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'When Sending Cboe Native Symbology Set Put Or Call To Ascii Nul 0 X 00'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Member Position In The Option'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'A Valid Parent Id Of The Directed Market Maker'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        doc: 'Session Eligibility'
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        doc: 'Allows For An Order To Be Attributed To A Firms Executing Broker Id In Cboe Market Data Feeds'
      - id: display_range
        type: u4
        doc: 'Used For Random Replenishment Of Reserve Orders'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop Price. Implied decimal with scale 1e-4'
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        doc: 'Routing Strategy'
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        doc: 'Route Delivery Method'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Used To Specify The Designated Away Venue'
      - id: auction_id
        type: u8
        doc: 'Auction Order Identifier Supplied By Cboe'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'Clearing Optional Data'
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        doc: 'User Defined Identifier For Quote Attribution'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies The Frequent Trader Program In Which The Order Is Participating'
      - id: compression
        type: u1
        enum: compression
        doc: 'Order Is A Compression Trade'
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        doc: 'Specifies A Default Par Workstation Ex'
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        doc: 'Floor Routing Inst'
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor Acronym Of Market Maker On Whose Behalf This Order Is Being'
      - id: order_router_subsidy
        type: u1
        enum: order_router_subsidy
        doc: 'Order Router Subsidy Eligibility'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Price Type'
      - id: held
        type: u1
        enum: held
        doc: 'Indicates If Order Should Be Designated As Held Upon Order Entry'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
  prevent_match:
    seq:
      - id: mtp_modifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Instrument Type Filter'
      - id: unique_id_level
        type: str
        size: 1
        encoding: ASCII
        doc: 'Gtc Order Filter'
      - id: trading_group_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trading Group Id'
  new_order_short_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds To On Behalf Of Sub Id 116 And Clearing Account 440 In'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Exec Inst'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Ord Type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force'
      - id: min_qty
        type: u4
        doc: 'Minimum Fill Quantity For Ioc Orders Which Only Interact With Liquidity'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The Capacity Of The Order'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        doc: 'Routing Instruction'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: display_indicator
        type: u1
        enum: display_indicator
        doc: 'Display Indicator'
      - id: prevent_match
        type: prevent_match
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Member Position In The Option'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        doc: 'Session Eligibility'
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        doc: 'Allows For An Order To Be Attributed To A Firms Executing Broker Id In Cboe Market Data Feeds'
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        doc: 'Routing Strategy'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Used To Specify The Designated Away Venue'
      - id: auction_id
        type: u8
        doc: 'Auction Order Identifier Supplied By Cboe'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies The Frequent Trader Program In Which The Order Is Participating'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
  new_order_cross_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Dayunique Identifier For The Cross Order Chosen By The Member'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Auction Order Being Submitted'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Indicates Which Side Of The Cross Order Will Be Prioritized For Execution'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol'
      - id: maturity_date
        type: u4
        doc: 'When Sending Cboe Native Symbology Set Maturity Date To Zero'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Strike Price For Option. Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'When Sending Cboe Native Symbology Set Put Or Call To Ascii Nul 0 X 00'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Exec Inst'
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        doc: 'Allows For An Order To Be Attributed To A Firms Executing Broker Id In Cboe Market Data Feeds'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'A Valid Parent Id Of The Directed Market Maker'
      - id: prevent_match
        type: prevent_match
      - id: auto_match
        type: u1
        enum: auto_match
        doc: 'Betterpriced Responses Will Be Matched By The Contra Side'
      - id: auto_match_price
        type: decimal_s8_4
        doc: 'Sets The Limit Price At Which The Contra Order Will Auto Match. Implied decimal with scale 1e-4'
      - id: last_priority
        type: u1
        enum: last_priority
        doc: 'When Enabled Allocation Will Go To Other Members Responses Before Requiring The Contra Order To Satisfy Remaining Contracts Of The Agency Order'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        doc: 'User Defined Identifier For Quote Attribution'
      - id: equity_trade_price
        type: decimal_s8_4
        doc: 'Price At Which The Equity Associated With A Qcc Trade. Implied decimal with scale 1e-4'
      - id: equity_trade_size
        type: u4
        doc: 'Number Of Shares Executed In The Equity Associated With A Qcc Trade'
      - id: equity_trade_venue
        type: u1
        enum: equity_trade_venue
        doc: 'Exchange Venue Where Equity Associated With A Qcc Traded'
      - id: equity_transact_time
        type: nanosecond_timestamp
        doc: 'Time Of Equity Trade Associated With A Qcc Trade. Nanoseconds since Unix epoch'
      - id: equity_buy_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Clearing Firm On Buy Side Of The Equity Trade Associated With A Qcc'
      - id: equity_sell_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Clearing Firm On Sell Side Of The Equity Trade Associated With A Qcc'
      - id: compression
        type: u1
        enum: compression
        doc: 'Order Is A Compression Trade'
      - id: order_router_subsidy
        type: u1
        enum: order_router_subsidy
        doc: 'Order Router Subsidy Eligibility'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_allocation
        type: u1
        doc: 'Number Of Allocation Party Repeating Groups In The Message'
      - id: allocation
        type: allocation
        repeat: expr
        repeat-expr: num_allocation
  allocation:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: alloc_qty
        type: u4
        doc: 'Number Of Contracts For This Party'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The Capacity Of The Order'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Member Position In The Option'
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'For The Agency Side This Field Must Equal The Value Of Clearing Firm'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds To On Behalf Of Sub Id 116 And Clearing Account 440 In'
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'Clearing Optional Data'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies The Frequent Trader Program In Which The Order Is Participating'
  new_complex_instrument_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_complex_leg
        type: u1
        doc: 'Number Of Leg Repeating Groups In The Message'
      - id: complex_leg
        type: complex_leg
        repeat: expr
        repeat-expr: num_complex_leg
  complex_leg:
    seq:
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol'
      - id: maturity_date
        type: u4
        doc: 'When Sending Cboe Native Symbology Set Maturity Date To Zero'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Strike Price For Option. Implied decimal with scale 1e-4'
      - id: cfi_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Cfi Code For Leg'
      - id: ratio_qty
        type: u4
        doc: 'Integer Ratio Of A Complex Leg With Respect To The Other Legs Of A'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
  new_complex_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds To On Behalf Of Sub Id 116 And Clearing Account 440 In'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Exec Inst'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Ord Type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The Capacity Of The Order'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        doc: 'Routing Instruction'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: prevent_match
        type: prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required For Time In Force 6 Orders Specifies The Datetime In Utc. Nanoseconds since Unix epoch'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'A Valid Parent Id Of The Directed Market Maker'
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        doc: 'Allows For An Order To Be Attributed To A Firms Executing Broker Id In Cboe Market Data Feeds'
      - id: auction_id
        type: u8
        doc: 'Auction Order Identifier Supplied By Cboe'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: drill_thru_protection
        type: decimal_s8_4
        doc: 'Amount Sender Is Willing To Trade Through The Snbbo. Implied decimal with scale 1e-4'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Mpid Used To Clear The Equity Leg Being Cleared Via The Exchange'
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'Clearing Optional Data'
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        doc: 'User Defined Identifier For Quote Attribution'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies The Frequent Trader Program In Which The Order Is Participating'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        doc: 'Session Eligibility'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display'
      - id: display_range
        type: u4
        doc: 'Used For Random Replenishment Of Reserve Orders'
      - id: combo_order
        type: u1
        enum: combo_order
        doc: 'Declare The Order As A Combo'
      - id: compression
        type: u1
        enum: compression
        doc: 'Order Is A Compression Trade'
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        doc: 'Valid When An Equity Symbol Is Present In The Complex Instrument'
      - id: equity_leg_short_sell
        type: u1
        enum: equity_leg_short_sell
        doc: 'Equity Leg Short Sell'
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        doc: 'Specifies A Default Par Workstation Ex'
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        doc: 'Floor Routing Inst'
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor Acronym Of Market Maker On Whose Behalf This Order Is Being'
      - id: order_router_subsidy
        type: u1
        enum: order_router_subsidy
        doc: 'Order Router Subsidy Eligibility'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Price Type'
      - id: strategy_id
        type: u1
        enum: strategy_id
        doc: 'Used To Declare When A Strategy Is Used'
      - id: tied_hedge
        type: u1
        enum: tied_hedge
        doc: 'Order Is A Tied Hedge'
      - id: held
        type: u1
        enum: held
        doc: 'Indicates If Order Should Be Designated As Held Upon Order Entry'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_leg_position_effect
        type: u1
        doc: 'Number Of Leg Repeating Groups In The Message'
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
        doc: 'Indicates Status Of Member Position In The Option Leg Of A Complex Order'
  new_complex_order_short_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds To On Behalf Of Sub Id 116 And Clearing Account 440 In'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Exec Inst'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Ord Type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The Capacity Of The Order'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        doc: 'Routing Instruction'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: prevent_match
        type: prevent_match
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'A Valid Parent Id Of The Directed Market Maker'
      - id: auction_id
        type: u8
        doc: 'Auction Order Identifier Supplied By Cboe'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Mpid Used To Clear The Equity Leg Being Cleared Via The Exchange'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies The Frequent Trader Program In Which The Order Is Participating'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        doc: 'Session Eligibility'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display'
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        doc: 'Specifies A Default Par Workstation Ex'
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        doc: 'Floor Routing Inst'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_leg_position_effect
        type: u1
        doc: 'Number Of Leg Repeating Groups In The Message'
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
        doc: 'Indicates Status Of Member Position In The Option Leg Of A Complex Order'
  new_order_cross_multileg_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Dayunique Identifier For The Cross Order Chosen By The Member'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Type Of Auction Order Being Submitted'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Indicates Which Side Of The Cross Order Will Be Prioritized For Execution'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Exec Inst'
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        doc: 'Allows For An Order To Be Attributed To A Firms Executing Broker Id In Cboe Market Data Feeds'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'A Valid Parent Id Of The Directed Market Maker'
      - id: prevent_match
        type: prevent_match
      - id: auto_match
        type: u1
        enum: auto_match
        doc: 'Betterpriced Responses Will Be Matched By The Contra Side'
      - id: auto_match_price
        type: decimal_s8_4
        doc: 'Sets The Limit Price At Which The Contra Order Will Auto Match. Implied decimal with scale 1e-4'
      - id: last_priority
        type: u1
        enum: last_priority
        doc: 'When Enabled Allocation Will Go To Other Members Responses Before Requiring The Contra Order To Satisfy Remaining Contracts Of The Agency Order'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        doc: 'User Defined Identifier For Quote Attribution'
      - id: equity_trade_price
        type: decimal_s8_4
        doc: 'Price At Which The Equity Associated With A Qcc Trade. Implied decimal with scale 1e-4'
      - id: equity_trade_size
        type: u4
        doc: 'Number Of Shares Executed In The Equity Associated With A Qcc Trade'
      - id: equity_trade_venue
        type: u1
        enum: equity_trade_venue
        doc: 'Exchange Venue Where Equity Associated With A Qcc Traded'
      - id: equity_transact_time
        type: nanosecond_timestamp
        doc: 'Time Of Equity Trade Associated With A Qcc Trade. Nanoseconds since Unix epoch'
      - id: equity_buy_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Clearing Firm On Buy Side Of The Equity Trade Associated With A Qcc'
      - id: equity_sell_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Clearing Firm On Sell Side Of The Equity Trade Associated With A Qcc'
      - id: drill_thru_protection
        type: decimal_s8_4
        doc: 'Amount Sender Is Willing To Trade Through The Snbbo. Implied decimal with scale 1e-4'
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        doc: 'Valid When An Equity Symbol Is Present In The Complex Instrument'
      - id: compression
        type: u1
        enum: compression
        doc: 'Order Is A Compression Trade'
      - id: order_router_subsidy
        type: u1
        enum: order_router_subsidy
        doc: 'Order Router Subsidy Eligibility'
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Mpid Field Required On Cross Orders Routed To Destinations Via Nyse'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_allocation
        type: u1
        doc: 'Number Of Allocation Party Repeating Groups In The Message'
      - id: num_leg_position_effect
        type: u1
        doc: 'Total Number Of Leg Details In The Message'
      - id: allocation
        type: allocation
        repeat: expr
        repeat-expr: num_allocation
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
        doc: 'Indicates Status Of Member Position In The Option Leg Of A Complex Order'
  cancel_order_message:
    seq:
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Orig Cl Ord Id'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
  mass_cancel_order_message:
    seq:
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'If The Populated Value Ends In A Space The Message Will Be Rejected'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        doc: 'The Underlying Symbol'
      - id: mass_cancel_inst
        type: mass_cancel_inst
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Gmt Timestamp When The Mass Cancel Or Purge Was Sent By The Market Maker To The Exchange. Nanoseconds since Unix epoch'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
  mass_cancel_inst:
    seq:
      - id: clearing_firm_filter
        type: str
        size: 1
        encoding: ASCII
        doc: 'Clearing Firm Filter'
      - id: acknowledgement_style
        type: str
        size: 1
        encoding: ASCII
        doc: 'Acknowledgement Style'
      - id: lockout_instruction
        type: str
        size: 1
        encoding: ASCII
        doc: 'Lockout Instruction'
      - id: instrument_type_filter
        type: str
        size: 1
        encoding: ASCII
        doc: 'Instrument Type Filter'
      - id: gtc_order_filter
        type: str
        size: 1
        encoding: ASCII
        doc: 'Gtc Order Filter'
      - id: instruction_details
        type: str
        size: 3
        encoding: ASCII
        doc: 'Instruction Details'
  modify_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Orig Cl Ord Id'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Ord Type'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop Price. Implied decimal with scale 1e-4'
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        doc: 'Indicates Handling Of Original Order On Failure To Modify'
      - id: reserved
        size: 41
        doc: 'Reserved'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
  quote_update_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Member'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds To On Behalf Of Sub Id 116 And Clearing Account 440 In'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Gmt Timestamp When The Mass Cancel Or Purge Was Sent By The Market Maker To The Exchange. Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'Posting Instruction'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        doc: 'Session Eligibility'
      - id: size_modifier
        type: u1
        enum: size_modifier
        doc: 'Controls The Behavior Of The Quote Order Qty Field. Nullable, New Quote Size = 0'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_quote
        type: u1
        doc: 'Number Of Quotes In The Message'
      - id: quote
        type: quote
        repeat: expr
        repeat-expr: num_quote
  quote:
    seq:
      - id: quote_symbol
        type: str
        size: 1
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol For A Quote Update'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Member Position In The Option'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
  quote_update_short_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Member'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds To On Behalf Of Sub Id 116 And Clearing Account 440 In'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Gmt Timestamp When The Mass Cancel Or Purge Was Sent By The Market Maker To The Exchange. Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'Posting Instruction'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        doc: 'Session Eligibility'
      - id: size_modifier
        type: u1
        enum: size_modifier
        doc: 'Controls The Behavior Of The Quote Order Qty Field. Nullable, New Quote Size = 0'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_quote_short
        type: u1
        doc: 'Number Of Quotes In The Message'
      - id: quote_short
        type: quote_short
        repeat: expr
        repeat-expr: num_quote_short
  quote_short:
    seq:
      - id: quote_symbol
        type: str
        size: 1
        encoding: ASCII
        doc: 'Entire Cboe Format Symbol For A Quote Update'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Member Position In The Option'
      - id: price_short
        type: decimal_s4_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: order_qty_short
        type: u2
        doc: 'Order Quantity'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
  purge_orders_message:
    seq:
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'If The Populated Value Ends In A Space The Message Will Be Rejected'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used To Optionally Convey The Routing Firm Of The Order'
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        doc: 'The Underlying Symbol'
      - id: mass_cancel_inst
        type: mass_cancel_inst
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Gmt Timestamp When The Mass Cancel Or Purge Was Sent By The Market Maker To The Exchange. Nanoseconds since Unix epoch'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
      - id: num_custom_group_id
        type: u1
        doc: 'Number Of Custom Group Id Fields In The Message'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
  reset_risk_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'User Defined Identifier Of A Reset Risk Message'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        doc: 'For Use By Customers Using Cboes Risk Management Tools To Reset Or Release Efid Group Efid Risk Root Or Custom Group Id Level Lockout Conditions Resulting From Risk Profile Trips Or Selfimposed Lockouts Issued Via Cancel Orderor Purge Orders Messages'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        doc: 'The Underlying Symbol'
      - id: target_matching_unit
        type: u1
        doc: 'Matching Unit To Which The Message Is To Be Directed'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Purge Ordersmessages Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: scratch_pad
        type: u2
        doc: 'Field Ignored By Cboe Any Value Is Accepted'
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
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

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
    0x07d1:
      id: 'new_order_message'
      doc: 'Submission of a new simple (single leg) order to Cboe'
    0x07d2:
      id: 'new_order_short_message'
      doc: 'Submission of a new simple (single leg) order to Cboe'
    0x07d3:
      id: 'new_order_cross_message'
      doc: 'A New Order Cross message contains the details for both the agency (initiating) and contra ide(s) of a cross order'
    0x07d5:
      id: 'new_complex_instrument_message'
      doc: 'A New Complex Instrument message is used to request that the system create a complex strategy.'
    0x07d6:
      id: 'new_complex_order_message'
      doc: 'A New Complex Order message contains the details required to enter an order on a complex instrument created with previously entered New Complex Instrument message request'
    0x07d7:
      id: 'new_complex_order_short_message'
      doc: 'A New Complex Order message contains the details required to enter an order on a complex instrument created with previously entered New Complex Instrument message request'
    0x07d8:
      id: 'new_order_cross_multileg_message'
      doc: 'A New Order Cross Multileg message contains the details for both the agency (initiating) and contra side(s) of a cross order'
    0x07da:
      id: 'cancel_order_message'
      doc: 'Request to cancel a single order'
    0x07df:
      id: 'mass_cancel_order_message'
      doc: 'MassCancelOrderMessage'
    0x07db:
      id: 'modify_order_message'
      doc: 'Request to modify an order'
    0x07dc:
      id: 'quote_update_message'
      doc: 'Request to enter or update one or more quotes'
    0x07dd:
      id: 'quote_update_short_message'
      doc: 'QuRequest to enter or update one or more quotes'
    0x07e0:
      id: 'purge_orders_message'
      doc: 'Request to cancel a group of orders across all the firm’s sessions'
    0x07de:
      id: 'reset_risk_message'
      doc: 'Reset or release Firm, Risk Root, or Custom Group ID level lockout conditions resulting from risk profile trips or self-imposed lockouts issued via Cancel Order or Purge Orders messages'
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
      id: 'sell_short_exempt_stock_leg_only_c_1_and_edgx_only'
      doc: 'Sell Short Exempt Stock Leg Only C 1 And Edgx Only'
  exec_inst:
    0x66:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x47:
      id: 'all_or_none'
      doc: 'All Or None'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x33:
      id: 'stop'
      doc: 'Stop'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x31:
      id: 'gtc'
      doc: 'Gtc'
    0x32:
      id: 'at_the_open'
      doc: 'At The Open'
    0x33:
      id: 'ioc'
      doc: 'Ioc'
    0x34:
      id: 'fok'
      doc: 'Fok'
    0x36:
      id: 'gtd'
      doc: 'Gtd'
    0x37:
      id: 'at_the_closee'
      doc: 'At The Closee'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x55:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x4e:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office'
  display_indicator:
    0x56:
      id: 'default_field'
      doc: 'As Determined By Port Level Setting'
    0x53:
      id: 'display_price_sliding'
      doc: 'This Is To Override A Optout Of Display Price'
    0x4c:
      id: 'display_price_sliding_but_reject_if_order_crosses_nbbo_on_entry'
      doc: 'Display Price Sliding But Reject If Order Crosses Nbbo On Entry'
    0x50:
      id: 'price_adjust'
      doc: 'Price Adjust'
    0x6d:
      id: 'multiple_price_adjust'
      doc: 'Multiple Price Adjust'
    0x52:
      id: 'reject_the_order_if_it_cannot_be_booked_and_displayed_without'
      doc: 'Reject The Order If It Cannot Be Booked And Displayed Without'
  put_or_call:
    0x30:
      id: 'put'
      doc: 'Put'
    0x31:
      id: 'call'
      doc: 'Call'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None'
  session_eligibility:
    0x52:
      id: 'order_participates_in_regular_trading_hours'
      doc: 'Order Participates In Regular Trading Hours'
    0x41:
      id: 'order_participates_in_both_global_and_regular_trading_hours_also'
      doc: 'Order Participates In Both Global And Regular Trading Hours Also'
    0x42:
      id: 'order_participates_in_both_rth_and_curb_session'
      doc: 'Order Participates In Both Rth And Curb Session'
  attributed_quote:
    0x4e:
      id: 'do_not_attribute_firm_executing_broker_id_to_this_order'
      doc: 'Do Not Attribute Firm Executing Broker Id To This Order'
    0x59:
      id: 'attribute_firm_executing_broker_id_to_this_order'
      doc: 'Attribute Firm Executing Broker Id To This Order'
    0x43:
      id: 'attribute_client_id_only'
      doc: 'Attribute Client Id Only'
    0x5a:
      id: 'attribute_both_clearing_firm_efid_and_client_id'
      doc: 'Attribute Both Clearing Firm Efid And Client Id'
  ex_destination:
    0x41:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x45:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x46:
      id: 'miax'
      doc: 'Miax'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
    0x47:
      id: 'edgx_options'
      doc: 'Edgx Options'
    0x48:
      id: 'c_2'
      doc: 'C 2'
    0x4b:
      id: 'box_field'
      doc: 'Box'
    0x4d:
      id: 'memx'
      doc: 'Memx'
    0x4e:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x53:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Bx'
    0x55:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x57:
      id: 'cboe_options_c_1'
      doc: 'Cboe Options C 1'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'Nasdaq Phlx'
    0x5a:
      id: 'bzx_options'
      doc: 'Bzx Options'
    0x67:
      id: 'nasdaq_gemx'
      doc: 'Nasdaq Gemx'
    0x6d:
      id: 'nasdaq_mrx'
      doc: 'Nasdaq Mrx'
    0x77:
      id: 'miax_sapphire'
      doc: 'Miax Sapphire'
  compression:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  floor_routing_inst:
    0x44:
      id: 'direct_do_not_attempt_to_process_electronically'
      doc: 'Direct Do Not Attempt To Process Electronically'
    0x45:
      id: 'electronic_only'
      doc: 'Electronic Only'
    0x58:
      id: 'route_to_floor_if_unable_to_process_electronically'
      doc: 'Route To Floor If Unable To Process Electronically'
    0x20:
      id: 'port_level_default'
      doc: 'Port Level Default'
  order_router_subsidy:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  price_type:
    0x30:
      id: 'fixed_cabinet_trade_price'
      doc: 'Fixed Cabinet Trade Price'
    0x32:
      id: 'price_per_unit'
      doc: 'Price Per Unit'
    0x33:
      id: 'fixed_amount'
      doc: 'Fixed Amount'
  held:
    0x4e:
      id: 'mark_order_as_not_held'
      doc: 'Mark Order As Not Held'
    0x59:
      id: 'mark_order_as_held'
      doc: 'Mark Order As Held'
  cross_type:
    0x31:
      id: 'aim'
      doc: 'Automated Improvement Mechamism'
    0x32:
      id: 'qcc'
      doc: 'Qualified Contingent Cross'
    0x33:
      id: 'sam'
      doc: 'Solicitation Cross'
  cross_prioritization:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  auto_match:
    0x30:
      id: 'disabled_default'
      doc: 'Disabled Default'
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
  last_priority:
    0x30:
      id: 'disabled'
      doc: 'Disabled'
    0x31:
      id: 'enabled'
      doc: 'Enabled'
  equity_trade_venue:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x49:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x4a:
      id: 'cboe_edga_exchange'
      doc: 'Cboe Edga Exchange'
    0x4b:
      id: 'cboe_edgx_exchange'
      doc: 'Cboe Edgx Exchange'
    0x4d:
      id: 'chx'
      doc: 'Chx'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx'
    0x59:
      id: 'cboe_byx_exchange'
      doc: 'Cboe Byx Exchange'
    0x5a:
      id: 'cboe_bzx_exchange'
      doc: 'Cboe Bzx Exchange'
  combo_order:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  equity_ex_destination:
    0x43:
      id: 'cowen_default'
      doc: 'Cowen Default'
    0x50:
      id: 'penserra_via_nyse_chicago'
      doc: 'Penserra Via Nyse Chicago'
    0x46:
      id: 'fog_equities_via_nyse_chicago'
      doc: 'Fog Equities Via Nyse Chicago'
    0x4c:
      id: 'libucki_via_nyse_chicago'
      doc: 'Libucki Via Nyse Chicago'
    0x53:
      id: 'srt_securities_via_nyse_chicago'
      doc: 'Srt Securities Via Nyse Chicago'
  equity_leg_short_sell:
    0x35:
      id: 'sell_short'
      doc: 'Sell Short'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  strategy_id:
    0x43:
      id: 'conversion'
      doc: 'Conversion'
    0x52:
      id: 'reversal'
      doc: 'Reversal'
    0x4d:
      id: 'merger'
      doc: 'Merger'
    0x53:
      id: 'short_stock_interest'
      doc: 'Short Stock Interest'
    0x4a:
      id: 'jelly_roll'
      doc: 'Jelly Roll'
  tied_hedge:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  leg_position_effect:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
  posting_instruction:
    0x50:
      id: 'post_only'
      doc: 'Do Not Remove Liquidity'
    0x42:
      id: 'book_only'
      doc: 'Allow Removal Of Liquidity'
    0x4e:
      id: 'book_only_no_slide'
      doc: 'Book Only No Slide'
    0x52:
      id: 'post_only_no_slide'
      doc: 'Do Not Remove Liquidity'
    0x49:
      id: 'book_only_ioc'
      doc: 'Book Only Ioc'
  size_modifier:
    0x52:
      id: 'reduce_outstanding_size_of_quote_by_the_order_qty_provided'
      doc: 'Reduce Outstanding Size Of Quote By The Order Qty Provided'
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
    0x09c5:
      id: 'order_acknowledgement_message'
      doc: 'OrderAcknowledgementMessage'
    0x09c6:
      id: 'cross_order_acknowledgment_message'
      doc: 'OrderAcknowledgementMessage'
    0x09d5:
      id: 'quote_update_acknowledgement_message'
      doc: 'Quote Update Acknowledgment messages are sent in response to a Quote Update message'
    0x09c7:
      id: 'order_rejected_message'
      doc: 'Order Rejected messages are sent in response to a New Order message which must be rejected'
    0x09c8:
      id: 'cross_order_rejected_message'
      doc: 'Cross Order Rejected messages are sent in response to a New Order Cross and New Order Cross Multileg message which must be rejected'
    0x09d6:
      id: 'quote_update_rejected_message'
      doc: 'Quote Update Rejected messages are sent in response to a Quote Update message when the entire quote block is rejected by the order handler'
    0x09cb:
      id: 'order_modified_message'
      doc: 'Order Modified messages are sent in response to a Modify Request message to indicate that the order has been successfully modified'
    0x09cd:
      id: 'order_restated_message'
      doc: 'Order Restated messages are sent to inform the Member that an order has been asynchronously modified'
    0x09d9:
      id: 'quote_restated_message'
      doc: 'Quote Restated messages are sent to inform the Member that an order has been asynchronously modified for some reason by the Exchange'
    0x09cc:
      id: 'modify_rejected_message'
      doc: 'User Modify Rejected messages are sent in response to a Modify Order message for an order which cannot be modified'
    0x09d0:
      id: 'order_cancelled_message'
      doc: 'This message indicates an order has been cancelled'
    0x09d7:
      id: 'quote_cancelled_message'
      doc: 'A Quote Cancelled message will be sent to indicate an unsolicited cancellation of a quote entered with a Quote Update message'
    0x09d1:
      id: 'cross_order_cancelled_message'
      doc: 'A New Order Cross message has been cancelled'
    0x09d2:
      id: 'cancel_rejected_message'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur'
    0x09d3:
      id: 'order_execution_message'
      doc: 'An Order Execution message is sent for each fill on an order'
    0x09d8:
      id: 'quote_execution_message'
      doc: 'A Quote Execution message is used to indicate an execution has occurred on a resting quote'
    0x09d4:
      id: 'trade_cancel_correct_message'
      doc: 'Used to relay a trade which has been cancelled (busted) or corrected'
    0x09de:
      id: 'purge_rejected_message'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur'
    0x09da:
      id: 'reset_risk_acknowledgement_message'
      doc: 'Response to a Reset Risk message request'
    0x09db:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'A Mass Cancel Acknowledgment message is an unsequenced message sent when a Mass Cancel Order message requesting a mass cancellation has completed canceling all individual orders'
    0x09dc:
      id: 'mass_cancel_rejected_message'
      doc: 'A Mass Cancel Rejected message is sent in response to a Mass Cancel message to indicate that the mass cancellation cannot occur'
    0x09dd:
      id: 'purge_acknowledgement_message'
      doc: 'A Purge Acknowledgment message is an unsequenced message sent when a Purge Orders message requesting an order purge has completed canceling all individual orders'
    0x09df:
      id: 'purge_notification_message'
      doc: 'One Purge Notification message is sent for each matching unit that cancelled orders for that order entry port'
    0x09c9:
      id: 'new_complex_instrument_accepted_message'
      doc: 'The New Complex Instrument Accepted message is used to indicate acceptance of a complex strategy'
    0x09ca:
      id: 'new_complex_instrument_rejected_message'
      doc: 'The New Complex Instrument Rejected message is used to indicate that a requested complex strategy has been rejected'
    0x09ce:
      id: 'carried_restatement_message'
      doc: 'The Carried Restatement message is used to indicate the restoration of a multi-day GTC or GTD order at the start of a new business day'
    0x09cf:
      id: 'done_for_day_message'
      doc: 'The Done For Day messages represent orders persisted during the current day session to carry over to the next session'
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
    0x58:
      id: 'routed_to_another_market'
      doc: 'Routed To Another Market'
    0x43:
      id: 'auction_uncrossing'
      doc: 'Auction Uncrossing'
  sub_liquidity_indicator:
    0x53:
      id: 'execution_from_order_that_set_the_nbbo'
      doc: 'Execution From Order That Set The Nbbo'
    0x42:
      id: 'step_up_mechanism'
      doc: 'Step Up Mechanism'
    0x62:
      id: 'aim'
      doc: 'Aim'
    0x43:
      id: 'carried'
      doc: 'Carried'
    0x44:
      id: 'done_for_day'
      doc: 'Done For Day'
    0x51:
      id: 'qcc'
      doc: 'Qcc'
    0x73:
      id: 'sam'
      doc: 'Sam'
  quote_result:
    0x41:
      id: 'new_quote'
      doc: 'New Quote'
    0x49:
      id: 'ioc_quote_accepted'
      doc: 'Ioc Quote Accepted'
    0x4c:
      id: 'modified_loss_of_priority'
      doc: 'Modified Loss Of Priority'
    0x52:
      id: 'modified_retains_priority'
      doc: 'Modified Retains Priority'
    0x4e:
      id: 'no_change_matches_existing_quote'
      doc: 'No Change Matches Existing Quote'
    0x44:
      id: 'new_quote_but_may_remove_liquidity'
      doc: 'New Quote But May Remove Liquidity'
    0x64:
      id: 'modified_but_may_remove_liquidity'
      doc: 'Modified But May Remove Liquidity'
    0x56:
      id: 'no_change_existing_constituent_series_quote_modify_attempt_after'
      doc: 'No Change Existing Constituent Series Quote Modify Attempt After'
    0x55:
      id: 'user_cancelled'
      doc: 'User Cancelled'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x4f:
      id: 'rejected_doesnt_match_a_known_quote'
      doc: 'Rejected Doesnt Match A Known Quote'
    0x50:
      id: 'rejected_cant_post'
      doc: 'Rejected Cant Post'
    0x66:
      id: 'risk_management_firm_or_custom_group_id_level'
      doc: 'Risk Management Firm Or Custom Group Id Level'
    0x53:
      id: 'rejected_symbol_not_found'
      doc: 'Rejected Symbol Not Found'
    0x70:
      id: 'rejected_invalid_price'
      doc: 'Rejected Invalid Price'
    0x72:
      id: 'invalid_remove'
      doc: 'Invalid Remove'
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'rejected_other_reason'
      doc: 'Rejected Other Reason'
    0x2b:
      id: 'risk_management_efid_group_level'
      doc: 'Risk Management Efid Group Level'
    0x63:
      id: 'rejected_closing_only_series'
      doc: 'Rejected Closing Only Series'
    0x76:
      id: 'rejected_attempt_to_add_constituent_series_quote_after_cutoff'
      doc: 'Rejected Attempt To Add Constituent Series Quote After Cutoff'
  order_restatement_reason:
    0x45:
      id: 'reduction_of_ord_qty_due_to_equity_leg_reject'
      doc: 'Reduction Of Ord Qty Due To Equity Leg Reject'
    0x4c:
      id: 'reload'
      doc: 'Reload'
    0x50:
      id: 'price_sliding_reprice'
      doc: 'Price Sliding Reprice'
    0x51:
      id: 'liquidity_updated'
      doc: 'Liquidity Updated'
    0x52:
      id: 'reroute'
      doc: 'Reroute'
    0x53:
      id: 'ship_and_post'
      doc: 'Ship And Post'
    0x57:
      id: 'wash'
      doc: 'Wash'
  restatement_reason:
    0x51:
      id: 'liquidity'
      doc: 'Liquidity'
    0x57:
      id: 'wash'
      doc: 'Wash'
  cross_exclusion_indicator:
    0x4e:
      id: 'contracts_were_executed_in_auction_against_contra_party'
      doc: 'Contracts Were Executed In Auction Against Contra Party'
    0x59:
      id: 'contracts_were_executed_in_auction_against_another_party'
      doc: 'Contracts Were Executed In Auction Against Another Party'
  multileg_reporting_type:
    0x31:
      id: 'singleleg_instrument'
      doc: 'Singleleg Instrument'
    0x32:
      id: 'individual_leg_of_multileg_instrument'
      doc: 'Individual Leg Of Multileg Instrument'
    0x33:
      id: 'entire_multileg_instrument_package'
      doc: 'Entire Multileg Instrument Package'
    0x34:
      id: 'last_individual_leg_of_multileg_instrument'
      doc: 'Last Individual Leg Of Multileg Instrument'
  trade_through_alert_type:
    0x30:
      id: 'no_trade_through'
      doc: 'No Trade Through'
    0x31:
      id: 'nbbo'
      doc: 'Nbbo'
    0x32:
      id: 'bbo'
      doc: 'Local Best Bid Or Offer'
    0x33:
      id: 'sbbo'
      doc: 'Market Quote Of Complex Derived By Legs'
    0x34:
      id: 'book_trade_through'
      doc: 'Trade Through Customer Size'
    0x35:
      id: 'due_dilligence_trade_through'
      doc: 'Due Dilligence Trade Through'
  sender_location_id:
    0x46:
      id: 'floor'
      doc: 'Floor'
    0x20:
      id: 'electronic_execution'
      doc: 'Electronic Execution'
  risk_reset_result:
    0x20:
      id: 'ignored'
      doc: 'Ignored'
    0x43:
      id: 'rejected_exceeds_custom_group_id_limit'
      doc: 'Rejected Exceeds Custom Group Id Limit'
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
      id: 'rejected_exceeds_risk_root_reset_limit'
      doc: 'Rejected Exceeds Risk Root Reset Limit'
    0x55:
      id: 'rejected_invalid_risk_root'
      doc: 'Rejected Invalid Risk Root'
    0x59:
      id: 'success'
      doc: 'Success'
    0x63:
      id: 'rejected_invalid_efid_clearing_firm'
      doc: 'Rejected Invalid Efid Clearing Firm'
    0x79:
      id: 'rejected_in_replay'
      doc: 'Rejected In Replay'
  mass_cancel_lockout:
    0x59:
      id: 'lockout'
      doc: 'Lockout'
    0x4e:
      id: 'no_lockout'
      doc: 'No Lockout'

