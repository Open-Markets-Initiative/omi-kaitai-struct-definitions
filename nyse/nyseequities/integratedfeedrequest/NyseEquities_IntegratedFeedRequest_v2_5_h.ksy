# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseEquities IntegratedFeedRequest Pillar v2.5.h
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Integrated Feed Request
#   Encoding: Pillar
#   Version: 2.5.h
#   Date: 07/30/2026
#   Specification: NYSE_Pillar_Integrated_Feed_Client_Specification.pdf
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
  id: nyse_nyseequities_integratedfeedrequest_pillar_v2_5_h
  title: Nyse NyseEquities IntegratedFeedRequest Pillar v2.5.h
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Equities Integrated Feed Request Pillar v2.5.h'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/NYSE_Pillar_Integrated_Feed_Client_Specification.pdf

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Pillar common client tcp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_msgs
    doc: 'Pillar message'

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'The size of the packet in bytes, including this 16 byte packet header'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'A flag that indicates whether this is an original, retransmitted, or ‘replayed’ message'
      - id: number_msgs
        type: u1
        doc: 'The number of messages in this packet'
      - id: seq_num
        type: u4
        doc: 'The message sequence number of the first message in this packet'
      - id: send_time
        type: send_time
        doc: 'The time when this packet was sent on the request channel. Nanoseconds since Unix epoch'
  send_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds since Jan 1, 1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The nanosecond offset from the Send Time. Nanoseconds since Second epoch'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Pillar message header'
      - id: payload
        size: message_header.message_size - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::retransmission_request_message': retransmission_request_message
            'message_type::request_response_message': request_response_message
            'message_type::heartbeat_response_message': heartbeat_response_message
            'message_type::symbol_index_mapping_request_message': symbol_index_mapping_request_message
            'message_type::refresh_request_message': refresh_request_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'The size of this message in bytes'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  retransmission_request_message:
    seq:
      - id: begin_seq_num
        type: u4
        doc: 'The beginning sequence number of the range of messages to be retransmitted'
      - id: end_seq_num
        type: u4
        doc: 'The end sequence number of the range of messages to be retransmitted'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID of the feed for which a retransmission is requested (listed in the feed''s client specification)'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel on which the gap occurred'
  request_response_message:
    seq:
      - id: request_seq_num
        type: u4
        doc: 'The sequence number of the request message sent by the client. This can be used by the client to couple this response with the original request message'
      - id: begin_seq_num
        type: u4
        doc: 'The beginning sequence number of the range of messages to be retransmitted'
      - id: end_seq_num
        type: u4
        doc: 'The end sequence number of the range of messages to be retransmitted'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID of the feed for which a retransmission is requested (listed in the feed''s client specification)'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel on which the gap occurred'
      - id: status
        type: u1
        enum: status
        doc: 'The reason why the request was rejected'
  heartbeat_response_message:
    seq:
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
  symbol_index_mapping_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The ID (from the Symbol Index msg) of the symbol for which a refresh is requested. To request a refresh for all symbols in the specified channel, set this field to 0'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID of the feed for which a retransmission is requested (listed in the feed''s client specification)'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel on which the gap occurred'
      - id: retransmit_method
        type: u1
        doc: 'The delivery method for the requested symbol index mapping information. Valid values: 0 - deliver via UDP'
  refresh_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The ID (from the Symbol Index msg) of the symbol for which a refresh is requested. To request a refresh for all symbols in the specified channel, set this field to 0'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID of the feed for which a retransmission is requested (listed in the feed''s client specification)'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel on which the gap occurred'
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
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000

enums:
  delivery_flag:
    1:
      id: 'heartbeat'
      doc: 'Pillar Heartbeat Message'
    10:
      id: 'pillar_failover'
      doc: 'Pillar Failover'
    11:
      id: 'original_message'
      doc: 'Original Message'
    12:
      id: 'sequence_number_reset_message'
      doc: 'Sequence Number Reset Message'
    13:
      id: 'one_retransmission_packet'
      doc: 'Only one packet in retransmission sequence'
    15:
      id: 'retransmission_sequence_message'
      doc: 'Part of a retransmission sequence'
    17:
      id: 'one_refresh_packet'
      doc: 'One packet in Refresh sequence'
    18:
      id: 'refresh_sequence_start'
      doc: 'Start of Refresh sequence'
    19:
      id: 'refresh_sequence_message'
      doc: 'Part of a Refresh sequence'
    20:
      id: 'refresh_sequence_end'
      doc: 'End of Refresh Sequence'
    21:
      id: 'message_unavailable'
      doc: 'Message Unavailable'
  message_type:
    10:
      id: 'retransmission_request_message'
      doc: 'Clients who have experienced a sequence number gap and need a retransmission of the missed messages should send a Retransmission Request message via TCP to the Request Controller.'
    11:
      id: 'request_response_message'
      doc: 'This message will be sent immediately via TCP/IP in response to the client''s request for retransmission, refresh or Symbol Mapping messages.'
    12:
      id: 'heartbeat_response_message'
      doc: 'Clients who remain connected to the Retransmission Server intraday must respond to a Heartbeat with a Heartbeat Response message within 5 seconds. If no timely client response is received, the connection will be closed.'
    13:
      id: 'symbol_index_mapping_request_message'
      doc: 'This message is sent by clients via TCP/IP requesting the Symbol Index Mapping messages for one or all symbols in a specified channel.'
    15:
      id: 'refresh_request_message'
      doc: 'Clients who have experienced a failure and need a refresh of the state of one or all symbols in a specific channel should send a Refresh Request message via TCP to the Request Controller.'
  status:
    0x30:
      id: 'message_was_accepted'
      doc: 'Message Was Accepted'
    0x31:
      id: 'rejected_due_to_an_invalid_source_id'
      doc: 'Rejected Due To An Invalid Source Id'
    0x33:
      id: 'rejected_due_to_maximum_sequence_range_see_threshold_limits'
      doc: 'Rejected Due To Maximum Sequence Range See Threshold Limits'
    0x34:
      id: 'rejected_due_to_maximum_request_in_a_day'
      doc: 'Rejected Due To Maximum Request In A Day'
    0x35:
      id: 'rejected_due_to_maximum_number_of_refresh_requests_in_a_day'
      doc: 'Rejected Due To Maximum Number Of Refresh Requests In A Day'
    0x36:
      id: 'rejected_request_message_seq_num_ttl_time_to_live_is_too_old_use_refresh_to_recover_current_state_if_necessary'
      doc: 'Rejected Request Message Seq Num Ttl Time To Live Is Too Old Use Refresh To Recover Current State If Necessary'
    0x37:
      id: 'rejected_due_to_an_invalid_channel_id'
      doc: 'Rejected Due To An Invalid Channel Id'
    0x38:
      id: 'rejected_due_to_an_invalid_product_id'
      doc: 'Rejected Due To An Invalid Product Id'
    0x39:
      id: 'rejected_due_to_1_invalid_msg_type_or_2_mismatch_between_msg_type_and_msg_size'
      doc: 'Rejected Due To 1 Invalid Msg Type Or 2 Mismatch Between Msg Type And Msg Size'

