# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Drop AsciiDrop v1.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Drop
#   Encoding: Ascii Drop
#   Version: 1.0
#   Date: 01/13/2015
#   Specification: drop_100.pdf
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
  id: nasdaq_nsmequities_drop_asciidrop_v1_0
  title: Nasdaq NsmEquities Drop AsciiDrop v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Drop AsciiDrop v1.0'
doc-ref: https://www.nasdaqtrader.com/content/technicalsupport/specifications/TradingProducts/drop_100.pdf

seq:
  - id: frame
    type: frame_struct
    repeat: eos
    doc: 'A fixed length, comma delimited, CR/LF terminated Drop message line'

types:
  frame_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Time Stamp and Type opening every Drop message line'
      - id: message
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::new_order_accepted_message': new_order_accepted_message
            'message_type::existing_order_executed_message': existing_order_executed_message
            'message_type::existing_order_canceled_message': existing_order_canceled_message
            'message_type::previous_execution_broken_message': previous_execution_broken_message
      - id: cr
        type: u1
        doc: 'Carriage return ending the line'
      - id: lf
        type: u1
        doc: 'Line feed ending the line'
  message_header:
    seq:
      - id: time_stamp
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time the event occurred, seconds past midnight Eastern with a written decimal point and three decimals (milliseconds)'
      - id: comma
        type: str
        size: 1
        encoding: ASCII
        doc: 'Field separator'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'The event the line reports'
  new_order_accepted_message:
    seq:
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
  existing_order_executed_message:
    seq:
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The match number assigned by Nasdaq to this trade. Each match consists of an execution between a buy order and a sell order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
  existing_order_canceled_message:
    seq:
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'For cancel messages, the cancel reason value'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
  previous_execution_broken_message:
    seq:
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The match number assigned by Nasdaq to this trade. Each match consists of an execution between a buy order and a sell order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'

enums:
  message_type:
    0x41:
      id: 'new_order_accepted_message'
      doc: 'New order accepted.'
    0x45:
      id: 'existing_order_executed_message'
      doc: 'Existing order executed.'
    0x58:
      id: 'existing_order_canceled_message'
      doc: 'Existing order canceled.'
    0x42:
      id: 'previous_execution_broken_message'
      doc: 'Previous execution broken.'
  buy_sell:
    0x42:
      id: 'bought'
      doc: 'B = Bought'
    0x53:
      id: 'sold'
      doc: 'S = Sold'
    0x54:
      id: 'sold_short'
      doc: 'T = Sold Short'
    0x45:
      id: 'sold_short_exempt'
      doc: 'E = Sold Short Exempt'
  capacity:
    0x41:
      id: 'agency'
      doc: 'A = Agency'
    0x50:
      id: 'principal'
      doc: 'P = Principal'
    0x52:
      id: 'riskless'
      doc: 'R = Riskless'
  liquidity_code:
    0x41:
      id: 'added'
      doc: 'A = Added'
    0x52:
      id: 'removed'
      doc: 'R = Removed'
    0x58:
      id: 'routed'
      doc: 'X = Routed'
    0x44:
      id: 'dot'
      doc: 'D = DOT'
    0x46:
      id: 'opening_trade_on_nyse'
      doc: 'F = Opening Trade (on NYSE)'
    0x47:
      id: 'on_close_order_on_nyse'
      doc: 'G = On-Close order (on NYSE)'
    0x4f:
      id: 'opening_cross'
      doc: 'O = Opening Cross'
    0x4d:
      id: 'opening_cross_imbalanceonly'
      doc: 'M = Opening Cross (imbalance-only)'
    0x43:
      id: 'closing_cross'
      doc: 'C = Closing Cross'
    0x4c:
      id: 'closing_cross_imbalanceonly'
      doc: 'L = Closing Cross (imbalance-only)'
    0x48:
      id: 'halt_ipo_cross'
      doc: 'H = Halt/IPO Cross'
    0x4b:
      id: 'halt_cross'
      doc: 'K = Halt Cross'
    0x4a:
      id: 'nondisplayed_adding_liquidity'
      doc: 'J = Non-displayed adding liquidity'
    0x59:
      id: 're_routed_by_nyse'
      doc: 'Y = Re-Routed by NYSE'
    0x53:
      id: 'odd_lot_execution_on_nyse'
      doc: 'S = Odd Lot Execution (on NYSE)'
    0x55:
      id: 'added_liquidity_on_nyse'
      doc: 'U = Added Liquidity (On NYSE)'
    0x42:
      id: 'routed_to_bx'
      doc: 'B = Routed to BX'
    0x45:
      id: 'nyse_other'
      doc: 'E = NYSE Other'
    0x50:
      id: 'routed_to_psx'
      doc: 'P = Routed to PSX'
    0x54:
      id: 'opening_trade_on_arca'
      doc: 'T = Opening Trade (on ARCA)'
    0x5a:
      id: 'on_close_order_on_arca'
      doc: 'Z = On-Close order (on ARCA)'
    0x57:
      id: 'added_postonly_not_currently_available'
      doc: 'W = Added post-only (not currently available)'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'm = Removed liquidity at a midpoint'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'k = Added liquidity via a midpoint order'
    0x30:
      id: 'supplemental_order_execution'
      doc: '0 = Supplemental order execution'
    0x37:
      id: 'displayed_liquidityadding_order_improves_the_nbbo'
      doc: '7 = Displayed, liquidity-adding order improves the NBBO'
    0x38:
      id: 'displayed_liquidityadding_order_sets_the_qbbo_while_joining_the_nbbo'
      doc: '8 = Displayed, liquidity-adding order sets the QBBO while joining the NBBO'
    0x64:
      id: 'retail_designated_execution_that_removed_liquidity_not_currently_available'
      doc: 'd = Retail designated execution that removed liquidity (not currently available)'
    0x65:
      id: 'retail_designated_execution_that_added_displayed_liquidity'
      doc: 'e = Retail designated execution that added displayed liquidity'
    0x66:
      id: 'retail_designated_execution_that_added_nondisplayed_liquidity_not_currently_available'
      doc: 'f = Retail designated execution that added non-displayed liquidity (not currently available)'
    0x6a:
      id: 'rpi_order_that_provides_liquidity'
      doc: 'j = RPI order that provides liquidity'
    0x72:
      id: 'retail_order_that_removes_rpi_liquidity'
      doc: 'r = Retail order that removes RPI liquidity'
    0x74:
      id: 'retail_order_that_removes_price_improving_nondisplayed_liquidity_other_than_rpi_liquidity'
      doc: 't = Retail order that removes price improving non-displayed liquidity other than RPI liquidity'
    0x34:
      id: 'added_displayed_liquidity_in_a_select_symbol'
      doc: '4 = Added displayed liquidity in a Select Symbol'
    0x35:
      id: 'added_nondisplayed_liquidity_in_a_select_symbol'
      doc: '5 = Added non-displayed liquidity in a Select Symbol'
    0x36:
      id: 'liquidity_removing_order_in_a_select_symbol'
      doc: '6 = Liquidity Removing Order in a Select Symbol'
    0x67:
      id: 'added_nondisplayed_midpoint_liquidity_in_a_select_symbol'
      doc: 'g = Added non-displayed midpoint liquidity in a Select Symbol'
  clearing_code:
    0x51:
      id: 'qsr'
      doc: 'Q = QSR'
  cancel_reason:
    0x55:
      id: 'user_cancel'
      doc: 'U = User cancel'
    0x49:
      id: 'ioc_cancel'
      doc: 'I = IOC cancel'
    0x54:
      id: 'timeout'
      doc: 'T = Timeout'
    0x53:
      id: 'supervisory_cancel'
      doc: 'S = Supervisory cancel'
    0x44:
      id: 'regulatory_cancel'
      doc: 'D = Regulatory cancel'
    0x51:
      id: 'self_match_prevention'
      doc: 'Q = Self Match Prevention'
    0x5a:
      id: 'system_cancel'
      doc: 'Z = System cancel'
    0x43:
      id: 'cross_cancel'
      doc: 'C = Cross cancel'

