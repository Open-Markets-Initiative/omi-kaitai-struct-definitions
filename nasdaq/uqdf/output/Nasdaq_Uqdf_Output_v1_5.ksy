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
  id: nasdaq_uqdf_output_utp_v1_5
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
            '"Q"': quote_message
            '"A"': administrative_message
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
  quote_message:
    seq:
      - id: quote_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Quote message type'
      - id: quote_message_payload
        type:
          switch-on: quote_message_type
          cases:
            '"E"': quote_short_form_message
            '"F"': quote_long_form_message
            '"M"': finra_adf_market_participant_quotation_message
  quote_short_form_message:
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
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Bid Price Short. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Bid Size short'
      - id: ask_price_short
        type: decimal_u2_2
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
        if: nbbo_appendage_indicator == nbbo_appendage_indicator::short_form_national_bbo_appendage
        doc: 'Short Form National BBO Appendage'
      - id: long_form_national_bbo_appendage
        type: long_form_national_bbo_appendage
        if: nbbo_appendage_indicator == nbbo_appendage_indicator::long_form_national_bbo_appendage
        doc: 'Long Form National BBO Appendage'
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
        type: decimal_u2_2
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
        type: decimal_u2_2
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
        type: decimal_u8_6
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
        type: decimal_u8_6
        doc: 'Best Ask Price. Implied decimal with scale 1e-6'
      - id: best_ask_size
        type: u4
        doc: 'Best Ask Size'
  quote_long_form_message:
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
      - id: bid_price
        type: decimal_u8_6
        doc: 'Bid Price. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Bid Size'
      - id: ask_price
        type: decimal_u8_6
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
        if: nbbo_appendage_indicator == nbbo_appendage_indicator::short_form_national_bbo_appendage
        doc: 'Short Form National BBO Appendage'
      - id: long_form_national_bbo_appendage
        type: long_form_national_bbo_appendage
        if: nbbo_appendage_indicator == nbbo_appendage_indicator::long_form_national_bbo_appendage
        doc: 'Long Form National BBO Appendage'
      - id: finra_adf_mpid_appendage
        type: finra_adf_mpid_appendage
        if: finra_adf_mpid_appendage_indicator == finra_adf_mpid_appendage_indicator::adf_mpi_ds_attached
        doc: 'FINRA ADF MPID Appendage'
  finra_adf_mpid_appendage:
    seq:
      - id: bid_adf_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid ADF MPID'
      - id: ask_adf_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask ADF MPID'
  finra_adf_market_participant_quotation_message:
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
      - id: bid_price
        type: decimal_u8_6
        doc: 'Bid Price. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Bid Size'
      - id: ask_price
        type: decimal_u8_6
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
        pad-right: 0x20
        doc: 'FINRA Market Participant'
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
            '"R"': session_close_recap_message
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
  session_close_recap_message:
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
      - id: national_best_bid_market_center
        type: str
        size: 1
        encoding: ASCII
        doc: 'National Best Bid Market Center'
      - id: national_best_bid_price
        type: decimal_u8_6
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
        type: decimal_u8_6
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
        doc: 'At the request of the market data community, the UTP SIP generates a Session Close Recap message that reflects the National BBO quotation information at the close of the normal market session'
  market_center_close_recap:
    seq:
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
      - id: market_center_bid_price
        type: decimal_u8_6
        doc: 'Market Center Bid Price. Implied decimal with scale 1e-6'
      - id: market_center_bid_size
        type: u8
        doc: 'Market Center Bid Size'
      - id: market_center_ask_price
        type: decimal_u8_6
        doc: 'Market Center Ask Price. Implied decimal with scale 1e-6'
      - id: market_center_ask_size
        type: u8
        doc: 'Market Center Ask Size'
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
            '"P"': quote_wipe_out_message
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
  quote_wipe_out_message:
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
  quote_condition:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask Automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid Automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast Trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid And Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed Quote'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Non Firm Quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening Quote Automated'
    0x52:
      id: 'regular_two_sided_open_quote_automated'
      doc: 'Regular Two Sided Open Quote Automated'
    0x55:
      id: 'manual_bid_and_ask_non_firm'
      doc: 'Manual Bid And Ask Non Firm'
    0x58:
      id: 'order_influx'
      doc: 'Order Influx'
    0x59:
      id: 'automated_bid_no_offer_or_automated_offer_no_bid'
      doc: 'Automated Bid No Offer Or Automated Offer No Bid'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No Open No Resume'
    0x34:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  sip_generated_update:
    0x20:
      id: 'originated_from_the_market_participant'
      doc: 'Originated From The Market Participant'
    0x45:
      id: 'si_pgenerated_transaction'
      doc: 'Si Pgenerated Transaction'
  luld_bbo_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'bid_price_above_upper_limit_price_band'
      doc: 'Bid Price Above Upper Limit Price Band'
    0x42:
      id: 'ask_price_below_lower_limit_price_band'
      doc: 'Ask Price Below Lower Limit Price Band'
    0x43:
      id: 'bid_and_ask_outside_price_band'
      doc: 'Bid And Ask Outside Price Band'
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
      doc: 'On Both Bid And Ask Quote'
  nbbo_appendage_indicator:
    0x30:
      id: 'no_national_bbo_change'
      doc: 'No National Bbo Change'
    0x31:
      id: 'no_national_bbo_can_be_calculated'
      doc: 'No National Bbo Can Be Calculated'
    0x32:
      id: 'short_form_national_bbo_appendage'
      doc: 'Short Form National Bbo Appendage'
    0x33:
      id: 'long_form_national_bbo_appendage'
      doc: 'Long Form National Bbo Appendage'
    0x34:
      id: 'quote_contains_all_national_bbo_information'
      doc: 'Long Form National Bbo Appendage'
  luld_national_bbo_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'national_best_bid_and_national_best_ask_are_executable'
      doc: 'National Best Bid And National Best Ask Are Executable'
    0x42:
      id: 'national_best_bid_below_lower_limit_price_band'
      doc: 'National Best Bid Below Lower Limit Price Band'
    0x43:
      id: 'national_best_ask_above_upper_limit_price_band'
      doc: 'National Best Ask Above Upper Limit Price Band'
    0x44:
      id: 'national_best_bid_below_lower_limit_price_band_and_national_best_ask_above_upper_limit_price_band'
      doc: 'National Best Bid Below Lower Limit Price Band And National Best Ask Above Upper Limit Price Band'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band'
      doc: 'National Best Bid Equals Upper Limit Price Band'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Offer Equals Lower Limit Price Band'
    0x47:
      id: 'national_best_bid_equals_upper_limit_price_band_x47'
      doc: 'National Best Bid Equals Upper Limit Price Band'
    0x48:
      id: 'national_best_ask_equals_lower_limit_price_band'
      doc: 'National Best Ask Equals Lower Limit Price Band'
    0x49:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_ask_equals_lower_limit_price_band'
      doc: 'National Best Bid Equals Upper Limit Price Band And National Best Ask Equals Lower Limit Price Band'
  nbbo_quote_condition:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask Automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid Automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast Trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid And Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed Quote'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Non Firm Quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening Quote Automated'
    0x52:
      id: 'regular_two_sided_open_quote_automated'
      doc: 'Regular Two Sided Open Quote Automated'
    0x55:
      id: 'manual_bid_and_ask_non_firm'
      doc: 'Manual Bid And Ask Non Firm'
    0x58:
      id: 'order_influx'
      doc: 'Order Influx'
    0x59:
      id: 'automated_bid_no_offer_or_automated_offer_no_bid'
      doc: 'Automated Bid No Offer Or Automated Offer No Bid'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No Open No Resume'
    0x34:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  finra_adf_mpid_appendage_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x30:
      id: 'no_adf_mpid_changes'
      doc: 'No Adf Mpid Changes'
    0x31:
      id: 'no_adf_mpid_exists'
      doc: 'No Adf Mpid Exists'
    0x32:
      id: 'adf_mpi_ds_attached'
      doc: 'Adf Mpi Ds Attached'
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
  special_condition:
    0x4f:
      id: 'one_sided_national_bbo_at_market_close'
      doc: 'One Sided National Bbo At Market Close'
    0x48:
      id: 'trading_halt_in_effect_at_market_close'
      doc: 'Trading Halt In Effect At Market Close'
    0x4d:
      id: 'no_eligible_market_participant_quotes_in_issue_at_market_close'
      doc: 'No Eligible Market Participant Quotes In Issue At Market Close'
    0x20:
      id: 'no_special_condition_exists'
      doc: 'No Special Condition Exists'

