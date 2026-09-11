# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicEquities TotalView Itch v3.04.X
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nordic Equity TotalView
#   Encoding: Itch
#   Version: 3.04.X
#   Date: 11/12/2025
#   Specification: Nasdaq Nordic INET Equity TotalView-ITCH PureStream (3.04.X).pdf
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
  id: nasdaq_nordicequities_totalview_itch_v3_04_x
  title: Nasdaq NordicEquities TotalView Itch v3.04.X
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Equities Nordic Equity TotalView Itch v3.04.X'
doc-ref: https://www.nasdaq.com/solutions/technical-information-inet-nordic-trading-platform

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::order_book_trading_action_message': order_book_trading_action_message
            'message_type::order_book_directory_message': order_book_directory_message
            'message_type::add_order_message': add_order_message
            'message_type::add_order_mpid_attribution_message': add_order_mpid_attribution_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_book_flush_message': order_book_flush_message
            'message_type::order_replace_message': order_replace_message
            'message_type::trade_message': trade_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::broken_trade_message': broken_trade_message
            'message_type::noii_message': noii_message
            'message_type::moii_message': moii_message
            'message_type::execution_summary_message': execution_summary_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System event code'
  order_book_trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: symbol_state
        type: u1
        enum: symbol_state
        doc: 'Trading state of the order book'
      - id: extension
        type: u1
        enum: extension
        doc: 'Whether the cross has been extended'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Halt reason code'
  order_book_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: symbol
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Human readable name of the security'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Isin code identifying security'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Type of financial product'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market identifier code'
      - id: market_segment_id
        type: u2
        doc: 'Market segment this order book belongs to'
      - id: note_codes_bit_field_1
        type: note_codes_bit_field_1
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: note_codes_bit_field_2
        type: note_codes_bit_field_2
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: note_codes_bit_field_3
        type: note_codes_bit_field_3
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: note_codes_bit_field_4
        type: note_codes_bit_field_4
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: note_codes_bit_field_5
        type: note_codes_bit_field_5
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: note_codes_bit_field_6
        type: note_codes_bit_field_6
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: note_codes_bit_field_7
        type: note_codes_bit_field_7
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: note_codes_bit_field_8
        type: note_codes_bit_field_8
        doc: 'Note codes, logical Or is used to identify multiple note codes'
      - id: round_lot_size
        type: u4
        doc: 'Number of shares representing a round lot'
      - id: nordic_mid_mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Venue Mic if a Nordic At Mid order book applies'
      - id: aod_mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Venue Mic if an auction on demand order book applies'
      - id: notation_of_qty
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Measurement units the quantity is expressed in'
      - id: notional_amount
        type: decimal_u8_5
        doc: 'Notional amount if specified. Implied decimal with scale 1e-5'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency of the notional amount'
      - id: price_notation
        type: u1
        enum: price_notation
        doc: 'Populated with M if price is monetary value'
      - id: multiplier_for_calculating_quantity_in_measurement_unit
        type: decimal_u8_6
        doc: 'Multiplier to calculate quantity in measurement units. Implied decimal with scale 1e-6'
      - id: pure_stream_mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Venue Mic if a PureStream order book applies'
  note_codes_bit_field_1:
    seq:
      - id: nm_new_market_company
        type: b1
      - id: xr_excluding_participating_in_rights
        type: b1
      - id: sp_excluding_participating_in_split
        type: b1
      - id: po_company_subject_to_public_offer
        type: b1
      - id: ud_under_drawing
        type: b1
      - id: sr_excluding_comb_split_and_issue_rights
        type: b1
      - id: ul_un_listed
        type: b1
      - id: wi_when_issued
        type: b1
  note_codes_bit_field_2:
    seq:
      - id: br_company_bankruptcy
        type: b1
      - id: su_suspension
        type: b1
      - id: rl_removal_from_listing_in_process
        type: b1
      - id: sl_other_surveillance_list_reason
        type: b1
      - id: to_a_significant_reverse_takeover_pending
        type: b1
      - id: cs_cent_shares
        type: b1
      - id: rs_reversed_split
        type: b1
      - id: bs_excluding_comb_bonus_split
        type: b1
  note_codes_bit_field_3:
    seq:
      - id: ss_excluding_comb_split_redemption_share
        type: b1
      - id: fn_first_north_company
        type: b1
      - id: ob_observation_status
        type: b1
      - id: xd_excluding_dividend
        type: b1
      - id: fe_foreign_non_eueea_entity
        type: b1
      - id: so_sold_out_buy_back
        type: b1
      - id: sk_soft_knock
        type: b1
      - id: kb_knock_out_buy_back
        type: b1
  note_codes_bit_field_4:
    seq:
      - id: bb_buy_back
        type: b1
      - id: reserved_23
        type: b2
      - id: ce_capped_by_esma
        type: b1
      - id: reserved_5
        type: b1
      - id: pd_price_discrepancy_historical_average_share_classes
        type: b1
      - id: sm_stressed_market
        type: b1
      - id: ew_marketwide_exceptional_circumstance
        type: b1
  note_codes_bit_field_5:
    seq:
      - id: em_exceptional_circumstances_related_to_market_maker
        type: b1
      - id: un_underlying_not_quoted
        type: b1
      - id: da_digital_asset
        type: b1
      - id: kn_knockout_buy_back_into_next_trading_day
        type: b1
      - id: reserved_58
        type: b4
  note_codes_bit_field_6:
    seq:
      - id: reserved_18
        type: b8
  note_codes_bit_field_7:
    seq:
      - id: reserved_18
        type: b8
  note_codes_bit_field_8:
    seq:
      - id: reserved_18
        type: b8
  add_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_reference_number
        type: u8
        doc: 'Unique reference number assigned to the new order'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: quantity
        type: u4
        doc: 'Total number of shares in the order'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: price
        type: decimal_u4_4
        doc: 'Display price of the new order. Implied decimal with scale 1e-4'
  add_order_mpid_attribution_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_reference_number
        type: u8
        doc: 'Unique reference number assigned to the new order'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of order being added'
      - id: quantity
        type: u4
        doc: 'Total number of shares in the order'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: price
        type: decimal_u4_4
        doc: 'Display price of the new order. Implied decimal with scale 1e-4'
      - id: attribution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market participant identifier of the order'
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_reference_number
        type: u8
        doc: 'Unique reference number assigned to the new order'
      - id: executed_quantity
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u4
        doc: 'Day unique match number of this execution'
      - id: mpid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the order, if public'
      - id: mpid_counterparty
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the counterparty, if public'
  order_executed_with_price_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_reference_number
        type: u8
        doc: 'Unique reference number assigned to the new order'
      - id: executed_quantity
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u4
        doc: 'Day unique match number of this execution'
      - id: printable
        type: u1
        enum: printable
        doc: 'Whether the execution should be reflected in statistics'
      - id: trade_price
        type: decimal_u4_4
        doc: 'The price at which the order execution occurred. Implied decimal with scale 1e-4'
      - id: mpid_owner
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the order, if public'
      - id: mpid_counterparty
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the counterparty, if public'
  order_cancel_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_reference_number
        type: u8
        doc: 'Unique reference number assigned to the new order'
      - id: canceled_quantity
        type: u4
        doc: 'Number of shares removed from the display size'
  order_delete_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_reference_number
        type: u8
        doc: 'Unique reference number assigned to the new order'
  order_book_flush_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_book
        type: u4
        doc: 'Order book id'
  order_replace_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: original_order_reference_number
        type: u8
        doc: 'Reference number of the order being replaced'
      - id: new_order_reference_number
        type: u8
        doc: 'New reference number for this order'
      - id: quantity
        type: u4
        doc: 'Total number of shares in the order'
      - id: price
        type: decimal_u4_4
        doc: 'Display price of the new order. Implied decimal with scale 1e-4'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_reference_number
        type: u8
        doc: 'Unique reference number assigned to the new order'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Where a non displayed order has been executed'
      - id: quantity
        type: u4
        doc: 'Total number of shares in the order'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: match_number
        type: u4
        doc: 'Day unique match number of this execution'
      - id: trade_price
        type: decimal_u4_4
        doc: 'The price at which the order execution occurred. Implied decimal with scale 1e-4'
      - id: participant_id_buyer
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the buyer, if public'
      - id: participant_id_seller
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Mpid of the seller, if public'
  cross_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: quantity
        type: u4
        doc: 'Total number of shares in the order'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: cross_price
        type: decimal_u4_4
        doc: 'The price at which the cross occurred. Implied decimal with scale 1e-4'
      - id: match_number
        type: u4
        doc: 'Day unique match number of this execution'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The cross session the message is generated for'
      - id: number_of_trades
        type: u4
        doc: 'Number of trades in the cross'
  broken_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: match_number
        type: u4
        doc: 'Day unique match number of this execution'
  noii_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: paired_quantity
        type: u8
        doc: 'Shares eligible to match at the reference price'
      - id: imbalance_quantity
        type: u8
        doc: 'Shares not paired at the reference price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'The market side of the order imbalance'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: equilibrium_price
        type: decimal_u4_4
        doc: 'Equilibrium price if the order book is crossed. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The cross session the message is generated for'
      - id: best_bid_price
        type: decimal_u4_4
        doc: 'Best bid price, or zero if the book is crossed. Implied decimal with scale 1e-4'
      - id: best_bid_quantity
        type: u8
        doc: 'Bid volume at top of book'
      - id: best_ask_price
        type: decimal_u4_4
        doc: 'Best ask price, or zero if the book is crossed. Implied decimal with scale 1e-4'
      - id: best_ask_quantity
        type: u8
        doc: 'Ask volume at top of book'
  moii_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: paired_quantity
        type: u8
        doc: 'Shares eligible to match at the reference price'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: equilibrium_price
        type: decimal_u4_4
        doc: 'Equilibrium price if the order book is crossed. Implied decimal with scale 1e-4'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The cross session the message is generated for'
      - id: cross_level
        type: u1
        enum: cross_level
        doc: 'The level the cross is being generated for'
  execution_summary_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: tracking_number
        type: u2
        doc: 'Nasdaq Nordic internal tracking number'
      - id: order_book
        type: u4
        doc: 'Order book id'
      - id: aggressing_side
        type: u1
        enum: aggressing_side
        doc: 'Side of the incoming aggressive order'
      - id: quantity
        type: u4
        doc: 'Total number of shares in the order'
      - id: hidden_quantity
        type: u4
        doc: 'Total hidden quantity matched'
      - id: stp_cancel_quantity
        type: u4
        doc: 'Quantity deleted due to self trade prevention'
      - id: far_price
        type: decimal_u4_4
        doc: 'Highest or lowest price of the match. Implied decimal with scale 1e-4'
      - id: add_quantity
        type: u4
        doc: 'Lit volume of the aggressive order added to the book'
      - id: number_of_lit_executions
        type: u2
        doc: 'Total number of partial lit executions'
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
  decimal_u8_5:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'Signals a market or data feed handler event'
    0x48:
      id: 'order_book_trading_action_message'
      doc: 'Indicates the current trading status of a security'
    0x52:
      id: 'order_book_directory_message'
      doc: 'Disseminated for all active order books at the start of each trading day'
    0x41:
      id: 'add_order_message'
      doc: 'An order added to the book without Mpid attribution'
    0x46:
      id: 'add_order_mpid_attribution_message'
      doc: 'An order added to the book with Mpid attribution'
    0x45:
      id: 'order_executed_message'
      doc: 'Sent whenever an order on the book is executed in whole or in part'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'An order executed at a price different to its display price'
    0x58:
      id: 'order_cancel_message'
      doc: 'An order on the book modified by a partial cancellation'
    0x44:
      id: 'order_delete_message'
      doc: 'An order on the book being cancelled in full'
    0x59:
      id: 'order_book_flush_message'
      doc: 'An order book is flushed and all orders removed'
    0x55:
      id: 'order_replace_message'
      doc: 'An order on the book has been cancel replaced'
    0x50:
      id: 'trade_message'
      doc: 'Execution details for a match involving non displayable order types'
    0x51:
      id: 'cross_trade_message'
      doc: 'The cross process has completed for a specific security'
    0x42:
      id: 'broken_trade_message'
      doc: 'An execution has been broken and cannot be reinstated'
    0x49:
      id: 'noii_message'
      doc: 'Net order imbalance indicator disseminated during a cross auction'
    0x4a:
      id: 'moii_message'
      doc: 'Auction on demand order imbalance indicator'
    0x4b:
      id: 'execution_summary_message'
      doc: 'Summary information disseminated before the individual trades'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  symbol_state:
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x50:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x49:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    0x4c:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x53:
      id: 'post_trade'
      doc: 'Post Trade'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'auction_period'
      doc: 'Auction Period'
    0x41:
      id: 'trading_at_closing_price'
      doc: 'Trading At Closing Price'
  extension:
    0x45:
      id: 'cross_extension'
      doc: 'Cross Extension'
  financial_product:
    1:
      id: 'stock'
      doc: 'Stock'
    2:
      id: 'equity_warrant'
      doc: 'Equity Warrant'
    3:
      id: 'equity_right'
      doc: 'Equity Right'
    4:
      id: 'bond'
      doc: 'Bond'
    6:
      id: 'lottery_bond_series'
      doc: 'Lottery Bond Series'
    7:
      id: 'convertible'
      doc: 'Convertible'
    8:
      id: 'warrant'
      doc: 'Warrant'
    11:
      id: 'unit_trust_certificate'
      doc: 'Unit Trust Certificate'
    12:
      id: 'index_fund_unit'
      doc: 'Index Fund Unit'
  price_notation:
    0x4d:
      id: 'monetary_value'
      doc: 'Monetary Value'
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  trade_type:
    0x42:
      id: 'main_book'
      doc: 'Main Book'
    0x53:
      id: 'nordic_mid'
      doc: 'Nordic Mid'
  cross_type:
    0x4f:
      id: 'opening_cross'
      doc: 'Opening Cross'
    0x49:
      id: 'scheduled_intraday_cross'
      doc: 'Scheduled Intraday Cross'
    0x43:
      id: 'closing_cross'
      doc: 'Closing Cross'
    0x48:
      id: 'cross_for_halted_securities'
      doc: 'Cross For Halted Securities'
    0x41:
      id: 'auction_on_demand'
      doc: 'Auction On Demand'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders_to_calculate'
      doc: 'Insufficient Orders To Calculate'
  cross_level:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x4d:
      id: 'mid'
      doc: 'Mid'
    0x4c:
      id: 'limit'
      doc: 'Limit'
  aggressing_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'none'
      doc: 'None'

