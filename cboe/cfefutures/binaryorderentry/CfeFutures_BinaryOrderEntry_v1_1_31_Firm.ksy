# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures BinaryOrderEntry Boe3 v1.1.31
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Futures Binary Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.1.31
#   Date: 1/14/2026
#   Specification: CBOE_FUTURES_EXCHANGE_BOE3_SPECIFICATION.pdf
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
  id: cboe_cfefutures_binaryorderentry_boe3_v1_1_31_firm
  title: Cboe CfeFutures BinaryOrderEntry Boe3 v1.1.31
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange Futures Binary Order Entry Boe3 v1.1.31'
doc-ref: http://markets.cboe.com/us/futures/support/technical

seq:
  - id: firm_message_header
    type: firm_message_header_struct
    doc: 'Message header of a packet sent by the firm'
  - id: firm_message
    type:
      switch-on: firm_message_header.firm_message_type
      cases:
        'firm_message_type::login_request_message': login_request_message
        'firm_message_type::new_order': new_order
        'firm_message_type::new_order_option': new_order_option
        'firm_message_type::modify_order': modify_order
        'firm_message_type::cancel_order': cancel_order
        'firm_message_type::mass_cancel_order': mass_cancel_order
        'firm_message_type::purge_orders': purge_orders
        'firm_message_type::quote_update': quote_update
        'firm_message_type::quote_update_option': quote_update_option
        'firm_message_type::reset_risk': reset_risk
        'firm_message_type::new_complex_instrument_option': new_complex_instrument_option

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
  new_order:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id Chosen By The Client'
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
        doc: 'Supplemental Identifier'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order Type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force'
      - id: min_qty
        type: u4
        doc: 'Minimum Fill Quantity For Ioc Orders'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Simple Instruments Can Be Specified By Providing The Mapped Symbol Format In The Symbol Field Or By Providing The Product Name E'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique Account Identifier Associated With An Order'
      - id: prevent_match
        type: prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required For Time In Force 6 Orders Specifies The Datetime In Utc That The Order Expires. Nanoseconds since Unix epoch'
      - id: maturity_date
        type: u4
        doc: 'Used To Specify The Expiration Date Of The Symbol Within The Specified Product Class'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Client Position In A Trade Resulting From The Order. Nullable, None = 0'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop Price. Implied decimal with scale 1e-4'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Mass Cancels Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: cti_code
        type: u1
        enum: cti_code
        doc: 'Cti Code'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Supplemental Customer Identifier Used For Billing Related Programs'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'Execution Source Code Provided During Order Entry To Describe Broker Service. Nullable, Apply Default = 0'
      - id: country_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Identifies The Country Code Of The Person Or System Submitting The Order Using The Iso 3166 Twocharacter Code'
  prevent_match:
    seq:
      - id: mtp_modifier
        type: u1
        enum: mtp_modifier
        doc: 'Instrument Type Filter'
      - id: unique_id_level
        type: u1
        enum: unique_id_level
        doc: 'Gtc Order Filter'
      - id: trading_group_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trading Group Id'
  new_order_option:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id Chosen By The Client'
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
        doc: 'Supplemental Identifier'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order Type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Simple Instruments Can Be Specified By Providing The Mapped Symbol Format In The Symbol Field Or By Providing The Product Name E'
      - id: security_desc
        size: 16
        doc: 'The Options On Futures Identifier Name'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique Account Identifier Associated With An Order'
      - id: prevent_match
        type: prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required For Time In Force 6 Orders Specifies The Datetime In Utc That The Order Expires. Nanoseconds since Unix epoch'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Client Position In A Trade Resulting From The Order. Nullable, None = 0'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Mass Cancels Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: cti_code
        type: u1
        enum: cti_code
        doc: 'Cti Code'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Supplemental Customer Identifier Used For Billing Related Programs'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'Execution Source Code Provided During Order Entry To Describe Broker Service. Nullable, Apply Default = 0'
      - id: country_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Identifies The Country Code Of The Person Or System Submitting The Order Using The Iso 3166 Twocharacter Code'
      - id: num_leg_position_effect
        type: u1
        doc: 'For Complex Orders The Number Of Legs Of The Complex Instrument Specified In The Symbol Field'
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
        doc: 'Indicates Status Of Client Position In The Option For This Leg'
  modify_order:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id Chosen By The Client'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The Cl Ord Id Of The Original Order'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order Type'
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        doc: 'Cancel Original On Reject'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop Price. Implied decimal with scale 1e-4'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Supplemental Customer Identifier Used For Billing Related Programs'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'Execution Source Code Provided During Order Entry To Describe Broker Service. Nullable, Apply Default = 0'
  cancel_order:
    seq:
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The Cl Ord Id Of The Original Order'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
  mass_cancel_order:
    seq:
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Userdefined Identifier Of The Mass Cancel Or Purge Request'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
        doc: 'Used To Specify Product Class E'
      - id: mass_cancel_inst
        type: mass_cancel_inst
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
  mass_cancel_inst:
    seq:
      - id: clearing_firm_filter
        type: u1
        enum: clearing_firm_filter
        doc: 'Clearing Firm Filter'
      - id: acknowledgement_style
        type: u1
        enum: acknowledgement_style
        doc: 'Acknowledgement Style'
      - id: lockout_instruction
        type: u1
        enum: lockout_instruction
        doc: 'Lockout Instruction'
      - id: instrument_type_filter
        type: u1
        enum: instrument_type_filter
        doc: 'Instrument Type Filter'
      - id: gtc_order_filter
        type: u1
        enum: gtc_order_filter
        doc: 'Gtc Order Filter'
      - id: instruction_details
        type: str
        size: 11
        encoding: ASCII
        doc: 'Gtc Order Filter'
  purge_orders:
    seq:
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Userdefined Identifier Of The Mass Cancel Or Purge Request'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
        doc: 'Used To Specify Product Class E'
      - id: mass_cancel_inst
        type: mass_cancel_inst
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
      - id: custom_group_id_cnt
        type: u1
        doc: 'Number Of Repeating Custom Group Ids Included In This Message'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Mass Cancels Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
  quote_update:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Supplemental Identifier'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique Account Identifier Associated With An Order'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Mass Cancels Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
      - id: cti_code
        type: u1
        enum: cti_code
        doc: 'Cti Code'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
      - id: size_modifier
        type: u1
        enum: size_modifier
        doc: 'Controls The Behavior Of The Quote Order Qty Field. Nullable, New Quote Size = 0'
      - id: num_quote_update_group
        type: u1
        doc: 'Number Of Repeating Groups Included In This Message'
      - id: quote_update_group
        type: quote_update_group
        repeat: expr
        repeat-expr: num_quote_update_group
  quote_update_group:
    seq:
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cfe Native Identifier Of The Instrument Being Quoted'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Client Position In A Trade Resulting From The Order. Nullable, None = 0'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
  quote_update_option:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Supplemental Identifier'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique Account Identifier Associated With An Order'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Mass Cancels Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
      - id: cti_code
        type: u1
        enum: cti_code
        doc: 'Cti Code'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Y Manual Order Entry N Automated Order Entry'
      - id: oeo_id
        type: str
        size: 18
        encoding: ASCII
        doc: 'Identifies The Order Entry Operator Responsible For This Message'
      - id: size_modifier
        type: u1
        enum: size_modifier
        doc: 'Controls The Behavior Of The Quote Order Qty Field. Nullable, New Quote Size = 0'
      - id: num_quote_update_option_group
        type: u1
        doc: 'Number Of Repeating Groups Included In This Message'
      - id: quote_update_option_group
        type: quote_update_option_group
        repeat: expr
        repeat-expr: num_quote_update_option_group
  quote_update_option_group:
    seq:
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cfe Native Identifier Of The Instrument Being Quoted'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Client Position In A Trade Resulting From The Order. Nullable, None = 0'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
  reset_risk:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique Identifier For This Reset Risk Request'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        doc: 'Single Character Values Values May Be Combined S Productlevel Risklockout Reset Futures Only F Firmlevel Risklockout Reset Futures Only C Custom Group Id Lockout Reset Futures Only R Productlevel Risklockout Reset Options Only I Firmlevel Risklockout Reset'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
        doc: 'Used To Specify Product Class E'
      - id: custom_group_id
        type: u2
        doc: 'Used To Group Orders For Use In Mass Cancels Where Multiple Orders Can Be Cancelled By Specifying A List Of Custom Group Ids'
  new_complex_instrument_option:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id Chosen By The Client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: num_option_leg
        type: u1
        doc: 'For Complex Orders The Number Of Legs Of The Complex Instrument Specified In The Symbol Field'
      - id: option_leg
        type: option_leg
        repeat: expr
        repeat-expr: num_option_leg
  option_leg:
    seq:
      - id: leg_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'The Symbol Id For The Simple Options On Futures Instrument'
      - id: leg_ratio_qty
        type: u4
        doc: 'Ratio Of Number Of Contracts In This Leg Per Order Quantity'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Side'
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
    1008:
      id: 'new_order'
      doc: 'New order futures message'
    1009:
      id: 'new_order_option'
      doc: 'New order option on futures message'
    1002:
      id: 'modify_order'
      doc: 'Request to modify an order'
    1003:
      id: 'cancel_order'
      doc: 'Request to cancel a single order or quote'
    1004:
      id: 'mass_cancel_order'
      doc: 'A Mass Cancel Order message is a request to cancel a group of orders or quotes'
    1005:
      id: 'purge_orders'
      doc: 'Request to cancel a group of orders or quotes across all the TPH''s sessions for that port’s matching unit'
    1006:
      id: 'quote_update'
      doc: 'Request to enter or update one or more quotes'
    1010:
      id: 'quote_update_option'
      doc: 'Request to enter or update one or more option quotes'
    1007:
      id: 'reset_risk'
      doc: 'Reset or release Firm/EFID, Product, or Custom Group Id level lockout conditions resulting from risk profile trips or self-imposed lockouts issued viaMass Cancel Order or Purge Orders messages'
    1011:
      id: 'new_complex_instrument_option'
      doc: 'A New Complex Instrument message is used to request that the system create a complex strategy'
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
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Expires At The End Of The Business Day'
    0x31:
      id: 'gtc'
      doc: 'Order Remains Until Cancelled Or Contract Expires'
    0x33:
      id: 'ioc'
      doc: 'Portion Not Filled Immediately Is Cancelled'
    0x34:
      id: 'fok'
      doc: 'An Ioc Where The Entire Size Must Be Filled Else The Order Will Be Cancelled Back'
    0x36:
      id: 'gtd'
      doc: 'Expires At The Datetime Specified In The Expire Time Field'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
  mtp_modifier:
    0x4e:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    0x4f:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    0x42:
      id: 'cancel_both'
      doc: 'Cancel Both'
  unique_id_level:
    0x4e:
      id: 'none'
      doc: 'Do Not Prevent Match At Any Level'
    0x46:
      id: 'tph'
      doc: 'Tph'
    0x4d:
      id: 'efid'
      doc: 'Prevent Match At Efid Level'
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
  cti_code:
    0x31:
      id: 'cti_1'
      doc: 'Transactions Initiated And Executed By An Individual Tph For The Tp Hs Own Account For An Account The Tph Controls Or For The Account In Which The Tph Has An Ownership Or Financial Interest'
    0x32:
      id: 'cti_2'
      doc: 'Transactions Executed For The Proprietary Account Of A Clearing Tph Or Nonclearing Tph'
    0x33:
      id: 'cti_3'
      doc: 'Transactions Where An Individual Tph Or Authorized Trader Executes For The Personal Account Of Another Individual Tph For An Account The Other Individual Tph Controls Or For An Account In Which The Other Individual Tph Has An Ownership Or Financial Interest'
    0x34:
      id: 'cti_4'
      doc: 'Any Transaction Not Meeting The Definition Of Cti 12 Or 3'
  manual_order_indicator:
    0x59:
      id: 'manual'
      doc: 'Manual'
    0x4e:
      id: 'automated'
      doc: 'Automated'
  cust_order_handling_inst:
    0x57:
      id: 'desk'
      doc: 'High Touch'
    0x59:
      id: 'electronic'
      doc: 'Electronic'
    0x43:
      id: 'vendorprovided_platform_billed_by'
      doc: 'Vendorprovided Platform Billed By'
    0x47:
      id: 'sponsored_access_via_exchange_api'
      doc: 'Sponsored Access Via Exchange Api'
    0x48:
      id: 'premium_algorithmic_trading'
      doc: 'Premium Algorithmic Trading'
    0x44:
      id: 'other'
      doc: 'Other'
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
  clearing_firm_filter:
    0x41:
      id: 'no_filtering_by_clearing_firm'
      doc: 'No Filtering By Clearing Firm'
    0x46:
      id: 'specified_clearing_firm_optional_field'
      doc: 'Specified Clearing Firm Optional Field'
  acknowledgement_style:
    0x4d:
      id: 'order_cancelled_messages_are_sent_for_each_cancelled_order'
      doc: 'Order Cancelled Messages Are Sent For Each Cancelled Order'
    0x53:
      id: 'a_single_mass_cancel_acknowledgement_message_is_sent'
      doc: 'A Single Mass Cancel Acknowledgement Message Is Sent'
    0x42:
      id: 'both_individual_order_cancelled_and_mass_cancel_acknowledgement_messages_will_be_sent'
      doc: 'Both Individual Order Cancelled And Mass Cancel Acknowledgement Messages Will Be Sent'
  lockout_instruction:
    0x4e:
      id: 'no_lockout'
      doc: 'No Lockout'
    0x4c:
      id: 'lockout_until_corresponding_reset_risk_received'
      doc: 'Lockout Until Corresponding Reset Risk Received'
  instrument_type_filter:
    0x42:
      id: 'both_simple_and_complex_orders'
      doc: 'Both Simple And Complex Orders'
    0x53:
      id: 'simple_orders_only'
      doc: 'Simple Orders Only'
    0x43:
      id: 'spread_orders_only'
      doc: 'Spread Orders Only'
  gtc_order_filter:
    0x43:
      id: 'cancel_gtc_and_gtd_orders'
      doc: 'Cancel Gtc And Gtd Orders'
    0x50:
      id: 'preserve_gtc_and_gtd_orders'
      doc: 'Preserve Gtc And Gtd Orders'
  size_modifier:
    0x52:
      id: 'reduced_size'
      doc: 'Reduce Outstanding Size Of Quote By The Order Qty Provided'
  leg_side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
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
    1501:
      id: 'order_acknowledgement'
      doc: 'Order Acknowledgement messages are sent in response to a new order message'
    1523:
      id: 'order_acknowledgement_option'
      doc: 'Order Acknowledgement messages are sent in response to a new order message'
    1502:
      id: 'order_rejected'
      doc: 'Order Rejected messages are sent in response to a New Order which must be rejected'
    1503:
      id: 'order_modified'
      doc: 'Order Modified messages are sent in response to a Modify Order to indicate that the orderhas been successfully modified'
    1504:
      id: 'modify_rejected'
      doc: 'Modify Rejected messages are sent in response to a Modify Order for an order which cannot be modified'
    1505:
      id: 'order_execution'
      doc: 'AnOrder Executionis sent for each fill on an order'
    1524:
      id: 'order_execution_option'
      doc: 'An Order Execution is sent for each fill on an order'
    1506:
      id: 'order_cancelled'
      doc: 'Order Cancelled message'
    1507:
      id: 'cancel_rejected'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur'
    1508:
      id: 'mass_cancel_acknowledgement'
      doc: 'A Mass Cancel Acknowledgment is an unsequenced message sent when a Cancel Order or Purge Orders message requesting a mass cancellation has completed cancelling all individual orders'
    1509:
      id: 'mass_cancel_rejected'
      doc: 'A Mass Cancel Rejected message is sent in response to a Mass Cancel Order message to indicate that the mass cancellation cannot occur'
    1510:
      id: 'purge_acknowledgement'
      doc: 'A Purge Acknowledgment is an unsequenced message sent when a Purge Orders message requesting an order purge has completed cancelling all individual orders'
    1511:
      id: 'purge_rejected'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur'
    1512:
      id: 'trade_cancel_correct'
      doc: 'Used to provide notification that a trade has been cancelled or corrected'
    1525:
      id: 'trade_cancel_correct_option'
      doc: 'Used to provide notification that an option trade has been cancelled or corrected'
    1513:
      id: 'tas_restatement'
      doc: 'A Tas Restatement is sent post-settlement time for each TAS execution during the associated business day to communicate the updated Price and Symbol associated with the cleared execution'
    1515:
      id: 'quote_update_acknowledgement'
      doc: 'Quote Update Acknowledgment messages are sent in response to a Quote Update or Quote Update Option message'
    1516:
      id: 'quote_update_rejected'
      doc: 'Quote Update Rejected messages are sent in response to a Quote Update or Quote Update Option message when the entire quote block is rejected by the order handler'
    1517:
      id: 'quote_restated'
      doc: 'Quote Restatedmessages are sent to inform the TPH that an order has been asynchronously modified for some reason by CFE'
    1518:
      id: 'quote_execution'
      doc: 'A Quote Execution message is used to indicate an execution has occurred on a resting quote'
    1519:
      id: 'quote_cancelled'
      doc: 'A Quote Cancelled message will be sent to indicate an unsolicited cancellation of a quote entered with a Quote Update message'
    1520:
      id: 'tas_quote_restatement'
      doc: 'A TAS Quote Restatement is sent post-settlement time for each TAS quote execution during the associated business day to communicate the updated Price and Symbol associated with the cleared execution'
    1522:
      id: 'reset_risk_acknowledgement'
      doc: 'Response to a Reset Risk request'
    1526:
      id: 'new_complex_instrument_accepted_option'
      doc: 'The New Complex Instrument Acceptedmessage indicates acceptance of a complex strategy'
    1527:
      id: 'new_complex_instrument_rejected_option'
      doc: 'The New Complex Instrument Rejected indicates that a requested complex strategy has been rejected'
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
      id: 'market_opening_trade'
      doc: 'Opening Reopening'
  sub_liquidity_indicator:
    0x43:
      id: 'carried_order_indicator'
      doc: 'Carried Order Indicator'
    0x55:
      id: 'qualifying_market_turner_order'
      doc: 'Qualifying Market Turner Order'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  pending_status:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x50:
      id: 'pending'
      doc: 'Pending'
  multileg_reporting_type:
    0x31:
      id: 'simple_instrument_execution'
      doc: 'Simple Instrument Execution'
    0x32:
      id: 'part_of_a_spread_execution'
      doc: 'Part Of A Spread Execution'
    0x33:
      id: 'spread_instrument_execution'
      doc: 'Spread Instrument Execution'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  mass_cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  quote_result:
    0x41:
      id: 'new_quote'
      doc: 'New Quote'
    0x4c:
      id: 'modified_loss_of_priority'
      doc: 'Modified Loss Of Priority'
    0x52:
      id: 'modified_retains_priority'
      doc: 'Size Reduction'
    0x4e:
      id: 'no_change'
      doc: 'Matches Existing Quote'
    0x44:
      id: 'new_quote_x44'
      doc: 'May Remove Liquidity'
    0x64:
      id: 'modified_but_may_remove_liquidity'
      doc: 'Modified But May Remove Liquidity'
    0x55:
      id: 'user_cancelled'
      doc: 'Zero Sizeprice'
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
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
    0x53:
      id: 'rejected_symbol_not_found'
      doc: 'Rejected Symbol Not Found'
    0x70:
      id: 'rejected_invalid_price'
      doc: 'Rejected Invalid Price'
    0x73:
      id: 'risk_management_product_root_level'
      doc: 'Risk Management Product Root Level'
    0x6e:
      id: 'risk_management_configuration_is_insuffcient'
      doc: 'Risk Management Configuration Is Insuffcient'
    0x75:
      id: 'rejected_other_reason'
      doc: 'Rejected Other Reason'
  quote_reject_reason:
    0x43:
      id: 'invalid_efid'
      doc: 'Invalid Efid'
    0x44:
      id: 'invalid_wash_id'
      doc: 'Invalid Wash Id'
    0x46:
      id: 'not_enabled_for_quotes'
      doc: 'Not Enabled For Quotes'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'invalid_quote_cnt'
      doc: 'Invalid Quote Cnt'
    0x4d:
      id: 'symbols_not_on_same_matching_engine'
      doc: 'Symbols Not On Same Matching Engine'
    0x4f:
      id: 'invalid_manual_order_indicator'
      doc: 'Invalid Manual Order Indicator'
    0x51:
      id: 'invalid_quote_update_id'
      doc: 'Invalid Quote Update Id'
    0x52:
      id: 'futures_root_does_not_match_across_quotes'
      doc: 'Futures Root Does Not Match Across Quotes'
    0x53:
      id: 'symbol_not_found'
      doc: 'Symbol Not Found'
    0x57:
      id: 'invalid_wash_prevent_type'
      doc: 'Invalid Wash Prevent Type'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x63:
      id: 'invalid_capacity'
      doc: 'Invalid Capacity'
    0x65:
      id: 'invalid_oeoid'
      doc: 'Invalid Oeoid'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x69:
      id: 'invalid_cti_code'
      doc: 'Invalid Cti Code'
    0x6d:
      id: 'invalid_wash_method'
      doc: 'Invalid Wash Method'
    0x6e:
      id: 'exceeds_max_notional_value_per_order'
      doc: 'Exceeds Max Notional Value Per Order'
    0x6f:
      id: 'invalid_open_close'
      doc: 'Invalid Open Close'
    0x70:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x72:
      id: 'invalid_remove'
      doc: 'Invalid Remove'
    0x73:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x75:
      id: 'symbol_range_unreachable'
      doc: 'Symbol Range Unreachable'
    0x78:
      id: 'exceeds_max_size_per_order'
      doc: 'Exceeds Max Size Per Order'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'invalid_size_modifier'
      doc: 'Invalid Size Modifier'
  restatement_reason:
    0x51:
      id: 'liquidity'
      doc: 'Liquidity'
    0x57:
      id: 'wash'
      doc: 'Wash'
  risk_reset_result:
    0x20:
      id: 'ignored'
      doc: 'Ignored'
    0x59:
      id: 'success'
      doc: 'Success'
    0x46:
      id: 'rejected_exceeds_firm_reset_limit'
      doc: 'Rejected Exceeds Firm Reset Limit'
    0x43:
      id: 'rejected_exceeds_custom_group_id'
      doc: 'Rejected Exceeds Custom Group Id'
    0x45:
      id: 'rejected_empty_reset_risk_field'
      doc: 'Rejected Empty Reset Risk Field'
    0x49:
      id: 'rejected_incorrect_data_center'
      doc: 'Rejected Incorrect Data Center'
    0x53:
      id: 'rejected_exceeds_product_level_reset'
      doc: 'Rejected Exceeds Product Level Reset'
    0x55:
      id: 'rejected_invalid_risk_root'
      doc: 'Rejected Invalid Risk Root'
    0x63:
      id: 'rejected_invalid_efid_clearing_firm'
      doc: 'Rejected Invalid Efid Clearing Firm'
    0x79:
      id: 'rejected_in_replay'
      doc: 'Rejected In Replay'
    0x44:
      id: 'custom_group_id_lockout_reset'
      doc: 'Custom Group Id Lockout Reset'

