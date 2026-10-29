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
        doc: 'Designates the OPRA binary version'
      - id: block_size
        type: u2
        doc: 'Size in bytes of entire transmission block'
      - id: data_feed_indicator
        type: u1
        enum: data_feed_indicator
        doc: 'Value is ‘O’ for OPRA'
      - id: retransmission_indicator
        type: u1
        enum: retransmission_indicator
        doc: 'Contains either a space; not a retransmitted message or V; indicating a retransmission of the block'
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: '0x00 for regular trading session'
      - id: block_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The number of messages contained in the block data of the transmission block'
      - id: block_timestamp
        type: block_timestamp
        doc: 'Opra packet timestamp. Nanoseconds since Unix epoch'
      - id: block_checksum
        type: u2
        doc: 'Lower 16 bits of the 32 bit sum of all bytes in the block, excluding the Block Checksum field'
  block_timestamp:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Contains the number seconds from epoch 1/1/1970, 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'the nanosecond portion of the time currently rounded to the nearest microsecond. Nanoseconds since Second epoch'
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
        doc: 'ASCII character that identifies the Participant or Processor that initiated the message'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Message identifier'
  administrative_category:
    seq:
      - id: administrative_message_type
        type: u1
        enum: administrative_message_type
        doc: 'Message type'
      - id: administrative_message_payload
        type:
          switch-on: administrative_message_type
          cases:
            'administrative_message_type::administrative': administrative_message
  administrative_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: message_data_length
        type: u2
        doc: 'Represents the length of the Message Data field'
      - id: message_data
        type: str
        size: message_data_length
        encoding: ASCII
        pad-right: 0x20
        if: message_data_length > 0
        doc: 'Represents the Message Data field'
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
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
  equity_and_index_last_sale_category:
    seq:
      - id: equity_and_index_last_sale_message_type
        type: u1
        enum: equity_and_index_last_sale_message_type
        doc: 'Message type'
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
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: reserved_1
        size: 1
        doc: 'One reserved byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code field indicates the position of the floating decimal point within the Strike Price field'
      - id: strike_price
        type: s4
        doc: 'Represents the stated price per share for which the underlying security may be purchased (in the case of a call) or sold (in the case of a put) by the option holder upon exercise of the option contract'
      - id: volume
        type: u4
        doc: 'Represents the total number of contracts traded for an option in one trade, or the total number of contracts traded for an option for the entire trading day'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Represents the first price paid for an option during the trading day'
      - id: premium_price
        type: s4
        doc: 'Represents the price of an option contract, determined in the competitive marketplace, which the buyer of the option pays to the option writer for the rights conveyed by the option contract'
      - id: trade_identifier
        type: u4
        doc: 'FOR FUTURE USE. Filled with Hex 0x00'
      - id: reserved_4
        size: 4
        doc: 'Four reserved bytes'
  expiration_block:
    seq:
      - id: expiration_month
        type: u1
        enum: expiration_month
        doc: 'Indicates the expiration month and identifies the option as a Call or a Put'
      - id: expiration_day
        type: u1
        doc: 'Contains Hex 0x01 to 0x1F (decimal 1 to 31), indicating the day of the month the series expires'
      - id: expiration_year
        type: u1
        doc: 'Contains Hex 0x00 to 0x63 (decimal 0 to 99). Represents the year, starting with year 2000'
  open_interest_category:
    seq:
      - id: open_interest_message_type
        type: u1
        enum: open_interest_message_type
        doc: 'Open Interest Message Type'
      - id: open_interest_message_payload
        type:
          switch-on: open_interest_message_type
          cases:
            'open_interest_message_type::open_interest': open_interest_message
  open_interest_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: reserved_1
        size: 1
        doc: 'One reserved byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code field indicates the position of the floating decimal point within the Strike Price field'
      - id: strike_price
        type: s4
        doc: 'Represents the stated price per share for which the underlying security may be purchased (in the case of a call) or sold (in the case of a put) by the option holder upon exercise of the option contract'
      - id: open_interest_volume
        type: u4
        doc: 'Represents the total number of outstanding option contracts that have not been exercised and have not yet reached expiration'
  equity_and_index_end_of_day_summary_category:
    seq:
      - id: equity_and_index_end_of_day_summary_message_type
        type: u1
        enum: equity_and_index_end_of_day_summary_message_type
        doc: 'Equity and Index End of Day Summary Message Type'
      - id: equity_and_index_end_of_day_summary_message_payload
        type:
          switch-on: equity_and_index_end_of_day_summary_message_type
          cases:
            'equity_and_index_end_of_day_summary_message_type::equity_and_index_end_of_day_summary': equity_and_index_end_of_day_summary_message
  equity_and_index_end_of_day_summary_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: reserved_1
        size: 1
        doc: 'One reserved byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code field indicates the position of the floating decimal point within the Strike Price field'
      - id: strike_price
        type: s4
        doc: 'Represents the stated price per share for which the underlying security may be purchased (in the case of a call) or sold (in the case of a put) by the option holder upon exercise of the option contract'
      - id: volume
        type: u4
        doc: 'Represents the total number of contracts traded for an option in one trade, or the total number of contracts traded for an option for the entire trading day'
      - id: open_interest_volume
        type: u4
        doc: 'Represents the total number of outstanding option contracts that have not been exercised and have not yet reached expiration'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Represents the first price paid for an option during the trading day'
      - id: open_price
        type: s4
        doc: 'Represents the first price paid for an option during the trading day'
      - id: high_price
        type: s4
        doc: 'Represents the highest price paid for an option during the trading day'
      - id: low_price
        type: s4
        doc: 'Represents the lowest price paid for an option during the trading day'
      - id: last_price
        type: s4
        doc: 'Represents the last price paid for an option during the trading day'
      - id: net_change
        type: s4
        doc: 'Represents the change in the price of an option from the closing price of one day to the closing price on the next day on which the option is traded'
      - id: underlying_price_denominator_code
        type: u1
        enum: underlying_price_denominator_code
        doc: 'The Underlying Price Denominator Code field indicates the position of the floating decimal point within the Underlying Price field'
      - id: underlying_price
        type: s8
        doc: 'Represents the price of the underlying security'
      - id: bid_price
        type: s4
        doc: 'Represents the price at which a buyer is willing to buy an option'
      - id: offer_price
        type: s4
        doc: 'Represents the price at which a seller is offering to sell an option'
  long_equity_and_index_quote_category:
    seq:
      - id: long_equity_and_index_quote_message_type
        type: u1
        enum: long_equity_and_index_quote_message_type
        doc: 'Long Equity and Index Quote Message Type'
      - id: long_equity_and_index_quote_message_payload
        type:
          switch-on: long_equity_and_index_quote_message_type
          cases:
            'long_equity_and_index_quote_message_type::regular_trading': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::non_firm_quote': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::indicative_value': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::rotation': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::trading_halted': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::eligible_for_automatic_execution': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::bid_contains_customer_trading_interest': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::offer_contains_customer_trading_interest': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::both_bid_and_offer_contain_customer_trading_interest': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::offer_side_of_quote_not_firm_bid_side_firm': long_equity_and_index_quote_message
            'long_equity_and_index_quote_message_type::bid_side_of_quote_not_firm_offer_side_firm': long_equity_and_index_quote_message
  long_equity_and_index_quote_message:
    seq:
      - id: bbo_indicator
        type: u1
        enum: bbo_indicator
        doc: 'Indicates the effect the new quote has on the Best Bid and/or the Best Offer'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: reserved_1
        size: 1
        doc: 'One reserved byte'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code field indicates the position of the floating decimal point within the Strike Price field'
      - id: strike_price
        type: s4
        doc: 'Represents the stated price per share for which the underlying security may be purchased (in the case of a call) or sold (in the case of a put) by the option holder upon exercise of the option contract'
      - id: premium_price_denominator_code
        type: u1
        enum: premium_price_denominator_code
        doc: 'Represents the first price paid for an option during the trading day'
      - id: bid_price
        type: s4
        doc: 'Represents the price at which a buyer is willing to buy an option'
      - id: bid_size
        type: u4
        doc: 'The Bid Size identifies the number of contracts being bought for an option at the Bid Price'
      - id: offer_price
        type: s4
        doc: 'Represents the price at which a seller is offering to sell an option'
      - id: offer_size
        type: u4
        doc: 'The Offer Size identifies the number of contracts for sale for an option at the Offer Price'
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
        doc: 'Identifies the participant that entered the Best Bid'
      - id: best_bid_denominator_code
        type: u1
        enum: best_bid_denominator_code
        doc: 'The Bed Bid Denominator Code field indicates the position of the floating decimal point within the Best Bid Price field'
      - id: best_bid_price
        type: s4
        doc: 'Represents the best price at which a buyer is willing to buy an option'
      - id: best_bid_size
        type: u4
        doc: 'The Best Bid Size identifies the number of contracts being bought for an option at the Best Bid price'
  best_offer_appendage:
    seq:
      - id: best_offer_participant_id
        type: u1
        enum: best_offer_participant_id
        doc: 'Identifies the participant that entered the Best Bid'
      - id: best_offer_denominator_code
        type: u1
        enum: best_offer_denominator_code
        doc: 'The Bed OFFER Denominator Code field indicates the position of the floating decimal point within the Best Offer Price field'
      - id: best_offer_price
        type: s4
        doc: 'Represents the best price at which a seller is offering to sell an option'
      - id: best_offer_size
        type: u4
        doc: 'The Best Offer Size identifies the number of contracts being bought for an option at the Best Offer price'
  best_bid_and_offer_appendage:
    seq:
      - id: best_bid_participant_id
        type: u1
        enum: best_bid_participant_id
        doc: 'Identifies the participant that entered the Best Bid'
      - id: best_bid_denominator_code
        type: u1
        enum: best_bid_denominator_code
        doc: 'The Bed Bid Denominator Code field indicates the position of the floating decimal point within the Best Bid Price field'
      - id: best_bid_price
        type: s4
        doc: 'Represents the best price at which a buyer is willing to buy an option'
      - id: best_bid_size
        type: u4
        doc: 'The Best Bid Size identifies the number of contracts being bought for an option at the Best Bid price'
      - id: best_offer_participant_id
        type: u1
        enum: best_offer_participant_id
        doc: 'Identifies the participant that entered the Best Bid'
      - id: best_offer_denominator_code
        type: u1
        enum: best_offer_denominator_code
        doc: 'The Bed OFFER Denominator Code field indicates the position of the floating decimal point within the Best Offer Price field'
      - id: best_offer_price
        type: s4
        doc: 'Represents the best price at which a seller is offering to sell an option'
      - id: best_offer_size
        type: u4
        doc: 'The Best Offer Size identifies the number of contracts being bought for an option at the Best Offer price'
  short_equity_and_index_quote_category:
    seq:
      - id: short_equity_and_index_quote_message_type
        type: u1
        enum: short_equity_and_index_quote_message_type
        doc: 'Short Equity and Index Quote Message Type'
      - id: short_equity_and_index_quote_message_payload
        type:
          switch-on: short_equity_and_index_quote_message_type
          cases:
            'short_equity_and_index_quote_message_type::regular_trading': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::non_firm_quote': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::indicative_value': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::rotation': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::trading_halted': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::eligible_for_automatic_execution': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::bid_contains_customer_trading_interest': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::offer_contains_customer_trading_interest': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::both_bid_and_offer_contain_customer_trading_interest': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::offer_side_of_quote_not_firm_bid_side_firm': short_equity_and_index_quote_message
            'short_equity_and_index_quote_message_type::bid_side_of_quote_not_firm_offer_side_firm': short_equity_and_index_quote_message
  short_equity_and_index_quote_message:
    seq:
      - id: bbo_indicator
        type: u1
        enum: bbo_indicator
        doc: 'Indicates the effect the new quote has on the Best Bid and/or the Best Offer'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol_short
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_short
        type: decimal_u2_1
        doc: 'Represents the stated price per share for which the underlying security may be purchased (in the case of a call) or sold (in the case of a put) by the option holder upon exercise of the option contract. Implied decimal with scale 1e-1'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Represents the price at which a buyer is willing to buy an option. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'The Bid Size identifies the number of contracts being bought for an option at the Bid Price'
      - id: offer_price_short
        type: decimal_u2_2
        doc: 'Represents the price at which a seller is offering to sell an option. Implied decimal with scale 1e-2'
      - id: offer_size_short
        type: u2
        doc: 'The Offer Size identifies the number of contracts for sale for an option at the Offer Price'
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
          switch-on: series_mapping_message_type
          cases:
            'series_mapping_message_type::series_mapping': series_mapping_message
  series_mapping_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: expiration_block
        type: expiration_block
        doc: 'Expiration Block'
      - id: strike_price_denominator_code
        type: u1
        enum: strike_price_denominator_code
        doc: 'The Strike Price Denominator Code field indicates the position of the floating decimal point within the Strike Price field'
      - id: strike_price
        type: s4
        doc: 'Represents the stated price per share for which the underlying security may be purchased (in the case of a call) or sold (in the case of a put) by the option holder upon exercise of the option contract'
      - id: multicast_line_number
        type: u2
        doc: 'Multicast Line Number assigned to the option series (values between 1 and 96)'
      - id: reserved_128
        size: 128
        doc: 'One hundred twenty-eight reserved bytes'
  underlying_value_category:
    seq:
      - id: underlying_value_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Underlying Value Message type'
      - id: underlying_value_message_payload
        type:
          switch-on: underlying_value_message_type
          cases:
            '" "': underlying_value_last_sale_message
            '"I"': underlying_value_bid_and_offer_message
  underlying_value_last_sale_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: reserved_1
        size: 1
        doc: 'One reserved byte'
      - id: index_value_denominator_code
        type: u1
        enum: index_value_denominator_code
        doc: 'Contains the index value using last sale values of index components'
      - id: index_value
        type: s4
        doc: 'Contains the index value using last sale values of index components'
      - id: reserved_4
        size: 4
        doc: 'Four reserved bytes'
  underlying_value_bid_and_offer_message:
    seq:
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the unique symbol assigned to the underlying security'
      - id: reserved_1
        size: 1
        doc: 'One reserved byte'
      - id: index_value_denominator_code
        type: u1
        enum: index_value_denominator_code
        doc: 'Contains the index value using last sale values of index components'
      - id: bid_index_value
        type: s4
        doc: 'The Bid Index Value represents the value of the index’s calculation formula using the current bid values of the component securities'
      - id: offer_index_value
        type: s8
        doc: 'The Offer Index Value represents the value of the index’s calculation formula using the current Offer values of the component securities'
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
  decimal_u2_1:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 10.0
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0

enums:
  data_feed_indicator:
    0x4f:
      id: 'opra'
      doc: 'Opra'
  retransmission_indicator:
    0x20:
      id: 'not_retransmitted'
      doc: 'Not a retransmitted message'
    0x56:
      id: 'retransmitted'
      doc: 'Retransmission of the block'
  session_indicator:
    0:
      id: 'regular'
      doc: 'Regular Trading Session'
    1:
      id: 'sunday_into_monday'
      doc: 'Global Trading Hours session: Sunday into Monday'
    2:
      id: 'monday_into_tuesday'
      doc: 'Global Trading Hours session: Monday into Tuesday'
    3:
      id: 'tuesday_into_wednesday'
      doc: 'Global Trading Hours session: Tuesday into Wednesday'
    4:
      id: 'wednesday_into_thursday'
      doc: 'Global Trading Hours session: Wednesday into Thursday'
    5:
      id: 'thursday_into_friday'
      doc: 'Global Trading Hours session: Thursday into Friday'
    0x58:
      id: 'generated_by_opra'
      doc: 'ASCII ''X'' (hex 0x58) on any messages generated by OPRA during GTH, e.g. Control (Category H) messages or OPRA-generated Zero Quotes'
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
      doc: 'Cboe EDGX Options Exchange'
    0x47:
      id: 'mx_2'
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
      doc: 'Miami International Securities Exchange'
    0x4e:
      id: 'nyse'
      doc: 'NYSE ARCA'
    0x4f:
      id: 'opra'
      doc: 'Options Price Reporting Authority'
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
      id: 'c_2'
      doc: 'Cboe C2 Options Exchange'
    0x58:
      id: 'phlx'
      doc: 'NASDAQ PHLX'
    0x5a:
      id: 'bats'
      doc: 'Cboe BZX Options Exchange'
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
      doc: 'Underlying Value Message Sub Dispatch Handled At The Category Message Type Low Byte Level'
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
      doc: 'Transaction previously reported (other than as the last or opening report for the particular option contract) is now to be cancelled.'
    0x42:
      id: 'oseq'
      doc: 'Transaction is being reported late and is out of sequence; i.e., later transactions have been reported for the particular option contract.'
    0x43:
      id: 'cncl'
      doc: 'Transaction is the last reported for the particular option contract and is now cancelled.'
    0x44:
      id: 'late'
      doc: 'Transaction is being reported late, but is in the correct sequence; i.e., no later transactions have been reported for the particular option contract.'
    0x45:
      id: 'cnco'
      doc: 'Transaction was the first one (opening) reported this day for the particular option contract. Although later transactions have been reported, this transaction is now to be cancelled.'
    0x46:
      id: 'open'
      doc: 'Transaction is a late report of the opening trade and is out of sequence; i.e., other transactions have been reported for the particular option contract.'
    0x47:
      id: 'cnol'
      doc: 'Transaction was the only one reported this day for the particular option contract and is now to be cancelled.'
    0x48:
      id: 'opnl'
      doc: 'Transaction is a late report of the opening trade, but is in the correct sequence; i.e., no other transactions have been reported for the particular option contract.'
    0x49:
      id: 'auto_field'
      doc: 'Transaction was executed electronically. Prefix appears solely for information; process as a regular transaction.'
    0x4a:
      id: 'reop'
      doc: 'Transaction is a reopening of an option contract in which trading has been previously halted. Prefix appears solely for information; process as a regular transaction.'
    0x4b:
      id: 'ajst'
      doc: 'Transaction is an option contract for which the terms have been adjusted to reflect a stock dividend, stock split, or similar event. Prefix appears solely for information; process as a regular transaction.'
    0x4c:
      id: 'sprd'
      doc: 'Transaction represents a trade in two options in the same class (a buy and a sell in the same class). Prefix appears solely for information; process as a regular transaction.'
    0x4d:
      id: 'stdl'
      doc: 'Transaction represents a trade in two options in the same class (a buy and a sell in a put and a call). Prefix appears solely for information; process as a regular transaction.'
    0x4e:
      id: 'stpd'
      doc: 'Transaction is the execution of a sale at a price agreed upon by the floor personnel involved, where a condition of the trade is that it reported following a non-stopped trade of the same series at the same price.'
    0x4f:
      id: 'cstp'
      doc: 'Cancel stopped transaction.'
    0x50:
      id: 'bwrt'
      doc: 'Transaction represents the option portion of an order involving a single option leg (buy or sell of a call or put) and stock. Prefix appears solely for information: process as a regular transaction.'
    0x51:
      id: 'cmbo'
      doc: 'Transaction represents the buying of a call and the selling of a put for the same underlying stock or index. Prefix appears solely for information; process as a regular transaction.'
    0x52:
      id: 'spim'
      doc: 'Transaction was the execution of an order which was "stopped" at a price that did not constitute a Trade-Through on another market at the time of the stop. Process like a normal transaction.'
    0x53:
      id: 'isoi'
      doc: 'Transaction was the execution of an order identified as an Intermarket Sweep Order. Process like normal transaction.'
    0x54:
      id: 'bnmt'
      doc: 'Transaction reflects the execution of a "benchmark trade". A "Benchmark Trade" is a trade resulting from the matching of "Benchmark Orders". A "Benchmark Order" is an order for which the price is not based, directly or indirectly, on the quote price of the option at the time of the order''s execution and for which the material terms were not reasonably determinable at the time a commitment to trade the order was made. Process like a normal transaction except don''t update "last".'
    0x58:
      id: 'xmpt'
      doc: 'Transaction is Trade Through Exempt. The transaction should be treated like a regular sale.'
    0x61:
      id: 'slan'
      doc: 'SLAN'
    0x62:
      id: 'slai'
      doc: 'SLAI'
    0x63:
      id: 'slcn'
      doc: 'SLCN'
    0x64:
      id: 'scli'
      doc: 'SCLI'
    0x65:
      id: 'slft'
      doc: 'SLFT'
    0x66:
      id: 'mlet'
      doc: 'MLET'
    0x67:
      id: 'mlat'
      doc: 'MLAT'
    0x68:
      id: 'mlct'
      doc: 'MLCT'
    0x69:
      id: 'mlft'
      doc: 'MLFT'
    0x6a:
      id: 'mesl'
      doc: 'MESL'
    0x6b:
      id: 'tlat'
      doc: 'TLAT'
    0x6c:
      id: 'masl'
      doc: 'MASL'
    0x6d:
      id: 'mfsl'
      doc: 'MFSL'
    0x6e:
      id: 'tlet'
      doc: 'TLET'
    0x6f:
      id: 'tlct'
      doc: 'TLCT'
    0x70:
      id: 'tlft'
      doc: 'TLFT'
    0x71:
      id: 'tesl'
      doc: 'TESL'
    0x72:
      id: 'tasl'
      doc: 'TASL'
    0x73:
      id: 'tfsl'
      doc: 'TFSL'
    0x74:
      id: 'cbmo'
      doc: 'CBMO'
    0x75:
      id: 'mctp'
      doc: 'MCTP'
    0x76:
      id: 'exht'
      doc: 'EXHT'
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
      doc: '1,000'
    0x44:
      id: 'ten_thousand'
      doc: '10,000'
    0x45:
      id: 'hundred_thousand'
      doc: '100,000'
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
      doc: '1,000'
    0x44:
      id: 'ten_thousand'
      doc: '10,000'
    0x45:
      id: 'hundred_thousand'
      doc: '100,000'
    0x46:
      id: 'million'
      doc: '1,000,000'
    0x47:
      id: 'ten_million'
      doc: '10,000,000'
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
      doc: 'Equity and Index End of Day Summary Message'
  underlying_price_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1,000'
    0x44:
      id: 'ten_thousand'
      doc: '10,000'
    0x45:
      id: 'hundred_thousand'
      doc: '100,000'
    0x46:
      id: 'million'
      doc: '1,000,000'
    0x47:
      id: 'ten_million'
      doc: '10,000,000'
    0x48:
      id: 'hundred_million'
      doc: '100,000,000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  long_equity_and_index_quote_message_type:
    0x20:
      id: 'regular_trading'
      doc: 'Regular Trading'
    0x46:
      id: 'non_firm_quote'
      doc: 'Non-Firm Quote'
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
      doc: 'Eligible for Automatic Execution'
    0x42:
      id: 'bid_contains_customer_trading_interest'
      doc: 'Bid contains Customer Trading Interest'
    0x4f:
      id: 'offer_contains_customer_trading_interest'
      doc: 'Offer contains Customer Trading Interest'
    0x43:
      id: 'both_bid_and_offer_contain_customer_trading_interest'
      doc: 'Both Bid and Offer contain Customer Trading Interest'
    0x58:
      id: 'offer_side_of_quote_not_firm_bid_side_firm'
      doc: 'Offer side of Quote Not Firm; Bid Side Firm'
    0x59:
      id: 'bid_side_of_quote_not_firm_offer_side_firm'
      doc: 'Bid Side of Quote Not Firm; Offer Side Firm'
  bbo_indicator:
    0x41:
      id: 'no_best_bid_change_or_best_offer_change'
      doc: 'No Best Bid change Or Best Offer change'
    0x42:
      id: 'no_best_bid_change_quote_contains_best_offer'
      doc: 'No Best Bid change Quote contains Best Offer'
    0x43:
      id: 'no_best_bid_change_best_offer_appendage'
      doc: 'No Best Bid Change Best Offer Appendage'
    0x44:
      id: 'no_best_bid_change_no_best_offer'
      doc: 'No Best Bid Change No Best Offer'
    0x45:
      id: 'quote_contains_best_bid_no_best_offer_change'
      doc: 'Quote contains Best Bid, No Best Offer Change'
    0x46:
      id: 'quote_contains_best_bid_quote_contains_best_offer'
      doc: 'Quote contains Best Bid, Quote contains Best Offer'
    0x47:
      id: 'quote_contains_best_bid_best_offer_appendage'
      doc: 'Quote contains Best Bid, Best Offer Appendage'
    0x48:
      id: 'quote_contains_best_bid_no_best_offer'
      doc: 'Quote contains Best Bid, No Best Offer'
    0x49:
      id: 'no_best_bid_no_best_offer_change'
      doc: 'No Best Bid, No Best Offer Change'
    0x4a:
      id: 'no_best_bid_quote_contains_best_offer'
      doc: 'No Best Bid, Quote contains Best Offer'
    0x4b:
      id: 'no_best_bid_best_offer_appendage'
      doc: 'No Best Bid, Best Offer Appendage'
    0x4c:
      id: 'no_best_bid_no_best_offer'
      doc: 'No Best Bid, No Best Offer'
    0x4d:
      id: 'best_bid_appendage_no_best_offer_change'
      doc: 'Best Bid Appendage, No Best Offer Change'
    0x4e:
      id: 'best_bid_appendage_quote_contains_best_offer'
      doc: 'Best Bid Appendage, Quote contains Best Offer'
    0x4f:
      id: 'best_bid_appendage_best_offer_appendage'
      doc: 'Best Bid Appendage, Best Offer Appendage'
    0x50:
      id: 'best_bid_appendage_no_best_offer'
      doc: 'Best Bid Appendage, No Best Offer'
    0x20:
      id: 'not_included_in_the_bbo'
      doc: 'not included in the BBO'
  best_bid_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x42:
      id: 'boston_options_exchange'
      doc: 'Boston Options Exchange'
    0x43:
      id: 'cboe_options_exchange'
      doc: 'Cboe Options Exchange'
    0x44:
      id: 'miax_emerald'
      doc: 'MIAX EMERALD'
    0x45:
      id: 'cboe_edgx_options'
      doc: 'Cboe EDGX Options'
    0x47:
      id: 'mx_2_options'
      doc: 'MX2 Options'
    0x48:
      id: 'nasdaq_gemx'
      doc: 'Nasdaq GEMX'
    0x49:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'nasdaq_mrx'
      doc: 'Nasdaq MRX'
    0x4d:
      id: 'miami_international_securities_exchange'
      doc: 'Miami International Securities Exchange'
    0x4e:
      id: 'nyse_arca'
      doc: 'NYSE ARCA'
    0x4f:
      id: 'options_price_reporting_authority'
      doc: 'Options Price Reporting Authority'
    0x50:
      id: 'miax_pearl'
      doc: 'MIAX PEARL'
    0x51:
      id: 'nasdaq_options_market'
      doc: 'NASDAQ Options Market'
    0x54:
      id: 'nasdaq_bx_options'
      doc: 'NASDAQ BX Options'
    0x56:
      id: 'iex_options_llc'
      doc: 'IEX Options LLC'
    0x57:
      id: 'cboe_c_2_options'
      doc: 'Cboe C2 Options'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'NASDAQ PHLX'
    0x5a:
      id: 'cboe_bzx_options_exchange'
      doc: 'Cboe BZX Options Exchange'
  best_bid_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1,000'
    0x44:
      id: 'ten_thousand'
      doc: '10,000'
    0x45:
      id: 'hundred_thousand'
      doc: '100,000'
    0x46:
      id: 'million'
      doc: '1,000,000'
    0x47:
      id: 'ten_million'
      doc: '10,000,000'
    0x48:
      id: 'hundred_million'
      doc: '100,000,000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  best_offer_participant_id:
    0x41:
      id: 'nyse_american'
      doc: 'NYSE American'
    0x42:
      id: 'boston_options_exchange'
      doc: 'Boston Options Exchange'
    0x43:
      id: 'cboe_options_exchange'
      doc: 'Cboe Options Exchange'
    0x44:
      id: 'miax_emerald'
      doc: 'MIAX EMERALD'
    0x45:
      id: 'cboe_edgx_options'
      doc: 'Cboe EDGX Options'
    0x47:
      id: 'mx_2_options'
      doc: 'MX2 Options'
    0x48:
      id: 'nasdaq_gemx'
      doc: 'Nasdaq GEMX'
    0x49:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'nasdaq_mrx'
      doc: 'Nasdaq MRX'
    0x4d:
      id: 'miami_international_securities_exchange'
      doc: 'Miami International Securities Exchange'
    0x4e:
      id: 'nyse_arca'
      doc: 'NYSE ARCA'
    0x4f:
      id: 'options_price_reporting_authority'
      doc: 'Options Price Reporting Authority'
    0x50:
      id: 'miax_pearl'
      doc: 'MIAX PEARL'
    0x51:
      id: 'nasdaq_options_market'
      doc: 'NASDAQ Options Market'
    0x54:
      id: 'nasdaq_bx_options'
      doc: 'NASDAQ BX Options'
    0x56:
      id: 'iex_options_llc'
      doc: 'IEX Options LLC'
    0x57:
      id: 'cboe_c_2_options'
      doc: 'Cboe C2 Options'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'NASDAQ PHLX'
    0x5a:
      id: 'cboe_bzx_options_exchange'
      doc: 'Cboe BZX Options Exchange'
  best_offer_denominator_code:
    0x41:
      id: 'ten'
      doc: '10'
    0x42:
      id: 'hundred'
      doc: '100'
    0x43:
      id: 'thousand'
      doc: '1,000'
    0x44:
      id: 'ten_thousand'
      doc: '10,000'
    0x45:
      id: 'hundred_thousand'
      doc: '100,000'
    0x46:
      id: 'million'
      doc: '1,000,000'
    0x47:
      id: 'ten_million'
      doc: '10,000,000'
    0x48:
      id: 'hundred_million'
      doc: '100,000,000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'
  short_equity_and_index_quote_message_type:
    0x20:
      id: 'regular_trading'
      doc: 'Regular Trading'
    0x46:
      id: 'non_firm_quote'
      doc: 'Non-Firm Quote'
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
      doc: 'Eligible for Automatic Execution'
    0x42:
      id: 'bid_contains_customer_trading_interest'
      doc: 'Bid contains Customer Trading Interest'
    0x4f:
      id: 'offer_contains_customer_trading_interest'
      doc: 'Offer contains Customer Trading Interest'
    0x43:
      id: 'both_bid_and_offer_contain_customer_trading_interest'
      doc: 'Both Bid and Offer contain Customer Trading Interest'
    0x58:
      id: 'offer_side_of_quote_not_firm_bid_side_firm'
      doc: 'Offer side of Quote Not Firm; Bid Side Firm'
    0x59:
      id: 'bid_side_of_quote_not_firm_offer_side_firm'
      doc: 'Bid Side of Quote Not Firm; Offer Side Firm'
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
      doc: '1,000'
    0x44:
      id: 'ten_thousand'
      doc: '10,000'
    0x45:
      id: 'hundred_thousand'
      doc: '100,000'
    0x46:
      id: 'million'
      doc: '1,000,000'
    0x47:
      id: 'ten_million'
      doc: '10,000,000'
    0x49:
      id: 'no_fraction'
      doc: 'No Fraction'

