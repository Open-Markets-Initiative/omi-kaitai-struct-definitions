# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Orders Ouch v5.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Orders
#   Encoding: Ouch
#   Version: 5.0
#   Date: 4/1/2023
#   Specification: OUCH5.0.pdf
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
  id: nasdaq_nsmequities_orders_ouch_v5_0_server
  title: Nasdaq NsmEquities Orders Ouch v5.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Orders Ouch v5.0'
doc-ref: https://nasdaqtrader.com/Trader.aspx?id=TradingSpecs

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: _parent.server_packet_header.packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::order_accepted_message': order_accepted_message
            'sequenced_message_type::replaced_message': replaced_message
            'sequenced_message_type::canceled_message': canceled_message
            'sequenced_message_type::aiq_canceled_message': aiq_canceled_message
            'sequenced_message_type::order_executed_message': order_executed_message
            'sequenced_message_type::broken_trade_message': broken_trade_message
            'sequenced_message_type::rejected_order_message': rejected_order_message
            'sequenced_message_type::cancel_pending_message': cancel_pending_message
            'sequenced_message_type::cancel_reject_message': cancel_reject_message
            'sequenced_message_type::order_priority_update_message': order_priority_update_message
            'sequenced_message_type::order_modified_message': order_modified_message
            'sequenced_message_type::order_restated_message': order_restated_message
            'sequenced_message_type::account_query_response_message': account_query_response_message
            'sequenced_message_type::mass_cancel_response_message': mass_cancel_response_message
            'sequenced_message_type::disable_order_entry_response_message': disable_order_entry_response_message
            'sequenced_message_type::enable_order_entry_response_message': enable_order_entry_response_message
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event Code'
  order_accepted_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the order. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Corresponds to TimeInForce (59) in Nasdaq FIX'
      - id: display
        type: u1
        enum: display
        doc: 'Display'
      - id: order_reference_number
        type: u8
        doc: 'The day-unique Order Reference Number assigned by NASDAQ to this order'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
      - id: inter_market_sweep_eligibility
        type: u1
        enum: inter_market_sweep_eligibility
        doc: 'InterMarket Sweep Eligibility'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'CrossType'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Order State'
      - id: clordid
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer order identifier. ClOrdID will not be checked for day-uniqueness for each OUCH account'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: order_accepted_appendage
        type: order_accepted_appendage
        repeat: eos
        doc: 'Order Accepted Appendage'
  order_accepted_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: order_accepted_optional_field
        type: u1
        enum: order_accepted_optional_field
        doc: 'Appendage Id'
      - id: order_accepted_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: order_accepted_optional_field
          cases:
            'order_accepted_optional_field::firm': firm_value
            'order_accepted_optional_field::minqty': min_qty_value
            'order_accepted_optional_field::customertype': customer_type_value
            'order_accepted_optional_field::maxfloor': max_floor_value
            'order_accepted_optional_field::pricetype': price_type_value
            'order_accepted_optional_field::pegoffset': peg_offset_value
            'order_accepted_optional_field::discretionprice': discretion_price_value
            'order_accepted_optional_field::discretionpricetype': discretion_price_type_value
            'order_accepted_optional_field::discretionpegoffset': discretion_peg_offset_value
            'order_accepted_optional_field::postonly': post_only_value
            'order_accepted_optional_field::randomreserves': random_reserves_value
            'order_accepted_optional_field::route': route_value
            'order_accepted_optional_field::expiretime': expire_time_value
            'order_accepted_optional_field::tradenow': trade_now_value
            'order_accepted_optional_field::handleinst': handle_inst_value
            'order_accepted_optional_field::bbo_weight_indicator': bbo_weight_indicator_value
            'order_accepted_optional_field::group_id': group_id_value
            'order_accepted_optional_field::shares_located': shares_located_value
            'order_accepted_optional_field::userrefidx': user_ref_idx_value
            'order_accepted_optional_field::aiq_strategy': aiq_strategy_value
            'order_accepted_optional_field::aiq_group_id': aiq_group_id_value
  replaced_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: orig_user_ref_num
        type: u4
        doc: 'This must be filled out with the Order UserRefNum sent on the Enter Order Message or last Replace Order Message'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the order. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Corresponds to TimeInForce (59) in Nasdaq FIX'
      - id: display
        type: u1
        enum: display
        doc: 'Display'
      - id: order_reference_number
        type: u8
        doc: 'The day-unique Order Reference Number assigned by NASDAQ to this order'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
      - id: inter_market_sweep_eligibility
        type: u1
        enum: inter_market_sweep_eligibility
        doc: 'InterMarket Sweep Eligibility'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'CrossType'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Order State'
      - id: clordid
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer order identifier. ClOrdID will not be checked for day-uniqueness for each OUCH account'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: replaced_message_appendage
        type: replaced_message_appendage
        repeat: eos
        doc: 'Replaced Message Appendage'
  replaced_message_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: replaced_message_optional_field
        type: u1
        enum: replaced_message_optional_field
        doc: 'Appendage Id'
      - id: replaced_message_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: replaced_message_optional_field
          cases:
            'replaced_message_optional_field::firm': firm_value
            'replaced_message_optional_field::minqty': min_qty_value
            'replaced_message_optional_field::maxfloor': max_floor_value
            'replaced_message_optional_field::pricetype': price_type_value
            'replaced_message_optional_field::postonly': post_only_value
            'replaced_message_optional_field::expiretime': expire_time_value
            'replaced_message_optional_field::tradenow': trade_now_value
            'replaced_message_optional_field::handleinst': handle_inst_value
            'replaced_message_optional_field::bbo_weight_indicator': bbo_weight_indicator_value
            'replaced_message_optional_field::userrefidx': user_ref_idx_value
            'replaced_message_optional_field::aiq_strategy': aiq_strategy_value
            'replaced_message_optional_field::aiq_group_id': aiq_group_id_value
  canceled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: cancel_order_reason
        type: u1
        enum: cancel_order_reason
        doc: 'Reason the order was reduced or canceled'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: canceled_message_appendage
        type: canceled_message_appendage
        repeat: eos
        doc: 'Canceled Message Appendage'
  canceled_message_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: canceled_message_optional_field
        type: u1
        enum: canceled_message_optional_field
        doc: 'Appendage Id'
      - id: canceled_message_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: canceled_message_optional_field
          cases:
            'canceled_message_optional_field::userrefidx': user_ref_idx_value
  aiq_canceled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: decrement_shares
        type: u4
        doc: 'The number of shares just decremented from the order. This number is incremental, not cumulative'
      - id: order_cancel_reason
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason the order was reduced or canceled. For an AIQ Cancel message, this value will always be “Q”'
      - id: quantity_prevented_from_trading
        type: u4
        doc: 'Shares that would have executed if the trade would have occurred. Depending on AIQ type and the sizes of orders in question the value for this field could either be the same or different than the Decrement Shares field. For “Decrement both” they are always the same. For “Cancel oldest” they will be different if the incoming order is smaller than the resting order'
      - id: execution_price
        type: decimal_u8_4
        doc: 'Price at which the trade would have occurred. Implied decimal with scale 1e-4'
      - id: liquidity_flag
        type: u1
        enum: liquidity_flag
        doc: 'Liquidity flag the order would have received'
      - id: aiq_strategy
        type: u1
        enum: aiq_strategy
        doc: 'AIQ strategy used on the cancelled order'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: aiq_canceled_appendage
        type: aiq_canceled_appendage
        repeat: eos
        doc: 'AIQ Canceled Appendage'
  aiq_canceled_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: aiq_canceled_optional_field
        type: u1
        enum: aiq_canceled_optional_field
        doc: 'Appendage Id'
      - id: aiq_canceled_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: aiq_canceled_optional_field
          cases:
            'aiq_canceled_optional_field::userrefidx': user_ref_idx_value
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the order. Implied decimal with scale 1e-4'
      - id: liquidity_flag
        type: u1
        enum: liquidity_flag
        doc: 'Liquidity flag the order would have received'
      - id: match_number
        type: u8
        doc: 'Assigned by the exchange to identify the trade. Both the buy and the sell executions participating in the trade will share the same match number'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: order_executed_appendage
        type: order_executed_appendage
        repeat: eos
        doc: 'Order Executed Appendage'
  order_executed_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: order_executed_optional_field
        type: u1
        enum: order_executed_optional_field
        doc: 'Appendage Id'
      - id: order_executed_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: order_executed_optional_field
          cases:
            'order_executed_optional_field::userrefidx': user_ref_idx_value
  broken_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: match_number
        type: u8
        doc: 'Assigned by the exchange to identify the trade. Both the buy and the sell executions participating in the trade will share the same match number'
      - id: broken_trade_reason
        type: u1
        enum: broken_trade_reason
        doc: 'The reason the trade was broken'
      - id: clordid
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer order identifier. ClOrdID will not be checked for day-uniqueness for each OUCH account'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: broken_trade_appendage
        type: broken_trade_appendage
        repeat: eos
        doc: 'Broken Trade Appendage'
  broken_trade_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: broken_trade_optional_field
        type: u1
        enum: broken_trade_optional_field
        doc: 'Appendage Id'
      - id: broken_trade_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: broken_trade_optional_field
          cases:
            'broken_trade_optional_field::userrefidx': user_ref_idx_value
  rejected_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: rejected_order_reason
        type: u2
        enum: rejected_order_reason
        doc: 'The reason the order was rejected'
      - id: clordid
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer order identifier. ClOrdID will not be checked for day-uniqueness for each OUCH account'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: rejected_order_appendage
        type: rejected_order_appendage
        repeat: eos
        doc: 'Rejected Order Appendage'
  rejected_order_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: rejected_order_optional_field
        type: u1
        enum: rejected_order_optional_field
        doc: 'Appendage Id'
      - id: rejected_order_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: rejected_order_optional_field
          cases:
            'rejected_order_optional_field::userrefidx': user_ref_idx_value
  cancel_pending_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: cancel_pending_appendage
        type: cancel_pending_appendage
        repeat: eos
        doc: 'Cancel Pending Appendage'
  cancel_pending_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: cancel_pending_optional_field
        type: u1
        enum: cancel_pending_optional_field
        doc: 'Appendage Id'
      - id: cancel_pending_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: cancel_pending_optional_field
          cases:
            'cancel_pending_optional_field::userrefidx': user_ref_idx_value
  cancel_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: cancel_reject_appendage
        type: cancel_reject_appendage
        repeat: eos
        doc: 'Cancel Reject Appendage'
  cancel_reject_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: cancel_reject_optional_field
        type: u1
        enum: cancel_reject_optional_field
        doc: 'Appendage Id'
      - id: cancel_reject_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: cancel_reject_optional_field
          cases:
            'cancel_reject_optional_field::userrefidx': user_ref_idx_value
  order_priority_update_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the order. Implied decimal with scale 1e-4'
      - id: display
        type: u1
        enum: display
        doc: 'Display'
      - id: order_reference_number
        type: u8
        doc: 'The day-unique Order Reference Number assigned by NASDAQ to this order'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: order_priority_update_appendage
        type: order_priority_update_appendage
        repeat: eos
        doc: 'Order Priority Update Appendage'
  order_priority_update_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: order_priority_update_optional_field
        type: u1
        enum: order_priority_update_optional_field
        doc: 'Appendage Id'
      - id: order_priority_update_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: order_priority_update_optional_field
          cases:
            'order_priority_update_optional_field::userrefidx': user_ref_idx_value
  order_modified_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: order_modified_appendage
        type: order_modified_appendage
        repeat: eos
        doc: 'Order Modified Appendage'
  order_modified_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: order_modified_optional_field
        type: u1
        enum: order_modified_optional_field
        doc: 'Appendage Id'
      - id: order_modified_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: order_modified_optional_field
          cases:
            'order_modified_optional_field::userrefidx': user_ref_idx_value
            'order_modified_optional_field::shares_located': shares_located_value
            'order_modified_optional_field::locate_broker': locate_broker_value
  order_restated_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: order_restated_reason
        type: u1
        enum: order_restated_reason
        doc: 'The reason for this order being restated'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: order_restated_appendage
        type: order_restated_appendage
        repeat: eos
        doc: 'Order Restated Appendage'
  order_restated_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: order_restated_optional_field
        type: u1
        enum: order_restated_optional_field
        doc: 'Appendage Id'
      - id: order_restated_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: order_restated_optional_field
          cases:
            'order_restated_optional_field::display_quantity': display_quantity_value
            'order_restated_optional_field::display_price': display_price_value
            'order_restated_optional_field::secondaryordrefnum': secondary_ord_ref_num_value
            'order_restated_optional_field::userrefidx': user_ref_idx_value
  account_query_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: next_user_ref_num
        type: u4
        doc: 'The next available UserRefNum'
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage field'
      - id: account_query_response_appendage
        type: account_query_response_appendage
        repeat: eos
        doc: 'Account Query Response Appendage'
  account_query_response_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: account_query_response_optional_field
        type: u1
        enum: account_query_response_optional_field
        doc: 'Appendage Id'
      - id: account_query_response_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: account_query_response_optional_field
          cases:
            'account_query_response_optional_field::userrefidx': user_ref_idx_value
  mass_cancel_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain all caps. Firm identifier for the order entry firm. One logical OUCH account can potentially enter orders for multiple firms in a Service Bureau configuration'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: mass_cancel_response_appendage
        type: mass_cancel_response_appendage
        repeat: eos
        doc: 'Mass Cancel Response Appendage'
  mass_cancel_response_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: mass_cancel_response_optional_field
        type: u1
        enum: mass_cancel_response_optional_field
        doc: 'Appendage Id'
      - id: mass_cancel_response_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: mass_cancel_response_optional_field
          cases:
            'mass_cancel_response_optional_field::side': side_value
            'mass_cancel_response_optional_field::group_id': group_id_value
            'mass_cancel_response_optional_field::userrefidx': user_ref_idx_value
  disable_order_entry_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain all caps. Firm identifier for the order entry firm. One logical OUCH account can potentially enter orders for multiple firms in a Service Bureau configuration'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: disable_order_entry_response_appendage
        type: disable_order_entry_response_appendage
        repeat: eos
        doc: 'Disable Order Entry Response Appendage'
  disable_order_entry_response_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: disable_order_entry_response_optional_field
        type: u1
        enum: disable_order_entry_response_optional_field
        doc: 'Appendage Id'
      - id: disable_order_entry_response_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: disable_order_entry_response_optional_field
          cases:
            'disable_order_entry_response_optional_field::userrefidx': user_ref_idx_value
  enable_order_entry_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Expressed as nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: user_ref_num
        type: u4
        doc: 'UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain all caps. Firm identifier for the order entry firm. One logical OUCH account can potentially enter orders for multiple firms in a Service Bureau configuration'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: enable_order_entry_response_appendage
        type: enable_order_entry_response_appendage
        repeat: eos
        doc: 'Enable Order Entry Response Appendage'
  enable_order_entry_response_appendage:
    seq:
      - id: optional_field_length
        type: u1
        doc: 'Appendage Length Type'
      - id: enable_order_entry_response_optional_field
        type: u1
        enum: enable_order_entry_response_optional_field
        doc: 'Appendage Id'
      - id: enable_order_entry_response_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: enable_order_entry_response_optional_field
          cases:
            'enable_order_entry_response_optional_field::userrefidx': user_ref_idx_value
  firm_value:
    seq:
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain all caps. Firm identifier for the order entry firm. One logical OUCH account can potentially enter orders for multiple firms in a Service Bureau configuration'
  min_qty_value:
    seq:
      - id: min_qty
        type: u4
        doc: 'MinQty must be a round lot'
  customer_type_value:
    seq:
      - id: customer_type
        type: u1
        enum: customer_type
        doc: 'CustomerType'
  max_floor_value:
    seq:
      - id: max_floor
        type: u4
        doc: 'Represents the portion of your order that you wish to have displayed'
  price_type_value:
    seq:
      - id: price_type
        type: u1
        enum: price_type
        doc: 'PriceType'
  peg_offset_value:
    seq:
      - id: peg_offset
        type: decimal_s4_4
        doc: 'Offset amount for the pegged value. Implied decimal with scale 1e-4'
  discretion_price_value:
    seq:
      - id: discretion_price
        type: decimal_u8_4
        doc: 'Discretion price for Discretionary Order. Implied decimal with scale 1e-4'
  discretion_price_type_value:
    seq:
      - id: discretion_price_type
        type: u1
        enum: discretion_price_type
        doc: 'DiscretionPriceType'
  discretion_peg_offset_value:
    seq:
      - id: discretion_peg_offset
        type: decimal_s4_4
        doc: 'Offset amount for the pegged value of the Discretionary Price. Implied decimal with scale 1e-4'
  post_only_value:
    seq:
      - id: post_only
        type: u1
        enum: post_only
        doc: 'PostOnly'
  random_reserves_value:
    seq:
      - id: random_reserves
        type: u4
        doc: 'Shares to do random reserve with'
  route_value:
    seq:
      - id: route
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Route'
  expire_time_value:
    seq:
      - id: expire_time
        type: u4
        doc: 'Seconds to live. Must be less than 86400 (number of seconds in a day)'
  trade_now_value:
    seq:
      - id: trade_now
        type: u1
        enum: trade_now
        doc: 'TradeNow'
  handle_inst_value:
    seq:
      - id: handle_inst
        type: u1
        enum: handle_inst
        doc: 'HandleInst'
  bbo_weight_indicator_value:
    seq:
      - id: bbo_weight_indicator
        type: u1
        enum: bbo_weight_indicator
        doc: 'BBO Weight Indicator'
  group_id_value:
    seq:
      - id: group_id
        type: u2
        doc: 'Customer Group ID – identifies specific entity'
  shares_located_value:
    seq:
      - id: shares_located
        type: u1
        enum: shares_located
        doc: 'Shares located for short sale order'
  user_ref_idx_value:
    seq:
      - id: user_ref_idx
        type: u1
        doc: 'User Reference Index – identifies the channel within the given port'
  aiq_strategy_value:
    seq:
      - id: aiq_strategy
        type: u1
        enum: aiq_strategy
        doc: 'AIQ strategy used on the cancelled order'
  aiq_group_id_value:
    seq:
      - id: aiq_group_id
        type: str
        size: 2
        encoding: ASCII
        doc: 'Specified to enable self match prevention at a more granular level within a given matching level'
  locate_broker_value:
    seq:
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker code from which the locate has been acquired for short sale orders'
  display_quantity_value:
    seq:
      - id: display_quantity
        type: u4
        doc: 'Used in the Order Restated Message only. Represents an update of an order''s displayed quantity (i.e. an order with reserves)'
  display_price_value:
    seq:
      - id: display_price
        type: decimal_u8_4
        doc: 'Used in the Order Restated Message only. Represents an update of an order''s displayed price. Implied decimal with scale 1e-4'
  secondary_ord_ref_num_value:
    seq:
      - id: secondary_ord_ref_num
        type: u8
        doc: 'An alternative order reference number used when publishing the order on the Nasdaq market data feeds (identifying, for example, the displayed portion of a reserve order)'
  side_value:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Side'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  unsequenced_message_type:
    0x4f:
      id: 'enter_order_message'
      doc: 'Enter Order Message'
    0x55:
      id: 'replace_order_message'
      doc: 'The Replace Order Message allows you to cancel and replace an existing order in a single message. This is more efficient than canceling an existing order and immediately succeeding it with a new order. Replacing an order always gives it a new timestamp for its time priority on the book. If you wish you simply partially cancel an order and retain its time priority, send a Cancel Order Message instead.'
    0x58:
      id: 'cancel_order_message'
      doc: 'The Cancel Order Message is used to request that an order be canceled or reduced. In the Cancel Order Message, you must specify the new "intended order size" for the order. The "intended order size" is the maximum number of shares that can be executed in total after the cancel is applied.'
    0x4d:
      id: 'modify_order_message'
      doc: 'The Modify Order Message is used to request modifications that will not affect order priority on the book. Since priority of the order does not change, allowed modifications are restricted. Increasing share amount is not allowed and requests to do so will be ignored.'
    0x51:
      id: 'account_query_message'
      doc: 'The Account Query Request message can be used when recovering state to request the next available UserRefNum that can be used for identifying new transactions.'
    0x43:
      id: 'mass_cancel_request_message'
      doc: 'The Mass Cancel Request message allows firms to initiate the cancellation of one or more orders that are currently booked at the exchange if they match the criteria specified in the request. If no optional criteria are specified then all orders for the specified firm on the account will be cancelled. Optional criteria can be specified in the Appendage field.'
    0x44:
      id: 'disable_order_entry_request_message'
      doc: 'The Disable Order Entry Request allows firms the ability to block submissions of new orders on a particular account.'
    0x45:
      id: 'enable_order_entry_request_message'
      doc: 'The Enable Order Entry Request allows firms the ability to unblock submission of new orders on a particular account.'
  side:
    0x42:
      id: 'buy'
      doc: 'buy'
    0x53:
      id: 'sell'
      doc: 'sell'
    0x54:
      id: 'sell_short'
      doc: 'sell short'
    0x45:
      id: 'sell_short_exempt'
      doc: 'sell short exempt'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day (Market Hours)'
    0x33:
      id: 'ioc'
      doc: 'IOC'
    0x35:
      id: 'gtx_extended_hours'
      doc: 'GTX (Extended Hours)'
    0x36:
      id: 'gtt'
      doc: 'GTT (ExpireTime needs to be specified)'
    0x45:
      id: 'after_hours'
      doc: 'After hours'
  display:
    0x41:
      id: 'attributable'
      doc: 'Attributable'
    0x59:
      id: 'visible'
      doc: 'Visible'
    0x4e:
      id: 'hidden'
      doc: 'Hidden'
    0x5a:
      id: 'conformant'
      doc: 'conformant'
  capacity:
    0x4f:
      id: 'other'
      doc: 'Other'
    0x41:
      id: 'agency'
      doc: 'agency'
    0x50:
      id: 'principal'
      doc: 'principal'
    0x52:
      id: 'riskless'
      doc: 'riskless'
  inter_market_sweep_eligibility:
    0x59:
      id: 'eligible'
      doc: 'eligible'
    0x4e:
      id: 'not_eligible'
      doc: 'not eligible'
  cross_type:
    0x4e:
      id: 'continuous_market'
      doc: 'continuous market'
    0x4f:
      id: 'opening_cross'
      doc: 'opening cross (Nasdaq only)'
    0x43:
      id: 'closing_cross'
      doc: 'closing cross (Nasdaq only)'
    0x48:
      id: 'halt_ipo'
      doc: 'halt/IPO (Nasdaq only)'
    0x53:
      id: 'supplemental'
      doc: 'supplemental (Nasdaq only)'
    0x52:
      id: 'retail'
      doc: 'retail (BX only)'
    0x45:
      id: 'extended_life'
      doc: 'extended life (Nasdaq only)'
    0x41:
      id: 'after_hours_close'
      doc: 'after hours close (Nasdaq only)'
  enter_order_optional_field:
    2:
      id: 'firm'
      doc: 'Enter Order Optional Firm Enum'
    3:
      id: 'minqty'
      doc: 'Enter Order Optional MinQty Enum'
    4:
      id: 'customertype'
      doc: 'Enter Order Optional CustomerType Enum'
    5:
      id: 'maxfloor'
      doc: 'Enter Order Optional MaxFloor Enum'
    6:
      id: 'pricetype'
      doc: 'Enter Order Optional PriceType Enum'
    7:
      id: 'pegoffset'
      doc: 'Enter Order Optional PegOffset Enum'
    9:
      id: 'discretionprice'
      doc: 'Enter Order Optional DiscretionPrice Enum'
    10:
      id: 'discretionpricetype'
      doc: 'Enter Order Optional DiscretionPriceType Enum'
    11:
      id: 'discretionpegoffset'
      doc: 'Enter Order Optional DiscretionPegOffset Enum'
    12:
      id: 'postonly'
      doc: 'Enter Order Optional PostOnly Enum'
    13:
      id: 'randomreserves'
      doc: 'Enter Order Optional RandomReserves Enum'
    15:
      id: 'expiretime'
      doc: 'Enter Order Optional ExpireTime Enum'
    16:
      id: 'tradenow'
      doc: 'Enter Order Optional TradeNow Enum'
    17:
      id: 'handleinst'
      doc: 'Enter Order Optional HandleInst Enum'
    24:
      id: 'group_id'
      doc: 'Enter Order Optional Group ID Enum'
    25:
      id: 'shares_located'
      doc: 'Enter Order Optional Shares Located Enum'
    26:
      id: 'locate_broker'
      doc: 'Enter Order Optional Locate Broker Enum'
    28:
      id: 'userrefidx'
      doc: 'Enter Order Optional UserRefIdx Enum'
    29:
      id: 'aiq_strategy'
      doc: 'Enter Order Optional AIQ Strategy Enum'
    30:
      id: 'aiq_group_id'
      doc: 'Enter Order Optional AIQ Group ID Enum'
  customer_type:
    0x52:
      id: 'retail_designated_order'
      doc: 'Retail Designated Order'
    0x4e:
      id: 'not_retail_designated'
      doc: 'Not Retail Designated (default)'
  price_type:
    0x4c:
      id: 'limit'
      doc: 'limit (default)'
    0x50:
      id: 'market_peg'
      doc: 'market peg'
    0x4d:
      id: 'midpoint_peg'
      doc: 'midpoint peg'
    0x52:
      id: 'primary_peg'
      doc: 'primary peg'
    0x51:
      id: 'market_maker_peg'
      doc: 'market maker peg'
    0x6d:
      id: 'midpoint'
      doc: 'midpoint'
  discretion_price_type:
    0x4c:
      id: 'limit'
      doc: 'limit (default)'
    0x50:
      id: 'market_peg'
      doc: 'market peg'
    0x4d:
      id: 'midpoint_peg'
      doc: 'midpoint peg'
    0x52:
      id: 'primary_peg'
      doc: 'primary peg'
  post_only:
    0x50:
      id: 'post_only'
      doc: 'Post Only (Mid-point Post Only not available on BX)'
    0x4e:
      id: 'no_field'
      doc: 'No (default)'
  trade_now:
    0x59:
      id: 'yes_field'
      doc: 'yes'
    0x4e:
      id: 'no_field'
      doc: 'no (default)'
  handle_inst:
    0x49:
      id: 'imbalance_only'
      doc: 'imbalance only (CrossType O and C)'
    0x4f:
      id: 'retail_order_type_1'
      doc: 'retail order type 1 (CrossType R)'
    0x54:
      id: 'retail_order_type_2'
      doc: 'retail order type 2 (CrossType R)'
    0x51:
      id: 'retail_price_improvement'
      doc: 'retail price improvement (CrossType R)'
    0x42:
      id: 'extended_life_continuous'
      doc: 'Extended Life + Continuous (CrossType E)'
    0x44:
      id: 'direct_listing_capital_raise'
      doc: 'Direct Listing Capital Raise (CrossType H)'
  shares_located:
    0x59:
      id: 'yes_field'
      doc: 'yes'
    0x4e:
      id: 'no_field'
      doc: 'no (default)'
  aiq_strategy:
    0x2a:
      id: 'use_port_default'
      doc: 'use port default'
    0x4e:
      id: 'disabled'
      doc: 'Disabled'
    0x59:
      id: 'firm_level_decrement_both_no_details'
      doc: 'Firm Level Decrement Both No Details'
    0x44:
      id: 'firm_level_decrement_both'
      doc: 'Firm Level Decrement Both'
    0x4f:
      id: 'firm_level_cancel_oldest'
      doc: 'Firm Level Cancel Oldest'
    0x57:
      id: 'firm_level_cancel_newest'
      doc: 'Firm Level Cancel Newest'
    0x52:
      id: 'firm_level_use_remover'
      doc: 'Firm Level Use Remover'
    0x79:
      id: 'organization_level_decrement_both_no_details'
      doc: 'Organization Level Decrement Both No Details'
    0x64:
      id: 'organization_level_decrement_both'
      doc: 'Organization Level Decrement Both'
    0x6f:
      id: 'organization_level_cancel_oldest'
      doc: 'Organization Level Cancel Oldest'
    0x77:
      id: 'organization_level_cancel_newest'
      doc: 'Organization Level Cancel Newest'
    0x72:
      id: 'organization_level_use_remover'
      doc: 'Organization Level Use Remover'
    0x5a:
      id: 'affiliate_level_decrement_both_no_details'
      doc: 'Affiliate Level Decrement Both No Details'
    0x45:
      id: 'affiliate_level_decrement_both'
      doc: 'Affiliate Level Decrement Both'
    0x50:
      id: 'affiliate_level_cancel_oldest'
      doc: 'Affiliate Level Cancel Oldest'
    0x58:
      id: 'affiliate_level_cancel_newest'
      doc: 'Affiliate Level Cancel Newest'
    0x53:
      id: 'affiliate_level_use_remover'
      doc: 'Affiliate Level Use Remover'
    0x30:
      id: 'match_any_level_decrement_both_no_details'
      doc: 'Match Any Level Decrement Both No Details'
    0x31:
      id: 'match_any_level_decrement_both'
      doc: 'Match Any Level Decrement Both'
    0x32:
      id: 'match_any_level_cancel_oldest'
      doc: 'Match Any Level Cancel Oldest'
    0x34:
      id: 'match_any_level_cancel_newest'
      doc: 'Match Any Level Cancel Newest'
    0x35:
      id: 'match_any_level_use_remover'
      doc: 'Match Any Level Use Remover'
  replace_order_optional_field:
    3:
      id: 'minqty'
      doc: 'Replace Order Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Replace Order Optional MaxFloor Enum'
    6:
      id: 'pricetype'
      doc: 'Replace Order Optional PriceType Enum'
    12:
      id: 'postonly'
      doc: 'Replace Order Optional PostOnly Enum'
    15:
      id: 'expiretime'
      doc: 'Replace Order Optional ExpireTime Enum'
    16:
      id: 'tradenow'
      doc: 'Replace Order Optional TradeNow Enum'
    17:
      id: 'handleinst'
      doc: 'Replace Order Optional HandleInst Enum'
    13:
      id: 'randomreserves'
      doc: 'Replace Order Optional RandomReserves Enum'
    7:
      id: 'pegoffset'
      doc: 'Replace Order Optional PegOffset Enum'
    9:
      id: 'discretionprice'
      doc: 'Replace Order Optional DiscretionPrice Enum'
    10:
      id: 'discretionpricetype'
      doc: 'Replace Order Optional DiscretionPriceType Enum'
    11:
      id: 'discretionpegoffset'
      doc: 'Replace Order Optional DiscretionPegOffset Enum'
    25:
      id: 'shares_located'
      doc: 'Replace Order Optional Shares Located Enum'
    26:
      id: 'locate_broker'
      doc: 'Replace Order Optional Locate Broker Enum'
    28:
      id: 'userrefidx'
      doc: 'Replace Order Optional UserRefIdx Enum'
    27:
      id: 'side'
      doc: 'Replace Order Optional Side Enum'
    29:
      id: 'aiq_strategy'
      doc: 'Replace Order Optional AIQ Strategy Enum'
    30:
      id: 'aiq_group_id'
      doc: 'Replace Order Optional AIQ Group ID Enum'
  cancel_order_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Cancel Order Optional UserRefIdx Enum'
  modify_order_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Modify Order Optional UserRefIdx Enum'
    25:
      id: 'shares_located'
      doc: 'Modify Order Optional Shares Located Enum'
    26:
      id: 'locate_broker'
      doc: 'Modify Order Optional Locate Broker Enum'
  account_query_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Account Query Optional UserRefIdx Enum'
  mass_cancel_request_optional_field:
    27:
      id: 'side'
      doc: 'Mass Cancel Request Optional Side Enum'
    24:
      id: 'group_id'
      doc: 'Mass Cancel Request Optional Group ID Enum'
    28:
      id: 'userrefidx'
      doc: 'Mass Cancel Request Optional UserRefIdx Enum'
  disable_order_entry_request_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Disable Order Entry Request Optional UserRefIdx Enum'
  enable_order_entry_request_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Enable Order Entry Request Optional UserRefIdx Enum'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire NASDAQ system.'
    0x41:
      id: 'order_accepted_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Enter Order Message. The data fields from the Enter Order Message are echoed back in this message. Note that the accepted values may differ from the entered values for some fields.'
    0x55:
      id: 'replaced_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Replace Order Message. The data fields from the Replace Order Message are echoed back in this message. Note that the accepted values may differ from the entered values for some fields. You will receive one and only one of these two for each replacement.'
    0x43:
      id: 'canceled_message'
      doc: 'A Canceled Message informs you that an order has been reduced or canceled. This could be acknowledging a Cancel Order Message, or it could be the result of the order timing out or being canceled automatically.'
    0x44:
      id: 'aiq_canceled_message'
      doc: 'AIQ Canceled Message'
    0x45:
      id: 'order_executed_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed.'
    0x42:
      id: 'broken_trade_message'
      doc: 'A Broken Trade Message informs you that an execution has been broken. The trade is no longer good and will not clear. The reason for the break is given.'
    0x4a:
      id: 'rejected_order_message'
      doc: 'A Rejected Message may be sent in response to an Enter Order Message or Replace Order Message if the order or replace cannot be accepted at this time. The reason for the rejection is given.'
    0x50:
      id: 'cancel_pending_message'
      doc: 'A Cancel Pending Message is sent in response to a cancel request for a cross order during a pre-cross late period signifying that it cannot be canceled at this time, but any unexecuted portion of this order will automatically be canceled immediately after the cross completes.'
    0x49:
      id: 'cancel_reject_message'
      doc: 'A Cancel Reject Message is sent in response to a partial cancel request (with non-zero “intended order size”) for a cross order during a pre-cross late period signifying that it cannot be partially canceled at this time. No automatic cancel will be scheduled for this order. Clients could repeat their request for any unexecuted portion of the order after the cross completes.'
    0x54:
      id: 'order_priority_update_message'
      doc: 'A Priority Update Message is sent whenever priority of the order has been changed by the system.'
    0x4d:
      id: 'order_modified_message'
      doc: 'An Order Modified Message is sent in response to an order modify request.'
    0x52:
      id: 'order_restated_message'
      doc: 'The Order Restated Message is sent to indicate that the system has modified an order as part of its order management.'
    0x51:
      id: 'account_query_response_message'
      doc: 'The Account Query Response message in sent in response to an Account Query Request to indicate the next available UserRefNum that can be used to identify new transactions.'
    0x58:
      id: 'mass_cancel_response_message'
      doc: 'This message acknowledges the receipt of a valid Mass Cancel Request message. The data fields from the Mass Cancel Request message are echoed back in this message.'
    0x47:
      id: 'disable_order_entry_response_message'
      doc: 'This message acknowledges the receipt of the Disable Order Entry Request message. The data fields from the Disable Order Entry Request message are echoed back in this message.'
    0x4b:
      id: 'enable_order_entry_response_message'
      doc: 'This message acknowledges the receipt of the Enable Order Entry Request message. The data fields from the Enable Order Entry Request message are echoed back in this message.'
  event_code:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day, indicating that exchange is open and is ready to accept orders.'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day, indicating that the exchange is closed and will no longer accept new orders. Note that it is still possible to receive breaks and cancels after this event.'
  order_state:
    0x4c:
      id: 'order_live'
      doc: 'Order Live'
    0x44:
      id: 'order_dead'
      doc: 'Order Dead'
  order_accepted_optional_field:
    2:
      id: 'firm'
      doc: 'Order Accepted Optional Firm Enum'
    3:
      id: 'minqty'
      doc: 'Order Accepted Optional MinQty Enum'
    4:
      id: 'customertype'
      doc: 'Order Accepted Optional CustomerType Enum'
    5:
      id: 'maxfloor'
      doc: 'Order Accepted Optional MaxFloor Enum'
    6:
      id: 'pricetype'
      doc: 'Order Accepted Optional PriceType Enum'
    7:
      id: 'pegoffset'
      doc: 'Order Accepted Optional PegOffset Enum'
    9:
      id: 'discretionprice'
      doc: 'Order Accepted Optional DiscretionPrice Enum'
    10:
      id: 'discretionpricetype'
      doc: 'Order Accepted Optional DiscretionPriceType Enum'
    11:
      id: 'discretionpegoffset'
      doc: 'Order Accepted Optional DiscretionPegOffset Enum'
    12:
      id: 'postonly'
      doc: 'Order Accepted Optional PostOnly Enum'
    13:
      id: 'randomreserves'
      doc: 'Order Accepted Optional RandomReserves Enum'
    14:
      id: 'route'
      doc: 'Order Accepted Optional Route Enum'
    15:
      id: 'expiretime'
      doc: 'Order Accepted Optional ExpireTime Enum'
    16:
      id: 'tradenow'
      doc: 'Order Accepted Optional TradeNow Enum'
    17:
      id: 'handleinst'
      doc: 'Order Accepted Optional HandleInst Enum'
    18:
      id: 'bbo_weight_indicator'
      doc: 'Order Accepted Optional BBO Weight Indicator Enum'
    24:
      id: 'group_id'
      doc: 'Order Accepted Optional Group ID Enum'
    25:
      id: 'shares_located'
      doc: 'Order Accepted Optional Shares Located Enum'
    28:
      id: 'userrefidx'
      doc: 'Order Accepted Optional UserRefIdx Enum'
    29:
      id: 'aiq_strategy'
      doc: 'Order Accepted Optional AIQ Strategy Enum'
    30:
      id: 'aiq_group_id'
      doc: 'Order Accepted Optional AIQ Group ID Enum'
  bbo_weight_indicator:
    0x30:
      id: 'weight_0_to_02_percent'
      doc: '0-0.2%'
    0x31:
      id: 'weight_02_to_1_percent'
      doc: '0.2%-1%'
    0x32:
      id: 'weight_1_to_2_percent'
      doc: '1%-2%'
    0x33:
      id: 'greater_than_2'
      doc: 'greater than 2%'
    0x20:
      id: 'unspecified'
      doc: 'unspecified (default)'
    0x53:
      id: 'sets_the_qbbo_while_joining_the_nbbo'
      doc: 'Sets the QBBO while joining the NBBO'
    0x4e:
      id: 'improves_the_nbbo_upon_entry'
      doc: 'Improves the NBBO upon entry'
  replaced_message_optional_field:
    2:
      id: 'firm'
      doc: 'Replaced Message Optional Firm Enum'
    3:
      id: 'minqty'
      doc: 'Replaced Message Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Replaced Message Optional MaxFloor Enum'
    6:
      id: 'pricetype'
      doc: 'Replaced Message Optional PriceType Enum'
    12:
      id: 'postonly'
      doc: 'Replaced Message Optional PostOnly Enum'
    15:
      id: 'expiretime'
      doc: 'Replaced Message Optional ExpireTime Enum'
    16:
      id: 'tradenow'
      doc: 'Replaced Message Optional TradeNow Enum'
    17:
      id: 'handleinst'
      doc: 'Replaced Message Optional HandleInst Enum'
    18:
      id: 'bbo_weight_indicator'
      doc: 'Replaced Message Optional BBO Weight Indicator Enum'
    28:
      id: 'userrefidx'
      doc: 'Replaced Message Optional UserRefIdx Enum'
    29:
      id: 'aiq_strategy'
      doc: 'Replaced Message Optional AIQ Strategy Enum'
    30:
      id: 'aiq_group_id'
      doc: 'Replaced Message Optional AIQ Group ID Enum'
  cancel_order_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'Sent in response to a Cancel Request Message.'
    0x49:
      id: 'immediate_or_cancel_order'
      doc: 'Immediate or Cancel Order.'
    0x54:
      id: 'timeout'
      doc: 'The Time In Force for this order has expired'
    0x53:
      id: 'supervisory'
      doc: 'The order was manually canceled or reduced by an NASDAQ supervisory terminal.'
    0x44:
      id: 'regulatory_restriction'
      doc: 'This order cannot be executed because of a regulatory restriction (e.g.: trade through restrictions).'
    0x51:
      id: 'self_match_prevention'
      doc: 'The order was cancelled because it would have executed with an existing order entered by the same MPID.'
    0x5a:
      id: 'system_cancel'
      doc: 'This order was cancelled by the system.'
    0x4b:
      id: 'this_order_cannot_be_executed'
      doc: 'This order cannot be executed because of Market Collars'
    0x48:
      id: 'halted'
      doc: 'The on-open order was canceled because the symbol remained halted after the opening cross completed.'
    0x58:
      id: 'open_protection'
      doc: 'Orders that are cancelled as a result of the Opening Price Protection Threshold.'
    0x45:
      id: 'closed'
      doc: 'Any DAY order that was received after the closing cross is complete in a given symbol will receive this cancel reason.'
    0x46:
      id: 'post_only_cancel'
      doc: 'This Post Only order was cancelled because it would have been price slid for NMS.'
    0x47:
      id: 'post_only_cancel_contra_side_displayed'
      doc: 'This Post Only order was cancelled because it would have been price slid due to a contra side displayed order on the book.'
    0x65:
      id: 'company_direct_listing_capital_raise_order_exceeds_allowable_shares_offered'
      doc: 'Company Direct Listing Capital Raise order exceeds allowable shares offered'
  canceled_message_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Canceled Message Optional UserRefIdx Enum'
  liquidity_flag:
    0x41:
      id: 'added'
      doc: 'Added'
    0x43:
      id: 'closing'
      doc: 'Closing Cross'
    0x65:
      id: 'retail_designated'
      doc: 'Retail designated execution that added displayed liquidity'
    0x48:
      id: 'halt_ipo'
      doc: 'Halt/IPO Cross'
    0x69:
      id: 'after_hours_closing'
      doc: 'After hours closing cross'
    0x4a:
      id: 'non_displayed_adding_liquidity'
      doc: 'Non-displayed adding liquidity'
    0x6a:
      id: 'rpi_order_provides_liquidity'
      doc: 'RPI (Retail Price Improving) order provides liquidity'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'Added liquidity via a midpoint order'
    0x4b:
      id: 'halt_cross'
      doc: 'Halt Cross'
    0x4c:
      id: 'closing_cross'
      doc: 'Closing Cross (imbalance-only)'
    0x4d:
      id: 'opening_cross'
      doc: 'Opening Cross (imbalance-only)'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'Removed liquidity at a midpoint'
    0x4e:
      id: 'passive_midpoint_execution'
      doc: 'Passive midpoint execution'
    0x6e:
      id: 'midpoint_extended_life_order_execution'
      doc: 'Midpoint Extended Life Order execution'
    0x4f:
      id: 'opening'
      doc: 'Opening Cross'
    0x70:
      id: 'removed_price_improving_non_displayed_liquidity'
      doc: 'Removed price improving non-displayed liquidity'
    0x71:
      id: 'rmo_retail_order_removes_non_rpi_midpoint_liquidity'
      doc: 'RMO Retail Order removes non-RPI midpoint liquidity'
    0x52:
      id: 'removed'
      doc: 'Removed'
    0x72:
      id: 'retail_order_removes_rpi_liquidity'
      doc: 'Retail Order removes RPI liquidity'
    0x74:
      id: 'retail_order_removes_price_improving_non_displayed_liquidity_other_than_rpi_liquidity'
      doc: 'Retail Order removes price improving non-displayed liquidity other than RPI liquidity'
    0x75:
      id: 'added_non_displayed_liquidity_via_a_reserve_order'
      doc: 'Added non-displayed liquidity via a Reserve order'
    0x30:
      id: 'supplemental'
      doc: 'Supplemental order execution'
    0x37:
      id: 'displayed_liquidity_adding_order_improves_the_nbbo'
      doc: 'Displayed, liquidity-adding order improves the NBBO'
    0x38:
      id: 'displayed_liquidity_adding_order_sets_the_qbbo_while_joining_the_nbbo'
      doc: 'Displayed, liquidity-adding order sets the QBBO while joining the NBBO'
    0x31:
      id: 'rpi_order_provides_liquidity_no_rpii'
      doc: 'RPI order provides liquidity, No RPII'
    0x32:
      id: 'added_in_the_pre_market'
      doc: 'Added in the pre-market'
    0x33:
      id: 'removed_in_the_pre_market'
      doc: 'Removed in the pre-market'
    0x35:
      id: 'displayed_liquidity_adding_order_improves_the_nbbo_in_the_pre_market'
      doc: 'Displayed, liquidity-adding order improves the NBBO in the pre-market'
    0x39:
      id: 'non_displayed_adding_liquidity_in_the_pre_market'
      doc: 'Non-displayed adding liquidity in the pre-market'
  aiq_canceled_optional_field:
    28:
      id: 'userrefidx'
      doc: 'AIQ Canceled Optional UserRefIdx Enum'
  order_executed_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Order Executed Optional UserRefIdx Enum'
  broken_trade_reason:
    0x45:
      id: 'erroneous'
      doc: 'Erroneous (trade deemed clearly erroneous)'
    0x43:
      id: 'consent'
      doc: 'Consent (both parties agreed to break the trade)'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory (manually broken by supervisory)'
    0x58:
      id: 'external'
      doc: 'External (trade broken by an external third party)'
  broken_trade_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Broken Trade Optional UserRefIdx Enum'
  rejected_order_reason:
    0x0001:
      id: 'quote_unavailable'
      doc: 'Quote Unavailable'
    0x0002:
      id: 'destination_closed'
      doc: 'Destination Closed'
    0x0003:
      id: 'invalid_display'
      doc: 'Invalid Display'
    0x0004:
      id: 'invalid_max_floor'
      doc: 'Invalid Max Floor'
    0x0005:
      id: 'invalid_peg_type'
      doc: 'Invalid Peg Type'
    0x0006:
      id: 'fat_finger'
      doc: 'Fat Finger'
    0x0007:
      id: 'halted'
      doc: 'Halted'
    0x0008:
      id: 'iso_not_allowed'
      doc: 'ISO Not Allowed'
    0x0009:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x000a:
      id: 'processing_error'
      doc: 'Processing Error'
    0x000b:
      id: 'cancel_pending'
      doc: 'Cancel Pending'
    0x000c:
      id: 'firm_not_authorized'
      doc: 'Firm Not Authorized'
    0x000d:
      id: 'invalid_min_quantity'
      doc: 'Invalid Min Quantity'
    0x000e:
      id: 'no_closing_reference_price'
      doc: 'No Closing Reference Price'
    0x000f:
      id: 'other'
      doc: 'Other'
    0x0010:
      id: 'cancel_not_allowed'
      doc: 'Cancel Not Allowed'
    0x0011:
      id: 'pegging_not_allowed'
      doc: 'Pegging Not Allowed'
    0x0012:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x0013:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    0x0014:
      id: 'invalid_cross_order'
      doc: 'Invalid Cross Order'
    0x0015:
      id: 'replace_not_allowed'
      doc: 'Replace Not Allowed'
    0x0016:
      id: 'routing_not_allowed'
      doc: 'Routing Not Allowed'
    0x0017:
      id: 'invalid_symbol'
      doc: 'Invalid Symbol'
    0x0018:
      id: 'test'
      doc: 'Test'
    0x0019:
      id: 'late_loc_too_aggressive'
      doc: 'Late LOC Too Aggressive'
    0x001a:
      id: 'retail_not_allowed'
      doc: 'Retail Not Allowed'
    0x001b:
      id: 'invalid_midpoint_post_only_price'
      doc: 'Invalid Midpoint Post Only Price'
    0x001c:
      id: 'invalid_destination'
      doc: 'Invalid Destination'
    0x001d:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x001e:
      id: 'shares_exceed_threshold'
      doc: 'Shares Exceed Threshold'
    0x001f:
      id: 'exceeds_maximum_allowed_notional_value'
      doc: 'Exceeds Maximum Allowed Notional Value'
    0x0020:
      id: 'risk_aggregate_exposure_exceeded'
      doc: 'Risk: Aggregate Exposure Exceeded'
    0x0021:
      id: 'risk_market_impact'
      doc: 'Risk: Market Impact'
    0x0022:
      id: 'risk_restricted_stock'
      doc: 'Risk: Restricted Stock'
    0x0023:
      id: 'risk_short_sell_restricted'
      doc: 'Risk: Short Sell Restricted'
    0x0024:
      id: 'risk_iso_not_allowed'
      doc: 'Risk: ISO Not Allowed.'
    0x0025:
      id: 'risk_exceeds_adv_limit'
      doc: 'Risk: Exceeds ADV Limit'
    0x0026:
      id: 'risk_fat_finger'
      doc: 'Risk: Fat Finger'
    0x0027:
      id: 'risk_locate_required'
      doc: 'Risk: Locate Required'
    0x0028:
      id: 'risk_symbol_message_rate_restriction'
      doc: 'Risk: Symbol Message Rate Restriction'
    0x0029:
      id: 'risk_port_message_rate_restriction'
      doc: 'Risk: Port Message Rate Restriction'
    0x002a:
      id: 'risk_duplicate_message_rate_restriction'
      doc: 'Risk: Duplicate Message Rate Restriction'
    0x002b:
      id: 'risk_short_sell_not_allowed'
      doc: 'Risk: Short Sell Not Allowed'
    0x002c:
      id: 'risk_market_order_not_allowed'
      doc: 'Risk: Market Order Not Allowed'
    0x002d:
      id: 'risk_pre_market_not_allowed'
      doc: 'Risk: Pre-Market Not Allowed'
    0x002e:
      id: 'risk_post_market_not_allowed'
      doc: 'Risk: Post-Market Not Allowed'
    0x002f:
      id: 'risk_short_sell_exempt_not_allowed'
      doc: 'Risk: Short Sell Exempt Not Allowed'
    0x0030:
      id: 'risk_single_order_notional_exceeded'
      doc: 'Risk: Single Order Notional Exceeded'
    0x0031:
      id: 'risk_max_quantity_exceeded'
      doc: 'Risk: Max Quantity Exceeded'
    0x0032:
      id: 'reg_sho_state_not_available'
      doc: 'Reg SHO State Not Available'
    0x0033:
      id: 'risk_ipo_market_buy_not_allowed'
      doc: 'Risk: IPO Market Buy Not Allowed'
    0x0040:
      id: 'invalid_aiq'
      doc: 'Invalid AIQ'
  rejected_order_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Rejected Order Optional UserRefIdx Enum'
  cancel_pending_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Cancel Pending Optional UserRefIdx Enum'
  cancel_reject_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Cancel Reject Optional UserRefIdx Enum'
  order_priority_update_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Order Priority Update Optional UserRefIdx Enum'
  order_modified_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Order Modified Optional UserRefIdx Enum'
    25:
      id: 'shares_located'
      doc: 'Order Modified Optional Shares Located Enum'
    26:
      id: 'locate_broker'
      doc: 'Order Modified Optional Locate Broker Enum'
  order_restated_reason:
    0x52:
      id: 'refresh_of_display'
      doc: 'Refresh of display (on an order with reserves)'
    0x50:
      id: 'update_of_displayed_price'
      doc: 'Update of displayed price'
  order_restated_optional_field:
    22:
      id: 'display_quantity'
      doc: 'Order Restated Optional Display Quantity Enum'
    23:
      id: 'display_price'
      doc: 'Order Restated Optional Display Price Enum'
    1:
      id: 'secondaryordrefnum'
      doc: 'Order Restated Optional SecondaryOrdRefNum Enum'
    28:
      id: 'userrefidx'
      doc: 'Order Restated Optional UserRefIdx Enum'
  account_query_response_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Account Query Response Optional UserRefIdx Enum'
  mass_cancel_response_optional_field:
    27:
      id: 'side'
      doc: 'Mass Cancel Response Optional Side Enum'
    24:
      id: 'group_id'
      doc: 'Mass Cancel Response Optional Group ID Enum'
    28:
      id: 'userrefidx'
      doc: 'Mass Cancel Response Optional UserRefIdx Enum'
  disable_order_entry_response_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Disable Order Entry Response Optional UserRefIdx Enum'
  enable_order_entry_response_optional_field:
    28:
      id: 'userrefidx'
      doc: 'Enable Order Entry Response Optional UserRefIdx Enum'

