# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Input Cta v2.9.b
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.9.b
#   Date: 01/29/2026
#   Specification: CQS_Pillar_Input_Specification.pdf
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
  id: siac_cqs_input_cta_v2_9_b
  title: Siac Cqs Input Cta v2.9.b
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Quotation System Cta v2.9.b'
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
            'message_category::quote': quote_message
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
            '"P"': partial_rejection_message
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
  partial_rejection_message:
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
      - id: odd_lot_quote_appendage_type
        type: u1
        enum: odd_lot_quote_appendage_type
        doc: 'Identifies The Type Of Odd Lot Quote Appendage On A Partial Reject Message Short Long Or Extended'
      - id: count_of_odd_lot_bid_appendages
        type: u1
        doc: 'Number Of Odd Lot Bid Appendages On A Quote Message Optional Set To Zero Bid Appendages Are Populated Before Any Offer Appendage'
      - id: count_of_odd_lot_offer_appendages
        type: u1
        doc: 'Number Of Odd Lot Offer Appendages On A Quote Message Optional Set To Zero Offer Appendages Are Populated After Any Odd Lot Bid Appendages'
      - id: partial_reject_odd_lot_bid_short_quote_appendage
        type: partial_reject_odd_lot_bid_short_quote_appendage
        repeat: expr
        repeat-expr: count_of_odd_lot_bid_appendages
        if: odd_lot_quote_appendage_type == odd_lot_quote_appendage_type::odd_lot_quote_short_appendage
        doc: 'Partial Reject Odd Lot Short Quote Appendage for the bid side, applicable when Odd Lot Quote Appendage Type = S'
      - id: partial_reject_odd_lot_offer_short_quote_appendage
        type: partial_reject_odd_lot_offer_short_quote_appendage
        repeat: expr
        repeat-expr: count_of_odd_lot_offer_appendages
        if: odd_lot_quote_appendage_type == odd_lot_quote_appendage_type::odd_lot_quote_short_appendage
        doc: 'Partial Reject Odd Lot Short Quote Appendage for the offer side, applicable when Odd Lot Quote Appendage Type = S'
      - id: partial_reject_odd_lot_bid_long_quote_appendage
        type: partial_reject_odd_lot_bid_long_quote_appendage
        repeat: expr
        repeat-expr: count_of_odd_lot_bid_appendages
        if: odd_lot_quote_appendage_type == odd_lot_quote_appendage_type::odd_lot_quote_long_appendage
        doc: 'Partial Reject Odd Lot Long Quote Appendage for the bid side, applicable when Odd Lot Quote Appendage Type = L'
      - id: partial_reject_odd_lot_offer_long_quote_appendage
        type: partial_reject_odd_lot_offer_long_quote_appendage
        repeat: expr
        repeat-expr: count_of_odd_lot_offer_appendages
        if: odd_lot_quote_appendage_type == odd_lot_quote_appendage_type::odd_lot_quote_long_appendage
        doc: 'Partial Reject Odd Lot Long Quote Appendage for the offer side, applicable when Odd Lot Quote Appendage Type = L'
      - id: partial_reject_odd_lot_bid_extended_quote_appendage
        type: partial_reject_odd_lot_bid_extended_quote_appendage
        repeat: expr
        repeat-expr: count_of_odd_lot_bid_appendages
        if: odd_lot_quote_appendage_type == odd_lot_quote_appendage_type::odd_lot_quote_extended_appendage
        doc: 'Partial Reject Odd Lot Extended Quote Appendage for the bid side, applicable when Odd Lot Quote Appendage Type = E'
      - id: partial_reject_odd_lot_offer_extended_quote_appendage
        type: partial_reject_odd_lot_offer_extended_quote_appendage
        repeat: expr
        repeat-expr: count_of_odd_lot_offer_appendages
        if: odd_lot_quote_appendage_type == odd_lot_quote_appendage_type::odd_lot_quote_extended_appendage
        doc: 'Partial Reject Odd Lot Extended Quote Appendage for the offer side, applicable when Odd Lot Quote Appendage Type = E'
  partial_reject_odd_lot_bid_short_quote_appendage:
    seq:
      - id: odd_lot_quote_price_2
        type: decimal_u2_2
        doc: 'Price Associated With An Odd Lot Bid Or Offer Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  partial_reject_odd_lot_offer_short_quote_appendage:
    seq:
      - id: odd_lot_quote_price_2
        type: decimal_u2_2
        doc: 'Price Associated With An Odd Lot Bid Or Offer Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  partial_reject_odd_lot_bid_long_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  partial_reject_odd_lot_offer_long_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  partial_reject_odd_lot_bid_extended_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
      - id: odd_lot_finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier Of The Finra Adf Market Maker Associated With The Respective Finra Odd Lot Bid Or Offer Left Justified Spacefilled'
  partial_reject_odd_lot_offer_extended_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
      - id: odd_lot_finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier Of The Finra Adf Market Maker Associated With The Respective Finra Odd Lot Bid Or Offer Left Justified Spacefilled'
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
            '"R"': odd_lot_refresh_request_message
            '"5"': test_message
  sequence_information_and_message_count_response_message:
    seq:
      - id: current_block_sequence_number
        type: u4
        doc: 'Next Expected Participant Block Sequence Number Returned By Cqs In A Sequence Information And Message Count Response'
      - id: last_participant_reference_number
        type: s8
        doc: 'Last Participant Reference Number Received By Cqs On The Individual Line'
      - id: message_count
        type: u8
        doc: 'Count Of Messages Received On The Individual Line Since Startup Excludes Line Integrity And Sequence Information And Message Count Inquiry Messages'
  odd_lot_refresh_request_message:
    seq:
      - id: security_symbol_begin_range
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Contains The Alphabetic Range For The First Symbol'
      - id: security_symbol_end_range
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Contains The Alphabetic Range For The Last Symbol'
      - id: reserved_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved For Future Use Tbd'
  test_message:
    seq:
      - id: data
        type: str
        size: 256
        encoding: ASCII
        pad-right: 0x20
        doc: 'All Ascii Characters Starting With Hex 0 And Ending Hex Ff In Sequential Order'
  quote_message:
    seq:
      - id: quote_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Type Of Quote Message'
      - id: quote_message_payload
        type:
          switch-on: quote_message_type
          cases:
            '"A"': auction_status_message
            '"Q"': short_quote_message
            '"L"': long_quote_message
            '"S"': special_long_quote_message
            '"P"': round_lot_short_quote_message
            '"K"': round_lot_long_quote_message
            '"U"': round_lot_finra_adf_quote_message
            '"R"': odd_lot_short_quote_message
            '"M"': odd_lot_long_quote_message
            '"T"': odd_lot_finra_adf_quote_message
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
        doc: 'Identifies The Instrument Type Relevant To The Quote'
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
  short_quote_message:
    seq:
      - id: security_symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Short Form Security Symbol Used In Short Quote Messages'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Bid Price Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Bid Size Short Form'
      - id: offer_price_short
        type: decimal_u2_2
        doc: 'Offer Price Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: offer_size_short
        type: u2
        doc: 'Offer Size Short Form'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved For Future Use Tbd'
  long_quote_message:
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
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote Used To Determine Whether A Quote Qualifies For The Best Bid And Best Offer Calculation'
      - id: security_status_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Security Status Indicator Codes In Input Quote Messages Are Not Supported By Cqs Must Be Space'
      - id: bid_price
        type: decimal_u8_6
        doc: 'Bid Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Bid Size In Shares'
      - id: offer_price
        type: decimal_u8_6
        doc: 'Offer Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: offer_size
        type: u4
        doc: 'Offer Size In Shares'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement Rpi Interest Priced Better Than The Protected Bbo'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies The Settlement Condition For A Security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies The Market Condition Of A Quote For A Security Normal Crossed Or Locked'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Or The Finra Adf Identifier Fnra Left Justified Spacefilled'
      - id: finra_bbo_indicator
        type: u1
        enum: finra_bbo_indicator
        doc: 'For Finra Adf Represents The Finra Bbo State Of The Finra Adf Quote'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
  timestamp_2:
    seq:
      - id: seconds
        type: u4
        doc: 'Number of seconds since Unix epoch 1/1/1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'Nanosecond portion of the timestamp'
  special_long_quote_message:
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
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote Used To Determine Whether A Quote Qualifies For The Best Bid And Best Offer Calculation'
      - id: security_status_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Security Status Indicator Codes In Input Quote Messages Are Not Supported By Cqs Must Be Space'
      - id: bid_price
        type: decimal_u8_6
        doc: 'Bid Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Bid Size In Shares'
      - id: offer_price
        type: decimal_u8_6
        doc: 'Offer Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: offer_size
        type: u4
        doc: 'Offer Size In Shares'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement Rpi Interest Priced Better Than The Protected Bbo'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies The Settlement Condition For A Security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies The Market Condition Of A Quote For A Security Normal Crossed Or Locked'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Or The Finra Adf Identifier Fnra Left Justified Spacefilled'
      - id: finra_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Finra Adf Provided Quote Condition Associated With The Finra Best Bid Price Spacefilled When Not Applicable'
      - id: finra_best_bid_price
        type: decimal_u8_6
        doc: 'Finra Adf Provided Best Bid Price That Is The Finra Best Bid Fbbo Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: finra_best_bid_size
        type: u4
        doc: 'Finra Adf Provided Best Bid Size In Shares Optional Set To Zero'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Adf Provided Market Maker Id That Had The Finra Best Bid Fbbo Left Justified Spacefilled'
      - id: finra_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Finra Adf Provided Quote Condition Associated With The Finra Best Offer Price Spacefilled When Not Applicable'
      - id: finra_best_offer_price
        type: decimal_u8_6
        doc: 'Finra Adf Provided Best Offer Price That Is The Finra Best Offer Fbbo Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: finra_best_offer_size
        type: u4
        doc: 'Finra Adf Provided Best Offer Size In Shares Optional Set To Zero'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Adf Provided Market Maker Id That Had The Finra Best Offer Fbbo Left Justified Spacefilled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
  round_lot_short_quote_message:
    seq:
      - id: security_symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Short Form Security Symbol Used In Short Quote Messages'
      - id: round_lot_bid_price_short
        type: decimal_u2_2
        doc: 'Round Lot Bid Price Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: round_lot_bid_size_short
        type: u2
        doc: 'Round Lot Bid Size Short Form'
      - id: round_lot_offer_price_short
        type: decimal_u2_2
        doc: 'Round Lot Offer Price Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: round_lot_offer_size_short
        type: u2
        doc: 'Round Lot Offer Size Short Form'
      - id: clear_prior_odd_lot_quotes
        type: u1
        enum: clear_prior_odd_lot_quotes
        doc: 'Identifies Whether To Clear All Previously Reported Odd Lot Bids Andor Offers For The Participant'
      - id: num_odd_lot_bid_short_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Bid Appendages On A Quote Message Optional Set To Zero Bid Appendages Are Populated Before Any Offer Appendage'
      - id: num_odd_lot_offer_short_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Offer Appendages On A Quote Message Optional Set To Zero Offer Appendages Are Populated After Any Odd Lot Bid Appendages'
      - id: odd_lot_bid_short_quote_appendage
        type: odd_lot_bid_short_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_bid_short_quote_appendage
        doc: 'Repeating Odd Lot Short Quote Appendage for the bid side'
      - id: odd_lot_offer_short_quote_appendage
        type: odd_lot_offer_short_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_offer_short_quote_appendage
        doc: 'Repeating Odd Lot Short Quote Appendage for the offer side'
  odd_lot_bid_short_quote_appendage:
    seq:
      - id: odd_lot_quote_price_2
        type: decimal_u2_2
        doc: 'Price Associated With An Odd Lot Bid Or Offer Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  odd_lot_offer_short_quote_appendage:
    seq:
      - id: odd_lot_quote_price_2
        type: decimal_u2_2
        doc: 'Price Associated With An Odd Lot Bid Or Offer Short Form Implied 2 Decimal Places. Implied decimal with scale 1e-2'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  round_lot_long_quote_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote Used To Determine Whether A Quote Qualifies For The Best Bid And Best Offer Calculation'
      - id: round_lot_bid_price
        type: decimal_u8_6
        doc: 'Round Lot Bid Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: round_lot_bid_size
        type: u4
        doc: 'Round Lot Bid Size In Shares'
      - id: round_lot_offer_price
        type: decimal_u8_6
        doc: 'Round Lot Offer Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: round_lot_offer_size
        type: u4
        doc: 'Round Lot Offer Size In Shares'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement Rpi Interest Priced Better Than The Protected Bbo'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies The Settlement Condition For A Security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies The Market Condition Of A Quote For A Security Normal Crossed Or Locked'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Or The Finra Adf Identifier Fnra Left Justified Spacefilled'
      - id: finra_bbo_indicator
        type: u1
        enum: finra_bbo_indicator
        doc: 'For Finra Adf Represents The Finra Bbo State Of The Finra Adf Quote'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
      - id: clear_prior_odd_lot_quotes
        type: u1
        enum: clear_prior_odd_lot_quotes
        doc: 'Identifies Whether To Clear All Previously Reported Odd Lot Bids Andor Offers For The Participant'
      - id: num_odd_lot_bid_long_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Bid Appendages On A Quote Message Optional Set To Zero Bid Appendages Are Populated Before Any Offer Appendage'
      - id: num_odd_lot_offer_long_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Offer Appendages On A Quote Message Optional Set To Zero Offer Appendages Are Populated After Any Odd Lot Bid Appendages'
      - id: odd_lot_bid_long_quote_appendage
        type: odd_lot_bid_long_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_bid_long_quote_appendage
        doc: 'Repeating Odd Lot Long Quote Appendage for the bid side'
      - id: odd_lot_offer_long_quote_appendage
        type: odd_lot_offer_long_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_offer_long_quote_appendage
        doc: 'Repeating Odd Lot Long Quote Appendage for the offer side'
  odd_lot_bid_long_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  odd_lot_offer_long_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
  round_lot_finra_adf_quote_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote Used To Determine Whether A Quote Qualifies For The Best Bid And Best Offer Calculation'
      - id: round_lot_bid_price
        type: decimal_u8_6
        doc: 'Round Lot Bid Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: round_lot_bid_size
        type: u4
        doc: 'Round Lot Bid Size In Shares'
      - id: round_lot_offer_price
        type: decimal_u8_6
        doc: 'Round Lot Offer Price Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: round_lot_offer_size
        type: u4
        doc: 'Round Lot Offer Size In Shares'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Identifies Retail Price Improvement Rpi Interest Priced Better Than The Protected Bbo'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies The Settlement Condition For A Security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies The Market Condition Of A Quote For A Security Normal Crossed Or Locked'
      - id: finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Market Maker Id Of The Quoting Participant On Finr As Alternative Display Facility Or The Finra Adf Identifier Fnra Left Justified Spacefilled'
      - id: finra_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Finra Adf Provided Quote Condition Associated With The Finra Best Bid Price Spacefilled When Not Applicable'
      - id: finra_best_bid_price
        type: decimal_u8_6
        doc: 'Finra Adf Provided Best Bid Price That Is The Finra Best Bid Fbbo Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: finra_best_bid_size
        type: u4
        doc: 'Finra Adf Provided Best Bid Size In Shares Optional Set To Zero'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Adf Provided Market Maker Id That Had The Finra Best Bid Fbbo Left Justified Spacefilled'
      - id: finra_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Finra Adf Provided Quote Condition Associated With The Finra Best Offer Price Spacefilled When Not Applicable'
      - id: finra_best_offer_price
        type: decimal_u8_6
        doc: 'Finra Adf Provided Best Offer Price That Is The Finra Best Offer Fbbo Implied 6 Decimal Places Optional Set To Zero. Implied decimal with scale 1e-6'
      - id: finra_best_offer_size
        type: u4
        doc: 'Finra Adf Provided Best Offer Size In Shares Optional Set To Zero'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Finra Adf Provided Market Maker Id That Had The Finra Best Offer Fbbo Left Justified Spacefilled'
      - id: timestamp_2
        type: timestamp_2
        doc: 'Timestamp 2'
      - id: clear_prior_odd_lot_quotes
        type: u1
        enum: clear_prior_odd_lot_quotes
        doc: 'Identifies Whether To Clear All Previously Reported Odd Lot Bids Andor Offers For The Participant'
      - id: num_odd_lot_bid_extended_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Bid Appendages On A Quote Message Optional Set To Zero Bid Appendages Are Populated Before Any Offer Appendage'
      - id: num_odd_lot_offer_extended_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Offer Appendages On A Quote Message Optional Set To Zero Offer Appendages Are Populated After Any Odd Lot Bid Appendages'
      - id: odd_lot_bid_extended_quote_appendage
        type: odd_lot_bid_extended_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_bid_extended_quote_appendage
        doc: 'Repeating Odd Lot Extended Quote Appendage for the bid side, including FINRA Market Maker ID'
      - id: odd_lot_offer_extended_quote_appendage
        type: odd_lot_offer_extended_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_offer_extended_quote_appendage
        doc: 'Repeating Odd Lot Extended Quote Appendage for the offer side, including FINRA Market Maker ID'
  odd_lot_bid_extended_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
      - id: odd_lot_finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier Of The Finra Adf Market Maker Associated With The Respective Finra Odd Lot Bid Or Offer Left Justified Spacefilled'
  odd_lot_offer_extended_quote_appendage:
    seq:
      - id: odd_lot_quote_price
        type: decimal_u8_6
        doc: 'Price Associated With An Odd Lot Bid Or Offer Implied 6 Decimal Places. Implied decimal with scale 1e-6'
      - id: odd_lot_quote_size
        type: u1
        doc: 'Size Associated With An Odd Lot Bid Or Offer In Shares Set To Zero Indicates Removal Of A Previously Reported Odd Lot At This Price'
      - id: odd_lot_finra_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier Of The Finra Adf Market Maker Associated With The Respective Finra Odd Lot Bid Or Offer Left Justified Spacefilled'
  odd_lot_short_quote_message:
    seq:
      - id: security_symbol_short
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Short Form Security Symbol Used In Short Quote Messages'
      - id: clear_prior_odd_lot_quotes
        type: u1
        enum: clear_prior_odd_lot_quotes
        doc: 'Identifies Whether To Clear All Previously Reported Odd Lot Bids Andor Offers For The Participant'
      - id: num_odd_lot_bid_short_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Bid Appendages On A Quote Message Optional Set To Zero Bid Appendages Are Populated Before Any Offer Appendage'
      - id: num_odd_lot_offer_short_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Offer Appendages On A Quote Message Optional Set To Zero Offer Appendages Are Populated After Any Odd Lot Bid Appendages'
      - id: odd_lot_bid_short_quote_appendage
        type: odd_lot_bid_short_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_bid_short_quote_appendage
        doc: 'Repeating Odd Lot Short Quote Appendage for the bid side'
      - id: odd_lot_offer_short_quote_appendage
        type: odd_lot_offer_short_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_offer_short_quote_appendage
        doc: 'Repeating Odd Lot Short Quote Appendage for the offer side'
  odd_lot_long_quote_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: clear_prior_odd_lot_quotes
        type: u1
        enum: clear_prior_odd_lot_quotes
        doc: 'Identifies Whether To Clear All Previously Reported Odd Lot Bids Andor Offers For The Participant'
      - id: num_odd_lot_bid_long_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Bid Appendages On A Quote Message Optional Set To Zero Bid Appendages Are Populated Before Any Offer Appendage'
      - id: num_odd_lot_offer_long_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Offer Appendages On A Quote Message Optional Set To Zero Offer Appendages Are Populated After Any Odd Lot Bid Appendages'
      - id: odd_lot_bid_long_quote_appendage
        type: odd_lot_bid_long_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_bid_long_quote_appendage
        doc: 'Repeating Odd Lot Long Quote Appendage for the bid side'
      - id: odd_lot_offer_long_quote_appendage
        type: odd_lot_offer_long_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_offer_long_quote_appendage
        doc: 'Repeating Odd Lot Long Quote Appendage for the offer side'
  odd_lot_finra_adf_quote_message:
    seq:
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Left Justified Spacefilled Root Symbol May Be 1 To 6 Characters With Remaining Characters Available For Possible Suffixes'
      - id: clear_prior_odd_lot_quotes
        type: u1
        enum: clear_prior_odd_lot_quotes
        doc: 'Identifies Whether To Clear All Previously Reported Odd Lot Bids Andor Offers For The Participant'
      - id: num_odd_lot_bid_extended_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Bid Appendages On A Quote Message Optional Set To Zero Bid Appendages Are Populated Before Any Offer Appendage'
      - id: num_odd_lot_offer_extended_quote_appendage
        type: u1
        doc: 'Number Of Odd Lot Offer Appendages On A Quote Message Optional Set To Zero Offer Appendages Are Populated After Any Odd Lot Bid Appendages'
      - id: odd_lot_bid_extended_quote_appendage
        type: odd_lot_bid_extended_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_bid_extended_quote_appendage
        doc: 'Repeating Odd Lot Extended Quote Appendage for the bid side, including FINRA Market Maker ID'
      - id: odd_lot_offer_extended_quote_appendage
        type: odd_lot_offer_extended_quote_appendage
        repeat: expr
        repeat-expr: num_odd_lot_offer_extended_quote_appendage
        doc: 'Repeating Odd Lot Extended Quote Appendage for the offer side, including FINRA Market Maker ID'
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
            '"S"': trading_status_message
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
        doc: 'Identifies The Instrument Type Relevant To The Quote'
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
        doc: 'Trading Action On The Trading Status Category T Type S Message'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Reason For A Trading Halt'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
      - id: trading_status_id
        type: u4
        doc: 'Unique Identifier For Each Trading Status Message Used To Eliminate Duplicate Trading Status Messages Received Over Cqs And Cts Input Lines'
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
  message_category:
    0x41:
      id: 'administrative'
      doc: 'Administrative Category Sent From Cqs To Participant'
    0x43:
      id: 'control'
      doc: 'Control Category Source May Be Either Participant Or Cqs Processor'
    0x51:
      id: 'quote'
      doc: 'Quote Category Reports Cta Eligible Equity Local Issue Or Bond Quote Information Including Round Lot And Odd Lot Bids And Offers'
    0x54:
      id: 'trade'
      doc: 'Trade Category Reports Trading Status Events For Cta Eligible Equity Local Issue Or Bond Information'
  odd_lot_quote_appendage_type:
    0x53:
      id: 'odd_lot_quote_short_appendage'
      doc: 'Odd Lot Quote Short Appendage'
    0x4c:
      id: 'odd_lot_quote_long_appendage'
      doc: 'Odd Lot Quote Long Appendage'
    0x45:
      id: 'odd_lot_quote_extended_appendage'
      doc: 'Odd Lot Quote Extended Appendage'
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
  quote_condition:
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
      id: 'closed_market_maker_finra'
      doc: 'Closed Market Maker Finra'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Non Firm Quote'
    0x4f:
      id: 'opening_quote'
      doc: 'Opening Quote'
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x55:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_both_sides'
      doc: 'Slow Quote Due To Lrp Or Gap Quote On Both Sides'
    0x57:
      id: 'slow_quote_due_to_set_slow_list_on_both_sides'
      doc: 'Slow Quote Due To Set Slow List On Both Sides'
    0x34:
      id: 'on_demand_intra_day_auction'
      doc: 'On Demand Intra Day Auction'
  retail_interest_indicator:
    0x20:
      id: 'retail_interest_not_applicable'
      doc: 'Retail Interest Not Applicable'
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
      id: 'finra_bbo_indicator_not_applicable'
      doc: 'Finra Bbo Indicator Not Applicable'
    0x41:
      id: 'no_finra_bbo_change'
      doc: 'No Finra Bbo Change'
    0x42:
      id: 'no_finra_bbo_exists'
      doc: 'No Finra Bbo Exists'
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
  clear_prior_odd_lot_quotes:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x42:
      id: 'clear_all_previous_odd_lot_bids'
      doc: 'Clear All Previous Odd Lot Bids'
    0x53:
      id: 'clear_all_previous_odd_lot_offers'
      doc: 'Clear All Previous Odd Lot Offers'
    0x58:
      id: 'clear_all_previous_odd_lot_bids_and_offers'
      doc: 'Clear All Previous Odd Lot Bids And Offers'
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

