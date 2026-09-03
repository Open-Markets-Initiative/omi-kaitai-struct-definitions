# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Opra Output Obi v6.3.a
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: Output
#   Encoding: Opra Binary Interface
#   Version: 6.3.a
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
  id: siac_opra_output_obi_v6_3_a
  title: Siac Opra Output Obi v6.3.a
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Options Price Reporting Authority Output Obi v6.3.a'
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
        type: u1
        enum: data_feed_indicator
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
        doc: 'Opra Message Header first level dispatch'
      - id: payload
        type:
          switch-on: message_header.message_category
          cases:
            'message_category::administrative': administrative_category
            'message_category::control': control_category
            'message_category::equity_and_index_last_sale': equity_and_index_last_sale_category
            'message_category::open_interest': open_interest_category
            'message_category::equity_and_index_end_of_day_summary': equity_and_index_end_of_day_summary_category
            'message_category::long_equity_and_index_quote': long_equity_and_index_quote_category
            'message_category::short_equity_and_index_quote': short_equity_and_index_quote_category
            'message_category::series_mapping': series_mapping_category
            'message_category::underlying_value': underlying_value_category
  message_header:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Ascii Character That Identifies The Participant Or Processor That Initiated The Message'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Message Identifier'
  administrative_category:
    seq:
      - id: administrative_message_type
        type: u1
        enum: administrative_message_type
        doc: 'Message Type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type.to_i
          cases:
            _: administrative_message
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
  control_category:
    seq:
      - id: control_message_type
        type: u1
        enum: control_message_type
        doc: 'Control message type'
      - id: control_message_payload
        type:
          switch-on: control_message_type
          cases:
            'control_message_type::start_of_day': control_message
            'control_message_type::start_of_summary': control_message
            'control_message_type::end_of_summary': control_message
            'control_message_type::end_of_day': control_message
            'control_message_type::reset_block_sequence_number': control_message
            'control_message_type::start_of_open_interest': control_message
            'control_message_type::end_of_open_interest': control_message
            'control_message_type::line_integrity': control_message
            'control_message_type::disaster_recovery_data_center_activation': control_message
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
  equity_and_index_last_sale_category:
    seq:
      - id: equity_and_index_last_sale_message_type
        type: u1
        enum: equity_and_index_last_sale_message_type
        doc: 'Message Type'
      - id: equity_and_index_last_sale_message_payload
        type:
          switch-on: equity_and_index_last_sale_message_type
          cases:
            'equity_and_index_last_sale_message_type::canc': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::oseq': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::cncl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::late': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::cnco': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::open': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::cnol': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::opnl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::auto_field': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::reop': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::ajst': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::sprd': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::stdl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::stpd': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::cstp': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::bwrt': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::cmbo': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::spim': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::isoi': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::bnmt': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::xmpt': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::slan': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::slai': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::slcn': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::scli': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::slft': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::mlet': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::mlat': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::mlct': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::mlft': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::mesl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::tlat': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::masl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::mfsl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::tlet': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::tlct': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::tlft': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::tesl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::tasl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::tfsl': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::cbmo': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::mctp': equity_and_index_last_sale_message
            'equity_and_index_last_sale_message_type::exht': equity_and_index_last_sale_message
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
  open_interest_category:
    seq:
      - id: open_interest_message_type
        type: u1
        enum: open_interest_message_type
        doc: 'Open Interest Message Type'
      - id: open_interest_message_payload
        type:
          switch-on: open_interest_message_type.to_i
          cases:
            _: open_interest_message
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
  equity_and_index_end_of_day_summary_category:
    seq:
      - id: equity_and_index_end_of_day_summary_message_type
        type: u1
        enum: equity_and_index_end_of_day_summary_message_type
        doc: 'Equity And Index End Of Day Summary Message Type'
      - id: equity_and_index_end_of_day_summary_message_payload
        type:
          switch-on: equity_and_index_end_of_day_summary_message_type.to_i
          cases:
            _: equity_and_index_end_of_day_summary_message
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
  long_equity_and_index_quote_category:
    seq:
      - id: long_equity_and_index_quote_message_type
        type: u1
        enum: long_equity_and_index_quote_message_type
        doc: 'Long Equity And Index Quote Message Type'
      - id: long_equity_and_index_quote_message_payload
        type:
          switch-on: long_equity_and_index_quote_message_type.to_i
          cases:
            70: long_equity_and_index_quote_message
            73: long_equity_and_index_quote_message
            82: long_equity_and_index_quote_message
            84: long_equity_and_index_quote_message
            65: long_equity_and_index_quote_message
            66: long_equity_and_index_quote_message
            79: long_equity_and_index_quote_message
            67: long_equity_and_index_quote_message
            88: long_equity_and_index_quote_message
            89: long_equity_and_index_quote_message
            _: long_equity_and_index_quote_message
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
  short_equity_and_index_quote_category:
    seq:
      - id: short_equity_and_index_quote_message_type
        type: u1
        enum: short_equity_and_index_quote_message_type
        doc: 'Short Equity And Index Quote Message Type'
      - id: short_equity_and_index_quote_message_payload
        type:
          switch-on: short_equity_and_index_quote_message_type.to_i
          cases:
            70: short_equity_and_index_quote_message
            73: short_equity_and_index_quote_message
            82: short_equity_and_index_quote_message
            84: short_equity_and_index_quote_message
            65: short_equity_and_index_quote_message
            66: short_equity_and_index_quote_message
            79: short_equity_and_index_quote_message
            67: short_equity_and_index_quote_message
            88: short_equity_and_index_quote_message
            89: short_equity_and_index_quote_message
            _: short_equity_and_index_quote_message
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
  series_mapping_category:
    seq:
      - id: series_mapping_message_type
        type: u1
        enum: series_mapping_message_type
        doc: 'Series Mapping Message Type'
      - id: series_mapping_message_payload
        type:
          switch-on: series_mapping_message_type.to_i
          cases:
            _: series_mapping_message
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
  underlying_value_category:
    seq:
      - id: underlying_value_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Underlying Value Message Type'
      - id: underlying_value_message_payload
        type:
          switch-on: underlying_value_message_type
          cases:
            '"I"': underlying_value_bid_and_offer_message
            _: underlying_value_last_sale_message
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
  data_feed_indicator:
    0x4f:
      id: 'opra'
      doc: 'Opra'
  retransmission_indicator:
    0x56:
      id: 'retransmitted'
      doc: 'Retransmission Of The Block'
    0x20:
      id: 'not_retransmitted'
      doc: 'Not A Retransmitted Message'
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
  message_category:
    0x43:
      id: 'administrative'
      doc: 'Administrative Message'
    0x48:
      id: 'control'
      doc: 'Control Message'
    0x61:
      id: 'equity_and_index_last_sale'
      doc: 'Equity And Index Last Sale Message'
    0x64:
      id: 'open_interest'
      doc: 'Open Interest Message'
    0x66:
      id: 'equity_and_index_end_of_day_summary'
      doc: 'Equity And Index End Of Day Summary Message'
    0x6b:
      id: 'long_equity_and_index_quote'
      doc: 'Long Equity And Index Quote Message'
    0x71:
      id: 'short_equity_and_index_quote'
      doc: 'Short Equity And Index Quote Message'
    0x52:
      id: 'series_mapping'
      doc: 'Series Mapping Message Used To Report Mapping Information For Each Option Series To The Output Line It Is Assigned For The Current Opra Session'
    0x59:
      id: 'underlying_value'
      doc: 'Underlying Value Message Subdispatch Handled At The Category Message Type Lowbyte Level'
  administrative_message_type:
    0x20:
      id: 'administrative'
      doc: 'Administrative Message'
  control_message_type:
    0x43:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x45:
      id: 'start_of_summary'
      doc: 'Start Of Summary'
    0x46:
      id: 'end_of_summary'
      doc: 'End Of Summary'
    0x4a:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4b:
      id: 'reset_block_sequence_number'
      doc: 'Reset Block Sequence Number'
    0x4c:
      id: 'start_of_open_interest'
      doc: 'Start Of Open Interest'
    0x4d:
      id: 'end_of_open_interest'
      doc: 'End Of Open Interest'
    0x4e:
      id: 'line_integrity'
      doc: 'Line Integrity'
    0x50:
      id: 'disaster_recovery_data_center_activation'
      doc: 'Disaster Recovery Data Center Activation'
  equity_and_index_last_sale_message_type:
    0x41:
      id: 'canc'
      doc: 'Transaction Previously Reported Other Than As The Last Or Opening Report For The Particular Option Contract Is Now To Be Cancelled'
    0x42:
      id: 'oseq'
      doc: 'Transaction Is Being Reported Late And Is Out Of Sequence Ie Later Transactions Have Been Reported For The Particular Option Contract'
    0x43:
      id: 'cncl'
      doc: 'Transaction Is The Last Reported For The Particular Option Contract And Is Now Cancelled'
    0x44:
      id: 'late'
      doc: 'Transaction Is Being Reported Late But Is In The Correct Sequence Ie No Later Transactions Have Been Reported For The Particular Option Contract'
    0x45:
      id: 'cnco'
      doc: 'Transaction Was The First One Opening Reported This Day For The Particular Option Contract Although Later Transactions Have Been Reported This Transaction Is Now To Be Cancelled'
    0x46:
      id: 'open'
      doc: 'Transaction Is A Late Report Of The Opening Trade And Is Out Of Sequence Ie Other Transactions Have Been Reported For The Particular Option Contract'
    0x47:
      id: 'cnol'
      doc: 'Transaction Was The Only One Reported This Day For The Particular Option Contract And Is Now To Be Cancelled'
    0x48:
      id: 'opnl'
      doc: 'Transaction Is A Late Report Of The Opening Trade But Is In The Correct Sequence Ie No Other Transactions Have Been Reported For The Particular Option Contract'
    0x49:
      id: 'auto_field'
      doc: 'Transaction Was Executed Electronically Prefix Appears Solely For Information Process As A Regular Transaction'
    0x4a:
      id: 'reop'
      doc: 'Transaction Is A Reopening Of An Option Contract In Which Trading Has Been Previously Halted Prefix Appears Solely For Information Process As A Regular Transaction'
    0x4b:
      id: 'ajst'
      doc: 'Transaction Is An Option Contract For Which The Terms Have Been Adjusted To Reflect A Stock Dividend Stock Split Or Similar Event Prefix Appears Solely For Information Process As A Regular Transaction'
    0x4c:
      id: 'sprd'
      doc: 'Transaction Represents A Trade In Two Options In The Same Class A Buy And A Sell In The Same Class Prefix Appears Solely For Information Process As A Regular Transaction'
    0x4d:
      id: 'stdl'
      doc: 'Transaction Represents A Trade In Two Options In The Same Class A Buy And A Sell In A Put And A Call Prefix Appears Solely For Information Process As A Regular Transaction'
    0x4e:
      id: 'stpd'
      doc: 'Transaction Is The Execution Of A Sale At A Price Agreed Upon By The Floor Personnel Involved Where A Condition Of The Trade Is That It Reported Following A Nonstopped Trade Of The Same Series At The Same Price'
    0x4f:
      id: 'cstp'
      doc: 'Cancel Stopped Transaction'
    0x50:
      id: 'bwrt'
      doc: 'Transaction Represents The Option Portion Of An Order Involving A Single Option Leg Buy Or Sell Of A Call Or Put And Stock Prefix Appears Solely For Information Process As A Regular Transaction'
    0x51:
      id: 'cmbo'
      doc: 'Transaction Represents The Buying Of A Call And The Selling Of A Put For The Same Underlying Stock Or Index Prefix Appears Solely For Information Process As A Regular Transaction'
    0x52:
      id: 'spim'
      doc: 'Transaction Was The Execution Of An Order Which Was Stopped At A Price That Did Not Constitute A Trade Through On Another Market At The Time Of The Stop Process Like A Normal Transaction'
    0x53:
      id: 'isoi'
      doc: 'Transaction Was The Execution Of An Order Identified As An Intermarket Sweep Order Process Like Normal Transaction'
    0x54:
      id: 'bnmt'
      doc: 'Transaction Reflects The Execution Of A Benchmark Trade A Benchmark Trade Is A Trade Resulting From The Matching Of Benchmark Orders A Benchmark Order Is An Order For Which The Price Is Not Based Directly Or Indirectly On The Quote Price Of The Option At The Time Of The Orders Execution And For Which The Material Terms Were Not Reasonably Determinable At The Time A Commitment To Trade The Order Was Made Process Like A Normal Transaction Except Dont Update Last'
    0x58:
      id: 'xmpt'
      doc: 'Transaction Is Trade Through Exempt The Transaction Should Be Treated Like A Regular Sale'
    0x61:
      id: 'slan'
      doc: 'Slan'
    0x62:
      id: 'slai'
      doc: 'Slai'
    0x63:
      id: 'slcn'
      doc: 'Slcn'
    0x64:
      id: 'scli'
      doc: 'Scli'
    0x65:
      id: 'slft'
      doc: 'Slft'
    0x66:
      id: 'mlet'
      doc: 'Mlet'
    0x67:
      id: 'mlat'
      doc: 'Mlat'
    0x68:
      id: 'mlct'
      doc: 'Mlct'
    0x69:
      id: 'mlft'
      doc: 'Mlft'
    0x6a:
      id: 'mesl'
      doc: 'Mesl'
    0x6b:
      id: 'tlat'
      doc: 'Tlat'
    0x6c:
      id: 'masl'
      doc: 'Masl'
    0x6d:
      id: 'mfsl'
      doc: 'Mfsl'
    0x6e:
      id: 'tlet'
      doc: 'Tlet'
    0x6f:
      id: 'tlct'
      doc: 'Tlct'
    0x70:
      id: 'tlft'
      doc: 'Tlft'
    0x71:
      id: 'tesl'
      doc: 'Tesl'
    0x72:
      id: 'tasl'
      doc: 'Tasl'
    0x73:
      id: 'tfsl'
      doc: 'Tfsl'
    0x74:
      id: 'cbmo'
      doc: 'Cbmo'
    0x75:
      id: 'mctp'
      doc: 'Mctp'
    0x76:
      id: 'exht'
      doc: 'Exht'
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
  open_interest_message_type:
    0x20:
      id: 'open_interest'
      doc: 'Open Interest Message'
  equity_and_index_end_of_day_summary_message_type:
    0x20:
      id: 'equity_and_index_end_of_day_summary'
      doc: 'Equity And Index End Of Day Summary Message'
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
  long_equity_and_index_quote_message_type:
    0x20:
      id: 'regular_trading'
      doc: 'Regular Trading'
    0x46:
      id: 'non_firm_quote'
      doc: 'Non Firm Quote'
    0x49:
      id: 'indicative_value'
      doc: 'Indicative Value'
    0x52:
      id: 'rotation'
      doc: 'Rotation'
    0x54:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x41:
      id: 'eligible_for_automatic_execution'
      doc: 'Eligible For Automatic Execution'
    0x42:
      id: 'bid_contains_customer_trading_interest'
      doc: 'Bid Contains Customer Trading Interest'
    0x4f:
      id: 'offer_contains_customer_trading_interest'
      doc: 'Offer Contains Customer Trading Interest'
    0x43:
      id: 'both_bid_and_offer_contain_customer_trading_interest'
      doc: 'Both Bid And Offer Contain Customer Trading Interest'
    0x58:
      id: 'offer_side_of_quote_not_firm_bid_side_firm'
      doc: 'Offer Side Of Quote Not Firm Bid Side Firm'
    0x59:
      id: 'bid_side_of_quote_not_firm_offer_side_firm'
      doc: 'Bid Side Of Quote Not Firm Offer Side Firm'
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
  short_equity_and_index_quote_message_type:
    0x20:
      id: 'regular_trading'
      doc: 'Regular Trading'
    0x46:
      id: 'non_firm_quote'
      doc: 'Non Firm Quote'
    0x49:
      id: 'indicative_value'
      doc: 'Indicative Value'
    0x52:
      id: 'rotation'
      doc: 'Rotation'
    0x54:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x41:
      id: 'eligible_for_automatic_execution'
      doc: 'Eligible For Automatic Execution'
    0x42:
      id: 'bid_contains_customer_trading_interest'
      doc: 'Bid Contains Customer Trading Interest'
    0x4f:
      id: 'offer_contains_customer_trading_interest'
      doc: 'Offer Contains Customer Trading Interest'
    0x43:
      id: 'both_bid_and_offer_contain_customer_trading_interest'
      doc: 'Both Bid And Offer Contain Customer Trading Interest'
    0x58:
      id: 'offer_side_of_quote_not_firm_bid_side_firm'
      doc: 'Offer Side Of Quote Not Firm Bid Side Firm'
    0x59:
      id: 'bid_side_of_quote_not_firm_offer_side_firm'
      doc: 'Bid Side Of Quote Not Firm Offer Side Firm'
  series_mapping_message_type:
    0x20:
      id: 'series_mapping'
      doc: 'Series Mapping Message'
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

