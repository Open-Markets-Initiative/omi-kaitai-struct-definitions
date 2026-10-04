# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PsxEquities Bbo AsciiItch v1.1.2013.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Best Bid And Offer
#   Encoding: Ascii Itch
#   Version: 1.1.2013.2
#   Date: 03/11/2013
#   Specification: PSXbbo-v1_1.pdf
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
  id: nasdaq_psxequities_bbo_asciiitch_v1_1_2013_2
  title: Nasdaq PsxEquities Bbo AsciiItch v1.1.2013.2
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PSX Best Bid And Offer AsciiItch v1.1.2013.2'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=DPSpecs_USEquities

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
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
      - id: sequence_number
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
      - id: message_count
        type: u2le
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 9
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::quotation_message': quotation_message
  message_header:
    seq:
      - id: message_length
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
        doc: 'Denotes the type of event for which the message is being generated'
  stock_directory_message:
    seq:
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue for which the directory message is being generated'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Denotes the listing market for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For NASDAQ-listed issues, this field indicates when a firm is not in compliance with NASDAQ continued listing requirements'
  stock_trading_action_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the issue'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reflects the Market Ops or MarketWatch code for the trading state change'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg SHO Short Sale Price Test Restriction status for the issue at the time of the message dissemination'
  quotation_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: psx_best_bid_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the PSX best bid price, the highest price for market buy order(s) in the PSX system. Price format is $$$$$$dddd. Implied decimal with scale 1e-4'
      - id: psx_best_bid_size
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the aggregated number of shares available for display within the PSX market center system at the PSX best bid Price'
      - id: psx_best_offer_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the PSX exchange''s best offer price, the lowest price for market sell order(s) in the PSX system. Price format is $$$$$$dddd. Implied decimal with scale 1e-4'
      - id: psx_best_offer_size
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the aggregated number of shares available for display within the PSX market center system at the PSX Best Offer Price'
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
      doc: 'The System Event message is used to signal key market or data feed control events.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, NASDAQ PSX disseminates stock directory messages for all active symbols in its market center system.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'NASDAQ OMX uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Denotes the Reg SHO Short Sale Price Test Restriction (Rule 201) status for an issue: a full pre-opening spin for NASDAQ-listed issues and intraday status changes.'
    0x51:
      id: 'quotation_message'
      doc: 'PSX BBO will broadcast a real-time update every time that the exchange''s best bid and offer quote is updated during the trading day.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes That Psx Bbo Has Started Its Daily Transmission Schedule'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Psx Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Psx Is Now Closed And Will Not Accept Any New Orders Today'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes That Psx Bbo Has Completed Its Daily Transmission Schedule'
    0x41:
      id: 'emergency_market_condition_halt'
      doc: 'This Message Is Sent To Inform Psx Market Participants That The Emc Is In Effect No Trading Is Allowed During The Emc'
    0x52:
      id: 'emergency_market_condition_quote_only_period'
      doc: 'This Message Is Sent To Inform Psx Market Participants That The Emc Quotation Only Period Is In Effect'
    0x42:
      id: 'emergency_market_condition_resumption'
      doc: 'This Message Is Sent To Inform Psx Market Participants That Emc Is No Longer In Effect'
  market_category:
    0x4e:
      id: 'nyse'
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
    0x20:
      id: 'not_available'
      doc: 'Not Available'
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
      id: 'in_compliance_or_not_listed'
      doc: 'Company Is In Compliance If Nasda Qlisted Issue Or Issue Is Not Listed On Nasdaq'
  security_class:
    0x51:
      id: 'nasdaq_listed_issue'
      doc: 'Nasdaq Listed Issue'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x41:
      id: 'nyse_amex'
      doc: 'Nyse Amex'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x5a:
      id: 'bats'
      doc: 'Bats'
  current_trading_state:
    0x48:
      id: 'halted_or_paused_on_nasdaq_and_all_utp_participants'
      doc: 'Halted Paused On Nasdaq And All Utp Participants'
    0x51:
      id: 'quotation_only_period_for_cross_sro_halt_or_pause'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x52:
      id: 'quotation_only_period_for_nasdaq_omx_only_halt_or_pause'
      doc: 'Quotation Only Period For Nasdaq Omx Only Halt Or Pause'
    0x54:
      id: 'trading_on_nasdaq'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'restriction_remains_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'

