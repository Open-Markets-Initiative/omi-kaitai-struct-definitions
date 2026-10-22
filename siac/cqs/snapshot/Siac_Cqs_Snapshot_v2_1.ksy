# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Snapshot Cta v2.1
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.1
#   Date: 06/06/2025
#   Specification: Siac.Cqs.Output.Cta.v2.10.a.pdf
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
        doc: 'Identifies the type of category and message'
      - id: category_payload
        size: message_length - 3
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
        doc: 'Identifies the Participant or Processor that generated the message'
  symbol_reference_data_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol, left justified, space filled'
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
        doc: 'Primary Listing Market Previous Closing Price. Implied decimal with scale 1e-6'
      - id: consolidated_closing_price
        type: decimal_u8_6
        doc: 'Consolidated Closing Price. Implied decimal with scale 1e-6'
      - id: round_lot_size
        type: u2
        doc: 'Round-lot size for a symbol can consist of 1, 10, 40 or 100 shares'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled, reserved for future use'
      - id: luld_tier
        type: u1
        enum: luld_tier
        doc: 'Identifies the Limit Up Limit Down tier of the security symbol'
      - id: luld_leverage_ratio
        type: u4
        doc: 'Represents the Leverage ratio associated with the LULD Tier of the security symbol'
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
        doc: 'Identifies whether a Short Sale Restriction is in effect'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes the reason for the Trading Halt'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the quote'
      - id: second_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled, reserved for future use'
      - id: third_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled, reserved for future use'
      - id: fourth_reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled, reserved for future use'
  market_wide_circuit_breaker_decline_level_status_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: mwcb_level_1
        type: s8
        doc: 'Identifies the daily established drop level value, Level 1 = 7% of Previous Close S&P 500 Value'
      - id: mwcb_level_2
        type: s8
        doc: 'Identifies the daily established drop level value, Level 2 = 13% of Previous Close S&P 500 Value'
      - id: mwcb_level_3
        type: s8
        doc: 'Identifies the daily established drop level value, Level 3 = 20% of Previous Close S&P 500 Value'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled, reserved for future use'
  consolidated_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol, left justified, space filled'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Identifies the instrument type relevant to the quote'
      - id: lower_limit_price_band
        type: decimal_u8_6
        doc: 'Represents the lower price band value for a security, set to zero when Price Bands are not in effect. Implied decimal with scale 1e-6'
      - id: upper_limit_price_band
        type: decimal_u8_6
        doc: 'Represents the upper price band value for a security, set to zero when Price Bands are not in effect. Implied decimal with scale 1e-6'
      - id: auction_collar_reference_price
        type: decimal_u8_6
        doc: 'The Auction Collar Reference Price represents the price used by the exchange to establish the Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_upper_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest upper threshold price of the Auction Collar. Implied decimal with scale 1e-6'
      - id: auction_collar_lower_threshold_price
        type: decimal_u8_6
        doc: 'Represents the latest lower threshold price of the Auction Collar. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u1
        doc: 'Identifies the number of manual or automatic extensions the applicable auction has received'
      - id: national_best_bid_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Bid on a consolidated basis'
      - id: national_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Quote Condition associated with the Best Bid Price on a consolidated basis'
      - id: national_best_bid_price
        type: decimal_u8_6
        doc: 'Represents the Best Bid Price on a consolidated basis. Implied decimal with scale 1e-6'
      - id: national_best_bid_size
        type: u4
        doc: 'Represents the Best Bid Size associated with the Best Bid Price on a consolidated basis'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Market Maker identifier of the Market Maker that had the FINRA Best Bid (FBBO)'
      - id: national_best_offer_participant_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Participant that submitted the Best Offer on a consolidated basis'
      - id: national_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the Quote Condition associated with the Best Offer Price on a consolidated basis'
      - id: national_best_offer_price
        type: decimal_u8_6
        doc: 'Represents the Best Offer Price on a consolidated basis. Implied decimal with scale 1e-6'
      - id: national_best_offer_size
        type: u4
        doc: 'Represents the Best Offer Size associated with the Best Offer Price on a consolidated basis'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Market Maker identifier of the Market Maker that had the FINRA Best Offer (FBBO)'
      - id: national_bbo_luld_indicator
        type: u1
        enum: national_bbo_luld_indicator
        doc: 'Indicates the effect that the Limit Up-Limit Down Price Band changes have on the National Best Bid and National Best Offer'
      - id: primary_listing_market_participant_id
        type: u1
        enum: primary_listing_market_participant_id
        doc: 'Identifies the Primary Listing Market for a security'
      - id: financial_status_indicator
        type: u1
        enum: financial_status_indicator
        doc: 'Identifies the financial status of the security'
      - id: short_sale_restriction_indicator
        type: u1
        enum: short_sale_restriction_indicator
        doc: 'Identifies whether a Short Sale Restriction is in effect'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes the reason for the Trading Halt'
      - id: reserved
        type: str
        size: 1
        encoding: ASCII
        doc: 'Space-filled, reserved for future use'
  participant_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol, left justified, space filled'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Denotes a particular condition applicable to the quote, used to determine whether a quote qualifies for the Best Bid and Best Offer calculation'
      - id: bid_price
        type: decimal_u8_6
        doc: 'Represents the highest price a prospective buyer is prepared to pay at a particular time for a security. Implied decimal with scale 1e-6'
      - id: bid_size
        type: u4
        doc: 'Integer has a maximum size of 4,294,967,295'
      - id: offer_price
        type: decimal_u8_6
        doc: 'Represents the lowest price acceptable to a prospective seller at a particular time for a security. Implied decimal with scale 1e-6'
      - id: offer_size
        type: u4
        doc: 'Identifies the number of shares for a symbol rounded down to the nearest multiple of its Round Lot Size'
      - id: retail_interest_indicator
        type: u1
        enum: retail_interest_indicator
        doc: 'Indicates Retail Price Improvement (RPI) interest priced better than the Protected Best Bid or Offer (PBBO) by a minimum of $0.001'
      - id: settlement_condition
        type: u1
        enum: settlement_condition
        doc: 'Identifies the settlement condition for a security'
      - id: market_condition
        type: u1
        enum: market_condition
        doc: 'Identifies the market condition of a quote for a security'
      - id: limit_up_limit_down_luld_indicator
        type: u1
        enum: limit_up_limit_down_luld_indicator
        doc: 'Indicates the effect the Quote has on the Limit Up-Limit Down Price Band range'
      - id: high_indication_price
        type: decimal_u8_6
        doc: 'Represents an approximation of what the high end Offer price of a security''s trading range may be, used for Trading Range Indication or Price Indication following a Trading Halt. Implied decimal with scale 1e-6'
      - id: low_indication_price
        type: decimal_u8_6
        doc: 'Represents an approximation of what the low end Bid price of a security''s trading range may be, used for Trading Range Indication or Price Indication following a Trading Halt. Implied decimal with scale 1e-6'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes the reason for the Trading Halt'
  finra_snapshot_message:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that generated the message'
      - id: security_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the security symbol, left justified, space filled'
      - id: finra_best_bid_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Quote Condition associated with the FINRA Best Bid Price that had the FINRA Best Bid (FBBO)'
      - id: finra_best_bid_price
        type: decimal_u8_6
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Price that is the FINRA Best Bid (FBBO). Implied decimal with scale 1e-6'
      - id: finra_best_bid_size
        type: u4
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Size associated with the FINRA Best Bid Price that had the FINRA Best Bid (FBBO)'
      - id: finra_best_bid_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Bid Market Maker identifier of the Market Maker that had the FINRA Best Bid (FBBO)'
      - id: finra_best_offer_quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Quote Condition associated with the Best FINRA Offer Price that had the FINRA Best Offer (FBBO)'
      - id: finra_best_offer_price
        type: decimal_u8_6
        doc: 'Contains the FINRA ADF provided Best FINRA Offer Price that is the FINRA Best Offer (FBBO). Implied decimal with scale 1e-6'
      - id: finra_best_offer_size
        type: u4
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Size associated with the FINRA Best Offer Price that had the FINRA Best Offer (FBBO)'
      - id: finra_best_offer_market_maker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contains the FINRA ADF provided FINRA Best Offer Market Maker identifier of the Market Maker that had the FINRA Best Offer (FBBO)'
      - id: finra_bbo_luld_indicator
        type: u1
        enum: finra_bbo_luld_indicator
        doc: 'Indicates the effect that the Limit Up-Limit Down Price Bands have on the FINRA Best Bid and FINRA Best Offer (FBBO)'
      - id: high_indication_price
        type: decimal_u8_6
        doc: 'Represents an approximation of what the high end Offer price of a security''s trading range may be, used for Trading Range Indication or Price Indication following a Trading Halt. Implied decimal with scale 1e-6'
      - id: low_indication_price
        type: decimal_u8_6
        doc: 'Represents an approximation of what the low end Bid price of a security''s trading range may be, used for Trading Range Indication or Price Indication following a Trading Halt. Implied decimal with scale 1e-6'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Denotes the reason for the Trading Halt'
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
      doc: 'Non-Regulatory'
    0x4d:
      id: 'limit_up_limit_down_luld_trading_pause'
      doc: 'Regulatory'
    0x4e:
      id: 'corporate_action'
      doc: 'Non-Regulatory'
    0x4f:
      id: 'new_security_offering'
      doc: 'Non-Regulatory'
    0x50:
      id: 'news_pending'
      doc: 'Regulatory'
    0x56:
      id: 'intraday_indicative_value_not_available'
      doc: 'Regulatory'
    0x58:
      id: 'operational'
      doc: 'Non-Regulatory'
    0x59:
      id: 'sub_penny_trading'
      doc: 'Non-Regulatory'
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
      doc: 'National Best Bid is Non-Executable'
    0x43:
      id: 'national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Offer is Non-Executable'
    0x44:
      id: 'national_best_bid_below_lower_limit_price_band_and_national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Bid and National Best Offer are Non-Executable'
    0x45:
      id: 'national_best_bid_equals_upper_limit_price_band'
      doc: 'National Best Bid is in Limit State'
    0x46:
      id: 'national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Offer is in Limit State'
    0x47:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_offer_above_upper_limit_price_band'
      doc: 'National Best Bid is in Limit State and National Best Offer is Non-Executable'
    0x48:
      id: 'national_best_bid_below_lower_limit_price_band_and_national_best_offer_equals_lower_limit_price_band'
      doc: 'National Best Bid is Non-Executable and National Best Offer is in Limit State'
    0x49:
      id: 'national_best_bid_equals_upper_limit_price_band_and_national_best_offer_equals_lower_limit_price_band'
      doc: 'Crossed - NOT in Limit State'
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
      doc: 'ONLY OFFER SIDE is eligible for BBO'
    0x46:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_the_offer_side'
      doc: 'ONLY BID SIDE is eligible for BBO'
    0x48:
      id: 'slow_quote_on_the_bid_and_offer_sides'
      doc: 'Eligible for BBO'
    0x4c:
      id: 'closed_market_maker_finra'
      doc: 'Not eligible for BBO'
    0x4e:
      id: 'non_firm_quote'
      doc: 'Not eligible for BBO'
    0x4f:
      id: 'opening_quote'
      doc: 'Eligible for BBO'
    0x52:
      id: 'regular_finra_open'
      doc: 'Eligible for BBO'
    0x55:
      id: 'slow_quote_due_to_lrp_or_gap_quote_on_both_the_bid_and_offer_sides'
      doc: 'Not eligible for BBO'
    0x57:
      id: 'slow_quote_due_to_set_slow_list_on_both_the_bid_and_offer_sides'
      doc: 'Eligible for BBO'
    0x34:
      id: 'on_demand_intra_day_auction'
      doc: 'Not eligible for BBO'
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
      doc: 'Bid is Non-Executable'
    0x42:
      id: 'offer_price_below_lower_limit_price_band'
      doc: 'Offer is Non-Executable'
  finra_bbo_luld_indicator:
    0x20:
      id: 'limit_up_limit_down_not_applicable'
      doc: 'Limit Up Limit Down Not Applicable'
    0x41:
      id: 'finra_best_bid_andor_finra_best_offer_are_executable'
      doc: 'Finra Best Bid Andor Finra Best Offer Are Executable'
    0x42:
      id: 'finra_best_bid_outside_price_band'
      doc: 'FINRA Best Bid is Non-Executable'
    0x43:
      id: 'finra_best_offer_outside_price_band'
      doc: 'FINRA Best Offer is Non-Executable'
    0x44:
      id: 'finra_best_bid_and_finra_best_offer_outside_price_band'
      doc: 'FINRA Best Bid and FINRA Best Offer are Non-Executable'

