# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseEquities BinaryGateway PillarStream v5.8
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Binary Gateway
#   Encoding: Pillar Stream Protocol
#   Version: 5.8
#   Date: 8/23/2023
#   Specification: NYSE_Pillar_Gateway_Binary_Protocol_Specification.pdf
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
  id: nyse_nyseequities_binarygateway_pillarstream_v5_8
  title: Nyse NyseEquities BinaryGateway PillarStream v5.8
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Equities Binary Gateway PillarStream v5.8'
doc-ref: https://www.nyse.com/connectivity/specs

seq:
  - id: pillar_stream_message
    type:
      switch-on: peek_msg_type
      cases:
        'msg_type::login': login_message_struct
        'msg_type::login_response': login_response_struct
        'msg_type::stream_avail': stream_avail_struct
        'msg_type::heartbeat': heartbeat_struct
        'msg_type::open': open_struct
        'msg_type::open_response': open_response_struct
        'msg_type::close': close_struct
        'msg_type::close_response': close_response_struct
        'msg_type::seq_msg': seq_msg_struct

instances:
  peek_msg_type:
    pos: 0
    type: u2
    enum: msg_type

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
        doc: 'Pillar Username'
      - id: password
        type: str
        size: 32
        encoding: ASCII
        doc: 'User password in plain text'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market to login'
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
        doc: 'Pillar Username'
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
        type: u4
        doc: '4 bytes reserved for future use'
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
            'seq_msg_type::new_order_single_and_cancel_replace_request_message': new_order_single_and_cancel_replace_request_message
  seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Message sequence number'
  seq_msg_header:
    seq:
      - id: seq_msg_type
        type: u2
        enum: seq_msg_type
        doc: 'Code identifying this message type'
      - id: seq_msg_length
        type: u2
        doc: 'Length of sequenced data message including this field'
  new_order_single_and_cancel_replace_request_message:
    seq:
      - id: symbol_id
        type: u4
        doc: 'Identification number assigned to the security'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Firm Identifier – MPID'
      - id: mmid
        type: u4
        doc: 'This value represents the integer representation of a Market Maker, LMM, SLP, SLMM or DMM, agreed upon between the firm and the Exchange. These firms must provide their MMID along with its associated MPID on all orders intended to receive credit for satisfying their marking making/liquidity obligations'
      - id: mp_sub_id
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer defined – identifies specific entity/trading desk of customer firm'
      - id: cl_ord_id
        type: u8
        doc: 'Unique ID of the new Order, Cancel/Replace, Cancel, Modify, or Bulk Cancel request as assigned by the firm'
      - id: orig_cl_ord_id
        type: u8
        doc: 'Refers to the ClOrdID of a previously entered order'
      - id: bitfield_order_instructions_u_12816
        size: 16
        doc: 'Bitfield containing various order attributes and modifiers'
      - id: price
        type: decimal_s8_8
        doc: '0.000001-999999.999999. Implied decimal with scale 1e-8'
      - id: order_qty
        type: u4
        doc: '1 - 999,999,999'
      - id: min_qty
        type: u4
        doc: '0 = no MinQty Otherwise, Must be ≥ Round Lot and ≤ OrderQty'
      - id: user_data
        type: str
        size: 8
        encoding: ASCII
        doc: 'Customer defined up to 8 characters; only printable ASCII characters allowed, excluding comma, semicolon, pipe delimiter, “at” symbol, greater than/less than, ampersand (&) and single/double quotation mark'
      - id: optional_order_add_on
        type: optional_order_add_on
        if: _parent.seq_msg_header.seq_msg_length > 61
        doc: 'OptionalOrderAddOn'
  optional_order_add_on:
    seq:
      - id: sub_msg_header
        type: sub_msg_header
        doc: 'Pillar Stream Sub Message Item Header'
      - id: stop_px
        type: decimal_s8_8
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0

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
    0x0240:
      id: 'new_order_single_and_cancel_replace_request_message'
      doc: 'This message type is used as both a New Order message or a Cancel/Replacement message'

