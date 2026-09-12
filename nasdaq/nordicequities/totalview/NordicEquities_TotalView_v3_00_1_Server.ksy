# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicEquities TotalView Glimpse v3.00.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nordic Equity TotalView
#   Encoding: Glimpse
#   Version: 3.00.1
#   Date: 12/01/2015
#   Specification: Nasdaq Nordic INET Equity GLIMPSE (3.00.1).pdf
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
  id: nasdaq_nordicequities_totalview_glimpse_v3_00_1_server
  title: Nasdaq NordicEquities TotalView Glimpse v3.00.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Equities Nordic Equity TotalView Glimpse v3.00.1'
doc-ref: https://www.nasdaq.com/solutions/technical-information-inet-nordic-trading-platform

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
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'TotalView Itch sequence number when the snapshot was taken'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
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
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::order_book_trading_action_message': order_book_trading_action_message
            'sequenced_message_type::order_book_directory_message': order_book_directory_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::add_order_mpid_attribution_message': add_order_mpid_attribution_message
            'sequenced_message_type::end_of_snapshot_message': end_of_snapshot_message
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
  note_codes_bit_field_1:
    meta:
      bit-endian: le
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
    meta:
      bit-endian: le
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
    meta:
      bit-endian: le
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
    meta:
      bit-endian: le
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
    meta:
      bit-endian: le
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
    meta:
      bit-endian: le
    seq:
      - id: reserved_18
        type: b8
  note_codes_bit_field_7:
    meta:
      bit-endian: le
    seq:
      - id: reserved_18
        type: b8
  note_codes_bit_field_8:
    meta:
      bit-endian: le
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
  end_of_snapshot_message:
    seq:
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'TotalView Itch sequence number when the snapshot was taken'
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
  sequenced_message_type:
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
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'Denotes the TotalView Itch sequence number to begin real time processing from'
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

