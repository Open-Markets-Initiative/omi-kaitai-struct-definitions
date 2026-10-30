# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw Wse OrderBook Xdp v6.8
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: Warsaw Stock Exchange Order Book
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
  id: gpw_wse_orderbook_xdp_v6_8
  title: Gpw Wse OrderBook Xdp v6.8
  license: GPL-3.0
  endian: be

doc: 'Giełda Papierów Wartościowych w Warszawie Warsaw Stock Exchange Warsaw Stock Exchange Order Book Xdp v6.8'
doc-ref: https://www.gpw.pl/utp-documentation

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'All messages are preceded by a common packet header format, which section 1.1 states for every Market Information message'
  - id: message_buffer
    type: message_buffer_struct
    size-eos: true
    doc: 'The packet''s message area: the messages it counts, or one ZliB block holding them'

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
  message_buffer_struct:
    seq:
      - id: message
        type: message
        repeat: expr
        repeat-expr: _root.packet_header.number_msg_entries
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::order_update_market_sheet_message': order_update_market_sheet_message
            'message_type::order_book_retransmission_delimiter_message': order_book_retransmission_delimiter_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of the message body, excluding the 2 byte MsgSize field'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  order_update_market_sheet_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the time when the Order Update is generated. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: price
        type: u4
        doc: 'Price (Tto be calculated with the PriceScaleCode'
      - id: aggregated_volume
        type: u4
        doc: 'Total quantity of orders at the given price level BondSpot: Not applicable'
      - id: volume
        type: u4
        doc: 'Displayed quantity of the order'
      - id: link_id
        type: u4
        doc: 'Not used'
      - id: order_id
        type: u4
        doc: 'Identifies the uniqueness of the order, when combined with OrderDate'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds'
      - id: number_orders
        type: u2
        doc: 'Number of orders in the Book at the price of the current order BondSpot: Not applicable'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of Order. Nullable, Not Provided Case Of Order Deletion Independently Of Reason = 0'
      - id: action_type
        type: u1
        enum: action_type
        doc: 'This field identifies the type of operation on order book'
      - id: price_scale_code
        type: u1
        doc: 'Applicable to all prices in the message'
      - id: order_date
        type: yyyymmdd_date
        doc: 'Date of order (YYYYMMDD)'
      - id: order_priority_date
        type: yyyymmdd_date
        doc: 'Date giving the priority of the order (YYYYMMDD)'
      - id: order_priority_time
        type: hhmmssmmm_time
        doc: 'Time giving the priority of the order (HHMMSSsss)'
      - id: order_priority_micro_secs
        type: u2
        doc: 'Number of micro seconds in the current millisecond BondSpot: Set to zero'
      - id: order_origin
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
      - id: reserved_1
        size: 1
        doc: 'For future use'
  order_book_retransmission_delimiter_message:
    seq:
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the time when the Order Update is generated. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: application_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code identifying the application where the orderbooks are retransmitted'
      - id: instance_num
        type: u1
        doc: 'Indicates the number of trading units for which the orderbooks are rebroadcast'
      - id: retransmission_indicator
        type: u1
        enum: retransmission_indicator
        doc: 'Indicates the status of the retransmission for the instance of the trading engine'
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
    230:
      id: 'order_update_market_sheet_message'
      doc: 'The Order update message generated by the trading engine UTP indicates the creation or modification of a line in the "market sheet" (a.k.a'
    231:
      id: 'order_book_retransmission_delimiter_message'
      doc: 'The Orderbook retransmission delimiter message is set to clean then update the market sheet with the orders from previous days still remaining in the order book'
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
  order_type:
    0x31:
      id: 'market_order'
      doc: 'Market Order'
    0x32:
      id: 'limit_order'
      doc: 'Limit Order'
    0x4b:
      id: 'market_to_limit_order'
      doc: 'Market To Limit Order'
    0x50:
      id: 'peg_order'
      doc: 'Peg Order'
  action_type:
    0x41:
      id: 'new_order'
      doc: 'New Order'
    0x4d:
      id: 'modification_of_existing_order_case_of_partial_fill'
      doc: 'Modification Of Existing Order Case Of Partial Fill'
    0x44:
      id: 'deletion_of_order_identified_by_order_id'
      doc: 'Deletion Of Order Identified By Order Id'
    0x46:
      id: 'deletion_all_orders_for_one_instrument_at_the_start_of_the_day_before_the_order_book_retransmission'
      doc: 'Deletion All Orders For One Instrument At The Start Of The Day Before The Order Book Retransmission'
    0x59:
      id: 'retransmission_of_all_orders_for_the_given_instrument'
      doc: 'Retransmission Of All Orders For The Given Instrument'
  retransmission_indicator:
    0x42:
      id: 'beginning_of_the_retransmission'
      doc: 'Beginning Of The Retransmission'
    0x45:
      id: 'end_of_the_retransmission'
      doc: 'End Of The Retransmission'

