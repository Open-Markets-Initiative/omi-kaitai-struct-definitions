# ---------------------------------------------------------------------
# Kaitai struct definition for: 24X 24XEquities MemoirLastSale Sbe v1.3
#
# Protocol:
#   Organization: 24 National Exchange
#   Protocol: Member Order Information Record Last Sale
#   Encoding: Simple Binary Encoding
#   Version: 1.3
#   Date: 9/1/25
#   Specification: memoir-last-sale-feed-v1_3.pdf
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
  id: n24x_24xequities_memoirlastsale_sbe_v1_3
  title: 24X 24XEquities MemoirLastSale Sbe v1.3
  license: GPL-3.0
  endian: be

doc: '24 National Exchange 24X Equities Member Order Information Record Last Sale Sbe v1.3'
doc-ref: https://equities.24exchange.com/exchange

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
        size: sbe_header.block_length
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::instrument_directory_message': instrument_directory_message
            'template_id::reg_sho_restriction_message': reg_sho_restriction_message
            'template_id::security_trading_status_message': security_trading_status_message
            'template_id::trading_session_status_message': trading_session_status_message
            'template_id::trade_report_message': trade_report_message
            'template_id::trade_cancel_message': trade_cancel_message
            'template_id::trade_correct_message': trade_correct_message
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
  trade_report_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: trade_qty
        type: u4
        doc: 'TradeQty'
      - id: trade_price
        type: decimal_s8_6
        doc: 'TradePrice. Implied decimal with scale 1e-6'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'SaleCondition1'
      - id: sale_condition_2
        type: u1
        enum: sale_condition_2
        doc: 'SaleCondition2'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'SaleCondition3'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'SaleCondition4'
  trade_cancel_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: trade_qty
        type: u4
        doc: 'TradeQty'
      - id: last_price
        type: decimal_s8_6
        doc: 'LastPrice. Implied decimal with scale 1e-6'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'SaleCondition1'
      - id: sale_condition_2
        type: u1
        enum: sale_condition_2
        doc: 'SaleCondition2'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'SaleCondition3'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'SaleCondition4'
  trade_correct_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: original_trade_qty
        type: u4
        doc: 'OriginalTradeQty'
      - id: original_trade_price
        type: decimal_s8_6
        doc: 'OriginalTradePrice. Implied decimal with scale 1e-6'
      - id: original_sale_condition_1
        type: u1
        enum: original_sale_condition_1
        doc: 'OriginalSaleCondition1'
      - id: original_sale_condition_2
        type: u1
        enum: original_sale_condition_2
        doc: 'OriginalSaleCondition2'
      - id: original_sale_condition_3
        type: u1
        enum: original_sale_condition_3
        doc: 'OriginalSaleCondition3'
      - id: original_sale_condition_4
        type: u1
        enum: original_sale_condition_4
        doc: 'OriginalSaleCondition4'
      - id: corrected_trade_qty
        type: u4
        doc: 'CorrectedTradeQty'
      - id: corrected_trade_price
        type: decimal_s8_6
        doc: 'CorrectedTradePrice. Implied decimal with scale 1e-6'
      - id: corrected_sale_condition_1
        type: u1
        enum: corrected_sale_condition_1
        doc: 'CorrectedSaleCondition1'
      - id: corrected_sale_condition_2
        type: u1
        enum: corrected_sale_condition_2
        doc: 'CorrectedSaleCondition2'
      - id: corrected_sale_condition_3
        type: u1
        enum: corrected_sale_condition_3
        doc: 'CorrectedSaleCondition3'
      - id: corrected_sale_condition_4
        type: u1
        enum: corrected_sale_condition_4
        doc: 'CorrectedSaleCondition4'
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
      id: 'trade_report_message'
      doc: 'TradeReportMessage'
    11:
      id: 'trade_cancel_message'
      doc: 'TradeCancelMessage'
    12:
      id: 'trade_correct_message'
      doc: 'TradeCorrectMessage'
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
  sale_condition_1:
    0x40:
      id: 'regular'
      doc: 'SCSettlementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  sale_condition_2:
    0x46:
      id: 'intermarket_sweep'
      doc: 'SCTradeThroughExemptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCTradeThroughExemptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  sale_condition_3:
    0x54:
      id: 'form_t'
      doc: 'SCExtendedHoursOrSoldType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCExtendedHoursOrSoldType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  sale_condition_4:
    0x48:
      id: 'price_variation'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'odd_lot'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'cross'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  original_sale_condition_1:
    0x40:
      id: 'regular'
      doc: 'SCSettlementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  original_sale_condition_2:
    0x46:
      id: 'intermarket_sweep'
      doc: 'SCTradeThroughExemptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCTradeThroughExemptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  original_sale_condition_3:
    0x54:
      id: 'form_t'
      doc: 'SCExtendedHoursOrSoldType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCExtendedHoursOrSoldType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  original_sale_condition_4:
    0x48:
      id: 'price_variation'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'odd_lot'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'cross'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  corrected_sale_condition_1:
    0x40:
      id: 'regular'
      doc: 'SCSettlementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  corrected_sale_condition_2:
    0x46:
      id: 'intermarket_sweep'
      doc: 'SCTradeThroughExemptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCTradeThroughExemptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  corrected_sale_condition_3:
    0x54:
      id: 'form_t'
      doc: 'SCExtendedHoursOrSoldType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCExtendedHoursOrSoldType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  corrected_sale_condition_4:
    0x48:
      id: 'price_variation'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'odd_lot'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'cross'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x20:
      id: 'not_applicable'
      doc: 'SCSROTradeDetailType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

