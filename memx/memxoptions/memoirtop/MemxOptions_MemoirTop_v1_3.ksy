# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxOptions MemoirTop Sbe v1.3
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Member Order Information Record Top
#   Encoding: Simple Binary Encoding
#   Version: 1.3
#   Date: 6/29/23
#   Specification: MEMOIR Top for US Options-v1_3.pdf
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
  id: memx_memxoptions_memoirtop_sbe_v1_3
  title: Memx MemxOptions MemoirTop Sbe v1.3
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Options Member Order Information Record Top Sbe v1.3'
doc-ref: https://memxtrading.com/

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Memx Udp Common Header'
  - id: sequenced_messages
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::sequenced_message': sequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Memx Udp Message Type'
      - id: header_length
        type: u1
        doc: 'Total bytes in this header'
      - id: session_id
        type: u8
        doc: 'session identifier'
      - id: sequence_number
        type: u8
        doc: 'Sequence Number'
  sequenced_message:
    seq:
      - id: num_message
        type: u2
        doc: 'Number of messages in this packet'
      - id: message
        type: message
        repeat: expr
        repeat-expr: num_message
        doc: 'Memx Udp Message'
  message:
    seq:
      - id: message_length
        type: u2
        doc: 'Number of bytes in the following message'
      - id: sbe_message
        type: sbe_message
        doc: 'Sbe Message'
  sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::instrument_directory_message': instrument_directory_message
            'template_id::instrument_trading_status_message': instrument_trading_status_message
            'template_id::trading_session_status_message': trading_session_status_message
            'template_id::broken_trade_message': broken_trade_message
            'template_id::corrected_trade_message': corrected_trade_message
            'template_id::snapshot_complete_message': snapshot_complete_message
            'template_id::best_bid_offer_message': best_bid_offer_message
            'template_id::best_bid_message': best_bid_message
            'template_id::best_offer_message': best_offer_message
            'template_id::best_bid_short_message': best_bid_short_message
            'template_id::best_offer_short_message': best_offer_short_message
            'template_id::trade_message': trade_message
            'template_id::clear_book_message': clear_book_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Memx Udp Message Type'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'T8 Identifier of the message template'
      - id: schema_id
        type: u1
        doc: 'The identifier of a message schema'
      - id: version
        type: u2
        doc: 'The version number of the message schema that was used to encode a message'
  instrument_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: options_product_type
        type: u1
        enum: options_product_type
        doc: 'OptionsProductType'
      - id: underlier
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlier'
      - id: osi_root
        type: str
        size: 6
        encoding: ASCII
        doc: 'OSIRoot'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'MaturityDate'
      - id: strike_put_or_call
        type: u1
        enum: strike_put_or_call
        doc: 'StrikePutOrCall'
      - id: strike_price
        type: decimal_u8_8
        doc: 'StrikePrice. Implied decimal with scale 1e-8'
      - id: closing_only
        type: u1
        enum: closing_only
        doc: 'ClosingOnly'
      - id: closing_time
        type: u8
        doc: 'ClosingTime'
      - id: is_test_symbol
        type: u1
        enum: is_test_symbol
        doc: 'IsTestSymbol'
  instrument_trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: instrument_trading_status_reason
        type: u1
        enum: instrument_trading_status_reason
        doc: 'InstrumentTradingStatusReason'
  trading_session_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: trading_session
        type: u1
        enum: trading_session
        doc: 'TradingSession'
  broken_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: original_quantity
        type: u4
        doc: 'OriginalQuantity'
      - id: original_price
        type: decimal_u8_8
        doc: 'OriginalPrice. Implied decimal with scale 1e-8'
  corrected_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: original_quantity
        type: u4
        doc: 'OriginalQuantity'
      - id: original_price
        type: decimal_u8_8
        doc: 'OriginalPrice. Implied decimal with scale 1e-8'
      - id: corrected_quantity
        type: u4
        doc: 'CorrectedQuantity'
      - id: corrected_price
        type: decimal_u8_8
        doc: 'CorrectedPrice. Implied decimal with scale 1e-8'
  snapshot_complete_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: as_of_sequence_number
        type: u8
        doc: 'AsOfSequenceNumber'
  best_bid_offer_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: total_bid_size
        type: u4
        doc: 'TotalBidSize'
      - id: cust_bid_size
        type: u4
        doc: 'CustBidSize'
      - id: bid_price
        type: decimal_u8_8
        doc: 'BidPrice. Implied decimal with scale 1e-8'
      - id: total_offer_size
        type: u4
        doc: 'TotalOfferSize'
      - id: cust_offer_size
        type: u4
        doc: 'CustOfferSize'
      - id: offer_price
        type: decimal_u8_8
        doc: 'OfferPrice. Implied decimal with scale 1e-8'
  best_bid_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: total_bid_size
        type: u4
        doc: 'TotalBidSize'
      - id: cust_bid_size
        type: u4
        doc: 'CustBidSize'
      - id: bid_price
        type: decimal_u8_8
        doc: 'BidPrice. Implied decimal with scale 1e-8'
  best_offer_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: total_offer_size
        type: u4
        doc: 'TotalOfferSize'
      - id: cust_offer_size
        type: u4
        doc: 'CustOfferSize'
      - id: offer_price
        type: decimal_u8_8
        doc: 'OfferPrice. Implied decimal with scale 1e-8'
  best_bid_short_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: total_bid_size_short
        type: u2
        doc: 'TotalBidSize'
      - id: cust_bid_size_short
        type: u2
        doc: 'CustBidSize'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'BidPrice. Implied decimal with scale 1e-2'
  best_offer_short_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: total_offer_size_short
        type: u2
        doc: 'TotalOfferSize'
      - id: cust_offer_size_short
        type: u2
        doc: 'CustOfferSize'
      - id: offer_price_short
        type: decimal_u2_2
        doc: 'OfferPrice. Implied decimal with scale 1e-2'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: trade_conditions
        type: trade_conditions
        doc: 'TradeConditions bit set'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: price
        type: decimal_u8_8
        doc: 'Price. Implied decimal with scale 1e-8'
      - id: cust_quantity
        type: u4
        doc: 'CustQuantity'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity'
  trade_conditions:
    seq:
      - id: intermarket_sweep
        type: b1
        doc: 'IntermarketSweep'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  clear_book_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Symbol'
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0:
      id: 'heartbeat_message'
      doc: 'Memx Udp Heartbeat Message'
    1:
      id: 'session_shutdown_message'
      doc: 'Memx Udp Session Shutdown Message'
    2:
      id: 'sequenced_message'
      doc: 'Memx Udp Sequenced Message'
  template_id:
    1:
      id: 'instrument_directory_message'
      doc: 'InstrumentDirectoryMessage'
    2:
      id: 'instrument_trading_status_message'
      doc: 'InstrumentTradingStatusMessage'
    3:
      id: 'trading_session_status_message'
      doc: 'TradingSessionStatusMessage'
    5:
      id: 'broken_trade_message'
      doc: 'BrokenTradeMessage'
    6:
      id: 'corrected_trade_message'
      doc: 'CorrectedTradeMessage'
    7:
      id: 'snapshot_complete_message'
      doc: 'SnapshotCompleteMessage'
    10:
      id: 'best_bid_offer_message'
      doc: 'BestBidOfferMessage'
    11:
      id: 'best_bid_message'
      doc: 'BestBidMessage'
    12:
      id: 'best_offer_message'
      doc: 'BestOfferMessage'
    13:
      id: 'best_bid_short_message'
      doc: 'BestBidShortMessage'
    14:
      id: 'best_offer_short_message'
      doc: 'BestOfferShortMessage'
    15:
      id: 'trade_message'
      doc: 'TradeMessage'
    16:
      id: 'clear_book_message'
      doc: 'ClearBookMessage'
  options_product_type:
    0:
      id: 'equity_underlying'
      doc: 'OptionsProductType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'index_underlying'
      doc: 'OptionsProductType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  strike_put_or_call:
    0:
      id: 'put'
      doc: 'PutOrCallType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'call'
      doc: 'PutOrCallType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  closing_only:
    0:
      id: 'false_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  is_test_symbol:
    0:
      id: 'false_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_trading_status:
    0x48:
      id: 'halted'
      doc: 'InstrumentTradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'trading'
      doc: 'InstrumentTradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_trading_status_reason:
    0x58:
      id: 'none'
      doc: 'InstrumentTradingStatusReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'administrative'
      doc: 'InstrumentTradingStatusReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_session:
    0x31:
      id: 'trading'
      doc: 'TradingSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'closed'
      doc: 'TradingSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    0x42:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  capacity:
    0x43:
      id: 'customer'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'non_customer'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

