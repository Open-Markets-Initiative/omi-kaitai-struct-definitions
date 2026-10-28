# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCm Broadcast NnfBcast v6.6
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: 
#   Encoding: Non-Neat Front End Broadcast
#   Version: 6.6
#   Date: 8/3/2026
#   Specification: TP_CM_Trimmed_NNF_PROTOCOL_6.6_20260803151116.pdf
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
  id: nse_nsecm_broadcast_nnfbcast_v6_6
  title: Nse NseCm Broadcast NnfBcast v6.6
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Capital Market NnfBcast v6.6'
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
            'transaction_code::broadcast_journal_vct_message': broadcast_journal_vct_message
            'transaction_code::security_master_change_message': security_master_change_message
            'transaction_code::participant_master_change_message': participant_master_change_message
            'transaction_code::security_status_change_message': security_status_change_message
            'transaction_code::security_status_change_preopen_message': security_status_change_preopen_message
            'transaction_code::turnover_exceeded_message': turnover_exceeded_message
            'transaction_code::broker_reactivated_message': broker_reactivated_message
            'transaction_code::auction_inquiry_message': auction_inquiry_message
            'transaction_code::auction_status_change_message': auction_status_change_message
            'transaction_code::preopen_shutdown_message': preopen_shutdown_message
            'transaction_code::preopen_market_order_restricted_message': preopen_market_order_restricted_message
            'transaction_code::normal_market_preopen_ended_message': normal_market_preopen_ended_message
            'transaction_code::market_open_message': market_open_message
            'transaction_code::cts_close_for_cas_message': cts_close_for_cas_message
            'transaction_code::revised_price_band_completed_message': revised_price_band_completed_message
            'transaction_code::cas_start_message': cas_start_message
            'transaction_code::market_order_restricted_message': market_order_restricted_message
            'transaction_code::cas_end_message': cas_end_message
            'transaction_code::market_close_message': market_close_message
            'transaction_code::closing_start_message': closing_start_message
            'transaction_code::closing_end_message': closing_end_message
            'transaction_code::symbol_status_change_action_message': symbol_status_change_action_message
            'transaction_code::ticker_and_market_index_message': ticker_and_market_index_message
            'transaction_code::market_by_order_and_market_by_price_message': market_by_order_and_market_by_price_message
            'transaction_code::only_market_by_price_message': only_market_by_price_message
            'transaction_code::market_watch_round_robin_message': market_watch_round_robin_message
            'transaction_code::call_auction_market_by_price_message': call_auction_market_by_price_message
            'transaction_code::call_auction_market_watch_message': call_auction_market_watch_message
            'transaction_code::security_open_price_message': security_open_price_message
            'transaction_code::indices_message': indices_message
            'transaction_code::indicative_indices_message': indicative_indices_message
            'transaction_code::indices_vix_message': indices_vix_message
            'transaction_code::industry_indices_message': industry_indices_message
            'transaction_code::buy_back_message': buy_back_message
            'transaction_code::call_auction_order_cancel_update_message': call_auction_order_cancel_update_message
            'transaction_code::cas_reference_price_message': cas_reference_price_message
  bcast_header:
    seq:
      - id: reserved_0
        size: 2
        doc: 'Reserved'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: log_time
        type: s4
        doc: 'Time the message was generated by the trading system'
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
        doc: 'Branch number of the trader or broker'
      - id: broker_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Member Id of the broker'
      - id: action_code_char_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the action taken'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  broadcast_destination:
    seq:
      - id: trader_ws
        type: b1
        doc: 'Destined for the trader workstation'
      - id: reserved_115
        type: b15
        doc: 'Reserved'
  security_master_change_message:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
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
      - id: settlement_type
        type: s2
        enum: settlement_type
        doc: 'Settlement type'
      - id: freeze_percent
        type: decimal_s2_4
        doc: 'Volume freeze percent with respect to issued capital, interpreted as freeze percent divided by 10000. Implied decimal with scale 1e-4'
      - id: credit_rating
        type: str
        size: 19
        encoding: ASCII
        pad-right: 0x20
        doc: 'Daily price range of the security'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: security_eligibility_per_market
        type: security_eligibility_per_market
        repeat: expr
        repeat-expr: 6
        doc: 'SECURITY ELIGIBILITY PER MARKET'
      - id: surv_ind
        type: s2
        doc: 'Indicator for a security in Surveillance Measure'
      - id: issue_start_date
        type: dos_second_timestamp
        doc: 'Date of issue of the security. Seconds since Dos epoch'
      - id: interest_payment_date
        type: dos_second_timestamp
        doc: 'Interest payment date of the issue. Seconds since Dos epoch'
      - id: issue_maturity_date
        type: dos_second_timestamp
        doc: 'Maturity date. Seconds since Dos epoch'
      - id: board_lot_quantity
        type: s4
        doc: 'Regular lot size'
      - id: tick_size
        type: s4
        doc: 'Tick size or minimum spread size'
      - id: name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security name'
      - id: second_reserved_1
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
        doc: 'Date from when physical delivery of share certificates is stopped for book closure. Seconds since Dos epoch'
      - id: no_delivery_end_date
        type: dos_second_timestamp
        doc: 'Date from when physical delivery of share certificates starts after book closure. Seconds since Dos epoch'
      - id: eligiblity_indicators
        type: eligiblity_indicators
        doc: 'Order attributes allowed on this security'
      - id: book_closure_start_date
        type: dos_second_timestamp
        doc: 'Date when the record books in the company for shareholder names starts. Seconds since Dos epoch'
      - id: book_closure_end_date
        type: dos_second_timestamp
        doc: 'Date when the record books in the company for shareholder names ends. Seconds since Dos epoch'
      - id: purpose
        type: purpose
        doc: 'Corporate action the security update carries'
      - id: local_update_date_time
        type: dos_second_timestamp
        doc: 'Local database update date and time. Seconds since Dos epoch'
      - id: delete_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
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
      - id: mkt_maker_spread
        type: s4
        doc: 'Spread value of the security, used by a market maker to place two way quotes'
      - id: mkt_maker_min_qty
        type: s4
        doc: 'Minimum quantity for the security, used by a market maker for a market maker order'
      - id: call_auction_1_flag
        type: s2
        doc: 'Whether the security participates in Call Auction 1'
  sec_info:
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
  security_eligibility_per_market:
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
  eligiblity_indicators:
    seq:
      - id: participate_in_market_index
        type: b1
        doc: 'Security participates in the market index'
      - id: aon
        type: b1
        doc: 'All Or None attribute is allowed in orders of this security'
      - id: minimum_fill
        type: b1
        doc: 'Minimum Fill attribute is allowed in orders of this security'
      - id: reserved_113
        type: b13
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
        doc: 'Annual General Meeting'
      - id: egm
        type: b1
        doc: 'Extraordinary General Meeting'
      - id: reserved_110
        type: b10
        doc: 'Reserved'
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
        doc: 'Name of the participant that is changed'
      - id: participant_status
        type: u1
        enum: participant_status
        doc: 'Status of the participant which is changed'
      - id: participant_update_date_time
        type: dos_second_timestamp
        doc: 'Time when the participant information was changed. Seconds since Dos epoch'
      - id: delete_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is deleted'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
  security_status_change_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: token_and_eligibility
        type: token_and_eligibility
        repeat: expr
        repeat-expr: 25
        doc: 'TOKEN AND ELIGIBILITY'
  token_and_eligibility:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: security_status_per_market
        type: security_status_per_market
        repeat: expr
        repeat-expr: 6
        doc: 'SECURITY STATUS PER MARKET'
  security_status_per_market:
    seq:
      - id: status
        type: s2
        enum: status
        doc: 'Status of the security in this market'
  security_status_change_preopen_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: token_and_eligibility
        type: token_and_eligibility
        repeat: expr
        repeat-expr: 25
        doc: 'TOKEN AND ELIGIBILITY'
  turnover_exceeded_message:
    seq:
      - id: broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker code who is about to exceed or has already exceeded the turnover limit'
      - id: counter_broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not in use'
      - id: warning_type
        type: s2
        enum: warning_type
        doc: 'One if the turnover limit is about to be exceeded, two if it is exceeded and the broker is deactivated'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: trade_number
        type: s4
        doc: 'Trade number in which the broker has last traded'
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
        doc: 'Broker code who is about to exceed or has already exceeded the turnover limit'
      - id: counter_broker_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not in use'
      - id: warning_type
        type: s2
        enum: warning_type
        doc: 'One if the turnover limit is about to be exceeded, two if it is exceeded and the broker is deactivated'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: trade_number
        type: s4
        doc: 'Trade number in which the broker has last traded'
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
  auction_inquiry_message:
    seq:
      - id: st_auction_inq_info
        type: st_auction_inq_info
        doc: 'ST_AUCTION_INQ_INFO'
  st_auction_inq_info:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status_short_2
        type: s2
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Whether the auction is initiated by trader or control'
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
        doc: 'Price at which the auction trade has taken place. Implied decimal with scale 1e-2'
      - id: auction_qty
        type: s4
        doc: 'Quantity of securities that have been auctioned'
      - id: settlement_period
        type: s2
        doc: 'Period by which settlement between the parties should take place'
  auction_status_change_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Status of the auction'
      - id: action_code_char_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the action taken'
      - id: broadcast_destination
        type: broadcast_destination
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  preopen_market_order_restricted_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  cts_close_for_cas_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  revised_price_band_completed_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  cas_start_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  market_order_restricted_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  cas_end_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  closing_start_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  closing_end_message:
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
        doc: 'Destination the broadcast is intended for'
      - id: broadcast_message_length
        type: s2
        doc: 'Length of the broadcast message'
      - id: broadcast_message
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of the broadcast message'
  symbol_status_change_action_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: action_code_short_2
        type: s2
        enum: action_code_short_2
        doc: 'Action code indicating the status the security moved to'
  ticker_and_market_index_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: ticker_index_information
        type: ticker_index_information
        repeat: expr
        repeat-expr: 28
        doc: 'TICKER INDEX INFORMATION'
  ticker_index_information:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Type of market'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order has been traded. Implied decimal with scale 1e-2'
      - id: fill_volume
        type: s4
        doc: 'Quantity of security traded'
      - id: market_index_value
        type: s4
        doc: 'Value of the market index'
  market_by_order_and_market_by_price_message:
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
        doc: 'Whether there is a buyback or market maker order on the buy side'
      - id: bb_total_sell_flag
        type: s2
        enum: bb_total_sell_flag
        doc: 'Currently set to zero'
      - id: total_buy_quantity
        type: s8
        doc: 'Total quantity of buy orders in the security'
      - id: total_sell_quantity
        type: s8
        doc: 'Total quantity of sell orders in the security'
      - id: mbo_mbp_indicator
        type: mbo_mbp_indicator
        doc: 'Flags indicating buy, sell and whether the latest trade is less or greater than the previous one'
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
      - id: reserved_4
        size: 4
        doc: 'Reserved'
  interactive_mbo_data:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: book_type
        type: s2
        doc: 'Book type of the security'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the security'
      - id: volume_traded_today
        type: s8
        doc: 'Total quantity of the security traded on the current day'
      - id: last_traded_price
        type: decimal_s4_2
        doc: 'Price at which the latest trade in the security has taken place. Implied decimal with scale 1e-2'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: net_price_change_from_closing_price
        type: decimal_s4_2
        doc: 'Net change between the order price and the last traded price. Implied decimal with scale 1e-2'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity at which the last trade took place in the security'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time when the last trade took place in the security. Seconds since Dos epoch'
      - id: average_trade_price
        type: decimal_s4_2
        doc: 'Average price of all the trades in the security. Implied decimal with scale 1e-2'
      - id: auction_number
        type: s2
        doc: 'Auction number'
      - id: auction_status_short_2
        type: s2
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Whether the auction is initiated by trader or control'
      - id: initiator_price
        type: decimal_s4_2
        doc: 'Price of the security of the initiator auction order, otherwise zero. Implied decimal with scale 1e-2'
      - id: initiator_quantity
        type: s4
        doc: 'Quantity of the security of the initiator auction order, otherwise zero'
      - id: auction_price
        type: decimal_s4_2
        doc: 'Price at which the auction trade has taken place. Implied decimal with scale 1e-2'
      - id: auction_quantity
        type: s4
        doc: 'Quantity at which the auction in the security takes place, otherwise zero'
      - id: mbo_information
        type: mbo_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBO INFORMATION'
  mbo_information:
    seq:
      - id: trader_id
        type: s4
        doc: 'Trader Id'
      - id: qty
        type: s4
        doc: 'Quantity at the order'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: st_mbo_mbp_terms
        type: st_mbo_mbp_terms
        doc: 'Order terms carried with a market by order record'
      - id: min_fill_qty
        type: s4
        doc: 'Minimum fill quantity'
  st_mbo_mbp_terms:
    seq:
      - id: mf
        type: b1
        doc: 'Minimum Fill order'
      - id: aon
        type: b1
        doc: 'All Or None attribute is allowed in orders of this security'
      - id: reserved_114
        type: b14
        doc: 'Reserved'
  mbp_information:
    seq:
      - id: quantity
        type: s8
        doc: 'Quantity at the price point'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: number_of_orders
        type: s2
        doc: 'Number of orders at the price point'
      - id: bb_buy_sell_flag
        type: s2
        enum: bb_buy_sell_flag
        doc: 'Whether there is a buyback or market maker order on the buy or sell side at the price point'
  mbo_mbp_indicator:
    seq:
      - id: last_trade_more
        type: b1
        doc: 'Latest trade is greater than the immediately previous last traded price'
      - id: last_trade_less
        type: b1
        doc: 'Latest trade is less than the immediately previous last traded price'
      - id: buy
        type: b1
        doc: 'Buy side'
      - id: sell
        type: b1
        doc: 'Sell side'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  only_market_by_price_message:
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
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: book_type
        type: s2
        doc: 'Book type of the security'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the security'
      - id: volume_traded_today
        type: s8
        doc: 'Total quantity of the security traded on the current day'
      - id: last_traded_price
        type: decimal_s4_2
        doc: 'Price at which the latest trade in the security has taken place. Implied decimal with scale 1e-2'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: net_price_change_from_closing_price
        type: decimal_s4_2
        doc: 'Net change between the order price and the last traded price. Implied decimal with scale 1e-2'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity at which the last trade took place in the security'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time when the last trade took place in the security. Seconds since Dos epoch'
      - id: average_trade_price
        type: decimal_s4_2
        doc: 'Average price of all the trades in the security. Implied decimal with scale 1e-2'
      - id: reserved_14
        size: 14
        doc: 'Reserved'
      - id: indicative_imbalance_qty
        type: s8
        doc: 'Indicative imbalance quantity'
      - id: mbp_information
        type: mbp_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBP INFORMATION'
      - id: bb_total_buy_flag
        type: s2
        enum: bb_total_buy_flag
        doc: 'Whether there is a buyback or market maker order on the buy side'
      - id: bb_total_sell_flag
        type: s2
        enum: bb_total_sell_flag
        doc: 'Currently set to zero'
      - id: total_buy_quantity
        type: s8
        doc: 'Total quantity of buy orders in the security'
      - id: total_sell_quantity
        type: s8
        doc: 'Total quantity of sell orders in the security'
      - id: mbp_indicator
        type: mbp_indicator
        doc: 'Flags indicating buy, sell and whether the latest trade is less or greater than the previous one'
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
      - id: indicative_close_price
        type: decimal_s4_2
        doc: 'Indicative close price. Implied decimal with scale 1e-2'
  mbp_indicator:
    seq:
      - id: last_trade_more
        type: b1
        doc: 'Latest trade is greater than the immediately previous last traded price'
      - id: last_trade_less
        type: b1
        doc: 'Latest trade is less than the immediately previous last traded price'
      - id: buy
        type: b1
        doc: 'Buy side'
      - id: sell
        type: b1
        doc: 'Sell side'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  market_watch_round_robin_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: marketwatchbroadcast
        type: marketwatchbroadcast
        repeat: expr
        repeat-expr: 4
        doc: 'MARKETWATCHBROADCAST'
  marketwatchbroadcast:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: market_wise_information
        type: market_wise_information
        repeat: expr
        repeat-expr: 3
        doc: 'MARKET WISE INFORMATION'
  market_wise_information:
    seq:
      - id: mbo_mbp_indicator
        type: mbo_mbp_indicator
        doc: 'Flags indicating buy, sell and whether the latest trade is less or greater than the previous one'
      - id: buy_volume
        type: s8
        doc: 'Quantity of the best buy order'
      - id: buy_price
        type: decimal_s4_2
        doc: 'Price of the best buy order. Implied decimal with scale 1e-2'
      - id: sell_volume
        type: s8
        doc: 'Quantity of the best sell order'
      - id: sell_price
        type: decimal_s4_2
        doc: 'Price of the best sell order. Implied decimal with scale 1e-2'
      - id: last_trade_price
        type: decimal_s4_2
        doc: 'Latest trade price of the security. Implied decimal with scale 1e-2'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time when the last trade took place in the security. Seconds since Dos epoch'
  call_auction_market_by_price_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of securities sent'
      - id: interactive_call_auction_mbp_data
        type: interactive_call_auction_mbp_data
        repeat: expr
        repeat-expr: 2
        doc: 'INTERACTIVE CALL AUCTION MBP DATA'
  interactive_call_auction_mbp_data:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: book_type
        type: s2
        doc: 'Book type of the security'
      - id: trading_status
        type: s2
        enum: trading_status
        doc: 'Trading status of the security'
      - id: volume_traded_today
        type: s8
        doc: 'Total quantity of the security traded on the current day'
      - id: indicative_traded_qty
        type: s8
        doc: 'Indicative traded quantity'
      - id: last_traded_price
        type: decimal_s4_2
        doc: 'Price at which the latest trade in the security has taken place. Implied decimal with scale 1e-2'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: net_price_change_from_closing_price
        type: decimal_s4_2
        doc: 'Net change between the order price and the last traded price. Implied decimal with scale 1e-2'
      - id: last_trade_quantity
        type: s4
        doc: 'Quantity at which the last trade took place in the security'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time when the last trade took place in the security. Seconds since Dos epoch'
      - id: average_trade_price
        type: decimal_s4_2
        doc: 'Average price of all the trades in the security. Implied decimal with scale 1e-2'
      - id: first_open_price
        type: decimal_s4_2
        doc: 'First open price. Implied decimal with scale 1e-2'
      - id: mbp_information
        type: mbp_information
        repeat: expr
        repeat-expr: 10
        doc: 'MBP INFORMATION'
      - id: bb_total_buy_flag
        type: s2
        enum: bb_total_buy_flag
        doc: 'Whether there is a buyback or market maker order on the buy side'
      - id: bb_total_sell_flag
        type: s2
        enum: bb_total_sell_flag
        doc: 'Currently set to zero'
      - id: total_buy_quantity
        type: s8
        doc: 'Total quantity of buy orders in the security'
      - id: total_sell_quantity
        type: s8
        doc: 'Total quantity of sell orders in the security'
      - id: mbp_indicator
        type: mbp_indicator
        doc: 'Flags indicating buy, sell and whether the latest trade is less or greater than the previous one'
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
  call_auction_market_watch_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of securities sent'
      - id: ca_marketwatchbroadcast
        type: ca_marketwatchbroadcast
        repeat: expr
        repeat-expr: 11
        doc: 'CA_MARKETWATCHBROADCAST'
  ca_marketwatchbroadcast:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: mkt_type
        type: s2
        enum: mkt_type
        doc: 'Market type, five for Call Auction 1 and six for Call Auction 2'
      - id: mbo_mbp_indicator
        type: mbo_mbp_indicator
        doc: 'Flags indicating buy, sell and whether the latest trade is less or greater than the previous one'
      - id: buy_volume
        type: s8
        doc: 'Quantity of the best buy order'
      - id: buy_price
        type: decimal_s4_2
        doc: 'Price of the best buy order. Implied decimal with scale 1e-2'
      - id: sell_volume
        type: s8
        doc: 'Quantity of the best sell order'
      - id: sell_price
        type: decimal_s4_2
        doc: 'Price of the best sell order. Implied decimal with scale 1e-2'
      - id: last_trade_price
        type: decimal_s4_2
        doc: 'Latest trade price of the security. Implied decimal with scale 1e-2'
      - id: last_trade_time
        type: dos_second_timestamp
        doc: 'Time when the last trade took place in the security. Seconds since Dos epoch'
  security_open_price_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: token_short_2
        type: s2
        doc: 'Unique number given to a particular symbol series combination'
      - id: opening_price
        type: decimal_s4_2
        doc: 'Open price of the security. Implied decimal with scale 1e-2'
  indices_message:
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
        doc: 'Online market index value at that instance of broadcast'
      - id: high_index_value
        type: s4
        doc: 'Day highest index value at the time of broadcast'
      - id: low_index_value
        type: s4
        doc: 'Day lowest index value at the time of broadcast'
      - id: opening_index
        type: s4
        doc: 'Opening index value at the time of market open'
      - id: closing_index
        type: s4
        doc: 'Previous day closing index while the market is open'
      - id: percent_change
        type: s4
        doc: 'Percent change in the current index with respect to yesterday closing index'
      - id: yearly_high
        type: s4
        doc: 'Highest index in the year'
      - id: yearly_low
        type: s4
        doc: 'Lowest index in the year'
      - id: no_of_upmoves
        type: s4
        doc: 'Number of times the index has moved up with respect to the previous index'
      - id: no_of_downmoves
        type: s4
        doc: 'Number of times the index has moved down with respect to the previous index'
      - id: market_capitalisation
        type: floating_point_integer
        doc: 'Market capitalisation of securities participating in the index'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  indicative_indices_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: indicative_indices
        type: indicative_indices
        repeat: expr
        repeat-expr: 6
        doc: 'INDICATIVE INDICES'
  indicative_indices:
    seq:
      - id: index_name
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the index'
      - id: indicative_close_value
        type: s4
        doc: 'Indicative index close value'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved'
      - id: third_reserved_4
        size: 4
        doc: 'Reserved'
      - id: closing_index
        type: s4
        doc: 'Previous day closing index while the market is open'
      - id: percent_change
        type: s4
        doc: 'Percent change in the current index with respect to yesterday closing index'
      - id: fourth_reserved_4
        size: 4
        doc: 'Reserved'
      - id: fifth_reserved_4
        size: 4
        doc: 'Reserved'
      - id: change
        type: s4
        doc: 'Absolute difference between the indicative closing value and the previous day closing value'
      - id: sixth_reserved_4
        size: 4
        doc: 'Reserved'
      - id: market_capitalization
        type: floating_point_integer
        doc: 'Market capitalisation of securities participating during the indicative close session'
      - id: net_change_indicator
        type: u1
        enum: net_change_indicator
        doc: 'Direction of the change of the order price from the last traded price'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  indices_vix_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: indices
        type: indices
        repeat: expr
        repeat-expr: 6
        doc: 'INDICES'
  industry_indices_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: industry_indices
        type: industry_indices
        repeat: expr
        repeat-expr: 17
        doc: 'INDUSTRY_INDICES'
  industry_indices:
    seq:
      - id: industry_name
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the index'
      - id: index_value
        type: s4
        doc: 'Online market index value at that instance of broadcast'
  buy_back_message:
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
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
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
      - id: pday_cum_vol
        type: floating_point_integer
        doc: 'Previous day cumulative volume'
      - id: pday_high_price
        type: decimal_s4_2
        doc: 'Previous day high price. Implied decimal with scale 1e-2'
      - id: pday_low_price
        type: decimal_s4_2
        doc: 'Previous day low price. Implied decimal with scale 1e-2'
      - id: pday_wt_avg
        type: decimal_s4_2
        doc: 'Previous day weighted average price. Implied decimal with scale 1e-2'
      - id: cday_cum_vol
        type: floating_point_integer
        doc: 'Current day cumulative volume'
      - id: cday_high_price
        type: decimal_s4_2
        doc: 'Current day high price. Implied decimal with scale 1e-2'
      - id: cday_low_price
        type: decimal_s4_2
        doc: 'Current day low price. Implied decimal with scale 1e-2'
      - id: cday_wt_avg
        type: decimal_s4_2
        doc: 'Current day weighted average price. Implied decimal with scale 1e-2'
      - id: start_date
        type: dos_second_timestamp
        doc: 'Start date of the buyback period. Seconds since Dos epoch'
      - id: end_date
        type: dos_second_timestamp
        doc: 'End date of the buyback period. Seconds since Dos epoch'
  call_auction_order_cancel_update_message:
    seq:
      - id: no_of_records
        type: s2
        doc: 'Number of securities sent'
      - id: interactive_ord_cxl_details
        type: interactive_ord_cxl_details
        repeat: expr
        repeat-expr: 8
        doc: 'INTERACTIVE ORD CXL DETAILS'
  interactive_ord_cxl_details:
    seq:
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: buy_ord_cxl_count
        type: s8
        doc: 'Total count of buy orders cancelled for the security during the session'
      - id: buy_ord_cxl_vol
        type: s8
        doc: 'Total quantity of buy orders cancelled for the security during the session'
      - id: sell_ord_cxl_count
        type: s8
        doc: 'Total count of sell orders cancelled for the security during the session'
      - id: sell_ord_cxl_vol
        type: s8
        doc: 'Total quantity of sell orders cancelled for the security during the session'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
  cas_reference_price_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'Number of records of the structure TOKEN AND ELIGIBILITY'
      - id: token_and_refprice
        type: token_and_refprice
        repeat: expr
        repeat-expr: 20
        doc: 'TOKEN AND REFPRICE'
  token_and_refprice:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: token_long_4
        type: s4
        doc: 'Token number of the security being updated'
      - id: reference_price
        type: decimal_s4_2
        doc: 'Reference price of the security. Implied decimal with scale 1e-2'
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>
  decimal_s2_4:
    seq:
      - id: mantissa
        type: s2
    instances:
      real:
        value: mantissa / 10000.0
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

enums:
  transaction_code:
    6501:
      id: 'broadcast_journal_vct_message'
      doc: 'Carries a general message broadcast to the trading terminals'
    18720:
      id: 'security_master_change_message'
      doc: 'Sent whenever a parameter of any security is changed'
    7306:
      id: 'participant_master_change_message'
      doc: 'Sent whenever there is any participant change'
    18130:
      id: 'security_status_change_message'
      doc: 'Sent whenever the status of any security changes'
    18707:
      id: 'security_status_change_preopen_message'
      doc: 'Sent whenever the status of any security changes during the preopen session'
    9010:
      id: 'turnover_exceeded_message'
      doc: 'Sent when a broker turnover is about to exceed or has already exceeded the limit, deactivating the broker'
    9011:
      id: 'broker_reactivated_message'
      doc: 'Sent when a broker is reactivated after being deactivated'
    18700:
      id: 'auction_inquiry_message'
      doc: 'Sent whenever there is any auction related activity, including a change in the auction market by order'
    6581:
      id: 'auction_status_change_message'
      doc: 'Sent when the status of an auction changes'
    6531:
      id: 'preopen_shutdown_message'
      doc: 'Sent when the market is preopened.'
    6664:
      id: 'preopen_market_order_restricted_message'
      doc: 'Sent when market orders restriction starts during the preopen session.'
    6571:
      id: 'normal_market_preopen_ended_message'
      doc: 'Sent when the preopen period ends.'
    6511:
      id: 'market_open_message'
      doc: 'Sent when the market is opened.'
    6651:
      id: 'cts_close_for_cas_message'
      doc: 'Sent when the normal market has closed for securities participating in the closing auction session.'
    6652:
      id: 'revised_price_band_completed_message'
      doc: 'Sent when the price band of securities is revised for the Closing Auction Session.'
    6653:
      id: 'cas_start_message'
      doc: 'Sent when the closing auction session has started.'
    6654:
      id: 'market_order_restricted_message'
      doc: 'Sent when market orders restriction starts during the closing auction session.'
    6655:
      id: 'cas_end_message'
      doc: 'Sent when the closing auction session has ended.'
    6521:
      id: 'market_close_message'
      doc: 'Sent when the market is closed.'
    6583:
      id: 'closing_start_message'
      doc: 'Sent when the closing session is opened.'
    6584:
      id: 'closing_end_message'
      doc: 'Sent when the closing session is closed.'
    7764:
      id: 'symbol_status_change_action_message'
      doc: 'Carries a security level trading or market status change'
    18703:
      id: 'ticker_and_market_index_message'
      doc: 'Carries ticker and market index information'
    7200:
      id: 'market_by_order_and_market_by_price_message'
      doc: 'Carries the best buy orders and the best sell orders of a security'
    7208:
      id: 'only_market_by_price_message'
      doc: 'Carries the best buy and sell prices of a security without the order level detail'
    7201:
      id: 'market_watch_round_robin_message'
      doc: 'Carries the best buy and sell order, their quantities and the last trade price'
    7214:
      id: 'call_auction_market_by_price_message'
      doc: 'Carries Call Auction 2 market data during the preopen session'
    7215:
      id: 'call_auction_market_watch_message'
      doc: 'Carries the market watch data for the Call Auction market'
    6013:
      id: 'security_open_price_message'
      doc: 'Carries the open price of a security when the market opens. The document states this transaction code is not sent by the exchange'
    6541:
      id: 'circuit_check_message'
      doc: 'Pulse sent when there has been no data on the broadcast circuit for a stipulated period, carrying no body beyond the header'
    7207:
      id: 'indices_message'
      doc: 'Carries the multiple index broadcast'
    8207:
      id: 'indicative_indices_message'
      doc: 'Carries the multiple indicative index broadcast, starting half an hour before market close'
    7216:
      id: 'indices_vix_message'
      doc: 'Carries the multiple index broadcast for India VIX'
    7203:
      id: 'industry_indices_message'
      doc: 'Carries the index values of seventeen industry indices with their names'
    18708:
      id: 'buy_back_message'
      doc: 'Carries the buyback information running on that day, broadcast every hour from market open until market close'
    7210:
      id: 'call_auction_order_cancel_update_message'
      doc: 'Carries order cancellation statistics during the Special Preopen Session order collection period'
    7338:
      id: 'cas_reference_price_message'
      doc: 'Sent for CAS enabled securities at the conclusion of the continuous trading session and before the CAS session starts'
  instrument_type:
    0:
      id: 'equities'
      doc: 'Equities'
    1:
      id: 'preference_shares'
      doc: 'Preference Shares'
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
      id: 'listed_but_not_permitted_to_trade'
      doc: 'Listed But Not Permitted To Trade'
    1:
      id: 'permitted_to_trade'
      doc: 'Permitted To Trade'
    2:
      id: 'bse_listed'
      doc: 'Bse Listed'
  settlement_type:
    0:
      id: 't_plus_zero_settlement'
      doc: 'T Plus Zero Settlement'
    1:
      id: 't_plus_one_settlement'
      doc: 'T Plus One Settlement'
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
      doc: 'Preopen Extended'
    6:
      id: 'price_discovery'
      doc: 'Price Discovery'
  participant_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x41:
      id: 'active'
      doc: 'Active'
  warning_type:
    1:
      id: 'turnover_limit_about_to_be_exceeded'
      doc: 'Turnover Limit About To Be Exceeded'
    2:
      id: 'turnover_limit_exceeded_and_the_broker_deactivated'
      doc: 'Turnover Limit Exceeded And The Broker Deactivated'
  market_type:
    1:
      id: 'normal'
      doc: 'Normal'
    2:
      id: 'odd_lot'
      doc: 'Odd Lot'
    3:
      id: 'spot'
      doc: 'Spot'
    4:
      id: 'auction'
      doc: 'Auction'
    5:
      id: 'call_auction_one'
      doc: 'Call Auction One'
    6:
      id: 'call_auction_two'
      doc: 'Call Auction Two'
  action_code_short_2:
    6531:
      id: 'security_preopened'
      doc: 'Security Preopened'
    6571:
      id: 'security_preopen_period_ended'
      doc: 'Security Preopen Period Ended'
    6511:
      id: 'security_opened'
      doc: 'Security Opened'
    6521:
      id: 'security_closed'
      doc: 'Security Closed'
    6583:
      id: 'security_closing_session_opened'
      doc: 'Security Closing Session Opened'
    6584:
      id: 'security_closing_session_closed'
      doc: 'Security Closing Session Closed'
    6651:
      id: 'normal_market_closed_for_securities_participating_in_the_closing_auction_session'
      doc: 'Normal Market Closed For Securities Participating In The Closing Auction Session'
    6652:
      id: 'price_band_of_securities_revised_for_the_closing_auction_session'
      doc: 'Price Band Of Securities Revised For The Closing Auction Session'
    6653:
      id: 'closing_auction_session_started'
      doc: 'Closing Auction Session Started'
    6654:
      id: 'market_orders_restricted_for_the_closing_auction_session'
      doc: 'Market Orders Restricted For The Closing Auction Session'
    6655:
      id: 'closing_auction_session_ended'
      doc: 'Closing Auction Session Ended'
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
  bb_buy_sell_flag:
    0:
      id: 'no_buyback_order_and_no_market_maker_order'
      doc: 'No Buyback Order And No Market Maker Order'
    1:
      id: 'buyback_order'
      doc: 'Buyback Order'
    2:
      id: 'market_maker_order'
      doc: 'Market Maker Order'
    3:
      id: 'buyback_order_and_market_maker_order'
      doc: 'Buyback Order And Market Maker Order'
  bb_total_buy_flag:
    0:
      id: 'no_buyback_order_and_no_market_maker_order'
      doc: 'No Buyback Order And No Market Maker Order'
    1:
      id: 'buyback_order'
      doc: 'Buyback Order'
    2:
      id: 'market_maker_order'
      doc: 'Market Maker Order'
    3:
      id: 'buyback_order_and_market_maker_order'
      doc: 'Buyback Order And Market Maker Order'
  bb_total_sell_flag:
    0:
      id: 'no_buyback_order_and_no_market_maker_order'
      doc: 'No Buyback Order And No Market Maker Order'
    1:
      id: 'buyback_order'
      doc: 'Buyback Order'
    2:
      id: 'market_maker_order'
      doc: 'Market Maker Order'
    3:
      id: 'buyback_order_and_market_maker_order'
      doc: 'Buyback Order And Market Maker Order'
  mkt_type:
    5:
      id: 'call_auction_one'
      doc: 'Call Auction One'
    6:
      id: 'call_auction_two'
      doc: 'Call Auction Two'

