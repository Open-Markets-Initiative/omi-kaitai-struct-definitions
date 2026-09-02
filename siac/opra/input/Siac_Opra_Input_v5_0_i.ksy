# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Opra Input Obi v5.0.i
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: Input
#   Encoding: Opra Binary Interface
#   Version: 5.0.i
#   Date: 02/20/2026
#   Specification: OPRA_Pillar_Input_Specification.pdf
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
  id: siac_opra_input_obi_v5_0_i
  title: Siac Opra Input Obi v5.0.i
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Options Price Reporting Authority Input Obi v5.0.i'
doc-ref: https://www.opraplan.com/document-library

seq:
  - id: block_separator
    type: u2
    doc: 'Two byte sequence (Hex 0xA5 0x5A) preceding every block'
  - id: block_header
    type: block_header_struct
    doc: 'Opra Tcp block header'
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
        doc: 'Indicates The Opra Binary Protocol Version'
      - id: block_size
        type: u2
        doc: 'Size In Bytes Of Entire Transmission Block'
      - id: reserved
        type: u1
        doc: 'Reserved for future use'
      - id: second_reserved
        type: u1
        doc: 'Reserved for future use'
      - id: third_reserved
        type: u1
        doc: 'Reserved for future use'
      - id: block_sequence_number
        type: u4
        doc: 'Last Block Sequence Number Received On The Input Line'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Block Data'
      - id: block_timestamp
        type: block_timestamp
        doc: 'Opra block timestamp. Nanoseconds since Unix epoch'
      - id: block_checksum
        type: u2
        doc: 'Lower 16 Bits Of The 32 Bit Sum Of All Bytes In The Block Excluding The Block Checksum Field'
  block_timestamp:
    seq:
      - id: seconds
        type: u4
        doc: 'Number Of Seconds From Epoch 1/1/1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Opra Message Header first level dispatch'
      - id: payload
        type:
          switch-on: message_header.message_category
          cases:
            'message_category::equity_and_index_last_sale': equity_and_index_last_sale_category
            'message_category::equity_and_index_end_of_day_summary': equity_and_index_end_of_day_summary_category
            'message_category::long_equity_and_index_quote': long_equity_and_index_quote_category
            'message_category::short_equity_and_index_quote': short_equity_and_index_quote_category
            'message_category::administrative': administrative_category
            'message_category::control': control_category
            'message_category::sequence_number_status': sequence_number_status_category
            'message_category::underlying_value_message': underlying_value_message_category
  message_header:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'Identifies the Participant or Processor that initiated the message'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Identifies the message category, drives first level dispatch'
  equity_and_index_last_sale_category:
    seq:
      - id: equity_and_index_last_sale_message_type
        type: u1
        enum: equity_and_index_last_sale_message_type
        doc: 'Equity And Index Last Sale message type'
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
            'equity_and_index_last_sale_message_type::isoi': equity_and_index_last_sale_message
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
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'The Security Symbol Is Used For Equity And Index Options It Identifies The Unique Symbol Assigned To The Underlying Security Left Justified Space Filled'
      - id: reserved_1
        type: u1
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: s4
        doc: 'The Strike Price Of The Option Series'
      - id: volume
        type: u4
        doc: 'Number Of Contracts Traded'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Premium Price Field'
      - id: premium_price
        type: s4
        doc: 'Premium Price Of The Option'
      - id: trade_identifier
        type: u4
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
      - id: reserved_4
        type: u4
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
  expiration_block:
    seq:
      - id: expiration_month
        type: u1
        enum: expiration_month
        doc: 'Expiration Month Identifying Call Or Put'
      - id: expiration_day
        type: u1
        doc: 'Day Of The Month The Series Expires Hex 0 X 01 To 0 X 1f'
      - id: expiration_year
        type: u1
        doc: 'Year Starting With Year 2000 Hex 0 X 00 To 0 X 63'
  equity_and_index_end_of_day_summary_category:
    seq:
      - id: equity_and_index_end_of_day_summary_message_type
        type: u1
        enum: equity_and_index_end_of_day_summary_message_type
        doc: 'Equity And Index End Of Day Summary message type'
      - id: equity_and_index_end_of_day_summary_message_payload
        type:
          switch-on: equity_and_index_end_of_day_summary_message_type.to_i
          cases:
            _: equity_and_index_end_of_day_summary_message
  equity_and_index_end_of_day_summary_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'The Security Symbol Is Used For Equity And Index Options It Identifies The Unique Symbol Assigned To The Underlying Security Left Justified Space Filled'
      - id: reserved_1
        type: u1
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: s4
        doc: 'The Strike Price Of The Option Series'
      - id: volume
        type: u4
        doc: 'Number Of Contracts Traded'
      - id: open_interest_volume
        type: u4
        doc: 'Total Open Option Contracts'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Premium Price Field'
      - id: open_price
        type: s4
        doc: 'Opening Price For The Day'
      - id: high_price
        type: s4
        doc: 'Highest Price Paid During The Day'
      - id: low_price
        type: s4
        doc: 'Lowest Price Paid During The Day'
      - id: last_price
        type: s4
        doc: 'Last Price Paid During The Day'
      - id: net_change
        type: s4
        doc: 'Change From Previous Day Close'
      - id: underlying_price_denominator_code
        type: u1
        enum: underlying_price_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Underlying Price Field'
      - id: underlying_price
        type: s8
        doc: 'Price Of The Underlying Security'
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
        doc: 'Long Equity And Index Quote message type'
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
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'The Security Symbol Is Used For Equity And Index Options It Identifies The Unique Symbol Assigned To The Underlying Security Left Justified Space Filled'
      - id: reserved_1
        type: u1
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Strike Price Field'
      - id: strike_price
        type: s4
        doc: 'The Strike Price Of The Option Series'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Premium Price Field'
      - id: bid_price
        type: s4
        doc: 'Represents The Price At Which A Buyer Is Willing To Buy An Option'
      - id: bid_size
        type: u4
        doc: 'Number Of Contracts At The Bid Price'
      - id: offer_price
        type: s4
        doc: 'Represents The Price At Which A Seller Is Offering To Sell An Option'
      - id: offer_size
        type: u4
        doc: 'Number Of Contracts At The Offer Price'
  short_equity_and_index_quote_category:
    seq:
      - id: short_equity_and_index_quote_message_type
        type: u1
        enum: short_equity_and_index_quote_message_type
        doc: 'Short Equity And Index Quote message type'
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
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: security_symbol_short
        type: str
        size: 4
        encoding: ASCII
        doc: 'Security Symbol Restricted To Four Characters For Short Quote Messages Category Q Left Justified Space Filled'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_short
        type: u2
        doc: 'The Strike Price Of The Option Series With Implied Denominator Code A Short Quote Variant'
      - id: bid_price_short
        type: u2
        doc: 'Bid Price With Implied Premium Denominator Code B Short Quote Variant'
      - id: bid_size_short
        type: u2
        doc: 'Number Of Contracts At The Bid Price Short Quote Variant'
      - id: offer_price_short
        type: u2
        doc: 'Offer Price With Implied Premium Denominator Code B Short Quote Variant'
      - id: offer_size_short
        type: u2
        doc: 'Number Of Contracts At The Offer Price Short Quote Variant'
  administrative_category:
    seq:
      - id: administrative_message_type
        type: u1
        enum: administrative_message_type
        doc: 'Administrative message type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type.to_i
          cases:
            _: administrative_message
  administrative_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: message_data_length
        type: u2
        doc: 'Length Of The Message Data Field Can Be Zero'
      - id: message_data
        type: str
        size: message_data_length
        encoding: ASCII
        if: message_data_length > 0
        doc: 'Variable Length Printable Ascii Text Up To 200 Characters'
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
            'control_message_type::line_integrity': control_message
  control_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
  sequence_number_status_category:
    seq:
      - id: sequence_number_status_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Sequence Number Status message type'
      - id: sequence_number_status_message_payload
        type:
          switch-on: sequence_number_status_message_type
          cases:
            '"L"': block_sequence_number_status_inquiry_request_message
            '"M"': block_sequence_number_status_response_message
            '"R"': message_count_status_inquiry_request_message
            '"S"': message_count_status_response_message
  block_sequence_number_status_inquiry_request_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: reserved_4
        type: u4
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
      - id: second_reserved_4
        type: u4
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
  block_sequence_number_status_response_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: block_sequence_number
        type: u4
        doc: 'Last Block Sequence Number Received On The Input Line'
      - id: reserved_4
        type: u4
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
  message_count_status_inquiry_request_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: reserved_8
        type: u8
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
  message_count_status_response_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: message_count
        type: u8
        doc: 'Count Of Messages Received On The Line Since Startup'
  underlying_value_message_category:
    seq:
      - id: underlying_value_message_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Underlying Value Message message type'
      - id: underlying_value_message_message_payload
        type:
          switch-on: underlying_value_message_message_type
          cases:
            '"I"': underlying_value_bid_and_offer_message
            _: underlying_value_last_sale_message
  underlying_value_last_sale_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'The Security Symbol Is Used For Equity And Index Options It Identifies The Unique Symbol Assigned To The Underlying Security Left Justified Space Filled'
      - id: reserved_1
        type: u1
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
      - id: index_value_denominator_code
        type: u1
        enum: index_value_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Index Value Field'
      - id: index_value
        type: s4
        doc: 'Last Sale Index Value'
      - id: reserved_4
        type: u4
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
  underlying_value_bid_and_offer_message:
    seq:
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'Session Indicator Value On Messages From Participant To Opra 0 X 00 For Regular Trading Session 0 X 01 To 0 X 05 For Pre Market Trading Session Global Trading Hours'
      - id: participant_reference_number
        type: u4
        doc: 'Optional Reference Number For Use By The Participant Does Not Need To Be Unique On A Per Security Basis'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        doc: 'The Security Symbol Is Used For Equity And Index Options It Identifies The Unique Symbol Assigned To The Underlying Security Left Justified Space Filled'
      - id: reserved_1
        type: u1
        doc: 'Reserved For Future Use Filled With Hex 0 X 00'
      - id: index_value_denominator_code
        type: u1
        enum: index_value_denominator_code
        doc: 'Indicates The Position Of The Floating Decimal Point Within The Index Value Field'
      - id: bid_index_value
        type: s4
        doc: 'Index Value Using Current Bid Values Of Component Securities'
      - id: offer_index_value
        type: s4
        doc: 'Index Value Using Current Offer Values Of Component Securities'
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
  participant_id:
    0x41:
      id: 'amex'
      doc: 'NYSE American'
    0x42:
      id: 'box_field'
      doc: 'Boston Options Exchange'
    0x43:
      id: 'cboe'
      doc: 'Cboe Options Exchange'
    0x44:
      id: 'emerald'
      doc: 'MIAX Emerald'
    0x45:
      id: 'edgx'
      doc: 'Cboe EDGX Options'
    0x47:
      id: 'mx2'
      doc: 'MX2 Options'
    0x48:
      id: 'gemx'
      doc: 'Nasdaq GEMX'
    0x49:
      id: 'ise'
      doc: 'Nasdaq ISE'
    0x4a:
      id: 'mrx'
      doc: 'Nasdaq MRX'
    0x4d:
      id: 'miax'
      doc: 'Miami International'
    0x4e:
      id: 'nyse'
      doc: 'NYSE ARCA'
    0x4f:
      id: 'opra'
      doc: 'Options Price Reporting'
    0x50:
      id: 'pearl'
      doc: 'MIAX PEARL'
    0x51:
      id: 'nasd'
      doc: 'NASDAQ Options Market'
    0x53:
      id: 'sphr'
      doc: 'MIAX Sapphire'
    0x54:
      id: 'bx'
      doc: 'NASDAQ BX Options'
    0x55:
      id: 'memx'
      doc: 'Members Options Exchange'
    0x56:
      id: 'iex'
      doc: 'IEX Options LLC'
    0x57:
      id: 'c2'
      doc: 'Cboe C2 Options Exchange'
    0x58:
      id: 'phlx'
      doc: 'NASDAQ PHLX'
    0x5a:
      id: 'bats'
      doc: 'Cboe BZX Options'
  message_category:
    0x61:
      id: 'equity_and_index_last_sale'
      doc: 'Equity And Index Last Sale Message Used To Report Equity And Index Options Last Sale Information'
    0x66:
      id: 'equity_and_index_end_of_day_summary'
      doc: 'Equity And Index End Of Day Summary Message Providing Per Symbol Open High Low Last Net Change And Underlying Information'
    0x6b:
      id: 'long_equity_and_index_quote'
      doc: 'Long Equity And Index Quote Message Containing A Full Quote Using Four Byte Integers For Prices And Sizes'
    0x71:
      id: 'short_equity_and_index_quote'
      doc: 'Short Equity And Index Quote Message Containing A Short Quote Using Two Byte Unsigned Integers For Prices And Sizes'
    0x43:
      id: 'administrative'
      doc: 'Administrative Unformatted Message Carrying Free Form Printable Ascii Text Up To 200 Characters'
    0x48:
      id: 'control'
      doc: 'Control Message Performs Specified Control Functions Consists Of Standard Message Header Only'
    0x4e:
      id: 'sequence_number_status'
      doc: 'Sequence Number Status Messages Synchronize Block Sequence Numbers And Retrieve Message Counts'
    0x59:
      id: 'underlying_value_message'
      doc: 'Underlying Value Message Containing Index Values For The Underlying Security'
  equity_and_index_last_sale_message_type:
    0x41:
      id: 'canc'
      doc: 'Canc'
    0x42:
      id: 'oseq'
      doc: 'Oseq'
    0x43:
      id: 'cncl'
      doc: 'Cncl'
    0x44:
      id: 'late'
      doc: 'Late'
    0x45:
      id: 'cnco'
      doc: 'Cnco'
    0x46:
      id: 'open'
      doc: 'Open'
    0x47:
      id: 'cnol'
      doc: 'Cnol'
    0x48:
      id: 'opnl'
      doc: 'Opnl'
    0x49:
      id: 'auto_field'
      doc: 'Auto'
    0x4a:
      id: 'reop'
      doc: 'Reop'
    0x53:
      id: 'isoi'
      doc: 'Isoi'
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
  session_indicator:
    0:
      id: 'regular'
      doc: 'Regular trading session'
    1:
      id: 'gth_monday'
      doc: 'Global Trading Hours session ending on Monday'
    2:
      id: 'gth_tuesday'
      doc: 'Global Trading Hours session ending on Tuesday'
    3:
      id: 'gth_wednesday'
      doc: 'Global Trading Hours session ending on Wednesday'
    4:
      id: 'gth_thursday'
      doc: 'Global Trading Hours session ending on Thursday'
    5:
      id: 'gth_friday'
      doc: 'Global Trading Hours session ending on Friday'
  expiration_month:
    0x41:
      id: 'call_january'
      doc: 'Call January'
    0x42:
      id: 'call_february'
      doc: 'Call February'
    0x43:
      id: 'call_march'
      doc: 'Call March'
    0x44:
      id: 'call_april'
      doc: 'Call April'
    0x45:
      id: 'call_may'
      doc: 'Call May'
    0x46:
      id: 'call_june'
      doc: 'Call June'
    0x47:
      id: 'call_july'
      doc: 'Call July'
    0x48:
      id: 'call_august'
      doc: 'Call August'
    0x49:
      id: 'call_september'
      doc: 'Call September'
    0x4a:
      id: 'call_october'
      doc: 'Call October'
    0x4b:
      id: 'call_november'
      doc: 'Call November'
    0x4c:
      id: 'call_december'
      doc: 'Call December'
    0x4d:
      id: 'put_january'
      doc: 'Put January'
    0x4e:
      id: 'put_february'
      doc: 'Put February'
    0x4f:
      id: 'put_march'
      doc: 'Put March'
    0x50:
      id: 'put_april'
      doc: 'Put April'
    0x51:
      id: 'put_may'
      doc: 'Put May'
    0x52:
      id: 'put_june'
      doc: 'Put June'
    0x53:
      id: 'put_july'
      doc: 'Put July'
    0x54:
      id: 'put_august'
      doc: 'Put August'
    0x55:
      id: 'put_september'
      doc: 'Put September'
    0x56:
      id: 'put_october'
      doc: 'Put October'
    0x57:
      id: 'put_november'
      doc: 'Put November'
    0x58:
      id: 'put_december'
      doc: 'Put December'
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
  equity_and_index_end_of_day_summary_message_type:
    0x20:
      id: 'end_of_day_summary'
      doc: 'End Of Day Summary'
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
  administrative_message_type:
    0x20:
      id: 'administrative'
      doc: 'Administrative'
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
    0x4f:
      id: 'line_integrity'
      doc: 'Line Integrity'
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

