# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq Utdf Output Utp v3.0.c
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Output
#   Encoding: Utp
#   Version: 3.0.c
#   Date: 02/01/2026
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
  id: nasdaq_utdf_output_utp_v3_0_c
  title: Nasdaq Utdf Output Utp v3.0.c
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq UTP Trade Data Feed Output Utp v3.0.c'
doc-ref: https://www.utpplan.com/technical

seq:
  - id: udp_packet_header
    type: udp_packet_header_struct
    doc: 'Utp Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: udp_packet_header.message_count
    type:
      switch-on: udp_packet_header.message_count
      cases:
        _: message

types:
  udp_packet_header_struct:
    seq:
      - id: udp_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: udp_sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Utp Mold Udp 64 Message Header'
      - id: category_payload
        size: message_header.message_length - 4
        type:
          switch-on: message_header.message_category
          cases:
            '"T"': trade_message
            '"A"': administrative_message
            '"V"': total_consolidated_volume_message
            '"C"': control_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: version
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol Version. Allows each message format to be updated while still supporting previous versions during transition'
      - id: message_category
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message category'
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
            '"A"': trade_report_message_shortform_message
            '"W"': trade_report_message_longform_message
            '"Z"': trade_cancel_error_message
            '"Y"': trade_correction_message
            '"H"': prior_day_as_of_trade_message
            '"M"': fractional_trade_report_message_shortform_message
            '"N"': fractional_trade_report_message_longform_message
            '"O"': fractional_trade_cancel_error_message
            '"P"': fractional_trade_correction_message
            '"Q"': fractional_as_of_trade_message
  trade_report_message_shortform_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_id
        type: u8
        doc: 'Trade Id, unique per participant per sub market center per symbol per session'
      - id: trade_price_short
        type: decimal_u2_2
        doc: 'Trade Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: trade_volume_short
        type: u2
        doc: 'Trade Volume, in number of actual shares'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition, Level1/Level2/Level3/Level4 byte values'
      - id: trade_through_exempt_flag
        type: u1
        enum: trade_through_exempt_flag
        doc: 'Trade Through Exempt Flag'
      - id: consolidated_price_change_indicator
        type: u1
        enum: consolidated_price_change_indicator
        doc: 'Consolidated Price Change Indicator'
      - id: participant_price_change_indicator
        type: u1
        enum: participant_price_change_indicator
        doc: 'Participant Price Change Indicator'
  trade_report_message_longform_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_id
        type: u8
        doc: 'Trade Id, unique per participant per sub market center per symbol per session'
      - id: trade_price_long
        type: decimal_u8_6
        doc: 'Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume_long
        type: u4
        doc: 'Trade Volume'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition, Level1/Level2/Level3/Level4 byte values'
      - id: trade_through_exempt_flag
        type: u1
        enum: trade_through_exempt_flag
        doc: 'Trade Through Exempt Flag'
      - id: sellers_sale_days
        type: u2
        doc: 'Seller''s Sale Days. Zero filled unless Sale Condition is R (Seller)'
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
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_cancellation_type
        type: u1
        enum: trade_cancellation_type
        doc: 'Trade Cancellation Type'
      - id: original_trade_id
        type: u8
        doc: 'Original Trade Id of the trade being canceled'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: original_volume_short
        type: u4
        doc: 'Original Volume'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: original_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: original_sellers_sale_days
        type: u2
        doc: 'Original Seller''s Sale Days'
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
      - id: consolidated_last_price_originator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Originator for consolidated last price'
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
  trade_correction_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: original_trade_id
        type: u8
        doc: 'Original Trade Id of the trade being canceled'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: original_volume_short
        type: u4
        doc: 'Original Volume'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: original_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: original_sellers_sale_days
        type: u2
        doc: 'Original Seller''s Sale Days'
      - id: corrected_trade_id
        type: u8
        doc: 'Corrected Trade Id'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Trade Price. Implied decimal with scale 1e-6'
      - id: corrected_volume_short
        type: u4
        doc: 'Corrected Volume'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition'
      - id: corrected_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Trade Through Exempt Flag'
      - id: corrected_sellers_sale_days
        type: u2
        doc: 'Corrected Seller''s Sale Days'
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
      - id: consolidated_last_price_originator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Originator for consolidated last price'
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
  prior_day_as_of_trade_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_id
        type: u8
        doc: 'Trade Id, unique per participant per sub market center per symbol per session'
      - id: trade_price_long
        type: decimal_u8_6
        doc: 'Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume_long
        type: u4
        doc: 'Trade Volume'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition, Level1/Level2/Level3/Level4 byte values'
      - id: trade_through_exempt_flag
        type: u1
        enum: trade_through_exempt_flag
        doc: 'Trade Through Exempt Flag'
      - id: sellers_sale_days
        type: u2
        doc: 'Seller''s Sale Days. Zero filled unless Sale Condition is R (Seller)'
      - id: as_of_action
        type: u1
        enum: as_of_action
        doc: 'As-Of Action'
      - id: timestamp_of_trade
        type: nanosecond_timestamp
        doc: 'Timestamp of original trade. Nanoseconds since Unix epoch'
  fractional_trade_report_message_shortform_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_id
        type: u8
        doc: 'Trade Id, unique per participant per sub market center per symbol per session'
      - id: trade_price_short
        type: decimal_u2_2
        doc: 'Trade Price, 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: trade_volume
        type: decimal_u8_6
        doc: 'Trade Volume, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition, Level1/Level2/Level3/Level4 byte values'
      - id: trade_through_exempt_flag
        type: u1
        enum: trade_through_exempt_flag
        doc: 'Trade Through Exempt Flag'
      - id: consolidated_price_change_indicator
        type: u1
        enum: consolidated_price_change_indicator
        doc: 'Consolidated Price Change Indicator'
      - id: participant_price_change_indicator
        type: u1
        enum: participant_price_change_indicator
        doc: 'Participant Price Change Indicator'
  fractional_trade_report_message_longform_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_id
        type: u8
        doc: 'Trade Id, unique per participant per sub market center per symbol per session'
      - id: trade_price_long
        type: decimal_u8_6
        doc: 'Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: decimal_u8_6
        doc: 'Trade Volume, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition, Level1/Level2/Level3/Level4 byte values'
      - id: trade_through_exempt_flag
        type: u1
        enum: trade_through_exempt_flag
        doc: 'Trade Through Exempt Flag'
      - id: sellers_sale_days
        type: u2
        doc: 'Seller''s Sale Days. Zero filled unless Sale Condition is R (Seller)'
      - id: consolidated_price_change_indicator
        type: u1
        enum: consolidated_price_change_indicator
        doc: 'Consolidated Price Change Indicator'
      - id: participant_price_change_indicator
        type: u1
        enum: participant_price_change_indicator
        doc: 'Participant Price Change Indicator'
  fractional_trade_cancel_error_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_cancellation_type
        type: u1
        enum: trade_cancellation_type
        doc: 'Trade Cancellation Type'
      - id: original_trade_id
        type: u8
        doc: 'Original Trade Id of the trade being canceled'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: original_volume_long
        type: decimal_u8_6
        doc: 'Original Volume, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: original_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: original_sellers_sale_days
        type: u2
        doc: 'Original Seller''s Sale Days'
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
      - id: consolidated_last_price_originator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Originator for consolidated last price'
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
  fractional_trade_correction_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: original_trade_id
        type: u8
        doc: 'Original Trade Id of the trade being canceled'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: original_volume_long
        type: decimal_u8_6
        doc: 'Original Volume, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: original_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: original_sellers_sale_days
        type: u2
        doc: 'Original Seller''s Sale Days'
      - id: corrected_trade_id
        type: u8
        doc: 'Corrected Trade Id'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Trade Price. Implied decimal with scale 1e-6'
      - id: corrected_volume_long
        type: decimal_u8_6
        doc: 'Corrected Volume, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition'
      - id: corrected_trade_through_exempt_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corrected Trade Through Exempt Flag'
      - id: corrected_sellers_sale_days
        type: u2
        doc: 'Corrected Seller''s Sale Days'
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
      - id: consolidated_last_price_originator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Originator for consolidated last price'
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
  fractional_as_of_trade_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: timestamp_2
        type: nanosecond_timestamp_nullable
        doc: 'FINRA Timestamp, nanoseconds since Epoch. Set to 0 if from an exchange. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trade_id
        type: u8
        doc: 'Trade Id, unique per participant per sub market center per symbol per session'
      - id: trade_price_long
        type: decimal_u8_6
        doc: 'Trade Price, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: decimal_u8_6
        doc: 'Trade Volume, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition, Level1/Level2/Level3/Level4 byte values'
      - id: trade_through_exempt_flag
        type: u1
        enum: trade_through_exempt_flag
        doc: 'Trade Through Exempt Flag'
      - id: sellers_sale_days
        type: u2
        doc: 'Seller''s Sale Days. Zero filled unless Sale Condition is R (Seller)'
      - id: as_of_action
        type: u1
        enum: as_of_action
        doc: 'As-Of Action'
      - id: timestamp_of_trade
        type: nanosecond_timestamp
        doc: 'Timestamp of original trade. Nanoseconds since Unix epoch'
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
            '"V"': reg_sho_short_sale_price_test_restricted_indicator_message
            '"P"': limit_up_limit_down_price_band_message
            '"C"': market_wide_circuit_breaker_decline_level_message
            '"D"': market_wide_circuit_breaker_status_message
            '"E"': auction_collar_message
            '"U"': closing_trade_summary_report_message
  general_administrative_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: len_text
        type: u2
        doc: 'Length of the variable Text field'
      - id: text
        type: str
        size: len_text
        encoding: ASCII
        pad-right: 0x20
        doc: 'Administrative text; variable-length, sized by Text Length'
  cross_sro_trading_action_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: trading_action_sequence_number
        type: u4
        doc: 'Trading Action Sequence Number'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the action occurred. Nanoseconds since Unix epoch'
      - id: reason_for_the_trading_action
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Action Reason Code'
  market_center_trading_action_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: trading_action_code
        type: u1
        enum: trading_action_code
        doc: 'Trading Action Code'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the action occurred. Nanoseconds since Unix epoch'
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
  issue_symbol_directory_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: old_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old Symbol'
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
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: 'Reg SHO Action Code'
  limit_up_limit_down_price_band_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: luld_price_band_indicator
        type: u1
        enum: luld_price_band_indicator
        doc: 'LULD Price Band Indicator'
      - id: luld_price_band_effective_time
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
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: mwcb_level_1
        type: u8
        doc: 'MWCB Level 1 (7% decline) price'
      - id: mwcb_level_2
        type: u8
        doc: 'MWCB Level 2 (13% decline) price'
      - id: mwcb_level_3
        type: u8
        doc: 'MWCB Level 3 (20% decline) price'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: mwcb_status_level_indicator
        type: u1
        enum: mwcb_status_level_indicator
        doc: 'MWCB Status Level Indicator'
  auction_collar_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
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
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security symbol'
      - id: daily_consolidated_high_price
        type: decimal_u8_6
        doc: 'Daily Consolidated High Price. Implied decimal with scale 1e-6'
      - id: daily_consolidated_low_price
        type: decimal_u8_6
        doc: 'Daily Consolidated Low Price. Implied decimal with scale 1e-6'
      - id: daily_consolidated_closing_price
        type: decimal_u8_6
        doc: 'Daily Consolidated Closing Price. Implied decimal with scale 1e-6'
      - id: consolidated_last_price_originator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Originator for consolidated last price'
      - id: consolidated_volume
        type: decimal_u8_6
        doc: 'Consolidated Volume. Implied decimal with scale 1e-6'
      - id: trading_action_indicator
        type: u1
        enum: trading_action_indicator
        doc: 'Trading Action Indicator'
      - id: num_market_center_closing_price_and_volume_summary
        type: u2
        doc: 'Number of Market Center Attachments'
      - id: market_center_closing_price_and_volume_summary
        type: market_center_closing_price_and_volume_summary
        repeat: expr
        repeat-expr: num_market_center_closing_price_and_volume_summary
        doc: 'Market Center Closing Price and Volume Summary attachment following the Closing Trade Summary Report Message. Repeats Number of Market Center Attachments times'
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
  total_consolidated_volume_message:
    seq:
      - id: total_consolidated_volume_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Total Consolidated Volume message type'
      - id: total_consolidated_volume_message_payload
        type:
          switch-on: total_consolidated_volume_message_type
          cases:
            '"V"': total_consolidated_and_market_center_volume_message
  total_consolidated_and_market_center_volume_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
      - id: total_consolidated_volume
        type: decimal_u8_6
        doc: 'Total Consolidated Volume, 6 implied decimal places. Implied decimal with scale 1e-6'
      - id: num_market_center_volume_group
        type: u2
        doc: 'Number of Market Center Attachments'
      - id: market_center_volume_group
        type: market_center_volume_group
        repeat: expr
        repeat-expr: num_market_center_volume_group
        doc: 'Market Center Volume attachment following the Total Consolidated and Market Center Volume Message. Repeats Number of Market Center Attachments times'
  market_center_volume_group:
    seq:
      - id: market_center_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market Center Identifier'
      - id: market_center_volume
        type: decimal_u8_6
        doc: 'Market Center Volume. Implied decimal with scale 1e-6'
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
            '"S"': end_of_consolidated_last_sale_eligibility_message
  start_of_day_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
  end_of_day_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
  market_session_open_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
  market_session_close_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
  end_of_transmissions_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
  end_of_trade_reporting_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
  end_of_consolidated_last_sale_eligibility_message:
    seq:
      - id: market_center_originator
        type: u1
        enum: market_center_originator
        doc: 'Market Center Originator'
      - id: sub_market_center_id
        type: u1
        enum: sub_market_center_id
        doc: 'Sub-Market Center ID'
      - id: sip_timestamp
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: timestamp_1
        type: nanosecond_timestamp_nullable
        doc: 'Participant Timestamp. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: participant_token
        type: u8
        doc: 'Participant Token'
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
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  market_center_originator:
    0x59:
      id: 'cboe_byx_exchange_inc'
      doc: 'Cboe Byx Exchange Inc'
    0x5a:
      id: 'cboe_bzx_exchange_inc'
      doc: 'Cboe Bzx Exchange Inc'
    0x4a:
      id: 'cboe_edga_exchange_inc'
      doc: 'Cboe Edga Exchange Inc'
    0x4b:
      id: 'cboe_edgx_exchange_inc'
      doc: 'Cboe Edgx Exchange Inc'
    0x57:
      id: 'cboe_exchange_inc'
      doc: 'Cboe Exchange Inc'
    0x42:
      id: 'nasdaq_texas_llc'
      doc: 'Nasdaq Texas Llc'
    0x58:
      id: 'nasdaq_phlx_llc'
      doc: 'Nasdaq Phlx Llc'
    0x51:
      id: 'nasdaq_inc'
      doc: 'Nasdaq Inc'
    0x49:
      id: 'nasdaq_ise_llc'
      doc: 'Nasdaq Ise Llc'
    0x4e:
      id: 'new_york_stock_exchange_llc'
      doc: 'New York Stock Exchange Llc'
    0x50:
      id: 'nyse_arca_inc'
      doc: 'Nyse Arca Inc'
    0x41:
      id: 'nyse_american_llc'
      doc: 'Nyse American Llc'
    0x43:
      id: 'nyse_national_inc'
      doc: 'Nyse National Inc'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x46:
      id: 'texas_stock_exchange_llc'
      doc: 'Texas Stock Exchange Llc'
    0x47:
      id: 'n_24_x_national_exchange_llc'
      doc: 'N 24 X National Exchange Llc'
    0x44:
      id: 'financial_industry_regulatory_authority'
      doc: 'Financial Industry Regulatory Authority'
    0x56:
      id: 'investors_exchange_llc'
      doc: 'Investors Exchange Llc'
    0x4c:
      id: 'long_term_stock_exchange'
      doc: 'Long Term Stock Exchange'
    0x48:
      id: 'miax_pearl_llc'
      doc: 'Miax Pearl Llc'
    0x55:
      id: 'memx_llc'
      doc: 'Memx Llc'
    0x45:
      id: 'market_independent_generated_by_sip'
      doc: 'Market Independent Generated By Sip'
  sub_market_center_id:
    0x4e:
      id: 'finra_nyse_trf'
      doc: 'Finra Nyse Trf'
    0x51:
      id: 'finra_nasdaq_trf_carteret'
      doc: 'Finra Nasdaq Trf Carteret'
    0x42:
      id: 'finra_nasdaq_trf_chicago'
      doc: 'Finra Nasdaq Trf Chicago'
    0x20:
      id: 'trade_originates_from_finra_alternative_display_facility'
      doc: 'Trade Originates From Finra Alternative Display Facility'
  trade_through_exempt_flag:
    0x58:
      id: 'rule_611_trade_through_exempt'
      doc: 'Rule 611 Trade Through Exempt'
    0x20:
      id: 'not_rule_611_trade_through_exempt'
      doc: 'Not Rule 611 Trade Through Exempt'
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
  trade_cancellation_type:
    0x43:
      id: 'cancel'
      doc: 'Cancel'
    0x45:
      id: 'error'
      doc: 'Error'
  as_of_action:
    0x41:
      id: 'as_of_trade_addition'
      doc: 'As Of Trade Addition'
    0x43:
      id: 'as_of_trade_cancel'
      doc: 'As Of Trade Cancel'
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
      id: 'sec_144_a'
      doc: 'Sec 144 A'
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
      id: 'live_production'
      doc: 'Live Production'
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
      id: 'issue_is_restricted_under_sec_rule_203_b_3'
      doc: 'Issue Is Restricted Under Sec Rule 203 B 3'
    0x4e:
      id: 'issue_is_not_restricted'
      doc: 'Issue Is Not Restricted'
    0x20:
      id: 'threshold_indicator_not_available'
      doc: 'Threshold Indicator Not Available'
  financial_status_indicator:
    0x43:
      id: 'creations_andor_redemptions_suspended_for_exchange_traded_product'
      doc: 'Creations Andor Redemptions Suspended For Exchange Traded Product'
    0x44:
      id: 'deficient_issuer_failed_to_meet_nasdaq_continued_listing_requirements'
      doc: 'Deficient Issuer Failed To Meet Nasdaq Continued Listing Requirements'
    0x45:
      id: 'delinquent_issuer_missed_regulatory_filing_deadline'
      doc: 'Delinquent Issuer Missed Regulatory Filing Deadline'
    0x51:
      id: 'bankrupt_issuer_has_filed_for_bankruptcy'
      doc: 'Bankrupt Issuer Has Filed For Bankruptcy'
    0x4e:
      id: 'normal_default_issuer_is_not_deficient_delinquent_or_bankrupt'
      doc: 'Normal Default Issuer Is Not Deficient Delinquent Or Bankrupt'
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
      id: 'reg_sho_in_effect_due_to_an_intra_day_price_drop_in_security'
      doc: 'Reg Sho In Effect Due To An Intra Day Price Drop In Security'
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
      id: 'market_wide_circuit_breaker_decline_level_1_breached_7_decline'
      doc: 'Market Wide Circuit Breaker Decline Level 1 Breached 7 Decline'
    0x32:
      id: 'market_wide_circuit_breaker_decline_level_2_breached_13_decline'
      doc: 'Market Wide Circuit Breaker Decline Level 2 Breached 13 Decline'
    0x33:
      id: 'market_wide_circuit_breaker_decline_level_3_breached_20_decline'
      doc: 'Market Wide Circuit Breaker Decline Level 3 Breached 20 Decline'
  trading_action_indicator:
    0x48:
      id: 'trading_halt_in_effect'
      doc: 'Trading Halt In Effect'
    0x20:
      id: 'regular_trading_in_effect'
      doc: 'Regular Trading In Effect'
  market_center_close_indicator:
    0x4d:
      id: 'market_center_closing_price_is_based_on_transaction_with_m_sale_condition_modifier'
      doc: 'Market Center Closing Price Is Based On Transaction With M Sale Condition Modifier'
    0x20:
      id: 'market_center_closing_price_is_not_based_on_a_transaction_with_an_m_sale_condition_modifier'
      doc: 'Market Center Closing Price Is Not Based On A Transaction With An M Sale Condition Modifier'

