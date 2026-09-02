# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Opra Output Obi v6.3.Hft
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: Output
#   Encoding: Opra Binary Interface
#   Version: 6.3.Hft
#   Date: 02/20/2026
#   Specification: OPRA_Pillar_Output_Specification.pdf
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
  id: siac_opra_output_obi_v6_3_hft
  title: Siac Opra Output Obi v6.3.Hft
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Options Price Reporting Authority Output Obi v6.3.Hft'
doc-ref: https://www.opraplan.com/document-library

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Opra packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: block_header.messages_in_block
    doc: 'Opra Obi Block Data containing messages'
  - id: block_pad_byte
    type: u1
    if: _io.pos % 2 != 0
    doc: 'Block Pad Byte'

types:
  block_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Designates The Opra Binary Version'
      - id: block_size
        type: u2
        doc: 'Size In Bytes Of Entire Transmission Block'
      - id: data_feed_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value Is O For Opra'
      - id: retransmission_indicator
        type: u1
        enum: retransmission_indicator
        doc: 'Contains Either A Space Not A Retransmitted Message Or V Indicating A Retransmission Of The Block'
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: '0 X 00 For Regular Trading Session'
      - id: block_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Block Data Of The Transmission Block'
      - id: block_timestamp
        type: block_timestamp
        doc: 'Opra packet timestamp. Nanoseconds since Unix epoch'
      - id: block_checksum
        type: u2
        doc: 'Lower 16 Bits Of The 32 Bit Sum Of All Bytes In The Block Excluding The Block Checksum Field'
  block_timestamp:
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
        doc: 'Opra Udp Message Header'
      - id: payload
        type: series_mapping_message
        doc: 'Series Mapping Message. Used to report mapping information for each option series to the output line it is assigned for the current OPRA session. Dispatches on Category Message Type ''R '' (R + space)'
  message_header:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Ascii Character That Identifies The Participant Or Processor That Initiated The Message'
      - id: message_category
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Type'
  underlying_value_last_sale_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: reserved_1
        type: u1
        doc: 'One Reserved Byte'
      - id: index_value_denominator_code
        type: u1
        enum: index_value_denominator_code
        doc: 'Contains The Index Value Using Last Sale Values Of Index Components'
      - id: index_value
        type: s4
        doc: 'Contains The Index Value Using Last Sale Values Of Index Components'
      - id: reserved_4
        type: u4
        doc: 'Four Reserved Bytes'
  underlying_value_bid_and_offer_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: reserved_1
        type: u1
        doc: 'One Reserved Byte'
      - id: index_value_denominator_code
        type: u1
        enum: index_value_denominator_code
        doc: 'Contains The Index Value Using Last Sale Values Of Index Components'
      - id: bid_index_value
        type: s4
        doc: 'The Bid Index Value Represents The Value Of The Indexs Calculation Formula Using The Current Bid Values Of The Component Securities'
      - id: offer_index_value
        type: s8
        doc: 'The Offer Index Value Represents The Value Of The Indexs Calculation Formula Using The Current Offer Values Of The Component Securities'
  administrative_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: message_data_length
        type: u2
        doc: 'Represents The Length Of The Message Data Field'
      - id: message_data
        type: str
        size: message_data_length
        encoding: ASCII
        if: message_data_length > 0
        doc: 'Represents The Message Data Field'
  control_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
  equity_and_index_last_sale_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: reserved_1
        type: u1
        doc: 'One Reserved Byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: u4
        doc: 'Represents The Stated Price Per Share For Which The Underlying Security May Be Purchased In The Case Of A Call Or Sold In The Case Of A Put By The Option Holder Upon Exercise Of The Option Contract'
      - id: volume
        type: u4
        doc: 'Represents The Total Number Of Contracts Traded For An Option In One Trade Or The Total Number Of Contracts Traded For An Option For The Entire Trading Day'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Represents The First Price Paid For An Option During The Trading Day'
      - id: premium_price
        type: s4
        doc: 'Represents The Price Of An Option Contract Determined In The Competitive Marketplace Which The Buyer Of The Option Pays To The Option Writer For The Rights Conveyed By The Option Contract'
      - id: trade_identifier
        type: u4
        doc: 'For Future Use Filled With Hex 0 X 00'
      - id: reserved_4
        type: u4
        doc: 'Four Reserved Bytes'
  expiration_block:
    seq:
      - id: expiration_month
        type: u1
        enum: expiration_month
        doc: 'Indicates The Expiration Month And Identifies The Option As A Call Or A Put'
      - id: expiration_day
        type: u1
        doc: 'Contains Hex 0 X 01 To 0 X 1f Decimal 1 To 31 Indicating The Day Of The Month The Series Expires'
      - id: expiration_year
        type: u1
        doc: 'Contains Hex 0 X 00 To 0 X 63 Decimal 0 To 99 Represents The Year Starting With Year 2000'
  open_interest_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: reserved_1
        type: u1
        doc: 'One Reserved Byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: u4
        doc: 'Represents The Stated Price Per Share For Which The Underlying Security May Be Purchased In The Case Of A Call Or Sold In The Case Of A Put By The Option Holder Upon Exercise Of The Option Contract'
      - id: open_interest_volume
        type: u4
        doc: 'Represents The Total Number Of Outstanding Option Contracts That Have Not Been Exercised And Have Not Yet Reached Expiration'
  equity_and_index_end_of_day_summary_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: reserved_1
        type: u1
        doc: 'One Reserved Byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: u4
        doc: 'Represents The Stated Price Per Share For Which The Underlying Security May Be Purchased In The Case Of A Call Or Sold In The Case Of A Put By The Option Holder Upon Exercise Of The Option Contract'
      - id: volume
        type: u4
        doc: 'Represents The Total Number Of Contracts Traded For An Option In One Trade Or The Total Number Of Contracts Traded For An Option For The Entire Trading Day'
      - id: open_interest_volume
        type: u4
        doc: 'Represents The Total Number Of Outstanding Option Contracts That Have Not Been Exercised And Have Not Yet Reached Expiration'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Represents The First Price Paid For An Option During The Trading Day'
      - id: open_price
        type: s4
        doc: 'Represents The First Price Paid For An Option During The Trading Day'
      - id: high_price
        type: s4
        doc: 'Represents The Highest Price Paid For An Option During The Trading Day'
      - id: low_price
        type: s4
        doc: 'Represents The Lowest Price Paid For An Option During The Trading Day'
      - id: last_price
        type: s4
        doc: 'Represents The Last Price Paid For An Option During The Trading Day'
      - id: net_change
        type: s4
        doc: 'Represents The Change In The Price Of An Option From The Closing Price Of One Day To The Closing Price On The Next Day On Which The Option Is Traded'
      - id: underlying_price_denominator_code
        type: u1
        enum: underlying_price_denominator_code
        doc: 'The Underlying Price Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Underlying Price Field'
      - id: underlying_price
        type: s8
        doc: 'Represents The Price Of The Underlying Security'
      - id: bid_price
        type: s4
        doc: 'Represents The Price At Which A Buyer Is Willing To Buy An Option'
      - id: offer_price
        type: s4
        doc: 'Represents The Price At Which A Seller Is Offering To Sell An Option'
  long_equity_and_index_quote_message:
    seq:
      - id: bbo_indicator
        type: u1
        enum: bbo_indicator
        doc: 'Indicates The Effect The New Quote Has On The Best Bid Andor The Best Offer'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: reserved_1
        type: u1
        doc: 'One Reserved Byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: u4
        doc: 'Represents The Stated Price Per Share For Which The Underlying Security May Be Purchased In The Case Of A Call Or Sold In The Case Of A Put By The Option Holder Upon Exercise Of The Option Contract'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Represents The First Price Paid For An Option During The Trading Day'
      - id: bid_price
        type: s4
        doc: 'Represents The Price At Which A Buyer Is Willing To Buy An Option'
      - id: bid_size
        type: u4
        doc: 'The Bid Size Identifies The Number Of Contracts Being Bought For An Option At The Bid Price'
      - id: offer_price
        type: s4
        doc: 'Represents The Price At Which A Seller Is Offering To Sell An Option'
      - id: offer_size
        type: u4
        doc: 'The Offer Size Identifies The Number Of Contracts For Sale For An Option At The Offer Price'
      - id: best_bid_appendage
        type: best_bid_appendage
        if: bbo_indicator == bbo_indicator::best_bid_appendage_no_best_offer_change or bbo_indicator == bbo_indicator::best_bid_appendage_quote_contains_best_offer or bbo_indicator == bbo_indicator::best_bid_appendage_no_best_offer
        doc: 'Best Bid Appendage'
      - id: best_offer_appendage
        type: best_offer_appendage
        if: bbo_indicator == bbo_indicator::no_best_bid_change_best_offer_appendage or bbo_indicator == bbo_indicator::quote_contains_best_bid_best_offer_appendage or bbo_indicator == bbo_indicator::no_best_bid_best_offer_appendage
        doc: 'Best Offer Appendage'
      - id: best_bid_and_offer_appendage
        type: best_bid_and_offer_appendage
        if: bbo_indicator == bbo_indicator::best_bid_appendage_best_offer_appendage
        doc: 'Best Bid and Offer Appendage'
  best_bid_appendage:
    seq:
      - id: best_bid_participant_id
        type: u1
        enum: best_bid_participant_id
        doc: 'Identifies The Participant That Entered The Best Bid'
      - id: best_bid_denominator_code
        type: u1
        enum: best_bid_denominator_code
        doc: 'The Bed Bid Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Best Bid Price Field'
      - id: best_bid_price
        type: s4
        doc: 'Represents The Best Price At Which A Buyer Is Willing To Buy An Option'
      - id: best_bid_size
        type: u4
        doc: 'The Best Bid Size Identifies The Number Of Contracts Being Bought For An Option At The Best Bid Price'
  best_offer_appendage:
    seq:
      - id: best_offer_participant_id
        type: u1
        enum: best_offer_participant_id
        doc: 'Identifies The Participant That Entered The Best Bid'
      - id: best_offer_denominator_code
        type: u1
        enum: best_offer_denominator_code
        doc: 'The Bed Offer Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Best Offer Price Field'
      - id: best_offer_price
        type: s4
        doc: 'Represents The Best Price At Which A Seller Is Offering To Sell An Option'
      - id: best_offer_size
        type: u4
        doc: 'The Best Offer Size Identifies The Number Of Contracts Being Bought For An Option At The Best Offer Price'
  best_bid_and_offer_appendage:
    seq:
      - id: best_bid_participant_id
        type: u1
        enum: best_bid_participant_id
        doc: 'Identifies The Participant That Entered The Best Bid'
      - id: best_bid_denominator_code
        type: u1
        enum: best_bid_denominator_code
        doc: 'The Bed Bid Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Best Bid Price Field'
      - id: best_bid_price
        type: s4
        doc: 'Represents The Best Price At Which A Buyer Is Willing To Buy An Option'
      - id: best_bid_size
        type: u4
        doc: 'The Best Bid Size Identifies The Number Of Contracts Being Bought For An Option At The Best Bid Price'
      - id: best_offer_participant_id
        type: u1
        enum: best_offer_participant_id
        doc: 'Identifies The Participant That Entered The Best Bid'
      - id: best_offer_denominator_code
        type: u1
        enum: best_offer_denominator_code
        doc: 'The Bed Offer Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Best Offer Price Field'
      - id: best_offer_price
        type: s4
        doc: 'Represents The Best Price At Which A Seller Is Offering To Sell An Option'
      - id: best_offer_size
        type: u4
        doc: 'The Best Offer Size Identifies The Number Of Contracts Being Bought For An Option At The Best Offer Price'
  short_equity_and_index_quote_message:
    seq:
      - id: bbo_indicator
        type: u1
        enum: bbo_indicator
        doc: 'Indicates The Effect The New Quote Has On The Best Bid Andor The Best Offer'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol_short
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_short
        type: u2
        doc: 'Represents The Stated Price Per Share For Which The Underlying Security May Be Purchased In The Case Of A Call Or Sold In The Case Of A Put By The Option Holder Upon Exercise Of The Option Contract'
      - id: bid_price_short
        type: u2
        doc: 'Represents The Price At Which A Buyer Is Willing To Buy An Option'
      - id: bid_size_short
        type: u2
        doc: 'The Bid Size Identifies The Number Of Contracts Being Bought For An Option At The Bid Price'
      - id: offer_price_short
        type: u2
        doc: 'Represents The Price At Which A Seller Is Offering To Sell An Option'
      - id: offer_size_short
        type: u2
        doc: 'The Offer Size Identifies The Number Of Contracts For Sale For An Option At The Offer Price'
      - id: best_bid_appendage
        type: best_bid_appendage
        if: bbo_indicator == bbo_indicator::best_bid_appendage_no_best_offer_change or bbo_indicator == bbo_indicator::best_bid_appendage_quote_contains_best_offer or bbo_indicator == bbo_indicator::best_bid_appendage_no_best_offer
        doc: 'Best Bid Appendage'
      - id: best_offer_appendage
        type: best_offer_appendage
        if: bbo_indicator == bbo_indicator::no_best_bid_change_best_offer_appendage or bbo_indicator == bbo_indicator::quote_contains_best_bid_best_offer_appendage or bbo_indicator == bbo_indicator::no_best_bid_best_offer_appendage
        doc: 'Best Offer Appendage'
      - id: best_bid_and_offer_appendage
        type: best_bid_and_offer_appendage
        if: bbo_indicator == bbo_indicator::best_bid_appendage_best_offer_appendage
        doc: 'Best Bid and Offer Appendage'
  series_mapping_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message Identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved For Internal Use Only'
      - id: participant_reference_number
        type: u4
        doc: 'The Prn Is For Optional Use By The Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'Identifies The Unique Symbol Assigned To The Underlying Security'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code Field Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: u4
        doc: 'Represents The Stated Price Per Share For Which The Underlying Security May Be Purchased In The Case Of A Call Or Sold In The Case Of A Put By The Option Holder Upon Exercise Of The Option Contract'
      - id: multicast_line_number
        type: u2
        doc: 'Multicast Line Number Assigned To The Option Series Values Between 1 And 96'
      - id: reserved_128
        type: str
        size: 128
        encoding: ASCII
        doc: 'One Hundred Twentyeight Reserved Bytes'
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

enums:
  retransmission_indicator:
    0x20:
      id: 'not_retransmitted'
      doc: 'Not A Retransmitted Message'
    0x56:
      id: 'retransmitted'
      doc: 'Retransmission Of The Block'
  session_indicator:
    0:
      id: 'regular'
      doc: 'Regular Trading Session'
    1:
      id: 'sunday_into_monday'
      doc: 'Global Trading Hours Session Sunday Into Monday'
    2:
      id: 'monday_into_tuesday'
      doc: 'Global Trading Hours Session Monday Into Tuesday'
    3:
      id: 'tuesday_into_wednesday'
      doc: 'Global Trading Hours Session Tuesday Into Wednesday'
    4:
      id: 'wednesday_into_thursday'
      doc: 'Global Trading Hours Session Wednesday Into Thursday'
    5:
      id: 'thursday_into_friday'
      doc: 'Global Trading Hours Session Thursday Into Friday'
    0x58:
      id: 'generated_by_opra'
      doc: 'Ascii X Hex 0 X 58 On Any Messages Generated By Opra During Gth Eg Control Category H Messages Or Opr Agenerated Zero Quotes'
  participant_id:
    0x41:
      id: 'amex'
      doc: 'Nyse American'
    0x42:
      id: 'box_field'
      doc: 'Boston Options Exchange'
    0x43:
      id: 'cboe'
      doc: 'Cboe Options Exchange'
    0x44:
      id: 'emerald'
      doc: 'Miax Emerald'
    0x45:
      id: 'edgx'
      doc: 'Cboe Edgx Options Exchange'
    0x47:
      id: 'mx_2'
      doc: 'Mx 2 Options'
    0x48:
      id: 'gemx'
      doc: 'Nasdaq Gemx'
    0x49:
      id: 'ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'mrx'
      doc: 'Nasdaq Mrx'
    0x4d:
      id: 'miax'
      doc: 'Miami International Securities Exchange'
    0x4e:
      id: 'nyse'
      doc: 'Nyse Arca'
    0x4f:
      id: 'opra'
      doc: 'Options Price Reporting Authority'
    0x50:
      id: 'pearl'
      doc: 'Miax Pearl'
    0x51:
      id: 'nasd'
      doc: 'Nasdaq Options Market'
    0x53:
      id: 'sphr'
      doc: 'Miax Sapphire'
    0x54:
      id: 'bx'
      doc: 'Nasdaq Bx Options'
    0x55:
      id: 'memx'
      doc: 'Members Options Exchange'
    0x56:
      id: 'iex'
      doc: 'Iex Options Llc'
    0x57:
      id: 'c_2'
      doc: 'Cboe C 2 Options Exchange'
    0x58:
      id: 'phlx'
      doc: 'Nasdaq Phlx'
    0x5a:
      id: 'bats'
      doc: 'Cboe Bzx Options Exchange'
  index_value_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1000'
    0x44:
      id: 'ten_thousand'
      doc: '10000'
    0x45:
      id: 'hundred_thousand'
      doc: '100000'
    0x46:
      id: 'million'
      doc: '1000000'
    0x47:
      id: 'ten_million'
      doc: '10000000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  expiration_month:
    0x41:
      id: 'call_options_january'
      doc: 'January'
    0x42:
      id: 'call_options_february'
      doc: 'February'
    0x43:
      id: 'call_options_march'
      doc: 'March'
    0x44:
      id: 'call_options_april'
      doc: 'April'
    0x45:
      id: 'call_options_may'
      doc: 'May'
    0x46:
      id: 'call_options_june'
      doc: 'June'
    0x47:
      id: 'call_options_july'
      doc: 'July'
    0x48:
      id: 'call_options_august'
      doc: 'August'
    0x49:
      id: 'call_options_september'
      doc: 'September'
    0x4a:
      id: 'call_options_october'
      doc: 'October'
    0x4b:
      id: 'call_options_november'
      doc: 'November'
    0x4c:
      id: 'call_options_december'
      doc: 'December'
    0x4d:
      id: 'put_options_january'
      doc: 'January'
    0x4e:
      id: 'put_options_february'
      doc: 'February'
    0x4f:
      id: 'put_options_march'
      doc: 'March'
    0x50:
      id: 'put_options_april'
      doc: 'April'
    0x51:
      id: 'put_options_may'
      doc: 'May'
    0x52:
      id: 'put_options_june'
      doc: 'June'
    0x53:
      id: 'put_options_july'
      doc: 'July'
    0x54:
      id: 'put_options_august'
      doc: 'August'
    0x55:
      id: 'put_options_september'
      doc: 'September'
    0x56:
      id: 'put_options_october'
      doc: 'October'
    0x57:
      id: 'put_options_november'
      doc: 'November'
    0x58:
      id: 'put_options_december'
      doc: 'December'
  strike_price_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1000'
    0x44:
      id: 'ten_thousand'
      doc: '10000'
    0x45:
      id: 'hundred_thousand'
      doc: '100000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  premium_price_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1000'
    0x44:
      id: 'ten_thousand'
      doc: '10000'
    0x45:
      id: 'hundred_thousand'
      doc: '100000'
    0x46:
      id: 'million'
      doc: '1000000'
    0x47:
      id: 'ten_million'
      doc: '10000000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  underlying_price_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1000'
    0x44:
      id: 'ten_thousand'
      doc: '10000'
    0x45:
      id: 'hundred_thousand'
      doc: '100000'
    0x46:
      id: 'million'
      doc: '1000000'
    0x47:
      id: 'ten_million'
      doc: '10000000'
    0x48:
      id: 'hundred_million'
      doc: '100000000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  bbo_indicator:
    0x41:
      id: 'no_best_bid_change_or_best_offer_change'
      doc: 'No Best Bid Change Or Best Offer Change'
    0x42:
      id: 'no_best_bid_change_quote_contains_best_offer'
      doc: 'No Best Bid Change Quote Contains Best Offer'
    0x43:
      id: 'no_best_bid_change_best_offer_appendage'
      doc: 'No Best Bid Change Best Offer Appendage'
    0x44:
      id: 'no_best_bid_change_no_best_offer'
      doc: 'No Best Bid Change No Best Offer'
    0x45:
      id: 'quote_contains_best_bid_no_best_offer_change'
      doc: 'Quote Contains Best Bid No Best Offer Change'
    0x46:
      id: 'quote_contains_best_bid_quote_contains_best_offer'
      doc: 'Quote Contains Best Bid Quote Contains Best Offer'
    0x47:
      id: 'quote_contains_best_bid_best_offer_appendage'
      doc: 'Quote Contains Best Bid Best Offer Appendage'
    0x48:
      id: 'quote_contains_best_bid_no_best_offer'
      doc: 'Quote Contains Best Bid No Best Offer'
    0x49:
      id: 'no_best_bid_no_best_offer_change'
      doc: 'No Best Bid No Best Offer Change'
    0x4a:
      id: 'no_best_bid_quote_contains_best_offer'
      doc: 'No Best Bid Quote Contains Best Offer'
    0x4b:
      id: 'no_best_bid_best_offer_appendage'
      doc: 'No Best Bid Best Offer Appendage'
    0x4c:
      id: 'no_best_bid_no_best_offer'
      doc: 'No Best Bid No Best Offer'
    0x4d:
      id: 'best_bid_appendage_no_best_offer_change'
      doc: 'Best Bid Appendage No Best Offer Change'
    0x4e:
      id: 'best_bid_appendage_quote_contains_best_offer'
      doc: 'Best Bid Appendage Quote Contains Best Offer'
    0x4f:
      id: 'best_bid_appendage_best_offer_appendage'
      doc: 'Best Bid Appendage Best Offer Appendage'
    0x50:
      id: 'best_bid_appendage_no_best_offer'
      doc: 'Best Bid Appendage No Best Offer'
    0x20:
      id: 'not_included_in_the_bbo'
      doc: 'Not Included In The Bbo'
  best_bid_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'boston_options_exchange'
      doc: 'Boston Options Exchange'
    0x43:
      id: 'cboe_options_exchange'
      doc: 'Cboe Options Exchange'
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
    0x45:
      id: 'cboe_edgx_options'
      doc: 'Cboe Edgx Options'
    0x47:
      id: 'mx_2_options'
      doc: 'Mx 2 Options'
    0x48:
      id: 'nasdaq_gemx'
      doc: 'Nasdaq Gemx'
    0x49:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'nasdaq_mrx'
      doc: 'Nasdaq Mrx'
    0x4d:
      id: 'miami_international_securities_exchange'
      doc: 'Miami International Securities Exchange'
    0x4e:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x4f:
      id: 'options_price_reporting_authority'
      doc: 'Options Price Reporting Authority'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x51:
      id: 'nasdaq_options_market'
      doc: 'Nasdaq Options Market'
    0x54:
      id: 'nasdaq_bx_options'
      doc: 'Nasdaq Bx Options'
    0x56:
      id: 'iex_options_llc'
      doc: 'Iex Options Llc'
    0x57:
      id: 'cboe_c_2_options'
      doc: 'Cboe C 2 Options'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'Nasdaq Phlx'
    0x5a:
      id: 'cboe_bzx_options_exchange'
      doc: 'Cboe Bzx Options Exchange'
  best_bid_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1000'
    0x44:
      id: 'ten_thousand'
      doc: '10000'
    0x45:
      id: 'hundred_thousand'
      doc: '100000'
    0x46:
      id: 'million'
      doc: '1000000'
    0x47:
      id: 'ten_million'
      doc: '10000000'
    0x48:
      id: 'hundred_million'
      doc: '100000000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  best_offer_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'boston_options_exchange'
      doc: 'Boston Options Exchange'
    0x43:
      id: 'cboe_options_exchange'
      doc: 'Cboe Options Exchange'
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
    0x45:
      id: 'cboe_edgx_options'
      doc: 'Cboe Edgx Options'
    0x47:
      id: 'mx_2_options'
      doc: 'Mx 2 Options'
    0x48:
      id: 'nasdaq_gemx'
      doc: 'Nasdaq Gemx'
    0x49:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'nasdaq_mrx'
      doc: 'Nasdaq Mrx'
    0x4d:
      id: 'miami_international_securities_exchange'
      doc: 'Miami International Securities Exchange'
    0x4e:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x4f:
      id: 'options_price_reporting_authority'
      doc: 'Options Price Reporting Authority'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x51:
      id: 'nasdaq_options_market'
      doc: 'Nasdaq Options Market'
    0x54:
      id: 'nasdaq_bx_options'
      doc: 'Nasdaq Bx Options'
    0x56:
      id: 'iex_options_llc'
      doc: 'Iex Options Llc'
    0x57:
      id: 'cboe_c_2_options'
      doc: 'Cboe C 2 Options'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'Nasdaq Phlx'
    0x5a:
      id: 'cboe_bzx_options_exchange'
      doc: 'Cboe Bzx Options Exchange'
  best_offer_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1000'
    0x44:
      id: 'ten_thousand'
      doc: '10000'
    0x45:
      id: 'hundred_thousand'
      doc: '100000'
    0x46:
      id: 'million'
      doc: '1000000'
    0x47:
      id: 'ten_million'
      doc: '10000000'
    0x48:
      id: 'hundred_million'
      doc: '100000000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'

