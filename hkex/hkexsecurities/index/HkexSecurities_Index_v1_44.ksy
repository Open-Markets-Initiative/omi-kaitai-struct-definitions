# ---------------------------------------------------------------------
# Kaitai struct definition for: Hkex HkexSecurities Index Omd v1.44
#
# Protocol:
#   Organization: Hong Kong Exchanges and Clearing
#   Protocol: Orion Market Data Cash Index
#   Encoding: Orion Market Data
#   Version: 1.44
#   Date: 7/21/2025
#   Specification: HKEX_OMD-C_Binary_Interface_Specifications_v1.44.pdf
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
  id: hkex_hkexsecurities_index_omd_v1_44
  title: Hkex HkexSecurities Index Omd v1.44
  license: GPL-3.0
  endian: le

doc: 'Hong Kong Exchanges and Clearing Hkex Securities Market Orion Market Data Cash Index Omd v1.44'
doc-ref: https://www.hkex.com.hk/Mutual-Market/Stock-Connect/Reference-Materials/Technical-Documents

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Omd packet header (no payload compression; byte 3 is Filler)'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.msg_count

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'Size of the packet including this field'
      - id: msg_count
        type: u1
        doc: 'Number of messages included in the packet'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved filler byte (OMD does not use payload compression)'
      - id: seq_num
        type: u4
        doc: 'Sequence number of the first message in the packet'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time of the packet — nanoseconds since Unix epoch UTC (precision to millisecond). Nanoseconds since Unix epoch'
  message_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Omd message header'
      - id: payload
        size: msg_header.msg_size - 4
        type:
          switch-on: msg_header.msg_type
          cases:
            'msg_type::sequence_reset_message': sequence_reset_message
            'msg_type::disaster_recovery_signal_message': disaster_recovery_signal_message
            'msg_type::index_definition_message': index_definition_message
            'msg_type::index_data_message': index_data_message
  msg_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'Length of the message including this field'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Code identifying this message type'
  sequence_reset_message:
    seq:
      - id: new_seq_no
        type: u4
        doc: 'New sequence number. Always set to 1'
  disaster_recovery_signal_message:
    seq:
      - id: dr_status
        type: u4
        enum: dr_status
        doc: 'Status during site failover'
  index_definition_message:
    seq:
      - id: index_code
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Upstream source''s index code or market information identifier'
      - id: index_source
        type: u1
        enum: index_source
        doc: 'Index or market information source'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code of Index Turnover. Can be blank if not defined by third party index compilers'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  index_data_message:
    seq:
      - id: index_code
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Upstream source''s index code or market information identifier'
      - id: index_status
        type: u1
        enum: index_status
        doc: 'Index status. Can be blank if not defined by third party index compilers'
      - id: index_time
        type: s8
        doc: 'Publisher timestamp. Nanoseconds since Unix epoch UTC, precision to the nearest second'
      - id: index_value
        type: decimal_s8_4
        doc: 'Current value of the index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: net_chg_prev_day
        type: decimal_s8_4
        doc: 'Net change of IndexValue from the previous close, as provided in index source. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: high_value
        type: decimal_s8_4
        doc: 'Highest value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: low_value
        type: decimal_s8_4
        doc: 'Lowest value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: eas_value
        type: decimal_s8_2
        doc: 'Estimated Average Settlement Value. 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: index_turnover
        type: decimal_s8_4
        doc: 'Current turnover of underlying constituents. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: opening_value
        type: decimal_s8_4
        doc: 'First value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: closing_value
        type: decimal_s8_4
        doc: 'Last value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: previous_ses_close
        type: decimal_s8_4
        doc: 'Previous session closing value (previous day for CSI, CES, S&P; previous session for HSI and TR). 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: index_volume
        type: s8
        doc: 'Index volume of underlying constituents. Only applicable for CSI and CES'
      - id: net_chg_prev_day_pct
        type: decimal_s4_4
        doc: 'Percentage change of IndexValue from the previous close. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: exception
        type: u1
        enum: exception
        doc: 'Exception indicator'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_2:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100.0
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  msg_type:
    100:
      id: 'sequence_reset_message'
      doc: 'The Sequence Reset message is sent on each multicast channel at start of day. It may also be sent when there is a need for the rectification of stock reference data before market open.'
    105:
      id: 'disaster_recovery_signal_message'
      doc: 'The Disaster Recovery (DR) Signal message is sent on a dedicated multicast channel whenever a site failover scenario is triggered.'
    70:
      id: 'index_definition_message'
      doc: 'The Index Definition message contains the static referential data for the given index and is generated at the start of the business day. May be re-disseminated during trading hours.'
    71:
      id: 'index_data_message'
      doc: 'The Index Data message contains all the real-time data for a given index. Fields may be populated with null values to indicate when an update is not provided.'
  dr_status:
    1:
      id: 'dr_in_progress'
      doc: 'Dr In Progress'
    2:
      id: 'dr_completed'
      doc: 'Dr Completed'
  index_source:
    0x43:
      id: 'csi_and_ces'
      doc: 'Csi And Ces'
    0x48:
      id: 'hsi'
      doc: 'Hsi'
    0x53:
      id: 's_and_p'
      doc: 'S And P'
  index_status:
    0x43:
      id: 'closing_value'
      doc: 'Closing Value'
    0x49:
      id: 'indicative'
      doc: 'Indicative'
    0x4f:
      id: 'opening_index'
      doc: 'Opening Index'
    0x50:
      id: 'last_close_value_previous_session'
      doc: 'Last Close Value Previous Session'
    0x52:
      id: 'preliminary_close'
      doc: 'Preliminary Close'
    0x53:
      id: 'stop_loss_index'
      doc: 'Stop Loss Index'
    0x54:
      id: 'realtime_index_value'
      doc: 'Realtime Index Value'
  exception:
    0x23:
      id: 'index_with_hsil_defined_exceptional_rule_applied'
      doc: 'Index With Hsil Defined Exceptional Rule Applied'
    0x20:
      id: 'normal_index'
      doc: 'Normal Index'

