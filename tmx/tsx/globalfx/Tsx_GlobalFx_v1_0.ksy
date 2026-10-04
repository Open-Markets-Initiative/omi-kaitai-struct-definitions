# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Tsx GlobalFx Gfx v1.0
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Global Fx Feed
#   Encoding: Global Fx
#   Version: 1.0
#   Date: 5/20/2016
#   Specification: TMX Global FX Feed Functional Specifications v1.0.pdf
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
  id: tmx_tsx_globalfx_gfx_v1_0
  title: Tmx Tsx GlobalFx Gfx v1.0
  license: GPL-3.0
  endian: be

doc: 'TMX Group Toronto Stock Exchange Global Fx Feed Gfx v1.0'
doc-ref: https://www.tmx.com/market-data

seq:
  - id: msg_type
    type: str
    size: 1
    encoding: ASCII
    doc: 'Identifies the datagram type'
  - id: datagram_body
    type:
      switch-on: msg_type
      cases:
        '"#"': reference_price_fx_spot

types:
  reference_price_fx_spot:
    seq:
      - id: unused_1
        size: 1
        doc: 'Reserved for future use'
      - id: currency_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Base currency'
      - id: currency_2
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter currency'
      - id: timestamp
        type: microsecond_timestamp
        doc: 'Time in microseconds since Jan 1, 1970. Microseconds since Unix epoch'
      - id: stream_id
        type: u8
        doc: 'Stream Id, which changes when the sequence number resets'
      - id: sequence_number
        type: u4
        doc: 'Sequence Number within this Stream Id'
      - id: valid_for_seconds
        type: u2
        doc: 'Time to live for the prices in this datagram, zero if periodic refresh is not enabled'
      - id: unused_2
        size: 1
        doc: 'Reserved for future use'
      - id: num_size_tier
        type: u1
        doc: 'Number of repeating groups following'
      - id: size_tier
        type: size_tier
        repeat: expr
        repeat-expr: num_size_tier
        doc: 'Bid and offer reference prices at one pre-configured size tier'
  size_tier:
    seq:
      - id: tier_status
        type: u1
        enum: tier_status
        doc: 'Whether a reference price is available at this size tier'
      - id: tier_size
        type: u4
        doc: 'Size Tier, not shifted'
      - id: price_terms
        type: u1
        enum: price_terms
        doc: 'Which currency the Tier Size is in and which way the prices are quoted. The section 3.3 example leaves it zero in every tier, though section 3 states only D and I'
      - id: bid_price
        type: s4
        doc: 'Bid Price mantissa, which Bid Price Exponent scales. Zero for Tier Status Z'
      - id: bid_price_exponent
        type: s1
        doc: 'Power of ten the Bid Price mantissa is multiplied by, for example -5 for 0.00001'
      - id: offer_price
        type: s4
        doc: 'Offer Price mantissa, which Offer Price Exponent scales. Zero for Tier Status Z'
      - id: offer_price_exponent
        type: s1
        doc: 'Power of ten the Offer Price mantissa is multiplied by'
  microsecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000 % 24
      minute:
        value: time / 60000000 % 60
      second:
        value: time / 1000000 % 60
      millisecond:
        value: time / 1000 % 1000
      microsecond:
        value: time % 1000

enums:
  tier_status:
    0x52:
      id: 'valid_reference_price'
      doc: 'Valid reference price'
    0x5a:
      id: 'price_not_available'
      doc: 'Price not available at this size tier'
  price_terms:
    0x44:
      id: 'direct_terms'
      doc: 'Tier Size is in Currency 1 and prices are in units of Currency 2 per Currency 1'
    0x49:
      id: 'inverted_terms'
      doc: 'Tier Size is in Currency 2 and prices are in units of Currency 1 per Currency 2'

