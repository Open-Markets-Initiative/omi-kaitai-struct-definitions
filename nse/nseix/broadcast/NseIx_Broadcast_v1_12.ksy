# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseIx Broadcast NnfBcast v1.12
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: 
#   Encoding: Non-Neat Front End Broadcast
#   Version: 1.12
#   Date: 10/1/2025
#   Specification: NSEIFSC_Trimmed_NNF_PROTOCOL_20260925143827.pdf
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nse_nseix_broadcast_nnfbcast_v1_12
  title: Nse NseIx Broadcast NnfBcast v1.12
  license: MIT-0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE International Exchange NnfBcast v1.12'
doc-ref: https://www.nseix.com/technology/tradingprotocol

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
        pad-right: 0x20
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
        size: 7
        doc: 'Ignored, the header begins at the ninth byte'
      - id: bcast_header
        type: bcast_header
        doc: 'BCAST_HEADER'
      - id: message_payload
        type:
          switch-on: bcast_header.transaction_code
          cases:
            'transaction_code::broadcast_journal_vct_message': broadcast_journal_vct_message
            'transaction_code::security_master_change_message': security_master_change_message
            'transaction_code::security_master_change_message_7340': security_master_change_message
            'transaction_code::instrument_master_change_message': instrument_master_change_message
            'transaction_code::participant_master_change_message': participant_master_change_message
            'transaction_code::security_status_change_message': security_status_change_message
            'transaction_code::security_status_change_message_7210': security_status_change_message
            'transaction_code::turnover_exceeded_message': turnover_exceeded_message
            'transaction_code::turnover_exceeded_message_9011': turnover_exceeded_message
            'transaction_code::market_status_message': market_status_message
            'transaction_code::market_status_message_6521': market_status_message
            'transaction_code::market_status_message_6522': market_status_message
            'transaction_code::market_status_message_6531': market_status_message
            'transaction_code::market_status_message_6551': market_status_message
            'transaction_code::market_status_message_6571': market_status_message
            'transaction_code::ticker_and_market_index_message': ticker_and_market_index_message
            'transaction_code::market_by_order_and_market_by_price_message': market_by_order_and_market_by_price_message
            'transaction_code::only_market_by_price_message': only_market_by_price_message
            'transaction_code::only_market_by_price_message_7343': only_market_by_price_message
            'transaction_code::market_watch_round_robin_message': market_watch_round_robin_message
            'transaction_code::currency_assets_message': currency_assets_message
            'transaction_code::interest_rate_assets_message': interest_rate_assets_message
            'transaction_code::spread_market_by_price_delta_message': spread_market_by_price_delta_message
            'transaction_code::asset_open_interest_message': asset_open_interest_message
            'transaction_code::asset_interest_rate_change_message': asset_interest_rate_change_message
            'transaction_code::trade_execution_range_message': trade_execution_range_message
            'transaction_code::trade_execution_range_message_7221': trade_execution_range_message
            'transaction_code::trade_execution_range_message_7342': trade_execution_range_message
            'transaction_code::market_by_aggregate_delta_message': market_by_aggregate_delta_message
            'transaction_code::market_by_aggregate_delta_message_7216': market_by_aggregate_delta_message
            'transaction_code::spread_combination_master_change_message': spread_combination_master_change_message
            'transaction_code::spread_combination_master_change_message_7341': spread_combination_master_change_message
  bcast_header:
    seq:
      - id: reserved_0
        size: 2
        doc: 'Reserved'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch'
      - id: alpha_char
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
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
        size: 1
        doc: 'Reserved'
      - id: reserved_19
        size: 3
        doc: 'Reserved'
      - id: time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the message reached the gateway'
      - id: filler_2
        size: 8
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
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text of the broadcast message'
  st_bcast_destination:
    seq:
      - id: trader_workstation
        type: b1
        doc: 'Destined for the trader workstation'
      - id: control_workstation
        type: b1
        doc: 'Destined for the control workstation'
      - id: tandem
        type: b1
        doc: 'Destined for Tandem'
      - id: journaling_required
        type: b1
        doc: 'Whether the message is to be journalled'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  security_master_change_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: permitted_to_trade
        type: s2
        enum: permitted_to_trade
        doc: 'Whether the security is permitted to trade'
      - id: issued_capital
        type: floating_point_integer
        doc: 'Issue size of the security'
      - id: warning_quantity
        type: s4
        doc: 'Warning quantity'
      - id: freeze_quantity
        type: s4
        doc: 'Freeze quantity'
      - id: credit_rating
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit rating of the security'
      - id: st_sec_eligibility_per_market
        type: st_sec_eligibility_per_market
        repeat: expr
        repeat-expr: 4
        doc: 'ST_SEC_ELIGIBILITY_PER_MARKET'
      - id: issue_rate
        type: s2
        doc: 'Price of the issue'
      - id: issue_start_date
        type: dos_second_timestamp
        doc: 'Date of issue of the security. Seconds since Dos epoch'
      - id: interest_payment_date
        type: dos_second_timestamp
        doc: 'Interest payment date of the issue. Seconds since Dos epoch'
      - id: issue_maturity_date
        type: dos_second_timestamp
        doc: 'Maturity date. Seconds since Dos epoch'
      - id: margin_percentage
        type: s4
        doc: 'Initial margin percent to be collected on a contract'
      - id: minimum_lot_quantity
        type: s4
        doc: 'Minimum lot of an order'
      - id: board_lot_quantity
        type: s4
        doc: 'Regular lot size'
      - id: tick_size
        type: s4
        doc: 'Tick size'
      - id: name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security name'
      - id: traded_in_cents
        type: u1
        enum: traded_in_cents
        doc: 'C when the contract is traded in cents'
      - id: listing_date
        type: dos_second_timestamp
        doc: 'Date of listing. Seconds since Dos epoch'
      - id: expulsion_date
        type: dos_second_timestamp
        doc: 'Date of expulsion. Seconds since Dos epoch'
      - id: re_admission_date
        type: dos_second_timestamp
        doc: 'Date of readmission. Seconds since Dos epoch'
      - id: record_date
        type: dos_second_timestamp
        doc: 'Record date. Seconds since Dos epoch'
      - id: low_price_range
        type: s4
        doc: 'Lower price limit of the operating range'
      - id: high_price_range
        type: s4
        doc: 'Upper price limit of the operating range'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Last date of trading before any corporate action. Seconds since Dos epoch'
      - id: no_delivery_start_date
        type: dos_second_timestamp
        doc: 'Date physical delivery stops for book closure. Seconds since Dos epoch'
      - id: no_delivery_end_date
        type: dos_second_timestamp
        doc: 'Date physical delivery starts after book closure. Seconds since Dos epoch'
      - id: st_eligiblity_indicators
        type: st_eligiblity_indicators
        doc: 'Order attributes the security is eligible for'
      - id: book_closure_start_date
        type: dos_second_timestamp
        doc: 'Date the record books for shareholder names start. Seconds since Dos epoch'
      - id: book_closure_end_date
        type: dos_second_timestamp
        doc: 'Date the record books for shareholder names end. Seconds since Dos epoch'
      - id: exercise_start_date
        type: dos_second_timestamp
        doc: 'Starting date for exercise. Seconds since Dos epoch'
      - id: exercise_end_date
        type: dos_second_timestamp
        doc: 'Last date for exercise. Seconds since Dos epoch'
      - id: multiplier
        type: s4
        doc: 'Multiplier of the volume to get the actual quantity'
      - id: asset_instrument
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying asset type'
      - id: asset_name
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the underlying asset'
      - id: asset_token
        type: s4
        doc: 'Token number of the asset'
      - id: intrinsic_value
        type: s4
        doc: 'Intrinsic value of the contract'
      - id: extrinsic_value
        type: s4
        doc: 'Extrinsic value of the contract'
      - id: st_purpose
        type: st_purpose
        doc: 'Corporate action flags of the security'
      - id: local_update_date_time
        type: dos_second_timestamp
        doc: 'Local database update date and time. Seconds since Dos epoch'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the security is deleted'
      - id: remark
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks'
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
        doc: 'Type of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security last traded'
      - id: series
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series of the security'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Last date of trading before any corporate action. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of the contract last traded'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the contract last traded'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
  st_sec_eligibility_per_market:
    seq:
      - id: security_eligibility_flags
        type: security_eligibility_flags
        doc: 'Whether the security is eligible in this market'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
        doc: 'Security is allowed to trade in this market'
  st_eligiblity_indicators:
    seq:
      - id: participate_in_market_index
        type: b1
        doc: 'Security participates in the market index'
      - id: aon
        type: b1
        doc: 'All or none attribute allowed in orders in this security'
      - id: minimum_fill
        type: b1
        doc: 'Minimum fill attribute allowed in orders in this security'
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
        doc: 'Exercise style'
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
        doc: 'Id of the instrument'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the instrument'
      - id: instrument_description
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Full name of the instrument'
      - id: instrument_update_date_time
        type: dos_second_timestamp
        doc: 'Time the record was modified. Seconds since Dos epoch'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the security is deleted'
  participant_master_change_message:
    seq:
      - id: participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant Id'
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
        type: dos_second_timestamp
        doc: 'Time the participant information was changed. Seconds since Dos epoch'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the security is deleted'
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
        doc: 'Token number of the security, unique for a symbol and series'
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
  turnover_exceeded_message:
    seq:
      - id: broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker about to exceed or exceeding the turnover limit'
      - id: counter_broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not in use'
      - id: warning_type
        type: s2
        enum: warning_type
        doc: 'Whether the turnover limit is about to exceed or has exceeded'
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security last traded'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Last date of trading before any corporate action. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of the contract last traded'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the contract last traded'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
      - id: trade_number
        type: s4
        doc: 'Trade number the broker last traded in'
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
        doc: 'Whether it is the final auction trade'
      - id: c_filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  market_status_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: reserved_4
        size: 4
        doc: 'Padding, the specification lists no field at these offsets'
      - id: st_bcast_destination
        type: st_bcast_destination
        doc: 'Destinations the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: market_status_broadcast_message
        type: str
        size: 234
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
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
        doc: 'Token number of the security, unique for a symbol and series'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded'
      - id: fill_volume
        type: s4
        doc: 'Quantity traded'
      - id: open_interest
        type: s4
        doc: 'Open interest'
      - id: day_hi_oi
        type: s4
        doc: 'Highest open interest of the day'
      - id: day_lo_oi
        type: s4
        doc: 'Lowest open interest of the day'
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
      - id: total_buy_quantity
        type: floating_point_integer
        doc: 'Total quantity of buy orders'
      - id: total_sell_quantity
        type: floating_point_integer
        doc: 'Total quantity of sell orders'
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
        doc: 'Highest trade price'
      - id: low_price
        type: s4
        doc: 'Lowest trade price'
  st_interactive_mbo_data:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order of the underlying asset'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the security'
      - id: volume_traded_today
        type: s4
        doc: 'Total quantity traded today'
      - id: last_traded_price
        type: s4
        doc: 'Price of the latest trade'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change from the last traded price'
      - id: net_price_change_from_closing_price
        type: s4
        doc: 'Net change between the closing price and the last traded price'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity of the last trade'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time of the last trade. Seconds since Dos epoch'
      - id: average_trade_price
        type: s4
        doc: 'Average price of the trades'
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
        doc: 'Price of the initiator''s auction order'
      - id: initiator_quantity
        type: s4
        doc: 'Quantity of the initiator''s auction order'
      - id: auction_price
        type: s4
        doc: 'Price at which the auction takes place'
      - id: auction_quantity
        type: s4
        doc: 'Quantity at which the auction takes place'
      - id: st_mbo_info
        type: st_mbo_info
        repeat: expr
        repeat-expr: 10
        doc: 'ST_MBO_INFO'
  st_mbo_info:
    seq:
      - id: trader_id
        type: s4
        doc: 'Trader Id of the order'
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
        doc: 'Minimum fill quantity'
  st_mbo_mbp_terms:
    seq:
      - id: mf
        type: b1
        doc: 'Minimum fill order'
      - id: aon
        type: b1
        doc: 'All or none attribute allowed in orders in this security'
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
        doc: 'Number of orders at the price'
  st_indicator:
    seq:
      - id: last_trade_more
        type: b1
        doc: 'Last trade greater than the previous last traded price'
      - id: last_trade_less
        type: b1
        doc: 'Last trade less than the previous last traded price'
      - id: buy
        type: b1
        doc: 'Buy'
      - id: sell
        type: b1
        doc: 'Sell'
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
        doc: 'Token number of the security, unique for a symbol and series'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order of the underlying asset'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the security'
      - id: volume_traded_today
        type: s4
        doc: 'Total quantity traded today'
      - id: last_traded_price
        type: s4
        doc: 'Price of the latest trade'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change from the last traded price'
      - id: net_price_change_from_closing_price
        type: s4
        doc: 'Net change between the closing price and the last traded price'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity of the last trade'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time of the last trade. Seconds since Dos epoch'
      - id: average_trade_price
        type: s4
        doc: 'Average price of the trades'
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
        doc: 'Price of the initiator''s auction order'
      - id: initiator_quantity
        type: s4
        doc: 'Quantity of the initiator''s auction order'
      - id: auction_price
        type: s4
        doc: 'Price at which the auction takes place'
      - id: auction_quantity
        type: s4
        doc: 'Quantity at which the auction takes place'
      - id: mbp_information
        type: mbp_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBP_INFORMATION'
      - id: bb_total_buy_flag
        type: s2
        doc: 'Buy back flag, zero'
      - id: bb_total_sell_flag
        type: s2
        doc: 'Buy back flag, zero'
      - id: total_buy_quantity
        type: floating_point_integer
        doc: 'Total quantity of buy orders'
      - id: total_sell_quantity
        type: floating_point_integer
        doc: 'Total quantity of sell orders'
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
        doc: 'Highest trade price'
      - id: low_price
        type: s4
        doc: 'Lowest trade price'
  mbp_information:
    seq:
      - id: quantity
        type: s4
        doc: 'Quantity at the price'
      - id: price
        type: s4
        doc: 'Price of the order'
      - id: number_of_orders
        type: s2
        doc: 'Number of orders at the price'
      - id: bb_buy_sell_flag
        type: s2
        doc: 'Buy back flag'
  market_watch_round_robin_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of contract records'
      - id: st_market_watch_bcast
        type: st_market_watch_bcast
        repeat: expr
        repeat-expr: 5
        doc: 'ST_MARKET_WATCH_BCAST'
  st_market_watch_bcast:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: st_mkt_wise_info
        type: st_mkt_wise_info
        repeat: expr
        repeat-expr: 3
        doc: 'ST_MKT_WISE_INFO'
      - id: open_interest
        type: s4
        doc: 'Open interest'
  st_mkt_wise_info:
    seq:
      - id: st_indicator
        type: st_indicator
        doc: 'Side and last trade direction indicators'
      - id: buy_volume
        type: s4
        doc: 'Quantity of the best buy order'
      - id: buy_price
        type: s4
        doc: 'Price of the best buy order'
      - id: sell_volume
        type: s4
        doc: 'Quantity of the best sell order'
      - id: sell_price
        type: s4
        doc: 'Price of the best sell order'
      - id: last_trade_price
        type: s4
        doc: 'Latest trade price'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time of the last trade. Seconds since Dos epoch'
  currency_assets_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: bid_price
        type: s4
        doc: 'Bid price'
      - id: ask_price
        type: s4
        doc: 'Ask price'
      - id: deal_price
        type: s4
        doc: 'Deal price'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security last traded'
      - id: instrument
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument of the underlying asset'
      - id: closing_price
        type: s4
        doc: 'Closing price'
  interest_rate_assets_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security last traded'
      - id: mbp_buy_level
        type: mbp_buy_level
        repeat: expr
        repeat-expr: 5
        doc: 'MbpBuy Level'
      - id: mbp_sell_level
        type: mbp_sell_level
        repeat: expr
        repeat-expr: 5
        doc: 'MbpSell Level'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order of the underlying asset'
      - id: instrument_type
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument type of the underlying asset'
  mbp_buy_level:
    seq:
      - id: order_count
        type: s4
        doc: 'Total number of orders at the price'
      - id: order_price
        type: s4
        doc: 'Price of the orders'
      - id: yield_rate
        type: s4
        doc: 'Yield for the price point'
      - id: order_quantity
        type: floating_point_integer
        doc: 'Total volume ordered at the price'
  mbp_sell_level:
    seq:
      - id: order_count
        type: s4
        doc: 'Total number of orders at the price'
      - id: order_price
        type: s4
        doc: 'Price of the orders'
      - id: yield_rate
        type: s4
        doc: 'Yield for the price point'
      - id: order_quantity
        type: floating_point_integer
        doc: 'Total volume ordered at the price'
  spread_market_by_price_delta_message:
    seq:
      - id: token_1
        type: s4
        doc: 'Token number of the security with the earlier expiry'
      - id: token_2
        type: s4
        doc: 'Token number of the security with the later expiry'
      - id: mbp_buy
        type: s2
        doc: 'Total number of buys for the combination'
      - id: mbp_sell
        type: s2
        doc: 'Total number of sells for the combination'
      - id: last_active_time
        type: dos_second_timestamp
        doc: 'Time the last activity was done. Seconds since Dos epoch'
      - id: traded_volume
        type: s4
        doc: 'Total number of trades today'
      - id: total_traded_value
        type: floating_point_integer
        doc: 'Total value traded, divided by 10000 for the value in US dollars'
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
        doc: 'Price difference of the first spread trade of the day'
      - id: day_high_price_difference
        type: s4
        doc: 'Highest price difference of the day'
      - id: day_low_price_difference
        type: s4
        doc: 'Lowest price difference of the day'
      - id: last_traded_price_difference
        type: s4
        doc: 'Price difference of the latest spread trade'
      - id: last_update_time
        type: dos_second_timestamp
        doc: 'Time the last activity was done. Seconds since Dos epoch'
  mbp_buys:
    seq:
      - id: no_orders
        type: s2
        doc: 'Number of orders at the price'
      - id: volume
        type: s4
        doc: 'Total volume ordered at the price'
      - id: price
        type: s4
        doc: 'Price of the order'
  mbp_sells:
    seq:
      - id: no_orders
        type: s2
        doc: 'Number of orders at the price'
      - id: volume
        type: s4
        doc: 'Total volume ordered at the price'
      - id: price
        type: s4
        doc: 'Price of the order'
  total_order_volume:
    seq:
      - id: total_order_buy
        type: floating_point_integer
        doc: 'Total buy volume ordered for the combination'
      - id: total_order_sell
        type: floating_point_integer
        doc: 'Total sell volume ordered for the combination'
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
        doc: 'Token number of the underlying asset'
      - id: current_oi
        type: s4
        doc: 'Current open interest of the underlying asset'
  asset_interest_rate_change_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: foreign_interest_rate
        type: s2
        doc: 'Foreign interest rate of the asset'
      - id: volatility
        type: s4
        doc: 'Volatility'
      - id: domestic_interest_rate
        type: s2
        doc: 'Domestic interest rate'
  trade_execution_range_message:
    seq:
      - id: trade_execution_range_data
        type: trade_execution_range_data
        doc: 'TRADE_EXECUTION_RANGE_DATA'
  trade_execution_range_data:
    seq:
      - id: msg_count
        type: s4
        doc: 'Number of tokens in the packet'
      - id: trade_execution_range_details
        type: trade_execution_range_details
        repeat: expr
        repeat-expr: 25
        doc: 'TRADE_EXECUTION_RANGE_DETAILS'
  trade_execution_range_details:
    seq:
      - id: token_number
        type: s4
        doc: 'Token number of the contract'
      - id: high_exec_band
        type: s4
        doc: 'High trade execution band'
      - id: low_exec_band
        type: s4
        doc: 'Low trade execution band'
  market_by_aggregate_delta_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the security, unique for a symbol and series'
      - id: no_of_records
        type: s2
        doc: 'Number of contract records'
      - id: market_buy_price
        type: s4
        doc: 'Best buy price for the contract'
      - id: market_sell_price
        type: s4
        doc: 'Best sell price for the contract'
      - id: ideal_price
        type: s4
        doc: 'Average of the best bid and ask prices'
      - id: mba_data
        type: mba_data
        repeat: expr
        repeat-expr: 5
        doc: 'MBA_DATA'
  mba_data:
    seq:
      - id: buy_side
        type: buy_side
        doc: 'BUY_SIDE'
      - id: sell_side
        type: sell_side
        doc: 'SELL_SIDE'
  buy_side:
    seq:
      - id: cumulative_quantity_of_orders
        type: s4
        doc: 'Cumulative quantity, or cumulative value, of orders'
      - id: wap
        type: s4
        doc: 'Weighted average price for the cumulative quantity'
      - id: total_value
        type: floating_point_integer
        doc: 'Total value for the cumulative quantity, in cents'
      - id: impact_cost
        type: s4
        doc: 'Percentage markup over the ideal price'
      - id: order_price
        type: s4
        doc: 'Price of the orders'
  sell_side:
    seq:
      - id: cumulative_quantity_of_orders
        type: s4
        doc: 'Cumulative quantity, or cumulative value, of orders'
      - id: wap
        type: s4
        doc: 'Weighted average price for the cumulative quantity'
      - id: total_value
        type: floating_point_integer
        doc: 'Total value for the cumulative quantity, in cents'
      - id: impact_cost
        type: s4
        doc: 'Percentage markup over the ideal price'
      - id: order_price
        type: s4
        doc: 'Price of the orders'
  spread_combination_master_change_message:
    seq:
      - id: token_1
        type: s4
        doc: 'Token number of the security with the earlier expiry'
      - id: token_2
        type: s4
        doc: 'Token number of the security with the later expiry'
      - id: sec_info_1
        type: sec_info_1
        doc: 'SecInfo1'
      - id: sec_info_2
        type: sec_info_2
        doc: 'SecInfo2'
      - id: reference_price
        type: s4
        doc: 'Settlement price of the first leg, the base of the price difference ranges'
      - id: day_low_price_diff_range
        type: s4
        doc: 'Day low price difference range'
      - id: day_high_price_diff_range
        type: s4
        doc: 'Day high price difference range'
      - id: op_low_price_diff_range
        type: s4
        doc: 'Operating low price difference range'
      - id: op_high_price_diff_range
        type: s4
        doc: 'Operating high price difference range'
      - id: st_spd_eligibility
        type: st_spd_eligibility
        doc: 'Whether the spread combination is allowed to trade'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the security is deleted'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  sec_info_1:
    seq:
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security last traded'
      - id: series
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series of the security'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Last date of trading before any corporate action. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of the contract last traded'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the contract last traded'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
  sec_info_2:
    seq:
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the instrument'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the security last traded'
      - id: series
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series of the security'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Last date of trading before any corporate action. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of the contract last traded'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the contract last traded'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
  st_spd_eligibility:
    meta:
      bit-endian: le
    seq:
      - id: reserved_17
        type: b7
        doc: 'Reserved'
      - id: eligibility
        type: b1
        doc: 'Security is allowed to trade in this market'
  dos_second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      unix_seconds:
        value: time + 315532800
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
    7305:
      id: 'security_master_change_message'
      doc: 'Broadcasts a change to the security master, and periodically the securities changed during the day'
    7340:
      id: 'security_master_change_message_7340'
      doc: 'Broadcasts a change to the security master, and periodically the securities changed during the day'
    7324:
      id: 'instrument_master_change_message'
      doc: 'Broadcasts a change to the instrument master'
    7306:
      id: 'participant_master_change_message'
      doc: 'Broadcasts a change to a participant'
    7320:
      id: 'security_status_change_message'
      doc: 'Broadcasts the status of securities across markets, and in pre open'
    7210:
      id: 'security_status_change_message_7210'
      doc: 'Broadcasts the status of securities across markets, and in pre open'
    9010:
      id: 'turnover_exceeded_message'
      doc: 'Broadcast when a broker''s turnover limit is about to exceed or has exceeded, or when the broker is reactivated'
    9011:
      id: 'turnover_exceeded_message_9011'
      doc: 'Broadcast when a broker''s turnover limit is about to exceed or has exceeded, or when the broker is reactivated'
    6511:
      id: 'market_status_message'
      doc: 'Broadcast when a market opens, closes, enters or leaves pre open or enters or leaves pre close. Transaction Code names which'
    6521:
      id: 'market_status_message_6521'
      doc: 'Broadcast when a market opens, closes, enters or leaves pre open or enters or leaves pre close. Transaction Code names which'
    6522:
      id: 'market_status_message_6522'
      doc: 'Broadcast when a market opens, closes, enters or leaves pre open or enters or leaves pre close. Transaction Code names which'
    6531:
      id: 'market_status_message_6531'
      doc: 'Broadcast when a market opens, closes, enters or leaves pre open or enters or leaves pre close. Transaction Code names which'
    6551:
      id: 'market_status_message_6551'
      doc: 'Broadcast when a market opens, closes, enters or leaves pre open or enters or leaves pre close. Transaction Code names which'
    6571:
      id: 'market_status_message_6571'
      doc: 'Broadcast when a market opens, closes, enters or leaves pre open or enters or leaves pre close. Transaction Code names which'
    7202:
      id: 'ticker_and_market_index_message'
      doc: 'Broadcasts the last trade of each contract as a ticker'
    7200:
      id: 'market_by_order_and_market_by_price_message'
      doc: 'Broadcasts the best buy and sell orders and prices of a contract'
    7208:
      id: 'only_market_by_price_message'
      doc: 'Broadcasts the best buy and sell prices for two contracts, and periodically for the contracts active during the day'
    7343:
      id: 'only_market_by_price_message_7343'
      doc: 'Broadcasts the best buy and sell prices for two contracts, and periodically for the contracts active during the day'
    7201:
      id: 'market_watch_round_robin_message'
      doc: 'Broadcasts the market watch for five contracts in rotation'
    7213:
      id: 'currency_assets_message'
      doc: 'Broadcasts the price details of an asset'
    7214:
      id: 'interest_rate_assets_message'
      doc: 'Broadcasts the five best buy and sell prices of an interest rate asset'
    6541:
      id: 'circuit_check_message'
      doc: 'Pulse sent when there has been no data on the broadcast circuit for a stipulated period, carrying no body beyond the header'
    7211:
      id: 'spread_market_by_price_delta_message'
      doc: 'Broadcasts the best buy and sell prices of a spread combination'
    7130:
      id: 'asset_open_interest_message'
      doc: 'Broadcasts the open interest of each underlying asset'
    6503:
      id: 'asset_interest_rate_change_message'
      doc: 'Broadcast when the interest rates or volatility of an asset change'
    7220:
      id: 'trade_execution_range_message'
      doc: 'Broadcasts the trade execution bands for a set of contracts, periodically, and for negotiated large trades. Transaction Code names which'
    7221:
      id: 'trade_execution_range_message_7221'
      doc: 'Broadcasts the trade execution bands for a set of contracts, periodically, and for negotiated large trades. Transaction Code names which'
    7342:
      id: 'trade_execution_range_message_7342'
      doc: 'Broadcasts the trade execution bands for a set of contracts, periodically, and for negotiated large trades. Transaction Code names which'
    7215:
      id: 'market_by_aggregate_delta_message'
      doc: 'Broadcasts the market by aggregate figures for the exchange defined quantity or value points of a contract. Transaction Code names which'
    7216:
      id: 'market_by_aggregate_delta_message_7216'
      doc: 'Broadcasts the market by aggregate figures for the exchange defined quantity or value points of a contract. Transaction Code names which'
    7309:
      id: 'spread_combination_master_change_message'
      doc: 'Broadcasts a change to the spread combination master, and periodically the combinations changed during the day'
    7341:
      id: 'spread_combination_master_change_message_7341'
      doc: 'Broadcasts a change to the spread combination master, and periodically the combinations changed during the day'
  permitted_to_trade:
    0:
      id: 'listed_but_not_permitted_to_trade'
      doc: 'Listed But Not Permitted To Trade'
    1:
      id: 'permitted_to_trade'
      doc: 'Permitted To Trade'
  status:
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
      id: 'price_discovery'
      doc: 'Price Discovery'
    5:
      id: 'preclose'
      doc: 'Preclose'
  traded_in_cents:
    0x43:
      id: 'traded_in_cents'
      doc: 'Traded In Cents'
  delete_flag:
    0x59:
      id: 'deleted'
      doc: 'Deleted'
    0x4e:
      id: 'active'
      doc: 'Active'
  participant_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x41:
      id: 'active'
      doc: 'Active'
  warning_type:
    1:
      id: 'turnover_limit_about_to_exceed'
      doc: 'Turnover Limit About To Exceed'
    2:
      id: 'turnover_limit_exceeded'
      doc: 'The broker has been deactivated'
  market_type:
    1:
      id: 'normal_market'
      doc: 'Normal Market'
    2:
      id: 'odd_lot_market'
      doc: 'Not used'
    3:
      id: 'spot_market'
      doc: 'Not used'
    4:
      id: 'auction_market'
      doc: 'Not used'
  book_type:
    1:
      id: 'regular_lot_order'
      doc: 'Regular Lot Order'
    2:
      id: 'special_terms_order'
      doc: 'Special Terms Order'
    3:
      id: 'stop_loss_or_mit_order'
      doc: 'Stop Loss Or Mit Order'
    4:
      id: 'negotiated_order_or_nlt'
      doc: 'Negotiated Order Or Nlt'
    5:
      id: 'odd_lot_order'
      doc: 'Not used'
    6:
      id: 'spot_order'
      doc: 'Not used'
    7:
      id: 'auction_order'
      doc: 'Not used'
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
      id: 'price_discovery'
      doc: 'Price Discovery'
    5:
      id: 'preclose'
      doc: 'Preclose'
  net_change_indicator:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
  auction_status:
    0:
      id: 'pre_open'
      doc: 'Only for the normal market'
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

