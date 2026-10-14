# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cts Output Cta v1.91
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: Output
#   Encoding: Consolidated Tape Association
#   Version: 1.91
#   Date: 1/02/2020
#   Specification: CTS_BINARY_OUTPUT_SPECIFICATION.pdf
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
  id: siac_cts_output_cta_v1_91
  title: Siac Cts Output Cta v1.91
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Tape System Output Cta v1.91'
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
    doc: 'Cta Block Pad Byte'

types:
  block_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'CQS binary protocol version'
      - id: block_size
        type: u2
        doc: 'Indicate size in bytes of the entire transmission bloc'
      - id: data_feed_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q for Consolidated Quotation System'
      - id: retransmission_indicator
        type: u1
        enum: retransmission_indicator
        doc: 'Indicates an original message or a retransmitted block'
      - id: block_sequence_number
        type: u4
        doc: 'All transmission blocks are assigned a sequential Block Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The number of messages contained in the transmission block'
      - id: sip_block_timestamp
        type: sip_block_timestamp
        doc: 'Sip Block Timestamp. Nanoseconds since Unix epoch'
      - id: block_checksum
        type: u2
        doc: 'Lower 2 bytes of the 4 byte sum of all the bytes in the block, excluding this Block Checksum field'
  sip_block_timestamp:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'contains the number of seconds from Epoch 1/1/1970, 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the time. Nanoseconds since Second epoch'
  message_struct:
    seq:
      - id: message_length
        type: u2
        doc: 'The Message Length identifies the total message length inclusive of the Message Header and Message Body'
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
        doc: 'Administrative message type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            'administrative_message_type::start_of_end_of_day_message': start_of_end_of_day_message
            'administrative_message_type::end_of_end_of_day_message': end_of_end_of_day_message
            'administrative_message_type::start_of_start_of_day_message': start_of_start_of_day_message
            'administrative_message_type::end_of_start_of_day_message': end_of_start_of_day_message
            'administrative_message_type::administrative_unformatted_message': administrative_unformatted_message
  start_of_end_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  timestamp_1:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'contains the number of seconds from Epoch 1/1/1970, 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the time. Nanoseconds since Second epoch'
  end_of_end_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  start_of_start_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  end_of_start_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  administrative_unformatted_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: text
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free Form administrative informational message text'
  control_message:
    seq:
      - id: control_message_type
        type: u1
        enum: control_message_type
        doc: 'Control message type'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            'control_message_type::start_of_day_message': start_of_day_message
            'control_message_type::reset_block_sequence_number_message': reset_block_sequence_number_message
            'control_message_type::start_of_test_cycle_message': start_of_test_cycle_message
            'control_message_type::end_of_test_cycle_message': end_of_test_cycle_message
            'control_message_type::disaster_recovery_data_center_activation_message': disaster_recovery_data_center_activation_message
            'control_message_type::line_integrity_message': line_integrity_message
            'control_message_type::end_of_day_message': end_of_day_message
  start_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  reset_block_sequence_number_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  start_of_test_cycle_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  end_of_test_cycle_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  disaster_recovery_data_center_activation_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  line_integrity_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  end_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  indices_message:
    seq:
      - id: indices_message_type
        type: u1
        enum: indices_message_type
        doc: 'Indices message type'
      - id: indices_message_payload
        type:
          switch-on: indices_message_type
          cases:
            'indices_message_type::index_message': index_message
            'indices_message_type::bid_and_offer_index_message': bid_and_offer_index_message
  index_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Index symbol'
      - id: index_value
        type: s8
        doc: 'The Index Value represents a statistical composite that measures changes in the economy or in financial markets'
  bid_and_offer_index_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the Index symbol'
      - id: bid_index_value
        type: s8
        doc: 'The Bid Index Value represents the value of the index’s calculation formula using the current Bid values of the component securities'
      - id: offer_index_value
        type: s8
        doc: 'Represents the value of the index calculation formula using the current offer values of the component securities'
  market_status_message:
    seq:
      - id: market_status_message_type
        type: u1
        enum: market_status_message_type
        doc: 'Market Status message type'
      - id: market_status_message_payload
        type:
          switch-on: market_status_message_type
          cases:
            'market_status_message_type::market_wide_circuit_breaker_decline_level_status_message': market_wide_circuit_breaker_decline_level_status_message
            'market_status_message_type::market_wide_circuit_breaker_status_message': market_wide_circuit_breaker_status_message
            'market_status_message_type::approximate_adjusted_volume_market_center_message': approximate_adjusted_volume_market_center_message
            'market_status_message_type::approximate_trades_and_total_dollar_value_message': approximate_trades_and_total_dollar_value_message
            'market_status_message_type::crossing_session_summary_message': crossing_session_summary_message
  market_wide_circuit_breaker_decline_level_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: mwcb_level_1
        type: s8
        doc: 'Identifies the daily established drop level value. Level 1 = 7% of Previous Close S&P 500 Value. Has implied 6 decimal places'
      - id: mwcb_level_2
        type: s8
        doc: 'Decline Level 13% of Previous Close'
      - id: mwcb_level_3
        type: s8
        doc: 'Decline Level 20% of Previous Close'
      - id: reserved
        type: u1
        doc: 'Field is reserved for future use'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: market_wide_circuit_breaker_level_indicator
        type: u1
        enum: market_wide_circuit_breaker_level_indicator
        doc: 'Identifies the threshold level that was breached'
      - id: reserved
        type: u1
        doc: 'Field is reserved for future use'
  approximate_adjusted_volume_market_center_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: num_participants
        type: u1
        doc: 'Represents the actual number of Participants for which an issue will be reported'
      - id: participants
        type: participants
        repeat: expr
        repeat-expr: num_participants
        doc: 'Active Participants'
  participants:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: trade_total_volume
        type: u8
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
  approximate_trades_and_total_dollar_value_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: total_trades
        type: u4
        doc: 'Contains the total number of trade transactions executed from a Market Center'
      - id: dollar_value
        type: u8
        doc: 'The Dollar Value represents the total dollar worth of the daily trade transactions'
  crossing_session_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: crossing_session_1_total_trades_volume
        type: u8
        doc: 'Contains the number of shares traded at the Participant’s close price and taking place after the close of a Participant’s regular session'
      - id: crossing_session_2_dollar_value
        type: u8
        doc: 'Contains the Dollar Value traded after the close of a Participant’s regular session'
      - id: crossing_session_2_total_trades_volume
        type: u8
        doc: 'Contains the number of shares traded after the close of a Participant’s regular session'
  prior_day_message:
    seq:
      - id: prior_day_message_type
        type: u1
        enum: prior_day_message_type
        doc: 'Prior Day message type'
      - id: prior_day_message_payload
        type:
          switch-on: prior_day_message_type.to_i.as<s4>
          cases:
            67: prior_day_trade_correction_message
            84: prior_day_trade_message
            88: prior_day_trade_cancel_error_message
  prior_day_trade_correction_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_trade
        type: corrected_trade
        doc: 'Corrected Trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility has been formed'
      - id: original_trade
        type: original_trade
        doc: 'Original Trade'
  corrected_trade:
    seq:
      - id: sale_conditions
        type: sale_conditions
        doc: 'Sale Conditions'
      - id: trade_price_long
        type: decimal_u8_6
        doc: 'The Trade Price is the monetary value of an individual share of security at the time of the trade. Implied decimal with scale 1e-6'
      - id: trade_volume_long
        type: u4
        doc: 'Trade volume of the original transaction'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'The transaction that constituted the trade-through was the execution by a trading center of an order for which, at the time of receipt of the order, the trading center had guaranteed an execution at no worse than a specified price'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and when used jointly with certain Sale Conditions, will more fully describe the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
  sale_conditions:
    seq:
      - id: category_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denotes the Settlement Type sale condition'
      - id: category_2
        type: u1
        enum: category_2
        doc: 'Denotes the Reason Type sale condition'
      - id: category_3
        type: u1
        enum: category_3
        doc: 'Denotes the Sequence Type sale condition'
      - id: category_4
        type: u1
        enum: category_4
        doc: 'Denotes the Trade Detail sale condition'
  prior_day_trade_date_and_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'contains the number of seconds from Epoch 1/1/1970, 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the time. Nanoseconds since Second epoch'
  original_trade:
    seq:
      - id: sale_conditions
        type: sale_conditions
        doc: 'Sale Conditions'
      - id: trade_price_long
        type: decimal_u8_6
        doc: 'The Trade Price is the monetary value of an individual share of security at the time of the trade. Implied decimal with scale 1e-6'
      - id: trade_volume_long
        type: u4
        doc: 'Trade volume of the original transaction'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'The transaction that constituted the trade-through was the execution by a trading center of an order for which, at the time of receipt of the order, the trading center had guaranteed an execution at no worse than a specified price'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and when used jointly with certain Sale Conditions, will more fully describe the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
  prior_day_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_conditions
        type: sale_conditions
        doc: 'Sale Conditions'
      - id: trade_price
        type: decimal_u8_6
        doc: 'The Trade Price is the monetary value of an individual share of security at the time of the trade. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'The transaction that constituted the trade-through was the execution by a trading center of an order for which, at the time of receipt of the order, the trading center had guaranteed an execution at no worse than a specified price'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and when used jointly with certain Sale Conditions, will more fully describe the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility has been formed'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
  prior_day_trade_cancel_error_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_conditions
        type: sale_conditions
        doc: 'Sale Conditions'
      - id: trade_price
        type: decimal_u8_6
        doc: 'The Trade Price is the monetary value of an individual share of security at the time of the trade. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'The transaction that constituted the trade-through was the execution by a trading center of an order for which, at the time of receipt of the order, the trading center had guaranteed an execution at no worse than a specified price'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and when used jointly with certain Sale Conditions, will more fully describe the characteristics of a particular trade'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect for a security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility has been formed'
      - id: prior_day_trade_date_and_time
        type: prior_day_trade_date_and_time
        doc: 'Prior Day Trade Date and Time. Nanoseconds since Unix epoch'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or error'
  summary_message:
    seq:
      - id: summary_message_type
        type: u1
        enum: summary_message_type
        doc: 'Summary message type'
      - id: summary_message_payload
        type:
          switch-on: summary_message_type
          cases:
            'summary_message_type::consolidated_start_of_day_summary_message': consolidated_start_of_day_summary_message
            'summary_message_type::participant_start_of_day_summary_message': participant_start_of_day_summary_message
            'summary_message_type::consolidated_end_of_day_summary_message': consolidated_end_of_day_summary_message
            'summary_message_type::participant_end_of_day_summary_message': participant_end_of_day_summary_message
  consolidated_start_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
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
        doc: 'Represents the date the security last traded'
      - id: previous_close_price
        type: decimal_u8_6
        doc: 'The Previous Close Price represents the last qualifying price paid for a security during the trading day. Implied decimal with scale 1e-6'
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
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
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
        doc: 'Represents the date the security last traded'
      - id: previous_close_price
        type: decimal_u8_6
        doc: 'The Previous Close Price represents the last qualifying price paid for a security during the trading day. Implied decimal with scale 1e-6'
  consolidated_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: last_participant_id
        type: u1
        enum: last_participant_id
        doc: 'Refer to Participant ID field description for Participant codes'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded'
      - id: last_price
        type: decimal_u8_6
        doc: 'The Last Price represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'The High Price represents the highest price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'The Low Price represents the lowest price paid for a security during the trading day. Implied decimal with scale 1e-6'
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
  participant_end_of_day_summary_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
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
        doc: 'Represents the date the security last traded'
      - id: last_price
        type: decimal_u8_6
        doc: 'The Last Price represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'The High Price represents the highest price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'The Low Price represents the lowest price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: open_price
        type: decimal_u8_6
        doc: 'The Open Price represents the first qualifying price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: total_volume
        type: u8
        doc: 'Contains Total Volume of shares traded in a security either on a Consolidated or an individual Participant basis at the time it is disseminated'
      - id: tick
        type: u1
        enum: tick
        doc: 'Represents for a Participant the upward, downward or unchanged price movement in a security''s trades'
  trade_message:
    seq:
      - id: trade_message_type
        type: u1
        enum: trade_message_type
        doc: 'Trade message type'
      - id: trade_message_payload
        type:
          switch-on: trade_message_type
          cases:
            'trade_message_type::auction_status_message': auction_status_message
            'trade_message_type::trade_correction_message': trade_correction_message
            'trade_message_type::long_trade_message': long_trade_message
            'trade_message_type::trading_status_message': trading_status_message
            'trade_message_type::short_trade_message': short_trade_message
            'trade_message_type::trade_cancel_error_message': trade_cancel_error_message
  auction_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'The Auction Collar Reference Price represents the price used by the exchange to establish the Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest upper threshold price of the Auction Collar. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest lower threshold price of the Auction Collar. The lower threshold price of the Auction Collar is the lowest price of the auction collar, if any. Implied decimal with scale 1e-6'
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
      - id: future_use
        type: str
        size: 62
        encoding: ASCII
        pad-right: 0x20
        doc: 'Field is reserved for future use'
  trade_correction_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: corrected_trade
        type: corrected_trade
        doc: 'Corrected Trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility has been formed'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number of transaction to be corrected, cancelled or error'
      - id: original_trade
        type: original_trade
        doc: 'Original Trade'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market of the security symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: consolidated_data
        type: consolidated_data
        doc: 'Consolidated Data'
      - id: participant_data
        type: participant_data
        doc: 'Participant Data'
  timestamp_2:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'contains the number of seconds from Epoch 1/1/1970, 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the time. Nanoseconds since Second epoch'
  consolidated_data:
    seq:
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded'
      - id: last_participant_id
        type: u1
        enum: last_participant_id
        doc: 'Refer to Participant ID field description for Participant codes'
      - id: last_price
        type: decimal_u8_6
        doc: 'The Last Price represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'The High Price represents the highest price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'The Low Price represents the lowest price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: total_volume
        type: u8
        doc: 'Contains Total Volume of shares traded in a security either on a Consolidated or an individual Participant basis at the time it is disseminated'
      - id: tick
        type: u1
        enum: tick
        doc: 'Represents for a Participant the upward, downward or unchanged price movement in a security''s trades'
  participant_data:
    seq:
      - id: previous_close_price_date
        type: u4
        doc: 'Represents the date the security last traded'
      - id: last_participant_id
        type: u1
        enum: last_participant_id
        doc: 'Refer to Participant ID field description for Participant codes'
      - id: last_price
        type: decimal_u8_6
        doc: 'The Last Price represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'The High Price represents the highest price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'The Low Price represents the lowest price paid for a security during the trading day. Implied decimal with scale 1e-6'
      - id: total_volume
        type: u8
        doc: 'Contains Total Volume of shares traded in a security either on a Consolidated or an individual Participant basis at the time it is disseminated'
      - id: tick
        type: u1
        enum: tick
        doc: 'Represents for a Participant the upward, downward or unchanged price movement in a security''s trades'
  long_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_conditions
        type: sale_conditions
        doc: 'Sale Conditions'
      - id: trade_price
        type: decimal_u8_6
        doc: 'The Trade Price is the monetary value of an individual share of security at the time of the trade. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'The transaction that constituted the trade-through was the execution by a trading center of an order for which, at the time of receipt of the order, the trading center had guaranteed an execution at no worse than a specified price'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and when used jointly with certain Sale Conditions, will more fully describe the characteristics of a particular trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility has been formed'
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
        doc: 'The Held Trade Indicator reflects whether this trade qualifies for the Participant or Consolidated Last Price at the time it is disseminated'
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
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: last_price
        type: decimal_u8_6
        doc: 'The Last Price represents the last price for that security either on a Consolidated or an individual Participant basis at the time it is disseminated. Implied decimal with scale 1e-6'
      - id: high_indication_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'Represents an approximation of what the high end Offer price of a security''s trading range may be, or the upper price band value for a security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: low_indication_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'The Low Indication Price represents an approximation of what the low end "Bid" price of a security''s trading range may be. Implied decimal with scale 1e-6'
      - id: buy_volume
        type: u4
        doc: 'The Buy Volume represents the reported imbalance of buy orders without matching sell orders for the security for a Participant'
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
        doc: 'Denotes the reason for the Opening Delay or Trading Halt'
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
      - id: limit_up_limit_down_indicator
        type: u1
        enum: limit_up_limit_down_indicator
        doc: 'Identifies the Limit Up-Limit Down action related to a security'
  short_trade_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: sale_condition
        type: u1
        enum: sale_condition
        doc: 'Denotes the sale condition associated with a trade'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'In the Short Trade format, identifies the Sale Condition Category level associated with a trade'
      - id: trade_price_short
        type: decimal_u2_2
        doc: 'The Trade Price is the monetary value of an individual share of security at the time of the trade. Implied decimal with scale 1e-2'
      - id: trade_volume_short
        type: u2
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
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
        doc: 'Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the trade'
      - id: sale_conditions
        type: sale_conditions
        doc: 'Sale Conditions'
      - id: trade_price
        type: decimal_u8_6
        doc: 'The Trade Price is the monetary value of an individual share of security at the time of the trade. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains the total number of shares traded in a single transaction for an individual security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies the number of days that may elapse before delivery of the security'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'The transaction that constituted the trade-through was the execution by a trading center of an order for which, at the time of receipt of the order, the trading center had guaranteed an execution at no worse than a specified price'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes whether or not a trade is exempt (Rule 611) and when used jointly with certain Sale Conditions, will more fully describe the characteristics of a particular trade'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies the Participant with whom a Trade Reporting Facility has been formed'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains the Participant Reference Number of transaction to be corrected, cancelled or error'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes whether the referenced transaction is to be cancelled or error'
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
      - id: consolidated_data
        type: consolidated_data
        doc: 'Consolidated Data'
      - id: participant_data
        type: participant_data
        doc: 'Participant Data'
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0

enums:
  retransmission_indicator:
    0x4f:
      id: 'original'
      doc: 'Original message'
    0x56:
      id: 'retransmitted'
      doc: 'Retransmitted message'
  message_category:
    0x41:
      id: 'administrative'
      doc: 'Administrative Messages Header'
    0x43:
      id: 'control'
      doc: 'Control Messages Header'
    0x49:
      id: 'indices'
      doc: 'Index Messages Header'
    0x4d:
      id: 'market_status'
      doc: 'Market Status Messages Header'
    0x50:
      id: 'prior_day'
      doc: 'Prior Day Messages'
    0x53:
      id: 'summary'
      doc: 'Summary Messages'
    0x54:
      id: 'trade'
      doc: 'Trade Messages'
  administrative_message_type:
    0x41:
      id: 'start_of_end_of_day_message'
      doc: 'Start Of End Of Day Message'
    0x42:
      id: 'end_of_end_of_day_message'
      doc: 'End Of End Of Day Message'
    0x43:
      id: 'start_of_start_of_day_message'
      doc: 'Start Of Start Of Day Message'
    0x44:
      id: 'end_of_start_of_day_message'
      doc: 'End Of Start Of Day Message'
    0x48:
      id: 'administrative_unformatted_message'
      doc: 'Administrative Unformatted Message'
  participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'NASDAQ BX'
    0x43:
      id: 'nyse_national'
      doc: 'NYSE National'
    0x44:
      id: 'finra_adf'
      doc: 'FINRA Alternative Display Facility'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe EDGA Exchange'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe EDGX Exchange'
    0x4c:
      id: 'ltse'
      doc: 'Long-Term Stock Exchange'
    0x4d:
      id: 'nyse_chicago'
      doc: 'NYSE Chicago'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x53:
      id: 'cts'
      doc: 'Consolidated Tape System'
    0x54:
      id: 'nasdaq'
      doc: 'NASDAQ Stock Market'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange'
    0x57:
      id: 'cbsx'
      doc: 'CBOE Stock Exchange'
    0x58:
      id: 'nasdaq_psx'
      doc: 'NASDAQ OMX PSX'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe BYX Exchange'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe BZX Exchange'
  control_message_type:
    0x41:
      id: 'start_of_day_message'
      doc: 'Start Of Day Message'
    0x4c:
      id: 'reset_block_sequence_number_message'
      doc: 'Reset Block Sequence Number Message'
    0x4d:
      id: 'start_of_test_cycle_message'
      doc: 'Start Of Test Cycle Message'
    0x4e:
      id: 'end_of_test_cycle_message'
      doc: 'End Of Test Cycle Message'
    0x50:
      id: 'disaster_recovery_data_center_activation_message'
      doc: 'Disaster Recovery Data Center Activation Message'
    0x54:
      id: 'line_integrity_message'
      doc: 'Line Integrity Message'
    0x5a:
      id: 'end_of_day_message'
      doc: 'End Of Day Message'
  indices_message_type:
    0x49:
      id: 'index_message'
      doc: 'Index Message'
    0x51:
      id: 'bid_and_offer_index_message'
      doc: 'Bid And Offer Index Message'
  market_status_message_type:
    0x4d:
      id: 'market_wide_circuit_breaker_decline_level_status_message'
      doc: 'Market Wide Circuit Breaker Decline Level Status Message'
    0x4c:
      id: 'market_wide_circuit_breaker_status_message'
      doc: 'Market Wide Circuit Breaker Status Message'
    0x4e:
      id: 'approximate_adjusted_volume_market_center_message'
      doc: 'Approximate Adjusted Volume Market Center Message'
    0x4f:
      id: 'approximate_trades_and_total_dollar_value_message'
      doc: 'Approximate Trades And Total Dollar Value Message'
    0x50:
      id: 'crossing_session_summary_message'
      doc: 'Crossing Session Summary Message'
  market_wide_circuit_breaker_level_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      id: 'prior_day_trade_correction_message'
      doc: 'Prior Day Trade Correction Message'
    0x4c:
      id: 'prior_day_trade_message'
      doc: 'Prior Day Trade Message'
    0x58:
      id: 'prior_day_trade_message_x58'
      doc: 'Prior Day Trade Message'
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
  category_2:
    0x20:
      id: 'no_reason'
      doc: 'No Reason'
    0x46:
      id: 'intermarket_sweep_order'
      doc: 'Intermarket Sweep Order'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'Market Center Opening Trade'
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
      id: 'sold_last'
      doc: 'Sold Last'
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_sold'
      doc: 'Extended Hours Sold'
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
      id: 'rule_127_or_155'
      doc: 'Rule 127 Or 155'
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
      id: 'cross_trade'
      doc: 'Cross Trade'
  stop_stock_indicator:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      id: 'not_in_effect'
      doc: 'Not In Effect'
    0x41:
      id: 'activated'
      doc: 'Activated'
    0x43:
      id: 'continued'
      doc: 'Continued'
    0x44:
      id: 'deactivated'
      doc: 'Deactivated'
    0x45:
      id: 'restriction_in_effect'
      doc: 'Restriction In Effect'
  trade_reporting_facility_id:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'inactive_value_a'
      doc: 'Inactive Value A'
    0x42:
      id: 'finra_nasdaq_chicago'
      doc: 'Finra Nasdaq Chicago'
    0x43:
      id: 'inactive_value_c'
      doc: 'Inactive Value C'
    0x44:
      id: 'inactive_value_d'
      doc: 'Inactive Value D'
    0x49:
      id: 'inactive_value_i'
      doc: 'Inactive Value I'
    0x4a:
      id: 'inactive_value_j'
      doc: 'Inactive Value J'
    0x4b:
      id: 'inactive_value_k'
      doc: 'Inactive Value K'
    0x4d:
      id: 'inactive_value_m'
      doc: 'Inactive Value M'
    0x4e:
      id: 'finra_nyse'
      doc: 'Finra Nyse'
    0x50:
      id: 'inactive_value_p'
      doc: 'Inactive Value P'
    0x54:
      id: 'finra_nasdaq_carteret'
      doc: 'Finra Nasdaq Carteret'
    0x56:
      id: 'inactive_value_v'
      doc: 'Inactive Value V'
    0x57:
      id: 'inactive_value_w'
      doc: 'Inactive Value W'
    0x58:
      id: 'inactive_value_x'
      doc: 'Inactive Value X'
    0x59:
      id: 'inactive_value_y'
      doc: 'Inactive Value Y'
    0x5a:
      id: 'inactive_value_z'
      doc: 'Inactive Value Z'
  cancel_error_action:
    0x31:
      id: 'cancel'
      doc: 'Cancel'
    0x32:
      id: 'error'
      doc: 'Error'
  summary_message_type:
    0x41:
      id: 'consolidated_start_of_day_summary_message'
      doc: 'Consolidated Start Of Day Summary Message'
    0x42:
      id: 'participant_start_of_day_summary_message'
      doc: 'Participant Start Of Day Summary Message'
    0x43:
      id: 'consolidated_end_of_day_summary_message'
      doc: 'Consolidated End Of Day Summary Message'
    0x44:
      id: 'participant_end_of_day_summary_message'
      doc: 'Participant End Of Day Summary Message'
  primary_listing_market_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'NASDAQ BX'
    0x43:
      id: 'nyse_national'
      doc: 'NYSE National'
    0x44:
      id: 'finra_adf'
      doc: 'FINRA Alternative Display Facility'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe EDGA Exchange'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe EDGX Exchange'
    0x4d:
      id: 'nyse_chicago'
      doc: 'NYSE Chicago'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x54:
      id: 'nasdaq'
      doc: 'NASDAQ Stock Market'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange'
    0x57:
      id: 'cbsx'
      doc: 'CBOE Stock Exchange'
    0x58:
      id: 'nasdaq_psx'
      doc: 'NASDAQ OMX PSX'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe BYX Exchange'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe BZX Exchange'
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
      id: 'bankrupt_and_below_continuing_listing_standards'
      doc: 'Bankrupt And Below Continuing Listing Standards'
    0x34:
      id: 'late_filing'
      doc: 'Late Filing'
    0x35:
      id: 'bankrupt_and_late_filing'
      doc: 'Bankrupt And Late Filing'
    0x36:
      id: 'below_continuing_listing_standards_and_late_filing'
      doc: 'Below Continuing Listing Standards And Late Filing'
    0x37:
      id: 'bankrupt_below_continuing_listing_standards_and_late_filing'
      doc: 'Bankrupt, Below Continuing Listing Standards And Late Filing'
    0x38:
      id: 'creations_suspended'
      doc: 'Creations Suspended'
    0x39:
      id: 'redemptions_suspended'
      doc: 'Redemptions Suspended'
    0x41:
      id: 'liquidation'
      doc: 'Liquidation'
  last_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'NASDAQ BX'
    0x43:
      id: 'nyse_national'
      doc: 'NYSE National'
    0x44:
      id: 'finra_adf'
      doc: 'FINRA Alternative Display Facility'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe EDGA Exchange'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe EDGX Exchange'
    0x4c:
      id: 'ltse'
      doc: 'Long-Term Stock Exchange'
    0x4d:
      id: 'nyse_chicago'
      doc: 'NYSE Chicago'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x53:
      id: 'cts'
      doc: 'Consolidated Tape System'
    0x54:
      id: 'nasdaq'
      doc: 'NASDAQ Stock Market'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange'
    0x57:
      id: 'cbsx'
      doc: 'CBOE Stock Exchange'
    0x58:
      id: 'nasdaq_psx'
      doc: 'NASDAQ OMX PSX'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe BYX Exchange'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe BZX Exchange'
  tick:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x31:
      id: 'upward'
      doc: 'Upward'
    0x32:
      id: 'downward'
      doc: 'Downward'
    0x33:
      id: 'unchanged_upward'
      doc: 'Unchanged Upward'
    0x34:
      id: 'unchanged_downward'
      doc: 'Unchanged Downward'
  trade_message_type:
    0x41:
      id: 'auction_status_message'
      doc: 'Auction Status Message'
    0x43:
      id: 'trade_correction_message'
      doc: 'Trade Correction Message'
    0x4c:
      id: 'long_trade_message'
      doc: 'Long Trade Message'
    0x53:
      id: 'trading_status_message'
      doc: 'Trading Status Message'
    0x54:
      id: 'short_trade_message'
      doc: 'Short Trade Message'
    0x58:
      id: 'trade_cancel_error_message'
      doc: 'Trade Cancel Error Message'
  held_trade_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'cannot_be_used_as_a_last_sale_for_both_participant_and_consolidated_basis'
      doc: 'Cannot Be Used As A Last Sale For Both Participant And Consolidated Basis'
    0x42:
      id: 'can_be_used_as_a_last_sale_for_participant_but_not_consolidated_basis'
      doc: 'Can Be Used As A Last Sale For Participant But Not Consolidated Basis'
    0x43:
      id: 'can_be_used_as_a_last_sale_for_participant_and_consolidated_basis'
      doc: 'Can Be Used As A Last Sale For Participant And Consolidated Basis'
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
  security_status:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x31:
      id: 'opening_delay'
      doc: 'Opening Delay'
    0x32:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x33:
      id: 'resume'
      doc: 'Resume'
    0x34:
      id: 'no_open_no_resume'
      doc: 'No Open No Resume'
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
      id: 'market_on_close_imbalance_buy'
      doc: 'Market On Close Imbalance Buy'
    0x41:
      id: 'market_on_close_imbalance_sell'
      doc: 'Market On Close Imbalance Sell'
    0x42:
      id: 'reserved'
      doc: 'Reserved'
    0x43:
      id: 'no_market_imbalance'
      doc: 'No Market Imbalance'
    0x44:
      id: 'no_market_on_close_imbalance'
      doc: 'No Market On Close Imbalance'
    0x45:
      id: 'short_sale_restriction'
      doc: 'Short Sale Restriction'
    0x46:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down'
  halt_reason:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x44:
      id: 'news_dissemination'
      doc: 'News Dissemination'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4d:
      id: 'limit_up_limit_down_trading_pause'
      doc: 'Limit Up Limit Down Trading Pause'
    0x50:
      id: 'news_pending'
      doc: 'News Pending'
    0x58:
      id: 'operational'
      doc: 'Operational'
    0x59:
      id: 'subpenny_trading'
      doc: 'Subpenny Trading'
    0x31:
      id: 'market_wide_circuit_breaker_level_1_breached'
      doc: 'Market Wide Circuit Breaker Level 1 Breached'
    0x32:
      id: 'market_wide_circuit_breaker_level_2_breached'
      doc: 'Market Wide Circuit Breaker Level 2 Breached'
    0x33:
      id: 'market_wide_circuit_breaker_level_3_breached'
      doc: 'Market Wide Circuit Breaker Level 3 Breached'
  limit_up_limit_down_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'limit_up_limit_down_price_band'
      doc: 'Limit Up-Limit Down Price Band'
    0x42:
      id: 'republished_limit_up_limit_down_price_band'
      doc: 'Republished Limit Up-Limit Down Price Band'
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
      doc: 'National Best Bid and National Best Offer Limit State Entered'
    0x48:
      id: 'national_best_bid_and_national_best_offer_limit_state_exited'
      doc: 'National Best Bid and National Best Offer Limit State Exited'
    0x49:
      id: 'national_best_bid_limit_state_entered_and_national_best_offer_limit_state_exited'
      doc: 'National Best Bid Limit State Entered and National Best Offer Limit State Exited'
    0x4a:
      id: 'national_best_bid_limit_state_exited_and_national_best_offer_limit_state_entered'
      doc: 'National Best Bid Limit State Exited and National Best Offer Limit State Entered'
  sale_condition:
    0x20:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x42:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x43:
      id: 'cash_trade'
      doc: 'Cash Trade'
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
      id: 'rule_127_or_155'
      doc: 'Rule 127 Or 155'
    0x4c:
      id: 'sold_last'
      doc: 'Sold Last'
    0x4d:
      id: 'market_center_official_close'
      doc: 'Market Center Official Close'
    0x4e:
      id: 'next_day_trade'
      doc: 'Next Day Trade'
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
      id: 'extended_hours_sold'
      doc: 'Extended Hours Sold'
    0x56:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
    0x5a:
      id: 'sold'
      doc: 'Sold'
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
  sale_condition_category:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x31:
      id: 'category_1'
      doc: 'Category 1'
    0x32:
      id: 'category_2'
      doc: 'Category 2'
    0x33:
      id: 'category_3'
      doc: 'Category 3'
    0x34:
      id: 'category_4'
      doc: 'Category 4'

