# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicEquities LastSale Itch v1.2.9
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nordic Equity Last Sale
#   Encoding: Itch
#   Version: 1.2.9
#   Date: 07/18/2025
#   Specification: Nasdaq Nordic INET Equity Last Sale NLS (1.2.9).pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_nordicequities_lastsale_itch_v1_2_9
  title: Nasdaq NordicEquities LastSale Itch v1.2.9
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Equities Nordic Equity Last Sale Itch v1.2.9'
doc-ref: https://www.nasdaq.com/solutions/technical-information-inet-nordic-trading-platform

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
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
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::adjusted_closing_price_message': adjusted_closing_price_message
            'message_type::on_exchange_trade_message': on_exchange_trade_message
            'message_type::otc_trade_message': otc_trade_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  adjusted_closing_price_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight, the publication time. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: adjusted_closing_price
        type: decimal_u8_6
        doc: 'Previous trading day closing price adjusted for corporate actions. Implied decimal with scale 1e-6'
  on_exchange_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight, the publication time. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: execution_date
        type: yyyymmdd_date
        doc: 'Date of execution'
      - id: execution_time
        type: hhmmssnnnnnnnnn_time
        doc: 'Time of execution'
      - id: agreement_date
        type: yyyymmdd_date
        doc: 'Date of agreement'
      - id: agreement_time
        type: hhmmssnnnnnnnnn_time
        doc: 'Time of agreement'
      - id: price_price_68
        type: decimal_u8_6
        doc: 'Execution price. Implied decimal with scale 1e-6'
      - id: quantity_integer_8
        type: u8
        doc: 'Execution quantity'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Mic code of the execution venue'
      - id: transaction_identifier_code
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade match id assigned to each trade'
      - id: mmt_trade_flags
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market model typology trade flags'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Type of negotiated trade'
      - id: mpid_buyer
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the buyer, if public'
      - id: mpid_seller
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the seller, if public'
      - id: transaction_to_be_cleared
        type: u1
        enum: transaction_to_be_cleared
        doc: 'Whether the transaction is to be cleared'
  otc_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight, the publication time. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: instrument_identification_code_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of instrument identifier'
      - id: instrument_identification_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Isin code identifying the instrument'
      - id: agreement_date
        type: yyyymmdd_date
        doc: 'Date of agreement'
      - id: agreement_time
        type: hhmmssnnnnnnnnn_time
        doc: 'Time of agreement'
      - id: price_integer_18_n_8
        type: u8
        doc: 'Execution price with runtime decimal places'
      - id: price_fraction
        type: u1
        doc: 'Number of fractional digits in Price'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'How the price is expressed'
      - id: price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Iso currency code of the price'
      - id: quantity_integer_18_n_8
        type: u8
        doc: 'Execution quantity with runtime decimal places'
      - id: quantity_fraction
        type: u1
        doc: 'Number of fractional digits in Quantity'
      - id: notation_of_the_quantity_in_measurement_unit
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Measurement units the quantity is expressed in'
      - id: quantity_in_measurement_unit
        type: u8
        doc: 'Quantity expressed in measurement units'
      - id: quantity_in_measurement_unit_fraction
        type: u1
        doc: 'Number of fractional digits in Quantity in measurement unit'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Mic code of the execution venue'
      - id: notional_amount
        type: u8
        doc: 'Notional amount with runtime decimal places'
      - id: notional_amount_fraction
        type: u1
        doc: 'Number of fractional digits in Notional amount'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Iso currency code of the notional amount'
      - id: type_field
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emission allowance type, for emission allowance derivatives only'
      - id: transaction_identifier_code
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade match id assigned to each trade'
      - id: mmt_trade_flags
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market model typology trade flags'
      - id: transaction_to_be_cleared
        type: u1
        enum: transaction_to_be_cleared
        doc: 'Whether the transaction is to be cleared'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Type of negotiated trade'
      - id: third_country_trading_venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Mic code of a third country execution venue'
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
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  hhmmssnnnnnnnnn_time:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 10000000000000 % 100
      minute:
        value: time / 100000000000 % 100
      second:
        value: time / 1000000000 % 100
      nanosecond:
        value: time % 1000000000

enums:
  message_type:
    0x47:
      id: 'adjusted_closing_price_message'
      doc: 'Adjusted closing price disseminated for all active symbols at the start of each trading day'
    0x54:
      id: 'on_exchange_trade_message'
      doc: 'Relays on exchange trade transactions executed or deferred to the current business day'
    0x5a:
      id: 'otc_trade_message'
      doc: 'Relays over the counter and systematic internaliser trade transactions'
  trade_type:
    0x31:
      id: 'standard_trade'
      doc: 'Standard Trade'
    0x32:
      id: 'non_standard_settlement'
      doc: 'Non Standard Settlement'
    0x33:
      id: 'exchange_granted_trade'
      doc: 'Exchange Granted Trade'
    0x35:
      id: 'portfolio_trade'
      doc: 'Portfolio Trade'
    0x36:
      id: 'volume_weighted_average_price_trade'
      doc: 'Volume Weighted Average Price Trade'
    0x38:
      id: 'pre_opening_trade'
      doc: 'Pre Opening Trade'
    0x44:
      id: 'standard_routed_trade'
      doc: 'Standard Routed Trade'
    0x45:
      id: 'standard_routed_dark_trade'
      doc: 'Standard Routed Dark Trade'
    0x46:
      id: 'standard_dark_trade'
      doc: 'Standard Dark Trade'
    0x47:
      id: 'standard_auction_on_demand_trade'
      doc: 'Standard Auction On Demand Trade'
    0x48:
      id: 'standard_trade_at_closing_trade'
      doc: 'Standard Trade At Closing Trade'
    0x49:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x39:
      id: 'otc_standard_trade'
      doc: 'Otc Standard Trade'
    0x41:
      id: 'otc_non_standard_trade'
      doc: 'Otc Non Standard Trade'
    0x42:
      id: 'si_standard_trade'
      doc: 'Si Standard Trade'
    0x43:
      id: 'si_non_standard_trade'
      doc: 'Si Non Standard Trade'
    0x4f:
      id: 'otc_loan_payment'
      doc: 'Otc Loan Payment'
    0x50:
      id: 'otc_primary_transaction'
      doc: 'Otc Primary Transaction'
  transaction_to_be_cleared:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'

