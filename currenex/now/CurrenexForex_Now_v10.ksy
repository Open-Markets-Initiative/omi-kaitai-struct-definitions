# ---------------------------------------------------------------------
# Kaitai struct definition for: Currenex Now Cbp v10
#
# Protocol:
#   Organization: Currenex
#   Protocol: Now Forex Market Data
#   Encoding: Currenex Binary Protocol
#   Version: 10
#   Date: 5/7/2018
#   Specification: Currenex_NOW_Itch_Specification.pdf
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
  id: currenex_currenexforex_now_cbp_v10
  title: Currenex Now Cbp v10
  license: GPL-3.0
  endian: be

doc: 'Currenex Currenex Forex Now Forex Market Data Cbp v10'
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
        'message_type::logon_message': logon_message
        'message_type::logout_message': logout_message
        'message_type::heart_beat_message': heart_beat_message
        'message_type::instrument_info': instrument_info
        'message_type::instrument_info_ack_message': instrument_info_ack_message
        'message_type::subscription_request_message': subscription_request_message
        'message_type::mass_subscription_request_message': mass_subscription_request_message
        'message_type::subscription_reply_message': subscription_reply_message
        'message_type::mass_subscription_reply_message': mass_subscription_reply_message
        'message_type::depth_of_book_message': depth_of_book_message
        'message_type::paid_given_message': paid_given_message
        'message_type::wamr_with_confidence_factor_message': wamr_with_confidence_factor_message
        'message_type::mid_activity_indicator_message': mid_activity_indicator_message
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
        type: s8
        doc: 'Epoch microseconds of WAMR calc'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'The type of message being sent'
  logon_message:
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
        doc: 'Unique session ID'
  logout_message:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'User session login id'
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: reason_alpha_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Logout reason code'
  heart_beat_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
  instrument_info:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: '1=Foreign Exchange,2=Cash Metals'
      - id: instrument_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency pair or metal code'
      - id: settlement_date
        type: s8
        doc: 'Epoch ms for settlement date'
  instrument_info_ack_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
  subscription_request_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: subscription_type
        type: u1
        enum: subscription_type
        doc: 'SubscriptionType'
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
      - id: subscribe_to_now_depth_of_book
        type: u1
        enum: subscribe_to_now_depth_of_book
        doc: 'Subscribe to price updates with full depth of the book'
      - id: subscribe_to_now_paid_given_with_bucketed_size
        type: str
        size-eos: true
        encoding: ASCII
        pad-right: 0x20
        doc: 'Subscribe to now paid/given with bucketed size'
      - id: subscribe_to_nowwamr_with_confidence_factor
        type: str
        size: 1
        encoding: ASCII
        doc: 'Subscribe to WAMR updates with confidence factor'
      - id: subscribe_to_now_mid_activity_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Subscribe to Mid Activity Indicator updates'
  mass_subscription_request_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: subscription_type
        type: u1
        enum: subscription_type
        doc: 'SubscriptionType'
      - id: subscribe_to_now_depth_of_book
        type: u1
        enum: subscribe_to_now_depth_of_book
        doc: 'Subscribe to price updates with full depth of the book'
      - id: subscribe_to_now_paid_given_with_bucketed_size
        type: str
        size-eos: true
        encoding: ASCII
        pad-right: 0x20
        doc: 'Subscribe to now paid/given with bucketed size'
      - id: subscribe_to_nowwamr_with_confidence_factor
        type: str
        size: 1
        encoding: ASCII
        doc: 'Subscribe to WAMR updates with confidence factor'
      - id: subscribe_to_now_mid_activity_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Subscribe to Mid Activity Indicator updates'
  subscription_reply_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
      - id: type_field
        type: str
        size: 1
        encoding: ASCII
        doc: '1=Accepted,2=Rejected'
      - id: reason_alpha_50
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rejection reason text'
  mass_subscription_reply_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: type_field
        type: str
        size: 1
        encoding: ASCII
        doc: '1=Accepted,2=Rejected'
      - id: reason_alpha_50
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rejection reason text'
  depth_of_book_message:
    seq:
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
      - id: level
        type: level
        repeat: expr
        repeat-expr: 20
        doc: 'Market level'
  level:
    seq:
      - id: bid
        type: bid
        doc: 'Market level bid'
      - id: offer
        type: offer
        doc: 'Market level offer'
  bid:
    seq:
      - id: rate
        type: decimal_s4_5
        doc: 'Trade rate. Implied decimal with scale 1e-5'
      - id: amount
        type: s8
        doc: 'Aggregated amount at this level'
  offer:
    seq:
      - id: rate
        type: decimal_s4_5
        doc: 'Trade rate. Implied decimal with scale 1e-5'
      - id: amount
        type: s8
        doc: 'Aggregated amount at this level'
  paid_given_message:
    seq:
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
      - id: rate
        type: decimal_s4_5
        doc: 'Trade rate. Implied decimal with scale 1e-5'
      - id: size_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: '2M'
      - id: paid_given_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Paid or given'
      - id: transact_time
        type: s8
        doc: 'Epoch ms of trade'
  wamr_with_confidence_factor_message:
    seq:
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
      - id: price
        type: decimal_s4_6
        doc: 'WAMR scaled six decimals. Implied decimal with scale 1e-6'
      - id: conf_factor_75
        type: conf_factor_75
        doc: '75th percentile confidence factor'
      - id: conf_factor_50
        type: conf_factor_50
        doc: '50th percentile confidence factor'
      - id: conf_factor_25
        type: conf_factor_25
        doc: '25th percentile confidence factor'
      - id: timestamp
        type: s8
        doc: 'Epoch microseconds of WAMR calc'
  conf_factor_75:
    seq:
      - id: bid_price
        type: decimal_s4_5
        doc: 'bid price. Implied decimal with scale 1e-5'
      - id: offer_price
        type: decimal_s4_5
        doc: 'offer price. Implied decimal with scale 1e-5'
  conf_factor_50:
    seq:
      - id: bid_price
        type: decimal_s4_5
        doc: 'bid price. Implied decimal with scale 1e-5'
      - id: offer_price
        type: decimal_s4_5
        doc: 'offer price. Implied decimal with scale 1e-5'
  conf_factor_25:
    seq:
      - id: bid_price
        type: decimal_s4_5
        doc: 'bid price. Implied decimal with scale 1e-5'
      - id: offer_price
        type: decimal_s4_5
        doc: 'offer price. Implied decimal with scale 1e-5'
  mid_activity_indicator_message:
    seq:
      - id: instrument_index
        type: s2
        doc: 'Instrument numeric index'
      - id: activity_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: '45s'
  reject_message:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID'
      - id: reject_msg_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message type rejected'
      - id: reason_alpha_50
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rejection reason text'
  decimal_s4_5:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100000.0
  decimal_s4_6:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  message_type:
    0x41:
      id: 'logon_message'
      doc: 'Client initiates a session by submitting a Logon message to Currenex_NOW'
    0x42:
      id: 'logout_message'
      doc: 'Terminate a session by sending or receiving a Logout message'
    0x43:
      id: 'heart_beat_message'
      doc: 'Keep-alive ping sent every 15 seconds; client must respond'
    0x44:
      id: 'instrument_info'
      doc: 'Definition of a currency or metal instrument'
    0x45:
      id: 'instrument_info_ack_message'
      doc: 'Acknowledge receipt of InstrumentInfo'
    0x58:
      id: 'subscription_request_message'
      doc: 'Request market data for a specific instrument'
    0x59:
      id: 'mass_subscription_request_message'
      doc: 'Subscribe or unsubscribe all instruments at once'
    0x47:
      id: 'subscription_reply_message'
      doc: 'Response to SubscriptionRequest'
    0x5a:
      id: 'mass_subscription_reply_message'
      doc: 'Response to MassSubscriptionRequest'
    0x64:
      id: 'depth_of_book_message'
      doc: 'Depth of book updates up to 20 levels'
    0x6b:
      id: 'paid_given_message'
      doc: 'Latest trade versus liquidity'
    0x72:
      id: 'wamr_with_confidence_factor_message'
      doc: 'Weighted average mid-rate with confidence factors'
    0x78:
      id: 'mid_activity_indicator_message'
      doc: 'Indicator of mid-rate activity windows'
    0x4b:
      id: 'reject_message'
      doc: 'Reject incorrectly formatted or invalid messages'
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
  subscribe_to_now_depth_of_book:
    0x30:
      id: 'subscribe'
      doc: 'Subscribe'
    0x31:
      id: 'do_not_subscribe'
      doc: 'Do Not Subscribe'

