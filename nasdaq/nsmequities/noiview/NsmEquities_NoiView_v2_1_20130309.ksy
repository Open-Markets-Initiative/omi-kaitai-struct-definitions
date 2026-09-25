# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities NoiView Itch v2.1.20130309
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Net Order Imbalance View
#   Encoding: Itch
#   Version: 2.1.20130309
#   Date: 03/09/2013
#   Specification: NQNoiview-v2_1.pdf
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
  id: nasdaq_nsmequities_noiview_itch_v2_1_20130309
  title: Nasdaq NsmEquities NoiView Itch v2.1.20130309
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Net Order Imbalance View Itch v2.1.20130309'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=DPSpecs_USEquities

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of the multicast session the payload relates to'
      - id: sequence
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
      - id: count
        type: u2le
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.length - 9
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_restriction_message': reg_sho_restriction_message
            'message_type::noii_message': noii_message
            'message_type::cross_trade_message': cross_trade_message
  message_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of data message not including this field'
      - id: timestamp
        type: millisecond_ascii_timestamp
        doc: 'Milliseconds past midnight Eastern the message was generated. Milliseconds since Midnight epoch'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
  stock_directory_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ Single Book'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Indicates when a firm is not in compliance with NASDAQ continued listing requirements'
      - id: round_lot_size
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if NASDAQ system limits order entry for issue'
  stock_trading_action_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ Single Book'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Indicates the current trading state for the stock'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Action reason'
  reg_sho_restriction_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ Single Book'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue'
  noii_message:
    seq:
      - id: paired_shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the total number of shares that are eligible to be matched at the Current Reference Price'
      - id: imbalance_shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of shares not paired at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Indicates the market side of the imbalance'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ Single Book'
      - id: far_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'A hypothetical auction-clearing price for cross orders only. Implied decimal with scale 1e-4'
      - id: near_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'A hypothetical auction-clearing price for cross orders as well as continuous orders. Implied decimal with scale 1e-4'
      - id: current_reference_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates price at which the NOII shares are being calculated. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Denotes the type of NASDAQ cross for which the NOII message is being generated'
      - id: price_variation_indicator
        type: u1
        enum: price_variation_indicator
        doc: 'This field indicates the absolute value of the percentage of deviation of the Near Indicative Clearing Price to the nearest Current Reference Price'
  cross_trade_message:
    seq:
      - id: shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The number of shares matched in the NASDAQ Cross'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the NASDAQ Single Book'
      - id: cross_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The price at which the cross occurred. Implied decimal with scale 1e-4'
      - id: match_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The NASDAQ generated day-unique Match Number of this execution'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Denotes the type of NASDAQ cross for which the NOII message is being generated'
  millisecond_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      hour:
        value: text.to_i / 3600000 % 24
      minute:
        value: text.to_i / 60000 % 60
      second:
        value: text.to_i / 1000 % 60
      millisecond:
        value: text.to_i % 1000

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, NASDAQ disseminates stock directory messages for all active symbols in Single Book.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'NASDAQ uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_restriction_message'
      doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination.'
    0x49:
      id: 'noii_message'
      doc: 'NASDAQ disseminates NOII data at 5-second intervals in the minutes leading up to the NASDAQ Opening and Closing Crosses as well as the IPO/Halt Crosses.'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross Trade message indicates that NASDAQ has completed its cross process for a specific security.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'This Is Always The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x58:
      id: 'clear_noii_opening_cross_data'
      doc: 'This Message Signals That Firms May Clear Noii Cache For The Regular Opening Cross'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders'
    0x43:
      id: 'end_of_messages'
      doc: 'This Is Always The Last Message Sent In Any Trading Day'
  market_category:
    0x4e:
      id: 'new_york_stock_exchange_nyse'
      doc: 'New York Stock Exchange Nyse'
    0x41:
      id: 'nyse_amex'
      doc: 'Nyse Amex'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
    0x5a:
      id: 'bats_bzx_exchange'
      doc: 'Bats Bzx Exchange'
  financial_status_indicator:
    0x44:
      id: 'deficient'
      doc: 'Deficient'
    0x45:
      id: 'delinquent'
      doc: 'Delinquent'
    0x51:
      id: 'bankrupt'
      doc: 'Bankrupt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x47:
      id: 'deficient_and_bankrupt'
      doc: 'Deficient And Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient And Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent And Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient Delinquent And Bankrupt'
    0x20:
      id: 'company_is_in_compliance'
      doc: 'Company Is In Compliance If Nasda Qlisted Issue'
  round_lots_only:
    0x59:
      id: 'only_round_lots_are_accepted_in_this_stock'
      doc: 'Only Round Lots Are Accepted In This Stock'
    0x4e:
      id: 'oddmixed_lots_are_allowed'
      doc: 'Oddmixed Lots Are Allowed'
  current_trading_state:
    0x48:
      id: 'halted_or_paused_across_all_us_equity_markets_sr_os'
      doc: 'Halted Or Paused Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused_across_all_us_equity_markets_sr_os'
      doc: 'Paused Across All Us Equity Markets Sr Os'
    0x51:
      id: 'quotation_only_period_for_cross_sro_halt_or_pause'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading_on_nasdaq'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction_in_effect_due_to_an_intraday_price_drop_in_security'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'reg_sho_short_sale_price_test_restriction_remains_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders_to_calculate'
      doc: 'Insufficient Orders To Calculate'
  cross_type:
    0x4f:
      id: 'open_cross'
      doc: 'Open Cross'
    0x43:
      id: 'close_cross'
      doc: 'Close Cross'
    0x48:
      id: 'intraday_opening_cross_for_ipo_and_halted_paused_securities'
      doc: 'Intraday Opening Cross For Ipo And Halted Paused Securities'
  price_variation_indicator:
    0x4c:
      id: 'less_than_1'
      doc: 'Less Than 1%'
    0x31:
      id: 'one_to_one_point_nine_nine_percent'
      doc: '1 To 1.99%'
    0x32:
      id: 'two_to_two_point_nine_nine_percent'
      doc: '2 To 2.99%'
    0x33:
      id: 'three_to_three_point_nine_nine_percent'
      doc: '3 To 3.99%'
    0x34:
      id: 'four_to_four_point_nine_nine_percent'
      doc: '4 To 4.99%'
    0x35:
      id: 'five_to_five_point_nine_nine_percent'
      doc: '5 To 5.99%'
    0x36:
      id: 'six_to_six_point_nine_nine_percent'
      doc: '6 To 6.99%'
    0x37:
      id: 'seven_to_seven_point_nine_nine_percent'
      doc: '7 To 7.99%'
    0x38:
      id: 'eight_to_eight_point_nine_nine_percent'
      doc: '8 To 8.99%'
    0x39:
      id: 'nine_to_nine_point_nine_nine_percent'
      doc: '9 To 9.99%'
    0x41:
      id: 'ten_to_nineteen_point_nine_nine_percent'
      doc: '10 To 19.99%'
    0x42:
      id: 'twenty_to_twenty_nine_point_nine_nine_percent'
      doc: '20 To 29.99%'
    0x43:
      id: 'thirty_percent_or_greater'
      doc: '30% Or Greater'
    0x20:
      id: 'cannot_be_calculated'
      doc: 'Cannot Be Calculated'

