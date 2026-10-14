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
        doc: 'Participant-provided timestamp. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'Identifies the individual message within the block, beginning with one (1) and incremented for subsequent messages within a block'
      - id: reserved
        size: 4
        doc: 'Reserved for Future Use (TBD), space filled'
      - id: participant_reference_number
        type: s8
        doc: 'Unique reference number per Participant ID, Trade Reporting Facility, and Security Symbol; encodes a 6-byte ASCII Regional Reference Number in the low 6 bytes with the upper 2 bytes set to binary zero'
  timestamp_1:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the timestamp. Nanoseconds since Second epoch'
  administrative_message:
    seq:
      - id: administrative_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of Administrative message'
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
        doc: 'Error code indicating the first error encountered while validating the rejected Participant input message'
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
        doc: 'Block Sequence Number prior to the gap that triggered the Warning'
      - id: previous_participant_reference_number
        type: s8
        doc: 'Participant Reference Number prior to the gap that triggered the Warning'
  control_message:
    seq:
      - id: control_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of Control message'
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
        doc: 'Next expected Participant Block Sequence Number returned by CTS in a Sequence Information and Message Count Response'
      - id: last_participant_reference_number
        type: s8
        doc: 'Last Participant Reference Number received by CTS on the individual line'
      - id: message_count
        type: u8
        doc: 'Count of messages received on the individual line since startup. Excludes Line Integrity and Sequence Information and Message Count Inquiry messages'
  test_message:
    seq:
      - id: data
        type: str
        size: 256
        encoding: ASCII
        pad-right: 0x20
        doc: 'All ASCII characters starting with hex 0 and ending hex FF, in sequential order'
  indices_message:
    seq:
      - id: indices_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of Index message'
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
        doc: 'Left justified, space-filled. Contains the Index symbol'
      - id: index_value
        type: s8
        doc: 'Index value (not a price) with implied 6 decimal places'
  bid_and_offer_index_message:
    seq:
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Contains the Index symbol'
      - id: bid_index_value
        type: s8
        doc: 'Index value (not a price) representing the index''s calculation formula using current Bid values of the component securities. Implied 6 decimal places'
      - id: offer_index_value
        type: s8
        doc: 'Index value (not a price) representing the index''s calculation formula using current Offer values of the component securities. Implied 6 decimal places'
  market_status_message:
    seq:
      - id: market_status_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of Market Status message'
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
        doc: 'Total number of trade transactions executed from a Participant. Optional set to zero'
      - id: dollar_value
        type: u8
        doc: 'Total dollar worth of the daily trade transactions. Implied 6 decimal places. Optional set to zero'
  crossing_session_message:
    seq:
      - id: crossing_session_i_total_trades_volume
        type: u8
        doc: 'Shares traded at the Participant''s close price after the close of the Participant''s regular session. Optional set to zero'
      - id: crossing_session_ii_dollar_value
        type: u8
        doc: 'Dollar Value traded after the close of the Participant''s regular session. Implied 6 decimal places. Optional set to zero'
      - id: crossing_session_ii_total_trades_volume
        type: u8
        doc: 'Shares traded after the close of the Participant''s regular session. Optional set to zero'
  prior_day_message:
    seq:
      - id: prior_day_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of Prior Day message'
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
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition. Four positional Category levels per Sale Condition table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected monetary value of an individual share. Implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected total number of shares traded'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Seller''s Sale Days. Allowed values 2 through 60. Optional set to zero'
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
        doc: 'Corrected Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition. Four positional Category levels per Sale Condition table'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original monetary value of an individual share. Implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: original_trade_volume
        type: u4
        doc: 'Original total number of shares traded'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original Seller''s Sale Days. Allowed values 2 through 60. Optional set to zero'
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
        doc: 'Original Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
  corrected_prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the timestamp. Nanoseconds since Second epoch'
  original_prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the timestamp. Nanoseconds since Second epoch'
  fractional_prior_day_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition. Four positional Category levels per Sale Condition table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected monetary value of an individual share. Implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_fractional_trade_volume
        type: u8
        doc: 'Corrected total number of shares (represented in fraction) traded. Implied 6 decimal places'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Seller''s Sale Days. Allowed values 2 through 60. Optional set to zero'
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
        doc: 'Corrected Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition. Four positional Category levels per Sale Condition table'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original monetary value of an individual share. Implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: original_fractional_trade_volume
        type: u8
        doc: 'Original total number of shares (represented in fraction) traded. Implied 6 decimal places'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original Seller''s Sale Days. Allowed values 2 through 60. Optional set to zero'
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
        doc: 'Original Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
  prior_day_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Number of days that may elapse before delivery of the security. Allowed values 2 through 60. Optional set to zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether a trade is considered a stop stock at the time of the trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and, when used jointly with certain Sale Conditions, describes the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect by the Primary Listing Market for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
  prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the timestamp. Nanoseconds since Second epoch'
  fractional_prior_day_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total number of shares (represented in fraction) traded in a single transaction. Implied 6 decimal places. Optional set to zero'
      - id: sellers_sale_days
        type: u1
        doc: 'Number of days that may elapse before delivery of the security. Allowed values 2 through 60. Optional set to zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether a trade is considered a stop stock at the time of the trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and, when used jointly with certain Sale Conditions, describes the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect by the Primary Listing Market for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
  prior_day_trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Number of days that may elapse before delivery of the security. Allowed values 2 through 60. Optional set to zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether a trade is considered a stop stock at the time of the trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and, when used jointly with certain Sale Conditions, describes the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect by the Primary Listing Market for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or errored'
  fractional_prior_day_trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total number of shares (represented in fraction) traded in a single transaction. Implied 6 decimal places. Optional set to zero'
      - id: sellers_sale_days
        type: u1
        doc: 'Number of days that may elapse before delivery of the security. Allowed values 2 through 60. Optional set to zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether a trade is considered a stop stock at the time of the trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and, when used jointly with certain Sale Conditions, describes the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect by the Primary Listing Market for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or errored'
  trade_message:
    seq:
      - id: trade_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of Trade message'
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
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'Price used by the exchange to establish the Auction Collar. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Latest upper threshold price of the Auction Collar. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Latest lower threshold price of the Auction Collar. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Number of manual or automatic extensions the applicable auction has received. Optional set to zero'
      - id: reserved_62
        type: str
        size: 62
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use (TBD)'
  trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition. Four positional Category levels per Sale Condition table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected monetary value of an individual share. Implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected total number of shares traded'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Seller''s Sale Days. Allowed values 2 through 60. Optional set to zero'
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
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: original_participant_reference_number
        type: s8
        doc: 'Participant Reference Number of the original transaction being corrected, cancelled or errored'
  timestamp_2:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the timestamp. Nanoseconds since Second epoch'
  fractional_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition. Four positional Category levels per Sale Condition table'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected monetary value of an individual share. Implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_fractional_trade_volume
        type: u8
        doc: 'Corrected total number of shares (represented in fraction) traded. Implied 6 decimal places'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Seller''s Sale Days. Allowed values 2 through 60. Optional set to zero'
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
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: original_participant_reference_number
        type: s8
        doc: 'Participant Reference Number of the original transaction being corrected, cancelled or errored'
  long_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Number of days that may elapse before delivery of the security. Allowed values 2 through 60. Optional set to zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether a trade is considered a stop stock at the time of the trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and, when used jointly with certain Sale Conditions, describes the characteristics of a particular trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
  fractional_long_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total number of shares (represented in fraction) traded in a single transaction. Implied 6 decimal places. Optional set to zero'
      - id: sellers_sale_days
        type: u1
        doc: 'Number of days that may elapse before delivery of the security. Allowed values 2 through 60. Optional set to zero'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether a trade is considered a stop stock at the time of the trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and, when used jointly with certain Sale Conditions, describes the characteristics of a particular trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
  trading_status_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: last_price_opening_reopening_luld_reference_price
        type: decimal_u8_6
        doc: 'Last price for a security; when Security Status is set to LULD Reference Price, contains the Opening (Reopening) LULD Reference Price reported by the listing exchange. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: high_indication_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'High Indication Price for trading range or, when paired with LULD Trading Pause, the Upper Limit Price Band. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: low_indication_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'Low Indication Price for trading range or, when paired with LULD Trading Pause, the Lower Limit Price Band. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: buy_volume
        type: u4
        doc: 'Reported imbalance of buy orders without matching sell orders for the security for a Participant. Optional set to zero'
      - id: sell_volume
        type: u4
        doc: 'Reported imbalance of sell orders without matching buy orders for the security for a Participant'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Trading action related to the transaction'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Reason for a Trading Halt'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect by the Primary Listing Market for a security'
      - id: trading_status_id
        type: u4
        doc: 'Unique identifier for each Trading Status Message; used to eliminate duplicate Trading Status messages received over CQS and CTS input lines'
  short_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'Identifies the Sale Condition Category level associated with a Short Trade'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Total number of shares traded in a single transaction for an individual security'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use (TBD)'
  fractional_short_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition for Long-form messages. Four positional Category levels per Sale Condition table'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'Identifies the Sale Condition Category level associated with a Short Trade'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Monetary value of an individual share at the time of the trade. Implied 6 decimal places. Optional set to zero. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Total number of shares (represented in fraction) traded in a single transaction. Implied 6 decimal places. Optional set to zero'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use (TBD)'
  trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left justified, space-filled. Root symbol may be 1 to 6 characters with remaining characters available for possible suffixes'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and, when used jointly with certain Sale Conditions, describes the characteristics of a particular trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled when TRF Not Applicable'
      - id: original_participant_reference_number
        type: s8
        doc: 'Participant Reference Number of the original transaction being corrected, cancelled or errored'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or errored'
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
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == 0

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

