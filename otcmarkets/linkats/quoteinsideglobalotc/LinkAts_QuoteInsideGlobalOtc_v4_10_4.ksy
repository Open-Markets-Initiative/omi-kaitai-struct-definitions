# ---------------------------------------------------------------------
# Kaitai struct definition for: OtcMarkets LinkAts QuoteInsideGlobalOtc Link v4.10.4
#
# Protocol:
#   Organization: OTC Markets Group
#   Protocol: 
#   Encoding: Otc Link
#   Version: 4.10.4
#   Date: 6/16/2026
#   Specification: OTC Markets Multicast Data Feeds.pdf
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
  id: otcmarkets_linkats_quoteinsideglobalotc_link_v4_10_4
  title: OtcMarkets LinkAts QuoteInsideGlobalOtc Link v4.10.4
  license: GPL-3.0
  endian: be

doc: 'OTC Markets Group OTC Link ATS Link v4.10.4'
doc-ref: https://www.otcmarkets.com/market-data/technical-and-user-documentation

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.messages

types:
  packet_header_struct:
    seq:
      - id: packet_size
        type: u2
        doc: 'Size of packet in bytes'
      - id: seq_num
        type: u4
        doc: 'Channel specific Sequence number of packet'
      - id: packet_flag
        type: packet_flag
        doc: 'Packet Flags'
      - id: messages
        type: u1
        doc: 'Number of messages in packet'
      - id: packet_milli
        type: millisecond_timestamp
        doc: 'Milliseconds since local time midnight (EST/EDT). Milliseconds since Midnight epoch'
  packet_flag:
    seq:
      - id: heartbeat
        type: b1
        doc: 'A Heartbeat is sent if no business level message has been published for more than a second'
      - id: seq_num_reset
        type: b1
        doc: 'indicates that the channel sequence numbers are being reset to 1'
      - id: reserved_4
        type: b4
        doc: 'Reserved 4'
      - id: replay
        type: b1
        doc: 'Packet contains replay messages'
      - id: test
        type: b1
        doc: 'Packet contains test messages'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Otc Udp Message Header'
      - id: payload
        size: message_header.message_size - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::start_of_spin_message': start_of_spin_message
            'message_type::end_of_spin_message': end_of_spin_message
            'message_type::market_open_message': market_open_message
            'message_type::market_close_message': market_close_message
            'message_type::security_message': security_message
            'message_type::inside_message': inside_message
            'message_type::inside_update_message': inside_update_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Size of message in bytes'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  start_of_spin_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: spin_type
        type: u1
        enum: spin_type
        doc: 'Spin type'
      - id: spin_start_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: spin_last_seq_num
        type: u4
        doc: 'Last sequence number applied to this spin'
  end_of_spin_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: spin_type
        type: u1
        enum: spin_type
        doc: 'Spin type'
      - id: spin_msg_ct
        type: u4
        doc: 'Total number of messages in the spin'
      - id: spin_end_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: spin_last_seq_num
        type: u4
        doc: 'Last sequence number applied to this spin'
  market_open_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: market_open
        type: u8
        doc: 'Market open time in milliseconds since UTC epoch'
      - id: market_close
        type: u8
        doc: 'Anticipated market close time in milliseconds since UTC epoch'
  market_close_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: market_close_time_milli
        type: u8
        doc: 'Market close time in milliseconds since UTC epoch midnight'
      - id: market_msg_ct
        type: u4
        doc: 'Total day message count'
  security_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        doc: 'Ticker symbol. Fixed income symbols may not have a symbol. For these securities, the SecurityID or CUSIP (Reference Data Security Message) must be used as an identifier'
      - id: last_update_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: security_action
        type: u1
        enum: security_action
        doc: 'Security action indicator'
      - id: asset_class
        type: u1
        enum: asset_class
        doc: 'Asset class of the security'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: security_flags
        type: security_flags
        doc: 'Notes security level attributes'
      - id: tier
        type: u1
        enum: tier
        doc: 'Market tier assigned by OTC Markets Group'
      - id: reporting_status
        type: u1
        enum: reporting_status
        doc: 'Reporting status of the issuer'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Current security status'
  security_flags:
    seq:
      - id: proprietary_quote_eligible
        type: b1
        doc: 'Security is eligible for proprietary quoting under SEC Rule 15c-211'
      - id: caveat_emptor_warning
        type: b1
        doc: 'Indicates whether a Caveat Emptor warning has been applied'
      - id: qualified_institutional_buyers_only
        type: b1
        doc: 'Indicates if the security is restricted to Qualified Institutional Buyers'
      - id: unsolicited_only
        type: b1
        doc: 'Indicates if the security may only be quoted unsolicited'
      - id: bb_quoted
        type: b1
        doc: 'Indicates if the security is quoted on the OTC Bulletin Board'
      - id: otc_link_ecn_eligible
        type: b1
        doc: 'OTC Link ECN eligible'
      - id: otc_link_messaging_disabled
        type: b1
        doc: 'OTC Link Messaging Disabled'
      - id: saturation_eligible
        type: b1
        doc: 'Indicates if a security is eligible to have their quotes saturated'
  inside_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: inside_id
        type: u4
        doc: 'Unique inside quote identifier'
      - id: inside_action
        type: u1
        enum: inside_action
        doc: 'Inside action indicator (Add, Delete, Spin)'
      - id: quote_flags
        type: quote_flags
        doc: 'Inside Quote Information'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: ask_price
        type: u8
        doc: 'Ask price with 6 decimal places assumed'
      - id: ask_size
        type: u4
        doc: 'Number of shares at the ask'
      - id: ask_time_milli
        type: u8
        doc: 'Ask timestamp in milliseconds since UTC epoch'
      - id: bid_price
        type: u8
        doc: 'Bid price with 6 decimal places assumed'
      - id: bid_size
        type: u4
        doc: 'Number of shares at the bid'
      - id: bid_time_milli
        type: u8
        doc: 'Bid timestamp in milliseconds since UTC epoch'
      - id: ask_num_priced_mp
        type: u1
        doc: 'Number of market participants at the ask inside price level'
      - id: bid_num_priced_mp
        type: u1
        doc: 'Number of market participants at the bid inside price level'
  quote_flags:
    seq:
      - id: update_side
        type: b1
        doc: 'Ask or Bid'
      - id: state
        type: b1
        doc: 'Open or Closed'
      - id: reserved_1
        type: b1
        doc: 'Reserved'
      - id: ask_priced
        type: b1
        doc: 'Ask Priced'
      - id: ask_size_overflow
        type: b1
        doc: 'Ask aggregated size exceeds 2B'
      - id: second_reserved_1
        type: b1
        doc: 'Reserved'
      - id: bid_priced
        type: b1
        doc: 'Bid Priced Actual'
      - id: bid_size_overflow
        type: b1
        doc: 'Bid aggregated size exceeds 2B'
  inside_update_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: inside_id
        type: u4
        doc: 'Unique inside quote identifier'
      - id: quote_flags
        type: quote_flags
        doc: 'Inside Quote Information'
      - id: price
        type: u8
        doc: 'Price with 6 decimal places assumed'
      - id: size
        type: u4
        doc: 'Number of shares at the inside price level'
      - id: inside_time_milli
        type: u8
        doc: 'Timestamp in milliseconds since UTC epoch'
      - id: num_priced_mp
        type: u1
        doc: 'Number of market participants at the inside price level'
  millisecond_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000

enums:
  message_type:
    11:
      id: 'start_of_spin_message'
      doc: 'This message appears on all quote channels and indicates the beginning of a spin message cycle.'
    12:
      id: 'end_of_spin_message'
      doc: 'This message appears on all quote channels and indicates the end of a spin message cycle.'
    13:
      id: 'market_open_message'
      doc: 'This message is sent out at 6 AM on all channels. The message can also be sent mid-day if a technical outage caused a temporary closure of the market.'
    14:
      id: 'market_close_message'
      doc: 'This message is sent out at 5 PM on all channels. The message can also be sent mid-day if a technical outage causes a temporary closure of the market.'
    9:
      id: 'security_message'
      doc: 'The Security Message is included in all quote channels and provides basic security attribute information.'
    3:
      id: 'inside_message'
      doc: 'This message is sent on the Quote Inside Channel and the Quote Inside with Global OTC data channel.'
    4:
      id: 'inside_update_message'
      doc: 'Quote update information for the Quote Inside channel and the Quote Inside with Global OTC data channel.'
  spin_type:
    1:
      id: 'reference'
      doc: 'Reference Spin'
    2:
      id: 'market_data'
      doc: 'Market Data Spin'
    3:
      id: 'opening'
      doc: 'Opening Spin'
  security_action:
    1:
      id: 'update'
      doc: 'Update Existing Security'
    2:
      id: 'add'
      doc: 'Add New Security'
    3:
      id: 'delete_field'
      doc: 'Delete Security'
    4:
      id: 'spin'
      doc: 'Spin Refresh'
  asset_class:
    1:
      id: 'equity'
      doc: 'Equity'
    2:
      id: 'fixed_income'
      doc: 'Fixed Income'
  tier:
    0:
      id: 'no_tier'
      doc: 'No Tier'
    1:
      id: 'otcqxus_premier'
      doc: 'Otcqx Us Premier'
    2:
      id: 'otcqxus'
      doc: 'Otcqx Us'
    5:
      id: 'otcqx_international_premier'
      doc: 'Otcqx International Premier'
    6:
      id: 'otcqx_international'
      doc: 'Otcqx International'
    10:
      id: 'otcqb'
      doc: 'Otcqb'
    11:
      id: 'otcbb_only'
      doc: 'Otcbb Only'
    20:
      id: 'pink_current'
      doc: 'Pink Current'
    21:
      id: 'pink_limited'
      doc: 'Pink Limited'
    22:
      id: 'pink_no_information'
      doc: 'Pink No Information'
    30:
      id: 'grey_market'
      doc: 'Grey Market'
    40:
      id: 'expert_market'
      doc: 'Expert Market'
    50:
      id: 'otc_bonds'
      doc: 'Otc Bonds'
  reporting_status:
    0x41:
      id: 'alternative_reporting'
      doc: 'Alternative Reporting Standard'
    0x42:
      id: 'bank_thrift'
      doc: 'Bank Thrift'
    0x43:
      id: 'sec_reporting_reg_cf'
      doc: 'Sec Reporting Reg Cf'
    0x46:
      id: 'sec_reporting'
      doc: 'Sec Reporting'
    0x47:
      id: 'international_reporting'
      doc: 'International Reporting'
    0x49:
      id: 'insurance_company'
      doc: 'Insurance Company'
    0x4e:
      id: 'no_reporting'
      doc: 'No Reporting'
    0x4f:
      id: 'other_reporting'
      doc: 'Other Reporting Standard'
    0x52:
      id: 'finra_reporting'
      doc: 'Finra Reporting'
    0x56:
      id: 'sec_investment_company'
      doc: 'Sec Reporting Investment Company'
    0x57:
      id: 'sec_reporting_reg_a'
      doc: 'Sec Reporting Reg A'
  security_status:
    0x41:
      id: 'active'
      doc: 'Security Is Active'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x53:
      id: 'suspended'
      doc: 'Security Suspended'
    0x48:
      id: 'halted'
      doc: 'Security Halted'
    0x49:
      id: 'internal_halt'
      doc: 'Internal Halt'
    0x52:
      id: 'revoked'
      doc: 'Security Revoked'
    0x44:
      id: 'deleted'
      doc: 'Security Deleted'
  inside_action:
    2:
      id: 'add'
      doc: 'Add Inside Quote'
    3:
      id: 'delete_field'
      doc: 'Delete Inside Quote'
    4:
      id: 'spin'
      doc: 'Spin Refresh'

