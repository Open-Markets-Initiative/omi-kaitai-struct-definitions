# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities LastSale AsciiItch v1.2.2013
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Last Sale
#   Encoding: Ascii Itch
#   Version: 1.2.2013
#   Date: 11/01/2013
#   Specification: NQLastSale-V1_1.pdf
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
  id: nasdaq_nsmequities_lastsale_asciiitch_v1_2_2013
  title: Nasdaq NsmEquities LastSale AsciiItch v1.2.2013
  license: GPL-3.0
  endian: le

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Last Sale AsciiItch v1.2.2013'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

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
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_body
        size: message_length + 2 - 2
        type:
          switch-on: message_length
          cases:
            _: message_data
  message_data:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: _parent.message_length - 9
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::trade_report_message': trade_report_message
            'message_type::trade_cancel_error_message': trade_cancel_error_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::adjusted_closing_price_message': adjusted_closing_price_message
  message_header:
    seq:
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
        doc: 'Denotes the NLS type of system event for which the message is being generated'
  trade_report_message:
    seq:
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the NASDAQ market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the NASDAQ-assigned issue symbol of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the source''s internal control number associated with the given trade transaction'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the report price on the trade transaction. Price format is $$$$$$dddd. Implied decimal with scale 1e-4'
      - id: trade_size
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the reported number of shares on the trade transaction'
      - id: sale_condition_modifier
        type: sale_condition_modifier
        doc: 'Sale Condition Modifier'
  sale_condition_modifier:
    seq:
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Sale Condition Modifier Level 1, used for Settlement Type information'
      - id: trade_through_exemption
        type: u1
        enum: trade_through_exemption
        doc: 'Sale Condition Modifier Level 2, used for SEC Regulation NMS Trade Through Exemption Codes'
      - id: extended_hours_or_sold_code
        type: u1
        enum: extended_hours_or_sold_code
        doc: 'Sale Condition Modifier Level 3, used for Extended Hours or Sold Codes'
      - id: special_sale_condition
        type: u1
        enum: special_sale_condition
        doc: 'Sale Condition Modifier Level 4, used for special sale condition codes'
  trade_cancel_error_message:
    seq:
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the NASDAQ market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the NASDAQ-assigned issue symbol of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: original_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the source''s internal control number associated with the given trade transaction'
      - id: original_trade_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reported price for the transaction. Price format is $$$$$$dddd. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reported number of shares for transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'Original Sale Condition Modifier'
  original_sale_condition_modifier:
    seq:
      - id: original_settlement_type
        type: u1
        enum: original_settlement_type
        doc: 'Sale Condition Modifier Level 1, used for Settlement Type information'
      - id: original_trade_through_exemption
        type: u1
        enum: original_trade_through_exemption
        doc: 'Sale Condition Modifier Level 2, used for SEC Regulation NMS Trade Through Exemption Codes'
      - id: original_extended_hours_or_sold_code
        type: u1
        enum: original_extended_hours_or_sold_code
        doc: 'Sale Condition Modifier Level 3, used for Extended Hours or Sold Codes'
      - id: original_special_sale_condition
        type: u1
        enum: original_special_sale_condition
        doc: 'Sale Condition Modifier Level 4, used for special sale condition codes'
  trade_correction_message:
    seq:
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the NASDAQ market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the NASDAQ-assigned issue symbol of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: original_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the source''s internal control number associated with the given trade transaction'
      - id: original_trade_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reported price for the transaction. Price format is $$$$$$dddd. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reported number of shares for transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'Original Sale Condition Modifier'
      - id: corrected_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the NASDAQ internal control number associated with the adjusted trade transaction'
      - id: corrected_trade_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the price for the corrected trade transaction. Price format is $$$$$$dddd. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the number of shares for the corrected trade transaction'
      - id: corrected_sale_condition_modifier
        type: corrected_sale_condition_modifier
        doc: 'Corrected Sale Condition Modifier'
  corrected_sale_condition_modifier:
    seq:
      - id: corrected_settlement_type
        type: u1
        enum: corrected_settlement_type
        doc: 'Sale Condition Modifier Level 1, used for Settlement Type information'
      - id: corrected_trade_through_exemption
        type: u1
        enum: corrected_trade_through_exemption
        doc: 'Sale Condition Modifier Level 2, used for SEC Regulation NMS Trade Through Exemption Codes'
      - id: corrected_extended_hours_or_sold_code
        type: u1
        enum: corrected_extended_hours_or_sold_code
        doc: 'Sale Condition Modifier Level 3, used for Extended Hours or Sold Codes'
      - id: corrected_special_sale_condition
        type: u1
        enum: corrected_special_sale_condition
        doc: 'Sale Condition Modifier Level 4, used for special sale condition codes'
  stock_trading_action_message:
    seq:
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the NASDAQ-assigned issue symbol of the security for which the trade report is being generated'
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
        doc: 'Reflects the Market Ops or MarketWatch code for the trading state change (Appendix C)'
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
  stock_directory_message:
    seq:
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the NASDAQ-assigned issue symbol of the security for which the trade report is being generated'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Denotes the listing market for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For NASDAQ-listed issues, this field indicates when a firm is not in compliance with NASDAQ continued listing requirements'
  adjusted_closing_price_message:
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
      - id: adjusted_closing_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The previous trading day''s official closing price adjusted for any applicable corporate actions. Implied decimal with scale 1e-4'
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
      doc: 'System Event Messages is used to signal key market or data feed control events.'
    0x54:
      id: 'trade_report_message'
      doc: 'The following message is used to relay NASDAQ execution system and TRF trade transactions that are reported for the current business day. Please note that NASDAQ only reports one-side of a trade execution on the NASDAQ Last Sale (NLS) feed and other data feed products.'
    0x58:
      id: 'trade_cancel_error_message'
      doc: 'The following message is used in the event that a NASDAQ or TRF trade transaction is cancelled on the same business day that it is reported.'
    0x43:
      id: 'trade_correction_message'
      doc: 'The following message is used in the event that a TRF trade transaction is corrected on the same business day that it is reported.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'NASDAQ uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Denotes the Reg SHO Short Sale Price Test Restriction (Rule 201) status for an issue: a full pre-opening spin for NASDAQ-listed issues and intraday status changes.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, NASDAQ disseminates stock directory messages for all active symbols in the NASDAQ system.'
    0x47:
      id: 'adjusted_closing_price_message'
      doc: 'At the start of each trading day, NASDAQ disseminates the adjusted closing price for all active symbols in the NASDAQ system.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes that the NLS system has started its daily transmission schedule.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This message indicates that NASDAQ is open and ready to start accepting orders.'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Denotes the start of the regular US market session.'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'Denotes the end of the regular US session.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Indicates that NASDAQ is now closed and will not accept any new orders today.'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes that the NLS system has ended its daily transmission schedule.'
  market_center_identifier:
    0x51:
      id: 'nasdaq'
      doc: 'NASDAQ execution system'
    0x4c:
      id: 'trf'
      doc: 'NASDAQ/FINRA Trade Reporting Facility (TRF)'
  security_class:
    0x51:
      id: 'nasdaq'
      doc: 'NASDAQ-Listed Issue'
    0x4e:
      id: 'nyse'
      doc: 'NYSE Listed Issue'
    0x41:
      id: 'nyse_mkt'
      doc: 'NYSE MKT-Listed Issue'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca-Listed Issue'
    0x5a:
      id: 'bats'
      doc: 'BATS-Listed Issue'
  settlement_type:
    0x40:
      id: 'regular_settlement'
      doc: 'Regular Settlement'
    0x43:
      id: 'cash_settlement'
      doc: 'Cash Settlement'
    0x4e:
      id: 'next_day_settlement'
      doc: 'Next Day Settlement'
    0x52:
      id: 'seller_settlement'
      doc: 'Seller Settlement'
  trade_through_exemption:
    0x46:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x4f:
      id: 'opening_print'
      doc: 'Opening Print'
    0x34:
      id: 'derivative_priced'
      doc: 'Derivative Priced'
    0x35:
      id: 're_opening_print'
      doc: 'Re-Opening Print'
    0x36:
      id: 'closing_print'
      doc: 'Closing Print'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  extended_hours_or_sold_code:
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_trade_reported_late_or_out_of_sequence'
      doc: 'Extended Hours Trade - Reported Late or Out of Sequence'
    0x4c:
      id: 'sold_last_reported_late_but_in_sequence'
      doc: 'Sold Last - Reported Late But In Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold - Out of Sequence'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  special_sale_condition:
    0x41:
      id: 'acquisition'
      doc: 'Acquisition'
    0x42:
      id: 'bunched'
      doc: 'Bunched'
    0x44:
      id: 'distribution'
      doc: 'Distribution'
    0x48:
      id: 'price_variation_transaction'
      doc: 'Price Variation Transaction'
    0x4d:
      id: 'official_close_price'
      doc: 'NASDAQ Official Close Price (NOCP)'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'official_opening_price'
      doc: 'NASDAQ Official Opening Price (NOOP)'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
    0x6f:
      id: 'odd_lot_execution'
      doc: 'Odd lot execution'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  original_settlement_type:
    0x40:
      id: 'regular_settlement'
      doc: 'Regular Settlement'
    0x43:
      id: 'cash_settlement'
      doc: 'Cash Settlement'
    0x4e:
      id: 'next_day_settlement'
      doc: 'Next Day Settlement'
    0x52:
      id: 'seller_settlement'
      doc: 'Seller Settlement'
  original_trade_through_exemption:
    0x46:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x4f:
      id: 'opening_print'
      doc: 'Opening Print'
    0x34:
      id: 'derivative_priced'
      doc: 'Derivative Priced'
    0x35:
      id: 're_opening_print'
      doc: 'Re-Opening Print'
    0x36:
      id: 'closing_print'
      doc: 'Closing Print'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  original_extended_hours_or_sold_code:
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_trade_reported_late_or_out_of_sequence'
      doc: 'Extended Hours Trade - Reported Late or Out of Sequence'
    0x4c:
      id: 'sold_last_reported_late_but_in_sequence'
      doc: 'Sold Last - Reported Late But In Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold - Out of Sequence'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  original_special_sale_condition:
    0x41:
      id: 'acquisition'
      doc: 'Acquisition'
    0x42:
      id: 'bunched'
      doc: 'Bunched'
    0x44:
      id: 'distribution'
      doc: 'Distribution'
    0x48:
      id: 'price_variation_transaction'
      doc: 'Price Variation Transaction'
    0x4d:
      id: 'official_close_price'
      doc: 'NASDAQ Official Close Price (NOCP)'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'official_opening_price'
      doc: 'NASDAQ Official Opening Price (NOOP)'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
    0x6f:
      id: 'odd_lot_execution'
      doc: 'Odd lot execution'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  corrected_settlement_type:
    0x40:
      id: 'regular_settlement'
      doc: 'Regular Settlement'
    0x43:
      id: 'cash_settlement'
      doc: 'Cash Settlement'
    0x4e:
      id: 'next_day_settlement'
      doc: 'Next Day Settlement'
    0x52:
      id: 'seller_settlement'
      doc: 'Seller Settlement'
  corrected_trade_through_exemption:
    0x46:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x4f:
      id: 'opening_print'
      doc: 'Opening Print'
    0x34:
      id: 'derivative_priced'
      doc: 'Derivative Priced'
    0x35:
      id: 're_opening_print'
      doc: 'Re-Opening Print'
    0x36:
      id: 'closing_print'
      doc: 'Closing Print'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  corrected_extended_hours_or_sold_code:
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_trade_reported_late_or_out_of_sequence'
      doc: 'Extended Hours Trade - Reported Late or Out of Sequence'
    0x4c:
      id: 'sold_last_reported_late_but_in_sequence'
      doc: 'Sold Last - Reported Late But In Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold - Out of Sequence'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  corrected_special_sale_condition:
    0x41:
      id: 'acquisition'
      doc: 'Acquisition'
    0x42:
      id: 'bunched'
      doc: 'Bunched'
    0x44:
      id: 'distribution'
      doc: 'Distribution'
    0x48:
      id: 'price_variation_transaction'
      doc: 'Price Variation Transaction'
    0x4d:
      id: 'official_close_price'
      doc: 'NASDAQ Official Close Price (NOCP)'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'official_opening_price'
      doc: 'NASDAQ Official Opening Price (NOOP)'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
    0x6f:
      id: 'odd_lot_execution'
      doc: 'Odd lot execution'
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
  current_trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted across all U.S. equity markets / SROs'
    0x50:
      id: 'paused'
      doc: 'Paused across all U.S. equity markets / SROs (NASDAQ-listed securities only)'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation only period for cross-SRO halt or pause'
    0x54:
      id: 'trading'
      doc: 'Trading on NASDAQ'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No price test in place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg SHO Short Sale Price Test Restriction in effect due to an intra-day price drop in security'
    0x32:
      id: 'restriction_remains'
      doc: 'Reg SHO Short Sale Price Test Restriction remains in effect'
  market_category:
    0x4e:
      id: 'nyse'
      doc: 'NYSE'
    0x41:
      id: 'nyse_mkt'
      doc: 'NYSE MKT'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'NASDAQ Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'NASDAQ Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'NASDAQ Capital Market'
    0x5a:
      id: 'bats'
      doc: 'BATS'
    0x20:
      id: 'not_available'
      doc: 'Not available'
  financial_status_indicator:
    0x4e:
      id: 'normal'
      doc: 'Normal (Default): Issuer Is NOT Deficient, Delinquent, or Bankrupt'
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
      doc: 'Deficient and Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient and Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent and Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient, Delinquent, and Bankrupt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x20:
      id: 'in_compliance_or_not_listed'
      doc: 'Company is in compliance with NASDAQ listing standards OR Issue is listed on NYSE, NYSE MKT, NYSE Arca, BATS or regional exchange (not NASDAQ)'

