# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PsxEquities LastSale Itch v2.1.2026
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Last Sale
#   Encoding: Itch
#   Version: 2.1.2026
#   Date: 02/13/2026
#   Specification: PLSSpecification2.1.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: psxequities_lastsale_v2_1_2026
  title: Nasdaq PsxEquities LastSale Itch v2.1.2026
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PSX Last Sale Itch v2.1.2026'
doc-ref: http://www.nasdaqtrader.com/content/technicalsupport/specifications/dataproducts/PLSSpecification2.1.pdf

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
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
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::trade_report_message': trade_report_message
            'message_type::next_shares_trade_report_message': next_shares_trade_report_message
            'message_type::trade_cancel_error_message': trade_cancel_error_message
            'message_type::trade_cancel_error_for_next_shares_message': trade_cancel_error_for_next_shares_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::trade_correction_for_next_shares_message': trade_correction_for_next_shares_message
            'message_type::trading_action_message': trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_breach_message': mwcb_breach_message
            'message_type::operational_halt_message': operational_halt_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System Event Codes'
  trade_report_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the PSX market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX system internal control number associated with the given trade transaction'
      - id: trade_price
        type: decimal_u4_4
        doc: 'Denotes the report price on the trade transaction. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the trade transaction'
      - id: sale_condition_modifier_level_1
        type: u1
        enum: sale_condition_modifier_level_1
        doc: 'Sale Condition Modifier Level 1 value'
      - id: sale_condition_modifier_level_2
        type: u1
        enum: sale_condition_modifier_level_2
        doc: 'Sale Condition Modifier Level 2 value'
      - id: sale_condition_modifier_level_3
        type: u1
        enum: sale_condition_modifier_level_3
        doc: 'Sale Condition Modifier Level 3 value'
      - id: sale_condition_modifier_level_4
        type: u1
        enum: sale_condition_modifier_level_4
        doc: 'Sale Condition Modifier Level 4 value'
  next_shares_trade_report_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the PSX market system that generated the trade report message'
      - id: next_shares_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the symbol of the NextShares for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX system internal control number associated with the given trade transaction'
      - id: proxy_price
        type: decimal_u4_4
        doc: 'Denotes the proxy price on the NextShares trade transaction. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the trade transaction'
      - id: nav_premium_discount_amount
        type: decimal_u4_4
        doc: 'The NAV premium or discount that should be applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: sale_condition_modifier_level_1
        type: u1
        enum: sale_condition_modifier_level_1
        doc: 'Sale Condition Modifier Level 1 value'
      - id: sale_condition_modifier_level_2
        type: u1
        enum: sale_condition_modifier_level_2
        doc: 'Sale Condition Modifier Level 2 value'
      - id: sale_condition_modifier_level_3
        type: u1
        enum: sale_condition_modifier_level_3
        doc: 'Sale Condition Modifier Level 3 value'
      - id: sale_condition_modifier_level_4
        type: u1
        enum: sale_condition_modifier_level_4
        doc: 'Sale Condition Modifier Level 4 value'
  trade_cancel_error_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the PSX market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: original_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX system internal control number associated with the given trade transaction'
      - id: original_trade_price
        type: decimal_u4_4
        doc: 'Reported price for the transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'Reported number of shares for transaction'
      - id: original_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the sale condition modifiers as reported on the original trade transaction'
  trade_cancel_error_for_next_shares_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the PSX market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: original_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX system internal control number associated with the given trade transaction'
      - id: original_trade_price
        type: decimal_u4_4
        doc: 'Reported price for the transaction. Implied decimal with scale 1e-4'
      - id: original_nav_premium_discount_amount
        type: decimal_u4_4
        doc: 'Original NAV premium or discount originally applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'Reported number of shares for transaction'
      - id: original_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the sale condition modifiers as reported on the original trade transaction'
  trade_correction_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the PSX market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: original_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX system internal control number associated with the given trade transaction'
      - id: original_trade_price
        type: decimal_u4_4
        doc: 'Reported price for the transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'Reported number of shares for transaction'
      - id: original_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the sale condition modifiers as reported on the original trade transaction'
      - id: corrected_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX internal control number associated with the adjusted trade transaction'
      - id: corrected_trade_price
        type: decimal_u4_4
        doc: 'Indicates the price for the corrected trade transaction. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: u4
        doc: 'Indicates the number of shares for the corrected trade transaction'
      - id: corrected_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the sale condition modifiers associated with the corrected trade transaction'
  trade_correction_for_next_shares_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: market_center_identifier
        type: u1
        enum: market_center_identifier
        doc: 'Denotes the PSX market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: original_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX system internal control number associated with the given trade transaction'
      - id: original_trade_price
        type: decimal_u4_4
        doc: 'Reported price for the transaction. Implied decimal with scale 1e-4'
      - id: original_nav_premium_discount_amount
        type: decimal_u4_4
        doc: 'Original NAV premium or discount originally applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'Reported number of shares for transaction'
      - id: original_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the sale condition modifiers as reported on the original trade transaction'
      - id: corrected_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the PSX internal control number associated with the adjusted trade transaction'
      - id: corrected_trade_price
        type: decimal_u4_4
        doc: 'Indicates the price for the corrected trade transaction. Implied decimal with scale 1e-4'
      - id: corrected_nav_premium_discount_amount
        type: decimal_u4_4
        doc: 'Indicates the corrected NAV premium or discount originally applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: u4
        doc: 'Indicates the number of shares for the corrected trade transaction'
      - id: corrected_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the sale condition modifiers associated with the corrected trade transaction'
  trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the issue'
      - id: trading_action_reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reflects the Market Ops or Market Watch code for the trading state change'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
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
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates Listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For Nasdaq-listed issues, this field indicates when a firm is not in compliance with Nasdaq continued listing requirements'
      - id: round_lot_size
        type: u4
        doc: 'Denotes the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if Nasdaq system limits order entry for issue'
      - id: issue_classification
        type: u1
        enum: issue_classification
        doc: 'Identifies the security class for the issue as assigned by Nasdaq'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub-type for the issue as assigned by Nasdaq'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Denotes if an issue or quoting participant record is set-up in Nasdaq systems in a live/production, test, or demo state. Please note that firms should only show live issues and quoting participants on public quotation displays'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the Nasdaq security is set up for IPO release. This field is intended to help Nasdaq market participant firms comply with FINRA Rule 5131(b)'
      - id: luld_reference_price_tier
        type: u1
        enum: luld_reference_price_tier
        doc: 'Indicates which Limit Up / Limit Down price band calculation parameter is to be used for the instrument'
      - id: etp_flag
        type: u1
        enum: etp_flag
        doc: 'Indicates whether the security is an exchange traded product (ETP)'
      - id: etp_leverage_factor
        type: u4
        doc: 'Tracks the integral relationship of the ETP to the underlying index'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index'
  mwcb_decline_level_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: level_1
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 1 Value. Implied decimal with scale 1e-8'
      - id: level_2
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 2 Value. Implied decimal with scale 1e-8'
      - id: level_3
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 3 Value. Implied decimal with scale 1e-8'
  mwcb_breach_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  operational_halt_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds past midnight (US Eastern Time). Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'Market code'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Indicates the price of the Upper Auction Collar Threshold'
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages is used to signal key market or data feed control events.'
    0x54:
      id: 'trade_report_message'
      doc: 'The following message is used to relay PSX execution system transactions that are reported for the current business day. Please note that PSX only reports one-side of a trade execution on the PSX Last Sale (PLS) feed and other data feed products.'
    0x4d:
      id: 'next_shares_trade_report_message'
      doc: 'The following message is used to relay PSX execution system and TRF trade transactions for Exchange Traded Managed Funds (NextShares) that are reported for the current business day.'
    0x58:
      id: 'trade_cancel_error_message'
      doc: 'The following message is used in the event that a PSX trade transaction is cancelled on the same business day that it is reported'
    0x4f:
      id: 'trade_cancel_error_for_next_shares_message'
      doc: 'The following message is used in the event that a Nasdaq or TRF trade transaction for an NextShares is cancelled on the same business day that it is reported.'
    0x43:
      id: 'trade_correction_message'
      doc: 'The following message is used in the event that a TRF trade transaction is corrected on the same business day that it is reported.'
    0x5a:
      id: 'trade_correction_for_next_shares_message'
      doc: 'The following message is used in the event that a TRF trade transaction for a NextShares is corrected on the same business day that it is reported.'
    0x48:
      id: 'trading_action_message'
      doc: 'PSX uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'For Nasdaq-listed issues, Nasdaq supports a full pre-opening spin of Reg SHO Short Sale Price Test Restricted Indicator messages indicating the Rule 201 status for all active issues. Nasdaq also sends the Reg SHO Short Sale Price Test Restricted Indicator message in the event of an intraday status change. For other exchange-listed issues, Nasdaq relays the Reg SHO Short Sale Price Test Restricted Indicator message when it receives an update from the primary listing exchange.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, PSX disseminates stock directory messages for all active symbols in the PSX system'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_breach_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels'
    0x68:
      id: 'operational_halt_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of the three market centers operated by Nasdaq.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes That The Psx Last Sale Has Started Its Daily Transmission Schedule'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Denotes The Start Of Regular Us Market Session'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'Denotes The End Of The Regular Us Session'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders Today'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes That The Psx Last Sale Has Ended Its Daily Transmission Schedule'
  market_center_identifier:
    0x42:
      id: 'psx_execution_system'
      doc: 'Psx Execution System'
    0x58:
      id: 'psx_execution_system_x58'
      doc: 'Psx Execution System'
  security_class:
    0x51:
      id: 'nasdaq'
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
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
  sale_condition_modifier_level_1:
    0x4a:
      id: 'proxy_price_settlement'
      doc: 'Proxy Price Settlement'
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
  sale_condition_modifier_level_2:
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
      doc: 'Re Opening Print'
    0x36:
      id: 'closing_print'
      doc: 'Closing Print'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  sale_condition_modifier_level_3:
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'reported_late_or_out_of_sequence'
      doc: 'Extended Hours Trade Reported Late Or Out Of Sequence'
    0x4c:
      id: 'reported_late_but_in_sequence'
      doc: 'Sold Last Reported Late But In Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold Out Of Sequence'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  sale_condition_modifier_level_4:
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
      id: 'psx_official_close_price'
      doc: 'Psx Official Close Price For Ps Xlisted Securities Only'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'psx_official_opening_price'
      doc: 'Psx Official Opening Price For Ps Xlisted Securities Only'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x57:
      id: 'weighted_average_price'
      doc: 'Weighted Average Price'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade For Ps Xlisted Securities Only'
    0x6f:
      id: 'odd_lot_execution'
      doc: 'Odd Lot Execution'
    0x78:
      id: 'odd_lot_cross_execution'
      doc: 'Odd Lot Cross Execution'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  current_trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Or Paused On Across All Us Equity Markets'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation Only Period For Crossmarket Halt Or Pause'
    0x54:
      id: 'trading'
      doc: 'Trading On Psx'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No Price Test In Place'
    0x31:
      id: 'reg_sho_short_sale_price_test_restriction'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'test_restriction_remains'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
  market_category:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange Nyse'
    0x41:
      id: 'nyse_mkt'
      doc: 'Nyse Mkt'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x5a:
      id: 'bats_z'
      doc: 'Bats Z Exchange'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange Llc'
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
    0x43:
      id: 'creations_and_redemptions_suspended'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'na'
      doc: 'Not Available Firms Should Refer To Siac Feeds For Code If Needed'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Nasdaq System Only Accepts Round Lots Orders For This Security'
    0x4e:
      id: 'no_restriction'
      doc: 'Nasdaq System Does Not Have Any Order Size Restrictions For This Security Odd And Mixed Lot Orders Are Allowed'
  issue_classification:
    0x41:
      id: 'american_depositary_share'
      doc: 'American Depositary Share'
    0x42:
      id: 'bond'
      doc: 'Bond'
    0x43:
      id: 'common'
      doc: 'Common Stock'
    0x46:
      id: 'depository'
      doc: 'Depository Receipt'
    0x49:
      id: 'value_x49'
      doc: '144 A'
    0x4c:
      id: 'limited'
      doc: 'Limited Partnership'
    0x4e:
      id: 'notes'
      doc: 'Notes'
    0x4f:
      id: 'ordinary_share'
      doc: 'Ordinary Share'
    0x50:
      id: 'preferred'
      doc: 'Preferred Stock'
    0x51:
      id: 'other'
      doc: 'Other Securities'
    0x52:
      id: 'right'
      doc: 'Right'
    0x53:
      id: 'shares'
      doc: 'Shares Of Beneficial Interest'
    0x54:
      id: 'convertible'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_benif_int'
      doc: 'Units Benif Int'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  authenticity:
    0x50:
      id: 'live_production'
      doc: 'Live Production'
    0x54:
      id: 'test'
      doc: 'Test'
  short_sale_threshold_indicator:
    0x59:
      id: 'restricted'
      doc: 'Issue Is Restricted Under Sec Rule 203 B 3'
    0x4e:
      id: 'not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'na'
      doc: 'Threshold Indicator Not Available'
  ipo_flag:
    0x59:
      id: 'nasdaq_listed_instrument'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'nasdaq_listed_instrument_x4e'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x20:
      id: 'na'
      doc: 'Not Available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1'
      doc: 'Tier 1 Nms Stocks And Select Et Ps'
    0x32:
      id: 'tier_2'
      doc: 'Tier 2 Nms Stocks'
    0x20:
      id: 'na'
      doc: 'Not Available'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Instrument Is An Etp'
    0x4e:
      id: 'not_etp'
      doc: 'Instrument Is Not An Etp'
    0x20:
      id: 'na'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'Etp Is Not An Inverse Etp'
  breached_level:
    0x31:
      id: 'level_1'
      doc: 'Level 1'
    0x32:
      id: 'level_2'
      doc: 'Level 2'
    0x33:
      id: 'level_3'
      doc: 'Level 3'
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'bx'
      doc: 'Bx'
    0x58:
      id: 'psx'
      doc: 'Psx'
  operational_halt_action:
    0x48:
      id: 'halted'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'resumed'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'

