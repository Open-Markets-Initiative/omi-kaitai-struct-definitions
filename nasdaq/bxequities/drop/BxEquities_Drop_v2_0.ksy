# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq BxEquities Drop AsciiDrop v2.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Drop
#   Encoding: Ascii Drop
#   Version: 2.0
#   Date: 04/19/2012
#   Specification: NQBX_DROP20.pdf
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
  id: nasdaq_bxequities_drop_asciidrop_v2_0
  title: Nasdaq BxEquities Drop AsciiDrop v2.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq BX Drop AsciiDrop v2.0'
doc-ref: https://www.nasdaqtrader.com/content/technicalsupport/specifications/TradingProducts/NQBX_DROP20.pdf

seq:
  - id: message_header
    type: message_header_struct
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

types:
  message_header_struct:
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
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
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
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The match number assigned by Nasdaq to this trade. Each match consists of an execution between a buy order and a sell order'
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
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
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
  previous_execution_broken_message:
    seq:
      - id: separator_1
        size: 1
        doc: 'Field separator'
      - id: source
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The source of the order. Typically the account of the OUCH port used to enter the order, but can also have the special value "$PHON " for orders received via the phone desk'
      - id: separator_2
        size: 1
        doc: 'Field separator'
      - id: user
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form User field as specified by the order entry firm when the order was entered'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered'
      - id: separator_4
        size: 1
        doc: 'Field separator'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'The side of the trade executed'
      - id: separator_5
        size: 1
        doc: 'Field separator'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accept, the total number of shares entered; for a cancel, the incremental number of shares canceled; for an execution, the incremental number of shares executed in this trade; for a broken execution, the number of shares in the previously transmitted execution'
      - id: separator_6
        size: 1
        doc: 'Field separator'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The stock symbol'
      - id: separator_7
        size: 1
        doc: 'Field separator'
      - id: price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a new order accepted, the limit price of the order; for an execution, the execution price; for a cancel, the limit price of the open order'
      - id: separator_8
        size: 1
        doc: 'Field separator'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order entry firm'
      - id: separator_9
        size: 1
        doc: 'Field separator'
      - id: reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The match number assigned by Nasdaq to this trade. Each match consists of an execution between a buy order and a sell order'
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
      doc: 'B Bought'
    0x53:
      id: 'sold'
      doc: 'S Sold'
    0x54:
      id: 'sold_short'
      doc: 'T Sold Short'
    0x45:
      id: 'sold_short_exempt'
      doc: 'E Sold Short Exempt'
  liquidity_code:
    0x41:
      id: 'added'
      doc: 'A Added'
    0x52:
      id: 'removed'
      doc: 'R Removed'
    0x58:
      id: 'routed'
      doc: 'X Routed'
    0x44:
      id: 'dot'
      doc: 'D Dot'
    0x46:
      id: 'added_or_opening_trade_on_nyse'
      doc: 'F Added Or Opening Trade On Nyse'
    0x47:
      id: 'odd_lot_or_on_close_order_on_nyse'
      doc: 'G Odd Lot Or On Close Order On Nyse'
    0x4f:
      id: 'opening_cross_billable'
      doc: 'O Opening Cross Billable'
    0x4d:
      id: 'opening_cross_nonbillable'
      doc: 'M Opening Cross Nonbillable'
    0x43:
      id: 'closing_cross_billable'
      doc: 'C Closing Cross Billable'
    0x4c:
      id: 'closing_cross_nonbillable'
      doc: 'L Closing Cross Nonbillable'
    0x48:
      id: 'halt_ipo_cross_billable'
      doc: 'H Halt Ipo Cross Billable'
    0x4b:
      id: 'halt_ipo_cross_nonbillable'
      doc: 'K Halt Ipo Cross Nonbillable'
    0x49:
      id: 'intraday_and_postmarket_crosses'
      doc: 'I Intraday And Postmarket Crosses'
    0x4a:
      id: 'nondisplayed_adding_liquidity'
      doc: 'J Nondisplayed Adding Liquidity'
    0x59:
      id: 're_routed_by_nyse'
      doc: 'Y Re Routed By Nyse'
    0x53:
      id: 'odd_lot_execution_on_nyse'
      doc: 'S Odd Lot Execution On Nyse'
    0x55:
      id: 'added_liquidity_on_nyse'
      doc: 'U Added Liquidity On Nyse'
    0x42:
      id: 'routed_to_bx'
      doc: 'B Routed To Bx'
    0x45:
      id: 'nyse_other'
      doc: 'E Nyse Other'
    0x50:
      id: 'routed_to_psx'
      doc: 'P Routed To Psx'
    0x54:
      id: 'opening_trade_on_arca'
      doc: 'T Opening Trade On Arca'
    0x5a:
      id: 'on_close_order_on_arca'
      doc: 'Z On Close Order On Arca'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'M Removed Liquidity At A Midpoint'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'K Added Liquidity Via A Midpoint Order'
  clearing_code:
    0x51:
      id: 'qsr'
      doc: 'Q Qsr'

