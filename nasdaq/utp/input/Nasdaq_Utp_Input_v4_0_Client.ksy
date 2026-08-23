# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq Utp Input Utp v4.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: 
#   Encoding: Utp
#   Version: 4.0
#   Date: 06/01/2026
#   Specification: UtpBinaryInputSpec.pdf
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
  id: nasdaq_utp_input_utp_v4_0_client
  title: Nasdaq Utp Input Utp v4.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Unlisted Trading Privileges Plan Utp v4.0'
doc-ref: https://www.utpplan.com/technical

seq:
  - id: client_tcp_packet_header
    type: client_tcp_packet_header_struct
    doc: 'Packet header of a packet sent by the client'
  - id: client_tcp_payload
    size: client_tcp_packet_header.packet_length + 2 - 3
    type:
      switch-on: client_tcp_packet_header.client_packet_type
      cases:
        'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
        'client_packet_type::debug_packet': debug_packet
        'client_packet_type::login_request_packet': login_request_packet

types:
  client_tcp_packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the SoupBinTCP packet not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying the SoupBinTCP packet type sent by the client'
  unsequenced_data_packet:
    seq:
      - id: message_header
        type: message_header
        doc: 'UTP Participant Input message header — fixed Version + Message Category prefix common to inbound and return messages'
      - id: category_payload
        size: _root.client_tcp_packet_header.packet_length - 3
        type:
          switch-on: message_header.message_category
          cases:
            '"Q"': inbound_quote_messages_message
            '"T"': inbound_trade_messages_message
            '"A"': inbound_administrative_messages_message
            '"C"': inbound_control_messages_message
            '"a"': return_administrative_messages_message
            '"c"': return_control_messages_message
  message_header:
    seq:
      - id: version
        type: u1
        doc: 'UTP Participant Input protocol version'
      - id: message_category
        type: str
        size: 1
        encoding: ASCII
        doc: 'UTP message category. Uppercase letters (A/C/Q/T) denote inbound messages (Participant → SIP); lowercase letters (a/c) denote return messages (SIP → Participant)'
  inbound_quote_messages_message:
    seq:
      - id: inbound_quote_messages_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Inbound Quote Messages message type'
      - id: inbound_quote_messages_message_payload
        type:
          switch-on: inbound_quote_messages_message_type
          cases:
            '"Q"': protected_exchange_quote_message_shortform_message
            '"L"': protected_exchange_quote_message_longform_message
            '"O"': exchange_odd_lot_quote_message_short_form_message
            '"J"': exchange_odd_lot_quote_message_long_form_message
            '"P"': exchange_combined_quote_message_short_form_message
            '"K"': exchange_combined_quote_message_long_form_message
            '"G"': finra_protected_quote_message_with_bbo_info_message
            '"F"': finra_protected_quote_message_without_bbo_info_message
            '"H"': finra_adf_odd_lot_quotation_message
            '"R"': finra_adf_combined_quote_message_with_bbo
  protected_exchange_quote_message_shortform_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (short form, 5 chars)'
      - id: bid_short_2
        type: u2
        doc: 'Bid Price (short form, implied 2 decimal precision)'
      - id: bid_size_short_2
        type: u2
        doc: 'Bid Size (short form)'
      - id: ask_short_2
        type: u2
        doc: 'Ask Price (short form, implied 2 decimal precision)'
      - id: ask_size_short_2
        type: u2
        doc: 'Ask Size (short form)'
      - id: cond
        type: u1
        enum: cond
        doc: 'Quote Condition code'
      - id: rii
        type: u1
        enum: rii
        doc: 'Retail Interest Indicator code'
  protected_exchange_quote_message_longform_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: bid_long_8
        type: u8
        doc: 'Bid Price (long form, implied 6 decimal precision)'
      - id: bid_size_int_4
        type: u4
        doc: 'Bid Size (long form)'
      - id: ask_long_8
        type: u8
        doc: 'Ask Price (long form, implied 6 decimal precision)'
      - id: ask_size_int_4
        type: u4
        doc: 'Ask Size (long form)'
      - id: cond
        type: u1
        enum: cond
        doc: 'Quote Condition code'
      - id: rii
        type: u1
        enum: rii
        doc: 'Retail Interest Indicator code'
  exchange_odd_lot_quote_message_short_form_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (short form, 5 chars)'
      - id: num_odd_lot_bid_short_form_attachment
        type: u2
        doc: 'Number of Odd Lot Bid Levels Attached'
      - id: num_odd_lot_ask_short_form_attachment
        type: u2
        doc: 'Number of Odd Lot Ask Levels Attached'
      - id: odd_lot_bid_short_form_attachment
        type: odd_lot_bid_short_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_bid_short_form_attachment
        doc: 'Short-form Odd Lot Quote Attachment for the bid side. Repeats olBidLevelCount times'
      - id: odd_lot_ask_short_form_attachment
        type: odd_lot_ask_short_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_ask_short_form_attachment
        doc: 'Short-form Odd Lot Quote Attachment for the ask side. Repeats olAskLevelCount times'
  odd_lot_bid_short_form_attachment:
    seq:
      - id: ol_price_short_2
        type: decimal_u2_2
        doc: 'olPrice. Implied decimal with scale 1e-2'
      - id: ol_size
        type: u2
        doc: 'olSize'
  odd_lot_ask_short_form_attachment:
    seq:
      - id: ol_price_short_2
        type: decimal_u2_2
        doc: 'olPrice. Implied decimal with scale 1e-2'
      - id: ol_size
        type: u2
        doc: 'olSize'
  exchange_odd_lot_quote_message_long_form_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: num_odd_lot_bid_long_form_attachment
        type: u2
        doc: 'Number of Odd Lot Bid Levels Attached'
      - id: num_odd_lot_ask_long_form_attachment
        type: u2
        doc: 'Number of Odd Lot Ask Levels Attached'
      - id: odd_lot_bid_long_form_attachment
        type: odd_lot_bid_long_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_bid_long_form_attachment
        doc: 'Long-form Odd Lot Quote Attachment for the bid side. Repeats olBidLevelCount times'
      - id: odd_lot_ask_long_form_attachment
        type: odd_lot_ask_long_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_ask_long_form_attachment
        doc: 'Long-form Odd Lot Quote Attachment for the ask side. Repeats olAskLevelCount times'
  odd_lot_bid_long_form_attachment:
    seq:
      - id: ol_price_long_8
        type: decimal_u8_6
        doc: 'olPrice. Implied decimal with scale 1e-6'
      - id: ol_size
        type: u2
        doc: 'olSize'
  odd_lot_ask_long_form_attachment:
    seq:
      - id: ol_price_long_8
        type: decimal_u8_6
        doc: 'olPrice. Implied decimal with scale 1e-6'
      - id: ol_size
        type: u2
        doc: 'olSize'
  exchange_combined_quote_message_short_form_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (short form, 5 chars)'
      - id: bid_short_2
        type: u2
        doc: 'Bid Price (short form, implied 2 decimal precision)'
      - id: bid_size_short_2
        type: u2
        doc: 'Bid Size (short form)'
      - id: ask_short_2
        type: u2
        doc: 'Ask Price (short form, implied 2 decimal precision)'
      - id: ask_size_short_2
        type: u2
        doc: 'Ask Size (short form)'
      - id: cond
        type: u1
        enum: cond
        doc: 'Quote Condition code'
      - id: rii
        type: u1
        enum: rii
        doc: 'Retail Interest Indicator code'
      - id: num_odd_lot_bid_short_form_attachment
        type: u2
        doc: 'Number of Odd Lot Bid Levels Attached'
      - id: num_odd_lot_ask_short_form_attachment
        type: u2
        doc: 'Number of Odd Lot Ask Levels Attached'
      - id: odd_lot_bid_short_form_attachment
        type: odd_lot_bid_short_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_bid_short_form_attachment
        doc: 'Short-form Odd Lot Quote Attachment for the bid side. Repeats olBidLevelCount times'
      - id: odd_lot_ask_short_form_attachment
        type: odd_lot_ask_short_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_ask_short_form_attachment
        doc: 'Short-form Odd Lot Quote Attachment for the ask side. Repeats olAskLevelCount times'
  exchange_combined_quote_message_long_form_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: bid_long_8
        type: u8
        doc: 'Bid Price (long form, implied 6 decimal precision)'
      - id: bid_size_int_4
        type: u4
        doc: 'Bid Size (long form)'
      - id: ask_long_8
        type: u8
        doc: 'Ask Price (long form, implied 6 decimal precision)'
      - id: ask_size_int_4
        type: u4
        doc: 'Ask Size (long form)'
      - id: cond
        type: u1
        enum: cond
        doc: 'Quote Condition code'
      - id: rii
        type: u1
        enum: rii
        doc: 'Retail Interest Indicator code'
      - id: num_odd_lot_bid_long_form_attachment
        type: u2
        doc: 'Number of Odd Lot Bid Levels Attached'
      - id: num_odd_lot_ask_long_form_attachment
        type: u2
        doc: 'Number of Odd Lot Ask Levels Attached'
      - id: odd_lot_bid_long_form_attachment
        type: odd_lot_bid_long_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_bid_long_form_attachment
        doc: 'Long-form Odd Lot Quote Attachment for the bid side. Repeats olBidLevelCount times'
      - id: odd_lot_ask_long_form_attachment
        type: odd_lot_ask_long_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_ask_long_form_attachment
        doc: 'Long-form Odd Lot Quote Attachment for the ask side. Repeats olAskLevelCount times'
  finra_protected_quote_message_with_bbo_info_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: bid_long_8
        type: u8
        doc: 'Bid Price (long form, implied 6 decimal precision)'
      - id: bid_size_int_4
        type: u4
        doc: 'Bid Size (long form)'
      - id: ask_long_8
        type: u8
        doc: 'Ask Price (long form, implied 6 decimal precision)'
      - id: ask_size_int_4
        type: u4
        doc: 'Ask Size (long form)'
      - id: cond
        type: u1
        enum: cond
        doc: 'Quote Condition code'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FINRA Market Participant identifier'
      - id: bbo_bid
        type: u8
        doc: 'Best Bid Price'
      - id: bbo_bid_size
        type: u4
        doc: 'Best Bid Size'
      - id: bbo_bid_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Best Bid Market Participant'
      - id: bbo_ask
        type: u8
        doc: 'Best Ask Price'
      - id: bbo_ask_size
        type: u4
        doc: 'Best Ask Size'
      - id: bbo_ask_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Best Ask Market Participant'
      - id: bbo_cond
        type: u1
        enum: bbo_cond
        doc: 'BBO Quote Condition'
  finra_protected_quote_message_without_bbo_info_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: bid_long_8
        type: u8
        doc: 'Bid Price (long form, implied 6 decimal precision)'
      - id: bid_size_int_4
        type: u4
        doc: 'Bid Size (long form)'
      - id: ask_long_8
        type: u8
        doc: 'Ask Price (long form, implied 6 decimal precision)'
      - id: ask_size_int_4
        type: u4
        doc: 'Ask Size (long form)'
      - id: cond
        type: u1
        enum: cond
        doc: 'Quote Condition code'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FINRA Market Participant identifier'
      - id: bbo_indicator
        type: u1
        enum: bbo_indicator
        doc: 'FINRA BBO Indicator'
  finra_adf_odd_lot_quotation_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: num_odd_lot_bid_adf_form_attachment
        type: u2
        doc: 'Number of Odd Lot Bid Levels Attached'
      - id: num_odd_lot_ask_adf_form_attachment
        type: u2
        doc: 'Number of Odd Lot Ask Levels Attached'
      - id: odd_lot_bid_adf_form_attachment
        type: odd_lot_bid_adf_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_bid_adf_form_attachment
        doc: 'ADF-form Odd Lot Quote Attachment for the bid side, including FINRA mpid attribution. Repeats olBidLevelCount times'
      - id: odd_lot_ask_adf_form_attachment
        type: odd_lot_ask_adf_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_ask_adf_form_attachment
        doc: 'ADF-form Odd Lot Quote Attachment for the ask side, including FINRA mpid attribution. Repeats olAskLevelCount times'
  odd_lot_bid_adf_form_attachment:
    seq:
      - id: ol_price_long_8
        type: decimal_u8_6
        doc: 'olPrice. Implied decimal with scale 1e-6'
      - id: ol_size
        type: u2
        doc: 'olSize'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FINRA Market Participant identifier'
  odd_lot_ask_adf_form_attachment:
    seq:
      - id: ol_price_long_8
        type: decimal_u8_6
        doc: 'olPrice. Implied decimal with scale 1e-6'
      - id: ol_size
        type: u2
        doc: 'olSize'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FINRA Market Participant identifier'
  finra_adf_combined_quote_message_with_bbo:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: bid_long_8
        type: u8
        doc: 'Bid Price (long form, implied 6 decimal precision)'
      - id: bid_size_int_4
        type: u4
        doc: 'Bid Size (long form)'
      - id: ask_long_8
        type: u8
        doc: 'Ask Price (long form, implied 6 decimal precision)'
      - id: ask_size_int_4
        type: u4
        doc: 'Ask Size (long form)'
      - id: cond
        type: u1
        enum: cond
        doc: 'Quote Condition code'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FINRA Market Participant identifier'
      - id: rii
        type: u1
        enum: rii
        doc: 'Retail Interest Indicator code'
      - id: bbo_bid_price
        type: decimal_u8_6
        doc: 'ADF Best Protected Bid Price. Implied decimal with scale 1e-6'
      - id: bbo_bid_size
        type: u4
        doc: 'Best Bid Size'
      - id: bbo_bid_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Best Bid Market Participant'
      - id: bbo_ask_price
        type: decimal_u8_6
        doc: 'ADF Best Protected Ask Price. Implied decimal with scale 1e-6'
      - id: bbo_ask_size
        type: u4
        doc: 'Best Ask Size'
      - id: bbo_ask_mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Best Ask Market Participant'
      - id: bbo_cond
        type: u1
        enum: bbo_cond
        doc: 'BBO Quote Condition'
      - id: num_odd_lot_bid_adf_form_attachment
        type: u2
        doc: 'Number of Odd Lot Bid Levels Attached'
      - id: num_odd_lot_ask_adf_form_attachment
        type: u2
        doc: 'Number of Odd Lot Ask Levels Attached'
      - id: odd_lot_bid_adf_form_attachment
        type: odd_lot_bid_adf_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_bid_adf_form_attachment
        doc: 'ADF-form Odd Lot Quote Attachment for the bid side, including FINRA mpid attribution. Repeats olBidLevelCount times'
      - id: odd_lot_ask_adf_form_attachment
        type: odd_lot_ask_adf_form_attachment
        repeat: expr
        repeat-expr: num_odd_lot_ask_adf_form_attachment
        doc: 'ADF-form Odd Lot Quote Attachment for the ask side, including FINRA mpid attribution. Repeats olAskLevelCount times'
  inbound_trade_messages_message:
    seq:
      - id: inbound_trade_messages_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Inbound Trade Messages message type'
      - id: inbound_trade_messages_message_payload
        type:
          switch-on: inbound_trade_messages_message_type
          cases:
            '"E"': regular_trade_report_message
            '"I"': trade_cancel_error_message
            '"J"': trade_correction_message
            '"H"': as_of_trade_report_message
            '"K"': fractional_regular_trade_report_message
            '"O"': fractional_trade_cancel_error_message
            '"P"': fractional_trade_correction_message
            '"Q"': fractional_as_of_trade_report_message
  regular_trade_report_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: trade_id
        type: u4
        doc: 'Trade Identifier — per-symbol sequence starting at 1'
      - id: tt_exempt
        type: u1
        enum: tt_exempt
        doc: 'Trade Through Exempt Flag'
      - id: trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition (4-byte positional)'
      - id: ssday
        type: u2
        doc: 'Seller Sales Day'
      - id: side
        type: u1
        enum: side
        doc: 'Side of execution'
      - id: price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
      - id: volume_int_4
        type: u4
        doc: 'Trade Volume'
  trade_cancel_error_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: cancel_type
        type: u1
        enum: cancel_type
        doc: 'Trade Cancellation Type (C=Cancel, E=Error)'
      - id: orig_trade_id
        type: u4
        doc: 'Original Trade Id of trade being acted on'
      - id: orig_tt_exempt
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: orig_trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: orig_ssday
        type: u2
        doc: 'Original Seller Sales Day'
      - id: orig_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Side of execution'
      - id: orig_price
        type: decimal_u8_6
        doc: 'Original Trade Price. Implied decimal with scale 1e-6'
      - id: orig_volume_int_4
        type: u4
        doc: 'Original Trade Volume'
  trade_correction_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: trade_id
        type: u4
        doc: 'Trade Identifier — per-symbol sequence starting at 1'
      - id: orig_trade_id
        type: u4
        doc: 'Original Trade Id of trade being acted on'
      - id: orig_tt_exempt
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: orig_trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: orig_ssday
        type: u2
        doc: 'Original Seller Sales Day'
      - id: side
        type: u1
        enum: side
        doc: 'Side of execution'
      - id: orig_price
        type: decimal_u8_6
        doc: 'Original Trade Price. Implied decimal with scale 1e-6'
      - id: orig_volume_int_4
        type: u4
        doc: 'Original Trade Volume'
      - id: new_tt_exempt
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trade Through Exempt Flag (new)'
      - id: new_trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition (new)'
      - id: new_ssday
        type: u2
        doc: 'Seller Sales Day (new)'
      - id: new_price
        type: decimal_u8_6
        doc: 'Trade Price (new). Implied decimal with scale 1e-6'
      - id: new_volume_int_4
        type: u4
        doc: 'Trade volume (new)'
  as_of_trade_report_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: trade_id
        type: u4
        doc: 'Trade Identifier — per-symbol sequence starting at 1'
      - id: tt_exempt
        type: u1
        enum: tt_exempt
        doc: 'Trade Through Exempt Flag'
      - id: trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition (4-byte positional)'
      - id: ssday
        type: u2
        doc: 'Seller Sales Day'
      - id: side
        type: u1
        enum: side
        doc: 'Side of execution'
      - id: price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
      - id: volume_int_4
        type: u4
        doc: 'Trade Volume'
      - id: trade_time
        type: nanosecond_timestamp
        doc: 'Time of trade (may be prior day, nanoseconds since Epoch). Nanoseconds since Unix epoch'
      - id: reversal
        type: u1
        enum: reversal
        doc: 'Reversal Indicator (Y/N)'
  fractional_regular_trade_report_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: trade_id
        type: u4
        doc: 'Trade Identifier — per-symbol sequence starting at 1'
      - id: tt_exempt
        type: u1
        enum: tt_exempt
        doc: 'Trade Through Exempt Flag'
      - id: trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition (4-byte positional)'
      - id: ssday
        type: u2
        doc: 'Seller Sales Day'
      - id: side
        type: u1
        enum: side
        doc: 'Side of execution'
      - id: price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
      - id: volume_long_8
        type: decimal_u8_6
        doc: 'Trade Volume (implied 6 decimals). Implied decimal with scale 1e-6'
  fractional_trade_cancel_error_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: cancel_type
        type: u1
        enum: cancel_type
        doc: 'Trade Cancellation Type (C=Cancel, E=Error)'
      - id: orig_trade_id
        type: u4
        doc: 'Original Trade Id of trade being acted on'
      - id: orig_tt_exempt
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: orig_trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: orig_ssday
        type: u2
        doc: 'Original Seller Sales Day'
      - id: orig_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Side of execution'
      - id: orig_price
        type: decimal_u8_6
        doc: 'Original Trade Price. Implied decimal with scale 1e-6'
      - id: orig_volume_long_8
        type: decimal_u8_6
        doc: 'Original Trade Volume (implied 6 decimals). Implied decimal with scale 1e-6'
  fractional_trade_correction_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: timestamp_2
        type: nanosecond_timestamp
        doc: 'FINRA-provided timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: trade_id
        type: u4
        doc: 'Trade Identifier — per-symbol sequence starting at 1'
      - id: orig_trade_id
        type: u4
        doc: 'Original Trade Id of trade being acted on'
      - id: orig_tt_exempt
        type: str
        size: 1
        encoding: ASCII
        doc: 'Original Trade Through Exempt Flag'
      - id: orig_trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Sale Condition'
      - id: orig_ssday
        type: u2
        doc: 'Original Seller Sales Day'
      - id: side
        type: u1
        enum: side
        doc: 'Side of execution'
      - id: orig_price
        type: decimal_u8_6
        doc: 'Original Trade Price. Implied decimal with scale 1e-6'
      - id: orig_volume_long_8
        type: decimal_u8_6
        doc: 'Original Trade Volume (implied 6 decimals). Implied decimal with scale 1e-6'
      - id: new_tt_exempt
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trade Through Exempt Flag (new)'
      - id: new_trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition (new)'
      - id: new_ssday
        type: u2
        doc: 'Seller Sales Day (new)'
      - id: new_price
        type: decimal_u8_6
        doc: 'Trade Price (new). Implied decimal with scale 1e-6'
      - id: new_volume_long_8
        type: decimal_u8_6
        doc: 'Corrected Trade volume (implied 6 decimals). Implied decimal with scale 1e-6'
  fractional_as_of_trade_report_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: trade_id
        type: u4
        doc: 'Trade Identifier — per-symbol sequence starting at 1'
      - id: tt_exempt
        type: u1
        enum: tt_exempt
        doc: 'Trade Through Exempt Flag'
      - id: trcond
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Condition (4-byte positional)'
      - id: ssday
        type: u2
        doc: 'Seller Sales Day'
      - id: side
        type: u1
        enum: side
        doc: 'Side of execution'
      - id: price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
      - id: volume_long_8
        type: decimal_u8_6
        doc: 'Trade Volume (implied 6 decimals). Implied decimal with scale 1e-6'
      - id: trade_time
        type: nanosecond_timestamp
        doc: 'Time of trade (may be prior day, nanoseconds since Epoch). Nanoseconds since Unix epoch'
      - id: reversal
        type: u1
        enum: reversal
        doc: 'Reversal Indicator (Y/N)'
  inbound_administrative_messages_message:
    seq:
      - id: inbound_administrative_messages_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Inbound Administrative Messages message type'
      - id: inbound_administrative_messages_message_payload
        type:
          switch-on: inbound_administrative_messages_message_type
          cases:
            '"A"': general_administrative_message
            '"O"': trading_action_message
            '"J"': market_center_trading_action_message
            '"U"': market_center_mass_trading_action_message
            '"V"': reg_sho_short_sale_price_test_restricted_indicator_message
            '"M"': opening_reference_midpoint_price_message
            '"N"': t_1_adjusted_closing_price_message
            '"X"': market_open_message
            '"Y"': market_closed_message
            '"E"': auction_collar_message
  general_administrative_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: text_len
        type: u2
        doc: 'Text Length'
      - id: text
        type: str
        size-eos: true
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text body (length contained in textLen, max 300)'
  trading_action_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: action
        type: u1
        enum: action
        doc: 'Trading Action Code (H/Q/T/P)'
      - id: action_sequence
        type: u4
        doc: 'Trading Action Sequence Number — per-symbol sequence'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Time Action occurred (may be prior day). Nanoseconds since Unix epoch'
      - id: reason
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for the Trading Action'
  market_center_trading_action_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: action
        type: u1
        enum: action
        doc: 'Trading Action Code (H/Q/T/P)'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Time Action occurred (may be prior day). Nanoseconds since Unix epoch'
  market_center_mass_trading_action_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: first_security
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'First Security symbol in range'
      - id: last_security
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Last Security symbol in range'
      - id: action
        type: u1
        enum: action
        doc: 'Trading Action Code (H/Q/T/P)'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Time Action occurred (may be prior day). Nanoseconds since Unix epoch'
  reg_sho_short_sale_price_test_restricted_indicator_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: action
        type: u1
        enum: action
        doc: 'Trading Action Code (H/Q/T/P)'
  opening_reference_midpoint_price_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
  t_1_adjusted_closing_price_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: price
        type: decimal_u8_6
        doc: 'Trade Price. Implied decimal with scale 1e-6'
  market_open_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
  market_closed_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
  auction_collar_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: action_sequence
        type: u4
        doc: 'Trading Action Sequence Number — per-symbol sequence'
      - id: collar_reference_price
        type: decimal_u8_6
        doc: 'Reference price used to set collar. Implied decimal with scale 1e-6'
      - id: collar_up_price
        type: decimal_u8_6
        doc: 'Collar Up Price. Implied decimal with scale 1e-6'
      - id: collar_down_price
        type: decimal_u8_6
        doc: 'Collar Down Price. Implied decimal with scale 1e-6'
      - id: collar_extension
        type: str
        size: 1
        encoding: ASCII
        doc: 'Collar Extension Indicator'
  inbound_control_messages_message:
    seq:
      - id: inbound_control_messages_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Inbound Control Messages message type'
      - id: inbound_control_messages_message_payload
        type:
          switch-on: inbound_control_messages_message_type
          cases:
            '"C"': sequence_inquiry_message
            '"S"': symbol_state_inquiry_message
            '"G"': end_of_participant_reporting_message
  sequence_inquiry_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
  symbol_state_inquiry_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
  end_of_participant_reporting_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: timestamp_1
        type: nanosecond_timestamp
        doc: 'Participant-provided timestamp, nanoseconds since Epoch. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
  return_administrative_messages_message:
    seq:
      - id: return_administrative_messages_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Return Administrative Messages message type'
      - id: return_administrative_messages_message_payload
        type:
          switch-on: return_administrative_messages_message_type
          cases:
            '"A"': return_general_administrative_message
            '"J"': return_market_center_trading_action_acknowledgement_message
            '"X"': return_market_open_message
            '"Y"': return_market_closed_message
            '"R"': reject_message
            '"K"': sequence_acknowledgement_message
            '"W"': participant_input_warning_message
  return_general_administrative_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: text_len
        type: u2
        doc: 'Text Length'
      - id: text
        type: str
        size-eos: true
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text body (length contained in textLen, max 300)'
  return_market_center_trading_action_acknowledgement_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: action
        type: u1
        enum: action
        doc: 'Trading Action Code (H/Q/T/P)'
      - id: action_time
        type: nanosecond_timestamp
        doc: 'Time Action occurred (may be prior day). Nanoseconds since Unix epoch'
  return_market_open_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
  return_market_closed_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
  reject_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: reject_code
        type: u2
        enum: reject_code
        doc: 'Error Code for the First Diagnosed Error'
      - id: syntax_violation
        type: u1
        enum: syntax_violation
        doc: 'Syntax Violation Flag (Y/N)'
  sequence_acknowledgement_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
  participant_input_warning_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: warning_code
        type: u2
        doc: 'Warning Code (typically 101 for excess odd-lot levels)'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: ol_attachmen_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Odd Lot Attachment Type (2=Short form, 3=Long form, 5=ADF MPID form)'
      - id: ol_attachment_count
        type: u2
        doc: 'Number of Odd Lot Price Level Attachments that follow'
  return_control_messages_message:
    seq:
      - id: return_control_messages_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Return Control Messages message type'
      - id: return_control_messages_message_payload
        type:
          switch-on: return_control_messages_message_type
          cases:
            '"E"': start_of_day_message
            '"F"': end_of_day_message
            '"C"': sequence_inquiry_response_message
            '"S"': symbol_state_inquiry_response_message
  start_of_day_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
  end_of_day_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
  sequence_inquiry_response_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: feed_sequence
        type: u8
        doc: 'Message Sequence Number, consecutive positive integers starting at 1'
      - id: part_token
        type: u8
        doc: 'Participant Token, pass-through value'
      - id: sip_state
        type: u1
        enum: sip_state
        doc: 'Present SIP State (N=Before SOD, S=After SOD, E=After EOD)'
  symbol_state_inquiry_response_message:
    seq:
      - id: orig
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Originating Participant'
      - id: sip_time
        type: nanosecond_timestamp
        doc: 'SIP Timestamp. Nanoseconds since Unix epoch'
      - id: symbol_byte_11
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Identifier (long form)'
      - id: next_trade_id
        type: u4
        doc: 'Next Expected Trade Id (0 for Quote lines)'
      - id: next_action_sequence
        type: u4
        doc: 'Next Expected Action Sequence'
      - id: symbol_state
        type: u1
        enum: symbol_state
        doc: 'Symbol Trading Status (H=Halt, Q=Quotation, T=Trading, P=Volatility Pause)'
  debug_packet:
    seq:
      - id: text
        type: str
        size-eos: true
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text body (length contained in textLen, max 300)'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'The SoupBinTCP login username, left padded with spaces'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'The SoupBinTCP login password, left padded with spaces'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'The requested session ID, space-padded; spaces request the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'The first sequenced message number the client wishes to receive, space-padded'
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  client_packet_type:
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Unsequenced Data Packet'
    0x2b:
      id: 'debug_packet'
      doc: 'SoupBinTCP Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupBinTCP Login Request Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupBinTCP Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupBinTCP Logout Request Packet'
  cond:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask Automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid Automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast Trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid And Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed Quote'
    0x4e:
      id: 'nonfirm_quote'
      doc: 'Nonfirm Quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening Quote Automated'
    0x52:
      id: 'regular_twosided_open_quote_automated'
      doc: 'Regular Twosided Open Quote Automated'
    0x55:
      id: 'manual_bid_and_ask_nonfirm'
      doc: 'Manual Bid And Ask Nonfirm'
    0x58:
      id: 'order_influx'
      doc: 'Order Influx'
    0x59:
      id: 'automated_bid_no_offer_or_automated_offer_no_bid'
      doc: 'Automated Bid No Offer Or Automated Offer No Bid'
    0x5a:
      id: 'no_openno_resume'
      doc: 'No Openno Resume'
    0x34:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  rii:
    0x20:
      id: 'retail_interest_not_applicable'
      doc: 'Retail Interest Not Applicable'
    0x41:
      id: 'retail_interest_on_bid_quote'
      doc: 'Retail Interest On Bid Quote'
    0x42:
      id: 'retail_interest_on_ask_quote'
      doc: 'Retail Interest On Ask Quote'
    0x43:
      id: 'retail_interest_on_both_bid_and_ask_quote'
      doc: 'Retail Interest On Both Bid And Ask Quote'
  bbo_cond:
    0x41:
      id: 'manual_ask_automated_bid'
      doc: 'Manual Ask Automated Bid'
    0x42:
      id: 'manual_bid_automated_ask'
      doc: 'Manual Bid Automated Ask'
    0x46:
      id: 'fast_trading'
      doc: 'Fast Trading'
    0x48:
      id: 'manual_bid_and_ask'
      doc: 'Manual Bid And Ask'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x4c:
      id: 'closed_quote'
      doc: 'Closed Quote'
    0x4e:
      id: 'nonfirm_quote'
      doc: 'Nonfirm Quote'
    0x4f:
      id: 'opening_quote_automated'
      doc: 'Opening Quote Automated'
    0x52:
      id: 'regular_twosided_open_quote_automated'
      doc: 'Regular Twosided Open Quote Automated'
  bbo_indicator:
    0x41:
      id: 'no_finra_bbo_change'
      doc: 'No Finra Bbo Change'
    0x42:
      id: 'no_finra_bbo_exists'
      doc: 'No Finra Bbo Exists'
  tt_exempt:
    0x58:
      id: 'rule_611_trade_through_exempt'
      doc: 'Rule 611 Trade Through Exempt'
    0x20:
      id: 'not_rule_611_trade_through_exempt'
      doc: 'Not Rule 611 Trade Through Exempt'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x58:
      id: 'cross'
      doc: 'Cross'
    0x52:
      id: 'short_sale'
      doc: 'Short Sale'
  cancel_type:
    0x43:
      id: 'cancel'
      doc: 'Cancel'
    0x45:
      id: 'error'
      doc: 'Error'
  reversal:
    0x59:
      id: 'transaction_represents_a_reversal'
      doc: 'Transaction Represents A Reversal'
    0x4e:
      id: 'transaction_does_not_represent_a_reversal'
      doc: 'Transaction Does Not Represent A Reversal'
  action:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x51:
      id: 'quotation_resumption_including_revoke_emergency_market_action'
      doc: 'Quotation Resumption Including Revoke Emergency Market Action'
    0x54:
      id: 'trading_resumption'
      doc: 'Trading Resumption'
    0x50:
      id: 'volatility_trading_pause'
      doc: 'Volatility Trading Pause'
    0x57:
      id: 'wipeout_quote'
      doc: 'Wipeout Quote'
    0x45:
      id: 'emergency_market_action_wipeout_and_reject_new_quotes'
      doc: 'Emergency Market Action Wipeout And Reject New Quotes'
    0x4f:
      id: 'clear_odd_lot_quotes'
      doc: 'Clear Odd Lot Quotes'
  reject_code:
    1:
      id: 'invalid_message_type'
      doc: 'Invalid Message Type'
    2:
      id: 'invalid_originating_participant'
      doc: 'Invalid Originating Participant'
    7:
      id: 'missing_message_gap_detected'
      doc: 'Missing Message Gap Detected'
    11:
      id: 'system_not_open'
      doc: 'System Not Open'
    26:
      id: 'unknown_security_id'
      doc: 'Unknown Security Id'
    27:
      id: 'invalid_trade_cancellation_type'
      doc: 'Invalid Trade Cancellation Type'
    28:
      id: 'invalid_price'
      doc: 'Invalid Price'
    29:
      id: 'invalid_volume'
      doc: 'Invalid Volume'
    31:
      id: 'invalid_condition'
      doc: 'Invalid Condition'
    32:
      id: 'invalid_number_of_days_field'
      doc: 'Invalid Number Of Days Field'
    33:
      id: 'invalid_execution_side'
      doc: 'Invalid Execution Side'
    36:
      id: 'security_halted'
      doc: 'Security Halted'
    37:
      id: 'invalid_message_format'
      doc: 'Invalid Message Format'
    48:
      id: 'invalid_size'
      doc: 'Invalid Size'
    60:
      id: 'invalid_date_and_time'
      doc: 'Invalid Date And Time'
    62:
      id: 'market_open_message_not_received'
      doc: 'Market Open Message Not Received'
    66:
      id: 'invalid_mpid'
      doc: 'Invalid Mpid'
    68:
      id: 'invalid_finra_bbo_mpid'
      doc: 'Invalid Finra Bbo Mpid'
    69:
      id: 'invalid_finra_bbo_price'
      doc: 'Invalid Finra Bbo Price'
    70:
      id: 'invalid_finra_bbo_size'
      doc: 'Invalid Finra Bbo Size'
    71:
      id: 'invalid_finra_bbo_cond'
      doc: 'Invalid Finra Bbo Cond'
    73:
      id: 'trade_doesnt_match'
      doc: 'Trade Doesnt Match'
    75:
      id: 'participant_halted'
      doc: 'Participant Halted'
    76:
      id: 'invalid_reversal_indicator'
      doc: 'Invalid Reversal Indicator'
    77:
      id: 'invalid_reason'
      doc: 'Invalid Reason'
    79:
      id: 'market_wide_halt'
      doc: 'Market Wide Halt'
    80:
      id: 'invalid_retail_interest_indicator'
      doc: 'Invalid Retail Interest Indicator'
    82:
      id: 'invalid_reporting_time'
      doc: 'Invalid Reporting Time'
    83:
      id: 'unsupported_message_version'
      doc: 'Unsupported Message Version'
    84:
      id: 'originating_participant_not_allowed'
      doc: 'Originating Participant Not Allowed'
    86:
      id: 'invalid_bbo_indicator'
      doc: 'Invalid Bbo Indicator'
    87:
      id: 'invalid_trade_through_exempt_flag'
      doc: 'Invalid Trade Through Exempt Flag'
    88:
      id: 'invalid_action'
      doc: 'Invalid Action'
    89:
      id: 'action_not_allowed'
      doc: 'Action Not Allowed'
    92:
      id: 'unexpected_trade_id'
      doc: 'Unexpected Trade Id'
    93:
      id: 'unexpected_trading_action_sequence'
      doc: 'Unexpected Trading Action Sequence'
    101:
      id: 'invalid_odd_level'
      doc: 'Invalid Odd Level'
  syntax_violation:
    0x59:
      id: 'syntax_violation_port_will_disconnect'
      doc: 'Syntax Violation— Port Will Disconnect'
    0x4e:
      id: 'no_syntax_violation'
      doc: 'No Syntax Violation'
  sip_state:
    0x4e:
      id: 'before_start_of_day_sod'
      doc: 'Before Start Of Day Sod'
    0x53:
      id: 'after_start_of_day_sod_before_end_of_day_eod'
      doc: 'After Start Of Day Sod Before End Of Day Eod'
    0x45:
      id: 'after_end_of_day_eod'
      doc: 'After End Of Day Eod'
  symbol_state:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x51:
      id: 'quotation_only'
      doc: 'Quotation Only'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x50:
      id: 'volatility_trading_pause'
      doc: 'Volatility Trading Pause'
  server_packet_type:
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x2b:
      id: 'debug_packet'
      doc: 'SoupBinTCP Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupBinTCP Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupBinTCP Login Rejected Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupBinTCP Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupBinTCP End of Session Packet'

