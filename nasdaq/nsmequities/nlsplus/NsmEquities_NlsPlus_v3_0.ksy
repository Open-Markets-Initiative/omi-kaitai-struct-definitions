# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities NlsPlus Itch v3.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Last Sale Plus
#   Encoding: Itch
#   Version: 3.0
#   Date: 5/6/2025
#   Specification: NLSPlusSpecification3.0.pdf
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
  id: nasdaq_nsmequities_nlsplus_itch_v3_0
  title: Nasdaq NsmEquities NlsPlus Itch v3.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Last Sale Plus Itch v3.0'
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
      - id: payload
        size: message_header.message_length - 9
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::trade_report_message': trade_report_message
            'message_type::long_form_trade_report_message': long_form_trade_report_message
            'message_type::next_shares_trade_report_message': next_shares_trade_report_message
            'message_type::trade_cancel_error_message': trade_cancel_error_message
            'message_type::long_form_trade_cancel_error_message': long_form_trade_cancel_error_message
            'message_type::next_shares_trade_cancel_error_message': next_shares_trade_cancel_error_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::long_form_trade_correction_message': long_form_trade_correction_message
            'message_type::next_shares_trade_correction_message': next_shares_trade_correction_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::reg_sho_short_sale_price_test_restricted_indicator_message': reg_sho_short_sale_price_test_restricted_indicator_message
            'message_type::adjusted_closing_price_message': adjusted_closing_price_message
            'message_type::long_form_adjusted_closing_price_message': long_form_adjusted_closing_price_message
            'message_type::end_of_day_trade_summary_message': end_of_day_trade_summary_message
            'message_type::long_form_end_of_day_trade_summary_message': long_form_end_of_day_trade_summary_message
            'message_type::next_shares_end_of_day_trade_summary_message': next_shares_end_of_day_trade_summary_message
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
      - id: tracking_number
        type: u2
        doc: 'Internal tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Denotes the Nls Plus type of system event for which the message is being generated'
  trade_report_message:
    seq:
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
        type: decimal_u4_4
        doc: 'The price associated with the trade transaction being reported. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the trade transaction'
      - id: sale_condition_modifier
        type: sale_condition_modifier
        doc: 'Sale condition modifier, consisting of four levels'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  sale_condition_modifier:
    seq:
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Used for Settlement Type information'
      - id: trade_through_exemption
        type: u1
        enum: trade_through_exemption
        doc: 'Used for Sec Regulation Nms Trade Through Exemption codes'
      - id: extended_hours_or_sold_code
        type: u1
        enum: extended_hours_or_sold_code
        doc: 'Used for Extended Hours or Sold codes'
      - id: special_sale_condition
        type: u1
        enum: special_sale_condition
        doc: 'Used for special sale condition codes. This field is case sensitive'
  long_form_trade_report_message:
    seq:
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
      - id: trade_price_long
        type: decimal_u8_4
        doc: 'The price associated with the trade transaction being reported. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the trade transaction'
      - id: sale_condition_modifier
        type: sale_condition_modifier
        doc: 'Sale condition modifier, consisting of four levels'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  next_shares_trade_report_message:
    seq:
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq market system that generated the trade report message'
      - id: next_shares_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the NextShares symbol for which the trade report is being generated'
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
      - id: proxy_price
        type: decimal_u4_4
        doc: 'Reported proxy price for the transaction. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the trade transaction'
      - id: nav_offset_amount
        type: decimal_u4_4
        doc: 'The Nav offset that should be applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: sale_condition_modifier
        type: sale_condition_modifier
        doc: 'Sale condition modifier, consisting of four levels'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  trade_cancel_error_message:
    seq:
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
        doc: 'Indicates the source''s internal control number associated with the original trade transaction'
      - id: original_trade_price
        type: decimal_u4_4
        doc: 'The price reported on the original trade transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'The number of shares reported on the original trade transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'The sale condition modifier reported on the original trade transaction'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  original_sale_condition_modifier:
    seq:
      - id: original_settlement_type
        type: u1
        enum: original_settlement_type
        doc: 'Used for Settlement Type information'
      - id: original_trade_through_exemption
        type: u1
        enum: original_trade_through_exemption
        doc: 'Used for Sec Regulation Nms Trade Through Exemption codes'
      - id: original_extended_hours_or_sold_code
        type: u1
        enum: original_extended_hours_or_sold_code
        doc: 'Used for Extended Hours or Sold codes'
      - id: original_special_sale_condition
        type: u1
        enum: original_special_sale_condition
        doc: 'Used for special sale condition codes. This field is case sensitive'
  long_form_trade_cancel_error_message:
    seq:
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
        doc: 'Indicates the source''s internal control number associated with the original trade transaction'
      - id: original_trade_price_long
        type: decimal_u8_4
        doc: 'The price reported on the original trade transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'The number of shares reported on the original trade transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'The sale condition modifier reported on the original trade transaction'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  next_shares_trade_cancel_error_message:
    seq:
      - id: market_center
        type: u1
        enum: market_center
        doc: 'Denotes the Nasdaq market system that generated the original trade report message'
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
        doc: 'Indicates the source''s internal control number associated with the original trade transaction'
      - id: original_proxy_price
        type: decimal_u4_4
        doc: 'The proxy price reported on the original trade transaction. Implied decimal with scale 1e-4'
      - id: original_nav_offset_amount
        type: decimal_u4_4
        doc: 'The Nav offset originally applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'The number of shares reported on the original trade transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'The sale condition modifier reported on the original trade transaction'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  trade_correction_message:
    seq:
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
        doc: 'Indicates the source''s internal control number associated with the original trade transaction'
      - id: original_trade_price
        type: decimal_u4_4
        doc: 'The price reported on the original trade transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'The number of shares reported on the original trade transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'The sale condition modifier reported on the original trade transaction'
      - id: corrected_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the source''s internal control number associated with the corrected trade transaction'
      - id: corrected_trade_price
        type: decimal_u4_4
        doc: 'The price reported on the corrected trade transaction. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: u4
        doc: 'The number of shares reported on the corrected trade transaction'
      - id: corrected_sale_condition_modifier
        type: corrected_sale_condition_modifier
        doc: 'The sale condition modifier reported on the corrected trade transaction'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  corrected_sale_condition_modifier:
    seq:
      - id: corrected_settlement_type
        type: u1
        enum: corrected_settlement_type
        doc: 'Used for Settlement Type information'
      - id: corrected_trade_through_exemption
        type: u1
        enum: corrected_trade_through_exemption
        doc: 'Used for Sec Regulation Nms Trade Through Exemption codes'
      - id: corrected_extended_hours_or_sold_code
        type: u1
        enum: corrected_extended_hours_or_sold_code
        doc: 'Used for Extended Hours or Sold codes'
      - id: corrected_special_sale_condition
        type: u1
        enum: corrected_special_sale_condition
        doc: 'Used for special sale condition codes. This field is case sensitive'
  long_form_trade_correction_message:
    seq:
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
        doc: 'Indicates the source''s internal control number associated with the original trade transaction'
      - id: original_trade_price_long
        type: decimal_u8_4
        doc: 'The price reported on the original trade transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'The number of shares reported on the original trade transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'The sale condition modifier reported on the original trade transaction'
      - id: corrected_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the source''s internal control number associated with the corrected trade transaction'
      - id: corrected_trade_price_long
        type: decimal_u8_4
        doc: 'The price reported on the corrected trade transaction. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: u4
        doc: 'The number of shares reported on the corrected trade transaction'
      - id: corrected_sale_condition_modifier
        type: corrected_sale_condition_modifier
        doc: 'The sale condition modifier reported on the corrected trade transaction'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  next_shares_trade_correction_message:
    seq:
      - id: market_center
        type: u1
        enum: market_center
        doc: 'Denotes the Nasdaq market system that generated the original trade report message'
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
        doc: 'Indicates the source''s internal control number associated with the original trade transaction'
      - id: original_proxy_price
        type: decimal_u4_4
        doc: 'The proxy price reported on the original trade transaction. Implied decimal with scale 1e-4'
      - id: original_nav_offset_amount
        type: decimal_u4_4
        doc: 'The Nav offset originally applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'The number of shares reported on the original trade transaction'
      - id: original_sale_condition_modifier
        type: original_sale_condition_modifier
        doc: 'The sale condition modifier reported on the original trade transaction'
      - id: corrected_trade_control_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the source''s internal control number associated with the corrected trade transaction'
      - id: corrected_proxy_price
        type: decimal_u4_4
        doc: 'The proxy price reported on the corrected trade transaction. Implied decimal with scale 1e-4'
      - id: corrected_nav_offset_amount
        type: decimal_u4_4
        doc: 'The corrected Nav offset applied to the Proxy Price. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: u4
        doc: 'The number of shares reported on the corrected trade transaction'
      - id: corrected_sale_condition_modifier
        type: corrected_sale_condition_modifier
        doc: 'The sale condition modifier reported on the corrected trade transaction'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
  stock_trading_action_message:
    seq:
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use; space filled in the initial release'
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
  stock_directory_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates the listing market or listing market tier for the issue'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'For Nasdaq listed issues, denotes when an issue is flagged as deficient, delinquent, bankrupt or in a compliance period'
      - id: round_lot_size
        type: u4
        doc: 'Denotes the number of shares that represent a round lot for the issue'
      - id: round_lots_only
        type: u1
        enum: round_lots_only
        doc: 'Indicates if Nasdaq system limits order entry for the issue'
      - id: issue_classification
        type: u1
        enum: issue_classification
        doc: 'Identifies the security class for the issue as assigned by Nasdaq'
      - id: issue_sub_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security sub type for the issue as assigned by Nasdaq'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Denotes if an issue or quoting participant record is set up in Nasdaq systems in a live, test or demo state'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Indicates if a security is subject to mandatory close-out of short sales under Sec Rule 203(b)(3)'
      - id: ipo_flag
        type: u1
        enum: ipo_flag
        doc: 'Indicates if the Nasdaq security is set up for Ipo release'
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
        doc: 'Tracks the integral relationship of the Etp to the underlying index'
      - id: inverse_indicator
        type: u1
        enum: inverse_indicator
        doc: 'Indicates the directional relationship between the Etp and the underlying index'
      - id: bloomberg_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bloomberg global identifier for the issue'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Denotes the Reg Sho short sale price test restriction status for the issue'
  adjusted_closing_price_message:
    seq:
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
        type: decimal_u4_4
        doc: 'Denotes the adjusted previous close price for the issue. Implied decimal with scale 1e-4'
  long_form_adjusted_closing_price_message:
    seq:
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
      - id: adjusted_closing_price_long
        type: decimal_u8_4
        doc: 'Denotes the adjusted previous close price for the issue. Implied decimal with scale 1e-4'
  end_of_day_trade_summary_message:
    seq:
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates the listing market or listing market tier for the issue'
      - id: consolidated_high_price
        type: decimal_u4_4
        doc: 'The consolidated high price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_low_price
        type: decimal_u4_4
        doc: 'The consolidated low price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_closing_price
        type: decimal_u4_4
        doc: 'The consolidated closing price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
      - id: consolidated_open_price
        type: decimal_u4_4
        doc: 'The consolidated opening price for the issue for the trading day. Implied decimal with scale 1e-4'
  long_form_end_of_day_trade_summary_message:
    seq:
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates the listing market or listing market tier for the issue'
      - id: consolidated_high_price_long
        type: decimal_u8_4
        doc: 'The consolidated high price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_low_price_long
        type: decimal_u8_4
        doc: 'The consolidated low price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_closing_price_long
        type: decimal_u8_4
        doc: 'The consolidated closing price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
      - id: consolidated_open_price_long
        type: decimal_u8_4
        doc: 'The consolidated opening price for the issue for the trading day. Implied decimal with scale 1e-4'
  next_shares_end_of_day_trade_summary_message:
    seq:
      - id: issue_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq-assigned issue symbol of the security for which the trade report is being generated'
      - id: market_category
        type: u1
        enum: market_category
        doc: 'Indicates the listing market or listing market tier for the issue'
      - id: consolidated_high_price
        type: decimal_u4_4
        doc: 'The consolidated high price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: nav_offset_amount_high
        type: decimal_u4_4
        doc: 'The Nav offset that should be applied to the consolidated high proxy price. Implied decimal with scale 1e-4'
      - id: consolidated_low_price
        type: decimal_u4_4
        doc: 'The consolidated low price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: nav_offset_amount_low
        type: decimal_u4_4
        doc: 'The Nav offset that should be applied to the consolidated low proxy price. Implied decimal with scale 1e-4'
      - id: consolidated_closing_price
        type: decimal_u4_4
        doc: 'The consolidated closing price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: nav_offset_amount_closing
        type: decimal_u4_4
        doc: 'The Nav offset that should be applied to the consolidated closing proxy price. Implied decimal with scale 1e-4'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the volume for the Issue Symbol as reported on the consolidated market data feed at the time the trade message was generated'
      - id: consolidated_open_price
        type: decimal_u4_4
        doc: 'The consolidated opening price for the issue for the trading day. Implied decimal with scale 1e-4'
      - id: nav_offset_amount_open
        type: decimal_u4_4
        doc: 'The Nav offset that should be applied to the consolidated opening proxy price. Implied decimal with scale 1e-4'
  ipo_information_message:
    seq:
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
        doc: 'Indicates the basis of the reference price for net change calculations'
      - id: reference_price
        type: decimal_u4_4
        doc: 'Denotes the reference price to be used for intraday net change calculations. Implied decimal with scale 1e-4'
  mwcb_decline_level_message:
    seq:
      - id: level_1
        type: decimal_u8_8
        doc: 'Denotes the Mwcb Level 1 value. Implied decimal with scale 1e-8'
      - id: level_2
        type: decimal_u8_8
        doc: 'Denotes the Mwcb Level 2 value. Implied decimal with scale 1e-8'
      - id: level_3
        type: decimal_u8_8
        doc: 'Denotes the Mwcb Level 3 value. Implied decimal with scale 1e-8'
  mwcb_status_message:
    seq:
      - id: breached_level
        type: u1
        enum: breached_level
        doc: 'Denotes the Mwcb level that was breached'
  ipo_quoting_period_update_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: ipo_quotation_release_time
        type: u4
        doc: 'Denotes the Ipo release time, in seconds since midnight, for quotation to the nearest second'
      - id: ipo_quotation_release_qualifier
        type: u1
        enum: ipo_quotation_release_qualifier
        doc: 'Denotes whether the release time is anticipated or the release has been cancelled or postponed'
      - id: ipo_price
        type: decimal_u4_4
        doc: 'Denotes the Ipo price to be used for intraday net change calculations. Implied decimal with scale 1e-4'
  operational_halt_message:
    seq:
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: market_code
        type: u1
        enum: market_code
        doc: 'Denotes the market centre for which the operational halt is declared'
      - id: operational_halt_action
        type: u1
        enum: operational_halt_action
        doc: 'Denotes whether the issue is operationally halted on the identified market or has resumed trading'
  nanosecond_timestamp:
    seq:
      - id: time
        type: b48
    instances:
      hour:
        value: time.as<s8> / 3600000000000 % 24
      minute:
        value: time.as<s8> / 60000000000 % 60
      second:
        value: time.as<s8> / 1000000000 % 60
      millisecond:
        value: time.as<s8> / 1000000 % 1000
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
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
      doc: 'Relays Nasdaq execution system and Trf trade transactions reported for the current business day. Nasdaq reports only one side of a trade execution on the Nls Plus feed.'
    0x74:
      id: 'long_form_trade_report_message'
      doc: 'Trade Report carrying an eight byte trade price, used when the price breaches the maximum value the four byte form can carry.'
    0x4d:
      id: 'next_shares_trade_report_message'
      doc: 'Relays trade transactions for NextShares exchange traded managed funds, reported as a proxy price with the Nav offset to apply to it.'
    0x58:
      id: 'trade_cancel_error_message'
      doc: 'Indicates that a previously reported trade transaction has been cancelled or was reported in error.'
    0x78:
      id: 'long_form_trade_cancel_error_message'
      doc: 'Trade Cancel/Error carrying an eight byte original trade price.'
    0x4f:
      id: 'next_shares_trade_cancel_error_message'
      doc: 'Indicates that a previously reported NextShares trade transaction has been cancelled or was reported in error.'
    0x43:
      id: 'trade_correction_message'
      doc: 'Indicates that a previously reported trade transaction has been corrected, carrying both the original and the corrected transaction.'
    0x63:
      id: 'long_form_trade_correction_message'
      doc: 'Trade Correction carrying eight byte original and corrected trade prices.'
    0x5a:
      id: 'next_shares_trade_correction_message'
      doc: 'Indicates that a previously reported NextShares trade transaction has been corrected.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Indicates the current trading status of a security to the trading community. Clients should initialize all securities as halted at the start of the session.'
    0x52:
      id: 'stock_directory_message'
      doc: 'Identifies the securities eligible for the trading session, disseminated at the start of each day.'
    0x59:
      id: 'reg_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Indicates the Reg Sho short sale price test restriction status for an issue, under Rule 201 of Regulation Sho.'
    0x47:
      id: 'adjusted_closing_price_message'
      doc: 'Denotes the adjusted previous close price to be used for intraday net change calculations.'
    0x67:
      id: 'long_form_adjusted_closing_price_message'
      doc: 'Adjusted Closing Price carrying an eight byte price.'
    0x4a:
      id: 'end_of_day_trade_summary_message'
      doc: 'Summarises the consolidated trading activity for an issue at the end of the trading day.'
    0x6a:
      id: 'long_form_end_of_day_trade_summary_message'
      doc: 'End of Day Trade Summary carrying eight byte prices.'
    0x4e:
      id: 'next_shares_end_of_day_trade_summary_message'
      doc: 'Summarises the consolidated trading activity for a NextShares issue, each price paired with the Nav offset to apply to it.'
    0x49:
      id: 'ipo_information_message'
      doc: 'Denotes the reference price to be used for intraday net change calculations for an issue.'
    0x56:
      id: 'mwcb_decline_level_message'
      doc: 'Informs the market of the daily market wide circuit breaker decline levels, disseminated at the start of the trading day.'
    0x57:
      id: 'mwcb_status_message'
      doc: 'Informs the market that a market wide circuit breaker decline level has been breached.'
    0x4b:
      id: 'ipo_quoting_period_update_message'
      doc: 'Indicates the anticipated Ipo quotation release time of a security.'
    0x68:
      id: 'operational_halt_message'
      doc: 'Indicates the current operational status of a security to the trading community. An operational halt is specific to the market centre for which it is declared and does not interrupt trading of the instrument on any other market place.'
  event_code:
    0x4f:
      id: 'start_of_transmissions'
      doc: 'Denotes That The Nls Plus System Has Started Its Daily Transmission Schedule'
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
      doc: 'Denotes That The Nls Plus System Has Ended Its Daily Transmission Schedule'
  originating_market_center_identifier:
    0x51:
      id: 'nasdaq'
      doc: 'The Nasdaq Stock Market'
    0x4c:
      id: 'trf_carteret'
      doc: 'Nasdaq Finra Trade Reporting Facility Trf Carteret'
    0x32:
      id: 'trf_chicago'
      doc: 'Nasdaq Finra Trade Reporting Facility Trf Chicago'
    0x42:
      id: 'bx'
      doc: 'Nasdaq Bx'
    0x58:
      id: 'psx'
      doc: 'Nasdaq Psx'
  security_class:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
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
      doc: 'Re Opening Print'
    0x36:
      id: 'closing_print'
      doc: 'Closing Print'
    0x37:
      id: 'qualified_contingent_trade'
      doc: 'Qualified Contingent Trade Qct'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  extended_hours_or_sold_code:
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_trade_reported_late'
      doc: 'Extended Hours Trade Reported Late Or Out Of Sequence'
    0x4c:
      id: 'sold_last'
      doc: 'Sold Last Reported Late But In Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold Out Of Sequence'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      id: 'nasdaq_official_close_price'
      doc: 'Nasdaq Official Close Price Nocp'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'nasdaq_official_opening_price'
      doc: 'Nasdaq Official Opening Price Noop'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x56:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade Nls Plus Uses This Code For All Average Price Trades Regardless Of Listing Market'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
    0x6f:
      id: 'odd_lot_execution'
      doc: 'Odd Lot Execution'
    0x78:
      id: 'odd_lot_cross_execution'
      doc: 'Odd Lot Cross Execution'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      doc: 'Re Opening Print'
    0x36:
      id: 'closing_print'
      doc: 'Closing Print'
    0x37:
      id: 'qualified_contingent_trade'
      doc: 'Qualified Contingent Trade Qct'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  original_extended_hours_or_sold_code:
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_trade_reported_late'
      doc: 'Extended Hours Trade Reported Late Or Out Of Sequence'
    0x4c:
      id: 'sold_last'
      doc: 'Sold Last Reported Late But In Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold Out Of Sequence'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      id: 'nasdaq_official_close_price'
      doc: 'Nasdaq Official Close Price Nocp'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'nasdaq_official_opening_price'
      doc: 'Nasdaq Official Opening Price Noop'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x56:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade Nls Plus Uses This Code For All Average Price Trades Regardless Of Listing Market'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
    0x6f:
      id: 'odd_lot_execution'
      doc: 'Odd Lot Execution'
    0x78:
      id: 'odd_lot_cross_execution'
      doc: 'Odd Lot Cross Execution'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  market_center:
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq Execution System'
    0x4c:
      id: 'trf_carteret'
      doc: 'Nasdaq Finra Trade Reporting Facility Trf'
    0x32:
      id: 'trf_chicago'
      doc: 'Nasdaq Finra Trade Reporting Facility Trf Chicago'
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
      doc: 'Re Opening Print'
    0x36:
      id: 'closing_print'
      doc: 'Closing Print'
    0x37:
      id: 'qualified_contingent_trade'
      doc: 'Qualified Contingent Trade Qct'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  corrected_extended_hours_or_sold_code:
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_trade_reported_late'
      doc: 'Extended Hours Trade Reported Late Or Out Of Sequence'
    0x4c:
      id: 'sold_last'
      doc: 'Sold Last Reported Late But In Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold Out Of Sequence'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      id: 'nasdaq_official_close_price'
      doc: 'Nasdaq Official Close Price Nocp'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'nasdaq_official_opening_price'
      doc: 'Nasdaq Official Opening Price Noop'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x56:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade Nls Plus Uses This Code For All Average Price Trades Regardless Of Listing Market'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
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
      doc: 'Halt In Effect Across All Us Equity Exchanges'
    0x50:
      id: 'paused'
      doc: 'Paused Across All Us Equity Markets And Sros Nasdaq Listed Securities Only'
    0x51:
      id: 'quotation_only'
      doc: 'Quote Only Period In Effect Across All Us Equity Exchanges'
    0x54:
      id: 'trading'
      doc: 'Trading On The Nasdaq Market'
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
      doc: 'New York Stock Exchange'
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
      doc: 'Bats Z Exchange'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange Llc'
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
      id: 'creations_or_redemptions_suspended'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x4e:
      id: 'normal'
      doc: 'Normal Default Issuer Is Not Deficient Delinquent Or Bankrupt'
    0x20:
      id: 'not_available'
      doc: 'Not Available Firms Should Refer To Siac Feeds For The Code If Needed'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Nasdaq System Only Accepts Round Lot Orders For This Security'
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
      id: 'common_stock'
      doc: 'Common Stock'
    0x46:
      id: 'depository_receipt'
      doc: 'Depository Receipt'
    0x49:
      id: 'rule_144_a'
      doc: '144 A'
    0x4c:
      id: 'limited_partnership'
      doc: 'Limited Partnership'
    0x4e:
      id: 'notes'
      doc: 'Notes'
    0x4f:
      id: 'ordinary_share'
      doc: 'Ordinary Share'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x51:
      id: 'other_securities'
      doc: 'Other Securities'
    0x52:
      id: 'right'
      doc: 'Right'
    0x53:
      id: 'shares_of_beneficial_interest'
      doc: 'Shares Of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_of_beneficial_interest'
      doc: 'Units Of Beneficial Interest'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  authenticity:
    0x50:
      id: 'production'
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
      id: 'new_ipo'
      doc: 'Nasdaq Listed Instrument Is Set Up As A New Ipo Security'
    0x4e:
      id: 'not_new_ipo'
      doc: 'Nasdaq Listed Instrument Is Not Set Up As A New Ipo Security'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  luld_reference_price_tier:
    0x31:
      id: 'tier_1'
      doc: 'Tier 1 Nms Stocks And Select Etps'
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
      id: 'inverse'
      doc: 'Etp Is An Inverse Etp'
    0x4e:
      id: 'not_inverse'
      doc: 'Etp Is Not An Inverse Etp'
  reg_sho_action:
    0x30:
      id: 'no_price_test'
      doc: 'No Price Test In Place'
    0x31:
      id: 'restriction_in_effect'
      doc: 'Reg Sho Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In The Security'
    0x32:
      id: 'restriction_remains'
      doc: 'Reg Sho Short Sale Price Test Restriction Remains In Effect'
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
      doc: 'Anticipated Quotation Release Time Used When Nasdaq Market Operations Initially Enters The Ipo Instrument For Release'
    0x43:
      id: 'cancelled'
      doc: 'Ipo Release Cancelled Or Postponed'
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
      id: 'trading'
      doc: 'Operational Halt Has Been Lifted And Trading Resumed'

