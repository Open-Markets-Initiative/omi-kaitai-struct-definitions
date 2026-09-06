# ---------------------------------------------------------------------
# Kaitai struct definition for: Bse BseIndia Eobi Fbe v1.4
#
# Protocol:
#   Organization: BSE Limited
#   Protocol: Enhanced Order Book Interface
#   Encoding: Flat Binary Encoding
#   Version: 1.4
#   Date: 7/14/2025
#   Specification: EOBI_Data_Manual_V1.4.pdf
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
  id: bse_bseindia_eobi_fbe_v1_4
  title: Bse BseIndia Eobi Fbe v1.4
  license: GPL-3.0
  endian: le

doc: 'BSE Limited BSE India Enhanced Order Book Interface Fbe v1.4'
doc-ref: https://www.bseindia.com/nta

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Technical header delivered in every Udp datagram, identifying the product, the partition, and the send time'
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Bse Eobi Message'

types:
  packet_header_struct:
    seq:
      - id: eobi_header
        type: eobi_header
        doc: 'Body Len, Template Id, and Msg Seq Num opening the Packet Header'
      - id: appl_seq_num
        type: u4
        doc: 'Packet sequence number, contiguous and incremented per multicast address and port'
      - id: market_segment_id
        type: s4
        doc: 'Product identifier'
      - id: partition_id
        type: u1
        doc: 'Grouping of Bse products'
      - id: completion_indicator
        type: u1
        doc: 'Indicates whether a unit of work fits into a single datagram, 0 Incomplete and 1 Complete'
      - id: appl_seq_reset_indicator
        type: u1
        doc: 'Set in the first packet header after a market data fail over or restart, 0 No Reset and 1 Reset'
      - id: pad_5
        size: 5
        doc: 'not used'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
  eobi_header:
    seq:
      - id: body_len
        type: u2
        doc: 'Number of bytes for the message, including this field'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Unique identifier for a Bse Eobi message layout'
      - id: msg_seq_num
        type: u4
        doc: 'Message sequence number, incremented per product across all message types'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Body Len, Template Id, and Msg Seq Num opening every message behind the Packet Header'
      - id: payload
        size: message_header.body_len - 8
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::heartbeat_message': heartbeat_message
            'template_id::product_summary_message': product_summary_message
            'template_id::snapshot_order_message': snapshot_order_message
            'template_id::instrument_summary_message': instrument_summary_message
            'template_id::auction_best_bid_offer_message': auction_best_bid_offer_message
            'template_id::auction_clearing_price_message': auction_clearing_price_message
            'template_id::top_of_book_message': top_of_book_message
            'template_id::order_add_message': order_add_message
            'template_id::order_modify_message': order_modify_message
            'template_id::order_modify_same_priority_message': order_modify_same_priority_message
            'template_id::order_delete_message': order_delete_message
            'template_id::order_mass_delete_message': order_mass_delete_message
            'template_id::partial_order_execution_message': partial_order_execution_message
            'template_id::full_order_execution_message': full_order_execution_message
            'template_id::trade_reversal_message': trade_reversal_message
            'template_id::execution_summary_message': execution_summary_message
            'template_id::instrument_info_message': instrument_info_message
            'template_id::lpp_range_message': lpp_range_message
            'template_id::product_state_change_message': product_state_change_message
            'template_id::instrument_state_change_message': instrument_state_change_message
            'template_id::add_complex_instrument_message': add_complex_instrument_message
  message_header:
    seq:
      - id: body_len
        type: u2
        doc: 'Number of bytes for the message, including this field'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Unique identifier for a Bse Eobi message layout'
      - id: msg_seq_num
        type: u4
        doc: 'Message sequence number, incremented per product across all message types'
  heartbeat_message:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
        doc: 'Last Message Sequence number that was processed'
      - id: pad_4
        size: 4
        doc: 'not used'
  product_summary_message:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
        doc: 'Last Message Sequence number that was processed'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Miscellaneous state information'
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
        doc: 'Product state information'
      - id: trad_ses_status
        type: u1
        enum: trad_ses_status
        doc: 'Miscellaneous state information'
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
        doc: 'Indicates if product is in the state Fast Market'
  snapshot_order_message:
    seq:
      - id: order_details
        type: order_details
        doc: 'OrderDetails'
  order_details:
    seq:
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp
        doc: 'Priority timestamp. Nanoseconds since Unix epoch'
      - id: display_qty
        type: s8
        doc: 'Quantity'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: pad_7
        size: 7
        doc: 'not used'
      - id: price
        type: decimal_s8_8
        doc: 'Reserved for future use. Implied decimal with scale 1e-8'
  instrument_summary_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'Last update time of the corresponding order book. Nanoseconds since Unix epoch'
      - id: trd_reg_ts_execution_time
        type: nanosecond_timestamp_nullable
        doc: 'Last matching execution timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: tot_no_orders
        type: u4
        doc: 'Corresponding number of orders for this instrument'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Instrument status'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'Instrument state status'
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
        doc: 'Indicates if product is in the state Fast Market'
      - id: num_md_instrument_entry_grp
        type: u1
        doc: 'Number of entries in Market Data message for MDEntryGrp'
      - id: trade_volume
        type: s8
        doc: 'Cumulative volume of units traded in the day'
      - id: no_of_trades
        type: u4
        doc: 'Total number of trades'
      - id: pad_4
        size: 4
        doc: 'not used'
      - id: md_instrument_entry_grp
        type: md_instrument_entry_grp
        repeat: expr
        repeat-expr: num_md_instrument_entry_grp
        doc: 'Instrument trade statistics repeated NoMDEntries times in the Instrument Summary Message. The group is not cut off by design'
  md_instrument_entry_grp:
    seq:
      - id: md_entry_px
        type: decimal_s8_8_nullable
        doc: 'Price. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_size
        type: s8_nullable
        doc: 'Quantity. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Type of market data entry'
      - id: pad_7
        size: 7
        doc: 'not used'
  auction_best_bid_offer_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: bid_px
        type: decimal_s8_8_nullable
        doc: 'Bid price/rate. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_s8_8_nullable
        doc: 'Offer price/rate. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
  auction_clearing_price_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: last_px
        type: decimal_s8_8
        doc: 'Indicating the potential Auction price for a crossed order book. Implied decimal with scale 1e-8'
      - id: last_qty
        type: s8
        doc: 'The potential matchable quantity for the auction'
  top_of_book_message:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: bid_px
        type: decimal_s8_8_nullable
        doc: 'Bid price/rate. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_s8_8_nullable
        doc: 'Offer price/rate. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
  order_add_message:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Matching engine In timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: order_details
        type: order_details
        doc: 'OrderDetails'
  order_modify_message:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Matching engine In timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_prev_time_priority
        type: nanosecond_timestamp
        doc: 'Previous order priority timestamp. Nanoseconds since Unix epoch'
      - id: prev_price
        type: decimal_s8_8
        doc: 'Previous order price. Implied decimal with scale 1e-8'
      - id: prev_display_qty
        type: s8
        doc: 'Previous display quantity'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: order_details
        type: order_details
        doc: 'OrderDetails'
  order_modify_same_priority_message:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Matching engine In timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
      - id: prev_display_qty
        type: s8
        doc: 'Previous display quantity'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: order_details
        type: order_details
        doc: 'OrderDetails'
  order_delete_message:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Matching engine In timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: order_details
        type: order_details
        doc: 'OrderDetails'
  order_mass_delete_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
  partial_order_execution_message:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: pad_7
        size: 7
        doc: 'not used'
      - id: price
        type: decimal_s8_8
        doc: 'Reserved for future use. Implied decimal with scale 1e-8'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp
        doc: 'Priority timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: trd_match_id
        type: u4
        doc: 'Unique identifier for each price level of a match event'
      - id: pad_4
        size: 4
        doc: 'not used'
      - id: last_qty
        type: s8
        doc: 'The potential matchable quantity for the auction'
      - id: last_px
        type: decimal_s8_8
        doc: 'Indicating the potential Auction price for a crossed order book. Implied decimal with scale 1e-8'
  full_order_execution_message:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: pad_7
        size: 7
        doc: 'not used'
      - id: price
        type: decimal_s8_8
        doc: 'Reserved for future use. Implied decimal with scale 1e-8'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp
        doc: 'Priority timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: trd_match_id
        type: u4
        doc: 'Unique identifier for each price level of a match event'
      - id: pad_4
        size: 4
        doc: 'not used'
      - id: last_qty
        type: s8
        doc: 'The potential matchable quantity for the auction'
      - id: last_px
        type: decimal_s8_8
        doc: 'Indicating the potential Auction price for a crossed order book. Implied decimal with scale 1e-8'
  trade_reversal_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
      - id: trd_match_id
        type: u4
        doc: 'Unique identifier for each price level of a match event'
      - id: pad_4
        size: 4
        doc: 'not used'
      - id: last_qty
        type: s8
        doc: 'The potential matchable quantity for the auction'
      - id: last_px
        type: decimal_s8_8
        doc: 'Indicating the potential Auction price for a crossed order book. Implied decimal with scale 1e-8'
      - id: trd_reg_ts_execution_time
        type: nanosecond_timestamp_nullable
        doc: 'Last matching execution timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: num_md_trade_entry_grp
        type: u1
        doc: 'Number of entries in Market Data message for MDEntryGrp'
      - id: pad_7
        size: 7
        doc: 'not used'
      - id: md_trade_entry_grp
        type: md_trade_entry_grp
        repeat: expr
        repeat-expr: num_md_trade_entry_grp
        doc: 'Trade statistics repeated NoMDEntries times in the Trade Reversal Message'
  md_trade_entry_grp:
    seq:
      - id: md_entry_px
        type: decimal_s8_8_nullable
        doc: 'Price. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_size
        type: s8_nullable
        doc: 'Quantity. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Type of market data entry'
      - id: pad_7
        size: 7
        doc: 'not used'
  execution_summary_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: aggressor_timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Always identical to the matching engine in timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: exec_id
        type: nanosecond_timestamp
        doc: 'Matching timestamp. Nanoseconds since Unix epoch'
      - id: last_qty
        type: s8
        doc: 'The potential matchable quantity for the auction'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Side of the incoming order'
      - id: trade_condition
        type: u1_nullable
        doc: 'Indicates whether a synthetic match is occured. Nullable, No Value = 255'
      - id: pad_6
        size: 6
        doc: 'not used'
      - id: last_px
        type: decimal_s8_8
        doc: 'Indicating the potential Auction price for a crossed order book. Implied decimal with scale 1e-8'
      - id: resting_hidden_qty
        type: s8_nullable
        doc: 'Quantity of matched passive orders that is not displayed to the market. Nullable, No Value = 0x8000000000000000'
  instrument_info_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: close_price
        type: decimal_s8_8_nullable
        doc: 'Close Price. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: prev_close_price
        type: decimal_s8_8_nullable
        doc: 'Previous Close Price. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: upper_ckt_limit
        type: decimal_s8_8_nullable
        doc: 'Upper Circuit Limit Price. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: lower_ckt_limit
        type: decimal_s8_8_nullable
        doc: 'Lower Circuit Limit Price. Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
  lpp_range_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: upper_exec_limit
        type: decimal_s8_8
        doc: 'Upper Limit Execution Price. Implied decimal with scale 1e-8'
      - id: lower_exec_limit
        type: decimal_s8_8
        doc: 'Lower Limit Execution Price. Implied decimal with scale 1e-8'
  product_state_change_message:
    seq:
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Miscellaneous state information'
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
        doc: 'Product state information'
      - id: trad_ses_status
        type: u1
        enum: trad_ses_status
        doc: 'Miscellaneous state information'
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
        doc: 'Indicates if product is in the state Fast Market'
      - id: pad_4
        size: 4
        doc: 'not used'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
  instrument_state_change_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Instrument status'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'Instrument state status'
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
        doc: 'Indicates if product is in the state Fast Market'
      - id: pad_5
        size: 5
        doc: 'not used'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
  add_complex_instrument_message:
    seq:
      - id: security_id
        type: s8
        doc: 'Unique instrument identifier'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Transaction timestamp. Nanoseconds since Unix epoch'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Strategy Type. Nullable, No Value = -2147483648'
      - id: product_complex
        type: u1
        enum: product_complex
        doc: 'This field qualifies an instrument type on BSE'
      - id: implied_market_indicator
        type: u1
        enum: implied_market_indicator
        doc: 'Indicates that an implied market to be created for either the legs of a multi-leg instrument or for the multi-leg instrument based on the existence of the legs'
      - id: num_instrmt_leg_grp
        type: u1
        doc: 'Number of Legs repeating group instances'
      - id: pad_1
        size: 1
        doc: 'not used'
      - id: instrmt_leg_grp
        type: instrmt_leg_grp
        repeat: expr
        repeat-expr: num_instrmt_leg_grp
        doc: 'Leg definitions repeated NoLegs times in the Add Complex Instrument Message'
  instrmt_leg_grp:
    seq:
      - id: leg_security_id
        type: s8
        doc: 'Instrument identifier of the leg security'
      - id: leg_ratio_qty
        type: s4_nullable
        doc: 'The ratio of quantity for this individual leg relative to the entire multi-leg security. Nullable, No Value = -2147483648'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of the individual leg of a strategy as defined in signature'
      - id: pad_3
        size: 3
        doc: 'not used'
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1
  decimal_s8_8_nullable:
    seq:
      - id: value
        type: decimal_s8_8
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648

enums:
  template_id:
    13001:
      id: 'heartbeat_message'
      doc: 'Published regularly when there is no activity on the snapshot or the incremental channel.'
    13600:
      id: 'product_summary_message'
      doc: 'Published once each snapshot cycle, carrying attributes that are equal for all instruments in the product.'
    13602:
      id: 'snapshot_order_message'
      doc: 'Represents each individual order or quote in a snapshot cycle on the snapshot channel.'
    13601:
      id: 'instrument_summary_message'
      doc: 'Published for each instrument in one snapshot cycle, carrying instrument state information and trade statistics.'
    13500:
      id: 'auction_best_bid_offer_message'
      doc: 'Carries the best bid and offer of a non crossed order book during an auction call phase.'
    13501:
      id: 'auction_clearing_price_message'
      doc: 'Published for a crossed order book in an auction, indicating the potential auction price.'
    13504:
      id: 'top_of_book_message'
      doc: 'Carries the best bid and offer of an order book outside continuous trading.'
    13100:
      id: 'order_add_message'
      doc: 'Published for each new order that was entered in the order book.'
    13101:
      id: 'order_modify_message'
      doc: 'Published if an existing order in the book is modified, whereby the new parameters might cause a change in time priority.'
    13106:
      id: 'order_modify_same_priority_message'
      doc: 'Published if the time priority of an existing order is not changed.'
    13102:
      id: 'order_delete_message'
      doc: 'Published whenever an existing order is deleted from the order book.'
    13103:
      id: 'order_mass_delete_message'
      doc: 'Published when the order book is expected to be emptied.'
    13105:
      id: 'partial_order_execution_message'
      doc: 'Published whenever a visible order is partially executed at its displayed price.'
    13104:
      id: 'full_order_execution_message'
      doc: 'Published whenever a visible order is fully executed at its displayed price.'
    13200:
      id: 'trade_reversal_message'
      doc: 'Published when a trade is reversed.'
    13202:
      id: 'execution_summary_message'
      doc: 'Published whenever an incoming order is executed, carrying information on the execution of that incoming order.'
    13203:
      id: 'instrument_info_message'
      doc: 'Published whenever there is a change in the daily price range of the instrument.'
    13204:
      id: 'lpp_range_message'
      doc: 'Published whenever there is a change in the limit price protection range of the instrument.'
    13300:
      id: 'product_state_change_message'
      doc: 'Provides updates on the trading state for all instruments in a particular product.'
    13301:
      id: 'instrument_state_change_message'
      doc: 'Provides state information for a single instrument.'
    13400:
      id: 'add_complex_instrument_message'
      doc: 'Published whenever a new complex instrument is created intraday or an existing complex instrument is modified.'
    13002:
      id: 'packet_header'
      doc: 'MarketDataReport, MsgType = U20'
  trading_session_id:
    1:
      id: 'day'
      doc: 'Day'
    3:
      id: 'morning'
      doc: 'Morning'
    5:
      id: 'evening'
      doc: 'Evening'
    7:
      id: 'holiday'
      doc: 'Holiday'
  trading_session_sub_id:
    1:
      id: 'pre_trading'
      doc: 'Pre Trading'
    3:
      id: 'trading'
      doc: 'Trading'
    4:
      id: 'closing'
      doc: 'Closing'
    5:
      id: 'post_trading'
      doc: 'Post Trading'
    6:
      id: 'post_closing'
      doc: 'Post Closing'
    7:
      id: 'quiescent'
      doc: 'Quiescent'
  trad_ses_status:
    1:
      id: 'halted'
      doc: 'Halted'
    2:
      id: 'open'
      doc: 'Open'
    3:
      id: 'closed'
      doc: 'Closed'
  fast_market_indicator:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  security_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'inactive'
      doc: 'Inactive'
    4:
      id: 'expired'
      doc: 'Expired'
    9:
      id: 'suspended'
      doc: 'Suspended'
  security_trading_status:
    200:
      id: 'closed'
      doc: 'Closed'
    201:
      id: 'restricted'
      doc: 'Restricted'
    202:
      id: 'book'
      doc: 'Book'
    203:
      id: 'continuous'
      doc: 'Continuous'
    204:
      id: 'opening_auction'
      doc: 'Opening Auction'
    205:
      id: 'opening_auction_freeze'
      doc: 'Opening Auction Freeze'
    206:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
    207:
      id: 'intraday_auction_freeze'
      doc: 'Intraday Auction Freeze'
    208:
      id: 'circuit_breaker_auction'
      doc: 'Circuit Breaker Auction'
    209:
      id: 'circuit_breaker_auction_freeze'
      doc: 'Circuit Breaker Auction Freeze'
    210:
      id: 'closing_auction'
      doc: 'Closing Auction'
    211:
      id: 'closing_auction_freeze'
      doc: 'Closing Auction Freeze'
  md_entry_type:
    2:
      id: 'trade'
      doc: 'Trade'
    4:
      id: 'opening_price'
      doc: 'Opening Price'
    5:
      id: 'closing_price'
      doc: 'Closing Price'
    7:
      id: 'high_price'
      doc: 'High Price'
    8:
      id: 'low_price'
      doc: 'Low Price'
    101:
      id: 'previous_closing_price'
      doc: 'Previous Closing Price'
    200:
      id: 'opening_auction'
      doc: 'Opening Auction'
    201:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
    202:
      id: 'circuit_breaker_auction'
      doc: 'Circuit Breaker Auction'
    203:
      id: 'closing_auction'
      doc: 'Closing Auction'
    204:
      id: 'upper_ckt_limit'
      doc: 'Upper Ckt Limit'
    205:
      id: 'lower_ckt_limit'
      doc: 'Lower Ckt Limit'
    206:
      id: 'gross_trade_amt'
      doc: 'Gross Trade Amt'
    208:
      id: 'upper_exec_limit'
      doc: 'Upper Exec Limit'
    209:
      id: 'lower_exec_limit'
      doc: 'Lower Exec Limit'
  aggressor_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  trade_condition:
    1:
      id: 'implied_trade'
      doc: 'Implied Trade'
  product_complex:
    5:
      id: 'futures_spread'
      doc: 'Futures Spread'
  implied_market_indicator:
    0:
      id: 'not_implied'
      doc: 'Not Implied'
    3:
      id: 'implied_in_out'
      doc: 'Implied In Out'
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'

