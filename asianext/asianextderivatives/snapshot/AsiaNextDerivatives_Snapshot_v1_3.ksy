# ---------------------------------------------------------------------
# Kaitai struct definition for: AsiaNext AsiaNextDerivatives Snapshot Amd v1.3
#
# Protocol:
#   Organization: AsiaNext
#   Protocol: Market Data Snapshot
#   Encoding: Aquis Market Data Protocol
#   Version: 1.3
#   Date: 11/6/2026
#   Specification: AsiaNext-Market-Data-Technical-Specification-v1.3.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: asianext_asianextderivatives_snapshot_amd_v1_3
  title: AsiaNext AsiaNextDerivatives Snapshot Amd v1.3
  license: MIT-0
  endian: le

doc: 'AsiaNext AsiaNext Derivatives Market Data Snapshot Amd v1.3'
doc-ref: https://www.asianext.com/tech/

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Aquis udp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count
    doc: 'Aquis Amd Message'

types:
  packet_header_struct:
    seq:
      - id: message_count
        type: u1
        doc: 'number of messages (n) in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Aquis market data message header'
      - id: payload
        size: message_header.msg_length - 6
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::snapshot_start_message': snapshot_start_message
            'msg_type::book_status_message': book_status_message
            'msg_type::book_entry_message': book_entry_message
            'msg_type::tick_table_data_message': tick_table_data_message
            'msg_type::security_definition_message': security_definition_message
            'msg_type::security_definition_futures_message': security_definition_futures_message
            'msg_type::security_definition_options_message': security_definition_options_message
            'msg_type::security_status_message': security_status_message
            'msg_type::sequence_number_reset_message': sequence_number_reset_message
  message_header:
    seq:
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Message type identifier'
      - id: msg_length
        type: u1
        doc: 'Length of market data message, including header'
      - id: seq_no
        type: u4
        doc: 'Sequence number of this message in the market data stream for the current trading day'
  snapshot_start_message:
    seq:
      - id: stream_seq_no
        type: u4
        doc: 'The sequence number of the last message in the continuous stream which relates to this snapshot'
      - id: security_count
        type: u4
        doc: 'Number of securities reported in this snapshot'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this snapshot. Nanoseconds since Unix epoch'
  book_status_message:
    seq:
      - id: security_id
        type: u4
        doc: 'Numeric identifier of relevant security'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'See Security Status message'
      - id: market_flags
        type: market_flags
        doc: 'Market status flags'
      - id: entries
        type: u2
        doc: 'Number of open orders in the book for this security'
      - id: closing_buy_qty
        type: u8
        doc: 'Total order quantity on the buy side during the closing market, otherwise set to 0. Not applicable to AsiaNext'
      - id: closing_sell_qty
        type: u8
        doc: 'Total order quantity on the sell side during the closing market, otherwise set to 0. Not applicable to AsiaNext'
      - id: indicative_price
        type: decimal_u8_5
        doc: 'Indicative auction price. Not applicable to AsiaNext. Implied decimal with scale 1e-5'
  market_flags:
    meta:
      bit-endian: le
    seq:
      - id: trading
        type: b1
        doc: '0 = Continuous Trading Closed, 1 = Continuous Trading Open'
      - id: mac_open
        type: b1
        doc: '0 = MaC is Closed, 1 = MaC is Open. Not Applicable to AsiaNext'
      - id: mac_run
        type: b1
        doc: '0 = MaC is not locked down, 1 = MaC is locked down. Not Applicable to AsiaNext'
      - id: unused_5
        type: b5
        doc: 'Reserved'
  book_entry_message:
    seq:
      - id: security_id
        type: u4
        doc: 'Numeric identifier of relevant security'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: quantity
        type: u8
        doc: 'Number of open contracts'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: order_ref
        type: u8
        doc: 'Unique order reference number for the session'
  tick_table_data_message:
    seq:
      - id: tick_table_id
        type: u1
        doc: 'Numeric identifier for this tick table or static tick'
      - id: name
        type: str
        size: 10
        encoding: ASCII
        doc: 'Short name'
      - id: threshold
        type: decimal_u8_5
        doc: 'The price threshold at which this tick data applies. Implied decimal with scale 1e-5'
      - id: tick_size
        type: decimal_u8_5
        doc: 'The tick size (price increment). Implied decimal with scale 1e-5'
  security_definition_message:
    seq:
      - id: security_id
        type: u4
        doc: 'Numeric identifier of relevant security'
      - id: umtf
        type: str
        size: 6
        encoding: ASCII
        doc: 'This is used to represent the exchange Symbol'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'ISIN for the security. This is not applicable to AsiaNext'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trading currency for the security'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'MIC for the security''s market of listing'
      - id: tick_table_id
        type: u1
        doc: 'Numeric identifier for this tick table or static tick'
      - id: flags
        type: flags
        doc: 'Security flags'
      - id: exchange_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Exchange symbol for the security'
      - id: lot_size_composite
        type: lot_size_composite
        doc: 'Lot size scaled at runtime by lotSizeDecimal'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: mac_enabled
        type: b1
        doc: 'Not in used. Default to 0'
      - id: test_stock
        type: b1
        doc: '0 = Security is not a test stock, 1 = Security is a test stock'
      - id: illiquid
        type: b1
        doc: '0 = Security is liquid, 1 = Security is illiquid'
      - id: live
        type: b1
        doc: '0 = Security is not live, 1 = Security is live'
      - id: aod_enabled
        type: b1
        doc: '0 = Security is not enabled for the AoD, 1 = Security is enabled. This is not applicable to AsiaNext'
      - id: unused_11
        type: b11
        doc: 'Reserved'
  lot_size_composite:
    seq:
      - id: lot_size
        type: u8
        doc: 'Lot Size for the security'
      - id: lot_size_decimal
        type: u1
        doc: 'Number of decimals implied in lotSize'
  security_definition_futures_message:
    seq:
      - id: security_id
        type: u4
        doc: 'Numeric identifier of relevant security'
      - id: umtf
        type: str
        size: 6
        encoding: ASCII
        doc: 'This is used to represent the exchange Symbol'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'ISIN for the security. This is not applicable to AsiaNext'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trading currency for the security'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'MIC for the security''s market of listing'
      - id: tick_table_id
        type: u1
        doc: 'Numeric identifier for this tick table or static tick'
      - id: futures_flags
        type: futures_flags
        doc: 'Futures security flags'
      - id: exchange_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Exchange symbol for the security'
      - id: lot_size_composite
        type: lot_size_composite
        doc: 'Lot size scaled at runtime by lotSizeDecimal'
      - id: maturity_date
        type: nanosecond_timestamp
        doc: 'The date and time a futures instrument will expire. Maturity date is not applicable for perpetual futures. The value is defaulted to 7956835200000000000 in Timestamp format, ie, 2222-02-22T00:00:00.0000000Z. Nanoseconds since Unix epoch'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the instrument'
      - id: contract_size_composite
        type: contract_size_composite
        doc: 'Contract size scaled at runtime by contractSizeDecimals'
      - id: underlying
        type: str
        size: 20
        encoding: ASCII
        doc: 'The asset or security on which the contract is based'
  futures_flags:
    meta:
      bit-endian: le
    seq:
      - id: mac_enabled
        type: b1
        doc: 'Not in used. Default to 0'
      - id: test_stock
        type: b1
        doc: '0 = Security is not a test stock, 1 = Security is a test stock'
      - id: illiquid
        type: b1
        doc: '0 = Security is liquid, 1 = Security is illiquid'
      - id: live
        type: b1
        doc: '0 = Security is not live, 1 = Security is live'
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: underlying_flag
        type: b1
        doc: '0 = Security is not an underlying, 1 = Security is an underlying'
      - id: rfq_only
        type: b1
        doc: '0 = Security is not RFQ only, 1 = Security is available for RFQ trading only'
      - id: unused_9
        type: b9
        doc: 'Reserved'
  contract_size_composite:
    seq:
      - id: contract_size
        type: u8
        doc: 'The contract size by which a price must be adjusted to determine the nominal value of a futures contract'
      - id: contract_size_decimals
        type: u1
        doc: 'Number of decimal places implied in contractSize'
  security_definition_options_message:
    seq:
      - id: security_id
        type: u4
        doc: 'Numeric identifier of relevant security'
      - id: umtf
        type: str
        size: 6
        encoding: ASCII
        doc: 'This is used to represent the exchange Symbol'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'ISIN for the security. This is not applicable to AsiaNext'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trading currency for the security'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'MIC for the security''s market of listing'
      - id: tick_table_id
        type: u1
        doc: 'Numeric identifier for this tick table or static tick'
      - id: options_flags
        type: options_flags
        doc: 'Options security flags'
      - id: exchange_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Exchange symbol for the security'
      - id: lot_size_composite
        type: lot_size_composite
        doc: 'Lot size scaled at runtime by lotSizeDecimal'
      - id: maturity_date
        type: nanosecond_timestamp
        doc: 'The date and time a futures instrument will expire. Maturity date is not applicable for perpetual futures. The value is defaulted to 7956835200000000000 in Timestamp format, ie, 2222-02-22T00:00:00.0000000Z. Nanoseconds since Unix epoch'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the instrument'
      - id: contract_size_composite
        type: contract_size_composite
        doc: 'Contract size scaled at runtime by contractSizeDecimals'
      - id: underlying
        type: str
        size: 20
        encoding: ASCII
        doc: 'The asset or security on which the contract is based'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'The option type of the contract'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'The exercise style of the contract'
      - id: strike_price
        type: u8
        doc: 'The strike price of the contract'
  options_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: test_stock
        type: b1
        doc: '0 = Security is not a test stock, 1 = Security is a test stock'
      - id: illiquid
        type: b1
        doc: '0 = Security is liquid, 1 = Security is illiquid'
      - id: live
        type: b1
        doc: '0 = Security is not live, 1 = Security is live'
      - id: second_unused_1
        type: b1
        doc: 'Reserved'
      - id: underlying_flag
        type: b1
        doc: '0 = Security is not an underlying, 1 = Security is an underlying'
      - id: rfq_only
        type: b1
        doc: '0 = Security is not RFQ only, 1 = Security is available for RFQ trading only'
      - id: unused_9
        type: b9
        doc: 'Reserved'
  security_status_message:
    seq:
      - id: security_id
        type: u4
        doc: 'Numeric identifier of relevant security'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'See Security Status message'
      - id: market_flags
        type: market_flags
        doc: 'Market status flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this snapshot. Nanoseconds since Unix epoch'
      - id: trading_phase
        type: u1
        enum: trading_phase
        doc: '1= Continuous trading'
  sequence_number_reset_message:
    seq:
      - id: next_seq_no
        type: u4
        doc: 'Sequence number of the next message published following this message. This value will always be 1'
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
  decimal_u8_5:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000.0

enums:
  msg_type:
    10:
      id: 'snapshot_start_message'
      doc: 'A Snapshot Start message is published as the first message in a snapshot to identify the sequence number in the continuous stream that this snapshot relates to.'
    11:
      id: 'book_status_message'
      doc: 'A Book Status message is published to report the trading and market status of each security and the number of open orders on the order book for the security at the time of the snapshot.'
    12:
      id: 'book_entry_message'
      doc: 'An appropriate number of Book Entry messages is published after each Book Status message to provide details of each order and allow the book to be built.'
    7:
      id: 'tick_table_data_message'
      doc: 'A series of Tick Table Data messages are published to specify the dynamic tick tables and static ticks that apply to the securities traded on AsiaNext.'
    8:
      id: 'security_definition_message'
      doc: 'Security Definition messages are published to identify the securities traded on AsiaNext.'
    30:
      id: 'security_definition_futures_message'
      doc: 'Security Definition messages are published to identify the Futures securities traded on AsiaNext.'
    32:
      id: 'security_definition_options_message'
      doc: 'Security Definition messages are published to identify the Option securities traded on AsiaNext.'
    9:
      id: 'security_status_message'
      doc: 'The Security Status message is published when the trading status of a security changes or when there is a change to the status of the market on AsiaNext to which the security belongs.'
    29:
      id: 'sequence_number_reset_message'
      doc: 'The Sequence Number Reset is published when AsiaNext initiates a seqNo reset.'
  trading_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'halted'
      doc: 'Halted'
    3:
      id: 'suspended'
      doc: 'Suspended'
  trading:
    0:
      id: 'continuous_trading_closed'
      doc: 'Continuous Trading Closed'
    1:
      id: 'continuous_trading_open'
      doc: 'Continuous Trading Open'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  settlement_type:
    1:
      id: 'cash'
      doc: 'Cash'
    2:
      id: 'physical'
      doc: 'Physical'
  option_type:
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  exercise_style:
    1:
      id: 'american'
      doc: 'American'
    2:
      id: 'european'
      doc: 'European'
    3:
      id: 'asian'
      doc: 'Asian'
    4:
      id: 'bermudan'
      doc: 'Bermudan'
  trading_phase:
    1:
      id: 'continuous_trading'
      doc: 'Continuous Trading'

