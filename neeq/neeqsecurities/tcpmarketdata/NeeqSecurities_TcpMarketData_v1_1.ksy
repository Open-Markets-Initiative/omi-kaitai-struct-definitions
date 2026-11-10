# ---------------------------------------------------------------------
# Kaitai struct definition for: Neeq NeeqSecurities TcpMarketData BjseBinary v1.1
#
# Protocol:
#   Organization: National Equities Exchange and Quotations
#   Protocol: Neeq Tcp Market Data
#   Encoding: Bjse Binary Market Data Feed
#   Version: 1.1
#   Date: 12/31/2025
#   Specification: 20251231194517_82kitaljxu.pdf
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
  id: neeq_neeqsecurities_tcpmarketdata_bjsebinary_v1_1
  title: Neeq NeeqSecurities TcpMarketData BjseBinary v1.1
  license: MIT-0
  endian: be

doc: 'National Equities Exchange and Quotations National Equities Exchange and Quotations Neeq Tcp Market Data BjseBinary v1.1'
doc-ref: https://www.neeq.com.cn/rule/Tech_area.html

seq:
  - id: message_header
    type: message_header_struct
    doc: 'Bjse Bjqg Message Header, defining the type and body length of a message, transmitted without encryption'
  - id: payload
    size: message_header.body_length
    type:
      switch-on: message_header.msg_type
      cases:
        'msg_type::logon_message': logon_message
        'msg_type::logout_message': logout_message
        'msg_type::channel_heartbeat_message': channel_heartbeat_message
        'msg_type::retransmission_message': retransmission_message
        'msg_type::snapshot_channel_statistics_message': snapshot_channel_statistics_message
        'msg_type::business_reject_message': business_reject_message
        'msg_type::security_real_time_status_message': security_real_time_status_message
        'msg_type::announcement_message': announcement_message
        'msg_type::bond_spot_trading_snapshot_message': bond_spot_trading_snapshot_message
        'msg_type::auction_trading_snapshot_message': auction_trading_snapshot_message
        'msg_type::index_snapshot_message': index_snapshot_message
        'msg_type::bond_spot_matching_large_order_tick_message': bond_spot_matching_large_order_tick_message
        'msg_type::agreement_trading_order_tick_message': agreement_trading_order_tick_message
        'msg_type::securities_lending_order_tick_message': securities_lending_order_tick_message
        'msg_type::bond_spot_matching_large_trade_tick_message': bond_spot_matching_large_trade_tick_message
        'msg_type::bond_spot_negotiated_trade_tick_message': bond_spot_negotiated_trade_tick_message
        'msg_type::securities_lending_trade_tick_message': securities_lending_trade_tick_message
  - id: message_tail
    type: message_tail_struct
    doc: 'Bjse Bjqg Message Tail, defining the checksum of a message, transmitted without encryption'

types:
  message_header_struct:
    seq:
      - id: msg_type
        type: u4
        enum: msg_type
        doc: 'Type of a message'
      - id: body_length
        type: u4
        doc: 'The length of a message body'
  logon_message:
    seq:
      - id: sender_comp_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sender code'
      - id: target_comp_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Receiver code'
      - id: heart_bt_int
        type: s4
        doc: 'Heartbeat interval in seconds, provided to the gateway by the Vendor Supplied System at logon'
      - id: password
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password'
      - id: default_appl_ver_id
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Binary protocol version, in the form n.xy; the communication version of this specification is 1.00'
  logout_message:
    seq:
      - id: session_status
        type: s4
        enum: session_status
        doc: 'Session status at logout'
      - id: text
        type: str
        size: 200
        encoding: ASCII
        pad-right: 0x20
        doc: 'Further explanation of the logout reason, up to 200 bytes that may include Chinese characters'
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
        enum: end_of_channel
        doc: 'End of channel flag'
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time the channel heartbeat was generated'
  retransmission_message:
    seq:
      - id: resend_type
        type: u1
        enum: resend_type
        doc: 'Retransmission type'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_beg_seq_num
        type: s8
        doc: 'Starting sequence number, effective when ResendType = 1'
      - id: appl_end_seq_num
        type: s8
        doc: 'Ending sequence number, effective when ResendType = 1; when 0 the gateway sets it to the highest sequence number of the channel it holds in memory'
      - id: news_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Announcement identifier, effective when ResendType = 2; an empty string requests the announcement summary'
      - id: resend_status
        type: u1
        enum: resend_status
        doc: 'Retransmission status, effective only on the gateway reply'
      - id: reject_text
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Effective only on the gateway reply; when the request is rejected, the error code is returned here'
  snapshot_channel_statistics_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time the channel heartbeat was generated'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: num_md_stream_i_ds
        type: u4
        doc: 'Number of market data categories'
      - id: md_stream_i_ds
        type: md_stream_i_ds
        repeat: expr
        repeat-expr: num_md_stream_i_ds
        doc: 'One entry per market data category carried on the channel'
  md_stream_i_ds:
    seq:
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: stock_num
        type: u4
        doc: 'Number of securities'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. Only the first two characters are used: character 0 is the phase, S = start before the open, O = opening call auction, T = continuous trading, E = closed, H = temporary halt, V = volatility interruption; character 1 is 0 = cannot trade normally (before the open, suspended all day or after the close) or 1 = can trade normally'
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
        doc: 'Business layer ID of the rejected message'
      - id: business_reject_reason
        type: u2
        doc: 'Reject reason'
      - id: business_reject_text
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reject reason text, up to 50 bytes that may include Chinese characters'
  security_real_time_status_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time the channel heartbeat was generated'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: security_symbol
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security short name'
      - id: num_switch_field
        type: u4
        doc: 'Number of switches'
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
        doc: 'Switch type'
      - id: security_switch_status
        type: u2
        enum: security_switch_status
        doc: 'Switch status'
  announcement_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time the channel heartbeat was generated'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: news_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Announcement identifier, effective when ResendType = 2; an empty string requests the announcement summary'
      - id: headline
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Announcement title, up to 128 bytes that may include Chinese characters'
      - id: news_type
        type: u1
        enum: news_type
        doc: 'Announcement type'
      - id: raw_data_format
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Binary data format, such as TXT, PDF or DOC'
      - id: len_raw_data
        type: u4
        doc: 'Binary data length'
      - id: raw_data
        size: len_raw_data
        doc: 'Binary data, its length given by the leading RawDataLength'
  bond_spot_trading_snapshot_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time the channel heartbeat was generated'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. Only the first two characters are used: character 0 is the phase, S = start before the open, O = opening call auction, T = continuous trading, E = closed, H = temporary halt, V = volatility interruption; character 1 is 0 = cannot trade normally (before the open, suspended all day or after the close) or 1 = can trade normally'
      - id: pre_close_px
        type: decimal_s8_5
        doc: 'Previous close price. Implied decimal with scale 1e-5'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_3
        doc: 'Total trade volume. Implied decimal with scale 1e-3'
      - id: total_value_trade
        type: decimal_s8_3
        doc: 'Total trade value. Implied decimal with scale 1e-3'
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
        doc: 'Number of trading phase subdivisions, reserved'
      - id: sub_trading_phase_codes
        type: sub_trading_phase_codes
        repeat: expr
        repeat-expr: num_sub_trading_phase_codes
        doc: 'One entry per trading phase subdivision, giving its code and trading type'
      - id: auction_volume_trade
        type: decimal_s8_3
        doc: 'Matching trade volume. Implied decimal with scale 1e-3'
      - id: auction_value_trade
        type: decimal_s8_3
        doc: 'Matching trade value. Implied decimal with scale 1e-3'
      - id: trade_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of the most recent trade'
  md_entries:
    seq:
      - id: md_entry_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data entry type'
      - id: md_entry_px
        type: decimal_s8_5
        doc: 'Price, N18(5). Implied decimal with scale 1e-5'
      - id: md_entry_size
        type: decimal_s8_3
        doc: 'Quantity. In a spot bond trading snapshot the last price entry (MDEntryType 2) uses it for the trading method that produced the price: 0.001 = matching, 0.002 = click, 0.003 = negotiated, 0.004 = inquiry, 0.005 = bidding. Implied decimal with scale 1e-3'
      - id: md_price_level
        type: u2
        doc: 'Bid or offer book level'
      - id: number_of_orders
        type: s8
        doc: 'Total number of orders at the price level; 0 means not disclosed'
      - id: num_orders
        type: u4
        doc: 'Number of orders disclosed at the price level; 0 means not disclosed'
      - id: orders
        type: orders
        repeat: expr
        repeat-expr: num_orders
        doc: 'The individual order quantities disclosed at this price level'
  orders:
    seq:
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
  sub_trading_phase_codes:
    seq:
      - id: sub_trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the trading type'
      - id: trading_type
        type: u1
        enum: trading_type
        doc: 'Trading type'
  auction_trading_snapshot_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time the channel heartbeat was generated'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. Only the first two characters are used: character 0 is the phase, S = start before the open, O = opening call auction, T = continuous trading, E = closed, H = temporary halt, V = volatility interruption; character 1 is 0 = cannot trade normally (before the open, suspended all day or after the close) or 1 = can trade normally'
      - id: pre_close_px
        type: decimal_s8_5
        doc: 'Previous close price. Implied decimal with scale 1e-5'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_3
        doc: 'Total trade volume. Implied decimal with scale 1e-3'
      - id: total_value_trade
        type: decimal_s8_3
        doc: 'Total trade value. Implied decimal with scale 1e-3'
      - id: num_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'Market data entries disclosing the order book, with the orders at each price level nested inside'
  index_snapshot_message:
    seq:
      - id: orig_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time the channel heartbeat was generated'
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: trading_phase_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading phase code of the product. Only the first two characters are used: character 0 is the phase, S = start before the open, O = opening call auction, T = continuous trading, E = closed, H = temporary halt, V = volatility interruption; character 1 is 0 = cannot trade normally (before the open, suspended all day or after the close) or 1 = can trade normally'
      - id: pre_close_px
        type: decimal_s8_5
        doc: 'Previous close price. Implied decimal with scale 1e-5'
      - id: num_trades
        type: s8
        doc: 'Number of trades'
      - id: total_volume_trade
        type: decimal_s8_3
        doc: 'Total trade volume. Implied decimal with scale 1e-3'
      - id: total_value_trade
        type: decimal_s8_3
        doc: 'Total trade value. Implied decimal with scale 1e-3'
      - id: num_index_md_entries
        type: u4
        doc: 'Number of market data entries'
      - id: index_md_entries
        type: index_md_entries
        repeat: expr
        repeat-expr: num_index_md_entries
        doc: 'Market data entries giving the index points'
  index_md_entries:
    seq:
      - id: md_entry_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data entry type'
      - id: md_entry_px
        type: decimal_s8_5
        doc: 'Price, N18(5). Implied decimal with scale 1e-5'
  bond_spot_matching_large_order_tick_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, counting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: price
        type: decimal_s8_5
        doc: 'Order price. Implied decimal with scale 1e-5'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Order time'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
  agreement_trading_order_tick_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, counting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: price
        type: decimal_s8_5
        doc: 'Order price. Implied decimal with scale 1e-5'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Order time'
      - id: confirm_id
        type: u4
        doc: 'Trade agreement number'
  securities_lending_order_tick_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, counting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: price
        type: decimal_s8_5
        doc: 'Order price. Implied decimal with scale 1e-5'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Order time'
      - id: expiration_days
        type: u2
        doc: 'Term in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Term type'
  bond_spot_matching_large_trade_tick_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, counting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Buy order index, counting from 1; 0 means no corresponding order'
      - id: ask_appl_seq_num
        type: s8
        doc: 'Sell order index, counting from 1; 0 means no corresponding order'
      - id: trade_price
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: trade_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trade_money
        type: decimal_s8_3
        doc: 'Trade value in yuan. Implied decimal with scale 1e-3'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution type'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Order time'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
  bond_spot_negotiated_trade_tick_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, counting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Buy order index, counting from 1; 0 means no corresponding order'
      - id: ask_appl_seq_num
        type: s8
        doc: 'Sell order index, counting from 1; 0 means no corresponding order'
      - id: trade_price
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: trade_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trade_money
        type: decimal_s8_3
        doc: 'Trade value in yuan. Implied decimal with scale 1e-3'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution type'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Order time'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
  securities_lending_trade_tick_message:
    seq:
      - id: channel_no
        type: u2
        doc: 'Channel code'
      - id: appl_seq_num
        type: s8
        doc: 'Message sequence number, counting from 1'
      - id: md_stream_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market data category'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, six digits behind two leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, behind one leading space'
      - id: bid_appl_seq_num
        type: s8
        doc: 'Buy order index, counting from 1; 0 means no corresponding order'
      - id: ask_appl_seq_num
        type: s8
        doc: 'Sell order index, counting from 1; 0 means no corresponding order'
      - id: trade_price
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: trade_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trade_money
        type: decimal_s8_3
        doc: 'Trade value in yuan. Implied decimal with scale 1e-3'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution type'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Order time'
  message_tail_struct:
    seq:
      - id: checksum
        type: u4
        doc: 'The checksum of a message, the sum of every byte from the start of the message header through the end of the message body taken modulo 256'
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
  decimal_s8_5:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000.0
  decimal_s8_3:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000.0

enums:
  msg_type:
    1:
      id: 'logon_message'
      doc: 'The first message the Vendor Supplied System sends to the market quotation gateway, which confirms a successful logon with a Logon of its own, so both sides transmit this message type.'
    2:
      id: 'logout_message'
      doc: 'Sent by the gateway to refuse a logon request it does not accept; the Vendor Supplied System may also send it to end the connection, so both sides transmit this message type.'
    3:
      id: 'heartbeat_message'
      doc: 'Sent by either side when it is idle so that the other can check the Tcp connection, so both sides transmit this message type. BodyLength is 0 and the message carries no body.'
    301000:
      id: 'channel_heartbeat_message'
      doc: 'Sent on a market data channel every 3 seconds, carrying the sequence number of the last tick message on the channel.'
    302000:
      id: 'retransmission_message'
      doc: 'Sent by the Vendor Supplied System to request tick data or announcements again; the gateway returns the data and then the same message type to mark the retransmission complete or report why it failed, so both sides transmit this message type.'
    303000:
      id: 'snapshot_channel_statistics_message'
      doc: 'Sent by each snapshot channel every 15 seconds.'
    8:
      id: 'business_reject_message'
      doc: 'Rejects an application message that satisfies the session layer rules but not the business layer rules, mainly an invalid retransmission request.'
    304000:
      id: 'security_real_time_status_message'
      doc: 'Real time status of a security, published every 10 minutes; the switch types are not yet enabled.'
    305000:
      id: 'announcement_message'
      doc: 'Carries an announcement file; an empty NewsID marks the announcement summary, a text list of NewsNo, NewsID, Headline, RawDataLength, OrigTime and NewsType for every announcement issued. Under the multicast distribution protocol with announcement landing enabled, each announcement is sent as a summary that carries no content and has RawDataLength fixed to 0, its content being stored as a file.'
    306001:
      id: 'bond_spot_trading_snapshot_message'
      doc: 'Snapshot of spot bond trading, market data category 010, published every 3 seconds.'
    306002:
      id: 'auction_trading_snapshot_message'
      doc: 'Snapshot of centralized auction trading of stocks, convertible bonds and other cash products, market data category 020, published every 3 seconds; not yet enabled.'
    306003:
      id: 'index_snapshot_message'
      doc: 'Snapshot of Beijing Stock Exchange indices and volume statistics, market data category 030, published every 3 seconds; not yet enabled.'
    307011:
      id: 'bond_spot_matching_large_order_tick_message'
      doc: 'Order tick of large lot matching in spot bond trading, market data category 011, published in real time.'
    307021:
      id: 'agreement_trading_order_tick_message'
      doc: 'Order tick of agreement trading on the trading support platform, market data category 021, published in real time; not yet enabled.'
    307023:
      id: 'securities_lending_order_tick_message'
      doc: 'Order tick of refinancing securities lending, market data category 023, published in real time; not yet enabled.'
    308011:
      id: 'bond_spot_matching_large_trade_tick_message'
      doc: 'Trade tick of large lot matching in spot bond trading, market data category 011, published in real time.'
    308012:
      id: 'bond_spot_negotiated_trade_tick_message'
      doc: 'Trade tick of negotiated trading in spot bond trading, market data category 012, published in real time.'
    308023:
      id: 'securities_lending_trade_tick_message'
      doc: 'Trade tick of refinancing securities lending, market data category 023, published in real time; it has no extension fields and is not yet enabled.'
  session_status:
    0:
      id: 'session_active'
      doc: 'Session Active'
    1:
      id: 'session_password_changed'
      doc: 'Session Password Changed'
    2:
      id: 'session_password_due_to_expire'
      doc: 'Session Password Due To Expire'
    3:
      id: 'new_session_password_does_not_comply_with_policy'
      doc: 'New Session Password Does Not Comply With Policy'
    4:
      id: 'session_logout_complete'
      doc: 'Session Logout Complete'
    5:
      id: 'invalid_username_or_password'
      doc: 'Invalid Username Or Password'
    6:
      id: 'account_locked'
      doc: 'Account Locked'
    7:
      id: 'logons_are_not_allowed_at_this_time'
      doc: 'Logons Are Not Allowed At This Time'
    8:
      id: 'password_expired'
      doc: 'Password Expired'
    9:
      id: 'msg_seq_num_received_too_low'
      doc: 'MsgSeqNum(34) received is too small'
    10:
      id: 'next_expected_msg_seq_num_received_too_high'
      doc: 'NextExpectedMsgSeqNum(789) received is too large'
    101:
      id: 'other'
      doc: 'Other'
    102:
      id: 'invalid_message'
      doc: 'Invalid Message'
  end_of_channel:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  resend_type:
    1:
      id: 'tick_data'
      doc: 'Tick Data'
    2:
      id: 'announcement'
      doc: 'Announcement'
  resend_status:
    1:
      id: 'complete'
      doc: 'Complete'
    2:
      id: 'partially_complete'
      doc: 'Some of the requested data was not returned'
    3:
      id: 'no_permission'
      doc: 'No Permission'
    4:
      id: 'data_unavailable'
      doc: 'Data Unavailable'
  security_switch_type:
    1:
      id: 'margin_buy'
      doc: 'Applicable to securities eligible for margin buying'
    2:
      id: 'short_sell'
      doc: 'Applicable to securities eligible for short selling'
    5:
      id: 'subscription'
      doc: 'Applicable to online issue subscription codes'
    6:
      id: 'conversion'
      doc: 'Applicable to directed issue convertible bonds, delisted company convertible bonds and non-public preferred shares in the conversion period'
    7:
      id: 'put_back'
      doc: 'Applicable to corporate bonds, non-public corporate bonds, directed issue convertible bonds and delisted company convertible bonds in the put back period'
    14:
      id: 'tender_offer_acceptance'
      doc: 'Applicable to stocks in a tender offer period'
    15:
      id: 'tender_offer_withdrawal'
      doc: 'Applicable to stocks in a tender offer period'
    22:
      id: 'voting_right'
      doc: 'Applicable to non-public preferred shares'
    23:
      id: 'stock_pledged_repo'
      doc: 'Applicable to securities eligible for stock pledged repo'
    27:
      id: 'market_maker_quotation'
      doc: 'Applicable to bonds and other securities supporting market maker quotation'
    34:
      id: 'put_back_cancellation'
      doc: 'Applicable to corporate bonds, non-public corporate bonds, directed issue convertible bonds and delisted company convertible bonds in the put back cancellation period'
  security_switch_status:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  news_type:
    1:
      id: 'information_announcement'
      doc: 'Information Announcement'
    2:
      id: 'listed_company_information'
      doc: 'Quoted or listed company information'
    3:
      id: 'urgent_announcement'
      doc: 'Urgent Announcement'
    4:
      id: 'securities_company_information'
      doc: 'Securities Company Information'
    5:
      id: 'other_announcement'
      doc: 'Other Announcement'
    6:
      id: 'stock_temporary_halt_announcement'
      doc: 'Stock Temporary Halt Announcement'
    7:
      id: 'bond_temporary_halt_announcement'
      doc: 'Bond Temporary Halt Announcement'
  trading_type:
    1:
      id: 'matching_trade'
      doc: 'Matching Trade'
    2:
      id: 'click_trade'
      doc: 'Click Trade'
    3:
      id: 'negotiated_trade'
      doc: 'Negotiated Trade'
    4:
      id: 'inquiry_trade'
      doc: 'Inquiry Trade'
    5:
      id: 'bidding_trade'
      doc: 'Bidding Trade'
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
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x55:
      id: 'best_own_side'
      doc: 'Best Own Side'
  settl_type:
    0x31:
      id: 'gross'
      doc: 'Trade by trade gross settlement'
    0x32:
      id: 'multilateral_net'
      doc: 'Multilateral Net'
  settl_period:
    0x30:
      id: 't_plus_0'
      doc: 'T+0'
    0x31:
      id: 't_plus_1'
      doc: 'T+1'
    0x32:
      id: 't_plus_2'
      doc: 'T+2'
    0x33:
      id: 't_plus_3'
      doc: 'T+3'
  expiration_type:
    1:
      id: 'fixed_term'
      doc: 'Fixed Term'
  exec_type:
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x46:
      id: 'trade'
      doc: 'Trade'

