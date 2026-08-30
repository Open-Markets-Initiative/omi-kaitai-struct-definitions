# ---------------------------------------------------------------------
# Kaitai struct definition for: OtcMarkets LinkAts Multicast Link v4.5
#
# Protocol:
#   Organization: OTC Markets Group
#   Protocol: OTC Markets Multicast
#   Encoding: Otc Link
#   Version: 4.5
#   Date: 7/28/2022
#   Specification: OTC Markets Multicast Data Feeds -v4.5.pdf
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
  id: otcmarkets_linkats_multicast_link_v4_5
  title: OtcMarkets LinkAts Multicast Link v4.5
  license: GPL-3.0
  endian: be

doc: 'OTC Markets Group OTC Link ATS OTC Markets Multicast Link v4.5'
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
        doc: 'Reserved Extended Quote Flag Bits'
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
            'message_type::quote_message': quote_message
            'message_type::quote_update_message': quote_update_message
            'message_type::inside_message': inside_message
            'message_type::inside_update_message': inside_update_message
            'message_type::reference_price_message': reference_price_message
            'message_type::reference_price_update_message': reference_price_update_message
            'message_type::extended_security_message': extended_security_message
            'message_type::extended_security_no_cusip_message': extended_security_no_cusip_message
            'message_type::trade_message': trade_message
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
  quote_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: quote_id
        type: u4
        doc: 'Unique Quote ID'
      - id: quote_action
        type: u1
        doc: 'Quote action indicator'
      - id: quote_flags
        type: quote_flags
        doc: 'Quote Information'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Participant ID owning the quote (always 4 characters)'
      - id: ask_price
        type: u8
        doc: 'Ask price, 6 decimal places assumed'
      - id: ask_size
        type: u4
        doc: 'Number of shares on the ask'
      - id: ask_qap
        type: s1
        doc: 'Specifies the access fee or rebate for the offer. Positive values (1 to 30) indicate a rebate, negative values (-1 to -30) indicate an access fee, and 0 indicates no rebate or access fee'
      - id: ask_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: bid_price
        type: u8
        doc: 'Bid price, 6 decimal places assumed'
      - id: bid_size
        type: u4
        doc: 'Number of shares on the bid'
      - id: bid_qap
        type: s1
        doc: 'Specifies the access fee or rebate for the bid. Positive values (1 to 30) indicate a rebate, negative values (-1 to -30) indicate an access fee, and 0 indicates no rebate or access fee'
      - id: bid_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: quote_reference_id
        type: u2
        doc: 'Numeric value (0 to 64,999) assigned by the quote owner for correlation purposes (FIX Tag 9670)'
      - id: extended_quote_flags
        type: extended_quote_flags
        doc: 'Extended Quote Information'
  quote_flags:
    seq:
      - id: update_side
        type: b1
        doc: 'Ask or Bid'
      - id: state
        type: b1
        doc: 'Open or Closed'
      - id: ask_unsolicited
        type: b1
        doc: 'Ask Unsolicited'
      - id: ask_priced
        type: b1
        doc: 'Ask Priced'
      - id: ask_bid_wanted
        type: b1
        doc: 'Ask Bid Wanted'
      - id: bid_unsolicited
        type: b1
        doc: 'Bid Unsolicited'
      - id: bid_priced
        type: b1
        doc: 'Bid Priced'
      - id: bid_ask_wanted
        type: b1
        doc: 'Bid Ask Wanted'
  extended_quote_flags:
    seq:
      - id: quote_saturated
        type: b1
        doc: 'Determines whether the quote should be considered for the inside price'
      - id: bid_auto_ex
        type: b1
        doc: 'If the AutoEx flag is set for the bid side, responses to OTC Link trade messages are immediate'
      - id: offer_auto_ex
        type: b1
        doc: 'If the AutoEx flag is set for the offer side, responses to OTC Link trade messages are immediate'
      - id: nms_conditional_quote
        type: b1
        doc: 'The displayed quote size is a round lot at least two times greater than the minimum round lot size and cannot be partially filled'
      - id: reserved_4
        type: b4
        doc: 'Reserved Extended Quote Flag Bits'
  quote_update_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: quote_id
        type: u4
        doc: 'Unique Quote ID'
      - id: quote_flags
        type: quote_flags
        doc: 'Quote Information'
      - id: price
        type: u8
        doc: 'Price with 6 decimal places assumed'
      - id: size
        type: u4
        doc: 'Number of shares'
      - id: qap
        type: s1
        doc: 'Specifies the access fee or rebate for the bid/offer. Positive values (1 to 30) indicate a rebate, negative values (-1 to -30) indicate an access fee, and 0 indicates no rebate or access fee'
      - id: quote_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: quote_reference_id
        type: u2
        doc: 'Numeric value (0 to 64,999) assigned by the quote owner for correlation purposes (FIX Tag 9670)'
      - id: extended_quote_flags
        type: extended_quote_flags
        doc: 'Extended Quote Information'
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
        doc: 'Quote Information'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: ask_price
        type: u8
        doc: 'Ask price, 6 decimal places assumed'
      - id: ask_size
        type: u4
        doc: 'Number of shares on the ask'
      - id: ask_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: bid_price
        type: u8
        doc: 'Bid price, 6 decimal places assumed'
      - id: bid_size
        type: u4
        doc: 'Number of shares on the bid'
      - id: bid_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: ask_num_priced_mp
        type: u1
        doc: 'Number of market participants at the ask inside price level'
      - id: bid_num_priced_mp
        type: u1
        doc: 'Number of market participants at the bid inside price level'
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
        doc: 'Quote Information'
      - id: price
        type: u8
        doc: 'Price with 6 decimal places assumed'
      - id: size
        type: u4
        doc: 'Number of shares'
      - id: inside_time_milli
        type: u8
        doc: 'Timestamp in milliseconds since UTC epoch'
      - id: num_priced_mp
        type: u1
        doc: 'Number of market participants at the inside price level'
  reference_price_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: reference_price_id
        type: u4
        doc: 'Unique reference price identifier'
      - id: reference_price_action
        type: u1
        enum: reference_price_action
        doc: 'Action applied to the reference price. See ReferencePriceAction definition'
      - id: quote_flags
        type: quote_flags
        doc: 'Quote Information'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: ask_price
        type: u8
        doc: 'Ask price, 6 decimal places assumed'
      - id: ask_size
        type: u4
        doc: 'Number of shares on the ask'
      - id: ask_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: bid_price
        type: u8
        doc: 'Bid price, 6 decimal places assumed'
      - id: bid_size
        type: u4
        doc: 'Number of shares on the bid'
      - id: bid_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
  reference_price_update_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: reference_price_id
        type: u4
        doc: 'Unique reference price identifier'
      - id: quote_flags
        type: quote_flags
        doc: 'Quote Information'
      - id: price
        type: u8
        doc: 'Price with 6 decimal places assumed'
      - id: size
        type: u4
        doc: 'Number of shares'
      - id: time_milli
        type: u8
        doc: 'Timestamp in milliseconds since UTC epoch'
  extended_security_message:
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
      - id: otc_issuer_id
        type: u4
        doc: 'Unique OTC issuer identifier'
      - id: security_desc
        type: str
        size: 25
        encoding: ASCII
        doc: 'Security description'
      - id: short_name
        type: str
        size: 25
        encoding: ASCII
        doc: 'Short name of the security'
      - id: asset_class
        type: u1
        enum: asset_class
        doc: 'Asset class of the security'
      - id: security_type
        type: str
        size: 5
        encoding: ASCII
        doc: 'Indicates the type of security'
      - id: primary_market
        type: str
        size: 3
        encoding: ASCII
        doc: 'Primary market or exchange where the security trades'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: extended_security_flags
        type: extended_security_flags
        doc: 'notes security level attributes'
      - id: tier
        type: u1
        enum: tier
        doc: 'Market tier assigned by OTC Markets Group'
      - id: reporting_status
        type: u1
        enum: reporting_status
        doc: 'Reporting status of the issuer'
      - id: disclosure_status
        type: u1
        enum: disclosure_status
        doc: 'Current disclosure status of the issuer'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Current security status'
      - id: par_value
        type: u8
        doc: 'Par value with 6 decimal places assumed. Zero indicates not available'
      - id: coupon
        type: u8
        doc: 'Coupon rate with 6 decimal places assumed. Fixed income only'
      - id: maturity_date_milli
        type: u8
        doc: 'Maturity date in milliseconds since UTC epoch. Fixed income only'
      - id: callable_date_milli
        type: u8
        doc: 'Callable date in milliseconds since UTC epoch. Fixed income only'
      - id: adr_ratio
        type: u8
        doc: 'ADR ratio with 6 decimal places assumed. Equity ADR/GDR only'
      - id: adr_level
        type: str
        size: 15
        encoding: ASCII
        doc: 'ADR level. Equity ADR/GDR only'
      - id: security_detail
        type: security_detail
        doc: 'SecurityDetail'
      - id: issuer
        type: issuer
        doc: 'Issuer'
      - id: cusip
        type: str
        size: 9
        encoding: ASCII
        doc: 'CUSIP identifier'
  extended_security_flags:
    seq:
      - id: piggyback
        type: b1
        doc: 'Rule 15c2-11 Piggyback exemption'
      - id: caveat_emptor_warning
        type: b1
        doc: 'Indicates whether a Caveat Emptor warning has been applied'
      - id: qualified_institutional_buyers_only
        type: b1
        doc: 'Indicates if the security is restricted to Qualified Institutional Buyers'
      - id: unsolicited_only
        type: b1
        doc: 'Indicates if the security may only be quoted unsolicited'
      - id: sponsored_status
        type: b1
        doc: 'Security is sponsored'
      - id: otc_link_ecn_eligible
        type: b1
        doc: 'OTC Link ECN eligible'
      - id: otc_link_messaging_disabled
        type: b1
        doc: 'OTC Link Messaging Disabled'
      - id: saturation_eligible
        type: b1
        doc: 'Indicates if a security is eligible to have their quotes saturated'
      - id: investment_grade
        type: b1
        doc: 'Indicates if the security is investment grade'
      - id: trading_flat
        type: b1
        doc: 'Indicates if the security is trading flat (no coupon)'
      - id: callable
        type: b1
        doc: 'Indicates if the security is callable'
      - id: reserved_5
        type: b5
        doc: 'Reserved'
  security_detail:
    seq:
      - id: len_security_detail_name
        type: u1
        doc: 'Size of the SecurityDetail field. If zero, SecurityDetail is not present'
      - id: security_detail_name
        type: str
        size: len_security_detail_name
        encoding: ASCII
        doc: 'Security detail name'
  issuer:
    seq:
      - id: len_issuer_name
        type: u1
        doc: 'Size of the IssuerName field. If zero, IssuerName is not present'
      - id: issuer_name
        type: str
        size: len_issuer_name
        encoding: ASCII
        doc: 'Issuer name'
  extended_security_no_cusip_message:
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
      - id: otc_issuer_id
        type: u4
        doc: 'Unique OTC issuer identifier'
      - id: security_desc
        type: str
        size: 25
        encoding: ASCII
        doc: 'Security description'
      - id: short_name
        type: str
        size: 25
        encoding: ASCII
        doc: 'Short name of the security'
      - id: asset_class
        type: u1
        enum: asset_class
        doc: 'Asset class of the security'
      - id: security_type
        type: str
        size: 5
        encoding: ASCII
        doc: 'Indicates the type of security'
      - id: primary_market
        type: str
        size: 3
        encoding: ASCII
        doc: 'Primary market or exchange where the security trades'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: extended_security_flags
        type: extended_security_flags
        doc: 'notes security level attributes'
      - id: tier
        type: u1
        enum: tier
        doc: 'Market tier assigned by OTC Markets Group'
      - id: reporting_status
        type: u1
        enum: reporting_status
        doc: 'Reporting status of the issuer'
      - id: disclosure_status
        type: u1
        enum: disclosure_status
        doc: 'Current disclosure status of the issuer'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Current security status'
      - id: par_value
        type: u8
        doc: 'Par value with 6 decimal places assumed. Zero indicates not available'
      - id: coupon
        type: u8
        doc: 'Coupon rate with 6 decimal places assumed. Fixed income only'
      - id: maturity_date_milli
        type: u8
        doc: 'Maturity date in milliseconds since UTC epoch. Fixed income only'
      - id: callable_date_milli
        type: u8
        doc: 'Callable date in milliseconds since UTC epoch. Fixed income only'
      - id: adr_ratio
        type: u8
        doc: 'ADR ratio with 6 decimal places assumed. Equity ADR/GDR only'
      - id: adr_level
        type: str
        size: 15
        encoding: ASCII
        doc: 'ADR level. Equity ADR/GDR only'
      - id: security_detail
        type: security_detail
        doc: 'SecurityDetail'
      - id: issuer
        type: issuer
        doc: 'Issuer'
  trade_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: trade_id
        type: u4
        doc: 'Unique Trade ID'
      - id: trade_action
        type: u1
        enum: trade_action
        doc: 'Trade action indicator'
      - id: trade_flags
        type: u1
        doc: 'Trade flags. See TradeFlag definition'
      - id: security_id
        type: u4
        doc: 'Unique security ID issued by OTC Markets'
      - id: trade_status
        type: trade_status
        doc: 'Trade Status Information'
      - id: deprecated
        type: str
        size: 8
        encoding: ASCII
        doc: 'Deprecated field. Spaces will be sent in message'
      - id: trade_price
        type: u8
        doc: 'Trade price. Six decimal places assumed'
      - id: trade_size
        type: u4
        doc: 'Number of shares'
      - id: trade_time_milli
        type: u8
        doc: 'Milliseconds from UTC epoch'
  trade_status:
    seq:
      - id: irregular
        type: b1
        doc: 'Indicates irregular trade'
      - id: reserved_7
        type: b7
        doc: 'Reserved Trade Status Bits'
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
    1:
      id: 'quote_message'
      doc: 'This message is sent on the Quote Book channel and the Quote Book with Global OTC data channel.'
    2:
      id: 'quote_update_message'
      doc: 'Quote update information for the Quote Book channel and the Quote Book with Global OTC data channel.'
    3:
      id: 'inside_message'
      doc: 'This message is sent on the Quote Inside Channel and the Quote Inside with Global OTC data channel.'
    4:
      id: 'inside_update_message'
      doc: 'Quote update information for the Quote Inside channel and the Quote Inside with Global OTC data channel.'
    7:
      id: 'reference_price_message'
      doc: 'This message is sent on the Reference Prices Channel. Size fields will always be set to 1.'
    8:
      id: 'reference_price_update_message'
      doc: 'Quote update information for the Reference Price channel.'
    15:
      id: 'extended_security_message'
      doc: 'Extended security attribute information for OTC Markets securities.'
    16:
      id: 'extended_security_no_cusip_message'
      doc: 'This message is sent out at 6 AM on all channels. The message can also be sent mid-day if a technical outage caused a temporary closure of the market.'
    17:
      id: 'trade_message'
      doc: 'A Trade Message is created for every trade that occurs on OTC Markets OTC Link ATS.'
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
  reference_price_action:
    2:
      id: 'add'
      doc: 'Add Reference Price'
    3:
      id: 'delete_field'
      doc: 'Delete Reference Price'
    4:
      id: 'spin'
      doc: 'Spin Refresh'
  disclosure_status:
    0:
      id: 'no_disclosure'
      doc: 'No Disclosure Status'
    2:
      id: 'current_information'
      doc: 'Current Information'
    3:
      id: 'limited_information'
      doc: 'Limited Information'
    4:
      id: 'no_information'
      doc: 'No Information'
  trade_action:
    2:
      id: 'add'
      doc: 'Add'

