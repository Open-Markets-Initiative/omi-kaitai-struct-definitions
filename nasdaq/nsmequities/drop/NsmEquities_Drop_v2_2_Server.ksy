# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Drop AsciiDrop v2.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Drop
#   Encoding: Ascii Drop
#   Version: 2.2
#   Date: 10/01/2024
#   Specification: drop2.2.pdf
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
  id: nasdaq_nsmequities_drop_asciidrop_v2_2_server
  title: Nasdaq NsmEquities Drop AsciiDrop v2.2
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Drop AsciiDrop v2.2'
doc-ref: https://www.nasdaqtrader.com/content/technicalsupport/specifications/TradingProducts/drop2.2.pdf

seq:
  - id: server_packet_header
    type: server_packet_header_struct
    doc: 'SoupTcp Packet Header sent by the server'
  - id: server_payload
    type:
      switch-on: server_packet_header.server_packet_type
      cases:
        'server_packet_type::debug_packet': debug_packet
        'server_packet_type::login_accepted_packet': login_accepted_packet
        'server_packet_type::login_rejected_packet': login_rejected_packet
        'server_packet_type::sequenced_data_packet': sequenced_data_packet
  - id: soup_lf
    type: u1
    doc: 'Terminating line feed character'

types:
  server_packet_header_struct:
    seq:
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_header
        type: sequenced_message_header
        doc: 'Time Stamp and Type opening every Drop message line'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.message_type
          cases:
            'message_type::new_order_accepted_message': new_order_accepted_message
            'message_type::existing_order_executed_message': existing_order_executed_message
            'message_type::existing_order_canceled_message': existing_order_canceled_message
            'message_type::previous_execution_broken_message': previous_execution_broken_message
            'message_type::existing_order_replaced_message': existing_order_replaced_message
            'message_type::existing_order_cancelled_aiq_message': existing_order_cancelled_aiq_message
            'message_type::trade_correction_message': trade_correction_message
  sequenced_message_header:
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
      - id: order_token
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered, defined as user(4)+comma(1)+token(10)'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: replaced_token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered. Only used on a replaced message'
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
        size: 8
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
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_13
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
      - id: separator_14
        size: 1
        doc: 'Field separator'
      - id: reference_price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference price associated with the execution (may be 0 if not applicable)'
      - id: separator_15
        size: 1
        doc: 'Field separator'
      - id: reference_price_type
        type: u1
        enum: reference_price_type
        doc: 'The type of the reference price'
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
      - id: order_token
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered, defined as user(4)+comma(1)+token(10)'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: replaced_token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered. Only used on a replaced message'
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
        size: 8
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
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: match_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The match number assigned by Nasdaq to this trade. Each match consists of an execution between a buy order and a sell order'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_13
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
      - id: separator_14
        size: 1
        doc: 'Field separator'
      - id: reference_price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference price associated with the execution (may be 0 if not applicable)'
      - id: separator_15
        size: 1
        doc: 'Field separator'
      - id: reference_price_type
        type: u1
        enum: reference_price_type
        doc: 'The type of the reference price'
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
      - id: order_token
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered, defined as user(4)+comma(1)+token(10)'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: replaced_token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered. Only used on a replaced message'
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
        size: 8
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
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'For cancel messages, the cancel reason value'
      - id: separator_13
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
      - id: separator_14
        size: 1
        doc: 'Field separator'
      - id: reference_price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference price associated with the execution (may be 0 if not applicable)'
      - id: separator_15
        size: 1
        doc: 'Field separator'
      - id: reference_price_type
        type: u1
        enum: reference_price_type
        doc: 'The type of the reference price'
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
      - id: order_token
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered, defined as user(4)+comma(1)+token(10)'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: replaced_token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered. Only used on a replaced message'
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
        size: 8
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
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: match_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The match number assigned by Nasdaq to this trade. Each match consists of an execution between a buy order and a sell order'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_13
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
      - id: separator_14
        size: 1
        doc: 'Field separator'
      - id: reference_price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference price associated with the execution (may be 0 if not applicable)'
      - id: separator_15
        size: 1
        doc: 'Field separator'
      - id: reference_price_type
        type: u1
        enum: reference_price_type
        doc: 'The type of the reference price'
  existing_order_replaced_message:
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
      - id: order_token
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered, defined as user(4)+comma(1)+token(10)'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: replaced_token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered. Only used on a replaced message'
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
        size: 8
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
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_13
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
      - id: separator_14
        size: 1
        doc: 'Field separator'
      - id: reference_price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference price associated with the execution (may be 0 if not applicable)'
      - id: separator_15
        size: 1
        doc: 'Field separator'
      - id: reference_price_type
        type: u1
        enum: reference_price_type
        doc: 'The type of the reference price'
  existing_order_cancelled_aiq_message:
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
      - id: order_token
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered, defined as user(4)+comma(1)+token(10)'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: replaced_token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered. Only used on a replaced message'
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
        size: 8
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
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: time_in_force
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'On messages other than executions and breaks the Match field carries the order''s Time in Force (TIF)'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'For cancel messages, the cancel reason value'
      - id: separator_13
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
      - id: separator_14
        size: 1
        doc: 'Field separator'
      - id: reference_price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference price associated with the execution (may be 0 if not applicable)'
      - id: separator_15
        size: 1
        doc: 'Field separator'
      - id: reference_price_type
        type: u1
        enum: reference_price_type
        doc: 'The type of the reference price'
  trade_correction_message:
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
      - id: order_token
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered, defined as user(4)+comma(1)+token(10)'
      - id: separator_3
        size: 1
        doc: 'Field separator'
      - id: replaced_token
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The free form Token field as specified by the order entry firm when the order was entered. Only used on a replaced message'
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
        size: 8
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
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order unique reference number assigned by Nasdaq to this order'
      - id: separator_10
        size: 1
        doc: 'Field separator'
      - id: match_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The match number assigned by Nasdaq to this trade. Each match consists of an execution between a buy order and a sell order'
      - id: separator_11
        size: 1
        doc: 'Field separator'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'The capacity as specified by the order entry firm'
      - id: separator_12
        size: 1
        doc: 'Field separator'
      - id: liquidity_code
        type: u1
        enum: liquidity_code
        doc: 'For execution messages, the liquidity code value'
      - id: separator_13
        size: 1
        doc: 'Field separator'
      - id: clearing_code
        type: u1
        enum: clearing_code
        doc: 'The clearing path this trade will take'
      - id: separator_14
        size: 1
        doc: 'Field separator'
      - id: reference_price
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference price associated with the execution (may be 0 if not applicable)'
      - id: separator_15
        size: 1
        doc: 'Field separator'
      - id: reference_price_type
        type: u1
        enum: reference_price_type
        doc: 'The type of the reference price'

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SoupTcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupTcp Server Heartbeat Packet'
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
    0x55:
      id: 'existing_order_replaced_message'
      doc: 'Existing order replaced.'
    0x59:
      id: 'existing_order_cancelled_aiq_message'
      doc: 'Existing order cancelled (AIQ).'
    0x43:
      id: 'trade_correction_message'
      doc: 'Trade correction.'
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
  capacity:
    0x41:
      id: 'agency'
      doc: 'A Agency'
    0x50:
      id: 'principal'
      doc: 'P Principal'
    0x52:
      id: 'riskless'
      doc: 'R Riskless'
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
      id: 'opening_trade_on_nyse'
      doc: 'F Opening Trade On Nyse'
    0x47:
      id: 'on_close_order_on_nyse'
      doc: 'G On Close Order On Nyse'
    0x4f:
      id: 'opening_cross'
      doc: 'O Opening Cross'
    0x4d:
      id: 'opening_cross_imbalanceonly'
      doc: 'M Opening Cross Imbalanceonly'
    0x43:
      id: 'closing_cross'
      doc: 'C Closing Cross'
    0x4c:
      id: 'closing_cross_imbalanceonly'
      doc: 'L Closing Cross Imbalanceonly'
    0x48:
      id: 'halt_ipo_cross'
      doc: 'H Halt Ipo Cross'
    0x4b:
      id: 'halt_cross'
      doc: 'K Halt Cross'
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
    0x57:
      id: 'added_postonly_not_currently_available'
      doc: 'W Added Postonly Not Currently Available'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'M Removed Liquidity At A Midpoint'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'K Added Liquidity Via A Midpoint Order'
    0x30:
      id: 'supplemental_order_execution'
      doc: '0 Supplemental Order Execution'
    0x37:
      id: 'displayed_liquidityadding_order_improves_the_nbbo'
      doc: '7 Displayed Liquidityadding Order Improves The Nbbo'
    0x38:
      id: 'displayed_liquidityadding_order_sets_the_qbbo_while_joining_the_nbbo'
      doc: '8 Displayed Liquidityadding Order Sets The Qbbo While Joining The Nbbo'
    0x64:
      id: 'retail_designated_execution_that_removed_liquidity_not_currently_available'
      doc: 'D Retail Designated Execution That Removed Liquidity Not Currently Available'
    0x65:
      id: 'retail_designated_execution_that_added_displayed_liquidity'
      doc: 'E Retail Designated Execution That Added Displayed Liquidity'
    0x66:
      id: 'retail_designated_execution_that_added_nondisplayed_liquidity_not_currently_available'
      doc: 'F Retail Designated Execution That Added Nondisplayed Liquidity Not Currently Available'
    0x6a:
      id: 'rpi_order_that_provides_liquidity'
      doc: 'J Rpi Order That Provides Liquidity'
    0x72:
      id: 'retail_order_that_removes_rpi_liquidity'
      doc: 'R Retail Order That Removes Rpi Liquidity'
    0x74:
      id: 'retail_order_that_removes_price_improving_nondisplayed_liquidity_other_than_rpi_liquidity'
      doc: 'T Retail Order That Removes Price Improving Nondisplayed Liquidity Other Than Rpi Liquidity'
    0x34:
      id: 'added_displayed_liquidity_in_a_group_a_symbol'
      doc: '4 Added Displayed Liquidity In A Group A Symbol'
    0x35:
      id: 'added_nondisplayed_liquidity_in_a_group_a_symbol'
      doc: '5 Added Nondisplayed Liquidity In A Group A Symbol'
    0x36:
      id: 'liquidity_removing_order_in_a_group_a_symbol'
      doc: '6 Liquidity Removing Order In A Group A Symbol'
    0x67:
      id: 'added_nondisplayed_midpoint_liquidity_in_a_group_a_symbol'
      doc: 'G Added Nondisplayed Midpoint Liquidity In A Group A Symbol'
    0x61:
      id: 'added_displayed_liquidity_in_a_scip_symbol'
      doc: 'A Added Displayed Liquidity In A Scip Symbol'
    0x78:
      id: 'displayed_liquidityadding_order_improves_the_nbbo_in_a_scip_symbol'
      doc: 'X Displayed Liquidityadding Order Improves The Nbbo In A Scip Symbol'
    0x79:
      id: 'displayed_liquidityadding_order_set_the_qbbo_while_joining_the_nbbo_in_a_scip_symbol'
      doc: 'Y Displayed Liquidityadding Order Set The Qbbo While Joining The Nbbo In A Scip Symbol'
    0x62:
      id: 'displayed_liquidityadding_order_improves_the_nbbo_in_pilot_symbol_during_specified_luld_pricing_pilot_timeframe'
      doc: 'B Displayed Liquidityadding Order Improves The Nbbo In Pilot Symbol During Specified Luld Pricing Pilot Timeframe'
    0x63:
      id: 'added_displayed_liquidity_in_a_pilot_symbol_during_specified_luld_pricing_pilot_timeframe'
      doc: 'C Added Displayed Liquidity In A Pilot Symbol During Specified Luld Pricing Pilot Timeframe'
    0x68:
      id: 'removed_liquidity_in_a_pilot_symbol_during_specified_luld_pricing_pilot_timeframe'
      doc: 'H Removed Liquidity In A Pilot Symbol During Specified Luld Pricing Pilot Timeframe'
    0x4e:
      id: 'halt_cross_orders_entered_in_pilot_symbols_during_the_luld_trading_pause'
      doc: 'N Halt Cross Orders Entered In Pilot Symbols During The Luld Trading Pause'
  clearing_code:
    0x51:
      id: 'qsr'
      doc: 'Q Qsr'
  reference_price_type:
    0x20:
      id: 'not_applicable'
      doc: 'Blank Not Applicable'
    0x49:
      id: 'intraday_indicative_value'
      doc: 'I Intraday Indicative Value'
  cancel_reason:
    0x55:
      id: 'user_cancel'
      doc: 'U User Cancel'
    0x49:
      id: 'ioc_cancel'
      doc: 'I Ioc Cancel'
    0x54:
      id: 'timeout'
      doc: 'T Timeout'
    0x53:
      id: 'supervisory_cancel'
      doc: 'S Supervisory Cancel'
    0x44:
      id: 'regulatory_cancel'
      doc: 'D Regulatory Cancel'
    0x51:
      id: 'self_match_prevention'
      doc: 'Q Self Match Prevention'
    0x5a:
      id: 'system_cancel'
      doc: 'Z System Cancel'
    0x43:
      id: 'cross_cancel'
      doc: 'C Cross Cancel'
    0x48:
      id: 'halted'
      doc: 'Halted The Onopen Order Was Canceled Because The Symbol Remained Halted After The Opening Cross Completed'
    0x58:
      id: 'open_protection'
      doc: 'Open Protection Orders That Are Cancelled As A Result Of The Opening Price Protection Threshold'

