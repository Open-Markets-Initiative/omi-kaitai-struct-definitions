# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw Wse Quotes Xdp v6.8
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: Warsaw Stock Exchange Quotes
#   Encoding: Exchange Data Publisher
#   Version: 6.8
#   Date: 02/11/2020
#   Specification: WSE_CDE_XDP_Message_Specifications_v_68.pdf
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
  id: gpw_wse_quotes_xdp_v6_8
  title: Gpw Wse Quotes Xdp v6.8
  license: GPL-3.0
  endian: be

doc: 'Giełda Papierów Wartościowych w Warszawie Warsaw Stock Exchange Warsaw Stock Exchange Quotes Xdp v6.8'
doc-ref: https://www.gpw.pl/utp-documentation

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'All messages are preceded by a common packet header format, which section 1.1 states for every Market Information message'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_msg_entries

types:
  packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the packet including the 16 byte packet header'
      - id: packet_type
        type: u2
        enum: packet_type
        doc: 'Identifier for the type of data contained in the packet. Section 1.1 states one value, 501 for Market Data messages, for every feed the document specifies'
      - id: packet_sequence_number
        type: u4
        doc: 'The packet sequence number, unique for each broadcast stream and used for gap detection. It increases serially and monotonically and is reset to 1 at the beginning of each trading day. It is unique for packets containing market data only, and heartbeats inherit it from the last market data packet or packet sequence number reset packet'
      - id: send_time
        type: u4
        doc: 'Timestamp in millisecond indicating the packet broadcast time. The number represents the number of milliseconds since midnight of the last Sunday 00:00 UTC, a weekly epoch no Epoch trait represents, so the field carries no epoch and a reader resolves the absolute time against the Sunday preceding the capture'
      - id: service_id
        type: u2
        doc: 'Numeric value identifying the broadcast stream. Section 1.1 states that the possible values are described in the XDP CDE Configuration document, a companion this specification does not reproduce, so no value set is declared here'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'Indicates delivery method, and a client reads it to determine whether the packet is ZliB compressed'
      - id: number_msg_entries
        type: u1
        doc: 'The number of messages that are contained within the packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::quotes_and_bbo_5_message': quotes_and_bbo_5_message
            'message_type::indication_of_interest_message': indication_of_interest_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of the message body, excluding the 2 byte MsgSize field'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  quotes_and_bbo_5_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: quote_link_id
        type: u4
        doc: 'Not used'
      - id: ask_price
        type: u4
        doc: 'Ask Price for Quote or BBO (To be calculated with the ScaleCode) Specific values: ''0'' - Limit Deletion ''FF FF FF FE '' - Market Order or Market To Limit Order'
      - id: ask_size
        type: u4
        doc: 'Total number of shares requested in sell orders at the ask price'
      - id: bid_price
        type: u4
        doc: 'Bid Price for Quote or BBO (To be calculated with the ScaleCode) Specific values: ''0'' - Limit Deletion ''FF FF FF FE '' - Market Order or Market To Limit Order'
      - id: bid_size
        type: u4
        doc: 'Total number of securities requested in buy orders at the bid price'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: number_ask_orders
        type: u2
        doc: 'Number of sell orders at the ask price'
      - id: number_bid_orders
        type: u2
        doc: 'Number of buy orders at the bid price Set to 1 when QuoteNumber is equal to 0 (Market Summary)'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: type_of_ask_price
        type: u1
        enum: type_of_ask_price
      - id: type_of_bid_price
        type: u1
        enum: type_of_bid_price
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Liquidity provider presence indicator, only provided for instruments traded on a LP quote driven book. Nullable, Not Provided Not Applicable = 0'
      - id: quote_number
        type: u1
        doc: 'Indicates the level in the order book for the given aggregate quote, derived from it''s price value'
      - id: price_scale_code
        type: u1
        doc: 'Applicable to all prices in the message'
      - id: reserved_1
        size: 1
        doc: 'For future use'
  indication_of_interest_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: ioiutpid
        type: u4
        doc: 'IOI identifier: uniqueness is guaranteed for the day for all instruments'
      - id: ioi_qty
        type: u4
        doc: 'Optional, IOI quantity'
      - id: price
        type: u4
        doc: 'Optional, IOI price, to be calculated with PriceScaleCode'
      - id: validity_time
        type: hhmmss_time
        doc: 'Optional, indicates the IOI end of validity time (HHMMSS)'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: price_scale_code
        type: u1
        doc: 'Applicable to all prices in the message'
      - id: ioi_trans_type
        type: u1
        enum: ioi_trans_type
        doc: 'Indicates the IOI type'
      - id: firm_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the Firm ID who issued the indication of interest if the IOI is not anonymous'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the IOI'
      - id: settlement_date
        type: yyyymmdd_ascii_date
        doc: 'Optional, settlement date (YYYYMMDD)'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'IOI trade type'
      - id: reserved_3
        size: 3
        doc: 'For future use'
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
  hhmmss_time:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 10000 % 100
      minute:
        value: time / 100 % 100
      second:
        value: time % 100
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

enums:
  packet_type:
    501:
      id: 'market_data_messages'
      doc: 'Market Data messages'
  delivery_flag:
    0:
      id: 'real_time_message_uncompressed'
      doc: 'Real Time message (Uncompressed)'
    2:
      id: 'retransmission_message_uncompressed'
      doc: 'Retransmission message (Uncompressed)'
    16:
      id: 'real_time_message_zlib_compressed'
      doc: 'Real Time message (ZliB Compressed)'
    17:
      id: 'refresh_message_zlib_compressed'
      doc: 'Refresh message (ZliB Compressed)'
    18:
      id: 'retransmission_message_compressed'
      doc: 'Retransmission message (Compressed)'
  message_type:
    140:
      id: 'quotes_and_bbo_5_message'
      doc: 'A Quotes & BBO5 message indicates the modification of one or more of the N best limits (N being the number of limits disseminated for the given exchange 1 ) for an instrument and, during the Pre-Opening phase, the modification of the "market summary" for the instrument'
    142:
      id: 'indication_of_interest_message'
      doc: 'The Indication of Interest message disseminates an indication of interest for a given instrument to all participants'
  system_id:
    1:
      id: 'all_non_utp_systems'
      doc: 'All Non Utp Systems'
    11:
      id: 'utp_trading_unit_1'
      doc: 'Utp Trading Unit 1'
    12:
      id: 'utp_trading_unit_2'
      doc: 'Utp Trading Unit 2'
  type_of_ask_price:
    0:
      id: 'limit_order_and_peg_order'
      doc: 'Limit Order And Peg Order'
    1:
      id: 'market_order_and_market_to_limit_order'
      doc: 'Market Order And Market To Limit Order'
  type_of_bid_price:
    0:
      id: 'limit_order_and_peg_order'
      doc: 'Limit Order And Peg Order'
    1:
      id: 'market_order_and_market_to_limit_order'
      doc: 'Market Order And Market To Limit Order'
  quote_condition:
    0x30:
      id: 'no_liquidity_provider_lp'
      doc: 'No Liquidity Provider Lp'
    0x31:
      id: 'lp_only_on_ask_side'
      doc: 'Lp Only On Ask Side'
    0x32:
      id: 'lp_only_on_bid_side'
      doc: 'Lp Only On Bid Side'
    0x33:
      id: 'lp_on_ask_and_bid_sides'
      doc: 'Lp On Ask And Bid Sides'
  ioi_trans_type:
    0x4e:
      id: 'new_field'
      doc: 'New'
    0x43:
      id: 'cancel'
      doc: 'Cancel'
    0x45:
      id: 'expire'
      doc: 'Expire'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x35:
      id: 'sell_short_equivalent_to_value_2_sell_optional_for_exchange_members_and_not_monitored_by_the_wse'
      doc: 'Sell Short Equivalent To Value 2 Sell Optional For Exchange Members And Not Monitored By The Wse'
  trade_type:
    0x4f:
      id: 'block_trade'
      doc: 'Block Trade'
    0x53:
      id: 'biso_trade'
      doc: 'Biso Trade'

