# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq Utdf Output Utp v1.5
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Output
#   Encoding: Unlisted Trading Privilege
#   Version: 1.5
#   Date: 5/01/2020
#   Specification: UtpBinaryOutputSpec.pdf
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
  id: nasdaq_utdf_output_utp_v1_5
  title: Nasdaq Utdf Output Utp v1.5
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq UTP Trade Data Feed Output Utp v1.5'
doc-ref: http://www.utpplan.com/technical

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.count

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
        type: u8
        doc: 'Sequence Number of the first message to follow this header'
      - id: count
        type: u2
        doc: 'Number of messages to follow this header'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp Message Header'
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_category
          cases:
            '"T"': trade_message
            '"A"': administrative_message
            '"V"': volume_message
            '"C"': control_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: version
        type: u1
        doc: 'Code identifying this message type'
      - id: message_category
        type: str
        size: 1
        encoding: ASCII
        doc: 'Code identifying this message type'
  trade_message:
    seq:
      - id: trade_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trade message type'
      - id: trade_message_payload
        type:
          switch-on: trade_message_type
          cases:
            '"A"': trade_report_message_short_form_message
            '"W"': trade_report_message_long_form_message
            '"Z"': trade_cancel_error_message
            '"Y"': trade_correction_message
            '"H"': prior_day_as_of_trade_message
  trade_report_message_short_form_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: finra_timestamp
        type: nanosecond_timestamp
        doc: 'FINRA Timestamp. Nanoseconds since Unix epoch'
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: trade_id
        type: u8
        doc: 'Trade Id'
      - id: trade_price_short
        type: decimal_u2_2
        doc: 'Trade Price Short. Implied decimal with scale 1e-2'
      - id: trade_volume_short
        type: u2
        doc: 'Trade Volume Short'
      - id: sale_condition
        type: sale_condition
        doc: 'Sale Condition'
      - id: trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trade Through Exempt Flag'
      - id: consolidated_price_change_indicator
        type: u1
        enum: consolidated_price_change_indicator
        doc: 'Consolidated Price Change Indicator'
      - id: participant_price_change_indicator
        type: u1
        enum: participant_price_change_indicator
        doc: 'Participant Price Change Indicator'
  message_info:
    seq:
      - id: market_center_originator_id
        type: u1
        enum: market_center_originator_id
        doc: 'Market Center Originator ID'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: participant_timestamp
        type: nanosecond_timestamp
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
  sale_condition:
    seq:
      - id: level_1
        type: u1
        enum: level_1
        doc: 'Settlement Type'
      - id: level_2
        type: u1
        enum: level_2
        doc: 'Reason for TT Exemption'
      - id: level_3
        type: u1
        enum: level_3
        doc: 'Extended Hours or Sold'
      - id: level_4
        type: str
        size: 1
        encoding: ASCII
        doc: 'SRO Trade Detail'
  trade_report_message_long_form_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: finra_timestamp
        type: nanosecond_timestamp
        doc: 'FINRA Timestamp. Nanoseconds since Unix epoch'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: trade_id
        type: u8
        doc: 'Trade Id'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Trade Volume'
      - id: sale_condition
        type: sale_condition
        doc: 'Sale Condition'
      - id: trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trade Through Exempt Flag'
      - id: sellers_sale_days
        type: u2
        doc: 'Seller’s Sale Days'
      - id: consolidated_price_change_indicator
        type: u1
        enum: consolidated_price_change_indicator
        doc: 'Consolidated Price Change Indicator'
      - id: participant_price_change_indicator
        type: u1
        enum: participant_price_change_indicator
        doc: 'Participant Price Change Indicator'
  trade_cancel_error_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: finra_timestamp
        type: nanosecond_timestamp
        doc: 'FINRA Timestamp. Nanoseconds since Unix epoch'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: trade_cancellation_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trade Cancellation Type'
      - id: original_trade_id
        type: u8
        doc: 'Original Trade Id'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Trade Price. Implied decimal with scale 1e-6'
      - id: original_volume
        type: u4
        doc: 'Original Volume'
      - id: original_sale_condition
        type: original_sale_condition
        doc: 'Original Sale Condition'
      - id: original_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: original_sellers_sale_days
        type: u2
        doc: 'Original Seller’s Sale Days'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated High Price. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated Low Price. Implied decimal with scale 1e-6'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated Last Price. Implied decimal with scale 1e-6'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Consolidated Volume. Implied decimal with scale 1e-6'
      - id: consolidated_price_change_indicator
        type: u1
        enum: consolidated_price_change_indicator
        doc: 'Consolidated Price Change Indicator'
      - id: market_center_originator_id
        type: u1
        enum: market_center_originator_id
        doc: 'Market Center Originator ID'
      - id: market_participant_high_price
        type: decimal_u8_6
        doc: 'Market Participant High Price. Implied decimal with scale 1e-6'
      - id: market_participant_low_price
        type: decimal_u8_6
        doc: 'Market Participant Low Price. Implied decimal with scale 1e-6'
      - id: market_participant_last_price
        type: decimal_u8_6
        doc: 'Market Participant Last Price. Implied decimal with scale 1e-6'
      - id: market_participant_volume
        type: decimal_u8_6
        doc: 'Market Participant Volume. Implied decimal with scale 1e-6'
  original_sale_condition:
    seq:
      - id: level_1
        type: u1
        enum: level_1
        doc: 'Settlement Type'
      - id: level_2
        type: u1
        enum: level_2
        doc: 'Reason for TT Exemption'
      - id: level_3
        type: u1
        enum: level_3
        doc: 'Extended Hours or Sold'
      - id: level_4
        type: str
        size: 1
        encoding: ASCII
        doc: 'SRO Trade Detail'
  trade_correction_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: finra_timestamp
        type: nanosecond_timestamp
        doc: 'FINRA Timestamp. Nanoseconds since Unix epoch'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: original_trade_id
        type: u8
        doc: 'Original Trade Id'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Trade Price. Implied decimal with scale 1e-6'
      - id: original_volume
        type: u4
        doc: 'Original Volume'
      - id: original_sale_condition
        type: original_sale_condition
        doc: 'Original Sale Condition'
      - id: original_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: original_sellers_sale_days
        type: u2
        doc: 'Original Seller’s Sale Days'
      - id: corrected_trade_id
        type: u8
        doc: 'Corrected Trade Id'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Trade Price. Implied decimal with scale 1e-6'
      - id: corrected_volume
        type: u4
        doc: 'Corrected Volume'
      - id: corrected_sale_condition
        type: corrected_sale_condition
        doc: 'Corrected Sale Condition'
      - id: corrected_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Trade Through Exempt Flag'
      - id: corrected_sellers_sale_days
        type: u2
        doc: 'Corrected Seller’s Sale Days'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated High Price. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated Low Price. Implied decimal with scale 1e-6'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated Last Price. Implied decimal with scale 1e-6'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Consolidated Volume. Implied decimal with scale 1e-6'
      - id: consolidated_price_change_indicator
        type: u1
        enum: consolidated_price_change_indicator
        doc: 'Consolidated Price Change Indicator'
      - id: market_center_originator_id
        type: u1
        enum: market_center_originator_id
        doc: 'Market Center Originator ID'
      - id: market_participant_high_price
        type: decimal_u8_6
        doc: 'Market Participant High Price. Implied decimal with scale 1e-6'
      - id: market_participant_low_price
        type: decimal_u8_6
        doc: 'Market Participant Low Price. Implied decimal with scale 1e-6'
      - id: market_participant_last_price
        type: decimal_u8_6
        doc: 'Market Participant Last Price. Implied decimal with scale 1e-6'
      - id: market_participant_volume
        type: decimal_u8_6
        doc: 'Market Participant Volume. Implied decimal with scale 1e-6'
  corrected_sale_condition:
    seq:
      - id: level_1
        type: u1
        enum: level_1
        doc: 'Settlement Type'
      - id: level_2
        type: u1
        enum: level_2
        doc: 'Reason for TT Exemption'
      - id: level_3
        type: u1
        enum: level_3
        doc: 'Extended Hours or Sold'
      - id: level_4
        type: str
        size: 1
        encoding: ASCII
        doc: 'SRO Trade Detail'
  prior_day_as_of_trade_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: finra_timestamp
        type: nanosecond_timestamp
        doc: 'FINRA Timestamp. Nanoseconds since Unix epoch'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: trade_id
        type: u8
        doc: 'Trade Id'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Trade Volume'
      - id: sale_condition
        type: sale_condition
        doc: 'Sale Condition'
      - id: trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trade Through Exempt Flag'
      - id: sellers_sale_days
        type: u2
        doc: 'Seller’s Sale Days'
      - id: as_of_action
        type: u1
        enum: as_of_action
        doc: 'As Of Action'
      - id: timestamp_of_trade
        type: nanosecond_timestamp
        doc: 'Timestamp of Trade. Nanoseconds since Unix epoch'
  administrative_message:
    seq:
      - id: administrative_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Administrative message type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            '"A"': general_administrative_message
            '"H"': cross_sro_trading_action_message
            '"K"': market_center_trading_action_message
            '"B"': issue_symbol_directory_message
            '"V"': regulation_sho_short_sale_price_test_restricted_indicator_message
            '"P"': limit_up_limit_down_price_band_message
            '"C"': market_wide_circuit_breaker_decline_level_message
            '"D"': market_wide_circuit_breaker_status_message
            '"E"': auction_collar_message
            '"Z"': closing_trade_summary_report_message
  general_administrative_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: len_text
        type: u2
        doc: 'Text Length'
      - id: text
        type: str
        size: len_text
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text'
  cross_sro_trading_action_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: trading_action_sequence_number
        type: u4
        doc: 'Trading Action Sequence Number'
      - id: action_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the action occurred. Nanoseconds since Unix epoch'
      - id: trading_action_reason
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for the Trading Action'
  market_center_trading_action_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: action_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the action occurred. Nanoseconds since Unix epoch'
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
  issue_symbol_directory_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: old_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old Security Identifier'
      - id: issue_name
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Name'
      - id: issue_type
        type: u1
        enum: issue_type
        doc: 'Issue Type'
      - id: issue_subtype
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Subtype'
      - id: market_tier
        type: u1
        enum: market_tier
        doc: 'Market Tier'
      - id: authenticity
        type: u1
        enum: authenticity
        doc: 'Authenticity'
      - id: short_sale_threshold_indicator
        type: u1
        enum: short_sale_threshold_indicator
        doc: 'Short Sale Threshold Indicator'
      - id: round_lot_size
        type: u2
        doc: 'Round Lot Size'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Financial Status Indicator'
  regulation_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action'
  limit_up_limit_down_price_band_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: luld_price_band_indicator
        type: u1
        enum: luld_price_band_indicator
        doc: 'LULD Price Band Indicator'
      - id: luld_timestamp
        type: nanosecond_timestamp
        doc: 'LULD Price Band Effective Time. Nanoseconds since Unix epoch'
      - id: limit_down_price
        type: decimal_u8_6
        doc: 'Limit Down Price. Implied decimal with scale 1e-6'
      - id: limit_up_price
        type: decimal_u8_6
        doc: 'Limit Up Price. Implied decimal with scale 1e-6'
  market_wide_circuit_breaker_decline_level_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: mwcb_level_1
        type: u8
        doc: 'MWCB Level 1'
      - id: mwcb_level_2
        type: u8
        doc: 'MWCB Level 2'
      - id: mwcb_level_3
        type: u8
        doc: 'MWCB Level 3'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: mwcb_status_level_indicator
        type: u1
        enum: mwcb_status_level_indicator
        doc: 'MWCB Status Level Indicator'
  auction_collar_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: trading_action_sequence_number
        type: u4
        doc: 'Trading Action Sequence Number'
      - id: collar_reference_price
        type: decimal_u8_6
        doc: 'Reference price used to set collar. Implied decimal with scale 1e-6'
      - id: collar_up_price
        type: decimal_u8_6
        doc: 'Collar Up Price. Implied decimal with scale 1e-6'
      - id: collar_down_price
        type: decimal_u8_6
        doc: 'Collar Down Price. Implied decimal with scale 1e-6'
      - id: collar_extension_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Collar Extension Indicator'
  closing_trade_summary_report_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier'
      - id: daily_consolidated_high_price
        type: decimal_u8_6
        doc: 'Daily Consolidated High Price. Implied decimal with scale 1e-6'
      - id: daily_consolidated_low_price
        type: decimal_u8_6
        doc: 'Daily Consolidated Low Price. Implied decimal with scale 1e-6'
      - id: daily_consolidated_closing_price
        type: decimal_u8_6
        doc: 'Daily Consolidated Closing Price. Implied decimal with scale 1e-6'
      - id: market_center_originator_id
        type: u1
        enum: market_center_originator_id
        doc: 'Market Center Originator ID'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Consolidated Volume. Implied decimal with scale 1e-6'
      - id: trading_action_indicator
        type: u1
        enum: trading_action_indicator
        doc: 'Trading Action Indicator'
      - id: num_market_center_closing_price_and_volume_summary
        type: u2
        doc: 'Number of Market Center Summaries'
      - id: market_center_closing_price_and_volume_summary
        type: market_center_closing_price_and_volume_summary
        repeat: expr
        repeat-expr: num_market_center_closing_price_and_volume_summary
        doc: 'Market Center Closing Price And Volume Summary'
  market_center_closing_price_and_volume_summary:
    seq:
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
      - id: market_center_closing_price
        type: decimal_u8_6
        doc: 'Market Center Closing Price. Implied decimal with scale 1e-6'
      - id: market_center_volume
        type: decimal_u8_6
        doc: 'Market Center Volume. Implied decimal with scale 1e-6'
      - id: market_center_close_indicator
        type: u1
        enum: market_center_close_indicator
        doc: 'Market Center Close Indicator'
      - id: market_participant_high_price
        type: decimal_u8_6
        doc: 'Market Participant High Price. Implied decimal with scale 1e-6'
      - id: market_participant_low_price
        type: decimal_u8_6
        doc: 'Market Participant Low Price. Implied decimal with scale 1e-6'
  volume_message:
    seq:
      - id: volume_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Volume message type'
      - id: volume_message_payload
        type:
          switch-on: volume_message_type
          cases:
            '"M"': total_consolidated_and_market_center_volume_message
  total_consolidated_and_market_center_volume_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
      - id: total_consolidated_volume
        type: decimal_u8_6
        doc: 'Total Consolidated Volume. Implied decimal with scale 1e-6'
      - id: num_market_center_volume_attachment
        type: u2
        doc: 'Number of Market Center Volumes'
      - id: market_center_volume_attachment
        type: market_center_volume_attachment
        repeat: expr
        repeat-expr: num_market_center_volume_attachment
        doc: 'Market Center Volume Attachment'
  market_center_volume_attachment:
    seq:
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
      - id: current_market_center_volume
        type: decimal_u8_6
        doc: 'Current Market Center Volume. Implied decimal with scale 1e-6'
  control_message:
    seq:
      - id: control_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Control message type'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            '"I"': start_of_day_message
            '"J"': end_of_day_message
            '"O"': market_session_open_message
            '"C"': market_session_close_message
            '"Z"': end_of_transmissions_message
            '"X"': end_of_trade_reporting_message
            '"S"': end_of_consolidated_last_sale_eligibility
  start_of_day_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
  end_of_day_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
  market_session_open_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
  market_session_close_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
  end_of_transmissions_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
  end_of_trade_reporting_message:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
  end_of_consolidated_last_sale_eligibility:
    seq:
      - id: message_info
        type: message_info
        doc: 'Message Info'
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  market_center_originator_id:
    0x59:
      id: 'byx'
      doc: 'Cboe Byx'
    0x5a:
      id: 'bzx'
      doc: 'Cboe Bzx'
    0x4a:
      id: 'edga'
      doc: 'Cboe Edga'
    0x4b:
      id: 'edgx'
      doc: 'Cboe Edgx'
    0x57:
      id: 'cboe'
      doc: 'Cboe'
    0x42:
      id: 'bx'
      doc: 'Nasdaq Bx'
    0x58:
      id: 'phlx'
      doc: 'Nasdaq Phlx'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x49:
      id: 'ise'
      doc: 'Nasdaq Ise'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'arca'
      doc: 'Nyse Arca'
    0x41:
      id: 'american'
      doc: 'Nyse American'
    0x43:
      id: 'national'
      doc: 'Nyse National'
    0x4d:
      id: 'chicago'
      doc: 'Nyse Chicago'
    0x44:
      id: 'finra'
      doc: 'Financial Industry Regulatory Authority'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange'
    0x4c:
      id: 'ltse'
      doc: 'Long Term Stock Exchange'
    0x48:
      id: 'pearl'
      doc: 'Miax Pearl'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x45:
      id: 'market_independent'
      doc: 'Market Independent'
  sub_market_center_id:
    0x4e:
      id: 'nyse_trf'
      doc: 'Nyse Trf'
    0x51:
      id: 'nasdaq_trf_carteret'
      doc: 'Nasdaq Trf Carteret'
    0x42:
      id: 'nasdaq_trf_chicago'
      doc: 'Nasdaq Trf Chicago'
    0x20:
      id: 'finra_alternative_display_facility'
      doc: 'Finra Alternative Display Facility'
  level_1:
    0x40:
      id: 'regular_trade'
      doc: 'Regular Trade'
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'next_day'
      doc: 'Next Day'
    0x52:
      id: 'seller'
      doc: 'Seller'
    0x59:
      id: 'yellow_flag'
      doc: 'Yellow Flag'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  level_2:
    0x46:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x4f:
      id: 'opening_prints'
      doc: 'Opening Prints'
    0x34:
      id: 'derivatively_priced'
      doc: 'Derivatively Priced'
    0x35:
      id: 're_opening_prints'
      doc: 'Re Opening Prints'
    0x36:
      id: 'closing_prints'
      doc: 'Closing Prints'
    0x37:
      id: 'qualified_contingent_trade'
      doc: 'Qualified Contingent Trade'
    0x38:
      id: 'placeholder_for_611_exempt'
      doc: 'Placeholder For 611 Exempt'
    0x39:
      id: 'corrected_consolidated_close'
      doc: 'Corrected Consolidated Close'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  level_3:
    0x54:
      id: 'form_t'
      doc: 'Form T'
    0x4c:
      id: 'sold_last'
      doc: 'Sold Last'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold Out Of Sequence'
    0x55:
      id: 'extended_trading_hours'
      doc: 'Extended Trading Hours'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
    0x31:
      id: 'stopped_stock'
      doc: 'Stopped Stock'
    0x41:
      id: 'acquisition'
      doc: 'Acquisition'
    0x42:
      id: 'bunched'
      doc: 'Bunched'
    0x44:
      id: 'distribution'
      doc: 'Distribution'
    0x45:
      id: 'placeholder_future'
      doc: 'Placeholder Future'
    0x47:
      id: 'bunched_sold_trade'
      doc: 'Bunched Sold Trade'
    0x48:
      id: 'price_variation'
      doc: 'Price Variation'
    0x49:
      id: 'odd_lot_trade'
      doc: 'Odd Lot Trade'
    0x4b:
      id: 'rule_155'
      doc: 'Rule 155'
    0x4d:
      id: 'market_center_official_close_price'
      doc: 'Market Center Official Close Price'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'market_center_official_open_price'
      doc: 'Market Center Official Open Price'
    0x53:
      id: 'split_trade'
      doc: 'Split Trade'
    0x56:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x57:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
  consolidated_price_change_indicator:
    0x30:
      id: 'no_prices_changed'
      doc: 'No Prices Changed'
    0x31:
      id: 'consolidated_last_price_changed'
      doc: 'Consolidated Last Price Changed'
    0x32:
      id: 'consolidated_low_price_changed'
      doc: 'Consolidated Low Price Changed'
    0x33:
      id: 'consolidated_last_and_consolidated_low_prices_changed'
      doc: 'Consolidated Last And Consolidated Low Prices Changed'
    0x34:
      id: 'consolidated_high_price_changed'
      doc: 'Consolidated High Price Changed'
    0x35:
      id: 'consolidated_last_and_consolidated_high_prices_changed'
      doc: 'Consolidated Last And Consolidated High Prices Changed'
    0x36:
      id: 'consolidated_high_and_consolidated_low_prices_changed'
      doc: 'Consolidated High And Consolidated Low Prices Changed'
    0x37:
      id: 'all_consolidated_prices_changed'
      doc: 'All Consolidated Prices Changed'
  participant_price_change_indicator:
    0x30:
      id: 'no_prices_changed'
      doc: 'No Prices Changed'
    0x31:
      id: 'participant_last_price_changed'
      doc: 'Participant Last Price Changed'
    0x32:
      id: 'participant_low_price_changed'
      doc: 'Participant Low Price Changed'
    0x33:
      id: 'participant_last_and_low_prices_changed'
      doc: 'Participant Last And Low Prices Changed'
    0x34:
      id: 'participant_high_price_changed'
      doc: 'Participant High Price Changed'
    0x35:
      id: 'participant_last_and_high_prices_changed'
      doc: 'Participant Last And High Prices Changed'
    0x36:
      id: 'participant_high_and_low_prices_changed'
      doc: 'Participant High And Low Prices Changed'
    0x37:
      id: 'all_participant_prices_changed'
      doc: 'All Participant Prices Changed'
  as_of_action:
    0x41:
      id: 'trade_addition'
      doc: 'Trade Addition'
    0x43:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
  trading_action_code:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x51:
      id: 'quotation_resumption_including_after_ema'
      doc: 'Quotation Resumption Including After Ema'
    0x54:
      id: 'trading_resumption'
      doc: 'Trading Resumption'
    0x50:
      id: 'volatility_trading_pause'
      doc: 'Volatility Trading Pause'
  issue_type:
    0x41:
      id: 'american_depository_receipt'
      doc: 'American Depository Receipt'
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
      id: 'rule_144a'
      doc: 'Rule 144a'
    0x4c:
      id: 'limited_partnership'
      doc: 'Limited Partnership'
    0x4e:
      id: 'note'
      doc: 'Note'
    0x4f:
      id: 'ordinary_shares'
      doc: 'Ordinary Shares'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x51:
      id: 'other_securities'
      doc: 'Other Securities'
    0x52:
      id: 'rights'
      doc: 'Rights'
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
  market_tier:
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'Nasdaq Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'Nasdaq Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'Nasdaq Capital Market'
  authenticity:
    0x50:
      id: 'production'
      doc: 'Production'
    0x54:
      id: 'test'
      doc: 'Test'
    0x44:
      id: 'demo'
      doc: 'Demo'
    0x58:
      id: 'deleted'
      doc: 'Deleted'
  short_sale_threshold_indicator:
    0x59:
      id: 'issue_is_restricted'
      doc: 'Issue Is Restricted'
    0x4e:
      id: 'issue_is_not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'not_available'
      doc: 'Not Available'
  financial_status_indicator:
    0x43:
      id: 'creations_and_or_redemptions_suspended'
      doc: 'Creations And Or Redemptions Suspended For Exchange Traded Product'
    0x44:
      id: 'deficient'
      doc: 'Deficient Issuer Failed To Meet Nasdaq Continued Listing Requirements'
    0x45:
      id: 'delinquent'
      doc: 'Issuer Missed Regulatory Filing Deadline'
    0x51:
      id: 'bankrupt'
      doc: 'Issuer Has Filed For Bankruptcy'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is Not Deficient Delinquent Or Bankrupt'
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
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_in_effect_due_to_an_intra_day_price_drop'
      doc: 'Reg Sho In Effect Due To An Intra Day Price Drop'
    0x32:
      id: 'reg_sho_restriction_remains_in_effect'
      doc: 'Reg Sho Restriction Remains In Effect'
  luld_price_band_indicator:
    0x41:
      id: 'opening_update'
      doc: 'Opening Update'
    0x42:
      id: 'intra_day_update'
      doc: 'Intra Day Update'
    0x43:
      id: 'restated_value'
      doc: 'Restated Value'
    0x44:
      id: 'suspended_during_trading_halt_or_trading_pause'
      doc: 'Suspended During Trading Halt Or Trading Pause'
    0x45:
      id: 're_opening_update'
      doc: 'Re Opening Update'
    0x46:
      id: 'outside_price_band_rule_hours'
      doc: 'Outside Price Band Rule Hours'
    0x20:
      id: 'none_provided'
      doc: 'None Provided'
  mwcb_status_level_indicator:
    0x31:
      id: 'level_1_breached'
      doc: 'Level 1 Breached'
    0x32:
      id: 'level_2_breached'
      doc: 'Level 2 Breached'
    0x33:
      id: 'level_3_breached'
      doc: 'Level 3 Breached'
  trading_action_indicator:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x20:
      id: 'regular_trading'
      doc: 'Regular Trading'
  market_center_close_indicator:
    0x4d:
      id: 'based_on_m_sale_condition'
      doc: 'Based On M Sale Condition'
    0x20:
      id: 'not_based_on_m_sale_condition'
      doc: 'Not Based On M Sale Condition'

