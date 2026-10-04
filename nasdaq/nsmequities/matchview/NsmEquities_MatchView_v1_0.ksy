# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities MatchView AsciiItch v1.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Match View
#   Encoding: Ascii Itch
#   Version: 1.0
#   Date: 12/14/2007
#   Specification: ouchpricingfeed.pdf
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
  id: nasdaq_nsmequities_matchview_asciiitch_v1_0
  title: Nasdaq NsmEquities MatchView AsciiItch v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Match View AsciiItch v1.0'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=DPSpecs_USEquities

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of the multicast session the payload relates to'
      - id: sequence_number
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
      - id: message_count
        type: u2le
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 9
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::best_bid_and_offer_message': best_bid_and_offer_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: timestamp
        type: millisecond_ascii_timestamp
        doc: 'Milliseconds past midnight Eastern the message was generated. Milliseconds since Midnight epoch'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  best_bid_and_offer_message:
    seq:
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Stock Symbol'
      - id: bid_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The price on the bid with 6 whole number places followed by 4 decimal digits. The decimal point is implied by position; it does not appear inside the price field. The price is padded with spaces on the left. Implied decimal with scale 1e-4'
      - id: ask_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The price on the ask with 6 whole number places followed by 4 decimal digits. The decimal point is implied by position; it does not appear inside the price field. The price is padded with spaces on the left. Implied decimal with scale 1e-4'
  millisecond_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      hour:
        value: text.to_i / 3600000 % 24
      minute:
        value: text.to_i / 60000 % 60
      second:
        value: text.to_i / 1000 % 60
      millisecond:
        value: text.to_i % 1000

enums:
  message_type:
    0x55:
      id: 'best_bid_and_offer_message'
      doc: 'Nasdaq''s internal view of the National Best Bid and Offer, used with OUCH to prevent trade-throughs and quote-throughs. For this feed, the only message type is "U".'

