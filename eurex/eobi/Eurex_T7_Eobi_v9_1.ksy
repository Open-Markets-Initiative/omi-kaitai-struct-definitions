# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Eurex T7 Eobi v9.1
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: eurex_t7_eobi_v9_1
  title: Eurex T7 Eobi Fbe v9.1
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Enhanced Order Book Interface Fbe v9.1'
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
            'template_id::mass_instrument_state_change': mass_instrument_state_change
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
      - id: pad_2
        size: 2
      - id: leg_ratio_multiplier
        type: u4
      - id: no_legs
        type: u1
      - id: pad_3
        size: 3
      - id: instrmt_leg_grp_comp
        type: instrmt_leg_grp_comp
        repeat: expr
        repeat-expr: no_legs
  instrmt_leg_grp_comp:
    seq:
      - id: leg_symbol
        type: s4
      - id: pad_4
        size: 4
      - id: leg_security_id
        type: s8
      - id: leg_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leg_ratio_qty
        type: s4
      - id: leg_security_type
        type: u1
        enum: leg_security_type
      - id: leg_side
        type: u1
        enum: leg_side
      - id: pad_2
        size: 2
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
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: potential_security_trading_event
        type: u1
        enum: potential_security_trading_event
      - id: bid_ord_type
        type: u1
        enum: bid_ord_type
      - id: offer_ord_type
        type: u1
        enum: offer_ord_type
      - id: pad_1
        size: 1
        doc: 'Padding to 8-byte alignment before TransactTime'
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
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: imbalance_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: potential_security_trading_event
        type: u1
        enum: potential_security_trading_event
      - id: pad_6
        size: 6
  cross_request:
    seq:
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
      - id: cross_request_type
        type: u1
        enum: cross_request_type
      - id: input_source
        type: u1
        enum: input_source
      - id: pad_1
        size: 1
        doc: 'Padding to 8-byte alignment before TransactTime'
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
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
      - id: pad_1
        size: 1
      - id: trade_condition
        type: u2
        enum: trade_condition
      - id: pad_4
        size: 4
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: resting_hidden_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: resting_cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
  full_order_execution:
    seq:
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: algorithmic_trade_indicator
        type: u1
        enum: algorithmic_trade_indicator
      - id: pad_1
        size: 1
      - id: trd_match_id
        type: u4
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
  heartbeat:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
      - id: pad_4
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
      - id: market_condition
        type: u1
        enum: market_condition
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: security_trading_event
        type: u1
        enum: security_trading_event
      - id: sold_out_indicator
        type: u1
        enum: sold_out_indicator
      - id: pad_2
        size: 2
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
      - id: market_condition
        type: u1
        enum: market_condition
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: security_trading_event
        type: u1
        enum: security_trading_event
      - id: sold_out_indicator
        type: u1
        enum: sold_out_indicator
      - id: product_complex
        type: u1
        enum: product_complex
      - id: no_md_entries
        type: u1
      - id: pad_6
        size: 6
      - id: md_instrument_entry_grp_comp
        type: md_instrument_entry_grp_comp
        repeat: expr
        repeat-expr: no_md_entries
  md_instrument_entry_grp_comp:
    seq:
      - id: md_entry_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: md_entry_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
      - id: pad_1
        size: 1
      - id: trade_condition
        type: u2
        enum: trade_condition
      - id: pad_4
        size: 4
  mass_instrument_state_change:
    seq:
      - id: instrument_scope_product_complex
        type: u1
        enum: instrument_scope_product_complex
      - id: security_mass_status
        type: u1
        enum: security_mass_status
      - id: security_mass_trading_status
        type: u1
        enum: security_mass_trading_status
      - id: mass_market_condition
        type: u1
        enum: mass_market_condition
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: security_mass_trading_event
        type: u1
        enum: security_mass_trading_event
      - id: mass_sold_out_indicator
        type: u1
        enum: mass_sold_out_indicator
      - id: pad_1
        size: 1
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: last_fragment
        type: u1
        enum: last_fragment
      - id: no_related_sym
        type: u1
      - id: pad_6
        size: 6
      - id: sec_mass_stat_grp_comp
        type: sec_mass_stat_grp_comp
        repeat: expr
        repeat-expr: no_related_sym
  sec_mass_stat_grp_comp:
    seq:
      - id: security_id
        type: s8
      - id: security_status
        type: u1
        enum: security_status
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: market_condition
        type: u1
        enum: market_condition
      - id: security_trading_event
        type: u1
        enum: security_trading_event
      - id: sold_out_indicator
        type: u1
        enum: sold_out_indicator
      - id: pad_3
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
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: pad_6
        size: 6
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
        type: u8
        doc: 'Implied decimal with scale 1e-4'
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
        type: u8
        doc: 'Implied decimal with scale 1e-4'
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
      - id: algorithmic_trade_indicator
        type: u1
        enum: algorithmic_trade_indicator
      - id: pad_1
        size: 1
      - id: trd_match_id
        type: u4
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
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
      - id: market_condition
        type: u1
        enum: market_condition
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: pad_3
        size: 3
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
      - id: market_condition
        type: u1
        enum: market_condition
      - id: fast_market_indicator
        type: u1
        enum: fast_market_indicator
      - id: pad_7
        size: 7
  quote_request:
    seq:
      - id: security_id
        type: s8
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
      - id: pad_7
        size: 7
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
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: number_of_buy_orders
        type: u2
      - id: number_of_sell_orders
        type: u2
      - id: pad_4
        size: 4
  trade_report:
    seq:
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trd_match_id
        type: u4
      - id: match_type
        type: u1
        enum: match_type
      - id: match_sub_type
        type: u1
        enum: match_sub_type
      - id: algorithmic_trade_indicator
        type: u1
        enum: algorithmic_trade_indicator
      - id: pad_1
        size: 1
      - id: trade_condition
        type: u2
        enum: trade_condition
      - id: pad_6
        size: 6
  trade_reversal:
    seq:
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trd_reg_ts_execution_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_match_id
        type: u4
      - id: trade_condition
        type: u2
        enum: trade_condition
      - id: pad_2
        size: 2
      - id: no_md_entries
        type: u1
      - id: pad_7
        size: 7
      - id: md_trade_entry_grp_comp
        type: md_trade_entry_grp_comp
        repeat: expr
        repeat-expr: no_md_entries
  md_trade_entry_grp_comp:
    seq:
      - id: md_entry_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: md_entry_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
      - id: pad_7
        size: 7

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
    13302:
      id: 'mass_instrument_state_change'
      doc: 'Mass Instrument State Change TemplateId'
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
    13004:
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
    0:
      id: 'no_reset'
      doc: 'No Reset'
    1:
      id: 'reset'
      doc: 'Reset'
  product_complex:
    1: 'simple_instrument'
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
  leg_security_type:
    1: 'leg_security_multi_leg'
    2: 'leg_security_underlying_leg'
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
  bid_ord_type:
    1:
      id: 'market'
      doc: 'Market Order'
  offer_ord_type:
    1:
      id: 'market'
      doc: 'Market Order'
  security_trading_status:
    2: 'trading_halt'
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
    214: 'pre_call'
    215: 'call'
    216: 'freeze'
    217: 'trade_at_close'
  side:
    1: 'buy'
    2: 'sell'
  cross_request_type:
    1: 'cross_announcement'
    2: 'liquidity_improvement_cross'
  input_source:
    1: 'clip_client_broker'
  aggressor_side:
    1:
      id: 'buy'
      doc: 'Triggered by the buy side'
    2:
      id: 'sell'
      doc: 'Triggered by the sell side'
  trade_condition:
    1: 'implied_trade'
    107:
      id: 'out_of_sequence'
      doc: 'Out of sequence'
    155:
      id: 'midpoint_price'
      doc: 'Midpoint price (BB)'
    156:
      id: 'trading_on_terms_of_issue'
      doc: 'Trading On Terms Of Issue (BC)'
    596:
      id: 'special_auction'
      doc: 'Special Auction (SA)'
    624:
      id: 'trade_at_close'
      doc: 'Trade At Close (TC)'
  ord_type:
    1:
      id: 'market'
      doc: 'Market Order'
  algorithmic_trade_indicator:
    1: 'algorithmic_trade'
  security_status:
    1: 'active'
    2: 'inactive'
    4: 'expired'
    6: 'knocked_out'
    7: 'knock_out_revoked'
    9: 'suspended'
    11: 'pending_deletion'
    12: 'knocked_out_and_suspended'
  market_condition:
    0: 'normal'
    1: 'stressed'
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
  sold_out_indicator:
    1: 'sold_out'
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
  instrument_scope_product_complex:
    1: 'simple_instrument'
    2: 'standard_option_strategy'
    3: 'non_standard_option_strategy'
    4: 'volatility_strategy'
    5: 'futures_spread'
    6: 'inter_product_spread'
    7: 'standard_futures_strategy'
    8: 'pack_and_bundle'
    9: 'strip'
  security_mass_status:
    1: 'active'
    2: 'inactive'
    4: 'expired'
    6: 'knocked_out'
    7: 'knock_out_revoked'
    9: 'suspended'
    11: 'pending_deletion'
    12: 'knocked_out_and_suspended'
  security_mass_trading_status:
    2: 'trading_halt'
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
    214: 'pre_call'
    215: 'call'
    216: 'freeze'
    217: 'trade_at_close'
  mass_market_condition:
    0: 'normal'
    1: 'stressed'
  security_mass_trading_event:
    10:
      id: 'price_volatility_auction_is_extended'
      doc: 'Price volatility, auction is extended'
    11:
      id: 'price_volatility_auction_is_extended_again'
      doc: 'Price volatility, auction is extended again'
  mass_sold_out_indicator:
    1: 'sold_out'
  last_fragment:
    0: 'n'
    1: 'y'
  trading_session_id:
    1: 'day'
    3: 'morning'
    5: 'evening'
    6: 'after_hours'
    7: 'holiday'
  trading_session_sub_id:
    1: 'pre_trading'
    3: 'continuous'
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
    13:
      id: 'liquidity_improvement_cross'
      doc: 'Trade from Liquidity Improvement Cross'
    14:
      id: 'continuous_auction'
      doc: 'Price Without Turnover in Continuous Auction'
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
#   Version: 9.1
#   Date: 4/8/2021
#   Specification: T7_EOBI_Manual_v.9.1.1.pdf
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
