# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Output Cta v1.91
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: Output
#   Encoding: Consolidated Tape Association
#   Version: 1.91
#   Date: 1/02/2020
#   Specification: CQS_BINARY_OUTPUT_SPECIFICATION.pdf
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
  id: siac_cqs_output_cta_v1_91
  title: Siac Cqs Output Cta v1.91
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Quotation System Output Cta v1.91'
doc-ref: https://www.ctaplan.com/tech-specs

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Block Header'
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
        doc: 'Cqs Binary Protocol Version'
      - id: block_size
        type: u2
        doc: 'Indicate Size In Bytes Of The Entire Transmission Bloc'
      - id: data_feed_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Q For Consolidated Quotation System'
      - id: retransmission_indicator
        type: u1
        enum: retransmission_indicator
        doc: 'Indicates An Original Message Or A Retransmitted Block'
      - id: block_sequence_number
        type: u4
        doc: 'All Transmission Blocks Are Assigned A Sequential Block Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Transmission Block'
      - id: sip_block_timestamp
        type: sip_block_timestamp
        doc: 'Sip Block Timestamp'
      - id: block_checksum
        type: u2
        doc: 'Lower 2 Bytes Of The 4 Byte Sum Of All The Bytes In The Block Excluding This Block Checksum Field'
  sip_block_timestamp:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Of Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond Portion Of The Time'
  message_struct:
    seq:
      - id: message_length
        type: u2
        doc: 'The Message Length Identifies The Total Message Length Inclusive Of The Message Header And Message Body'
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
        doc: 'Administrative message type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            'administrative_message_type::administrative_unformatted_message': administrative_unformatted_message
  administrative_unformatted_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: text
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free Form Text'
  participant_timestamp:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Of Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond Portion Of The Time'
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
            'control_message_type::finra_close_message': finra_close_message
            'control_message_type::reset_block_sequence_number_message': reset_block_sequence_number_message
            'control_message_type::start_of_test_cycle_message': start_of_test_cycle_message
            'control_message_type::end_of_test_cycle_message': end_of_test_cycle_message
            'control_message_type::finra_open_message': finra_open_message
            'control_message_type::disaster_recovery_data_center_activation_message': disaster_recovery_data_center_activation_message
            'control_message_type::line_integrity_message': line_integrity_message
            'control_message_type::end_of_day_message': end_of_day_message
  start_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  start_of_test_cycle_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
  end_of_test_cycle_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Market Status message type'
      - id: market_status_message_payload
        type:
          switch-on: market_status_message_type
          cases:
            'market_status_message_type::market_wide_circuit_breaker_decline_level_status_message': market_wide_circuit_breaker_decline_level_status_message
            'market_status_message_type::market_wide_circuit_breaker_status_message': market_wide_circuit_breaker_status_message
  market_wide_circuit_breaker_decline_level_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        doc: 'Identifies The Daily Established Drop Level Value Level 17 Of Previous Close Sp 500 Value Has Implied 6 Decimal Places'
      - id: mwcb_level_2
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Trigger Value Associated With Each Decline Level 13'
      - id: mwcb_level_3
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Trigger Value Associated With Each Decline Level 20'
      - id: reserved
        type: u1
        doc: 'Field Is Reserved For Future Use'
  market_wide_circuit_breaker_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
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
        type: u1
        doc: 'Field Is Reserved For Future Use'
  quote_message:
    seq:
      - id: quote_message_type
        type: u1
        enum: quote_message_type
        doc: 'Quote message type'
      - id: quote_message_payload
        type:
          switch-on: quote_message_type
          cases:
            'quote_message_type::auction_status_message': auction_status_message
            'quote_message_type::long_quote_message': long_quote_message
            'quote_message_type::short_quote_message': short_quote_message
            'quote_message_type::special_long_quote_message': special_long_quote_message
  auction_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: auction_collar_reference_price
        type: decimal_u8_6_nullable
        doc: 'Price Used By The Exchange To Establish The Auction Collar. Implied decimal with scale 1e-6. Nullable, Not Populated = 0'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6_nullable
        doc: 'Latest Upper Threshold Price Of The Auction Collar. Implied decimal with scale 1e-6. Nullable, Not Populated = 0'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6_nullable
        doc: 'Latest Lower Threshold Price Of The Auction Collar. Implied decimal with scale 1e-6. Nullable, Not Populated = 0'
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
      - id: future
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Field Is Reserved For Future Use'
  long_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote'
      - id: security_status_indicator
        type: u1
        enum: security_status_indicator
        doc: 'The Security Status Indicator Field Is Used To Report Trading Suspensions In A Security Price Indications Trading Range Indications Luld Price Bands And Market Wide Circuit Breaker Activity'
      - id: bid_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'Represents The Lower Price Band Value For A Security. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'The Bid Size Identifies The Number Of Roundlots For A Security'
      - id: offer_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'Represents The Upper Price Band Value For A Security. Implied decimal with scale 1e-6'
      - id: offer_size_long
        type: u4
        doc: 'The Offer Size Identifies The Number Of Roundlots For A Security'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'When Retail Price Improvement Rpi Interest Is Priced Better Than The Protected Best Bid Or Offer Pbbo By A Minimum Of 0001 An Indication Of Interest On The Bid Offer Or Both The Bid And Offer Will Identify That Interest Will Be Eligible To Interact With Incoming Retail Order Interest'
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
        doc: 'Contains The Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Adf Or The Finra Adf Identifier'
      - id: finra_bbo_indicator
        type: u1
        enum: finra_bbo_indicator
        doc: 'For Finra Adf Represents The Finra Bbo State Of The Finra Adf Quote'
      - id: adf_timestamp
        type: adf_timestamp
        doc: 'Adf Timestamp'
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
      - id: luld_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates The Affect The Quote Has On The Limit Up Limit Down Price Band Range'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates The Affect That The Limit Up Limit Down Price Band Changes Have On The National Best Bid And National Best Offer'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates The Affect The New Quote Has On The National Bbo'
      - id: national_best_bid_long_appendage
        type: national_best_bid_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Bid Long Appendage'
      - id: national_best_offer_long_appendage
        type: national_best_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Offer Long Appendage'
      - id: national_best_bid_short_appendage
        type: national_best_bid_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Bid Short Appendage'
      - id: national_best_offer_short_appendage
        type: national_best_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Offer Short Appendage'
  adf_timestamp:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Of Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond Portion Of The Time'
  national_best_bid_long_appendage:
    seq:
      - id: best_bid_participant_id
        type: u1
        enum: best_bid_participant_id
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Quote Condition Associated With The Best Offer Price On A Consolidated Basis'
      - id: best_bid_price_long
        type: decimal_u8_6
        doc: 'Represents The Best Offer Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: best_bid_size_long
        type: u4
        doc: 'Represents The Best Bid Size Associated With The Best Bid Price On A Consolidated Basis'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Bid Market Maker Identifier Of The Market Maker That Had The Finra Best Bid Fbbo'
  national_best_offer_long_appendage:
    seq:
      - id: best_offer_participant_id
        type: u1
        enum: best_offer_participant_id
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
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
        doc: 'Represents The Best Offer Size Associated With The Best Bid Price On A Consolidated Basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer'
  national_best_bid_short_appendage:
    seq:
      - id: best_bid_participant_id
        type: u1
        enum: best_bid_participant_id
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: best_bid_price_short
        type: decimal_u2_2
        doc: 'Represents The Best Offer Price On A Consolidated Basis. Implied decimal with scale 1e-2'
      - id: best_bid_size_short
        type: u2
        doc: 'Represents The Best Offer Bid Associated With The Best Bid Price On A Consolidated Basis'
  national_best_offer_short_appendage:
    seq:
      - id: best_offer_participant_id
        type: u1
        enum: best_offer_participant_id
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: best_offer_price_short
        type: decimal_u2_2
        doc: 'Represents The Best Offer Price On A Consolidated Basis. Implied decimal with scale 1e-2'
      - id: best_offer_size_short
        type: u2
        doc: 'Represents The Best Offer Size Associated With The Best Bid Price On A Consolidated Basis'
  short_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Represents The Highest Price A Prospective Buyer Is Prepared To Pay At A Particular Time For A Security. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'The Bid Size Identifies The Number Of Roundlots For A Security'
      - id: offer_price_short
        type: decimal_u2_2
        doc: 'Represents The Lowest Price Acceptable To A Prospective Seller At A Particular Time For A Security. Implied decimal with scale 1e-2'
      - id: offer_size_short
        type: u2
        doc: 'The Offer Size Identifies The Number Of Roundlots For A Security'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market For A Security'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates The Affect The New Quote Has On The National Bbo'
      - id: national_best_bid_long_appendage
        type: national_best_bid_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Bid Long Appendage'
      - id: national_best_offer_long_appendage
        type: national_best_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Offer Long Appendage'
      - id: national_best_bid_short_appendage
        type: national_best_bid_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Bid Short Appendage'
      - id: national_best_offer_short_appendage
        type: national_best_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Offer Short Appendage'
  special_long_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: participant_timestamp
        type: participant_timestamp
        doc: 'Participant Timestamp'
      - id: message_id
        type: u1
        doc: 'The Message Id Identifies The Individual Message Within The Block Beginning With Number One'
      - id: transaction_id
        type: u4
        doc: 'The Transaction Id Will Be Populated By Cqs And Is Reserved For Internal Use Only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number Is A Passthru Of The Inbound Participant Reference Number Assigned To A Transaction'
      - id: security_symbol_long
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote'
      - id: security_status_indicator
        type: u1
        enum: security_status_indicator
        doc: 'The Security Status Indicator Field Is Used To Report Trading Suspensions In A Security Price Indications Trading Range Indications Luld Price Bands And Market Wide Circuit Breaker Activity'
      - id: bid_price_long
        type: decimal_u8_6
        doc: 'Represents The Highest Price A Prospective Buyer Is Prepared To Pay At A Particular Time For A Security. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'The Bid Size Identifies The Number Of Roundlots For A Security'
      - id: offer_price_long
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Acceptable To A Prospective Seller At A Particular Time For A Security. Implied decimal with scale 1e-6'
      - id: offer_size_long
        type: u4
        doc: 'The Offer Size Identifies The Number Of Roundlots For A Security'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'When Retail Price Improvement Rpi Interest Is Priced Better Than The Protected Best Bid Or Offer Pbbo By A Minimum Of 0001 An Indication Of Interest On The Bid Offer Or Both The Bid And Offer Will Identify That Interest Will Be Eligible To Interact With Incoming Retail Order Interest'
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
        doc: 'Contains The Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Adf Or The Finra Adf Identifier'
      - id: finra_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains The Finra Adf Provided Finra Best Bid Price That Is The Finra Best Bid Fbbo'
      - id: finra_best_bid_price
        type: decimal_u8_6
        doc: 'Contains The Finra Adf Provided Finra Best Bid Price That Is The Finra Best Bid Fbbo. Implied decimal with scale 1e-6'
      - id: finra_best_bid_size
        type: u4
        doc: 'Contains The Finra Adf Provided Finra Best Bid Size Associated With The Finra Best Bid Price That Had The Finra Best Bid'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Bid Market Maker Identifier Of The Market Maker That Had The Finra Best Bid Fbbo'
      - id: finra_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains The Finra Adf Provided Finra Best Offer Quote Condition Associated With The Best Finra Offer Price That Had The Finra Best Offer'
      - id: finra_best_offer_price
        type: decimal_u8_6
        doc: 'Contains The Finraadf Provided Best Finra Offer Price That Is The Finra Best Offer. Implied decimal with scale 1e-6'
      - id: finra_best_offer_size
        type: u4
        doc: 'Contains The Finra Adf Provided Finra Best Offer Size Associated With The Finra Best Offer Price That Had The Finra Best Offer'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer'
      - id: adf_timestamp
        type: adf_timestamp
        doc: 'Adf Timestamp'
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
        doc: 'Indicates The Affect That The Limit Up Limit Down Price Bands Have On The Finra Best Bid And Finra Best Offer'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates The Affect That The Limit Up Limit Down Price Band Changes Have On The National Best Bid And National Best Offer'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates The Affect The New Quote Has On The National Bbo'
      - id: national_best_bid_long_appendage
        type: national_best_bid_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Bid Long Appendage'
      - id: national_best_offer_long_appendage
        type: national_best_offer_long_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_long_appendage_best_offer_long_appendage
        doc: 'National Best Offer Long Appendage'
      - id: national_best_bid_short_appendage
        type: national_best_bid_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Bid Short Appendage'
      - id: national_best_offer_short_appendage
        type: national_best_offer_short_appendage
        if: national_bbo_indicator == national_bbo_indicator::best_bid_short_appendage_best_offer_short_appendage
        doc: 'National Best Offer Short Appendage'
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_u8_6_nullable:
    seq:
      - id: value
        type: decimal_u8_6
    instances:
      is_null:
        value: value.mantissa == 0
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
      doc: 'Original Message'
    0x56:
      id: 'retransmitted'
      doc: 'Retransmitted Message'
  message_category:
    0x41:
      id: 'administrative'
      doc: 'Administrative Messages Header'
    0x43:
      id: 'control'
      doc: 'Control Messages Header'
    0x4d:
      id: 'market_status'
      doc: 'Market Status Messages Header'
    0x51:
      id: 'quote'
      doc: 'Quote Messages'
  administrative_message_type:
    0x48:
      id: 'administrative_unformatted_message'
      doc: 'Administrative Unformatted Message'
  participant_id:
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
      doc: 'Finra Alternative Display Facility'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe Edga Exchange'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe Edgx Exchange'
    0x4c:
      id: 'ltse'
      doc: 'Long Term Stock Exchange'
    0x4d:
      id: 'nyse_chicago'
      doc: 'Nyse Chicago'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x53:
      id: 'cqs'
      doc: 'Consolidated Quotation System'
    0x54:
      id: 'nasdaq'
      doc: 'Nasdaq Stock Market'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange'
    0x57:
      id: 'cbsx'
      doc: 'Cboe Stock Exchange'
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Omx Psx'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe Byx Exchange'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx Exchange'
  control_message_type:
    0x41:
      id: 'start_of_day_message'
      doc: 'Start Of Day Message'
    0x43:
      id: 'finra_close_message'
      doc: 'Finra Close Message'
    0x4c:
      id: 'reset_block_sequence_number_message'
      doc: 'Reset Block Sequence Number Message'
    0x4d:
      id: 'start_of_test_cycle_message'
      doc: 'Start Of Test Cycle Message'
    0x4e:
      id: 'end_of_test_cycle_message'
      doc: 'End Of Test Cycle Message'
    0x4f:
      id: 'finra_open_message'
      doc: 'Finra Open Message'
    0x50:
      id: 'disaster_recovery_data_center_activation_message'
      doc: 'Disaster Recovery Data Center Activation Message'
    0x54:
      id: 'line_integrity_message'
      doc: 'Line Integrity Message'
    0x5a:
      id: 'end_of_day_message'
      doc: 'End Of Day Message'
  market_status_message_type:
    0x4d:
      id: 'market_wide_circuit_breaker_decline_level_status_message'
      doc: 'Market Wide Circuit Breaker Decline Level Status Message'
    0x4c:
      id: 'market_wide_circuit_breaker_status_message'
      doc: 'Market Wide Circuit Breaker Status Message'
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
      id: 'auction_status_message'
      doc: 'Auction Status Message'
    0x4c:
      id: 'long_quote_message'
      doc: 'Long Quote Message'
    0x51:
      id: 'short_quote_message'
      doc: 'Short Quote Message'
    0x53:
      id: 'special_long_quote_message'
      doc: 'Special Long Quote Message'
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
  short_sale_restriction_indicator:
    0x20:
      id: 'not_in_effect'
      doc: 'Not In Effect'
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
  primary_listing_market_participant_id:
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
    0x49:
      id: 'ise'
      doc: 'Ise'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe Edga'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe Edgx'
    0x4d:
      id: 'nyse_chicago'
      doc: 'Nyse Chicago'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x54:
      id: 'nasdaq'
      doc: 'Nasdaq'
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
      doc: 'Creations Suspended'
    0x39:
      id: 'redemptions_suspended'
      doc: 'Redemptions Suspended'
    0x41:
      id: 'liquidation'
      doc: 'Liquidation'
  quote_condition:
    0x20:
      id: 'quote_condition_not_applicable'
      doc: 'Quote Condition Not Applicable'
    0x41:
      id: 'slow_quote_on_offer_side'
      doc: 'Slow Quote On Offer Side'
    0x42:
      id: 'slow_quote_on_bid_side'
      doc: 'Slow Quote On Bid Side'
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x45:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_the_bid_side'
      doc: 'Slow Quote Due To Lrp Or Gap Quote On The Bid Side'
    0x46:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_the_offer_side'
      doc: 'Slow Quote Due To Lrp Or Gap Quote On The Offer Side'
    0x48:
      id: 'slow_quote_on_the_bid_and_offer_sides'
      doc: 'Slow Quote On The Bid And Offer Sides'
    0x4c:
      id: 'closed_market_maker'
      doc: 'Closed Market Maker'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Non Firm Quote'
    0x4f:
      id: 'opening_quote'
      doc: 'Opening Quote'
    0x52:
      id: 'regular_finra_open'
      doc: 'Regular Finra Open'
    0x55:
      id: 'slow_quote_due_to_liquidity_replenishment_point_or_gap_quote_on_both_the_bid_and_offer_sides'
      doc: 'Slow Quote Due To Liquidity Replenishment Point Or Gap Quote On Both The Bid And Offer Sides'
    0x57:
      id: 'slow_quote_due_to_set_slow_list_on_both_the_bid_and_offer_sides'
      doc: 'Slow Quote Due To Set Slow List On Both The Bid And Offer Sides'
    0x34:
      id: 'on_demand_intra_day_auction'
      doc: 'On Demand Intra Day Auction'
  security_status_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x44:
      id: 'news_dissemination'
      doc: 'News Dissemination'
    0x47:
      id: 'trading_range_indication'
      doc: 'Trading Range Indication'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4d:
      id: 'luld_trading_pause'
      doc: 'Luld Trading Pause'
    0x50:
      id: 'news_pending'
      doc: 'News Pending'
    0x54:
      id: 'resume'
      doc: 'Resume'
    0x58:
      id: 'operational'
      doc: 'Operational'
    0x59:
      id: 'sup_penny_trading'
      doc: 'Sup Penny Trading'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No Open No Resume'
    0x30:
      id: 'luld_price_band'
      doc: 'Luld Price Band'
    0x31:
      id: 'market_wide_circuit_breaker_level_1_breached'
      doc: 'Market Wide Circuit Breaker Level 1 Breached'
    0x32:
      id: 'market_wide_circuit_breaker_level_2_breached'
      doc: 'Market Wide Circuit Breaker Level 2 Breached'
    0x33:
      id: 'market_wide_circuit_breaker_level_3_breached'
      doc: 'Market Wide Circuit Breaker Level 3 Breached'
    0x39:
      id: 'republished_luld_price_band'
      doc: 'Republished Luld Price Band'
  retail_interest_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      id: 'cash_only_settlement'
      doc: 'Cash Only Settlement'
    0x42:
      id: 'next_day_only_settlement'
      doc: 'Next Day Only Settlement'
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
      id: 'not_applicable'
      doc: 'Finra Bbo Indicator Not Applicable'
    0x41:
      id: 'no_finra_bbo_change'
      doc: 'No Finra Bbo Change'
    0x42:
      id: 'no_finra_bbo_exists'
      doc: 'No Finra Bbo Exists'
  sip_generated_message_identifier:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x53:
      id: 'consolidated_quotation_system'
      doc: 'Consolidated Quotation System'
  national_bbo_luld_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'national_best_bid_and_or_national_best_offer_are_executable'
      doc: 'National Best Bid And Or National Best Offer Are Executable'
    0x42:
      id: 'national_best_bid_below_lower_limit_price_band_and_is_non_executable'
      doc: 'National Best Bid Below Lower Limit Price Band And Is Non Executable'
    0x43:
      id: 'national_best_offer_above_upper_limit_price_band_and_is_non_executable'
      doc: 'National Best Offer Above Upper Limit Price Band And Is Non Executable'
    0x44:
      id: 'national_best_bid_below_lower_limit_price_band_and_national_best_offer_above_upper_limit_price_band_both_are_non_executable'
      doc: 'National Best Bid Below Lower Limit Price Band And National Best Offer Above Upper Limit Price Band Both Are Non Executable'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band_and_is_in_limit_state'
      doc: 'National Best Bid Equals Upper Limit Price Band And Is In Limit State'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band_and_is_in_limit_state'
      doc: 'National Best Offer Equals Lower Limit Price Band And Is In Limit State'
    0x47:
      id: 'national_best_bid_equals_upper_limit_price_band_and_is_in_limit_state_and_national_best_offer_above_upper_limit_price_band_and_is_non_executable'
      doc: 'National Best Bid Equals Upper Limit Price Band And Is In Limit State And National Best Offer Above Upper Limit Price Band And Is Non Executable'
    0x48:
      id: 'national_best_bid_below_lower_limit_price_band_and_is_non_executable_and_national_best_offer_equals_lower_limit_price_band_and_is_in_limit_state'
      doc: 'National Best Bid Below Lower Limit Price Band And Is Non Executable And National Best Offer Equals Lower Limit Price Band And Is In Limit State'
    0x49:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Bid Equals Upper Limit Price Band And National Best Offer Equals Lower Limit Price Band'
  national_bbo_indicator:
    0x20:
      id: 'not_included'
      doc: 'Not Included In The Bbo'
    0x41:
      id: 'no_best_bid_change_or_best_offer_change'
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
  best_bid_participant_id:
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
      doc: 'Finra Alternative Display Facility'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe Edga Exchange'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe Edgx Exchange'
    0x4c:
      id: 'ltse'
      doc: 'Long Term Stock Exchange'
    0x4d:
      id: 'nyse_chicago'
      doc: 'Nyse Chicago'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x53:
      id: 'cqs'
      doc: 'Consolidated Quotation System'
    0x54:
      id: 'nasdaq'
      doc: 'Nasdaq Stock Market'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange'
    0x57:
      id: 'cbsx'
      doc: 'Cboe Stock Exchange'
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Omx Psx'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe Byx Exchange'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx Exchange'
  best_offer_participant_id:
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
      doc: 'Finra Alternative Display Facility'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe Edga Exchange'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe Edgx Exchange'
    0x4c:
      id: 'ltse'
      doc: 'Long Term Stock Exchange'
    0x4d:
      id: 'nyse_chicago'
      doc: 'Nyse Chicago'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x53:
      id: 'cqs'
      doc: 'Consolidated Quotation System'
    0x54:
      id: 'nasdaq'
      doc: 'Nasdaq Stock Market'
    0x56:
      id: 'iex'
      doc: 'Investors Exchange'
    0x57:
      id: 'cbsx'
      doc: 'Cboe Stock Exchange'
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Omx Psx'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe Byx Exchange'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx Exchange'
  finra_bbo_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'finra_best_bid_and_or_finra_best_offer_are_executable'
      doc: 'Finra Best Bid And Or Finra Best Offer Are Executable'
    0x42:
      id: 'finra_best_bid_below_lower_limit_price_band_and_finra_best_bid_is_non_executable'
      doc: 'Finra Best Bid Below Lower Limit Price Band And Finra Best Bid Is Non Executable'
    0x43:
      id: 'finra_best_offer_above_upper_limit_price_band_and_finra_best_offer_is_non_executable'
      doc: 'Finra Best Offer Above Upper Limit Price Band And Finra Best Offer Is Non Executable'
    0x44:
      id: 'best_bid_below_lower_limit_price_band_and_best_offer_above_upper_limit_price_band_best_bid_and_best_offer_are_non_executable_for_finra'
      doc: 'Finra Best Bid Below Lower Limit Price Band And Finra Best Offer Above Upper Limit Price Band Finra Best Bid And Finra Best Offer Are Non Executable'

