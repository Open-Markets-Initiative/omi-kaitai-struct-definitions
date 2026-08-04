# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse ArcaOptions BinaryGateway PillarStream v3.15
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Binary Gateway
#   Encoding: Pillar Stream Protocol
#   Version: 3.15
#   Date: 5/8/2023
#   Specification: NYSE_Pillar_Options_Gateway_Binary_Protocol_Specification.pdf
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
# The Binary Data Compiler technologies used to produce this file
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
  id: arcaoptions_binarygateway_v3_15
  title: Nyse ArcaOptions BinaryGateway PillarStream v3.15
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Options Binary Gateway PillarStream v3.15'
doc-ref: https://www.nyse.com/connectivity/specs

seq:
  - id: login_message
    type: login_message_struct
    doc: 'Client must send Login before any other message'
  - id: login_response
    type: login_response_struct
    doc: 'Pillar Stream Login Response Message Branch'
  - id: stream_avail
    type: stream_avail_struct
    doc: 'The message contains stream ID and sequence of next message on stream'
  - id: heartbeat
    type: heartbeat_struct
    doc: 'Heartbeat must be sent once a second'
  - id: open
    type: open_struct
    doc: 'Request open a stream for reading or writing'
  - id: open_response
    type: open_response_struct
    doc: 'Response to Open'
  - id: close
    type: close_struct
    doc: 'Request close stream'
  - id: close_response
    type: close_response_struct
    doc: 'Response to Close Message'
  - id: seq_msg
    type: seq_msg_struct
    doc: 'Used to transmit a stream message'

types:
  login_message_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: password
        type: str
        size: 32
        encoding: ASCII
        doc: 'User password in plain text'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code (MIC) of the connected market'
      - id: version
        type: str
        size: 20
        encoding: ASCII
        doc: 'Protocol version, should be 1.1'
  msg_header:
    seq:
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Pillar stream message type'
      - id: msg_length
        type: u2
        doc: 'Total message length, including this header'
  login_response_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: status
        type: u1
        enum: status
        doc: 'Pillar Status Code'
  stream_avail_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: next_seq
        type: u8
        doc: 'Next sequence number'
      - id: access
        type: u1
        doc: 'Available access on the stream'
  stream_id:
    seq:
      - id: sess
        type: u4
        doc: '32 bit session id'
      - id: user
        type: u4
        doc: 'Id of stream within session'
  heartbeat_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
  open_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: start_seq
        type: u8
        doc: 'Start sequence number'
      - id: end_seq
        type: u8
        doc: 'End sequence (ignored for write request)'
      - id: access
        type: u1
        doc: 'Available access on the stream'
      - id: mode
        type: u1
        doc: 'Mode requested'
  open_response_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Pillar Status Code'
      - id: access
        type: u1
        doc: 'Available access on the stream'
  close_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
  close_response_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Pillar Status Code'
  seq_msg_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: seq_msg_id
        type: seq_msg_id
        doc: 'Pillar Stream Sequenced Message Identifier'
      - id: reserved_4
        size: 4
        doc: 'Bytes reserved for future use'
      - id: timestamp
        type: u8
        doc: 'Message timestamp'
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: sequenced_message
        size: msg_header.msg_length - 36
        type:
          switch-on: seq_msg_header.seq_msg_type
          cases:
            'seq_msg_type::session_configuration_request_message': session_configuration_request_message
            'seq_msg_type::sequenced_filler': sequenced_filler
            'seq_msg_type::order_request': order_request
            'seq_msg_type::order_cancel_request': order_cancel_request
            'seq_msg_type::new_bulk_quote': new_bulk_quote
            'seq_msg_type::new_order_cross': new_order_cross
            'seq_msg_type::bulk_cancel_request': bulk_cancel_request
            'seq_msg_type::risk_limit_update_request': risk_limit_update_request
            'seq_msg_type::risk_action_request': risk_action_request
            'seq_msg_type::new_complex_series_request': new_complex_series_request
            'seq_msg_type::underlying_symbol_reference_data': underlying_symbol_reference_data
            'seq_msg_type::series_reference_data': series_reference_data
            'seq_msg_type::minimum_price_variant_class_reference_data': minimum_price_variant_class_reference_data
            'seq_msg_type::minimum_price_variant_level_reference_data': minimum_price_variant_level_reference_data
            'seq_msg_type::mpid_configuration': mpid_configuration
            'seq_msg_type::options_market_maker_symbol_appointment_reference_data': options_market_maker_symbol_appointment_reference_data
            'seq_msg_type::session_configuration_acknowledgement': session_configuration_acknowledgement
            'seq_msg_type::order_acknowledgement': order_acknowledgement
            'seq_msg_type::bulk_quote_acknowledgment': bulk_quote_acknowledgment
            'seq_msg_type::order_request_acknowledgment': order_request_acknowledgment
            'seq_msg_type::order_priority_update_acknowledgment': order_priority_update_acknowledgment
            'seq_msg_type::execution_report': execution_report
            'seq_msg_type::trade_bust_or_correct': trade_bust_or_correct
            'seq_msg_type::application_layer_reject': application_layer_reject
            'seq_msg_type::risk_control_acknowledgement': risk_control_acknowledgement
            'seq_msg_type::risk_control_alert': risk_control_alert
            'seq_msg_type::complex_series_request_acknowledgement': complex_series_request_acknowledgement
  seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Sequence number, starting from 1'
  seq_msg_header:
    seq:
      - id: seq_msg_type
        type: u2
        enum: seq_msg_type
        doc: 'Code identifying this message type'
      - id: seq_msg_length
        type: u2
        doc: 'Length of sequenced data message including this field'
  session_configuration_request_message:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: cancel_on_disconnect
        type: u1
        enum: cancel_on_disconnect
        doc: 'Note: the firm may only “upgrade” the Cancel on Disconnect subscription setting through the gateway Session Configuration Request. That is, if'
      - id: throttle_preference
        type: u1
        enum: throttle_preference
        doc: 'ThrottlePreference'
      - id: self_trade_prevention
        type: u1
        enum: self_trade_prevention
        doc: 'Session level default for the STP value on all Order and Cancel/Replace requests entered on the session'
      - id: order_priority_update_ack_subscription
        type: u1
        enum: order_priority_update_ack_subscription
        doc: '0 = Not subscribed to receive the unsolicited “Order Priority Update Ack” message or unsolicited “Repricing Ack” message on the Session'
      - id: bold_designation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session level default for the BOLD setting on all Order and Cancel/Replace requests entered on the session. Note: if the BOLD value is set on an individual Order'
      - id: reserved_49
        size: 49
        doc: 'Bytes reserved for future use'
  sequenced_filler:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
  order_request:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: order_instructions
        type: order_instructions
      - id: price_price_8
        type: s8
        doc: '0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
      - id: min_qty
        type: u4
        doc: '0 = no MinQty'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Indicates sender’s position of each leg of a Complex order'
      - id: auction_id
        type: u8
        doc: 'CUBE Auction identifier supplied by Pillar Market Data to allow GTX responses to target specific CUBE auctions. If provided on non-GTX responses, the order will be rejected'
      - id: optional_order_add_on
        type: optional_order_add_on
  order_instructions:
    seq:
      - id: reserved_bits_34
        type: b34
        doc: 'Bits reserved for future use'
      - id: security_type
        type: b5
        enum: security_type
        doc: 'SecurityType'
      - id: capacity
        type: b5
        doc: 'Indicates sender’s capacity'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates sender’s position'
      - id: sub_id_indicator
        type: b5
        doc: 'When using Pillar Pre-trade Risk Controls and specifying both MPSubID and SelfTradeType on an order, allows the firm to specify whether it should be used for both Risk and STP purposes, or for Risk purposes only. See “Self-Trade Prevention” section of this spec for more details'
      - id: special_ord_type
        type: b5
        enum: special_ord_type
        doc: 'SpecialOrdType'
      - id: locate_reqd
        type: u1
        enum: locate_reqd
        doc: '0 = No LocateReqd, or Not Applicable 1 = LocateReq for SSH orders'
      - id: retail_indicator
        type: b5
        enum: retail_indicator
        doc: 'RetailIndicator'
      - id: attributed_quote
        type: b5
        enum: attributed_quote
        doc: 'AttributedQuote'
      - id: order_capacity
        type: b5
        enum: order_capacity
        doc: 'OrderCapacity'
      - id: interest_type
        type: b5
        enum: interest_type
        doc: 'InterestType'
      - id: trading_session_id
        type: b5
        enum: trading_session_id
        doc: 'TradingSessionID'
      - id: time_in_force
        type: b5
        enum: time_in_force
        doc: 'TimeInForce'
      - id: proactive_if_locked
        type: b5
        enum: proactive_if_locked
        doc: 'ProactiveIfLocked'
      - id: self_trade_type
        type: u1
        enum: self_trade_type
        doc: 'Applies to all Quote messages in repeating group'
      - id: cancel_instead_of_reprice
        type: b5
        enum: cancel_instead_of_reprice
        doc: 'CancelInsteadOfReprice'
      - id: routing_inst
        type: b5
        enum: routing_inst
        doc: 'RoutingInst'
      - id: extended_exec_inst
        type: b5
        enum: extended_exec_inst
        doc: 'ExtendedExecInst'
      - id: exec_inst
        type: b5
        enum: exec_inst
        doc: 'ExecInst'
      - id: ord_type
        type: b5
        enum: ord_type
        doc: 'OrdType'
      - id: side_bit_5
        type: b5
        doc: 'Note: One side of a Cross order must be ‘Buy’ and the other ‘Sell’'
  optional_order_add_on:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: stop_px
        type: s8
        doc: 'Trigger price for Stop and Stop Limit orders. Implied decimal with scale 1e-8'
      - id: max_floor
        type: u4
        doc: '0 = No MaxFloor'
      - id: deliver_to_comp_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'Options MarketMaker MPID for Directed MM Order or Market Maker MPID for PFOF'
      - id: clearing_firm
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing number of CMTA'
      - id: optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'Clearing Optional Data'
      - id: clearing_account
        type: str
        size: 5
        encoding: ASCII
        doc: 'OCC number if a non-default value is to be used'
  sub_msg_header:
    seq:
      - id: sub_msg_type
        type: u2
        doc: 'Code identifying sub message type'
      - id: sub_msg_length
        type: u2
        doc: 'Length of sub message including this field'
  order_cancel_request:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
  order_modify_request:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
      - id: side_u_81
        type: u1
        doc: 'Side'
      - id: locate_reqd
        type: u1
        enum: locate_reqd
        doc: '0 = No LocateReqd, or Not Applicable 1 = LocateReq for SSH orders'
  new_bulk_quote:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – Applies to all Quote messages in repeating group'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: self_trade_type
        type: u1
        enum: self_trade_type
        doc: 'Applies to all Quote messages in repeating group'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group. Applies to all Quote messages in repeating group'
      - id: mm_sent_time
        type: nanosecond_timestamp
        doc: 'Customer provided sending time. CAT compliance Number of nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: bulk_quote
        type: bulk_quote
        repeat: eos
  bulk_quote:
    seq:
      - id: series_index
        type: u4
        doc: 'Options series index'
      - id: bit_field_quote_inst
        type: u1
        doc: 'Bitfield (containing Side and Type)'
      - id: price_price_8
        type: s8
        doc: '0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
  new_order_cross:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: cross_id
        type: u8
        doc: 'Unique ID of the Cross as assigned by the firm'
      - id: allocation_pct
        type: u1
        doc: 'Percentage of allocation a single stop price Covered order is willing to surrender'
      - id: clearing_firm_exposed
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing number of CMTA of the Exposed side of the Cross order. For CUBEs, this is the CUBE order'
      - id: clearing_account_exposed
        type: str
        size: 5
        encoding: ASCII
        doc: 'OCC number of the Exposed side of the Cross order if a non-default value is to be used. For CUBEs, this is the CUBE order'
      - id: clearing_firm_covered
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing number of CMTA of the Covered side of the Cross order. For CUBEs, this is the CUBE Contra order'
      - id: clearing_account_covered
        type: str
        size: 5
        encoding: ASCII
        doc: 'OCC number of the Covered side of the Cross order if a non-default value is to be used. For CUBEs, this is the CUBE Contra order'
      - id: reserved_16
        size: 16
        doc: 'Bytes reserved for future use'
      - id: exposed
        type: exposed
      - id: covered
        type: covered
  exposed:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: order_instructions
        type: order_instructions
      - id: price_price_8
        type: s8
        doc: '0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
      - id: min_qty
        type: u4
        doc: '0 = no MinQty'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Indicates sender’s position of each leg of a Complex order'
      - id: auction_id
        type: u8
        doc: 'CUBE Auction identifier supplied by Pillar Market Data to allow GTX responses to target specific CUBE auctions. If provided on non-GTX responses, the order will be rejected'
  covered:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: order_instructions
        type: order_instructions
      - id: price_price_8
        type: s8
        doc: '0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
      - id: min_qty
        type: u4
        doc: '0 = no MinQty'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Indicates sender’s position of each leg of a Complex order'
      - id: auction_id
        type: u8
        doc: 'CUBE Auction identifier supplied by Pillar Market Data to allow GTX responses to target specific CUBE auctions. If provided on non-GTX responses, the order will be rejected'
      - id: optional_order_add_on
        type: optional_order_add_on
  bulk_cancel_request:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: mm_sent_time
        type: nanosecond_timestamp
        doc: 'Customer provided sending time. CAT compliance Number of nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: side_u_81
        type: u1
        doc: 'Side'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group. Applies to all Quote messages in repeating group'
      - id: target_cancel_username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional - either TargetCancelUsername or TargetCancelMPID must be specified for cancel only'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'For all sessions'
      - id: cancel_scope
        type: u1
        enum: cancel_scope
        doc: 'Orders only'
      - id: target_cancel_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
  risk_limit_update_request:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: floor_broker_firm_crd
        type: u4
        doc: 'Risk Entity – CRD of NYSE Floor Broker Firm'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'RiskControlType'
      - id: risk_control_activation
        type: u1
        enum: risk_control_activation
        doc: 'Risk Control'
      - id: usd_limit
        type: s8
        doc: 'Integer US Dollar limit'
      - id: time_limit
        type: s4
        doc: 'Microsecond time period'
      - id: percentage_limit
        type: s4
        doc: 'Percentage (%)'
      - id: count_limit
        type: s4
        doc: 'Integer count'
      - id: breach_action_request
        type: u1
        enum: breach_action_request
        doc: 'BreachActionRequest'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'IOCAttribution'
      - id: reserved_200
        size: 200
        doc: 'Bytes reserved for future use'
  risk_action_request:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: floor_broker_firm_crd
        type: u4
        doc: 'Risk Entity – CRD of NYSE Floor Broker Firm'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'RiskControlType'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: '0 = Not Applicable'
      - id: reserved_200
        size: 200
        doc: 'Bytes reserved for future use'
  new_complex_series_request:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: complex_leg
        type: complex_leg
        repeat: eos
  complex_leg:
    seq:
      - id: leg_symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: leg_ratio_qty
        type: u2
        doc: 'The ratio of quantity for this individual leg'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Side'
  underlying_symbol_reference_data:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: nyse_symbol
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pillar Market Data Symbology'
      - id: listed_mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Identifier Code (MIC) of Primary Market'
      - id: underlying_type
        type: u1
        enum: underlying_type
        doc: 'Identifies what type of security the underlying symbols is'
      - id: max_order_price
        type: s8
        doc: 'Maximum allowable order entry price. Implied decimal with scale 1e-8'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number assigned to the MPVClass'
      - id: test_symbol_indicator
        type: u1
        enum: test_symbol_indicator
        doc: '0 = Production Symbol'
      - id: channel_id
        type: u1
        doc: 'TXN of Underlying'
      - id: legal_width_multiplier
        type: u1
        doc: 'Multiplier applied to standard legal width. For example:'
  series_reference_data:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: series_index
        type: u4
        doc: 'Options series index'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: occ_symbol_root
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'OCC root for Option series'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Call or Put indicator'
      - id: strike_price
        type: u8
        doc: 'Strike price. Implied decimal with scale 1e-8'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity year month day yyyy mm dd'
      - id: contract_multiplier
        type: u4
        doc: 'Number of Underlying shares per option contract. Ties directly to the root symbol underlying'
      - id: series_type
        type: u1
        doc: 'SeriesType'
      - id: closing_only_indicator
        type: u1
        enum: closing_only_indicator
        doc: 'ClosingOnlyIndicator'
  minimum_price_variant_class_reference_data:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: mpv_class_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the Minimum Price Variant (MPV) Class'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number assigned to the MPVClass'
      - id: rpimpv
        type: u8
        doc: 'Numeric value of the Minimum Price Variation for Retail Price Improvement (RPI) orders for securities belonging to the MPVClass. Implied decimal with scale 1e-8'
      - id: luldmpv
        type: u8
        doc: 'Numeric value of the Minimum Price Variation for LULD bands for securities belonging to the MPVClass. Implied decimal with scale 1e-8'
  minimum_price_variant_level_reference_data:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: mpv_level_definition
        type: mpv_level_definition
        repeat: eos
  mpv_level_definition:
    seq:
      - id: mpv_level_name
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the Minimum Price Variant (MPV) Level. Naming'
      - id: price_u_price_8
        type: u8
        doc: 'Order entry Limit price range for the MPVLevel. Implied decimal with scale 1e-8'
      - id: quoting_mpv
        type: u8
        doc: 'Numeric value of the Quoting Minimum Price Variation for the. Implied decimal with scale 1e-8'
      - id: trading_mpv
        type: u8
        doc: 'Numeric value of the Trading Minimum Price Variation for the. Implied decimal with scale 1e-8'
      - id: mpv_class_id
        type: u2
        doc: 'Identification number assigned to the MPVClass'
  mpid_configuration:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: mpid_status
        type: u1
        enum: mpid_status
        doc: 'Indicates the status of the MPID'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: reserved_50
        size: 50
        doc: 'Bytes reserved for future use'
  options_market_maker_symbol_appointment_reference_data:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: nyse_symbol
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pillar Market Data Symbology'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: mm_type
        type: u1
        enum: mm_type
        doc: 'MMType'
      - id: appointment_status
        type: u1
        enum: appointment_status
        doc: 'AppointmentStatus'
      - id: reserved_50
        size: 50
        doc: 'Bytes reserved for future use'
  session_configuration_acknowledgement:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: user_session_type
        type: u1
        enum: user_session_type
        doc: 'Defines the permission type assigned to the gateway session. UserSessionType controls the message types and values available to the session'
      - id: user_session_status
        type: u1
        enum: user_session_status
        doc: 'Indicates the status of the gateway session'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier of the gateway session – SenderCompID'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code (MIC) of the connected market'
      - id: cancel_on_disconnect
        type: u1
        enum: cancel_on_disconnect
        doc: 'Note: the firm may only “upgrade” the Cancel on Disconnect subscription setting through the gateway Session Configuration Request. That is, if'
      - id: throttle_preference
        type: u1
        enum: throttle_preference
        doc: 'ThrottlePreference'
      - id: throttle_window
        type: u2
        doc: 'Time period over which the ThrottleThreshold is enforced'
      - id: throttle_threshold
        type: u2
        doc: 'Maximum number of inbound messages allowed over the time period specified by ThrottleWindow'
      - id: symbol_eligibility
        type: u1
        doc: 'Session level permission to control order entry based on type of symbol'
      - id: max_order_quantity
        type: u4
        doc: 'Maximum allowable OrderQty for Order and Cancel/Replace Requests entered on the gateway session'
      - id: self_trade_prevention
        type: u1
        enum: self_trade_prevention
        doc: 'Session level default for the STP value on all Order and Cancel/Replace requests entered on the session'
      - id: order_priority_update_ack_subscription
        type: u1
        enum: order_priority_update_ack_subscription
        doc: '0 = Not subscribed to receive the unsolicited “Order Priority Update Ack” message or unsolicited “Repricing Ack” message on the Session'
      - id: ack_status
        type: u1
        doc: 'AckStatus'
      - id: bold_designation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session level default for the BOLD setting on all Order and Cancel/Replace requests entered on the session. Note: if the BOLD value is set on an individual Order'
      - id: reserved_49
        size: 49
        doc: 'Bytes reserved for future use'
  order_acknowledgement:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: order_instructions
        type: order_instructions
      - id: price_price_8
        type: s8
        doc: '0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
      - id: min_qty
        type: u4
        doc: '0 = no MinQty'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: order_id
        type: u8
        doc: 'Unique identifier of most recent order as assigned by the Exchange. Published externally to market data feeds'
      - id: leaves_qty
        type: u4
        doc: '0 - 999,999'
      - id: working_price
        type: s8
        doc: '0.01- 9,999.99. Implied decimal with scale 1e-8'
      - id: working_away_from_display
        type: u1
        doc: '0 = Working Price is equal to Display Price 1 = Working Price is different from Display Price'
      - id: pre_liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'PreLiquidityIndicator'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'These reason codes are provided by the matching engine and qualify the event that produced the message. See Appendix for list of values'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'AckType'
      - id: flow_indicator
        type: u1
        enum: flow_indicator
        doc: 'Bitfield indicating whether the inbound message was throttled'
      - id: leg_open_close
        type: u8
        enum: leg_open_close
        doc: 'Indicates sender’s position of each leg of a Complex order'
      - id: auction_id
        type: u8
        doc: 'CUBE Auction identifier supplied by Pillar Market Data to allow GTX responses to target specific CUBE auctions. If provided on non-GTX responses, the order will be rejected'
      - id: optional_order_add_on
        type: optional_order_add_on
  bulk_quote_acknowledgment:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – Applies to all Quote messages in repeating group'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: flow_indicator
        type: u1
        enum: flow_indicator
        doc: 'Bitfield indicating whether the inbound message was throttled'
      - id: self_trade_type
        type: u1
        enum: self_trade_type
        doc: 'Applies to all Quote messages in repeating group'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group. Applies to all Quote messages in repeating group'
      - id: repeating_groups
        type: u1
        doc: 'Indicates the number of repeating groups included in the message'
      - id: quote_ack
        type: quote_ack
        repeat: eos
  quote_ack:
    seq:
      - id: series_index
        type: u4
        doc: 'Options series index'
      - id: side_u_81
        type: u1
        doc: 'Side'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'AckType'
      - id: price_price_8
        type: s8
        doc: '0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: quantity
        type: u4
        doc: '0 - 999,999'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'These reason codes are provided by the matching engine and qualify the event that produced the message. See Appendix for list of values'
      - id: working_away_from_display
        type: u1
        doc: '0 = Working Price is equal to Display Price 1 = Working Price is different from Display Price'
  order_request_acknowledgment:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique identifier of most recent order as assigned by the Exchange. Published externally to market data feeds'
      - id: ref_cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: price_price_8
        type: s8
        doc: '0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
      - id: leaves_qty
        type: u4
        doc: '0 - 999,999'
      - id: side_u_81
        type: u1
        doc: 'Side'
      - id: locate_reqd
        type: u1
        enum: locate_reqd
        doc: '0 = No LocateReqd, or Not Applicable 1 = LocateReq for SSH orders'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'These reason codes are provided by the matching engine and qualify the event that produced the message. See Appendix for list of values'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'AckType'
      - id: flow_indicator
        type: u1
        enum: flow_indicator
        doc: 'Bitfield indicating whether the inbound message was throttled'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: group_id
        type: u4
        doc: 'User-defined takedown group. Applies to all Quote messages in repeating group'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: target_cancel_username
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional - either TargetCancelUsername or TargetCancelMPID must be specified for cancel only'
      - id: target_cancel_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'For all sessions'
      - id: cancel_scope
        type: u1
        enum: cancel_scope
        doc: 'Orders only'
  order_priority_update_acknowledgment:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique identifier of most recent order as assigned by the Exchange. Published externally to market data feeds'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: working_price
        type: s8
        doc: '0.01- 9,999.99. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999'
      - id: working_away_from_display
        type: u1
        doc: '0 = Working Price is equal to Display Price 1 = Working Price is different from Display Price'
      - id: pre_liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'PreLiquidityIndicator'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'AckType'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
  execution_report:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique identifier of most recent order as assigned by the Exchange. Published externally to market data feeds'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: deal_id
        type: u8
        doc: 'Unique identifier of a transaction, assigned by the Exchange to both Execution reports representing the two sides of a single trade. Published externally to market data feeds'
      - id: last_px
        type: s8
        doc: 'Price of current partial fill or fill message 0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u4
        doc: '0 - 999,999'
      - id: cum_qty
        type: u4
        doc: '1 - 999,999'
      - id: last_qty
        type: u4
        doc: 'Quantity of current partial fill or fill message 1 - 999,999'
      - id: liquidity_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'On Partial Fills and Fills:'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Indicates the type of Execution Report. (e.g.: used with multi-leg securities, such as option strategies, spreads, etc.)'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
      - id: locate_reqd
        type: u1
        enum: locate_reqd
        doc: '0 = No LocateReqd, or Not Applicable 1 = LocateReq for SSH orders'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'ParticipantType'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'These reason codes are provided by the matching engine and qualify the event that produced the message. See Appendix for list of values'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: side_u_81
        type: u1
        doc: 'Side'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: contra_market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'Alphanumeric MMID of contra local or away MM'
      - id: contra_clearing_firm
        type: str
        size: 5
        encoding: ASCII
        doc: 'Contra party clearing number of CMTA, if any - 5 digits'
      - id: contra_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Contra party Firm Identifier - MPID'
      - id: contra_open_close
        type: u1
        enum: contra_open_close
        doc: 'Indicates sender’s position'
      - id: contra_customer_or_firm
        type: u1
        enum: contra_customer_or_firm
        doc: 'Capacity of the order'
      - id: contra_clearing_account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Contra party clearing number - 5 digits'
      - id: contra_cross_type
        type: u2
        enum: contra_cross_type
        doc: '0 = Not Applicable'
      - id: contra_covered_or_uncovered
        type: u1
        enum: contra_covered_or_uncovered
        doc: 'Identifies the Exposed or Covered Side when the contra side was Cross'
      - id: covered_or_uncovered
        type: u1
        enum: covered_or_uncovered
        doc: 'Identifies the Exposed and Covered Side of each order in the Cross'
      - id: cross_id
        type: u8
        doc: 'Unique ID of the Cross as assigned by the firm'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates sender’s position'
      - id: optional_order_add_on
        type: optional_order_add_on
  trade_bust_or_correct:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: order_id
        type: u8
        doc: 'Unique identifier of most recent order as assigned by the Exchange. Published externally to market data feeds'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: ref_seq_msg_id
        type: ref_seq_msg_id
        doc: 'Pillar reference sequenced message identifier'
      - id: deal_id
        type: u8
        doc: 'Unique identifier of a transaction, assigned by the Exchange to both Execution reports representing the two sides of a single trade. Published externally to market data feeds'
      - id: last_px
        type: s8
        doc: 'Price of current partial fill or fill message 0.01 - 9,999.99. Implied decimal with scale 1e-8'
      - id: last_qty
        type: u4
        doc: 'Quantity of current partial fill or fill message 1 - 999,999'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'These reason codes are provided by the matching engine and qualify the event that produced the message. See Appendix for list of values'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: bust_correct_indicator
        type: u1
        enum: bust_correct_indicator
        doc: 'BustCorrectIndicator'
  ref_seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Sequence number, starting from 1'
  application_layer_reject:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'These reason codes are provided by the matching engine and qualify the event that produced the message. See Appendix for list of values'
      - id: reject_type
        type: u1
        enum: reject_type
        doc: 'RejectType'
      - id: user_data
        type: str
        size: 10
        encoding: ASCII
        doc: 'Customer defined up to 10 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: reserved_4
        size: 4
        doc: 'Bytes reserved for future use'
  risk_control_acknowledgement:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: floor_broker_firm_crd
        type: u4
        doc: 'Risk Entity – CRD of NYSE Floor Broker Firm'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: risk_ack_type
        type: u1
        enum: risk_ack_type
        doc: 'RiskAckType'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'RiskControlType'
      - id: risk_control_activation
        type: u1
        enum: risk_control_activation
        doc: 'Risk Control'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: '0 = Not Applicable'
      - id: usd_limit
        type: s8
        doc: 'Integer US Dollar limit'
      - id: time_limit
        type: s4
        doc: 'Microsecond time period'
      - id: percentage_limit
        type: s4
        doc: 'Percentage (%)'
      - id: count_limit
        type: s4
        doc: 'Integer count'
      - id: breach_action_response
        type: u1
        enum: breach_action_response
        doc: 'BreachActionResponse'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'IOCAttribution'
      - id: usd_calculation_1
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: usd_calculation_2
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: usd_calculation_3
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: usd_calculation_4
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: count_calculation
        type: u4
        doc: 'Integer count'
      - id: blocked_by_breach_indicator
        type: u1
        enum: blocked_by_breach_indicator
        doc: 'BlockedByBreachIndicator'
      - id: blocked_by_kill_switch_indicator
        type: u1
        enum: blocked_by_kill_switch_indicator
        doc: 'BlockedByKillSwitchIndicator'
      - id: reinstatement_requiredby_self
        type: u1
        enum: reinstatement_requiredby_self
        doc: 'Indicates whether Reinstatement Approval from SELF (the Risk User to which this message is sent) is required for this Risk Entity upon breach'
      - id: reinstatement_requiredby_other
        type: u1
        enum: reinstatement_requiredby_other
        doc: 'Indicates whether Reinstatement Approval from OTHER Risk User(s) is required for this Risk Entity upon breach'
      - id: reserved_200
        size: 200
        doc: 'Bytes reserved for future use'
  risk_control_alert:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: market_maker
        type: str
        size: 10
        encoding: ASCII
        doc: 'This value represents a Market Maker (including LMM, Primary Specialist, Specialist and e-Specialist), agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: floor_broker_firm_crd
        type: u4
        doc: 'Risk Entity – CRD of NYSE Floor Broker Firm'
      - id: clearing_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: risk_user_crd
        type: u4
        doc: 'Risk User – CRD of the firm that owns the risk control represented by this message'
      - id: risk_user_type
        type: u1
        enum: risk_user_type
        doc: 'Risk User – type of firm that owns the risk control represented by this message'
      - id: risk_control_type
        type: u1
        enum: risk_control_type
        doc: 'RiskControlType'
      - id: usd_limit
        type: s8
        doc: 'Integer US Dollar limit'
      - id: time_limit
        type: s4
        doc: 'Microsecond time period'
      - id: percentage_limit
        type: s4
        doc: 'Percentage (%)'
      - id: count_limit
        type: s4
        doc: 'Integer count'
      - id: breach_action_response
        type: u1
        enum: breach_action_response
        doc: 'BreachActionResponse'
      - id: ioc_attribution
        type: u1
        enum: ioc_attribution
        doc: 'IOCAttribution'
      - id: usd_calculation_1
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: usd_calculation_2
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: usd_calculation_3
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: usd_calculation_4
        type: s8
        doc: 'Integer US Dollar calculation. For the following RiskControlTypes – will be populated with the'
      - id: count_calculation
        type: u4
        doc: 'Integer count'
      - id: risk_action_type
        type: u1
        enum: risk_action_type
        doc: '0 = Not Applicable'
      - id: threshold_breach_level
        type: u1
        enum: threshold_breach_level
        doc: 'ThresholdBreachLevel'
      - id: blocked_by_breach_indicator
        type: u1
        enum: blocked_by_breach_indicator
        doc: 'BlockedByBreachIndicator'
      - id: blocked_by_kill_switch_indicator
        type: u1
        enum: blocked_by_kill_switch_indicator
        doc: 'BlockedByKillSwitchIndicator'
      - id: reinstatement_requiredby_self
        type: u1
        enum: reinstatement_requiredby_self
        doc: 'Indicates whether Reinstatement Approval from SELF (the Risk User to which this message is sent) is required for this Risk Entity upon breach'
      - id: reinstatement_requiredby_other
        type: u1
        enum: reinstatement_requiredby_other
        doc: 'Indicates whether Reinstatement Approval from OTHER Risk User(s) is required for this Risk Entity upon breach'
      - id: reserved_200
        size: 200
        doc: 'Bytes reserved for future use'
  complex_series_request_acknowledgement:
    seq:
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: transact_time
        type: u8
        doc: 'Exchange application time'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the message as assigned by the firm'
      - id: reason_code
        type: u2
        enum: reason_code
        doc: 'These reason codes are provided by the matching engine and qualify the event that produced the message. See Appendix for list of values'
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: side_u_81
        type: u1
        doc: 'Side'
      - id: repeating_groups
        type: u1
        doc: 'Indicates the number of repeating groups included in the message'
      - id: complex_leg_ack
        type: complex_leg_ack
        repeat: eos
  complex_leg_ack:
    seq:
      - id: leg_symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: leg_ratio_qty
        type: u2
        doc: 'The ratio of quantity for this individual leg'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Side'
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

enums:
  msg_type:
    0x0201:
      id: 'login'
      doc: 'Login'
    0x0202:
      id: 'login_response'
      doc: 'Login Response'
    0x0203:
      id: 'stream_avail'
      doc: 'Stream Avail'
    0x0204:
      id: 'heartbeat'
      doc: 'Heartbeat'
    0x0205:
      id: 'open'
      doc: 'Open'
    0x0206:
      id: 'open_response'
      doc: 'Open Response'
    0x0207:
      id: 'close'
      doc: 'Close'
    0x0208:
      id: 'close_response'
      doc: 'Close Response'
    0x0905:
      id: 'seq_msg'
      doc: 'Sequenced Message'
  status:
    0:
      id: 'request_processed_successfully'
      doc: 'Request processed successfully'
    18:
      id: 'not_logged_in'
      doc: 'Not logged in'
  seq_msg_type:
    0x0220:
      id: 'session_configuration_request_message'
      doc: 'This message may be sent by the firm to change their configuration settings for a given gateway session, as defined by its Username'
    0x0282:
      id: 'sequenced_filler'
      doc: 'This message may be sent by the firm to change their configuration settings for a given gateway session, as defined by its Username'
    0x0248:
      id: 'order_request'
      doc: 'This message type is used as both a New Order message or a Cancel/Replacement message, as well as in conjunction with the New Order Cross message'
    0x0250:
      id: 'order_cancel_request'
      doc: 'This message is used to cancel a single targeted order including complex orders'
    0x0243:
      id: 'new_bulk_quote'
      doc: 'This message may be sent by an Options Market Maker to enter up to 20 Quote messages at once'
    0x0222:
      id: 'new_order_cross'
      doc: 'This message can be used to enter cross orders'
    0x0223:
      id: 'bulk_cancel_request'
      doc: 'This message is used to bulk cancel multiple orders/Market Maker Quotes based on the combination of criteria specified in the message'
    0x0330:
      id: 'risk_limit_update_request'
      doc: 'This message allows firms using Pillar Risk Controls to set/update the risk configurations of Risk Entities for which they have “write” entitlements'
    0x0331:
      id: 'risk_action_request'
      doc: 'This message allows firms using Pillar Risk Controls to query Risk Entities for current configurations/calculations/status, invoke Kill Switch actions, and Approve Reinstatement following a breach with “Block” instructions'
    0x0357:
      id: 'new_complex_series_request'
      doc: 'This message type is used to create a new complex series as defined in the message'
    0x0233:
      id: 'underlying_symbol_reference_data'
      doc: 'This message is published for each Underlying symbol for which a gateway session is configured to trade'
    0x0234:
      id: 'series_reference_data'
      doc: 'This message is published for each security traded on the market for which a gateway session is configured to trade'
    0x0230:
      id: 'minimum_price_variant_class_reference_data'
      doc: 'This message defines a single MPV Class by name and Identification number, and provides attributes belonging to that class'
    0x0231:
      id: 'minimum_price_variant_level_reference_data'
      doc: 'This message defines one or more MPV Levels within a single MPV Class'
    0x0272:
      id: 'mpid_configuration'
      doc: 'An instance of this message is provided, unsolicited, at start of day for each MPID configured on a gateway session'
    0x0833:
      id: 'options_market_maker_symbol_appointment_reference_data'
      doc: 'This message is provided to Market Makers for each of their appointed underlying symbols'
    0x0221:
      id: 'session_configuration_acknowledgement'
      doc: 'This message is provided, unsolicited, at start of day'
    0x026:
      id: 'order_acknowledgement'
      doc: 'This message is provided by the Exchange in response to an Order/Cancel Replace Request or New Order Cross'
    0x0294:
      id: 'bulk_quote_acknowledgment'
      doc: 'This message may be sent by the firm to change their configuration settings for a given gateway session, as defined by its Username'
    0x0278:
      id: 'order_request_acknowledgment'
      doc: 'This message is used as a Modify Request Acknowledgement, a Cancel Request Acknowledgment, a UROUT, and a Billable Cancel'
    0x0268:
      id: 'order_priority_update_acknowledgment'
      doc: 'This message is sent unsolicited by the Exchange to notify the firm of a Reserve Order replenishment event'
    0x0295:
      id: 'execution_report'
      doc: 'This message type will be returned on executions for Options orders and indicates whether an order has been partially or entirely filled'
    0x0293:
      id: 'trade_bust_or_correct'
      doc: 'This message is sent as a result of a report bust or correction'
    0x0267:
      id: 'application_layer_reject'
      doc: 'This message informs the firm that a request has been rejected'
    0x0332:
      id: 'risk_control_acknowledgement'
      doc: 'This message may be sent by the firm to change their configuration settings for a given gateway session, as defined by its Username'
    0x0333:
      id: 'risk_control_alert'
      doc: 'this message provides notification of threshold, breach, reinstatement and kill switch events'
    0x0358:
      id: 'complex_series_request_acknowledgement'
      doc: 'This message may be sent by the firm to change their configuration settings for a given gateway session, as defined by its Username'
  cancel_on_disconnect:
    1:
      id: 'enable_cancel_on_disconnect_day'
      doc: 'Enable Cancel On Disconnect Day'
    2:
      id: 'enable_cancel_on_disconnect_all'
      doc: 'Enable Cancel On Disconnect All'
  throttle_preference:
    0:
      id: 'queue_orders_when_throttled'
      doc: 'Queue Orders When Throttled'
    1:
      id: 'reject_orders_when_throttled'
      doc: 'Reject Orders When Throttled'
  self_trade_prevention:
    1:
      id: 'no_self_trade_prevention'
      doc: 'No Self Trade Prevention'
    2:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    4:
      id: 'cancel_both'
      doc: 'Cancel Both'
    5:
      id: 'cancel_decrement'
      doc: 'Cancel Decrement'
  order_priority_update_ack_subscription:
    1:
      id: 'unsolicited_order_priority_update_ack'
      doc: 'Unsolicited Order Priority Update Ack'
    2:
      id: 'unsolicited_order_priority_update_ack_and_unsolicited_repricing_ack'
      doc: 'Unsolicited Order Priority Update Ack And Unsolicited Repricing Ack'
  security_type:
    1:
      id: 'opt'
      doc: 'Opt'
    2:
      id: 'mleg'
      doc: 'Mleg'
  open_close:
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'close'
      doc: 'Close'
  special_ord_type:
    0:
      id: 'no_special_ord_type'
      doc: 'No Special Ord Type'
    1:
      id: 'dmm_open_reopen_close_with_or_without_auction_aoc'
      doc: 'Dmm Open Reopen Close With Or Without Auction Aoc'
    2:
      id: 'dmm_preauction'
      doc: 'Dmm Preauction'
    3:
      id: 'dmm_afterauction'
      doc: 'Dmm Afterauction'
    4:
      id: 'qct'
      doc: 'Qct'
    5:
      id: 'price_improvement_cube'
      doc: 'Price Improvement Cube'
    7:
      id: 'aon_cube_solicitation'
      doc: 'Aon Cube Solicitation'
    9:
      id: 'cabinet'
      doc: 'Cabinet'
    10:
      id: 'qcc'
      doc: 'Qcc'
    11:
      id: 'customer_to_customer_cross'
      doc: 'Customer To Customer Cross'
  locate_reqd:
    0:
      id: 'no_locate_reqd'
      doc: 'No Locate Reqd'
    1:
      id: 'locate_req_for_ssh_orders'
      doc: 'Locate Req For Ssh Orders'
  retail_indicator:
    0:
      id: 'not_retail'
      doc: 'Not Retail'
    1:
      id: 'retail_order'
      doc: 'Retail Order'
  attributed_quote:
    0:
      id: 'not_attributed_equities'
      doc: 'Not Attributed Equities'
    1:
      id: 'attributed_for_market_data_feeds'
      doc: 'Attributed For Market Data Feeds'
    2:
      id: 'include_in_broker_volume'
      doc: 'Include In Broker Volume'
    3:
      id: 'attributed_for_market_data_feeds_and_include_in_broker_volume'
      doc: 'Attributed For Market Data Feeds And Include In Broker Volume'
    4:
      id: 'bold_expose_order_info_only'
      doc: 'Bold Expose Order Info Only'
    5:
      id: 'bold_expose_order_info_and_capacity_only'
      doc: 'Bold Expose Order Info And Capacity Only'
    6:
      id: 'bold_expose_order_info_and_participant_id_only'
      doc: 'Bold Expose Order Info And Participant Id Only'
    7:
      id: 'bold_expose_order_info_capacity_and_participant_id'
      doc: 'Bold Expose Order Info Capacity And Participant Id'
    8:
      id: 'do_not_bold'
      doc: 'Do Not Bold'
  order_capacity:
    1:
      id: 'agency'
      doc: 'Agency'
    2:
      id: 'principal'
      doc: 'Principal'
    3:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
    4:
      id: 'error_account'
      doc: 'Error Account'
  interest_type:
    0:
      id: 'no_interest_type'
      doc: 'No Interest Type'
    1:
      id: 'options_mm_quote'
      doc: 'Options Mm Quote'
    4:
      id: 'q_order'
      doc: 'Q Order'
    5:
      id: 'capital_commitment_order_cco'
      doc: 'Capital Commitment Order Cco'
    6:
      id: 'capital_commitment_order_cco_partial_fill_contraside'
      doc: 'Capital Commitment Order Cco Partial Fill Contraside'
  trading_session_id:
    1:
      id: 'early_trading_session'
      doc: 'Early Trading Session'
    2:
      id: 'core_trading_session'
      doc: 'Core Trading Session'
    3:
      id: 'late_trading_session'
      doc: 'Late Trading Session'
    4:
      id: 'early_core_trading_sessions'
      doc: 'Early Core Trading Sessions'
    5:
      id: 'core_and_late_trading_sessions'
      doc: 'Core And Late Trading Sessions'
    6:
      id: 'early_core_and_late_trading_sessions'
      doc: 'Early Core And Late Trading Sessions'
  time_in_force:
    1:
      id: 'day'
      doc: 'Day'
    2:
      id: 'ioc'
      doc: 'Ioc'
    3:
      id: 'at_the_opening'
      doc: 'At The Opening'
    4:
      id: 'on_close'
      doc: 'On Close'
    5:
      id: 'gtx'
      doc: 'Gtx'
    6:
      id: 'gtc'
      doc: 'Gtc'
    7:
      id: 'fok'
      doc: 'Fok'
  proactive_if_locked:
    0:
      id: 'no_proactive_if_locked'
      doc: 'No Proactive If Locked'
    1:
      id: 'proactive_route'
      doc: 'Proactive Route'
    2:
      id: 'proactive_trade_non_display'
      doc: 'Proactive Trade Non Display'
  self_trade_type:
    0:
      id: 'use_current_session_configuration_stp_setting_for_the_username'
      doc: 'Use Current Session Configuration Stp Setting For The Username'
    1:
      id: 'no_self_trade_prevention'
      doc: 'No Self Trade Prevention'
    2:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    4:
      id: 'cancel_both'
      doc: 'Cancel Both'
    5:
      id: 'cancel_decrement'
      doc: 'Cancel Decrement'
  cancel_instead_of_reprice:
    1:
      id: 'cancel_order_instead_of_repricing_for_luld_only'
      doc: 'Cancel Order Instead Of Repricing For Luld Only'
    2:
      id: 'cancel_if_doesnt_set_nbbo_on_arrival_or_if_needs_to_reprice_for_luld'
      doc: 'Cancel If Doesnt Set Nbbo On Arrival Or If Needs To Reprice For Luld'
    3:
      id: 'cancel_order_instead_of_repricing_for_any_reason'
      doc: 'Cancel Order Instead Of Repricing For Any Reason'
    4:
      id: 'once_resting_allow_to_reprice_once_then_cancel_instead_of_repricing'
      doc: 'Once Resting Allow To Reprice Once Then Cancel Instead Of Repricing'
    5:
      id: 'combination_of_value_2_and_3'
      doc: 'Combination Of Value 2 And 3'
    6:
      id: 'combination_of_value_2_and_4'
      doc: 'Combination Of Value 2 And 4'
  routing_inst:
    0:
      id: 'no_routing_inst_minimum_fill_matches_vs_aggregate_volume_both_upon_arrival_and_when_resting_must_be_entered_with_min_qty_tag_populated_with_a_nonzero_value_1_nonroutable_2_routable_3_directed_primary_only_4_directed_routable_pos_5_primary_market_until_9456_primary_market_after_3557_both_primary_market_until_945_and_primary_market_after_355'
      doc: 'No Routing Inst Minimum Fill Matches Vs Aggregate Volume Both Upon Arrival And When Resting Must Be Entered With Min Qty Tag Populated With A Nonzero Value 1 Nonroutable 2 Routable 3 Directed Primary Only 4 Directed Routable Pos 5 Primary Market Until 9456 Primary Market After 3557 Both Primary Market Until 945 And Primary Market After 355'
    8:
      id: 'minimum_fill_must_be_entered_with_min_qty_field_populated_with_a_nonzero_value'
      doc: 'Minimum Fill Must Be Entered With Min Qty Field Populated With A Nonzero Value'
    9:
      id: 'complex_book_only_nonlegging_complex_order'
      doc: 'Complex Book Only Nonlegging Complex Order'
  extended_exec_inst:
    0:
      id: 'no_extended_exec_inst'
      doc: 'No Extended Exec Inst'
    1:
      id: 'add_liquidity_only'
      doc: 'Add Liquidity Only'
    2:
      id: 'no_trade_against_mpl'
      doc: 'No Trade Against Mpl'
    3:
      id: 'no_route_to_ioi'
      doc: 'No Route To Ioi'
    4:
      id: 'no_trade_against_mpl_and_no_route_to_ioi'
      doc: 'No Trade Against Mpl And No Route To Ioi'
    5:
      id: 'retail_order_type_1'
      doc: 'Retail Order Type 1'
    6:
      id: 'retail_order_type_2'
      doc: 'Retail Order Type 2'
    7:
      id: 'retail_provider'
      doc: 'Retail Provider'
    8:
      id: 'imbalance_offset'
      doc: 'Imbalance Offset'
    9:
      id: 'discretionary_peg'
      doc: 'Discretionary Peg'
    10:
      id: 'dark_non_displayed_primary_peg'
      doc: 'Dark Non Displayed Primary Peg'
    11:
      id: 'reserved_for_future_use_11'
      doc: 'Reserved For Future Use 11'
    12:
      id: 'reserved_for_future_use_12'
      doc: 'Reserved For Future Use 12'
    13:
      id: 'add_liquidity_only_nontaking_alo'
      doc: 'Add Liquidity Only Nontaking Alo'
    14:
      id: 'issuer_direct_offering'
      doc: 'Issuer Direct Offering'
    17:
      id: 'complex_order_auction'
      doc: 'Complex Order Auction'
  exec_inst:
    0:
      id: 'no_exec_inst'
      doc: 'No Exec Inst'
    3:
      id: 'tracking_order'
      doc: 'Tracking Order'
    4:
      id: 'iso'
      doc: 'Iso'
    5:
      id: 'primary_peg'
      doc: 'Primary Peg'
    6:
      id: 'market_peg'
      doc: 'Market Peg'
    7:
      id: 'midpoint_liquidity'
      doc: 'Midpoint Liquidity'
    8:
      id: 'non_displayed'
      doc: 'Non Displayed'
    9:
      id: 'tradeat_iso'
      doc: 'Tradeat Iso'
    10:
      id: 'last_sale_peg'
      doc: 'Last Sale Peg'
    13:
      id: 'allor_none_aon'
      doc: 'Allor None Aon'
  ord_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'inside_limit'
      doc: 'Inside Limit'
    4:
      id: 'pegged'
      doc: 'Pegged'
    5:
      id: 'stop'
      doc: 'Stop'
    6:
      id: 'stop_limit'
      doc: 'Stop Limit'
    9:
      id: 'auto_match_limit'
      doc: 'Auto Match Limit'
  leg_open_close:
    0:
      id: 'open'
      doc: 'Open'
    1:
      id: 'close'
      doc: 'Close'
    2:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    3:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    4:
      id: 'cancel_both'
      doc: 'Cancel Both'
    5:
      id: 'cancel_decrement'
      doc: 'Cancel Decrement'
  bulk_action:
    1:
      id: 'cancel_single_leg_only'
      doc: 'Cancel Single Leg Only'
    2:
      id: 'cancel_complex_only'
      doc: 'Cancel Complex Only'
    3:
      id: 'cancel_both_single_leg_and_complex'
      doc: 'Cancel Both Single Leg And Complex'
    4:
      id: 'block_and_cancel'
      doc: 'Block And Cancel'
    5:
      id: 'unblock'
      doc: 'Unblock'
  cancel_scope:
    0:
      id: 'orders_only'
      doc: 'Orders Only'
    1:
      id: 'options_mm_quotes_only'
      doc: 'Options Mm Quotes Only'
    2:
      id: 'both_orders_and_options_mm_quotes'
      doc: 'Both Orders And Options Mm Quotes'
  risk_user_type:
    0x45:
      id: 'entering_firm'
      doc: 'Entering Firm'
    0x43:
      id: 'clearing_firm'
      doc: 'Clearing Firm'
    0x46:
      id: 'nyse_floor_broker_firm'
      doc: 'Nyse Floor Broker Firm'
    0x4f:
      id: 'options_market_maker_firm'
      doc: 'Options Market Maker Firm'
  risk_control_type:
    1:
      id: 'single_order_max_qty'
      doc: 'Single Order Max Qty'
    2:
      id: 'single_order_max_notional_value'
      doc: 'Single Order Max Notional Value'
    3:
      id: 'gross_credit'
      doc: 'Gross Credit'
    8:
      id: 'activitybased_rolling_transaction'
      doc: 'Activitybased Rolling Transaction'
    9:
      id: 'activitybased_rolling_volume'
      doc: 'Activitybased Rolling Volume'
    10:
      id: 'activitybased_rolling_percentage'
      doc: 'Activitybased Rolling Percentage'
    11:
      id: 'activitybased_global_risk_mitigation_protection_for_transaction_volume_percentage'
      doc: 'Activitybased Global Risk Mitigation Protection For Transaction Volume Percentage'
  risk_control_activation:
    0:
      id: 'risk_control_turned_off'
      doc: 'Risk Control Turned Off'
    1:
      id: 'risk_control_turned_on'
      doc: 'Risk Control Turned On'
  breach_action_request:
    1:
      id: 'notifications_only'
      doc: 'Notifications Only'
    2:
      id: 'cancel_non_auction_orders_and_block'
      doc: 'Cancel Non Auction Orders And Block'
    3:
      id: 'block_only'
      doc: 'Block Only'
  ioc_attribution:
    1:
      id: 'include_ioc_and_gtx_orders_in_activitybased_calculations_and_cancellations'
      doc: 'Include Ioc And Gtx Orders In Activitybased Calculations And Cancellations'
    2:
      id: 'exclude_ioc_and_gtx_orders_from_activitybased_calculations_and_cancellations'
      doc: 'Exclude Ioc And Gtx Orders From Activitybased Calculations And Cancellations'
  risk_action_type:
    1:
      id: 'query_risk_entity_for_current_risk_control_configscalculationsstatus'
      doc: 'Query Risk Entity For Current Risk Control Configscalculationsstatus'
    2:
      id: 'kill_switch_block'
      doc: 'Kill Switch Block'
    3:
      id: 'kill_switch_un_block'
      doc: 'Kill Switch Un Block'
    4:
      id: 'kill_switch_cancel_auction_orders'
      doc: 'Kill Switch Cancel Auction Orders'
    5:
      id: 'kill_switch_cancel_non_auction_orders'
      doc: 'Kill Switch Cancel Non Auction Orders'
    6:
      id: 'kill_switch_cancel_gtc_orders'
      doc: 'Kill Switch Cancel Gtc Orders'
    7:
      id: 'approve_reinstatement'
      doc: 'Approve Reinstatement'
    8:
      id: 'risk_entity_reinstated_all_necessary_reinstatement_approvals_received_reinstatement_processed'
      doc: 'Risk Entity Reinstated All Necessary Reinstatement Approvals Received Reinstatement Processed'
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  underlying_type:
    0x41:
      id: 'adr'
      doc: 'Adr'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x44:
      id: 'debentures'
      doc: 'Debentures'
    0x45:
      id: 'etf'
      doc: 'Etf'
    0x46:
      id: 'foreign'
      doc: 'Foreign'
    0x48:
      id: 'ads'
      doc: 'Ads'
    0x49:
      id: 'units'
      doc: 'Units'
    0x4d:
      id: 'misc_others'
      doc: 'Misc Others'
    0x4c:
      id: 'index_linked_notes'
      doc: 'Index Linked Notes'
    0x4e:
      id: 'bonds'
      doc: 'Bonds'
    0x4f:
      id: 'ordinary_shares'
      doc: 'Ordinary Shares'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x52:
      id: 'rights'
      doc: 'Rights'
    0x53:
      id: 'beneficiary_interest'
      doc: 'Beneficiary Interest'
    0x54:
      id: 'structured_notes'
      doc: 'Structured Notes'
    0x55:
      id: 'closed_end_fund'
      doc: 'Closed End Fund'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
    0x58:
      id: 'index'
      doc: 'Index'
    0x5a:
      id: 'options'
      doc: 'Options'
  test_symbol_indicator:
    0:
      id: 'production_symbol'
      doc: 'Production Symbol'
    1:
      id: 'test_symbol'
      doc: 'Test Symbol'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'
  closing_only_indicator:
    0:
      id: 'standard_series'
      doc: 'Standard Series'
    1:
      id: 'closing_only_series'
      doc: 'Closing Only Series'
  mpid_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'inactive'
      doc: 'Inactive'
    3:
      id: 'prospect'
      doc: 'Prospect'
  mm_type:
    1:
      id: 'nyse_american_options_market_maker'
      doc: 'Nyse American Options Market Maker'
    2:
      id: 'nyse_american_options_specialist'
      doc: 'Nyse American Options Specialist'
    3:
      id: 'nyse_american_options_e_specialist'
      doc: 'Nyse American Options E Specialist'
    4:
      id: 'nyse_american_options_domm'
      doc: 'Nyse American Options Domm'
    5:
      id: 'nyse_american_options_specialist_and_domm'
      doc: 'Nyse American Options Specialist And Domm'
    6:
      id: 'nyse_american_options_e_specialist_and_domm'
      doc: 'Nyse American Options E Specialist And Domm'
  appointment_status:
    0:
      id: 'not_appointed_for_underlying_symbol'
      doc: 'Not Appointed For Underlying Symbol'
    1:
      id: 'appointed_for_underlying_symbol'
      doc: 'Appointed For Underlying Symbol'
  user_session_type:
    1:
      id: 'all_asset_clases_andor_equities_market_maker'
      doc: 'All Asset Clases Andor Equities Market Maker'
    2:
      id: 'service_bureau'
      doc: 'Service Bureau'
    3:
      id: 'designated_market_maker'
      doc: 'Designated Market Maker'
    4:
      id: 'options_market_maker'
      doc: 'Options Market Maker'
    5:
      id: 'third_party_algo_vendor'
      doc: 'Third Party Algo Vendor'
    6:
      id: 'nyse_floor_broker'
      doc: 'Nyse Floor Broker'
    7:
      id: 'direct_to_nyse_floor_broker'
      doc: 'Direct To Nyse Floor Broker'
    12:
      id: 'risk_admin'
      doc: 'Risk Admin'
  user_session_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'inactive'
      doc: 'Inactive'
    3:
      id: 'prospect'
      doc: 'Prospect'
  reason_code:
    0:
      id: 'ok'
      doc: 'Ok'
    1:
      id: 'invalid_sender_comp_id'
      doc: 'Invalid Sender Comp Id'
    2:
      id: 'invalid_sender_sub_id'
      doc: 'Invalid Sender Sub Id'
    3:
      id: 'invalid_sending_time'
      doc: 'Invalid Sending Time'
    4:
      id: 'invalid_target_comp_id'
      doc: 'Invalid Target Comp Id'
    5:
      id: 'invalid_target_sub_id'
      doc: 'Invalid Target Sub Id'
    6:
      id: 'invalid_on_behalf_of_comp_id'
      doc: 'Invalid On Behalf Of Comp Id'
    7:
      id: 'invalid_on_behalf_of_sub_id'
      doc: 'Invalid On Behalf Of Sub Id'
    8:
      id: 'invalid_deliver_to_comp_id'
      doc: 'Invalid Deliver To Comp Id'
    9:
      id: 'invalid_deliver_to_sub_id'
      doc: 'Invalid Deliver To Sub Id'
    10:
      id: 'invalid_account'
      doc: 'Invalid Account'
    11:
      id: 'invalid_cl_ord_id'
      doc: 'Invalid Cl Ord Id'
    12:
      id: 'invalid_exec_inst'
      doc: 'Invalid Exec Inst'
    13:
      id: 'invalid_id_source'
      doc: 'Invalid Id Source'
    14:
      id: 'invalid_order_qty'
      doc: 'Invalid Order Qty'
    15:
      id: 'invalid_ord_type'
      doc: 'Invalid Ord Type'
    16:
      id: 'invalid_price'
      doc: 'Invalid Price'
    17:
      id: 'invalid_order_capacity'
      doc: 'Invalid Order Capacity'
    18:
      id: 'invalid_security_id'
      doc: 'Invalid Security Id'
    19:
      id: 'invalid_side'
      doc: 'Invalid Side'
    20:
      id: 'invalid_symbol_series'
      doc: 'Invalid Symbol Series'
    21:
      id: 'invalid_text'
      doc: 'Invalid Text'
    22:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    23:
      id: 'invalid_settlement_type'
      doc: 'Invalid Settlement Type'
    24:
      id: 'invalid_fut_sett_date'
      doc: 'Invalid Fut Sett Date'
    25:
      id: 'invalid_symbol_sfx'
      doc: 'Invalid Symbol Sfx'
    26:
      id: 'invalid_open_close'
      doc: 'Invalid Open Close'
    27:
      id: 'invalid_stop_px'
      doc: 'Invalid Stop Px'
    28:
      id: 'invalid_client_id'
      doc: 'Invalid Client Id'
    29:
      id: 'invalid_min_qty'
      doc: 'Invalid Min Qty'
    30:
      id: 'invalid_max_floor'
      doc: 'Invalid Max Floor'
    31:
      id: 'invalid_locate_reqd'
      doc: 'Invalid Locate Reqd'
    32:
      id: 'invalid_expire_time'
      doc: 'Invalid Expire Time'
    33:
      id: 'invalid_security_type'
      doc: 'Invalid Security Type'
    34:
      id: 'invalid_maturity_month_year'
      doc: 'Invalid Maturity Month Year'
    35:
      id: 'invalid_put_or_call'
      doc: 'Invalid Put Or Call'
    36:
      id: 'invalid_strike_price'
      doc: 'Invalid Strike Price'
    37:
      id: 'invalid_covered_or_uncovered'
      doc: 'Invalid Covered Or Uncovered'
    38:
      id: 'invalid_customer_or_firm'
      doc: 'Invalid Customer Or Firm'
    39:
      id: 'invalid_maturity_day'
      doc: 'Invalid Maturity Day'
    40:
      id: 'invalid_peg_difference'
      doc: 'Invalid Peg Difference'
    41:
      id: 'invalid_sellers_days'
      doc: 'Invalid Sellers Days'
    42:
      id: 'invalid_trading_session_id'
      doc: 'Invalid Trading Session Id'
    43:
      id: 'invalid_no_trading_sessions'
      doc: 'Invalid No Trading Sessions'
    44:
      id: 'invalid_discretion_inst'
      doc: 'Invalid Discretion Inst'
    45:
      id: 'invalid_discretion_offset'
      doc: 'Invalid Discretion Offset'
    46:
      id: 'invalid_price_type'
      doc: 'Invalid Price Type'
    47:
      id: 'invalid_clearing_firm'
      doc: 'Invalid Clearing Firm'
    48:
      id: 'invalid_clearing_account'
      doc: 'Invalid Clearing Account'
    49:
      id: 'invalid_party_id'
      doc: 'Invalid Party Id'
    50:
      id: 'invalid_optional_data'
      doc: 'Invalid Optional Data'
    51:
      id: 'invalid_cross_id'
      doc: 'Invalid Cross Id'
    52:
      id: 'invalid_strategy_indicator'
      doc: 'Invalid Strategy Indicator'
    53:
      id: 'invalid_trade_id'
      doc: 'Invalid Trade Id'
    54:
      id: 'invalid_no_self_trade'
      doc: 'Invalid No Self Trade'
    55:
      id: 'invalid_cap_strategy'
      doc: 'Invalid Cap Strategy'
    56:
      id: 'invalid_special_ord_type'
      doc: 'Invalid Special Ord Type'
    57:
      id: 'invalid_routing_inst'
      doc: 'Invalid Routing Inst'
    58:
      id: 'invalid_offset_price'
      doc: 'Invalid Offset Price'
    59:
      id: 'invalid_extended_exec_inst'
      doc: 'Invalid Extended Exec Inst'
    60:
      id: 'invalid_introducing_badge_id'
      doc: 'Invalid Introducing Badge Id'
    61:
      id: 'invalid_bill_to'
      doc: 'Invalid Bill To'
    62:
      id: 'invalid_parent_firm_cl_ord_id'
      doc: 'Invalid Parent Firm Cl Ord Id'
    63:
      id: 'invalid_parent_firm_exchange_ord_id'
      doc: 'Invalid Parent Firm Exchange Ord Id'
    64:
      id: 'invalid_parent_firm'
      doc: 'Invalid Parent Firm'
    65:
      id: 'invalid_interest_type'
      doc: 'Invalid Interest Type'
    66:
      id: 'invalid_display_ind'
      doc: 'Invalid Display Ind'
    67:
      id: 'invalid_peg_ind'
      doc: 'Invalid Peg Ind'
    68:
      id: 'invalid_ceiling_floor_price'
      doc: 'Invalid Ceiling Floor Price'
    69:
      id: 'invalid_min_peg_qty'
      doc: 'Invalid Min Peg Qty'
    70:
      id: 'invalid_d_order_auction_price'
      doc: 'Invalid D Order Auction Price'
    71:
      id: 'invalid_disc_max_vol'
      doc: 'Invalid Disc Max Vol'
    72:
      id: 'invalid_dics_route_ind'
      doc: 'Invalid Dics Route Ind'
    73:
      id: 'invalid_minimum_trigger_vol_mtv'
      doc: 'Invalid Minimum Trigger Vol Mtv'
    74:
      id: 'invalid_attributed_quote'
      doc: 'Invalid Attributed Quote'
    75:
      id: 'invalid_proactive_if_locked'
      doc: 'Invalid Proactive If Locked'
    76:
      id: 'system_not_available'
      doc: 'System Not Available'
    77:
      id: 'system_full_mengrateexceeded'
      doc: 'System Full Mengrateexceeded'
    78:
      id: 'throttle_reject'
      doc: 'Throttle Reject'
    79:
      id: 'symbol_series_halted'
      doc: 'Symbol Series Halted'
    80:
      id: 'no_symbolseries_permission'
      doc: 'No Symbolseries Permission'
    81:
      id: 'price_too_far_outside'
      doc: 'Price Too Far Outside'
    82:
      id: 'mwcb_halt'
      doc: 'Mwcb Halt'
    83:
      id: 'market_closed'
      doc: 'Market Closed'
    84:
      id: 'symbolseries_closed'
      doc: 'Symbolseries Closed'
    85:
      id: 'luld_cancel_instruction'
      doc: 'Luld Cancel Instruction'
    86:
      id: 'no_price_slide_inst_during_ssr'
      doc: 'No Price Slide Inst During Ssr'
    87:
      id: 'invalid_stock_leg_give_up'
      doc: 'Invalid Stock Leg Give Up'
    88:
      id: 'invalid_no_legs'
      doc: 'Invalid No Legs'
    89:
      id: 'invalid_leg_position_effect'
      doc: 'Invalid Leg Position Effect'
    90:
      id: 'invalid_leg_symbol'
      doc: 'Invalid Leg Symbol'
    91:
      id: 'invalid_leg_cfi_code'
      doc: 'Invalid Leg Cfi Code'
    92:
      id: 'invalid_leg_maturity_date'
      doc: 'Invalid Leg Maturity Date'
    93:
      id: 'invalid_leg_strike_price'
      doc: 'Invalid Leg Strike Price'
    94:
      id: 'invalid_leg_contract_multiplier'
      doc: 'Invalid Leg Contract Multiplier'
    95:
      id: 'invalid_leg_ratio_qty'
      doc: 'Invalid Leg Ratio Qty'
    96:
      id: 'invalid_leg_side'
      doc: 'Invalid Leg Side'
    97:
      id: 'invalid_leg_ref_id'
      doc: 'Invalid Leg Ref Id'
    98:
      id: 'unsupported_order_type'
      doc: 'Unsupported Order Type'
    99:
      id: 'urout'
      doc: 'Urout'
    100:
      id: 'primary_market_not_available'
      doc: 'Primary Market Not Available'
    101:
      id: 'no_nbbopbbo_for_peg'
      doc: 'No Nbbopbbo For Peg'
    102:
      id: 'no_market_for_market_order'
      doc: 'No Market For Market Order'
    103:
      id: 'marketable_price'
      doc: 'Marketable Price'
    104:
      id: 'done_for_day'
      doc: 'Done For Day'
    105:
      id: 'credit_limit_violation'
      doc: 'Credit Limit Violation'
    106:
      id: 'cancel_remaining_ioc'
      doc: 'Cancel Remaining Ioc'
    107:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    108:
      id: 'invalid_poss_resend'
      doc: 'Invalid Poss Resend'
    109:
      id: 'cancel_pending'
      doc: 'Cancel Pending'
    110:
      id: 'symbol_series_already_opened'
      doc: 'Symbol Series Already Opened'
    111:
      id: 'firm_bulk_cancel'
      doc: 'Firm Bulk Cancel'
    112:
      id: 'on_behalf_of_comp_id_blocked'
      doc: 'On Behalf Of Comp Id Blocked'
    113:
      id: 'clearing_firm_blocked'
      doc: 'Clearing Firm Blocked'
    114:
      id: 'cancel_replace_pending'
      doc: 'Cancel Replace Pending'
    115:
      id: 'modify_pending'
      doc: 'Modify Pending'
    116:
      id: 'cannot_flip_imbalance'
      doc: 'Cannot Flip Imbalance'
    117:
      id: 'cannot_increase_imbalance'
      doc: 'Cannot Increase Imbalance'
    118:
      id: 'pending_cancel_imbalance_freeze'
      doc: 'Pending Cancel Imbalance Freeze'
    119:
      id: 'pending_replace_imbalance_freeze'
      doc: 'Pending Replace Imbalance Freeze'
    120:
      id: 'pending_modify_imbalance_freeze'
      doc: 'Pending Modify Imbalance Freeze'
    121:
      id: 'pending_cancel_routed_interest'
      doc: 'Pending Cancel Routed Interest'
    122:
      id: 'pending_replace_routed_interest'
      doc: 'Pending Replace Routed Interest'
    123:
      id: 'pending_modify_routed_interest'
      doc: 'Pending Modify Routed Interest'
    124:
      id: 'pending_auction_running'
      doc: 'Pending Auction Running'
    125:
      id: 'duplicative_order_check'
      doc: 'Duplicative Order Check'
    126:
      id: 'cancelled_by_exchange'
      doc: 'Cancelled By Exchange'
    127:
      id: 'new_order'
      doc: 'New Order'
    128:
      id: 'fill'
      doc: 'Fill'
    129:
      id: 'partial_fill'
      doc: 'Partial Fill'
    130:
      id: 'reduced'
      doc: 'Reduced'
    131:
      id: 'replaced'
      doc: 'Replaced'
    132:
      id: 'no_market_for_cross'
      doc: 'No Market For Cross'
    133:
      id: 'stp_cancel'
      doc: 'Stp Cancel'
    134:
      id: 'invalid_poss_dupe'
      doc: 'Invalid Poss Dupe'
    135:
      id: 'tpid_blocked'
      doc: 'Tpid Blocked'
    136:
      id: 'invalid_bulk_cancel'
      doc: 'Invalid Bulk Cancel'
    137:
      id: 'pending_bulk_cancel'
      doc: 'Pending Bulk Cancel'
    138:
      id: 'symbol_series_not_open'
      doc: 'Symbol Series Not Open'
    139:
      id: 'symbol_series_suspended'
      doc: 'Symbol Series Suspended'
    140:
      id: 'symbol_ipo_halt'
      doc: 'Symbol Ipo Halt'
    141:
      id: 'invld_inst_during_imbalance_freeze'
      doc: 'Invld Inst During Imbalance Freeze'
    142:
      id: 'invld_inst_after_cutoff_time'
      doc: 'Invld Inst After Cutoff Time'
    143:
      id: 'cancelled_by_primary_market'
      doc: 'Cancelled By Primary Market'
    144:
      id: 'pending_imbalance_freeze'
      doc: 'Pending Imbalance Freeze'
    145:
      id: 'no_rlp_permission'
      doc: 'No Rlp Permission'
    146:
      id: 'invalid_instruction_for_io_cs'
      doc: 'Invalid Instruction For Io Cs'
    147:
      id: 'system_full_cgrateexceeded'
      doc: 'System Full Cgrateexceeded'
    148:
      id: 'pending_cancel_auction_running'
      doc: 'Pending Cancel Auction Running'
    149:
      id: 'pending_modify_auction_running'
      doc: 'Pending Modify Auction Running'
    150:
      id: 'pending_replace_auction_running'
      doc: 'Pending Replace Auction Running'
    151:
      id: 'invld_inst_for_pending_order'
      doc: 'Invld Inst For Pending Order'
    152:
      id: 'ssh_price_below_nbb_on_iso'
      doc: 'Ssh Price Below Nbb On Iso'
    153:
      id: 'ioc_received_while_auction_running'
      doc: 'Ioc Received While Auction Running'
    154:
      id: 'pending_session_transition'
      doc: 'Pending Session Transition'
    155:
      id: 'pending_cancel_session_transition'
      doc: 'Pending Cancel Session Transition'
    156:
      id: 'pending_modify_session_transition'
      doc: 'Pending Modify Session Transition'
    157:
      id: 'pending_replace_session_transition'
      doc: 'Pending Replace Session Transition'
    158:
      id: 'invalid_for_tick_pilot'
      doc: 'Invalid For Tick Pilot'
    159:
      id: 'invalid_mmid'
      doc: 'Invalid Mmid'
    160:
      id: 'invalid_mpid'
      doc: 'Invalid Mpid'
    161:
      id: 'invalid_cancel_instead_of_reprice'
      doc: 'Invalid Cancel Instead Of Reprice'
    162:
      id: 'invalid_retail_indicator'
      doc: 'Invalid Retail Indicator'
    163:
      id: 'sender_comp_id_not_active'
      doc: 'Sender Comp Id Not Active'
    164:
      id: 'mpid_blocked'
      doc: 'Mpid Blocked'
    165:
      id: 'invalid_timestamp'
      doc: 'Invalid Timestamp'
    166:
      id: 'invalid_permission_for_sender_comp_id'
      doc: 'Invalid Permission For Sender Comp Id'
    167:
      id: 'invalid_user_data'
      doc: 'Invalid User Data'
    168:
      id: 'pillar_risk_mitigation'
      doc: 'Pillar Risk Mitigation'
    169:
      id: 'no_last_sale_for_peg'
      doc: 'No Last Sale For Peg'
    170:
      id: 'symbol_pending_closing_auction'
      doc: 'Symbol Pending Closing Auction'
    171:
      id: 'extreme_closing_order_imbalance'
      doc: 'Extreme Closing Order Imbalance'
    172:
      id: 'invalid_multi_message'
      doc: 'Invalid Multi Message'
    173:
      id: 'invalid_request_targeting_manual_sender_comp_id'
      doc: 'Invalid Request Targeting Manual Sender Comp Id'
    174:
      id: 'invalid_dmm_reject_reason'
      doc: 'Invalid Dmm Reject Reason'
    175:
      id: 'pending_pending_auction_state'
      doc: 'Pending Pending Auction State'
    176:
      id: 'pending_cancel_pending_auction_state'
      doc: 'Pending Cancel Pending Auction State'
    177:
      id: 'pending_modify_pending_auction_state'
      doc: 'Pending Modify Pending Auction State'
    178:
      id: 'pending_replace_pending_auction_state'
      doc: 'Pending Replace Pending Auction State'
    179:
      id: 'cancelled_dmm_manual_order_reprice'
      doc: 'Cancelled Dmm Manual Order Reprice'
    180:
      id: 'too_early_to_open'
      doc: 'Too Early To Open'
    181:
      id: 'too_early_to_close'
      doc: 'Too Early To Close'
    182:
      id: 'symbol_not_frozen_by_auction_request'
      doc: 'Symbol Not Frozen By Auction Request'
    183:
      id: 'symbol_is_frozen_by_dbk_gui'
      doc: 'Symbol Is Frozen By Dbk Gui'
    184:
      id: 'too_late_auction_running'
      doc: 'Too Late Auction Running'
    185:
      id: 'too_late_symbol_transition'
      doc: 'Too Late Symbol Transition'
    186:
      id: 'no_eligible_crossing_interest'
      doc: 'No Eligible Crossing Interest'
    187:
      id: 'book_is_lockedcrossed'
      doc: 'Book Is Lockedcrossed'
    188:
      id: 'no_interest_exists'
      doc: 'No Interest Exists'
    189:
      id: 'imbalance_too_large'
      doc: 'Imbalance Too Large'
    190:
      id: 'ssh_price_below_ssr_filing_price'
      doc: 'Ssh Price Below Ssr Filing Price'
    191:
      id: 'symbol_already_closed'
      doc: 'Symbol Already Closed'
    192:
      id: 'opening_template_opened'
      doc: 'Opening Template Opened'
    193:
      id: 'closing_template_opened'
      doc: 'Closing Template Opened'
    194:
      id: 'prin_entered_on_auction_template'
      doc: 'Prin Entered On Auction Template'
    195:
      id: 'mandatory_indication_submitted'
      doc: 'Mandatory Indication Submitted'
    196:
      id: 'pending_crowd_exists'
      doc: 'Pending Crowd Exists'
    197:
      id: 'no_consolidated_last_sale'
      doc: 'No Consolidated Last Sale'
    198:
      id: 'paired_qty_exceeds_max_trade_parameter'
      doc: 'Paired Qty Exceeds Max Trade Parameter'
    199:
      id: 'luld_or_mwcb_timer_running'
      doc: 'Luld Or Mwcb Timer Running'
    200:
      id: 'locking_crossing_away_quote'
      doc: 'Locking Crossing Away Quote'
    201:
      id: 'cross_not_eligible'
      doc: 'Cross Not Eligible'
    202:
      id: 'reserved_for_future_use_202'
      doc: 'Reserved For Future Use 202'
    203:
      id: 'pending_acceptance_for_ack_on_order_arrival'
      doc: 'Pending Acceptance For Ack On Order Arrival'
    204:
      id: 'rejected_cancel_by_dmm'
      doc: 'Rejected Cancel By Dmm'
    205:
      id: 'cancelled_by_dmm'
      doc: 'Cancelled By Dmm'
    206:
      id: 'price_is_outside_allowable_range'
      doc: 'Price Is Outside Allowable Range'
    207:
      id: 'auction_validation_in_progress'
      doc: 'Auction Validation In Progress'
    208:
      id: 'invalid_manual_action_id'
      doc: 'Invalid Manual Action Id'
    209:
      id: 'invalid_auction_sell_indicator'
      doc: 'Invalid Auction Sell Indicator'
    210:
      id: 'invalid_intraday_sell_short_qty'
      doc: 'Invalid Intraday Sell Short Qty'
    211:
      id: 'indication_template_is_open'
      doc: 'Indication Template Is Open'
    212:
      id: 'no_prev_closing_price'
      doc: 'No Prev Closing Price'
    213:
      id: 'cancelled_due_to_trading_collars'
      doc: 'Cancelled Due To Trading Collars'
    214:
      id: 'underlying_is_in_luld_state'
      doc: 'Underlying Is In Luld State'
    215:
      id: 'invalid_manual_response_type'
      doc: 'Invalid Manual Response Type'
    216:
      id: 'no_nyse_last_sale'
      doc: 'No Nyse Last Sale'
    217:
      id: 'symbol_direct_listing_state'
      doc: 'Symbol Direct Listing State'
    218:
      id: 'dmm_gui_reduction_in_manual_order_qty'
      doc: 'Dmm Gui Reduction In Manual Order Qty'
    219:
      id: 'cross_eligible'
      doc: 'Cross Eligible'
    220:
      id: 'dry_run'
      doc: 'Dry Run'
    221:
      id: 'unsupported_by_broker_plex'
      doc: 'Unsupported By Broker Plex'
    222:
      id: 'cross_blocked_by_bbopbbo'
      doc: 'Cross Blocked By Bbopbbo'
    223:
      id: 'risk_single_ord_max_qty'
      doc: 'Risk Single Ord Max Qty'
    224:
      id: 'risk_single_ord_max_notional'
      doc: 'Risk Single Ord Max Notional'
    225:
      id: 'risk_gross_credit_breach'
      doc: 'Risk Gross Credit Breach'
    226:
      id: 'risk_kill_switch'
      doc: 'Risk Kill Switch'
    227:
      id: 'invalid_route_to_broker'
      doc: 'Invalid Route To Broker'
    228:
      id: 'spread_too_wide'
      doc: 'Spread Too Wide'
    229:
      id: 'expire_fok'
      doc: 'Expire Fok'
    230:
      id: 'locks_displayed_interest'
      doc: 'Locks Displayed Interest'
    231:
      id: 'mm_quote_price_lockcross_contra_side_nbbo'
      doc: 'Mm Quote Price Lockcross Contra Side Nbbo'
    232:
      id: 'invalid_leg_symbols'
      doc: 'Invalid Leg Symbols'
    233:
      id: 'duplicate_leg_symbol'
      doc: 'Duplicate Leg Symbol'
    234:
      id: 'symbol_not_in_underlying'
      doc: 'Symbol Not In Underlying'
    235:
      id: 'leg_ratios_not_in_the_most_reduced_form'
      doc: 'Leg Ratios Not In The Most Reduced Form'
    236:
      id: 'option_leg_ratio_too_high'
      doc: 'Option Leg Ratio Too High'
    237:
      id: 'stock_leg_ratio_too_low'
      doc: 'Stock Leg Ratio Too Low'
    238:
      id: 'complex_series_already_exists'
      doc: 'Complex Series Already Exists'
    239:
      id: 'number_of_legs_incorrect'
      doc: 'Number Of Legs Incorrect'
    240:
      id: 'cancel_does_not_set_nbbo_inst'
      doc: 'Cancel Does Not Set Nbbo Inst'
    241:
      id: 'cancel_avoid_reprice_inst'
      doc: 'Cancel Avoid Reprice Inst'
    242:
      id: 'allow_reprice_once_then_cancel_inst'
      doc: 'Allow Reprice Once Then Cancel Inst'
    243:
      id: 'invalid_allocation_pct'
      doc: 'Invalid Allocation Pct'
    244:
      id: 'invalid_mm_quote_type'
      doc: 'Invalid Mm Quote Type'
    245:
      id: 'invalid_mm_sent_time'
      doc: 'Invalid Mm Sent Time'
    246:
      id: 'series_expired'
      doc: 'Series Expired'
    247:
      id: 'invalid_give_up_mmid'
      doc: 'Invalid Give Up Mmid'
    248:
      id: 'invalid_no_sides'
      doc: 'Invalid No Sides'
    249:
      id: 'pending_to_acceptance'
      doc: 'Pending To Acceptance'
    250:
      id: 'reserved_for_future_use_250'
      doc: 'Reserved For Future Use 250'
    251:
      id: 'invalid_bulk_action'
      doc: 'Invalid Bulk Action'
    252:
      id: 'invalid_cancel_scope'
      doc: 'Invalid Cancel Scope'
    253:
      id: 'no_legal_width_spread'
      doc: 'No Legal Width Spread'
    254:
      id: 'invalid_target_cancel_mpid'
      doc: 'Invalid Target Cancel Mpid'
    255:
      id: 'invalid_target_cancel_sender_comp_id'
      doc: 'Invalid Target Cancel Sender Comp Id'
    256:
      id: 'clear_the_book_prev_entered'
      doc: 'Clear The Book Prev Entered'
    257:
      id: 'timer_expired_api_allocation'
      doc: 'Timer Expired Api Allocation'
    258:
      id: 'invalid_number_of_quotes'
      doc: 'Invalid Number Of Quotes'
    259:
      id: 'invalid_order_id'
      doc: 'Invalid Order Id'
    260:
      id: 'risk_control_event'
      doc: 'Risk Control Event'
    261:
      id: 'to_rejected'
      doc: 'To Rejected'
    262:
      id: 'cancelled_corporate_action'
      doc: 'Cancelled Corporate Action'
    263:
      id: 'too_late_to_replace'
      doc: 'Too Late To Replace'
    264:
      id: 'invalid_ref_delta'
      doc: 'Invalid Ref Delta'
    265:
      id: 'invalid_stock_price'
      doc: 'Invalid Stock Price'
    266:
      id: 'reserved_for_future_use_266'
      doc: 'Reserved For Future Use 266'
    267:
      id: 'invalid_tied_to_stock'
      doc: 'Invalid Tied To Stock'
    268:
      id: 'too_late_to_allocate'
      doc: 'Too Late To Allocate'
    269:
      id: 'customer_interest_on_bbo'
      doc: 'Customer Interest On Bbo'
    270:
      id: 'ido_cannot_be_modified'
      doc: 'Ido Cannot Be Modified'
    271:
      id: 'cross_outside_bbo'
      doc: 'Cross Outside Bbo'
    272:
      id: 'pending_to_approval'
      doc: 'Pending To Approval'
    273:
      id: 'invalid_leg_open_close'
      doc: 'Invalid Leg Open Close'
    274:
      id: 'invalid_risk_control_type'
      doc: 'Invalid Risk Control Type'
    275:
      id: 'invalid_risk_control_activation'
      doc: 'Invalid Risk Control Activation'
    276:
      id: 'invalid_breach_action_request'
      doc: 'Invalid Breach Action Request'
    277:
      id: 'invalid_ioc_attribution'
      doc: 'Invalid Ioc Attribution'
    278:
      id: 'invalid_risk_action_type'
      doc: 'Invalid Risk Action Type'
    279:
      id: 'invalid_usd_limit'
      doc: 'Invalid Usd Limit'
    280:
      id: 'ido_already_exists'
      doc: 'Ido Already Exists'
    281:
      id: 'invalid_time_limit'
      doc: 'Invalid Time Limit'
    282:
      id: 'invalid_percentage_limit'
      doc: 'Invalid Percentage Limit'
    283:
      id: 'invalid_count_limit'
      doc: 'Invalid Count Limit'
    284:
      id: 'risk_roll_transact_breach'
      doc: 'Risk Roll Transact Breach'
    285:
      id: 'risk_roll_vol_breach'
      doc: 'Risk Roll Vol Breach'
    286:
      id: 'risk_roll_pct_breach'
      doc: 'Risk Roll Pct Breach'
    287:
      id: 'risk_roll_grmp_breach'
      doc: 'Risk Roll Grmp Breach'
    288:
      id: 'risk_mm_arbitrage_breach'
      doc: 'Risk Mm Arbitrage Breach'
    289:
      id: 'risk_mm_intrinsic_breach'
      doc: 'Risk Mm Intrinsic Breach'
    290:
      id: 'ido_must_exist'
      doc: 'Ido Must Exist'
    291:
      id: 'invalid_allocation_tag'
      doc: 'Invalid Allocation Tag'
    292:
      id: 'invalid_trade_tag'
      doc: 'Invalid Trade Tag'
    293:
      id: 'arbitrage_check'
      doc: 'Arbitrage Check'
    294:
      id: 'intrinsic_value_check'
      doc: 'Intrinsic Value Check'
    295:
      id: 'credit_debit_check'
      doc: 'Credit Debit Check'
    296:
      id: 'invalid_risk_user'
      doc: 'Invalid Risk User'
    297:
      id: 'invalid_risk_entity'
      doc: 'Invalid Risk Entity'
    298:
      id: 'invalid_flex_series_already_exists'
      doc: 'Invalid Flex Series Already Exists'
    299:
      id: 'invalid_flex_series_key'
      doc: 'Invalid Flex Series Key'
    300:
      id: 'invalid_clear_the_book'
      doc: 'Invalid Clear The Book'
    301:
      id: 'invalid_stock_qty'
      doc: 'Invalid Stock Qty'
    302:
      id: 'invalid_package_link_id'
      doc: 'Invalid Package Link Id'
    303:
      id: 'complex_max_series_breach'
      doc: 'Complex Max Series Breach'
    304:
      id: 'invalid_flex_eod_tag'
      doc: 'Invalid Flex Eod Tag'
    305:
      id: 'invalid_percentage_price'
      doc: 'Invalid Percentage Price'
    999:
      id: 'unknown_issue_encountered'
      doc: 'Unknown Issue Encountered'
  ack_type:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'new_interest'
      doc: 'New Interest'
    2:
      id: 'order_priority_update_new_order_id'
      doc: 'Order Priority Update New Order Id'
    3:
      id: 'order_priority_update_same_order_id'
      doc: 'Order Priority Update Same Order Id'
    4:
      id: 'bulk_cancel_ack'
      doc: 'Bulk Cancel Ack'
    5:
      id: 'pending_cancel'
      doc: 'Pending Cancel'
    6:
      id: 'pending_replace'
      doc: 'Pending Replace'
    7:
      id: 'pending_modify'
      doc: 'Pending Modify'
    8:
      id: 'replaced'
      doc: 'Replaced'
    9:
      id: 'modified'
      doc: 'Modified'
    10:
      id: 'eligible_for_cross'
      doc: 'Eligible For Cross'
    11:
      id: 'canceled'
      doc: 'Canceled'
    12:
      id: 'done_for_day'
      doc: 'Done For Day'
    13:
      id: 'billable_cancel_adding_liquidity'
      doc: 'Billable Cancel Adding Liquidity'
    14:
      id: 'billable_cancel_removing_liquidity'
      doc: 'Billable Cancel Removing Liquidity'
    15:
      id: 'billable_cancel_subdollar_adding_liquidity'
      doc: 'Billable Cancel Subdollar Adding Liquidity'
    16:
      id: 'billable_cancel_subdollar_removing_liquidity'
      doc: 'Billable Cancel Subdollar Removing Liquidity'
    17:
      id: 'gtc_renewal_restatement'
      doc: 'Gtc Renewal Restatement'
  flow_indicator:
    0:
      id: 'inbound_message_was_not_throttled'
      doc: 'Inbound Message Was Not Throttled'
    1:
      id: 'inbound_message_was_throttled'
      doc: 'Inbound Message Was Throttled'
  multileg_reporting_type:
    1:
      id: 'singleleg_security'
      doc: 'Singleleg Security'
    2:
      id: 'individual_leg_of_a_multileg_security'
      doc: 'Individual Leg Of A Multileg Security'
    3:
      id: 'multileg_security'
      doc: 'Multileg Security'
  participant_type:
    1:
      id: 'customer'
      doc: 'Customer'
    2:
      id: 'market_maker_lmm'
      doc: 'Market Maker Lmm'
    3:
      id: 'dmm'
      doc: 'Dmm'
    4:
      id: 'slp'
      doc: 'Slp'
    5:
      id: 'nyse_floor_broker_nyse_chicago_ib'
      doc: 'Nyse Floor Broker Nyse Chicago Ib'
  contra_open_close:
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'close'
      doc: 'Close'
  contra_customer_or_firm:
    1:
      id: 'customer'
      doc: 'Customer'
    2:
      id: 'firm'
      doc: 'Firm'
    3:
      id: 'broker'
      doc: 'Broker'
    4:
      id: 'market_maker'
      doc: 'Market Maker'
    5:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    6:
      id: 'prof_customer'
      doc: 'Prof Customer'
  contra_cross_type:
    10:
      id: 'qcc'
      doc: 'Qcc'
    11:
      id: 'customer_to_customer_cross'
      doc: 'Customer To Customer Cross'
  contra_covered_or_uncovered:
    1:
      id: 'exposed'
      doc: 'Exposed'
    2:
      id: 'covered'
      doc: 'Covered'
  covered_or_uncovered:
    1:
      id: 'exposed'
      doc: 'Exposed'
    2:
      id: 'covered'
      doc: 'Covered'
  bust_correct_indicator:
    0:
      id: 'trade_bust'
      doc: 'Trade Bust'
    1:
      id: 'trade_correction'
      doc: 'Trade Correction'
  reject_type:
    1:
      id: 'order_cancel_replace_reject'
      doc: 'Order Cancel Replace Reject'
    2:
      id: 'modify_request_reject'
      doc: 'Modify Request Reject'
    3:
      id: 'cancel_request_reject'
      doc: 'Cancel Request Reject'
    4:
      id: 'bulk_cancel_request_reject'
      doc: 'Bulk Cancel Request Reject'
    5:
      id: 'new_bulk_quote_reject'
      doc: 'New Bulk Quote Reject'
    6:
      id: 'manual_action_response_reject'
      doc: 'Manual Action Response Reject'
    7:
      id: 'risk_limit_update_request_reject'
      doc: 'Risk Limit Update Request Reject'
    8:
      id: 'bulk_cancel_request_reject_options'
      doc: 'Bulk Cancel Request Reject Options'
    9:
      id: 'cross_order_reject'
      doc: 'Cross Order Reject'
    10:
      id: 'new_complex_series_request_reject'
      doc: 'New Complex Series Request Reject'
    11:
      id: 'risk_action_request_reject'
      doc: 'Risk Action Request Reject'
  risk_ack_type:
    0:
      id: 'solicited_ack'
      doc: 'Solicited Ack'
    1:
      id: 'unsolicited_ack'
      doc: 'Unsolicited Ack'
  breach_action_response:
    1:
      id: 'notification'
      doc: 'Notification'
    2:
      id: 'cancel_non_auction_orders'
      doc: 'Cancel Non Auction Orders'
    3:
      id: 'block'
      doc: 'Block'
  blocked_by_breach_indicator:
    0:
      id: 'not_blocked_by_breach'
      doc: 'Not Blocked By Breach'
    1:
      id: 'blocked_by_breach'
      doc: 'Blocked By Breach'
    2:
      id: 'blocked_by_arbitrage_check'
      doc: 'Blocked By Arbitrage Check'
    3:
      id: 'blocked_by_intrinsic_value_check'
      doc: 'Blocked By Intrinsic Value Check'
  blocked_by_kill_switch_indicator:
    0:
      id: 'not_blocked_by_kill_switch'
      doc: 'Not Blocked By Kill Switch'
    1:
      id: 'blocked_by_kill_switch'
      doc: 'Blocked By Kill Switch'
  reinstatement_requiredby_self:
    0:
      id: 'not_required'
      doc: 'Not Required'
    1:
      id: 'required'
      doc: 'Required'
  reinstatement_requiredby_other:
    0:
      id: 'not_required'
      doc: 'Not Required'
    1:
      id: 'required'
      doc: 'Required'
  threshold_breach_level:
    1:
      id: 'greater_than_50_percent'
      doc: 'Greater Than 50 Percent'
    2:
      id: 'greater_than_75_percent'
      doc: 'Greater Than 75 Percent'
    3:
      id: 'greater_than_90_percent'
      doc: 'Greater Than 90 Percent'
    4:
      id: 'greater_than_100_percent'
      doc: 'Greater Than 100 Percent'

