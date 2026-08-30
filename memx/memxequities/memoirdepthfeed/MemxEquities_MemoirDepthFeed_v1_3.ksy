# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxEquities MemoirDepthFeed Sbe v1.3
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Memoir Depth Feed
#   Encoding: Simple Binary Encoding
#   Version: 1.3
#   Date: 4/05/21
#   Specification: MEMOIR Depth Feed-v1_3.pdf
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
  id: memx_memxequities_memoirdepthfeed_sbe_v1_3
  title: Memx MemxEquities MemoirDepthFeed Sbe v1.3
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Equities Memoir Depth Feed Sbe v1.3'
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
            'template_id::reg_sho_restriction_message': reg_sho_restriction_message
            'template_id::security_trading_status_message': security_trading_status_message
            'template_id::trading_session_status_message': trading_session_status_message
            'template_id::order_added_message': order_added_message
            'template_id::order_deleted_message': order_deleted_message
            'template_id::order_reduced_message': order_reduced_message
            'template_id::order_executed_message': order_executed_message
            'template_id::trade_message': trade_message
            'template_id::broken_trade_message': broken_trade_message
            'template_id::corrected_trade_message': corrected_trade_message
            'template_id::clear_book_message': clear_book_message
            'template_id::snapshot_complete_message': snapshot_complete_message
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
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
      - id: round_lot
        type: u4
        doc: 'RoundLot'
      - id: reserved
        type: u1
        doc: 'Reserved'
      - id: is_test_symbol
        type: u1
        enum: is_test_symbol
        doc: 'IsTestSymbol'
      - id: mpv
        type: decimal_s8_6
        doc: 'MPV. Implied decimal with scale 1e-6'
  reg_sho_restriction_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: short_sale_restriction
        type: u1
        enum: short_sale_restriction
        doc: 'ShortSaleRestriction'
  security_trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'SecurityTradingStatus'
      - id: security_trading_status_reason
        type: u1
        enum: security_trading_status_reason
        doc: 'SecurityTradingStatusReason'
  trading_session_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: trading_session
        type: u1
        enum: trading_session
        doc: 'TradingSession'
  order_added_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderId'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: price
        type: decimal_s8_6
        doc: 'Price. Implied decimal with scale 1e-6'
  order_deleted_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderId'
  order_reduced_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderId'
      - id: quantity
        type: u4
        doc: 'Quantity'
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderId'
      - id: trade_id
        type: u8
        doc: 'TradeId'
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: price
        type: decimal_s8_6
        doc: 'Price. Implied decimal with scale 1e-6'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeId'
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: price
        type: decimal_s8_6
        doc: 'Price. Implied decimal with scale 1e-6'
  broken_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeId'
      - id: original_quantity
        type: u4
        doc: 'OriginalQuantity'
      - id: original_price
        type: decimal_s8_6
        doc: 'OriginalPrice. Implied decimal with scale 1e-6'
  corrected_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeId'
      - id: original_quantity
        type: u4
        doc: 'OriginalQuantity'
      - id: original_price
        type: decimal_s8_6
        doc: 'OriginalPrice. Implied decimal with scale 1e-6'
      - id: corrected_quantity
        type: u4
        doc: 'CorrectedQuantity'
      - id: corrected_price
        type: decimal_s8_6
        doc: 'CorrectedPrice. Implied decimal with scale 1e-6'
  clear_book_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
  snapshot_complete_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: as_of_sequence_number
        type: u8
        doc: 'AsOfSequenceNumber'
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
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0

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
      id: 'reg_sho_restriction_message'
      doc: 'RegSHORestrictionMessage'
    3:
      id: 'security_trading_status_message'
      doc: 'SecurityTradingStatusMessage'
    5:
      id: 'trading_session_status_message'
      doc: 'TradingSessionStatusMessage'
    10:
      id: 'order_added_message'
      doc: 'OrderAddedMessage'
    11:
      id: 'order_deleted_message'
      doc: 'OrderDeletedMessage'
    12:
      id: 'order_reduced_message'
      doc: 'OrderReducedMessage'
    13:
      id: 'order_executed_message'
      doc: 'OrderExecutedMessage'
    14:
      id: 'trade_message'
      doc: 'TradeMessage'
    15:
      id: 'broken_trade_message'
      doc: 'BrokenTradeMessage'
    16:
      id: 'corrected_trade_message'
      doc: 'CorrectedTradeMessage'
    18:
      id: 'clear_book_message'
      doc: 'ClearBookMessage'
    100:
      id: 'snapshot_complete_message'
      doc: 'SnapshotCompleteMessage'
  is_test_symbol:
    0:
      id: 'false_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  short_sale_restriction:
    0:
      id: 'false_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'BooleanType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_trading_status:
    0x48:
      id: 'halted'
      doc: 'SecurityTradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'paused'
      doc: 'SecurityTradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x51:
      id: 'quoting'
      doc: 'SecurityTradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'trading'
      doc: 'SecurityTradingStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_trading_status_reason:
    0x58:
      id: 'none'
      doc: 'SecurityTradingStatusReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'regulatory'
      doc: 'SecurityTradingStatusReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'administrative'
      doc: 'SecurityTradingStatusReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_session:
    0x31:
      id: 'opening'
      doc: 'TradingSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'trading'
      doc: 'TradingSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'post_trading'
      doc: 'TradingSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'closed'
      doc: 'TradingSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    0x42:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

