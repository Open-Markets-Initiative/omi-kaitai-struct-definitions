# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options BinaryOrderEntry Boe3 v1.1.23
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Binary Order Entry 3
#   Version: 1.1.23
#   Date: 09/14/2026
#   Specification: technical-specifications-cboe-titanium-us-options-boev3-specification.pdf
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
  id: cboe_c1options_binaryorderentry_boe3_v1_1_23_exchange
  title: Cboe C1Options BinaryOrderEntry Boe3 v1.1.23
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C1 Options Binary Order Entry Boe3 v1.1.23'
doc-ref: https://www.cboe.com/us/options/support/technical

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
        'exchange_message_type::cross_order_acknowledgment_message': cross_order_acknowledgment_message
        'exchange_message_type::quote_update_acknowledgement_message': quote_update_acknowledgement_message
        'exchange_message_type::order_rejected_message': order_rejected_message
        'exchange_message_type::cross_order_rejected_message': cross_order_rejected_message
        'exchange_message_type::quote_update_rejected_message': quote_update_rejected_message
        'exchange_message_type::order_modified_message': order_modified_message
        'exchange_message_type::order_restated_message': order_restated_message
        'exchange_message_type::quote_restated_message': quote_restated_message
        'exchange_message_type::modify_rejected_message': modify_rejected_message
        'exchange_message_type::order_cancelled_message': order_cancelled_message
        'exchange_message_type::quote_cancelled_message': quote_cancelled_message
        'exchange_message_type::cross_order_cancelled_message': cross_order_cancelled_message
        'exchange_message_type::cancel_rejected_message': cancel_rejected_message
        'exchange_message_type::order_execution_message': order_execution_message
        'exchange_message_type::quote_execution_message': quote_execution_message
        'exchange_message_type::complex_quote_execution_message': complex_quote_execution_message
        'exchange_message_type::trade_cancel_correct_message': trade_cancel_correct_message
        'exchange_message_type::purge_rejected_message': purge_rejected_message
        'exchange_message_type::reset_risk_acknowledgement_message': reset_risk_acknowledgement_message
        'exchange_message_type::mass_cancel_acknowledgment_message': mass_cancel_acknowledgment_message
        'exchange_message_type::mass_cancel_rejected_message': mass_cancel_rejected_message
        'exchange_message_type::purge_acknowledgement_message': purge_acknowledgement_message
        'exchange_message_type::purge_notification_message': purge_notification_message
        'exchange_message_type::new_complex_instrument_accepted_message': new_complex_instrument_accepted_message
        'exchange_message_type::new_complex_instrument_rejected_message': new_complex_instrument_rejected_message
        'exchange_message_type::carried_restatement_message': carried_restatement_message
        'exchange_message_type::done_for_day_message': done_for_day_message
        'exchange_message_type::floor_trade_notification_message': floor_trade_notification_message
        'exchange_message_type::floor_trade_confirmation_rejected_message': floor_trade_confirmation_rejected_message
        'exchange_message_type::add_floor_trade_rejected_message': add_floor_trade_rejected_message
        'exchange_message_type::delete_floor_trade_rejected_message': delete_floor_trade_rejected_message
        'exchange_message_type::floor_order_represented_message': floor_order_represented_message
        'exchange_message_type::delete_floor_trade_acknowledgement_message': delete_floor_trade_acknowledgement_message

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
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
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
        doc: 'Side'
      - id: price
        type: decimal_s8_4
        doc: 'Limit price. Implied decimal with scale 1e-4'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: display_price
        type: decimal_s8_4
        doc: 'Only present when order is fully or partially booked. Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        doc: 'If price had to be adjusted to a less aggressive value for some reason, the adjusted price will be reported here, otherwise equals price. Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional information about an execution. Nullable, No Additional Information = 0'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
  cross_order_acknowledgment_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Day-unique identifier for the cross order chosen by the member'
      - id: auction_id
        type: u8
        doc: 'Auction order identifier supplied by Cboe'
      - id: price
        type: decimal_s8_4
        doc: 'Limit price. Implied decimal with scale 1e-4'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: order_qty
        type: u4
        doc: 'Order quantity'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
      - id: num_acknowledgement_allocation
        type: u1
        doc: 'Number of allocation party repeating groups in the message'
      - id: acknowledgement_allocation
        type: acknowledgement_allocation
        repeat: expr
        repeat-expr: num_acknowledgement_allocation
  acknowledgement_allocation:
    seq:
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
        doc: 'Side'
      - id: alloc_qty
        type: u4
        doc: 'Number of contracts for this party'
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'For the Agency Side, this field must equal the value of ClearingFirm'
  quote_update_acknowledgement_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the member'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
      - id: num_quote_acknowledgement
        type: u1
        doc: 'Number of quotes in the message'
      - id: quote_acknowledgement
        type: quote_acknowledgement
        repeat: expr
        repeat-expr: num_quote_acknowledgement
  quote_acknowledgement:
    seq:
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: quote_result
        type: u1
        enum: quote_result
        doc: 'Result of the quote request'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional information about an execution. Nullable, No Additional Information = 0'
      - id: quote_reject_sub_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character sub-reason code for the rejection of a quote'
  order_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: order_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of an order'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  cross_order_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Day-unique identifier for the cross order chosen by the member'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: order_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of an order'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  quote_update_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the member'
      - id: quote_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of an order'
  order_modified_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'OrigClOrdID'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: order_qty
        type: u4
        doc: 'Order quantity'
      - id: price
        type: decimal_s8_4
        doc: 'Limit price. Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'OrdType'
      - id: max_floor
        type: u4
        doc: 'Portion of OrderQty to display'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop price. Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: display_price
        type: decimal_s8_4
        doc: 'Only present when order is fully or partially booked. Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        doc: 'If price had to be adjusted to a less aggressive value for some reason, the adjusted price will be reported here, otherwise equals price. Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: secondary_order_id
        type: u8
        doc: 'Denotes an alternative OrderID which is present on Cboe market data'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
  order_restated_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
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
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: order_restatement_reason
        type: u1
        enum: order_restatement_reason
        doc: 'The reason for this Order Restated message'
      - id: order_qty
        type: u4
        doc: 'Order quantity'
      - id: price
        type: decimal_s8_4
        doc: 'Limit price. Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: display_price
        type: decimal_s8_4
        doc: 'Only present when order is fully or partially booked. Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        doc: 'If price had to be adjusted to a less aggressive value for some reason, the adjusted price will be reported here, otherwise equals price. Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: secondary_order_id
        type: u8
        doc: 'Denotes an alternative OrderID which is present on Cboe market data'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price of this fill. Implied decimal with scale 1e-4'
  quote_restated_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the member'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: working_price
        type: decimal_s8_4
        doc: 'If price had to be adjusted to a less aggressive value for some reason, the adjusted price will be reported here, otherwise equals price. Implied decimal with scale 1e-4'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Entire Cboe format symbol for a quote update'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Quote Restated message'
  modify_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'OrigClOrdID'
      - id: modify_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of a modify'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  order_cancelled_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: cancel_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the cancellation reason'
      - id: cancel_sub_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the cancellation sub-reason'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
  quote_cancelled_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the member'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Entire Cboe format symbol for a quote update'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: cancel_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the cancellation reason'
      - id: cancel_sub_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the cancellation sub-reason'
  cross_order_cancelled_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Day-unique identifier for the cross order chosen by the member'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: cancel_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the cancellation reason'
      - id: num_allocation_cancelled
        type: u1
        doc: 'Number of allocation party repeating groups in the message'
      - id: allocation_cancelled
        type: allocation_cancelled
        repeat: expr
        repeat-expr: num_allocation_cancelled
  allocation_cancelled:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'For the Agency Side, this field must equal the value of ClearingFirm'
  cancel_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: cancel_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the cancel rejection reason'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  order_execution_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: exec_id
        type: u8
        doc: 'Execution ID'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price of this fill. Implied decimal with scale 1e-4'
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
        doc: 'Internally matched simple executions will identify the OCC clearing number of the contra on the execution'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Only present on local book trades, not present on routed trades'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        doc: 'Capacity of the contra for this execution'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates fee associated with an execution'
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'MarketingFeeCode'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        doc: 'CrossExclusionIndicator'
      - id: trade_date
        type: u4
        doc: 'TradeDate'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Indicates the type of Order Execution message'
      - id: secondary_exec_id
        type: u8
        doc: 'Indicates whether a fill or partial fill is a complex instrument fill or a single leg fill that comprises a complex execution'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'PriceType'
      - id: trade_through_alert_type
        type: u1
        enum: trade_through_alert_type
        doc: 'Indication of a type of trade through'
      - id: sender_location_id
        type: u1
        enum: sender_location_id
        doc: 'Sender Location Id'
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor Acronym of member submitting trade'
      - id: floor_trade_time
        type: nanosecond_timestamp
        doc: 'Trade time reported by the trading floor. Nanoseconds since Unix epoch'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Used to specify the designated away venue'
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        doc: 'Valid when an equity symbol is present in the complex instrument'
  quote_execution_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the member'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: exec_id
        type: u8
        doc: 'Execution ID'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Entire Cboe format symbol for a quote update'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price of this fill. Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Only present on local book trades, not present on routed trades'
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        doc: 'Capacity of the contra for this execution'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional information about an execution. Nullable, No Additional Information = 0'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates fee associated with an execution'
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'MarketingFeeCode'
      - id: trade_date
        type: u4
        doc: 'TradeDate'
  complex_quote_execution_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the member'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe'
      - id: exec_id
        type: u8
        doc: 'Execution ID'
      - id: quote_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Entire Cboe format symbol for a quote update'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price of this fill. Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Only present on local book trades, not present on routed trades'
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        doc: 'Capacity of the contra for this execution'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Additional information about an execution. Nullable, No Additional Information = 0'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates fee associated with an execution'
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'MarketingFeeCode'
      - id: trade_date
        type: u4
        doc: 'TradeDate'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Indicates the type of Order Execution message'
      - id: secondary_exec_id
        type: u8
        doc: 'Indicates whether a fill or partial fill is a complex instrument fill or a single leg fill that comprises a complex execution'
  trade_cancel_correct_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
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
        doc: 'Side'
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
        doc: 'EFID that will clear the trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to OnBehalfOfSubID (116) and ClearingAccount (440) in'
      - id: last_shares
        type: u4
        doc: 'Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Price of this fill. Implied decimal with scale 1e-4'
      - id: corrected_price
        type: decimal_s8_4
        doc: 'Price of the trade after adjustment. Implied decimal with scale 1e-4'
      - id: corrected_size
        type: u4
        doc: 'Number of shares after trade adjustment'
      - id: orig_time
        type: nanosecond_timestamp
        doc: 'Time of the original transaction. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: maturity_date
        type: u4
        doc: 'When sending Cboe native symbology, set MaturityDate to zero'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Strike Price for option. Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'When sending Cboe native symbology, set PutOrCall to ASCII NUL (0x00)'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity of the order'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates status of member position in the option'
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'MarketingFeeCode'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'A valid Parent ID of the Directed Market Maker'
      - id: cmta_number
        type: u4
        doc: 'CMTA Number of the firm that will clear the trade'
  purge_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'If the populated value ends in a space the message will be rejected'
      - id: purge_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of a purge request'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  reset_risk_acknowledgement_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'User defined identifier of a Reset Risk message'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: '<space> = Ignored; exceeds 1 reset per 100 milliseconds'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
  mass_cancel_acknowledgment_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'If the populated value ends in a space the message will be rejected'
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled by the mass cancel or purge operation'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
  mass_cancel_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'If the populated value ends in a space the message will be rejected'
      - id: mass_cancel_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of a mass cancel reject request'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  purge_acknowledgement_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'If the populated value ends in a space the message will be rejected'
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled by the mass cancel or purge operation'
      - id: source_matching_unit
        type: u1
        doc: 'Matching unit originating the message'
      - id: request_received_time
        type: nanosecond_timestamp
        doc: 'A hardware timestamp, populated with nanosecond precision, that. Nanoseconds since Unix epoch'
  purge_notification_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'If the populated value ends in a space the message will be rejected'
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled by the mass cancel or purge operation'
      - id: source_matching_unit
        type: u1
        doc: 'Matching unit originating the message'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        doc: 'The underlying symbol'
      - id: mass_cancel_lockout
        type: u1
        enum: mass_cancel_lockout
        doc: 'Reports the status of the mass cancel lockout'
  new_complex_instrument_accepted_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: no_of_securities
        type: u4
        doc: 'Indicates the number of securities created by the member in this trading session'
      - id: num_complex_leg
        type: u1
        doc: 'Number of leg repeating groups in the message'
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
        doc: 'Entire Cboe format symbol'
      - id: maturity_date
        type: u4
        doc: 'When sending Cboe native symbology, set MaturityDate to zero'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Strike Price for option. Implied decimal with scale 1e-4'
      - id: cfi_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'CFI Code for leg'
      - id: ratio_qty
        type: u4
        doc: 'Integer ratio of a complex leg with respect to the other legs of a'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
  new_complex_instrument_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: no_of_securities
        type: u4
        doc: 'Indicates the number of securities created by the member in this trading session'
      - id: order_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of an order'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  carried_restatement_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
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
        doc: 'Side'
      - id: price
        type: decimal_s8_4
        doc: 'Limit price. Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        doc: 'ExecInst'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'OrdType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'TimeInForce'
      - id: min_qty
        type: u4
        doc: 'Minimum fill quantity for IOC orders which only interact with liquidity'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity of the order'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Reflected back on execution reports associated with this order'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to OnBehalfOfSubID (116) and ClearingAccount (440) in'
      - id: display_indicator
        type: u1
        enum: display_indicator
        doc: 'DisplayIndicator'
      - id: max_floor
        type: u4
        doc: 'Portion of OrderQty to display'
      - id: order_qty
        type: u4
        doc: 'Order quantity'
      - id: prevent_match
        type: prevent_match
      - id: maturity_date
        type: u4
        doc: 'When sending Cboe native symbology, set MaturityDate to zero'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Strike Price for option. Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'When sending Cboe native symbology, set PutOrCall to ASCII NUL (0x00)'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates status of member position in the option'
      - id: leaves_qty
        type: u4
        doc: 'Quantity still open for further execution'
      - id: display_price
        type: decimal_s8_4
        doc: 'Only present when order is fully or partially booked. Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        doc: 'If price had to be adjusted to a less aggressive value for some reason, the adjusted price will be reported here, otherwise equals price. Implied decimal with scale 1e-4'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Required for TimeInForce = 6 orders, specifies the date-time (in UTC). Nanoseconds since Unix epoch'
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        doc: 'Allows for an order to be attributed to a firm''s Executing Broker ID in Cboe market data feeds'
      - id: stop_px
        type: decimal_s8_4
        doc: 'Stop price. Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        doc: 'Routing Instruction'
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        doc: 'Routing Strategy'
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        doc: 'RouteDeliveryMethod'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Used to specify the designated away venue'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'A valid Parent ID of the Directed Market Maker'
      - id: auction_id
        type: u8
        doc: 'Auction order identifier supplied by Cboe'
      - id: cmta_number
        type: u4
        doc: 'CMTA Number of the firm that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'Clearing optional data'
      - id: cum_qty
        type: u4
        doc: 'The total quantity traded by the order'
      - id: drill_thru_protection
        type: decimal_s8_4
        doc: 'Amount sender is willing to trade through the SNBBO. Implied decimal with scale 1e-4'
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'MPID used to clear the equity leg being cleared via the Exchange'
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        doc: 'User defined identifier for quote attribution'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies the frequent trader program in which the order is participating'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        doc: 'Session Eligibility'
      - id: combo_order
        type: u1
        enum: combo_order
        doc: 'Declare the order as a Combo'
      - id: compression
        type: u1
        enum: compression
        doc: 'Order is a compression trade'
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        doc: 'Specifies a default PAR workstation (ex'
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        doc: 'FloorRoutingInst'
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor acronym of Market Maker on whose behalf this order is being'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'PriceType'
      - id: strategy_id
        type: u1
        enum: strategy_id
        doc: 'Used to declare when a strategy is used'
      - id: held
        type: u1
        enum: held
        doc: 'Indicates if order should be designated as ''Held'' upon order entry'
  prevent_match:
    seq:
      - id: mtp_modifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Instrument type filter'
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
  done_for_day_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
  floor_trade_notification_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: exec_id
        type: u8
        doc: 'Execution ID'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Entire Cboe format symbol'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'When sending Cboe native symbology, set PutOrCall to ASCII NUL (0x00)'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Strike Price for option. Implied decimal with scale 1e-4'
      - id: maturity_date
        type: u4
        doc: 'When sending Cboe native symbology, set MaturityDate to zero'
      - id: order_qty
        type: u4
        doc: 'Order quantity'
      - id: price
        type: decimal_s8_4
        doc: 'Limit price. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Only present on local book trades, not present on routed trades'
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor Acronym of member submitting trade'
      - id: floor_trade_time
        type: nanosecond_timestamp
        doc: 'Trade time reported by the trading floor. Nanoseconds since Unix epoch'
      - id: trade_through_alert_type
        type: u1
        enum: trade_through_alert_type
        doc: 'Indication of a type of trade through'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'PriceType'
  floor_trade_confirmation_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: exec_id
        type: u8
        doc: 'Execution ID'
      - id: order_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of an order'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  add_floor_trade_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: order_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of an order'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  delete_floor_trade_rejected_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: exec_id
        type: u8
        doc: 'Execution ID'
      - id: order_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Single character code for the rejection of an order'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Printable ASCII text, null (0x00) terminated'
  floor_order_represented_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
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
        doc: 'EFID that will clear the trade'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used to optionally convey the routing firm of the order'
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor Acronym of member submitting trade'
      - id: order_restatement_reason
        type: u1
        enum: order_restatement_reason
        doc: 'The reason for this Order Restated message'
  delete_floor_trade_acknowledgement_message:
    seq:
      - id: in_flight
        type: u2
        doc: 'Total number of messages "in-flight" from the port'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The exchange timestamp of the transaction. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client'
      - id: exec_id
        type: u8
        doc: 'Execution ID'
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
    0x07e7:
      id: 'new_complex_order_v_2_message'
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
    0x07e1:
      id: 'complex_quote_update_message'
      doc: 'Request to enter or update one or more quotes for quotable complex options'
    0x07e2:
      id: 'complex_quote_update_short_message'
      doc: 'A shorter version of Complex Quote Update messages which restricts the information which can be presented'
    0x07e5:
      id: 'purge_orders_v_2_message'
      doc: 'Request to cancel a group of orders across all the firm’s sessions'
    0x07de:
      id: 'reset_risk_message'
      doc: 'Reset or release Firm, Risk Root, or Custom Group ID level lockout conditions resulting from risk profile trips or self-imposed lockouts issued via Cancel Order or Purge Orders messages'
    0x07e4:
      id: 'floor_trade_confirmation_message'
      doc: 'TPHs are encouraged to use Floor Trade Confirmation messages to respond to Floor Trade Notification messages if they agree with the terms of the trade'
    0x07e3:
      id: 'add_floor_trade_message'
      doc: 'TPHs having in-person Market Makers on the Cboe trading floor can enter their version of a floor trade using the Add Floor Trade message'
    0x07e6:
      id: 'delete_floor_trade_message'
      doc: 'TPHs with in-person Market Makers on the Cboe trading floor can request the deletion of a floor trade using the Delete Floor Trade message type'
  replay_instruction:
    0x44:
      id: 'deep_replay_of_specified_unit'
      doc: 'Deep Replay Of Specified Unit'
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
    0x31:
      id: 'not_held'
      doc: 'Not Held'
    0x66:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x72:
      id: 'settlement_liquidity'
      doc: 'Settlement Liquidity'
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
    0x4c:
      id: 'non_trading_permit_holder_affiliate'
      doc: 'Non Trading Permit Holder Affiliate'
  display_indicator:
    0x56:
      id: 'default_field'
      doc: 'As determined by port level setting (default to S)'
    0x50:
      id: 'price_adjust'
      doc: 'Price Adjust'
    0x6d:
      id: 'multiple_price_adjust'
      doc: 'Multiple Price Adjust'
    0x52:
      id: 'reject_the_order_if_it_cannot_be_booked_and_displayed_without_adjustment'
      doc: 'Reject The Order If It Cannot Be Booked And Displayed Without Adjustment'
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
    0x49:
      id: 'iex_options'
      doc: 'Iex Options'
    0x4a:
      id: 'mx_2_options'
      doc: 'Mx 2 Options'
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
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
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
    0x34:
      id: 'pcc'
      doc: 'Position Compression Cross'
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
    0x33:
      id: 'market_no_starting_price_adjustments'
      doc: 'Market No Starting Price Adjustments'
    0x34:
      id: 'limit_no_starting_price_adjustments'
      doc: 'Limit No Starting Price Adjustments'
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
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
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
  use_drill_thru_override:
    0x4e:
      id: 'no_field'
      doc: 'Do not use the value present in DrillThruProtection'
    0x59:
      id: 'yes_field'
      doc: 'Use the value present in DrillThruProtection'
  combo_order:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  equity_ex_destination:
    0x43:
      id: 'td_securities_usa_llc_default'
      doc: 'Td Securities Usa Llc Default'
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
    0x46:
      id: 'compression_forum'
      doc: 'Compression Forum'
    0x42:
      id: 'box_spread'
      doc: 'Box Spread'
    0x41:
      id: 'box_swap'
      doc: 'Box Swap'
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
  stop_px_type:
    0x4c:
      id: 'fixed_limit_price'
      doc: 'Fixed Limit Price'
    0x42:
      id: 'fixed_underlying_bid_price_or_index_level'
      doc: 'Complex orders only'
    0x41:
      id: 'fixed_underlying_ask_price_or_index_level'
      doc: 'Complex orders only'
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
      doc: 'Do not remove liquidity'
    0x42:
      id: 'book_only'
      doc: 'Allow removal of liquidity'
    0x4e:
      id: 'book_only_no_slide'
      doc: 'Book Only No Slide'
    0x52:
      id: 'post_only_no_slide'
      doc: 'Do not remove liquidity'
    0x49:
      id: 'book_only_ioc'
      doc: 'Book Only Ioc'
  size_modifier:
    0x52:
      id: 'reduce_outstanding_size_of_quote_by_the_order_qty_provided'
      doc: 'Reduce Outstanding Size Of Quote By The Order Qty Provided'
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
    0x09e1:
      id: 'complex_quote_execution_message'
      doc: 'A Complex Quote Execution message is used to indicate an execution has occurred on a resting complex quote'
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
    0x09e2:
      id: 'floor_trade_notification_message'
      doc: 'TPHs with Market Makers on the Cboe trading floor may optionally receive Floor Trade Notification messages'
    0x09e4:
      id: 'floor_trade_confirmation_rejected_message'
      doc: 'The Add Floor Trade Rejected message is used to indicate that a requested Add Floor Trade message has been rejected'
    0x09e3:
      id: 'add_floor_trade_rejected_message'
      doc: 'The Add Floor Trade Rejected message is used to indicate that a requested Add Floor Trade message has been rejected'
    0x09e5:
      id: 'delete_floor_trade_rejected_message'
      doc: 'The Delete Floor Trade Rejected message is used to indicate that a requested Delete Floor Trade message has been rejected'
    0x09e7:
      id: 'floor_order_represented_message'
      doc: 'Orders routed to the trading floor will be represented before being traded in open outcry'
    0x09e6:
      id: 'delete_floor_trade_acknowledgement_message'
      doc: 'A Delete Floor Trade Acknowledgment message is an unsequenced message sent when a Delete Floor Trade message has been accepted'
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
    0x52:
      id: 'replay_too_deep'
      doc: 'Replay Too Deep'
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
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day'
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
    0x4a:
      id: 'nbbo_joiner'
      doc: 'Nbbo Joiner'
    0x42:
      id: 'step_up_mechanism'
      doc: 'Step Up Mechanism'
    0x55:
      id: 'market_turner'
      doc: 'Market Turner'
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
    0x50:
      id: 'pcc'
      doc: 'Pcc'
    0x46:
      id: 'rfc'
      doc: 'Rfc'
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
    0x46:
      id: 'represented_on_floor'
      doc: 'Represented On Floor'
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
    0x66:
      id: 'unsolicited_floor_action'
      doc: 'Unsolicited Floor Action'
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
  trade_through_alert_type:
    0x30:
      id: 'no_trade_through'
      doc: 'No Trade Through'
    0x31:
      id: 'nbbo'
      doc: 'Nbbo'
    0x32:
      id: 'bbo'
      doc: 'local best bid or offer'
    0x33:
      id: 'sbbo'
      doc: 'Market quote of complex derived by legs'
    0x34:
      id: 'book_trade_through'
      doc: 'trade through customer size'
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

