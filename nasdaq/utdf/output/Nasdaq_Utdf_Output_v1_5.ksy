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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
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
        size: message_header.message_length - 4
        type:
          switch-on: message_header.message_category
          cases:
            '"T"': trade
            '"A"': administrative
            '"V"': volume
            '"C"': control
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
  trade:
    seq:
      - id: trade_message_type
        type: u1
        enum: trade_message_type
        doc: 'Trade Messages'
      - id: trade_payload
        size: _parent.message_header.message_length - 2 - 1
        type:
          switch-on: trade_message_type
          cases:
            'trade_message_type::trade_report_message_short_form_message': trade_report_message_short_form_message
            'trade_message_type::trade_report_message_long_form_message': trade_report_message_long_form_message
            'trade_message_type::trade_cancel_error_message': trade_cancel_error_message
            'trade_message_type::trade_correction_message': trade_correction_message
            'trade_message_type::prior_day_as_of_trade_message': prior_day_as_of_trade_message
  trade_report_message_short_form_message:
    seq:
      - id: message_info
        type: message_info
      - id: finra_timestamp
        type: u8
        doc: 'FINRA Timestamp'
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
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
        type: u8
        doc: 'SIP Timestamp'
      - id: participant_timestamp
        type: u8
        doc: 'Participant Timestamp'
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
      - id: finra_timestamp
        type: u8
        doc: 'FINRA Timestamp'
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
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
      - id: finra_timestamp
        type: u8
        doc: 'FINRA Timestamp'
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
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
        type: u8
        doc: 'Consolidated Volume'
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
        type: u8
        doc: 'Market Participant Volume'
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
      - id: finra_timestamp
        type: u8
        doc: 'FINRA Timestamp'
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
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
        type: u8
        doc: 'Consolidated Volume'
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
        type: u8
        doc: 'Market Participant Volume'
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
      - id: finra_timestamp
        type: u8
        doc: 'FINRA Timestamp'
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
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
        type: u8
        doc: 'Timestamp of Trade'
  administrative:
    seq:
      - id: administrative_message_type
        type: u1
        enum: administrative_message_type
        doc: 'Administrative Messages'
      - id: administrative_payload
        size: _parent.message_header.message_length - 2 - 1
        type:
          switch-on: administrative_message_type
          cases:
            'administrative_message_type::general_administrative_message': general_administrative_message
            'administrative_message_type::cross_sro_trading_action_message': cross_sro_trading_action_message
            'administrative_message_type::market_center_trading_action_message': market_center_trading_action_message
            'administrative_message_type::issue_symbol_directory_message': issue_symbol_directory_message
            'administrative_message_type::regulation_sho_short_sale_price_test_restricted_indicator_message': regulation_sho_short_sale_price_test_restricted_indicator_message
            'administrative_message_type::limit_up_limit_down_price_band_message': limit_up_limit_down_price_band_message
            'administrative_message_type::market_wide_circuit_breaker_decline_level_message': market_wide_circuit_breaker_decline_level_message
            'administrative_message_type::market_wide_circuit_breaker_status_message': market_wide_circuit_breaker_status_message
            'administrative_message_type::auction_collar_message': auction_collar_message
            'administrative_message_type::closing_trade_summary_report_message': closing_trade_summary_report_message
  general_administrative_message:
    seq:
      - id: message_info
        type: message_info
      - id: len_text
        type: u2
        doc: 'Text Length'
      - id: text
        type: str
        size: len_text
        encoding: ASCII
        doc: 'Text'
  cross_sro_trading_action_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Security Identifier'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: trading_action_sequence_number
        type: u4
        doc: 'Trading Action Sequence Number'
      - id: action_timestamp
        type: u8
        doc: 'Timestamp of when the action occurred'
      - id: trading_action_reason
        type: str
        size: 6
        encoding: ASCII
        doc: 'Reason for the Trading Action'
  market_center_trading_action_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Security Identifier'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: action_timestamp
        type: u8
        doc: 'Timestamp of when the action occurred'
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
  issue_symbol_directory_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Security Identifier'
      - id: old_symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Old Security Identifier'
      - id: issue_name
        type: str
        size: 30
        encoding: ASCII
        doc: 'Issue Name'
      - id: issue_type
        type: u1
        enum: issue_type
        doc: 'Issue Type'
      - id: issue_subtype
        type: str
        size: 2
        encoding: ASCII
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
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Security Identifier'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action'
  limit_up_limit_down_price_band_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Security Identifier'
      - id: luld_price_band_indicator
        type: u1
        enum: luld_price_band_indicator
        doc: 'LULD Price Band Indicator'
      - id: luld_timestamp
        type: u8
        doc: 'LULD Price Band Effective Time'
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
      - id: mwcb_status_level_indicator
        type: u1
        enum: mwcb_status_level_indicator
        doc: 'MWCB Status Level Indicator'
  auction_collar_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
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
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
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
        type: u8
        doc: 'Consolidated Volume'
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
        type: u8
        doc: 'Market Center Volume'
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
  volume:
    seq:
      - id: volume_message_type
        type: u1
        enum: volume_message_type
        doc: 'Volume Messages'
      - id: volume_payload
        size: _parent.message_header.message_length - 2 - 1
        type:
          switch-on: volume_message_type
          cases:
            'volume_message_type::total_consolidated_and_market_center_volume_message': total_consolidated_and_market_center_volume_message
  total_consolidated_and_market_center_volume_message:
    seq:
      - id: message_info
        type: message_info
      - id: total_consolidated_volume
        type: u8
        doc: 'Total Consolidated Volume'
      - id: num_market_center_volume_attachment
        type: u2
        doc: 'Number of Market Center Volumes'
      - id: market_center_volume_attachment
        type: market_center_volume_attachment
        repeat: expr
        repeat-expr: num_market_center_volume_attachment
  market_center_volume_attachment:
    seq:
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
      - id: current_market_center_volume
        type: u8
        doc: 'Current Market Center Volume'
  control:
    seq:
      - id: control_message_type
        type: u1
        enum: control_message_type
        doc: 'Control Messages'
      - id: control_payload
        size: _parent.message_header.message_length - 2 - 1
        type:
          switch-on: control_message_type
          cases:
            'control_message_type::start_of_day_message': start_of_day_message
            'control_message_type::end_of_day_message': end_of_day_message
            'control_message_type::market_session_open_message': market_session_open_message
            'control_message_type::market_session_close_message': market_session_close_message
            'control_message_type::end_of_transmissions_message': end_of_transmissions_message
            'control_message_type::end_of_trade_reporting_message': end_of_trade_reporting_message
            'control_message_type::end_of_consolidated_last_sale_eligibility': end_of_consolidated_last_sale_eligibility
  start_of_day_message:
    seq:
      - id: message_info
        type: message_info
  end_of_day_message:
    seq:
      - id: message_info
        type: message_info
  market_session_open_message:
    seq:
      - id: message_info
        type: message_info
  market_session_close_message:
    seq:
      - id: message_info
        type: message_info
  end_of_transmissions_message:
    seq:
      - id: message_info
        type: message_info
  end_of_trade_reporting_message:
    seq:
      - id: message_info
        type: message_info
  end_of_consolidated_last_sale_eligibility:
    seq:
      - id: message_info
        type: message_info
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
  trade_message_type:
    0x41:
      id: 'trade_report_message_short_form_message'
      doc: 'Used to disseminate Trade Reports'
    0x57:
      id: 'trade_report_message_long_form_message'
      doc: 'Used to disseminate Trade Reports'
    0x5a:
      id: 'trade_cancel_error_message'
      doc: 'Used to disseminate trade cancels or errors'
    0x59:
      id: 'trade_correction_message'
      doc: 'Used to disseminate trade corrections'
    0x48:
      id: 'prior_day_as_of_trade_message'
      doc: 'Used to disseminate trade prior day as of action'
  market_center_originator_id:
    0x59:
      id: 'byx'
      doc: 'Cboe BYX'
    0x5a:
      id: 'bzx'
      doc: 'Cboe BZX'
    0x4a:
      id: 'edga'
      doc: 'Cboe EDGA'
    0x4b:
      id: 'edgx'
      doc: 'Cboe EDGX'
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
      doc: 'Nasdaq ISE'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'arca'
      doc: 'NYSE Arca'
    0x41:
      id: 'american'
      doc: 'NYSE American'
    0x43:
      id: 'national'
      doc: 'NYSE National'
    0x4d:
      id: 'chicago'
      doc: 'NYSE Chicago'
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
      doc: 'MIAX Pearl'
    0x55:
      id: 'memx'
      doc: 'MEMX'
    0x45:
      id: 'market_independent'
      doc: 'Market Independent'
  sub_market_center_id:
    0x4e:
      id: 'nyse_trf'
      doc: 'NYSE TRF'
    0x51:
      id: 'nasdaq_trf_carteret'
      doc: 'Nasdaq TRF Carteret'
    0x42:
      id: 'nasdaq_trf_chicago'
      doc: 'Nasdaq TRF Chicago'
    0x20:
      id: 'finra_alternative_display_facility'
      doc: 'FINRA Alternative Display Facility'
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
      doc: 'Re-Opening Prints'
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
      doc: 'No prices changed'
    0x31:
      id: 'consolidated_last_price_changed'
      doc: 'Consolidated Last price changed'
    0x32:
      id: 'consolidated_low_price_changed'
      doc: 'Consolidated Low price changed'
    0x33:
      id: 'consolidated_last_and_consolidated_low_prices_changed'
      doc: 'Consolidated Last and Consolidated Low prices changed'
    0x34:
      id: 'consolidated_high_price_changed'
      doc: 'Consolidated High price changed'
    0x35:
      id: 'consolidated_last_and_consolidated_high_prices_changed'
      doc: 'Consolidated Last and Consolidated High prices changed'
    0x36:
      id: 'consolidated_high_and_consolidated_low_prices_changed'
      doc: 'Consolidated High and Consolidated Low prices changed'
    0x37:
      id: 'all_consolidated_prices_changed'
      doc: 'All Consolidated prices changed'
  participant_price_change_indicator:
    0x30:
      id: 'no_prices_changed'
      doc: 'No prices changed'
    0x31:
      id: 'participant_last_price_changed'
      doc: 'Participant Last price changed'
    0x32:
      id: 'participant_low_price_changed'
      doc: 'Participant Low price changed'
    0x33:
      id: 'participant_last_and_low_prices_changed'
      doc: 'Participant Last and Low prices changed'
    0x34:
      id: 'participant_high_price_changed'
      doc: 'Participant High price changed'
    0x35:
      id: 'participant_last_and_high_prices_changed'
      doc: 'Participant Last and High prices changed'
    0x36:
      id: 'participant_high_and_low_prices_changed'
      doc: 'Participant High and Low prices changed'
    0x37:
      id: 'all_participant_prices_changed'
      doc: 'All Participant prices changed'
  as_of_action:
    0x41:
      id: 'trade_addition'
      doc: 'Trade Addition'
    0x43:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
  administrative_message_type:
    0x41:
      id: 'general_administrative_message'
      doc: 'General Administrative'
    0x48:
      id: 'cross_sro_trading_action_message'
      doc: 'This fixed format message will be used to inform subscribers of trading actions – such as halts, pauses, quotation resumptions and trading resumptions'
    0x4b:
      id: 'market_center_trading_action_message'
      doc: 'This fixed format message will inform UTP data feed subscribers of when a UTP participant invokes or releases a market center-specific trading halt for a NASDAQ-listed security.'
    0x42:
      id: 'issue_symbol_directory_message'
      doc: 'General Administrative'
    0x56:
      id: 'regulation_sho_short_sale_price_test_restricted_indicator_message'
      doc: 'Used to disseminate quotation data for NASDAQ listed securities'
    0x50:
      id: 'limit_up_limit_down_price_band_message'
      doc: 'Designed to prevent trades in individual NMS Stocks from occurring outside of specified Upper and Lower Limit Price Bands'
    0x43:
      id: 'market_wide_circuit_breaker_decline_level_message'
      doc: 'A Market Wide Circuit Breaker (MWCB) Level message will inform participants and the UTP data recipients what the daily MWCB breach points are set to for the current trading day'
    0x44:
      id: 'market_wide_circuit_breaker_status_message'
      doc: 'A Market Wide Circuit Breaker (MWCB) Status message will inform participants and the UTP data recipients when a MWCB has breached one of the established levels.'
    0x45:
      id: 'auction_collar_message'
      doc: 'Primary markets using an automated reopening will calculate new Auction Collars, in compliance with rules around prices for re-opening, when applicable and publish this new Auction Collar Message'
    0x5a:
      id: 'closing_trade_summary_report_message'
      doc: 'The Closing Trade Summary Report will be disseminated three times daily'
  trading_action_code:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x51:
      id: 'quotation_resumption_including_after_ema'
      doc: 'Quotation Resumption, including after EMA'
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
      doc: 'Rule144A'
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
      doc: 'Shares of Beneficial Interest'
    0x54:
      id: 'convertible_debenture'
      doc: 'Convertible Debenture'
    0x55:
      id: 'unit'
      doc: 'Unit'
    0x56:
      id: 'units_of_beneficial_interest'
      doc: 'Units of Beneficial Interest'
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
      doc: 'Issue is restricted'
    0x4e:
      id: 'issue_is_not_restricted'
      doc: 'Issue is not restricted'
    0x20:
      id: 'not_available'
      doc: 'not available'
  financial_status_indicator:
    0x43:
      id: 'creations_and_or_redemptions_suspended'
      doc: 'Creations and or Redemptions Suspended for Exchange Traded Product'
    0x44:
      id: 'deficient'
      doc: 'Deficient Issuer Failed to Meet NASDAQ Continued Listing Requirements'
    0x45:
      id: 'delinquent'
      doc: 'Issuer Missed Regulatory Filing Deadline'
    0x51:
      id: 'bankrupt'
      doc: 'Issuer Has Filed for Bankruptcy'
    0x4e:
      id: 'normal'
      doc: 'Issuer Is NOT Deficient, Delinquent, or Bankrupt.'
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
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No price test in effect'
    0x31:
      id: 'reg_sho_in_effect_due_to_an_intra_day_price_drop'
      doc: 'Reg SHO in effect due to an intra day price drop'
    0x32:
      id: 'reg_sho_restriction_remains_in_effect'
      doc: 'Reg SHO Restriction remains in effect'
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
      doc: 'Suspended during trading halt or trading pause'
    0x45:
      id: 're_opening_update'
      doc: 'Re-Opening Update'
    0x46:
      id: 'outside_price_band_rule_hours'
      doc: 'Outside price band rule hours'
    0x20:
      id: 'none_provided'
      doc: 'None provided'
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
      doc: 'Based on M sale Condition'
    0x20:
      id: 'not_based_on_m_sale_condition'
      doc: 'Not Based on M sale Condition'
  volume_message_type:
    0x4d:
      id: 'total_consolidated_and_market_center_volume_message'
      doc: 'The Total Consolidated Market Center Volume message will be used to relay intraday values for the current total cumulative consolidated share volume and each active market center current cumulative volume activity as reported by all UTP participants in all NASDAQ issues'
  control_message_type:
    0x49:
      id: 'start_of_day_message'
      doc: 'The Start of Day control message signifies the beginning of each operational cycle for SIP Processing'
    0x4a:
      id: 'end_of_day_message'
      doc: 'The End of Day control message signals the end of active message dissemination for the UTP SIP operational cycle'
    0x4f:
      id: 'market_session_open_message'
      doc: 'The Market Session Open Control Message signifies the opening of market systems for the session indicated in the Message Header'
    0x43:
      id: 'market_session_close_message'
      doc: 'The Session Close Control Message signals the closing of market systems for the session indicated in the Message Header'
    0x5a:
      id: 'end_of_transmissions_message'
      doc: 'The End of Transmissions Message signals that there will be no further transmissions of data sent through the UTP SIP line'
    0x58:
      id: 'end_of_trade_reporting_message'
      doc: 'The End of Trade Reporting Control Message signals that SIP has completed its trade entry eligibility and that no further data will be accepted by the UTP SIP for the market session'
    0x53:
      id: 'end_of_consolidated_last_sale_eligibility'
      doc: 'The End of Consolidated Last Sale Eligibility control message signals the closing of the trade-reporting window for consolidated last sale calculation eligibility'

