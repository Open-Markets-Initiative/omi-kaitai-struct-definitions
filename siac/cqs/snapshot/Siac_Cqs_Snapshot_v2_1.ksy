# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Snapshot Cta v2.1
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.1
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
  id: siac_cqs_snapshot_cta_v2_1
  title: Siac Cqs Snapshot Cta v2.1
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Quotation System Cta v2.1'
doc-ref: https://www.ctaplan.com/tech-specs

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Cqs Snapshot packet header'
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
        doc: 'Designates The Cqs Binary Version'
      - id: block_size
        type: u2
        doc: 'Size In Bytes Of Entire Transmission Block'
      - id: block_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Block Data Of The Transmission Block'
      - id: deliveryflag
        type: u1
        enum: deliveryflag
        doc: 'Used to identify all messages associated with a specific Snapshot request'
      - id: lastseqnum
        type: u4
        doc: 'It indicates the as-of Message Sequence Number for the Symbol published on the Production Output line'
      - id: totpubseqrollover
        type: u1
        doc: 'Indicates the number of times the sequence number has previously rolled over for the Real-Time Output line on which the symbol resides'
      - id: sip_block_timestamp
        type: sip_block_timestamp
        doc: 'Cqs packet timestamp. Nanoseconds since Unix epoch'
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
        doc: 'Identifies the type of category and message'
      - id: category_payload
        type:
          switch-on: message_category
          cases:
            'message_category::snapshot': snapshot_message
  snapshot_message:
    seq:
      - id: snapshot_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Snapshot message type'
      - id: snapshot_message_payload
        type:
          switch-on: snapshot_message_type
          cases:
            '"T"': line_integrity_message
            '"S"': symbol_reference_data_message
            '"K"': market_wide_circuit_breaker_decline_level_status_snapshot_message
            '"C"': consolidated_snapshot_message
            '"P"': participant_snapshot_message
            '"F"': finra_snapshot_message
  line_integrity_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
  symbol_reference_data_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Space Filled'
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
        doc: 'Primary Listing Market Previous Closing Price. Implied decimal with scale 1e-6'
      - id: consolidated_closing_price
        type: decimal_u8_6
        doc: 'Consolidated Closing Price. Implied decimal with scale 1e-6'
      - id: round_lot_size
        type: u2
        doc: 'Roundlot Size For A Symbol Can Consist Of 11040 Or 100 Shares'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Reserved For Future Use'
      - id: luld_tier
        type: u1
        enum: luld_tier
        doc: 'Identifies The Limit Up Limit Down Tier Of The Security Symbol'
      - id: luld_leverage_ratio
        type: u4
        doc: 'Represents The Leverage Ratio Associated With The Luld Tier Of The Security Symbol'
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
        doc: 'Identifies Whether A Short Sale Restriction Is In Effect'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: second_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Reserved For Future Use'
      - id: third_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Reserved For Future Use'
      - id: fourth_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Reserved For Future Use'
  market_wide_circuit_breaker_decline_level_status_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: mwcb_level_1
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Level 17 Of Previous Close Sp 500 Value'
      - id: mwcb_level_2
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Level 213 Of Previous Close Sp 500 Value'
      - id: mwcb_level_3
        type: s8
        doc: 'Identifies The Daily Established Drop Level Value Level 320 Of Previous Close Sp 500 Value'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Reserved For Future Use'
  consolidated_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Space Filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies The Instrument Type Relevant To The Quote'
      - id: lower_limit_price_band
        type: decimal_u8_6
        doc: 'Represents The Lower Price Band Value For A Security Set To Zero When Price Bands Are Not In Effect. Implied decimal with scale 1e-6'
      - id: upper_limit_price_band
        type: decimal_u8_6
        doc: 'Represents The Upper Price Band Value For A Security Set To Zero When Price Bands Are Not In Effect. Implied decimal with scale 1e-6'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Bid On A Consolidated Basis'
      - id: national_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Participant That Submitted The Best Offer On A Consolidated Basis'
      - id: national_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies The Quote Condition Associated With The Best Offer Price On A Consolidated Basis'
      - id: national_best_offer_price
        type: decimal_u8_6
        doc: 'Represents The Best Offer Price On A Consolidated Basis. Implied decimal with scale 1e-6'
      - id: national_best_offer_size
        type: u4
        doc: 'Represents The Best Offer Size Associated With The Best Offer Price On A Consolidated Basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer Fbbo'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates The Effect That The Limit Up Limit Down Price Band Changes Have On The National Best Bid And National Best Offer'
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
        doc: 'Identifies Whether A Short Sale Restriction Is In Effect'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Spacefilled Reserved For Future Use'
  participant_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Space Filled'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes A Particular Condition Applicable To The Quote Used To Determine Whether A Quote Qualifies For The Best Bid And Best Offer Calculation'
      - id: bid_price
        type: decimal_u8_6
        doc: 'Represents The Highest Price A Prospective Buyer Is Prepared To Pay At A Particular Time For A Security. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Integer Has A Maximum Size Of 4294967295'
      - id: offer_price
        type: decimal_u8_6
        doc: 'Represents The Lowest Price Acceptable To A Prospective Seller At A Particular Time For A Security. Implied decimal with scale 1e-6'
      - id: offer_size
        type: u4
        doc: 'Identifies The Number Of Shares For A Symbol Rounded Down To The Nearest Multiple Of Its Round Lot Size'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Indicates Retail Price Improvement Rpi Interest Priced Better Than The Protected Best Bid Or Offer Pbbo By A Minimum Of 0001'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies The Settlement Condition For A Security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies The Market Condition Of A Quote For A Security'
      - id: limit_up_limit_down_luld_indicator
        type: u1
        enum: limit_up_limit_down_luld_indicator
        doc: 'Indicates The Effect The Quote Has On The Limit Up Limit Down Price Band Range'
      - id: high_indication_price
        type: decimal_u8_6
        doc: 'Represents An Approximation Of What The High End Offer Price Of A Securitys Trading Range May Be Used For Trading Range Indication Or Price Indication Following A Trading Halt. Implied decimal with scale 1e-6'
      - id: low_indication_price
        type: decimal_u8_6
        doc: 'Represents An Approximation Of What The Low End Bid Price Of A Securitys Trading Range May Be Used For Trading Range Indication Or Price Indication Following A Trading Halt. Implied decimal with scale 1e-6'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
  finra_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies The Participant Or Processor That Generated The Message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Security Symbol Left Justified Space Filled'
      - id: finra_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains The Finra Adf Provided Finra Best Bid Quote Condition Associated With The Finra Best Bid Price That Had The Finra Best Bid Fbbo'
      - id: finra_best_bid_price
        type: decimal_u8_6
        doc: 'Contains The Finra Adf Provided Finra Best Bid Price That Is The Finra Best Bid Fbbo. Implied decimal with scale 1e-6'
      - id: finra_best_bid_size
        type: u4
        doc: 'Contains The Finra Adf Provided Finra Best Bid Size Associated With The Finra Best Bid Price That Had The Finra Best Bid Fbbo'
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
        doc: 'Contains The Finra Adf Provided Finra Best Offer Quote Condition Associated With The Best Finra Offer Price That Had The Finra Best Offer Fbbo'
      - id: finra_best_offer_price
        type: decimal_u8_6
        doc: 'Contains The Finra Adf Provided Best Finra Offer Price That Is The Finra Best Offer Fbbo. Implied decimal with scale 1e-6'
      - id: finra_best_offer_size
        type: u4
        doc: 'Contains The Finra Adf Provided Finra Best Offer Size Associated With The Finra Best Offer Price That Had The Finra Best Offer Fbbo'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains The Finra Adf Provided Finra Best Offer Market Maker Identifier Of The Market Maker That Had The Finra Best Offer Fbbo'
      - id: finra_bbo_luld_indicator
        type: u1
        enum: finra_bbo_luld_indicator
        doc: 'Indicates The Effect That The Limit Up Limit Down Price Bands Have On The Finra Best Bid And Finra Best Offer Fbbo'
      - id: high_indication_price
        type: decimal_u8_6
        doc: 'Represents An Approximation Of What The High End Offer Price Of A Securitys Trading Range May Be Used For Trading Range Indication Or Price Indication Following A Trading Halt. Implied decimal with scale 1e-6'
      - id: low_indication_price
        type: decimal_u8_6
        doc: 'Represents An Approximation Of What The Low End Bid Price Of A Securitys Trading Range May Be Used For Trading Range Indication Or Price Indication Following A Trading Halt. Implied decimal with scale 1e-6'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes The Reason For The Trading Halt'
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

enums:
  deliveryflag:
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
    0x52:
      id: 'snapshot'
      doc: 'Snapshot Messages'
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
    0x45:
      id: 'short_sale_restriction_in_effect'
      doc: 'Short Sale Restriction In Effect'
  halt_reason:
    0x20:
      id: 'halt_reason_not_applicable'
      doc: 'Halt Reason Not Applicable'
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
    0x49:
      id: 'order_imbalance'
      doc: 'Non Regulatory'
    0x4d:
      id: 'limit_up_limit_down_luld_trading_pause'
      doc: 'Regulatory'
    0x4e:
      id: 'corporate_action'
      doc: 'Non Regulatory'
    0x4f:
      id: 'new_security_offering'
      doc: 'Non Regulatory'
    0x50:
      id: 'news_pending'
      doc: 'Regulatory'
    0x56:
      id: 'intraday_indicative_value_not_available'
      doc: 'Regulatory'
    0x58:
      id: 'operational'
      doc: 'Non Regulatory'
    0x59:
      id: 'sub_penny_trading'
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
      id: 'national_best_bid_below_lower_limit_price_band_and_national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Bid And National Best Offer Are Non Executable'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band'
      doc: 'National Best Bid Is In Limit State'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Offer Is In Limit State'
    0x47:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Bid Is In Limit State And National Best Offer Is Non Executable'
    0x48:
      id: 'national_best_bid_below_lower_limit_price_band_and_national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Bid Is Non Executable And National Best Offer Is In Limit State'
    0x49:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_offer_equals_lower_limit_price_band'
      doc: 'Crossed Not In Limit State'
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
      id: 'closed_market_maker_finra'
      doc: 'Not Eligible For Bbo'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Not Eligible For Bbo'
    0x4f:
      id: 'opening_quote'
      doc: 'Eligible For Bbo'
    0x52:
      id: 'regular_finra_open'
      doc: 'Eligible For Bbo'
    0x55:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_both_the_bid_and_offer_sides'
      doc: 'Not Eligible For Bbo'
    0x57:
      id: 'slow_quote_due_to_set_slow_list_on_both_the_bid_and_offer_sides'
      doc: 'Eligible For Bbo'
    0x34:
      id: 'on_demand_intra_day_auction'
      doc: 'Not Eligible For Bbo'
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
  finra_bbo_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'finra_best_bid_andor_finra_best_offer_are_executable'
      doc: 'Finra Best Bid Andor Finra Best Offer Are Executable'
    0x42:
      id: 'finra_best_bid_outside_price_band'
      doc: 'Finra Best Bid Is Non Executable'
    0x43:
      id: 'finra_best_offer_outside_price_band'
      doc: 'Finra Best Offer Is Non Executable'
    0x44:
      id: 'finra_best_bid_and_finra_best_offer_outside_price_band'
      doc: 'Finra Best Bid And Finra Best Offer Are Non Executable'

