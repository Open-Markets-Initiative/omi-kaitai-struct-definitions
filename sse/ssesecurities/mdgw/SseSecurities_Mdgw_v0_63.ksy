# ---------------------------------------------------------------------
# Kaitai struct definition for: Sse SseSecurities Mdgw Is120 v0.63
#
# Protocol:
#   Organization: Shanghai Stock Exchange
#   Protocol: Market Data Gateway
#   Encoding: IS120 Market Data Gateway Binary
#   Version: 0.63
#   Date: 9/18/2026
#   Specification: IS120_上海证券交易所行情网关BINARY数据接口规范0.63版_20260918.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: sse_ssesecurities_mdgw_is120_v0_63
  title: Sse SseSecurities Mdgw Is120 v0.63
  license: MIT-0
  endian: be

doc: 'Shanghai Stock Exchange Shanghai Stock Exchange Securities Market Market Data Gateway Is120 v0.63'
doc-ref: https://www.sse.com.cn/services/tradingtech/data/

seq:
  - id: binary_message
    type: binary_message_struct
    repeat: eos
    doc: 'BINARY message'

types:
  binary_message_struct:
    seq:
      - id: standard_header
        type: standard_header
      - id: message_body
        size: standard_header.bodylength
        type:
          switch-on: standard_header.msgtype
          cases:
            '"S001"': logon_message
            '"S002"': logout_message
            '"P001"': channel_heartbeat
            '"P002"': retransmission_message
            '"M101"': market_status_message
            '"M102"': market_data_snapshot_message
            '"M201"': tickbytick_market_data_message
      - id: standard_trailer
        type: standard_trailer
        doc: 'The checksum is calculated from the start of the message header (header included) to the end of the message body. See Appendix 1 "Calculating the checksum" for sample code'
  standard_header:
    seq:
      - id: msgtype
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Message type'
      - id: sendingtime
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Sending time, format: YYYYMMDDHHmmSSsss'
      - id: msgseqnum
        type: u8
        doc: 'Message sequence number'
      - id: bodylength
        type: u4
        doc: 'Message body length'
  logon_message:
    seq:
      - id: sendercompid
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sender code'
      - id: targetcompid
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Receiver code'
      - id: heartbtint
        type: u2
        doc: 'Heartbeat interval, in seconds'
      - id: applverid
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Protocol version, in the format mm.nn, where mm is the major version number and nn is the minor version number, for example 0.30, 12.22'
  logout_message:
    seq:
      - id: sessionstatus
        type: u4
        enum: sessionstatus
        doc: 'Session status at logout. 1–999 = Logout in general circumstances, reconnecting can recover; 1000–9999 = Logout in serious circumstances, switching servers is recommended'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text'
  channel_heartbeat:
    seq:
      - id: channel_heartbeat_securitytype
        type: u1
        enum: channel_heartbeat_securitytype
        doc: 'Security type'
      - id: channel_heartbeat_channelno
        type: u2
        enum: channel_heartbeat_channelno
        doc: 'Channel number'
      - id: appllastseqnum
        type: u8
        doc: 'Largest message record number published on this channel'
      - id: endofchannel
        type: u1
        enum: endofchannel
        doc: 'Channel end flag'
  retransmission_message:
    seq:
      - id: retransmission_message_channelno
        type: u2
        enum: retransmission_message_channelno
        doc: 'Channel number'
      - id: resendtype
        type: u1
        enum: resendtype
        doc: 'Retransmission category'
      - id: applbegseqnum
        type: u8
        doc: 'Retransmission start message record number. The value is greater than 0'
      - id: applendseqnum
        type: u8
        doc: 'Retransmission end message record number. When the value is 0, the exchange sets this field to the largest message record number published on this channel; in a reply, the value is the largest message record number actually transmitted'
      - id: resendstatus
        type: u1
        enum: resendstatus
        doc: 'Valid only in retransmission reply messages'
      - id: rejecttext
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Valid only in retransmission reply messages. Gives the reason the retransmission was rejected (if any)'
  market_status_message:
    seq:
      - id: market_status_message_securitytype
        type: u1
        enum: market_status_message_securitytype
        doc: 'Security type'
      - id: tradsesmode
        type: u1
        enum: tradsesmode
        doc: 'Trading session mode'
      - id: tradingsessionid
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data status: this field is an 8-character string; each position, counted from the left, has a specific meaning; a position with no definition is filled with a space'
      - id: totnorelatedsym
        type: u4
        doc: 'Maximum number of products (including indices)'
  market_data_snapshot_message:
    seq:
      - id: market_data_snapshot_message_securitytype
        type: u1
        enum: market_data_snapshot_message_securitytype
        doc: 'Security type'
      - id: tradsesmode
        type: u1
        enum: tradsesmode
        doc: 'Trading session mode'
      - id: tradedate
        type: yyyymmdd_date
        doc: 'Trade date YYYYMMDD'
      - id: lastupdatetime
        type: hhmmssmmm_time
        doc: 'Last update time HHMMSSsss'
      - id: mdstreamid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: securityid
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product short name'
      - id: preclosepx
        type: decimal_u8_5
        doc: 'Previous close. Implied decimal with scale 1e-5'
      - id: totalvolumetraded
        type: u8
        doc: 'Trade volume'
      - id: numtrades
        type: u8
        doc: 'Number of trades'
      - id: market_data_snapshot_message_totalvaluetraded
        type: decimal_u8_2
        doc: 'Trade value. Implied decimal with scale 1e-2'
      - id: tradingphasecode
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Real-time phase and flags'
      - id: market_data_snapshot_message_extendfields
        type:
          switch-on: mdstreamid
          cases:
            '"MD001"': index_market_data_snapshot_extension_fields
            '"MD002"': market_data_snapshot_extension_fields
            '"MD003"': market_data_snapshot_extension_fields
            '"MD004"': market_data_snapshot_extension_fields
            '"MD101"': market_data_snapshot_extension_fields
            '"MD102"': market_data_snapshot_extension_fields
            '"MD301"': market_data_snapshot_extension_fields
            '"MD201"': market_data_snapshot_extension_fields
            '"MDE01"': market_data_snapshot_extension_fields
            '"MD210"': market_data_snapshot_extension_fields
  index_market_data_snapshot_extension_fields:
    seq:
      - id: num_index_market_data_snapshot_entries
        type: u2
        doc: 'Number of market data entries'
      - id: index_market_data_snapshot_entries
        type: index_market_data_snapshot_entries
        repeat: expr
        repeat-expr: num_index_market_data_snapshot_entries
  index_market_data_snapshot_entries:
    seq:
      - id: index_market_data_snapshot_entries_mdentrytype
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data entry type'
      - id: index_market_data_snapshot_entries_mdentrypx
        type: decimal_u8_5
        doc: 'Index value. Implied decimal with scale 1e-5'
  market_data_snapshot_extension_fields:
    seq:
      - id: num_market_data_snapshot_entries
        type: u2
        doc: 'Number of market data entries'
      - id: market_data_snapshot_entries
        type: market_data_snapshot_entries
        repeat: expr
        repeat-expr: num_market_data_snapshot_entries
  market_data_snapshot_entries:
    seq:
      - id: market_data_snapshot_entries_mdentrytype
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data entry type'
      - id: market_data_snapshot_entries_mdentrypx
        type: decimal_u8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: mdentrysize
        type: u8
        doc: 'Quantity'
      - id: mdentrypositionno
        type: u1
        doc: 'Bid or ask level number, giving the level of the five levels of bid and ask prices and quantities'
  tickbytick_market_data_message:
    seq:
      - id: tickbytick_market_data_message_securitytype
        type: u1
        enum: tickbytick_market_data_message_securitytype
        doc: 'Security type'
      - id: tickbytick_market_data_message_channelno
        type: u2
        doc: 'Channel number'
      - id: applseqnum
        type: u8
        doc: 'Message record number, counted from 1'
      - id: mdstreamid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: securityid
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code'
      - id: transacttime
        type: hhmmssmmm_time
        doc: 'Time the order or trade market data was generated: HHMMSSsss'
      - id: exectype
        type: u1
        enum: exectype
        doc: 'Type'
      - id: price
        type: decimal_u8_5
        doc: 'For a tick-by-tick order, the order price; it is 0 when an intention declaration does not fill in a price or when an order is deleted. For a tick-by-tick trade, the trade price. Implied decimal with scale 1e-5'
      - id: orderqty
        type: decimal_u8_3
        doc: 'For a tick-by-tick order, the order quantity; it is 0 when an intention declaration does not fill in a quantity or when an order is deleted. For a tick-by-tick trade, the trade quantity. Implied decimal with scale 1e-3'
      - id: tickbytick_market_data_message_extendfields
        type:
          switch-on: mdstreamid
          cases:
            '"MD211"': tickbytick_order_market_data_extension_fields
            '"MD212"': tickbytick_order_market_data_extension_fields
            '"MD213"': tickbytick_order_market_data_extension_fields
            '"MD214"': tickbytick_order_market_data_extension_fields
            '"MD215"': tickbytick_order_market_data_extension_fields
            '"MD216"': tickbytick_order_market_data_extension_fields
            '"MD217"': tickbytick_trade_market_data_extension_fields
  tickbytick_order_market_data_extension_fields:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quoteid
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order number; for an order deletion, the order number of the deleted order'
      - id: memberid
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Institution code of the quoting party''s trading participant. Blank if the initiator chooses to be anonymous'
      - id: tradercode
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Quoting trader''s Yizhaitong account. Blank if the initiator chooses to be anonymous'
      - id: fullamounttrade
        type: u1
        enum: fullamounttrade
        doc: 'Whether the trade is for the full amount'
      - id: settltype
        type: u1
        enum: settltype
        doc: 'Settlement method'
      - id: contractmultiplier
        type: decimal_u4_2
        doc: 'Conversion ratio (%); 0 if the initiator did not fill in this field. Implied decimal with scale 1e-2'
      - id: expirationdays
        type: u2
        doc: 'Term (days); 0 if the initiator did not fill in this field'
      - id: tickbytick_order_market_data_extension_fields_totalvaluetraded
        type: decimal_u8_2
        doc: 'Trade value; 0 if the initiator did not fill in this field. Implied decimal with scale 1e-2'
      - id: basketid
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Basket information. Positions from the left stand for basket 1 to basket N. For example, to specify baskets 1, 2 and 5, fill in "1100100000000000"'
      - id: investorname
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor name'
      - id: bidtranstype
        type: u1
        enum: bidtranstype
        doc: 'Competitive bidding declaration category'
      - id: bidexecinsttype
        type: u1
        enum: bidexecinsttype
        doc: 'Competitive bidding declaration method'
      - id: expiredate
        type: yyyymmdd_date
        doc: 'Competitive bidding date: YYYYMMDD'
      - id: secondaryorderid
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order number that the response price declaration corresponds to (that is, the competitive bidding declaration number)'
      - id: minqty
        type: u8
        doc: 'Minimum trade quantity, reserved'
  tickbytick_trade_market_data_extension_fields:
    seq:
      - id: bidapplseqnum
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Buyer order number (QuoteID). Blank when there is no corresponding order'
      - id: offerapplseqnum
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Seller order number (QuoteID). Blank when there is no corresponding order'
      - id: tickbytick_trade_market_data_extension_fields_totalvaluetraded
        type: decimal_u8_2
        doc: 'Trade value. Implied decimal with scale 1e-2'
      - id: trademethod
        type: u1
        enum: trademethod
        doc: 'Trade method'
      - id: marginprice
        type: decimal_u8_5
        doc: 'Marginal price. Applies only to competitive bidding trades with multiple entities. Implied decimal with scale 1e-5'
  standard_trailer:
    seq:
      - id: checksum
        type: u4
        doc: 'Checksum'
  yyyymmddhhmmssmmm_timestamp:
    seq:
      - id: packed
        type: s8
    instances:
      year:
        value: packed / 10000000000000
      month:
        value: packed / 100000000000 % 100
      day:
        value: packed / 1000000000 % 100
      hour:
        value: packed / 10000000 % 100
      minute:
        value: packed / 100000 % 100
      second:
        value: packed / 1000 % 100
      millisecond:
        value: packed % 1000
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
  hhmmssmmm_time:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 10000000 % 100
      minute:
        value: time / 100000 % 100
      second:
        value: time / 1000 % 100
      millisecond:
        value: time % 1000
  decimal_u8_5:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000.0
  decimal_u8_2:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100.0
  decimal_u8_3:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000.0
  decimal_u4_2:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 100.0

enums:
  sessionstatus:
    0: 'normal_logout'
  channel_heartbeat_securitytype:
    13: 'bonds_nonmatched_trading'
  channel_heartbeat_channelno:
    100: 'nonmatched_trading_tickbytick_market_data'
  endofchannel:
    0x59: 'market_data_updates_have_ended'
    0x4e: 'market_data_updates_have_not_ended'
  retransmission_message_channelno:
    100: 'nonmatched_trading_tickbytick_market_data'
  resendtype:
    1: 'tickbytick_market_data'
  resendstatus:
    1: 'all_complete'
    2: 'partially_complete_part_of_the_requested_data_was_not_returned'
    3: 'no_permission'
    4: 'data_not_available'
    5: 'a_retransmission_request_is_being_processed'
    99: 'other'
  market_status_message_securitytype:
    1: 'stocks_funds_indices_and_bond_distribution'
    2: 'derivatives'
    3: 'comprehensive_business'
    12: 'bonds_matched_trading'
    13: 'bonds_nonmatched_trading'
    14: 'external_source_market_data'
  tradsesmode:
    1: 'system_test'
    2: 'simulated_trading'
    3: 'production_normal_trading'
  market_data_snapshot_message_securitytype:
    1: 'stocks_funds_indices_and_bond_distribution'
    2: 'derivatives'
    3: 'comprehensive_business'
    12: 'bonds_matched_trading'
    13: 'bonds_nonmatched_trading'
    14: 'external_source_market_data'
  tickbytick_market_data_message_securitytype:
    13: 'bonds_nonmatched_trading'
  exectype:
    0x30:
      id: 'new_order'
      doc: 'For tick-by-tick orders'
    0x34:
      id: 'delete_order'
      doc: 'For tick-by-tick orders'
    0x46:
      id: 'trade'
      doc: 'For tick-by-tick trades'
  side:
    0x31: 'buy'
    0x32: 'sell'
  fullamounttrade:
    1: 'yes_field'
    2: 'no_field'
  settltype:
    1: 'net_settlement'
    2: 'rtgs'
  bidtranstype:
    1: 'competitive_bidding_reservation'
    2: 'competitive_bidding_declaration'
    3: 'response_price_declaration_for_a_single_winning_entity'
  bidexecinsttype:
    1: 'single_winning_entity'
    2: 'multiple_winning_entities_at_a_single_price'
    3: 'multiple_winning_entities_at_multiple_prices'
  trademethod:
    0: 'matched_trade_reserved'
    1: 'firm_quote_click_trade'
    2: 'indicative_quote_click_trade'
    3: 'inquiry_trade'
    6: 'negotiated_trade_including_merged_declarations'
    7: 'competitive_bidding_singleentity_trade'
    10: 'competitive_bidding_multientity_singleprice_trade'
    11: 'competitive_bidding_multientity_multipleprice_trade'

