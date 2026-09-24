# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe NeoEquities OrderEntry Boe3 v1.0.19
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.0.19
#   Date: 12/03/2025
#   Specification: Cboe Canada Equities BOE Specification.pdf
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
  id: cboe_neoequities_orderentry_boe3_v1_0_19_exchange
  title: Cboe NeoEquities OrderEntry Boe3 v1.0.19
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Canada NEO Order Entry Boe3 v1.0.19'
doc-ref: https://www.cboe.com/ca/equities/support/technical/

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
        'exchange_message_type::order_acknowledgement_ca_equities_v_1': order_acknowledgement_ca_equities_v_1
        'exchange_message_type::order_rejected_ca_equities_v_1': order_rejected_ca_equities_v_1
        'exchange_message_type::order_modified_ca_equities_v_1': order_modified_ca_equities_v_1
        'exchange_message_type::modify_rejected_ca_equities_v_1': modify_rejected_ca_equities_v_1
        'exchange_message_type::order_restated_ca_equities_v_1': order_restated_ca_equities_v_1
        'exchange_message_type::order_execution_ca_equities_v_1': order_execution_ca_equities_v_1
        'exchange_message_type::order_cancelled_ca_equities_v_1': order_cancelled_ca_equities_v_1
        'exchange_message_type::cancel_rejected_ca_equities_v_1': cancel_rejected_ca_equities_v_1
        'exchange_message_type::carried_restatement_ca_equities_v_1': carried_restatement_ca_equities_v_1
        'exchange_message_type::done_for_day_ca_equities_v_1': done_for_day_ca_equities_v_1
        'exchange_message_type::trade_cancel_correct_ca_equities_v_1': trade_cancel_correct_ca_equities_v_1

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
  order_acknowledgement_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: order_id
        type: u8
        doc: 'Order Id Supplied By Cboe Canada On The Order Acknowledgement'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Execution Instruction For The Order. Nullable, No ExecInst = 0'
      - id: order_qty
        type: u4
        doc: 'Number Of Shares For Order'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order Type'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: stop_px
        type: decimal_s8_4
        doc: 'The Trigger Price For Stop And Stop Limit Orders. Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        doc: 'The Effective Working Price Of The Order. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'Side Of The Order'
      - id: short_marking_exempt
        type: u1
        enum: short_marking_exempt
        doc: 'Used By Regulators To Identify Directional Neutral Accounts. Nullable, Not Short Marking Exempt = 0'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Symbol Upper Case'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force For The Order'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display Used For Iceberg Orders'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Specifies The Utc Date Time Timestamp That The Order Expires. Nanoseconds since Unix epoch'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Destination Book Of The Order'
      - id: no_trade_feat
        type: u1
        enum: no_trade_feat
        doc: 'Defines How To Prevent A Selftrade'
      - id: no_trade_key
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier For Selftrade Prevention'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Trade Added Or Removed Liquidity Indicator'
      - id: true_min_qty
        type: u4
        doc: 'All Fills Must Be At Least Of Size True Min Qty'
      - id: expire_date
        type: u4
        doc: 'Specifies The Date On Which A Gtd Order Will Expire'
  order_rejected_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason Code For The Order Rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Free Format Text String'
  order_modified_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: order_id
        type: u8
        doc: 'Order Id Supplied By Cboe Canada On The Order Acknowledgement'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force For The Order'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display Used For Iceberg Orders'
      - id: expire_date
        type: u4
        doc: 'Specifies The Date On Which A Gtd Order Will Expire'
      - id: lei_order_origin
        type: u1
        enum: lei_order_origin
        doc: 'Identify The Type Of Customer Sending The Order'
      - id: lei_routing_arrangement_indicator
        type: u1
        enum: lei_routing_arrangement_indicator
        doc: 'Routing Arrangement Is In Place'
      - id: umir_account_type
        type: u1
        enum: umir_account_type
        doc: 'The Capacity For The Order'
      - id: lei_customer_account
        type: str
        size: 20
        encoding: ASCII
        doc: 'Account Number For Clients Not Eligible To Obtain An Lei'
      - id: lei_algorithm_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Identifier For The Endclient Orders Automatically Generated On A Predetermined Basis'
      - id: customer_lei
        type: str
        size: 52
        encoding: ASCII
        doc: 'Lei For Clients Eligible To Obtain An Lei'
      - id: broker_lei
        type: str
        size: 20
        encoding: ASCII
        doc: 'Non Po Iiroc Dealer Member Correspondent Broker'
      - id: order_qty
        type: u4
        doc: 'Number Of Shares For Order'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Cl Ord Id Of The Order Being Cancelled Or Replaced'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Of Shares Still Open For Further Execution'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: stop_px
        type: decimal_s8_4
        doc: 'The Trigger Price For Stop And Stop Limit Orders. Implied decimal with scale 1e-4'
      - id: true_min_qty
        type: u4
        doc: 'All Fills Must Be At Least Of Size True Min Qty'
      - id: secondary_order_id
        type: u8
        doc: 'Populated On A Self Trade Prevention Triggered Cancelrestatement'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Specifies The Utc Date Time Timestamp That The Order Expires. Nanoseconds since Unix epoch'
  modify_rejected_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Cl Ord Id Of The Order Being Cancelled Or Replaced'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Free Format Text String'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Reason Code For The Rejection Of A Modify Order Message'
  order_restated_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: order_id
        type: u8
        doc: 'Order Id Supplied By Cboe Canada On The Order Acknowledgement'
      - id: order_qty
        type: u4
        doc: 'Number Of Shares For Order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Of Shares Still Open For Further Execution'
      - id: secondary_order_id
        type: u8
        doc: 'Populated On A Self Trade Prevention Triggered Cancelrestatement'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: last_shares
        type: u4
        doc: 'Quantity Of Shares On This Fill'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Trade Added Or Removed Liquidity Indicator'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: true_min_qty
        type: u4
        doc: 'All Fills Must Be At Least Of Size True Min Qty'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'Reason For The Restatement'
  order_execution_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: exec_id
        type: u8
        doc: 'Dayunique Id Of Execution Message'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: last_shares
        type: u4
        doc: 'Quantity Of Shares On This Fill'
      - id: order_id
        type: u8
        doc: 'Order Id Supplied By Cboe Canada On The Order Acknowledgement'
      - id: side
        type: u1
        enum: side
        doc: 'Side Of The Order'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Symbol Upper Case'
      - id: trade_date
        type: u4
        doc: 'Business Date For The Trade'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Of Shares Still Open For Further Execution'
      - id: contra_broker
        type: u2
        doc: 'Broker Id Of The Contra Party On This Fill'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Trade Added Or Removed Liquidity Indicator'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: principal_trade
        type: u1
        enum: principal_trade
        doc: 'Broker Executed A Principal Trade Indicator'
      - id: wash_trade
        type: u1
        enum: wash_trade
        doc: 'Broker Executed A Wash Trade Indicator'
      - id: no_trade_feat
        type: u1
        enum: no_trade_feat
        doc: 'Defines How To Prevent A Selftrade'
      - id: no_trade_key
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier For Selftrade Prevention'
      - id: short_marking_exempt
        type: u1
        enum: short_marking_exempt
        doc: 'Used By Regulators To Identify Directional Neutral Accounts. Nullable, Not Short Marking Exempt = 0'
      - id: matching_priority
        type: u1
        enum: matching_priority
        doc: 'The Type Of Priority Used To Match An Order In A Trade'
      - id: is_self_trade
        type: u1
        enum: is_self_trade
        doc: 'Selftrade Indicator'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Fee Code Of The Transaction'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Destination Book Of The Order'
  order_cancelled_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason For The Cancellation'
  cancel_rejected_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Free Format Text String'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Reason For The Cancel Rejection'
  carried_restatement_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id Supplied By Cboe Canada On The Order Acknowledgement'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'Execution Instruction For The Order. Nullable, No ExecInst = 0'
      - id: handling_inst
        type: u1
        enum: handling_inst
        doc: 'Handling Instruction For The Order'
      - id: order_qty
        type: u4
        doc: 'Number Of Shares For Order'
      - id: cum_qty
        type: u4
        doc: 'Cumulative Quantity Filled On The Order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity Of Shares Still Open For Further Execution'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order Type'
      - id: price
        type: decimal_s8_4
        doc: 'Limit Price. Implied decimal with scale 1e-4'
      - id: stop_px
        type: decimal_s8_4
        doc: 'The Trigger Price For Stop And Stop Limit Orders. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'Side Of The Order'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Symbol Upper Case'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time In Force For The Order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Indicates The Settlement Period'
      - id: fut_settl_date
        type: u4
        doc: 'Specific Date Of Trade Settlement'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Destination Book Of The Order'
      - id: max_floor
        type: u4
        doc: 'Portion Of Order Qty To Display Used For Iceberg Orders'
      - id: expire_date
        type: u4
        doc: 'Specifies The Date On Which A Gtd Order Will Expire'
      - id: lei_order_origin
        type: u1
        enum: lei_order_origin
        doc: 'Identify The Type Of Customer Sending The Order'
      - id: lei_routing_arrangement_indicator
        type: u1
        enum: lei_routing_arrangement_indicator
        doc: 'Routing Arrangement Is In Place'
      - id: umir_account_type
        type: u1
        enum: umir_account_type
        doc: 'The Capacity For The Order'
      - id: umir_user_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Identifies The Trader Responsible For The Order Also Known As Trader Id'
      - id: basket_trade
        type: u4
        doc: 'Identification For Order As Part Of A Basket Trade'
      - id: program_trade
        type: u1
        enum: program_trade
        doc: 'Identify This Order As Part Of A Program Trade'
      - id: jitney
        type: u2
        doc: 'Broker On Whose Behalf This Order Is Being Submitted If Different Than The Executing Broker'
      - id: anonymous
        type: u1
        enum: anonymous
        doc: 'Anonymize This Order When Trade Reporting Y Or N'
      - id: umir_regulation_id
        type: u1
        enum: umir_regulation_id
        doc: 'Reported To Feeds Does Not Affect Order Handling'
      - id: non_resident
        type: u1
        enum: non_resident
        doc: 'Identifies An Order As Non Resident'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'Identifies An Order As Eligible To Match Against The Displayed Volume Only'
      - id: ncib
        type: u1
        enum: ncib
        doc: 'Identifies Normal Course Issuer Bid Orders'
      - id: short_marking_exempt
        type: u1
        enum: short_marking_exempt
        doc: 'Used By Regulators To Identify Directional Neutral Accounts. Nullable, Not Short Marking Exempt = 0'
      - id: lei_customer_account
        type: str
        size: 20
        encoding: ASCII
        doc: 'Account Number For Clients Not Eligible To Obtain An Lei'
      - id: lei_algorithm_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique Identifier For The Endclient Orders Automatically Generated On A Predetermined Basis'
      - id: customer_lei
        type: str
        size: 52
        encoding: ASCII
        doc: 'Lei For Clients Eligible To Obtain An Lei'
      - id: broker_lei
        type: str
        size: 20
        encoding: ASCII
        doc: 'Non Po Iiroc Dealer Member Correspondent Broker'
      - id: routing_inst
        type: u1
        enum: routing_inst
        doc: 'Routing Instruction For The Order'
      - id: display_indicator
        type: u1
        enum: display_indicator
        doc: 'Display Visibility Indicator'
      - id: matching_state_participation
        type: u1
        enum: matching_state_participation
        doc: 'Indicates Which Order Flow Type A Passive Dark Order Elects To Interact With'
      - id: true_min_qty
        type: u4
        doc: 'All Fills Must Be At Least Of Size True Min Qty'
  done_for_day_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: broker_id
        type: u2
        doc: 'Identifies The Broker'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Symbol Upper Case'
  trade_cancel_correct_ca_equities_v_1:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Time Of The Transaction. Nanoseconds since Unix epoch'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected Back On Execution Reports Associated With This Order'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order Identifier'
      - id: exec_id
        type: u8
        doc: 'Dayunique Id Of Execution Message'
      - id: exec_ref_id
        type: u8
        doc: 'Refers To The Exec Id Of The Message Being Cancelled Or Corrected'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price Of This Fill. Implied decimal with scale 1e-4'
      - id: last_shares
        type: u4
        doc: 'Quantity Of Shares On This Fill'
      - id: side
        type: u1
        enum: side
        doc: 'Side Of The Order'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        doc: 'Symbol Upper Case'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Trade Added Or Removed Liquidity Indicator'
      - id: corrected_size
        type: u4
        doc: 'Corrected Size Of A Trade'
      - id: umir_user_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Identifies The Trader Responsible For The Order Also Known As Trader Id'
      - id: corrected_price
        type: decimal_s8_4
        doc: 'Corrected Price Of A Trade. Implied decimal with scale 1e-4'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Fee Code Of The Transaction'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Indicates The Settlement Period'
      - id: fut_settl_date
        type: u4
        doc: 'Specific Date Of Trade Settlement'
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
    6001:
      id: 'new_order_ca_equities_v_1'
      doc: 'New order message for Cboe Canada Equities'
    6006:
      id: 'new_order_ca_equities_v_2'
      doc: 'New order V2 message for Cboe Canada Equities, adds PegDifference'
    6002:
      id: 'modify_order_ca_equities_v_1'
      doc: 'Request to modify an existing order'
    6003:
      id: 'cancel_order_ca_equities_v_1'
      doc: 'Request to cancel a single order'
    6004:
      id: 'new_order_cross_ca_equities_v_1'
      doc: 'New Order Cross message for pre-arranged two-sided trades'
    6005:
      id: 'new_order_cross_ca_equities_v_2'
      doc: 'New Order Cross V2 message with Anonymous flag'
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
    0x4d:
      id: 'trade_at_the_pnbbo_midpoint_only'
      doc: 'Trade At The Pnbbo Midpoint Only'
    0x52:
      id: 'trade_at_the_nearside_pnbbo'
      doc: 'Trade At The Nearside Pnbbo'
    0x70:
      id: 'trade_at_the_less_aggressive_of_pnbbo_midpoint_or_minimum_improvement_from_the_pnbbo'
      doc: 'Trade At The Less Aggressive Of Pnbbo Midpoint Or Minimum Improvement From The Pnbbo'
    0x72:
      id: 'late_used_with_time_in_force_7_to_enter_a_late_limit_on_close_lloc'
      doc: 'Late Used With Time In Force 7 To Enter A Late Limit On Close Lloc'
  handling_inst:
    0x31:
      id: 'direct_action_order_dao'
      doc: 'Direct Action Order Dao'
    0x35:
      id: 'protect_and_cancel'
      doc: 'Protect And Cancel'
    0x36:
      id: 'protect_and_reprice'
      doc: 'Protect And Reprice'
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
    0x50:
      id: 'pegged'
      doc: 'Pegged'
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
      id: 'day'
      doc: 'Day'
    0x31:
      id: 'good_til_cancel_gtc'
      doc: 'Good Til Cancel Gtc'
    0x32:
      id: 'at_the_open_opg'
      doc: 'At The Open Opg'
    0x33:
      id: 'immediate_or_cancel_ioc'
      doc: 'Immediate Or Cancel Ioc'
    0x34:
      id: 'fill_or_kill_fok'
      doc: 'Fill Or Kill Fok'
    0x36:
      id: 'good_til_date_gtd_good_til_time_gtt'
      doc: 'Good Til Date Gtd Good Til Time Gtt'
    0x37:
      id: 'at_the_close_atc'
      doc: 'At The Close Atc'
    0x52:
      id: 'regular_hours_only_rho'
      doc: 'Regular Hours Only Rho'
  settlement_type:
    1:
      id: 'cash'
      doc: 'Cash'
    6:
      id: 'future'
      doc: 'Future'
    11:
      id: 'non_net'
      doc: 'Non Net'
  ex_destination:
    0x43:
      id: 'crossing_facility'
      doc: 'Crossing Facility'
    0x44:
      id: 'neod'
      doc: 'Neod'
    0x4c:
      id: 'neol'
      doc: 'Neol'
    0x4e:
      id: 'neon'
      doc: 'Neon'
    0x53:
      id: 'sst'
      doc: 'Sst'
  lei_order_origin:
    5:
      id: 'direct_access_client'
      doc: 'Direct Access Client'
    6:
      id: 'foreign_dealer_equivalent'
      doc: 'Foreign Dealer Equivalent'
    7:
      id: 'order_execution_only_service'
      doc: 'Order Execution Only Service'
  lei_routing_arrangement_indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  umir_account_type:
    0x49:
      id: 'inventory'
      doc: 'Inventory'
    0x4e:
      id: 'non_client'
      doc: 'Non Client'
    0x43:
      id: 'client'
      doc: 'Client'
    0x53:
      id: 'specialist'
      doc: 'Specialist'
    0x46:
      id: 'options_firm_account'
      doc: 'Options Firm Account'
    0x4d:
      id: 'options_market_maker'
      doc: 'Options Market Maker'
    0x42:
      id: 'bundled'
      doc: 'Bundled'
    0x58:
      id: 'multi_client'
      doc: 'Multi Client'
  program_trade:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  anonymous:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  umir_regulation_id:
    0x53:
      id: 'significant_shareholder'
      doc: 'Significant Shareholder'
    0x49:
      id: 'insider'
      doc: 'Insider'
  non_resident:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  bypass:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  ncib:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  no_trade_feat:
    0x54:
      id: 'suppress_from_tape'
      doc: 'Suppress From Tape'
    0x4e:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    0x4f:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    0x44:
      id: 'decrement_larger_cancel_smaller'
      doc: 'Decrement Larger Cancel Smaller'
    0x55:
      id: 'no_self_trade_protection'
      doc: 'No Self Trade Protection'
  short_marking_exempt:
    0x30:
      id: 'short_market_exempt'
      doc: 'Short Market Exempt'
    0x31:
      id: 'buy_of_a_new_order_cross_is_short_marking_exempt'
      doc: 'Buy Of A New Order Cross Is Short Marking Exempt'
    0x32:
      id: 'sell_of_a_new_order_cross_is_short_marking_exempt'
      doc: 'Sell Of A New Order Cross Is Short Marking Exempt'
    0x33:
      id: 'both_sides_of_a_new_order_cross_is_short_marking_exempt'
      doc: 'Both Sides Of A New Order Cross Is Short Marking Exempt'
  routing_inst:
    0x50:
      id: 'post_only_cancel'
      doc: 'Post Only Cancel'
    0x70:
      id: 'post_only_reprice'
      doc: 'Post Only Reprice'
  display_indicator:
    0x56:
      id: 'visible'
      doc: 'Visible'
    0x49:
      id: 'invisible'
      doc: 'Invisible'
  matching_state_participation:
    0x31:
      id: 'active_orders_only'
      doc: 'Active Orders Only'
    0x32:
      id: 'passive_orders_only'
      doc: 'Passive Orders Only'
    0x33:
      id: 'both_active_and_passive_orders'
      doc: 'Both Active And Passive Orders'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_replacement_fails'
      doc: 'Cancel Original Order If Replacement Fails'
  cross_type:
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x44:
      id: 'derivative'
      doc: 'Derivative'
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x4e:
      id: 'net_asset_value_nav'
      doc: 'Net Asset Value Nav'
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x56:
      id: 'vwap'
      doc: 'Vwap'
  cross_side:
    0x38:
      id: 'cross'
      doc: 'Cross'
    0x39:
      id: 'cross_short'
      doc: 'Cross Short'
  buy_umir_account_type:
    0x49:
      id: 'inventory'
      doc: 'Inventory'
    0x4e:
      id: 'non_client'
      doc: 'Non Client'
    0x43:
      id: 'client'
      doc: 'Client'
    0x53:
      id: 'specialist'
      doc: 'Specialist'
    0x46:
      id: 'options_firm_account'
      doc: 'Options Firm Account'
    0x4d:
      id: 'options_market_maker'
      doc: 'Options Market Maker'
    0x42:
      id: 'bundled'
      doc: 'Bundled'
    0x58:
      id: 'multi_client'
      doc: 'Multi Client'
  buy_umir_regulation_id:
    0x53:
      id: 'significant_shareholder'
      doc: 'Significant Shareholder'
    0x49:
      id: 'insider'
      doc: 'Insider'
  buy_lei_order_origin:
    5:
      id: 'direct_access_client'
      doc: 'Direct Access Client'
    6:
      id: 'foreign_dealer_equivalent'
      doc: 'Foreign Dealer Equivalent'
    7:
      id: 'order_execution_only_service'
      doc: 'Order Execution Only Service'
  buy_lei_routing_arrangemeant_indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  sell_umir_account_type:
    0x49:
      id: 'inventory'
      doc: 'Inventory'
    0x4e:
      id: 'non_client'
      doc: 'Non Client'
    0x43:
      id: 'client'
      doc: 'Client'
    0x53:
      id: 'specialist'
      doc: 'Specialist'
    0x46:
      id: 'options_firm_account'
      doc: 'Options Firm Account'
    0x4d:
      id: 'options_market_maker'
      doc: 'Options Market Maker'
    0x42:
      id: 'bundled'
      doc: 'Bundled'
    0x58:
      id: 'multi_client'
      doc: 'Multi Client'
  sell_umir_regulation_id:
    0x53:
      id: 'significant_shareholder'
      doc: 'Significant Shareholder'
    0x49:
      id: 'insider'
      doc: 'Insider'
  sell_lei_order_origin:
    5:
      id: 'direct_access_client'
      doc: 'Direct Access Client'
    6:
      id: 'foreign_dealer_equivalent'
      doc: 'Foreign Dealer Equivalent'
    7:
      id: 'order_execution_only_service'
      doc: 'Order Execution Only Service'
  sell_lei_routing_arrangement_indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  buy_lei_routing_arrangement_indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
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
    6501:
      id: 'order_acknowledgement_ca_equities_v_1'
      doc: 'Order Acknowledgement sent in response to a New Order message'
    6502:
      id: 'order_rejected_ca_equities_v_1'
      doc: 'Order Rejected message sent in response to a New Order or New Order Cross that must be rejected'
    6503:
      id: 'order_modified_ca_equities_v_1'
      doc: 'Order Modified message sent in response to a Modify Order indicating successful modification'
    6504:
      id: 'modify_rejected_ca_equities_v_1'
      doc: 'Modify Rejected message sent in response to a Modify Order that cannot be modified'
    6505:
      id: 'order_restated_ca_equities_v_1'
      doc: 'Order Restated message sent when iceberg order reloads or when self-trade protection reduces an order'
    6506:
      id: 'order_execution_ca_equities_v_1'
      doc: 'Order Execution message sent for each fill on an order'
    6507:
      id: 'order_cancelled_ca_equities_v_1'
      doc: 'Order Cancelled message'
    6508:
      id: 'cancel_rejected_ca_equities_v_1'
      doc: 'Cancel Rejected message sent when a Cancel Order cancellation cannot occur'
    6510:
      id: 'carried_restatement_ca_equities_v_1'
      doc: 'Carried Restatement message used to indicate restoration of a multi-day GTC or GTD order at the start of a new business day'
    6511:
      id: 'done_for_day_ca_equities_v_1'
      doc: 'Done For Day message representing orders persisted during the current day session to carry over to the next session'
    6512:
      id: 'trade_cancel_correct_ca_equities_v_1'
      doc: 'Trade Cancel or Correct notification that a trade has been busted or corrected'
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
      id: 'trade_added_liquidity'
      doc: 'Trade Added Liquidity'
    0x52:
      id: 'trade_removed_liquidity'
      doc: 'Trade Removed Liquidity'
    0x43:
      id: 'auction_trade'
      doc: 'Auction Trade'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
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
    0x4c:
      id: 'order_would_cross_or_lock_nbbo'
      doc: 'Order Would Cross Or Lock Nbbo'
    0x4e:
      id: 'ran_out_of_liquidity'
      doc: 'Ran Out Of Liquidity'
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
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x75:
      id: 'circuit_breaker_threshold_breach_limit_up_down'
      doc: 'Circuit Breaker Threshold Breach Limit Up Down'
    0x79:
      id: 'order_received_by_cboe_canada_during_replay'
      doc: 'Order Received By Cboe Canada During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
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
    0x4c:
      id: 'order_would_cross_or_lock_nbbo'
      doc: 'Order Would Cross Or Lock Nbbo'
    0x4e:
      id: 'ran_out_of_liquidity'
      doc: 'Ran Out Of Liquidity'
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
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x75:
      id: 'circuit_breaker_threshold_breach_limit_up_down'
      doc: 'Circuit Breaker Threshold Breach Limit Up Down'
    0x79:
      id: 'order_received_by_cboe_canada_during_replay'
      doc: 'Order Received By Cboe Canada During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  restatement_reason:
    0x4c:
      id: 'reload_iceberg_display_size_refreshed'
      doc: 'Reload Iceberg Display Size Refreshed'
    0x50:
      id: 'reprice_ex_opr_mtl'
      doc: 'Reprice Ex Opr Mtl'
    0x57:
      id: 'partial_reduce_due_selftrade_prevention_result_based_on_no_trade_feat'
      doc: 'Partial Reduce Due Selftrade Prevention Result Based On No Trade Feat'
    0x54:
      id: 'triggered_stop_order'
      doc: 'Triggered Stop Order'
  principal_trade:
    0x59:
      id: 'broker_executed_a_principal_trade'
      doc: 'Broker Executed A Principal Trade'
    0x4e:
      id: 'all_other_cases'
      doc: 'All Other Cases'
  wash_trade:
    0x59:
      id: 'broker_executed_a_wash_trade'
      doc: 'Broker Executed A Wash Trade'
    0x4e:
      id: 'all_other_cases'
      doc: 'All Other Cases'
  matching_priority:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'broker_preferencing'
      doc: 'Broker Preferencing'
    100:
      id: 'market_maker_preferential_trading'
      doc: 'Market Maker Preferential Trading'
  is_self_trade:
    0x59:
      id: 'broker_executed_a_selftrade_using_no_trade_feat_t_suppress_from_tape'
      doc: 'Broker Executed A Selftrade Using No Trade Feat T Suppress From Tape'
    0x4e:
      id: 'all_other_cases'
      doc: 'All Other Cases'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Most Rejects Due To Field Validation Errors Will Be Reported With A Reason Of Admin'
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
    0x4c:
      id: 'order_would_cross_or_lock_nbbo'
      doc: 'Order Would Cross Or Lock Nbbo'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
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
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x75:
      id: 'circuit_breaker_threshold_breach_limit_up_down'
      doc: 'Circuit Breaker Threshold Breach Limit Up Down'
    0x79:
      id: 'order_received_by_cboe_canada_during_replay'
      doc: 'Order Received By Cboe Canada During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
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
    0x4c:
      id: 'order_would_cross_or_lock_nbbo'
      doc: 'Order Would Cross Or Lock Nbbo'
    0x4e:
      id: 'ran_out_of_liquidity'
      doc: 'Ran Out Of Liquidity'
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
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x75:
      id: 'circuit_breaker_threshold_breach_limit_up_down'
      doc: 'Circuit Breaker Threshold Breach Limit Up Down'
    0x79:
      id: 'order_received_by_cboe_canada_during_replay'
      doc: 'Order Received By Cboe Canada During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'

