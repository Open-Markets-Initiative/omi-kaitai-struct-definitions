# ---------------------------------------------------------------------
# Kaitai struct definition for: Hkex Szse ChinaConnectRefresh Omd v1.4
#
# Protocol:
#   Organization: Hong Kong Exchanges and Clearing
#   Protocol: Orion Market Data China Connect Refresh
#   Encoding: Orion Market Data
#   Version: 1.4
#   Date: 4/22/2022
#   Specification: HKEX_OMD_China_Connect_Securities_Interface_Specifications_v1_4.pdf
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
  id: hkex_szse_chinaconnectrefresh_omd_v1_4
  title: Hkex Szse ChinaConnectRefresh Omd v1.4
  license: GPL-3.0
  endian: le

doc: 'Hong Kong Exchanges and Clearing Shenzhen Stock Exchange Orion Market Data China Connect Refresh Omd v1.4'
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
            'msg_type::market_definition_message': market_definition_message
            'msg_type::refresh_complete_message': refresh_complete_message
            'msg_type::security_definition_message': security_definition_message
            'msg_type::security_status_message': security_status_message
            'msg_type::statistics_message': statistics_message
            'msg_type::top_of_book_message': top_of_book_message
  msg_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'Length of the message including this field'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Code identifying this message type'
  market_definition_message:
    seq:
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market code'
      - id: market_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Name'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Base currency code of the market'
      - id: number_of_securities
        type: u4
        doc: 'Number of securities within the market'
  refresh_complete_message:
    seq:
      - id: last_seq_num
        type: u4
        doc: 'Sequence number with which the refresh is synchronized'
  security_definition_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 6 digit security codes with possible values 1 to 999999'
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market code'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code of the security'
      - id: instrument_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument type of the security'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: security_short_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security short name'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Base currency code of the market'
      - id: filler_60
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: security_name_gb
        size: 60
        doc: 'Security name in Simplified Chinese using Unicode UTF-16LE encoding'
      - id: lot_size
        type: u4
        doc: 'Board lot size for the security'
      - id: previous_closing_price
        type: decimal_s4_3
        doc: 'Previous closing price of the security. 3 implied decimal places. May be 0 on first day of listing. Implied decimal with scale 1e-3'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: shortsell_flag
        type: u1
        enum: shortsell_flag
        doc: 'Indicator for short-sell authorization'
      - id: filler_6
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: listing_date
        type: u4
        doc: 'Date of security listing. YYYYMMDD. Value is 19000101 for unknown listing date'
      - id: filler_7
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  security_status_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 6 digit security codes with possible values 1 to 999999'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'Identifies the trading status of a security'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the trading state of the security. Refer to TradingPhaseCode information in SSE and SZSE market data of this security for details'
  statistics_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 6 digit security codes with possible values 1 to 999999'
      - id: shares_traded
        type: u8
        doc: 'Number of shares traded for a security'
      - id: turnover
        type: decimal_s8_3
        doc: 'Current turnover. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: high_price
        type: decimal_s4_3
        doc: 'Highest trade price currently performed for a security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: low_price
        type: decimal_s4_3
        doc: 'Lowest trade price currently performed for a security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: last_price
        type: decimal_s4_3
        doc: 'Last trade price for a security. For MarketCode=ASHR this is updated with Close price at Market Close. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: opening_price
        type: decimal_s4_3
        doc: 'Opening price for a security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: filler_12
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  top_of_book_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 6 digit security codes with possible values 1 to 999999'
      - id: aggregate_bid_quantity
        type: u8
        doc: 'Aggregated number of shares on the bid side. Provides Virtual Auction Volume during Call Auction period'
      - id: aggregate_ask_quantity
        type: u8
        doc: 'Aggregated number of shares on the ask side. Provides Virtual Auction Volume during Call Auction period'
      - id: bid_price
        type: decimal_s4_3
        doc: 'The bid price. Provides Virtual Auction Price during Call Auction period. 3 implied decimal places. 0 means N/A. Implied decimal with scale 1e-3'
      - id: ask_price
        type: decimal_s4_3
        doc: 'The ask price. Provides Virtual Auction Price during Call Auction period. 3 implied decimal places. 0 means N/A. Implied decimal with scale 1e-3'
      - id: filler_8
        type: str
        size: 8
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
  decimal_s4_3:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 1000.0
  decimal_s8_3:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000.0

enums:
  msg_type:
    610:
      id: 'market_definition_message'
      doc: 'The Market Definition message is generated at the start of the business day for each market (SSE or SZSE). Market Definition messages for different markets are sent via different channels.'
    203:
      id: 'refresh_complete_message'
      doc: 'This message is published to mark the end of a refresh.'
    611:
      id: 'security_definition_message'
      doc: 'The Security Definition message contains all the reference data for a security. Security Definition messages for different markets (SSE and SZSE) are sent via different channels.'
    621:
      id: 'security_status_message'
      doc: 'The Security Status message is generated at the start of the business day if the security is halted, and whenever a security state or trading phase changes. Security Status messages for different markets (SSE and SZSE) are sent via different channels.'
    660:
      id: 'statistics_message'
      doc: 'The Statistics message provides statistics including turnover. Statistics messages for different markets (SSE and SZSE) are sent via different channels.'
    655:
      id: 'top_of_book_message'
      doc: 'The Top Of Book (TOB) message is generated when the top price level has been modified. TOB messages for different markets (SSE and SZSE) are sent via different channels.'
  shortsell_flag:
    0x59:
      id: 'shortsell_allowed'
      doc: 'Shortsell Allowed'
    0x4e:
      id: 'shortsell_not_allowed'
      doc: 'Shortsell Not Allowed'
  security_trading_status:
    2:
      id: 'trading_halt'
      doc: 'Trading Halt'
    3:
      id: 'resume'
      doc: 'Resume'

