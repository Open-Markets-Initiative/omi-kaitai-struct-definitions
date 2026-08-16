# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex BrokerTecUst Sbe v10.1
#
# Protocol:
#   Organization: CME Group
#   Protocol: BrokerTec Us Treasuries
#   Encoding: Simple Binary Encoding
#   Version: 10.1
#   Date: 4/13/2023
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: cme_globex_brokertecust_sbe_v10_1_tcp
  title: Cme Globex BrokerTecUst Sbe v10.1
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex BrokerTec Us Treasuries Sbe v10.1'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/BrokerTec+U.S.+Treasury+Market+Data

seq:
  - id: technical_header
    type: technical_header_struct
    doc: 'Cme Technical Header'
  - id: tcp_message
    type: tcp_message_struct
    repeat: eos
    doc: 'Cme Market Data Message'

types:
  technical_header_struct:
    seq:
      - id: encoding_type
        type: u2
        doc: 'Encoding Type'
      - id: message_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: tcp_sending_time
        type: u8
        doc: 'Packet Sending Time'
  tcp_message_struct:
    seq:
      - id: tcp_message_size
        type: u2
        doc: 'Message Size'
      - id: message_header
        type: message_header
        doc: 'Template ID and length of message root'
      - id: payload
        size: tcp_message_size - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::md_incremental_refresh_btec': md_incremental_refresh_btec
  message_header:
    seq:
      - id: block_length
        type: u2
      - id: template_id
        type: u2
        enum: template_id
      - id: schema_id
        type: u2
      - id: version
        type: u2
  md_incremental_refresh_btec:
    seq:
      - id: trade_date
        type: u2_nullable
        doc: 'Trade Date. Nullable, No Value = 65535'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Event processing time (UTC), sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: incremental_refresh_btec_groups
        type: incremental_refresh_btec_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_btec_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_btec_group
        type: incremental_refresh_btec_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of data blocks'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  incremental_refresh_btec_group:
    seq:
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Indicates the type of Market Data update action'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Indicates the type of Market Data entry'
      - id: md_entry_px
        type: md_entry_px
        doc: 'Number of data blocks'
      - id: md_entry_size
        type: u4_nullable
        doc: 'Quantity or volume represented by the Market Data Entry. Nullable, No Value = 4294967295'
      - id: md_price_level
        type: u1_nullable
        doc: 'Price level in the book. Nullable, No Value = 255'
      - id: trade_volume
        type: u4_nullable
        doc: 'Total traded volume since the beginning of the session. If this tag is not present, then there is no volume. Nullable, No Value = 4294967295'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Contract symbol, name'
      - id: maturity_date
        type: u2_nullable
        doc: 'Instrument Maturity Date. Nullable, No Value = 65535'
      - id: security_alt_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'CUSIP'
      - id: security_alt_id_source
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies class or source of the SecurityAltID (455) value'
      - id: coupon_rate
        type: coupon_rate
        doc: 'Number of data blocks'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'List of conditions describing a trade. H= Hit, T=Take'
      - id: price_type
        type: u1_nullable
        doc: 'Price type condition. 9=Yield. Nullable, No Value = 255'
  md_entry_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = -9223372036854775808'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127. Nullable, No Value = -128'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  coupon_rate:
    seq:
      - id: mantissa_32
        type: s4
        doc: 'mantissa. Nullable, No Value = 2147483647'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127. Nullable, No Value = -128'
    instances:
      real:
        value: 'mantissa_32 * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255

enums:
  template_id:
    405:
      id: 'md_incremental_refresh_btec'
      doc: 'MDIncrementalRefreshBtec'
    411:
      id: 'admin_heartbeat'
      doc: 'AdminHeartbeat'
  md_update_action:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'update'
      doc: 'Update'
    2:
      id: 'delete_field'
      doc: 'Delete'
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'offer'
      doc: 'Offer'
    0x32:
      id: 'trade'
      doc: 'Trade'
    0x34:
      id: 'open_price'
      doc: 'Open Price'
    0x35:
      id: 'close_price'
      doc: 'Close Price'
    0x37:
      id: 'high_trade_price'
      doc: 'Trading Session High Price'
    0x38:
      id: 'low_trade_price'
      doc: 'Trading Session Low Price'
    0x39:
      id: 'vwap'
      doc: 'VWAP or VWAY'
    0x45:
      id: 'implied_bid'
      doc: 'Implied Bid'
    0x46:
      id: 'implied_offer'
      doc: 'Implied Offer'
    0x4a:
      id: 'book_reset'
      doc: 'Book Reset'

