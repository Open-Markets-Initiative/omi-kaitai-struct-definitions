# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq Uqdf Output Utp v1.5
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
# The Binary Data Compiler technologies used to produce this file
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
  id: nasdaq_uqdf_output_v1_5
  title: Nasdaq Uqdf Output Utp v1.5
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq UTP Quote Data Feed Output Utp v1.5'
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
            '"Q"': quote
            '"A"': administrative
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
  quote:
    seq:
      - id: quote_message_type
        type: u1
        enum: quote_message_type
        doc: 'Quote Messages'
      - id: quote_payload
        size: _parent.message_header.message_length - 2 - 1
        type:
          switch-on: quote_message_type
          cases:
            'quote_message_type::quote_short_form_message': quote_short_form_message
            'quote_message_type::quote_long_form_message': quote_long_form_message
            'quote_message_type::finra_adf_market_participant_quotation_message': finra_adf_market_participant_quotation_message
  quote_short_form_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        doc: 'Security Identifier'
      - id: bid_price_short
        type: u2
        doc: 'Bid Price Short. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Bid Size short'
      - id: ask_price_short
        type: u2
        doc: 'Ask Price short. Implied decimal with scale 1e-2'
      - id: ask_size_short
        type: u2
        doc: 'Ask Size short'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition'
      - id: sip_generated_update
        type: u1
        enum: sip_generated_update
        doc: 'SIP Generated Update'
      - id: luld_bbo_indicator
        type: u1
        enum: luld_bbo_indicator
        doc: 'LULD BBO Indicator'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Retail Interest Indicator'
      - id: nbbo_appendage_indicator
        type: u1
        enum: nbbo_appendage_indicator
        doc: 'NBBO Appendage Indicator'
      - id: luld_national_bbo_indicator
        type: u1
        enum: luld_national_bbo_indicator
        doc: 'LULD National BBO Indicator'
      - id: short_form_national_bbo_appendage
        type: short_form_national_bbo_appendage
      - id: long_form_national_bbo_appendage
        type: long_form_national_bbo_appendage
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
  short_form_national_bbo_appendage:
    seq:
      - id: nbbo_quote_condition
        type: u1
        enum: nbbo_quote_condition
        doc: 'NBBO Quote Condition'
      - id: national_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Bid Market Center'
      - id: national_best_bid_price_short
        type: u2
        doc: 'National Best Bid Price short. Implied decimal with scale 1e-2'
      - id: national_best_bid_size_short
        type: u2
        doc: 'National Best Bid Size short'
      - id: national_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Ask Market Center'
      - id: national_best_ask_price_short
        type: u2
        doc: 'National Best Ask Price Short. Implied decimal with scale 1e-2'
      - id: national_best_ask_size_short
        type: u2
        doc: 'National Best Ask Size Short'
  long_form_national_bbo_appendage:
    seq:
      - id: nbbo_quote_condition
        type: u1
        enum: nbbo_quote_condition
        doc: 'NBBO Quote Condition'
      - id: best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'Best Bid Market Center'
      - id: best_bid_price
        type: u8
        doc: 'Best Bid Price. Implied decimal with scale 1e-6'
      - id: best_bid_size
        type: u4
        doc: 'Best Bid Size'
      - id: best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'Best Ask Market Center'
      - id: best_ask_price
        type: u8
        doc: 'Best Ask Price. Implied decimal with scale 1e-6'
      - id: best_ask_size
        type: u4
        doc: 'Best Ask Size'
  quote_long_form_message:
    seq:
      - id: message_info
        type: message_info
      - id: finra_timestamp
        type: u8
        doc: 'FINRA Timestamp'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Security Identifier'
      - id: bid_price
        type: u8
        doc: 'Bid Price. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Bid Size'
      - id: ask_price
        type: u8
        doc: 'Ask Price. Implied decimal with scale 1e-6'
      - id: ask_size
        type: u4
        doc: 'Ask Size'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition'
      - id: sip_generated_update
        type: u1
        enum: sip_generated_update
        doc: 'SIP Generated Update'
      - id: luld_bbo_indicator
        type: u1
        enum: luld_bbo_indicator
        doc: 'LULD BBO Indicator'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Retail Interest Indicator'
      - id: nbbo_appendage_indicator
        type: u1
        enum: nbbo_appendage_indicator
        doc: 'NBBO Appendage Indicator'
      - id: luld_national_bbo_indicator
        type: u1
        enum: luld_national_bbo_indicator
        doc: 'LULD National BBO Indicator'
      - id: finra_adf_mpid_appendage_indicator
        type: u1
        enum: finra_adf_mpid_appendage_indicator
        doc: 'FINRA ADF MPID Appendage Indicator'
      - id: short_form_national_bbo_appendage
        type: short_form_national_bbo_appendage
      - id: long_form_national_bbo_appendage
        type: long_form_national_bbo_appendage
      - id: finra_adf_mpid_appendage
        type: finra_adf_mpid_appendage
  finra_adf_mpid_appendage:
    seq:
      - id: bid_adf_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bid ADF MPID'
      - id: ask_adf_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Ask ADF MPID'
  finra_adf_market_participant_quotation_message:
    seq:
      - id: message_info
        type: message_info
      - id: finra_timestamp
        type: u8
        doc: 'FINRA Timestamp'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Security Identifier'
      - id: bid_price
        type: u8
        doc: 'Bid Price. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Bid Size'
      - id: ask_price
        type: u8
        doc: 'Ask Price. Implied decimal with scale 1e-6'
      - id: ask_size
        type: u4
        doc: 'Ask Size'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition'
      - id: finra_market_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'FINRA Market Participant'
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
            'administrative_message_type::issue_symbol_directory_message': issue_symbol_directory_message
            'administrative_message_type::regulation_sho_short_sale_price_test_restricted_indicator_message': regulation_sho_short_sale_price_test_restricted_indicator_message
            'administrative_message_type::limit_up_limit_down_price_band_message': limit_up_limit_down_price_band_message
            'administrative_message_type::market_wide_circuit_breaker_decline_level_message': market_wide_circuit_breaker_decline_level_message
            'administrative_message_type::market_wide_circuit_breaker_decline_level_message_x44': market_wide_circuit_breaker_decline_level_message
            'administrative_message_type::auction_collar_message': auction_collar_message
            'administrative_message_type::session_close_recap_message': session_close_recap_message
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
        size: 11
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
        size: 11
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
        size: 11
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
        size: 11
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
        size: 11
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
        type: u8
        doc: 'Limit Down Price. Implied decimal with scale 1e-6'
      - id: limit_up_price
        type: u8
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
  auction_collar_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Security Identifier'
      - id: trading_action_sequence_number
        type: u4
        doc: 'Trading Action Sequence Number'
      - id: collar_reference_price
        type: u8
        doc: 'Reference price used to set collar. Implied decimal with scale 1e-6'
      - id: collar_up_price
        type: u8
        doc: 'Collar Up Price. Implied decimal with scale 1e-6'
      - id: collar_down_price
        type: u8
        doc: 'Collar Down Price. Implied decimal with scale 1e-6'
      - id: collar_extension_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Collar Extension Indicator'
  session_close_recap_message:
    seq:
      - id: message_info
        type: message_info
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Security Identifier'
      - id: national_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Bid Market Center'
      - id: national_best_bid_price
        type: u8
        doc: 'National Best Bid Price. Implied decimal with scale 1e-6'
      - id: national_best_bid_size
        type: u8
        doc: 'National Best Bid Size'
      - id: national_best_ask_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Ask Market Center'
      - id: national_best_ask_price
        type: u8
        doc: 'National Best Ask Price. Implied decimal with scale 1e-6'
      - id: national_best_ask_size
        type: u8
        doc: 'National Best Ask Size'
      - id: special_condition
        type: u1
        enum: special_condition
        doc: 'Special Condition'
      - id: num_market_center_close_recap
        type: u2
        doc: 'Number of Market Center Attachments'
      - id: market_center_close_recap
        type: market_center_close_recap
        repeat: expr
        repeat-expr: num_market_center_close_recap
  market_center_close_recap:
    seq:
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
      - id: market_center_bid_price
        type: u8
        doc: 'Market Center Bid Price. Implied decimal with scale 1e-6'
      - id: market_center_bid_size
        type: u8
        doc: 'Market Center Bid Size'
      - id: market_center_ask_price
        type: u8
        doc: 'Market Center Ask Price. Implied decimal with scale 1e-6'
      - id: market_center_ask_size
        type: u8
        doc: 'Market Center Ask Size'
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
            'control_message_type::quote_wipe_out_message': quote_wipe_out_message
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
  quote_wipe_out_message:
    seq:
      - id: message_info
        type: message_info

enums:
  quote_message_type:
    0x45:
      id: 'quote_short_form_message'
      doc: 'Used to disseminate quotation data for NASDAQ listed securities'
    0x46:
      id: 'quote_long_form_message'
      doc: 'Used to disseminate quotation data for NASDAQ listed securities'
    0x4d:
      id: 'finra_adf_market_participant_quotation_message'
      doc: 'For FINRA quotes that do not affect the NBBO or FINRA BBO a FINRA ADF Market Participant Quotation Message will be sent.'
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
  quote_condition:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid and Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed quote'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Non firm quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening quote automated'
    0x52:
      id: 'regular_two_sided_open_quote_automated'
      doc: 'Regular two sided open quote automated'
    0x55:
      id: 'manual_bid_and_ask_non_firm'
      doc: 'Manual Bid and Ask non firm'
    0x58:
      id: 'order_influx'
      doc: 'Order influx'
    0x59:
      id: 'automated_bid_no_offer_or_automated_offer_no_bid'
      doc: 'Automated bid, no offer or automated offer, no bid'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No open no resume'
    0x34:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  sip_generated_update:
    0x20:
      id: 'originated_from_the_market_participant'
      doc: 'Originated from the market participant'
    0x45:
      id: 'si_pgenerated_transaction'
      doc: 'SIP-generated transaction'
  luld_bbo_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'bid_price_above_upper_limit_price_band'
      doc: 'Bid Price above Upper Limit Price Band'
    0x42:
      id: 'ask_price_below_lower_limit_price_band'
      doc: 'Ask Price below Lower Limit Price Band'
    0x43:
      id: 'bid_and_ask_outside_price_band'
      doc: 'Bid and Ask outside price band'
  retail_interest_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'on_bid_quote'
      doc: 'On Bid Quote'
    0x42:
      id: 'on_ask_quote'
      doc: 'On Ask Quote'
    0x43:
      id: 'on_both_bid_and_ask_quote'
      doc: 'On both Bid and Ask Quote'
  nbbo_appendage_indicator:
    0x30:
      id: 'no_national_bbo_change'
      doc: 'No National BBO Change'
    0x31:
      id: 'no_national_bbo_can_be_calculated'
      doc: 'No National BBO Can be Calculated'
    0x32:
      id: 'short_form_national_bbo_appendage'
      doc: 'Short Form National BBO Appendage'
    0x33:
      id: 'long_form_national_bbo_appendage'
      doc: 'Long Form National BBO Appendage'
    0x34:
      id: 'quote_contains_all_national_bbo_information'
      doc: 'Long Form National BBO Appendage'
  luld_national_bbo_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'national_best_bid_and_national_best_ask_are_executable'
      doc: 'National Best Bid and National Best Ask are Executable'
    0x42:
      id: 'national_best_bid_below_lower_limit_price_band'
      doc: 'National Best Bid below Lower Limit Price Band'
    0x43:
      id: 'national_best_ask_above_upper_limit_price_band'
      doc: 'National Best Ask above Upper Limit Price Band'
    0x44:
      id: 'national_best_bid_below_lower_limit_price_band_and_national_best_ask_above_upper_limit_price_band'
      doc: 'National Best Bid below Lower Limit Price Band and National Best Ask above Upper Limit Price Band'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band'
      doc: 'National Best Bid equals Upper Limit Price Band'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Offer equals Lower Limit Price Band'
    0x47:
      id: 'national_best_bid_equals_upper_limit_price_band_x47'
      doc: 'National Best Bid equals Upper Limit Price Band'
    0x48:
      id: 'national_best_ask_equals_lower_limit_price_band'
      doc: 'National Best Ask equals Lower Limit Price Band'
    0x49:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_ask_equals_lower_limit_price_band'
      doc: 'National Best Bid equals Upper Limit Price Band and National Best Ask equals Lower Limit Price Band'
  nbbo_quote_condition:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid and Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed quote'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Non firm quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening quote automated'
    0x52:
      id: 'regular_two_sided_open_quote_automated'
      doc: 'Regular two sided open quote automated'
    0x55:
      id: 'manual_bid_and_ask_non_firm'
      doc: 'Manual Bid and Ask non firm'
    0x58:
      id: 'order_influx'
      doc: 'Order influx'
    0x59:
      id: 'automated_bid_no_offer_or_automated_offer_no_bid'
      doc: 'Automated bid, no offer or automated offer, no bid'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No open no resume'
    0x34:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  finra_adf_mpid_appendage_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not applicable'
    0x30:
      id: 'no_adf_mpid_changes'
      doc: 'No ADF MPID changes'
    0x31:
      id: 'no_adf_mpid_exists'
      doc: 'No ADF MPID exists'
    0x32:
      id: 'adf_mpi_ds_attached'
      doc: 'ADF MPIDs attached'
  administrative_message_type:
    0x41:
      id: 'general_administrative_message'
      doc: 'General Administrative'
    0x48:
      id: 'cross_sro_trading_action_message'
      doc: 'This fixed format message will be used to inform subscribers of trading actions – such as halts, pauses, quotation resumptions and trading resumptions'
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
      id: 'market_wide_circuit_breaker_decline_level_message_x44'
      doc: 'A Market Wide Circuit Breaker (MWCB) Status message will inform participants and the UTP data recipients when a MWCB has breached one of the established levels.'
    0x45:
      id: 'auction_collar_message'
      doc: 'Primary markets using an automated reopening will calculate new Auction Collars, in compliance with rules around prices for re-opening, when applicable and publish this new Auction Collar Message'
    0x52:
      id: 'session_close_recap_message'
      doc: 'At the request of the market data community, the UTP SIP generates a Session Close Recap message that reflects the National BBO quotation information at the close of the normal market session'
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
    0x47:
      id: 'normal_x47'
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
  special_condition:
    0x4f:
      id: 'one_sided_national_bbo_at_market_close'
      doc: 'One Sided National BBO at Market Close'
    0x48:
      id: 'trading_halt_in_effect_at_market_close'
      doc: 'Trading Halt In Effect at Market Close'
    0x4d:
      id: 'no_eligible_market_participant_quotes_in_issue_at_market_close'
      doc: 'No Eligible Market Participant Quotes in Issue at Market Close'
    0x20:
      id: 'no_special_condition_exists'
      doc: 'No Special Condition exists'
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
    0x50:
      id: 'quote_wipe_out_message'
      doc: 'The Quote Wipe-Out message will be sent to indicate that a UTP Participant is experiencing a problem with their internal systems and, as a result, are not able to update their UTP BBO quotation information'

