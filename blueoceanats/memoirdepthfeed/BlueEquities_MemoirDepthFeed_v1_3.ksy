# ---------------------------------------------------------------------
# Kaitai struct definition for: BlueOceanAts BlueEquities MemoirDepthFeed Sbe v1.3
#
# Protocol:
#   Organization: Blue Ocean Technologies
#   Protocol: Member Order Information Record Depth Feed
#   Encoding: Simple Binary Encoding
#   Version: 1.3
#   Date: 9/1/25
#   Specification: MEMOIR Depth Feed (v1.3).pdf
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
  id: blueoceanats_blueequities_memoirdepthfeed_sbe_v1_3
  title: BlueOceanAts BlueEquities MemoirDepthFeed Sbe v1.3
  license: GPL-3.0
  endian: be

doc: 'Blue Ocean Technologies Blue Equities Member Order Information Record Depth Feed Sbe v1.3'
doc-ref: https://blueocean-tech.io/trading-updates

seq:
  - id: common_header
    type: common_header_struct
    doc: 'The header every datagram opens with, naming the message type, the data session and the sequence the payload starts at'
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
        doc: 'The kind of datagram that follows the header, a heartbeat, a session shutdown or a sequenced message'
      - id: header_length
        type: u1
        doc: 'Total bytes in this header'
      - id: session_id
        type: u8
        doc: 'Identifier of the data session the datagram belongs to; heartbeats on the session report it as active'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message in the datagram; on a heartbeat or a session shutdown it is instead the highest sequence published so far, zero before any message is published'
  sequenced_message:
    seq:
      - id: num_message
        type: u2
        doc: 'Number of messages in this packet'
      - id: message
        type: message
        repeat: expr
        repeat-expr: num_message
        doc: 'One element of the message list, its length followed by that many bytes of payload'
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
        doc: 'Blue Ocean Udp Block length'
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
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'The Cms root for the tradable instrument'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'The Cms suffix for the tradable instrument'
      - id: round_lot
        type: u4
        doc: 'The number of shares in a round lot for the instrument'
      - id: reserved
        type: u1
        doc: 'Reserved for future use'
      - id: is_test_symbol
        type: u1
        enum: is_test_symbol
        doc: 'Determines if this security is a test instrument'
      - id: mpv
        type: decimal_s8_6
        doc: 'The minimum price variation for an instrument, the smallest price increment of the stock. Implied decimal with scale 1e-6'
  reg_sho_restriction_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: short_sale_restriction
        type: u1
        enum: short_sale_restriction
        doc: 'Identifies if this security is subject to the Regulation SHO short sales restrictions'
  security_trading_status_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'The current trading state'
      - id: security_trading_status_reason
        type: u1
        enum: security_trading_status_reason
        doc: 'The source of the trading status change'
  trading_session_status_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: trading_session
        type: u1
        enum: trading_session
        doc: 'The trading session which was entered'
  order_added_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: order_id
        type: u8
        doc: 'The trading session unique reference number assigned to the order by the Order Added message'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order being added'
      - id: quantity
        type: u4
        doc: 'The total quantity of the event, added, reduced, executed or traded; a reduction is always greater than zero'
      - id: price
        type: decimal_s8_6
        doc: 'The price of the event, a signed mantissa scaled by a constant exponent of -6; an execution price may differ from the displayed order price through price improvement or price sliding. Implied decimal with scale 1e-6'
  order_deleted_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: order_id
        type: u8
        doc: 'The trading session unique reference number assigned to the order by the Order Added message'
  order_reduced_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: order_id
        type: u8
        doc: 'The trading session unique reference number assigned to the order by the Order Added message'
      - id: quantity
        type: u4
        doc: 'The total quantity of the event, added, reduced, executed or traded; a reduction is always greater than zero'
  order_executed_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: order_id
        type: u8
        doc: 'The trading session unique reference number assigned to the order by the Order Added message'
      - id: trade_id
        type: u8
        doc: 'A trading session unique match number of the trade, assigned by the Trade or Order Executed message'
      - id: quantity
        type: u4
        doc: 'The total quantity of the event, added, reduced, executed or traded; a reduction is always greater than zero'
      - id: price
        type: decimal_s8_6
        doc: 'The price of the event, a signed mantissa scaled by a constant exponent of -6; an execution price may differ from the displayed order price through price improvement or price sliding. Implied decimal with scale 1e-6'
  trade_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: trade_id
        type: u8
        doc: 'A trading session unique match number of the trade, assigned by the Trade or Order Executed message'
      - id: quantity
        type: u4
        doc: 'The total quantity of the event, added, reduced, executed or traded; a reduction is always greater than zero'
      - id: price
        type: decimal_s8_6
        doc: 'The price of the event, a signed mantissa scaled by a constant exponent of -6; an execution price may differ from the displayed order price through price improvement or price sliding. Implied decimal with scale 1e-6'
  broken_trade_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: trade_id
        type: u8
        doc: 'A trading session unique match number of the trade, assigned by the Trade or Order Executed message'
      - id: original_quantity
        type: u4
        doc: 'The original quantity of the trade being broken or corrected'
      - id: original_price
        type: decimal_s8_6
        doc: 'The original price of the trade being broken or corrected, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6'
  corrected_trade_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
      - id: trade_id
        type: u8
        doc: 'A trading session unique match number of the trade, assigned by the Trade or Order Executed message'
      - id: original_quantity
        type: u4
        doc: 'The original quantity of the trade being broken or corrected'
      - id: original_price
        type: decimal_s8_6
        doc: 'The original price of the trade being broken or corrected, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6'
      - id: corrected_quantity
        type: u4
        doc: 'The corrected quantity of the trade'
      - id: corrected_price
        type: decimal_s8_6
        doc: 'The new price of the trade, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6'
  clear_book_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: security_id
        type: u2
        doc: 'An instrument code uniquely identifying the security from the Instrument Directory'
  snapshot_complete_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'The timestamp when the event occurred, nanoseconds since the unix epoch'
      - id: as_of_sequence_number
        type: u8
        doc: 'The sequence number on the real time multicast channel the snapshot is based upon; discard buffered messages at or below it and apply those above it'
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
      doc: 'Sent periodically to say the data session is active and connectivity is unbroken, and to expose loss when traffic is quiet; it carries no payload and does not advance the sequence'
    1:
      id: 'session_shutdown_message'
      doc: 'Replaces the heartbeat once no further sequenced messages will be sent for the session; repeated so every client sees it, carries no payload and does not advance the sequence'
    2:
      id: 'sequenced_message'
      doc: 'Carries one or more business messages, the message count followed by that many length prefixed payloads'
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

