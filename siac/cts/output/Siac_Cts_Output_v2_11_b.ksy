# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cts Output Cta v2.11.b
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.11.b
#   Date: 01/29/2026
#   Specification: CTS_Pillar_Output_Specification (2026-03-08).pdf
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
  id: siac_cts_output_cta_v2_11_b
  title: Siac Cts Output Cta v2.11.b
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Tape System Cta v2.11.b'
doc-ref: https://www.ctaplan.com/tech-specs

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Cta Output packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: block_header.messages_in_block
    doc: 'Repeating message block'
  - id: block_pad_byte
    type: u1
    if: _io.pos % 2 != 0
    doc: 'Block Pad Byte'

types:
  block_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Designates The Cta Binary Version'
      - id: block_size
        type: u2
        doc: 'Size In Bytes Of Entire Transmission Block'
      - id: data_feed_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Data Feed Indicator'
      - id: retransmission_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Retransmission Indicator'
      - id: block_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Block Data Of The Transmission Block'
      - id: sip_block_timestamp
        type: sip_block_timestamp
        doc: 'Cta packet timestamp. Nanoseconds since Unix epoch'
      - id: block_checksum
        type: u2
        doc: 'Lower 16 Bits Of The 32 Bit Sum Of All Bytes In The Block Excluding The Block Checksum Field'
  sip_block_timestamp:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
  message_struct:
    seq:
      - id: message_length
        type: u2
        doc: 'The total length of the message in bytes'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'The Message Category represents the message classification'
      - id: category_payload
        size: message_length - 3
        type:
          switch-on: message_category
          cases:
            'message_category::administrative': administrative_message
            'message_category::control': control_message
            'message_category::indices': indices_message
            'message_category::market_status': market_status_message
            'message_category::prior_day': prior_day_message
            'message_category::summary': summary_message
            'message_category::trade': trade_message
  administrative_message:
    seq:
      - id: administrative_message_type
        type: u1
        enum: administrative_message_type
        doc: 'Identifies the type of Administrative message'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            'administrative_message_type::start_of_end_of_day_summary': start_of_end_of_day_summary_message
            'administrative_message_type::end_of_end_of_day_summary': end_of_end_of_day_summary_message
            'administrative_message_type::start_of_start_of_day_summary': start_of_start_of_day_summary_message
            'administrative_message_type::end_of_start_of_day_summary': end_of_start_of_day_summary_message
            'administrative_message_type::symbol_reference_data': symbol_reference_data_message
  start_of_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  timestamp_1:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
  end_of_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  start_of_start_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  end_of_start_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  symbol_reference_data_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: prior_security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the prior Security Symbol'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: primary_listing_market_previous_closing_price
        type: decimal_u8_6
        doc: 'Represents the previous closing price for the primary listing market. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_closing_price
        type: decimal_u8_6
        doc: 'Represents the consolidated closing price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: round_lot_size
        type: u2
        doc: 'Round-lot size for a symbol can consist of 1, 10, 40 or 100 shares'
      - id: minimum_price_increment_indicator
        type: u1
        enum: minimum_price_increment_indicator
        doc: 'Identifies the applicable tick size for a symbol'
      - id: luld_tier
        type: u1
        enum: luld_tier
        doc: 'Identifies the Limit Up Limit Down tier of the security symbol'
      - id: luld_leverage_ratio
        type: decimal_u4_6
        doc: 'Represents the Leverage ratio associated with the LULD Tier of the security symbol. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: test
        type: u1
        enum: test
        doc: 'Identifies whether the security symbol is a test symbol'
      - id: ipo
        type: u1
        enum: ipo
        doc: 'Identifies whether the security symbol is an IPO'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes the reason for the Trading Halt'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled. Field is reserved for future use'
      - id: second_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled. Field is reserved for future use'
      - id: reserved_128
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Space-filled. Field is reserved for future use'
  control_message:
    seq:
      - id: control_message_type
        type: u1
        enum: control_message_type
        doc: 'Identifies the type of Control message'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            'control_message_type::start_of_day': start_of_day_message
            'control_message_type::reset_block_sequence_number': reset_block_sequence_number_message
            'control_message_type::disaster_recovery_data_center_activation': disaster_recovery_data_center_activation_message
            'control_message_type::line_integrity': line_integrity_message
            'control_message_type::end_of_day': end_of_day_message
  start_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  reset_block_sequence_number_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  disaster_recovery_data_center_activation_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  line_integrity_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  end_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
  indices_message:
    seq:
      - id: indices_message_type
        type: u1
        enum: indices_message_type
        doc: 'Identifies the type of Index message'
      - id: indices_message_payload
        type:
          switch-on: indices_message_type
          cases:
            'indices_message_type::indices': index_message
            'indices_message_type::bid_and_offer_index': bid_and_offer_index_message
  index_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Index symbol. Left justified, space-filled'
      - id: index_value
        type: decimal_s8_6
        doc: 'Represents a statistical composite that measures changes in the economy or in financial markets. Has implied 6 decimal places. Implied decimal with scale 1e-6'
  bid_and_offer_index_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Index symbol. Left justified, space-filled'
      - id: bid_index_value
        type: decimal_s8_6
        doc: 'Represents the value of the index''s calculation formula using the current Bid values of the component securities. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: offer_index_value
        type: decimal_s8_6
        doc: 'Represents the value of the index calculation formula using the current offer values of the component securities. Has implied 6 decimal places. Implied decimal with scale 1e-6'
  market_status_message:
    seq:
      - id: market_status_message_type
        type: u1
        enum: market_status_message_type
        doc: 'Identifies the type of Market Status message'
      - id: market_status_message_payload
        type:
          switch-on: market_status_message_type
          cases:
            'market_status_message_type::market_wide_circuit_breaker_decline_level_status': market_wide_circuit_breaker_decline_level_status_message
            'market_status_message_type::market_wide_circuit_breaker_status': market_wide_circuit_breaker_status_message
            'market_status_message_type::approximate_adjusted_volume_market_center': approximate_adjusted_volume_market_center_message
            'market_status_message_type::fractional_approximate_adjusted_volume_market_center': fractional_approximate_adjusted_volume_market_center_message
            'market_status_message_type::approximate_trades_and_total_dollar_value': approximate_trades_and_total_dollar_value_message
            'market_status_message_type::crossing_session_summary': crossing_session_summary_message
  market_wide_circuit_breaker_decline_level_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: mwcb_level_1
        type: decimal_s8_6
        doc: 'Identifies the daily established drop level value. Level 1 = 7% of Previous Close S&P 500 Value. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: mwcb_level_2
        type: decimal_s8_6
        doc: 'Identifies the daily established drop level value. Level 2 = 13% of Previous Close S&P 500 Value. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: mwcb_level_3
        type: decimal_s8_6
        doc: 'Identifies the daily established drop level value. Level 3 = 20% of Previous Close S&P 500 Value. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled. Field is reserved for future use'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: market_wide_circuit_breaker_level_indicator
        type: u1
        enum: market_wide_circuit_breaker_level_indicator
        doc: 'Identifies the threshold level that was breached'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled. Field is reserved for future use'
  approximate_adjusted_volume_market_center_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: num_approximate_volume_participant
        type: u1
        doc: 'Represents the actual number of Participants for which an issue will be reported'
      - id: approximate_volume_participant
        type: approximate_volume_participant
        repeat: expr
        repeat-expr: num_approximate_volume_participant
        doc: 'Active Participants for Approximate Adjusted Volume Market Center'
  approximate_volume_participant:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: trade_total_volume
        type: u8
        doc: 'Contains the total number of shares traded for an individual security'
  fractional_approximate_adjusted_volume_market_center_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: num_participant
        type: u1
        doc: 'Represents the actual number of Participants for which an issue will be reported'
      - id: participant
        type: participant
        repeat: expr
        repeat-expr: num_participant
        doc: 'Active Participants'
  participant:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: fractional_trade_total_volume
        type: decimal_u8_6
        doc: 'Contains the total number of shares traded for each Participant. Has implied 6 decimal places. Implied decimal with scale 1e-6'
  approximate_trades_and_total_dollar_value_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: total_trades
        type: u4
        doc: 'Contains the total number of trade transactions executed from a Market Center'
      - id: dollar_value
        type: decimal_u8_6
        doc: 'Represents the total dollar worth of the daily trade transactions. Has implied 6 decimal places. Implied decimal with scale 1e-6'
  crossing_session_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: crossing_session_i_total_trades_volume
        type: u8
        doc: 'Contains the number of shares traded at the Participant''s close price and taking place after the close of a Participant''s regular session'
      - id: crossing_session_ii_dollar_value
        type: decimal_u8_6
        doc: 'Contains the Dollar Value traded after the close of a Participant''s regular session. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: crossing_session_ii_total_trades_volume
        type: u8
        doc: 'Contains the number of shares traded after the close of a Participant''s regular session'
  prior_day_message:
    seq:
      - id: prior_day_message_type
        type: u1
        enum: prior_day_message_type
        doc: 'Identifies the type of Prior Day message'
      - id: prior_day_message_payload
        type:
          switch-on: prior_day_message_type
          cases:
            'prior_day_message_type::prior_day_trade_correction': prior_day_trade_correction_message
            'prior_day_message_type::prior_day_trade': prior_day_trade_message
            'prior_day_message_type::prior_day_trade_cancel_error': prior_day_trade_cancel_error_message
            'prior_day_message_type::fractional_prior_day_trade_correction': fractional_prior_day_trade_correction_message
            'prior_day_message_type::fractional_prior_day_trade': fractional_prior_day_trade_message
            'prior_day_message_type::fractional_prior_day_trade_cancel_error': fractional_prior_day_trade_cancel_error_message
  prior_day_trade_correction_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected sale condition associated with a trade'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected monetary value of an individual share of security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected total number of shares which traded in a single transaction for an individual security'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected number of days that may elapse before delivery of the security'
      - id: corrected_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected stop stock indicator'
      - id: corrected_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected trade through exempt indicator'
      - id: corrected_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected short sale restriction indicator'
      - id: corrected_prior_day_trade_date_and_time
        type: corrected_prior_day_trade_date_and_time
        doc: 'The corrected prior day trade date and time. Nanoseconds since Unix epoch'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original sale condition associated with a trade'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original monetary value of an individual share of security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: original_trade_volume
        type: u4
        doc: 'Original total number of shares which traded in a single transaction for an individual security'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original number of days that may elapse before delivery of the security'
      - id: original_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original stop stock indicator'
      - id: original_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original trade through exempt indicator'
      - id: original_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original short sale restriction indicator'
      - id: original_prior_day_trade_date_and_time
        type: original_prior_day_trade_date_and_time
        doc: 'The original prior day trade date and time. Nanoseconds since Unix epoch'
  corrected_prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
  original_prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
  prior_day_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'The date and time the prior day trade was executed. Nanoseconds since Unix epoch'
  sale_condition_4:
    seq:
      - id: category_1
        type: u1
        enum: category_1
        doc: 'Settlement Type'
      - id: category_2
        type: u1
        enum: category_2
        doc: 'Reason for Trade-Through Exemption / Other Reason'
      - id: category_3
        type: u1
        enum: category_3
        doc: 'Extended Hours / Sequence Type'
      - id: category_4
        type: u1
        enum: category_4
        doc: 'SRO Trade Detail'
  prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
  prior_day_trade_cancel_error_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'The date and time the prior day trade was executed. Nanoseconds since Unix epoch'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or errored'
  fractional_prior_day_trade_correction_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: decimal_u8_6
        doc: 'Contains the total number of shares which traded in a single transaction for an individual security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'The date and time the prior day trade was executed. Nanoseconds since Unix epoch'
  fractional_prior_day_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: decimal_u8_6
        doc: 'Contains the total number of shares which traded in a single transaction for an individual security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'The date and time the prior day trade was executed. Nanoseconds since Unix epoch'
  fractional_prior_day_trade_cancel_error_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: decimal_u8_6
        doc: 'Contains the total number of shares which traded in a single transaction for an individual security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'The date and time the prior day trade was executed. Nanoseconds since Unix epoch'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or errored'
  summary_message:
    seq:
      - id: summary_message_type
        type: u1
        enum: summary_message_type
        doc: 'Identifies the type of Summary message'
      - id: summary_message_payload
        type:
          switch-on: summary_message_type
          cases:
            'summary_message_type::consolidated_start_of_day_summary': consolidated_start_of_day_summary_message
            'summary_message_type::participant_start_of_day_summary': participant_start_of_day_summary_message
            'summary_message_type::consolidated_end_of_day_summary': consolidated_end_of_day_summary_message
            'summary_message_type::fractional_consolidated_end_of_day_summary': fractional_consolidated_end_of_day_summary_message
            'summary_message_type::participant_end_of_day_summary': participant_end_of_day_summary_message
            'summary_message_type::fractional_participant_end_of_day_summary': fractional_participant_end_of_day_summary_message
  consolidated_start_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: summary_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant whose summary information is provided'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded. Represented in seconds since Epoch'
      - id: previous_close_price
        type: decimal_u8_6
        doc: 'Represents the last qualifying price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: number_of_participants
        type: u1
        doc: 'Represents the actual number of Participants for which an issue will be reported'
  participant_start_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: summary_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant whose summary information is provided'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded. Represented in seconds since Epoch'
      - id: previous_close_price
        type: decimal_u8_6
        doc: 'Represents the last qualifying price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
  consolidated_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Refer to Participant ID field description for Participant codes. Space-filled'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded. Represented in seconds since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents the highest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents the lowest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: total_volume
        type: u8
        doc: 'Contains Total Volume of shares traded in a security either on a Consolidated or an individual Participant basis at the time it is disseminated'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: number_of_participants
        type: u1
        doc: 'Represents the actual number of Participants for which an issue will be reported'
  fractional_consolidated_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Refer to Participant ID field description for Participant codes. Space-filled'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded. Represented in seconds since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents the highest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents the lowest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: fractional_total_volume
        type: decimal_u8_6
        doc: 'Contains Total Volume of shares traded in a security either on a Consolidated or an individual Participant basis. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: number_of_participants
        type: u1
        doc: 'Represents the actual number of Participants for which an issue will be reported'
  participant_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: summary_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant whose summary information is provided'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded. Represented in seconds since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents the highest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents the lowest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: open_price
        type: decimal_u8_6
        doc: 'Represents the first qualifying price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: total_volume
        type: u8
        doc: 'Contains Total Volume of shares traded in a security either on a Consolidated or an individual Participant basis at the time it is disseminated'
      - id: tick
        type: u1
        enum: tick
        doc: 'Represents for a Participant the upward, downward or unchanged price movement in a security''s trades'
  fractional_participant_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: summary_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant whose summary information is provided'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded. Represented in seconds since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents the highest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents the lowest price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: open_price
        type: decimal_u8_6
        doc: 'Represents the first qualifying price paid for a security during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: fractional_total_volume
        type: decimal_u8_6
        doc: 'Contains Total Volume of shares traded in a security either on a Consolidated or an individual Participant basis. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: tick
        type: u1
        enum: tick
        doc: 'Represents for a Participant the upward, downward or unchanged price movement in a security''s trades'
  trade_message:
    seq:
      - id: trade_message_type
        type: u1
        enum: trade_message_type
        doc: 'Identifies the type of Trade message'
      - id: trade_message_payload
        type:
          switch-on: trade_message_type
          cases:
            'trade_message_type::auction_status': auction_status_message
            'trade_message_type::trade_correction': trade_correction_message
            'trade_message_type::long_trade': long_trade_message
            'trade_message_type::short_trade': short_trade_message
            'trade_message_type::trade_cancel_error': trade_cancel_error_message
            'trade_message_type::fractional_trade_correction': fractional_trade_correction_message
            'trade_message_type::fractional_long_trade': fractional_long_trade_message
            'trade_message_type::trading_status': trading_status_message
            'trade_message_type::fractional_short_trade': fractional_short_trade_message
            'trade_message_type::fractional_trade_cancel_error': fractional_trade_cancel_error_message
  auction_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'Represents the price used by the exchange to establish the Auction Collar. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest upper threshold price of the Auction Collar. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest lower threshold price of the Auction Collar. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Identifies the number of manual or automatic extensions the applicable auction has received'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: reserved_62
        type: str
        size: 62
        encoding: ASCII
        pad-right: 0x20
        doc: 'Space-filled. Field is reserved for future use'
  trade_correction_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected sale condition associated with a trade'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected monetary value of an individual share of security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected total number of shares which traded in a single transaction for an individual security'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected number of days that may elapse before delivery of the security'
      - id: corrected_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected stop stock indicator'
      - id: corrected_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected trade through exempt indicator'
      - id: corrected_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected short sale restriction indicator'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number of transaction to be corrected, cancelled or errored'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original sale condition associated with a trade'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original monetary value of an individual share of security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: original_trade_volume
        type: u4
        doc: 'Original total number of shares which traded in a single transaction for an individual security'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original number of days that may elapse before delivery of the security'
      - id: original_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original stop stock indicator'
      - id: original_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original trade through exempt indicator'
      - id: original_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original short sale restriction indicator'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated date the security last traded. Represented in seconds since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated last participant ID'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_total_volume
        type: u4
        doc: 'Contains the Consolidated Total Volume of shares traded for a security at the time of the trade correction or cancel/error'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated tick direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant date the security last traded. Represented in seconds since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant first qualifying price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_total_volume
        type: u4
        doc: 'Contains the Participant Total Volume of shares traded for a security at the time of the trade correction or cancel/error'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant tick direction'
  timestamp_2:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
  long_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: held_trade_indicator
        type: u1
        enum: held_trade_indicator
        doc: 'Reflects whether a held trade qualifies for the Participant or Consolidated Last Price at the time it is disseminated'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies the Consolidated High/Low/Last Price applicable to the trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies the Participant Open/High/Low/Last applicable to the transaction'
  short_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'Denotes the sale condition associated with a trade'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'In the Short Trade format, identifies the Sale Condition Category level associated with a trade'
      - id: trade_price_2
        type: decimal_u2_2
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: trade_volume_2
        type: u2
        doc: 'Contains the total number of shares traded in a single transaction for an individual security (short form)'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies the Consolidated High/Low/Last Price applicable to the trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies the Participant Open/High/Low/Last applicable to the transaction'
  trade_cancel_error_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number of transaction to be corrected, cancelled or errored'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or errored'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated date the security last traded. Represented in seconds since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated last participant ID'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_total_volume
        type: u4
        doc: 'Contains the Consolidated Total Volume of shares traded for a security at the time of the trade correction or cancel/error'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated tick direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant date the security last traded. Represented in seconds since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant first qualifying price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_total_volume
        type: u4
        doc: 'Contains the Participant Total Volume of shares traded for a security at the time of the trade correction or cancel/error'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant tick direction'
  fractional_trade_correction_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected sale condition associated with a trade'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected monetary value of an individual share of security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_fractional_trade_volume
        type: decimal_u8_6
        doc: 'Corrected total number of shares which traded in a single transaction. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected number of days that may elapse before delivery of the security'
      - id: corrected_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected stop stock indicator'
      - id: corrected_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected trade through exempt indicator'
      - id: corrected_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected short sale restriction indicator'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number of transaction to be corrected, cancelled or errored'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original sale condition associated with a trade'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original monetary value of an individual share of security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: original_fractional_trade_volume
        type: decimal_u8_6
        doc: 'Original total number of shares which traded in a single transaction. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original number of days that may elapse before delivery of the security'
      - id: original_stop_stock_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original stop stock indicator'
      - id: original_trade_through_exempt_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original trade through exempt indicator'
      - id: original_short_sale_restriction_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original short sale restriction indicator'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated date the security last traded. Represented in seconds since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated last participant ID'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_fractional_total_volume
        type: decimal_u8_6
        doc: 'Consolidated total volume of shares traded. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated tick direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant date the security last traded. Represented in seconds since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant first qualifying price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_fractional_total_volume
        type: decimal_u8_6
        doc: 'Participant total volume of shares traded. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant tick direction'
  fractional_long_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: decimal_u8_6
        doc: 'Contains the total number of shares which traded in a single transaction for an individual security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: held_trade_indicator
        type: u1
        enum: held_trade_indicator
        doc: 'Reflects whether a held trade qualifies for the Participant or Consolidated Last Price at the time it is disseminated'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies the Consolidated High/Low/Last Price applicable to the trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies the Participant Open/High/Low/Last applicable to the transaction'
  trading_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: high_indication_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'Represents an approximation of what the high end Offer price of a security''s trading range may be, or the upper price band value for a security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: low_indication_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'Represents an approximation of what the low end Bid price of a security''s trading range may be, or the lower price band value for a security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: buy_volume
        type: u4
        doc: 'Represents the reported imbalance of buy orders without matching sell orders for the security for a Participant'
      - id: sell_volume
        type: u4
        doc: 'Represents the reported imbalance of sell orders without matching buy orders for the security for a Participant'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Identifies the trading status applicable to the transaction'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes the reason for the Trading Halt'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: limit_up_limit_down_luld_indicator
        type: u1
        enum: limit_up_limit_down_luld_indicator
        doc: 'Identifies the Limit Up-Limit Down action related to a security'
  fractional_short_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'Denotes the sale condition associated with a trade'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'In the Short Trade format, identifies the Sale Condition Category level associated with a trade'
      - id: trade_price_2
        type: decimal_u2_2
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: fractional_trade_volume_4
        type: decimal_u4_6
        doc: 'Contains the total number of shares which traded in a single transaction for an individual security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies the Consolidated High/Low/Last Price applicable to the trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies the Participant Open/High/Low/Last applicable to the transaction'
  fractional_trade_cancel_error_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'Identifies the transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Security Symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents the monetary value of an individual share of security at the time of the trade. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: decimal_u8_6
        doc: 'Contains the total number of shares which traded in a single transaction for an individual security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security. Allowed values 2 through 60 days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies whether the transaction constituted a stopped order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611)'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility (TRF) has been formed. Space-filled'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number of transaction to be corrected, cancelled or errored'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or errored'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated date the security last traded. Represented in seconds since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated last participant ID'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_fractional_total_volume
        type: decimal_u8_6
        doc: 'Consolidated total volume of shares traded. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated tick direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant date the security last traded. Represented in seconds since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant last price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant highest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant lowest price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant first qualifying price paid during the trading day. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_fractional_total_volume
        type: decimal_u8_6
        doc: 'Participant total volume of shares traded. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant tick direction'
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
  decimal_u4_6:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_category:
    0x41:
      id: 'administrative'
      doc: 'Administrative Category'
    0x43:
      id: 'control'
      doc: 'Control Category'
    0x49:
      id: 'indices'
      doc: 'Index Category Index Messages Are Used To Provide Index Value Information Of A Security'
    0x4d:
      id: 'market_status'
      doc: 'Market Status Category Market Status Messages Are Used To Provide Market Data Information'
    0x50:
      id: 'prior_day'
      doc: 'Prior Day Category Prior Day Messages Are Used To Report Cta Eligible Equity Local Issue Or Bond Trades Corrections Cancels Or Errors For Transactions That Occurred Earlier Than The Current Trading Day And Had Not Been Reported'
    0x53:
      id: 'summary'
      doc: 'Summary Category Summary Messages Are Used To Provide Cta Eligible Equity Local Issue And Bond Summary Information By Security'
    0x54:
      id: 'trade'
      doc: 'Trade Category Trade Messages Are Used To Report Cta Eligible Equity Local Issue Or Bond Information'
  administrative_message_type:
    0x41:
      id: 'start_of_end_of_day_summary'
      doc: 'Start Of End Of Day Summary'
    0x42:
      id: 'end_of_end_of_day_summary'
      doc: 'End Of End Of Day Summary'
    0x43:
      id: 'start_of_start_of_day_summary'
      doc: 'Start Of Start Of Day Summary'
    0x44:
      id: 'end_of_start_of_day_summary'
      doc: 'End Of Start Of Day Summary'
    0x53:
      id: 'symbol_reference_data'
      doc: 'Symbol Reference Data'
  participant_id:
    0x41:
      id: 'nyse_american_llc_nyse_american'
      doc: 'Nyse American Llc Nyse American'
    0x42:
      id: 'nasdaq_omx_bx_inc_nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx Inc Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national_inc_nyse_national'
      doc: 'Nyse National Inc Nyse National'
    0x44:
      id: 'finra_alternative_display_facility_adf'
      doc: 'Finra Alternative Display Facility Adf'
    0x46:
      id: 'texas_stock_exchange_llc_txse'
      doc: 'Texas Stock Exchange Llc Txse'
    0x47:
      id: 'n24x_national_exchange_llc_24x'
      doc: '24 X National Exchange Llc 24 X'
    0x48:
      id: 'miax_pearl_exchange_llc_miax'
      doc: 'Miax Pearl Exchange Llc Miax'
    0x49:
      id: 'international_securities_exchange_llc_ise'
      doc: 'International Securities Exchange Llc Ise'
    0x4a:
      id: 'cboe_edga_exchange_inc_cboe_edga'
      doc: 'Cboe Edga Exchange Inc Cboe Edga'
    0x4b:
      id: 'cboe_edgx_exchange_inc_cboe_edgx'
      doc: 'Cboe Edgx Exchange Inc Cboe Edgx'
    0x4c:
      id: 'long_term_stock_exchange_inc_ltse'
      doc: 'Long Term Stock Exchange Inc Ltse'
    0x4d:
      id: 'nyse_texas_inc_nyse_texas'
      doc: 'Nyse Texas Inc Nyse Texas'
    0x4e:
      id: 'new_york_stock_exchange_llc_nyse'
      doc: 'New York Stock Exchange Llc Nyse'
    0x50:
      id: 'nyse_arca_inc_nyse_arca'
      doc: 'Nyse Arca Inc Nyse Arca'
    0x53:
      id: 'consolidated_tape_system_cts'
      doc: 'Consolidated Tape System Cts'
    0x54:
      id: 'nasdaq_stock_market_llc_nasdaq'
      doc: 'Nasdaq Stock Market Llc Nasdaq'
    0x55:
      id: 'members_exchange_llc_memx'
      doc: 'Members Exchange Llc Memx'
    0x56:
      id: 'investors_exchange_llc_iex'
      doc: 'Investors Exchange Llc Iex'
    0x57:
      id: 'cboe_stock_exchange_inc_cbsx'
      doc: 'Cboe Stock Exchange Inc Cbsx'
    0x58:
      id: 'nasdaq_omx_psx_inc_nasdaq_omx_psx'
      doc: 'Nasdaq Omx Psx Inc Nasdaq Omx Psx'
    0x59:
      id: 'cboe_byx_exchange_inc_cboe_byx'
      doc: 'Cboe Byx Exchange Inc Cboe Byx'
    0x5a:
      id: 'cboe_bzx_exchange_inc_cboe_bzx'
      doc: 'Cboe Bzx Exchange Inc Cboe Bzx'
  primary_listing_market_participant_id:
    0x20:
      id: 'primary_listing_market_participant_id_not_applicable'
      doc: 'Primary Listing Market Participant Id Not Applicable'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'finra_adf'
      doc: 'Finra Adf'
    0x46:
      id: 'texas_stock_exchange'
      doc: 'Texas Stock Exchange'
    0x47:
      id: 'n24x'
      doc: '24 X'
    0x48:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x49:
      id: 'ise'
      doc: 'Ise'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe Edga'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe Edgx'
    0x4c:
      id: 'ltse'
      doc: 'Ltse'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x54:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x55:
      id: 'members_exchange'
      doc: 'Members Exchange'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x57:
      id: 'cbsx'
      doc: 'Cbsx'
    0x58:
      id: 'nasdaq_omx_psx'
      doc: 'Nasdaq Omx Psx'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe Byx'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx'
  minimum_price_increment_indicator:
    0x31:
      id: 'penny_mpi_001'
      doc: 'Penny Mpi 0.01'
    0x32:
      id: 'half_penny_mpi_0005'
      doc: 'Half Penny Mpi 0.005'
  luld_tier:
    0x30:
      id: 'luld_not_applicable'
      doc: 'Luld Not Applicable'
    0x31:
      id: 'luld_tier_1_security'
      doc: 'Luld Tier 1 Security'
    0x32:
      id: 'luld_tier_2_security'
      doc: 'Luld Tier 2 Security'
  test:
    0x30:
      id: 'not_a_test_symbol'
      doc: 'Not A Test Symbol'
    0x31:
      id: 'test_symbol'
      doc: 'Test Symbol'
  ipo:
    0x30:
      id: 'not_an_ipo_symbol'
      doc: 'Not An Ipo Symbol'
    0x31:
      id: 'ipo_symbol'
      doc: 'Ipo Symbol'
  financial_status_indicator:
    0x30:
      id: 'financial_status_not_applicable'
      doc: 'Financial Status Not Applicable'
    0x31:
      id: 'bankrupt'
      doc: 'Bankrupt'
    0x32:
      id: 'below_continuing_listing_standards'
      doc: 'Below Continuing Listing Standards'
    0x33:
      id: 'bankrupt_below_continuing_listing_standards'
      doc: 'Bankrupt Below Continuing Listing Standards'
    0x34:
      id: 'late_filing'
      doc: 'Late Filing'
    0x35:
      id: 'bankrupt_late_filing'
      doc: 'Bankrupt Late Filing'
    0x36:
      id: 'below_continuing_listing_standards_late_filing'
      doc: 'Below Continuing Listing Standards Late Filing'
    0x37:
      id: 'bankrupt_below_continuing_listing_standards_late_filing'
      doc: 'Bankrupt Below Continuing Listing Standards Late Filing'
    0x38:
      id: 'creations_suspended_for_exchange_traded_products'
      doc: 'Creations Suspended For Exchange Traded Products'
    0x39:
      id: 'redemptions_suspended_for_exchange_traded_products'
      doc: 'Redemptions Suspended For Exchange Traded Products'
    0x41:
      id: 'liquidation_for_exchange_traded_products'
      doc: 'Liquidation For Exchange Traded Products'
  short_sale_restriction_indicator:
    0x20:
      id: 'short_sale_restriction_not_in_effect'
      doc: 'Short Sale Restriction Not In Effect'
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
  control_message_type:
    0x41:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x4c:
      id: 'reset_block_sequence_number'
      doc: 'Reset Block Sequence Number'
    0x50:
      id: 'disaster_recovery_data_center_activation'
      doc: 'Disaster Recovery Data Center Activation'
    0x54:
      id: 'line_integrity'
      doc: 'Line Integrity'
    0x5a:
      id: 'end_of_day'
      doc: 'End Of Day'
  indices_message_type:
    0x49:
      id: 'indices'
      doc: 'Indices'
    0x51:
      id: 'bid_and_offer_index'
      doc: 'Bid And Offer Index'
  market_status_message_type:
    0x4b:
      id: 'market_wide_circuit_breaker_decline_level_status'
      doc: 'Market Wide Circuit Breaker Decline Level Status'
    0x4c:
      id: 'market_wide_circuit_breaker_status'
      doc: 'Market Wide Circuit Breaker Status'
    0x4e:
      id: 'approximate_adjusted_volume_market_center'
      doc: 'Approximate Adjusted Volume Market Center'
    0x56:
      id: 'fractional_approximate_adjusted_volume_market_center'
      doc: 'Fractional Approximate Adjusted Volume Market Center'
    0x4f:
      id: 'approximate_trades_and_total_dollar_value'
      doc: 'Approximate Trades And Total Dollar Value'
    0x50:
      id: 'crossing_session_summary'
      doc: 'Crossing Session Summary'
  market_wide_circuit_breaker_level_indicator:
    0x20:
      id: 'mwcb_not_applicable'
      doc: 'Mwcb Not Applicable'
    0x31:
      id: 'level_1_breached'
      doc: 'Level 1 Breached'
    0x32:
      id: 'level_2_breached'
      doc: 'Level 2 Breached'
    0x33:
      id: 'level_3_breached'
      doc: 'Level 3 Breached'
  prior_day_message_type:
    0x43:
      id: 'prior_day_trade_correction'
      doc: 'Prior Day Trade Correction'
    0x4f:
      id: 'fractional_prior_day_trade_correction'
      doc: 'Fractional Prior Day Trade Correction'
    0x54:
      id: 'prior_day_trade'
      doc: 'Prior Day Trade'
    0x52:
      id: 'fractional_prior_day_trade'
      doc: 'Fractional Prior Day Trade'
    0x58:
      id: 'prior_day_trade_cancel_error'
      doc: 'Prior Day Trade Cancel Error'
    0x45:
      id: 'fractional_prior_day_trade_cancel_error'
      doc: 'Fractional Prior Day Trade Cancel Error'
  trade_reporting_facility_id:
    0x20:
      id: 'trf_not_applicable'
      doc: 'Trf Not Applicable'
    0x41:
      id: 'not_currently_active_a'
      doc: 'Not Currently Active'
    0x42:
      id: 'finra_nasdaq_trf_chicago'
      doc: 'Finra Nasdaq Trf Chicago'
    0x43:
      id: 'not_currently_active_c'
      doc: 'Not Currently Active'
    0x44:
      id: 'not_currently_active_d'
      doc: 'Not Currently Active'
    0x49:
      id: 'not_currently_active_i'
      doc: 'Not Currently Active'
    0x4a:
      id: 'not_currently_active_j'
      doc: 'Not Currently Active'
    0x4b:
      id: 'not_currently_active_k'
      doc: 'Not Currently Active'
    0x4d:
      id: 'not_currently_active_m'
      doc: 'Not Currently Active'
    0x4e:
      id: 'finra_nyse_trf'
      doc: 'Finra Nyse Trf'
    0x50:
      id: 'not_currently_active_p'
      doc: 'Not Currently Active'
    0x54:
      id: 'finra_nasdaq_trf_carteret'
      doc: 'Finra Nasdaq Trf Carteret'
    0x56:
      id: 'not_currently_active_v'
      doc: 'Not Currently Active'
    0x57:
      id: 'not_currently_active_w'
      doc: 'Not Currently Active'
    0x58:
      id: 'not_currently_active_x'
      doc: 'Not Currently Active'
    0x59:
      id: 'not_currently_active_y'
      doc: 'Not Currently Active'
    0x5a:
      id: 'not_currently_active_z'
      doc: 'Not Currently Active'
  category_1:
    0x20:
      id: 'regular_settlement'
      doc: 'Regular Settlement'
    0x43:
      id: 'cash_trade_same_day_clearing'
      doc: 'Cash Trade Same Day Clearing'
    0x4e:
      id: 'reserved'
      doc: 'Reserved'
    0x52:
      id: 'seller'
      doc: 'Seller'
  category_2:
    0x20:
      id: 'no_trade_through_exempt_reason'
      doc: 'No Trade Through Exempt Reason'
    0x46:
      id: 'intermarket_sweep_order'
      doc: 'Intermarket Sweep Order'
    0x34:
      id: 'derivatively_priced'
      doc: 'Derivatively Priced'
    0x35:
      id: 'market_center_reopening_trade'
      doc: 'Market Center Reopening Trade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'Market Center Closing Trade'
    0x37:
      id: 'qualified_contingent_trade'
      doc: 'Qualified Contingent Trade'
    0x38:
      id: 'reserved'
      doc: 'Reserved'
    0x39:
      id: 'corrected_consolidated_close_price_as_per_listing_market'
      doc: 'Corrected Consolidated Close Price As Per Listing Market'
  category_3:
    0x20:
      id: 'not_extended_hours_or_sold_out_of_sequence'
      doc: 'Not Extended Hours Or Sold Out Of Sequence'
    0x4c:
      id: 'sold_last_late_reporting'
      doc: 'Sold Last Late Reporting'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'Market Center Opening Trade'
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_sold_out_of_sequence'
      doc: 'Extended Hours Sold Out Of Sequence'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold Out Of Sequence'
  category_4:
    0x20:
      id: 'no_sro_required_trade_detail'
      doc: 'No Sro Required Trade Detail'
    0x42:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x45:
      id: 'automatic_execution'
      doc: 'Automatic Execution'
    0x48:
      id: 'price_variation_trade'
      doc: 'Price Variation Trade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'Odd Lot Trade'
    0x4b:
      id: 'rule_127_nyse_only_or_rule_155_nyse_american_only'
      doc: 'Rule 127 Nyse Only Or Rule 155 Nyse American Only'
    0x4d:
      id: 'market_center_official_close'
      doc: 'Market Center Official Close'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'market_center_official_open'
      doc: 'Market Center Official Open'
    0x56:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x58:
      id: 'cross_periodic_auction_trade'
      doc: 'Cross Periodic Auction Trade'
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
  cancel_error_action:
    0x31:
      id: 'cancel'
      doc: 'Cancel'
    0x32:
      id: 'error'
      doc: 'Error'
  summary_message_type:
    0x41:
      id: 'consolidated_start_of_day_summary'
      doc: 'Consolidated Start Of Day Summary'
    0x42:
      id: 'participant_start_of_day_summary'
      doc: 'Participant Start Of Day Summary'
    0x43:
      id: 'consolidated_end_of_day_summary'
      doc: 'Consolidated End Of Day Summary'
    0x54:
      id: 'fractional_consolidated_end_of_day_summary'
      doc: 'Fractional Consolidated End Of Day Summary'
    0x44:
      id: 'participant_end_of_day_summary'
      doc: 'Participant End Of Day Summary'
    0x50:
      id: 'fractional_participant_end_of_day_summary'
      doc: 'Fractional Participant End Of Day Summary'
  tick:
    0x20:
      id: 'tick_not_applicable'
      doc: 'Tick Not Applicable'
    0x31:
      id: 'up_tick'
      doc: 'Up Tick'
    0x32:
      id: 'down_tick'
      doc: 'Down Tick'
    0x33:
      id: 'zero_up_tick'
      doc: 'Zero Up Tick'
    0x34:
      id: 'zero_down_tick'
      doc: 'Zero Down Tick'
  trade_message_type:
    0x41:
      id: 'auction_status'
      doc: 'Auction Status'
    0x43:
      id: 'trade_correction'
      doc: 'Trade Correction'
    0x4f:
      id: 'fractional_trade_correction'
      doc: 'Fractional Trade Correction'
    0x4c:
      id: 'long_trade'
      doc: 'Long Trade'
    0x52:
      id: 'fractional_long_trade'
      doc: 'Fractional Long Trade'
    0x53:
      id: 'trading_status'
      doc: 'Trading Status'
    0x54:
      id: 'short_trade'
      doc: 'Short Trade'
    0x48:
      id: 'fractional_short_trade'
      doc: 'Fractional Short Trade'
    0x58:
      id: 'trade_cancel_error'
      doc: 'Trade Cancel Error'
    0x45:
      id: 'fractional_trade_cancel_error'
      doc: 'Fractional Trade Cancel Error'
  held_trade_indicator:
    0x20:
      id: 'held_trade_indicator_not_applicable'
      doc: 'Held Trade Indicator Not Applicable'
    0x41:
      id: 'held_trade_not_a_last_sale_for_participant_or_consolidated'
      doc: 'Held Trade Not A Last Sale For Participant Or Consolidated'
    0x42:
      id: 'held_trade_last_sale_for_participant_but_not_consolidated'
      doc: 'Held Trade Last Sale For Participant But Not Consolidated'
    0x43:
      id: 'held_trade_last_sale_for_participant_and_consolidated'
      doc: 'Held Trade Last Sale For Participant And Consolidated'
  consolidated_high_low_last_indicator:
    0x41:
      id: 'none'
      doc: 'None'
    0x42:
      id: 'high'
      doc: 'High'
    0x43:
      id: 'low'
      doc: 'Low'
    0x44:
      id: 'last'
      doc: 'Last'
    0x45:
      id: 'high_last'
      doc: 'High Last'
    0x46:
      id: 'low_last'
      doc: 'Low Last'
    0x47:
      id: 'high_low_last'
      doc: 'High Low Last'
    0x48:
      id: 'high_low'
      doc: 'High Low'
  participant_open_high_low_last_indicator:
    0x41:
      id: 'none'
      doc: 'None'
    0x42:
      id: 'high'
      doc: 'High'
    0x43:
      id: 'low'
      doc: 'Low'
    0x44:
      id: 'last'
      doc: 'Last'
    0x45:
      id: 'high_last'
      doc: 'High Last'
    0x46:
      id: 'low_last'
      doc: 'Low Last'
    0x47:
      id: 'unused'
      doc: 'Unused'
    0x48:
      id: 'open'
      doc: 'Open'
    0x49:
      id: 'open_high'
      doc: 'Open High'
    0x4a:
      id: 'open_low'
      doc: 'Open Low'
    0x4b:
      id: 'open_high_low_last'
      doc: 'Open High Low Last'
    0x4c:
      id: 'open_last'
      doc: 'Open Last'
    0x4d:
      id: 'open_high_low'
      doc: 'Open High Low'
    0x4e:
      id: 'open_high_last'
      doc: 'Open High Last'
    0x4f:
      id: 'open_low_last'
      doc: 'Open Low Last'
    0x50:
      id: 'high_low'
      doc: 'High Low'
    0x51:
      id: 'high_low_last'
      doc: 'High Low Last'
  sale_condition_1:
    0x20:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x42:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x43:
      id: 'cash_trade_same_day_clearing'
      doc: 'Cash Trade Same Day Clearing'
    0x45:
      id: 'automatic_execution'
      doc: 'Automatic Execution'
    0x46:
      id: 'intermarket_sweep_order'
      doc: 'Intermarket Sweep Order'
    0x48:
      id: 'price_variation_trade'
      doc: 'Price Variation Trade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'Odd Lot Trade'
    0x4b:
      id: 'rule_127_nyse_only_or_rule_155_nyse_american_only'
      doc: 'Rule 127 Nyse Only Or Rule 155 Nyse American Only'
    0x4c:
      id: 'sold_last_late_reporting'
      doc: 'Sold Last Late Reporting'
    0x4d:
      id: 'market_center_official_close'
      doc: 'Market Center Official Close'
    0x4e:
      id: 'reserved_n'
      doc: 'Reserved'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'Market Center Opening Trade'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'market_center_official_open'
      doc: 'Market Center Official Open'
    0x52:
      id: 'seller'
      doc: 'Seller'
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_sold_out_of_sequence'
      doc: 'Extended Hours Sold Out Of Sequence'
    0x56:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x58:
      id: 'cross_periodic_auction_trade'
      doc: 'Cross Periodic Auction Trade'
    0x5a:
      id: 'sold_out_of_sequence'
      doc: 'Sold Out Of Sequence'
    0x34:
      id: 'derivatively_priced'
      doc: 'Derivatively Priced'
    0x35:
      id: 'market_center_reopening_trade'
      doc: 'Market Center Reopening Trade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'Market Center Closing Trade'
    0x37:
      id: 'qualified_contingent_trade'
      doc: 'Qualified Contingent Trade'
    0x38:
      id: 'reserved_8'
      doc: 'Reserved'
    0x39:
      id: 'corrected_consolidated_close_price_as_per_listing_market'
      doc: 'Corrected Consolidated Close Price As Per Listing Market'
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
  security_status:
    0x20:
      id: 'security_status_not_applicable'
      doc: 'Security Status Not Applicable'
    0x31:
      id: 'reserved_1'
      doc: 'Reserved'
    0x32:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x33:
      id: 'resume'
      doc: 'Resume'
    0x34:
      id: 'reserved_4'
      doc: 'Reserved'
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
    0x42:
      id: 'reserved_b'
      doc: 'Reserved'
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
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down'
  limit_up_limit_down_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'limit_up_limit_down_price_band'
      doc: 'Limit Up Limit Down Price Band'
    0x42:
      id: 'republished_limit_up_limit_down_price_band'
      doc: 'Republished Limit Up Limit Down Price Band'
    0x43:
      id: 'national_best_bid_limit_state_entered'
      doc: 'National Best Bid Limit State Entered'
    0x44:
      id: 'national_best_bid_limit_state_exited'
      doc: 'National Best Bid Limit State Exited'
    0x45:
      id: 'national_best_offer_limit_state_entered'
      doc: 'National Best Offer Limit State Entered'
    0x46:
      id: 'national_best_offer_limit_state_exited'
      doc: 'National Best Offer Limit State Exited'
    0x47:
      id: 'national_best_bid_and_national_best_offer_limit_state_entered'
      doc: 'National Best Bid And National Best Offer Limit State Entered'
    0x48:
      id: 'national_best_bid_and_national_best_offer_limit_state_exited'
      doc: 'National Best Bid And National Best Offer Limit State Exited'
    0x49:
      id: 'national_best_bid_limit_state_entered_and_national_best_offer_limit_state_exited'
      doc: 'National Best Bid Limit State Entered And National Best Offer Limit State Exited'
    0x4a:
      id: 'national_best_bid_limit_state_exited_and_national_best_offer_limit_state_entered'
      doc: 'National Best Bid Limit State Exited And National Best Offer Limit State Entered'

