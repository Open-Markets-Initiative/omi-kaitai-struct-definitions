# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NomOptions Otto Ouch v3.0.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Ouch to Trade Options
#   Encoding: Ouch
#   Version: 3.0.0
#   Date: 08/17/2026
#   Specification: Options_ETH_OTTO.pdf
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
  id: nasdaq_nomoptions_otto_ouch_v3_0_0_client
  title: Nasdaq NomOptions Otto Ouch v3.0.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Options Market Ouch to Trade Options Ouch v3.0.0'
doc-ref:
  - https://www.nasdaq.com/products/north-american-markets/resources/options-specifications-and-resources-hub
  - https://www.nasdaq.com/Options_ETH_OTTO
  - https://www.nasdaq.com/Options_OTTO

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type sent by the client'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: u1
        enum: unsequenced_message_type
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::new_order_long_form_message': new_order_long_form_message
            'unsequenced_message_type::new_order_short_form_message': new_order_short_form_message
            'unsequenced_message_type::replace_order_message': replace_order_message
            'unsequenced_message_type::cancel_order_message': cancel_order_message
            'unsequenced_message_type::mass_cancel_message': mass_cancel_message
            'unsequenced_message_type::new_cross_order_message': new_cross_order_message
            'unsequenced_message_type::modify_trade_message': modify_trade_message
            'unsequenced_message_type::member_kill_switch_request_message': member_kill_switch_request_message
  new_order_long_form_message:
    seq:
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
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
        doc: 'Sub-account/MM Identifier at the registered exchange; all four characters will be provided to OCC'
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
        doc: 'N=Not ALO, Y=ALO'
      - id: iso
        type: u1
        enum: iso
        doc: 'N=Not ISO, I=ISO'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'L=Limit, M=Market'
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
      - id: auction_duration
        type: u4
        doc: 'User defined field for Auction Duration. In milliseconds between 3,000 and 300,000. Only required for Flex auctions. Must be 0 for Non-Flex Auctions'
      - id: disclosure_mask
        type: u1
        doc: 'See Disclosure Mask Field (bits 0-5: Firm, Clearing Account, CMTA Account, Side, Price, Quantity; a set bit makes the attribute visible)'
      - id: price_protection
        type: u1
        enum: price_protection
        doc: 'L=Local Market, N=National Market'
      - id: display_qty
        type: u2
        doc: 'Initial Display Quantity'
      - id: display_when
        type: u1
        enum: display_when
        doc: 'I=Immediate, E=Exhaust, N=N/A'
      - id: display_method
        type: u1
        enum: display_method
        doc: 'I=Initial, R=Random, N=None'
      - id: display_low_qty
        type: u2
        doc: 'If DisplayMethod = Random'
      - id: display_high_qty
        type: u2
        doc: 'If DisplayMethod = Random'
      - id: position_effect_mask
        type: u2
        doc: 'See Position Effect Mask Field (bit n = leg n; set bit = Open, cleared bit = Close)'
      - id: stock_leg_short_sale
        type: u1
        enum: stock_leg_short_sale
        doc: 'N=Not Applicable, H=Sell Short, E=Sell Short Exempt. If this is a multi-leg order for a stock combo where stock leg is on the Sell side StockLegShortSale may be set to H or E. In all other cases value N should be used'
      - id: stock_leg_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give-up for the stock leg'
      - id: stock_capacity
        type: u1
        enum: stock_capacity
        doc: 'P=Principal, A=Agency, R=Riskless Principal, space=Not Applicable'
      - id: reserved_9
        size: 9
        doc: 'Reserved for future use'
      - id: num_flex_leg_prices
        type: u1
        doc: 'To be used for notifying Leg Deltas on Delta-Adjusted At Close feature as well as Leg Prices on Flex instruments. It will be 0 for non-Flex instruments'
      - id: flex_leg_prices
        type: flex_leg_prices
        repeat: expr
        repeat-expr: num_flex_leg_prices
        doc: 'Leg Definitions (1-10) of New Order (Long Form) and New Cross Order: Leg Prices on Flex instruments, to be used for Leg Deltas on the Delta-Adjusted At Close feature'
  flex_leg_prices:
    seq:
      - id: leg_prices
        type: decimal_s8_6
        doc: 'Price of the individual leg. Implied decimal with scale 1e-6'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  new_order_short_form_message:
    seq:
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: alo_inst
        type: u1
        enum: alo_inst
        doc: 'N=Not ALO, Y=ALO'
      - id: iso
        type: u1
        enum: iso
        doc: 'N=Not ISO, I=ISO'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'L=Limit, M=Market'
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
        doc: 'L=Local Market, N=National Market'
      - id: position_effect_mask
        type: u2
        doc: 'See Position Effect Mask Field (bit n = leg n; set bit = Open, cleared bit = Close)'
      - id: stock_capacity
        type: u1
        enum: stock_capacity
        doc: 'P=Principal, A=Agency, R=Riskless Principal, space=Not Applicable'
  replace_order_message:
    seq:
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: orig_cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Identifier of the order to be replaced. If no open order with such identifier is found, request is rejected'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'L=Limit, M=Market'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Should be set to 0 if Order Type = M. Implied decimal with scale 1e-6'
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
      - id: price_protection
        type: u1
        enum: price_protection
        doc: 'L=Local Market, N=National Market'
  cancel_order_message:
    seq:
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: cl_ord_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Client Order Id'
  mass_cancel_message:
    seq:
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
        doc: 'Client identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'A=All, O=Simple Instrument, C=Standard Combination, S=Stock Combination'
      - id: scope
        type: u1
        enum: scope
        doc: 'Scope of the deletion request: P=Product (requires ProductID, InstrumentID must be 0), I=Instrument (requires InstrumentID, ProductID must be 0), F=Firm (ProductId and InstrumentId must be set to zero)'
      - id: product_id
        type: u2
        doc: 'Product (Underlying) ID, as specified by Option Directory notifications. Must be populated if Scope=P and UnderlyingSymbol not populated'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique underlying stock symbol for the option symbol. Must be populated if Scope = P and ProductID not populated'
  new_cross_order_message:
    seq:
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
        doc: 'A=Auction, Q=QCC, C=CCC'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'See Auction Type Field'
      - id: auction_alloc_pct
        type: u1
        doc: 'Order Allocation percentage 0 <= n <= 40. 0 for Simple and Complex Solicitation'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: iso
        type: u1
        enum: iso
        doc: 'N=Not ISO, I=ISO'
      - id: price_protection
        type: u1
        enum: price_protection
        doc: 'L=Local Market, N=National Market'
      - id: effective_time
        type: u8
        doc: 'Agreed upon time for the stopped price. UTC time in milliseconds'
      - id: disclosure_mask
        type: u1
        doc: 'See Disclosure Mask Field (bits 0-5: Firm, Clearing Account, CMTA Account, Side, Price, Quantity; a set bit makes the attribute visible)'
      - id: auction_duration
        type: u4
        doc: 'User defined field for Auction Duration. In milliseconds between 3,000 and 300,000. Only required for Flex auctions. Must be 0 for Non-Flex Auctions'
      - id: reserved_9
        size: 9
        doc: 'Reserved for future use'
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
        doc: 'Sub-account/MM Identifier at the registered exchange; all four characters will be provided to OCC'
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
        doc: 'N=Not Applicable, H=Sell Short, E=Sell Short Exempt. If this is a multi-leg order for a stock combo where stock leg is on the Sell side StockLegShortSale may be set to H or E. In all other cases value N should be used'
      - id: primary_stock_leg_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give-up for the stock leg'
      - id: primary_stock_capacity
        type: u1
        enum: primary_stock_capacity
        doc: 'P=Principal, A=Agency, R=Riskless Principal, space=Not Applicable'
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
        doc: 'Sub-account/MM Identifier at the registered exchange; all four characters will be provided to OCC'
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
        doc: 'L=Limit, M=Market'
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
        doc: 'N=Not Applicable, H=Sell Short, E=Sell Short Exempt. If this is a multi-leg order for a stock combo where stock leg is on the Sell side StockLegShortSale may be set to H or E. In all other cases value N should be used'
      - id: contra_stock_leg_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give-up for the stock leg'
      - id: contra_stock_capacity
        type: u1
        enum: contra_stock_capacity
        doc: 'P=Principal, A=Agency, R=Riskless Principal, space=Not Applicable'
      - id: num_flex_leg_prices
        type: u1
        doc: 'To be used for notifying Leg Deltas on Delta-Adjusted At Close feature as well as Leg Prices on Flex instruments. It will be 0 for non-Flex instruments'
      - id: flex_leg_prices
        type: flex_leg_prices
        repeat: expr
        repeat-expr: num_flex_leg_prices
        doc: 'Leg Definitions (1-10) of New Order (Long Form) and New Cross Order: Leg Prices on Flex instruments, to be used for Leg Deltas on the Delta-Adjusted At Close feature'
  modify_trade_message:
    seq:
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID (e.g. ABCD, 123A)'
      - id: instrument_id
        type: u4
        doc: 'Instrument ID, as specified by Option Directory notifications'
      - id: cl_request_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
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
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: num_trade_splits
        type: u2
        doc: 'Number of parties this trade is being split into (1 <= n <= 10)'
      - id: trade_splits
        type: trade_splits
        repeat: expr
        repeat-expr: num_trade_splits
        doc: 'Trade Splits [1..10] of Modify Trade: clearing configuration for each party the trade is being split into'
  trade_splits:
    seq:
      - id: alloc_qty
        type: u4
        doc: 'Quantity being allocated to the specified clearing configuration'
      - id: cmta
        type: u4
        doc: 'CMTA'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sub-account/MM Identifier at the registered exchange; all four characters will be provided to OCC'
      - id: occ_account
        type: u4
        doc: 'OCC # to use for clearing (give up)'
      - id: cust_acct
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account on the customer system (pass-through)'
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
        type: u1
        enum: open_close
        doc: 'O=Open, C=Closed, space=Carry Forward'
      - id: stock_capacity
        type: u1
        enum: stock_capacity
        doc: 'P=Principal, A=Agency, R=Riskless Principal, space=Not Applicable'
  member_kill_switch_request_message:
    seq:
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
        doc: 'Client identifier of the request. It is echoed back with either Mass Cancel Response or Reject'
      - id: target_firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Firm ID being targeted by the Kill Switch Request'
      - id: kill_action
        type: u1
        enum: kill_action
        doc: 'A=Block Entry of new requests and delete all open orders'
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
      doc: 'Long form of the New Order request provides full flexibility of configuring order attributes: simple and multi-leg instruments (up to 10 legs), clearing overrides, preferenced, AON/FOK, reserve and attributable orders, one-sided auction initiation (Block, Exposure and Flex auctions), auction responses and Do Not Trade Through orders. Acknowledged by Order Accepted (Long Form).'
    0x42:
      id: 'new_order_short_form_message'
      doc: 'Short format of the New Order request is a compact message (50 bytes) with limited flexibility: simple and multi-leg instruments, quantity up to 65535, auction responses, default clearing configuration for the Firm. Acknowledged by Order Accepted (Short Form).'
    0x52:
      id: 'replace_order_message'
      doc: 'Replace Order message is used to modify an existing order for both simple and complex instruments. It can also be used to alter price of the contra side of Cross Orders. The order to be replaced is identified by OrigClOrdId.'
    0x43:
      id: 'cancel_order_message'
      doc: 'Cancel Order by Client ID. Deletes a single simple order, a single complex order, or a Cross Order (terminating an ongoing auction). The order to be deleted is identified by the ClOrdId field.'
    0x55:
      id: 'mass_cancel_message'
      doc: 'This message is used to mass-delete multiple open orders based on the specified Scope. The sequence of Order Canceled messages is terminated with a single Mass Cancel Response.'
    0x58:
      id: 'new_cross_order_message'
      doc: 'Cross Order message allows specifying two opposite sides to trade against each other. The primary side of the order is exposed in an auction if CrossType is set to A (Auction). Other cross types (QCC and CCC) trade the two sides without market exposure. The Primary Side and Contra Side blocks of the document are carried as Primary and Contra prefixed fields.'
    0x4d:
      id: 'modify_trade_message'
      doc: 'The Modify Trade request is used to change clearing information on an existing trade as well as split a trade into multiple components with different clearing assignments. The trade to be changed is identified by the MatchId field. Acknowledged by Modify Trade Response.'
    0x4b:
      id: 'member_kill_switch_request_message'
      doc: 'The Member Kill Switch Request is used to block ability to enter new orders, alter existing orders, delete orders, and create complex instruments. Scope of the Kill Switch Request is one firm per request. Answered by Member Kill Switch Notification or Reject.'
  alo_inst:
    0x4e:
      id: 'not_alo'
      doc: 'Not Alo'
    0x59:
      id: 'alo'
      doc: 'Alo'
  iso:
    0x4e:
      id: 'not_iso'
      doc: 'Not Iso'
    0x49:
      id: 'iso'
      doc: 'Iso'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Bought On Executions Bid On Auction Notification'
    0x53:
      id: 'sell'
      doc: 'Sell Sold On Executions'
    0x4f:
      id: 'offer'
      doc: 'Offer Auction Notification Only'
    0x4e:
      id: 'not_disclosed'
      doc: 'Not Disclosed Auction Notification Only'
  order_type:
    0x4c:
      id: 'limit'
      doc: 'Limit'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4e:
      id: 'not_disclosed'
      doc: 'Not Disclosed Auction Notification Only'
  tif:
    0x44:
      id: 'day'
      doc: 'Day'
    0x46:
      id: 'fok'
      doc: 'Fill Or Kill'
    0x49:
      id: 'ioc'
      doc: 'Immediate Or Cancel'
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
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo Supported On Phlx And Nom Placeholder On Ise Gemx And Mrx'
    0x52:
      id: 'retail'
      doc: 'Retail Placeholder In All Venues'
    0x20:
      id: 'not_applicable'
      doc: 'Space Na'
  auction_type:
    0x46:
      id: 'simple_exposure_order'
      doc: 'Simple Exposure Order'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x4e:
      id: 'none'
      doc: 'Order Is Neither An Initiation Nor A Response To An Auction'
  price_protection:
    0x4c:
      id: 'local'
      doc: 'Local Market'
    0x4e:
      id: 'national'
      doc: 'National Market'
  display_when:
    0x49:
      id: 'immediate'
      doc: 'Immediate'
    0x45:
      id: 'exhaust'
      doc: 'Exhaust'
    0x4e:
      id: 'not_applicable'
      doc: 'Na'
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
      doc: 'Sell Short Sold Short On Executions'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt Sold Short Exempt On Executions'
  stock_capacity:
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  instrument_type:
    0x41:
      id: 'all'
      doc: 'All Mass Cancel Only'
    0x4f:
      id: 'simple_instrument'
      doc: 'Simple Instrument'
  scope:
    0x50:
      id: 'product'
      doc: 'Cancel All Open Orders For The Specified Firm Id Product Id Instrument Type'
    0x49:
      id: 'instrument'
      doc: 'Cancel All The Open Orders For The Specified Firm Id Instrument Id'
    0x46:
      id: 'firm'
      doc: 'Cancel All Open Orders For The Specified Firm Id Instrument Type'
  cross_type:
    0x41:
      id: 'auction'
      doc: 'Auction'
    0x51:
      id: 'qcc'
      doc: 'Qcc'
    0x43:
      id: 'ccc'
      doc: 'Ccc'
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
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo Supported On Phlx And Nom Placeholder On Ise Gemx And Mrx'
    0x52:
      id: 'retail'
      doc: 'Retail Placeholder In All Venues'
    0x20:
      id: 'not_applicable'
      doc: 'Space Na'
  primary_stock_leg_short_sale:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x48:
      id: 'sell_short'
      doc: 'Sell Short'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  primary_stock_capacity:
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo Supported On Phlx And Nom Placeholder On Ise Gemx And Mrx'
    0x52:
      id: 'retail'
      doc: 'Retail Placeholder In All Venues'
    0x20:
      id: 'not_applicable'
      doc: 'Space Na'
  contra_stock_leg_short_sale:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x48:
      id: 'sell_short'
      doc: 'Sell Short'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  contra_stock_capacity:
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x20:
      id: 'carry_forward'
      doc: 'Blank Space Carry Forward'
  kill_action:
    0x41:
      id: 'block_and_delete'
      doc: 'Block Entry Of New Requests And Delete All Open Orders'
    0x52:
      id: 'block_removed'
      doc: 'Killswitch Block Removed By Exchange Support Personnel'
    0x42:
      id: 'block'
      doc: 'Block Entry Of New Requests'
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
    0x69:
      id: 'instrument_trading_action_message'
      doc: 'This message notifies of changes to the trading status of an instrument.'
    0x6e:
      id: 'auction_notification_message'
      doc: 'Auction Notification message announces that a new Auction has started in the market for Nasdaq PHLX, ISE, GEMX and MRX. Auction orders include Block, Complex Exposure, Simple Exposed order, Facilitation, Solicitation, and PIM.'
    0x61:
      id: 'order_accepted_long_form_message'
      doc: 'Acknowledges the receipt and acceptance of a valid New Order (Long Form). The data fields from the New Order Message are echoed back. Order Accepted messages always come before any Order Executed or Order Canceled Messages for an order. Does not include Leg Prices or Auction Duration.'
    0x62:
      id: 'order_accepted_short_form_message'
      doc: 'This message is used to acknowledge a valid order submitted via New Order (Short Form).'
    0x72:
      id: 'order_replaced_message'
      doc: 'Acknowledges a Replace Order request.'
    0x63:
      id: 'order_canceled_message'
      doc: 'An Order Canceled Message informs you that an order has been fully canceled. This could be acknowledging a Cancel Order Message, or it could be the result of the order being canceled automatically by the system.'
    0x65:
      id: 'order_executed_message'
      doc: 'Order Executed message reports an execution of an order for a simple instrument, a complex instrument, or an option or stock leg of a complex order.'
    0x74:
      id: 'trade_details_message'
      doc: 'A Trade Details message contains additional details, specifically clearing information. This message is sent out with a nominal delay after Order Executed message. Trade Busts and Adjustments are made against individual MatchIds; Modify Trade results are reported with TransType B for the original trade and C for the new trades.'
    0x78:
      id: 'cross_order_accepted_message'
      doc: 'Acknowledges a valid New Cross Order. The Primary Side and Contra Side blocks of the document are carried as Primary and Contra prefixed fields.'
    0x6b:
      id: 'member_kill_switch_notification_message'
      doc: 'The Member Kill Switch Notification informs of a Member Kill Switch Request issued by this OTTO account, or a Kill Switch Action (User or System initiated) targeting Firm ID(s) associated with this OTTO account.'
    0x75:
      id: 'mass_cancel_response_message'
      doc: 'Mass Cancel Response is sent out upon completion of processing of a valid Mass Cancel Request.'
    0x6d:
      id: 'modify_trade_response_message'
      doc: 'Modify Trade Response is sent when a valid Modify Trade Request is accepted.'
    0x6a:
      id: 'reject_message'
      doc: 'Reject is sent in response to a Request that is deemed invalid. Reject message contains error code explaining the reason for rejection.'
    0x70:
      id: 'pending_response_message'
      doc: 'A Pending Response is sent by OTTO when a Request cannot be immediately, fully processed or validated, and indicates that the final status of the Request is not yet known (typically, any Request for a pending instrument). It is eventually followed by the Notification associated with the Request or a Reject.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages This Is Always The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours The System Is Up And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process The System Has Started Its Opening Process'
    0x57:
      id: 'end_of_wco_early_closing'
      doc: 'End Of Wco Early Closing No New Orders Or Changes To Existing Orders On Last Trading Date Of Wco Options'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End Of Normal Hours Processing No New Executions For Options That Trade During Normal Hours'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End Of Late Hours Processing No New Executions For Options That Trade During Extended Hours'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours The System Is Now Closed'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages This Is Always The Last Message Sent In Any Trading Day'
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
      id: 'wco_early_closing'
      doc: 'Wco Early Closing At 1200 Noon'
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
      doc: 'Option Is Closing Position Only Only Mm Origin Orders Can Have Open Position In The Series'
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
      doc: 'Trading'
  exec_flag:
    0x30:
      id: 'none'
      doc: 'None'
    0x31:
      id: 'aon'
      doc: 'Aon'
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
      doc: 'Other Exchange Registered Market Maker Farmmawaymm'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office Jbo Supported On Phlx And Nom Placeholder On Ise Gemx And Mrx'
    0x52:
      id: 'retail'
      doc: 'Retail Placeholder In All Venues'
    0x20:
      id: 'not_applicable'
      doc: 'Space Na'
  auction_event:
    0x53:
      id: 'start'
      doc: 'Start'
    0x55:
      id: 'auction_update'
      doc: 'Auction Update'
    0x45:
      id: 'end_of_auction'
      doc: 'End Of Auction'
  cancel_reason:
    0x55:
      id: 'user_requested'
      doc: 'User Requested Cancel Sent In Response To A Cancel Message'
    0x49:
      id: 'immediate_or_cancel'
      doc: 'Immediate Or Cancel Order No Further Matches Were Available On The Book So The Remaining Unexecuted Contracts Were Immediately Canceled'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory This Order Was Manually Canceled By An Exchange Supervisory Terminal'
    0x44:
      id: 'regulatory_restriction'
      doc: 'This Order Cannot Be Executed Because Of A Regulatory Restriction Eg Trade Through Restrictions'
    0x51:
      id: 'anti_internalize'
      doc: 'Anti Internalize The Order Was Cancelled By The System To Avoid Trading With Another Order Or Quote With The Same Firm Id'
    0x42:
      id: 'alo_not_displayable'
      doc: 'Alo Order Canceled To Avoid Being Displayed At The Price Other Than Its Limit'
    0x41:
      id: 'unexecuted_auction_response'
      doc: 'Unexecuted Auction Response'
    0x4b:
      id: 'kill_switch'
      doc: 'Cancel Triggered By Kill Switch'
    0x43:
      id: 'cancel_on_disconnect'
      doc: 'Cancel On Disconnect'
    0x4f:
      id: 'open_delay_timer'
      doc: 'Open Delay Timer Cancellation'
    0x50:
      id: 'atr_limit'
      doc: 'Atr Limit Cancellation'
    0x5a:
      id: 'rejected_cancel_replace'
      doc: 'Original Order Cancel Due To Rejected Cancel Replace Attempt'
  ord_exec_type:
    0x41:
      id: 'simple_instrument'
      doc: 'Execution Of An Order For A Simple Instrument Option'
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
      doc: 'Combo Taker Against Io'
    21:
      id: 'regular_incl_pim_taker_against_io'
      doc: 'Regular Incl Pim Taker Against Io'
    22:
      id: 'io_maker_against_combo'
      doc: 'Io Maker Against Combo'
    23:
      id: 'io_maker_against_regular'
      doc: 'Io Maker Against Regular'
    24:
      id: 'regular_maker_against_io_participant'
      doc: 'Regular Maker Against Io Participant'
    25:
      id: 'io_participant_taker_against_regular'
      doc: 'Io Participant Taker Against Regular'
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
      doc: 'Price Improvement Response'
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
      doc: 'Customer To Customer'
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
      doc: 'Combo Customer To Customer'
    51:
      id: 'sweep_routed_out'
      doc: 'Sweep Routed Out'
    52:
      id: 'sweep_trade_report'
      doc: 'Sweep Trade Report'
    53:
      id: 'combo_taker_against_regular_thru_nbbo'
      doc: 'Combo Taker Against Regular Thru Nbbo'
    54:
      id: 'combo_taker_against_io_thru_nbbo'
      doc: 'Combo Taker Against Io Thru Nbbo'
    55:
      id: 'simple_exposure_order_initiator_upon_receipt'
      doc: 'Simple Exposure Order Initiator Upon Receipt'
    56:
      id: 'simple_exposure_order_initiator'
      doc: 'Simple Exposure Order Initiator'
    57:
      id: 'simple_exposure_order_responder'
      doc: 'Simple Exposure Order Responder'
    58:
      id: 'flex_auction'
      doc: 'Flex Auction'
    59:
      id: 'flex_auction_responder'
      doc: 'Flex Auction Responder'
    60:
      id: 'flex_price_improvement'
      doc: 'Flex Price Improvement'
    61:
      id: 'flex_price_improvement_responder'
      doc: 'Flex Price Improvement Responder'
    62:
      id: 'flex_broken_price_improvement'
      doc: 'Flex Broken Price Improvement'
    63:
      id: 'flex_solicitation'
      doc: 'Flex Solicitation'
    64:
      id: 'flex_solicitation_responder'
      doc: 'Flex Solicitation Responder'
    65:
      id: 'flex_broken_solicitation'
      doc: 'Flex Broken Solicitation'
    66:
      id: 'combo_flex_auction'
      doc: 'Combo Flex Auction'
    67:
      id: 'combo_flex_auction_responder'
      doc: 'Combo Flex Auction Responder'
    68:
      id: 'combo_flex_price_improvement'
      doc: 'Combo Flex Price Improvement'
    69:
      id: 'combo_flex_price_improvement_responder'
      doc: 'Combo Flex Price Improvement Responder'
    70:
      id: 'combo_flex_broken_price_improvement'
      doc: 'Combo Flex Broken Price Improvement'
    71:
      id: 'combo_flex_solicitation'
      doc: 'Combo Flex Solicitation'
    72:
      id: 'combo_flex_solicitation_responder'
      doc: 'Combo Flex Solicitation Responder'
    73:
      id: 'combo_flex_broken_solicitation'
      doc: 'Combo Flex Broken Solicitation'
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
      doc: 'Trade Modification User'
    0x43:
      id: 'trade_modification_contra_side_user'
      doc: 'Trade Modification Contraside User'
    0x45:
      id: 'trade_modification_exchange'
      doc: 'Trade Modification Exchange'
    0x42:
      id: 'trade_bust_exchange'
      doc: 'Trade Bust Exchange'
  stock_venue:
    0x58:
      id: 'not_applicable'
      doc: 'Not Applicable Non Qcc Stock Leg Execution'
  reject_code:
    10:
      id: 'invalid_firm'
      doc: 'Invalid Firm'
    11:
      id: 'invalid_instrument'
      doc: 'Invalid Instrument'
    12:
      id: 'invalid_instrument_type'
      doc: 'Invalid Instrument Type'
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
      doc: 'Invalid Auction Type'
    19:
      id: 'invalid_auction_id'
      doc: 'Invalid Auction Id'
    20:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    21:
      id: 'invalid_pref_party'
      doc: 'Invalid Pref Party'
    22:
      id: 'invalid_alo'
      doc: 'Invalid Alo'
    23:
      id: 'invalid_capacity'
      doc: 'Invalid Capacity'
    24:
      id: 'invalid_reserved_inst'
      doc: 'Invalid Reserved Inst'
    25:
      id: 'invalid_trade'
      doc: 'Invalid Trade'
    26:
      id: 'invalid_format'
      doc: 'Invalid Format'
    27:
      id: 'invalid_cross_type'
      doc: 'Invalid Cross Type'
    28:
      id: 'invalid_min_quantity'
      doc: 'Invalid Min Quantity'
    29:
      id: 'invalid_price_protection'
      doc: 'Invalid Price Protection'
    30:
      id: 'invalid_reserve'
      doc: 'Invalid Reserve'
    31:
      id: 'invalid_persist'
      doc: 'Invalid Persist'
    32:
      id: 'invalid_short_sale_ind'
      doc: 'Invalid Short Sale Ind'
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
      doc: 'Invalid Cross Id'
    38:
      id: 'invalid_match_id'
      doc: 'Invalid Match Id'
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
      doc: 'Un Authorized Give Up'
    50:
      id: 'invalid_session'
      doc: 'Invalid Session'
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
      doc: 'Luld In Effect'
    114:
      id: 'too_many_combos'
      doc: 'Too Many Combos'
    115:
      id: 'request_cancelled'
      doc: 'Request Cancelled'
    116:
      id: 'below_minimum_reserve'
      doc: 'Below Minimum Reserve'
    117:
      id: 'port_rate_breached'
      doc: 'Port Rate Breached'
    118:
      id: 'invalid_trader_id'
      doc: 'Invalid Trader Id'
    119:
      id: 'stop_price_not_allowed'
      doc: 'Stop Price Not Allowed'
    120:
      id: 'stop_price'
      doc: 'Stop Price'
    121:
      id: 'firm_suspended'
      doc: 'Firm Suspended'
    122:
      id: 'trader_suspended'
      doc: 'Trader Suspended'
    123:
      id: 'port_suspended'
      doc: 'Port Suspended'
    124:
      id: 'invalid_investment_decision'
      doc: 'Invalid Investment Decision'
    125:
      id: 'invalid_execution_decision'
      doc: 'Invalid Execution Decision'
    126:
      id: 'invalid_dea'
      doc: 'Invalid Dea'
    127:
      id: 'invalid_client_id'
      doc: 'Invalid Client Id'
    128:
      id: 'invalid_party_role_qualifier'
      doc: 'Invalid Party Role Qualifier'
    129:
      id: 'order_expired'
      doc: 'Order Expired'
    130:
      id: 'invalid_good_til_date'
      doc: 'Invalid Good Til Date'
    131:
      id: 'instrument_expired'
      doc: 'Instrument Expired'
    132:
      id: 'invalid_self_match_prev_id'
      doc: 'Invalid Self Match Prev Id'
    133:
      id: 'spread'
      doc: 'Spread'
    134:
      id: 'not_permitted'
      doc: 'Not Permitted'
    135:
      id: 'size'
      doc: 'Size'
    136:
      id: 'attribute'
      doc: 'Attribute'
    137:
      id: 'reentry_required'
      doc: 'Reentry Required'
    138:
      id: 'opening_rotation'
      doc: 'Opening Rotation'
    139:
      id: 'kill_switch_reentry_required'
      doc: 'Kill Switch Reentry Required'
    140:
      id: 'auction'
      doc: 'Auction'
    141:
      id: 'market_closed'
      doc: 'Market Closed'
    142:
      id: 'pending'
      doc: 'Pending'
    143:
      id: 'system_error'
      doc: 'System Error'
    144:
      id: 'cancel_on_disconnect'
      doc: 'Cancel On Disconnect'
    145:
      id: 'auction_duration'
      doc: 'Auction Duration'
  pending_reason:
    0x41:
      id: 'request_in_progress'
      doc: 'Request In Progress'

