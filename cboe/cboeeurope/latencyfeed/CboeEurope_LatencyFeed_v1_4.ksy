# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CboeEurope LatencyFeed Pitch v1.4
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Latency Feed
#   Encoding: Pitch
#   Version: 1.4
#   Date: 2/19/2016
#   Specification: BATS_Europe_Multicast_Latency_Feed_Specification.pdf
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
  id: cboe_cboeeurope_latencyfeed_pitch_v1_4
  title: Cboe CboeEurope LatencyFeed Pitch v1.4
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Europe Multicast Latency Feed Pitch v1.4'
doc-ref: https://www.cboe.com/europe/equities/support/technical

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Message Count messages to follow'
      - id: message_count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::latency_stat_message': latency_stat_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  latency_stat_message:
    seq:
      - id: measurement_type
        type: u1
        enum: measurement_type
        doc: '0 (zero) = Order to Quote'
      - id: matching_unit
        type: u1
        doc: 'Refer to the Multicast PITCH specification for Matching Unit mappings'
      - id: begin_time
        type: u4
        doc: 'Number of milliseconds from midnight (London time)'
      - id: end_time
        type: u4
        doc: 'Number of milliseconds from midnight (London time)'
      - id: count
        type: u4
        doc: 'Count of orders used in calculation of all other metrics from Begin Time to End Time'
      - id: minimum
        size: 8
        doc: 'Minimum order processing latency (seconds) from Begin Time to End Time'
      - id: maximum
        size: 8
        doc: 'Maximum order processing latency (seconds) from Begin Time to End Time'
      - id: average
        size: 8
        doc: 'Average order processing latency (seconds) from Begin Time to End Time'
      - id: standard_deviation
        size: 8
        doc: 'Standard deviation'
      - id: mode
        size: 8
        doc: 'Mode of order processing latency (seconds) from Begin Time to End Time'
      - id: percentile_99_point_9
        size: 8
        doc: '99.9 percentile of order processing latency (seconds) from Begin Time to End Time'
      - id: percentile_99
        size: 8
        doc: '99 percentile of order processing latency (seconds) from Begin Time to End Time'
      - id: percentile_95
        size: 8
        doc: '95 percentile of order processing latency (seconds) from Begin Time to End Time'
      - id: percentile_90
        size: 8
        doc: '90 percentile of order processing latency (seconds) from Begin Time to End Time'
      - id: percentile_75
        size: 8
        doc: '75 percentile of order processing latency (seconds) from Begin Time to End Time'
      - id: percentile_50
        size: 8
        doc: '50 percentile of order processing latency (seconds) from Begin Time to End Time'
      - id: percentile_25
        size: 8
        doc: '25 percentile of order processing latency (seconds) from Begin Time to End Time'

enums:
  message_type:
    0x90:
      id: 'latency_stat_message'
      doc: 'A Latency Stat Message demonstrates performance for a specific Matching Engine unit for a specific timeframe'
  measurement_type:
    0:
      id: 'order_to_quote'
      doc: 'Order To Quote'

