# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseBonds Quote Pdp v1.2.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Quote
#   Encoding: Pdp
#   Version: 1.2.a
#   Date: 03/12/2015
#   Specification: NYSE_Bonds_Quote_Client_Spec.pdf
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
  id: nyse_nysebonds_quote_pdp_v1_2_a
  title: Nyse NyseBonds Quote Pdp v1.2.a
  license: GPL-3.0
  endian: be

doc: 'New York Stock Exchange Nyse Bonds Quote Pdp v1.2.a'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/NYSE_Bonds_Quote_Client_Spec.pdf

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Nyse Pdp message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Nyse Pdp common message header'
      - id: payload
        size: message_header.msg_size - 14
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::sequence_number_reset_message': sequence_number_reset_message
            'msg_type::message_unavailable_message': message_unavailable_message
            'msg_type::refresh_quote_message': refresh_quote_message
            'msg_type::symbol_index_mapping_message': symbol_index_mapping_message
            'msg_type::quote_message': quote_message
  message_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'The size of the message, header and body, in bytes. The value does not account for the MsgSize field size'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'The type of this message'
      - id: msg_seq_num
        type: u4
        doc: 'The message sequence number assigned by Pdp for each product, used for gap detection. Also known as the Line Sequence Number'
      - id: send_time
        type: millisecond_timestamp
        doc: 'The time the message was created by Pdp, in milliseconds since midnight of the same day. Milliseconds since Midnight epoch'
      - id: product_id
        type: u1
        doc: 'The product value in the Pdp header. 117 identifies the Nyse Bonds Quotes feed'
      - id: retrans_flag
        type: u1
        doc: 'Whether this is an original, retransmitted or replayed message. 1 is original, 2 retransmitted, 5 a refresh retransmission'
      - id: num_body_entries
        type: u1
        doc: 'The number of times the message body repeats in the message'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
  sequence_number_reset_message:
    seq:
      - id: next_seq_number
        type: u4le
        doc: 'The sequence number the recipient should expect in the immediately succeeding data packet'
  message_unavailable_message:
    seq:
      - id: begin_seq_num
        type: u4le
        doc: 'The first sequence number that is unavailable'
      - id: end_seq_num
        type: u4le
        doc: 'The last sequence number that is unavailable'
  refresh_quote_message:
    seq:
      - id: symbol_index
        type: u4le
        doc: 'The numerical representation of the symbol'
      - id: source_time
        type: u4le
        doc: 'The quote generation time, in milliseconds since midnight of the same day'
      - id: quote_link_id
        type: u4le
        doc: 'Identifies a unique quote, allowing quotes to be correlated to the last sale. For future use'
      - id: ask_price_numerator
        type: u4le
        doc: 'Ask price for the quote, scaled by the PriceScaleCode'
      - id: ask_size
        type: u4le
        doc: 'Size of the quote on the ask side, in shares'
      - id: bid_price_numerator
        type: u4le
        doc: 'Bid price for the quote, scaled by the PriceScaleCode'
      - id: bid_size
        type: u4le
        doc: 'Size of the quote on the bid side, in shares'
      - id: price_scale_code
        type: u1
        doc: 'The power of ten that is the common denominator for the price numerators in this message. A price of 27.56 is a numerator of 2756 with a PriceScaleCode of 2'
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'The originating exchange of the quote'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The security type for this message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'The condition of the quote. Nyse Arca will only send quote condition R'
      - id: flat_pricing
        type: u1
        enum: flat_pricing
        doc: 'Whether flat pricing or interest pricing is in effect'
      - id: trading_action
        type: u1
        enum: trading_action
        doc: 'The current state of trading for this bond'
      - id: filler_ascii_2
        type: str
        size: 2
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'The bond symbol'
      - id: cusip
        type: str
        size: 14
        encoding: ASCII
        doc: 'The bond Cusip'
  symbol_index_mapping_message:
    seq:
      - id: symbol_index
        type: u4le
        doc: 'The numerical representation of the symbol'
      - id: symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'The bond symbol'
      - id: cusip
        type: str
        size: 14
        encoding: ASCII
        doc: 'The bond Cusip'
      - id: filler_ascii_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Reserved for future use'
  quote_message:
    seq:
      - id: symbol_index
        type: u4le
        doc: 'The numerical representation of the symbol'
      - id: source_time
        type: u4le
        doc: 'The quote generation time, in milliseconds since midnight of the same day'
      - id: quote_link_id
        type: u4le
        doc: 'Identifies a unique quote, allowing quotes to be correlated to the last sale. For future use'
      - id: ask_price_numerator
        type: u4le
        doc: 'Ask price for the quote, scaled by the PriceScaleCode'
      - id: ask_size
        type: u4le
        doc: 'Size of the quote on the ask side, in shares'
      - id: bid_price_numerator
        type: u4le
        doc: 'Bid price for the quote, scaled by the PriceScaleCode'
      - id: bid_size
        type: u4le
        doc: 'Size of the quote on the bid side, in shares'
      - id: price_scale_code
        type: u1
        doc: 'The power of ten that is the common denominator for the price numerators in this message. A price of 27.56 is a numerator of 2756 with a PriceScaleCode of 2'
      - id: exchange_id
        type: u1
        enum: exchange_id
        doc: 'The originating exchange of the quote'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The security type for this message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'The condition of the quote. Nyse Arca will only send quote condition R'
      - id: flat_pricing
        type: u1
        enum: flat_pricing
        doc: 'Whether flat pricing or interest pricing is in effect'
      - id: trading_action
        type: u1
        enum: trading_action
        doc: 'The current state of trading for this bond'
      - id: filler_ascii_2
        type: str
        size: 2
        encoding: ASCII
        doc: 'Reserved for future use'
  millisecond_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000

enums:
  msg_type:
    1:
      id: 'sequence_number_reset_message'
      doc: 'Sent to reset the sequence number at start of day and in response to failures. The message carries its own valid sequence number in the header.'
    2:
      id: 'heartbeat_message'
      doc: 'Sent to subscribers connected to the Tcp retransmission server to show the connection is still alive. There is no message body.'
    5:
      id: 'message_unavailable_message'
      doc: 'Sent when the requested messages cannot be retransmitted.'
    23:
      id: 'refresh_quote_message'
      doc: 'Sent in response to a Refresh Quote Request, and automatically when there are intraday symbol additions. The same body as a Quote message with the symbol and Cusip appended.'
    26:
      id: 'symbol_index_mapping_message'
      doc: 'Maps a symbol index to its bond symbol and Cusip.'
    141:
      id: 'quote_message'
      doc: 'The L1 top of book quote for a bond.'
  exchange_id:
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
  security_type:
    0x46:
      id: 'fixed_income_bonds'
      doc: 'Fixed Income Bonds'
  quote_condition:
    0x41:
      id: 'slow_on_ask_side'
      doc: 'Slow On Ask Side'
    0x42:
      id: 'slow_on_bid_side'
      doc: 'Slow On Bid Side'
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x45:
      id: 'slow_on_the_bid_due_to_an_lrp_or_gap_quote'
      doc: 'Slow On The Bid Due To An Lrp Or Gap Quote'
    0x46:
      id: 'slow_on_the_ask_due_to_an_lrp_or_gap_quote'
      doc: 'Slow On The Ask Due To An Lrp Or Gap Quote'
    0x48:
      id: 'slow_on_both_ask_and_bid'
      doc: 'Slow On Both Ask And Bid'
    0x4e:
      id: 'nonfirm_quote'
      doc: 'Nonfirm Quote'
    0x4f:
      id: 'opening_quote'
      doc: 'Opening Quote'
    0x52:
      id: 'regular_quote'
      doc: 'Regular Quote'
    0x55:
      id: 'slow_on_the_bid_and_ask_due_to_an_lrp_or_gap_quote'
      doc: 'Slow On The Bid And Ask Due To An Lrp Or Gap Quote'
    0x57:
      id: 'slow_on_the_bid_and_ask_due_to_a_set_slow_list'
      doc: 'Slow On The Bid And Ask Due To A Set Slow List'
  flat_pricing:
    0x46:
      id: 'flat_pricing_is_in_effect'
      doc: 'Flat Pricing Is In Effect'
  trading_action:
    1:
      id: 'called'
      doc: 'Called'
    2:
      id: 'delisted'
      doc: 'Delisted'
    3:
      id: 'exinterest'
      doc: 'Exinterest'
    4:
      id: 'missed_an_interest_payment'
      doc: 'Missed An Interest Payment'
    5:
      id: 'bankrupt'
      doc: 'Bankrupt'
    6:
      id: 'late_filing'
      doc: 'Late Filing'
    7:
      id: 'below_listing_standards'
      doc: 'Below Listing Standards'
    8:
      id: 'late_filing_and_below_listing_standards'
      doc: 'Late Filing And Below Listing Standards'
    9:
      id: 'bankrupt_and_late_filing'
      doc: 'Bankrupt And Late Filing'
    10:
      id: 'bankrupt_and_below_listing_standards'
      doc: 'Bankrupt And Below Listing Standards'
    11:
      id: 'bankrupt_below_listing_standards_and_late_filing'
      doc: 'Bankrupt Below Listing Standards And Late Filing'

