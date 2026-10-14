# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Output Cta v2.10.a
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.10.a
#   Date: 06/06/2025
#   Specification: CQS_Pillar_Output_Specification.pdf
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
            'message_category::market_status': market_status_message
            'message_category::quote': quote_message
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
            'administrative_message_type::symbol_reference_data': symbol_reference_data_message
  symbol_reference_data_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol. Left justified, space-filled'
      - id: prior_security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the prior security symbol, left justified, space filled'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market for a security'
      - id: primary_listing_market_previous_closing_price
        type: decimal_u8_6
        doc: 'Primary Listing Market Previous Closing Price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: consolidated_closing_price
        type: decimal_u8_6
        doc: 'Consolidated Closing Price. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: round_lot_size
        type: u2
        doc: 'Round-lot size for a symbol can consist of 1, 10, 40 or 100 shares'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled. Field is reserved for future use'
      - id: luld_tier
        type: u1
        enum: luld_tier
        doc: 'Identifies the Limit Up Limit Down tier of the security symbol'
      - id: luld_leverage_ratio
        type: u4
        doc: 'Represents the Leverage ratio associated with the LULD Tier of the security symbol. Has implied 6 decimal places'
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
        doc: 'Identifies whether or not a Short Sale Restriction is in effect'
      - id: halt_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Denotes the reason for the Trading Halt'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the quote'
      - id: second_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled. Field is reserved for future use'
      - id: third_reserved
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
  timestamp_1:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
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
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  finra_close_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  reset_block_sequence_number_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  finra_open_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  disaster_recovery_data_center_activation_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  line_integrity_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
  end_of_day_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
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
  market_wide_circuit_breaker_decline_level_status_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: mwcb_level_1
        type: s8
        doc: 'Identifies the daily established drop level value associated with Level 1 = 7% of Previous Close S&P 500 Value. Has implied 6 decimal places'
      - id: mwcb_level_2
        type: s8
        doc: 'Identifies the daily established drop level value associated with Level 2 = 13% of Previous Close S&P 500 Value. Has implied 6 decimal places'
      - id: mwcb_level_3
        type: s8
        doc: 'Identifies the daily established drop level value associated with Level 3 = 20% of Previous Close S&P 500 Value. Has implied 6 decimal places'
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
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: market_wide_circuit_breaker_level_indicator
        type: u1
        enum: market_wide_circuit_breaker_level_indicator
        doc: 'Identifies the threshold level that was breached'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled. Field is reserved for future use'
  quote_message:
    seq:
      - id: quote_message_type
        type: u1
        enum: quote_message_type
        doc: 'Identifies the type of Quote message'
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
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the quote'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'Represents the price used by the exchange to establish the Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest upper threshold price of the Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest lower threshold price of the Auction Collar. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Identifies the number of manual or automatic extensions the applicable auction has received'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market for a security'
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
  long_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes a particular condition applicable to the quote used to determine whether a quote qualifies for the Best Bid and Best Offer calculation'
      - id: security_status_indicator
        type: u1
        enum: security_status_indicator
        doc: 'Reports trading suspensions, price indications, trading range indications, LULD Price Bands and Market Wide Circuit Breaker activity'
      - id: bid_price_lower_limit_price_band
        type: decimal_u8_6
        doc: 'Bid Price represents the highest price a prospective buyer is prepared to pay; Lower Limit Price Band represents the lower price band value when Security Status Indicator is Limit Up-Limit Down Price Band. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'Identifies the number of shares for a symbol rounded down to the nearest multiple of its Round Lot Size'
      - id: offer_price_upper_limit_price_band
        type: decimal_u8_6
        doc: 'Offer Price represents the lowest price acceptable to a prospective seller at a particular time for a security; Upper Limit Price Band represents the upper price band value when Security Status Indicator is Limit Up-Limit Down Price Band. Implied decimal with scale 1e-6'
      - id: offer_size_long
        type: u4
        doc: 'Identifies the number of shares for a symbol rounded down to the nearest multiple of its Round Lot Size'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement interest priced better than the Protected Best Bid or Offer by a minimum of $0.001'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies the settlement condition for a security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies the market condition of a quote for a security'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA Market Maker ID of the quoting participant on FINRA''s Alternative Display Facility or the FINRA ADF Identifier ''FNRA'''
      - id: finra_bbo_indicator
        type: u1
        enum: finra_bbo_indicator
        doc: 'For FINRA ADF, represents the FINRA BBO state of the FINRA ADF quote'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market for a security'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: sip_generated_message_identifier
        type: u1
        enum: sip_generated_message_identifier
        doc: 'Identifies CQS as the originator of a message'
      - id: limit_up_limit_down_luld_indicator
        type: u1
        enum: limit_up_limit_down_luld_indicator
        doc: 'Indicates the effect the Quote has on the Limit Up-Limit Down Price Band range'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates the effect that the Limit Up-Limit Down Price Band changes have on the National Best Bid and National Best Offer'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates the effect the new quote has on the National BBO'
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
        type: second_timestamp
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond. Nanoseconds since Second epoch'
  national_best_bid_long_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Bid on a consolidated basis'
      - id: best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Quote Condition associated with the Best Bid Price on a consolidated basis'
      - id: best_bid_price_long
        type: decimal_u8_6
        doc: 'Represents the Best Bid Price on a consolidated basis. Implied decimal with scale 1e-6'
      - id: best_bid_size_long
        type: u4
        doc: 'Represents the Best Bid Size associated with the Best Bid Price on a consolidated basis'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Market Maker identifier of the Market Maker that had the FINRA Best Bid'
  national_best_offer_long_appendage:
    seq:
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Offer on a consolidated basis'
      - id: best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Quote Condition associated with the Best Offer Price on a consolidated basis'
      - id: best_offer_price_long
        type: decimal_u8_6
        doc: 'Represents the Best Offer Price on a consolidated basis. Implied decimal with scale 1e-6'
      - id: best_offer_size_long
        type: u4
        doc: 'Represents the Best Offer Size associated with the Best Offer Price on a consolidated basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Market Maker identifier of the Market Maker that had the FINRA Best Offer'
  national_best_bid_and_offer_long_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Bid on a consolidated basis'
      - id: best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Quote Condition associated with the Best Bid Price on a consolidated basis'
      - id: best_bid_price_long
        type: decimal_u8_6
        doc: 'Represents the Best Bid Price on a consolidated basis. Implied decimal with scale 1e-6'
      - id: best_bid_size_long
        type: u4
        doc: 'Represents the Best Bid Size associated with the Best Bid Price on a consolidated basis'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Market Maker identifier of the Market Maker that had the FINRA Best Bid'
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Offer on a consolidated basis'
      - id: best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Quote Condition associated with the Best Offer Price on a consolidated basis'
      - id: best_offer_price_long
        type: decimal_u8_6
        doc: 'Represents the Best Offer Price on a consolidated basis. Implied decimal with scale 1e-6'
      - id: best_offer_size_long
        type: u4
        doc: 'Represents the Best Offer Size associated with the Best Offer Price on a consolidated basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Market Maker identifier of the Market Maker that had the FINRA Best Offer'
  national_best_bid_short_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Bid on a consolidated basis'
      - id: best_bid_price_short
        type: decimal_u2_2
        doc: 'Represents the Best Bid Price on a consolidated basis. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: best_bid_size_short
        type: u2
        doc: 'Represents the Best Bid Size associated with the Best Bid Price on a consolidated basis'
  national_best_offer_short_appendage:
    seq:
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Offer on a consolidated basis'
      - id: best_offer_price_short
        type: decimal_u2_2
        doc: 'Represents the Best Offer Price on a consolidated basis. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: best_offer_size_short
        type: u2
        doc: 'Represents the Best Offer Size associated with the Best Offer Price on a consolidated basis'
  national_best_bid_and_offer_short_appendage:
    seq:
      - id: best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Bid on a consolidated basis'
      - id: best_bid_price_short
        type: decimal_u2_2
        doc: 'Represents the Best Bid Price on a consolidated basis. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: best_bid_size_short
        type: u2
        doc: 'Represents the Best Bid Size associated with the Best Bid Price on a consolidated basis'
      - id: best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Offer on a consolidated basis'
      - id: best_offer_price_short
        type: decimal_u2_2
        doc: 'Represents the Best Offer Price on a consolidated basis. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: best_offer_size_short
        type: u2
        doc: 'Represents the Best Offer Size associated with the Best Offer Price on a consolidated basis'
  short_quote_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol. Left justified, space-filled'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Represents the highest price a prospective buyer is prepared to pay at a particular time for a security. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Identifies the number of shares for a symbol rounded down to the nearest multiple of its Round Lot Size'
      - id: offer_price_short
        type: decimal_u2_2
        doc: 'Represents the lowest price acceptable to a prospective seller at a particular time for a security. Has implied 2 decimal places. Implied decimal with scale 1e-2'
      - id: offer_size_short
        type: u2
        doc: 'Identifies the number of shares for a symbol rounded down to the nearest multiple of its Round Lot Size'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market for a security'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates the effect the new quote has on the National BBO'
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
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: timestamp_1
        type: timestamp_1
        doc: 'Timestamp 1. Nanoseconds since Unix epoch'
      - id: message_id
        type: u1
        doc: 'The Message ID identifies the individual message within the block beginning with number one'
      - id: transaction_id
        type: u4
        doc: 'The Transaction ID will be populated by CQS and is Reserved for Internal Use only'
      - id: participant_reference_number
        type: s8
        doc: 'Participant Reference Number is a pass-thru of the inbound Participant Reference number assigned to a transaction'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol. Left justified, space-filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes a particular condition applicable to the quote used to determine whether a quote qualifies for the Best Bid and Best Offer calculation'
      - id: security_status_indicator
        type: u1
        enum: security_status_indicator
        doc: 'Reports trading suspensions, price indications, trading range indications, LULD Price Bands and Market Wide Circuit Breaker activity'
      - id: bid_price_long
        type: decimal_u8_6
        doc: 'Represents the highest price a prospective buyer is prepared to pay at a particular time for a security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: bid_size_long
        type: u4
        doc: 'Identifies the number of shares for a symbol rounded down to the nearest multiple of its Round Lot Size'
      - id: offer_price_long
        type: decimal_u8_6
        doc: 'Represents the lowest price acceptable to a prospective seller at a particular time for a security. Has implied 6 decimal places. Implied decimal with scale 1e-6'
      - id: offer_size_long
        type: u4
        doc: 'Identifies the number of shares for a symbol rounded down to the nearest multiple of its Round Lot Size'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement interest priced better than the Protected Best Bid or Offer by a minimum of $0.001'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies the settlement condition for a security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies the market condition of a quote for a security'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA Market Maker ID of the quoting participant on FINRA''s Alternative Display Facility or the FINRA ADF Identifier ''FNRA'''
      - id: finra_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Quote Condition associated with the FINRA Best Bid Price that had the FINRA Best Bid'
      - id: finra_best_bid_price
        type: decimal_u8_6
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Price that is the FINRA Best Bid. Implied decimal with scale 1e-6'
      - id: finra_best_bid_size
        type: u4
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Size associated with the FINRA Best Bid Price that had the FINRA Best Bid'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Market Maker identifier of the Market Maker that had the FINRA Best Bid'
      - id: finra_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Quote Condition associated with the FINRA Best Offer Price that had the FINRA Best Offer'
      - id: finra_best_offer_price
        type: decimal_u8_6
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Price that is the FINRA Best Offer. Implied decimal with scale 1e-6'
      - id: finra_best_offer_size
        type: u4
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Size associated with the FINRA Best Offer Price that had the FINRA Best Offer'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Market Maker identifier of the Market Maker that had the FINRA Best Offer'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2. Nanoseconds since Unix epoch. Nullable, Not Applicable = 0'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether or not a Short Sale Restriction is in effect'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market for a security'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: sip_generated_message_identifier
        type: u1
        enum: sip_generated_message_identifier
        doc: 'Identifies CQS as the originator of a message'
      - id: finra_bbo_luld_indicator
        type: u1
        enum: finra_bbo_luld_indicator
        doc: 'Indicates the effect that the Limit Up-Limit Down Price Bands have on the FINRA Best Bid and FINRA Best Offer'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates the effect that the Limit Up-Limit Down Price Band changes have on the National Best Bid and National Best Offer'
      - id: national_bbo_indicator
        type: u1
        enum: national_bbo_indicator
        doc: 'Indicates the effect the new quote has on the National BBO'
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
      doc: 'NYSE American, LLC (NYSE American)'
    0x42:
      id: 'nasdaq_omx_bx'
      doc: 'NASDAQ OMX BX, Inc. (NASDAQ OMX BX)'
    0x43:
      id: 'nyse_national'
      doc: 'NYSE National, Inc. (NYSE National)'
    0x44:
      id: 'finra_adf'
      doc: 'FINRA Alternative Display Facility (ADF)'
    0x47:
      id: 'n_24_x'
      doc: '24X National Exchange LLC (24X)'
    0x48:
      id: 'miax'
      doc: 'MIAX Pearl Exchange, LLC (MIAX)'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange, LLC (ISE)'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe EDGA Exchange, Inc. (Cboe EDGA)'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe EDGX Exchange, Inc. (Cboe EDGX)'
    0x4c:
      id: 'ltse'
      doc: 'Long-Term Stock Exchange, Inc. (LTSE)'
    0x4d:
      id: 'nyse_texas'
      doc: 'NYSE Texas, Inc. (NYSE Texas)'
    0x4e:
      id: 'nyse'
      doc: 'New York Stock Exchange, LLC (NYSE)'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca, Inc. (NYSE Arca)'
    0x53:
      id: 'cqs'
      doc: 'Consolidated Quotation System'
    0x54:
      id: 'nasdaq'
      doc: 'NASDAQ Stock Market, LLC (NASDAQ)'
    0x55:
      id: 'memx'
      doc: 'Members Exchange, LLC (MEMX)'
    0x56:
      id: 'iex'
      doc: 'Investors'' Exchange, LLC. (IEX)'
    0x57:
      id: 'cbsx'
      doc: 'CBOE Stock Exchange, Inc. (CBSX)'
    0x58:
      id: 'nasdaq_omx_psx'
      doc: 'NASDAQ OMX PSX, Inc. (NASDAQ OMX PSX)'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe BYX Exchange, Inc. (Cboe BYX)'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe BZX Exchange, Inc. (Cboe BZX)'
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
      doc: 'Eligible for BBO'
    0x42:
      id: 'slow_quote_on_bid_side'
      doc: 'Eligible for BBO'
    0x43:
      id: 'closing'
      doc: 'Not eligible for BBO'
    0x45:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_the_bid_side'
      doc: 'Only Offer side is eligible for BBO'
    0x46:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_the_offer_side'
      doc: 'Only Bid side is eligible for BBO'
    0x48:
      id: 'slow_quote_on_the_bid_and_offer_sides'
      doc: 'Eligible for BBO'
    0x4c:
      id: 'closed_market_maker'
      doc: 'FINRA. Not eligible for BBO'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Not eligible for BBO'
    0x4f:
      id: 'opening_quote'
      doc: 'Eligible for BBO'
    0x52:
      id: 'regular'
      doc: 'FINRA Open. Eligible for BBO'
    0x55:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_both_sides'
      doc: 'Not eligible for BBO'
    0x57:
      id: 'slow_quote_due_to_set_slow_list_on_both_sides'
      doc: 'Eligible for BBO'
    0x34:
      id: 'on_demand_intra_day_auction'
      doc: 'Not eligible for BBO'
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
      doc: 'Trading no longer suspended'
    0x58:
      id: 'operational'
      doc: 'Regulatory'
    0x59:
      id: 'sup_penny_trading'
      doc: 'Regulatory'
    0x5a:
      id: 'reserved'
      doc: 'Currently not in use'
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
      doc: 'Used by Participants other than FINRA ADF'
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
      doc: 'Bid is Non-Executable'
    0x42:
      id: 'offer_price_below_lower_limit_price_band'
      doc: 'Offer is Non-Executable'
  national_bbo_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'national_best_bid_andor_national_best_offer_are_executable'
      doc: 'National Best Bid Andor National Best Offer Are Executable'
    0x42:
      id: 'national_best_bid_below_lower_limit_price_band'
      doc: 'National Best Bid is Non-Executable'
    0x43:
      id: 'national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Offer is Non-Executable'
    0x44:
      id: 'national_best_bid_below_lower_and_national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Bid and National Best Offer are Non-Executable'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band'
      doc: 'National Best Bid is in Limit State'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Offer is in Limit State'
    0x47:
      id: 'national_best_bid_in_limit_state_and_national_best_offer_non_executable'
      doc: 'National Best Bid equals Upper Limit Price Band and National Best Offer above Upper Limit Price Band'
    0x48:
      id: 'national_best_bid_non_executable_and_national_best_offer_in_limit_state'
      doc: 'National Best Bid below Lower Limit Price Band and National Best Offer equals Lower Limit Price Band'
    0x49:
      id: 'national_best_bid_equals_upper_and_national_best_offer_equals_lower_limit_price_band'
      doc: 'Crossed - NOT in Limit State'
  national_bbo_indicator:
    0x20:
      id: 'quote_not_included_in_bbo'
      doc: 'New quote did not meet the BBO requirements'
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
      doc: 'FINRA Best Bid is Non-Executable'
    0x43:
      id: 'finra_best_offer_outside_price_band'
      doc: 'FINRA Best Offer is Non-Executable'
    0x44:
      id: 'finra_best_bid_and_finra_best_offer_outside_price_band'
      doc: 'FINRA Best Bid and FINRA Best Offer are Non-Executable'

