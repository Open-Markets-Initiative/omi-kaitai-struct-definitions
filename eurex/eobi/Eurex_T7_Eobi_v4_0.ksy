# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Eurex T7 Eobi v4.0
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: eurex_t7_eobi_v4_0
  title: Eurex T7 Eobi Fbe v4.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Enhanced Order Book Interface Fbe v4.0'
doc-ref: https://www.eurex.com/ex-en/technology/t7

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Eurex Eobi Packet Header'
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Eurex Eobi Message'

types:
  packet_header_struct:
    seq:
      - id: eobi_header
        type: eobi_header
        doc: 'EOBI PacketHeader MessageHeaderComp (BodyLen + TemplateID + MsgSeqNum) — first 8 bytes of every Eurex T7 EOBI packet'
      - id: appl_seq_num
        type: u8
        doc: 'Application sequence number per Market Segment / Partition'
      - id: market_segment_id
        type: s4
        doc: 'Market Segment identifier for the partition'
      - id: partition_id
        type: u1
        doc: 'Partition identifier within the market segment'
      - id: completion_indicator
        type: u1
        enum: completion_indicator
        doc: 'End-of-event marker (0 = more to follow, 1 = last packet of event)'
      - id: appl_seq_reset_indicator
        type: u1
        enum: appl_seq_reset_indicator
        doc: 'Indicates whether Application Sequence Number was reset for this Market Segment'
      - id: pad_1
        size: 1
        doc: 'Padding to 8-byte alignment before TransactTime'
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  eobi_header:
    seq:
      - id: body_len
        type: u2
        doc: 'Total packet body length in bytes (header + messages)'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'SBE template identifier of the packet header (e.g., 13004 RefreshHeader / 13005 BeaconMessage)'
      - id: msg_seq_num
        type: u4
        doc: 'Per-packet sequence number; 0xFFFFFFFF for unsequenced packets (heartbeats)'
  message_struct:
    seq:
      - id: message_header_comp
        type: message_header_comp
      - id: payload
        size: message_header_comp.body_len - 8
        type:
          switch-on: message_header_comp.template_id
          cases:
            'template_id::add_complex_instrument': add_complex_instrument
            'template_id::auction_bbo': auction_bbo
            'template_id::auction_clearing_price': auction_clearing_price
            'template_id::cross_request': cross_request
            'template_id::execution_summary': execution_summary
            'template_id::full_order_execution': full_order_execution
            'template_id::heartbeat': heartbeat
            'template_id::instrument_state_change': instrument_state_change
            'template_id::instrument_summary': instrument_summary
            'template_id::order_add': order_add
            'template_id::order_delete': order_delete
            'template_id::order_mass_delete': order_mass_delete
            'template_id::order_modify': order_modify
            'template_id::order_modify_same_prio': order_modify_same_prio
            'template_id::partial_order_execution': partial_order_execution
            'template_id::product_state_change': product_state_change
            'template_id::product_summary': product_summary
            'template_id::quote_request': quote_request
            'template_id::snapshot_order': snapshot_order
            'template_id::top_of_book': top_of_book
            'template_id::trade_report': trade_report
            'template_id::trade_reversal': trade_reversal
  message_header_comp:
    seq:
      - id: body_len
        type: u2
        doc: 'Total packet body length in bytes (header + messages)'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'SBE template identifier of the packet header (e.g., 13004 RefreshHeader / 13005 BeaconMessage)'
      - id: msg_seq_num
        type: u4
        doc: 'Per-packet sequence number; 0xFFFFFFFF for unsequenced packets (heartbeats)'
  add_complex_instrument:
    seq:
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_sub_type
        type: s4
      - id: product_complex
        type: u1
        enum: product_complex
      - id: implied_market_indicator
        type: u1
        enum: implied_market_indicator
      - id: num_instrmt_leg_grp_comp
        type: u1
      - id: pad1
        size: 1
      - id: instrmt_leg_grp_comp
        type: instrmt_leg_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_leg_grp_comp
  instrmt_leg_grp_comp:
    seq:
      - id: leg_symbol
        type: s4
      - id: pad4
        size: 4
      - id: leg_security_id
        type: s8
      - id: leg_ratio_qty
        type: s4
      - id: leg_side
        type: u1
        enum: leg_side
      - id: pad3
        size: 3
  auction_bbo:
    seq:
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: s4
      - id: offer_size
        type: s4
      - id: potential_security_trading_event
        type: u1
        enum: potential_security_trading_event
      - id: pad7
        size: 7
  auction_clearing_price:
    seq:
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: s4
      - id: imbalance_qty
        type: s4
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: potential_security_trading_event
        type: u1
        enum: potential_security_trading_event
      - id: pad6
        size: 6
  cross_request:
    seq:
      - id: security_id
        type: s8
      - id: last_qty
        type: s4
      - id: pad4
        size: 4
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  execution_summary:
    seq:
      - id: security_id
        type: s8
      - id: aggressor_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: request_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: last_qty
        type: s4
      - id: aggressor_side
        type: u1
        enum: aggressor_side
      - id: trade_condition
        type: u1
        enum: trade_condition
      - id: pad2
        size: 2
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: resting_hidden_qty
        type: s4
      - id: resting_cxl_qty
        type: s4
  full_order_execution:
    seq:
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: pad6
        size: 6
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: trd_match_id
        type: u4
      - id: last_qty
        type: s4
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
  heartbeat:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
      - id: pad4
        size: 4
  instrument_state_change:
    seq:
      - id: security_id
        type: s8
      - id: security_status
        type: u1
        enum: security_status
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: security_trading_event
        type: u1
        enum: security_trading_event
      - id: pad4
        size: 4
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  instrument_summary:
    seq:
      - id: security_id
        type: s8
      - id: last_update_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_execution_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: tot_no_orders
        type: u2
      - id: security_status
        type: u1
        enum: security_status
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: security_trading_event
        type: u1
        enum: security_trading_event
      - id: num_md_instrument_entry_grp_comp
        type: u1
      - id: pad1
        size: 1
      - id: md_instrument_entry_grp_comp
        type: md_instrument_entry_grp_comp
        repeat: expr
        repeat-expr: num_md_instrument_entry_grp_comp
  md_instrument_entry_grp_comp:
    seq:
      - id: md_entry_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: md_entry_size
        type: s4
      - id: md_entry_type
        type: u1
        enum: md_entry_type
      - id: pad3
        size: 3
  order_add:
    seq:
      - id: trd_reg_ts_time_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: order_details_comp
        type: order_details_comp
  order_details_comp:
    seq:
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: display_qty
        type: s4
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: pad2
        size: 2
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
  order_delete:
    seq:
      - id: trd_reg_ts_time_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: order_details_comp
        type: order_details_comp
  order_mass_delete:
    seq:
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  order_modify:
    seq:
      - id: trd_reg_ts_time_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_prev_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: prev_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: prev_display_qty
        type: s4
      - id: pad4
        size: 4
      - id: security_id
        type: s8
      - id: order_details_comp
        type: order_details_comp
  order_modify_same_prio:
    seq:
      - id: trd_reg_ts_time_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: prev_display_qty
        type: s4
      - id: pad4
        size: 4
      - id: security_id
        type: s8
      - id: order_details_comp
        type: order_details_comp
  partial_order_execution:
    seq:
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: pad6
        size: 6
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: trd_match_id
        type: u4
      - id: last_qty
        type: s4
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
  product_state_change:
    seq:
      - id: trading_session_id
        type: u1
        enum: trading_session_id
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: trad_ses_status
        type: u1
        enum: trad_ses_status
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: pad4
        size: 4
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  product_summary:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
      - id: trading_session_id
        type: u1
        enum: trading_session_id
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: trad_ses_status
        type: u1
        enum: trad_ses_status
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
  quote_request:
    seq:
      - id: security_id
        type: s8
      - id: last_qty
        type: s4
      - id: side
        type: u1
        enum: side
      - id: pad3
        size: 3
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  snapshot_order:
    seq:
      - id: order_details_comp
        type: order_details_comp
  top_of_book:
    seq:
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
  trade_report:
    seq:
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: trd_match_id
        type: u4
      - id: last_qty
        type: s4
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: match_type
        type: u1
        enum: match_type
      - id: match_sub_type
        type: u1
        enum: match_sub_type
      - id: pad6
        size: 6
  trade_reversal:
    seq:
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: trd_match_id
        type: u4
      - id: last_qty
        type: s4
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trd_reg_ts_execution_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: num_md_trade_entry_grp_comp
        type: u1
      - id: pad7
        size: 7
      - id: md_trade_entry_grp_comp
        type: md_trade_entry_grp_comp
        repeat: expr
        repeat-expr: num_md_trade_entry_grp_comp
  md_trade_entry_grp_comp:
    seq:
      - id: md_entry_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: md_entry_size
        type: s4
      - id: md_entry_type
        type: u1
        enum: md_entry_type
      - id: pad3
        size: 3

enums:
  template_id:
    13400:
      id: 'add_complex_instrument'
      doc: 'Add Complex Instrument TemplateId'
    13500:
      id: 'auction_bbo'
      doc: 'Auction Bbo TemplateId'
    13501:
      id: 'auction_clearing_price'
      doc: 'Auction Clearing Price TemplateId'
    13502:
      id: 'cross_request'
      doc: 'Cross Request TemplateId'
    13202:
      id: 'execution_summary'
      doc: 'Execution Summary TemplateId'
    13104:
      id: 'full_order_execution'
      doc: 'Full Order Execution TemplateId'
    13001:
      id: 'heartbeat'
      doc: 'Heartbeat TemplateId'
    13301:
      id: 'instrument_state_change'
      doc: 'Instrument State Change TemplateId'
    13601:
      id: 'instrument_summary'
      doc: 'Instrument Summary TemplateId'
    13100:
      id: 'order_add'
      doc: 'Order Add TemplateId'
    13102:
      id: 'order_delete'
      doc: 'Order Delete TemplateId'
    13103:
      id: 'order_mass_delete'
      doc: 'Order Mass Delete TemplateId'
    13101:
      id: 'order_modify'
      doc: 'Order Modify TemplateId'
    13106:
      id: 'order_modify_same_prio'
      doc: 'Order Modify Same Prio TemplateId'
    13005:
      id: 'packet_header'
      doc: 'Packet Header TemplateId'
    13105:
      id: 'partial_order_execution'
      doc: 'Partial Order Execution TemplateId'
    13300:
      id: 'product_state_change'
      doc: 'Product State Change TemplateId'
    13600:
      id: 'product_summary'
      doc: 'Product Summary TemplateId'
    13503:
      id: 'quote_request'
      doc: 'Quote Request TemplateId'
    13602:
      id: 'snapshot_order'
      doc: 'Snapshot Order TemplateId'
    13504:
      id: 'top_of_book'
      doc: 'Top Of Book TemplateId'
    13201:
      id: 'trade_report'
      doc: 'Trade Report TemplateId'
    13200:
      id: 'trade_reversal'
      doc: 'Trade Reversal TemplateId'
  completion_indicator:
    0: 'incomplete'
    1: 'complete'
  appl_seq_reset_indicator:
    0: 'no_reset'
    1: 'reset'
  product_complex:
    2: 'standard_option_strategy'
    3: 'non_standard_option_strategy'
    4: 'volatility_strategy'
    5: 'futures_spread'
    6: 'inter_product_spread'
    7: 'standard_futures_strategy'
    8: 'pack_and_bundle'
    9: 'strip'
  implied_market_indicator:
    0: 'not_implied'
    3: 'implied_in_out'
  leg_side:
    1: 'buy'
    2: 'sell'
  potential_security_trading_event:
    0:
      id: 'none'
      doc: 'None'
    10:
      id: 'price_volatility_auction_is_extended'
      doc: 'Price volatility, auction is extended'
  security_trading_status:
    7: 'market_imbalance_buy'
    8: 'market_imbalance_sell'
    200: 'closed'
    201: 'restricted'
    202: 'book'
    203: 'continuous'
    204: 'opening_auction'
    205: 'opening_auction_freeze'
    206: 'intraday_auction'
    207: 'intraday_auction_freeze'
    208: 'circuit_breaker_auction'
    209: 'circuit_breaker_auction_freeze'
    210: 'closing_auction'
    211: 'closing_auction_freeze'
    212: 'ipo_auction'
    213: 'ipo_auction_freeze'
  aggressor_side:
    1:
      id: 'buy'
      doc: 'Triggered by the buy side'
    2:
      id: 'sell'
      doc: 'Triggered by the sell side'
  trade_condition:
    1: 'implied_trade'
  side:
    1: 'buy'
    2: 'sell'
  ord_type:
    1:
      id: 'market'
      doc: 'Market Order'
  security_status:
    1: 'active'
    2: 'inactive'
    4: 'expired'
    9: 'suspended'
  fast_market_indicator:
    0: 'no'
    1: 'yes'
  security_trading_event:
    10:
      id: 'price_volatility_auction_is_extended'
      doc: 'Price volatility, auction is extended'
    11:
      id: 'price_volatility_auction_is_extended_again'
      doc: 'Price volatility, auction is extended again'
  md_entry_type:
    2: 'trade'
    4: 'opening_price'
    5: 'closing_price'
    7: 'high_price'
    8: 'low_price'
    66: 'trade_volume'
    101: 'previous_closing_price'
    200: 'opening_auction'
    201: 'intraday_auction'
    202: 'circuit_breaker_auction'
    203: 'closing_auction'
    204: 'ipo_auction'
  trading_session_id:
    1: 'day'
    3: 'morning'
    5: 'evening'
    6: 'after_hours'
    7: 'holiday'
  trading_session_sub_id:
    1: 'pre_trading'
    3: 'trading'
    4: 'closing'
    5: 'post_trading'
    7: 'quiescent'
  trad_ses_status:
    1: 'halted'
    2: 'open'
    3: 'closed'
  match_type:
    3:
      id: 'confirmed_trade_report'
      doc: 'Manual Trade Entry'
    5:
      id: 'cross_auction'
      doc: 'Trade from Uncrossing'
    7:
      id: 'call_auction'
      doc: 'Trade from Auction'
  match_sub_type:
    1: 'opening_auction'
    2: 'closing_auction'
    3: 'intraday_auction'
    4: 'circuit_breaker_auction'
    5: 'ipo_auction'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: Eurex Exchange
#   Version: 4.0
#   Date: 11/11/2016
#   Specification: eurex_enhanced_order_book_interfaces.pdf
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------
