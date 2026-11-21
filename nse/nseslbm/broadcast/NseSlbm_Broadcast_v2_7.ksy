# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseSlbm Broadcast NnfBcast v2.7
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: 
#   Encoding: Non-Neat Front End Broadcast
#   Version: 2.7
#   Date: 11/10/2024
#   Specification: Proto_SLBM_NNF_PROTOCOL_2.7.pdf
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
  id: nse_nseslbm_broadcast_nnfbcast_v2_7
  title: Nse NseSlbm Broadcast NnfBcast v2.7
  license: MIT-0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Securities Lending and Borrowing Market NnfBcast v2.7'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

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
            'transaction_code::general_message_broadcast_message': general_message_broadcast_message
            'transaction_code::change_in_system_status_parameters_message': change_in_system_status_parameters_message
            'transaction_code::change_in_security_master_message': change_in_security_master_message
            'transaction_code::change_participant_status_message': change_participant_status_message
            'transaction_code::change_of_security_status_message': change_of_security_status_message
            'transaction_code::change_of_security_status_preopen_message': change_of_security_status_preopen_message
            'transaction_code::turnover_limit_exceeded_message': turnover_limit_exceeded_message
            'transaction_code::broker_reactivated_message': broker_reactivated_message
            'transaction_code::auction_activity_message': auction_activity_message
            'transaction_code::change_of_auction_status_message': change_of_auction_status_message
            'transaction_code::market_open_message': market_open_message
            'transaction_code::market_close_message': market_close_message
            'transaction_code::preopen_shutdown_message': preopen_shutdown_message
            'transaction_code::normal_market_preopen_ended_message': normal_market_preopen_ended_message
            'transaction_code::ticker_and_market_index_message': ticker_and_market_index_message
            'transaction_code::market_by_order_market_by_price_update_message': market_by_order_market_by_price_update_message
            'transaction_code::only_market_by_price_update_message': only_market_by_price_update_message
            'transaction_code::market_watch_update_message': market_watch_update_message
            'transaction_code::security_open_message': security_open_message
            'transaction_code::multiple_index_broadcast_message': multiple_index_broadcast_message
            'transaction_code::broadcast_industry_index_message': broadcast_industry_index_message
            'transaction_code::broadcast_buy_back_information_message': broadcast_buy_back_information_message
            'transaction_code::market_statistics_report_message': market_statistics_report_message
            'transaction_code::contingency_broadcast_message': contingency_broadcast_message
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
  general_message_broadcast_message:
    seq:
      - id: branch_number
        type: s2
        doc: 'Branch number of the trader or broker'
      - id: broker_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID of the broker'
      - id: action_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Action taken'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination of a broadcast message, packed into 2 bytes'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broadcast message'
  broadcast_destination:
    seq:
      - id: trader_ws
        type: b1
        doc: 'The message is for the trader workstation'
      - id: reserved_115
        type: b15
        doc: 'Reserved'
  change_in_system_status_parameters_message:
    seq:
      - id: normal
        type: s2
        enum: normal
        doc: 'Market status of the normal market'
      - id: oddlot
        type: s2
        enum: oddlot
        doc: 'Market status of the odd lot market'
      - id: spot
        type: s2
        enum: spot
        doc: 'Market status of the spot market'
      - id: auction
        type: s2
        enum: auction
        doc: 'Market status of the auction market'
      - id: market_index
        type: s4
        doc: 'Current market index'
      - id: default_settlement_period_normal
        type: s2
        doc: 'Default settlement period of the normal market'
      - id: default_settlement_period_spot
        type: s2
        doc: 'Default settlement period of the spot market'
      - id: default_settlement_period_auction
        type: s2
        doc: 'Default settlement period of the auction market'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: warning_percent
        type: s2
        doc: 'Turnover percentage at which a warning is broadcast to all traders'
      - id: volume_freeze_percent
        type: s2
        doc: 'Turnover percentage at which the broker is deactivated'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: terminal_idle_time
        type: s2
        doc: 'Idle time of the trader workstation'
      - id: board_lot_quantity
        type: s4
        doc: 'Board lot quantity; a regular lot order quantity must be a multiple of it'
      - id: tick_size
        type: decimal_s4_2
        doc: 'Tick size; order and trigger prices must be a multiple of it. Implied decimal with scale 1e-2'
      - id: maximum_gtc_days
        type: s2
        doc: 'Maximum number of days after which a Good Till Cancelled order is cancelled'
      - id: security_eligible_indicators
        type: security_eligible_indicators
        doc: 'Order attributes the system allows, packed into 2 bytes'
      - id: disclosed_quantity_percent_allowed
        type: s2
        doc: 'Disclosed quantity allowed, as a percentage of the total quantity'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
  security_eligible_indicators:
    seq:
      - id: aon
        type: b1
        doc: 'Orders have the all or none attribute set'
      - id: minimum_fill
        type: b1
        doc: 'Orders have the minimum fill attribute set'
      - id: books_merged
        type: b1
        doc: 'Books merged'
      - id: reserved_113
        type: b13
        doc: 'Reserved'
  change_in_security_master_message:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: instrument_type
        type: s2
        enum: instrument_type
        doc: 'Instrument type of the security'
      - id: permitted_to_trade
        type: s2
        enum: permitted_to_trade
        doc: 'Whether the security is permitted to trade'
      - id: issued_capital
        type: floating_point_integer
        doc: 'Issue size of the security'
      - id: warning_percent
        type: s2
        doc: 'Turnover percentage at which a warning is broadcast to all traders'
      - id: freeze_percent
        type: s2
        doc: 'Volume freeze percent'
      - id: credit_rating
        type: str
        size: 17
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit rating of the security'
      - id: security_eligibility_per_market
        type: security_eligibility_per_market
        repeat: expr
        repeat-expr: 4
        doc: 'SECURITY ELIGIBILITY PER MARKET'
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
        doc: 'Maturity date of the issue. Seconds since Dos epoch'
      - id: board_lot_quantity
        type: s4
        doc: 'Board lot quantity; a regular lot order quantity must be a multiple of it'
      - id: tick_size
        type: decimal_s4_2
        doc: 'Tick size; order and trigger prices must be a multiple of it. Implied decimal with scale 1e-2'
      - id: name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security name'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
        doc: 'Date of record changed. Seconds since Dos epoch'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Last date of trading before any corporate action. Seconds since Dos epoch'
      - id: no_delivery_start_date
        type: dos_second_timestamp
        doc: 'Date physical delivery of share certificates stops for book closure. Seconds since Dos epoch'
      - id: no_delivery_end_date
        type: dos_second_timestamp
        doc: 'Date physical delivery of share certificates resumes after book closure. Seconds since Dos epoch'
      - id: eligiblity_indicators
        type: eligiblity_indicators
        doc: 'Order attributes a security allows, packed into 2 bytes'
      - id: book_closure_start_date
        type: dos_second_timestamp
        doc: 'Date the record books of the company start. Seconds since Dos epoch'
      - id: book_closure_end_date
        type: dos_second_timestamp
        doc: 'Date the record books of the company end. Seconds since Dos epoch'
      - id: purpose
        type: purpose
        doc: 'Corporate action flags, packed into 2 bytes'
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
      - id: face_value
        type: s4
        doc: 'Face value of the security'
      - id: isin_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN number of the security'
  sec_info:
    seq:
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of a security'
      - id: series
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series of a security'
  security_eligibility_per_market:
    seq:
      - id: security_eligibility_flags
        type: security_eligibility_flags
        doc: 'Eligibility of a security in one market, packed into 1 byte'
      - id: status
        type: s2
        enum: status
        doc: 'Start or end of the outage'
  security_eligibility_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_17
        type: b7
        doc: 'Reserved'
      - id: eligibility
        type: b1
        doc: 'The security is allowed to trade in the market'
  eligiblity_indicators:
    seq:
      - id: participate_in_market_index
        type: b1
        doc: 'The security participates in the market index'
      - id: aon
        type: b1
        doc: 'Orders have the all or none attribute set'
      - id: minimum_fill
        type: b1
        doc: 'Orders have the minimum fill attribute set'
      - id: indicators_reserved_1113
        type: b3
        doc: 'Reserved'
      - id: allow_recall
        type: b1
        doc: 'The recall order is eligible for the contract'
      - id: allow_repay
        type: b1
        doc: 'The repay order is eligible for the contract'
      - id: indicators_reserved_18
        type: b8
        doc: 'Reserved'
  purpose:
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
      - id: reserved_110
        type: b10
        doc: 'Reserved'
  change_participant_status_message:
    seq:
      - id: participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID'
      - id: participant_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the participant that changed'
      - id: participant_status
        type: u1
        enum: participant_status
        doc: 'Status of the participant'
      - id: participant_update_date_time
        type: dos_second_timestamp
        doc: 'Time the participant information changed, in seconds from January 1 1980. Seconds since Dos epoch'
      - id: delete_flag
        type: u1
        enum: delete_flag
        doc: 'Whether the security is deleted'
  change_of_security_status_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: token_and_eligibility
        type: token_and_eligibility
        repeat: expr
        repeat-expr: 35
        doc: 'TOKEN AND ELIGIBILITY'
  token_and_eligibility:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: security_status_per_market
        type: security_status_per_market
        repeat: expr
        repeat-expr: 4
        doc: 'SECURITY STATUS PER MARKET'
  security_status_per_market:
    seq:
      - id: status
        type: s2
        enum: status
        doc: 'Start or end of the outage'
  change_of_security_status_preopen_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: token_and_eligibility
        type: token_and_eligibility
        repeat: expr
        repeat-expr: 35
        doc: 'TOKEN AND ELIGIBILITY'
  turnover_limit_exceeded_message:
    seq:
      - id: broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker about to exceed or exceeding its turnover limit, or reactivated'
      - id: counter_broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not in use'
      - id: warning_type
        type: s2
        enum: warning_type
        doc: 'Whether the turnover limit is about to be exceeded or exceeded'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: trade_number
        type: s4
        doc: 'Trade in which the broker last traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of the trade. Implied decimal with scale 1e-2'
      - id: trade_volume
        type: s4
        doc: 'Trade quantity of the trade'
      - id: final_field
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether it is the final auction trade'
  broker_reactivated_message:
    seq:
      - id: broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker about to exceed or exceeding its turnover limit, or reactivated'
      - id: counter_broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not in use'
      - id: warning_type
        type: s2
        enum: warning_type
        doc: 'Whether the turnover limit is about to be exceeded or exceeded'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: trade_number
        type: s4
        doc: 'Trade in which the broker last traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of the trade. Implied decimal with scale 1e-2'
      - id: trade_volume
        type: s4
        doc: 'Trade quantity of the trade'
      - id: final_field
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether it is the final auction trade'
  auction_activity_message:
    seq:
      - id: st_auction_inq_info
        type: st_auction_inq_info
        doc: 'ST_AUCTION_INQ_INFO'
  st_auction_inq_info:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status
        type: s2
        enum: auction_status
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Whether the auction was initiated by a trader or by control'
      - id: total_buy_qty
        type: s4
        doc: 'Total buy quantity for the auction'
      - id: best_buy_price
        type: decimal_s4_2
        doc: 'Best buy price, the highest price for a buy auction. Implied decimal with scale 1e-2'
      - id: total_sell_qty
        type: s4
        doc: 'Total sell quantity for the auction'
      - id: best_sell_price
        type: decimal_s4_2
        doc: 'Best sell price, the lowest price for a sell auction. Implied decimal with scale 1e-2'
      - id: auction_price
        type: decimal_s4_2
        doc: 'Price at which the auction trade took place. Implied decimal with scale 1e-2'
      - id: auction_qty
        type: s4
        doc: 'Quantity of securities auctioned'
      - id: settlement_period
        type: s2
        doc: 'Settlement period defaulted by the exchange'
  change_of_auction_status_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status_char
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Status of the auction'
      - id: action_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Action taken'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination of a broadcast message, packed into 2 bytes'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broadcast message'
  market_open_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination of a broadcast message, packed into 2 bytes'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broadcast message'
  market_close_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination of a broadcast message, packed into 2 bytes'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broadcast message'
  preopen_shutdown_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination of a broadcast message, packed into 2 bytes'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broadcast message'
  normal_market_preopen_ended_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination of a broadcast message, packed into 2 bytes'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broadcast message'
  ticker_and_market_index_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: ticker_index_information
        type: ticker_index_information
        repeat: expr
        repeat-expr: 25
        doc: 'TICKER INDEX INFORMATION'
  ticker_index_information:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: fill_volume
        type: s4
        doc: 'Quantity of the security traded'
      - id: market_index_value
        type: s4
        doc: 'Value of the market index'
  market_by_order_market_by_price_update_message:
    seq:
      - id: interactive_mbo_data
        type: interactive_mbo_data
        doc: 'INTERACTIVE MBO DATA'
      - id: mbp_information
        type: mbp_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBP INFORMATION'
      - id: bb_total_buy_flag
        type: s2
        enum: bb_total_buy_flag
        doc: 'Whether there is a buy back order on the buy side'
      - id: bb_total_sell_flag
        type: s2
        doc: 'Currently set to zero'
      - id: total_buy_quantity
        type: floating_point_integer
        doc: 'Total quantity of buy orders in the security'
      - id: total_sell_quantity
        type: floating_point_integer
        doc: 'Total quantity of sell orders in the security'
      - id: mbo_mbp_indicator
        type: mbo_mbp_indicator
        doc: 'Buy, sell and last trade direction flags, packed into 2 bytes'
      - id: closing_price
        type: decimal_s4_2
        doc: 'Closing price of the security. Implied decimal with scale 1e-2'
      - id: open_price
        type: decimal_s4_2
        doc: 'Open price of the security. Implied decimal with scale 1e-2'
      - id: high_price
        type: decimal_s4_2
        doc: 'Highest trade price. Implied decimal with scale 1e-2'
      - id: low_price
        type: decimal_s4_2
        doc: 'Lowest trade price. Implied decimal with scale 1e-2'
  interactive_mbo_data:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the security'
      - id: volume_traded_today
        type: s4
        doc: 'Total quantity of the security traded today'
      - id: last_traded_price
        type: decimal_s4_2
        doc: 'Price of the latest trade in the security. Implied decimal with scale 1e-2'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: net_price_change_from_closing_price
        type: decimal_s4_2
        doc: 'Net change between the order price and the last traded price. Implied decimal with scale 1e-2'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity of the last trade in the security'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time of the last trade in the security. Seconds since Dos epoch'
      - id: average_trade_price
        type: decimal_s4_2
        doc: 'Average price of all the trades in the security. Implied decimal with scale 1e-2'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status
        type: s2
        enum: auction_status
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Whether the auction was initiated by a trader or by control'
      - id: initiator_price
        type: decimal_s4_2
        doc: 'Price of the initiator''s auction order, else zero. Implied decimal with scale 1e-2'
      - id: initiator_quantity
        type: s4
        doc: 'Quantity of the initiator''s auction order, else zero'
      - id: auction_price
        type: decimal_s4_2
        doc: 'Price at which the auction trade took place. Implied decimal with scale 1e-2'
      - id: auction_quantity
        type: s4
        doc: 'Quantity at which the auction takes place, else zero'
      - id: mbo_information
        type: mbo_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBO INFORMATION'
  mbo_information:
    seq:
      - id: trader_id
        type: s4
        doc: 'Trader of the order'
      - id: qty
        type: s4
        doc: 'Quantity of the order'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: st_mbo_mbp_terms
        type: st_mbo_mbp_terms
        doc: 'Minimum fill and all or none terms, packed into 2 bytes'
      - id: min_fill_qty
        type: s4
        doc: 'Minimum fill quantity'
  st_mbo_mbp_terms:
    seq:
      - id: mf
        type: b1
        doc: 'Minimum fill'
      - id: aon
        type: b1
        doc: 'Orders have the all or none attribute set'
      - id: reserved_114
        type: b14
        doc: 'Reserved'
  mbp_information:
    seq:
      - id: quantity
        type: s4
        doc: 'Quantity at the price'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: number_of_orders
        type: s2
        doc: 'Number of orders at the price'
      - id: bb_buy_sell_flag
        type: s2
        doc: 'Buy back buy sell flag'
  mbo_mbp_indicator:
    seq:
      - id: last_trade_more
        type: b1
        doc: 'Latest trade greater than the previous last traded price'
      - id: last_trade_less
        type: b1
        doc: 'Latest trade less than the previous last traded price'
      - id: buy
        type: b1
        doc: 'Buy'
      - id: sell
        type: b1
        doc: 'Sell'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  only_market_by_price_update_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of securities sent'
      - id: interactive_only_mbp_data
        type: interactive_only_mbp_data
        repeat: expr
        repeat-expr: 2
        doc: 'INTERACTIVE ONLY MBP DATA'
  interactive_only_mbp_data:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the security'
      - id: volume_traded_today
        type: s4
        doc: 'Total quantity of the security traded today'
      - id: last_traded_price
        type: decimal_s4_2
        doc: 'Price of the latest trade in the security. Implied decimal with scale 1e-2'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: net_price_change_from_closing_price
        type: decimal_s4_2
        doc: 'Net change between the order price and the last traded price. Implied decimal with scale 1e-2'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity of the last trade in the security'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time of the last trade in the security. Seconds since Dos epoch'
      - id: average_trade_price
        type: decimal_s4_2
        doc: 'Average price of all the trades in the security. Implied decimal with scale 1e-2'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status
        type: s2
        enum: auction_status
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Whether the auction was initiated by a trader or by control'
      - id: initiator_price
        type: decimal_s4_2
        doc: 'Price of the initiator''s auction order, else zero. Implied decimal with scale 1e-2'
      - id: initiator_quantity
        type: s4
        doc: 'Quantity of the initiator''s auction order, else zero'
      - id: auction_price
        type: decimal_s4_2
        doc: 'Price at which the auction trade took place. Implied decimal with scale 1e-2'
      - id: auction_quantity
        type: s4
        doc: 'Quantity at which the auction takes place, else zero'
      - id: mbp_information
        type: mbp_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBP INFORMATION'
      - id: bb_total_buy_flag
        type: s2
        enum: bb_total_buy_flag
        doc: 'Whether there is a buy back order on the buy side'
      - id: bb_total_sell_flag
        type: s2
        doc: 'Currently set to zero'
      - id: total_buy_quantity
        type: floating_point_integer
        doc: 'Total quantity of buy orders in the security'
      - id: total_sell_quantity
        type: floating_point_integer
        doc: 'Total quantity of sell orders in the security'
      - id: mbp_indicator
        type: mbp_indicator
        doc: 'Buy, sell and last trade direction flags, packed into 2 bytes'
      - id: closing_price
        type: decimal_s4_2
        doc: 'Closing price of the security. Implied decimal with scale 1e-2'
      - id: open_price
        type: decimal_s4_2
        doc: 'Open price of the security. Implied decimal with scale 1e-2'
      - id: high_price
        type: decimal_s4_2
        doc: 'Highest trade price. Implied decimal with scale 1e-2'
      - id: low_price
        type: decimal_s4_2
        doc: 'Lowest trade price. Implied decimal with scale 1e-2'
  mbp_indicator:
    seq:
      - id: last_trade_more
        type: b1
        doc: 'Latest trade greater than the previous last traded price'
      - id: last_trade_less
        type: b1
        doc: 'Latest trade less than the previous last traded price'
      - id: buy
        type: b1
        doc: 'Buy'
      - id: sell
        type: b1
        doc: 'Sell'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  market_watch_update_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of securities sent'
      - id: marketwatchbroadcast
        type: marketwatchbroadcast
        repeat: expr
        repeat-expr: 5
        doc: 'MARKETWATCHBROADCAST'
  marketwatchbroadcast:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: market_wise_information
        type: market_wise_information
        repeat: expr
        repeat-expr: 3
        doc: 'MARKET WISE INFORMATION'
  market_wise_information:
    seq:
      - id: mbo_mbp_indicator
        type: mbo_mbp_indicator
        doc: 'Buy, sell and last trade direction flags, packed into 2 bytes'
      - id: buy_volume
        type: s4
        doc: 'Quantity of the best buy order'
      - id: buy_price
        type: decimal_s4_2
        doc: 'Price of the best buy order. Implied decimal with scale 1e-2'
      - id: sell_volume
        type: s4
        doc: 'Quantity of the best sell order'
      - id: sell_price
        type: decimal_s4_2
        doc: 'Price of the best sell order. Implied decimal with scale 1e-2'
      - id: last_trade_price
        type: decimal_s4_2
        doc: 'Latest trade price of the security. Implied decimal with scale 1e-2'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time of the last trade in the security. Seconds since Dos epoch'
  security_open_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: opening_price
        type: decimal_s4_2
        doc: 'Open price of the security. Implied decimal with scale 1e-2'
  multiple_index_broadcast_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: indices
        type: indices
        repeat: expr
        repeat-expr: 6
        doc: 'INDICES'
  indices:
    seq:
      - id: index_name
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the index'
      - id: index_value
        type: s4
        doc: 'Online market index value at the time of broadcast'
      - id: high_index_value
        type: s4
        doc: 'Day''s highest index value'
      - id: low_index_value
        type: s4
        doc: 'Day''s lowest index value'
      - id: opening_index
        type: s4
        doc: 'Opening index value at market open'
      - id: closing_index
        type: s4
        doc: 'Previous day''s closing index while the market is open, today''s after the batch'
      - id: percent_change
        type: s4
        doc: 'Percent change against yesterday''s closing index'
      - id: yearly_high
        type: s4
        doc: 'Highest index in the year'
      - id: yearly_low
        type: s4
        doc: 'Lowest index in the year'
      - id: no_of_upmoves
        type: s4
        doc: 'Number of times the index moved up'
      - id: no_of_downmoves
        type: s4
        doc: 'Number of times the index moved down'
      - id: market_capitalisation
        type: floating_point_integer
        doc: 'Market capitalisation of the securities in the index'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: filler
        size: 1
        doc: 'Filler'
  broadcast_industry_index_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: industry_indices
        type: industry_indices
        repeat: expr
        repeat-expr: 17
        doc: 'INDUSTRY INDICES'
  industry_indices:
    seq:
      - id: index_name
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the index'
      - id: index_value
        type: s4
        doc: 'Online market index value at the time of broadcast'
  broadcast_buy_back_information_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: buybackdata
        type: buybackdata
        repeat: expr
        repeat-expr: 6
        doc: 'BUYBACKDATA'
  buybackdata:
    seq:
      - id: token
        type: s4
        doc: 'Token of the security being updated, unique to a symbol and series'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of a security'
      - id: series
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series of a security'
      - id: pday_cum_vol
        type: floating_point_integer
        doc: 'Previous day cumulative volume'
      - id: pday_high_price
        type: decimal_s4_2
        doc: 'Previous day''s high price. Implied decimal with scale 1e-2'
      - id: pday_low_price
        type: decimal_s4_2
        doc: 'Previous day''s low price. Implied decimal with scale 1e-2'
      - id: pday_wt_avg
        type: decimal_s4_2
        doc: 'Previous day''s weighted average price. Implied decimal with scale 1e-2'
      - id: cday_cum_vol
        type: floating_point_integer
        doc: 'Current day''s cumulative volume'
      - id: cday_high_price
        type: decimal_s4_2
        doc: 'Current day''s high price. Implied decimal with scale 1e-2'
      - id: cday_low_price
        type: decimal_s4_2
        doc: 'Current day''s low price. Implied decimal with scale 1e-2'
      - id: cday_wt_avg
        type: decimal_s4_2
        doc: 'Current day''s weighted average price. Implied decimal with scale 1e-2'
      - id: start_date
        type: dos_second_timestamp
        doc: 'Start date of the buy back period. Seconds since Dos epoch'
      - id: end_date
        type: dos_second_timestamp
        doc: 'End date of the buy back period. Seconds since Dos epoch'
  market_statistics_report_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Header, report data, depository data or trailer'
      - id: report_body
        type:
          switch-on: message_type
          cases:
            'message_type::header': report_header_body
            'message_type::report_data': report_statistics_body
            'message_type::depository_data': report_statistics_body
            'message_type::trailer': report_trailer_body
  report_header_body:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: report_date
        type: dos_second_timestamp
        doc: 'Report date. Seconds since Dos epoch'
      - id: user_type
        type: s2
        doc: 'Type of user, set to minus one'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID, set to blanks'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the broker, set to blanks'
      - id: trader_number
        type: s4
        doc: 'Trader or user ID, set to zero'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trader, set to blanks'
  report_statistics_body:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: market_statistics_data
        type: market_statistics_data
        repeat: expr
        repeat-expr: 7
        doc: 'MARKET STATISTICS DATA'
  market_statistics_data:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: open_price
        type: decimal_s4_2
        doc: 'Open price of the security. Implied decimal with scale 1e-2'
      - id: high_price
        type: decimal_s4_2
        doc: 'Highest trade price. Implied decimal with scale 1e-2'
      - id: low_price
        type: decimal_s4_2
        doc: 'Lowest trade price. Implied decimal with scale 1e-2'
      - id: closing_price
        type: decimal_s4_2
        doc: 'Closing price of the security. Implied decimal with scale 1e-2'
      - id: total_quantity_traded
        type: s4
        doc: 'Total quantity of the security traded today'
      - id: total_value_traded
        type: floating_point_integer
        doc: 'Total value of the securities traded'
      - id: previous_close_price
        type: decimal_s4_2
        doc: 'Previous day''s closing price of the security. Implied decimal with scale 1e-2'
      - id: life_time_high
        type: decimal_s4_2
        doc: 'Highest trade price in the security. Implied decimal with scale 1e-2'
      - id: l_ife_time_low
        type: decimal_s4_2
        doc: 'Lowest trade price in the security. Implied decimal with scale 1e-2'
      - id: corporate_action_indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corporate action'
  report_trailer_body:
    seq:
      - id: number_of_records_long
        type: s4
        doc: 'Number of data packets sent in the bhav copy'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
  contingency_broadcast_message:
    seq:
      - id: stream_number
        type: s2
        doc: 'Impacted stream number, or zero when all streams are impacted'
      - id: outage_status
        type: s2
        enum: outage_status
        doc: 'Start or end of the outage'
      - id: reserved_200
        size: 200
        doc: 'Reserved for future use'
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
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0
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
      id: 'general_message_broadcast_message'
      doc: 'Sent as BCAST_JRNL_VCT_MSG for a general message to all traders'
    7206:
      id: 'change_in_system_status_parameters_message'
      doc: 'Sent as BCAST_SYSTEM_INFORMATION_OUT when global operating parameters or market status change'
    7305:
      id: 'change_in_security_master_message'
      doc: 'Sent as BCAST_SECURITY_MSTR_CHG whenever a parameter of a security changes'
    7306:
      id: 'change_participant_status_message'
      doc: 'Sent as BCAST_PART_MSTR_CHG whenever there is a participant change'
    7320:
      id: 'change_of_security_status_message'
      doc: 'Sent as BCAST_SECURITY_STATUS_CHG when the status of a security changes'
    7210:
      id: 'change_of_security_status_preopen_message'
      doc: 'Sent as BCAST_SECURITY_STATUS_CHG_PREOPEN'
    9010:
      id: 'turnover_limit_exceeded_message'
      doc: 'Sent as BCAST_TURNOVER_EXCEEDED when a broker''s turnover is about to exceed or has exceeded its limit'
    9011:
      id: 'broker_reactivated_message'
      doc: 'Sent as BROADCAST_BROKER_ACTIVATED when a deactivated broker is reactivated'
    6582:
      id: 'auction_activity_message'
      doc: 'Sent as BCAST_AUCTION_INQUIRY_OUT for any auction related activity in CM'
    6581:
      id: 'change_of_auction_status_message'
      doc: 'Sent as BC_AUCTION_STATUS_CHANGE when the status of an auction in CM changes'
    6511:
      id: 'market_open_message'
      doc: 'Sent as BC_OPEN_MESSAGE when the market is opened'
    6521:
      id: 'market_close_message'
      doc: 'Sent as BC_CLOSE_MESSAGE when the market is closed'
    6531:
      id: 'preopen_shutdown_message'
      doc: 'Sent as BC_PREOPEN_SHUTDOWN_MSG when the market is preopened'
    6571:
      id: 'normal_market_preopen_ended_message'
      doc: 'Sent as BC_NORMAL_MKT_PREOPEN_ENDED when the preopen period ends'
    7202:
      id: 'ticker_and_market_index_message'
      doc: 'Sent as BCAST_TICKER_AND_MKT_INDEX with ticker and market index information'
    7200:
      id: 'market_by_order_market_by_price_update_message'
      doc: 'Sent as BCAST_MBO_MBP_UPDATE with the best buy and sell orders and prices'
    7208:
      id: 'only_market_by_price_update_message'
      doc: 'Sent as BCAST_ONLY_MBP with the best buy and sell prices'
    7201:
      id: 'market_watch_update_message'
      doc: 'Sent as BCAST_MW_ROUND_ROBIN with the best buy and sell orders and the last trade'
    6013:
      id: 'security_open_message'
      doc: 'Sent as SECURITY_OPEN_PRICE with the open price of a security when the market opens'
    6541:
      id: 'broadcast_circuit_check_message'
      doc: 'Sent as BC_CIRCUIT_CHECK when the broadcast circuit has carried no data for nine seconds'
    7207:
      id: 'multiple_index_broadcast_message'
      doc: 'Sent as BCAST_INDICES with the CM indices; SLBM itself broadcasts no index'
    7203:
      id: 'broadcast_industry_index_message'
      doc: 'Sent as BCAST_IND_INDICES with industry index values and names'
    7211:
      id: 'broadcast_buy_back_information_message'
      doc: 'Sent as BCAST_BUY_BACK every hour with the buy backs running that day; there is no buy back in SLBM'
    1833:
      id: 'market_statistics_report_message'
      doc: 'Sent as MARKET_STATS_REPORT_DATA for the security bhav copy: header, records and trailer'
    5294:
      id: 'contingency_broadcast_message'
      doc: 'Sent as BCAST_CONTI_MSG at the start and the end of an outage of one or more streams'
  normal:
    0:
      id: 'preopen'
      doc: 'PreOpen, only for the normal market'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_ended'
      doc: 'Preopen ended; chapter 3 describes this value as Suspended'
  oddlot:
    0:
      id: 'preopen'
      doc: 'PreOpen, only for the normal market'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_ended'
      doc: 'Preopen ended; chapter 3 describes this value as Suspended'
  spot:
    0:
      id: 'preopen'
      doc: 'PreOpen, only for the normal market'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_ended'
      doc: 'Preopen ended; chapter 3 describes this value as Suspended'
  auction:
    0:
      id: 'preopen'
      doc: 'PreOpen, only for the normal market'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_ended'
      doc: 'Preopen ended; chapter 3 describes this value as Suspended'
  instrument_type:
    0:
      id: 'equities'
      doc: 'Equities'
    1:
      id: 'preference_shares'
      doc: 'Preference shares'
    2:
      id: 'debentures'
      doc: 'Debentures'
    3:
      id: 'warrants'
      doc: 'Warrants'
    4:
      id: 'miscellaneous'
      doc: 'Miscellaneous'
  permitted_to_trade:
    0:
      id: 'listed_not_permitted'
      doc: 'Listed but not permitted to trade'
    1:
      id: 'permitted'
      doc: 'Permitted to trade'
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
      id: 'preopen_extended'
      doc: 'Preopen extended'
  delete_flag:
    0x59:
      id: 'deleted'
      doc: 'Deleted'
    0x4e:
      id: 'not_deleted'
      doc: 'Not deleted'
  participant_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x41:
      id: 'active'
      doc: 'Active'
  warning_type:
    1:
      id: 'limit_about_to_exceed'
      doc: 'Turnover limit is about to exceed'
    2:
      id: 'limit_exceeded'
      doc: 'Turnover limit is exceeded and the broker is deactivated'
  auction_status:
    1:
      id: 'auction_pending_approval'
      doc: 'AUCTION_PENDING_APPROVAL'
    2:
      id: 'auction_pending'
      doc: 'AUCTION_PENDING'
    3:
      id: 'open_competitor_period'
      doc: 'OPEN_COMPETITIOR_PERIOD'
    4:
      id: 'open_solicitor_period'
      doc: 'OPEN_SOLICITOR_PERIOD'
    5:
      id: 'auction_matching'
      doc: 'AUCTION_MATCHING'
    6:
      id: 'auction_finished'
      doc: 'AUCTION_FINISHED'
    7:
      id: 'auction_cancelled'
      doc: 'AUCTION_CXLED'
  market_type:
    1:
      id: 'normal'
      doc: 'Normal'
    2:
      id: 'odd_lot'
      doc: 'Odd lot'
    3:
      id: 'spot'
      doc: 'Spot'
    4:
      id: 'auction'
      doc: 'Auction'
  book_type:
    1:
      id: 'regular_lot_order'
      doc: 'Normal market'
    2:
      id: 'special_terms_order'
      doc: 'Normal market'
    3:
      id: 'stop_loss_order'
      doc: 'Normal market'
    4:
      id: 'negotiated_order'
      doc: 'Normal market'
    5:
      id: 'odd_lot_order'
      doc: 'Odd lot market'
    6:
      id: 'spot_order'
      doc: 'Spot market'
    7:
      id: 'auction_order'
      doc: 'Auction market'
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
      doc: 'Preopen extended'
  net_change_indicator:
    0x2b:
      id: 'increase'
      doc: 'Increase'
    0x2d:
      id: 'decrease'
      doc: 'Decrease'
    0x20:
      id: 'no_change'
      doc: 'Equal to the previous value'
  bb_total_buy_flag:
    0:
      id: 'no_buy_back_order'
      doc: 'No buy back order on the buy side'
    1:
      id: 'buy_back_order'
      doc: 'A buy back order on the buy side'
  message_type:
    0x48:
      id: 'header'
      doc: 'Header'
    0x52:
      id: 'report_data'
      doc: 'Report data'
    0x44:
      id: 'depository_data'
      doc: 'Data for depository securities'
    0x54:
      id: 'trailer'
      doc: 'Trailer record'
  outage_status:
    0:
      id: 'end_of_outage'
      doc: 'End of outage'
    1:
      id: 'start_of_outage'
      doc: 'Start of outage'

