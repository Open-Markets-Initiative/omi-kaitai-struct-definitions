# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NfxFutures MarketData GeniumAmd v2.30.7
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Genium INET Auxiliary Market Data
#   Encoding: Genium INET Auxiliary Market Data
#   Version: 2.30.7
#   Date: 11/17/2017
#   Specification: Nasdaq AMD Market Data (2017-11).pdf
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
  id: nasdaq_nfxfutures_marketdata_geniumamd_v2_30_7
  title: Nasdaq NfxFutures MarketData GeniumAmd v2.30.7
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Futures Genium INET Auxiliary Market Data GeniumAmd v2.30.7'

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
            '"T"': seconds_message
            '"R"': order_book_directory
            '"M"': combination_order_book_leg
            '"L"': tick_size_table_entry
            '"S"': system_event_message
            '"O"': order_book_state_message
            '"r"': reported_trade
            '"B"': broken_trade_message
            '"o"': open_interest_message
            '"p"': price_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Code identifying this message type'
  seconds_message:
    seq:
      - id: second
        type: u4
        doc: 'Unix time (number of seconds since 1970-01-01 00:00:00 UTC)'
  order_book_directory:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security short name'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Human-readable long name of security'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code identifying security'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Values: 0 = Not applicable 1 = Option 2 = Forward 3 = Future 4 = FRA 5 = Cash 6 = Payment 7 = Exchange Rate 8 = Interest Rate Swap 9 = REPO 10 = Synthetic Box Leg/Reference 11 = Standard Combination 12 = Guarantee 13 = OTC General 14 = Equity Warrant 15 = Security Lending'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'This value defines the number of decimals used in price for this order book. NOTE: A value of 256 means that the instrument is traded in fractions (each fraction is 1/256)'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'This value defines the number of decimals in Nom- inal Value'
      - id: odd_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent an odd lot for the order book. NOTE: A value of 0 indicates that this lot type is undefined for the order book. The document states no data type for this field. Numeric is taken from the Nasdaq Nordic Equities TotalView Itch specification, which types Round Lot Size as Integer'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the quantity that represent a round lot for the issue The document states no data type for this field. Numeric is taken from the Nasdaq Nordic Equities TotalView Itch specification, which types Round Lot Size as Integer'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent a block lot for the order book. NOTE: A value of 0 indicates that this lot type is undefined for the order book. The document states no data type for this field. Numeric is taken from the Nasdaq Nordic Equities TotalView Itch specification, which types Round Lot Size as Integer'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
      - id: number_of_legs
        type: u1
        doc: 'Number of legs. NOTE: Only applicable for combination instruments'
      - id: underlying_order_book_id
        type: u4
        doc: 'Order book ID of underlying instrument. NOTE: Only applicable for derivative instruments except for combinations'
      - id: strike_price
        type: s4
        doc: 'NOTE: Only applicable for derivative instruments'
      - id: expiration_date
        type: yyyymmdd_date
        doc: 'Date of expiration. NOTE: Only applicable for derivative instruments. NOTE: If the effective expiration date is set in the system, it is also contained in this field'
      - id: number_of_decimals_in_strike_price
        type: u2
        doc: 'This value defines the number of decimals used in Strike Price for this order book. NOTE: Only applicable for derivative instruments'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Option type. Values: 1 = Call 2 = Put NOTE: A value of 0 indicates that Put or Call is un- defined for the order book'
      - id: market_id
        type: u2
        doc: 'Market ID'
      - id: strategy_subtype
        type: u1
        enum: strategy_subtype
        doc: 'Strategy subtype. Values: 0 = Not applicable 1 = Covered Option The document states the data type as Byte, which it does not declare. Numeric is what is written here, the two being the same at one byte'
      - id: minimum_quantity_and_multiple
        type: u4
        doc: 'Minimum quantity and quantity multiple for Cov- ered Options calculated by the system'
  combination_order_book_leg:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: combination_order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: leg_order_book_id
        type: u4
        doc: 'Order book ID of Leg instrument'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Values: B = As Defined C = Opposite'
      - id: leg_ratio
        type: u4
      - id: leg_price_future
        type: u4
        doc: 'The price of the Future leg as specified in the TMC for Covered Options'
      - id: leg_delta
        type: u4
        doc: 'The leg delta as specified in the TMC for Covered Options'
      - id: leg_quantity_future
        type: u4
        doc: 'The quantity multiple of the Future leg in the TMC for Covered Options, as calculated by the system'
  tick_size_table_entry:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: tick_size
        type: s8
        doc: 'Tick Size for the give price range'
      - id: price_from
        type: s4
        doc: 'Start of price range for this entry'
      - id: price_to
        type: s4
        doc: 'End of price range for this entry. Zero (0) means infinity'
  system_event_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: event_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The system supports the following event codes on a daily basis: “O” = Start of Messages. Outside of time stamp messages, the start of day message is the first message sent in any trading day. “C” = End of Messages. This is always the last mes- sage sent in any trading day'
  order_book_state_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of Order book State'
  reported_trade:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: traded_quantity
        type: u8
      - id: match_id
        type: u8
      - id: combo_group_id
        type: u4
        doc: 'Used to group combination order book executions and the trades in the constituent order books to- gether'
      - id: time_of_trade_execution
        type: u8
      - id: time_of_trade_agreement
        type: u8
      - id: time_of_trade_dissemination
        type: u8
      - id: trade_price
        type: s4
      - id: trade_type
        type: u2
        enum: trade_type
        doc: 'Values: 1 = Block Trade 2 = Exchange for Physical 11 = Exchange for Risk 14 = Exchange for Options'
      - id: reserved
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: second_reserved
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
  broken_trade_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: match_id
        type: u8
  open_interest_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: open_interest
        type: u8
        doc: 'Open interest'
  price_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: price_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of price published. Valid values: “P” = Preliminary Settlement Price “F” = Final Settlement Price “I” = Index Price “U” = Underlying Price'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: price
        type: s4
        doc: 'If set to MIN_INT (decimal -2147483648), it means that no price is available'
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

enums:
  financial_product:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'option'
      doc: 'Option'
    2:
      id: 'forward'
      doc: 'Forward'
    3:
      id: 'future'
      doc: 'Future'
    4:
      id: 'fra'
      doc: 'Fra'
    5:
      id: 'cash'
      doc: 'Cash'
    6:
      id: 'payment'
      doc: 'Payment'
    7:
      id: 'exchange_rate'
      doc: 'Exchange Rate'
    8:
      id: 'interest_rate_swap'
      doc: 'Interest Rate Swap'
    9:
      id: 'repo'
      doc: 'Repo'
    10:
      id: 'synthetic_box_leg_reference'
      doc: 'Synthetic Box Leg Reference'
    11:
      id: 'standard_combination'
      doc: 'Standard Combination'
    12:
      id: 'guarantee'
      doc: 'Guarantee'
    13:
      id: 'otc_general'
      doc: 'Otc General'
    14:
      id: 'equity_warrant'
      doc: 'Equity Warrant'
    15:
      id: 'security_lending'
      doc: 'Security Lending'
  put_or_call:
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  strategy_subtype:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'covered_option'
      doc: 'Covered Option'
  leg_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  trade_type:
    1:
      id: 'block_trade'
      doc: 'Block Trade'
    2:
      id: 'exchange_for_physical'
      doc: 'Exchange For Physical'
    11:
      id: 'exchange_for_risk'
      doc: 'Exchange For Risk'
    14:
      id: 'exchange_for_options'
      doc: 'Exchange For Options'

