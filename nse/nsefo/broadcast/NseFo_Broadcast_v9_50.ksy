# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseFo Broadcast NnfBcast v9.50
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: 
#   Encoding: Non-Neat Front End Broadcast
#   Version: 9.50
#   Date: 7/27/2026
#   Specification: TP_FO_Trimmed_NNF_PROTOCOL_9.50_20260820170606.pdf
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
  id: nse_nsefo_broadcast_nnfbcast_v9_50
  title: Nse NseFo Broadcast NnfBcast v9.50
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Futures & Options NnfBcast v9.50'
doc-ref: https://www.nseindia.com/trade/members-trading-software-vendors-api-download

seq:
  - id: bcast_pack_data
    type: bcast_pack_data_struct
    doc: 'BcastPackData sequential packing envelope'

types:
  bcast_pack_data_struct:
    seq:
      - id: net_id
        type: str
        size: 2
        encoding: ASCII
        doc: 'Identifies the segment, 2 for Equity Derivative'
      - id: num_packed_packet
        type: s2
        doc: 'Number of packets sequentially packed in this datagram'
      - id: packed_packet
        type: packed_packet
        repeat: expr
        repeat-expr: num_packed_packet
        doc: 'One sequentially packed broadcast packet'
  packed_packet:
    seq:
      - id: compression_length
        type: s2
        doc: 'Length after compression, zero when the data is uncompressed'
      - id: broadcast_data
        type: broadcast_data
        doc: 'Broadcast data, inflated first when it arrives compressed'
  broadcast_data:
    seq:
      - id: bcast_market_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market the broadcast belongs to, 2 for Futures and Options'
      - id: bcast_reserved
        type: str
        size: 7
        encoding: ASCII
        doc: 'Ignored, the header begins at the ninth byte'
      - id: bcast_header
        type: bcast_header
        doc: 'BCAST_HEADER'
      - id: message_payload
        type:
          switch-on: bcast_header.transaction_code
          cases:
            'transaction_code::broadcast_journal_vct_message': broadcast_journal_vct_message
            'transaction_code::security_open_price_message': security_open_price_message
            'transaction_code::security_master_change_message': security_master_change_message
            'transaction_code::instrument_master_change_message': instrument_master_change_message
            'transaction_code::participant_master_change_message': participant_master_change_message
            'transaction_code::security_status_change_message': security_status_change_message
            'transaction_code::market_by_order_and_market_by_price_message': market_by_order_and_market_by_price_message
            'transaction_code::only_market_by_price_message': only_market_by_price_message
            'transaction_code::enhanced_only_market_by_price_message': enhanced_only_market_by_price_message
            'transaction_code::ticker_and_market_index_message': ticker_and_market_index_message
            'transaction_code::enhanced_ticker_and_market_index_message': enhanced_ticker_and_market_index_message
            'transaction_code::market_watch_round_robin_message': market_watch_round_robin_message
            'transaction_code::enhanced_market_watch_round_robin_message': enhanced_market_watch_round_robin_message
            'transaction_code::indices_message': indices_message
            'transaction_code::industry_index_update_message': industry_index_update_message
            'transaction_code::spread_market_by_price_delta_message': spread_market_by_price_delta_message
            'transaction_code::enhanced_spread_market_by_price_delta_message': enhanced_spread_market_by_price_delta_message
            'transaction_code::asset_open_interest_message': asset_open_interest_message
            'transaction_code::enhanced_asset_open_interest_message': enhanced_asset_open_interest_message
            'transaction_code::limit_price_protection_range_message': limit_price_protection_range_message
            'transaction_code::cas_reference_price_message': cas_reference_price_message
            'transaction_code::turnover_exceeded_message': turnover_exceeded_message
            'transaction_code::turnover_exceeded_message_9011': turnover_exceeded_message
  bcast_header:
    seq:
      - id: reserved_0
        type: str
        size: 2
        encoding: ASCII
        doc: 'Reserved'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        doc: 'Reserved'
      - id: log_time
        type: s4
        doc: 'Time the message was generated by the trading system'
      - id: alpha_char
        type: str
        size: 2
        encoding: ASCII
        doc: 'First two characters of Symbol when the message carries one'
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Type of broadcast message'
      - id: error_code
        type: s2
        doc: 'Zero on broadcast messages'
      - id: bc_seq_no
        type: s4
        doc: 'Broadcast sequence number, used to detect a gap in the stream'
      - id: reserved_18
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved'
      - id: reserved_19
        type: str
        size: 3
        encoding: ASCII
        doc: 'Reserved'
      - id: time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time the message reached the gateway'
      - id: filler_2
        type: str
        size: 8
        encoding: ASCII
        doc: 'Padding, documented as Byte but eight bytes wide'
      - id: message_length
        type: s2
        doc: 'Length of the entire message including the broadcast header'
  broadcast_journal_vct_message:
    seq:
      - id: branch_number
        type: s2
        doc: 'Branch number of the trader''s branch'
      - id: broker_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id of the broker'
      - id: action_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Action code indicating the action taken'
      - id: st_bcast_destination
        type: st_bcast_destination
        doc: 'Destinations the broadcast is intended for'
      - id: reserved_26
        size: 26
        doc: 'Reserved'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message text'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text of the broadcast message'
  st_bcast_destination:
    seq:
      - id: trader_work_station
        type: b1
        doc: 'Destined for the trader workstation'
      - id: control_work_station
        type: b1
        doc: 'Destined for the control workstation'
      - id: tandem
        type: b1
        doc: 'Destined for Tandem'
      - id: journalling_required
        type: b1
        doc: 'Whether the message is to be journalled'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  security_open_price_message:
    seq:
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security'
      - id: series
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series of the security'
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: opening_price
        type: s4
        doc: 'Price at which the security opened'
  security_master_change_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: permitted_to_trade
        type: s2
        enum: permitted_to_trade
        doc: 'Whether the security may be traded'
      - id: issued_capital
        type: floating_point_integer
        doc: 'Issued capital of the security'
      - id: warning_quantity
        type: s4
        doc: 'Quantity above which a warning is raised'
      - id: freeze_quantity
        type: s4
        doc: 'Quantity above which an order freezes'
      - id: credit_rating
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit rating of the security'
      - id: st_sec_eligibility_per_mkt
        type: st_sec_eligibility_per_mkt
        repeat: expr
        repeat-expr: 4
        doc: 'ST_SEC_ELIGIBILITY_PER_MKT'
      - id: issue_rate
        type: s2
        doc: 'Issue rate'
      - id: issue_start_date
        type: s4
        doc: 'Date the issue starts'
      - id: interest_payment_date
        type: s4
        doc: 'Date interest is paid'
      - id: issue_maturity_date
        type: s4
        doc: 'Date the issue matures'
      - id: margin_percentage
        type: s4
        doc: 'Margin percentage'
      - id: minimum_lot_quantity
        type: s4
        doc: 'Minimum lot quantity'
      - id: board_lot_quantity
        type: s4
        doc: 'Regular lot quantity'
      - id: tick_size
        type: s4
        doc: 'Tick size'
      - id: name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the security'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: listing_date
        type: s4
        doc: 'Date the security was listed'
      - id: expulsion_date
        type: s4
        doc: 'Date the security was expelled'
      - id: re_admission_date
        type: s4
        doc: 'Date the security was re admitted'
      - id: record_date
        type: s4
        doc: 'Record date'
      - id: low_price_range
        type: s4
        doc: 'Lowest price allowed'
      - id: high_price_range
        type: s4
        doc: 'Highest price allowed'
      - id: expiry_date
        type: second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: no_delivery_start_date
        type: s4
        doc: 'Start of the no delivery period'
      - id: no_delivery_end_date
        type: s4
        doc: 'End of the no delivery period'
      - id: st_eligibility_indicators
        type: st_eligibility_indicators
        doc: 'Order attributes the security is eligible for'
      - id: book_closure_start_date
        type: s4
        doc: 'Start of book closure'
      - id: book_closure_end_date
        type: s4
        doc: 'End of book closure'
      - id: exercise_start_date
        type: s4
        doc: 'Start of the exercise period'
      - id: exercise_end_date
        type: s4
        doc: 'End of the exercise period'
      - id: old_token
        type: s4
        doc: 'Previous token number'
      - id: asset_instrument
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument of the underlying asset'
      - id: asset_name
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the underlying asset'
      - id: asset_token
        type: s4
        doc: 'Token of the underlying asset'
      - id: intrinsic_value
        type: s4
        doc: 'Intrinsic value'
      - id: extrinsic_value
        type: s4
        doc: 'Extrinsic value'
      - id: st_purpose
        type: st_purpose
        doc: 'Purpose flags of the security'
      - id: local_update_date_time
        type: s4
        doc: 'Time the record was last updated'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the record is deleted'
      - id: remark
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remark'
      - id: base_price
        type: s4
        doc: 'Base price of the security'
  sec_info:
    seq:
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security'
      - id: series
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series of the security'
      - id: expiry_date
        type: second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of an option'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a call or a put'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
  st_sec_eligibility_per_mkt:
    seq:
      - id: security_eligibility_flags
        type: security_eligibility_flags
        doc: 'Whether the security is eligible in this market'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: status
        type: s2
        enum: status
        doc: 'Status of the security in this market'
  security_eligibility_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_17
        type: b7
        doc: 'Reserved'
      - id: eligibility
        type: b1
        doc: 'Security is eligible in this market'
  st_eligibility_indicators:
    seq:
      - id: participate_in_market_index
        type: b1
        doc: 'Participates in the market index'
      - id: aon
        type: b1
        doc: 'Eligible for all or none orders'
      - id: minimum_fill
        type: b1
        doc: 'Eligible for minimum fill orders'
      - id: reserved_113
        type: b13
        doc: 'Reserved'
  st_purpose:
    seq:
      - id: dividend
        type: b1
        doc: 'Dividend'
      - id: rights
        type: b1
        doc: 'Rights'
      - id: bonus
        type: b1
        doc: 'Bonus'
      - id: interest
        type: b1
        doc: 'Interest'
      - id: agm
        type: b1
        doc: 'Annual general meeting'
      - id: egm
        type: b1
        doc: 'Extraordinary general meeting'
      - id: reserved_10
        type: b1
        doc: 'Reserved'
      - id: exercise_style
        type: b1
        doc: 'Exercise style of the option'
      - id: ex_allowed
        type: b1
        doc: 'Exercise allowed'
      - id: ex_rejection_allowed
        type: b1
        doc: 'Exercise rejection allowed'
      - id: pl_allowed
        type: b1
        doc: 'Position liquidation allowed'
      - id: is_this_asset
        type: b1
        doc: 'Record describes the asset itself'
      - id: is_corporate_adjusted
        type: b1
        doc: 'Record has been adjusted for a corporate action'
      - id: reserved_13
        type: b3
        doc: 'Reserved'
  instrument_master_change_message:
    seq:
      - id: instrument_id
        type: s2
        doc: 'Identifier of the instrument'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the instrument'
      - id: instrument_description
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Description of the instrument'
      - id: instrument_update_time
        type: s4
        doc: 'Time the record was last updated'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the record is deleted'
  participant_master_change_message:
    seq:
      - id: participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the participant'
      - id: participant_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the participant'
      - id: participant_status
        type: u1
        enum: participant_status
        doc: 'Status of the participant'
      - id: participant_update_date_time
        type: s4
        doc: 'Time the record was last updated'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the record is deleted'
  security_status_change_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of token and eligibility records'
      - id: token_and_eligibility
        type: token_and_eligibility
        repeat: expr
        repeat-expr: 35
        doc: 'TOKEN_AND_ELIGIBILITY'
  token_and_eligibility:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: st_sec_status_per_market
        type: st_sec_status_per_market
        repeat: expr
        repeat-expr: 4
        doc: 'ST_SEC_STATUS_PER_MARKET'
  st_sec_status_per_market:
    seq:
      - id: status
        type: s2
        enum: status
        doc: 'Status of the security in this market'
  market_by_order_and_market_by_price_message:
    seq:
      - id: st_interactive_mbo_data
        type: st_interactive_mbo_data
        doc: 'ST_INTERACTIVE_MBO_DATA'
      - id: st_mbp_info
        type: st_mbp_info
        repeat: expr
        repeat-expr: 10
        doc: 'ST_MBP_INFO'
      - id: total_buy_quantity_double
        type: floating_point_integer
        doc: 'Total quantity on the buy side'
      - id: total_sell_quantity_double
        type: floating_point_integer
        doc: 'Total quantity on the sell side'
      - id: st_indicator
        type: st_indicator
        doc: 'Side and last trade direction indicators'
      - id: closing_price
        type: s4
        doc: 'Closing price'
      - id: open_price
        type: s4
        doc: 'Opening price'
      - id: high_price
        type: s4
        doc: 'Highest price'
      - id: low_price
        type: s4
        doc: 'Lowest price'
  st_interactive_mbo_data:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the orders belong to'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the contract'
      - id: volume_traded_today_short
        type: u4
        doc: 'Quantity traded today'
      - id: last_traded_price
        type: s4
        doc: 'Price of the last trade'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the net price change'
      - id: net_price_change_from_closing_price
        type: s4
        doc: 'Net price change from the closing price'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity of the last trade'
      - id: last_trade_time
        type: s4
        doc: 'Time of the last trade'
      - id: average_trade_price
        type: s4
        doc: 'Average trade price'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status
        type: s2
        enum: auction_status
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Type of the auction initiator'
      - id: initiator_price
        type: s4
        doc: 'Price offered by the initiator'
      - id: initiator_quantity
        type: s4
        doc: 'Quantity offered by the initiator'
      - id: auction_price
        type: s4
        doc: 'Price of the auction'
      - id: auction_quantity
        type: s4
        doc: 'Quantity of the auction'
      - id: st_mbo_info
        type: st_mbo_info
        repeat: expr
        repeat-expr: 10
        doc: 'ST_MBO_INFO'
  st_mbo_info:
    seq:
      - id: trader_id
        type: s4
        doc: 'User Id that entered the order'
      - id: qty
        type: s4
        doc: 'Quantity of the order'
      - id: price
        type: s4
        doc: 'Price of the order'
      - id: st_mbo_mbp_terms
        type: st_mbo_mbp_terms
        doc: 'Terms attached to an order in the book'
      - id: min_fill_qty
        type: s4
        doc: 'Minimum quantity that must be filled'
  st_mbo_mbp_terms:
    seq:
      - id: mf
        type: b1
        doc: 'Minimum fill order'
      - id: terms_aon
        type: b1
        doc: 'All or none order'
      - id: reserved_114
        type: b14
        doc: 'Reserved'
  st_mbp_info:
    seq:
      - id: qty
        type: s4
        doc: 'Quantity of the order'
      - id: price
        type: s4
        doc: 'Price of the order'
      - id: no_of_orders
        type: s2
        doc: 'Number of orders at this price'
  st_indicator:
    seq:
      - id: last_trade_more
        type: b1
        doc: 'Last trade was above the previous'
      - id: last_trade_less
        type: b1
        doc: 'Last trade was below the previous'
      - id: buy
        type: b1
        doc: 'Buy side present'
      - id: sell
        type: b1
        doc: 'Sell side present'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  only_market_by_price_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of contract records'
      - id: interactive_only_mbp_data
        type: interactive_only_mbp_data
        repeat: expr
        repeat-expr: 2
        doc: 'INTERACTIVE_ONLY_MBP_DATA'
  interactive_only_mbp_data:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the orders belong to'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the contract'
      - id: volume_traded_today_short
        type: u4
        doc: 'Quantity traded today'
      - id: last_traded_price
        type: s4
        doc: 'Price of the last trade'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the net price change'
      - id: vol_trd_today_excd_indc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the traded volume exceeded the field width'
      - id: net_price_change_from_closing_price
        type: s4
        doc: 'Net price change from the closing price'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity of the last trade'
      - id: last_trade_time
        type: s4
        doc: 'Time of the last trade'
      - id: average_trade_price
        type: s4
        doc: 'Average trade price'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status
        type: s2
        enum: auction_status
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Type of the auction initiator'
      - id: initiator_price
        type: s4
        doc: 'Price offered by the initiator'
      - id: initiator_quantity
        type: s4
        doc: 'Quantity offered by the initiator'
      - id: auction_price
        type: s4
        doc: 'Price of the auction'
      - id: auction_quantity
        type: s4
        doc: 'Quantity of the auction'
      - id: mbp_information
        type: mbp_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBP_INFORMATION'
      - id: bb_total_buy_flag
        type: s2
        doc: 'Buy side best price flag'
      - id: bb_total_sell_flag
        type: s2
        doc: 'Sell side best price flag'
      - id: total_buy_quantity_double
        type: floating_point_integer
        doc: 'Total quantity on the buy side'
      - id: total_sell_quantity_double
        type: floating_point_integer
        doc: 'Total quantity on the sell side'
      - id: st_indicator
        type: st_indicator
        doc: 'Side and last trade direction indicators'
      - id: closing_price
        type: s4
        doc: 'Closing price'
      - id: open_price
        type: s4
        doc: 'Opening price'
      - id: high_price
        type: s4
        doc: 'Highest price'
      - id: low_price
        type: s4
        doc: 'Lowest price'
  mbp_information:
    seq:
      - id: quantity_short
        type: s4
        doc: 'Quantity at this price'
      - id: price
        type: s4
        doc: 'Price of the order'
      - id: number_of_orders
        type: s2
        doc: 'Number of orders at this price'
      - id: bb_buy_sell_flag
        type: s2
        doc: 'Buy or sell side'
  enhanced_only_market_by_price_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of contract records'
      - id: enhncd_interactive_only_mbp_data
        type: enhncd_interactive_only_mbp_data
        repeat: expr
        repeat-expr: 2
        doc: 'ENHNCD_INTERACTIVE_ONLY_MBP_DATA'
  enhncd_interactive_only_mbp_data:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the orders belong to'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the contract'
      - id: volume_traded_today_long
        type: s8
        doc: 'Quantity traded today'
      - id: last_traded_price
        type: s4
        doc: 'Price of the last trade'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the net price change'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: net_price_change_from_closing_price
        type: s4
        doc: 'Net price change from the closing price'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity of the last trade'
      - id: last_trade_time
        type: s4
        doc: 'Time of the last trade'
      - id: average_trade_price
        type: s4
        doc: 'Average trade price'
      - id: reserved_14
        size: 14
        doc: 'Reserved'
      - id: imbalance_qty_at_iop
        type: s8
        doc: 'Imbalance quantity at the indicative open price'
      - id: enhncd_mbp_information
        type: enhncd_mbp_information
        repeat: expr
        repeat-expr: 10
        doc: 'ENHNCD_MBP_INFORMATION'
      - id: bb_total_buy_flag
        type: s2
        doc: 'Buy side best price flag'
      - id: bb_total_sell_flag
        type: s2
        doc: 'Sell side best price flag'
      - id: total_buy_quantity_long
        type: s8
        doc: 'Total quantity on the buy side'
      - id: total_sell_quantity_long
        type: s8
        doc: 'Total quantity on the sell side'
      - id: st_indicator
        type: st_indicator
        doc: 'Side and last trade direction indicators'
      - id: closing_price
        type: s4
        doc: 'Closing price'
      - id: open_price
        type: s4
        doc: 'Opening price'
      - id: high_price
        type: s4
        doc: 'Highest price'
      - id: low_price
        type: s4
        doc: 'Lowest price'
  enhncd_mbp_information:
    seq:
      - id: quantity_long
        type: s8
        doc: 'Quantity at this price'
      - id: price
        type: s4
        doc: 'Price of the order'
      - id: number_of_orders
        type: s2
        doc: 'Number of orders at this price'
      - id: bb_buy_sell_flag
        type: s2
        doc: 'Buy or sell side'
  ticker_and_market_index_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of token and eligibility records'
      - id: st_ticker_index_info
        type: st_ticker_index_info
        repeat: expr
        repeat-expr: 17
        doc: 'ST_TICKER_INDEX_INFO'
  st_ticker_index_info:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Market the contract trades in'
      - id: fill_price
        type: s4
        doc: 'Price the trade occurred at'
      - id: fill_volume
        type: s4
        doc: 'Quantity traded'
      - id: open_interest_short
        type: u4
        doc: 'Open interest'
      - id: day_hi_oi_short
        type: u4
        doc: 'Highest open interest of the day'
      - id: day_lo_oi_short
        type: u4
        doc: 'Lowest open interest of the day'
  enhanced_ticker_and_market_index_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of token and eligibility records'
      - id: st_enhncd_ticker_index_info
        type: st_enhncd_ticker_index_info
        repeat: expr
        repeat-expr: 12
        doc: 'ST_ENHNCD_TICKER_INDEX_INFO'
  st_enhncd_ticker_index_info:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Market the contract trades in'
      - id: fill_price
        type: s4
        doc: 'Price the trade occurred at'
      - id: fill_volume
        type: s4
        doc: 'Quantity traded'
      - id: open_interest_long
        type: s8
        doc: 'Open interest'
      - id: day_hi_oi_long
        type: s8
        doc: 'Highest open interest of the day'
      - id: day_lo_oi_long
        type: s8
        doc: 'Lowest open interest of the day'
  market_watch_round_robin_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of contract records'
      - id: st_market_watch_bcast
        type: st_market_watch_bcast
        repeat: expr
        repeat-expr: 4
        doc: 'ST_MARKET_WATCH_BCAST'
  st_market_watch_bcast:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: st_enhncd_mkt_wise_info
        type: st_enhncd_mkt_wise_info
        repeat: expr
        repeat-expr: 3
        doc: 'ST_ENHNCD_MKT_WISE_INFO'
      - id: open_interest_long
        type: s8
        doc: 'Open interest'
  st_enhncd_mkt_wise_info:
    seq:
      - id: st_indicator
        type: st_indicator
        doc: 'Side and last trade direction indicators'
      - id: buy_volume_long
        type: s8
        doc: 'Quantity at the best buy price'
      - id: buy_price
        type: s4
        doc: 'Best buy price'
      - id: sell_volume_long
        type: s8
        doc: 'Quantity at the best sell price'
      - id: sell_price
        type: s4
        doc: 'Best sell price'
      - id: last_trade_price
        type: s4
        doc: 'Price of the last trade'
      - id: last_trade_time
        type: s4
        doc: 'Time of the last trade'
  enhanced_market_watch_round_robin_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of contract records'
      - id: st_enhncd_market_watch_bcast
        type: st_enhncd_market_watch_bcast
        repeat: expr
        repeat-expr: 5
        doc: 'ST_ENHNCD_MARKET_WATCH_BCAST'
  st_enhncd_market_watch_bcast:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: st_mkt_wise_info
        type: st_mkt_wise_info
        repeat: expr
        repeat-expr: 3
        doc: 'ST_MKT_WISE_INFO'
      - id: open_interest_long
        type: s8
        doc: 'Open interest'
  st_mkt_wise_info:
    seq:
      - id: st_indicator
        type: st_indicator
        doc: 'Side and last trade direction indicators'
      - id: buy_volume_short
        type: s4
        doc: 'Quantity at the best buy price'
      - id: buy_price
        type: s4
        doc: 'Best buy price'
      - id: sell_volume_short
        type: s4
        doc: 'Quantity at the best sell price'
      - id: sell_price
        type: s4
        doc: 'Best sell price'
      - id: last_trade_price
        type: s4
        doc: 'Price of the last trade'
      - id: last_trade_time
        type: s4
        doc: 'Time of the last trade'
  indices_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of token and eligibility records'
      - id: ms_indices
        type: ms_indices
        repeat: expr
        repeat-expr: 6
        doc: 'MS_INDICES'
  ms_indices:
    seq:
      - id: index_name
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the index'
      - id: index_value
        type: s4
        doc: 'Current value of the index'
      - id: high_index_value
        type: s4
        doc: 'Highest value of the day'
      - id: low_index_value
        type: s4
        doc: 'Lowest value of the day'
      - id: opening_index
        type: s4
        doc: 'Opening value'
      - id: closing_index
        type: s4
        doc: 'Closing value'
      - id: percent_change
        type: s4
        doc: 'Percentage change'
      - id: yearly_high
        type: s4
        doc: 'Highest value of the year'
      - id: yearly_low
        type: s4
        doc: 'Lowest value of the year'
      - id: no_of_upmoves
        type: s4
        doc: 'Number of upward moves'
      - id: no_of_downmoves
        type: s4
        doc: 'Number of downward moves'
      - id: market_capitalisation
        type: floating_point_integer
        doc: 'Market capitalisation'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the net price change'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
  industry_index_update_message:
    seq:
      - id: no_of_recs
        type: s2
        doc: 'Number of industry index records'
      - id: industry_indices
        type: industry_indices
        repeat: expr
        repeat-expr: 20
        doc: 'INDUSTRY_INDICES'
  industry_indices:
    seq:
      - id: industry_name
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the industry'
      - id: index_value
        type: s4
        doc: 'Current value of the index'
  spread_market_by_price_delta_message:
    seq:
      - id: token_1
        type: s4
        doc: 'Token number of the first leg'
      - id: token_2
        type: s4
        doc: 'Token number of the second leg'
      - id: mbp_buy
        type: s2
        doc: 'Number of buy levels carried'
      - id: mbp_sell
        type: s2
        doc: 'Number of sell levels carried'
      - id: last_active_time
        type: s4
        doc: 'Time the spread was last active'
      - id: traded_volume_short
        type: u4
        doc: 'Quantity traded'
      - id: total_traded_value
        type: floating_point_integer
        doc: 'Total value traded'
      - id: mbp_buys
        type: mbp_buys
        repeat: expr
        repeat-expr: 5
        doc: 'MbpBuys'
      - id: mbp_sells
        type: mbp_sells
        repeat: expr
        repeat-expr: 5
        doc: 'MbpSells'
      - id: total_order_volume
        type: total_order_volume
        doc: 'TotalOrderVolume'
      - id: open_price_difference
        type: s4
        doc: 'Opening price difference'
      - id: day_high_price_difference
        type: s4
        doc: 'Highest price difference of the day'
      - id: day_low_price_difference
        type: s4
        doc: 'Lowest price difference of the day'
      - id: last_traded_price_difference
        type: s4
        doc: 'Last traded price difference'
      - id: last_update_time
        type: s4
        doc: 'Time the record was last updated'
  mbp_buys:
    seq:
      - id: no_orders
        type: s2
        doc: 'Number of orders at this level'
      - id: volume_short
        type: s4
        doc: 'Quantity at this level'
      - id: price
        type: s4
        doc: 'Price of the order'
  mbp_sells:
    seq:
      - id: no_orders
        type: s2
        doc: 'Number of orders at this level'
      - id: volume_short
        type: s4
        doc: 'Quantity at this level'
      - id: price
        type: s4
        doc: 'Price of the order'
  total_order_volume:
    seq:
      - id: total_order_volume_buy
        type: floating_point_integer
        doc: 'Total quantity on the buy side'
      - id: total_order_volume_sell
        type: floating_point_integer
        doc: 'Total quantity on the sell side'
  enhanced_spread_market_by_price_delta_message:
    seq:
      - id: token_1
        type: s4
        doc: 'Token number of the first leg'
      - id: token_2
        type: s4
        doc: 'Token number of the second leg'
      - id: mbp_buy
        type: s2
        doc: 'Number of buy levels carried'
      - id: mbp_sell
        type: s2
        doc: 'Number of sell levels carried'
      - id: last_active_time
        type: s4
        doc: 'Time the spread was last active'
      - id: traded_volume_long
        type: s8
        doc: 'Quantity traded'
      - id: total_traded_value
        type: floating_point_integer
        doc: 'Total value traded'
      - id: enhncd_mbp_buys
        type: enhncd_mbp_buys
        repeat: expr
        repeat-expr: 5
        doc: 'Enhncd_MbpBuys'
      - id: enhncd_mbp_sells
        type: enhncd_mbp_sells
        repeat: expr
        repeat-expr: 5
        doc: 'Enhncd_MbpSells'
      - id: total_order_volume
        type: total_order_volume
        doc: 'TotalOrderVolume'
      - id: open_price_difference
        type: s4
        doc: 'Opening price difference'
      - id: day_high_price_difference
        type: s4
        doc: 'Highest price difference of the day'
      - id: day_low_price_difference
        type: s4
        doc: 'Lowest price difference of the day'
      - id: last_traded_price_difference
        type: s4
        doc: 'Last traded price difference'
      - id: last_update_time
        type: s4
        doc: 'Time the record was last updated'
  enhncd_mbp_buys:
    seq:
      - id: no_orders
        type: s2
        doc: 'Number of orders at this level'
      - id: volume_long
        type: s8
        doc: 'Quantity at this level'
      - id: price
        type: s4
        doc: 'Price of the order'
  enhncd_mbp_sells:
    seq:
      - id: no_orders
        type: s2
        doc: 'Number of orders at this level'
      - id: volume_long
        type: s8
        doc: 'Quantity at this level'
      - id: price
        type: s4
        doc: 'Price of the order'
  asset_open_interest_message:
    seq:
      - id: asset_open_interest
        type: asset_open_interest
        repeat: expr
        repeat-expr: 58
        doc: 'ASSET_OPEN_INTEREST'
  asset_open_interest:
    seq:
      - id: token_no
        type: s4
        doc: 'Token number of the asset'
      - id: current_oi_short
        type: u4
        doc: 'Current open interest'
  enhanced_asset_open_interest_message:
    seq:
      - id: enhncd_open_interest
        type: enhncd_open_interest
        repeat: expr
        repeat-expr: 39
        doc: 'ENHNCD_OPEN_INTEREST'
  enhncd_open_interest:
    seq:
      - id: token_no
        type: s4
        doc: 'Token number of the asset'
      - id: current_oi_long
        type: s8
        doc: 'Current open interest'
  limit_price_protection_range_message:
    seq:
      - id: limit_price_protection_range_data
        type: limit_price_protection_range_data
        doc: 'LIMIT_PRICE_PROTECTION_RANGE_DATA'
  limit_price_protection_range_data:
    seq:
      - id: msg_count
        type: s4
        doc: 'Number of price protection records'
      - id: limit_price_protection_range_detail
        type: limit_price_protection_range_detail
        repeat: expr
        repeat-expr: 25
        doc: 'LIMIT_PRICE_PROTECTION_RANGE_DETAIL'
  limit_price_protection_range_detail:
    seq:
      - id: token_number
        type: s4
        doc: 'Token number of the contract'
      - id: high_exec_band
        type: s4
        doc: 'Upper execution band'
      - id: low_exec_band
        type: s4
        doc: 'Lower execution band'
  cas_reference_price_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of token and eligibility records'
      - id: token_and_ref_price
        type: token_and_ref_price
        repeat: expr
        repeat-expr: 10
        doc: 'TOKEN_AND_REF_PRICE'
  token_and_ref_price:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: reference_price
        type: s4
        doc: 'Call auction reference price'
  turnover_exceeded_message:
    seq:
      - id: turnover_body
        type: turnover_body
        doc: 'Record body selected by Message Length'
  turnover_body:
    seq:
      - id: turnover_payload
        type:
          switch-on: _parent._parent.bcast_header.message_length
          cases:
            98: turnover_limit_exceeded_body
            320: turnover_vct_messages_body
  turnover_limit_exceeded_body:
    seq:
      - id: broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member whose limit was exceeded'
      - id: counter_broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party trading member'
      - id: warning_type
        type: s2
        enum: warning_type
        doc: 'Type of warning raised'
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security'
      - id: expiry_date
        type: second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of an option'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a call or a put'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
      - id: trade_number
        type: s4
        doc: 'Number of the trade'
      - id: trade_price
        type: s4
        doc: 'Price of the trade'
      - id: trade_volume
        type: s4
        doc: 'Quantity of the trade'
      - id: final_field
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether this is the final message'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  turnover_vct_messages_body:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Market the contract trades in'
      - id: st_bcast_destination
        type: st_bcast_destination
        doc: 'Destinations the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message text'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text of the broadcast message'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>

enums:
  transaction_code:
    6501:
      id: 'broadcast_journal_vct_message'
      doc: 'Carries a general message broadcast to the trading terminals'
    6013:
      id: 'security_open_price_message'
      doc: 'Carries the open price of a security once it opens'
    7305:
      id: 'security_master_change_message'
      doc: 'Broadcasts a change to the security master'
    7324:
      id: 'instrument_master_change_message'
      doc: 'Broadcasts a change to the instrument master'
    7306:
      id: 'participant_master_change_message'
      doc: 'Broadcasts a change to the participant master'
    7320:
      id: 'security_status_change_message'
      doc: 'Broadcasts the status of securities across markets'
    7200:
      id: 'market_by_order_and_market_by_price_message'
      doc: 'Broadcasts the order book of a contract, order by order and aggregated by price'
    7208:
      id: 'only_market_by_price_message'
      doc: 'Broadcasts the price aggregated order book for two contracts'
    17208:
      id: 'enhanced_only_market_by_price_message'
      doc: 'Broadcasts the price aggregated order book for two contracts with wider quantity fields'
    7202:
      id: 'ticker_and_market_index_message'
      doc: 'Broadcasts the last trade of each contract as a ticker'
    17202:
      id: 'enhanced_ticker_and_market_index_message'
      doc: 'Broadcasts the ticker with wider open interest fields'
    7201:
      id: 'market_watch_round_robin_message'
      doc: 'Broadcasts the market watch for four contracts in rotation'
    17201:
      id: 'enhanced_market_watch_round_robin_message'
      doc: 'Broadcasts the market watch for five contracts in rotation'
    7207:
      id: 'indices_message'
      doc: 'Broadcasts the value of each market index'
    7203:
      id: 'industry_index_update_message'
      doc: 'Broadcasts the value of each industry index'
    7211:
      id: 'spread_market_by_price_delta_message'
      doc: 'Broadcasts the price aggregated book of a spread combination'
    17211:
      id: 'enhanced_spread_market_by_price_delta_message'
      doc: 'Broadcasts the spread book with wider volume fields'
    7130:
      id: 'asset_open_interest_message'
      doc: 'Broadcasts the open interest of each asset'
    17130:
      id: 'enhanced_asset_open_interest_message'
      doc: 'Broadcasts the open interest of each asset with a wider field'
    7220:
      id: 'limit_price_protection_range_message'
      doc: 'Broadcasts the execution price bands for a set of contracts'
    7338:
      id: 'cas_reference_price_message'
      doc: 'Broadcasts the call auction reference price for a set of contracts'
    9010:
      id: 'turnover_exceeded_message'
      doc: 'Broadcast when a broker''s turnover limit is exceeded or the broker is reactivated. Message Length selects the layout'
    9011:
      id: 'turnover_exceeded_message_9011'
      doc: 'Broadcast when a broker''s turnover limit is exceeded or the broker is reactivated. Message Length selects the layout'
  permitted_to_trade:
    0:
      id: 'listed_but_not_permitted_to_trade'
      doc: 'Listed But Not Permitted To Trade'
    1:
      id: 'permitted_to_trade'
      doc: 'Permitted To Trade'
    2:
      id: 'bse_listed'
      doc: 'Trading Allowed Only In Case Of Outage At Bse'
  status:
    1:
      id: 'pre_open'
      doc: 'Only For Normal Market'
    2:
      id: 'open'
      doc: 'Open'
    3:
      id: 'suspended'
      doc: 'Suspended'
    4:
      id: 'pre_open_extended'
      doc: 'Pre Open Extended'
    5:
      id: 'stock_open_with_market'
      doc: 'Stock Open With Market'
    6:
      id: 'price_discovery'
      doc: 'Price Discovery'
  delete_flag:
    0x59:
      id: 'deleted'
      doc: 'Deleted'
    0x4e:
      id: 'not_deleted'
      doc: 'Not Deleted'
  participant_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x41:
      id: 'active'
      doc: 'Active'
  book_type:
    1:
      id: 'regular_lot_order'
      doc: 'Normal Market'
    2:
      id: 'special_terms_order'
      doc: 'Normal Market'
    3:
      id: 'stop_loss_mit_order'
      doc: 'Normal Market'
    4:
      id: 'negotiated_order'
      doc: 'Normal Market Not Used'
    5:
      id: 'odd_lot_order'
      doc: 'Odd Lot Market Not Used'
    6:
      id: 'spot_order'
      doc: 'Spot Market Not Used'
    7:
      id: 'auction_order'
      doc: 'Auction Market Not Used'
  trading_status:
    1:
      id: 'preopen'
      doc: 'Preopen'
    2:
      id: 'open'
      doc: 'Open'
    3:
      id: 'suspended'
      doc: 'Suspended'
    4:
      id: 'preopen_extended'
      doc: 'Preopen Extended'
    6:
      id: 'price_discovery'
      doc: 'Price Discovery'
  net_change_indicator:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'No Change'
  auction_status:
    0:
      id: 'pre_open'
      doc: 'Only For Normal Market'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'pre_open_ended'
      doc: 'Pre Open Ended'
    4:
      id: 'postclose'
      doc: 'Postclose'
  market_type:
    1:
      id: 'normal_market'
      doc: 'Normal Market'
    2:
      id: 'odd_lot_market'
      doc: 'Not Used'
    3:
      id: 'spot_market'
      doc: 'Not Used'
    4:
      id: 'auction_market'
      doc: 'Not Used'
  warning_type:
    1:
      id: 'turnover_limit_about_to_exceed'
      doc: 'Turnover Limit About To Exceed'
    2:
      id: 'turnover_limit_exceeded'
      doc: 'The Broker Has Been Deactivated'

