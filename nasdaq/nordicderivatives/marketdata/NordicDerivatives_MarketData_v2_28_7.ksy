# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicDerivatives MarketData GeniumAmd v2.28.7
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Genium INET Auxiliary Market Data
#   Encoding: Genium INET Auxiliary Market Data
#   Version: 2.28.7
#   Date: 10/31/2017
#   Specification: Nasdaq Nordic Genium INET AMD Protocol Specification (a2.28.7).pdf
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
  id: nasdaq_nordicderivatives_marketdata_geniumamd_v2_28_7
  title: Nasdaq NordicDerivatives MarketData GeniumAmd v2.28.7
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Derivatives Genium INET Auxiliary Market Data GeniumAmd v2.28.7'

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
            '"V"': market_directory
            '"M"': combination_order_book_leg_directory
            '"L"': tick_size_table_entry
            '"S"': system_event_message
            '"r"': reported_trade
            '"B"': broken_trade_message
            '"q"': quote_request_message
            '"o"': open_interest_messsage
            '"p"': price_message
            '"W"': market_by_level_message
            '"U"': underlying_price_message
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
        doc: 'Values: 0 = Not applicable 1 = Option 2 = Forward 3 = Future 4 = FRA 5 = Cash 6 = Payment 7 = Exchange Rate 8 = Interest Rate Swap 9 = REPO 10 = Synthetic Box Leg/Reference 11 = Standard Combination 12 = Guarantee 13 = OTC General 14 = Equity Warrant 15 = Security Lending 16 = Non deliverable rolling spot 17 = Strip'
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
        doc: 'Order book ID of underlying instrument. NOTE: Only applicable for underlying instruments'
      - id: strike_price
        type: s4
        doc: 'NOTE: Only applicable for derivative instruments'
      - id: expiration_date
        type: yyyymmdd_date
        doc: 'Date of expiration. NOTE: Only applicable for derivative instruments'
      - id: number_of_decimals_in_strike_price
        type: u2
        doc: 'This value defines the number of decimals used in Strike Price for this order book. NOTE: Only applicable for derivative instruments'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Option type. Values: 1 = Call 2 = Put NOTE: A value of 0 indicates that Put or Call is un- defined for the order book'
      - id: notation_date
        type: yyyymmdd_date
        doc: 'Notation Date'
      - id: first_trading_date_and_time
        type: u8
        doc: 'First Trading Date and Time'
      - id: last_trading_date_and_time
        type: u8
        doc: 'Last Trading Date and Time'
      - id: country_id
        type: u1
        doc: 'Country Code'
      - id: market_id
        type: u1
        doc: 'Market Code'
      - id: physical_delivery
        type: u1
        enum: physical_delivery
        doc: 'Defines if the order book is physically delivered. 0 = Not applicable 1 = Yes 2 = No'
      - id: option_style
        type: u2
        enum: option_style
        doc: 'Defines the style of option. 0 = Not applicable 1 = American 2 = European 3 = Asian'
  market_directory:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: country_id
        type: u1
        doc: 'Country Code'
      - id: market_id
        type: u1
        doc: 'Market Code'
      - id: market_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Name'
  combination_order_book_leg_directory:
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
        doc: 'Values: Trade Types as configured for the exchange'
      - id: reserved_alpha_7
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
  quote_request_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: reserved_alpha_7
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: reserved_alpha_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: reserved_alpha_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The side of quote being requested. Values: “B” = buy quote requested. “S” = sell quote requested. “C” = request for cross “ ” (Space) = Double-sided quote requested'
      - id: quantity
        type: u8
        doc: 'Requested Quote quantity. Zero means any quanti- ty'
  open_interest_messsage:
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
      - id: previous_trading_date
        type: yyyymmdd_date
        doc: 'Previous trading date (T-1)'
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
        doc: 'Type of price published. Valid values: “S” = Settlement Price “I” = Indicative “M” = Margin Price'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: price_price_4
        type: s4
        doc: 'If set to MIN_INT (decimal -2147483648), it means that no price is available'
      - id: price_source
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '“E” = Exchange “T” = Theoretical'
  market_by_level_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: last_message
        type: u1
        enum: last_message
        doc: 'Indicates if the message is the final message in a Market by Level update 0 = Not Last Message 1 = Last Message Where Last Message = 0, there will be more mes- sages to follow to complete the Market by Level update. When Last Message = 1, the full Market by Level update will have been received'
      - id: level_update_action
        type: u1
        enum: level_update_action
        doc: 'Type of market update action. 0 = New 1 = Change 2 = Delete 3 = Max Depth Where Level Update Action = 3 (Max Depth), the following fields will have a zero (0) value: • Level Update • Entry Type • Price • Quantity'
      - id: max_depth
        type: u2
        doc: 'Maximum number of available price levels'
      - id: level_update
        type: u2
        doc: 'Integer to convey the price level of the bid or offer. 1 is the highest level'
      - id: entry_type
        type: u1
        enum: entry_type
        doc: 'Valid values: B = Buy S = Sell'
      - id: market_by_level_price
        type: u4
        doc: 'Market by Level Price'
      - id: quantity
        type: u8
        doc: 'Requested Quote quantity. Zero means any quanti- ty'
  underlying_price_message:
    seq:
      - id: timestamp_nanoseconds
        type: u4
        doc: 'Nanoseconds portion of the timestamp'
      - id: underlying_order_book_id
        type: u4
        doc: 'Order book ID of underlying instrument. NOTE: Only applicable for underlying instruments'
      - id: bid_price
        type: u4
      - id: ask_price
        type: u4
      - id: closing_price
        type: u4
      - id: opening_price
        type: u4
      - id: high_price
        type: u4
      - id: low_price
        type: u4
      - id: last_price
        type: u4
      - id: turnover
        type: u8
        doc: 'The number of traded contracts'
      - id: best_bid_volume
        type: u8
        doc: 'Total volume of orders in the market on best bid'
      - id: best_ask_volume
        type: u8
        doc: 'Total volume of orders in the market on ask bid'
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
    16:
      id: 'non_deliverable_rolling_spot'
      doc: 'Non Deliverable Rolling Spot'
    17:
      id: 'strip'
      doc: 'Strip'
  put_or_call:
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  physical_delivery:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  option_style:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'american'
      doc: 'American'
    2:
      id: 'european'
      doc: 'European'
    3:
      id: 'asian'
      doc: 'Asian'
  leg_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  last_message:
    0:
      id: 'not_last_message'
      doc: 'Not Last Message'
    1:
      id: 'last_message'
      doc: 'Last Message'
  level_update_action:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'change'
      doc: 'Change'
    2:
      id: 'delete_field'
      doc: 'Delete'
    3:
      id: 'max_depth'
      doc: 'Max Depth'
  entry_type:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'

