# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Eobi Fbe v10.1
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Enhanced Order Book Interface
#   Encoding: Flat Binary Encoding
#   Version: 10.1
#   Date: 6/22/2022
#   Specification: T7_EOBI_Manual_v.10.1.1.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: eurex_t7_eobi_fbe_v10_1
  title: Eurex T7 Eobi Fbe v10.1
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Enhanced Order Book Interface Fbe v10.1'
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
        type: u8_nullable
        doc: 'Application sequence number per Market Segment / Partition. Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Market Segment identifier for the partition. Nullable, No Value = 0x80000000'
      - id: partition_id
        type: u1_nullable
        doc: 'Partition identifier within the market segment. Nullable, No Value = 0xFF'
      - id: completion_indicator
        type: u1_nullable
        doc: 'End-of-event marker (0 = more to follow, 1 = last packet of event). Nullable, No Value = 0xFF'
      - id: appl_seq_reset_indicator
        type: u1_nullable
        doc: 'Indicates whether Application Sequence Number was reset for this Market Segment. Nullable, No Value = 0xFF'
      - id: pad_1
        size: 1
        doc: 'Padding to 8-byte alignment before TransactTime'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  eobi_header:
    seq:
      - id: body_len
        type: u2_nullable
        doc: 'Total packet body length in bytes (header + messages). Nullable, No Value = 0xFFFF'
      - id: template_id
        type: u2_nullable
        doc: 'SBE template identifier of the packet header (e.g., 13004 RefreshHeader / 13005 BeaconMessage). Nullable, No Value = 0xFFFF'
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Per-packet sequence number; 0xFFFFFFFF for unsequenced packets (heartbeats). Nullable, No Value = 0xFFFFFFFF'
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
        doc: 'Total packet body length in bytes (header + messages). Nullable, No Value = 0xFFFF'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'SBE template identifier of the packet header (e.g., 13004 RefreshHeader / 13005 BeaconMessage). Nullable, No Value = 0xFFFF'
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Per-packet sequence number; 0xFFFFFFFF for unsequenced packets (heartbeats). Nullable, No Value = 0xFFFFFFFF'
  add_complex_instrument:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: implied_market_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2
        size: 2
      - id: leg_ratio_multiplier
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_instrmt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: instrmt_leg_grp_comp
        type: instrmt_leg_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_leg_grp_comp
  instrmt_leg_grp_comp:
    seq:
      - id: leg_symbol
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: pad4
        size: 4
      - id: leg_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: leg_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leg_ratio_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: leg_security_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: leg_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2
        size: 2
  auction_bbo:
    seq:
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: bid_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: offer_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: potential_security_trading_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: bid_ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: offer_ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad_1
        size: 1
        doc: 'Padding to 8-byte alignment before TransactTime'
  auction_clearing_price:
    seq:
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: imbalance_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: security_trading_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: potential_security_trading_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  cross_request:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: cross_request_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: input_source
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad_1
        size: 1
        doc: 'Padding to 8-byte alignment before TransactTime'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  execution_summary:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: aggressor_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: request_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: trade_condition
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad4
        size: 4
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: resting_hidden_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: resting_cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
  full_order_execution:
    seq:
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: trd_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
  heartbeat:
    seq:
      - id: last_msg_seq_num_processed
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
  instrument_state_change:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: security_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_trading_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: market_condition
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fast_market_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_trading_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: sold_out_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2
        size: 2
      - id: high_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: low_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  instrument_summary:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_update_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_execution_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: tot_no_orders
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: security_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_trading_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: market_condition
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fast_market_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_trading_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: sold_out_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: high_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: low_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_md_instrument_entry_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
      - id: md_instrument_entry_grp_comp
        type: md_instrument_entry_grp_comp
        repeat: expr
        repeat-expr: num_md_instrument_entry_grp_comp
  md_instrument_entry_grp_comp:
    seq:
      - id: md_entry_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: trade_condition
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad4
        size: 4
  mass_instrument_state_change:
    seq:
      - id: instrument_scope_product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_mass_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_mass_trading_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: mass_market_condition
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fast_market_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_mass_trading_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: mass_sold_out_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_fragment
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_sec_mass_stat_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
      - id: sec_mass_stat_grp_comp
        type: sec_mass_stat_grp_comp
        repeat: expr
        repeat-expr: num_sec_mass_stat_grp_comp
  sec_mass_stat_grp_comp:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: high_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: low_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: security_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_trading_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: market_condition
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: security_trading_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: sold_out_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  order_add:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_details_comp
        type: order_details_comp
  order_details_comp:
    seq:
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
  order_delete:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_details_comp
        type: order_details_comp
  order_mass_delete:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  order_modify:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_prev_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: prev_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: prev_display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_details_comp
        type: order_details_comp
  order_modify_same_prio:
    seq:
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: prev_display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_details_comp
        type: order_details_comp
  partial_order_execution:
    seq:
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: trd_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
  product_state_change:
    seq:
      - id: trading_session_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trad_ses_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: market_condition
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fast_market_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  product_summary:
    seq:
      - id: last_msg_seq_num_processed
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trading_session_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trad_ses_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: market_condition
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fast_market_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  quote_request:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  snapshot_order:
    seq:
      - id: order_details_comp
        type: order_details_comp
  top_of_book:
    seq:
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: bid_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: offer_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: number_of_buy_orders
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: number_of_sell_orders
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad4
        size: 4
  trade_report:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trd_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: match_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: trade_condition
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
  trade_reversal:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Matching-engine transaction time in nanoseconds since Unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trd_reg_ts_execution_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_condition
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad2
        size: 2
      - id: num_md_trade_entry_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: md_trade_entry_grp_comp
        type: md_trade_entry_grp_comp
        repeat: expr
        repeat-expr: num_md_trade_entry_grp_comp
  md_trade_entry_grp_comp:
    seq:
      - id: md_entry_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: md_entry_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 4294967295
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
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
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_u8_8_nullable:
    seq:
      - id: value
        type: decimal_u8_8
    instances:
      is_null:
        value: value.mantissa == 9223372036854775808
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_4_nullable:
    seq:
      - id: value
        type: decimal_u8_4
    instances:
      is_null:
        value: value.mantissa == 9223372036854775808

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
    0: 'no_field'
    1: 'yes_field'
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

