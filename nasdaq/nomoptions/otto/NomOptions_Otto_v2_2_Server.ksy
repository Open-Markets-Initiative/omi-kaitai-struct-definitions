# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NomOptions Otto Ouch v2.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Ouch to Trade Options
#   Encoding: Ouch
#   Version: 2.2
#   Date: 04/07/2020
#   Specification: OTTO-v2.2.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: nasdaq_nomoptions_otto_ouch_v2_2_server
  title: Nasdaq NomOptions Otto Ouch v2.2
  license: MIT-0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Options Market Ouch to Trade Options Ouch v2.2'
doc-ref: https://www.nasdaq.com/solutions/trading-services-documentation

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
            'sequenced_message_type::simple_instrument_directory_message': simple_instrument_directory_message
            'sequenced_message_type::complex_instrument_directory_message': complex_instrument_directory_message
            'sequenced_message_type::instrument_trading_action_message': instrument_trading_action_message
            'sequenced_message_type::auction_notification_message': auction_notification_message
            'sequenced_message_type::order_accepted_long_form_message': order_accepted_long_form_message
            'sequenced_message_type::order_accepted_short_form_message': order_accepted_short_form_message
            'sequenced_message_type::order_replaced_message': order_replaced_message
            'sequenced_message_type::order_cancelled_message': order_cancelled_message
            'sequenced_message_type::order_executed_message': order_executed_message
            'sequenced_message_type::trade_details_message': trade_details_message
            'sequenced_message_type::cross_order_accepted_message': cross_order_accepted_message
            'sequenced_message_type::member_kill_switch_notification_message': member_kill_switch_notification_message
            'sequenced_message_type::mass_cancel_response_message': mass_cancel_response_message
            'sequenced_message_type::add_complex_instrument_response_message': add_complex_instrument_response_message
            'sequenced_message_type::modify_trade_response_message': modify_trade_response_message
            'sequenced_message_type::subscription_response_message': subscription_response_message
            'sequenced_message_type::reject_message': reject_message
            'sequenced_message_type::pending_response_message': pending_response_message
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Codes'
  simple_instrument_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u2
        doc: 'notifications. Must be populated if Scope=P and UnderlyingSymbol not populated'
      - id: product_name
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product (Underlying) name; must be provided if ProductID =0'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: expir_year
        type: u1
        doc: 'Expiration Year (less 2000)'
      - id: expir_mon
        type: u1
        doc: 'Expiration Month (1-12)'
      - id: expir_day
        type: u1
        doc: 'Expiration Day (1-31)'
      - id: strike_price
        type: decimal_s8_6
        doc: 'Strike Price. Implied decimal with scale 1e-6'
      - id: option_type
        type: u1
        enum: option_type
      - id: closing_type
        type: u1
        enum: closing_type
      - id: tradable
        type: u1
        enum: tradable
      - id: closing_only
        type: u1
        enum: closing_only
      - id: contract_size
        type: u2
        doc: 'Underlying Deliverable size'
      - id: mpv
        type: u1
        enum: mpv
      - id: system_partition
        type: u1
        doc: 'For future use'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Industry assigned security symbol for the option contract'
  complex_instrument_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u2
        doc: 'notifications. Must be populated if Scope=P and UnderlyingSymbol not populated'
      - id: product_name
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product (Underlying) name; must be provided if ProductID =0'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: num_complex_directory_legs
        type: u1
        doc: 'Number or legs (2-10)'
      - id: complex_directory_legs
        type: complex_directory_legs
        repeat: expr
        repeat-expr: num_complex_directory_legs
        doc: 'Leg Definitions (2-10)'
  complex_directory_legs:
    seq:
      - id: leg_type
        type: u1
        enum: leg_type
      - id: leg_instrument_id
        type: u4
        doc: 'Leg Instrument ID. Only populated for OrdExecType=C. Zero otherwise. 0-based LegId within complex instrument identified by'
      - id: leg_side
        type: u1
        enum: leg_side
      - id: leg_ratio
        type: u2
        doc: '1 <= n <= 9,999'
      - id: leg_id
        type: u1
        doc: 'the InstrumentId field. Only meaningful for OrdExecType C or D'
  instrument_trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: product_id
        type: u2
        doc: 'notifications. Must be populated if Scope=P and UnderlyingSymbol not populated'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'assumed to be Trading unless notified as Halted by this message'
  auction_notification_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Scope of the deletion request: FirmID/ProductID/InstrumentType (requires ProductID). InstrumentID must be set to 0'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: auction_id
        type: u4
        doc: 'Identifies the Auction being responded. 0 if this order is not an auction response'
      - id: order_type
        type: u1
        enum: order_type
      - id: side
        type: u1
        enum: side
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: exec_flag
        type: u1
        enum: exec_flag
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'See Order Capacity Field'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: occ_account
        type: u4
        doc: 'OCC # to use for clearing (give up)'
      - id: cmta
        type: u4
        doc: 'CMTA'
      - id: auction_event
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'U-Auction Update'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: best_response_price
        type: decimal_s8_6
        doc: 'BestResponsePrice of 0 is valid for Exposure auctions if. Implied decimal with scale 1e-6'
      - id: best_response_size
        type: u4
        doc: 'Aggregated quantity at Best response price; 0 if not'
  order_accepted_long_form_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: cmta
        type: u4
        doc: 'CMTA'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sub-account/MM Identifier at the registered exchange'
      - id: occ_account
        type: u4
        doc: 'OCC # to use for clearing (give up)'
      - id: cust_acct
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account on the customer system (pass-through)'
      - id: preferred_party
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'IFI of the preferred Market Maker. Blank if none'
      - id: alo_inst
        type: u1
        enum: alo_inst
      - id: iso
        type: u1
        enum: iso
      - id: side
        type: u1
        enum: side
      - id: order_type
        type: u1
        enum: order_type
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: min_qty
        type: u4
        doc: '0 or Quantity'
      - id: tif
        type: u1
        enum: tif
        doc: 'See Time in Force Field (TIF)'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'See Order Capacity Field'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: auction_id
        type: u4
        doc: 'Identifies the Auction being responded. 0 if this order is not an auction response'
      - id: flash_inst
        type: u1
        enum: flash_inst
        doc: 'Only non-customer orders can opt out of Flash Auction This instruction is ignored for complex orders'
      - id: disclosure_mask
        type: u1
        doc: 'See Disclosure Mask Field'
      - id: display_qty
        type: u2
        doc: 'Initial Display Quantity'
      - id: display_when
        type: u1
        enum: display_when
      - id: display_method
        type: u1
        enum: display_method
      - id: display_low_qty
        type: u2
        doc: 'If DisplayMethod = Random'
      - id: display_high_qty
        type: u2
        doc: 'If DisplayMethod = Random'
      - id: position_effect_mask
        type: u2
        doc: 'See Position Effect Mask Field'
      - id: stock_leg_short_sale
        type: u1
        enum: stock_leg_short_sale
        doc: 'If this is a multi-leg order for a stock combo where stock leg is on the Sell side StockLegShortSale may be set to H or E. In all other cases value N should be used'
      - id: stock_leg_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give-up for the stock leg'
      - id: persist_inst
        type: u1
        enum: persist_inst
  order_accepted_short_form_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: alo_inst
        type: u1
        enum: alo_inst
      - id: iso
        type: u1
        enum: iso
      - id: side
        type: u1
        enum: side
      - id: order_type
        type: u1
        enum: order_type
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
      - id: quantity_short
        type: u2
        doc: 'Number of contracts'
      - id: tif
        type: u1
        enum: tif
        doc: 'See Time in Force Field (TIF)'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'See Order Capacity Field'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: auction_id
        type: u4
        doc: 'Identifies the Auction being responded. 0 if this order is not an auction response'
      - id: price_protection
        type: u1
        enum: price_protection
      - id: position_effect_mask
        type: u2
        doc: 'See Position Effect Mask Field'
  order_replaced_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: orig_order_id
        type: u8
        doc: 'Exchange ID of the replaced order'
      - id: order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: orig_cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'no open order with such identifier is found, request is rejected'
      - id: alo_inst
        type: u1
        enum: alo_inst
      - id: iso
        type: u1
        enum: iso
      - id: side
        type: u1
        enum: side
      - id: order_type
        type: u1
        enum: order_type
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: tif
        type: u1
        enum: tif
        doc: 'See Time in Force Field (TIF)'
      - id: cust_acct
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account on the customer system (pass-through)'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'See Order Capacity Field'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: auction_id
        type: u4
        doc: 'Identifies the Auction being responded. 0 if this order is not an auction response'
      - id: position_effect_mask
        type: u2
        doc: 'See Position Effect Mask Field'
      - id: price_protection
        type: u1
        enum: price_protection
  order_cancelled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'See Cancel Reason'
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: product_id
        type: u2
        doc: 'notifications. Must be populated if Scope=P and UnderlyingSymbol not populated'
      - id: ord_exec_type
        type: u1
        enum: ord_exec_type
        doc: 'Instrument ID, as specified by Instrument Directory'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: leg_instrument_id
        type: u4
        doc: 'Leg Instrument ID. Only populated for OrdExecType=C. Zero otherwise. 0-based LegId within complex instrument identified by'
      - id: leg_id
        type: u1
        doc: 'the InstrumentId field. Only meaningful for OrdExecType C or D'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: cross_id
        type: u4
        doc: 'CrossId of the trade being modified'
      - id: match_id
        type: u4
        doc: 'MatchId of the trade to be modified'
      - id: side
        type: u1
        enum: side
      - id: stock_leg_short_sale
        type: u1
        enum: stock_leg_short_sale
        doc: 'If this is a multi-leg order for a stock combo where stock leg is on the Sell side StockLegShortSale may be set to H or E. In all other cases value N should be used'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: liquidity_ind
        type: u1
        enum: liquidity_ind
        doc: 'See Liquidity (Maker/Taker) Field Codes'
  trade_details_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: product_id
        type: u2
        doc: 'notifications. Must be populated if Scope=P and UnderlyingSymbol not populated'
      - id: ord_exec_type
        type: u1
        enum: ord_exec_type
        doc: 'Instrument ID, as specified by Instrument Directory'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: leg_instrument_id
        type: u4
        doc: 'Leg Instrument ID. Only populated for OrdExecType=C. Zero otherwise. 0-based LegId within complex instrument identified by'
      - id: leg_id
        type: u1
        doc: 'the InstrumentId field. Only meaningful for OrdExecType C or D'
      - id: trans_type
        type: u1
        enum: trans_type
      - id: event_source
        type: u1
        enum: event_source
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: cross_id
        type: u4
        doc: 'CrossId of the trade being modified'
      - id: match_id
        type: u4
        doc: 'MatchId of the trade to be modified'
      - id: ref_match_id
        type: u4
        doc: 'For TransType=C indicates MatchId of the original trade. 0(zero) for TransType=A,B'
      - id: side
        type: u1
        enum: side
      - id: stock_leg_short_sale
        type: u1
        enum: stock_leg_short_sale
        doc: 'If this is a multi-leg order for a stock combo where stock leg is on the Sell side StockLegShortSale may be set to H or E. In all other cases value N should be used'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: liquidity_ind
        type: u1
        enum: liquidity_ind
        doc: 'See Liquidity (Maker/Taker) Field Codes'
      - id: cmta
        type: u4
        doc: 'CMTA'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sub-account/MM Identifier at the registered exchange'
      - id: occ_account
        type: u4
        doc: 'OCC # to use for clearing (give up)'
      - id: cust_acct
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account on the customer system (pass-through)'
      - id: stock_venue
        type: u1
        enum: stock_venue
        doc: 'See Stock Execution Venues'
      - id: stock_leg_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give-up for the stock leg'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'See Order Capacity Field'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Closed = "C" Carry Forward = Blank Space'
  cross_order_accepted_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'See Auction Type Field'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: auction_id
        type: u4
        doc: 'Identifies the Auction being responded. 0 if this order is not an auction response'
      - id: auction_alloc_pct
        type: u1
        doc: 'Order Allocation percentage 0 <= n <= 40. 0 for Simple and Complex Solicitation. Side of the primary part of the Cross Order. Contra part is implied to be on the opposite side'
      - id: side
        type: u1
        enum: side
      - id: iso
        type: u1
        enum: iso
      - id: price_protection
        type: u1
        enum: price_protection
      - id: effective_time
        type: u8
        doc: 'Agreed upon time for the stopped price. UTC time in milliseconds'
      - id: disclosure_mask
        type: u1
        doc: 'See Disclosure Mask Field'
      - id: primary_order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: primary_cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: primary_cmta
        type: u4
        doc: 'CMTA'
      - id: primary_clearing_account
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sub-account/MM Identifier at the registered exchange'
      - id: primary_occ_account
        type: u4
        doc: 'OCC # to use for clearing (give up)'
      - id: primary_cust_acct
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account on the customer system (pass-through)'
      - id: primary_price
        type: decimal_s8_6
        doc: 'Limit price. Primary Side of a Cross order cannot be Market. Implied decimal with scale 1e-6'
      - id: primary_quantity
        type: u4
        doc: 'Number of contracts'
      - id: primary_capacity
        type: u1
        enum: primary_capacity
        doc: 'See Order Capacity Field'
      - id: primary_position_effect_mask
        type: u2
        doc: 'See Position Effect Mask Field'
      - id: primary_stock_leg_short_sale
        type: u1
        enum: primary_stock_leg_short_sale
        doc: 'If this is a multi-leg order for a stock combo where stock leg is to sell StockLegShortSale may be set to H or E. In all other cases value N should be used'
      - id: primary_stock_leg_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give-up for the stock leg'
      - id: contra_order_id
        type: u8
        doc: 'Day-unique Order identifier assigned by exchange'
      - id: contra_cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: contra_cmta
        type: u4
        doc: 'CMTA'
      - id: contra_clearing_account
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sub-account/MM Identifier at the registered exchange'
      - id: contra_occ_account
        type: u4
        doc: 'OCC # to use for clearing (give up)'
      - id: contra_cust_acct
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account on the customer system (pass-through)'
      - id: contra_order_type
        type: u1
        enum: contra_order_type
      - id: contra_price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
      - id: contra_quantity
        type: u4
        doc: 'Number of contracts'
      - id: contra_capacity
        type: u1
        enum: contra_capacity
        doc: 'See Order Capacity Field'
      - id: contra_position_effect_mask
        type: u2
        doc: 'See Position Effect Mask Field'
      - id: contra_stock_leg_short_sale
        type: u1
        enum: contra_stock_leg_short_sale
      - id: contra_stock_leg_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give-up for the stock leg'
  member_kill_switch_notification_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: cl_request_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client''s identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
      - id: target_firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID being targeted by the Kill Switch Request'
      - id: kill_action
        type: u1
        enum: kill_action
  mass_cancel_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: cl_request_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client''s identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
      - id: num_cancelled
        type: u4
        doc: 'Number of order cancelled'
      - id: num_pending
        type: u4
        doc: 'Number of order where cancelation is pending due to paused instrument state'
  add_complex_instrument_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: cl_request_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client''s identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
  modify_trade_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: cl_request_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client''s identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: cross_id
        type: u4
        doc: 'CrossId of the trade being modified'
      - id: match_id
        type: u4
        doc: 'MatchId of the trade to be modified'
  subscription_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: cl_request_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client''s identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
  reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: reject_msg_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the message being rejected'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: reject_code
        type: u2
        enum: reject_code
        doc: 'Reason for the reject'
  pending_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: pending_msg_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the message placed in pending state'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: pending_reason
        type: u1
        enum: pending_reason
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
    0x41:
      id: 'new_order_long_form_message'
      doc: 'Long form of the New Order request provides full flexibility of configuring order attributes:'
    0x42:
      id: 'new_order_short_form_message'
      doc: 'Short format of the New Order request is a compact message (less than 50 bytes) with limited flexibility:'
    0x52:
      id: 'replace_order_message'
      doc: 'Replace Order message is used to modify an existing order for both simple and complex instruments.'
    0x43:
      id: 'cancel_order_message'
      doc: 'The order to be deleted is identified by the ClOrdId field. If the order cannot be deleted, or cannot be found, the request is rejected.'
    0x55:
      id: 'mass_cancel_message'
      doc: 'This message is used to mass-delete multiple open orders based on the specified Scope. - If message contains invalid fields request is rejected.'
    0x58:
      id: 'new_cross_order_message'
      doc: 'Cross Order message allows specifying two opposite sides to trade against each other. The primary side of the order is exposed in an auction if CrossType is set to A (Auction).'
    0x53:
      id: 'add_complex_instrument_message'
      doc: 'This is a variable length message where length is controlled by the number of legs in the instrument.'
    0x4d:
      id: 'modify_trade_message'
      doc: 'The Modify Trade request is used to change clearing information on an existing trade as well as split a trade into multiple components with different clearing assignments.'
    0x4b:
      id: 'member_kill_switch_request_message'
      doc: 'The Member Kill Switch Request is used to block ability to enter new orders, alter existing orders, delete orders, and create complex instruments on NOM, ISE, GEMX and MRX.'
    0x46:
      id: 'subscription_request_message'
      doc: 'OTTO protocol specifies a number of notification message types that can be sent to the client optionally.'
  alo_inst:
    0x4e:
      id: 'not_alo'
      doc: 'Not ALO'
    0x52:
      id: 're_price'
      doc: 'Re-price'
    0x43:
      id: 'cancel'
      doc: 'Cancel'
  iso:
    0x4e:
      id: 'not_iso'
      doc: 'Not ISO'
    0x49:
      id: 'iso'
      doc: 'ISO'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy; Bid in the Auction Notification, Bought in the execution messages'
    0x53:
      id: 'sell'
      doc: 'Sell; Sold in the execution messages'
    0x4f:
      id: 'offer'
      doc: 'Offer, in the Auction Notification'
    0x4e:
      id: 'not_disclosed'
      doc: 'Not Disclosed in the Auction Notification, Not Applicable in the execution messages'
  order_type:
    0x4c:
      id: 'limit'
      doc: 'Limit'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4e:
      id: 'not_disclosed'
      doc: 'Not Disclosed, in the Auction Notification'
  tif:
    0x44:
      id: 'day'
      doc: 'Day'
    0x46:
      id: 'fok'
      doc: 'Fill or Kill'
    0x49:
      id: 'ioc'
      doc: 'Immediate or Cancel'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other-Exchange Registered Market Maker (FARMM/AWAYMM)'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker/Dealer- Customer'
    0x4b:
      id: 'broker_dealer_firm'
      doc: 'Broker Dealer - Firm'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint BackOffice (JBO). A placeholder for future functionality on BX, ISE, GEMX and MRX; supported on NOM.'
    0x52:
      id: 'retail'
      doc: 'Retail. A placeholder for future functionality on NOM, ISE, GEMX and MRX.'
    0x45:
      id: 'proprietary_customer'
      doc: 'Proprietary Customer. Available on ISE, GEMX and MRX only; attempts to submit on BX or NOM are rejected.'
    0x20:
      id: 'na'
      doc: 'N/A'
  auction_type:
    0x42:
      id: 'block_order_auction'
      doc: 'Block Order Auction, initiated and responded to with a New Order'
    0x45:
      id: 'exposure_auction'
      doc: 'Exposure Auction, initiated and responded to with a New Order'
    0x46:
      id: 'flash_auction'
      doc: 'Flash Auction, responded to with a New Order'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction, responded to with a New Order'
    0x50:
      id: 'pim_auction'
      doc: 'PIM Auction and PRISM Auction, initiated with a New Cross Order and responded to with a New Order'
    0x48:
      id: 'facilitation_auction'
      doc: 'Facilitation Auction, initiated with a New Cross Order and responded to with a New Order'
    0x53:
      id: 'solicitation_auction'
      doc: 'Solicitation Auction, initiated with a New Cross Order and responded to with a New Order'
    0x4e:
      id: 'none'
      doc: 'Order is neither an initiation nor a response to an Auction'
  flash_inst:
    0x20:
      id: 'default_field'
      doc: 'Default'
    0x44:
      id: 'do_not_start_flash_auction'
      doc: 'Do not start Flash Auction (DNF)'
  price_protection:
    0x4c:
      id: 'local_market'
      doc: 'Local Market'
    0x4e:
      id: 'national_market'
      doc: 'National Market'
  display_when:
    0x49:
      id: 'immediate'
      doc: 'Immediate'
    0x45:
      id: 'exhaust'
      doc: 'Exhaust'
    0x4e:
      id: 'na'
      doc: 'N/A'
  display_method:
    0x49:
      id: 'initial'
      doc: 'Initial'
    0x52:
      id: 'random'
      doc: 'Random'
    0x4e:
      id: 'none'
      doc: 'None'
  stock_leg_short_sale:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x48:
      id: 'sell_short'
      doc: 'Sell Short; Sold Short in the execution messages'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt; Sold Short Exempt in the execution messages'
  persist_inst:
    0x4e:
      id: 'do_not_persist'
      doc: 'Do not persist'
    0x50:
      id: 'persist'
      doc: 'Persist'
  instrument_type:
    0x41:
      id: 'all'
      doc: 'All'
    0x4f:
      id: 'simple_instrument'
      doc: 'Simple Instrument'
    0x43:
      id: 'standard_combination'
      doc: 'Standard Combination'
    0x53:
      id: 'stock_combination'
      doc: 'Stock Combination'
  scope:
    0x50:
      id: 'product'
      doc: 'Cancel all open orders for the specified Product'
    0x49:
      id: 'instrument'
      doc: 'Cancel all the open orders for the specified Instrument'
    0x46:
      id: 'firm'
      doc: 'Cancel all open orders for the specified Firm'
  cross_type:
    0x41:
      id: 'auction'
      doc: 'Auction'
    0x51:
      id: 'qcc'
      doc: 'QCC'
    0x43:
      id: 'ccc'
      doc: 'CCC'
  primary_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other-Exchange Registered Market Maker (FARMM/AWAYMM)'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker/Dealer- Customer'
    0x4b:
      id: 'broker_dealer_firm'
      doc: 'Broker Dealer - Firm'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint BackOffice (JBO). A placeholder for future functionality on BX, ISE, GEMX and MRX; supported on NOM.'
    0x52:
      id: 'retail'
      doc: 'Retail. A placeholder for future functionality on NOM, ISE, GEMX and MRX.'
    0x45:
      id: 'proprietary_customer'
      doc: 'Proprietary Customer. Available on ISE, GEMX and MRX only; attempts to submit on BX or NOM are rejected.'
    0x20:
      id: 'na'
      doc: 'N/A'
  primary_stock_leg_short_sale:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x48:
      id: 'sell_short'
      doc: 'Sell Short; Sold Short in the execution messages'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt; Sold Short Exempt in the execution messages'
  contra_order_type:
    0x4c:
      id: 'limit'
      doc: 'Limit'
    0x4d:
      id: 'market'
      doc: 'Market'
  contra_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other-Exchange Registered Market Maker (FARMM/AWAYMM)'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker/Dealer- Customer'
    0x4b:
      id: 'broker_dealer_firm'
      doc: 'Broker Dealer - Firm'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint BackOffice (JBO). A placeholder for future functionality on BX, ISE, GEMX and MRX; supported on NOM.'
    0x52:
      id: 'retail'
      doc: 'Retail. A placeholder for future functionality on NOM, ISE, GEMX and MRX.'
    0x45:
      id: 'proprietary_customer'
      doc: 'Proprietary Customer. Available on ISE, GEMX and MRX only; attempts to submit on BX or NOM are rejected.'
    0x20:
      id: 'na'
      doc: 'N/A'
  contra_stock_leg_short_sale:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x48:
      id: 'sell_short'
      doc: 'Sell Short; Sold Short in the execution messages'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt; Sold Short Exempt in the execution messages'
  leg_type:
    0x4f:
      id: 'option'
      doc: 'Option'
    0x53:
      id: 'stock'
      doc: 'Stock'
  leg_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  kill_action:
    0x41:
      id: 'block_entry_of_new_requests_and_delete_all_open_orders'
      doc: 'Block Entry of new requests and delete all open orders'
    0x52:
      id: 'kill_switch_block_removed_by_exchange'
      doc: 'Kill-switch block removed (by Exchange)'
    0x42:
      id: 'block_entry_of_new_requests'
      doc: 'Block entry of new requests'
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
    0x7a:
      id: 'system_event_message'
      doc: 'System Event message informs of a market or a session-level event.'
    0x6f:
      id: 'simple_instrument_directory_message'
      doc: 'At the start of each trading day and during intra-day market state changes, the system disseminates directory messages for all symbols trading on the system.'
    0x73:
      id: 'complex_instrument_directory_message'
      doc: 'This message is sent whenever new complex strategy is created on the system. - InstrumentId of a complex strategy is unique for the trading day across both simple and complex instruments.'
    0x69:
      id: 'instrument_trading_action_message'
      doc: 'This message notifies of changes to the trading status of an instrument.'
    0x6e:
      id: 'auction_notification_message'
      doc: 'Auction Notification message announces that a new Auction has started in the market for Nasdasq ISE (ISE), Nasdaq GEMX (GEMX), Nasdaq MRX (MRX) and Nasdaq BX (BX).'
    0x61:
      id: 'order_accepted_long_form_message'
      doc: 'This message is used to acknowledge a valid order submitted via New Order (Long Form).'
    0x62:
      id: 'order_accepted_short_form_message'
      doc: 'This message is used to acknowledge a valid order submitted via New Order (Short Form).'
    0x72:
      id: 'order_replaced_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Replace Order Message. Like Order Accepted Message, Order Replaced Message always comes before any Order Executed Messages or Order Cancelled Messages for the replacement.'
    0x63:
      id: 'order_cancelled_message'
      doc: 'An Order Cancelled Message informs you that an order has been fully cancelled. This could be acknowledging a Cancel Order Message, or it could be the result of the order being cancelled automatically by the system.'
    0x65:
      id: 'order_executed_message'
      doc: 'Order Executed Message informs you that all or part of an order has been executed. This message is used for simple as well as complex instruments.'
    0x74:
      id: 'trade_details_message'
      doc: 'A Trade Details message contains additional details, specifically clearing information. This message is sent out with a nominal delay after Order Executed message.'
    0x78:
      id: 'cross_order_accepted_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid New Cross Order.'
    0x6b:
      id: 'member_kill_switch_notification_message'
      doc: 'The Member Kill Switch Notification informs of:'
    0x75:
      id: 'mass_cancel_response_message'
      doc: 'Mass Cancel Response is sent out upon completion of processing of a valid Mass Cancel Request.'
    0x64:
      id: 'add_complex_instrument_response_message'
      doc: 'Add Complex Instrument Response is sent out when new or existing complex strategy requested via Add Complex Instrument Request is successfully created.'
    0x6d:
      id: 'modify_trade_response_message'
      doc: 'Modify Trade Response is sent when a valid Modify Trade Request is accepted.'
    0x66:
      id: 'subscription_response_message'
      doc: 'Subscription Response is sent after a valid Subscription Request has been processed.'
    0x6a:
      id: 'reject_message'
      doc: 'Reject is sent in response to a Request that is deemed invalid. Reject message contains error code explaining the reason for rejection'
    0x70:
      id: 'pending_response_message'
      doc: 'A Pending Response is sent when a request cannot be immediately, fully processed or validated, and indicates that the final status of the request is not yet known.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start of Messages. This is always the first message sent in any trading day.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start of System Hours. This message indicates that the system is up and ready to start accepting orders.'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start of Opening Process. This message indicates that the system has started its opening process.'
    0x57:
      id: 'end_of_wco_early_closing'
      doc: 'End of WCO Early closing. This message is intended to indicate that the exchange will no longer accept any new orders or changes to existing Orders on last trading date of WCO options.'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End of Normal Hours Processing. This message indicates that the system will no longer generate new executions for options that trade during normal hours.'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End of Late Hours Processing. This message indicates that the system will no longer generate new executions for options that trade during extended hours.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End of System Hours. This message indicates that the system is now closed.'
    0x43:
      id: 'end_of_messages'
      doc: 'End of Messages. This is always the last message sent in any trading day.'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing_at_1200_noon'
      doc: 'WCO Early Closing at 12:00 Noon'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Not Tradable'
  closing_only:
    0x4e:
      id: 'unrestricted'
      doc: 'Unrestricted'
    0x59:
      id: 'closing_position_only'
      doc: 'Option is Closing Position Only. Only MM origin orders can have open position in the series'
  mpv:
    0x45:
      id: 'penny_everywhere'
      doc: 'Penny Everywhere'
    0x53:
      id: 'scaled'
      doc: 'Scaled'
    0x50:
      id: 'penny_pilot'
      doc: 'Penny Pilot'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x54:
      id: 'trading'
      doc: 'Trading. Note, at the start of day all instruments are assumed to be Trading unless notified as Halted by this message.'
  exec_flag:
    0x30:
      id: 'none'
      doc: 'None'
    0x31:
      id: 'aon'
      doc: 'AON'
  order_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other-Exchange Registered Market Maker (FARMM/AWAYMM)'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker/Dealer- Customer'
    0x4b:
      id: 'broker_dealer_firm'
      doc: 'Broker Dealer - Firm'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint BackOffice (JBO). A placeholder for future functionality on BX, ISE, GEMX and MRX; supported on NOM.'
    0x52:
      id: 'retail'
      doc: 'Retail. A placeholder for future functionality on NOM, ISE, GEMX and MRX.'
    0x45:
      id: 'proprietary_customer'
      doc: 'Proprietary Customer. Available on ISE, GEMX and MRX only; attempts to submit on BX or NOM are rejected.'
    0x20:
      id: 'na'
      doc: 'N/A'
  cancel_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'User requested cancel. Sent in response to a Cancel Message'
    0x49:
      id: 'immediate_or_cancel_order'
      doc: 'Immediate or Cancel order. This order was originally sent with a TIF=I and no further matches were available on the book so the remaining unexecuted shares were immediately cancelled'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory. This order was manually cancelled by an Exchange supervisory terminal'
    0x44:
      id: 'regulatory_restriction'
      doc: 'This order cannot be executed because of a regulatory restriction (e.g. trade through restrictions).'
    0x51:
      id: 'anti_internalize'
      doc: 'Anti-Internalize. The order was cancelled by the system to avoid trading with another order or quote with the same firm Id'
    0x42:
      id: 'alo_order_cancelled'
      doc: 'ALO Order cancelled to avoid being displayed at the price other than its limit'
    0x41:
      id: 'unexecuted_auction_response'
      doc: 'Unexecuted Auction Response'
    0x4b:
      id: 'kill_switch'
      doc: 'Cancel triggered by Kill Switch'
    0x43:
      id: 'cancel_on_disconnect'
      doc: 'Cancel on Disconnect'
    0x4f:
      id: 'open_delay_timer_cancellation'
      doc: 'Open Delay Timer Cancellation'
    0x52:
      id: 'atr_limit_cancellation'
      doc: 'ATR Limit Cancellation'
    0x5a:
      id: 'rejected_cancel_replace_attempt'
      doc: 'Original Order Cancel due to rejected Cancel Replace Attempt'
  ord_exec_type:
    0x41:
      id: 'execution_of_an_order_for_a_simple_instrument'
      doc: 'Execution of an order for a simple instrument'
    0x42:
      id: 'execution_of_an_order_for_a_complex_instrument'
      doc: 'Execution of an order for a complex instrument'
    0x43:
      id: 'execution_of_an_option_leg_of_a_complex_order'
      doc: 'Execution of an option leg of a complex order'
    0x44:
      id: 'execution_of_a_stock_leg_of_a_complex_order'
      doc: 'Execution of a stock leg of a complex order'
  liquidity_ind:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'maker'
      doc: 'Maker'
    2:
      id: 'taker'
      doc: 'Taker'
    4:
      id: 'response'
      doc: 'Response'
    5:
      id: 'hidden'
      doc: 'Hidden'
    6:
      id: 'opening_rotation'
      doc: 'Opening Rotation'
    7:
      id: 'cross'
      doc: 'Cross'
    8:
      id: 'flashed_order'
      doc: 'Flashed Order'
    9:
      id: 'flash_response'
      doc: 'Flash Response'
    10:
      id: 'routed_out'
      doc: 'Routed Out'
    11:
      id: 'trade_report'
      doc: 'Trade Report'
    12:
      id: 'combo_maker_against_combo'
      doc: 'Combo Maker Against Combo'
    13:
      id: 'combo_taker_against_combo'
      doc: 'Combo Taker Against Combo'
    14:
      id: 'combo_response_against_combo'
      doc: 'Combo Response Against Combo'
    15:
      id: 'combo_hidden_against_combo'
      doc: 'Combo Hidden Against Combo'
    16:
      id: 'combo_opening_rotation'
      doc: 'Combo Opening Rotation'
    17:
      id: 'combo_cross'
      doc: 'Combo Cross'
    18:
      id: 'combo_taker_against_regular'
      doc: 'Combo Taker Against Regular'
    19:
      id: 'regular_maker_against_combo'
      doc: 'Regular Maker Against Combo'
    20:
      id: 'combo_taker_against_io'
      doc: 'Combo Taker Against IO'
    21:
      id: 'regular_incl_pim_taker_against_io'
      doc: 'Regular (incl. PIM) Taker Against IO'
    22:
      id: 'io_maker_against_combo'
      doc: 'IO Maker Against Combo'
    23:
      id: 'io_maker_against_regular'
      doc: 'IO Maker Against Regular'
    24:
      id: 'regular_maker_against_io_participant'
      doc: 'Regular Maker Against IO Participant'
    25:
      id: 'io_participant_taker_against_regular'
      doc: 'IO Participant Taker Against Regular'
    26:
      id: 'broken_price_improvement'
      doc: 'Broken Price Improvement'
    27:
      id: 'broken_facilitation'
      doc: 'Broken Facilitation'
    28:
      id: 'broken_solicitation'
      doc: 'Broken Solicitation'
    29:
      id: 'combo_broken_price_improvement'
      doc: 'Combo Broken Price Improvement'
    30:
      id: 'combo_broken_facilitation'
      doc: 'Combo Broken Facilitation'
    31:
      id: 'combo_broken_solicitation'
      doc: 'Combo Broken Solicitation'
    32:
      id: 'block'
      doc: 'Block'
    33:
      id: 'block_response'
      doc: 'Block Response'
    34:
      id: 'directed_response'
      doc: 'Directed Response'
    35:
      id: 'facilitation'
      doc: 'Facilitation'
    36:
      id: 'facilitation_response'
      doc: 'Facilitation Response'
    37:
      id: 'price_improvement'
      doc: 'Price Improvement'
    38:
      id: 'price_improvement_response'
      doc: 'Price improvement Response'
    39:
      id: 'solicitation'
      doc: 'Solicitation'
    40:
      id: 'solicitation_response'
      doc: 'Solicitation Response'
    41:
      id: 'qualified_contingent_cross'
      doc: 'Qualified Contingent Cross'
    42:
      id: 'customer_to_customer'
      doc: 'Customer to Customer'
    43:
      id: 'combo_facilitation'
      doc: 'Combo Facilitation'
    44:
      id: 'combo_facilitation_response'
      doc: 'Combo Facilitation Response'
    45:
      id: 'combo_price_improvement'
      doc: 'Combo Price Improvement'
    46:
      id: 'combo_price_improvement_response'
      doc: 'Combo Price Improvement Response'
    47:
      id: 'combo_solicitation'
      doc: 'Combo Solicitation'
    48:
      id: 'combo_solicitation_response'
      doc: 'Combo Solicitation Response'
    49:
      id: 'combo_qualified_contingent_cross'
      doc: 'Combo Qualified Contingent Cross'
    50:
      id: 'combo_customer_to_customer'
      doc: 'Combo Customer to Customer'
    51:
      id: 'sweep_routed_out'
      doc: 'Sweep Routed Out'
    52:
      id: 'sweep_trade_report'
      doc: 'Sweep Trade Report'
  trans_type:
    0x41:
      id: 'new_trade'
      doc: 'New Trade'
    0x42:
      id: 'trade_busted'
      doc: 'Trade Busted'
    0x43:
      id: 'modified_trade'
      doc: 'Modified Trade'
  event_source:
    0x41:
      id: 'matching_engine'
      doc: 'Matching Engine'
    0x4d:
      id: 'manual_trade_entry'
      doc: 'Manual Trade Entry'
    0x55:
      id: 'trade_modification_user'
      doc: 'Trade Modification (user)'
    0x43:
      id: 'trade_modification_contra_side_user'
      doc: 'Trade Modification (contra-side user)'
    0x45:
      id: 'trade_modification_exchange'
      doc: 'Trade Modification (exchange)'
    0x42:
      id: 'trade_bust_exchange'
      doc: 'Trade Bust (exchange)'
  stock_venue:
    0x58:
      id: 'not_applicable'
      doc: 'Not Applicable (not a stock leg execution)'
    0x41:
      id: 'bny_converg_ex_us_transaction_services'
      doc: 'BNY ConvergEx U.S. Transaction Services'
    0x42:
      id: 'bny_converg_ex_millennium_ats'
      doc: 'BNY ConvergEx Millennium ATS'
    0x47:
      id: 'cheevers'
      doc: 'Cheevers'
    0x48:
      id: 'libucki'
      doc: 'Libucki'
    0x49:
      id: 'fog_equities'
      doc: 'FOG Equities'
    0x4a:
      id: 'knight_capital_group'
      doc: 'Knight Capital Group (KCG)'
  reject_code:
    10:
      id: 'invalid_firm'
      doc: 'Invalid Firm'
    11:
      id: 'invalid_instrument'
      doc: 'Invalid Instrument'
    12:
      id: 'invalid_instrument_type'
      doc: 'Invalid InstrumentType'
    13:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    14:
      id: 'invalid_price'
      doc: 'Invalid Price'
    15:
      id: 'invalid_side'
      doc: 'Invalid Side'
    16:
      id: 'invalid_tif'
      doc: 'Invalid Tif'
    17:
      id: 'invalid_iso'
      doc: 'Invalid Iso'
    18:
      id: 'invalid_auction_type'
      doc: 'Invalid AuctionType'
    19:
      id: 'invalid_auction_id'
      doc: 'Invalid AuctionId'
    20:
      id: 'invalid_order_type'
      doc: 'Invalid OrderType'
    21:
      id: 'invalid_pref_party'
      doc: 'Invalid PrefParty'
    22:
      id: 'invalid_alo'
      doc: 'Invalid ALO'
    23:
      id: 'invalid_capacity'
      doc: 'Invalid Capacity'
    24:
      id: 'invalid_flash_inst'
      doc: 'Invalid FlashInst'
    25:
      id: 'invalid_trade'
      doc: 'Invalid Trade'
    26:
      id: 'invalid_format'
      doc: 'Invalid Format'
    27:
      id: 'invalid_cross_type'
      doc: 'Invalid CrossType'
    28:
      id: 'invalid_min_quantity'
      doc: 'Invalid MinQuantity'
    29:
      id: 'invalid_price_protection'
      doc: 'Invalid PriceProtection'
    30:
      id: 'invalid_reserve'
      doc: 'Invalid Reserve'
    31:
      id: 'invalid_persist'
      doc: 'Invalid Persist'
    32:
      id: 'invalid_short_sale_ind'
      doc: 'Invalid ShortSaleInd'
    33:
      id: 'invalid_product'
      doc: 'Invalid Product'
    34:
      id: 'invalid_scope'
      doc: 'Invalid Scope'
    35:
      id: 'invalid_clearing_info'
      doc: 'Invalid Clearing Info'
    36:
      id: 'invalid_position_effect'
      doc: 'Invalid Position Effect'
    37:
      id: 'invalid_cross_id'
      doc: 'Invalid CrossId'
    38:
      id: 'invalid_match_id'
      doc: 'Invalid MatchId'
    39:
      id: 'invalid_client_order_id'
      doc: 'Invalid Client Order Id'
    40:
      id: 'invalid_killswitch_action'
      doc: 'Invalid Killswitch Action'
    41:
      id: 'invalid_leg_count'
      doc: 'Invalid Leg Count'
    42:
      id: 'invalid_leg_type'
      doc: 'Invalid Leg Type'
    43:
      id: 'invalid_leg_ratio'
      doc: 'Invalid Leg Ratio'
    44:
      id: 'invalid_mpid'
      doc: 'Invalid Mpid'
    45:
      id: 'invalid_time'
      doc: 'Invalid Time'
    46:
      id: 'invalid_msg_type'
      doc: 'Invalid Msg Type'
    47:
      id: 'invalid_disclosure_mask'
      doc: 'Invalid Disclosure Mask'
    48:
      id: 'post_only_reprice'
      doc: 'Post Only Reprice'
    49:
      id: 'un_authorized_give_up'
      doc: 'UnAuthorized GiveUp'
    101:
      id: 'not_free_trading'
      doc: 'Not Free Trading'
    102:
      id: 'pref_not_allowed'
      doc: 'Pref Not Allowed'
    103:
      id: 'stock_combo_not_allowed'
      doc: 'Stock Combo Not Allowed'
    104:
      id: 'instrument_halted'
      doc: 'Instrument Halted'
    105:
      id: 'kill_switch_in_effect'
      doc: 'Kill Switch In Effect'
    106:
      id: 'system_closed'
      doc: 'System Closed'
    107:
      id: 'test_mode'
      doc: 'Test Mode'
    108:
      id: 'order_not_found'
      doc: 'Order Not Found'
    109:
      id: 'too_late_to_act'
      doc: 'Too Late To Act'
    110:
      id: 'instrument_closed'
      doc: 'Instrument Closed'
    111:
      id: 'instrument_state'
      doc: 'Instrument State'
    112:
      id: 'action_not_allowed'
      doc: 'Action Not Allowed'
    113:
      id: 'luld_in_effect'
      doc: 'LULD In Effect'
    114:
      id: 'too_many_combos'
      doc: 'Too Many Combos'
    115:
      id: 'request_cancelled'
      doc: 'Request Cancelled'
  pending_reason:
    0x41:
      id: 'request_in_progress'
      doc: 'Request In Progress'

