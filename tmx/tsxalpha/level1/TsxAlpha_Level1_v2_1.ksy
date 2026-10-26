# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx TsxAlpha Level1 Qrtmd v2.1
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Level 1
#   Encoding: Quantum Real Time Market Data
#   Version: 2.1
#   Date: 10/20/2020
#   Specification: QRTMD Alpha Level 1 (2.1).pdf
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
  id: tmx_tsxalpha_level1_qrtmd_v2_1
  title: Tmx TsxAlpha Level1 Qrtmd v2.1
  license: GPL-3.0
  endian: be

doc: 'TMX Group TSX Alpha Exchange Level 1 Qrtmd v2.1'
doc-ref: https://www.tmxwebstore.com/products/qrtmd

seq:
  - id: qrtmd_stx
    type: u1
    doc: 'Start of Qrtmd message'
  - id: message_header
    type: message_header_struct
    doc: 'Twenty two byte ascii header carried on every Qrtmd message'
  - id: message_body
    type:
      switch-on: message_header.message_type
      cases:
        '"A"': trade_message
        '"B"': symbol_status_message
        '"D"': stock_state_message
        '"E"': quote_message
        '"G"': general_message
        '"H"': trade_cancellation_message
        '"S"': market_state_message
        '"T"': trading_tier_status_message
        '"X"': trade_correction_message
  - id: qrtmd_etx
    type: u1
    doc: 'End of Qrtmd message'

types:
  message_header_struct:
    seq:
      - id: message_length
        type: str
        size: 4
        encoding: ASCII
        doc: 'Total length of header and message business content, excluding Stx and Etx'
      - id: sequence_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'Assigned at service broadcast from 000000001 to 999999999, blank on a heartbeat'
      - id: service_identifier
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Service code identifying the market data service carried on the feed'
      - id: retransmission_identifier
        type: u1
        enum: retransmission_identifier
        doc: 'Marks a normal transmission, and is always blank on a heartbeat'
      - id: continuation_identifier
        type: u1
        enum: continuation_identifier
        doc: 'Provides for fragmentation of a message exceeding the maximum transmission unit'
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique code assigned to each message type, specific to each market service'
      - id: exchange_identifier
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code assigned to the originating exchange'
  trade_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume of shares traded'
      - id: trade_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Price at which the transaction took place. Implied decimal with scale 1e-5'
      - id: buyer_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the buying broker'
      - id: seller_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the selling broker'
      - id: trade_time_stamp
        type: hhmmss_ascii_time
        doc: 'Time of trade'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Unique identifier per stock assigned to each trade'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Identifies the type of an intentional cross'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An indicator for bypass crosses, which can be printed outside of the Protected NBBO and are not subject to cross interference'
      - id: opening_trade
        type: u1
        enum: opening_trade
        doc: 'An indicator as to whether the trade occurred at the opening or was the first board lot trade of the day'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement terms associated with the order'
      - id: is_dark
        type: u1
        enum: is_dark
        doc: 'Indicates that one side of the trade is dark'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
  symbol_status_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: exchange_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the exchange from which the message originated'
      - id: cusip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing and settlement registration number'
      - id: board_lot
        type: str
        size: 9
        encoding: ASCII
        doc: 'Board lot volume'
      - id: currency
        type: str
        size: 1
        encoding: ASCII
        doc: 'The currency of a price'
      - id: face_value
        type: str
        size: 9
        encoding: ASCII
        doc: 'The face value of a debenture. Implied decimal with scale 1e-3'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The product type for a symbol'
      - id: symbol_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'The security or issue symbol''s complete company name'
      - id: stock_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'An indicator of stock group'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The state of the stock'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The market on which a security is listed'
      - id: min_po_qty
        type: str
        size: 9
        encoding: ASCII
        doc: 'The minimum volume required for Post Only orders'
      - id: test_symbol
        type: u1
        enum: test_symbol
        doc: 'Indicates the symbol is a test symbol'
  stock_state_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: comment
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text accompanying the state change'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The state of the stock'
      - id: opening_time
        type: hhmmss_ascii_time
        doc: 'The opening time for a stock'
  quote_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: bid_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid price for the equity. Implied decimal with scale 1e-3'
      - id: bid_size
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume on the bid side'
      - id: ask_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask price for the equity. Implied decimal with scale 1e-3'
      - id: ask_size
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume on the ask side'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
  general_message:
    seq:
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: bulletin_indicator
        type: u1
        enum: bulletin_indicator
        doc: 'Indicates the message is a bulletin'
      - id: message_text
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bulletin in textual format'
  trade_cancellation_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume of shares traded'
      - id: trade_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Price at which the transaction took place. Implied decimal with scale 1e-5'
      - id: buyer_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the buying broker'
      - id: seller_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the selling broker'
      - id: trade_time_stamp
        type: hhmmss_ascii_time
        doc: 'Time of trade'
      - id: original_trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trade number'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
  market_state_message:
    seq:
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: stock_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'An indicator of stock group'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'The indication of the current market state'
  trading_tier_status_message:
    seq:
      - id: exchange_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the exchange from which the message originated'
      - id: total_number_of_symbols
        type: str
        size: 5
        encoding: ASCII
        doc: 'The total number of stocks per trading tier and Exchange ID'
      - id: total_number_of_stock_groups
        type: str
        size: 3
        encoding: ASCII
        doc: 'Total number of stock groups per trading tier and exchange ID'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: trading_tier_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Trading Engine identifier'
  trade_correction_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume of shares traded'
      - id: trade_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Price at which the transaction took place. Implied decimal with scale 1e-5'
      - id: buyer_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the buying broker'
      - id: seller_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the selling broker'
      - id: trade_time_stamp
        type: hhmmss_ascii_time
        doc: 'Time of trade'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Unique identifier per stock assigned to each trade'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Identifies the type of an intentional cross'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An indicator for bypass crosses, which can be printed outside of the Protected NBBO and are not subject to cross interference'
      - id: opening_trade
        type: u1
        enum: opening_trade
        doc: 'An indicator as to whether the trade occurred at the opening or was the first board lot trade of the day'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement terms associated with the order'
      - id: original_trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trade number'
      - id: is_dark
        type: u1
        enum: is_dark
        doc: 'Indicates that one side of the trade is dark'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
  hhmmss_ascii_time:
    seq:
      - id: text
        type: str
        size: 6
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i

enums:
  retransmission_identifier:
    0x30:
      id: 'normal_transmission'
      doc: 'Used for normal transmission, and unchanged on a message sent for a recovery'
  continuation_identifier:
    0x30:
      id: 'stand_alone_message'
      doc: 'All of the message fits in one packet'
  cross_type:
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x56:
      id: 'volume_weighted_average_price'
      doc: 'Volume Weighted Average Price'
    0x20:
      id: 'default_field'
      doc: 'Trade was not a cross'
  bypass:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  opening_trade:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  settlement_terms:
    0x20:
      id: 'default_field'
      doc: 'Default'
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'non_net'
      doc: 'Non Net'
    0x4d:
      id: 'derivatives_related_contingent_equity_trade'
      doc: 'Derivatives Related Contingent Equity Trade'
    0x54:
      id: 'cash_today'
      doc: 'Cash Today'
    0x44:
      id: 'settlement_date'
      doc: 'There is a valid Settlement Date associated with the order'
  is_dark:
    0x4e:
      id: 'no_field'
      doc: 'Always set to N'
  product_type:
    0x42:
      id: 'debenture'
      doc: 'Debenture'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x4d:
      id: 'mutual_fund'
      doc: 'Mutual Fund'
    0x46:
      id: 'etf'
      doc: 'Etf'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'tsxv'
      doc: 'Tsxv'
  test_symbol:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  bulletin_indicator:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  market_state:
    0x50:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x46:
      id: 'extended_hours_close'
      doc: 'Extended Hours Close'
    0x4e:
      id: 'extended_hours_cxls'
      doc: 'Extended Hours Cxls'

