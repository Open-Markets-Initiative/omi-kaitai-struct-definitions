# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Output Cta v2.10.a
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.10.a
#   Date: 06/06/2025
#   Specification: CQS_Pillar_Snapshot_Specification.pdf
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
  id: siac_cqs_output_cta_v2_10_a
  title: Siac Cqs Output Cta v2.10.a
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Quotation System Cta v2.10.a'
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
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  message_struct:
    seq:
      - id: message_length
        type: u2
        doc: 'The Total Length Of The Message In Bytes'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'The Message Category Represents The Message Classification'
      - id: category_payload
        type:
          switch-on: message_category
          cases:
            'message_category::administrative': administrative_message
            'message_category::control': control_message
            'message_category::market_status': market_status_message
            'message_category::quote': quote_message
  administrative_message:
    seq:
      - id: administrative_message_type
        type: u1
        enum: administrative_message_type
        doc: 'Identifies The Type Of Administrative Message'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            'administrative_message_type::symbol_reference_data': symbol_reference_data_message
  symbol_reference_data_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Spacefilled'
      - id: prior_security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Prior Security Symbol Left Justified Space Filled'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market For A Security'
      - id: primary_listing_market_previous_closing_price
        type: decimal_u8_6
        doc: 'Primary Listing Market Previous Closing Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: consolidated_closing_price
        type: decimal_u8_6
        doc: 'Consolidated Closing Price Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: round_lot_size
        type: u2
        doc: 'Roundlot Size For A Symbol Can Consist Of 11040 Or 100 Shares'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
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
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
      - id: halt_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denotes The Reason For The Trading Halt'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: second_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
      - id: third_reserved
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
  timestamp_1:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  control_message:
    seq:
      - id: control_message_type
        type: u1
        enum: control_message_type
        doc: 'Identifies The Type Of Control Message'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            'control_message_type::start_of_day': start_of_day_message
            'control_message_type::finra_close': finra_close_message
            'control_message_type::reset_block_sequence_number': reset_block_sequence_number_message
            'control_message_type::finra_open': finra_open_message
            'control_message_type::disaster_recovery_data_center_activation': disaster_recovery_data_center_activation_message
            'control_message_type::line_integrity': line_integrity_message
            'control_message_type::end_of_day': end_of_day_message
  start_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  finra_close_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  reset_block_sequence_number_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  finra_open_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  disaster_recovery_data_center_activation_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  line_integrity_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  end_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  market_status_message:
    seq:
      - id: market_status_message_type
        type: u1
        enum: market_status_message_type
        doc: 'Identifies The Type Of Market Status Message'
      - id: market_status_message_payload
        type:
          switch-on: market_status_message_type
          cases:
            'market_status_message_type::market_wide_circuit_breaker_decline_level_status': market_wide_circuit_breaker_decline_level_status_message
            'market_status_message_type::market_wide_circuit_breaker_status': market_wide_circuit_breaker_status_message
  market_wide_circuit_breaker_decline_level_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: mwcb_level_1
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Associated With Level 17 Of Previous Close Sp 500 Value Has Implied 6 Decimal Places'
      - id: mwcb_level_2
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Associated With Level 213 Of Previous Close Sp 500 Value Has Implied 6 Decimal Places'
      - id: mwcb_level_3
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Associated With Level 320 Of Previous Close Sp 500 Value Has Implied 6 Decimal Places'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: market_wide_circuit_breaker_level_indicator
        type: u1
        enum: market_wide_circuit_breaker_level_indicator
        doc: 'Identifies The Threshold Level That Was Breached'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Field Is Reserved For Future Use'
  quote_message:
    seq:
      - id: quote_message_type
        type: u1
        enum: quote_message_type
        doc: 'Identifies The Type Of Quote Message'
      - id: quote_message_payload
        type:
          switch-on: quote_message_type
          cases:
            'quote_message_type::auction_status': auction_status_message
            'quote_message_type::long_quote': long_quote_message
            'quote_message_type::short_quote': short_quote_message
            'quote_message_type::special_long_quote': special_long_quote_message
  auction_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'Represents The Price Used By The Exchange To Establish The Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Represents The Latest Upper Threshold Price Of The Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Represents The Latest Lower Threshold Price Of The Auction Collar. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Identifies The Number Of Manual Or Automatic Extensions The Applicable Auction Has Received'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market For A Security'
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
  long_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote Used To Determine Whether A Quote Qualifies For The Best Bid And Best Offer Calculation'
      - id: security_status_indicator
        type: u1
        enum: security_status_indicator
        doc: 'Reports Trading Suspensions Price Indications Trading Range Indications Luld Price Bands And Market Wide Circuit Breaker Activity'
      - id: bid_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'Bid Price Represents The Highest Price A Prospective Buyer Is Prepared To Pay Lower Limit Price Band Represents The Lower Price Band Value When Security Status Indicator Is Limit Up Limit Down Price Band. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'Identifies The Number Of Shares For A Symbol Rounded Down To The Nearest Multiple Of Its Round Lot Size'
      - id: offer_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'Offer Price Represents The Lowest Price Acceptable To A Prospective Seller At A Particular Time For A Security Upper Limit Price Band Represents The Upper Price Band Value When Security Status Indicator Is Limit Up Limit Down Price Band. Implied decimal with scale 1e-6'
      - id: offer_size_long
        type: u4
        doc: 'Identifies The Number Of Shares For A Symbol Rounded Down To The Nearest Multiple Of Its Round Lot Size'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement Interest Priced Better Than The Protected Best Bid Or Offer By A Minimum Of 0001'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies The Settlement Condition For A Security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies The Market Condition Of A Quote For A Security'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Or The Finra Adf Identifier Fnra'
      - id: finra_bbo_indicator
        type: u1
        enum: finra_bbo_indicator
        doc: 'For Finra Adf Represents The Finra Bbo State Of The Finra Adf Quote'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market For A Security'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: sip_generated_message_identifier
        type: u1
        enum: sip_generated_message_identifier
        doc: 'Identifies Cqs As The Originator Of A Message'
      - id: limit_up_limit_down_luld_indicator
        type: u1
        enum: limit_up_limit_down_luld_indicator
        doc: 'Indicates The Effect The Quote Has On The Limit Up Limit Down Price Band Range'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates The Effect That The Limit Up Limit Down Price Band Changes Have On The National Best Bid And National Best Offer'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates The Effect The New Quote Has On The National Bbo'
      - id: national_best_bid_long_appendage
        type: national_best_bid_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_no_best_offer_change or national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_quote_contains_best_offer or national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_no_best_offer
        doc: 'National Best Bid Long Appendage'
      - id: national_best_offer_long_appendage
        type: national_best_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::quote_contains_best_bid_best_offer_long_appendage or national_bbo_indicator == national_bbo_indicator::no_best_bid_best_offer_long_appendage
        doc: 'National Best Offer Long Appendage'
      - id: national_best_bid_and_offer_long_appendage
        type: national_best_bid_and_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Bid And Offer Long Appendage'
      - id: national_best_bid_short_appendage
        type: national_best_bid_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_no_best_offer_change or national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_quote_contains_best_offer or national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_no_best_offer
        doc: 'National Best Bid Short Appendage'
      - id: national_best_offer_short_appendage
        type: national_best_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::quote_contains_best_bid_best_offer_short_appendage or national_bbo_indicator == national_bbo_indicator::no_best_bid_best_offer_short_appendage
        doc: 'National Best Offer Short Appendage'
      - id: national_best_bid_and_offer_short_appendage
        type: national_best_bid_and_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Bid And Offer Short Appendage'
  timestamp_2:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  national_best_bid_long_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Quote Condition Associated With The Best Bid Price On A Consolidated Basis'
      - id: best_bid_price_long
        type: decimal_u8_6
        doc: 'Represents The Best Bid Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: best_bid_size_long
        type: u4
        doc: 'Represents The Best Bid Size Associated With The Best Bid Price On A Consolidated Basis'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Bid Market Maker Identifier Of The Market Maker That Had The Finra Best Bid'
  national_best_offer_long_appendage:
    seq:
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Offer On A Consolidated Basis'
      - id: best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Quote Condition Associated With The Best Offer Price On A Consolidated Basis'
      - id: best_offer_price_long
        type: decimal_u8_6
        doc: 'Represents The Best Offer Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: best_offer_size_long
        type: u4
        doc: 'Represents The Best Offer Size Associated With The Best Offer Price On A Consolidated Basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer'
  national_best_bid_and_offer_long_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Quote Condition Associated With The Best Bid Price On A Consolidated Basis'
      - id: best_bid_price_long
        type: decimal_u8_6
        doc: 'Represents The Best Bid Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: best_bid_size_long
        type: u4
        doc: 'Represents The Best Bid Size Associated With The Best Bid Price On A Consolidated Basis'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Bid Market Maker Identifier Of The Market Maker That Had The Finra Best Bid'
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Offer On A Consolidated Basis'
      - id: best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Quote Condition Associated With The Best Offer Price On A Consolidated Basis'
      - id: best_offer_price_long
        type: decimal_u8_6
        doc: 'Represents The Best Offer Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: best_offer_size_long
        type: u4
        doc: 'Represents The Best Offer Size Associated With The Best Offer Price On A Consolidated Basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer'
  national_best_bid_short_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: best_bid_price_short
        type: decimal_u2_2
        doc: 'Represents The Best Bid Price On A Consolidated Basis Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: best_bid_size_short
        type: u2
        doc: 'Represents The Best Bid Size Associated With The Best Bid Price On A Consolidated Basis'
  national_best_offer_short_appendage:
    seq:
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Offer On A Consolidated Basis'
      - id: best_offer_price_short
        type: decimal_u2_2
        doc: 'Represents The Best Offer Price On A Consolidated Basis Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: best_offer_size_short
        type: u2
        doc: 'Represents The Best Offer Size Associated With The Best Offer Price On A Consolidated Basis'
  national_best_bid_and_offer_short_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: best_bid_price_short
        type: decimal_u2_2
        doc: 'Represents The Best Bid Price On A Consolidated Basis Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: best_bid_size_short
        type: u2
        doc: 'Represents The Best Bid Size Associated With The Best Bid Price On A Consolidated Basis'
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Offer On A Consolidated Basis'
      - id: best_offer_price_short
        type: decimal_u2_2
        doc: 'Represents The Best Offer Price On A Consolidated Basis Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: best_offer_size_short
        type: u2
        doc: 'Represents The Best Offer Size Associated With The Best Offer Price On A Consolidated Basis'
  short_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Spacefilled'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Represents The Highest Price A Prospective Buyer Is Prepared To Pay At A Particular Time For A Security Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Identifies The Number Of Shares For A Symbol Rounded Down To The Nearest Multiple Of Its Round Lot Size'
      - id: offer_price_short
        type: decimal_u2_2
        doc: 'Represents The Lowest Price Acceptable To A Prospective Seller At A Particular Time For A Security Has Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: offer_size_short
        type: u2
        doc: 'Identifies The Number Of Shares For A Symbol Rounded Down To The Nearest Multiple Of Its Round Lot Size'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market For A Security'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates The Effect The New Quote Has On The National Bbo'
      - id: national_best_bid_long_appendage
        type: national_best_bid_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_no_best_offer_change or national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_quote_contains_best_offer or national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_no_best_offer
        doc: 'National Best Bid Long Appendage'
      - id: national_best_offer_long_appendage
        type: national_best_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::quote_contains_best_bid_best_offer_long_appendage or national_bbo_indicator == national_bbo_indicator::no_best_bid_best_offer_long_appendage
        doc: 'National Best Offer Long Appendage'
      - id: national_best_bid_and_offer_long_appendage
        type: national_best_bid_and_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Bid And Offer Long Appendage'
      - id: national_best_bid_short_appendage
        type: national_best_bid_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_no_best_offer_change or national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_quote_contains_best_offer or national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_no_best_offer
        doc: 'National Best Bid Short Appendage'
      - id: national_best_offer_short_appendage
        type: national_best_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::quote_contains_best_bid_best_offer_short_appendage or national_bbo_indicator == national_bbo_indicator::no_best_bid_best_offer_short_appendage
        doc: 'National Best Offer Short Appendage'
      - id: national_best_bid_and_offer_short_appendage
        type: national_best_bid_and_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Bid And Offer Short Appendage'
  special_long_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Spacefilled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote Used To Determine Whether A Quote Qualifies For The Best Bid And Best Offer Calculation'
      - id: security_status_indicator
        type: u1
        enum: security_status_indicator
        doc: 'Reports Trading Suspensions Price Indications Trading Range Indications Luld Price Bands And Market Wide Circuit Breaker Activity'
      - id: bid_price_long
        type: decimal_u8_6
        doc: 'Represents The Highest Price A Prospective Buyer Is Prepared To Pay At A Particular Time For A Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'Identifies The Number Of Shares For A Symbol Rounded Down To The Nearest Multiple Of Its Round Lot Size'
      - id: offer_price_long
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Acceptable To A Prospective Seller At A Particular Time For A Security Has Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: offer_size_long
        type: u4
        doc: 'Identifies The Number Of Shares For A Symbol Rounded Down To The Nearest Multiple Of Its Round Lot Size'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement Interest Priced Better Than The Protected Best Bid Or Offer By A Minimum Of 0001'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies The Settlement Condition For A Security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies The Market Condition Of A Quote For A Security'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Or The Finra Adf Identifier Fnra'
      - id: finra_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains The Finra Adf Provided Finra Best Bid Quote Condition Associated With The Finra Best Bid Price That Had The Finra Best Bid'
      - id: finra_best_bid_price
        type: decimal_u8_6
        doc: 'Contains The Finra Adf Provided Finra Best Bid Price That Is The Finra Best Bid. Implied decimal with scale 1e-6'
      - id: finra_best_bid_size
        type: u4
        doc: 'Contains The Finra Adf Provided Finra Best Bid Size Associated With The Finra Best Bid Price That Had The Finra Best Bid'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Bid Market Maker Identifier Of The Market Maker That Had The Finra Best Bid'
      - id: finra_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains The Finra Adf Provided Finra Best Offer Quote Condition Associated With The Finra Best Offer Price That Had The Finra Best Offer'
      - id: finra_best_offer_price
        type: decimal_u8_6
        doc: 'Contains The Finra Adf Provided Finra Best Offer Price That Is The Finra Best Offer. Implied decimal with scale 1e-6'
      - id: finra_best_offer_size
        type: u4
        doc: 'Contains The Finra Adf Provided Finra Best Offer Size Associated With The Finra Best Offer Price That Had The Finra Best Offer'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market For A Security'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: sip_generated_message_identifier
        type: u1
        enum: sip_generated_message_identifier
        doc: 'Identifies Cqs As The Originator Of A Message'
      - id: finra_bbo_luld_indicator
        type: u1
        enum: finra_bbo_luld_indicator
        doc: 'Indicates The Effect That The Limit Up Limit Down Price Bands Have On The Finra Best Bid And Finra Best Offer'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates The Effect That The Limit Up Limit Down Price Band Changes Have On The National Best Bid And National Best Offer'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates The Effect The New Quote Has On The National Bbo'
      - id: national_best_bid_long_appendage
        type: national_best_bid_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_no_best_offer_change or national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_quote_contains_best_offer or national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_no_best_offer
        doc: 'National Best Bid Long Appendage'
      - id: national_best_offer_long_appendage
        type: national_best_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::quote_contains_best_bid_best_offer_long_appendage or national_bbo_indicator == national_bbo_indicator::no_best_bid_best_offer_long_appendage
        doc: 'National Best Offer Long Appendage'
      - id: national_best_bid_and_offer_long_appendage
        type: national_best_bid_and_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Bid And Offer Long Appendage'
      - id: national_best_bid_short_appendage
        type: national_best_bid_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_no_best_offer_change or national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_quote_contains_best_offer or national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_no_best_offer
        doc: 'National Best Bid Short Appendage'
      - id: national_best_offer_short_appendage
        type: national_best_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::quote_contains_best_bid_best_offer_short_appendage or national_bbo_indicator == national_bbo_indicator::no_best_bid_best_offer_short_appendage
        doc: 'National Best Offer Short Appendage'
      - id: national_best_bid_and_offer_short_appendage
        type: national_best_bid_and_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Bid And Offer Short Appendage'
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
  message_category:
    0x41:
      id: 'administrative'
      doc: 'Administrative Category'
    0x43:
      id: 'control'
      doc: 'Control Category'
    0x4d:
      id: 'market_status'
      doc: 'Market Status Category'
    0x51:
      id: 'quote'
      doc: 'Quote Category'
  administrative_message_type:
    0x53:
      id: 'symbol_reference_data'
      doc: 'Symbol Reference Data'
  participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American Llc Nyse American'
    0x42:
      id: 'nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx Inc Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National Inc Nyse National'
    0x44:
      id: 'finra_adf'
      doc: 'Finra Alternative Display Facility Adf'
    0x47:
      id: 'n_24_x'
      doc: '24 X National Exchange Llc 24 X'
    0x48:
      id: 'miax'
      doc: 'Miax Pearl Exchange Llc Miax'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange Llc Ise'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe Edga Exchange Inc Cboe Edga'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe Edgx Exchange Inc Cboe Edgx'
    0x4c:
      id: 'ltse'
      doc: 'Long Term Stock Exchange Inc Ltse'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas Inc Nyse Texas'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange Llc Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca Inc Nyse Arca'
    0x53:
      id: 'cqs'
      doc: 'Consolidated Quotation System'
    0x54:
      id: 'nasdaq'
      doc: 'Nasdaq Stock Market Llc Nasdaq'
    0x55:
      id: 'memx'
      doc: 'Members Exchange Llc Memx'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange Llc Iex'
    0x57:
      id: 'cbsx'
      doc: 'Cboe Stock Exchange Inc Cbsx'
    0x58:
      id: 'nasdaq_omx_psx'
      doc: 'Nasdaq Omx Psx Inc Nasdaq Omx Psx'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe Byx Exchange Inc Cboe Byx'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx Exchange Inc Cboe Bzx'
  primary_listing_market_participant_id:
    0x20:
      id: 'primary_listing_market_participant_id_not_applicable'
      doc: 'Primary Listing Market Participant Id Not Applicable'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'finra_adf'
      doc: 'Finra Adf'
    0x47:
      id: 'n_24_x'
      doc: 'N 24 X'
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
      doc: 'Bankrupt Below Continuing Listing Standards And Late Filing'
    0x38:
      id: 'creations_suspended'
      doc: 'For Exchange Traded Products'
    0x39:
      id: 'redemptions_suspended'
      doc: 'For Exchange Traded Products'
    0x41:
      id: 'liquidation'
      doc: 'For Exchange Traded Products'
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
    0x43:
      id: 'finra_close'
      doc: 'Finra Close'
    0x4c:
      id: 'reset_block_sequence_number'
      doc: 'Reset Block Sequence Number'
    0x4f:
      id: 'finra_open'
      doc: 'Finra Open'
    0x50:
      id: 'disaster_recovery_data_center_activation'
      doc: 'Disaster Recovery Data Center Activation'
    0x54:
      id: 'line_integrity'
      doc: 'Line Integrity'
    0x5a:
      id: 'end_of_day'
      doc: 'End Of Day'
  market_status_message_type:
    0x4b:
      id: 'market_wide_circuit_breaker_decline_level_status'
      doc: 'Market Wide Circuit Breaker Decline Level Status'
    0x4c:
      id: 'market_wide_circuit_breaker_status'
      doc: 'Market Wide Circuit Breaker Status'
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
  quote_message_type:
    0x41:
      id: 'auction_status'
      doc: 'Auction Status'
    0x4c:
      id: 'long_quote'
      doc: 'Long Quote'
    0x51:
      id: 'short_quote'
      doc: 'Short Quote'
    0x53:
      id: 'special_long_quote'
      doc: 'Special Long Quote'
  quote_condition:
    0x20:
      id: 'quote_condition_not_applicable'
      doc: 'Quote Condition Not Applicable'
    0x41:
      id: 'slow_quote_on_offer_side'
      doc: 'Eligible For Bbo'
    0x42:
      id: 'slow_quote_on_bid_side'
      doc: 'Eligible For Bbo'
    0x43:
      id: 'closing'
      doc: 'Not Eligible For Bbo'
    0x45:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_the_bid_side'
      doc: 'Only Offer Side Is Eligible For Bbo'
    0x46:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_the_offer_side'
      doc: 'Only Bid Side Is Eligible For Bbo'
    0x48:
      id: 'slow_quote_on_the_bid_and_offer_sides'
      doc: 'Eligible For Bbo'
    0x4c:
      id: 'closed_market_maker'
      doc: 'Finra Not Eligible For Bbo'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Not Eligible For Bbo'
    0x4f:
      id: 'opening_quote'
      doc: 'Eligible For Bbo'
    0x52:
      id: 'regular'
      doc: 'Finra Open Eligible For Bbo'
    0x55:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_both_sides'
      doc: 'Not Eligible For Bbo'
    0x57:
      id: 'slow_quote_due_to_set_slow_list_on_both_sides'
      doc: 'Eligible For Bbo'
    0x34:
      id: 'on_demand_intra_day_auction'
      doc: 'Not Eligible For Bbo'
  security_status_indicator:
    0x20:
      id: 'security_status_indicator_not_applicable'
      doc: 'Security Status Indicator Not Applicable'
    0x41:
      id: 'additional_information_requested'
      doc: 'Regulatory'
    0x43:
      id: 'regulatory_concern'
      doc: 'Regulatory'
    0x44:
      id: 'news_released'
      doc: 'Regulatory'
    0x45:
      id: 'merger_effective'
      doc: 'Regulatory'
    0x46:
      id: 'etf_component_prices_not_available'
      doc: 'Regulatory'
    0x47:
      id: 'trading_range_indication'
      doc: 'Non Regulatory'
    0x49:
      id: 'order_imbalance'
      doc: 'Regulatory'
    0x4d:
      id: 'limit_up_limit_down_trading_pause'
      doc: 'Regulatory'
    0x4e:
      id: 'corporate_action'
      doc: 'Regulatory'
    0x4f:
      id: 'new_security_offering'
      doc: 'Regulatory'
    0x50:
      id: 'news_pending'
      doc: 'Regulatory'
    0x56:
      id: 'intraday_indicative_value_not_available'
      doc: 'Regulatory'
    0x54:
      id: 'resume'
      doc: 'Trading No Longer Suspended'
    0x58:
      id: 'operational'
      doc: 'Regulatory'
    0x59:
      id: 'sup_penny_trading'
      doc: 'Regulatory'
    0x5a:
      id: 'reserved'
      doc: 'Currently Not In Use'
    0x30:
      id: 'limit_up_limit_down_price_band'
      doc: 'Non Regulatory'
    0x31:
      id: 'market_wide_circuit_breaker_level_1_breached'
      doc: 'Regulatory'
    0x32:
      id: 'market_wide_circuit_breaker_level_2_breached'
      doc: 'Regulatory'
    0x33:
      id: 'market_wide_circuit_breaker_level_3_breached'
      doc: 'Regulatory'
    0x39:
      id: 'republished_limit_up_limit_down_price_band'
      doc: 'Non Regulatory'
  retail_interest_indicator:
    0x20:
      id: 'retail_interest_indicator_not_applicable'
      doc: 'Retail Interest Indicator Not Applicable'
    0x41:
      id: 'retail_interest_on_bid_quote'
      doc: 'Retail Interest On Bid Quote'
    0x42:
      id: 'retail_interest_on_offer_quote'
      doc: 'Retail Interest On Offer Quote'
    0x43:
      id: 'retail_interest_on_both_the_bid_and_offer_quotes'
      doc: 'Retail Interest On Both The Bid And Offer Quotes'
  settlement_condition:
    0x20:
      id: 'regular_way_settlement'
      doc: 'Regular Way Settlement'
    0x41:
      id: 'cash_settlement'
      doc: 'Cash Settlement'
    0x42:
      id: 'next_day_settlement'
      doc: 'Next Day Settlement'
  market_condition:
    0x20:
      id: 'normal_auction_market'
      doc: 'Normal Auction Market'
    0x41:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x42:
      id: 'locked_market'
      doc: 'Locked Market'
  finra_bbo_indicator:
    0x20:
      id: 'finra_bbo_indicator_not_applicable'
      doc: 'Used By Participants Other Than Finra Adf'
    0x41:
      id: 'no_finra_bbo_change'
      doc: 'No Finra Bbo Change'
    0x42:
      id: 'no_finra_bbo_exists'
      doc: 'No Finra Bbo Exists'
  sip_generated_message_identifier:
    0x20:
      id: 'sip_generated_message_not_applicable'
      doc: 'Sip Generated Message Not Applicable'
    0x53:
      id: 'consolidated_quotation_system'
      doc: 'Consolidated Quotation System'
  limit_up_limit_down_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'bid_price_above_upper_limit_price_band'
      doc: 'Bid Is Non Executable'
    0x42:
      id: 'offer_price_below_lower_limit_price_band'
      doc: 'Offer Is Non Executable'
  national_bbo_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'national_best_bid_andor_national_best_offer_are_executable'
      doc: 'National Best Bid Andor National Best Offer Are Executable'
    0x42:
      id: 'national_best_bid_below_lower_limit_price_band'
      doc: 'National Best Bid Is Non Executable'
    0x43:
      id: 'national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Offer Is Non Executable'
    0x44:
      id: 'national_best_bid_below_lower_and_national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Bid And National Best Offer Are Non Executable'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band'
      doc: 'National Best Bid Is In Limit State'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Offer Is In Limit State'
    0x47:
      id: 'national_best_bid_in_limit_state_and_national_best_offer_non_executable'
      doc: 'National Best Bid Equals Upper Limit Price Band And National Best Offer Above Upper Limit Price Band'
    0x48:
      id: 'national_best_bid_non_executable_and_national_best_offer_in_limit_state'
      doc: 'National Best Bid Below Lower Limit Price Band And National Best Offer Equals Lower Limit Price Band'
    0x49:
      id: 'national_best_bid_equals_upper_and_national_best_offer_equals_lower_limit_price_band'
      doc: 'Crossed Not In Limit State'
  national_bbo_indicator:
    0x20:
      id: 'quote_not_included_in_bbo'
      doc: 'New Quote Did Not Meet The Bbo Requirements'
    0x41:
      id: 'no_best_bid_change_no_best_offer_change'
      doc: 'No Best Bid Change No Best Offer Change'
    0x42:
      id: 'no_best_bid_change_quote_contains_best_offer'
      doc: 'No Best Bid Change Quote Contains Best Offer'
    0x43:
      id: 'no_best_bid_change_best_offer_short_appendage'
      doc: 'No Best Bid Change Best Offer Short Appendage'
    0x44:
      id: 'no_best_bid_change_best_offer_long_appendage'
      doc: 'No Best Bid Change Best Offer Long Appendage'
    0x45:
      id: 'no_best_bid_change_no_best_offer'
      doc: 'No Best Bid Change No Best Offer'
    0x46:
      id: 'quote_contains_best_bid_no_best_offer_change'
      doc: 'Quote Contains Best Bid No Best Offer Change'
    0x47:
      id: 'quote_contains_best_bid_quote_contains_best_offer'
      doc: 'Quote Contains Best Bid Quote Contains Best Offer'
    0x48:
      id: 'quote_contains_best_bid_best_offer_short_appendage'
      doc: 'Quote Contains Best Bid Best Offer Short Appendage'
    0x49:
      id: 'quote_contains_best_bid_best_offer_long_appendage'
      doc: 'Quote Contains Best Bid Best Offer Long Appendage'
    0x4a:
      id: 'quote_contains_best_bid_no_best_offer'
      doc: 'Quote Contains Best Bid No Best Offer'
    0x4b:
      id: 'no_best_bid_no_best_offer_change'
      doc: 'No Best Bid No Best Offer Change'
    0x4c:
      id: 'no_best_bid_quote_contains_best_offer'
      doc: 'No Best Bid Quote Contains Best Offer'
    0x4d:
      id: 'no_best_bid_best_offer_short_appendage'
      doc: 'No Best Bid Best Offer Short Appendage'
    0x4e:
      id: 'no_best_bid_best_offer_long_appendage'
      doc: 'No Best Bid Best Offer Long Appendage'
    0x4f:
      id: 'no_best_bid_no_best_offer'
      doc: 'No Best Bid No Best Offer'
    0x50:
      id: 'best_bid_short_appendage_no_best_offer_change'
      doc: 'Best Bid Short Appendage No Best Offer Change'
    0x51:
      id: 'best_bid_long_appendage_no_best_offer_change'
      doc: 'Best Bid Long Appendage No Best Offer Change'
    0x52:
      id: 'best_bid_short_appendage_quote_contains_best_offer'
      doc: 'Best Bid Short Appendage Quote Contains Best Offer'
    0x53:
      id: 'best_bid_long_appendage_quote_contains_best_offer'
      doc: 'Best Bid Long Appendage Quote Contains Best Offer'
    0x54:
      id: 'best_bid_short_appendage_best_offer_short_appendage'
      doc: 'Best Bid Short Appendage Best Offer Short Appendage'
    0x55:
      id: 'best_bid_long_appendage_best_offer_long_appendage'
      doc: 'Best Bid Long Appendage Best Offer Long Appendage'
    0x56:
      id: 'best_bid_short_appendage_no_best_offer'
      doc: 'Best Bid Short Appendage No Best Offer'
    0x57:
      id: 'best_bid_long_appendage_no_best_offer'
      doc: 'Best Bid Long Appendage No Best Offer'
  finra_bbo_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'finra_best_bid_and_finra_best_offer_are_executable'
      doc: 'Finra Best Bid And Finra Best Offer Are Executable'
    0x42:
      id: 'finra_best_bid_outside_price_band'
      doc: 'Finra Best Bid Is Non Executable'
    0x43:
      id: 'finra_best_offer_outside_price_band'
      doc: 'Finra Best Offer Is Non Executable'
    0x44:
      id: 'finra_best_bid_and_finra_best_offer_outside_price_band'
      doc: 'Finra Best Bid And Finra Best Offer Are Non Executable'

