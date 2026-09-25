# ---------------------------------------------------------------------
# Kaitai struct definition for: NsxAustralia Nets MarketDataFeed Itch v4.2.55
#
# Protocol:
#   Organization: Nation Stock Exchange of Australia
#   Protocol: NSX Market Data Feed
#   Encoding: Itch
#   Version: 4.2.55
#   Date: 4/6/2026
#   Specification: Unknown
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
  id: nsxaustralia_nets_marketdatafeed_itch_v4_2_55_server
  title: NsxAustralia Nets MarketDataFeed Itch v4.2.55
  license: GPL-3.0
  endian: be

doc: 'Nation Stock Exchange of Australia NETS Trading System NSX Market Data Feed Itch v4.2.55'
doc-ref: https://docs.nsx.com.au/ncd/nsx-itch-specification

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::timestamp_message': timestamp_message
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::price_tick_size_message': price_tick_size_message
            'sequenced_message_type::quantity_tick_size_message': quantity_tick_size_message
            'sequenced_message_type::orderbook_directory_message': orderbook_directory_message
            'sequenced_message_type::orderbook_trading_action_message': orderbook_trading_action_message
            'sequenced_message_type::orderbook_attribute_message': orderbook_attribute_message
            'sequenced_message_type::firm_directory_message': firm_directory_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::order_executed_message': order_executed_message
            'sequenced_message_type::order_executed_with_price_message': order_executed_with_price_message
            'sequenced_message_type::broken_trade_message': broken_trade_message
            'sequenced_message_type::order_delete_message': order_delete_message
            'sequenced_message_type::order_replace_message': order_replace_message
            'sequenced_message_type::indicative_price_quantity_message': indicative_price_quantity_message
            'sequenced_message_type::trade_message': trade_message
            'sequenced_message_type::news_message': news_message
            'sequenced_message_type::index_member_directory_message': index_member_directory_message
            'sequenced_message_type::index_value_message': index_value_message
  timestamp_message:
    seq:
      - id: nanosecond
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Epoch. Nanoseconds since Unix epoch'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: group
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Board for which this event applies. Left blank if not at Board level'
      - id: product
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Product for which this event applies. Left blank if not at Product level'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: event_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text identifier for the event'
      - id: event_status
        type: u1
        enum: event_status
        doc: 'Current status of the event'
      - id: scheduled_time
        type: u8
        doc: 'Event trigger time in nanoseconds since Epoch (UTC)'
  price_tick_size_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: tick_size_table_id
        type: u4
        doc: 'Price Tick Size Table identifier, to be looked up from Orderbook Directory [R] messages'
      - id: tick_size
        type: u8
        doc: 'The incremental price step value'
      - id: price_start
        type: u8
        doc: 'Starting Price for this Tick Size'
  quantity_tick_size_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: tick_size_table_id
        type: u4
        doc: 'Price Tick Size Table identifier, to be looked up from Orderbook Directory [R] messages'
      - id: tick_size
        type: u8
        doc: 'The incremental price step value'
      - id: quantity_start
        type: u8
        doc: 'Starting Quantity for this Tick Size'
  orderbook_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code. Left blank if not applicable'
      - id: security_code
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique text identifier for the security'
      - id: security_name
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Descriptive name for the security'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: board
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Board this orderbook trades on'
      - id: product
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the Product for which this event applies. Left blank if not at Product level'
      - id: minimum_quantity
        type: u8
        doc: 'Minimum order quantity. Maximum value indicates non-tradeable'
      - id: quantity_tick_size_table_id
        type: u4
        doc: 'Cross-reference to Quantity Tick Size [M] messages'
      - id: quantity_decimals
        type: u4
        doc: 'Decimals for quantity field decoding. Quantity = Integer / 10^QuantityDecimals'
      - id: price_tick_size_table_id
        type: u4
        doc: 'Cross-reference to Price Tick Size [L] messages'
      - id: price_decimals
        type: u4
        doc: 'Decimals for price field decoding. Price = Integer / 10^PriceDecimals'
      - id: listing
        type: yyyymmddhhmmss_timestamp_nullable
        doc: 'Listing date/time in YYYYMMDDHHMMSS format. Zero indicates none. Nullable, None = 0'
      - id: expiry
        type: yyyymmddhhmmss_timestamp_nullable
        doc: 'Expiry/delist date/time in YYYYMMDDHHMMSS format. Zero indicates none. Nullable, None = 0'
      - id: asset_type
        type: u1
        enum: asset_type
        doc: 'Asset type code. Blank if not applicable'
      - id: settle_date
        type: u4
        doc: 'Settlement date in YYYYMMDD format'
      - id: reference_alpha_12
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: remarks
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security board remarks for conditional markets'
  orderbook_trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Current trading state code for orderbook'
      - id: reason
        type: u1
        enum: reason
        doc: 'Trading state reason. Blank if not applicable'
  orderbook_attribute_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: attribute_value
        type: s8
        doc: 'The value that has been set, according to the AttributeType. Decode using the Price Decimals for the orderbook, unless otherwise specified'
      - id: attribute_type
        type: u1
        enum: attribute_type
        doc: 'Identifies the attribute type being referenced'
      - id: reason
        type: u1
        enum: reason
        doc: 'Trading state reason. Blank if not applicable'
  firm_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: firm_id
        type: u4
        doc: 'Unique firm identifier'
      - id: firm_code
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'The firm''s text identifier'
  add_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: order_number
        type: u8
        doc: 'The day unique reference number assigned to the new order'
      - id: order_verb
        type: u1
        enum: order_verb
        doc: 'Buy/Sell indicator'
      - id: quantity
        type: u8
        doc: 'The total quantity of the order being added to the book'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: price
        type: s8
        doc: 'The price of the new order'
      - id: firm_id
        type: u4
        doc: 'Unique firm identifier'
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: order_number
        type: u8
        doc: 'The day unique reference number assigned to the new order'
      - id: executed_quantity
        type: u8
        doc: 'The quantity executed'
      - id: match_number
        type: u8
        doc: 'The day unique match identifier'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if execution reflects in volume calculations'
      - id: aggressor_firm_id
        type: u4
        doc: 'The unique firm identifier for the aggressor order. Value of 0 indicates no applicable firm'
  order_executed_with_price_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: order_number
        type: u8
        doc: 'The day unique reference number assigned to the new order'
      - id: executed_quantity
        type: u8
        doc: 'The quantity executed'
      - id: match_number
        type: u8
        doc: 'The day unique match identifier'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if execution reflects in volume calculations'
      - id: execution_price
        type: s8
        doc: 'The price at which the execution occurred'
  broken_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: match_number
        type: u8
        doc: 'The day unique match identifier'
      - id: reason
        type: u1
        enum: reason
        doc: 'Trading state reason. Blank if not applicable'
  order_delete_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: order_number
        type: u8
        doc: 'The day unique reference number assigned to the new order'
  order_replace_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: original_order_number
        type: u8
        doc: 'The original order number of the order being replaced'
      - id: new_order_number
        type: u8
        doc: 'The new reference number for the order following its replacement'
      - id: quantity
        type: u8
        doc: 'The total quantity of the order being added to the book'
      - id: price
        type: s8
        doc: 'The price of the new order'
  indicative_price_quantity_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: theoretical_opening_quantity
        type: u8
        doc: 'Total quantity eligible for matching at current theoretical opening price'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: best_bid
        type: s8
        doc: 'Current best buy price'
      - id: best_offer
        type: s8
        doc: 'Current best sell price'
      - id: theoretical_opening_price
        type: s8
        doc: 'Theoretical price eligible for matching upon auction uncross'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Auction type identifier. Blank if not applicable'
      - id: best_bid_size
        type: u8
        doc: 'Aggregated quantity at best bid price'
      - id: best_offer_size
        type: u8
        doc: 'Aggregated quantity available at best offer price'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: executed_quantity
        type: u8
        doc: 'The quantity executed'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if execution reflects in volume calculations'
      - id: execution_price
        type: s8
        doc: 'The price at which the execution occurred'
      - id: match_number
        type: u8
        doc: 'The day unique match identifier'
      - id: trade_indicator
        type: u1
        enum: trade_indicator
        doc: 'Trade type. Blank for regular trade'
      - id: buy_firm_id
        type: u4
        doc: 'Firm ID of buy-side counterparty'
      - id: sell_firm_id
        type: u4
        doc: 'Firm ID of sell-side counterparty'
      - id: trade_source
        type: u1
        enum: trade_source
        doc: 'NSX source code (A-Z). Supplied only when TradeIndicator = B'
  news_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: orderbook
        type: u4
        doc: 'Identifies the Orderbook for which this event applies. Set to 0 if not at Orderbook level'
      - id: news_id
        type: u4
        doc: 'Unique news item identifier'
      - id: firm_code
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        doc: 'The firm''s text identifier'
      - id: title
        type: str
        size: 81
        encoding: ASCII
        doc: 'News Title. Null-terminated string, maximum 81 characters'
      - id: reference_null_terminated_char_256
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reference text for the news item (e.g. a URL, file pathname). Null-terminated string, maximum 256 characters'
      - id: news_text
        type: str
        size: 512
        encoding: ASCII
        doc: 'News data. Null-terminated string, maximum 512 characters'
  index_member_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: index_orderbook
        type: u4
        doc: 'Unique orderbook identifier for the index'
      - id: member_orderbook
        type: u4
        doc: 'Unique orderbook identifier for the index member'
      - id: weight
        type: u8
        doc: 'Index member''s weighting as part of the index'
  index_value_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since last ITCH Timestamp "T" message. Nanoseconds since Nanosecond epoch'
      - id: index_orderbook
        type: u4
        doc: 'Unique orderbook identifier for the index'
      - id: index_value
        type: u8
        doc: 'Value for the index, using the price decimals for the orderbook'
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
  yyyymmddhhmmss_timestamp:
    seq:
      - id: packed
        type: s8
    instances:
      year:
        value: packed / 10000000000
      month:
        value: packed / 100000000 % 100
      day:
        value: packed / 1000000 % 100
      hour:
        value: packed / 10000 % 100
      minute:
        value: packed / 100 % 100
      second:
        value: packed % 100
  yyyymmddhhmmss_timestamp_nullable:
    seq:
      - id: value
        type: yyyymmddhhmmss_timestamp
    instances:
      is_null:
        value: value.packed == 0

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x54:
      id: 'timestamp_message'
      doc: 'This message is sent to provide the time since Epoch. It should be used in combination with the Timestamp field of individual messages to determine the exact time for each message.'
    0x53:
      id: 'system_event_message'
      doc: 'This message will be sent to provide information about events that are scheduled or triggered by the system. Events may occur at Orderbook, Board, Board+Product or System level.'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'This message provides the price ticks (steps) for the orderbooks in the system. It should be used as a lookup from Orderbook Directory [R] messages.'
    0x4d:
      id: 'quantity_tick_size_message'
      doc: 'This message provides the quantity ticks (steps) for the orderbooks in the system. It should be used as a lookup from Orderbook Directory [R] messages.'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook Directory Messages are transmitted during the reference data spin. Static data messages are sent at the beginning of the feed and contain exchange reference information.'
    0x48:
      id: 'orderbook_trading_action_message'
      doc: 'This message indicates the current trading state of an orderbook.'
    0x58:
      id: 'orderbook_attribute_message'
      doc: 'This message provides dynamic reference values for an orderbook.'
    0x46:
      id: 'firm_directory_message'
      doc: 'This message provides reference information about system participants.'
    0x41:
      id: 'add_order_message'
      doc: 'This message is sent when an order is added to the orderbook.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent when an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent when an order on the book is executed in whole or in part at a negotiated price different from the order price.'
    0x42:
      id: 'broken_trade_message'
      doc: 'This message is sent when a trade is cancelled.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message indicates when an order has been removed from the orderbook.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message indicates when an order in the orderbook has been modified.'
    0x49:
      id: 'indicative_price_quantity_message'
      doc: 'This message provides auction information including the theoretical opening price and quantity.'
    0x50:
      id: 'trade_message'
      doc: 'This message is sent to provide information about off-book matching.'
    0x4e:
      id: 'news_message'
      doc: 'This message disseminates exchange news.'
    0x59:
      id: 'index_member_directory_message'
      doc: 'This message provides details about index members and their respective weightings within an index.'
    0x5a:
      id: 'index_value_message'
      doc: 'This message disseminates index values to market participants.'
  event_status:
    0x53:
      id: 'scheduled'
      doc: 'Scheduled'
    0x43:
      id: 'canceled'
      doc: 'Canceled'
    0x54:
      id: 'triggered'
      doc: 'Triggered'
  asset_type:
    0x44:
      id: 'debt'
      doc: 'Debt'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x49:
      id: 'index'
      doc: 'Index'
  trading_state:
    0x54:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  reason:
    0x4e:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x48:
      id: 'halted_due_to_extreme_trade_range'
      doc: 'Halted Due To Extreme Trade Range'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory'
  attribute_type:
    0x52:
      id: 'previous_day_close'
      doc: 'Previous Day Close'
    0x43:
      id: 'close_price'
      doc: 'Close Price'
    0x44:
      id: 'etr_upper_limit_percentage'
      doc: 'Etr Upper Limit Percentage'
    0x64:
      id: 'etr_lower_limit_percentage'
      doc: 'Etr Lower Limit Percentage'
    0x50:
      id: 'aot_upper_limit_percentage'
      doc: 'Aot Upper Limit Percentage'
    0x70:
      id: 'aot_lower_limit_percentage'
      doc: 'Aot Lower Limit Percentage'
    0x41:
      id: 'aot_reference_price'
      doc: 'Aot Reference Price'
    0x42:
      id: 'etr_reference_price'
      doc: 'Etr Reference Price'
  order_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  printable:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  cross_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x49:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
  trade_indicator:
    0x42:
      id: 'block_special'
      doc: 'Block Special'
  trade_source:
    0x41:
      id: 'autotrade'
      doc: 'Autotrade'
    0x42:
      id: 'best_execution'
      doc: 'Best Execution'
    0x43:
      id: 'off_market_automatic_crossing'
      doc: 'Off Market Automatic Crossing'
    0x44:
      id: 'directed_reporting_or_off_market_trades_crossing'
      doc: 'Directed Reporting Or Off Market Trades Crossing'
    0x45:
      id: 'special_crossing_less_than_a_marketable_parcel'
      doc: 'Special Crossing Less Than A Marketable Parcel'
    0x46:
      id: 'forward_delivery'
      doc: 'Forward Delivery'
    0x49:
      id: 'approved_index_crossing'
      doc: 'Approved Index Crossing'
    0x4b:
      id: 'buy_back_sales'
      doc: 'Buy Back Sales'
    0x4d:
      id: 'marriage_crossing'
      doc: 'Marriage Crossing'
    0x4e:
      id: 'trades_including_crossings_outside_of_market_hours'
      doc: 'Trades Including Crossings Outside Of Market Hours'
    0x4f:
      id: 'foreign_residents_or_recognised_overseas_exchange'
      doc: 'Foreign Residents Or Recognised Overseas Exchange'
    0x50:
      id: 'block_special_crossing_or_loan_securities'
      doc: 'Block Special Crossing Or Loan Securities'
    0x51:
      id: 'special_crossing_less_than_a_marketable_parcel_x51'
      doc: 'Special Crossing Less Than A Marketable Parcel'
    0x52:
      id: 'strategy'
      doc: 'Strategy'
    0x53:
      id: 'short_sales'
      doc: 'Short Sales'
    0x55:
      id: 'for_foreign_to_foreign_securities'
      doc: 'For Foreign To Foreign Securities'
    0x56:
      id: 'book_value_switch_sales'
      doc: 'Book Value Switch Sales'
    0x58:
      id: 'portfolio_special_crossing'
      doc: 'Portfolio Special Crossing'
    0x59:
      id: 'special'
      doc: 'Special'
    0x5a:
      id: 'special_crossing_underwriting_disposal_or_exchange_approval'
      doc: 'Special Crossing Underwriting Disposal Or Exchange Approval'

