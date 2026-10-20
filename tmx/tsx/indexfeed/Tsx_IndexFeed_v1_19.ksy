# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Tsx IndexFeed Qrtmd v1.19
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Index Feed
#   Encoding: Quantum Real Time Market Data
#   Version: 1.19
#   Date: 10/12/2021
#   Specification: QRTMD TX1 (1.19).pdf
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
  id: tmx_tsx_indexfeed_qrtmd_v1_19
  title: Tmx Tsx IndexFeed Qrtmd v1.19
  license: GPL-3.0
  endian: be

doc: 'TMX Group Toronto Stock Exchange Index Feed Qrtmd v1.19'
doc-ref: https://www.tmxwebstore.com/

seq:
  - id: qrtmd_stx
    type: u1
    doc: 'Start of Qrtmd message'
  - id: message_header
    type: message_header_struct
    doc: 'Twenty two byte ascii header carried on every Qrtmd message'
  - id: message_body
    type:
      switch-on: message_header.message_type
      cases:
        '"K"': s_and_p_tsx_official_index_level_message
  - id: qrtmd_etx
    type: u1
    doc: 'End of Qrtmd message'

types:
  message_header_struct:
    seq:
      - id: message_length
        type: str
        size: 4
        encoding: ASCII
        doc: 'Total length of header and message business content, excluding Stx and Etx'
      - id: sequence_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'Assigned at service broadcast from 000000001 to 999999999, blank on a heartbeat'
      - id: service_identifier
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Service code identifying the market data service carried on the feed'
      - id: retransmission_identifier
        type: u1
        enum: retransmission_identifier
        doc: 'Marks a normal transmission, and is always blank on a heartbeat'
      - id: continuation_identifier
        type: u1
        enum: continuation_identifier
        doc: 'Provides for fragmentation of a message exceeding the maximum transmission unit'
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique code assigned to each message type, specific to each market service'
      - id: exchange_identifier
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code assigned to the originating exchange'
  s_and_p_tsx_official_index_level_message:
    seq:
      - id: time
        type: hhmmss_ascii_time
        doc: 'Time of the index level calculation'
      - id: index_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the index'
      - id: last_level
        type: str
        size: 8
        encoding: ASCII
        doc: 'The level of the index as of the time of the calculation. Implied decimal with scale 1e-2'
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net change from previous index level close. Implied decimal with scale 1e-2'
      - id: volume
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total number of shares traded for the index'
      - id: value_field
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total dollar of shares traded for the index'
      - id: open_level
        type: str
        size: 8
        encoding: ASCII
        doc: 'Level of the index at the first calculation of the day. Implied decimal with scale 1e-2'
      - id: settlement_value
        type: str
        size: 8
        encoding: ASCII
        doc: 'Settlement open. Implied decimal with scale 1e-2'
      - id: special_opening_quote
        type: str
        size: 8
        encoding: ASCII
        doc: 'Adjusted index open value. Implied decimal with scale 1e-2'
      - id: percent_trading
        type: str
        size: 7
        encoding: ASCII
        doc: 'Percentage of the index constituents that are open. Implied decimal with scale 1e-4'
      - id: high_level
        type: str
        size: 8
        encoding: ASCII
        doc: 'Highest level of the index for the day. Implied decimal with scale 1e-2'
      - id: low_level
        type: str
        size: 8
        encoding: ASCII
        doc: 'Lowest level of the index for the day. Implied decimal with scale 1e-2'
      - id: pe
        type: str
        size: 7
        encoding: ASCII
        doc: 'Price/Earnings ratio for the index. Implied decimal with scale 1e-2'
      - id: yield_field
        type: str
        size: 5
        encoding: ASCII
        doc: 'Dividend Yield for the index, expressed as a percentage. Implied decimal with scale 1e-2'
      - id: markers
        type: u1
        enum: markers
        doc: 'Marks the message carrying the closing values'
      - id: bid_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Value for the Index based on the latest bid price of the stocks comprising the Index. Implied decimal with scale 1e-2'
      - id: ask_price
        type: str
        size: 7
        encoding: ASCII
        doc: 'Value for the Index based on the latest ask price of the stocks comprising the Index. Implied decimal with scale 1e-2'
  hhmmss_ascii_time:
    seq:
      - id: text
        type: str
        size: 6
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i

enums:
  retransmission_identifier:
    0x30:
      id: 'normal_transmission'
      doc: 'Used for normal transmission, and unchanged on a message sent for a recovery'
  continuation_identifier:
    0x30:
      id: 'stand_alone_message'
      doc: 'All of the message fits in one packet'
  markers:
    0x43:
      id: 'close'
      doc: 'The last index level message of the day for a given index'

