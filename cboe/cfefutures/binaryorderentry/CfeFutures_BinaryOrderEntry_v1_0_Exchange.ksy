# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures BinaryOrderEntry Boe3 v1.0
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Futures Binary Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.0
#   Date: 5/21/2021
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
  id: cboe_cfefutures_binaryorderentry_boe3_v1_0_exchange
  title: Cboe CfeFutures BinaryOrderEntry Boe3 v1.0
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange Futures Binary Order Entry Boe3 v1.0'
doc-ref: http://markets.cboe.com/us/futures/support/technical

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
        'exchange_message_type::order_acknowledgement_message': order_acknowledgement_message
        'exchange_message_type::order_rejected_message': order_rejected_message
        'exchange_message_type::order_modified_message': order_modified_message
        'exchange_message_type::modify_rejected_message': modify_rejected_message
        'exchange_message_type::order_execution_message': order_execution_message
        'exchange_message_type::order_cancelled_message': order_cancelled_message
        'exchange_message_type::cancel_rejected_message': cancel_rejected_message
        'exchange_message_type::mass_cancel_acknowledgement_message': mass_cancel_acknowledgement_message
        'exchange_message_type::mass_cancel_rejected_message': mass_cancel_rejected_message
        'exchange_message_type::purge_acknowledgement_message': purge_acknowledgement_message
        'exchange_message_type::purge_rejected_message': purge_rejected_message
        'exchange_message_type::trade_cancel_or_correct_message': trade_cancel_or_correct_message
        'exchange_message_type::tas_restatement_message': tas_restatement_message
        'exchange_message_type::variance_restatement_message': variance_restatement_message
        'exchange_message_type::quote_update_acknowledgement_message': quote_update_acknowledgement_message
        'exchange_message_type::quote_update_rejected_message': quote_update_rejected_message
        'exchange_message_type::quote_restated_message': quote_restated_message
        'exchange_message_type::quote_execution_message': quote_execution_message
        'exchange_message_type::quote_cancelled_message': quote_cancelled_message
        'exchange_message_type::tas_quote_restatement_message': tas_quote_restatement_message
        'exchange_message_type::variance_quote_restatement_message': variance_quote_restatement_message
        'exchange_message_type::reset_risk_acknowledgement_message': reset_risk_acknowledgement_message

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
  order_acknowledgement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id Chosen By The Client'
      - id: order_id
        type: u8
        doc: 'Order Identifier Supplied By Cfe'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
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
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: prevent_match
        type: prevent_match
      - id: maturity_date
        type: u4
        doc: 'Used To Specify The Expiration Date Of The Symbol Within The Specified Product Class'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates Status Of Client Position In A Trade Resulting From The Order. Nullable, None = 0'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Still Open For Further Execution'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates Whether The Trade Added Or Removed Liquidity'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required For Time In Force 6 Orders Specifies The Datetime In Utc That The Order Expires. Nanoseconds since Unix epoch'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional Information About The Liquidity Of An Order. Nullable, No Additional Information = 0'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop Price. Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        doc: 'Cmta Number Of The Firm That Will Clear The Trade'
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
      - id: cum_qty
        type: u4
        doc: 'Cumulative Quantity'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Supplemental Customer Identifier Used For Billing Related Programs'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'Execution Source Code Provided During Order Entry To Describe Broker Service. Nullable, Apply Default = 0'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'The Earliest Timestamp Populated With Nanosecond Precision Recorded By Cfe Of The Corresponding Inbound Message Being Acknowledged. Nanoseconds since Unix epoch'
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
  order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
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
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason For The Order Rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human Readable Text With More Information'
  order_modified_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
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
      - id: order_id
        type: u8
        doc: 'Order Identifier Supplied By Cfe'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order Type'
      - id: order_qty
        type: u4
        doc: 'Order Quantity'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Still Open For Further Execution'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates Whether The Trade Added Or Removed Liquidity'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop Price. Implied decimal with scale 1e-4'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Supplemental Customer Identifier Used For Billing Related Programs'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'Execution Source Code Provided During Order Entry To Describe Broker Service. Nullable, Apply Default = 0'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'The Earliest Timestamp Populated With Nanosecond Precision Recorded By Cfe Of The Corresponding Inbound Message Being Acknowledged. Nanoseconds since Unix epoch'
  modify_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
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
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'See Order Reason Codes On Page 174'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human Readable Text With More Information'
  order_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id Chosen By The Client'
      - id: exec_id
        type: u8
        doc: 'Sent To The Occ In The Trade Id Field'
      - id: last_shares
        type: u4
        doc: 'Executed Contracts Quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Still Open For Further Execution'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates Whether The Trade Added Or Removed Liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional Information About The Liquidity Of An Order. Nullable, No Additional Information = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Simple Instruments Can Be Specified By Providing The Mapped Symbol Format In The Symbol Field Or By Providing The Product Name E'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: maturity_date
        type: u4
        doc: 'Used To Specify The Expiration Date Of The Symbol Within The Specified Product Class'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates Fee Associated With An Execution'
      - id: trade_date
        type: u4
        doc: 'Business Date Of The Execution'
      - id: clearing_size
        type: u4
        doc: 'Size To Clear With Occ'
      - id: pending_status
        type: u1
        enum: pending_status
        doc: 'Field Is Provided As A Convenience To Determine Whether An Order Execution Message Is A Preliminary Notification Representing A Pending Trade'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Present On Order Execution And Tas Restatement Messages Representing Either Spread Orders Or Simple Orders That Are Part Spread Execution'
      - id: secondary_exec_id
        type: u8
        doc: 'Indicates Whether An Execution Is A Spread Or A Simple Instrument Execution That Is Part Of A Spread Trade'
  order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
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
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Cancel Reason'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'The Earliest Timestamp Populated With Nanosecond Precision Recorded By Cfe Of The Corresponding Inbound Message Being Acknowledged. Nanoseconds since Unix epoch'
  cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
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
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Cancel Reject Reason'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human Readable Text With More Information'
  mass_cancel_acknowledgement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Userdefined Identifier Of The Mass Cancel Or Purge Request'
      - id: cancelled_order_count
        type: u4
        doc: 'Number Of Orders Cancelled'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'The Earliest Timestamp Populated With Nanosecond Precision Recorded By Cfe Of The Corresponding Inbound Message Being Acknowledged. Nanoseconds since Unix epoch'
  mass_cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Userdefined Identifier Of The Mass Cancel Or Purge Request'
      - id: mass_cancel_reject_reason
        type: u1
        enum: mass_cancel_reject_reason
        doc: 'Reason For The Mass Cancel Rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human Readable Text With More Information'
  purge_acknowledgement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Userdefined Identifier Of The Mass Cancel Or Purge Request'
      - id: cancelled_order_count
        type: u4
        doc: 'Number Of Orders Cancelled'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'The Earliest Timestamp Populated With Nanosecond Precision Recorded By Cfe Of The Corresponding Inbound Message Being Acknowledged. Nanoseconds since Unix epoch'
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Userdefined Identifier Of The Mass Cancel Or Purge Request'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Reason For The Purge Rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human Readable Text With More Information'
  trade_cancel_or_correct_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Id Chosen By The Client'
      - id: exec_ref_id
        type: u8
        doc: 'Refers To The Exec Id Of The Fill Being Cancelled Or Corrected'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates Whether The Trade Added Or Removed Liquidity'
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
      - id: last_shares
        type: u4
        doc: 'Executed Contracts Quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: corrected_price
        type: decimal_s8_4
        doc: 'For Trade Corrections This Is The New Trade Price. Implied decimal with scale 1e-4'
      - id: orig_time
        type: nanosecond_timestamp
        doc: 'The Date And Time Of The Original Trade In Gmt. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Simple Instruments Can Be Specified By Providing The Mapped Symbol Format In The Symbol Field Or By Providing The Product Name E'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
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
  tas_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
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
      - id: exec_id
        type: u8
        doc: 'Sent To The Occ In The Trade Id Field'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Simple Instruments Can Be Specified By Providing The Mapped Symbol Format In The Symbol Field Or By Providing The Product Name E'
      - id: maturity_date
        type: u4
        doc: 'Used To Specify The Expiration Date Of The Symbol Within The Specified Product Class'
      - id: last_shares
        type: u4
        doc: 'Executed Contracts Quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates Fee Associated With An Execution'
      - id: trade_date
        type: u4
        doc: 'Business Date Of The Execution'
      - id: clearing_price
        type: decimal_s8_4
        doc: 'Price As Sent To Clearing After Applying Postclose Conversions To The Original Last Px Value. Implied decimal with scale 1e-4'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol As Sent To Clearing After Applying Postclose Conversions To The Original Symbol'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Present On Order Execution And Tas Restatement Messages Representing Either Spread Orders Or Simple Orders That Are Part Spread Execution'
      - id: secondary_exec_id
        type: u8
        doc: 'Indicates Whether An Execution Is A Spread Or A Simple Instrument Execution That Is Part Of A Spread Trade'
  variance_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
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
      - id: exec_id
        type: u8
        doc: 'Sent To The Occ In The Trade Id Field'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Simple Instruments Can Be Specified By Providing The Mapped Symbol Format In The Symbol Field Or By Providing The Product Name E'
      - id: maturity_date
        type: u4
        doc: 'Used To Specify The Expiration Date Of The Symbol Within The Specified Product Class'
      - id: last_shares
        type: u4
        doc: 'Executed Contracts Quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates Fee Associated With An Execution'
      - id: trade_date
        type: u4
        doc: 'Business Date Of The Execution'
      - id: clearing_price
        type: decimal_s8_4
        doc: 'Price As Sent To Clearing After Applying Postclose Conversions To The Original Last Px Value. Implied decimal with scale 1e-4'
      - id: clearing_size
        type: u4
        doc: 'Size To Clear With Occ'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol As Sent To Clearing After Applying Postclose Conversions To The Original Symbol'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Present On Order Execution And Tas Restatement Messages Representing Either Spread Orders Or Simple Orders That Are Part Spread Execution'
      - id: secondary_exec_id
        type: u8
        doc: 'Indicates Whether An Execution Is A Spread Or A Simple Instrument Execution That Is Part Of A Spread Trade'
  quote_update_acknowledgement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'The Earliest Timestamp Populated With Nanosecond Precision Recorded By Cfe Of The Corresponding Inbound Message Being Acknowledged. Nanoseconds since Unix epoch'
      - id: num_quote_update_acknowledgement_group
        type: u1
        doc: 'Number Of Repeating Groups Included In This Message'
      - id: quote_update_acknowledgement_group
        type: quote_update_acknowledgement_group
        repeat: expr
        repeat-expr: num_quote_update_acknowledgement_group
  quote_update_acknowledgement_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Order Identifier Supplied By Cfe'
      - id: quote_result
        type: u1
        enum: quote_result
        doc: 'Result Of The Quote Request'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional Information About The Liquidity Of An Order. Nullable, No Additional Information = 0'
  quote_update_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'Reason For The Quote Rejection'
  quote_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: order_id
        type: u8
        doc: 'Order Identifier Supplied By Cfe'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Still Open For Further Execution'
      - id: working_price
        type: decimal_s8_4
        doc: 'The Price At Which The Quote Is Working On The Order Book. Implied decimal with scale 1e-4'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cfe Native Identifier Of The Instrument Being Quoted'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The Reason For This Quote Restated Message'
  quote_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: order_id
        type: u8
        doc: 'Order Identifier Supplied By Cfe'
      - id: exec_id
        type: u8
        doc: 'Sent To The Occ In The Trade Id Field'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cfe Native Identifier Of The Instrument Being Quoted'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'Efid That Will Clear The Trade'
      - id: last_shares
        type: u4
        doc: 'Executed Contracts Quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Still Open For Further Execution'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates Whether The Trade Added Or Removed Liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional Information About The Liquidity Of An Order. Nullable, No Additional Information = 0'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates Fee Associated With An Execution'
  quote_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: order_id
        type: u8
        doc: 'Order Identifier Supplied By Cfe'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cfe Native Identifier Of The Instrument Being Quoted'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Cancel Reason'
  tas_quote_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: exec_id
        type: u8
        doc: 'Sent To The Occ In The Trade Id Field'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cfe Native Identifier Of The Instrument Being Quoted'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol As Sent To Clearing After Applying Postclose Conversions To The Original Symbol'
      - id: clearing_price
        type: decimal_s8_4
        doc: 'Price As Sent To Clearing After Applying Postclose Conversions To The Original Last Px Value. Implied decimal with scale 1e-4'
  variance_quote_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The Time The Event Occurred In The Cfe Matching Engine Not The Time The Message Was Sent. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Id Chosen By The Client'
      - id: exec_id
        type: u8
        doc: 'Sent To The Occ In The Trade Id Field'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cfe Native Identifier Of The Instrument Being Quoted'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol As Sent To Clearing After Applying Postclose Conversions To The Original Symbol'
      - id: clearing_price
        type: decimal_s8_4
        doc: 'Price As Sent To Clearing After Applying Postclose Conversions To The Original Last Px Value. Implied decimal with scale 1e-4'
      - id: clearing_size
        type: u4
        doc: 'Size To Clear With Occ'
  reset_risk_acknowledgement_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique Identifier For This Reset Risk Request'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: 'Result Of Risk Rest'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'The Earliest Timestamp Populated With Nanosecond Precision Recorded By Cfe Of The Corresponding Inbound Message Being Acknowledged. Nanoseconds since Unix epoch'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
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
    1001:
      id: 'new_order_message'
      doc: 'New order futures message'
    1002:
      id: 'modify_order_message'
      doc: 'Request to modify an order'
    1003:
      id: 'cancel_order_message'
      doc: 'Request to cancel a single order or quote'
    1004:
      id: 'mass_cancel_order_message'
      doc: 'A Mass Cancel Order message is a request to cancel a group of orders or quotes'
    1005:
      id: 'purge_orders_message'
      doc: 'Request to cancel a group of orders or quotes across all the TPH''s sessions for that port’s matching unit'
    1006:
      id: 'quote_update_message'
      doc: 'Request to enter or update one or more quotes'
    1007:
      id: 'reset_risk_message'
      doc: 'Reset or release Firm/EFID, Product, or Custom Group Id level lockout conditions resulting from risk profile trips or self-imposed lockouts issued viaMass Cancel Order or Purge Orders messages'
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
      id: 'order_acknowledgement_message'
      doc: 'Order Acknowledgement messages are sent in response to a new order message'
    1502:
      id: 'order_rejected_message'
      doc: 'Order Rejected messages are sent in response to a New Order which must be rejected'
    1503:
      id: 'order_modified_message'
      doc: 'Order Modified messages are sent in response to a Modify Order to indicate that the orderhas been successfully modified'
    1504:
      id: 'modify_rejected_message'
      doc: 'Modify Rejected messages are sent in response to a Modify Order for an order which cannot be modified'
    1505:
      id: 'order_execution_message'
      doc: 'An Order Execution is sent for each fill on an order'
    1506:
      id: 'order_cancelled_message'
      doc: 'Order Cancelled message'
    1507:
      id: 'cancel_rejected_message'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur'
    1508:
      id: 'mass_cancel_acknowledgement_message'
      doc: 'A Mass Cancel Acknowledgment is an unsequenced message sent when a Cancel Order or Purge Orders message requesting a mass cancellation has completed cancelling all individual orders'
    1509:
      id: 'mass_cancel_rejected_message'
      doc: 'A Mass Cancel Rejected message is sent in response to a Mass Cancel Order message to indicate that the mass cancellation cannot occur'
    1510:
      id: 'purge_acknowledgement_message'
      doc: 'A Purge Acknowledgment is an unsequenced message sent when a Purge Orders message requesting an order purge has completed cancelling all individual orders'
    1511:
      id: 'purge_rejected_message'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur'
    1512:
      id: 'trade_cancel_or_correct_message'
      doc: 'Used to provide notification that a trade has been cancelled or corrected'
    1513:
      id: 'tas_restatement_message'
      doc: 'A Tas Restatement is sent post-settlement time for each TAS execution during the associated business day to communicate the updated Price and Symbol associated with the cleared execution'
    1514:
      id: 'variance_restatement_message'
      doc: 'A Variance Restatement is sent post-settlement time for each VA and VAO execution during the associated business day to communicate updated Price, Size and Symbol associated with the cleared execution'
    1515:
      id: 'quote_update_acknowledgement_message'
      doc: 'Quote Update Acknowledgment messages are sent in response to a Quote Update or Quote Update Option message'
    1516:
      id: 'quote_update_rejected_message'
      doc: 'Quote Update Rejected messages are sent in response to a Quote Update or Quote Update Option message when the entire quote block is rejected by the order handler'
    1517:
      id: 'quote_restated_message'
      doc: 'Quote Restated messages are sent to inform the TPH that an order has been asynchronously modified for some reason by CFE'
    1518:
      id: 'quote_execution_message'
      doc: 'A Quote Execution message is used to indicate an execution has occurred on a resting quote'
    1519:
      id: 'quote_cancelled_message'
      doc: 'A Quote Cancelled message will be sent to indicate an unsolicited cancellation of a quote entered with a Quote Update message'
    1520:
      id: 'tas_quote_restatement_message'
      doc: 'A TAS Quote Restatement is sent post-settlement time for each TAS quote execution during the associated business day to communicate the updated Price and Symbol associated with the cleared execution'
    1521:
      id: 'variance_quote_restatement_message'
      doc: 'A Variance Quote Restatement is sent post-settlement time for each VA and VAO execution during the associated business day to communicate updated Price, Size, and Symbol values associated with the cleared execution'
    1522:
      id: 'reset_risk_acknowledgement_message'
      doc: 'Response to a Reset Risk request'
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

