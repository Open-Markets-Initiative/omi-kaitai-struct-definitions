# ---------------------------------------------------------------------
# Kaitai struct definition for: Currenex Esp Cbp v9
#
# Protocol:
#   Organization: Currenex
#   Protocol: Executable Streaming Prices
#   Encoding: Currenex Binary Protocol
#   Version: 9
#   Date: 3/24/2021
#   Specification: ITCH-Spec.pdf
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
  id: currenex_currenexforex_esp_cbp_v9
  title: Currenex Esp Cbp v9
  license: GPL-3.0
  endian: be

doc: 'Currenex Currenex Forex Executable Streaming Prices Cbp v9'
doc-ref: https://www.currenex.com/support

seq:
  - id: itch_soh
    type: u1
    doc: 'Start of Currenex Itch message'
  - id: message_header
    type: message_header_struct
    doc: 'Currenex Itch Market Data Message Header'
  - id: message_body
    type:
      switch-on: message_header.message_type
      cases:
        'message_type::logon': logon
        'message_type::logout': logout
        'message_type::heartbeat': heartbeat
        'message_type::instrument_info': instrument_info
        'message_type::instrument_info_ack': instrument_info_ack
        'message_type::subscription_request': subscription_request
        'message_type::subscription_reply': subscription_reply
        'message_type::price_message': price_message
        'message_type::price_cancel_message': price_cancel_message
        'message_type::trade_ticker_message': trade_ticker_message
        'message_type::reject_message': reject_message
  - id: itch_etx
    type: u1
    doc: 'End of Currenex Itch message'

types:
  message_header_struct:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Directional session based sequence number'
      - id: timestamp
        type: u4
        doc: 'Time in milliseconds since midnight GMT'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'The type of message being sent'
  logon:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'User session login id'
      - id: password
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'User password'
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
  logout:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'User session login id'
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
      - id: reason
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional text'
  heartbeat:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
  instrument_info:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
      - id: instrument_index
        type: s2
        doc: 'Numeric identifier for currency pair identified by the instrument id'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'InstrumentType'
      - id: instrument_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free form instrument definition string'
      - id: settlement_date
        type: s8
        doc: 'Settlement date in milliseconds since midnight 01 January 1900 GMT'
  instrument_info_ack:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
      - id: instrument_index
        type: s2
        doc: 'Numeric identifier for currency pair identified by the instrument id'
  subscription_request:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
      - id: subscription_type
        type: u1
        enum: subscription_type
        doc: 'Subscription Type'
      - id: instrument_index
        type: s2
        doc: 'Numeric identifier for currency pair identified by the instrument id'
      - id: subscribe_to_ticker
        type: u1
        enum: subscribe_to_ticker
        doc: 'Subscribe to Trade Ticker message'
  subscription_reply:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
      - id: instrument_index
        type: s2
        doc: 'Numeric identifier for currency pair identified by the instrument id'
      - id: reply_type
        type: u1
        enum: reply_type
        doc: 'Reply Type'
      - id: reject_reason
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free form reject reason text'
  price_message:
    seq:
      - id: instrument_index
        type: s2
        doc: 'Numeric identifier for currency pair identified by the instrument id'
      - id: price_id
        type: s1
        doc: 'Id assigned to the price, unique across all currency pairs for the scope of the session'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: max_amount
        type: s8
        doc: 'The maximum amount being offered at this Price'
      - id: min_amount
        type: s8
        doc: 'The minimum amount being offered at this Price'
      - id: price
        type: s4
        doc: 'Price rate'
      - id: attributed
        type: u1
        enum: attributed
        doc: 'Price rate'
      - id: price_provider
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market maker id'
  price_cancel_message:
    seq:
      - id: instrument_index
        type: s2
        doc: 'Numeric identifier for currency pair identified by the instrument id'
      - id: price_id
        type: s1
        doc: 'Id assigned to the price, unique across all currency pairs for the scope of the session'
  trade_ticker_message:
    seq:
      - id: instrument_index
        type: s2
        doc: 'Numeric identifier for currency pair identified by the instrument id'
      - id: rate
        type: s4
        doc: 'Trade execution rate'
      - id: ticker_type
        type: u1
        enum: ticker_type
        doc: 'Trade execution rate'
      - id: transact_time
        type: s8
        doc: 'Trade transaction time in epoch time GMT'
  reject_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session id provided by Currenex'
      - id: reject_msg_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Rejected message type'
      - id: reject_reason
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free form reject reason text'

enums:
  message_type:
    0x41:
      id: 'logon'
      doc: 'A MP initiates a session by submitting a Logon message to Currenex'
    0x42:
      id: 'logout'
      doc: 'Currenex or a MP can terminate a session by sending a Logout message'
    0x43:
      id: 'heartbeat'
      doc: 'To ensure session integrity, Currenex sends a heartbeat message every fifteen seconds'
    0x44:
      id: 'instrument_info'
      doc: 'Included in the InstrumentInfo message is the InstrumentType, a free form instrument definition, and the InstrumentIndex used to request quotes and manage price updates'
    0x45:
      id: 'instrument_info_ack'
      doc: 'A MP should respond to each received InstrumentInfo message with an InstrumentInfoAck message'
    0x46:
      id: 'subscription_request'
      doc: 'Currenex will stream ESP messages to a MP once it receives a SubscriptionRequest message for the pair'
    0x47:
      id: 'subscription_reply'
      doc: 'Currenex responds to a SubscriptionRequest with a SubscriptionReply message'
    0x48:
      id: 'price_message'
      doc: 'Price Message'
    0x49:
      id: 'price_cancel_message'
      doc: 'Price Cancel'
    0x4a:
      id: 'trade_ticker_message'
      doc: 'A MP can subscribe to TradeTicker messages by setting SubscribeToTicker=0 in the SubscriptionRequest message'
    0x4b:
      id: 'reject_message'
      doc: 'Included in the InstrumentInfo message is the InstrumentType, a free form instrument definition, and the InstrumentIndex used to request quotes and manage price updates'
  instrument_type:
    0x31:
      id: 'foreign_exchange'
      doc: 'Foreign Exchange'
    0x32:
      id: 'cash_metals'
      doc: 'Cash Metals'
  subscription_type:
    0x30:
      id: 'subscribe'
      doc: 'Subscribe'
    0x31:
      id: 'unsubscribe'
      doc: 'Unsubscribe'
    0x32:
      id: 'resubscribe'
      doc: 'Resubscribe'
  subscribe_to_ticker:
    0x30:
      id: 'subscribe'
      doc: 'Subscribe'
    0x31:
      id: 'do_not_subscribe'
      doc: 'Do Not Subscribe'
  reply_type:
    0x31:
      id: 'accepted'
      doc: 'Accepted'
    0x32:
      id: 'rejected'
      doc: 'Rejected'
  side:
    0x31:
      id: 'bid'
      doc: 'Bid'
    0x32:
      id: 'offer'
      doc: 'Offer'
  attributed:
    0x31:
      id: 'attributed'
      doc: 'Attributed'
    0x32:
      id: 'not_attributed'
      doc: 'Not Attributed'
  ticker_type:
    0x31:
      id: 'given'
      doc: 'Given'
    0x32:
      id: 'paid'
      doc: 'Paid'

