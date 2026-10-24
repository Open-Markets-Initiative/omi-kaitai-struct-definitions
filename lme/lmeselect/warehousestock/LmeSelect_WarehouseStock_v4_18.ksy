# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect WarehouseStock LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource WarehouseStock
#   Encoding: LMEsource
#   Version: 4.18
#   Date: 08/18/2026
#   Specification: lmesource-client-interface-specification-v4-18.pdf
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
  id: lme_lmeselect_warehousestock_lmesource_v4_18
  title: Lme LmeSelect WarehouseStock LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource WarehouseStock LmeSource v4.18'
doc-ref: https://www.lme.com/Trading/Systems/LMEsource

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'LMEsource packet header, giving the packet size, the number of messages it carries, the sequence number of the first of them and the time the packet was sent'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.msg_count
    doc: 'LMEsource application messages carried by this packet; a message is never fragmented across packets'

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'Size of the packet, including this field'
      - id: msg_count
        type: u1
        doc: 'Number of messages included in the packet'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        doc: 'Filler aligning the sequence number to a four byte boundary'
      - id: seq_num
        type: u4
        doc: 'Sequence number of the first message in the packet'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'UTC timestamp for the time this packet was sent, in nanoseconds since epoch, provided to the nearest microsecond. Nanoseconds since Unix epoch'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'LMEsource message header, giving the size of the message and its type'
      - id: payload
        size: message_header.msg_size - 4
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::sequence_reset_message': sequence_reset_message
            'msg_type::warehouse_stock_movement_message': warehouse_stock_movement_message
  message_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'Message length, including this field'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Type of message, selecting the payload that follows the message header'
  sequence_reset_message:
    seq:
      - id: new_seq_no
        type: u4
        doc: 'New sequence number. Always set to 1'
  warehouse_stock_movement_message:
    seq:
      - id: report_date
        type: yyyymmdd_date
        doc: 'The business date for which the stock movement is being reported, as YYYYMMDD'
      - id: report_level
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the level at which the stock movement quantity is being reported'
      - id: remaining_records
        type: u2
        doc: 'Number of remaining records to be published for a product. When the value of RemainingRecords equals RecordCount this is the last message for the report level'
      - id: num_stock_records
        type: u2
        doc: 'Number of repeating records in this message'
      - id: stock_records
        type: stock_records
        repeat: expr
        repeat-expr: num_stock_records
        doc: 'One warehouse stock movement record. The specification''s length formula names the repeat NoOfRecords, a field no table of this message declares; RecordCount is the count it gives, as the number of repeating records in this message'
  stock_records:
    seq:
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code. This identifies the commodity'
      - id: location
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Location where the commodity exists, as a four character code. Space if ReportLevel is Summary or Grade'
      - id: grade_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Grade of the commodity. Space if ReportLevel is Summary or Location'
      - id: stock_status
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock status'
      - id: stock_quantity
        type: s4
        doc: 'Stock quantity'
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

enums:
  msg_type:
    100:
      id: 'sequence_reset_message'
      doc: 'Sent on each multicast channel at start of day, and intraday in case of a disaster recovery. The client must ignore the sequence number of the Sequence Reset message itself and set the next expected sequence number to NewSeqNo, clear all cached data for all instruments and subscribe to the refresh channels to receive the current state of the market.'
    426:
      id: 'warehouse_stock_movement_message'
      doc: 'Provides stock movement data from LME approved warehouses by product, grade, stock status and location in tonnes. Stock figures for one location, or port, are the aggregate of all the stocks in all the warehouses in that one location.'

