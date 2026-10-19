# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw Wse OrderEntry Wats v1.7.6.20
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: Warsaw Stock Exchange Native Order Gateway
#   Encoding: Warsaw Automated Trading System
#   Version: 1.7.6.20
#   Date: 10/05/2026
#   Specification: GPW_WATS_2.01_Native_Order_Gateway_Specification_v1.7.6.20.pdf
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
  id: gpw_wse_orderentry_wats_v1_7_6_20
  title: Gpw Wse OrderEntry Wats v1.7.6.20
  license: GPL-3.0
  endian: le

doc: 'Giełda Papierów Wartościowych w Warszawie Warsaw Stock Exchange Warsaw Stock Exchange Native Order Gateway Wats v1.7.6.20'
doc-ref: https://gpwwats.pl/useful-documents-and-faqs

seq:
  - id: message
    type: message_struct
    repeat: eos

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Every order gateway message opens with the same 24 byte header'
      - id: payload
        size: message_header.message_length - 24
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login': login
            'message_type::login_response': login_response
            'message_type::connection_close': connection_close
            'message_type::reject': reject
            'message_type::test': test
            'message_type::test_event': test_event
            'message_type::trading_session_status': trading_session_status
            'message_type::order_add': order_add
            'message_type::order_add_response': order_add_response
            'message_type::order_cancel': order_cancel
            'message_type::order_cancel_response': order_cancel_response
            'message_type::order_modify': order_modify
            'message_type::order_modify_response': order_modify_response
            'message_type::order_mass_cancel': order_mass_cancel
            'message_type::order_mass_cancel_response': order_mass_cancel_response
            'message_type::order_execute': order_execute
            'message_type::mass_quote': mass_quote
            'message_type::mass_quote_response': mass_quote_response
            'message_type::market_maker_command': market_maker_command
            'message_type::market_maker_command_response': market_maker_command_response
            'message_type::request_for_execution': request_for_execution
            'message_type::bid_offer_update': bid_offer_update
            'message_type::trade_capture_report_single': trade_capture_report_single
            'message_type::trade_capture_report_dual': trade_capture_report_dual
            'message_type::trade_capture_report_response': trade_capture_report_response
            'message_type::trade_bust': trade_bust
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Total length of the message, which the message index of section 7 shows includes the 24 byte header: Heartbeat and Logout carry no body and state length 24'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'Type of the message, for example Login'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the message added by the sender. Section 6.2.1 reserves zero for the session messages, Login, LoginResponse, Logout, LogoutResponse, ConnectionClose and Heartbeat, and numbers the business messages from one'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Sending time, in nanoseconds since the Unix epoch. Section 4.12 states the type and the unit, a 64 bit unsigned integer given within nanosecond accuracy, and section 4.6.3.4 the zone, an expiry time being a UTC timestamp. Nanoseconds since Unix epoch'
      - id: source_timestamp
        type: nanosecond_timestamp
        doc: 'Time of the business event that triggered or generated the message, in nanoseconds since the Unix epoch. Nanoseconds since Unix epoch'
  login:
    seq:
      - id: version
        type: u2
        doc: 'Indicates the version of the protocol in which the message is defined'
      - id: token
        type: str
        size: 8
        encoding: ASCII
        doc: 'The security data required for authentication, which is a token received by the exchange member during the registration process'
      - id: connection_id
        type: u2
        doc: 'ID of the connection'
      - id: next_expected_seq_num
        type: u4
        doc: 'Next expected message sequence number value to be received'
      - id: last_sent_seq_num
        type: u4
        doc: 'Last sent sequence number'
  login_response:
    seq:
      - id: result_login_result
        type: u1
        enum: result_login_result
        doc: 'Login response status code'
      - id: next_expected_seq_num
        type: u4
        doc: 'Next expected message sequence number value to be received'
      - id: last_replay_seq_num
        type: u4
        doc: 'Last replay sequence number'
      - id: session_id
        type: u2
        doc: 'ID of the session'
  connection_close:
    seq:
      - id: reason_connection_close_reason
        type: u1
        enum: reason_connection_close_reason
        doc: 'Connection close reason'
  reject:
    seq:
      - id: ref_seq_num
        type: u4
        doc: 'Sequence number of the rejected message'
      - id: reject_reason
        type: u1
        enum: reject_reason
        doc: 'Reject reason'
  test:
    seq:
      - id: target_timestamp
        type: nanosecond_timestamp
        doc: 'Test timestamp (e.g. the send time of a message). Nanoseconds since Unix epoch'
  test_event:
    seq:
      - id: scenario_name
        type: str
        size: 200
        encoding: ASCII
        doc: 'Test scenario name'
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Test event type'
  trading_session_status:
    seq:
      - id: market_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: date
        type: yyyymmdd_date
        doc: 'Date of the business session when provided and 0 for StartOfTechnicalSession and EndOfTechnicalSession events'
      - id: trading_session_event
        type: u1
        enum: trading_session_event
        doc: 'Identifies an event related to the trading status of a trading session'
  order_add:
    seq:
      - id: stp_id
        type: u1
        doc: 'ID assigned by the client used in the Self Trade Prevention mechanism. Optional: Never required, can be 0 to disable stp'
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Indicates the order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Indicates the order''s time in force (e.g. GTC)'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the order''s side (buy or sell)'
      - id: price
        type: decimal_s8_8
        doc: 'Indicates the price of the order. Implied decimal with scale 1e-8'
      - id: trigger_price
        type: decimal_s8_8
        doc: 'Indicates the trigger price (Last Trade Price - LTP) after which the order should be added to the order book. Optional: Required for OrderType::StopLimit and OrderType::StopLoss, otherwise 0. Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Indicates the quantity of the instrument included in the order'
      - id: display_qty
        type: u8
        doc: 'Used only for iceberg order. The quantity to be displayed. Optional: Required for OrderType::Iceberg, otherwise 0'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the party making the order (either principal or agency)'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Account number. Optional: Required for AccountType different than Missing, otherwise filled with 0x0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Type of account associated with the order'
      - id: flags
        type: flags
        doc: 'Order related flags'
      - id: mifid_fields
        type: mifid_fields
        doc: 'MifidFields'
      - id: expire
        type: nanosecond_timestamp
        doc: 'Expiration time indicating the validity of the order - relevant only when TimeInForce is set to GTD (Good Till Date) or GTT (Good Till Time). Optional: Required for TimeInForce::GTD or TimeInForce::GTT, otherwise 0. Nanoseconds since Unix epoch'
      - id: memo
        type: str
        size: 18
        encoding: ASCII
        doc: 'Free text. Optional: Never required, if unused filled with 0x0'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
      - id: clearing_member_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Clearing member code. Optional: Never required, if unused filled with 0x0'
      - id: clearing_member_clearing_identifier
        type: u1
        enum: clearing_member_clearing_identifier
        doc: 'Clearing member''s clearing identifier'
      - id: exec_inst
        type: exec_inst
        doc: 'Instructions for order handling on exchange trading floor'
      - id: fee_structure_id
        type: u1
        doc: 'Optional identifier of a fee scheme for billing purposes. Optional: Never required, if unused 0'
      - id: interested_party
        type: str
        size: 8
        encoding: ASCII
        doc: '3rd party interested in this order or trade. Optional: Never required, if unused filled with 0x0'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: liquidity_provision_activity
        type: b1
        doc: 'Order submitted by any firm providing liquidity to the market'
      - id: direct_or_sponsored_access
        type: b1
        doc: 'Order submitted by Sponsored client using Sponsored Access connectivity'
      - id: market_maker_or_specialist
        type: b1
        doc: 'Order submitted as part of Liquidity Provision Activity by firm which have an agreement with Market'
      - id: reserved_3_to_7
        type: b5
        doc: 'Bits the schema assigns no meaning to'
  mifid_fields:
    seq:
      - id: client
        type: client
        doc: 'MifidField'
      - id: executing_trader
        type: executing_trader
        doc: 'MifidField'
      - id: investment_decision_maker
        type: investment_decision_maker
        doc: 'MifidField'
  client:
    seq:
      - id: short_code
        type: u4
        doc: 'Short code of MiFID participant'
      - id: qualifier
        type: u1
        enum: qualifier
        doc: 'Qualifier of MiFID participant'
  executing_trader:
    seq:
      - id: short_code
        type: u4
        doc: 'Short code of MiFID participant'
      - id: qualifier
        type: u1
        enum: qualifier
        doc: 'Qualifier of MiFID participant'
  investment_decision_maker:
    seq:
      - id: short_code
        type: u4
        doc: 'Short code of MiFID participant'
      - id: qualifier
        type: u1
        enum: qualifier
        doc: 'Qualifier of MiFID participant'
  exec_inst:
    meta:
      bit-endian: le
    seq:
      - id: cancel_on_connection_loss
        type: b1
        doc: 'Cancel on connection loss'
      - id: reserved_1_to_7
        type: b7
        doc: 'Bits the schema assigns no meaning to'
  order_add_response:
    seq:
      - id: order_id
        type: order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: public_order_id
        type: u8
        doc: 'Unique for single trading day order identifier assigned by the trading system and shared publicly in market data (public information)'
      - id: display_qty
        type: u8
        doc: 'Used only for iceberg order. The quantity to be displayed. Optional: Required for OrderType::Iceberg, otherwise 0'
      - id: filled
        type: u8
        doc: 'Indicates the quantity of the order which has already been filled'
      - id: status_order_status
        type: u1
        enum: status_order_status
        doc: 'Status of the given order'
      - id: reason_order_rejection_reason
        type: u2
        enum: reason_order_rejection_reason
        doc: 'Reason for rejecting the given order'
      - id: exec_type_reason
        type: u1
        enum: exec_type_reason
        doc: 'Describes why an order was executed and the events related to its lifecycle'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  order_id:
    meta:
      bit-endian: le
    seq:
      - id: seq_num
        type: b28
        doc: 'A sequence number of the OrderAdd message'
      - id: bulk_seq_num
        type: b8
        doc: 'Zero for single orders, for example Market and Limit, and the value of subsequent orders for messages carrying several orders or quotes, for example MassQuote'
      - id: session_id_order_id
        type: b14
        doc: 'A session number received during the login process'
      - id: connection_id_order_id
        type: b14
        doc: 'A connection number, a connectivity parameter provided by GPW'
  order_cancel:
    seq:
      - id: order_id
        type: order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: mifid_fields
        type: mifid_fields
        doc: 'MifidFields'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  order_cancel_response:
    seq:
      - id: order_id
        type: order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: status_order_status
        type: u1
        enum: status_order_status
        doc: 'Status of the given order'
      - id: reason_order_rejection_reason
        type: u2
        enum: reason_order_rejection_reason
        doc: 'Reason for rejecting the given order'
      - id: exec_type_reason
        type: u1
        enum: exec_type_reason
        doc: 'Describes why an order was executed and the events related to its lifecycle'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  order_modify:
    seq:
      - id: order_id
        type: order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: price
        type: decimal_s8_8
        doc: 'Indicates the price of the order. Implied decimal with scale 1e-8'
      - id: trigger_price
        type: decimal_s8_8
        doc: 'Indicates the trigger price (Last Trade Price - LTP) after which the order should be added to the order book. Optional: Required for OrderType::StopLimit and OrderType::StopLoss, otherwise 0. Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Indicates the quantity of the instrument included in the order'
      - id: display_qty
        type: u8
        doc: 'Used only for iceberg order. The quantity to be displayed. Optional: Required for OrderType::Iceberg, otherwise 0'
      - id: expire
        type: nanosecond_timestamp
        doc: 'Expiration time indicating the validity of the order - relevant only when TimeInForce is set to GTD (Good Till Date) or GTT (Good Till Time). Optional: Required for TimeInForce::GTD or TimeInForce::GTT, otherwise 0. Nanoseconds since Unix epoch'
      - id: mifid_fields
        type: mifid_fields
        doc: 'MifidFields'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  order_modify_response:
    seq:
      - id: order_id
        type: order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: filled
        type: u8
        doc: 'Indicates the quantity of the order which has already been filled'
      - id: status_order_status
        type: u1
        enum: status_order_status
        doc: 'Status of the given order'
      - id: priority_flag
        type: u1
        enum: priority_flag
        doc: 'Indicates whether the priority flag is lost or retained after modification'
      - id: reason_order_rejection_reason
        type: u2
        enum: reason_order_rejection_reason
        doc: 'Reason for rejecting the given order'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  order_mass_cancel:
    seq:
      - id: mass_cancel_request_type
        type: u1
        enum: mass_cancel_request_type
        doc: 'Mass cancel request type'
      - id: target_party_role
        type: u1
        enum: target_party_role
        doc: 'Target party role filter selection field'
      - id: target_party_id
        type: u4
        doc: 'Used to identify the party targeted for the action specified in the message. Optional: Required for TargetPartyRole::SenderLocation/ClientID/ExecutingTrader/InvestmentDecisionMaker, otherwise 0'
      - id: market_segment_id
        type: u4
        doc: 'Identifies the market segment for request type CancelOrdersForMarketSegment. Optional: Required for MassCancelRequestType::CancelOrdersForMarketSegment, otherwise 0'
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: executing_trader
        type: executing_trader
        doc: 'MifidField'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  order_mass_cancel_response:
    seq:
      - id: total_affected_orders
        type: u8
        doc: 'Total number of orders affected by the mass cancel request'
      - id: mass_cancel_request_type
        type: u1
        enum: mass_cancel_request_type
        doc: 'Mass cancel request type'
      - id: mass_cancel_id
        type: mass_cancel_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: target_party_role
        type: u1
        enum: target_party_role
        doc: 'Target party role filter selection field'
      - id: target_party_id
        type: u4
        doc: 'Used to identify the party targeted for the action specified in the message. Optional: Required for TargetPartyRole::SenderLocation/ClientID/ExecutingTrader/InvestmentDecisionMaker, otherwise 0'
      - id: market_segment_id
        type: u4
        doc: 'Identifies the market segment for request type CancelOrdersForMarketSegment. Optional: Required for MassCancelRequestType::CancelOrdersForMarketSegment, otherwise 0'
      - id: reason_mass_cancel_rejection_reason
        type: u2
        enum: reason_mass_cancel_rejection_reason
        doc: 'Reason for rejecting the given mass order cancel request'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  mass_cancel_id:
    meta:
      bit-endian: le
    seq:
      - id: seq_num
        type: b28
        doc: 'A sequence number of the OrderAdd message'
      - id: bulk_seq_num
        type: b8
        doc: 'Zero for single orders, for example Market and Limit, and the value of subsequent orders for messages carrying several orders or quotes, for example MassQuote'
      - id: session_id_order_id
        type: b14
        doc: 'A session number received during the login process'
      - id: connection_id_order_id
        type: b14
        doc: 'A connection number, a connectivity parameter provided by GPW'
  order_execute:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: order_id
        type: order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: trade_id
        type: u4
        doc: 'ID of the trade'
      - id: price
        type: decimal_s8_8
        doc: 'Indicates the price of the order. Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Indicates the quantity of the instrument included in the order'
      - id: leaves_qty
        type: u8
        doc: 'How much of the given security is left on the market after the trade is concluded'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Liquidity indicator'
      - id: currency
        type: u2
        enum: currency
        doc: 'Currency (e.g. USD)'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the order''s side (buy or sell)'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the order. Optional: Never required, if unused filled with 0x0'
  mass_quote:
    seq:
      - id: stp_id
        type: u1
        doc: 'ID assigned by the client used in the Self Trade Prevention mechanism. Optional: Never required, can be 0 to disable stp'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the party making the order (either principal or agency)'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Account number. Optional: Required for AccountType different than Missing, otherwise filled with 0x0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Type of account associated with the order'
      - id: flags
        type: flags
        doc: 'Order related flags'
      - id: mifid_fields
        type: mifid_fields
        doc: 'MifidFields'
      - id: memo
        type: str
        size: 18
        encoding: ASCII
        doc: 'Free text. Optional: Never required, if unused filled with 0x0'
      - id: clearing_member_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Clearing member code. Optional: Never required, if unused filled with 0x0'
      - id: clearing_member_clearing_identifier
        type: u1
        enum: clearing_member_clearing_identifier
        doc: 'Clearing member''s clearing identifier'
      - id: quotes
        type: quotes
        doc: 'Quotes'
      - id: fee_structure_id
        type: u1
        doc: 'Optional identifier of a fee scheme for billing purposes. Optional: Never required, if unused 0'
      - id: interested_party
        type: str
        size: 8
        encoding: ASCII
        doc: '3rd party interested in this order or trade. Optional: Never required, if unused filled with 0x0'
      - id: quote_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Arbitrary user provided value associated with the mass quote. Optional: Never required, if unused filled with 0x0'
  quotes:
    seq:
      - id: count
        type: u1
        doc: 'How many quotes this message contains'
      - id: items_quotes_array
        type: items_quotes_array
        repeat: expr
        repeat-expr: 30
        doc: 'The Array of quotes'
  items_quotes_array:
    seq:
      - id: quote
        type: quote
        doc: 'Quote'
  quote:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: bid
        type: bid
        doc: 'QuoteOrder'
      - id: ask
        type: ask
        doc: 'QuoteOrder'
  bid:
    seq:
      - id: price
        type: decimal_s8_8
        doc: 'Indicates the price of the order. Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Indicates the quantity of the instrument included in the order'
  ask:
    seq:
      - id: price
        type: decimal_s8_8
        doc: 'Indicates the price of the order. Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Indicates the quantity of the instrument included in the order'
  mass_quote_response:
    seq:
      - id: mass_quote_id
        type: mass_quote_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: responses
        type: responses
        doc: 'QuoteOrderResponses'
      - id: status_mass_quote_status
        type: u1
        enum: status_mass_quote_status
        doc: 'Status of the given mass quote order'
      - id: reason_mass_quote_rejection_reason
        type: u2
        enum: reason_mass_quote_rejection_reason
        doc: 'Reason for rejecting the given mass quote order'
      - id: fee_structure_id
        type: u1
        doc: 'Optional identifier of a fee scheme for billing purposes. Optional: Never required, if unused 0'
  mass_quote_id:
    meta:
      bit-endian: le
    seq:
      - id: seq_num
        type: b28
        doc: 'A sequence number of the OrderAdd message'
      - id: bulk_seq_num
        type: b8
        doc: 'Zero for single orders, for example Market and Limit, and the value of subsequent orders for messages carrying several orders or quotes, for example MassQuote'
      - id: session_id_order_id
        type: b14
        doc: 'A session number received during the login process'
      - id: connection_id_order_id
        type: b14
        doc: 'A connection number, a connectivity parameter provided by GPW'
  responses:
    seq:
      - id: count
        type: u1
        doc: 'How many quotes this message contains'
      - id: items_quote_order_response_array
        type: items_quote_order_response_array
        repeat: expr
        repeat-expr: 30
        doc: 'An array of QuoteOrderResponse'
  items_quote_order_response_array:
    seq:
      - id: quote_order_response
        type: quote_order_response
        doc: 'QuoteOrderResponse'
  quote_order_response:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: bid_order_id
        type: bid_order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: ask_order_id
        type: ask_order_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: status_order_status
        type: u1
        enum: status_order_status
        doc: 'Status of the given order'
      - id: reason_order_rejection_reason
        type: u2
        enum: reason_order_rejection_reason
        doc: 'Reason for rejecting the given order'
  bid_order_id:
    meta:
      bit-endian: le
    seq:
      - id: seq_num
        type: b28
        doc: 'A sequence number of the OrderAdd message'
      - id: bulk_seq_num
        type: b8
        doc: 'Zero for single orders, for example Market and Limit, and the value of subsequent orders for messages carrying several orders or quotes, for example MassQuote'
      - id: session_id_order_id
        type: b14
        doc: 'A session number received during the login process'
      - id: connection_id_order_id
        type: b14
        doc: 'A connection number, a connectivity parameter provided by GPW'
  ask_order_id:
    meta:
      bit-endian: le
    seq:
      - id: seq_num
        type: b28
        doc: 'A sequence number of the OrderAdd message'
      - id: bulk_seq_num
        type: b8
        doc: 'Zero for single orders, for example Market and Limit, and the value of subsequent orders for messages carrying several orders or quotes, for example MassQuote'
      - id: session_id_order_id
        type: b14
        doc: 'A session number received during the login process'
      - id: connection_id_order_id
        type: b14
        doc: 'A connection number, a connectivity parameter provided by GPW'
  market_maker_command:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: action
        type: u1
        enum: action
        doc: 'The action for the Market Maker command request'
  market_maker_command_response:
    seq:
      - id: ref_id
        type: u4
        doc: 'A reference id to the Market Maker command request message'
      - id: result_command_result
        type: u1
        enum: result_command_result
        doc: 'Confirmation of achieving the intended action. If the action (e.g., Buy Only state) has already been achieved before the command, the result will be positive'
      - id: rejection_code
        type: u2
        enum: rejection_code
        doc: 'Reason for rejecting the Market Maker command'
  request_for_execution:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: reason_request_for_execution_reason
        type: u1
        enum: reason_request_for_execution_reason
        doc: 'The reason for this RFE'
  bid_offer_update:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: update_type
        type: u1
        enum: update_type
        doc: 'Indicates a type of the BidOfferUpdate message'
      - id: total_bid_size
        type: u8
        doc: 'Specifies the total bid size'
      - id: total_offer_size
        type: u8
        doc: 'Specifies the total offer size'
      - id: bid_orders
        type: u4
        doc: 'Number of bid orders'
      - id: offer_orders
        type: u4
        doc: 'Number of offer orders'
  trade_capture_report_single:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: trade_report_id
        type: str
        size: 21
        encoding: ASCII
        doc: 'Unique identifier of the trade capture report'
      - id: secondary_trade_report_id
        type: secondary_trade_report_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: trade_id
        type: u4
        doc: 'ID of the trade'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Identifies Trade Report message transaction type'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Type of Trade Report'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Type of trade'
      - id: algorithmic_trade_indicator
        type: u1
        enum: algorithmic_trade_indicator
        doc: 'Indicates algorithmic trader'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of execution being reported. Uses subset of ExecType for trade capture reports'
      - id: trade_report_ref_id
        type: str
        size: 21
        encoding: ASCII
        doc: 'Reference identifier used with Cancel and Replace transaction types. The TradeReportID that is being referenced for trade correction or cancelation'
      - id: last_qty
        type: u8
        doc: 'Quantity (e.g. shares) bought/sold on this (last) fill'
      - id: last_px
        type: decimal_s8_8
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-8'
      - id: settlement_date
        type: yyyymmdd_date
        doc: 'Settlement date of the trade is equal to current date plus actual settlement offset calendar days'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the order''s side (buy or sell)'
      - id: counterparty_code
        type: str
        size: 16
        encoding: ASCII
        doc: 'Participant code of the counterparty'
      - id: tcr_party
        type: tcr_party
        doc: 'TcrParty'
  secondary_trade_report_id:
    meta:
      bit-endian: le
    seq:
      - id: seq_num
        type: b28
        doc: 'A sequence number of the OrderAdd message'
      - id: bulk_seq_num
        type: b8
        doc: 'Zero for single orders, for example Market and Limit, and the value of subsequent orders for messages carrying several orders or quotes, for example MassQuote'
      - id: session_id_order_id
        type: b14
        doc: 'A session number received during the login process'
      - id: connection_id_order_id
        type: b14
        doc: 'A connection number, a connectivity parameter provided by GPW'
  tcr_party:
    seq:
      - id: flags
        type: flags
        doc: 'Order related flags'
      - id: mifid_fields
        type: mifid_fields
        doc: 'MifidFields'
      - id: clearing_member_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Clearing member code. Optional: Never required, if unused filled with 0x0'
      - id: clearing_member_clearing_identifier
        type: u1
        enum: clearing_member_clearing_identifier
        doc: 'Clearing member''s clearing identifier'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Account number. Optional: Required for AccountType different than Missing, otherwise filled with 0x0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Type of account associated with the order'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: fee_structure_id
        type: u1
        doc: 'Optional identifier of a fee scheme for billing purposes. Optional: Never required, if unused 0'
      - id: interested_party
        type: str
        size: 8
        encoding: ASCII
        doc: '3rd party interested in this order or trade. Optional: Never required, if unused filled with 0x0'
      - id: memo
        type: str
        size: 18
        encoding: ASCII
        doc: 'Free text. Optional: Never required, if unused filled with 0x0'
  trade_capture_report_dual:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: trade_report_id
        type: str
        size: 21
        encoding: ASCII
        doc: 'Unique identifier of the trade capture report'
      - id: secondary_trade_report_id
        type: secondary_trade_report_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: trade_id
        type: u4
        doc: 'ID of the trade'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Identifies Trade Report message transaction type'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Type of Trade Report'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Type of trade'
      - id: algorithmic_trade_indicator
        type: u1
        enum: algorithmic_trade_indicator
        doc: 'Indicates algorithmic trader'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of execution being reported. Uses subset of ExecType for trade capture reports'
      - id: trade_report_ref_id
        type: str
        size: 21
        encoding: ASCII
        doc: 'Reference identifier used with Cancel and Replace transaction types. The TradeReportID that is being referenced for trade correction or cancelation'
      - id: last_qty
        type: u8
        doc: 'Quantity (e.g. shares) bought/sold on this (last) fill'
      - id: last_px
        type: decimal_s8_8
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-8'
      - id: settlement_date
        type: yyyymmdd_date
        doc: 'Settlement date of the trade is equal to current date plus actual settlement offset calendar days'
      - id: tcr_party_buy
        type: tcr_party_buy
        doc: 'TcrParty'
      - id: tcr_party_sell
        type: tcr_party_sell
        doc: 'TcrParty'
  tcr_party_buy:
    seq:
      - id: flags
        type: flags
        doc: 'Order related flags'
      - id: mifid_fields
        type: mifid_fields
        doc: 'MifidFields'
      - id: clearing_member_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Clearing member code. Optional: Never required, if unused filled with 0x0'
      - id: clearing_member_clearing_identifier
        type: u1
        enum: clearing_member_clearing_identifier
        doc: 'Clearing member''s clearing identifier'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Account number. Optional: Required for AccountType different than Missing, otherwise filled with 0x0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Type of account associated with the order'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: fee_structure_id
        type: u1
        doc: 'Optional identifier of a fee scheme for billing purposes. Optional: Never required, if unused 0'
      - id: interested_party
        type: str
        size: 8
        encoding: ASCII
        doc: '3rd party interested in this order or trade. Optional: Never required, if unused filled with 0x0'
      - id: memo
        type: str
        size: 18
        encoding: ASCII
        doc: 'Free text. Optional: Never required, if unused filled with 0x0'
  tcr_party_sell:
    seq:
      - id: flags
        type: flags
        doc: 'Order related flags'
      - id: mifid_fields
        type: mifid_fields
        doc: 'MifidFields'
      - id: clearing_member_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Clearing member code. Optional: Never required, if unused filled with 0x0'
      - id: clearing_member_clearing_identifier
        type: u1
        enum: clearing_member_clearing_identifier
        doc: 'Clearing member''s clearing identifier'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Account number. Optional: Required for AccountType different than Missing, otherwise filled with 0x0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Type of account associated with the order'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: fee_structure_id
        type: u1
        doc: 'Optional identifier of a fee scheme for billing purposes. Optional: Never required, if unused 0'
      - id: interested_party
        type: str
        size: 8
        encoding: ASCII
        doc: '3rd party interested in this order or trade. Optional: Never required, if unused filled with 0x0'
      - id: memo
        type: str
        size: 18
        encoding: ASCII
        doc: 'Free text. Optional: Never required, if unused filled with 0x0'
  trade_capture_report_response:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of the instrument being traded'
      - id: trade_id
        type: u4
        doc: 'ID of the trade'
      - id: trade_report_id
        type: str
        size: 21
        encoding: ASCII
        doc: 'Unique identifier of the trade capture report'
      - id: secondary_trade_report_id
        type: secondary_trade_report_id
        doc: 'Unique for each trading day order identifier based on the sequence number of order message, bulk sequence number, session ID and connection ID'
      - id: status_tcr_status
        type: u1
        enum: status_tcr_status
        doc: 'Status of the given order'
      - id: reason_tcr_rejection_reason
        type: u2
        enum: reason_tcr_rejection_reason
        doc: 'Reason for rejecting the given TCR'
  trade_bust:
    seq:
      - id: trade_id
        type: u4
        doc: 'ID of the trade'
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0

enums:
  message_type:
    2:
      id: 'login'
      doc: 'The login message authenticates a user establishing a connection to the trading port service. The login message must be the first message sent by the client application to request the initiation of a trading port session'
    3:
      id: 'login_response'
      doc: 'The login response message. The result field describes the login status, indicating whether the login was successful or not (i.e. successful login)'
    11:
      id: 'logout'
      doc: 'The logout message is sent from the client application to terminate the communication session with the trading port'
    14:
      id: 'logout_response'
      doc: 'The logout response message confirms the client logout message'
    12:
      id: 'connection_close'
      doc: 'The ConnectionClose message confirms the termination of a session through the trading port service'
    13:
      id: 'heartbeat'
      doc: 'Heartbeat message'
    15:
      id: 'reject'
      doc: 'The reject message is sent by the trading port service when receiving an erroneous message that cannot be further processed'
    34:
      id: 'gap_fill'
      doc: 'Create a SeqNum gap bettwen current SeqNum and header::seqNum'
    1:
      id: 'test'
      doc: 'The internal message for a test purpose'
    255:
      id: 'test_event'
      doc: 'Test event'
    35:
      id: 'trading_session_status'
      doc: 'The Trading Session Status provides information on the status of a trading session'
    4:
      id: 'order_add'
      doc: 'Message used to add new orders to the system'
    5:
      id: 'order_add_response'
      doc: 'The message is a response to an OrderAdd message and includes the order execution status'
    6:
      id: 'order_cancel'
      doc: 'Message used to cancel the previously submitted order'
    7:
      id: 'order_cancel_response'
      doc: 'The message is a response to an order cancel request and contains information about its execution, in particular whether the order to cancel was found or not'
    8:
      id: 'order_modify'
      doc: 'Message used to modify the submitted order'
    9:
      id: 'order_modify_response'
      doc: 'The response message for an OrderModify'
    29:
      id: 'order_mass_cancel'
      doc: 'Message used to cancel multiple existing orders'
    30:
      id: 'order_mass_cancel_response'
      doc: 'Response to message used to cancel multiple existing orders'
    10:
      id: 'order_execute'
      doc: 'The message used to report trades between counterparties (i.e. generated when two or more orders are matched)'
    24:
      id: 'mass_quote'
      doc: 'Mass Quote'
    25:
      id: 'mass_quote_response'
      doc: 'The response to a MassQuote message'
    32:
      id: 'market_maker_command'
      doc: 'Market Maker command request'
    33:
      id: 'market_maker_command_response'
      doc: 'The response to the Market Maker command'
    28:
      id: 'request_for_execution'
      doc: 'The information for the MM that one of the quotes has been crossed'
    31:
      id: 'bid_offer_update'
      doc: 'Message send during the IPO to the sell side or during the Tender Offer to the buy side'
    18:
      id: 'trade_capture_report_single'
      doc: 'Trade Capture Report - single side'
    19:
      id: 'trade_capture_report_dual'
      doc: 'Trade Capture Report - dual sided'
    20:
      id: 'trade_capture_report_response'
      doc: 'The message is a response to an Trade Capture Report message, containing the state of TCR execution'
    23:
      id: 'trade_bust'
      doc: 'Message used to inform about cancellation of previously accepted Trade'
  result_login_result:
    1:
      id: 'ok'
      doc: 'Successful login'
    2:
      id: 'not_found'
      doc: 'User not found'
    3:
      id: 'invalid_token'
      doc: 'Authorization failure'
    4:
      id: 'already_logged_in'
      doc: 'Already logged in'
    5:
      id: 'account_locked'
      doc: 'Account locked'
    6:
      id: 'login_not_allowed'
      doc: 'Login is currently unavailable due to reasons such as service unavailability'
    7:
      id: 'invalid_login_parameters'
      doc: 'The login parameters, such as the connection ID, are invalid'
    8:
      id: 'throttling_temporary_lock'
      doc: 'The login attempt failed due to exceeding the anti-flooding threshold'
    9:
      id: 'other'
      doc: 'Other errors'
  reason_connection_close_reason:
    1:
      id: 'protocol_error'
      doc: 'Invalid message or frame length'
    2:
      id: 'invalid_seq_num'
      doc: 'Message came with an incorrect sequence number'
    3:
      id: 'end_of_day'
      doc: 'The session day has come to an end'
    4:
      id: 'sync_fail'
      doc: 'The synchronization of messages has failed'
    5:
      id: 'anti_flooding_threshold_exceeded'
      doc: 'The second level of the throttling limit has been exceeded'
    6:
      id: 'connection_config_changed'
      doc: 'Connection configuration has changed'
    7:
      id: 'close_ops'
      doc: 'Service closed the connection because of an exchange operation (e.g. supervision operation)'
    8:
      id: 'disconnect'
      doc: 'Service closed the connection because of an internal operation (e.g. grace period end)'
  reject_reason:
    0:
      id: 'na'
      doc: 'Not applicable'
    1:
      id: 'max_throughput_exceeded'
      doc: 'Max throughput exceeded'
    2:
      id: 'invalid_msg_type'
      doc: 'Invalid message type'
    3:
      id: 'invalid_expire_time_precision'
      doc: 'Invalid expire time precision'
    4:
      id: 'invalid_settlement_date'
      doc: 'Invalid settlement date'
    5:
      id: 'settlement_date_required'
      doc: 'Settlement date required'
    6:
      id: 'trade_report_id_required'
      doc: 'Trade report ID required'
    7:
      id: 'missing_report_id_secondary_trade_report_id_or_trade_report_ref_id'
      doc: 'Missing report id (SecondaryTradeReportId or TradeReportRefId)'
    8:
      id: 'invalid_trade_id'
      doc: 'Invalid trade ID'
    9:
      id: 'invalid_algorithmic_trade_indicator'
      doc: 'Invalid algorithmic trade indicator'
    10:
      id: 'invalid_trade_report_id'
      doc: 'Invalid Trade report ID'
    11:
      id: 'invalid_gap_fill_seq_num'
      doc: 'GapFill seqNum should be higher than current seqNum'
  event_type:
    1:
      id: 'flush'
      doc: 'Flush the Test scenario'
    2:
      id: 'scenario_start'
      doc: 'Start of test scenario'
    3:
      id: 'scenario_end'
      doc: 'End of test scenario'
  trading_session_event:
    1:
      id: 'previous_day_restate_start'
      doc: 'Previous day restate start'
    2:
      id: 'previous_day_restate_end'
      doc: 'Previous day restate end'
    3:
      id: 'start_of_trading_session_mic'
      doc: 'Start of trading session MIC'
    4:
      id: 'end_of_trading_session_mic'
      doc: 'End of trading session MIC'
  order_type:
    1:
      id: 'limit'
      doc: 'Limit order type'
    2:
      id: 'market'
      doc: 'Market order type'
    3:
      id: 'market_to_limit'
      doc: 'Market to limit order type'
    4:
      id: 'iceberg'
      doc: 'Iceberg order type'
    5:
      id: 'stop_limit'
      doc: 'Stop limit order type'
    6:
      id: 'stop_loss'
      doc: 'Stop loss order type'
  time_in_force:
    1:
      id: 'day'
      doc: 'A day order is valid until the end of the trading day'
    2:
      id: 'gtc'
      doc: 'A GTC order is good till canceled'
    3:
      id: 'ioc'
      doc: 'An Immediate or Cancel order must be filled immediately or canceled'
    4:
      id: 'fok'
      doc: 'A Fill or Kill order must be immediately fully filled or canceled'
    5:
      id: 'vfa'
      doc: 'Valid For Auction'
    6:
      id: 'gtd'
      doc: 'A Good Till Date order must be filled before timestamp provided in `Expire` field or canceled'
    7:
      id: 'vfc'
      doc: 'Valid For Closing'
    8:
      id: 'gtt'
      doc: 'A Good Till Time order must be filled before timestamp provided in `Expire` field or canceled within the day of submission'
  side:
    1:
      id: 'buy'
      doc: 'Indicates a buy-side order'
    2:
      id: 'sell'
      doc: 'Indicates a sell-side order'
  capacity:
    1:
      id: 'agency'
      doc: 'Agency (mapped to AOTC)'
    2:
      id: 'principal'
      doc: 'Principal (mapped to DEAL)'
    3:
      id: 'riskless_principal'
      doc: 'Riskless Principal (mapped to MTCH)'
  account_type:
    1:
      id: 'missing'
      doc: 'Account is missing. Account is expected to be filled with 0x00'
    2:
      id: 'customer'
      doc: 'Account is carried on customer side of the books'
    3:
      id: 'house'
      doc: 'House trader'
  qualifier:
    1:
      id: 'na'
      doc: 'Na'
    2:
      id: 'algorithm'
      doc: 'Algorithm'
    3:
      id: 'firm_or_legal_entity'
      doc: 'Firm Or Legal Entity'
    4:
      id: 'natural_person'
      doc: 'Natural Person'
  clearing_member_clearing_identifier:
    33:
      id: 'not_applicable'
      doc: 'Not Applicable'
    78:
      id: 'lei'
      doc: 'Legal Entity Identifier'
    68:
      id: 'custom'
      doc: 'Custom clearing identifier'
  status_order_status:
    1:
      id: 'new_field'
      doc: 'New order( for Mass Quotes ->operation accepted)'
    2:
      id: 'cancelled'
      doc: 'Order cancelled (Not applicable to mass quotes)'
    3:
      id: 'rejected'
      doc: 'Order rejected'
    4:
      id: 'filled'
      doc: 'Order filled (Not applicable to mass quotes)'
    5:
      id: 'partially_filled'
      doc: 'Order partially filled (Not applicable to mass quotes)'
    6:
      id: 'expired'
      doc: 'Order expired (Not applicable to mass quotes)'
  reason_order_rejection_reason:
    0:
      id: 'na'
      doc: 'Not applicable'
    1:
      id: 'unknown_order'
      doc: 'Order id not recognized by the system'
    2:
      id: 'exchange_closed'
      doc: 'Exchange closed'
    18:
      id: 'invalid_price_increment'
      doc: 'Invalid price increment'
    99:
      id: 'other'
      doc: 'Other'
    106:
      id: 'instrument_phase_no_trading'
      doc: 'Trading is not available for the instrument in its current phase'
    1001:
      id: 'unknown_instrument'
      doc: 'Unknown instrument'
    1005:
      id: 'invalid_execution_trader'
      doc: 'Invalid execution trader'
    1006:
      id: 'invalid_decision_maker'
      doc: 'Invalid decision maker'
    1007:
      id: 'invalid_client_id'
      doc: 'Invalid client'
    1008:
      id: 'invalid_party_role_qualifier_for_client_id'
      doc: 'Invalid Party Role Qualifier for Client Id Party group'
    1009:
      id: 'invalid_party_role_qualifier_for_executing_trader'
      doc: 'Invalid Party Role Qualifier for Executing Trader Party group'
    1010:
      id: 'invalid_party_role_qualifier_for_investment_decision_maker'
      doc: 'Invalid Party Role Qualifier for Investment Decision Maker Party group'
    1012:
      id: 'cannot_modify_mifid_flags'
      doc: 'Cannot modify MiFID flags'
    1013:
      id: 'wrong_display_qty_value'
      doc: 'The display quantity (displayQty) cannot exceed the order quantity'
    1014:
      id: 'invalid_display_qty'
      doc: 'The Display quantity (displayQty) not allowed for specified order type - only for Iceberg'
    1015:
      id: 'iceberg_order_value_less_than_required'
      doc: 'The value of the iceberg order is less than the required'
    1019:
      id: 'cod_disabled_for_the_connection_id'
      doc: 'Attempt to submit an order with ExecInst = CancelOnConnectionLoss, while CoD being disabled for the ConnectionID used'
    1025:
      id: 'order_quantity_must_be_greater_than_minimum_quantity'
      doc: 'The order quantity must be greater than the minimum quanity'
    1026:
      id: 'order_quantity_must_be_lower_than_maximum_quantity'
      doc: 'The order quantity must be lower than the maximum quantity'
    1027:
      id: 'order_price_must_be_greater_than_minimum_price'
      doc: 'The order price must be greater than minimum price'
    1028:
      id: 'order_price_must_be_lower_than_maximum_price'
      doc: 'The order price must be greater than maximum price'
    1029:
      id: 'order_price_must_be_nonzero'
      doc: 'The order price must be non-zero'
    1030:
      id: 'order_value_must_be_greater_than_minimum_value'
      doc: 'The order value must be greater than minimum value'
    1031:
      id: 'order_value_must_be_lower_than_maximum_value'
      doc: 'The order value must be lower than maximum value'
    1032:
      id: 'invalid_ord_type_for_selected_market_model'
      doc: 'Invalid OrdType for selected market model'
    1034:
      id: 'leaves_quantity_must_be_greater_than_zero_after_modification'
      doc: 'The remaining quantity (LeavesQty) must be greater than 0 after the modification'
    1035:
      id: 'price_not_allowed'
      doc: 'The price is not allowed for a market order. In the binary protocol, the price field should have a value of 0'
    1039:
      id: 'invalid_time_in_force_for_order_type'
      doc: 'Invalid TimeInForce for specified OrderType'
    1040:
      id: 'invalid_time_in_force_for_current_market_phase'
      doc: 'Invalid TimeInForce for current market phase'
    1041:
      id: 'invalid_time_in_force_for_selected_market_model'
      doc: 'Invalid TimeInForce for selected market model'
    1042:
      id: 'forbidden_ord_type_and_time_in_force_combination_for_market_segment'
      doc: 'Time In Force vs. Order Type combination restriction per Market Segment imposed by Market Operator'
    1043:
      id: 'expire_time_cannot_be_modified'
      doc: 'ExpireTime (126) cannot be modified'
    1044:
      id: 'obsolete_expire_date'
      doc: 'ExpireDate (432) not allowed for selected TimeInForce (59)'
    1045:
      id: 'expire_date_in_past'
      doc: 'The expiration date is earlier than the current date'
    1046:
      id: 'obsolete_expire_time'
      doc: 'ExpireTime (126) not allowed for selected TimeInForce (59)'
    1047:
      id: 'expire_time_in_past'
      doc: 'The expiration time is earlier than the current time'
    1048:
      id: 'ambigous_expire'
      doc: 'Please provide either a time or a date, but not both'
    1049:
      id: 'expire_date_exceeds_limit'
      doc: 'The expiration date exceeds the allowed limit'
    1037:
      id: 'price_below_low_collar'
      doc: 'The validation for collars has failed. The price is too low'
    1038:
      id: 'price_above_high_collar'
      doc: 'The validation for collars has failed. The price is too high'
    1050:
      id: 'firm_is_not_a_market_maker'
      doc: 'Firm is not a Market Maker for this SecurityID (48)'
    1055:
      id: 'missing_order_origination_for_sponsored_access_connection'
      doc: 'Missing OrderOrigination for sponsored access connection'
    1056:
      id: 'operation_on_redistributed_instruments_forbidden'
      doc: 'Operation on redistributed instruments forbidden'
    1057:
      id: 'firm_not_authorized_to_buy_and_sell_the_instrument'
      doc: 'Firm has not been granted permission to buy and sell the selected instrument. Order entry/modification/cancellation is not possible'
    1058:
      id: 'firm_not_authorized_to_buy_the_instrument'
      doc: 'Firm has not been granted permission to buy the selected instrument (only selling is allowed). Order entry/modification/cancellation on the buy side is not possible'
    1059:
      id: 'firm_not_authorized_to_sell_the_instrument'
      doc: 'Firm has not been granted permission to sell the selected instrument (only buying is allowed). Order entry/modification/cancellation on the sell side is not possible'
    1060:
      id: 'operations_on_orders_and_quotes_forbidden_during_uncrossing'
      doc: 'Entry/modification/cancellation of orders and quotes is not possible when an instrument is being uncrossed'
    1061:
      id: 'operations_on_orders_and_quotes_forbidden_during_instrument_suspension'
      doc: 'Entry/modification/cancellation of orders and quotes is not possible when an instrument is suspended'
    1062:
      id: 'operations_on_orders_and_quotes_forbidden_due_to_drop_copy_disconnection'
      doc: 'Operations on orders and quotes forbidden due to Drop Copy disconnection'
    1063:
      id: 'trigger_price_not_allowed'
      doc: 'The trigger price not allowed for a specified order type'
    1064:
      id: 'trigger_price_not_higher_than_ltp'
      doc: 'The trigger price is not higher than the last trade price'
    1065:
      id: 'trigger_price_not_lower_than_ltp'
      doc: 'The trigger price is not lower than the last trade price'
    1066:
      id: 'trigger_price_lower_than_price'
      doc: 'The trigger price is lower than the limit price'
    1067:
      id: 'trigger_price_higher_than_price'
      doc: 'The trigger price is higher than the limit price'
    1068:
      id: 'trigger_price_modified_for_activated_order'
      doc: 'The trigger price has been modified for the activated order'
    1069:
      id: 'trigger_price_must_be_greater_than_zero'
      doc: 'TriggerPrice (1102) must be greater than 0'
    1070:
      id: 'invalid_party_id_for_client_id'
      doc: 'Invalid PartyID (448) for Client ID'
    1071:
      id: 'invalid_party_id_for_executing_trader'
      doc: 'Invalid PartyID (448) for Executing Trader'
    1072:
      id: 'invalid_party_id_for_investment_decision_maker'
      doc: 'Invalid PartyID (448) for Investment Decision Maker'
    1075:
      id: 'invalid_party_role_qualifier_for_party_id'
      doc: 'Invalid PartyRoleQualifier (2376) for PartyID (448)'
    1076:
      id: 'missing_clearing_member_code'
      doc: 'Missing ClearingMemberCode'
    1077:
      id: 'forbidden_clearing_member_code'
      doc: 'Forbidden ClearingMemberCode'
    1078:
      id: 'invalid_client_id_for_sponsored_connection'
      doc: 'Invalid Client ID for sponsored connection'
    1079:
      id: 'invalid_ord_type_for_sponsored_connection'
      doc: 'Invalid OrdType for sponsored connection'
    1080:
      id: 'forbidden_order_capacity_value_for_sponsored_connection'
      doc: 'Forbidden OrderCapacity value for sponsored connection'
    1081:
      id: 'market_model_not_supported_on_sponsored_connection'
      doc: 'Market Model not supported sponsored connection'
    1083:
      id: 'invalid_time_in_force_for_sponsored_connection'
      doc: 'Invalid TimeInForce for sponsored connection'
    1084:
      id: 'operation_forbidden_during_early_late_monitoring'
      doc: 'Entry/modification/cancellation of orders and quotes by members, as well as block and cross trades submission is not allowed when an instrument remains in Early / Late Monitoring market phases'
    1085:
      id: 'invalid_clearing_member_code_length'
      doc: 'Clearing Member code must be 4-digit number in case of custom codes and 20-char string in case of LEI'
    1086:
      id: 'operation_unsuccessful_retry_needed'
      doc: 'Operation could not be completed successfully due to a temporary lock. Resending the request is advised'
    1201:
      id: 'mass_quote_not_allowed_for_selected_market_model'
      doc: 'Mass Quote not allowed for selected Market Model'
    1203:
      id: 'instrument_closed'
      doc: 'Instrument closed for trading'
    1208:
      id: 'invalid_bid_ask_spread'
      doc: 'OfferPx (133) must be greater than BidPx (132)'
    1209:
      id: 'not_authorized_to_quote_instrument'
      doc: 'Firm is not a Market Maker for this SecurityID (48)'
    1301:
      id: 'buy_order_not_allowed'
      doc: 'Buy orders from participants are not allowed in BuyOnly phase'
    1307:
      id: 'stop_orders_not_allowed'
      doc: 'Stop Orders not allowed when no opposite LP quote available'
    1308:
      id: 'trigger_price_must_be_higher_than_lp_sell_quote'
      doc: 'TriggerPrice (1102) must be higher than LP sell quote for buy Stop Order'
    1309:
      id: 'trigger_price_must_be_lower_than_lp_buy_quote'
      doc: 'TriggerPrice (1102) must be lower than LP buy quote for sell Stop Order'
    1310:
      id: 'market_making_via_mass_quote_only_on_hybrid_market'
      doc: 'Market Making in Hybrid market model is only possible using Mass Quote message'
    1311:
      id: 'sell_quotes_not_allowed_during_buy_only_state'
      doc: 'During BuyOnly state in Hybrid market model sell quotes are not accepted'
    1312:
      id: 'instrument_knocked_out'
      doc: 'As soon as the instrument''s knock-out barrier is reached by the underlying, any orders/quotes are no longer accepted into the order book'
    1401:
      id: 'only_one_sell_order_is_allowed_for_ipo'
      doc: 'Only one sell order is allowed for IPO instrument'
    1402:
      id: 'only_one_buy_order_is_allowed_for_tender'
      doc: 'Only one buy order is allowed for Tender instrument'
    2026:
      id: 'request_not_allowed_for_block_instrument'
      doc: 'Request not allowed for BLOCK instrument'
    2028:
      id: 'request_not_allowed_for_cross_instrument'
      doc: 'Request not allowed for CROSS instrument'
    7000:
      id: 'risk_limit_not_defined'
      doc: 'The risk limit has not been defined'
    7001:
      id: 'risk_maximum_order_volume_exceeded'
      doc: 'The maximum order volume for the risk limit has been exceeded'
    7002:
      id: 'risk_maximum_order_value_exceeded'
      doc: 'The maximum order value for the risk limit has been exceeded'
    7003:
      id: 'risk_order_price_collar_exceeded'
      doc: 'The order price has exceeded the risk limit'
    7004:
      id: 'dynamic_order_price_collar_not_defined'
      doc: 'Dynamic Order Price Collar not defined'
    7005:
      id: 'static_order_price_collar_not_defined'
      doc: 'Static Order Price Collar not defined'
    7011:
      id: 'total_traded_value_exceeded'
      doc: 'Total traded value has exceeded the risk limit'
    7012:
      id: 'total_traded_buy_value_exceeded'
      doc: 'Total traded buy value has exceeded the risk limit'
    7013:
      id: 'total_traded_sell_value_exceeded'
      doc: 'Total traded sell value has exceeded the risk limit'
    7014:
      id: 'total_open_value_exceeded'
      doc: 'Total open value has exceeded the risk limit'
    7015:
      id: 'total_open_buy_value_exceeded'
      doc: 'Total open buy value has exceeded the risk limit'
    7016:
      id: 'total_open_sell_value_exceeded'
      doc: 'Total open sell value has exceeded the risk limit'
    7017:
      id: 'total_risk_value_exceeded'
      doc: 'Total risk value has exceeded the risk limit'
    7018:
      id: 'total_buy_risk_value_exceeded'
      doc: 'Total buy risk value has exceeded the risk limit'
    7019:
      id: 'total_sell_risk_value_exceeded'
      doc: 'Total sell risk value has exceeded the risk limit'
    7020:
      id: 'total_net_risk_value_exceeded'
      doc: 'Total net risk value has exceeded the risk limit'
    7021:
      id: 'max_order_count_exceeded'
      doc: 'Maximum order count has exceeded the risk limit'
    7022:
      id: 'rejected_due_to_kill_switch_activation'
      doc: 'Rejected due to kill switch activation'
  exec_type_reason:
    1:
      id: 'na'
      doc: 'Not applicable'
    2:
      id: 'cancel_on_disconnect'
      doc: 'Order cancelled by the canceller on client disconnect'
    3:
      id: 'expired'
      doc: 'Order cancelled by the canceller due to expiration'
    4:
      id: 'triggered'
      doc: 'Notification of Stop order activation'
    5:
      id: 'cancel_on_suspension'
      doc: 'Order cancelled by canceller due to instrument suspension'
    6:
      id: 'order_restatement'
      doc: 'Order reinstated'
    7:
      id: 'iceberg_order_refill'
      doc: 'Iceberg order refill'
    8:
      id: 'cancel_by_stp'
      doc: 'Order cancelled due to self-trade prevention'
    9:
      id: 'cancel_by_corporate_action'
      doc: 'Order cancelled due to submitted Corporate Action'
    10:
      id: 'cancel_by_mass_cancel'
      doc: 'Order cancelled due to mass cancel'
    11:
      id: 'cancel_ioc_fok_order'
      doc: 'Order cancelled due to IOC/FOK'
    12:
      id: 'cancel_by_market_operations'
      doc: 'Order cancelled due to market operations'
    13:
      id: 'replaced'
      doc: 'Order replaced'
    14:
      id: 'first_trade_on_aggressive_order'
      doc: 'First trade on aggressive order'
    15:
      id: 'rejected'
      doc: 'Order rejected'
    16:
      id: 'cancelon_buy_only_state_entry'
      doc: 'Cancel on BuyOnly state entry'
    17:
      id: 'cancelon_knocked_out_state_entry'
      doc: 'Cancel on KnockedOut state entry'
    18:
      id: 'cancel_by_risk_management'
      doc: 'Order cancelled due to exceeding RMA post trade limit'
    19:
      id: 'cancel_on_dc_disconnect'
      doc: 'Order cancelled due to drop copy disconnect'
    20:
      id: 'vfa_activated'
      doc: 'Notification of VFA/VFC order activation'
    21:
      id: 'hybrid_activated'
      doc: 'Notification of Hybrid order activation'
  priority_flag:
    1:
      id: 'lost'
      doc: 'The priority flag was lost'
    2:
      id: 'retained'
      doc: 'The priority flag was retained'
  mass_cancel_request_type:
    1:
      id: 'cancel_for_security'
      doc: 'Cancel orders for a security'
    7:
      id: 'cancel_all_orders'
      doc: 'Cancel all orders'
    9:
      id: 'cancel_orders_for_market_segment'
      doc: 'Cancel orders for a market segment'
  target_party_role:
    0:
      id: 'none'
      doc: 'No filtering'
    35:
      id: 'liquidity_provider'
      doc: 'Liquidity provider'
    54:
      id: 'sender_location'
      doc: 'Sender location'
    66:
      id: 'market_maker'
      doc: 'Market maker'
    3:
      id: 'client_id'
      doc: 'Client ID'
    12:
      id: 'executing_trader'
      doc: 'Executing trader'
    122:
      id: 'investment_decision_maker'
      doc: 'Investment decision maker'
  reason_mass_cancel_rejection_reason:
    99:
      id: 'other'
      doc: 'Other'
    101:
      id: 'na'
      doc: 'Not applicable'
    1001:
      id: 'unknown_instrument'
      doc: 'Unknown instrument'
    1005:
      id: 'invalid_execution_trader'
      doc: 'Missing Executing Trader repeating group'
    1016:
      id: 'unknown_market_segment_id'
      doc: 'Unknown market segment ID'
    1017:
      id: 'unknown_connection_id'
      doc: 'Unknown connection ID'
    1053:
      id: 'instrument_forbidden'
      doc: 'Instrument forbidden'
    1054:
      id: 'market_segment_id_forbidden'
      doc: 'Market segment ID forbidden'
    1056:
      id: 'operation_on_redistributed_instruments_forbidden'
      doc: 'Operation on redistributed instruments forbidden'
    2025:
      id: 'request_not_allowed_on_sponsored_connection'
      doc: 'Request not allowed on sponsored connection'
  liquidity_indicator:
    1:
      id: 'buy_order_execution'
      doc: 'Buy order execution'
    2:
      id: 'sell_order_execution'
      doc: 'Sell order execution'
    3:
      id: 'auction_execution'
      doc: 'Auction execution'
    4:
      id: 'not_applicable'
      doc: 'Not applicable'
  currency:
    8:
      id: 'all'
      doc: 'Lek'
    12:
      id: 'dzd'
      doc: 'Algerian Dinar'
    32:
      id: 'ars'
      doc: 'Argentine Peso'
    36:
      id: 'aud'
      doc: 'Australian Dollar'
    44:
      id: 'bsd'
      doc: 'Bahamian Dollar'
    48:
      id: 'bhd'
      doc: 'Bahraini Dinar'
    50:
      id: 'bdt'
      doc: 'Taka'
    51:
      id: 'amd'
      doc: 'Armenian Dram'
    52:
      id: 'bbd'
      doc: 'Barbados Dollar'
    60:
      id: 'bmd'
      doc: 'Bermudian Dollar'
    64:
      id: 'btn'
      doc: 'Ngultrum'
    68:
      id: 'bob'
      doc: 'Boliviano'
    72:
      id: 'bwp'
      doc: 'Pula'
    84:
      id: 'bzd'
      doc: 'Belize Dollar'
    90:
      id: 'sbd'
      doc: 'Solomon Islands Dollar'
    96:
      id: 'bnd'
      doc: 'Brunei Dollar'
    104:
      id: 'mmk'
      doc: 'Kyat'
    108:
      id: 'bif'
      doc: 'Burundi Franc'
    116:
      id: 'khr'
      doc: 'Riel'
    124:
      id: 'cad'
      doc: 'Canadian Dollar'
    132:
      id: 'cve'
      doc: 'Cabo Verde Escudo'
    136:
      id: 'kyd'
      doc: 'Cayman Islands Dollar'
    144:
      id: 'lkr'
      doc: 'Sri Lanka Rupee'
    152:
      id: 'clp'
      doc: 'Chilean Peso'
    156:
      id: 'cny'
      doc: 'Yuan Renminbi'
    170:
      id: 'cop'
      doc: 'Colombian Peso'
    174:
      id: 'kmf'
      doc: 'Comorian Franc'
    188:
      id: 'crc'
      doc: 'Costa Rican Colon'
    191:
      id: 'hrk'
      doc: 'Kuna'
    192:
      id: 'cup'
      doc: 'Cuban Peso'
    203:
      id: 'czk'
      doc: 'Czech Koruna'
    208:
      id: 'dkk'
      doc: 'Danish Krone'
    214:
      id: 'dop'
      doc: 'Dominican Peso'
    222:
      id: 'svc'
      doc: 'El Salvador Colon'
    230:
      id: 'etb'
      doc: 'Ethiopian Birr'
    232:
      id: 'ern'
      doc: 'Nakfa'
    238:
      id: 'fkp'
      doc: 'Falkland Islands Pound'
    242:
      id: 'fjd'
      doc: 'Fiji Dollar'
    262:
      id: 'djf'
      doc: 'Djibouti Franc'
    270:
      id: 'gmd'
      doc: 'Dalasi'
    292:
      id: 'gip'
      doc: 'Gibraltar Pound'
    320:
      id: 'gtq'
      doc: 'Quetzal'
    324:
      id: 'gnf'
      doc: 'Guinean Franc'
    328:
      id: 'gyd'
      doc: 'Guyana Dollar'
    332:
      id: 'htg'
      doc: 'Gourde'
    340:
      id: 'hnl'
      doc: 'Lempira'
    344:
      id: 'hkd'
      doc: 'Hong Kong Dollar'
    348:
      id: 'huf'
      doc: 'Forint'
    352:
      id: 'isk'
      doc: 'Iceland Krona'
    356:
      id: 'inr'
      doc: 'Indian Rupee'
    360:
      id: 'idr'
      doc: 'Rupiah'
    364:
      id: 'irr'
      doc: 'Iranian Rial'
    368:
      id: 'iqd'
      doc: 'Iraqi Dinar'
    376:
      id: 'ils'
      doc: 'New Israeli Sheqel'
    388:
      id: 'jmd'
      doc: 'Jamaican Dollar'
    392:
      id: 'jpy'
      doc: 'Yen'
    398:
      id: 'kzt'
      doc: 'Tenge'
    400:
      id: 'jod'
      doc: 'Jordanian Dinar'
    404:
      id: 'kes'
      doc: 'Kenyan Shilling'
    408:
      id: 'kpw'
      doc: 'North Korean Won'
    410:
      id: 'krw'
      doc: 'Won'
    414:
      id: 'kwd'
      doc: 'Kuwaiti Dinar'
    417:
      id: 'kgs'
      doc: 'Som'
    418:
      id: 'lak'
      doc: 'Lao Kip'
    422:
      id: 'lbp'
      doc: 'Lebanese Pound'
    426:
      id: 'lsl'
      doc: 'Loti'
    430:
      id: 'lrd'
      doc: 'Liberian Dollar'
    434:
      id: 'lyd'
      doc: 'Libyan Dinar'
    446:
      id: 'mop'
      doc: 'Pataca'
    454:
      id: 'mwk'
      doc: 'Malawi Kwacha'
    458:
      id: 'myr'
      doc: 'Malaysian Ringgit'
    462:
      id: 'mvr'
      doc: 'Rufiyaa'
    480:
      id: 'mur'
      doc: 'Mauritius Rupee'
    484:
      id: 'mxn'
      doc: 'Mexican Peso'
    496:
      id: 'mnt'
      doc: 'Tugrik'
    498:
      id: 'mdl'
      doc: 'Moldovan Leu'
    504:
      id: 'mad'
      doc: 'Moroccan Dirham'
    512:
      id: 'omr'
      doc: 'Rial Omani'
    516:
      id: 'nad'
      doc: 'Namibia Dollar'
    524:
      id: 'npr'
      doc: 'Nepalese Rupee'
    532:
      id: 'ang'
      doc: 'Netherlands Antillean Guilder'
    533:
      id: 'awg'
      doc: 'Aruban Florin'
    548:
      id: 'vuv'
      doc: 'Vatu'
    554:
      id: 'nzd'
      doc: 'New Zealand Dollar'
    558:
      id: 'nio'
      doc: 'Cordoba Oro'
    566:
      id: 'ngn'
      doc: 'Naira'
    578:
      id: 'nok'
      doc: 'Norwegian Krone'
    586:
      id: 'pkr'
      doc: 'Pakistan Rupee'
    590:
      id: 'pab'
      doc: 'Balboa'
    598:
      id: 'pgk'
      doc: 'Kina'
    600:
      id: 'pyg'
      doc: 'Guarani'
    604:
      id: 'pen'
      doc: 'Sol'
    608:
      id: 'php'
      doc: 'Philippine Peso'
    634:
      id: 'qar'
      doc: 'Qatari Rial'
    643:
      id: 'rub'
      doc: 'Russian Ruble'
    646:
      id: 'rwf'
      doc: 'Rwanda Franc'
    654:
      id: 'shp'
      doc: 'Saint Helena Pound'
    682:
      id: 'sar'
      doc: 'Saudi Riyal'
    690:
      id: 'scr'
      doc: 'Seychelles Rupee'
    702:
      id: 'sgd'
      doc: 'Singapore Dollar'
    704:
      id: 'vnd'
      doc: 'Dong'
    706:
      id: 'sos'
      doc: 'Somali Shilling'
    710:
      id: 'zar'
      doc: 'Rand'
    728:
      id: 'ssp'
      doc: 'South Sudanese Pound'
    748:
      id: 'szl'
      doc: 'Lilangeni'
    752:
      id: 'sek'
      doc: 'Swedish Krona'
    756:
      id: 'chf'
      doc: 'Swiss Franc'
    760:
      id: 'syp'
      doc: 'Syrian Pound'
    764:
      id: 'thb'
      doc: 'Baht'
    776:
      id: 'top'
      doc: 'Pa’anga'
    780:
      id: 'ttd'
      doc: 'Trinidad and Tobago Dollar'
    784:
      id: 'aed'
      doc: 'UAE Dirham'
    788:
      id: 'tnd'
      doc: 'Tunisian Dinar'
    800:
      id: 'ugx'
      doc: 'Uganda Shilling'
    807:
      id: 'mkd'
      doc: 'Denar'
    818:
      id: 'egp'
      doc: 'Egyptian Pound'
    826:
      id: 'gbp'
      doc: 'Pound Sterling'
    834:
      id: 'tzs'
      doc: 'Tanzanian Shilling'
    840:
      id: 'usd'
      doc: 'US Dollar'
    858:
      id: 'uyu'
      doc: 'Peso Uruguayo'
    860:
      id: 'uzs'
      doc: 'Uzbekistan Sum'
    882:
      id: 'wst'
      doc: 'Tala'
    886:
      id: 'yer'
      doc: 'Yemeni Rial'
    901:
      id: 'twd'
      doc: 'New Taiwan Dollar'
    925:
      id: 'sle'
      doc: 'Leone'
    926:
      id: 'ved'
      doc: 'Bolívar Soberano'
    927:
      id: 'uyw'
      doc: 'Unidad Previsional'
    928:
      id: 'ves'
      doc: 'Bolívar Soberano'
    929:
      id: 'mru'
      doc: 'Ouguiya'
    930:
      id: 'stn'
      doc: 'Dobra'
    931:
      id: 'cuc'
      doc: 'Peso Convertible'
    932:
      id: 'zwl'
      doc: 'Zimbabwe Dollar'
    933:
      id: 'byn'
      doc: 'Belarusian Ruble'
    934:
      id: 'tmt'
      doc: 'Turkmenistan New Manat'
    936:
      id: 'ghs'
      doc: 'Ghana Cedi'
    938:
      id: 'sdg'
      doc: 'Sudanese Pound'
    940:
      id: 'uyi'
      doc: 'Uruguay Peso en Unidades Indexadas (URUIURUI)'
    941:
      id: 'rsd'
      doc: 'Serbian Dinar'
    943:
      id: 'mzn'
      doc: 'Mozambique Metical'
    944:
      id: 'azn'
      doc: 'Azerbaijan Manat'
    946:
      id: 'ron'
      doc: 'Romanian Leu'
    947:
      id: 'che'
      doc: 'WIR Euro'
    948:
      id: 'chw'
      doc: 'WIR Franc'
    949:
      id: 'try_field'
      doc: 'Turkish Lira'
    950:
      id: 'xaf'
      doc: 'CFA Franc BEAC'
    951:
      id: 'xcd'
      doc: 'East Caribbean Dollar'
    952:
      id: 'xof'
      doc: 'CFA Franc BCEAO'
    953:
      id: 'xpf'
      doc: 'CFP Franc'
    955:
      id: 'xba'
      doc: 'Bond Markets Unit European Composite Unit (EURCO)'
    956:
      id: 'xbb'
      doc: 'Bond Markets Unit European Monetary Unit (E.M.U.-6)'
    957:
      id: 'xbc'
      doc: 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)'
    958:
      id: 'xbd'
      doc: 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)'
    959:
      id: 'xau'
      doc: 'Gold'
    960:
      id: 'xdr'
      doc: 'SDR (Special Drawing Right)'
    961:
      id: 'xag'
      doc: 'Silver'
    962:
      id: 'xpt'
      doc: 'Platinum'
    963:
      id: 'xts'
      doc: 'Codes specifically reserved for testing purposes'
    964:
      id: 'xpd'
      doc: 'Palladium'
    965:
      id: 'xua'
      doc: 'ADB Unit of Account'
    967:
      id: 'zmw'
      doc: 'Zambian Kwacha'
    968:
      id: 'srd'
      doc: 'Surinam Dollar'
    969:
      id: 'mga'
      doc: 'Malagasy Ariary'
    970:
      id: 'cou'
      doc: 'Unidad de Valor Real'
    971:
      id: 'afn'
      doc: 'Afghani'
    972:
      id: 'tjs'
      doc: 'Somoni'
    973:
      id: 'aoa'
      doc: 'Kwanza'
    975:
      id: 'bgn'
      doc: 'Bulgarian Lev'
    976:
      id: 'cdf'
      doc: 'Congolese Franc'
    977:
      id: 'bam'
      doc: 'Convertible Mark'
    978:
      id: 'eur'
      doc: 'Euro'
    979:
      id: 'mxv'
      doc: 'Unidad de inversion (UDI)'
    980:
      id: 'uah'
      doc: 'Hryvnia'
    981:
      id: 'gel'
      doc: 'Lari'
    984:
      id: 'bov'
      doc: 'Mvdol'
    985:
      id: 'pln'
      doc: 'Zloty'
    986:
      id: 'brl'
      doc: 'Brazilian Real'
    990:
      id: 'clf'
      doc: 'Unidad de Fomento'
    994:
      id: 'xsu'
      doc: 'Sucre'
    997:
      id: 'usn'
      doc: 'US Dollar (next day)'
    999:
      id: 'xxx'
      doc: 'The codes assigned for transactions where no currency is involved'
  status_mass_quote_status:
    1:
      id: 'accepted'
      doc: 'Mass quote acknowledged by system'
    2:
      id: 'rejected'
      doc: 'Mass quote rejected'
  reason_mass_quote_rejection_reason:
    1:
      id: 'na'
      doc: 'Not applicable'
    2:
      id: 'exchange_closed'
      doc: 'Exchange closed'
    99:
      id: 'other'
      doc: 'Other'
    1005:
      id: 'invalid_execution_trader'
      doc: 'Invalid execution trader'
    1006:
      id: 'invalid_decision_maker'
      doc: 'Invalid decision maker'
    1007:
      id: 'invalid_client_id'
      doc: 'Invalid client'
    1008:
      id: 'invalid_party_role_qualifier_for_client_id'
      doc: 'Invalid Party Role Qualifier for Client Id Party group'
    1009:
      id: 'invalid_party_role_qualifier_for_executing_trader'
      doc: 'Invalid Party Role Qualifier for Executing Trader Party group'
    1010:
      id: 'invalid_party_role_qualifier_for_investment_decision_maker'
      doc: 'Invalid Party Role Qualifier for Investment Decision Maker Party group'
    1055:
      id: 'missing_order_origination_for_sponsored_access_connection'
      doc: 'Missing OrderOrigination for sponsored access connection'
    1061:
      id: 'operations_on_orders_and_quotes_forbidden_during_instrument_suspension'
      doc: 'Entry/modification/cancellation of orders and quotes is not possible when an instrument is suspended'
    1070:
      id: 'invalid_party_id_for_client_id'
      doc: 'Invalid PartyID (448) for Client ID'
    1071:
      id: 'invalid_party_id_for_executing_trader'
      doc: 'Invalid PartyID (448) for Executing Trader'
    1072:
      id: 'invalid_party_id_for_investment_decision_maker'
      doc: 'Invalid PartyID (448) for Investment Decision Maker'
    1075:
      id: 'invalid_party_role_qualifier_for_party_id'
      doc: 'Invalid PartyRoleQualifier (2376) for PartyID (448)'
    1076:
      id: 'missing_clearing_member_code'
      doc: 'Missing ClearingMemberCode'
    1077:
      id: 'forbidden_clearing_member_code'
      doc: 'Forbidden ClearingMemberCode'
    1078:
      id: 'invalid_client_id_for_sponsored_connection'
      doc: 'Invalid Client ID for sponsored connection'
    1080:
      id: 'forbidden_order_capacity_value_for_sponsored_connection'
      doc: 'Forbidden OrderCapacity value for sponsored connection'
    1081:
      id: 'market_model_not_supported_on_sponsored_connection'
      doc: 'Market Model not supported sponsored connection'
    1085:
      id: 'invalid_clearing_member_code_length'
      doc: 'Clearing Member code must be 4-digit number in case of custom codes and 20-char string in case of LEI'
    1202:
      id: 'duplicate_instrument'
      doc: 'Multiple quotes for the same instrument within Mass Quote message'
    1204:
      id: 'invalid_quotes_count'
      doc: 'Invalid quotes count value'
    1210:
      id: 'forbidden_order_capacity_value'
      doc: 'Forbidden OrderCapacity (528) value for Mass Quote'
    1212:
      id: 'liquidity_provision_activity_flag_not_set_for_mass_quote'
      doc: 'LiquidityProvisionActivity flag (within mifidFields.flags) in binary Mass Quote meesage must be always set to 1'
  action:
    1:
      id: 'change_to_hybrid_buy_only'
      doc: 'Change To Hybrid Buy Only'
    2:
      id: 'change_to_knock_out'
      doc: 'Change To Knock Out'
    3:
      id: 'revoke_knock_out'
      doc: 'Revoke Knock Out'
  result_command_result:
    1:
      id: 'success'
      doc: 'Success'
    2:
      id: 'failure'
      doc: 'Failure'
  rejection_code:
    99:
      id: 'other'
      doc: 'Other'
    1001:
      id: 'unknown_instrument'
      doc: 'Unknown Instrument'
    1304:
      id: 'firm_not_authorized_for_mm_command'
      doc: 'Market Maker Command may be submitted only by firm that is a Market Maker for the instrument'
    1313:
      id: 'instrument_already_knocked_out'
      doc: 'Attempt to knock-out an instrument that is already in knocked-out state'
    1314:
      id: 'mm_cannot_revoke_market_operation_knock_out'
      doc: 'Market Maker''s attempt to revoke Market Operation''s knock-out on an instrument'
    1315:
      id: 'knock_out_or_revoke_knock_out_operations_not_allowed_during_instrument_suspension'
      doc: 'Cannot knockout or revoke knockout for suspended instrument'
    1316:
      id: 'revoke_knock_out_operations_not_allowed_once_barrier_is_reached'
      doc: 'Revoke knockout cannot be submitted once knock-out barrier has been reached'
    1317:
      id: 'mm_command_not_allowed_for_selected_market_model'
      doc: 'Market maker command not allowed for selected market model'
    1318:
      id: 'revoke_knock_out_operations_not_allowed_for_active_instrument'
      doc: 'Revoke hybrid knockout command is not applicable for active instruments'
    2026:
      id: 'request_not_allowed_for_block_instrument'
      doc: 'BLOCK instrument cannot be put in hybrid knockout'
    2027:
      id: 'request_not_allowed_for_clob_instrument'
      doc: 'CLOB instrument cannot be put in hybrid knockout'
    2028:
      id: 'request_not_allowed_for_cross_instrument'
      doc: 'CROSS instrument cannot be put in hybrid knockout'
    3002:
      id: 'exchange_closed'
      doc: 'Exchange Closed'
    3009:
      id: 'firm_not_authorized_to_quote_instrument'
      doc: 'Firm Not Authorized To Quote Instrument'
    3020:
      id: 'command_not_allowed_in_current_state'
      doc: 'Command Not Allowed In Current State'
  reason_request_for_execution_reason:
    1:
      id: 'passive_quote'
      doc: 'Passive Quote'
    2:
      id: 'aggressive_quote'
      doc: 'Aggressive Quote'
  update_type:
    1:
      id: 'ipo'
      doc: 'Ipo'
    2:
      id: 'tender_offer'
      doc: 'Tender Offer'
  trade_report_trans_type:
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'cancel'
      doc: 'Cancel'
    3:
      id: 'replace'
      doc: 'Replace'
  trade_report_type:
    1:
      id: 'submit'
      doc: 'Submit'
    2:
      id: 'alleged'
      doc: 'Alleged'
    3:
      id: 'accept'
      doc: 'Accept'
    4:
      id: 'decline'
      doc: 'Decline'
    7:
      id: 'trade_report_cancel'
      doc: 'Trade Report Cancel'
    8:
      id: 'trade_break'
      doc: 'Trade Break'
  trade_type:
    22:
      id: 'privately_negotiated_trade'
      doc: 'Privately negotiated trade'
    38:
      id: 'block_trade'
      doc: 'Block trade'
  algorithmic_trade_indicator:
    1:
      id: 'na'
      doc: 'Not applicable'
    2:
      id: 'non_algorithmic_trade'
      doc: 'Non-algorithmic trade'
    3:
      id: 'algorithmic_trade'
      doc: 'Algorithmic trade'
  exec_type:
    1:
      id: 'na'
      doc: 'Not applicable'
    8:
      id: 'rejected'
      doc: 'Rejected'
    12:
      id: 'expired'
      doc: 'Expired'
    15:
      id: 'trade'
      doc: 'Trade'
    16:
      id: 'trade_correct'
      doc: 'Trade Correct'
    17:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
  order_capacity:
    1:
      id: 'agency'
      doc: 'Agency (mapped to AOTC)'
    2:
      id: 'principal'
      doc: 'Principal (mapped to DEAL)'
    3:
      id: 'riskless_principal'
      doc: 'Riskless Principal (mapped to MTCH)'
  status_tcr_status:
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'accepted'
      doc: 'Accepted'
    3:
      id: 'rejected'
      doc: 'Rejected'
    4:
      id: 'cancelled'
      doc: 'Cancelled'
  reason_tcr_rejection_reason:
    1:
      id: 'na'
      doc: 'Not applicable'
    2:
      id: 'exchange_closed'
      doc: 'Exchange closed'
    18:
      id: 'invalid_price_increment'
      doc: 'Invalid price increment'
    99:
      id: 'other'
      doc: 'Other'
    106:
      id: 'instrument_phase_no_trading'
      doc: 'Trading is not available for the instrument in its current phase'
    1001:
      id: 'unknown_instrument'
      doc: 'Unknown instrument'
    1005:
      id: 'invalid_execution_trader'
      doc: 'Invalid execution trader'
    1006:
      id: 'invalid_decision_maker'
      doc: 'Invalid decision maker'
    1007:
      id: 'invalid_client_id'
      doc: 'Invalid client'
    1008:
      id: 'invalid_party_role_qualifier_for_client_id'
      doc: 'Invalid Party Role Qualifier for Client Id Party group'
    1009:
      id: 'invalid_party_role_qualifier_for_executing_trader'
      doc: 'Invalid Party Role Qualifier for Executing Trader Party group'
    1010:
      id: 'invalid_party_role_qualifier_for_investment_decision_maker'
      doc: 'Invalid Party Role Qualifier for Investment Decision Maker Party group'
    1025:
      id: 'order_quantity_must_be_greater_than_minimum_quantity'
      doc: 'The order quantity must be greater than the minimum quanity'
    1026:
      id: 'order_quantity_must_be_lower_than_maximum_quantity'
      doc: 'The order quantity must be lower than the maximum quantity'
    1027:
      id: 'order_price_must_be_greater_than_minimum_price'
      doc: 'The order price must be greater than minimum price'
    1028:
      id: 'order_price_must_be_lower_than_maximum_price'
      doc: 'The order price must be greater than maximum price'
    1029:
      id: 'order_price_must_be_nonzero'
      doc: 'The order price must be non-zero'
    1030:
      id: 'order_value_must_be_greater_than_minimum_value'
      doc: 'The order value must be greater than minimum value'
    1031:
      id: 'order_value_must_be_lower_than_maximum_value'
      doc: 'The order value must be lower than maximum value'
    1037:
      id: 'price_below_low_collar'
      doc: 'The validation for collars has failed. The price is too low'
    1038:
      id: 'price_above_high_collar'
      doc: 'The validation for collars has failed. The price is too high'
    1050:
      id: 'firm_is_not_a_market_maker'
      doc: 'Firm is not a Market Maker for this SecurityID (48)'
    1056:
      id: 'operation_on_redistributed_instruments_forbidden'
      doc: 'Operation on redistributed instruments forbidden'
    1057:
      id: 'firm_not_authorized_to_buy_and_sell_the_instrument'
      doc: 'Firm has not been granted permission to buy and sell the selected instrument. Order entry/modification/cancellation is not possible'
    1058:
      id: 'firm_not_authorized_to_buy_the_instrument'
      doc: 'Firm has not been granted permission to buy the selected instrument (only selling is allowed). Order entry/modification/cancellation on the buy side is not possible'
    1059:
      id: 'firm_not_authorized_to_sell_the_instrument'
      doc: 'Firm has not been granted permission to sell the selected instrument (only buying is allowed). Order entry/modification/cancellation on the sell side is not possible'
    1061:
      id: 'operations_on_orders_and_quotes_forbidden_during_instrument_suspension'
      doc: 'Entry/modification/cancellation of orders and quotes is not possible when an instrument is suspended'
    1070:
      id: 'invalid_party_id_for_client_id'
      doc: 'Invalid PartyID (448) for Client ID'
    1071:
      id: 'invalid_party_id_for_executing_trader'
      doc: 'Invalid PartyID (448) for Executing Trader'
    1072:
      id: 'invalid_party_id_for_investment_decision_maker'
      doc: 'Invalid PartyID (448) for Investment Decision Maker'
    1075:
      id: 'invalid_party_role_qualifier_for_party_id'
      doc: 'Invalid PartyRoleQualifier (2376) for PartyID (448)'
    1076:
      id: 'missing_clearing_member_code'
      doc: 'Missing ClearingMemberCode'
    1077:
      id: 'forbidden_clearing_member_code'
      doc: 'Forbidden ClearingMemberCode'
    1081:
      id: 'market_model_not_supported_on_sponsored_connection'
      doc: 'Market Model not supported sponsored connection'
    1084:
      id: 'operation_forbidden_during_early_late_monitoring'
      doc: 'Entry/modification/cancellation of orders and quotes by members, as well as block and cross trades submission is not allowed when an instrument remains in Early / Late Monitoring market phases'
    1085:
      id: 'invalid_clearing_member_code_length'
      doc: 'Clearing Member code must be 4-digit number in case of custom codes and 20-char string in case of LEI'
    1209:
      id: 'not_authorized_to_quote_instrument'
      doc: 'Firm is not a Market Maker for this SecurityID (48)'
    2001:
      id: 'unknown_trade_report'
      doc: 'Unknown trade report'
    2002:
      id: 'duplicate_trade_report_id'
      doc: 'Duplicate TradeReportId'
    2005:
      id: 'trade_report_type_not_compatible_with_trade_report_trans_type'
      doc: 'TradeReportType not compatible with TradeReportTransType'
    2008:
      id: 'invalid_exec_type'
      doc: 'Invalid ExecType'
    2009:
      id: 'trade_report_ref_id_not_allowed'
      doc: 'TradeReportRefId not allowed'
    2015:
      id: 'settlement_date_cannot_be_earlier_than_minimum_settlement_date'
      doc: 'Settlement date cannot be earlier than minimum settlement date'
    2016:
      id: 'settlement_date_cannot_be_later_than_maximum_settlement_date'
      doc: 'Settlement date cannot be later than maximum settlement date'
    2017:
      id: 'settlement_date_must_be_a_settlement_day'
      doc: 'In case settlement date provided does not follow settlement calendar'
    2022:
      id: 'unknown_contra_firm'
      doc: 'Unknown contra firm'
    2024:
      id: 'sent_attribute_does_not_match_original_value'
      doc: 'Sent attribute does not match original value'
    2026:
      id: 'request_not_allowed_for_block_instrument'
      doc: 'Request not allowed for BLOCK instrument'
    2027:
      id: 'request_not_allowed_for_clob_instrument'
      doc: 'Request not allowed for CLOB instrument'
    2028:
      id: 'request_not_allowed_for_cross_instrument'
      doc: 'Request not allowed for CROSS instrument'
    2030:
      id: 'cross_not_allowed_outside_of_clob_instrument_spread'
      doc: 'Cross not allowed outside of CLOB instrument spread'
    2031:
      id: 'cross_price_not_equal_to_the_reference_price'
      doc: 'Cross price not equal to the reference price'
    2032:
      id: 'cross_not_allowed_during_clob_instrument_auction_or_suspension'
      doc: 'Cross not allowed during CLOB instrument Auction or Suspension'
    2033:
      id: 'forbidden_secondary_tradereport_id'
      doc: 'Forbidden SecondaryTradeReportID'
    2034:
      id: 'unknown_secondary_tradereport_id'
      doc: 'Unknown SecondaryTradeReportID'
    2035:
      id: 'no_trade_for_clob_reference_instrument'
      doc: 'Trading on BLOCK and CROSS instruments is not alllowed, because linked CLOB instrument has not been traded yet'

