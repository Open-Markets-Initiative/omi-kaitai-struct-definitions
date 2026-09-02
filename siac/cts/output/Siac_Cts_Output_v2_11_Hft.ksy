# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cts Output Cta v2.11.Hft
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.11.Hft
#   Date: 01/29/2026
#   Specification: CTS_Pillar_Output_Specification.pdf
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
  id: siac_cts_output_cta_v2_11_hft
  title: Siac Cts Output Cta v2.11.Hft
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Tape System Cta v2.11.Hft'
doc-ref: https://www.ctaplan.com/tech-specs

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Cta Output packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: block_header.messages_in_block
    doc: 'One CTA Pillar message: faithful 26-byte header (spec section 4.0) + dispatched payload'
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
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'CTA Pillar Message Header (spec section 4.0)'
      - id: message_payload
        type: fractional_trade_cancel_error_message
        doc: 'Used to cancel or error CTA eligible securities, Local Issues or Bond information. Volume is represented as a fractional value'
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'The total length of the message in bytes'
      - id: message_category
        type: str
        size: 1
        encoding: ASCII
        doc: 'Category byte; paired with Message Type to identify the terminal message'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Per-message type code; paired with Message Category to identify the terminal message'
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Initiated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'Identifies The Transaction'
      - id: participant_reference_number
        type: s8
        doc: 'Contains The Participant Reference Number'
  timestamp_1:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  symbol_reference_data_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: prior_security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Prior Security Symbol'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: primary_listing_market_previous_closing_price
        type: decimal_u8_6
        doc: 'Represents The Previous Closing Price For The Primary Listing Market Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_closing_price
        type: decimal_u8_6
        doc: 'Represents The Consolidated Closing Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: round_lot_size
        type: u2
        doc: 'Roundlot Size For A Symbol Can Consist Of 11040 Or 100 Shares'
      - id: minimum_price_increment_indicator
        type: u1
        enum: minimum_price_increment_indicator
        doc: 'Identifies The Applicable Tick Size For A Symbol'
      - id: luld_tier
        type: u1
        enum: luld_tier
        doc: 'Identifies The Limit Up Limit Down Tier Of The Security Symbol'
      - id: luld_leverage_ratio
        type: u4
        doc: 'Represents The Leverage Ratio Associated With The Luld Tier Of The Security Symbol Has Implied 6 Decimal Places'
      - id: test
        type: u1
        enum: test
        doc: 'Identifies Whether The Security Symbol Is A Test Symbol'
      - id: ipo
        type: u1
        enum: ipo
        doc: 'Identifies Whether The Security Symbol Is An Ipo'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
      - id: reserved_2
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
      - id: reserved_128
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spacefilled Field Is Reserved For Future Use'
  index_message:
    seq:
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Index Symbol Left Justified Spacefilled'
      - id: index_value
        type: s8
        doc: 'Represents A Statistical Composite That Measures Changes In The Economy Or In Financial Markets Has Implied 6 Decimal Places'
  bid_and_offer_index_message:
    seq:
      - id: index_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Index Symbol Left Justified Spacefilled'
      - id: bid_index_value
        type: s8
        doc: 'Represents The Value Of The Indexs Calculation Formula Using The Current Bid Values Of The Component Securities Has Implied 6 Decimal Places'
      - id: offer_index_value
        type: s8
        doc: 'Represents The Value Of The Index Calculation Formula Using The Current Offer Values Of The Component Securities Has Implied 6 Decimal Places'
  market_wide_circuit_breaker_decline_level_status_message:
    seq:
      - id: mwcb_level_1
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Level 17 Of Previous Close Sp 500 Value Has Implied 6 Decimal Places'
      - id: mwcb_level_2
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Level 213 Of Previous Close Sp 500 Value Has Implied 6 Decimal Places'
      - id: mwcb_level_3
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Level 320 Of Previous Close Sp 500 Value Has Implied 6 Decimal Places'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: market_wide_circuit_breaker_level_indicator
        type: u1
        enum: market_wide_circuit_breaker_level_indicator
        doc: 'Identifies The Threshold Level That Was Breached'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
  approximate_adjusted_volume_market_center_message:
    seq:
      - id: number_of_participants
        type: u1
        doc: 'Represents The Actual Number Of Participants For Which An Issue Will Be Reported'
      - id: approximate_volume_participant
        type: approximate_volume_participant
        doc: 'Active Participants for Approximate Adjusted Volume Market Center'
  approximate_volume_participant:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Initiated The Message'
      - id: trade_total_volume
        type: u8
        doc: 'Contains The Total Number Of Shares Traded For An Individual Security'
  fractional_approximate_adjusted_volume_market_center_message:
    seq:
      - id: number_of_participants
        type: u1
        doc: 'Represents The Actual Number Of Participants For Which An Issue Will Be Reported'
      - id: participant
        type: participant
        doc: 'Active Participants'
  participant:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Initiated The Message'
      - id: fractional_trade_total_volume
        type: u8
        doc: 'Contains The Total Number Of Shares Traded For Each Participant Has Implied 6 Decimal Places'
  approximate_trades_and_total_dollar_value_message:
    seq:
      - id: total_trades
        type: u4
        doc: 'Contains The Total Number Of Trade Transactions Executed From A Market Center'
      - id: dollar_value
        type: u8
        doc: 'Represents The Total Dollar Worth Of The Daily Trade Transactions Has Implied 6 Decimal Places'
  crossing_session_summary_message:
    seq:
      - id: crossing_session_i_total_trades_volume
        type: u8
        doc: 'Contains The Number Of Shares Traded At The Participants Close Price And Taking Place After The Close Of A Participants Regular Session'
      - id: crossing_session_ii_dollar_value
        type: u8
        doc: 'Contains The Dollar Value Traded After The Close Of A Participants Regular Session Has Implied 6 Decimal Places'
      - id: crossing_session_ii_total_trades_volume
        type: u8
        doc: 'Contains The Number Of Shares Traded After The Close Of A Participants Regular Session'
  prior_day_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition Associated With A Trade'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Monetary Value Of An Individual Share Of Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected Total Number Of Shares Which Traded In A Single Transaction For An Individual Security'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Number Of Days That May Elapse Before Delivery Of The Security'
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
        type: u8
        doc: 'Corrected Date And Time The Prior Day Trade Was Executed'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition Associated With A Trade'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Monetary Value Of An Individual Share Of Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: original_trade_volume
        type: u4
        doc: 'Original Total Number Of Shares Which Traded In A Single Transaction For An Individual Security'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original Number Of Days That May Elapse Before Delivery Of The Security'
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
        type: u8
        doc: 'Original Date And Time The Prior Day Trade Was Executed'
  prior_day_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains The Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: prior_day_trade_date_and_time
        type: u8
        doc: 'The First Integer Contains The Number Of Seconds From Epoch 111970000000 Utc The Next Integer Contains The Nanosecond Portion Of The Time'
  sale_condition_4:
    seq:
      - id: category_1
        type: u1
        enum: category_1
        doc: 'Settlement Type'
      - id: category_2
        type: u1
        enum: category_2
        doc: 'Reason For Trade Through Exemption Other Reason'
      - id: category_3
        type: u1
        enum: category_3
        doc: 'Extended Hours Sequence Type'
      - id: category_4
        type: u1
        enum: category_4
        doc: 'Sro Trade Detail'
  prior_day_trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains The Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: prior_day_trade_date_and_time
        type: u8
        doc: 'The First Integer Contains The Number Of Seconds From Epoch 111970000000 Utc The Next Integer Contains The Nanosecond Portion Of The Time'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes Whether The Referenced Transaction Is To Be Cancelled Or Errored'
  fractional_prior_day_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Contains The Total Number Of Shares Which Traded In A Single Transaction For An Individual Security Has Implied 6 Decimal Places'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: prior_day_trade_date_and_time
        type: u8
        doc: 'The First Integer Contains The Number Of Seconds From Epoch 111970000000 Utc The Next Integer Contains The Nanosecond Portion Of The Time'
  fractional_prior_day_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Contains The Total Number Of Shares Which Traded In A Single Transaction For An Individual Security Has Implied 6 Decimal Places'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: prior_day_trade_date_and_time
        type: u8
        doc: 'The First Integer Contains The Number Of Seconds From Epoch 111970000000 Utc The Next Integer Contains The Nanosecond Portion Of The Time'
  fractional_prior_day_trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Contains The Total Number Of Shares Which Traded In A Single Transaction For An Individual Security Has Implied 6 Decimal Places'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: prior_day_trade_date_and_time
        type: u8
        doc: 'The First Integer Contains The Number Of Seconds From Epoch 111970000000 Utc The Next Integer Contains The Nanosecond Portion Of The Time'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes Whether The Referenced Transaction Is To Be Cancelled Or Errored'
  consolidated_start_of_day_summary_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: payload_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Id Carried In The Message Payload Distinct From The Messageheader Participant Id'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents The Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: previous_close_price
        type: decimal_u8_6
        doc: 'Represents The Last Qualifying Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: number_of_participants
        type: u1
        doc: 'Represents The Actual Number Of Participants For Which An Issue Will Be Reported'
  participant_start_of_day_summary_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: payload_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Id Carried In The Message Payload Distinct From The Messageheader Participant Id'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents The Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: previous_close_price
        type: decimal_u8_6
        doc: 'Represents The Last Qualifying Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
  consolidated_end_of_day_summary_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Refer To Participant Id Field Description For Participant Codes Spacefilled'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents The Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents The Last Price For That Security Either On A Consolidated Or An Individual Participant Basis At The Time It Is Disseminated Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents The Highest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: total_volume
        type: u8
        doc: 'Contains Total Volume Of Shares Traded In A Security Either On A Consolidated Or An Individual Participant Basis At The Time It Is Disseminated'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: number_of_participants
        type: u1
        doc: 'Represents The Actual Number Of Participants For Which An Issue Will Be Reported'
  fractional_consolidated_end_of_day_summary_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Refer To Participant Id Field Description For Participant Codes Spacefilled'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents The Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents The Last Price For That Security Either On A Consolidated Or An Individual Participant Basis At The Time It Is Disseminated Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents The Highest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: fractional_total_volume
        type: u8
        doc: 'Contains Total Volume Of Shares Traded In A Security Either On A Consolidated Or An Individual Participant Basis Has Implied 6 Decimal Places'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: number_of_participants
        type: u1
        doc: 'Represents The Actual Number Of Participants For Which An Issue Will Be Reported'
  participant_end_of_day_summary_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: payload_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Id Carried In The Message Payload Distinct From The Messageheader Participant Id'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents The Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents The Last Price For That Security Either On A Consolidated Or An Individual Participant Basis At The Time It Is Disseminated Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents The Highest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: open_price
        type: decimal_u8_6
        doc: 'Represents The First Qualifying Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: total_volume
        type: u8
        doc: 'Contains Total Volume Of Shares Traded In A Security Either On A Consolidated Or An Individual Participant Basis At The Time It Is Disseminated'
      - id: tick
        type: u1
        enum: tick
        doc: 'Represents For A Participant The Upward Downward Or Unchanged Price Movement In A Securitys Trades'
  fractional_participant_end_of_day_summary_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: payload_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Id Carried In The Message Payload Distinct From The Messageheader Participant Id'
      - id: previous_close_price_date
        type: u4
        doc: 'Represents The Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents The Last Price For That Security Either On A Consolidated Or An Individual Participant Basis At The Time It Is Disseminated Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: high_price
        type: decimal_u8_6
        doc: 'Represents The Highest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: low_price
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: open_price
        type: decimal_u8_6
        doc: 'Represents The First Qualifying Price Paid For A Security During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: fractional_total_volume
        type: u8
        doc: 'Contains Total Volume Of Shares Traded In A Security Either On A Consolidated Or An Individual Participant Basis Has Implied 6 Decimal Places'
      - id: tick
        type: u1
        enum: tick
        doc: 'Represents For A Participant The Upward Downward Or Unchanged Price Movement In A Securitys Trades'
  auction_status_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'Represents The Price Used By The Exchange To Establish The Auction Collar Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Represents The Latest Upper Threshold Price Of The Auction Collar Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Represents The Latest Lower Threshold Price Of The Auction Collar Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Identifies The Number Of Manual Or Automatic Extensions The Applicable Auction Has Received'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: reserved_62
        type: str
        size: 62
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spacefilled Field Is Reserved For Future Use'
  trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition Associated With A Trade'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Monetary Value Of An Individual Share Of Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: corrected_trade_volume
        type: u4
        doc: 'Corrected Total Number Of Shares Which Traded In A Single Transaction For An Individual Security'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Number Of Days That May Elapse Before Delivery Of The Security'
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
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains The Participant Reference Number Of Transaction To Be Corrected Cancelled Or Errored'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition Associated With A Trade'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Monetary Value Of An Individual Share Of Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: original_trade_volume
        type: u4
        doc: 'Original Total Number Of Shares Which Traded In A Single Transaction For An Individual Security'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original Number Of Days That May Elapse Before Delivery Of The Security'
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
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Last Participant Id'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_total_volume
        type: u4
        doc: 'Contains The Consolidated Total Volume Of Shares Traded For A Security At The Time Of The Trade Correction Or Cancelerror'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Tick Direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant First Qualifying Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_total_volume
        type: u4
        doc: 'Contains The Participant Total Volume Of Shares Traded For A Security At The Time Of The Trade Correction Or Cancelerror'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Tick Direction'
  timestamp_2:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  long_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains The Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: held_trade_indicator
        type: u1
        enum: held_trade_indicator
        doc: 'Reflects Whether A Held Trade Qualifies For The Participant Or Consolidated Last Price At The Time It Is Disseminated'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies The Consolidated High Low Last Price Applicable To The Trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies The Participant Open High Low Last Applicable To The Transaction'
  short_trade_message:
    seq:
      - id: security_symbol_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'Denotes The Sale Condition Associated With A Trade'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'In The Short Trade Format Identifies The Sale Condition Category Level Associated With A Trade'
      - id: trade_price_2
        type: decimal_u2_2
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: trade_volume_2
        type: u2
        doc: 'Contains The Total Number Of Shares Traded In A Single Transaction For An Individual Security Short Form'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies The Consolidated High Low Last Price Applicable To The Trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies The Participant Open High Low Last Applicable To The Transaction'
  trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: trade_volume
        type: u4
        doc: 'Contains The Total Number Of Shares Traded In A Single Transaction For An Individual Security'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains The Participant Reference Number Of Transaction To Be Corrected Cancelled Or Errored'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes Whether The Referenced Transaction Is To Be Cancelled Or Errored'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Last Participant Id'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_total_volume
        type: u4
        doc: 'Contains The Consolidated Total Volume Of Shares Traded For A Security At The Time Of The Trade Correction Or Cancelerror'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Tick Direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant First Qualifying Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_total_volume
        type: u4
        doc: 'Contains The Participant Total Volume Of Shares Traded For A Security At The Time Of The Trade Correction Or Cancelerror'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Tick Direction'
  fractional_trade_correction_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: corrected_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corrected Sale Condition Associated With A Trade'
      - id: corrected_trade_price
        type: decimal_u8_6
        doc: 'Corrected Monetary Value Of An Individual Share Of Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: corrected_fractional_trade_volume
        type: u8
        doc: 'Corrected Total Number Of Shares Which Traded In A Single Transaction Has Implied 6 Decimal Places'
      - id: corrected_sellers_sale_days
        type: u1
        doc: 'Corrected Number Of Days That May Elapse Before Delivery Of The Security'
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
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains The Participant Reference Number Of Transaction To Be Corrected Cancelled Or Errored'
      - id: original_sale_condition
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition Associated With A Trade'
      - id: original_trade_price
        type: decimal_u8_6
        doc: 'Original Monetary Value Of An Individual Share Of Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: original_fractional_trade_volume
        type: u8
        doc: 'Original Total Number Of Shares Which Traded In A Single Transaction Has Implied 6 Decimal Places'
      - id: original_sellers_sale_days
        type: u1
        doc: 'Original Number Of Days That May Elapse Before Delivery Of The Security'
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
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Last Participant Id'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_fractional_total_volume
        type: u8
        doc: 'Consolidated Total Volume Of Shares Traded Has Implied 6 Decimal Places'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Tick Direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant First Qualifying Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_fractional_total_volume
        type: u8
        doc: 'Participant Total Volume Of Shares Traded Has Implied 6 Decimal Places'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Tick Direction'
  fractional_long_trade_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Contains The Total Number Of Shares Which Traded In A Single Transaction For An Individual Security Has Implied 6 Decimal Places'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: held_trade_indicator
        type: u1
        enum: held_trade_indicator
        doc: 'Reflects Whether A Held Trade Qualifies For The Participant Or Consolidated Last Price At The Time It Is Disseminated'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies The Consolidated High Low Last Price Applicable To The Trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies The Participant Open High Low Last Applicable To The Transaction'
  trading_status_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: last_price
        type: decimal_u8_6
        doc: 'Represents The Last Price For That Security Either On A Consolidated Or An Individual Participant Basis At The Time It Is Disseminated Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: high_indication_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'Represents An Approximation Of What The High End Offer Price Of A Securitys Trading Range May Be Or The Upper Price Band Value For A Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: low_indication_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'Represents An Approximation Of What The Low End Bid Price Of A Securitys Trading Range May Be Or The Lower Price Band Value For A Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: buy_volume
        type: u4
        doc: 'Represents The Reported Imbalance Of Buy Orders Without Matching Sell Orders For The Security For A Participant'
      - id: sell_volume
        type: u4
        doc: 'Represents The Reported Imbalance Of Sell Orders Without Matching Buy Orders For The Security For A Participant'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Identifies The Trading Status Applicable To The Transaction'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: limit_up_limit_down_luld_indicator
        type: u1
        enum: limit_up_limit_down_luld_indicator
        doc: 'Identifies The Limit Up Limit Down Action Related To A Security'
  fractional_short_trade_message:
    seq:
      - id: security_symbol_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'Denotes The Sale Condition Associated With A Trade'
      - id: sale_condition_category
        type: u1
        enum: sale_condition_category
        doc: 'In The Short Trade Format Identifies The Sale Condition Category Level Associated With A Trade'
      - id: trade_price_2
        type: decimal_u2_2
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: fractional_trade_volume_4
        type: u4
        doc: 'Contains The Total Number Of Shares Which Traded In A Single Transaction For An Individual Security Has Implied 6 Decimal Places'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: consolidated_high_low_last_indicator
        type: u1
        enum: consolidated_high_low_last_indicator
        doc: 'Identifies The Consolidated High Low Last Price Applicable To The Trade'
      - id: participant_open_high_low_last_indicator
        type: u1
        enum: participant_open_high_low_last_indicator
        doc: 'Identifies The Participant Open High Low Last Applicable To The Transaction'
  fractional_trade_cancel_error_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Trade'
      - id: sale_condition_4
        type: sale_condition_4
        doc: 'Sale Condition 4'
      - id: trade_price
        type: decimal_u8_6
        doc: 'Represents The Monetary Value Of An Individual Share Of Security At The Time Of The Trade Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: fractional_trade_volume
        type: u8
        doc: 'Contains The Total Number Of Shares Which Traded In A Single Transaction For An Individual Security Has Implied 6 Decimal Places'
      - id: sellers_sale_days
        type: u1
        doc: 'Specifies The Number Of Days That May Elapse Before Delivery Of The Security Allowed Values 2 Through 60 Days'
      - id: stop_stock_indicator
        type: u1
        enum: stop_stock_indicator
        doc: 'Identifies Whether The Transaction Constituted A Stopped Order'
      - id: trade_through_exempt_indicator
        type: u1
        enum: trade_through_exempt_indicator
        doc: 'Denotes Whether Or Not A Trade Is Exempt Rule 611'
      - id: trade_reporting_facility_id
        type: u1
        enum: trade_reporting_facility_id
        doc: 'Identifies The Participant With Whom A Trade Reporting Facility Trf Has Been Formed Spacefilled'
      - id: original_participant_reference_number
        type: s8
        doc: 'Contains The Participant Reference Number Of Transaction To Be Corrected Cancelled Or Errored'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: cancel_error_action
        type: u1
        enum: cancel_error_action
        doc: 'Denotes Whether The Referenced Transaction Is To Be Cancelled Or Errored'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market Of The Security Symbol'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: consolidated_previous_close_price_date
        type: u4
        doc: 'Consolidated Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: consolidated_last_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Last Participant Id'
      - id: consolidated_last_price
        type: decimal_u8_6
        doc: 'Consolidated Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_high_price
        type: decimal_u8_6
        doc: 'Consolidated Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_low_price
        type: decimal_u8_6
        doc: 'Consolidated Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_fractional_total_volume
        type: u8
        doc: 'Consolidated Total Volume Of Shares Traded Has Implied 6 Decimal Places'
      - id: consolidated_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Consolidated Tick Direction'
      - id: participant_previous_close_price_date
        type: u4
        doc: 'Participant Date The Security Last Traded Represented In Seconds Since Epoch'
      - id: participant_last_price
        type: decimal_u8_6
        doc: 'Participant Last Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_high_price
        type: decimal_u8_6
        doc: 'Participant Highest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_low_price
        type: decimal_u8_6
        doc: 'Participant Lowest Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_open_price
        type: decimal_u8_6
        doc: 'Participant First Qualifying Price Paid During The Trading Day Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: participant_fractional_total_volume
        type: u8
        doc: 'Participant Total Volume Of Shares Traded Has Implied 6 Decimal Places'
      - id: participant_tick
        type: str
        size: 1
        encoding: ASCII
        doc: 'Participant Tick Direction'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8le
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
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
      id: 'value_x47'
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
      id: 'value_x47'
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
      doc: 'Penny Mpi 001'
    0x32:
      id: 'half_penny_mpi_0005'
      doc: 'Half Penny Mpi 0005'
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
  trade_reporting_facility_id:
    0x20:
      id: 'trf_not_applicable'
      doc: 'Trf Not Applicable'
    0x41:
      id: 'not_currently_active_a'
      doc: 'Not Currently Active A'
    0x42:
      id: 'finra_nasdaq_trf_chicago'
      doc: 'Finra Nasdaq Trf Chicago'
    0x43:
      id: 'not_currently_active_c'
      doc: 'Not Currently Active C'
    0x44:
      id: 'not_currently_active_d'
      doc: 'Not Currently Active D'
    0x49:
      id: 'not_currently_active_i'
      doc: 'Not Currently Active I'
    0x4a:
      id: 'not_currently_active_j'
      doc: 'Not Currently Active J'
    0x4b:
      id: 'not_currently_active_k'
      doc: 'Not Currently Active K'
    0x4d:
      id: 'not_currently_active_m'
      doc: 'Not Currently Active M'
    0x4e:
      id: 'finra_nyse_trf'
      doc: 'Finra Nyse Trf'
    0x50:
      id: 'not_currently_active_p'
      doc: 'Not Currently Active P'
    0x54:
      id: 'finra_nasdaq_trf_carteret'
      doc: 'Finra Nasdaq Trf Carteret'
    0x56:
      id: 'not_currently_active_v'
      doc: 'Not Currently Active V'
    0x57:
      id: 'not_currently_active_w'
      doc: 'Not Currently Active W'
    0x58:
      id: 'not_currently_active_x'
      doc: 'Not Currently Active X'
    0x59:
      id: 'not_currently_active_y'
      doc: 'Not Currently Active Y'
    0x5a:
      id: 'not_currently_active_z'
      doc: 'Not Currently Active Z'
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
      id: 'reserved_8'
      doc: 'Reserved 8'
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
      doc: 'Reserved N'
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
      doc: 'Reserved 8'
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
      doc: 'Reserved 1'
    0x32:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x33:
      id: 'resume'
      doc: 'Resume'
    0x34:
      id: 'reserved_4'
      doc: 'Reserved 4'
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
      doc: 'Reserved B'
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

