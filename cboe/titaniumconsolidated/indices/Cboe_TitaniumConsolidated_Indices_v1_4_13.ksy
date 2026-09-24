# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe TitaniumConsolidated Indices Cgif v1.4.13
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Global Indices Feed
#   Encoding: Cgif
#   Version: 1.4.13
#   Date: 05/16/2025
#   Specification: Cboe Titanium Cboe Global Indices Feed Specification _ Cboe.pdf
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
  id: cboe_titaniumconsolidated_indices_cgif_v1_4_13
  title: Cboe TitaniumConsolidated Indices Cgif v1.4.13
  license: GPL-3.0
  endian: be

doc: 'Chicago Board Options Exchange Cboe Titanium Consolidated Global Indices Feed Cgif v1.4.13'
doc-ref: https://www.cboe.com/document/tech-spec/document/technical-specifications/cboe-titanium-cboe-global-indices-feed-specification

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Cgif packet header appearing once at the beginning of each packet'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_of_messages
    doc: 'Cgif Message containing message header and payload'

types:
  packet_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Version associated with the contents and format of this header. Currently 1'
      - id: length
        type: u2
        doc: 'Length of the packet including this length field and the version. 2 byte length'
      - id: sending_time
        type: millisecond_timestamp
        doc: 'The time the packet was sent. Millisecond timestamp from midnight January 1, 1970 UTC. Milliseconds since Unix epoch'
      - id: number_of_messages
        type: u1
        doc: 'The number of messages in this packet'
      - id: first_msg_seq_num
        type: u4
        doc: 'The sequence number on the first message in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Cgif Message Header common to all messages. Per spec section "Message Header": Length + Template ID + MessageType + MsgSeqNum, 8 bytes total. Template ID drives payload dispatch; MessageType is per-spec FIX-compliant market data type (may be shared across templates); MsgSeqNum is the per-channel monotonic sequence number'
      - id: payload
        size: message_header.message_length - 8
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::index_value_message': index_value_message
            'template_id::contributor_value_message': contributor_value_message
            'template_id::index_summary_message': index_summary_message
            'template_id::index_value_with_status_message': index_value_with_status_message
            'template_id::index_definition_message': index_definition_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'The length of this message including the 2 bytes for this length field'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'Template identifier used for decoding the message structure'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'FIX-compliant market data message type. May be shared across templates'
      - id: msg_seq_num
        type: u4
        doc: 'Consecutively increasing sequence number on each message'
  index_value_message:
    seq:
      - id: symbol
        type: symbol
        doc: 'Symbol'
      - id: num_md_entries
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'One entry in a repeating MDEntries group. Repeats NoMDEntries times within the containing message'
  symbol:
    seq:
      - id: len_symbol_chars
        type: s1
        doc: 'Byte Length'
      - id: symbol_chars
        type: str
        size: len_symbol_chars
        encoding: ASCII
        doc: 'Symbol Chars'
  md_entries:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Market Data Entry Type. 0 = Bid, 1 = Ask, 3 = Index Value, 5 = Close Value, 6 = Settlement / EDSP Price'
      - id: md_entry_px
        type: md_entry_px
        doc: 'MDEntryPx'
  md_entry_px:
    seq:
      - id: exponent
        type: s1
        doc: 'Exponent'
      - id: mantissa
        type: s4
        doc: 'Mantissa'
  contributor_value_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'Time that data was calculated or produced from client. Applies only to this message within the packet'
      - id: symbol
        type: symbol
        doc: 'Symbol'
      - id: num_md_entries
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'One entry in a repeating MDEntries group. Repeats NoMDEntries times within the containing message'
  index_summary_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'Time that data was calculated or produced from client. Applies only to this message within the packet'
      - id: effective_business_date
        type: effective_business_date
        doc: 'EffectiveBusinessDate'
      - id: summary_type
        type: u1
        enum: summary_type
        doc: 'Type of summary message'
      - id: symbol
        type: symbol
        doc: 'Symbol'
      - id: num_md_entries
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'One entry in a repeating MDEntries group. Repeats NoMDEntries times within the containing message'
  effective_business_date:
    seq:
      - id: byte_length
        type: s1
        doc: 'Byte Length'
      - id: effective_business_date_chars
        type: yyyymmdd_ascii_date
        doc: 'EffectiveBusinessDate Chars'
  index_value_with_status_message:
    seq:
      - id: index_status
        type: u1
        enum: index_status
        doc: 'Status of the index value. N = Normal, I = Indicative'
      - id: symbol
        type: symbol
        doc: 'Symbol'
      - id: num_md_entries
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'One entry in a repeating MDEntries group. Repeats NoMDEntries times within the containing message'
  index_definition_message:
    seq:
      - id: current_record_number
        type: u4
        doc: 'Clients should begin capturing data beginning at 1'
      - id: total_number_of_records
        type: u4
        doc: 'Total number of updates within loop'
      - id: symbol
        type: symbol
        doc: 'Symbol'
      - id: len_description
        type: u1
        doc: 'Length in bytes of the Description that follows'
      - id: description
        type: str
        size: len_description
        encoding: ASCII
        doc: 'Description of the index. Variable length'
      - id: date
        type: date
        doc: 'Date'
      - id: status
        type: u1
        enum: status
        doc: 'Status of index. 1 = Active (loaded and a business day), 2 = Inactive (loaded and not a business day), 3 = Deleted (no longer distributed; removed from the feed after 30 days)'
      - id: agent_classification
        type: str
        size: 2
        encoding: ASCII
        doc: 'Originating source of the index. blank = Not Specified, CO = Cboe, CC = Cboe Custom, MS = Morningstar, TP = Third-party, MC = Morningstar Customer'
      - id: num_channels
        type: u1
        doc: 'Number of Channels in this message'
      - id: channels
        type: channels
        repeat: expr
        repeat-expr: num_channels
        doc: 'One entry in a repeating Channels group. Repeats NoChannels times within the containing message'
  date:
    seq:
      - id: byte_length
        type: s1
        doc: 'Byte Length'
      - id: date_chars
        type: iso_date
        doc: 'Date Chars'
  channels:
    seq:
      - id: len_channel
        type: u1
        doc: 'Length in bytes of the Channel that follows'
      - id: channel
        type: str
        size: len_channel
        encoding: ASCII
        doc: 'Channel name. MAIN = Cboe Global Indices Feed Main, CGI = Strategy/Benchmark/Custom Indices, MSCI = MSCI, INAV = Intraday Net Asset Values, FTSE = FTSE Russell, MSTAR = Morningstar, CCCY = Crypto Currency'
  millisecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i
  iso_date:
    seq:
      - id: text
        type: str
        size: 10
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(5, 7).to_i
      day:
        value: text.substring(8, 10).to_i

enums:
  template_id:
    0x10:
      id: 'heartbeat_message'
      doc: 'Heartbeat / line integrity message transmitted every 5 seconds. Contains only the standard message header (MessageType "0").'
    0x16:
      id: 'index_value_message'
      doc: 'Index Value message containing values associated with a calculated index. May include Index Value, Bid, and Ask MDEntries.'
    0x17:
      id: 'contributor_value_message'
      doc: 'Contributor Value message containing values associated with a given symbol or index, transmitted when received by Cboe.'
    0x18:
      id: 'index_summary_message'
      doc: 'Index Summary message containing values associated with start or end of day. Includes an effective business date for reference.'
    0x19:
      id: 'index_value_with_status_message'
      doc: 'Index Value With Status message contains the values associated with a calculated index along with a status describing whether the value is indicative or not. Valid entry types include close and settlement markers.'
    0x1a:
      id: 'index_definition_message'
      doc: 'Index Definition message published for every index within each cycle. Contains index information including current status, channel name, current trading date, data source, and description. Published on the Cboe Global Indices Definition Feed (CGIDF).'
  message_type:
    0x58:
      id: 'market_data_incremental_refresh'
      doc: 'Shared By Contributor Value Index Summary Index Value And Index Value With Status Messages Body Determined By Template Id'
    0x44:
      id: 'index_definition'
      doc: 'Index Definition Message'
    0x30:
      id: 'heartbeat'
      doc: 'Heartbeat Message'
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'ask'
      doc: 'Ask'
    0x33:
      id: 'index_value'
      doc: 'Index Value'
    0x35:
      id: 'close'
      doc: 'Close Value'
    0x36:
      id: 'settlement'
      doc: 'Settlement Edsp Price'
  summary_type:
    0x31:
      id: 'sod'
      doc: 'Start Of Day'
    0x32:
      id: 'eod'
      doc: 'End Of Day'
  index_status:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x49:
      id: 'indicative'
      doc: 'Indicative'
  status:
    1:
      id: 'active'
      doc: 'Active Loaded And A Business Day'
    2:
      id: 'inactive'
      doc: 'Inactive Loaded And Not A Business Day'
    3:
      id: 'deleted'
      doc: 'Deleted No Longer Distributed Removed From The Feed After 30 Days'

