# ---------------------------------------------------------------------
# Kaitai struct definition for: Szse SzseSecurities MulticastMarketData SzseBinary v1.17
#
# Protocol:
#   Organization: Shenzhen Stock Exchange
#   Protocol: Szse Multicast Market Data
#   Encoding: Szse Binary Market Data Feed
#   Version: 1.17
#   Date: 04/01/2025
#   Specification: SZSE Interface Specification of BINARY Market Data Feed (Ver1.17).pdf
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
  id: szse_szsesecurities_multicastmarketdata_szsebinary_v1_17
  title: Szse SzseSecurities MulticastMarketData SzseBinary v1.17
  license: GPL-3.0
  endian: be

doc: 'Shenzhen Stock Exchange Shenzhen Stock Exchange Szse Multicast Market Data SzseBinary v1.17'
doc-ref: http://www.szsi.cn/cpfw/overseas/market/technical/

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Szse Mddp Packet Header, transmitted without encryption'
  - id: packet_body
    type:
      switch-on: packet_header.channel
      cases:
        _: message_block
  - id: packet_trailer
    type: packet_trailer_struct
    doc: 'Szse Mddp Packet Trailer, transmitted without encryption'

types:
  packet_header_struct:
    seq:
      - id: protocol
        type: u1
        doc: 'Protocol identifier, fixed as 0xFF'
      - id: version
        type: u1
        doc: 'Protocol version number, currently 0x01'
      - id: header_size
        type: u1
        doc: 'The length of the entire packet header, counted in 4 byte words from Protocol to the end of Padding'
      - id: sender_id
        type: u1
        doc: 'Identifies different senders on the same multicast address and port'
      - id: mddp_market_id
        type: u2
        doc: 'Market identifier, a reserved field currently fixed as 1. Qualified with the Mddp prefix because the Szse Binary payload declares its own MarketID, a Char[8] market code, and an unqualified name merges with it'
      - id: channel
        type: u2
        doc: 'Channel number; channels in the same market are not repeated and the data content of one channel is in order'
      - id: seq_num
        type: s8
        doc: 'Sequence number of the packet, maintained per sender per channel and advancing by one for each message carried'
      - id: msg_count
        type: u2
        doc: 'The count of application messages carried in the packet body'
      - id: flag
        type: flag
        doc: 'Flag bits identifying packet attributes, most significant bit first'
      - id: original_size
        type: u4
        if: flag.compress > compress::no_compression
        doc: 'The length of the packet body before compression and encryption'
      - id: compressed_size
        type: u4
        if: flag.compress > compress::no_compression
        doc: 'The length of the transmitted packet body after compression'
      - id: encrypted_size
        type: u4
        if: flag.encryption > encryption::no_encryption
        doc: 'The length of the transmitted packet body after encryption'
      - id: padding
        size: (4 - _io.pos % 4) % 4
        if: _io.pos % 4 != 0
        doc: 'Byte aligned padding, meaningless, ensuring the length of the packet header is an integer multiple of 4 bytes'
  flag:
    seq:
      - id: reserved_06
        type: b7
        doc: 'Reserved'
      - id: msg_header
        type: b1
        doc: 'Leader length flag, marking the presence of the Message Lengths table ahead of the messages'
      - id: encryption
        type: b2
        doc: 'The mark of encryption applied to the packet body'
      - id: compress
        type: b2
        doc: 'The mark of compression applied to the packet body'
      - id: resend_by_seq_num
        type: b1
        doc: 'Whether the sender supports resending by the Seq Num of the packet'
      - id: packet_type
        type: b2
        doc: 'Mark of packet type'
      - id: poss_dup_flag
        type: b1
        doc: 'Identifies the data in the packet as possible duplicate data, when Seq Num may be less than the expected sequence number'
  message_block:
    seq:
      - id: message_lengths
        type: message_lengths
        repeat: expr
        repeat-expr: _root.packet_header.msg_count
        if: _root.packet_header.flag.msg_header == msg_header::existence_of_leader_length
        doc: 'Table giving the length of each application message in the packet, letting a receiver split messages without parsing them'
      - id: messages
        type: messages
        repeat: expr
        repeat-expr: _root.packet_header.msg_count
        doc: 'Szse Binary application messages carried by this packet; messages are never transmitted across packets'
  message_lengths:
    seq:
      - id: message_length
        type: u4
        doc: 'The length in bytes of one application message in the packet body'
  messages:
    seq:
      - id: message_header
        type: message_header
        doc: 'Szse Binary message header, defining the type and body length of a message'
      - id: payload
        size: message_header.body_length
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::channel_heartbeat_message': channel_heartbeat_message
            'msg_type::retransmitting_message': retransmitting_message
            'msg_type::client_user_information_reporting_message': client_user_information_reporting_message
            'msg_type::statistics_of_snapshot_data_channel_message': statistics_of_snapshot_data_channel_message
            'msg_type::business_reject_message': business_reject_message
            'msg_type::real_time_market_status_message': real_time_market_status_message
            'msg_type::real_time_status_of_security_message': real_time_status_of_security_message
            'msg_type::announcements_message': announcements_message
            'msg_type::snapshot_data_of_cash_auction_message': snapshot_data_of_cash_auction_message
            'msg_type::snapshot_data_of_spot_bond_trading_message': snapshot_data_of_spot_bond_trading_message
            'msg_type::snapshot_data_of_after_hour_trading_block_trade_message': snapshot_data_of_after_hour_trading_block_trade_message
            'msg_type::snapshot_data_of_after_hour_trading_message': snapshot_data_of_after_hour_trading_message
            'msg_type::snapshot_data_of_eligible_hk_stocks_message': snapshot_data_of_eligible_hk_stocks_message
            'msg_type::index_snapshot_message': index_snapshot_message
            'msg_type::statistic_indicator_snapshot_message': statistic_indicator_snapshot_message
            'msg_type::real_time_reference_net_value_of_funds_snapshot_message': real_time_reference_net_value_of_funds_snapshot_message
            'msg_type::order_tick_data_in_call_auction_message': order_tick_data_in_call_auction_message
            'msg_type::order_tick_data_of_negotiable_trade_message': order_tick_data_of_negotiable_trade_message
            'msg_type::order_tick_data_of_security_lending_message': order_tick_data_of_security_lending_message
            'msg_type::order_tick_data_of_spot_bond_trading_matching_deal_message': order_tick_data_of_spot_bond_trading_matching_deal_message
            'msg_type::order_tick_data_of_spot_bond_trading_quotation_message': order_tick_data_of_spot_bond_trading_quotation_message
            'msg_type::order_tick_data_of_bid_quotation_message': order_tick_data_of_bid_quotation_message
            'msg_type::transaction_tick_data_in_call_auction_message': transaction_tick_data_in_call_auction_message
            'msg_type::transaction_tick_data_of_negotiable_trade_message': transaction_tick_data_of_negotiable_trade_message
            'msg_type::transaction_tick_data_of_security_lending_message': transaction_tick_data_of_security_lending_message
            'msg_type::transaction_tick_data_of_bond_general_pledged_repo_message': transaction_tick_data_of_bond_general_pledged_repo_message
            'msg_type::transaction_tick_data_of_spot_bond_trading_quotation_message': transaction_tick_data_of_spot_bond_trading_quotation_message
            'msg_type::transaction_tick_data_of_bid_quotation_message': transaction_tick_data_of_bid_quotation_message
  message_header:
    seq:
      - id: msg_type
        type: u4
        enum: msg_type
        doc: 'Type of a message'
      - id: body_length
        type: u4
        doc: 'The length of a message body'
  channel_heartbeat_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_last_seq_num
        type: s8
        doc: 'Sequence number of the last market data message'
      - id: end_of_channel
        type: u2
        doc: 'Ending remark of channel'
  retransmitting_message:
    seq:
      - id: resend_type
        type: u1
        enum: resend_type
        doc: 'Category of Re-transmission'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_beg_seq_num
        type: s8
        doc: 'The starting sequence number, effective when ResendType=1, indicating the area of record number'
      - id: appl_end_seq_num
        type: s8
        doc: 'The ending sequence number. When ResendType=1 it indicates the area of record number. When ApplEndSeqNum=0 the Market Data GateWay sets it to the max value of this channel data record in memory on receiving the request'
      - id: news_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique mark of the announcement. Empty strings indicate announcement summary, which will be sent repeatedly'
      - id: resend_status
        type: u1
        enum: resend_status
        doc: 'Re-transmitting status, only effective when the Market Data GateWay front-end processor returns to the Vendor Supplied System server'
      - id: reject_text
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Only effective when the Market Data GateWay front-end processor returns to the Vendor Supplied System server. If the request is rejected the failure code is returned in this field'
  client_user_information_reporting_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: version_code
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of version'
      - id: user_num
        type: u2
        doc: 'The number of client users connected to this Vendor Supplied System at the current time'
  statistics_of_snapshot_data_channel_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: num_md_stream_i_ds
        type: u4
        doc: 'Number of market data types'
      - id: md_stream_i_ds
        type: md_stream_i_ds
        repeat: expr
        repeat-expr: num_md_stream_i_ds
        doc: 'One entry per market data type carried on the channel'
  md_stream_i_ds:
    seq:
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: stock_num
        type: u4
        doc: 'Number of stocks'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
  business_reject_message:
    seq:
      - id: ref_seq_num
        type: s8
        doc: 'Sequence number of the rejected message'
      - id: ref_msg_type
        type: u4
        doc: 'Message type of the rejected message'
      - id: business_reject_ref_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Layer ID of the rejected message'
      - id: business_reject_reason
        type: u2
        doc: 'Reasons of rejection'
      - id: business_reject_text
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Explanation of rejection reasons, may include Chinese characters'
  real_time_market_status_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: market_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market code'
      - id: market_segment_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment ID, reserved'
      - id: trading_session_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading session ID'
      - id: trading_session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading session sub-ID'
      - id: trad_ses_status
        type: u2
        doc: 'Trading session status, reserved'
      - id: trad_ses_start_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Starting time of a trading session, reserved'
      - id: trad_ses_end_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Ending time of a trading session, reserved'
      - id: thredhold_amount
        type: decimal_s8_4
        doc: 'Daily initial amount. Implied decimal with scale 1e4'
      - id: pos_amt
        type: decimal_s8_4
        doc: 'Intraday remaining amount, fixed at 0.0000 when the amount is not available. Implied decimal with scale 1e4'
      - id: amounts_status
        type: u1
        enum: amounts_status
        doc: 'Status of the amount'
  real_time_status_of_security_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: financial_status
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security status. Each byte displays one status, at most 8 concurrently'
      - id: num_switch_field
        type: u4
        doc: 'Number of switch'
      - id: switch_field
        type: switch_field
        repeat: expr
        repeat-expr: num_switch_field
        doc: 'One entry per security switch, giving its type and status'
  switch_field:
    seq:
      - id: security_switch_type
        type: u2
        enum: security_switch_type
        doc: 'Type of switch'
      - id: security_switch_status
        type: u2
        doc: 'Status of security switch'
  announcements_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: news_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique mark of the announcement. Empty strings indicate announcement summary, which will be sent repeatedly'
      - id: headline
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Announcement title, may include Chinese characters'
      - id: raw_data_format
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Format of binary data, such as TXT, PDF or DOC'
      - id: len_raw_data
        type: u4
        doc: 'Length of binary data'
      - id: raw_data
        size: len_raw_data
        doc: 'Binary data, its length given by the leading RawDataLength'
  snapshot_data_of_cash_auction_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: num_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'Market data entries disclosing the order book, with the orders at each price level nested inside'
  md_entries:
    seq:
      - id: md_entry_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of market data entries'
      - id: md_entry_px
        type: decimal_s8_6
        doc: 'Price, carrying eighteen digits of which six are decimal. Implied decimal with scale 1e6'
      - id: md_entry_size
        type: decimal_s8_2
        doc: 'Quantity. Implied decimal with scale 1e2'
      - id: md_price_level
        type: u2
        doc: 'Level of a bid or offer in the order book'
      - id: number_of_orders
        type: s8
        doc: 'Number of total orders on this price level, 0 indicates it is not shown'
      - id: num_orders
        type: u4
        doc: 'Number of orders disclosed at this price level, 0 indicates it is not shown'
      - id: orders
        type: orders
        repeat: expr
        repeat-expr: num_orders
        doc: 'The individual order quantities disclosed at this price level'
  orders:
    seq:
      - id: order_qty
        type: decimal_s8_2
        doc: 'Quantity of orders. Implied decimal with scale 1e2'
  snapshot_data_of_spot_bond_trading_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: num_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'Market data entries disclosing the order book, with the orders at each price level nested inside'
      - id: num_sub_trading_phase_codes
        type: u4
        doc: 'Number of the trading phase subdivision'
      - id: sub_trading_phase_codes
        type: sub_trading_phase_codes
        repeat: expr
        repeat-expr: num_sub_trading_phase_codes
        doc: 'One entry per trading phase subdivision, giving its code and trading type'
      - id: auction_volume_trade
        type: decimal_s8_2
        doc: 'Auction Volume of matching deal. Implied decimal with scale 1e2'
      - id: auction_value_trade
        type: decimal_s8_4
        doc: 'Auction value of matching deal. Implied decimal with scale 1e4'
  sub_trading_phase_codes:
    seq:
      - id: sub_trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code corresponding to the trading type'
      - id: trading_type
        type: u1
        enum: trading_type
        doc: 'Trading type'
  snapshot_data_of_after_hour_trading_block_trade_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: num_trade_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: trade_md_entries
        type: trade_md_entries
        repeat: expr
        repeat-expr: num_trade_md_entries
        doc: 'Market data entries carrying a price and a quantity only'
  trade_md_entries:
    seq:
      - id: md_entry_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of market data entries'
      - id: md_entry_px
        type: decimal_s8_6
        doc: 'Price, carrying eighteen digits of which six are decimal. Implied decimal with scale 1e6'
      - id: md_entry_size
        type: decimal_s8_2
        doc: 'Quantity. Implied decimal with scale 1e2'
  snapshot_data_of_after_hour_trading_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: num_trade_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: trade_md_entries
        type: trade_md_entries
        repeat: expr
        repeat-expr: num_trade_md_entries
        doc: 'Market data entries carrying a price and a quantity only'
  snapshot_data_of_eligible_hk_stocks_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: num_hk_stocks_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: hk_stocks_md_entries
        type: hk_stocks_md_entries
        repeat: expr
        repeat-expr: num_hk_stocks_md_entries
        doc: 'Market data entries carrying a price, a quantity and a book level'
      - id: num_complex_event_times
        type: u4
        doc: 'Number of cooling-off periods of VCM. 1 means it is in the cooling-off period of VCM, followed by the starting and ending time of the period'
      - id: complex_event_times
        type: complex_event_times
        repeat: expr
        repeat-expr: num_complex_event_times
        doc: 'The starting and ending time of each cooling-off period of VCM'
  hk_stocks_md_entries:
    seq:
      - id: md_entry_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of market data entries'
      - id: md_entry_px
        type: decimal_s8_6
        doc: 'Price, carrying eighteen digits of which six are decimal. Implied decimal with scale 1e6'
      - id: md_entry_size
        type: decimal_s8_2
        doc: 'Quantity. Implied decimal with scale 1e2'
      - id: md_price_level
        type: u2
        doc: 'Level of a bid or offer in the order book'
  complex_event_times:
    seq:
      - id: complex_event_start_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Starting time of the cooling-off period'
      - id: complex_event_end_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Ending time of the cooling-off period'
  index_snapshot_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: num_index_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: index_md_entries
        type: index_md_entries
        repeat: expr
        repeat-expr: num_index_md_entries
        doc: 'Market data entries carrying a price only'
  index_md_entries:
    seq:
      - id: md_entry_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of market data entries'
      - id: md_entry_px
        type: decimal_s8_6
        doc: 'Price, carrying eighteen digits of which six are decimal. Implied decimal with scale 1e6'
  statistic_indicator_snapshot_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: stock_num
        type: u4
        doc: 'Number of stocks'
  real_time_reference_net_value_of_funds_snapshot_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Originated time of data'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. The No.0 digit carries the trading phase, S=start before the market opened, O=Opening call auction, T=Continuous bidding, B=Closed, C=Closing call auction, E=Closed market, H=Temporary trading halts, A=After-hours Dealing, V=Volatility interruption. The No.1 digit carries the sub phase, 0=normal status, 1=All day suspension'
      - id: prev_close_px
        type: decimal_s8_4
        doc: 'Previous close price. Implied decimal with scale 1e4'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_2
        doc: 'Total volume of trades. Implied decimal with scale 1e2'
      - id: total_value_trade
        type: decimal_s8_4
        doc: 'Total value of trades. Implied decimal with scale 1e4'
      - id: num_index_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: index_md_entries
        type: index_md_entries
        repeat: expr
        repeat-expr: num_index_md_entries
        doc: 'Market data entries carrying a price only'
  order_tick_data_in_call_auction_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: price
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: order_qty
        type: decimal_s8_2
        doc: 'Quantity of orders. Implied decimal with scale 1e2'
      - id: side
        type: u1
        enum: side
        doc: 'Side of buy or sell'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of order'
  order_tick_data_of_negotiable_trade_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: price
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: order_qty
        type: decimal_s8_2
        doc: 'Quantity of orders. Implied decimal with scale 1e2'
      - id: side
        type: u1
        enum: side
        doc: 'Side of buy or sell'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: confirm_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Confirmed ID of a quote. When ConfirmID is null this is an indication of interest, otherwise a quote'
      - id: contactor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contact person, may include Chinese characters'
      - id: contact_info
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contact information, may include Chinese characters'
  order_tick_data_of_security_lending_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: price
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: order_qty
        type: decimal_s8_2
        doc: 'Quantity of orders. Implied decimal with scale 1e2'
      - id: side
        type: u1
        enum: side
        doc: 'Side of buy or sell'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: expiration_days
        type: u2
        doc: 'Term, in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Type of term'
  order_tick_data_of_spot_bond_trading_matching_deal_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: price
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: order_qty
        type: decimal_s8_2
        doc: 'Quantity of orders. Implied decimal with scale 1e2'
      - id: side
        type: u1
        enum: side
        doc: 'Side of buy or sell'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of order'
  order_tick_data_of_spot_bond_trading_quotation_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: price
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: order_qty
        type: decimal_s8_2
        doc: 'Quantity of orders. Implied decimal with scale 1e2'
      - id: side
        type: u1
        enum: side
        doc: 'Side of buy or sell'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: quote_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Quote message ID, applicable to click deal market data only'
      - id: member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transaction member''s ID'
      - id: investor_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor type'
      - id: investor_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor ID'
      - id: investor_name
        type: str
        size: 120
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor name'
      - id: trader_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader code'
      - id: settl_period
        type: u1
        doc: 'Settlement period'
      - id: settl_type
        type: u2
        enum: settl_type
        doc: 'Settlement type'
      - id: memo
        type: str
        size: 160
        encoding: ASCII
        pad-right: 0x20
        doc: 'Memo'
      - id: min_qty
        type: decimal_s8_2
        doc: 'Minimum number of transactions, applicable to Click Deal market data. Implied decimal with scale 1e2'
  order_tick_data_of_bid_quotation_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: price
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: order_qty
        type: decimal_s8_2
        doc: 'Quantity of orders. Implied decimal with scale 1e2'
      - id: side
        type: u1
        enum: side
        doc: 'Side of buy or sell'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transaction member''s ID'
      - id: investor_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor type'
      - id: investor_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor ID'
      - id: investor_name
        type: str
        size: 120
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor name'
      - id: trader_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader code'
      - id: settl_period
        type: u1
        doc: 'Settlement period'
      - id: settl_type
        type: u2
        enum: settl_type
        doc: 'Settlement type'
      - id: memo
        type: str
        size: 160
        encoding: ASCII
        pad-right: 0x20
        doc: 'Memo'
      - id: secondary_order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid session ID'
      - id: bid_trans_type
        type: u2
        enum: bid_trans_type
        doc: 'Bid transaction type'
      - id: bid_exec_inst_type
        type: u2
        enum: bid_exec_inst_type
        doc: 'Bid transaction method'
      - id: low_limit_price
        type: decimal_s8_4
        doc: 'Low limit price. Implied decimal with scale 1e4'
      - id: high_limit_price
        type: decimal_s8_4
        doc: 'High limit price, 0 means no high limit price. Implied decimal with scale 1e4'
      - id: min_qty
        type: decimal_s8_2
        doc: 'Minimum number of transactions, applicable to Click Deal market data. Implied decimal with scale 1e2'
      - id: trade_date
        type: yyyymmdd_date
        doc: 'Trade date'
  transaction_tick_data_in_call_auction_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Index of buy order, starting from 1, 0 stands for no related orders'
      - id: offer_appl_seq_num
        type: s8
        doc: 'Index of sell order, starting from 1, 0 stands for no related orders'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: last_px
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: last_qty
        type: decimal_s8_2
        doc: 'Order volume. Implied decimal with scale 1e2'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of Execution'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
  transaction_tick_data_of_negotiable_trade_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Index of buy order, starting from 1, 0 stands for no related orders'
      - id: offer_appl_seq_num
        type: s8
        doc: 'Index of sell order, starting from 1, 0 stands for no related orders'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: last_px
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: last_qty
        type: decimal_s8_2
        doc: 'Order volume. Implied decimal with scale 1e2'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of Execution'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
  transaction_tick_data_of_security_lending_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Index of buy order, starting from 1, 0 stands for no related orders'
      - id: offer_appl_seq_num
        type: s8
        doc: 'Index of sell order, starting from 1, 0 stands for no related orders'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: last_px
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: last_qty
        type: decimal_s8_2
        doc: 'Order volume. Implied decimal with scale 1e2'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of Execution'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
  transaction_tick_data_of_bond_general_pledged_repo_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Index of buy order, starting from 1, 0 stands for no related orders'
      - id: offer_appl_seq_num
        type: s8
        doc: 'Index of sell order, starting from 1, 0 stands for no related orders'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: last_px
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: last_qty
        type: decimal_s8_2
        doc: 'Order volume. Implied decimal with scale 1e2'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of Execution'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
  transaction_tick_data_of_spot_bond_trading_quotation_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Index of buy order, starting from 1, 0 stands for no related orders'
      - id: offer_appl_seq_num
        type: s8
        doc: 'Index of sell order, starting from 1, 0 stands for no related orders'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: last_px
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: last_qty
        type: decimal_s8_2
        doc: 'Order volume. Implied decimal with scale 1e2'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of Execution'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: settl_period
        type: u1
        doc: 'Settlement period'
      - id: settl_type
        type: u2
        enum: settl_type
        doc: 'Settlement type'
  transaction_tick_data_of_bid_quotation_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, starting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category of market data'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Index of buy order, starting from 1, 0 stands for no related orders'
      - id: offer_appl_seq_num
        type: s8
        doc: 'Index of sell order, starting from 1, 0 stands for no related orders'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Source of security code'
      - id: last_px
        type: decimal_s8_4
        doc: 'Order price. Implied decimal with scale 1e4'
      - id: last_qty
        type: decimal_s8_2
        doc: 'Order volume. Implied decimal with scale 1e2'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Type of Execution'
      - id: transac_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of order'
      - id: settl_period
        type: u1
        doc: 'Settlement period'
      - id: settl_type
        type: u2
        enum: settl_type
        doc: 'Settlement type'
      - id: secondary_order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid session ID'
      - id: bid_exec_inst_type
        type: u2
        enum: bid_exec_inst_type
        doc: 'Bid transaction method'
      - id: margin_price
        type: decimal_s8_4
        doc: 'Marginal price. Reveals the marginal price of a bidding transaction won by multiple entities at a single price or at multiple prices; meaningless for other bidding transaction methods, fixed fill -999999999.9999. Implied decimal with scale 1e4'
  packet_trailer_struct:
    seq:
      - id: checksum
        type: u4
        doc: 'Adler32 checksum calculated from the start of the packet header to the end of the packet body'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_2:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100.0
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0
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
  poss_dup_flag:
    0:
      id: 'impossible_duplicate_packet'
      doc: 'Seq Num is at or above the expected sequence number'
    1:
      id: 'possible_duplicate_packet'
      doc: 'Possible duplicate data; Seq Num may be below the expected sequence number and already received data can be discarded'
  packet_type:
    0:
      id: 'management_packet'
      doc: 'The packet carries a management message'
    1:
      id: 'application_packet'
      doc: 'The packet carries application messages'
  resend_by_seq_num:
    0:
      id: 'not_support'
      doc: 'The first packet the sender starts or restarts is numbered from 1'
    1:
      id: 'support'
      doc: 'The sender uses the sequence number of the first message in the packet as the sequence number of the packet'
  compress:
    0:
      id: 'no_compression'
      doc: 'The packet body is transmitted uncompressed'
    1:
      id: 'zlib_compression'
      doc: 'The packet body is zlib compressed'
    2:
      id: 'reserved_2'
      doc: 'Reserved'
    3:
      id: 'reserved_3'
      doc: 'Reserved'
  encryption:
    0:
      id: 'no_encryption'
      doc: 'The packet body is transmitted unencrypted'
    1:
      id: 'user_defined_encryption'
      doc: 'The packet body is encrypted by a user defined mechanism'
    2:
      id: 'reserved_2'
      doc: 'Reserved'
    3:
      id: 'reserved_3'
      doc: 'Reserved'
  msg_header:
    0:
      id: 'absence_of_leader_length'
      doc: 'The Message Lengths table is not present'
    1:
      id: 'existence_of_leader_length'
      doc: 'The Message Lengths table precedes the messages'
  msg_type:
    390095:
      id: 'channel_heartbeat_message'
      doc: 'Sent on a market data channel every 3 seconds, carrying the sequence number of the last market data message on the channel.'
    390094:
      id: 'retransmitting_message'
      doc: 'Vendor Supplied System sends a re-transmission message to Market Data GateWay, which returns the re-transmission data needed followed by a re-transmission message indicating completion, or the failure reason if it fails. Market Data GateWay handles multiple requests in the order in which they arrive, so this message type is transmitted by both sides; ResendStatus and RejectText are only effective on the gateway reply.'
    390093:
      id: 'client_user_information_reporting_message'
      doc: 'Vendor Supplied System reports the number of client users connected to it at the current time to the Market Data GateWay front-end processor at regular intervals. Only the Vendor Supplied System of a vendor sends this message.'
    390090:
      id: 'statistics_of_snapshot_data_channel_message'
      doc: 'Each snapshot channel sends the statistic message of the snapshot channel every 15 seconds.'
    8:
      id: 'business_reject_message'
      doc: 'Rejects an application layer message that satisfies the session layer rules but does not satisfy the rules of the business layer. It reports on an incorrect re-transmitted message or client user information reporting message declared by the user.'
    390019:
      id: 'real_time_market_status_message'
      doc: 'Released every 3 seconds, carrying the trading session state of a market and, for stock connect, the daily quota balance.'
    390013:
      id: 'real_time_status_of_security_message'
      doc: 'Released every 15 seconds, carrying the security status and the state of each business switch of one security.'
    390012:
      id: 'announcements_message'
      doc: 'Carries an announcement file. An empty NewsID indicates an announcement summary, an aggregate list of the current announcement files in text format carried in RawData as repeated BulletNum, ID, NAME, SIZE and TIME lines; under the multicast distribution protocol the summary carries no content and RawDataLength is fixed to 0.'
    300111:
      id: 'snapshot_data_of_cash_auction_message'
      doc: 'Snapshot of the cash auction, carrying market data categories 010 for equities, funds and bonds and 040 for option auction. The call auction discloses the virtual matched price and quantity in the buy 1 and sell 1 levels, with the bid or offer left quantity at that price in level 2.'
    300211:
      id: 'snapshot_data_of_spot_bond_trading_message'
      doc: 'Snapshot carrying market data categories 020 bond general pledged repo matching deal, 030 bond distribution and 410 spot bond trading. Market data entries 0 and 1 are used only to reveal the order of matching transactions.'
    300611:
      id: 'snapshot_data_of_after_hour_trading_block_trade_message'
      doc: 'Snapshot carrying market data categories 060 after-hour-trading block trade with close price and 061 after-hour-trading block trade with volume weighted average price.'
    303711:
      id: 'snapshot_data_of_after_hour_trading_message'
      doc: 'Snapshot carrying market data category 370, snapshot of after-hour-trading.'
    306311:
      id: 'snapshot_data_of_eligible_hk_stocks_message'
      doc: 'Snapshot carrying market data category 630, real time market data of eligible Hong Kong stocks, including the cooling-off periods of the Volatility Control Mechanism.'
    309011:
      id: 'index_snapshot_message'
      doc: 'Snapshot carrying market data categories 900 index and 920 CNI Indices snapshot data.'
    309111:
      id: 'statistic_indicator_snapshot_message'
      doc: 'Snapshot carrying market data category 910, statistic indicators.'
    309211:
      id: 'real_time_reference_net_value_of_funds_snapshot_message'
      doc: 'Snapshot carrying market data category 930, real time reference net value of funds. PrevClosePx, NumTrades, TotalVolumeTrade and TotalValueTrade are fixed to 0 for this message.'
    300192:
      id: 'order_tick_data_in_call_auction_message'
      doc: 'Order tick carrying market data categories 011 for equities, funds and bonds in the call auction of the spot market, 021 pledge-style repo and 041 call auction in options.'
    300592:
      id: 'order_tick_data_of_negotiable_trade_message'
      doc: 'Order tick carrying market data categories 051 indication of interest of negotiable trade and 052 quote of negotiable trade.'
    300792:
      id: 'order_tick_data_of_security_lending_message'
      doc: 'Order tick carrying market data category 071, security lending.'
    300292:
      id: 'order_tick_data_of_spot_bond_trading_matching_deal_message'
      doc: 'Order tick carrying market data categories 021 bond general pledged repo matching deal and 411 spot bond trading matching deal.'
    300392:
      id: 'order_tick_data_of_spot_bond_trading_quotation_message'
      doc: 'Order tick carrying market data categories 415 spot bond trading declaration of intent and 417 spot bond trading large amount matching deal, for spot bond trading other than bid.'
    300492:
      id: 'order_tick_data_of_bid_quotation_message'
      doc: 'Order tick carrying market data category 416, spot bond trading bidding deal, covering the bid order and bid reservation.'
    300191:
      id: 'transaction_tick_data_in_call_auction_message'
      doc: 'Transaction tick carrying market data categories 011 for equities, funds and bonds in the call auction of the spot market, 021 pledge-style repo and 041 call auction in options. The sequence number of tick order and tick transaction data in the same channel is consecutive.'
    300591:
      id: 'transaction_tick_data_of_negotiable_trade_message'
      doc: 'Transaction tick carrying market data categories 051 indication of interest of negotiable trade and 052 quote of negotiable trade.'
    300791:
      id: 'transaction_tick_data_of_security_lending_message'
      doc: 'Transaction tick carrying market data category 071, security lending.'
    300291:
      id: 'transaction_tick_data_of_bond_general_pledged_repo_message'
      doc: 'Transaction tick carrying market data categories 021 bond general pledged repo matching deal and 411 spot bond trading matching deal.'
    300391:
      id: 'transaction_tick_data_of_spot_bond_trading_quotation_message'
      doc: 'Transaction tick carrying market data categories 412 spot bond trading negotiated deal, 413 click deal, 414 inquiry deal and 417 large amount matching deal, for spot bond trading other than bid.'
    300491:
      id: 'transaction_tick_data_of_bid_quotation_message'
      doc: 'Transaction tick carrying market data category 416, spot bond trading bidding deal.'
  resend_type:
    1:
      id: 'tick_data'
      doc: 'Tick Data'
    2:
      id: 'announcement_message'
      doc: 'Announcement Message'
  resend_status:
    1:
      id: 'finished'
      doc: 'Finished'
    2:
      id: 'partly_finished'
      doc: 'Part Of Requested Data Has Not Been Returned Yet'
    3:
      id: 'no_authority_rights'
      doc: 'No Authority Rights'
    4:
      id: 'data_is_not_applicable'
      doc: 'Data Is Not Applicable'
  amounts_status:
    0x31:
      id: 'quota_unavailable'
      doc: 'Pos Amt Is Fixed At 0.0000'
    0x32:
      id: 'quota_available'
      doc: 'The Quota Balance Is Less Than 30% Of The Initial Limit For The Day And Pos Amt Carries The Actual Remaining Credit Limit'
    0x33:
      id: 'quota_adequate'
      doc: 'The Quota Balance Is At Or Above 30% Of The Initial Limit For The Day And Pos Amt Is Fixed At 0.0000'
  security_switch_type:
    1:
      id: 'margin_buy'
      doc: 'Applicable To The Underlying Security Of Margin Buy'
    2:
      id: 'short_sell'
      doc: 'Applicable To The Underlying Security Of Short Selling'
    3:
      id: 'fund_subscription'
      doc: 'Applicable To Etf Lof And Other Openended Funds Cash Subscription For Gold Et Fs'
    4:
      id: 'fund_redemption'
      doc: 'Applicable To Etf Lof And Other Openended Funds Cash Redemption For Gold Et Fs'
    5:
      id: 'issue_subscription'
      doc: 'Applicable To Subscription Code For Online Issuance And To Infrastructure Funds In The Non Targeted Additional Offering Period'
    6:
      id: 'conversion'
      doc: 'Applicable To Convertible Bonds And Preferred Stocks In Conversion Resale And To Exchangeable Private Bonds And Exchangeable Corporate Bonds In Exchange Period'
    7:
      id: 'resale'
      doc: 'Applicable To Enterprise Bonds Corporate Bonds Convertible Bonds Private Bonds Exchangeable Private Bonds Subordinated Debts Abs Preferred Stocks Security Firm Shortterm Bonds And Exchangeable Corporate Bonds In Conversion Resale'
    8:
      id: 'warrant_exercise'
      doc: 'Applicable To Warrant Or Options In Exercise Period'
    10:
      id: 'buy_open'
      doc: 'Applicable To Derivatives Like Options'
    11:
      id: 'sell_open'
      doc: 'Applicable To Derivatives Like Options'
    12:
      id: 'subscription_of_gold_etf_in_physical'
      doc: 'Applicable To Gold Etf'
    13:
      id: 'redemption_of_gold_etf_in_physical'
      doc: 'Applicable To Gold Etf'
    14:
      id: 'pre_accepted_tender_offer'
      doc: 'Applicable To Equities In Tender Offer'
    15:
      id: 'cancellation_of_tender_offer'
      doc: 'Applicable To Equities In Tender Offer'
    20:
      id: 'pledge'
      doc: 'Applicable To Pledgestyle Repo Securities'
    21:
      id: 'release_of_pledge'
      doc: 'Applicable To Pledgestyle Repo Securities'
    22:
      id: 'voting_rights'
      doc: 'Applicable To Preferred Stocks'
    23:
      id: 'equity_pledge_style_repo'
      doc: 'Applicable To Securities Allowed For Equity Pledgestyle Repo Business'
    26:
      id: 'covered_openning'
      doc: 'Applicable To Derivatives Like Options'
    27:
      id: 'market_maker_quotation'
      doc: 'Applicable To Securities Supported For Marketmaker Quotation Like Options'
    28:
      id: 'round_lot_buy_of_eligible_hk_stocks'
      doc: 'Applicable To Southbound Eligible Stocks Under Hk Stock Connect'
    29:
      id: 'round_lot_sell_of_eligible_hk_stocks'
      doc: 'Applicable To Southbound Eligible Stocks Under Hk Stock Connect'
    30:
      id: 'odd_lot_buy_of_eligible_hk_stocks'
      doc: 'Applicable To Southbound Eligible Stocks Under Hk Stock Connect'
    31:
      id: 'odd_lot_sell_of_eligible_hk_stocks'
      doc: 'Applicable To Southbound Eligible Stocks Under Hk Stock Connect'
    32:
      id: 'options_from_ordinary_to_covered'
      doc: 'Applicable To Options Transferring From Ordinary To Covered'
    33:
      id: 'options_from_covered_to_ordinary'
      doc: 'Applicable To Options Transferring From Covered To Ordinary'
    34:
      id: 'resale_cancellation'
      doc: 'Applicable To Enterprise Bonds Corporate Bonds Private Bonds Exchangeable Private Bonds Subordinated Debts Abs Security Firm Shortterm Bonds And Exchangeable Corporate Bonds In Resale Cancellation Period'
    35:
      id: 'securities_lending'
      doc: 'Applicable To Contractual Order Or Noncontractual Order Of Securities Lending Or Borrowing'
    36:
      id: 'bond_put_option_and_resale'
      doc: 'Applicable To Bonds And Assetbacked Securities In The Put Option And Resale Period'
  trading_type:
    1:
      id: 'matching_deal'
      doc: 'Matching Deal'
    2:
      id: 'negotiated_deal'
      doc: 'Negotiated Deal'
    3:
      id: 'click_deal'
      doc: 'Click Deal'
    4:
      id: 'inquiry_deal'
      doc: 'Inquiry Deal'
    5:
      id: 'bidding_deal'
      doc: 'Bidding Deal'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x47:
      id: 'borrow'
      doc: 'Borrow'
    0x46:
      id: 'lend'
      doc: 'Lend'
  ord_type:
    0x31:
      id: 'market_price'
      doc: 'Market Price'
    0x32:
      id: 'limit_price'
      doc: 'Limit Price'
    0x55:
      id: 'best_price_of_this_party'
      doc: 'Best Price Of This Party'
  expiration_type:
    1:
      id: 'fixed_term'
      doc: 'Fixed Term'
  settl_type:
    103:
      id: 'multilateral_netting'
      doc: 'Multilateral Netting'
    104:
      id: 'gross_settlement'
      doc: 'Gross Settlement'
  bid_trans_type:
    1:
      id: 'bid_reservation_declaration'
      doc: 'Bid Reservation Declaration'
    2:
      id: 'bid_initiation_declaration'
      doc: 'Bid Initiation Declaration'
    3:
      id: 'bid_price_declaration'
      doc: 'Bid Price Declaration'
  bid_exec_inst_type:
    1:
      id: 'single_subject_winning_the_bid'
      doc: 'Single Subject Winning The Bid'
    2:
      id: 'multiple_subjects_single_price_winning_the_bid'
      doc: 'Multiple Subjects Single Price Winning The Bid'
    3:
      id: 'multiple_subjects_multiple_price_winning_the_bid'
      doc: 'Multiple Subjects Multiple Price Winning The Bid'
  exec_type:
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x46:
      id: 'traded'
      doc: 'Traded'

