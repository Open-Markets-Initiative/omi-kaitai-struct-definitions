# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cts Input Cta v2.7.f
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.7.f
#   Date: 01/29/2026
#   Specification: CTS_Pillar_Input_Specification.pdf
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
  id: siac_cts_input_cta_v2_7_f
  title: Siac Cts Input Cta v2.7.f
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Tape System Cta v2.7.f'
doc-ref: https://www.ctaplan.com/tech-specs

seq:
  - id: block_separator
    type: u2
    doc: 'Fixed 2-byte sequence 0xA5 0x5A that precedes every block. Not included in Block Size'
  - id: block_header
    type: block_header_struct
    doc: 'Cta participant input block header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: block_header.messages_in_block
    doc: 'Cta participant input message'
  - id: block_pad_byte
    type: u1
    if: _io.pos % 2 != 0
    doc: 'Binary zero pad byte present when the block would otherwise be an odd number of bytes'

types:
  block_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Designates the Cta binary protocol version'
      - id: block_size
        type: u2
        doc: 'Size in bytes of the entire transmission block'
      - id: block_sequence_number
        type: u4
        doc: 'Sequential block sequence number; rolls over after 4,294,967,295'
      - id: messages_in_block
        type: u1
        doc: 'Number of messages contained in the block data'
      - id: block_checksum
        type: u2
        doc: 'Lower 2 bytes of the 4-byte sum of all bytes in the block, excluding this Block Checksum field'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Cta participant input message header (26 bytes)'
      - id: category_payload
        size: message_header.message_length - 26
        type:
          switch-on: message_header.message_category
          cases:
            'message_category::administrative': administrative_message
            'message_category::control': control_message
            'message_category::indices': indices_message
            'message_category::market_status': market_status_message
            'message_category::prior_day': prior_day_message
            'message_category::trade': trade_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Total message length inclusive of the Message Header and Message Body'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Message classification (Administrative, Control, Index, Market Status, Prior Day, Trade)'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Together with Message Category identifies the message'
      - id: participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Participant-provided timestamp'
      - id: message_id
        type: u1
        doc: 'Identifies the individual message within the block, beginning with one (1) and incremented for subsequent messages within a block'
      - id: reserved
        type: str
        size: 4
        encoding: ASCII
        doc: 'Reserved for Future Use (TBD), space filled'
      - id: participant_reference_number
        type: s8
        doc: 'Unique reference number per Participant ID, Trade Reporting Facility, and Security Symbol; encodes a 6-byte ASCII Regional Reference Number in the low 6 bytes with the upper 2 bytes set to binary zero'
  timestamp_1:
    seq:
      - id: seconds
        type: u4
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond portion of the timestamp'
  administrative_message:
    seq:
      - id: administrative_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Type Of Administrative Message'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            '"R"': rejection_message
            '"W"': warning_message
  rejection_message:
    seq:
      - id: error_code
        type: u1
        doc: 'Error Code Indicating The First Error Encountered While Validating The Rejected Participant Input Message'
      - id: block_sequence_number
        type: u4
        doc: 'Sequential block sequence number; rolls over after 4,294,967,295'
      - id: participant_reference_number
        type: s8
        doc: 'Unique reference number per Participant ID, Trade Reporting Facility, and Security Symbol; encodes a 6-byte ASCII Regional Reference Number in the low 6 bytes with the upper 2 bytes set to binary zero'
      - id: message_id
        type: u1
        doc: 'Identifies the individual message within the block, beginning with one (1) and incremented for subsequent messages within a block'
  warning_message:
    seq:
      - id: previous_block_sequence_number
        type: u4
        doc: 'Block Sequence Number Prior To The Gap That Triggered The Warning'
      - id: previous_participant_reference_number
        type: s8
        doc: 'Participant Reference Number Prior To The Gap That Triggered The Warning'
  control_message:
    seq:
      - id: control_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Type Of Control Message'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            '"N"': sequence_information_and_message_count_response_message
            '"5"': test_message
  sequence_information_and_message_count_response_message:
    seq:
      - id: current_block_sequence_number
        type: u4
        doc: 'Next Expected Participant Block Sequence Number Returned By Cts In A Sequence Information And Message Count Response'
      - id: last_participant_reference_number
        type: s8
        doc: 'Last Participant Reference Number Received By Cts On The Individual Line'
      - id: message_count
        type: u8
        doc: 'Count Of Messages Received On The Individual Line Since Startup Excludes Line Integrity And Sequence Information And Message Count Inquiry Messages'
  test_message:
    seq:
      - id: data
        type: str
        size: 256
        encoding: ASCII
        pad-right: 0x20
        doc: 'All Ascii Characters Starting With Hex 0 And Ending Hex Ff In Sequential Order'
  indices_message:
    seq:
      - id: indices_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Type Of Index Message'
      - id: indices_message_payload
        type:
          switch-on: indices_message_type
          cases:
            '"I"': index_message
            '"Q"': bid_and_offer_index_message
  index_message:
    seq:
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Contains The Index Symbol'
      - id: index_value
        type: s8
        doc: 'Index Value Not A Price With Implied 6 Decimal Places'
  bid_and_offer_index_message:
    seq:
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Contains The Index Symbol'
      - id: bid_index_value
        type: s8
        doc: 'Index Value Not A Price Representing The Indexs Calculation Formula Using Current Bid Values Of The Component Securities Implied 6 Decimal Places'
      - id: offer_index_value
        type: s8
        doc: 'Index Value Not A Price Representing The Indexs Calculation Formula Using Current Offer Values Of The Component Securities Implied 6 Decimal Places'
  market_status_message:
    seq:
      - id: market_status_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Type Of Market Status Message'
      - id: market_status_message_payload
        type:
          switch-on: market_status_message_type
          cases:
            '"O"': approximate_trades_and_total_dollar_value_message
            '"P"': crossing_session_message
  approximate_trades_and_total_dollar_value_message:
    seq:
      - id: total_trades
        type: u4
        doc: 'Total Number Of Trade Transactions Executed From A Participant Optional Set To Zero'
      - id: dollar_value
        type: u8
        doc: 'Total Dollar Worth Of The Daily Trade Transactions Implied 6 Decimal Places Optional Set To Zero'
  crossing_session_message:
    seq:
      - id: crossing_session_i_total_trades_volume
        type: u8
        doc: 'Shares Traded At The Participants Close Price After The Close Of The Participants Regular Session Optional Set To Zero'
      - id: crossing_session_ii_dollar_value
        type: u8
        doc: 'Dollar Value Traded After The Close Of The Participants Regular Session Implied 6 Decimal Places Optional Set To Zero'
      - id: crossing_session_ii_total_trades_volume
        type: u8
        doc: 'Shares Traded After The Close Of The Participants Regular Session Optional Set To Zero'
  prior_day_message:
    seq:
      - id: prior_day_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Type Of Prior Day Message'
      - id: prior_day_message_payload
        type:
          switch-on: prior_day_message_type
          cases:
            '"C"': prior_day_trade_correction_message
            '"O"': fractional_prior_day_trade_correction_message
            '"T"': prior_day_trade_message
            '"R"': fractional_prior_day_trade_message
            '"X"': prior_day_trade_cancel_error_message
            '"E"': fractional_prior_day_trade_cancel_error_message
  prior_day_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition Four Positional Category Levels Per Sale Condition Table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Monetary Value Of An Individual Share Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected Total Number Of Shares Traded'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Sellers Sale Days Allowed Values 2 Through 60 Optional Set To Zero'
      - id: corrected_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Stop Stock Indicator'
      - id: corrected_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Trade Through Exempt Indicator'
      - id: corrected_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Short Sale Restriction Indicator'
      - id: corrected_prior_day_trade_date_and_time
        type: corrected_prior_day_trade_date_and_time
        doc: 'Corrected Prior Day Trade Date and Time'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition Four Positional Category Levels Per Sale Condition Table'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Monetary Value Of An Individual Share Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: original_trade_volume
        type: u4
        doc: 'Original Total Number Of Shares Traded'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original Sellers Sale Days Allowed Values 2 Through 60 Optional Set To Zero'
      - id: original_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Stop Stock Indicator'
      - id: original_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Indicator'
      - id: original_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Short Sale Restriction Indicator'
      - id: original_prior_day_trade_date_and_time
        type: original_prior_day_trade_date_and_time
        doc: 'Original Prior Day Trade Date and Time'
  corrected_prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: u4
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond portion of the timestamp'
  original_prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: u4
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond portion of the timestamp'
  fractional_prior_day_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition Four Positional Category Levels Per Sale Condition Table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Monetary Value Of An Individual Share Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: corrected_fractional_trade_volume
        type: u8
        doc: 'Corrected Total Number Of Shares Represented In Fraction Traded Implied 6 Decimal Places'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Sellers Sale Days Allowed Values 2 Through 60 Optional Set To Zero'
      - id: corrected_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Stop Stock Indicator'
      - id: corrected_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Trade Through Exempt Indicator'
      - id: corrected_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Short Sale Restriction Indicator'
      - id: corrected_prior_day_trade_date_and_time
        type: corrected_prior_day_trade_date_and_time
        doc: 'Corrected Prior Day Trade Date and Time'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition Four Positional Category Levels Per Sale Condition Table'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Monetary Value Of An Individual Share Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: original_fractional_trade_volume
        type: u8
        doc: 'Original Total Number Of Shares Represented In Fraction Traded Implied 6 Decimal Places'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original Sellers Sale Days Allowed Values 2 Through 60 Optional Set To Zero'
      - id: original_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Stop Stock Indicator'
      - id: original_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Indicator'
      - id: original_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Short Sale Restriction Indicator'
      - id: original_prior_day_trade_date_and_time
        type: original_prior_day_trade_date_and_time
        doc: 'Original Prior Day Trade Date and Time'
  prior_day_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: sellers_sale_days
        type: u1
        doc: 'Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Optional Set To Zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether A Trade Is Considered A Stop Stock At The Time Of The Trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611 And When Used Jointly With Certain Sale Conditions Describes The Characteristics Of A Particular Trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect By The Primary Listing Market For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time'
  prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: u4
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond portion of the timestamp'
  fractional_prior_day_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total Number Of Shares Represented In Fraction Traded In A Single Transaction Implied 6 Decimal Places Optional Set To Zero'
      - id: sellers_sale_days
        type: u1
        doc: 'Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Optional Set To Zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether A Trade Is Considered A Stop Stock At The Time Of The Trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611 And When Used Jointly With Certain Sale Conditions Describes The Characteristics Of A Particular Trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect By The Primary Listing Market For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time'
  prior_day_trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: sellers_sale_days
        type: u1
        doc: 'Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Optional Set To Zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether A Trade Is Considered A Stop Stock At The Time Of The Trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611 And When Used Jointly With Certain Sale Conditions Describes The Characteristics Of A Particular Trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect By The Primary Listing Market For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes Whether The Referenced Transaction Is To Be Cancelled Or Errored'
  fractional_prior_day_trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total Number Of Shares Represented In Fraction Traded In A Single Transaction Implied 6 Decimal Places Optional Set To Zero'
      - id: sellers_sale_days
        type: u1
        doc: 'Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Optional Set To Zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether A Trade Is Considered A Stop Stock At The Time Of The Trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611 And When Used Jointly With Certain Sale Conditions Describes The Characteristics Of A Particular Trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect By The Primary Listing Market For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes Whether The Referenced Transaction Is To Be Cancelled Or Errored'
  trade_message:
    seq:
      - id: trade_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Type Of Trade Message'
      - id: trade_message_payload
        type:
          switch-on: trade_message_type
          cases:
            '"A"': auction_status_message
            '"C"': trade_correction_message
            '"O"': fractional_trade_correction_message
            '"L"': long_trade_message
            '"R"': fractional_long_trade_message
            '"S"': trading_status_message
            '"T"': short_trade_message
            '"H"': fractional_short_trade_message
            '"X"': trade_cancel_error_message
  auction_status_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'Price Used By The Exchange To Establish The Auction Collar Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Latest Upper Threshold Price Of The Auction Collar Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Latest Lower Threshold Price Of The Auction Collar Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Number Of Manual Or Automatic Extensions The Applicable Auction Has Received Optional Set To Zero'
      - id: reserved_62
        type: str
        size: 62
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved For Future Use Tbd'
  trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition Four Positional Category Levels Per Sale Condition Table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Monetary Value Of An Individual Share Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected Total Number Of Shares Traded'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Sellers Sale Days Allowed Values 2 Through 60 Optional Set To Zero'
      - id: corrected_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Stop Stock Indicator'
      - id: corrected_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Trade Through Exempt Indicator'
      - id: corrected_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Short Sale Restriction Indicator'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
      - id: original_participant_reference_number
        type: s8
        doc: 'Participant Reference Number Of The Original Transaction Being Corrected Cancelled Or Errored'
  timestamp_2:
    seq:
      - id: seconds
        type: u4
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond portion of the timestamp'
  fractional_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition Four Positional Category Levels Per Sale Condition Table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Monetary Value Of An Individual Share Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: corrected_fractional_trade_volume
        type: u8
        doc: 'Corrected Total Number Of Shares Represented In Fraction Traded Implied 6 Decimal Places'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Sellers Sale Days Allowed Values 2 Through 60 Optional Set To Zero'
      - id: corrected_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Stop Stock Indicator'
      - id: corrected_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Trade Through Exempt Indicator'
      - id: corrected_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Short Sale Restriction Indicator'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
      - id: original_participant_reference_number
        type: s8
        doc: 'Participant Reference Number Of The Original Transaction Being Corrected Cancelled Or Errored'
  long_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: sellers_sale_days
        type: u1
        doc: 'Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Optional Set To Zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether A Trade Is Considered A Stop Stock At The Time Of The Trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611 And When Used Jointly With Certain Sale Conditions Describes The Characteristics Of A Particular Trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
  fractional_long_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total Number Of Shares Represented In Fraction Traded In A Single Transaction Implied 6 Decimal Places Optional Set To Zero'
      - id: sellers_sale_days
        type: u1
        doc: 'Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Optional Set To Zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether A Trade Is Considered A Stop Stock At The Time Of The Trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611 And When Used Jointly With Certain Sale Conditions Describes The Characteristics Of A Particular Trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
  trading_status_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: last_price_opening_reopening_luld_reference_price
        type: decimal_u8_6
        doc: 'Last Price For A Security When Security Status Is Set To Luld Reference Price Contains The Opening Reopening Luld Reference Price Reported By The Listing Exchange Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: high_indication_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'High Indication Price For Trading Range Or When Paired With Luld Trading Pause The Upper Limit Price Band Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: low_indication_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'Low Indication Price For Trading Range Or When Paired With Luld Trading Pause The Lower Limit Price Band Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: buy_volume
        type: u4
        doc: 'Reported Imbalance Of Buy Orders Without Matching Sell Orders For The Security For A Participant Optional Set To Zero'
      - id: sell_volume
        type: u4
        doc: 'Reported Imbalance Of Sell Orders Without Matching Buy Orders For The Security For A Participant'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Trading Action Related To The Transaction'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Reason For A Trading Halt'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect By The Primary Listing Market For A Security'
      - id: trading_status_id
        type: u4
        doc: 'Unique Identifier For Each Trading Status Message Used To Eliminate Duplicate Trading Status Messages Received Over Cqs And Cts Input Lines'
  short_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'Identifies The Sale Condition Category Level Associated With A Short Trade'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved For Future Use Tbd'
  fractional_short_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition For Longform Messages Four Positional Category Levels Per Sale Condition Table'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'Identifies The Sale Condition Category Level Associated With A Short Trade'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary Value Of An Individual Share At The Time Of The Trade Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total Number Of Shares Represented In Fraction Traded In A Single Transaction Implied 6 Decimal Places Optional Set To Zero'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved For Future Use Tbd'
  trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611 And When Used Jointly With Certain Sale Conditions Describes The Characteristics Of A Particular Trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled When Trf Not Applicable'
      - id: original_participant_reference_number
        type: s8
        doc: 'Participant Reference Number Of The Original Transaction Being Corrected Cancelled Or Errored'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes Whether The Referenced Transaction Is To Be Cancelled Or Errored'
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  message_category:
    0x41:
      id: 'administrative'
      doc: 'Administrative Category Sent From Cts To Participant'
    0x43:
      id: 'control'
      doc: 'Control Category Source May Be Either Participant Or Cts Processor'
    0x49:
      id: 'indices'
      doc: 'Index Category Index Messages Provide Index Value Information For A Security'
    0x4d:
      id: 'market_status'
      doc: 'Market Status Category Market Status Messages Provide Market Data Information'
    0x50:
      id: 'prior_day'
      doc: 'Prior Day Category Reports Cta Eligible Equity Local Issue Or Bond Trades Corrections Cancels Or Errors For Transactions That Occurred Earlier Than The Current Trading Day'
    0x54:
      id: 'trade'
      doc: 'Trade Category Reports Cta Eligible Equity Local Issue Or Bond Trade Information Including Automated Corrections Cancellations Errors Trading Halts Resumes Indications And Imbalances'
  instrument_type:
    0x30:
      id: 'cta_eligible_equity'
      doc: 'Cta Eligible Equity'
    0x31:
      id: 'local_issue'
      doc: 'Local Issue'
    0x32:
      id: 'corporate_bond'
      doc: 'Corporate Bond'
    0x33:
      id: 'government_bond'
      doc: 'Government Bond'
  trade_reporting_facility_id:
    0x20:
      id: 'trf_not_applicable'
      doc: 'Trf Not Applicable'
    0x64:
      id: 'finra_adf'
      doc: 'Finra Adf'
    0x42:
      id: 'finra_nasdaq_trf_chicago'
      doc: 'Finra Nasdaq Trf Chicago'
    0x4e:
      id: 'finra_nyse_trf'
      doc: 'Finra Nyse Trf'
    0x54:
      id: 'finra_nasdaq_trf_carteret'
      doc: 'Finra Nasdaq Trf Carteret'
  stop_stock_indicator:
    0x30:
      id: 'stop_stock_not_applicable'
      doc: 'Stop Stock Not Applicable'
    0x31:
      id: 'stop_stock'
      doc: 'Stop Stock'
  trade_through_exempt_indicator:
    0x30:
      id: 'not_a_trade_through_exemption'
      doc: 'Not A Trade Through Exemption'
    0x31:
      id: 'trade_through_exemption'
      doc: 'Trade Through Exemption'
  short_sale_restriction_indicator:
    0x20:
      id: 'short_sale_restriction_not_applicable'
      doc: 'Short Sale Restriction Not Applicable'
    0x41:
      id: 'short_sale_restriction_activated'
      doc: 'Short Sale Restriction Activated'
    0x43:
      id: 'short_sale_restriction_continued'
      doc: 'Short Sale Restriction Continued'
    0x44:
      id: 'short_sale_restriction_deactivated'
      doc: 'Short Sale Restriction Deactivated'
    0x45:
      id: 'short_sale_restriction_in_effect'
      doc: 'Short Sale Restriction In Effect'
  cancel_error_action:
    0x31:
      id: 'cancel'
      doc: 'Cancel'
    0x32:
      id: 'error'
      doc: 'Error'
  security_status:
    0x20:
      id: 'security_status_not_applicable'
      doc: 'Security Status Not Applicable'
    0x32:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x33:
      id: 'resume'
      doc: 'Resume'
    0x35:
      id: 'price_indication'
      doc: 'Price Indication'
    0x36:
      id: 'trading_range_indication'
      doc: 'Trading Range Indication'
    0x37:
      id: 'market_imbalance_buy'
      doc: 'Market Imbalance Buy'
    0x38:
      id: 'market_imbalance_sell'
      doc: 'Market Imbalance Sell'
    0x39:
      id: 'closing_imbalance_buy'
      doc: 'Closing Imbalance Buy'
    0x41:
      id: 'closing_imbalance_sell'
      doc: 'Closing Imbalance Sell'
    0x43:
      id: 'no_market_imbalance'
      doc: 'No Market Imbalance'
    0x44:
      id: 'no_closing_imbalance'
      doc: 'No Closing Imbalance'
    0x45:
      id: 'short_sale_restriction'
      doc: 'Short Sale Restriction'
    0x46:
      id: 'limit_up_limit_down_luld_reference_price'
      doc: 'Limit Up Limit Down Luld Reference Price'
  halt_reason:
    0x20:
      id: 'halt_reason_not_applicable'
      doc: 'Halt Reason Not Applicable'
    0x41:
      id: 'additional_information_requested'
      doc: 'Additional Information Requested'
    0x43:
      id: 'regulatory_concern'
      doc: 'Regulatory Concern'
    0x44:
      id: 'news_released'
      doc: 'News Released'
    0x45:
      id: 'merger_effective'
      doc: 'Merger Effective'
    0x46:
      id: 'etf_component_prices_not_available'
      doc: 'Etf Component Prices Not Available'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4d:
      id: 'limit_up_limit_down_luld_trading_pause'
      doc: 'Limit Up Limit Down Luld Trading Pause'
    0x4e:
      id: 'corporate_action'
      doc: 'Corporate Action'
    0x4f:
      id: 'new_security_offering'
      doc: 'New Security Offering'
    0x50:
      id: 'news_pending'
      doc: 'News Pending'
    0x56:
      id: 'intraday_indicative_value_not_available'
      doc: 'Intraday Indicative Value Not Available'
    0x58:
      id: 'operational'
      doc: 'Operational'
    0x59:
      id: 'sub_penny_trading'
      doc: 'Sub Penny Trading'
    0x31:
      id: 'market_wide_circuit_breaker_level_1_breached'
      doc: 'Market Wide Circuit Breaker Level 1 Breached'
    0x32:
      id: 'market_wide_circuit_breaker_level_2_breached'
      doc: 'Market Wide Circuit Breaker Level 2 Breached'
    0x33:
      id: 'market_wide_circuit_breaker_level_3_breached'
      doc: 'Market Wide Circuit Breaker Level 3 Breached'
  sale_condition_category:
    0x20:
      id: 'sale_condition_category_not_applicable'
      doc: 'Sale Condition Category Not Applicable'
    0x31:
      id: 'sale_condition_category_1'
      doc: 'Sale Condition Category 1'
    0x32:
      id: 'sale_condition_category_2'
      doc: 'Sale Condition Category 2'
    0x33:
      id: 'sale_condition_category_3'
      doc: 'Sale Condition Category 3'
    0x34:
      id: 'sale_condition_category_4'
      doc: 'Sale Condition Category 4'

