# ---------------------------------------------------------------------
# Kaitai struct definition for: Euronext Optiq MarketDataPacket Udp v1
#
# Protocol:
#   Organization: Euronext
#   Protocol: Market Data Packet
#   Encoding: User Datagram Protocol
#   Version: 1
#   Date: 5/16/2023
#   Specification: Unknown
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
  id: euronext_optiq_marketdatapacket_udp_v1
  title: Euronext Optiq MarketDataPacket Udp v1
  license: GPL-3.0
  endian: le

doc: 'Euronext Euronext Optiq Market Data Packet Udp v1'
doc-ref: https://connect2.euronext.com/en/membership/resources/it-documentation

seq:
  - id: market_data_packet_header
    type: market_data_packet_header_struct
    doc: 'Optiq Udp Market Data Packet Header'
  - id: optiq_message
    type: optiq_message_struct
    repeat: eos
    doc: 'Optiq Udp Message'

types:
  market_data_packet_header_struct:
    seq:
      - id: packet_time
        type: nanosecond_timestamp
        doc: 'Time when the packet is pushed to the clients. Nanoseconds since Unix epoch'
      - id: packet_sequence_number
        type: u4
        doc: 'Each channel has its own PSN sequence'
      - id: packet_flags
        type: packet_flags
        doc: 'Packet Flags'
      - id: channel_id
        type: u2
        doc: 'Identifies the channel'
  packet_flags:
    meta:
      bit-endian: le
    seq:
      - id: compression
        type: b1
        doc: 'body of the packet is compressed'
      - id: mdg_restart_count
        type: b3
        doc: 'Will be set to 0 every morning and incremented for each restart of MDG in the same day'
      - id: psn_high_weight
        type: b3
        doc: 'Packet Sequence Number goes over (2^32)-1. They are PSN high weight bits'
      - id: has_start_of_day_snapshot
        type: b1
        doc: 'Packet contains Start Of Day Snapshot'
      - id: has_end_of_day_snapshot
        type: b1
        doc: 'Packet contains End Of Day Snapshot'
      - id: has_status_message
        type: b1
        doc: 'Packet contains a Health Status (1103) message, Start Of Day (1101) message or End Of Day (1102) message'
      - id: reserved_bits
        type: b6
        doc: 'Bits Reserved for future use'
  optiq_message_struct:
    seq:
      - id: frame
        type: u2
        doc: 'Total bytes of packet including this header'
      - id: message_header
        type: message_header
        doc: 'Optiq Sbe message header — message identifiers and length of message root'
      - id: payload
        size: frame - 10
        doc: 'Raw message bytes'
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Length of the root of the message contained before repeating groups or variable-length fields'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        doc: 'Identifier of the schema publishing the message'
      - id: version
        type: u2
        doc: 'Schema version'
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
  template_id:
    1103:
      id: 'health_status_message'
      doc: 'HealthStatus'

