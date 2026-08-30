# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities NlsPlus Itch v4.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Last Sale Plus
#   Encoding: Itch
#   Version: 4.0
#   Date: 2/19/2026
#   Specification: NLS4.0_02132026.pdf
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
  id: nasdaq_nsmequities_nlsplus_itch_v4_0
  title: Nasdaq NsmEquities NlsPlus Itch v4.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Last Sale Plus Itch v4.0'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

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
            'message_type::trade_cancel_error_message': trade_cancel_error_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::adjusted_closing_price_message': adjusted_closing_price_message
            'message_type::end_of_day_trade_summary_message': end_of_day_trade_summary_message
            'message_type::ipo_information_message': ipo_information_message
            'message_type::mwcb_decline_level_message': mwcb_decline_level_message
            'message_type::mwcb_status_message': mwcb_status_message
            'message_type::ipo_quoting_period_update_message': ipo_quoting_period_update_message
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
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
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
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: client_timestamp
        type: nanosecond_timestamp
        doc: 'TRF Reported timestamp. Set to 0 for non-TRF trades. Nanoseconds since Midnight epoch'
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
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
        type: decimal_u8_4
        doc: 'Denotes the report price on the trade transaction. Implied decimal with scale 1e-4'
      - id: trade_size
        type: decimal_u8_6
        doc: 'Indicates the reported number of shares on the trade transaction. Implied decimal with scale 1e-6'
      - id: sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the settlement type of the transaction'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time that the trade message was generated. Implied decimal with scale 1e-6'
  trade_cancel_error_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: client_timestamp
        type: nanosecond_timestamp
        doc: 'TRF Reported timestamp. Set to 0 for non-TRF trades. Nanoseconds since Midnight epoch'
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
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
        type: decimal_u8_4
        doc: 'Reported price for the transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: decimal_u8_6
        doc: 'Reported number of shares for transaction. Implied decimal with scale 1e-6'
      - id: original_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines the sale condition modifiers as reported on the original trade transaction'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time that the trade message was generated. Implied decimal with scale 1e-6'
  trade_correction_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: client_timestamp
        type: nanosecond_timestamp
        doc: 'TRF Reported timestamp. Set to 0 for non-TRF trades. Nanoseconds since Midnight epoch'
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq market system that generated the trade report message'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
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
        type: decimal_u8_4
        doc: 'Reported price for the transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: decimal_u8_6
        doc: 'Reported number of shares for transaction. Implied decimal with scale 1e-6'
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
        doc: 'Indicates the Nasdaq internal control number associated with the adjusted trade transaction'
      - id: corrected_trade_price
        type: decimal_u8_4
        doc: 'Indicates the price for the corrected trade transaction. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: decimal_u8_6
        doc: 'Indicates the number of shares for the corrected trade transaction. Implied decimal with scale 1e-6'
      - id: corrected_sale_condition_modifier
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the sale condition modifiers associated with the corrected trade transaction'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time that the trade message was generated. Implied decimal with scale 1e-6'
  stock_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
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
        doc: 'Reflects the Market Ops or Market Watch code for the trading state change'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
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
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Indicates when a firm is not in compliance with Nasdaq continued listing requirements'
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
        doc: 'Denotes if an issue or quoting participant record is set-up in Nasdaq systems in a live/production, test, or demo state'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under SEC Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the Nasdaq security is set up for IPO release'
      - id: luld_reference_price_tier
        type: u1
        enum: luld_reference_price_tier
        doc: 'Indicates which Limit Up / Limit Down price band calculation parameter is to be used for the instrument'
      - id: etp_flag
        type: u1
        enum: etp_flag
        doc: 'Indicates whether the security is an exchange traded product'
      - id: etp_leverage_factor
        type: u4
        doc: 'Tracks the integral relationship of the ETP to the underlying index'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the ETP and underlying index'
      - id: bloomberg_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The composite ID that Bloomberg has assigned to the security'
  adjusted_closing_price_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: adjusted_closing_price
        type: decimal_u8_4
        doc: 'The previous trading day''s official closing price adjusted for any applicable corporate actions. Implied decimal with scale 1e-4'
  end_of_day_trade_summary_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: consolidated_high_price
        type: decimal_u8_4
        doc: 'The highest price of any high/low eligible transaction on Tapes A, B or C received on the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_low_price
        type: decimal_u8_4
        doc: 'The lowest price of any high/low eligible transaction on Tapes A, B or C received on the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_closing_price
        type: decimal_u8_4
        doc: 'The final last sale eligible transaction on Tapes A, B or C received on the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time that the trade message was generated. Implied decimal with scale 1e-6'
      - id: consolidated_open_price
        type: decimal_u8_4
        doc: 'The first last sale eligible transactions received on the trading day for Tapes A, B or C. Implied decimal with scale 1e-4'
  ipo_information_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: reference_for_net_change
        type: u1
        enum: reference_for_net_change
        doc: 'Reflects the current trading state for the issue'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Reference Price. Implied decimal with scale 1e-4'
  mwcb_decline_level_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: level_1
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 1 Value. Implied decimal with scale 1e-8'
      - id: level_2
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 2 Value. Implied decimal with scale 1e-8'
      - id: level_3
        type: decimal_u8_8
        doc: 'Denotes the MWCB Level 3 Value. Implied decimal with scale 1e-8'
  mwcb_status_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the MWCB Level that was breached'
  ipo_quoting_period_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: ipo_quotation_release_time
        type: u4
        doc: 'Denotes the IPO release time, in seconds since midnight, for quotation to the nearest second'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'IPO Quotation Release Qualifier'
      - id: ipo_price
        type: decimal_u8_4
        doc: 'Denotes the IPO price to be used for intraday net change calculations. Implied decimal with scale 1e-4'
  operational_halt_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Nasdaq internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Midnight epoch'
      - id: stock_alpha_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in Nasdaq execution system'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'Market Code'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Indicates the operational halt action for the security'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
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
    0x65:
      id: 'trade_report_message'
      doc: 'The following message is used to relay trade transactions that are reported for the current business day. Please note that Nasdaq only reports one-side of a trade execution on the Last Sale feeds.'
    0x6f:
      id: 'trade_cancel_error_message'
      doc: 'The following message is used in the event that a transaction is cancelled on the same business day that it is reported.'
    0x62:
      id: 'trade_correction_message'
      doc: 'The following message is used in the event that a trade transaction is corrected on the same business day that it is reported.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of a security to the trading community.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Nasdaq processes orders based on the most Reg SHO Restriction status value.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates stock directory messages for all active Nasdaq and non Nasdaq listed security symbols.'
    0x67:
      id: 'adjusted_closing_price_message'
      doc: 'At the start of each trading day, Nasdaq disseminates the adjusted closing price for all active symbols in the Nasdaq system.'
    0x70:
      id: 'end_of_day_trade_summary_message'
      doc: 'At the close of each trading day, Nasdaq will disseminate end of day trade summary messages for all active Nasdaq- and non-Nasdaq-listed securities.'
    0x69:
      id: 'ipo_information_message'
      doc: 'Nasdaq will disseminate IPO messages from the UTP feeds for Initial Public Offerings for all Nasdaq-listed securities.'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs data recipients what the daily MWCB breach points are set to for the current trading day.'
    0x57:
      id: 'mwcb_status_message'
      doc: 'Informs data recipients when a MWCB has breached one of the established levels.'
    0x6b:
      id: 'ipo_quoting_period_update_message'
      doc: 'Indicates the anticipated IPO quotation release time of a security.'
    0x68:
      id: 'operational_halt_message'
      doc: 'An Operational Halt means that there has been an interruption of service on the identified security impacting only the designated Market Center.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes That The System Has Started Its Daily Transmission Schedule'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Denotes The Start Of The Regular Us Market Session'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'Denotes The End Of The Regular Us Session'
    0x45:
      id: 'end_of_system_hours'
      doc: 'Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders Today'
    0x43:
      id: 'end_of_transmissions'
      doc: 'Denotes That The System Has Ended Its Daily Transmission Schedule'
  originating_market_center_identifier:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq Execution System'
    0x4c:
      id: 'trf_carteret'
      doc: 'Nasdaq Finra Trade Reporting Facility Trf Carteret'
    0x32:
      id: 'trf_chicago'
      doc: 'Nasdaq Finra Trade Reporting Facility Trf Chicago'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x58:
      id: 'psx'
      doc: 'Nasdaq Psx'
  security_class:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x5a:
      id: 'bats'
      doc: 'Bats'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange Llc'
  current_trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted Across All Us Equity Markets Sr Os'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets Sr Os Nasdaqlisted Securities Only'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation Only Period For Cross Sro Halt Or Pause'
    0x54:
      id: 'trading'
      doc: 'Trading On Nasdaq'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No Price Test In Place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In Security'
    0x32:
      id: 'restriction_remains'
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
      id: 'nyse_american'
      doc: 'Nyse American'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x5a:
      id: 'bats_z'
      doc: 'Bats Z Exchange'
    0x56:
      id: 'iex'
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
      id: 'creations_redemptions_suspended'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Normal Default Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Not Available Firms Should Refer To Siac Feeds For Code If Needed'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Nasdaq System Only Accepts Round Lots Orders For This Security'
    0x4e:
      id: 'no_restrictions'
      doc: 'Nasdaq System Does Not Have Any Order Size Restrictions For This Security Odd And Mixed Lot Orders Are Allowed'
  issue_classification:
    0x41:
      id: 'ads'
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
      id: 'sec_144_a'
      doc: 'Sec 144 A'
    0x4c:
      id: 'limited'
      doc: 'Limited Partnership'
    0x4e:
      id: 'notes'
      doc: 'Notes'
    0x4f:
      id: 'ordinary'
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
      id: 'units_bi'
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
      id: 'not_available'
      doc: 'Threshold Indicator Not Available'
  ipo_flag:
    0x59:
      id: 'yes_field'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'no_field'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x5a:
      id: 'non_ipo_new_listed'
      doc: 'Nasdaq Listed Instrument Is A Non Ipo New Listed Security'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1'
      doc: 'Tier 1 Nms Stocks And Select Et Ps'
    0x32:
      id: 'tier_2'
      doc: 'Tier 2 Nms Stocks'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  etp_flag:
    0x59:
      id: 'etp'
      doc: 'Instrument Is An Etp'
    0x4e:
      id: 'not_etp'
      doc: 'Instrument Is Not An Etp'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  inverse_indicator:
    0x59:
      id: 'inverse_etp'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse_etp'
      doc: 'Etp Is Not An Inverse Etp'
  reference_for_net_change:
    0x46:
      id: 'first_trade_price'
      doc: 'First Trade Price'
    0x57:
      id: 'underwriter_price'
      doc: 'Underwriter Price'
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
  ipo_quotation_release_qualifier:
    0x41:
      id: 'anticipated'
      doc: 'Anticipated Quotation Release Time'
    0x43:
      id: 'canceled_postponed'
      doc: 'Ipo Release Canceledpostponed'
  market_code:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x58:
      id: 'psx'
      doc: 'Psx'
  operational_halt_action:
    0x48:
      id: 'operationally_halted'
      doc: 'Operationally Halted On The Identified Market'
    0x54:
      id: 'operational_halt_lifted'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'

