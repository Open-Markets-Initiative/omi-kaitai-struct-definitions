# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Snapshot Cta v1.0
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: Snapshot
#   Encoding: Consolidated Tape Association
#   Version: 1.0
#   Date: 1/24/2022
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
  id: siac_cqs_snapshot_cta_v1_0
  title: Siac Cqs Snapshot Cta v1.0
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Quotation System Snapshot Cta v1.0'
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
      - id: block_sequence_number
        type: u4
        doc: 'All Transmission Blocks Are Assigned A Sequential Block Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Transmission Block'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'Delivery Flag Field In The Block Header Is Used To Identify All Messages Associated With A Specific Snapshot Request'
      - id: last_seq_num
        type: str
        size: 1
        encoding: ASCII
        doc: 'It Indicates The Asof Message Sequence Number For The Symbol Published On The Production Output Line'
      - id: tot_pub_seq_rollover
        type: u1
        doc: 'Indicates The Number Of Times The Sequence Number Has Previously Rolled Over For The Real Time Output Line On Which The Symbol Resides'
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
            'message_category::snapshot': snapshot_message
  snapshot_message:
    seq:
      - id: snapshot_message_type
        type: u1
        enum: snapshot_message_type
        doc: 'Snapshot message type'
      - id: snapshot_message_payload
        type:
          switch-on: snapshot_message_type
          cases:
            'snapshot_message_type::line_integrity_message': line_integrity_message
            'snapshot_message_type::market_wide_circuit_breaker_decline_level_status_snapshot_message': market_wide_circuit_breaker_decline_level_status_snapshot_message
            'snapshot_message_type::consolidated_snapshot_message': consolidated_snapshot_message
            'snapshot_message_type::participant_snapshot_message': participant_snapshot_message
            'snapshot_message_type::finra_snapshot_message': finra_snapshot_message
  line_integrity_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
  market_wide_circuit_breaker_decline_level_status_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: mwcb_level_1
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Trigger Value Associated With Each Decline Level 7'
      - id: mwcb_level_2
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Trigger Value Associated With Each Decline Level 13'
      - id: mwcb_level_3
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Trigger Value Associated With Each Decline Level 20'
      - id: reserved
        type: u1
        doc: 'Field Is Reserved For Future Use'
  consolidated_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: lower_limit_price_band
        type: decimal_u8_6
        doc: 'It Represents The Lower Price Band Value For A Security. Implied decimal with scale 1e-6'
      - id: upper_limit_price_band
        type: decimal_u8_6
        doc: 'It Represents The Upper Price Band Value For A Security. Implied decimal with scale 1e-6'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'The Auction Collar Reference Price Represents The Price Used By The Exchange To Establish The Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Represents The Latest Upper Threshold Price Of The Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Represents The Latest Lower Threshold Price Of The Auction Collar. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Identifies The Number Of Manual Or Automatic Extensions The Applicable Auction Has Received'
      - id: national_best_bid_participant_id
        type: u1
        enum: national_best_bid_participant_id
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: national_best_bid_quote_condition
        type: u1
        enum: national_best_bid_quote_condition
        doc: 'Identifies The Quote Condition Associated With The Best Bid Price On A Consolidated Basis'
      - id: national_best_bid_price
        type: decimal_u8_6
        doc: 'Represents The Best Bid Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: national_best_bid_size
        type: u4
        doc: 'Represents The Best Bid Size Associated With The Best Bid Price On A Consolidated Basis'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Bid Market Maker Identifier Of The Market Maker That Had The Finra Best Bid Fbbo'
      - id: national_best_offer_participant_id
        type: u1
        enum: national_best_offer_participant_id
        doc: 'Identifies The Participant That Submitted The Best Offer On A Consolidated Basis'
      - id: national_best_offer_quote_condition
        type: u1
        enum: national_best_offer_quote_condition
        doc: 'Identifies The Quote Condition Associated With The Best Offer Price On A Consolidated Basis'
      - id: national_best_offer_price
        type: decimal_u8_6
        doc: 'Represents The Best Bid Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: national_best_offer_size
        type: u4
        doc: 'Represents The Best Offer Size Associated With The Best Bid Price On A Consolidated Basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates The Affect That The Limit Up Limit Down Price Band Changes Have On The National Best Bid And National Best Offer'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies The Primary Listing Market For A Security'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies The Financial Status Of The Security'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies Whether Or Not A Short Sale Restriction Is In Effect'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
      - id: future
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Field Is Reserved For Future Use'
  participant_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote'
      - id: bid_price
        type: decimal_u8_6
        doc: 'Represents The Highest Price A Prospective Buyer Is Prepared To Pay At A Particular Time For A Security. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'The Bid Size Identifies The Number Of Roundlots For A Security'
      - id: offer_price
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Acceptable To A Prospective Seller At A Particular Time For A Security. Implied decimal with scale 1e-6'
      - id: offer_size
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
      - id: luld_indicator
        type: u1
        enum: luld_indicator
        doc: 'Indicates The Affect The Quote Has On The Limit Up Limit Down Price Band Range'
      - id: high_indication_price
        type: decimal_u8_6
        doc: 'The High Indication Price Represents An Approximation Of What The High End Offer Price Of A Securitys Trading Range May Be. Implied decimal with scale 1e-6'
      - id: low_indication_price
        type: decimal_u8_6
        doc: 'The Low Indication Price Represents An Approximation Of What The Low End Bid Price Of A Securitys Trading Range May Be. Implied decimal with scale 1e-6'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
  finra_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Participant Or Processor That Generated The Message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol'
      - id: finra_best_bid_quote_condition
        type: u1
        enum: finra_best_bid_quote_condition
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
        type: u1
        enum: finra_best_offer_quote_condition
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
      - id: finra_bbo_luld_indicator
        type: u1
        enum: finra_bbo_luld_indicator
        doc: 'Indicates The Affect That The Limit Up Limit Down Price Bands Have On The Finra Best Bid And Finra Best Offer'
      - id: high_indication_price
        type: decimal_u8_6
        doc: 'The High Indication Price Represents An Approximation Of What The High End Offer Price Of A Securitys Trading Range May Be. Implied decimal with scale 1e-6'
      - id: low_indication_price
        type: decimal_u8_6
        doc: 'The Low Indication Price Represents An Approximation Of What The Low End Bid Price Of A Securitys Trading Range May Be. Implied decimal with scale 1e-6'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  delivery_flag:
    1:
      id: 'first_block'
      doc: 'First Block of Snapshot sequence'
    2:
      id: 'intermediate_block'
      doc: 'Intermediate Block of Snapshot sequence'
    3:
      id: 'last_block'
      doc: 'Last Block of Snapshot sequence'
    4:
      id: 'only_one_block'
      doc: 'Only one Block in Snapshot sequence'
  message_category:
    0x4b:
      id: 'snapshot'
      doc: 'Snapshot Message Header'
  snapshot_message_type:
    0x54:
      id: 'line_integrity_message'
      doc: 'Line Integrity Message'
    0x4b:
      id: 'market_wide_circuit_breaker_decline_level_status_snapshot_message'
      doc: 'Market Wide Circuit Breaker Decline Level Status Snapshot Message'
    0x43:
      id: 'consolidated_snapshot_message'
      doc: 'Consolidated Snapshot Message'
    0x50:
      id: 'participant_snapshot_message'
      doc: 'Participant Snapshot Message'
    0x46:
      id: 'finra_snapshot_message'
      doc: 'Finra Snapshot Message'
  participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'adf'
      doc: 'Finra Alternative Display Facility'
    0x48:
      id: 'miax'
      doc: 'Miax Pearl Exchange'
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
    0x55:
      id: 'memx'
      doc: 'Members Exchange'
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
  national_best_bid_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'adf'
      doc: 'Finra Alternative Display Facility'
    0x48:
      id: 'miax'
      doc: 'Miax Pearl Exchange'
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
    0x55:
      id: 'memx'
      doc: 'Members Exchange'
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
  national_best_bid_quote_condition:
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
  national_best_offer_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'adf'
      doc: 'Finra Alternative Display Facility'
    0x48:
      id: 'miax'
      doc: 'Miax Pearl Exchange'
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
    0x55:
      id: 'memx'
      doc: 'Members Exchange'
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
  national_best_offer_quote_condition:
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
  primary_listing_market_participant_id:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'adf'
      doc: 'Finra Alternative Display Facility'
    0x48:
      id: 'miax'
      doc: 'Miax Pearl Exchange'
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
    0x54:
      id: 'nasdaq'
      doc: 'Nasdaq Stock Market'
    0x55:
      id: 'memx'
      doc: 'Members Exchange'
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
  halt_reason:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
      id: 'limit_up_limit_down_trading_pause'
      doc: 'Limit Up Limit Down Trading Pause'
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
  quote_condition:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
  luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'bid_is_non_executable'
      doc: 'Bid Price Above Upper Limit Price Band Bid Is Non Executable'
    0x42:
      id: 'offer_is_non_executable'
      doc: 'Offer Price Below Lower Limit Price Band Offer Is Non Executable'
  finra_best_bid_quote_condition:
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
  finra_best_offer_quote_condition:
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

