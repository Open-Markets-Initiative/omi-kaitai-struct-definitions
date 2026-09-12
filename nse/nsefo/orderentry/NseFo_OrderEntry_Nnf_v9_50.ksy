# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseFo OrderEntry Nnf v9.50
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End
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
  id: nse_nsefo_orderentry_nnf_v9_50
  title: Nse NseFo OrderEntry Nnf v9.50
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Futures & Options Order Entry Nnf v9.50'
doc-ref: https://www.nseindia.com/trade/members-trading-software-vendors-api-download

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Nnf interactive message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: message_payload
        size: message_header.message_length - 40
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::sign_on_request_in_message': sign_on_request_in_message
            'transaction_code::sign_on_request_out_message': sign_on_request_out_message
            'transaction_code::sign_off_request_out_message': sign_off_request_out_message
            'transaction_code::system_information_in_message': system_information_in_message
            'transaction_code::system_information_out_message': system_information_out_message
            'transaction_code::gateway_router_request_message': gateway_router_request_message
            'transaction_code::gateway_router_response_message': gateway_router_response_message
            'transaction_code::update_local_database_in_message': update_local_database_in_message
            'transaction_code::update_local_database_header_message': update_local_database_header_message
            'transaction_code::update_local_database_trailer_message': update_local_database_trailer_message
            'transaction_code::download_request_message': download_request_message
            'transaction_code::update_local_database_data_message': update_local_database_data_message
            'transaction_code::message_record_message': message_record_message
            'transaction_code::order_entry_message': order_entry_message
            'transaction_code::order_entry_message_2012': order_entry_message
            'transaction_code::order_entry_message_2040': order_entry_message
            'transaction_code::order_entry_message_2042': order_entry_message
            'transaction_code::order_entry_message_2062': order_entry_message
            'transaction_code::order_entry_message_2070': order_entry_message
            'transaction_code::order_entry_message_2072': order_entry_message
            'transaction_code::order_entry_message_2073': order_entry_message
            'transaction_code::order_entry_message_2074': order_entry_message
            'transaction_code::order_entry_message_2170': order_entry_message
            'transaction_code::order_entry_message_2231': order_entry_message
            'transaction_code::order_entry_message_9002': order_entry_message
            'transaction_code::price_modification_message': price_modification_message
            'transaction_code::price_modification_message_20406': price_modification_message
            'transaction_code::trade_inquiry_message': trade_inquiry_message
            'transaction_code::trade_inquiry_message_5440': trade_inquiry_message
            'transaction_code::trade_inquiry_message_5441': trade_inquiry_message
            'transaction_code::trade_inquiry_message_2223': trade_inquiry_message
            'transaction_code::spread_order_entry_message': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2102': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2104': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2106': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2118': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2124': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2125': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2126': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2127': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2130': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2131': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2132': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2133': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2136': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2154': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2155': spread_order_entry_message
            'transaction_code::spread_order_entry_message_2156': spread_order_entry_message
            'transaction_code::spread_order_entry_message_9004': spread_order_entry_message
            'transaction_code::spread_order_entry_message_20408': spread_order_entry_message
            'transaction_code::spread_order_entry_message_20410': spread_order_entry_message
            'transaction_code::spread_order_entry_message_20412': spread_order_entry_message
            'transaction_code::spread_order_entry_message_20414': spread_order_entry_message
            'transaction_code::spread_order_entry_message_20416': spread_order_entry_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2212': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2282': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2286': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2287': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2288': trade_confirmation_message
            'transaction_code::user_order_limit_update_message': user_order_limit_update_message
            'transaction_code::dealer_limit_update_message': dealer_limit_update_message
            'transaction_code::spread_order_limit_update_message': spread_order_limit_update_message
            'transaction_code::control_message_to_trader_message': control_message_to_trader_message
            'transaction_code::market_statistics_report_message': market_statistics_report_message
            'transaction_code::enhanced_market_statistics_report_message': enhanced_market_statistics_report_message
            'transaction_code::market_index_report_message': market_index_report_message
            'transaction_code::industry_index_report_message': industry_index_report_message
            'transaction_code::sector_index_report_message': sector_index_report_message
            'transaction_code::spread_bhavcopy_message': spread_bhavcopy_message
            'transaction_code::global_indices_message': global_indices_message
            'transaction_code::global_contracts_message': global_contracts_message
            'transaction_code::secure_box_registration_request_in_message': secure_box_registration_request_in_message
            'transaction_code::box_sign_on_request_in_message': box_sign_on_request_in_message
            'transaction_code::box_sign_on_request_out_message': box_sign_on_request_out_message
            'transaction_code::box_sign_off_message': box_sign_off_message
            'transaction_code::contingency_broadcast_message': contingency_broadcast_message
            'transaction_code::branch_order_value_limit_update_message': branch_order_value_limit_update_message
            'transaction_code::user_order_value_limit_update_message': user_order_value_limit_update_message
            'transaction_code::normal_order_limit_update_message': normal_order_limit_update_message
            'transaction_code::reset_user_password_message': reset_user_password_message
            'transaction_code::collateral_user_status_change_request_message': collateral_user_status_change_request_message
            'transaction_code::collateral_user_status_change_response_message': collateral_user_status_change_response_message
            'transaction_code::user_trade_modify_cancel_status_change_request_message': user_trade_modify_cancel_status_change_request_message
            'transaction_code::user_trade_modify_cancel_status_change_response_message': user_trade_modify_cancel_status_change_response_message
            'transaction_code::user_address_unlock_request_message': user_address_unlock_request_message
            'transaction_code::user_address_unlock_confirm_message': user_address_unlock_confirm_message
            'transaction_code::user_address_unlock_approve_message': user_address_unlock_approve_message
            'transaction_code::giveup_confirmation_message': giveup_confirmation_message
            'transaction_code::giveup_confirmation_message_4507': giveup_confirmation_message
            'transaction_code::order_cancellation_confirmation_message': order_cancellation_confirmation_message
  message_header:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Transaction code of the record carried'
      - id: log_time
        type: second_timestamp
        doc: 'Time the record was logged. Seconds since Dos epoch'
      - id: alpha_char
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Alpha characters of the record'
      - id: trader_id
        type: s4
        doc: 'Trader Id of the connected user'
      - id: error_code
        type: s2
        enum: error_code
        doc: 'Error code of the record'
      - id: header_timestamp
        type: nanosecond_timestamp
        doc: 'Host end field, carrying nanoseconds since midnight 01-Jan-1980 on the transaction codes listed in the appendix. Nanoseconds since Dos epoch'
      - id: time_stamp_1
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Current time in jiffies from the host, 65536 jiffies to the second'
      - id: time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of the machine the packet came from'
      - id: message_length
        type: s2
        doc: 'Length of the record including this header'
  sign_on_request_in_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password of the user'
      - id: second_reserved_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: new_password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'New password when the user is changing it'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trader'
      - id: last_password_change_date
        type: second_timestamp
        doc: 'Date the password was last changed. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: version_number
        type: s4
        doc: 'Version number of the front end'
      - id: batch_2_start_time
        type: second_timestamp
        doc: 'Start time of the second batch. Seconds since Dos epoch'
      - id: host_switch_context
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Host switch context'
      - id: colour
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Colour'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: user_type
        type: s2
        doc: 'Type of the user'
      - id: sequence_number
        type: floating_point_integer
        doc: 'Sequence number'
      - id: ws_class_name
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Workstation class name'
      - id: broker_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Status of the trading member'
      - id: show_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the index is shown'
      - id: st_broker_eligibility_per_mkt
        type: st_broker_eligibility_per_mkt
        doc: 'Markets the trading member may place orders in'
      - id: member_type
        type: s2
        doc: 'Type of the trading member'
      - id: clearing_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing status of the trading member'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trading member'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: second_reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: third_reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  st_broker_eligibility_per_mkt:
    meta:
      bit-endian: le
    seq:
      - id: pre_open
        type: b1
        doc: 'Eligible for the pre open market'
      - id: reserved_212
        type: b11
        doc: 'Reserved'
      - id: auction_market
        type: b1
        doc: 'Eligible for the auction market'
      - id: spot_market
        type: b1
        doc: 'Eligible for the spot market'
      - id: oddlot_market
        type: b1
        doc: 'Eligible for the odd lot market'
      - id: normal_market
        type: b1
        doc: 'Eligible for the normal market'
  sign_on_request_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password of the user'
      - id: second_reserved_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: new_password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'New password when the user is changing it'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trader'
      - id: last_password_change_date
        type: second_timestamp
        doc: 'Date the password was last changed. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: version_number
        type: s4
        doc: 'Version number of the front end'
      - id: end_time
        type: second_timestamp
        doc: 'End time. Seconds since Dos epoch'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: colour
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Colour'
      - id: third_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: user_type
        type: s2
        doc: 'Type of the user'
      - id: sequence_number
        type: floating_point_integer
        doc: 'Sequence number'
      - id: reserved_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: broker_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Status of the trading member'
      - id: show_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the index is shown'
      - id: st_broker_eligibility_per_mkt
        type: st_broker_eligibility_per_mkt
        doc: 'Markets the trading member may place orders in'
      - id: member_type
        type: s2
        doc: 'Type of the trading member'
      - id: clearing_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing status of the trading member'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trading member'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: second_reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: third_reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  sign_off_request_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_145
        type: str
        size: 145
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  system_information_in_message:
    seq:
      - id: last_update_portfolio_t_ime
        type: second_timestamp
        doc: 'Time the portfolio was last updated. Seconds since Dos epoch'
  system_information_out_message:
    seq:
      - id: st_market_status
        type: st_market_status
        doc: 'ST_MARKET_STATUS'
      - id: st_ex_market_status
        type: st_ex_market_status
        doc: 'ST_EX_MARKET_STATUS'
      - id: st_pl_market_status
        type: st_pl_market_status
        doc: 'ST_PL_MARKET_STATUS'
      - id: update_portfolio
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the portfolio is to be updated'
      - id: market_index
        type: s4
        doc: 'Current market index'
      - id: default_settlement_period_normal
        type: s2
        doc: 'Default settlement period for the normal market'
      - id: default_settlement_period_spot
        type: s2
        doc: 'Default settlement period for the spot market'
      - id: default_settlement_period_auction
        type: s2
        doc: 'Default settlement period for the auction market'
      - id: competitor_period
        type: s2
        doc: 'Competitor period'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor period'
      - id: warning_percent
        type: s2
        doc: 'Warning percentage'
      - id: volume_freeze_percent
        type: s2
        doc: 'Volume freeze percentage'
      - id: snap_quote_time
        type: s2
        doc: 'Snap quote time'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: board_lot_quantity
        type: s4
        doc: 'Regular lot quantity'
      - id: tick_size
        type: s4
        doc: 'Tick size'
      - id: maximum_gtc_days
        type: s2
        doc: 'Maximum number of days a Gtc order may live'
      - id: st_stock_eligible_indicators
        type: st_stock_eligible_indicators
        doc: 'Order attributes the security is eligible for'
      - id: disclosed_quantity_percent_allowed
        type: s2
        doc: 'Minimum disclosed quantity percentage allowed'
      - id: risk_free_interest_rate
        type: s4
        doc: 'Risk free interest rate'
  st_market_status:
    seq:
      - id: market_status_normal
        type: s2
        enum: market_status_normal
        doc: 'Status of the normal market'
      - id: market_status_oddlot
        type: s2
        enum: market_status_oddlot
        doc: 'Status of the odd lot market'
      - id: market_status_spot
        type: s2
        enum: market_status_spot
        doc: 'Status of the spot market'
      - id: market_status_auction
        type: s2
        enum: market_status_auction
        doc: 'Status of the auction market'
  st_ex_market_status:
    seq:
      - id: ex_market_status_normal
        type: s2
        enum: ex_market_status_normal
        doc: 'Status of the normal market'
      - id: ex_market_status_oddlot
        type: s2
        enum: ex_market_status_oddlot
        doc: 'Status of the odd lot market'
      - id: ex_market_status_spot
        type: s2
        enum: ex_market_status_spot
        doc: 'Status of the spot market'
      - id: ex_market_status_auction
        type: s2
        enum: ex_market_status_auction
        doc: 'Status of the auction market'
  st_pl_market_status:
    seq:
      - id: pl_market_status_normal
        type: s2
        enum: pl_market_status_normal
        doc: 'Status of the normal market'
      - id: pl_market_status_oddlot
        type: s2
        enum: pl_market_status_oddlot
        doc: 'Status of the odd lot market'
      - id: pl_market_status_spot
        type: s2
        enum: pl_market_status_spot
        doc: 'Status of the spot market'
      - id: pl_market_status_auction
        type: s2
        enum: pl_market_status_auction
        doc: 'Status of the auction market'
  st_stock_eligible_indicators:
    meta:
      bit-endian: le
    seq:
      - id: reserved_113
        type: b13
        doc: 'Reserved'
      - id: books_merged
        type: b1
        doc: 'Whether the books are merged'
      - id: minimum_fill
        type: b1
        doc: 'Eligible for minimum fill orders'
      - id: eligible_aon
        type: b1
        doc: 'Eligible for all or none orders'
  gateway_router_request_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id used for this connection'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  gateway_router_response_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id used for this connection'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: ip_address
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ip address assigned by the exchange'
      - id: port
        type: s4
        doc: 'Port number given by the exchange'
      - id: session_key
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session key to be used for authentication'
      - id: cryptographic_key
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Key encrypting every message to the allocated gateway'
      - id: cryptographic_tail
        type: cryptographic_tail
        doc: 'Initialisation vectors, layout selected by Message Length'
  cryptographic_tail:
    seq:
      - id: cryptographic_payload
        type:
          switch-on: _parent._parent.message_header.message_length
          cases:
            124: existing_encryption_tail
            136: new_encryption_tail
  existing_encryption_tail:
    seq:
      - id: cryptographic_iv
        type: str
        size: 16
        encoding: ASCII
        doc: 'Initialisation vector for encryption and decryption with the gateway'
  new_encryption_tail:
    seq:
      - id: static_cryptographic_iv
        type: str
        size: 8
        encoding: ASCII
        doc: 'Fixed half of the initialisation vector'
      - id: dynamic_cryptographic_iv
        type: s8
        doc: 'Varying half of the initialisation vector'
      - id: cryptographic_additional_key
        type: str
        size: 12
        encoding: ASCII
        doc: 'Additional authenticated data key'
  update_local_database_in_message:
    seq:
      - id: last_update_security_time
        type: second_timestamp
        doc: 'Time the security master was last updated. Seconds since Dos epoch'
      - id: last_update_participant_time
        type: second_timestamp
        doc: 'Time the participant master was last updated. Seconds since Dos epoch'
      - id: last_update_instrument_time
        type: second_timestamp
        doc: 'Time the instrument master was last updated. Seconds since Dos epoch'
      - id: last_update_index_time
        type: second_timestamp
        doc: 'Time the index master was last updated. Seconds since Dos epoch'
      - id: request_for_open_orders
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether open orders are also requested'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: st_market_status
        type: st_market_status
        doc: 'ST_MARKET_STATUS'
      - id: st_ex_market_status
        type: st_ex_market_status
        doc: 'ST_EX_MARKET_STATUS'
      - id: st_pl_market_status
        type: st_pl_market_status
        doc: 'ST_PL_MARKET_STATUS'
  update_local_database_header_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  update_local_database_trailer_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  download_request_message:
    seq:
      - id: sequence_number
        type: floating_point_integer
        doc: 'Sequence number'
  update_local_database_data_message:
    seq:
      - id: inner_header
        type: inner_header
        doc: 'INNER_MESSAGE_HEADER'
      - id: local_database_data
        type: local_database_data
        size: _parent.message_header.message_length - 80
        doc: 'Record body selected by Inner Transaction Code'
  inner_header:
    seq:
      - id: inner_trader_id
        type: s4
        doc: 'User Id of the trader'
      - id: inner_log_time
        type: second_timestamp
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch'
      - id: inner_alpha_char
        type: str
        size: 2
        encoding: ASCII
        doc: 'First two characters of Symbol when the record carries one'
      - id: inner_transaction_code
        type: s2
        doc: 'Type of record carried in the data region'
      - id: inner_error_code
        type: s2
        doc: 'Zero when the record is valid'
      - id: inner_timestamp
        type: s8
        doc: 'Time the record was generated'
      - id: inner_time_stamp_1
        type: str
        size: 8
        encoding: ASCII
        doc: 'Reserved for the host'
      - id: inner_time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time the record reached the gateway'
      - id: inner_message_length
        type: s2
        doc: 'Length of the record including the inner header'
  local_database_data:
    seq:
      - id: data_payload
        size-eos: true
        doc: 'Record body, opaque until the master change structures are transcribed'
  message_record_message:
    seq:
      - id: inner_header
        type: inner_header
        doc: 'INNER_MESSAGE_HEADER'
      - id: message_download_data
        type: message_download_data
        size: _parent.message_header.message_length - 80
        doc: 'Downloaded record body selected by Inner Transaction Code'
  message_download_data:
    seq:
      - id: download_payload
        size-eos: true
        doc: 'Downloaded record body, any transaction code, opaque'
  order_entry_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_entry_body:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Type of participant the order belongs to'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Competitor period'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor period'
      - id: modified_cancelled_by
        type: u1
        enum: modified_cancelled_by
        doc: 'Who modified or cancelled the order'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason the give up was rejected'
      - id: reserved_4
        type: s4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract the order was placed for'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id of the counter party'
      - id: third_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the broker is in closeout status'
      - id: fourth_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Type of the order'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the order being modified'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belonged to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed quantity still outstanding'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity still outstanding'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: price
        type: decimal_s4_2
        doc: 'New price of the order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order triggers. Implied decimal with scale 1e-2'
      - id: good_till_date
        type: s4
        doc: 'Number of days a good till date order remains, from two to the maximum the market allows'
      - id: entry_date_time
        type: second_timestamp
        doc: 'Time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum quantity that must be filled'
      - id: last_modified
        type: s4
        doc: 'Time the order was last modified'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: trader_id
        type: s4
        doc: 'Trader Id of the connected user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlor of the order'
      - id: pro_client_indicator
        type: s2
        doc: 'Whether the order is proprietary or for a client'
      - id: settlement_period
        type: s2
        doc: 'Settlement period'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: fifth_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: filler_116
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen filler bits carrying no meaning'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Non Neat front end identifier supplied by the member'
      - id: mkt_replay
        type: s8
        doc: 'Market replay reference'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number'
      - id: algo_id
        type: s4
        doc: 'Identifier of the algorithm that generated the order'
      - id: second_reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_52
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  contract_desc:
    seq:
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument the contract belongs to'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the underlying security'
      - id: expiry_date
        type: second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: strike_price
        type: decimal_s4_2
        doc: 'Strike price of an option contract. Implied decimal with scale 1e-2'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a call or a put'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
  st_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_12
        type: b2
        doc: 'Reserved'
      - id: order_pre_open
        type: b1
        doc: 'Order belongs to the pre open session'
      - id: frozen
        type: b1
        doc: 'Order has resulted in a freeze awaiting approval'
      - id: modified
        type: b1
        doc: 'Order has been modified'
      - id: traded
        type: b1
        doc: 'Order has traded at least partly'
      - id: matched_ind
        type: b1
        doc: 'Order has been matched'
      - id: mf
        type: b1
        doc: 'Minimum fill order'
      - id: aon
        type: b1
        doc: 'All or none order'
      - id: ioc
        type: b1
        doc: 'Immediate or cancel order'
      - id: gtc
        type: b1
        doc: 'Good till cancelled order'
      - id: day
        type: b1
        doc: 'Day order'
      - id: mit
        type: b1
        doc: 'Market if touched order'
      - id: sl
        type: b1
        doc: 'Stop loss order'
      - id: market
        type: b1
        doc: 'Market order'
      - id: ato
        type: b1
        doc: 'At the open order'
  additional_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: boc
        type: b1
        doc: 'Book or cancel order'
      - id: col
        type: b1
        doc: 'Collateral order'
      - id: reserved_34
        type: b2
        doc: 'Reserved'
      - id: stpc
        type: b1
        doc: 'Self trade prevention check'
      - id: reserved_68
        type: b3
        doc: 'Reserved'
  price_modification_message:
    seq:
      - id: token_no
        type: s4
        doc: 'Token number of the contract the order was placed for'
      - id: trader_id
        type: s4
        doc: 'Trader Id of the connected user'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the order being modified'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell'
      - id: price
        type: decimal_s4_2
        doc: 'New price of the order. Implied decimal with scale 1e-2'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: last_modified
        type: s4
        doc: 'Time the order was last modified'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference supplied with the request'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_24
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  trade_inquiry_message:
    seq:
      - id: token_no
        type: s4
        doc: 'Token number of the contract the order was placed for'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: fill_number
        type: s4
        doc: 'Number of the trade'
      - id: fill_quantity
        type: s4
        doc: 'Quantity traded'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price the trade occurred at. Implied decimal with scale 1e-2'
      - id: mkt_type
        type: u1
        enum: mkt_type
        doc: 'Market the trade belongs to'
      - id: buy_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the buy opens or closes a position'
      - id: reserved_4
        type: s4
        doc: 'Reserved'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id on the buy side'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id on the sell side'
      - id: trader_id
        type: s4
        doc: 'Trader Id of the connected user'
      - id: requested_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Which side requested the change'
      - id: sell_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the sell opens or closes a position'
      - id: buy_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number on the buy side'
      - id: sell_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number on the sell side'
      - id: reserved_24
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: second_reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: buy_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number on the buy side'
      - id: sell_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number on the sell side'
      - id: reserved_60
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  spread_order_entry_message:
    seq:
      - id: spread_order_body
        type: spread_order_body
        doc: 'Spread Order Body'
  spread_order_body:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of participant the first leg belongs to'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: competitor_period_1
        type: s2
        doc: 'Competitor period'
      - id: solicitor_period_1
        type: s2
        doc: 'Solicitor period'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Who modified or cancelled the order'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Reason the request was rejected or the order changed'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Start of the alpha range'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of the alpha range'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party trading member Id'
      - id: fillerx_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: filler_options_1
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: fillery_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: order_type_1
        type: s2
        doc: 'Type of the first leg order'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number of the first leg'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book the first leg belongs to'
      - id: buy_sell_1
        type: s2
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Quantity disclosed to the market'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Disclosed quantity still outstanding'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity still outstanding'
      - id: volume_1
        type: s4
        doc: 'Quantity of the first leg'
      - id: volume_filled_today_1
        type: s4
        doc: 'Quantity traded today'
      - id: price_1
        type: decimal_s4_2
        doc: 'Price of the first leg. Implied decimal with scale 1e-2'
      - id: trigger_price_1
        type: decimal_s4_2
        doc: 'Price at which a stop loss order triggers. Implied decimal with scale 1e-2'
      - id: good_till_date_1
        type: s4
        doc: 'Number of days a good till date order remains, from two to the maximum the market allows'
      - id: entry_date_time_1
        type: second_timestamp
        doc: 'Time the order entered the system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Minimum quantity that must be filled'
      - id: last_modified_1
        type: s4
        doc: 'Time the order was last modified'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch Id of the trading member'
      - id: trader_id_1
        type: s4
        doc: 'User Id that entered the order'
      - id: broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: c_ord_filler
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: open_close_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the first leg opens or closes a position'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlor of the order'
      - id: pro_client_1
        type: s2
        doc: 'Whether the order is proprietary or for a client'
      - id: settlement_period_1
        type: s2
        doc: 'Settlement period'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: filler_116
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen filler bits carrying no meaning'
      - id: filler_17
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: filler_18
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Non Neat front end identifier supplied by the member'
      - id: mkt_replay
        type: s8
        doc: 'Market replay reference'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number'
      - id: algo_id
        type: s4
        doc: 'Identifier of the algorithm that generated the order'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_52
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: price_diff
        type: decimal_s4_2
        doc: 'Price difference between the legs. Implied decimal with scale 1e-2'
      - id: ms_spd_leg_info
        type: ms_spd_leg_info
        repeat: expr
        repeat-expr: 2
        doc: 'MS_SPD_LEG_INFO'
  ms_spd_leg_info:
    seq:
      - id: token_2
        type: s4
        doc: 'Token number of the leg'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_2
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party trading member Id'
      - id: fillerx_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: order_type_2
        type: s2
        doc: 'Type of the leg order'
      - id: buy_sell_2
        type: s2
        doc: 'Whether the leg is a buy or a sell'
      - id: disclosed_vol_2
        type: s4
        doc: 'Quantity disclosed to the market'
      - id: disclosed_vol_remaining_2
        type: s4
        doc: 'Disclosed quantity still outstanding'
      - id: total_vol_remaining_2
        type: s4
        doc: 'Total quantity still outstanding'
      - id: volume_2
        type: s4
        doc: 'Quantity of the leg'
      - id: volume_filled_today_2
        type: s4
        doc: 'Quantity traded today'
      - id: price_2
        type: decimal_s4_2
        doc: 'Price of the leg. Implied decimal with scale 1e-2'
      - id: trigger_price_2
        type: decimal_s4_2
        doc: 'Price at which a stop loss order triggers. Implied decimal with scale 1e-2'
      - id: min_fill_aon_2
        type: s4
        doc: 'Minimum quantity that must be filled'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: open_close_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the leg opens or closes a position'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: filler_y
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  trade_confirmation_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number the confirmation relates to'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: trader_number
        type: s4
        doc: 'User Id that entered the order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: original_volume
        type: s4
        doc: 'Original quantity of the order'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'Quantity still outstanding'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed quantity still outstanding'
      - id: price
        type: decimal_s4_2
        doc: 'New price of the order. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: good_till_date
        type: s4
        doc: 'Number of days a good till date order remains, from two to the maximum the market allows'
      - id: fill_number
        type: s4
        doc: 'Number of the trade'
      - id: fill_quantity
        type: s4
        doc: 'Quantity traded'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price the trade occurred at. Implied decimal with scale 1e-2'
      - id: volume_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
      - id: activity_time
        type: second_timestamp
        doc: 'Time the activity occurred. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'Order number on the counter party side'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id of the counter party'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: token
        type: s4
        doc: 'Token number of the contract'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade opens or closes a position'
      - id: old_open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: reserved_4
        type: s4
        doc: 'Reserved'
      - id: old_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous account number'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant the trade is for'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: fourth_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: fifth_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: sixth_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number'
      - id: old_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous permanent account number'
      - id: algo_id
        type: s4
        doc: 'Identifier of the algorithm that generated the order'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_52
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  user_order_limit_update_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: user_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the user'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: user_type
        type: s2
        doc: 'Type of the user'
      - id: instrument_user
        type: instrument_user
        repeat: expr
        repeat-expr: 2
        doc: 'INSTRUMENT_USER'
  instrument_user:
    seq:
      - id: branch_buy_value_limit
        type: floating_point_integer
        doc: 'Branch buy value limit'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'Branch sell value limit'
      - id: branch_used_buy_value_limit
        type: floating_point_integer
        doc: 'Branch buy value limit used'
      - id: branch_used_sell_value_limit
        type: floating_point_integer
        doc: 'Branch sell value limit used'
      - id: user_order_buy_value_limit
        type: floating_point_integer
        doc: 'User order buy value limit'
      - id: user_order_sell_value_limit
        type: floating_point_integer
        doc: 'User order sell value limit'
      - id: user_order_used_buy_value_limit
        type: floating_point_integer
        doc: 'User order buy value limit used'
      - id: user_order_used_sell_value_limit
        type: floating_point_integer
        doc: 'User order sell value limit used'
  dealer_limit_update_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: ord_qty_buff
        type: floating_point_integer
        doc: 'Maximum order quantity the user may enter'
      - id: ord_val_buff
        type: floating_point_integer
        doc: 'Maximum order value the user may enter'
  spread_order_limit_update_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: spd_ord_qty_buff
        type: floating_point_integer
        doc: 'Maximum spread order quantity the user may enter'
      - id: spd_ord_val_buff
        type: floating_point_integer
        doc: 'Maximum spread order value the user may enter'
  control_message_to_trader_message:
    seq:
      - id: trader_id
        type: s4
        doc: 'Trader Id of the connected user'
      - id: action_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Action code indicating the action taken'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: broad_cast_message_length
        type: s2
        doc: 'Length of the message text'
      - id: broad_cast_message
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text of the message'
  market_statistics_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Selects the record carried and the trading session'
      - id: report_body
        type:
          switch-on: message_type
          cases:
            '"H"': report_header_body
            '"X"': report_header_body
            '"L"': report_header_body
            '"R"': report_statistics_body
            '"Y"': report_statistics_body
            '"M"': report_statistics_body
            '"T"': report_trailer_body
            '"Z"': report_trailer_body
            '"N"': report_trailer_body
  report_header_body:
    seq:
      - id: org_scope
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: report_date
        type: second_timestamp
        doc: 'Date of the report. Seconds since Dos epoch'
      - id: user_type
        type: s2
        doc: 'Type of the user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: firm_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the firm'
      - id: trader_number
        type: s4
        doc: 'User Id that entered the order'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trader'
  report_statistics_body:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: number_of_records
        type: s2
        doc: 'Number of statistics records'
      - id: mkt_stats_data
        type: mkt_stats_data
        repeat: expr
        repeat-expr: 4
        doc: 'MKT_STATS_DATA'
  mkt_stats_data:
    seq:
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: market_type
        type: s2
        doc: 'Market the contract trades in'
      - id: open_price
        type: decimal_s4_2
        doc: 'Opening price. Implied decimal with scale 1e-2'
      - id: high_price
        type: decimal_s4_2
        doc: 'Highest price. Implied decimal with scale 1e-2'
      - id: low_price
        type: decimal_s4_2
        doc: 'Lowest price. Implied decimal with scale 1e-2'
      - id: closing_price
        type: decimal_s4_2
        doc: 'Closing price. Implied decimal with scale 1e-2'
      - id: total_quantity_traded_long
        type: s8
        doc: 'Total quantity traded'
      - id: total_value_traded
        type: floating_point_integer
        doc: 'Total value traded'
      - id: previous_close_price
        type: decimal_s4_2
        doc: 'Previous closing price. Implied decimal with scale 1e-2'
      - id: open_interest_long
        type: s8
        doc: 'Open interest'
      - id: chg_open_interest
        type: s8
        doc: 'Change in open interest'
      - id: indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Statistics indicator'
  report_trailer_body:
    seq:
      - id: number_of_packets
        type: s4
        doc: 'Number of data packets sent in the bhavcopy'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  enhanced_market_statistics_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Selects the record carried and the trading session'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: number_of_records
        type: s2
        doc: 'Number of statistics records'
      - id: enhncd_mkt_stats_data
        type: enhncd_mkt_stats_data
        repeat: expr
        repeat-expr: 4
        doc: 'ENHNCD_MKT_STATS_DATA'
  enhncd_mkt_stats_data:
    seq:
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: market_type
        type: s2
        doc: 'Market the contract trades in'
      - id: open_price
        type: decimal_s4_2
        doc: 'Opening price. Implied decimal with scale 1e-2'
      - id: high_price
        type: decimal_s4_2
        doc: 'Highest price. Implied decimal with scale 1e-2'
      - id: low_price
        type: decimal_s4_2
        doc: 'Lowest price. Implied decimal with scale 1e-2'
      - id: closing_price
        type: decimal_s4_2
        doc: 'Closing price. Implied decimal with scale 1e-2'
      - id: total_quantity_traded_short
        type: u4
        doc: 'Total quantity traded'
      - id: total_value_traded
        type: floating_point_integer
        doc: 'Total value traded'
      - id: previous_close_price
        type: decimal_s4_2
        doc: 'Previous closing price. Implied decimal with scale 1e-2'
      - id: open_interest_long
        type: s8
        doc: 'Open interest'
      - id: chg_open_interest
        type: s8
        doc: 'Change in open interest'
      - id: indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Statistics indicator'
  market_index_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Selects the record carried and the trading session'
      - id: index_name
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the index'
      - id: mkt_index
        type: mkt_index
        doc: 'MKT_INDEX'
  mkt_index:
    seq:
      - id: market_opening_index
        type: s2
        doc: 'Opening index'
      - id: market_high_index
        type: s2
        doc: 'Highest index'
      - id: market_low_index
        type: s2
        doc: 'Lowest index'
      - id: market_closing_index
        type: s2
        doc: 'Closing index'
      - id: market_start_index
        type: s2
        doc: 'Index at start'
  industry_index_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Selects the record carried and the trading session'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: number_of_industry_records
        type: s2
        doc: 'Number of industry records'
      - id: industry_index
        type: industry_index
        repeat: expr
        repeat-expr: 10
        doc: 'INDUSTRY_INDEX'
  industry_index:
    seq:
      - id: industry_name
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the industry'
      - id: opening
        type: s4
        doc: 'Opening index'
      - id: high
        type: s4
        doc: 'Highest index'
      - id: low
        type: s4
        doc: 'Lowest index'
      - id: closing
        type: s4
        doc: 'Closing index'
      - id: start
        type: s4
        doc: 'Index at start'
  sector_index_report_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Selects the record carried and the trading session'
      - id: industry_name
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the industry'
      - id: number_of_industry_records
        type: s2
        doc: 'Number of industry records'
      - id: index_data
        type: index_data
        repeat: expr
        repeat-expr: 10
        doc: 'INDEX_DATA'
  index_data:
    seq:
      - id: sector_name
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the sector'
      - id: index_value
        type: s4
        doc: 'Value of the index'
  spread_bhavcopy_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Selects the record carried and the trading session'
      - id: spread_report_body
        type:
          switch-on: message_type
          cases:
            '"H"': spread_report_header_body
            '"X"': spread_report_header_body
            '"L"': spread_report_header_body
            '"R"': spread_report_statistics_body
            '"Y"': spread_report_statistics_body
            '"M"': spread_report_statistics_body
            '"T"': report_trailer_body
            '"Z"': report_trailer_body
            '"N"': report_trailer_body
  spread_report_header_body:
    seq:
      - id: org_scope
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: report_date
        type: second_timestamp
        doc: 'Date of the report. Seconds since Dos epoch'
      - id: user_type
        type: s2
        doc: 'Type of the user'
      - id: brokernumber
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trading member'
      - id: trader_number
        type: s4
        doc: 'User Id that entered the order'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trader'
  spread_report_statistics_body:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: no_of_records
        type: s2
        doc: 'Number of statistics records'
      - id: spd_stats_data
        type: spd_stats_data
        repeat: expr
        repeat-expr: 3
        doc: 'SPD_STATS_DATA'
  spd_stats_data:
    seq:
      - id: market_type
        type: s2
        doc: 'Market the contract trades in'
      - id: instrumentname_1
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument of the first leg'
      - id: symbol_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the first leg'
      - id: expirydate_1
        type: second_timestamp
        doc: 'Expiry of the first leg. Seconds since Dos epoch'
      - id: strikeprice_1
        type: decimal_s4_2
        doc: 'Strike price of the first leg. Implied decimal with scale 1e-2'
      - id: optiontype_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the first leg'
      - id: calevel_1
        type: s2
        doc: 'Corporate action level of the first leg'
      - id: instrumentname_2
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument of the second leg'
      - id: symbol_2
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the second leg'
      - id: expirydate_2
        type: second_timestamp
        doc: 'Expiry of the second leg. Seconds since Dos epoch'
      - id: strikeprice_2
        type: decimal_s4_2
        doc: 'Strike price of the second leg. Implied decimal with scale 1e-2'
      - id: optiontype_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the second leg'
      - id: calevel_2
        type: s2
        doc: 'Corporate action level of the second leg'
      - id: openpd
        type: s4
        doc: 'Opening price difference'
      - id: hipd
        type: s4
        doc: 'Highest price difference'
      - id: lowpd
        type: s4
        doc: 'Lowest price difference'
      - id: lasttradedpd
        type: s4
        doc: 'Last traded price difference'
      - id: noofcontractstraded
        type: s4
        doc: 'Number of contracts traded'
  global_indices_message:
    seq:
      - id: index_details
        type: index_details
        doc: 'INDEX_DETAILS'
  index_details:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the contract'
      - id: name
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the index'
      - id: open
        type: s4
        doc: 'Opening value'
      - id: high
        type: s4
        doc: 'Highest index'
      - id: low
        type: s4
        doc: 'Lowest index'
      - id: last
        type: s4
        doc: 'Last value'
      - id: close
        type: s4
        doc: 'Closing value'
      - id: prev_close
        type: s4
        doc: 'Previous closing value'
      - id: life_high
        type: s4
        doc: 'Highest value on record'
      - id: life_low
        type: s4
        doc: 'Lowest value on record'
      - id: filler_4
        type: s4
        doc: 'Filler'
      - id: filler_2
        type: s4
        doc: 'Filler'
      - id: filler_3
        type: s4
        doc: 'Filler'
  global_contracts_message:
    seq:
      - id: contracts_details
        type: contracts_details
        doc: 'CONTRACTS_DETAILS'
  contracts_details:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the contract'
      - id: nse_symbol
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Nse symbol'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument the contract belongs to'
      - id: exp_day
        type: s2
        doc: 'Day the contract expires'
      - id: exp_month
        type: s2
        doc: 'Month the contract expires'
      - id: exp_year
        type: s2
        doc: 'Year the contract expires'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a call or a put'
      - id: strike_price
        type: decimal_s4_2
        doc: 'Strike price of an option contract. Implied decimal with scale 1e-2'
      - id: bid_price
        type: decimal_s4_2
        doc: 'Best bid price. Implied decimal with scale 1e-2'
      - id: ask_price
        type: decimal_s4_2
        doc: 'Best ask price. Implied decimal with scale 1e-2'
      - id: bid_size
        type: floating_point_integer
        doc: 'Quantity at the best bid'
      - id: ask_size
        type: floating_point_integer
        doc: 'Quantity at the best ask'
      - id: open
        type: s4
        doc: 'Opening value'
      - id: high
        type: s4
        doc: 'Highest index'
      - id: low
        type: s4
        doc: 'Lowest index'
      - id: last
        type: s4
        doc: 'Last value'
      - id: close
        type: s4
        doc: 'Closing value'
      - id: prev_close
        type: s4
        doc: 'Previous closing value'
      - id: limit_high
        type: s4
        doc: 'Upper price limit'
      - id: limit_low
        type: s4
        doc: 'Lower price limit'
      - id: total_trades
        type: floating_point_integer
        doc: 'Total number of trades'
      - id: open_interest_double
        type: floating_point_integer
        doc: 'Open interest'
      - id: filler_4
        type: s4
        doc: 'Filler'
      - id: filler_2
        type: s4
        doc: 'Filler'
      - id: filler_3
        type: s4
        doc: 'Filler'
  secure_box_registration_request_in_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id used for this connection'
  box_sign_on_request_in_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id used for this connection'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_5
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: session_key
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session key to be used for authentication'
  box_sign_on_request_out_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id used for this connection'
      - id: reserved_10
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  box_sign_off_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id used for this connection'
  contingency_broadcast_message:
    seq:
      - id: stream_number
        type: s2
        doc: 'Impacted stream number, or zero when all streams are impacted'
      - id: status
        type: s2
        enum: status
        doc: 'Whether the outage is starting or ending'
      - id: reserved_200
        type: str
        size: 200
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  branch_order_value_limit_update_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_25
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: branch_limits
        type: branch_limits
        repeat: expr
        repeat-expr: 2
        doc: 'BRANCH_LIMITS'
  branch_limits:
    seq:
      - id: branch_buy_value_limit
        type: floating_point_integer
        doc: 'Branch buy value limit'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'Branch sell value limit'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  user_order_value_limit_update_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: reserved_26
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: user_limits
        type: user_limits
        repeat: expr
        repeat-expr: 2
        doc: 'USER_LIMITS'
  user_limits:
    seq:
      - id: reserved_32
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: user_order_buy_value_limit
        type: floating_point_integer
        doc: 'User order buy value limit'
      - id: user_order_sell_value_limit
        type: floating_point_integer
        doc: 'User order sell value limit'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  normal_order_limit_update_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: order_qty_limit
        type: floating_point_integer
        doc: 'Maximum order quantity'
      - id: order_val_limit
        type: floating_point_integer
        doc: 'Maximum order value'
  reset_user_password_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_14
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  collateral_user_status_change_request_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: col_user_bit
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Collateral status of the user'
      - id: reserved_7
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  collateral_user_status_change_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: col_user_bit
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Collateral status of the user'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  user_trade_modify_cancel_status_change_request_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: trd_mod_cxl_bit
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade modify and cancel permission'
      - id: reserved_7
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  user_trade_modify_cancel_status_change_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: trd_mod_cxl_bit
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade modify and cancel permission'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  user_address_unlock_request_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_70
        type: str
        size: 70
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  user_address_unlock_confirm_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_36
        type: str
        size: 36
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  user_address_unlock_approve_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_36
        type: str
        size: 36
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  giveup_confirmation_message:
    seq:
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason the give up was rejected'
      - id: giveup
        type: giveup
        doc: 'GIVEUP'
  giveup:
    seq:
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the order being modified'
      - id: fill_number
        type: s4
        doc: 'Number of the trade'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument the contract belongs to'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the underlying security'
      - id: expiry_date
        type: second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: strike_price
        type: decimal_s4_2
        doc: 'Strike price of an option contract. Implied decimal with scale 1e-2'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a call or a put'
      - id: ca_level
        type: s2
        doc: 'Corporate action level'
      - id: fill_volume
        type: s4
        doc: 'Quantity traded'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price the trade occurred at. Implied decimal with scale 1e-2'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belonged to'
      - id: last_modified_date_time
        type: second_timestamp
        doc: 'Time the give up was last modified. Seconds since Dos epoch'
      - id: initiated_by_control
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether Nse Control initiated the give up'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade opens or closes a position'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant the trade is for'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'State of the give up'
      - id: deleted
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the give up record is deleted'
  order_cancellation_confirmation_message:
    seq:
      - id: cancellation_confirmation_body
        type:
          switch-on: _parent.message_header.message_length
          cases:
            316: order_entry_body
            480: spread_order_body
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
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0

enums:
  transaction_code:
    2300:
      id: 'sign_on_request_in_message'
      doc: 'Logs a trader on to the trading system'
    2301:
      id: 'sign_on_request_out_message'
      doc: 'Confirms that the trader has been signed on'
    2321:
      id: 'sign_off_request_out_message'
      doc: 'Breaks the virtual circuit between the host and the front end'
    1600:
      id: 'system_information_in_message'
      doc: 'Requests the system information of the trading system'
    1601:
      id: 'system_information_out_message'
      doc: 'Carries the system information of the trading system'
    2400:
      id: 'gateway_router_request_message'
      doc: 'Asks the gateway router which gateway server to connect to'
    2401:
      id: 'gateway_router_response_message'
      doc: 'Returns the allocated gateway server and the keys used to encrypt the session'
    2320:
      id: 'sign_off_request_in_message'
      doc: 'Breaks the virtual circuit between the front end and the host'
    7300:
      id: 'update_local_database_in_message'
      doc: 'Requests the local database download of contracts and participants'
    7307:
      id: 'update_local_database_header_message'
      doc: 'Opens the local database download'
    7308:
      id: 'update_local_database_trailer_message'
      doc: 'Closes the local database download'
    7000:
      id: 'download_request_message'
      doc: 'Requests the message download for one stream'
    7304:
      id: 'update_local_database_data_message'
      doc: 'Carries one local database record wrapped in an inner header'
    7011:
      id: 'header_record_message'
      doc: 'Opens the message download for a stream'
    7021:
      id: 'message_record_message'
      doc: 'Carries one downloaded message wrapped in an inner header'
    7031:
      id: 'trailer_record_message'
      doc: 'Signals the message download is complete for a stream'
    2000:
      id: 'order_entry_message'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2012:
      id: 'order_entry_message_2012'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2040:
      id: 'order_entry_message_2040'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2042:
      id: 'order_entry_message_2042'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2062:
      id: 'order_entry_message_2062'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2070:
      id: 'order_entry_message_2070'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2072:
      id: 'order_entry_message_2072'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2073:
      id: 'order_entry_message_2073'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2074:
      id: 'order_entry_message_2074'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2170:
      id: 'order_entry_message_2170'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2231:
      id: 'order_entry_message_2231'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    9002:
      id: 'order_entry_message_9002'
      doc: 'Order entry, modification, cancellation and kill switch, and their confirmations and errors, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2013:
      id: 'price_modification_message'
      doc: 'Modifies the price of a live order, and its acknowledgement'
    20406:
      id: 'price_modification_message_20406'
      doc: 'Modifies the price of a live order, and its acknowledgement'
    5445:
      id: 'trade_inquiry_message'
      doc: 'Trade modification and cancellation requests, the cancellation response and the trade error, all carried in the shared trade structure. Transaction Code in the header names the operation'
    5440:
      id: 'trade_inquiry_message_5440'
      doc: 'Trade modification and cancellation requests, the cancellation response and the trade error, all carried in the shared trade structure. Transaction Code in the header names the operation'
    5441:
      id: 'trade_inquiry_message_5441'
      doc: 'Trade modification and cancellation requests, the cancellation response and the trade error, all carried in the shared trade structure. Transaction Code in the header names the operation'
    2223:
      id: 'trade_inquiry_message_2223'
      doc: 'Trade modification and cancellation requests, the cancellation response and the trade error, all carried in the shared trade structure. Transaction Code in the header names the operation'
    2100:
      id: 'spread_order_entry_message'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2102:
      id: 'spread_order_entry_message_2102'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2104:
      id: 'spread_order_entry_message_2104'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2106:
      id: 'spread_order_entry_message_2106'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2118:
      id: 'spread_order_entry_message_2118'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2124:
      id: 'spread_order_entry_message_2124'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2125:
      id: 'spread_order_entry_message_2125'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2126:
      id: 'spread_order_entry_message_2126'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2127:
      id: 'spread_order_entry_message_2127'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2130:
      id: 'spread_order_entry_message_2130'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2131:
      id: 'spread_order_entry_message_2131'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2132:
      id: 'spread_order_entry_message_2132'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2133:
      id: 'spread_order_entry_message_2133'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2136:
      id: 'spread_order_entry_message_2136'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2154:
      id: 'spread_order_entry_message_2154'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2155:
      id: 'spread_order_entry_message_2155'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2156:
      id: 'spread_order_entry_message_2156'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    9004:
      id: 'spread_order_entry_message_9004'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    20408:
      id: 'spread_order_entry_message_20408'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    20410:
      id: 'spread_order_entry_message_20410'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    20412:
      id: 'spread_order_entry_message_20412'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    20414:
      id: 'spread_order_entry_message_20414'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    20416:
      id: 'spread_order_entry_message_20416'
      doc: 'Spread and 2L and 3L order entry, modification and cancellation, and their confirmations and errors, all carried in the shared spread structure. Transaction Code in the header names the operation'
    2222:
      id: 'trade_confirmation_message'
      doc: 'Trade confirmation, stop loss trigger notification, and trade cancellation and modification confirmations and rejections. Transaction Code in the header names the operation'
    2212:
      id: 'trade_confirmation_message_2212'
      doc: 'Trade confirmation, stop loss trigger notification, and trade cancellation and modification confirmations and rejections. Transaction Code in the header names the operation'
    2282:
      id: 'trade_confirmation_message_2282'
      doc: 'Trade confirmation, stop loss trigger notification, and trade cancellation and modification confirmations and rejections. Transaction Code in the header names the operation'
    2286:
      id: 'trade_confirmation_message_2286'
      doc: 'Trade confirmation, stop loss trigger notification, and trade cancellation and modification confirmations and rejections. Transaction Code in the header names the operation'
    2287:
      id: 'trade_confirmation_message_2287'
      doc: 'Trade confirmation, stop loss trigger notification, and trade cancellation and modification confirmations and rejections. Transaction Code in the header names the operation'
    2288:
      id: 'trade_confirmation_message_2288'
      doc: 'Trade confirmation, stop loss trigger notification, and trade cancellation and modification confirmations and rejections. Transaction Code in the header names the operation'
    5731:
      id: 'user_order_limit_update_message'
      doc: 'Carries the branch and user order value limits'
    5733:
      id: 'dealer_limit_update_message'
      doc: 'Carries the dealer order quantity and value limits'
    5772:
      id: 'spread_order_limit_update_message'
      doc: 'Carries the spread order quantity and value limits'
    5295:
      id: 'control_message_to_trader_message'
      doc: 'Interactive message sent to the trader from Nse Control'
    1833:
      id: 'market_statistics_report_message'
      doc: 'Bhavcopy header, market statistics records or trailer. Message Type selects which'
    11833:
      id: 'enhanced_market_statistics_report_message'
      doc: 'Enhanced bhavcopy market statistics records'
    1836:
      id: 'market_index_report_message'
      doc: 'Bhavcopy market index report'
    1837:
      id: 'industry_index_report_message'
      doc: 'Bhavcopy industry index report'
    1838:
      id: 'sector_index_report_message'
      doc: 'Bhavcopy sector index report'
    1862:
      id: 'spread_bhavcopy_message'
      doc: 'Spread bhavcopy header, spread statistics records or trailer. Message Type selects which'
    7732:
      id: 'global_indices_message'
      doc: 'Carries the values of a global index'
    7733:
      id: 'global_contracts_message'
      doc: 'Carries the values of a global contract'
    23008:
      id: 'secure_box_registration_request_in_message'
      doc: 'Registers the box with the allocated gateway server'
    23009:
      id: 'secure_box_registration_response_out_message'
      doc: 'Confirms the box registration, carrying only the message header'
    23000:
      id: 'box_sign_on_request_in_message'
      doc: 'Signs the box on to the allocated gateway server'
    23001:
      id: 'box_sign_on_request_out_message'
      doc: 'Confirms the box sign on'
    23506:
      id: 'heartbeat_message'
      doc: 'Keeps the interactive connection alive, carrying only the message header'
    20322:
      id: 'box_sign_off_message'
      doc: 'Signs the box off the gateway server'
    5294:
      id: 'contingency_broadcast_message'
      doc: 'Signals the start or end of an outage on one or all matching engine streams'
    5716:
      id: 'branch_order_value_limit_update_message'
      doc: 'Sets the buy and sell value limits for a branch'
    5730:
      id: 'user_order_value_limit_update_message'
      doc: 'Sets the buy and sell order value limits for a user'
    5732:
      id: 'normal_order_limit_update_message'
      doc: 'Sets the order quantity and value limits for a user'
    5740:
      id: 'reset_user_password_message'
      doc: 'Requests a reset of the user password'
    5744:
      id: 'collateral_user_status_change_request_message'
      doc: 'Changes the collateral status of a user'
    5745:
      id: 'collateral_user_status_change_response_message'
      doc: 'Confirms the collateral status change'
    5738:
      id: 'user_trade_modify_cancel_status_change_request_message'
      doc: 'Changes whether a user may modify or cancel trades'
    5739:
      id: 'user_trade_modify_cancel_status_change_response_message'
      doc: 'Confirms the trade modify and cancel permission change'
    5427:
      id: 'user_address_unlock_request_message'
      doc: 'Requests that a locked user address be unlocked'
    5428:
      id: 'user_address_unlock_confirm_message'
      doc: 'Confirms that the unlock request was received'
    5483:
      id: 'user_address_unlock_approve_message'
      doc: 'Approves the unlock of a user address'
    4506:
      id: 'giveup_confirmation_message'
      doc: 'Confirms or rejects a give up of a trade to another trading member. Transaction Code in the header names which'
    4507:
      id: 'giveup_confirmation_message_4507'
      doc: 'Confirms or rejects a give up of a trade to another trading member. Transaction Code in the header names which'
    2075:
      id: 'order_cancellation_confirmation_message'
      doc: 'Confirms an order cancellation. Message Length selects the ordinary or the two and three leg layout'
  error_code:
    293:
      id: 'invalid_instrument_type'
      doc: 'Invalid Instrument Type'
    509:
      id: 'order_number_invalid'
      doc: 'Order Does Not Exist'
    8049:
      id: 'ord_cxl_initiator_auc_not_allowed'
      doc: 'Initiator Is Not Allowed To Cancel Auction Order'
    8485:
      id: 'auction_number_invalid'
      doc: 'Auction Number Does Not Exist'
    16000:
      id: 'market_closed'
      doc: 'The Trading System Is Not Available For Trading'
    16001:
      id: 'e_invalid_user'
      doc: 'Header User Id Is Not Equal To User Id In The Order Packet'
    16003:
      id: 'error_bad_trans_code'
      doc: 'Invalid Transcode'
    16004:
      id: 'e_user_already_signed_on'
      doc: 'The User Is Already Signed On'
    16005:
      id: 'e_invalid_signoff'
      doc: 'System Error While Trying To Signoff Please Call The Exchange'
    16006:
      id: 'e_invalid_signon'
      doc: 'Invalid Box User Signon Please Try Again'
    16007:
      id: 'e_signon_not_possible'
      doc: 'Signing Onto The Trading System Is Restricted Please Try Later On'
    16012:
      id: 'err_invalid_symbol'
      doc: 'Invalid Symbol'
    16013:
      id: 'err_invalid_order_number'
      doc: 'Invalid Order Number'
    16014:
      id: 'e_not_your_order'
      doc: 'This Order Is Not Yours'
    16015:
      id: 'e_not_your_fill'
      doc: 'This Trade Is Not Yours'
    16016:
      id: 'e_invalid_fill_number'
      doc: 'Invalid Trade Number'
    16019:
      id: 'e_stock_not_found'
      doc: 'Stock Not Found'
    16020:
      id: 'e_order_price_out_of_revised_price_ra'
      doc: 'Order Price Is Outside The Revised Nge Price Range'
    16035:
      id: 'security_not_available'
      doc: 'Security Is Unavailable For Trading At This Time Please Try Later'
    16041:
      id: 'broker_not_found'
      doc: 'Trading Member Does Not Exist In The System'
    16042:
      id: 'user_not_found'
      doc: 'Dealer Does Not Exist In The System'
    16043:
      id: 'duplicate_record'
      doc: 'This Record Already Exists On The Neat System'
    16044:
      id: 'e_order_modified'
      doc: 'Order Has Been Modified Please Try Again'
    16049:
      id: 'stock_suspended'
      doc: 'Stock Is Suspended'
    16052:
      id: 'err_function_not_available'
      doc: 'Function Not Available When Preopen Trade Cancel Request Is Rejected'
    16053:
      id: 'e_change_password'
      doc: 'Your Password Has Expired Must Be Changed'
    16054:
      id: 'err_invalid_branch'
      doc: 'Invalid Branch For Trading Member'
    16056:
      id: 'oe_program_error'
      doc: 'Program Error'
    16063:
      id: 'err_invalid_status'
      doc: 'Requested User Status Is Active'
    16070:
      id: 'err_data_not_changed'
      doc: 'If Data In The Incoming Packet Is Same As The Existing Data'
    16086:
      id: 'e_dup_trd_cxl_request'
      doc: 'Duplicate Trade Cancel Request'
    16098:
      id: 'err_invalid_buyer_user_id'
      doc: 'Invalid Trader Id For Buyer'
    16099:
      id: 'err_invalid_seller_user_id'
      doc: 'Invalid Trader Id For Buyer'
    16100:
      id: 'e_invalid_version'
      doc: 'Your System Version Has Not Been Updated'
    16104:
      id: 'oe_system_error'
      doc: 'The System Could Not Complete Your Transaction Admin Notified'
    16134:
      id: 'err_user_disabled'
      doc: 'This Dealer Is Disabled Please Call The Exchange'
    16145:
      id: 'oe_invalid_stock_status'
      doc: 'Security Is Not Eligible To Trade In Preopen'
    16148:
      id: 'err_invalid_user_id'
      doc: 'Invalid Dealer Id Entered'
    16154:
      id: 'err_invalid_trader_id'
      doc: 'Invalid Trader Id Entered'
    16169:
      id: 'oe_ato_in_open'
      doc: 'Order Priced Ato Cannot Be Entered When A Security Is Open'
    16198:
      id: 'e_dup_request'
      doc: 'Duplicate Modification Or Cancellation Request For The Same Trade Has Been Encountered'
    16227:
      id: 'e_only_cp_allowed'
      doc: 'Only Market Orders Are Allowed In Postclose'
    16228:
      id: 'e_sl_mit_nt_not_allowed_pclose'
      doc: 'Sl Mit Or Nt Orders Are Not Allowed During Post Close'
    16229:
      id: 'e_gtc_gtd_ord_not_allowed_pclose'
      doc: 'Gtc Or Gtd Orders Are Not Allowed During Post Close'
    16230:
      id: 'oe_cont_mod_not_allowed'
      doc: 'Continuous Session Orders Cannot Be Modified'
    16231:
      id: 'trd_cont_mod_not_allowed'
      doc: 'Continuous Session Trades Cannot Be Changed'
    16233:
      id: 'str_pro_partivipant_invalid'
      doc: 'Proprietary Requests Cannot Be Made For Participant'
    16247:
      id: 'error_invalid_price'
      doc: 'Invalid Price'
    16251:
      id: 'oe_diff_trd_mod_vol'
      doc: 'Trade Modification With Different Quantities Is Received'
    16260:
      id: 'error_user_not_exists_in_system'
      doc: 'User Does Not Exists In System'
    16264:
      id: 'err_already_deleted'
      doc: 'User Or Branch Is Deleted'
    16273:
      id: 'record_not_found'
      doc: 'Record Does Not Exist'
    16278:
      id: 'oe_markets_closed'
      doc: 'The Markets Have Not Been Opened For Trading'
    16279:
      id: 'oe_security_not_admitted'
      doc: 'The Contract Has Not Yet Been Admitted For Trading'
    16280:
      id: 'oe_security_matured'
      doc: 'The Contract Has Matured'
    16281:
      id: 'oe_security_expelled'
      doc: 'The Security Has Been Expelled'
    16282:
      id: 'oe_issued_cap_exceeds'
      doc: 'The Order Quantity Is Greater Than The Issued Capital'
    16283:
      id: 'oe_price_not_mult'
      doc: 'The Order Price Is Not Multiple Of The Tick Size'
    16284:
      id: 'oe_price_exceeds_day_min_max'
      doc: 'The Order Price Is Out Of The Days Price Range'
    16285:
      id: 'oe_is_not_active'
      doc: 'The Broker Is Not Active'
    16300:
      id: 'e_system_wrong_state'
      doc: 'The System Is In A Wrong State To Make The Requested Change'
    16303:
      id: 'oe_auction_pending'
      doc: 'The Auction Is Pending'
    16307:
      id: 'oe_qty_freeze_can'
      doc: 'The Order Has Been Cancelled Due To Quantity Freeze'
    16308:
      id: 'oe_price_freeze_can'
      doc: 'The Order Has Been Cancelled Due To Price Freeze'
    16311:
      id: 'oe_sol_period_over'
      doc: 'The Solicitor Period For The Auction Is Over'
    16312:
      id: 'oe_comp_period_over'
      doc: 'The Competitor Period For The Auction Is Over'
    16313:
      id: 'oe_auc_period_greater'
      doc: 'The Auction Period Will Cross Market Close Time'
    16315:
      id: 'oe_limit_trigger'
      doc: 'The Limit Price Is Worse Than The Trigger Price'
    16316:
      id: 'oe_trigger_price_not_mult'
      doc: 'The Trigger Price Is Not A Multiple Of Tick Size'
    16317:
      id: 'oe_no_aon_attrib'
      doc: 'Aon Attribute Not Allowed'
    16318:
      id: 'oe_no_mf_attrib'
      doc: 'Mf Attribute Not Allowed'
    16319:
      id: 'oe_no_aon_in_attrib_1'
      doc: 'Aon Attribute Not Allowed At Security Level'
    16320:
      id: 'oe_no_mf_attrib_1'
      doc: 'Mf Attribute Not Allowed At Security Level'
    16321:
      id: 'oe_mf_greater_disc'
      doc: 'Mf Quantity Is Greater Than Disclosed Quantity'
    16322:
      id: 'oe_mf_not_mult'
      doc: 'Mf Quantity Is Not A Multiple Of Regular Lot'
    16323:
      id: 'oe_mf_greater_original'
      doc: 'Mf Quantity Is Greater Than Original Quantity'
    16324:
      id: 'oe_disc_greater_original'
      doc: 'Disclosed Quantity Is Greater Than Original Quantity'
    16325:
      id: 'oe_disc_not_mult'
      doc: 'Disclosed Quantity Is Not A Multiple Of Regular Lot'
    16326:
      id: 'oe_gtd_greater'
      doc: 'Gtd Is Greater Than That Specified At The Trading System'
    16327:
      id: 'oe_quantity_gerater_rl'
      doc: 'Odd Lot Quantity Cannot Be Greater Than Or Equal To Regular Lot Size'
    16328:
      id: 'oe_quantity_not_mult_rl'
      doc: 'Quantity Is Not A Multiple Of Regular Lot'
    16329:
      id: 'oe_broker_not_permitted'
      doc: 'Trading Member Not Permitted In The Market'
    16330:
      id: 'oe_is_suspended'
      doc: 'Security Is Suspended'
    16333:
      id: 'oe_branch_li_mit_exceeded'
      doc: 'Branch Order Value Limit Has Been Exceeded'
    16343:
      id: 'oe_ord_can_changed'
      doc: 'The Order To Be Cancelled Has Changed'
    16344:
      id: 'oe_ord_cannot_cancel'
      doc: 'The Order Cannot Be Cancelled'
    16345:
      id: 'oe_init_ord_cancel'
      doc: 'Initiator Order Cannot Be Cancelled'
    16346:
      id: 'oe_ord_cannot_modify'
      doc: 'Order Cannot Be Modified'
    16348:
      id: 'err_trading_not_allowed'
      doc: 'Trading Is Not Allowed In This Market'
    16357:
      id: 'oe_nt_rejected'
      doc: 'Control Has Rejected The Negotiated Trade'
    16363:
      id: 'chg_st_exists'
      doc: 'Status Is In The Required State'
    16369:
      id: 'oe_security_in_preopen'
      doc: 'Contract Is In Preopen'
    16372:
      id: 'oe_inq_not_allowed'
      doc: 'Order Entry Not Allowed For The User As It Is Of Inquiry Type'
    16387:
      id: 'oe_security_ineligible'
      doc: 'Contract Not Allowed To Trader In'
    16388:
      id: 'e_fok_order_cancelled'
      doc: 'Order Cancelled By System When Preopen Unmatched Orders Are Cancelled By The System After Preopen Session Ends When Normal Market Unmatched Orders Are Cancelled By The System If Order Collection Phase Is Planned After Circuit Hit When Ioc Unmatched Orders Are Cancelled By The System'
    16392:
      id: 'turnover_limit_not_provided'
      doc: 'Turnover Limit Not Provided Please Contact Exchange'
    16397:
      id: 'err_cannot_mod_auc_order'
      doc: 'Cannot Modify Auction Orders'
    16400:
      id: 'oe_max_dq_allowed'
      doc: 'Dq Is Less Than Minimum Quantity Allowed'
    16404:
      id: 'oe_admin_susp_can'
      doc: 'Order Has Been Cancelled Due To Freeze Admin Suspension'
    16405:
      id: 'e_invalid_buy_sell_type'
      doc: 'Buy Sell Type Entered Is Invalid'
    16406:
      id: 'e_invalid_book_type'
      doc: 'Book Type Entered Is Invalid'
    16408:
      id: 'e_invalid_trigger_price'
      doc: 'Triggerprice Entered Has Invalid Characters'
    16414:
      id: 'e_invalid_pro_client'
      doc: 'Pro Client Should Be Either 1 Client Or 2 Broker'
    16415:
      id: 'e_invalid_instructions'
      doc: 'Invalid Combination Of Book Type And Instructions Ordertype'
    16416:
      id: 'e_invalid_order_parameters'
      doc: 'Invalid Order Parameters'
    16418:
      id: 'e_nnf_req_exceeded'
      doc: 'Number Of Nnf Requests Exceeded'
    16419:
      id: 'invalid_order'
      doc: 'This Error Code Will Be Returned For Invalid Data In The Order Packet'
    16420:
      id: 'err_box_rate_exceeded_at_millisecond_level'
      doc: 'Box Rate Has Been Exceeded By The Member At Millisecond Level'
    16440:
      id: 'e_gtd_gt_maturity'
      doc: 'Gtd Is Greater Than Maturity Date'
    16441:
      id: 'dq_not_allowed_in_preopen'
      doc: 'Dq Orders Are Not Allowed In Preopen'
    16442:
      id: 'st_ord_not_allowed_popen'
      doc: 'St Orders Are Not Allowed In Preopen'
    16443:
      id: 'e_ord_lim_exceeds_ord_val_lim'
      doc: 'Order Value Exceeds The Order Limit Value'
    16444:
      id: 'err_usr_ord_value_limit_exceeded'
      doc: 'User Order Value Limit Exceeded'
    16445:
      id: 'sl_not_allowed'
      doc: 'Stop Loss Sl Orders Are Not Allowed'
    16446:
      id: 'mit_not_allowed'
      doc: 'Market If Touched Mit Orders Are Not Allowed'
    16447:
      id: 'e_ord_not_allowed_in_preopen'
      doc: 'Order Entry Not Allowed In Preopen'
    16448:
      id: 'error_sl_lmt_rsnblty_check'
      doc: 'Difference Between Limit Price And Trigger Price Is Beyond Permissible Range'
    16514:
      id: 'e_not_modifiable'
      doc: 'Not Modifiable'
    16518:
      id: 'e_tm_cm_does_not_exist'
      doc: 'Clearing Member Trading Member Link Not Found'
    16521:
      id: 'e_not_clg_mem'
      doc: 'Not A Clearing Member'
    16523:
      id: 'e_user_not_corp_mgr'
      doc: 'The User In Not A Corporate Manager'
    16532:
      id: 'e_pm_cm_invalid'
      doc: 'Clearing Member Participant Link Not Found'
    16533:
      id: 'e_corp_mgr_vu_mod'
      doc: 'Enter Either Trading Member Or Participant'
    16541:
      id: 'e_invalid_participant'
      doc: 'Participant Is Invalid'
    16550:
      id: 'e_trade_approved_by_cm'
      doc: 'Trade Cannot Be Modified Cancelled It Has Already Been Approved By Cm'
    16552:
      id: 'e_cm_stock_suspended'
      doc: 'Stock Has Been Suspended'
    16554:
      id: 'e_broker_not_permitted_in_fut'
      doc: 'Trading Member Not Permitted In Futures'
    16555:
      id: 'e_broker_not_permitted_in_opt'
      doc: 'Trading Member Not Permitted In Options'
    16556:
      id: 'e_qty_less_than_min_lot'
      doc: 'Quantity Less Than The Minimum Lot Size'
    16557:
      id: 'e_disc_qty_less_than_min_lot'
      doc: 'Disclose Quantity Less Than The Minimum Lot Size'
    16558:
      id: 'e_mf_qty_less_than_min_lot'
      doc: 'Minimum Fill Is Less Than The Minimum Lot Size'
    16560:
      id: 'e_already_rejected'
      doc: 'The Give Up Trade Has Already Been Rejected'
    16561:
      id: 'e_nt_orders_not_allowed'
      doc: 'Negotiated Orders Not Allowed'
    16562:
      id: 'e_nt_trade_not_allowed'
      doc: 'Negotiated Trade Not Allowed'
    16566:
      id: 'e_inconsistent_broker_branch'
      doc: 'User Does Not Belong To Broker Or Branch'
    16570:
      id: 'm_post_close_start'
      doc: 'The Market Is In Postclose'
    16571:
      id: 'm_post_close_ended'
      doc: 'The Closing Session Has Ended'
    16572:
      id: 'm_post_close_trades'
      doc: 'Closing Session Trades Have Been Generated'
    16573:
      id: 'e_invalid_msg_length'
      doc: 'Message Length Is Invalid'
    16574:
      id: 'e_invalid_open_close_type'
      doc: 'Open Close Type Entered Is Invalid'
    16576:
      id: 'e_nnf_inq_req_exceeded'
      doc: 'No Of Nnf Inquiry Requests Exceeded'
    16577:
      id: 'e_participant_and_volume_changed'
      doc: 'Both Participant And Volume Changed'
    16578:
      id: 'e_invalid_cover_uncover_type'
      doc: 'Cover Uncover Type Entered Is Invalid'
    16580:
      id: 'e_illegal_participant'
      doc: 'Order Does Not Belong To The Given Participant'
    16581:
      id: 'e_invalid_fill_price'
      doc: 'Invalid Trade Price'
    16583:
      id: 'e_pro_no_participant'
      doc: 'For Pro Order Participant Entry Not Allowed'
    16585:
      id: 'e_invalid_account_no'
      doc: 'Not A Valid Account Number'
    16586:
      id: 'e_allow_no_participant_order'
      doc: 'Participant Order Entry Not Allowed'
    16589:
      id: 'm_delete_all_orders'
      doc: 'All Continuous Session Orders Are Being Deleted Now'
    16597:
      id: 'e_cum_ur_ord_val_limit_exceede'
      doc: 'Branch Limit Should Be D Greater Than Sum Of User Limits'
    16598:
      id: 'e_branch_ord_val_limit_exceeded'
      doc: 'Branch Limit Should Be Greater Than Used Limit'
    16600:
      id: 'err_ord_val_exceeded'
      doc: 'The Order Value Has Exceeded Maximum Permissible Limit'
    16601:
      id: 'err_preopen_order_reject'
      doc: 'Request Rejected By The Exchange'
    16602:
      id: 'e_dealer_value_limit_exceeds'
      doc: 'Dealer Value Limit Exceeds The Set Limit'
    16604:
      id: 'e_participant_not_found'
      doc: 'Participant Not Found'
    16605:
      id: 'e_either_leg_failed'
      doc: 'One Leg Of Spread 2l Failed'
    16606:
      id: 'e_qty_greater_than_freeze_qty'
      doc: 'Quantity Greater Than Freeze Quantity'
    16607:
      id: 'e_spread_not_allowed'
      doc: 'Spread Not Allowed'
    16609:
      id: 'e_spread_allowed_if_stock_open'
      doc: 'Spread Allowed Only When Stock Is Open'
    16610:
      id: 'e_qty_should_be_same'
      doc: 'Both Legs Should Have Same Quantity'
    16611:
      id: 'e_ord_mod_qty_frz_not_allowed'
      doc: 'Modified Order Quantity Freeze Not Allowed'
    16612:
      id: 'e_trade_rec_modified'
      doc: 'The Trade Record Has Been Modified'
    16615:
      id: 'e_tm_order_cant_be_modified'
      doc: 'Order Cannot Be Modified'
    16616:
      id: 'e_tm_order_cant_be_cancelled'
      doc: 'Order Cannot Be Cancelled'
    16617:
      id: 'e_tm_trade_cant_be_manipulated'
      doc: 'Trade Cannot Be Manipulated'
    16625:
      id: 'e_cm_of_tm_suspended'
      doc: 'Clearing Member Is Suspended'
    16626:
      id: 'e_expdate_not_in_ascending_ord'
      doc: 'Expiry Date Not In Ascending Order'
    16627:
      id: 'e_invalid_contract_comb'
      doc: 'Invalid Contract Combination'
    16628:
      id: 'e_bm_cannot_cancel_cm_orders'
      doc: 'Branch Manager Cannot Cancel Corporate Managers Order'
    16629:
      id: 'e_bm_cannot_cancel_bm_orders'
      doc: 'Branch Manager Cannot Cancel Other Branch Managers Order'
    16630:
      id: 'e_cm_cannot_cancel_cm_orders'
      doc: 'Corporate Manager Cannot Cancel Other Corporate Managers Order'
    16631:
      id: 'e_spread_in_different_underlying'
      doc: 'Spread Not Allowed For Different Underlying'
    16632:
      id: 'e_invalid_cli_ac'
      doc: 'Cli Ac Number Cannot Be Modified As Trading Member Id'
    16636:
      id: 'e_br_ord_limit_fut_buy_exceeded'
      doc: 'Futures Buy Branch Order Value Limit Has Been Exceeded'
    16637:
      id: 'e_br_ord_limit_fut_sell_exceeded'
      doc: 'Futures Sell Branch Order Value Limit Has Been Exceeded'
    16638:
      id: 'e_br_ord_limit_opt_buy_exceeded'
      doc: 'Options Buy Branch Order Value Limit Has Been Exceeded'
    16639:
      id: 'e_br_ord_limit_opt_sell_exceeded'
      doc: 'Options Sell Branch Order Value Limit Has Been Exceeded'
    16640:
      id: 'e_ur_ord_limit_fut_buy_exceeded'
      doc: 'Futures Buy Used Limit Exceeded The User Limit'
    16641:
      id: 'e_ur_ord_limit_fut_sell_exceeded'
      doc: 'Futures Sell Used Limit Exceeded The User Limit'
    16642:
      id: 'e_ur_ord_limit_opt_buy_exceeded'
      doc: 'Options Buy Used Limit Exceeded The User Limit'
    16643:
      id: 'e_ur_ord_limit_opt_sell_exceeded'
      doc: 'Options Sell Used Limit Exceeded The User Limit'
    16645:
      id: 'e_cant_appr_bhav_copy_generated'
      doc: 'Cannot Approve Bhavcopy Generated'
    16646:
      id: 'e_collateral_lmt_chk'
      doc: 'Cannot Modify'
    16656:
      id: 'e_address_not_found'
      doc: 'No Address In The Database'
    16662:
      id: 'e_stk_in_popen'
      doc: 'Contract Is Opening Please Wait For The Contract To Open'
    16666:
      id: 'e_invalid_nnf_field'
      doc: 'Invalid Nnf Field'
    16667:
      id: 'e_gtcgtd_not_allowed'
      doc: 'Gtc Gtd Orders Not Allowed'
    16683:
      id: 'err_user_already_signed_off'
      doc: 'User Has Already Signed Off'
    16684:
      id: 'err_no_privilege'
      doc: 'User Has No Authority To Request For Change Of Mentioned User In Actual Packet'
    16686:
      id: 'closeout_order_reject'
      doc: 'This Error Code Will Be Returned If Close Out Order Rejected By The System'
    16687:
      id: 'closeout_frz_reject'
      doc: 'This Error Code Will Be Returned If The Close Out Order Entered Is Going Into Freeze Since Freeze Is Not Allowed For Close Out Orders'
    16688:
      id: 'closeout_not_allowed'
      doc: 'This Error Code Will Be Returned If The Close Out Order Is Not Allowed In The System'
    16690:
      id: 'closeout_trdmod_reject'
      doc: 'This Error Code Will Be Returned When A Trade Mod Request Is Placed By A Broker In Closeout'
    16706:
      id: 'partial_order_reject'
      doc: 'Cancelled By The System'
    16708:
      id: 'partial_quick_order_cxl_rej'
      doc: 'System Error Orders Not Completely Cancelled By The System Please Request Quick Cxl Again'
    16711:
      id: 'error_invalid_sprd_combination'
      doc: 'Spread Order Entered Has Invalid Combination'
    16713:
      id: 'e_price_diff_out_of_range'
      doc: 'Price Difference Is Beyond Operating Range'
    16725:
      id: 'rms_rejected_in_preopen'
      doc: 'Order Entry Modification Rejected By The Exchange'
    16730:
      id: 'error_algoid_nnfid_mismatch_1'
      doc: 'Nnf Id Algo Id Mismatch Algo Id Entered Is 0 In Order Request'
    16731:
      id: 'error_algoid_nnfid_mismatch_2'
      doc: 'Nnf Id Algo Id Mismatch For Non Algo Orders Algo Id Should Be 0 Zero In Order Request'
    16732:
      id: 'error_algo_mkt_not_allowed'
      doc: 'Market Order Not Allowed For Algo Order'
    16733:
      id: 'error_invalid_nnf_id'
      doc: 'Invalid Nnf Id'
    16749:
      id: 'error_preopn_ato_mod_can_rej'
      doc: 'Modification Cancellation Of Ato Orders Are Currently Not Allowed'
    16752:
      id: 'error_preopn_ato_not_allowed'
      doc: 'Ato Orders Are Currently Not Allowed In Preopen'
    16778:
      id: 'err_usr_not_found_in_nnf_file'
      doc: 'User Is Not Nnf User'
    16793:
      id: 'e_vc_order_rejected'
      doc: 'Order Entered Has Invalid Data'
    16794:
      id: 'e_ssd_order_rejected'
      doc: 'Order Entered Has Invalid Data'
    16795:
      id: 'e_order_cancelled_for_vc'
      doc: 'Order Cancelled Due To Voluntary Close Out'
    16796:
      id: 'e_order_cancelled_for_ssd'
      doc: 'Order Cancelled Due To Oi Violation'
    16797:
      id: 'msg_code_voluntary_close_out_status'
      doc: 'Broker Is In Voluntary Closeout'
    16798:
      id: 'msg_code_suspended_status'
      doc: 'Broker Is Suspended'
    16803:
      id: 'e_bo_price_out_of_range'
      doc: 'Bulk Order Rejected Due To Price Freeze'
    16804:
      id: 'e_bo_excess_quantity'
      doc: 'Bulk Order Rejected Due To Quantity Freeze'
    16805:
      id: 'e_user_ineligible_for_bulk_orders'
      doc: 'Trader Not Eligible For Bulk Order'
    16806:
      id: 'e_user_not_allowed_for_regular'
      doc: 'Trader Allowed To Enter Only Bulk Order'
    16807:
      id: 'e_account_debarred'
      doc: 'The Account Is Disabled From Trading As Per Directions Of Sebi Statutory Authority'
    16816:
      id: 'e_account_debarred_by_pit'
      doc: 'Account Is Disabled For Trading In The Scrip During The Trading Window Closure Period Sebi Pit Reg Please Contact The Company For More Details'
    16810:
      id: 'err_usr_already_unlcked'
      doc: 'User Is Already Unlocked'
    16811:
      id: 'err_duplicate_unlck_alrt'
      doc: 'User Unlock Request Is Already Present For Requested User'
    17022:
      id: 'err_actv_num_of_usrs_in_brnch_exceeded'
      doc: 'Active Number Of Users In Branch Exceeded'
    17039:
      id: 'ec_trd_mod_rej_cli_cp_mod_not_allowed'
      doc: 'Client Code Participant Modification Not Allowed'
    17045:
      id: 'error_quantity_lim_exceeds_qty_val_lim'
      doc: 'Order Quantity Exceeds Quantity Value Limit For The User'
    17046:
      id: 'user_trd_mod_disabled'
      doc: 'Trade Modification Not Allowed For The User'
    16055:
      id: 'preopen_trade_cancellation_not_allowed'
      doc: 'Trade Executed During Preopen Session Not Allowed To Cancel'
    17063:
      id: 'err_depndent_sessn_not_active'
      doc: 'Dependent Session Is Not Active'
    17070:
      id: 'e_trd_price_out_of_stock_tpp'
      doc: 'The Price Is Out Of The Current Execution Lpp Range Etrdpriceoutofstocklpp'
    17071:
      id: 'e_order_cancelled_for_self_trade'
      doc: 'The Order Could Have Resulted In Self Trade'
    17101:
      id: 'e_invalid_packet'
      doc: 'The Packet Has Invalid Data'
    17102:
      id: 'sssssse_hearbeat_not_received'
      doc: 'Heartbeat Not Received'
    17104:
      id: 'e_invalid_box_id'
      doc: 'Invalid Box Id'
    17105:
      id: 'e_seq_no_mismatch'
      doc: 'Sequence Number Mismatch'
    17106:
      id: 'e_box_rate_exceeded'
      doc: 'Box Rate Has Been Exceeded By The Member'
    17107:
      id: 'error_hb_rate_exceeded'
      doc: 'Heart Beat Rate Exceeded By The Member'
    17142:
      id: 'e_max_user_count_exceeded'
      doc: 'Maximum User Login Allowed Per Box Has Been Exceeded'
    16403:
      id: 'e_invalid_box_ip_combination'
      doc: 'Login From Invalid Ip'
    17177:
      id: 'err_invalid_pan_id'
      doc: 'Invalid Pan Id'
    17179:
      id: 'err_invalid_algo_id'
      doc: 'Invalid Algo Id'
    17180:
      id: 'err_invalid_value_in_reserved'
      doc: 'Invalid Value In The Reserved Field'
    17185:
      id: 'err_algo_id_disabled'
      doc: 'Order Rejected As Algo Id Is Disabled By The Exchange'
    17186:
      id: 'err_order_cancelled_algoid_disabled'
      doc: 'Order Cancelled As Algo Id Is Disabled By The Exchange'
    19028:
      id: 'err_checksum_failed_gr'
      doc: 'Checksum Verification Failed At Gateway Router'
    19029:
      id: 'err_multiple_gr_query_rcv'
      doc: 'Multiple Grquery Request Received'
    17181:
      id: 'err_mkt_order_not_allowed'
      doc: 'Contract Not Traded Market Order Not Allowed'
    17182:
      id: 'err_trade_beyond_markup_price'
      doc: 'Order Could Have Resulted In Trade Beyond Markup Price'
    19030:
      id: 'err_encryption_flag_mismatch'
      doc: 'Encryption Flag Mismatch'
    19031:
      id: 'err_md_5_checksum_failure'
      doc: 'Md 5 Checksum Failed'
    17184:
      id: 'err_user_having_null_rights'
      doc: 'Order Rejected As User Has No Trading Rights'
  market_status_normal:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  market_status_oddlot:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  market_status_spot:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  market_status_auction:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  ex_market_status_normal:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  ex_market_status_oddlot:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  ex_market_status_spot:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  ex_market_status_auction:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  pl_market_status_normal:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  pl_market_status_oddlot:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  pl_market_status_spot:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  pl_market_status_auction:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
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
  participant_type:
    0x49:
      id: 'initiator'
      doc: 'Initiator'
    0x43:
      id: 'competitor'
      doc: 'Competitor'
    0x53:
      id: 'solicitor'
      doc: 'Solicitor'
  modified_cancelled_by:
    0x54:
      id: 'trader'
      doc: 'Trader'
    0x42:
      id: 'branch_manager'
      doc: 'Branch Manager'
    0x4d:
      id: 'corporate_manager'
      doc: 'Corporate Manager'
    0x43:
      id: 'exchange'
      doc: 'Exchange'
  reason_code:
    2:
      id: 'exercise'
      doc: 'Exercise'
    3:
      id: 'position_liquidation'
      doc: 'Position Liquidation'
    5:
      id: 'security'
      doc: 'Security'
    6:
      id: 'broker'
      doc: 'Broker'
    7:
      id: 'branch'
      doc: 'Branch'
    8:
      id: 'user'
      doc: 'User'
    9:
      id: 'participant'
      doc: 'Participant'
    10:
      id: 'counter_party'
      doc: 'Counter Party'
    11:
      id: 'order_number'
      doc: 'Order Number'
    12:
      id: 'market_status'
      doc: 'Market Status'
    15:
      id: 'auction_number'
      doc: 'Auction Number'
    16:
      id: 'order_type'
      doc: 'Order Type'
    17:
      id: 'price_freeze'
      doc: 'Price Freeze'
    18:
      id: 'quantity_freeze'
      doc: 'Quantity Freeze'
    20:
      id: 'contract'
      doc: 'Contract'
    30:
      id: 'exercise_mode_mismatch'
      doc: 'Exercise Mode Mismatch'
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
      id: 'negotiated_order'
      doc: 'Negotiated Order'
    5:
      id: 'odd_lot_order'
      doc: 'Odd Lot Order'
    6:
      id: 'spot_order'
      doc: 'Spot Order'
    7:
      id: 'auction_order'
      doc: 'Auction Order'
  buy_sell_indicator:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  order_pre_open:
    0:
      id: 'normal_market_order'
      doc: 'Normal Market Order'
    1:
      id: 'preopen_session_order'
      doc: 'Preopen Session Order'
  market:
    0:
      id: 'market_order'
      doc: 'Market Order'
    1:
      id: 'not_a_market_order'
      doc: 'Not A Market Order'
  stpc:
    0:
      id: 'cancel_order_resulting_in_self_trade_by_exchange_default'
      doc: 'Cancel Order Resulting In Self Trade By Exchange Default'
    1:
      id: 'cancel_active_order_resulting_in_self_trade'
      doc: 'Cancel Active Order Resulting In Self Trade'
  buy_sell:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  mkt_type:
    0x31:
      id: 'normal_market'
      doc: 'Normal Market'
    0x32:
      id: 'odd_lot_market'
      doc: 'Odd Lot Market'
    0x33:
      id: 'spot_market'
      doc: 'Spot Market'
    0x34:
      id: 'auction_market'
      doc: 'Auction Market'
  book_type_1:
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
      id: 'negotiated_order'
      doc: 'Negotiated Order'
    5:
      id: 'odd_lot_order'
      doc: 'Odd Lot Order'
    6:
      id: 'spot_order'
      doc: 'Spot Order'
    7:
      id: 'auction_order'
      doc: 'Auction Order'
  status:
    0:
      id: 'end_of_outage'
      doc: 'End Of Outage'
    1:
      id: 'start_of_outage'
      doc: 'Start Of Outage'

