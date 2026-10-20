# ---------------------------------------------------------------------
# Kaitai struct definition for: Athex AthexSecurities Relaxed Ids v5.2
#
# Protocol:
#   Organization: Athens Exchange Group
#   Protocol: Athens Exchange Securities Market Relaxed Channel
#   Encoding: Information Dissemination System
#   Version: 5.2
#   Date: 11/01/2019
#   Specification: ATHEX OASIS IDS Market Data Feed Specification (5.2).pdf
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
  id: athex_athexsecurities_relaxed_ids_v5_2
  title: Athex AthexSecurities Relaxed Ids v5.2
  license: GPL-3.0
  endian: be

doc: 'Athens Exchange Group Athens Exchange Securities Market Athens Exchange Securities Market Relaxed Channel Ids v5.2'
doc-ref: https://www.athexgroup.gr/en/trade/trading-system

seq:
  - id: soh
    type: u1
    doc: 'First character of every message packet, signalling the beginning of the packet'
  - id: message_header
    type: message_header_struct
    doc: 'Thirty five character header succeeding the Soh character of every message packet'
  - id: message_text
    type:
      switch-on: message_header.message_category
      cases:
        'message_category::apa_post_trade_message': apa_post_trade_message
        'message_category::apa_pre_trade_message': apa_pre_trade_message
  - id: etx
    type: u1
    doc: 'Signals the end of the packet''s text'
  - id: lrc
    type: u1
    doc: 'Longitudinal Redundancy Check character signalling the packet''s end, the exclusive or of all message bytes from the header up to and including the Etx'

types:
  message_header_struct:
    seq:
      - id: vendor_identifier
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Data Vendor the packet is intended for: two spaces for every vendor, which is the value of every packet sent during the trading session, TV for a test vendor, or a vendor code, which the Ids sends only during retransmission'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Identifies the category of the transmitted message, and selects the Message Text that follows the header'
      - id: message_subcategory
        type: u1
        enum: message_subcategory
        doc: 'Identifies the financial product whose information is conveyed and imposes a second level of categorization upon it. The Ids sends one space when the packet''s category is not directly related to a specific financial product'
      - id: venue_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identification Code of the Exchange or Regulated Market publishing the packet''s information, as Iso 10383 defines it. Control message packets such as Line Verification carry four spaces'
      - id: message_sequence_number
        type: str
        size: 7
        encoding: ASCII
        doc: 'Sequence number of the packet. The first message sent has a sequence number of zero and every message thereafter increments it by one, except a Line Verification control message, which repeats the number of the last message sent. A vendor asks the Ids to retransmit by naming the first and last sequence numbers to send, and a retransmitted packet carries its original number'
      - id: publication_timestamp
        type: str
        size: 20
        encoding: ASCII
        doc: 'Local time the packet was created in the Ids subsystem, as YYYYMMDDHHMMSSdddddd to the microsecond'
  apa_post_trade_message:
    seq:
      - id: report_status
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the report is new or a cancellation'
      - id: trading_date_and_time
        type: str
        size: 20
        encoding: ASCII
        doc: 'Date and time of the trade, expressed as Utc, which may be prior to the current trading date'
      - id: trade_id_indicator
        type: u1
        enum: trade_id_indicator
        doc: 'Which system assigned the Trade ID'
      - id: trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the trade'
      - id: venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identification Code of the Market the instrument belongs to, XOFF for over the counter or SINT for a systematic internaliser'
      - id: transaction_to_be_cleared
        type: u1
        enum: transaction_to_be_cleared
        doc: 'Whether the transaction is to be cleared'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'How the price is expressed'
      - id: price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Eighteen digits of which thirteen may be fraction digits when the price is a monetary value, ten when it is a percentage or a yield, and seventeen when it is basis points'
      - id: price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the price is expressed in. Conditionally required'
      - id: quantity
        type: str
        size: 18
        encoding: ASCII
        doc: 'Seventeen fraction digits when the quantity is a number of units, and five when it is a monetary or nominal value'
      - id: quantity_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the quantity is expressed in, and spaces when the Quantity expresses units. Conditionally required'
      - id: notation_of_the_quantity_in_measurement_unit
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'TOCD for tons of carbon dioxide equivalent, or free text otherwise Conditionally required'
      - id: quantity_in_measurement_unit
        type: str
        size: 18
        encoding: ASCII
        doc: 'Quantity expressed in the measurement unit. Conditionally required'
      - id: notional_amount
        type: str
        size: 18
        encoding: ASCII
        doc: 'Notional amount of the trade. Conditionally required'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the notional amount is expressed in. Conditionally required'
      - id: instrument_id_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether an Isin is available for the instrument'
      - id: instrument_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Isin code of the instrument, as Iso 6166 defines it. Conditionally required'
      - id: instrument_full_name
        type: str
        size: 350
        encoding: ASCII
        pad-right: 0x20
        doc: 'Full name of the instrument. Conditionally required'
      - id: instrument_classification
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Iso 10962 Cfi code of the instrument'
      - id: price_multiplier
        type: str
        size: 18
        encoding: ASCII
        doc: 'Price multiplier of the instrument. Conditionally required'
      - id: underlying_instrument_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Isin code of the underlying instrument. Conditionally required'
      - id: underlying_index_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'One of the index codes of section 5.1, or free text when the index name is not in that list Conditionally required'
      - id: term_of_the_underlying_index
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Three digits of term followed by its unit, DAYS, WEEK, MNTH or YEAR Conditionally required'
      - id: option_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a put or a call. Conditionally required'
      - id: strike_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Thirteen fraction digits when the price is a monetary value, ten when it is a percentage or a yield, and seventeen when it is basis points Conditionally required'
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the strike price is expressed in. Conditionally required'
      - id: strike_price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'How the strike price is expressed. Conditionally required'
      - id: option_exercise_style
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exercise style of the option. Conditionally required'
      - id: maturity_date
        type: yyyymmdd_ascii_date
        doc: 'Maturity date of the instrument. Conditionally required'
      - id: expiry_date
        type: yyyymmdd_ascii_date
        doc: 'Expiry date of the instrument. Conditionally required'
      - id: delivery_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'How the instrument settles. Conditionally required'
      - id: type_emission_allowance
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the emission allowance. Conditionally required'
      - id: otc_posttrade_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bitmap of one or more flags: bit 1 BENC benchmark, bit 2 ACTX agency cross, bit 3 LRGS large in scale, bit 4 ILQD illiquid instrument, bit 5 SIZE above specified size, bit 6 CANC cancellations, bit 7 AMND amendments, bit 8 SDIV special dividend, bit 9 RPRI price improvement, bit 10 DUPL duplicative, bit 11 TNCP not contributing to price discovery process, bit 12 TPAC package, bit 13 XFPH exchange for physical Conditionally required'
      - id: deferral_indicator
        type: u1
        enum: deferral_indicator
        doc: 'Whether publication of the trade is deferred'
      - id: lmtf
        type: u1
        enum: lmtf
        doc: 'Mifid II deferral flag LMTF'
      - id: fulf
        type: u1
        enum: fulf
        doc: 'Mifid II deferral flag FULF'
      - id: datf
        type: u1
        enum: datf
        doc: 'Mifid II deferral flag DATF'
      - id: fula
        type: u1
        enum: fula
        doc: 'Mifid II deferral flag FULA'
      - id: volo
        type: u1
        enum: volo
        doc: 'Mifid II deferral flag VOLO'
      - id: fulv
        type: u1
        enum: fulv
        doc: 'Mifid II deferral flag FULV'
      - id: fwaf
        type: u1
        enum: fwaf
        doc: 'Mifid II deferral flag FWAF'
      - id: fulj
        type: u1
        enum: fulj
        doc: 'Mifid II deferral flag FULJ'
      - id: idaf
        type: u1
        enum: idaf
        doc: 'Mifid II deferral flag IDAF'
      - id: volw
        type: u1
        enum: volw
        doc: 'Mifid II deferral flag VOLW'
      - id: coaf
        type: u1
        enum: coaf
        doc: 'Mifid II deferral flag COAF'
  apa_pre_trade_message:
    seq:
      - id: report_status
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the report is new or a cancellation'
      - id: quote_type
        type: u1
        enum: quote_type
        doc: 'Which side of the market the quote is'
      - id: quote_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique sequential number generated internally by the Member based on Instrument ID, Mic, currency and Lei'
      - id: event_time
        type: str
        size: 20
        encoding: ASCII
        doc: 'Time the event was processed, expressed as Utc, which may be prior to the current trading date'
      - id: quote_liquidity
        type: u1
        enum: quote_liquidity
        doc: 'Whether the market for the instrument is liquid'
      - id: venue_mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identification Code of the Market the instrument belongs to, as Iso 10383 defines it'
      - id: submitting_entity_identification_code
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Legal entity identifier of the quote submitting entity, as Iso 17442 defines it'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'How the price is expressed'
      - id: price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Eighteen digits of which thirteen may be fraction digits when the price is a monetary value, ten when it is a percentage or a yield, and seventeen when it is basis points'
      - id: price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the price is expressed in. Conditionally required'
      - id: quantity
        type: str
        size: 18
        encoding: ASCII
        doc: 'Seventeen fraction digits when the quantity is a number of units, and five when it is a monetary or nominal value'
      - id: quantity_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the quantity is expressed in, and spaces when the Quantity expresses units. Conditionally required'
      - id: notation_of_the_quantity_in_measurement_unit
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'TOCD for tons of carbon dioxide equivalent, or free text otherwise Conditionally required'
      - id: quantity_in_measurement_unit
        type: str
        size: 18
        encoding: ASCII
        doc: 'Quantity expressed in the measurement unit. Conditionally required'
      - id: notional_amount
        type: str
        size: 18
        encoding: ASCII
        doc: 'Notional amount of the trade. Conditionally required'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the notional amount is expressed in. Conditionally required'
      - id: instrument_id_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether an Isin is available for the instrument'
      - id: instrument_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Isin code of the instrument, as Iso 6166 defines it. Conditionally required'
      - id: instrument_full_name
        type: str
        size: 350
        encoding: ASCII
        pad-right: 0x20
        doc: 'Full name of the instrument. Conditionally required'
      - id: instrument_classification
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Iso 10962 Cfi code of the instrument'
      - id: price_multiplier
        type: str
        size: 18
        encoding: ASCII
        doc: 'Price multiplier of the instrument. Conditionally required'
      - id: underlying_instrument_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Isin code of the underlying instrument. Conditionally required'
      - id: underlying_index_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'One of the index codes of section 5.1, or free text when the index name is not in that list Conditionally required'
      - id: term_of_the_underlying_index
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Three digits of term followed by its unit, DAYS, WEEK, MNTH or YEAR Conditionally required'
      - id: option_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a put or a call. Conditionally required'
      - id: strike_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Thirteen fraction digits when the price is a monetary value, ten when it is a percentage or a yield, and seventeen when it is basis points Conditionally required'
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency the strike price is expressed in. Conditionally required'
      - id: strike_price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'How the strike price is expressed. Conditionally required'
      - id: option_exercise_style
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exercise style of the option. Conditionally required'
      - id: maturity_date
        type: yyyymmdd_ascii_date
        doc: 'Maturity date of the instrument. Conditionally required'
      - id: expiry_date
        type: yyyymmdd_ascii_date
        doc: 'Expiry date of the instrument. Conditionally required'
      - id: delivery_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'How the instrument settles. Conditionally required'
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i

enums:
  message_category:
    0x55:
      id: 'apa_post_trade_message'
      doc: 'Transmitted whenever a trade is reported to the Ids subsystem, for the Athex Apa post trade transparency service required by Mifid II'
    0x56:
      id: 'apa_pre_trade_message'
      doc: 'Transmitted whenever a quote is reported to the Ids subsystem by the Athex Apa service, for the Athex Apa pre trade transparency service'
  message_subcategory:
    0x20:
      id: 'generic'
      doc: 'Generic, applicable mainly to category K and P messages'
    0x42:
      id: 'bond'
      doc: 'Bond'
    0x45:
      id: 'etf'
      doc: 'ETF'
    0x49:
      id: 'stock_index'
      doc: 'Stock Index'
    0x4e:
      id: 'etf_indicative_net_asset_value'
      doc: 'ETF Indicative Net Asset Value (INAV)'
    0x53:
      id: 'stock_rights'
      doc: 'Stock/Rights'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
    0x4f:
      id: 'option'
      doc: 'Option'
    0x46:
      id: 'future'
      doc: 'Future'
    0x52:
      id: 'repos'
      doc: 'Repos'
    0x56:
      id: 'standard_combinations'
      doc: 'Standard Combinations'
  trade_id_indicator:
    0x31:
      id: 'oasis_trade_id'
      doc: 'OASIS Trade ID'
    0x32:
      id: 'other_venue_trade_id'
      doc: 'Other Venue Trade ID'
  transaction_to_be_cleared:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  deferral_indicator:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  lmtf:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  fulf:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  datf:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  fula:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  volo:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  fulv:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  fwaf:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  fulj:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  idaf:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  volw:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  coaf:
    0x30:
      id: 'false_field'
      doc: 'False'
    0x31:
      id: 'true_field'
      doc: 'True'
  quote_type:
    0x31:
      id: 'bid'
      doc: 'Bid'
    0x32:
      id: 'offer'
      doc: 'Offer'
  quote_liquidity:
    0x31:
      id: 'liquid_market'
      doc: 'Liquid market for instrument'
    0x32:
      id: 'illiquid_market'
      doc: 'Illiquid market for instrument'

