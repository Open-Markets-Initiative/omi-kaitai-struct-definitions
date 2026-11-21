# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseIx OrderEntry Nnf v1.12
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End
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
  id: nse_nseix_orderentry_nnf_v1_12_server
  title: Nse NseIx OrderEntry Nnf v1.12
  license: MIT-0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE International Exchange Order Entry Nnf v1.12'
doc-ref: https://www.nseix.com/technology/tradingprotocol

seq:
  - id: server_message
    type: server_message_struct
    repeat: eos
    doc: 'Nnf interactive message sent by the exchange'

types:
  server_message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: server_message_payload
        size: message_header.message_length - 40
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::sign_on_request_out_message': sign_on_request_out_message
            'transaction_code::sign_on_request_out_message_5585': sign_on_request_out_message
            'transaction_code::sign_off_request_out_message': sign_off_request_out_message
            'transaction_code::system_information_out_message': system_information_out_message
            'transaction_code::system_information_out_message_7321': system_information_out_message
            'transaction_code::update_local_database_header_message': update_local_database_header_message
            'transaction_code::update_local_database_trailer_message': update_local_database_trailer_message
            'transaction_code::update_local_database_data_message': update_local_database_data_message
            'transaction_code::message_record_message': message_record_message
            'transaction_code::order_confirmation_message': order_confirmation_message
            'transaction_code::order_confirmation_message_2083': order_confirmation_message
            'transaction_code::order_modification_confirmation_message': order_modification_confirmation_message
            'transaction_code::order_modification_confirmation_message_2085': order_modification_confirmation_message
            'transaction_code::order_response_message': order_response_message
            'transaction_code::order_response_message_2012': order_response_message
            'transaction_code::order_response_message_2041': order_response_message
            'transaction_code::order_response_message_2042': order_response_message
            'transaction_code::order_response_message_2071': order_response_message
            'transaction_code::order_response_message_2072': order_response_message
            'transaction_code::order_response_message_2087': order_response_message
            'transaction_code::order_response_message_2088': order_response_message
            'transaction_code::order_response_message_2089': order_response_message
            'transaction_code::order_response_message_2170': order_response_message
            'transaction_code::order_response_message_2231': order_response_message
            'transaction_code::order_response_message_9002': order_response_message
            'transaction_code::order_response_message_27100': order_response_message
            'transaction_code::order_cancellation_confirmation_message': order_cancellation_confirmation_message
            'transaction_code::trade_inquiry_response_message': trade_inquiry_response_message
            'transaction_code::trade_inquiry_response_message_2288': trade_inquiry_response_message
            'transaction_code::trade_inquiry_response_message_5441': trade_inquiry_response_message
            'transaction_code::trade_inquiry_response_message_5450': trade_inquiry_response_message
            'transaction_code::trade_inquiry_response_message_5452': trade_inquiry_response_message
            'transaction_code::trade_inquiry_response_message_5453': trade_inquiry_response_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2212': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2222': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2282': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2286': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2287': trade_confirmation_message
            'transaction_code::trade_confirmation_message_5449': trade_confirmation_message
            'transaction_code::spread_order_response_message': spread_order_response_message
            'transaction_code::spread_order_response_message_2103': spread_order_response_message
            'transaction_code::spread_order_response_message_2105': spread_order_response_message
            'transaction_code::spread_order_response_message_2107': spread_order_response_message
            'transaction_code::spread_order_response_message_2119': spread_order_response_message
            'transaction_code::spread_order_response_message_2124': spread_order_response_message
            'transaction_code::spread_order_response_message_2125': spread_order_response_message
            'transaction_code::spread_order_response_message_2126': spread_order_response_message
            'transaction_code::spread_order_response_message_2127': spread_order_response_message
            'transaction_code::spread_order_response_message_2130': spread_order_response_message
            'transaction_code::spread_order_response_message_2131': spread_order_response_message
            'transaction_code::spread_order_response_message_2132': spread_order_response_message
            'transaction_code::spread_order_response_message_2133': spread_order_response_message
            'transaction_code::spread_order_response_message_2136': spread_order_response_message
            'transaction_code::spread_order_response_message_2154': spread_order_response_message
            'transaction_code::spread_order_response_message_2155': spread_order_response_message
            'transaction_code::spread_order_response_message_2156': spread_order_response_message
            'transaction_code::spread_order_response_message_9004': spread_order_response_message
            'transaction_code::spread_order_response_message_27102': spread_order_response_message
            'transaction_code::spread_order_response_message_27103': spread_order_response_message
            'transaction_code::spread_order_response_message_27104': spread_order_response_message
            'transaction_code::user_order_limit_update_message': user_order_limit_update_message
            'transaction_code::dealer_limit_update_message': dealer_limit_update_message
            'transaction_code::spread_order_limit_update_message': spread_order_limit_update_message
            'transaction_code::control_message_to_trader_message': control_message_to_trader_message
            'transaction_code::mba_inquiry_response_message': mba_inquiry_response_message
            'transaction_code::mba_inquiry_response_message_1687': mba_inquiry_response_message
            'transaction_code::mba_inquiry_response_message_1689': mba_inquiry_response_message
            'transaction_code::market_statistics_report_message': market_statistics_report_message
            'transaction_code::spread_bhavcopy_message': spread_bhavcopy_message
            'transaction_code::giveup_confirmation_message': giveup_confirmation_message
            'transaction_code::giveup_confirmation_message_4507': giveup_confirmation_message
            'transaction_code::gateway_router_response_message': gateway_router_response_message
            'transaction_code::box_sign_on_request_out_message': box_sign_on_request_out_message
            'transaction_code::box_sign_off_message': box_sign_off_message
            'transaction_code::contingency_broadcast_message': contingency_broadcast_message
            'transaction_code::branch_order_value_limit_update_response_message': branch_order_value_limit_update_response_message
            'transaction_code::reset_user_password_response_message': reset_user_password_response_message
            'transaction_code::collateral_user_status_change_response_message': collateral_user_status_change_response_message
            'transaction_code::user_trade_modify_cancel_status_change_response_message': user_trade_modify_cancel_status_change_response_message
            'transaction_code::user_address_unlock_confirm_message': user_address_unlock_confirm_message
            'transaction_code::user_address_unlock_approve_message': user_address_unlock_approve_message
            'transaction_code::user_address_unlock_approve_message_5484': user_address_unlock_approve_message
            'transaction_code::nlt_order_message_to_trader_message': nlt_order_message_to_trader_message
            'transaction_code::nlt_order_inquiry_response_message': nlt_order_inquiry_response_message
  message_header:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Type of message sent or received'
      - id: log_time
        type: dos_second_timestamp_nullable
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch. Nullable, No Value = 0'
      - id: alpha_char
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'First two characters of Symbol when the message carries one'
      - id: trader_id
        type: s4
        doc: 'Connected user''s trader Id, which the order must belong to'
      - id: error_code
        type: s2_nullable
        doc: 'Zero when the request succeeded, otherwise an Error Response follows. Nullable, No Error = 0'
      - id: header_timestamp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Used at the host end; zero when sent to the host'
      - id: time_stamp_1
        type: str_8_nullable
        doc: 'Time the message arrived at the trading system host, in jiffies; zero when sent to the host. Nullable, No Value = 00000000'
      - id: time_stamp_2
        type: str_8_nullable
        doc: 'Number of the machine the packet comes from; zero when sent to the host. Nullable, No Value = 00000000'
      - id: message_length
        type: s2
        doc: 'Length of the entire message including the message header'
  sign_on_request_out_message:
    seq:
      - id: sign_on_response_body
        type:
          switch-on: _parent.message_header.message_length
          cases:
            214: sign_on_out_body
            182: error_response_body
  sign_on_out_body:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password of the user'
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
        doc: 'Name of the trader, blank on the request'
      - id: last_password_change_date
        type: dos_second_timestamp
        doc: 'Date the password was last changed. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: version_number
        type: s4
        doc: 'Version number of the trading system'
      - id: end_time
        type: dos_second_timestamp
        doc: 'Time the markets last closed. Seconds since Dos epoch'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: colour
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Colour, blank on the request'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: user_type
        type: s2
        enum: user_type
        doc: 'Type of the user'
      - id: sequence_number
        type: floating_point_integer
        doc: 'Sequence number, zero on the request'
      - id: ws_class_name
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Network Id of the workstation'
      - id: broker_status
        type: u1
        enum: broker_status
        doc: 'Status of the trading member, blank on the request'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: st_broker_eligibility_per_mkt
        type: st_broker_eligibility_per_mkt
        doc: 'Markets the trading member may place orders in'
      - id: member_type
        type: s2
        enum: member_type
        doc: 'Type of the trading member'
      - id: clearing_status
        type: u1
        enum: clearing_status
        doc: 'Clearing status of the trading member'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trading member'
  st_broker_eligibility_per_mkt:
    seq:
      - id: normal_market
        type: b1
        doc: 'Eligible for the normal market'
      - id: oddlot_market
        type: b1
        doc: 'Eligible for the odd lot market'
      - id: spot_market
        type: b1
        doc: 'Eligible for the spot market'
      - id: auction_market
        type: b1
        doc: 'Eligible for the auction market'
      - id: preopen
        type: b1
        doc: 'Eligible for the pre open session'
      - id: pre_close
        type: b1
        doc: 'Eligible for the pre close session'
      - id: nlt
        type: b1
        doc: 'Eligible for negotiated large trades'
      - id: reserved_19
        type: b9
        doc: 'Reserved'
  error_response_body:
    seq:
      - id: key
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token number of the contract'
      - id: error_message
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Error message; see the List of Error Codes in the Appendix'
  sign_off_request_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: reserved_145
        size: 145
        doc: 'Reserved'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
        doc: 'Not used'
      - id: c_filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: market_index
        type: s4
        doc: 'Set to a thousand and of no use'
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
        doc: 'Default competitor period for an auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for an auction'
      - id: warning_percent
        type: s2
        doc: 'Warning percentage'
      - id: volume_freeze_percent
        type: s2
        doc: 'Volume freeze percentage'
      - id: snap_quote_time
        type: s2
        doc: 'Snap quote time in seconds'
      - id: reserved_2
        size: 2
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
      - id: normal
        type: s2
        enum: normal
        doc: 'Status of the normal market'
      - id: oddlot
        type: s2
        enum: oddlot
        doc: 'Status of the odd lot market'
      - id: spot
        type: s2
        enum: spot
        doc: 'Status of the spot market'
      - id: auction
        type: s2
        enum: auction
        doc: 'Status of the auction market'
  st_ex_market_status:
    seq:
      - id: normal
        type: s2
        enum: normal
        doc: 'Status of the normal market'
      - id: oddlot
        type: s2
        enum: oddlot
        doc: 'Status of the odd lot market'
      - id: spot
        type: s2
        enum: spot
        doc: 'Status of the spot market'
      - id: auction
        type: s2
        enum: auction
        doc: 'Status of the auction market'
  st_pl_market_status:
    seq:
      - id: normal
        type: s2
        enum: normal
        doc: 'Status of the normal market'
      - id: oddlot
        type: s2
        enum: oddlot
        doc: 'Status of the odd lot market'
      - id: spot
        type: s2
        enum: spot
        doc: 'Status of the spot market'
      - id: auction
        type: s2
        enum: auction
        doc: 'Status of the auction market'
  st_stock_eligible_indicators:
    seq:
      - id: aon
        type: b1
        doc: 'Eligible for all or none orders'
      - id: minimum_fill
        type: b1
        doc: 'Eligible for minimum fill orders'
      - id: books_merged
        type: b1
        doc: 'Whether the books are merged'
      - id: reserved_113
        type: b13
        doc: 'Reserved'
  update_local_database_header_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'Reserved'
  update_local_database_trailer_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'Reserved'
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
        type: dos_second_timestamp
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch'
      - id: inner_alpha_char
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'First two characters of Symbol when the record carries one'
      - id: inner_transaction_code
        type: s2
        doc: 'Type of record carried in the data region'
      - id: inner_error_code
        type: s2
        doc: 'Zero when the record is valid'
      - id: inner_timestamp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Used at the host end'
      - id: inner_time_stamp_1
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the record arrived at the trading system host'
      - id: inner_time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of the machine the record came from'
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
        doc: 'Downloaded message body selected by Inner Transaction Code'
  message_download_data:
    seq:
      - id: download_payload
        size-eos: true
        doc: 'Downloaded message body, any transaction code, opaque'
  order_confirmation_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_entry_body:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of participant, not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for an auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for an auction'
      - id: modified_cancelled_by
        type: u1
        enum: modified_cancelled_by
        doc: 'Who modified or cancelled the order'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason the give up was rejected'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract the order was placed on'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party trading member Id of a negotiated order'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order closes out a position of a broker in closeout'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Type of the order'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the order to be modified'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type of the counter order'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity still outstanding'
      - id: volume
        type: s4
        doc: 'Latest image of the order''s volume'
      - id: volume_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: price
        type: s4
        doc: 'New price of the order, zero to make it a market order'
      - id: trigger_price
        type: s4
        doc: 'Price at which a stop loss order triggers'
      - id: good_till_date
        type: s4
        doc: 'Good till date, as a number of days or as a date in seconds since midnight January 1, 1980'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum quantity that must be filled'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Last modified time received on the last response for the order. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: trader_id
        type: s4
        doc: 'Connected user''s trader Id, which the order must belong to'
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
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is a client order or the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free for the front end to use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit Non Neat front end identifier supplied by the member'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Market replay, zero when sending to the host'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Echo back field, carrying the algo Id in bytes 11 to 14'
      - id: last_activity_reference
        type: s8
        doc: 'Last activity reference received for the order'
      - id: reserved_52
        size: 52
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
        doc: 'Symbol of the underlying'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of an option, minus one for a future'
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
    seq:
      - id: ato
        type: b1
        doc: 'Market order in the pre open or pre close session'
      - id: market
        type: b1
        doc: 'Market order'
      - id: sl
        type: b1
        doc: 'Stop loss order'
      - id: mit
        type: b1
        doc: 'Market if touched order'
      - id: day
        type: b1
        doc: 'Day order'
      - id: gtc
        type: b1
        doc: 'Good till cancelled order'
      - id: ioc
        type: b1
        doc: 'Immediate or cancel order'
      - id: aon
        type: b1
        doc: 'Eligible for all or none orders'
      - id: mf
        type: b1
        doc: 'Minimum fill order'
      - id: matched_ind
        type: b1
        doc: 'Negotiated order has found a matching order'
      - id: traded
        type: b1
        doc: 'Order has traded partly or fully'
      - id: modified
        type: b1
        doc: 'Order has been modified'
      - id: frozen
        type: b1
        doc: 'Order has gone for a freeze'
      - id: preopen
        type: b1
        doc: 'Eligible for the pre open session'
      - id: pre_close
        type: b1
        doc: 'Eligible for the pre close session'
      - id: nlt_indc
        type: b1
        doc: 'Order is a negotiated large trade order'
  additional_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_bit_1
        type: b1
        doc: 'Reserved'
      - id: col
        type: b1
        doc: 'Cancel on logoff'
      - id: reserved_34
        type: b2
        doc: 'Reserved'
      - id: stpc
        type: b1
        doc: 'Self trade prevention check'
      - id: session_ind
        type: b1
        doc: 'Session the trade was done in, stamped only on trade messages'
      - id: reserved_78
        type: b2
        doc: 'Reserved'
  order_modification_confirmation_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_response_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_cancellation_confirmation_message:
    seq:
      - id: cancellation_confirmation_body
        type:
          switch-on: _parent.message_header.message_length
          cases:
            316: order_entry_body
            480: spread_order_body
  spread_order_body:
    seq:
      - id: participant_type_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: competitor_period_1
        type: s2
        doc: 'Not used'
      - id: solicitor_period_1
        type: s2
        doc: 'Not used'
      - id: mod_cxl_by_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Who modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Reason the request was rejected'
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
        doc: 'Counter party trading member Id, not used'
      - id: fillerx_1
        size: 1
        doc: 'Filler'
      - id: filler_options_1
        size: 3
        doc: 'Filler'
      - id: fillery_1
        size: 1
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
        doc: 'Book the order belongs to'
      - id: buy_sell_1
        type: s2
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
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
        type: s4
        doc: 'Price of the first leg, not used for a spread order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: s4
        doc: 'Not used'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order entered the system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified. Seconds since Dos epoch'
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
        doc: 'Participant responsible for settling the trades'
      - id: pro_client_1
        type: s2
        doc: 'Whether the order is a client order or the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_116
        size: 2
        doc: 'Sixteen filler bits carrying no meaning'
      - id: filler_17
        size: 1
        doc: 'Filler'
      - id: filler_18
        size: 1
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit Non Neat front end identifier supplied by the member'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Market replay, zero when sending to the host'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Echo back field, carrying the algo Id in bytes 11 to 14'
      - id: last_activity_reference
        type: s8
        doc: 'Last activity reference received for the order'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Price difference between the second and first legs, for a spread order only'
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
        doc: 'Counter party trading member Id, not used'
      - id: fillerx_2
        size: 1
        doc: 'Filler'
      - id: order_type_2
        type: s2
        doc: 'Not used'
      - id: buy_sell_2
        type: s2
        doc: 'Whether the leg is a buy or a sell'
      - id: disclosed_vol_2
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_2
        type: s4
        doc: 'Not used'
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
        type: s4
        doc: 'Not used'
      - id: trigger_price_2
        type: s4
        doc: 'Not used'
      - id: min_fill_aon_2
        type: s4
        doc: 'Not used'
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
      - id: giveup_flag_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_y
        size: 1
        doc: 'Filler'
  trade_inquiry_response_message:
    seq:
      - id: trade_inquiry_body
        type: trade_inquiry_body
        doc: 'Trade Inquiry Body'
  trade_inquiry_body:
    seq:
      - id: token_no
        type: s4
        doc: 'Token number of the contract the order was placed on'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_quantity
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded'
      - id: mkt_type
        type: u1
        enum: mkt_type
        doc: 'Market the trade took place in'
      - id: buy_open_close
        type: u1
        enum: buy_open_close
        doc: 'Open or close indicator of the buy trade'
      - id: new_volume
        type: s4
        doc: 'Zero on a trade confirmation, the modified trade quantity on a trade modification approval'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id of the buy side'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id of the sell side'
      - id: trader_id
        type: s4
        doc: 'Connected user''s trader Id, which the order must belong to'
      - id: requested_by
        type: u1
        enum: requested_by
        doc: 'Side requesting the trade modification'
      - id: sell_open_close
        type: u1
        enum: sell_open_close
        doc: 'Open or close indicator of the sell trade'
      - id: buy_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number of the buy side'
      - id: sell_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number of the sell side'
      - id: buy_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant Id of the buy side'
      - id: sell_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant Id of the sell side'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: buy_giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag of the buy side'
      - id: sell_giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag of the sell side'
      - id: reserved_80
        size: 80
        doc: 'Reserved'
  trade_confirmation_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: trader_number
        type: s4
        doc: 'Trader or user Id'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: original_volume
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'New price of the order, zero to make it a market order'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: good_till_date
        type: s4
        doc: 'Good till date, as a number of days or as a date in seconds since midnight January 1, 1980'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_quantity
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded'
      - id: volume_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Activity type'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'Time the activity took place. Seconds since Dos epoch'
      - id: counter_trader_order_number
        type: floating_point_integer
        doc: 'Order number of the counter order taking part in the trade'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id of the counter party'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: token
        type: s4
        doc: 'Token number of the contract'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: old_open_close
        type: u1
        enum: old_open_close
        doc: 'Previous open or close indicator'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book type of the order'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Zero on a trade confirmation, the modified trade quantity on a trade modification approval'
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
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: u1
        enum: give_up_trade
        doc: 'Give up flag of the trade'
      - id: fifth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: reserved_10
        size: 10
        doc: 'Reserved'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Echo back field, carrying the algo Id in bytes 11 to 14'
      - id: last_activity_reference
        type: s8
        doc: 'Last activity reference received for the order'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  spread_order_response_message:
    seq:
      - id: spread_order_body
        type: spread_order_body
        doc: 'Spread Order Body'
  user_order_limit_update_message:
    seq:
      - id: user_limit_response_body
        type:
          switch-on: _parent.message_header.message_length
          cases:
            206: user_order_limit_body
            208: user_order_value_limit_body
            182: error_response_body
  user_order_limit_body:
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
        doc: 'Id of the user signing on, or of the user to reset'
      - id: user_type
        type: s2
        enum: user_type
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
        doc: 'Total buy order limit of the user''s branch'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'Total sell order limit of the user''s branch'
      - id: branch_used_buy_value_limit
        type: floating_point_integer
        doc: 'Buy order limit used by the user''s branch'
      - id: branch_used_sell_value_limit
        type: floating_point_integer
        doc: 'Sell order limit used by the user''s branch'
      - id: user_order_buy_value_limit
        type: floating_point_integer
        doc: 'Total buy order limit of the user'
      - id: user_order_sell_value_limit
        type: floating_point_integer
        doc: 'Total sell order limit of the user'
      - id: user_order_used_buy_value_limit
        type: floating_point_integer
        doc: 'Buy order limit used by the user'
      - id: user_order_used_sell_value_limit
        type: floating_point_integer
        doc: 'Sell order limit used by the user'
  user_order_value_limit_body:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: reserved_26
        size: 26
        doc: 'Reserved'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: user_limits
        type: user_limits
        repeat: expr
        repeat-expr: 2
        doc: 'USER_LIMITS'
  user_limits:
    seq:
      - id: reserved_32
        size: 32
        doc: 'Reserved'
      - id: user_order_buy_value_limit
        type: floating_point_integer
        doc: 'Total buy order limit of the user'
      - id: user_order_sell_value_limit
        type: floating_point_integer
        doc: 'Total sell order limit of the user'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
  dealer_limit_update_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
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
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: spd_ord_qty_buff
        type: floating_point_integer
        doc: 'Maximum order quantity the user may enter in a spread order'
      - id: spd_ord_val_buff
        type: floating_point_integer
        doc: 'Maximum order value the user may enter in a spread order'
  control_message_to_trader_message:
    seq:
      - id: trader_id
        type: s4
        doc: 'Connected user''s trader Id, which the order must belong to'
      - id: action_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Action code indicating the action taken'
      - id: reserved_1
        size: 1
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
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  mba_inquiry_response_message:
    seq:
      - id: token
        type: s4
        doc: 'Token number of the contract'
      - id: book
        type: s2
        doc: 'Book inquired on, currently only the regular lot book'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell'
      - id: mba_inquiry_result
        type: mba_inquiry_result
        doc: 'Mba Inquiry Result'
  mba_inquiry_result:
    seq:
      - id: cumulative_quantity
        type: s4
        doc: 'Cumulative quantity inquired on'
      - id: total_value
        type: floating_point_integer
        doc: 'Total value inquired on, in cents'
      - id: wap
        type: s4
        doc: 'Weighted average price inquired on'
      - id: impact_cost
        type: s4
        doc: 'Percentage markup over the ideal price of buying or selling the quantity'
      - id: order_price
        type: s4
        doc: 'Price at which an order should be placed for the quantity, value or price'
  market_statistics_report_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Selects the record carried'
      - id: report_body
        type:
          switch-on: message_type
          cases:
            'message_type::header': report_header_body
            'message_type::data': report_statistics_body
            'message_type::trailer': report_trailer_body
  report_header_body:
    seq:
      - id: org_scope
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: report_date
        type: dos_second_timestamp
        doc: 'Date of the report. Seconds since Dos epoch'
      - id: user_type
        type: s2
        enum: user_type
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
        doc: 'Name of the firm, blank'
      - id: trader_number
        type: s4
        doc: 'Trader or user Id'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trader, blank on the request'
  report_statistics_body:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: number_of_records
        type: s2
        doc: 'Number of statistics records, at most six'
      - id: mkt_stats_data
        type: mkt_stats_data
        repeat: expr
        repeat-expr: 6
        doc: 'MKT_STATS_DATA'
  mkt_stats_data:
    seq:
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'Market the contract trades in'
      - id: open_price
        type: s4
        doc: 'Open price'
      - id: high_price
        type: s4
        doc: 'Highest trade price'
      - id: low_price
        type: s4
        doc: 'Lowest trade price'
      - id: closing_price
        type: s4
        doc: 'Closing price'
      - id: total_quantity_traded
        type: s4
        doc: 'Total quantity traded today'
      - id: total_value_traded
        type: floating_point_integer
        doc: 'Total value traded, divided by 10000 for the value in US dollars'
      - id: previous_close_price
        type: s4
        doc: 'Previous day''s closing price'
      - id: open_interest
        type: s4
        doc: 'Open interest'
      - id: chg_open_interest
        type: s4
        doc: 'Change in open interest'
      - id: indicator
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicator'
  report_trailer_body:
    seq:
      - id: number_of_packets
        type: s4
        doc: 'Number of data packets sent in the bhavcopy'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
  spread_bhavcopy_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Selects the record carried'
      - id: spread_report_body
        type:
          switch-on: message_type
          cases:
            'message_type::header': spread_report_header_body
            'message_type::data': spread_report_statistics_body
            'message_type::trailer': report_trailer_body
  spread_report_header_body:
    seq:
      - id: org_scope
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: report_date
        type: dos_second_timestamp
        doc: 'Date of the report. Seconds since Dos epoch'
      - id: user_type
        type: s2
        enum: user_type
        doc: 'Type of the user'
      - id: broker_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id, blank'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trading member'
      - id: trader_number
        type: s4
        doc: 'Trader or user Id'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the trader, blank on the request'
  spread_report_statistics_body:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: no_of_records
        type: s2
        doc: 'Number of statistics records, at most three'
      - id: report_data
        type: report_data
        repeat: expr
        repeat-expr: 3
        doc: 'REPORT_DATA'
  report_data:
    seq:
      - id: mkt
        type: s2
        doc: 'Market type, one for the normal market'
      - id: instrument_name_1
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument name of the first leg'
      - id: symbol_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the first leg'
      - id: expiry_date_1
        type: dos_second_timestamp
        doc: 'Expiry date of the first leg. Seconds since Dos epoch'
      - id: strike_price_1
        type: s4
        doc: 'Strike price of the first leg'
      - id: option_type_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the first leg'
      - id: ca_level_1
        type: s2
        doc: 'Corporate action level of the first leg'
      - id: instrument_name_2
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument name of the second leg'
      - id: symbol_2
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the second leg'
      - id: expiry_date_2
        type: dos_second_timestamp
        doc: 'Expiry date of the second leg. Seconds since Dos epoch'
      - id: strike_price_2
        type: s4
        doc: 'Strike price of the second leg'
      - id: option_type_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type of the second leg'
      - id: ca_level_2
        type: s2
        doc: 'Corporate action level of the second leg'
      - id: open_price_diff
        type: s4
        doc: 'Opening price of the combination'
      - id: high_price_diff
        type: s4
        doc: 'High price of the combination'
      - id: low_price_diff
        type: s4
        doc: 'Low price of the combination'
      - id: last_trade_price_diff
        type: s4
        doc: 'Last traded price of the combination'
      - id: num_of_contracts_trd
        type: s4
        doc: 'Total number of contracts traded'
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
        doc: 'Order number of the order to be modified'
      - id: fill_number
        type: s4
        doc: 'Trade number'
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
        doc: 'Symbol of the underlying'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: strike_price
        type: s4
        doc: 'Strike price of an option, minus one for a future'
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
        type: s4
        doc: 'Price at which the order traded'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: filler
        size: 1
        doc: 'Filler'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type of the counter order'
      - id: last_modified_date_time
        type: dos_second_timestamp
        doc: 'Time of the last activity on the order. Seconds since Dos epoch'
      - id: initiated_by_control
        type: u1
        enum: initiated_by_control
        doc: 'Whether Control initiated the approval'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: reserved_1
        size: 1
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
        doc: 'Give up flag'
      - id: deleted
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the record is deleted'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  gateway_router_response_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id to be used for this connection'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: filler
        size: 1
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
        doc: 'Key encrypting and decrypting every message to the allocated gateway server'
      - id: cryptographic_iv
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Initialization vector for encrypting and decrypting every message to the allocated gateway server'
  box_sign_on_request_out_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id to be used for this connection'
      - id: reserved_10
        size: 10
        doc: 'Reserved'
  box_sign_off_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id to be used for this connection'
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
        size: 200
        doc: 'Reserved'
  branch_order_value_limit_update_response_message:
    seq:
      - id: branch_limit_response_body
        type:
          switch-on: _parent.message_header.message_length
          cases:
            136: branch_order_value_limit_body
            182: error_response_body
  branch_order_value_limit_body:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_25
        size: 25
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
        doc: 'Total buy order limit of the user''s branch'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'Total sell order limit of the user''s branch'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
  reset_user_password_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: reserved_14
        size: 14
        doc: 'Reserved'
  collateral_user_status_change_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: col_user_bit
        type: u1
        enum: col_user_bit
        doc: 'Cancel on logout status to be set'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
  user_trade_modify_cancel_status_change_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: trd_mod_cxl_bit
        type: u1
        enum: trd_mod_cxl_bit
        doc: 'Trade modification or cancellation status to be set'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
  user_address_unlock_confirm_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: reserved_36
        size: 36
        doc: 'Reserved'
  user_address_unlock_approve_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on, or of the user to reset'
      - id: reserved_36
        size: 36
        doc: 'Reserved'
  nlt_order_message_to_trader_message:
    seq:
      - id: message_buffer
        type: str
        size: 276
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text including the price, volume and counter member Id of the counter order'
  nlt_order_inquiry_response_message:
    seq:
      - id: token_no
        type: s4
        doc: 'Token number of the contract the order was placed on'
      - id: counter_order_mkt_type
        type: s2
        enum: counter_order_mkt_type
        doc: 'Market of the counter order'
      - id: price
        type: s4
        doc: 'New price of the order, zero to make it a market order'
      - id: volume
        type: s4
        doc: 'Latest image of the order''s volume'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type of the counter order'
      - id: reserved_8
        size: 8
        doc: 'Padding, the specification lists no field at these offsets'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the order to be modified'
      - id: counter_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id of the counter party'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
  dos_second_timestamp_nullable:
    seq:
      - id: value
        type: dos_second_timestamp
    instances:
      is_null:
        value: value.time == 0
  s2_nullable:
    seq:
      - id: value
        type: s2
    instances:
      is_null:
        value: value == 0
  str_8_nullable:
    seq:
      - id: value
        size: 8
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "00000000"
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 0

enums:
  transaction_code:
    2300:
      id: 'sign_on_request_in_message'
      doc: 'Logs a trader on to the trading system, and the same structure sent by a corporate or branch manager to reset a user''s session'
    5584:
      id: 'sign_on_request_in_message_5584'
      doc: 'Logs a trader on to the trading system, and the same structure sent by a corporate or branch manager to reset a user''s session'
    2301:
      id: 'sign_on_request_out_message'
      doc: 'Confirms that the trader has been signed on, or that a user''s session has been reset'
    5585:
      id: 'sign_on_request_out_message_5585'
      doc: 'Confirms that the trader has been signed on, or that a user''s session has been reset'
    2321:
      id: 'sign_off_request_out_message'
      doc: 'Details of the user''s last log off, sent when the user logs on again'
    2320:
      id: 'sign_off_request_in_message'
      doc: 'Breaks the virtual circuit between the front end and the host, carrying only the message header'
    1600:
      id: 'system_information_in_message'
      doc: 'Requests the system information of the trading system'
    1601:
      id: 'system_information_out_message'
      doc: 'Carries the system information of the trading system, in full or as the partial response to a local database request'
    7321:
      id: 'system_information_out_message_7321'
      doc: 'Carries the system information of the trading system, in full or as the partial response to a local database request'
    7300:
      id: 'update_local_database_in_message'
      doc: 'Requests the local database download of securities, participants and open orders'
    7307:
      id: 'update_local_database_header_message'
      doc: 'Opens the local database download'
    7308:
      id: 'update_local_database_trailer_message'
      doc: 'Closes the local database download'
    7304:
      id: 'update_local_database_data_message'
      doc: 'Carries one local database record wrapped in an inner header'
    7000:
      id: 'download_request_message'
      doc: 'Requests the message download for one stream'
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
      id: 'order_entry_request_message'
      doc: 'Order entry request, and the negotiated large trade order entry, carried in the shared order entry structure'
    2082:
      id: 'order_entry_request_message_2082'
      doc: 'Order entry request, and the negotiated large trade order entry, carried in the shared order entry structure'
    2040:
      id: 'order_modification_request_message'
      doc: 'Order modification request, and the negotiated large trade modification, carried in the shared order entry structure'
    2084:
      id: 'order_modification_request_message_2084'
      doc: 'Order modification request, and the negotiated large trade modification, carried in the shared order entry structure'
    2070:
      id: 'order_cancellation_request_message'
      doc: 'Order cancellation request, and the negotiated large trade cancellation, carried in the shared order entry structure'
    2086:
      id: 'order_cancellation_request_message_2086'
      doc: 'Order cancellation request, and the negotiated large trade cancellation, carried in the shared order entry structure'
    2062:
      id: 'kill_switch_request_message'
      doc: 'Cancels all of a trader''s orders, or with a Trader Id of zero all of the trading member''s, carried in the shared order entry structure'
    2073:
      id: 'order_confirmation_message'
      doc: 'Order entry confirmation, and the negotiated large trade confirmation, carried in the shared order entry structure'
    2083:
      id: 'order_confirmation_message_2083'
      doc: 'Order entry confirmation, and the negotiated large trade confirmation, carried in the shared order entry structure'
    2074:
      id: 'order_modification_confirmation_message'
      doc: 'Order modification confirmation, and the negotiated large trade modification confirmation, carried in the shared order entry structure'
    2085:
      id: 'order_modification_confirmation_message_2085'
      doc: 'Order modification confirmation, and the negotiated large trade modification confirmation, carried in the shared order entry structure'
    2001:
      id: 'order_response_message'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2012:
      id: 'order_response_message_2012'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2041:
      id: 'order_response_message_2041'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2042:
      id: 'order_response_message_2042'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2071:
      id: 'order_response_message_2071'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2072:
      id: 'order_response_message_2072'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2087:
      id: 'order_response_message_2087'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2088:
      id: 'order_response_message_2088'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2089:
      id: 'order_response_message_2089'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2170:
      id: 'order_response_message_2170'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2231:
      id: 'order_response_message_2231'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    9002:
      id: 'order_response_message_9002'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    27100:
      id: 'order_response_message_27100'
      doc: 'Order requested, price confirmation, modification and cancellation responses and rejections, negotiated large trade cancellation confirmation and rejections, freeze, order error and batch cancellation, all carried in the shared order entry structure. Transaction Code in the header names the response'
    2075:
      id: 'order_cancellation_confirmation_message'
      doc: 'Confirms an order cancellation. Message Length selects the ordinary or the two and three leg layout'
    2013:
      id: 'price_modification_message'
      doc: 'Modifies the price of a live regular lot order'
    5440:
      id: 'trade_inquiry_message'
      doc: 'Trade modification and cancellation requests, including the negotiated large trade forms, carried in the shared trade structure'
    5445:
      id: 'trade_inquiry_message_5445'
      doc: 'Trade modification and cancellation requests, including the negotiated large trade forms, carried in the shared trade structure'
    5448:
      id: 'trade_inquiry_message_5448'
      doc: 'Trade modification and cancellation requests, including the negotiated large trade forms, carried in the shared trade structure'
    5451:
      id: 'trade_inquiry_message_5451'
      doc: 'Trade modification and cancellation requests, including the negotiated large trade forms, carried in the shared trade structure'
    2223:
      id: 'trade_inquiry_response_message'
      doc: 'Trade cancellation response, trade error, trade modification rejection and the negotiated large trade rejections and cancellation confirmation, carried in the shared trade structure. Transaction Code in the header names the response'
    2288:
      id: 'trade_inquiry_response_message_2288'
      doc: 'Trade cancellation response, trade error, trade modification rejection and the negotiated large trade rejections and cancellation confirmation, carried in the shared trade structure. Transaction Code in the header names the response'
    5441:
      id: 'trade_inquiry_response_message_5441'
      doc: 'Trade cancellation response, trade error, trade modification rejection and the negotiated large trade rejections and cancellation confirmation, carried in the shared trade structure. Transaction Code in the header names the response'
    5450:
      id: 'trade_inquiry_response_message_5450'
      doc: 'Trade cancellation response, trade error, trade modification rejection and the negotiated large trade rejections and cancellation confirmation, carried in the shared trade structure. Transaction Code in the header names the response'
    5452:
      id: 'trade_inquiry_response_message_5452'
      doc: 'Trade cancellation response, trade error, trade modification rejection and the negotiated large trade rejections and cancellation confirmation, carried in the shared trade structure. Transaction Code in the header names the response'
    5453:
      id: 'trade_inquiry_response_message_5453'
      doc: 'Trade cancellation response, trade error, trade modification rejection and the negotiated large trade rejections and cancellation confirmation, carried in the shared trade structure. Transaction Code in the header names the response'
    2090:
      id: 'trade_confirmation_message'
      doc: 'Trade confirmation, stop loss trigger notification, trade cancellation confirmation and rejection, and trade modification confirmations, including the negotiated large trade forms. Transaction Code in the header names the operation'
    2212:
      id: 'trade_confirmation_message_2212'
      doc: 'Trade confirmation, stop loss trigger notification, trade cancellation confirmation and rejection, and trade modification confirmations, including the negotiated large trade forms. Transaction Code in the header names the operation'
    2222:
      id: 'trade_confirmation_message_2222'
      doc: 'Trade confirmation, stop loss trigger notification, trade cancellation confirmation and rejection, and trade modification confirmations, including the negotiated large trade forms. Transaction Code in the header names the operation'
    2282:
      id: 'trade_confirmation_message_2282'
      doc: 'Trade confirmation, stop loss trigger notification, trade cancellation confirmation and rejection, and trade modification confirmations, including the negotiated large trade forms. Transaction Code in the header names the operation'
    2286:
      id: 'trade_confirmation_message_2286'
      doc: 'Trade confirmation, stop loss trigger notification, trade cancellation confirmation and rejection, and trade modification confirmations, including the negotiated large trade forms. Transaction Code in the header names the operation'
    2287:
      id: 'trade_confirmation_message_2287'
      doc: 'Trade confirmation, stop loss trigger notification, trade cancellation confirmation and rejection, and trade modification confirmations, including the negotiated large trade forms. Transaction Code in the header names the operation'
    5449:
      id: 'trade_confirmation_message_5449'
      doc: 'Trade confirmation, stop loss trigger notification, trade cancellation confirmation and rejection, and trade modification confirmations, including the negotiated large trade forms. Transaction Code in the header names the operation'
    2100:
      id: 'spread_order_entry_request_message'
      doc: 'Spread, two leg and three leg order entry, and spread modification and cancellation, carried in the shared spread structure. Transaction Code in the header names the request'
    2102:
      id: 'spread_order_entry_request_message_2102'
      doc: 'Spread, two leg and three leg order entry, and spread modification and cancellation, carried in the shared spread structure. Transaction Code in the header names the request'
    2104:
      id: 'spread_order_entry_request_message_2104'
      doc: 'Spread, two leg and three leg order entry, and spread modification and cancellation, carried in the shared spread structure. Transaction Code in the header names the request'
    2106:
      id: 'spread_order_entry_request_message_2106'
      doc: 'Spread, two leg and three leg order entry, and spread modification and cancellation, carried in the shared spread structure. Transaction Code in the header names the request'
    2118:
      id: 'spread_order_entry_request_message_2118'
      doc: 'Spread, two leg and three leg order entry, and spread modification and cancellation, carried in the shared spread structure. Transaction Code in the header names the request'
    2101:
      id: 'spread_order_response_message'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2103:
      id: 'spread_order_response_message_2103'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2105:
      id: 'spread_order_response_message_2105'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2107:
      id: 'spread_order_response_message_2107'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2119:
      id: 'spread_order_response_message_2119'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2124:
      id: 'spread_order_response_message_2124'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2125:
      id: 'spread_order_response_message_2125'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2126:
      id: 'spread_order_response_message_2126'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2127:
      id: 'spread_order_response_message_2127'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2130:
      id: 'spread_order_response_message_2130'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2131:
      id: 'spread_order_response_message_2131'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2132:
      id: 'spread_order_response_message_2132'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2133:
      id: 'spread_order_response_message_2133'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2136:
      id: 'spread_order_response_message_2136'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2154:
      id: 'spread_order_response_message_2154'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2155:
      id: 'spread_order_response_message_2155'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    2156:
      id: 'spread_order_response_message_2156'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    9004:
      id: 'spread_order_response_message_9004'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    27102:
      id: 'spread_order_response_message_27102'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    27103:
      id: 'spread_order_response_message_27103'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
    27104:
      id: 'spread_order_response_message_27104'
      doc: 'Spread, two leg and three leg order responses, confirmations, rejections, errors and batch cancellation, carried in the shared spread structure. Transaction Code in the header names the response'
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
      doc: 'Interactive message sent to the trader from Nse Ix Control'
    1684:
      id: 'mba_inquiry_request_message'
      doc: 'Requests the market by aggregate details for a user defined quantity, total value or weighted average price'
    1686:
      id: 'mba_inquiry_request_message_1686'
      doc: 'Requests the market by aggregate details for a user defined quantity, total value or weighted average price'
    1688:
      id: 'mba_inquiry_request_message_1688'
      doc: 'Requests the market by aggregate details for a user defined quantity, total value or weighted average price'
    1685:
      id: 'mba_inquiry_response_message'
      doc: 'Market by aggregate details for a user defined quantity, total value or weighted average price'
    1687:
      id: 'mba_inquiry_response_message_1687'
      doc: 'Market by aggregate details for a user defined quantity, total value or weighted average price'
    1689:
      id: 'mba_inquiry_response_message_1689'
      doc: 'Market by aggregate details for a user defined quantity, total value or weighted average price'
    1833:
      id: 'market_statistics_report_message'
      doc: 'Bhavcopy header, market statistics records or trailer. Message Type selects which'
    6502:
      id: 'spread_bhavcopy_message'
      doc: 'Spread bhavcopy header, spread statistics records or trailer. Message Type selects which'
    4506:
      id: 'giveup_confirmation_message'
      doc: 'Confirms the approval or rejection of a give up to the trading member who placed the participant order. Transaction Code in the header names which'
    4507:
      id: 'giveup_confirmation_message_4507'
      doc: 'Confirms the approval or rejection of a give up to the trading member who placed the participant order. Transaction Code in the header names which'
    2400:
      id: 'gateway_router_request_message'
      doc: 'Asks the gateway router which gateway server to connect to'
    2401:
      id: 'gateway_router_response_message'
      doc: 'Returns the allocated gateway server and the keys used to encrypt the session'
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
      doc: 'Signs the box off the gateway server when the exchange terminates the connection'
    5294:
      id: 'contingency_broadcast_message'
      doc: 'Signals the start or end of an outage on one or all matching engine streams'
    5716:
      id: 'branch_order_value_limit_update_request_message'
      doc: 'Sets the buy and sell value limits for a branch'
    5717:
      id: 'branch_order_value_limit_update_response_message'
      doc: 'Confirms the branch order value limit update'
    5730:
      id: 'user_order_value_limit_update_message'
      doc: 'Sets the buy and sell order value limits for a user'
    5732:
      id: 'normal_order_limit_update_message'
      doc: 'Sets the order quantity and value limits for a user, or with 5771 the spread order limits'
    5771:
      id: 'normal_order_limit_update_message_5771'
      doc: 'Sets the order quantity and value limits for a user, or with 5771 the spread order limits'
    5740:
      id: 'reset_user_password_message'
      doc: 'Requests a reset of a user''s password to the default'
    5741:
      id: 'reset_user_password_response_message'
      doc: 'Answers the password reset request, Error Code in the header saying whether it succeeded'
    5744:
      id: 'collateral_user_status_change_request_message'
      doc: 'Enables or disables cancel on logout for a user'
    5745:
      id: 'collateral_user_status_change_response_message'
      doc: 'Answers the cancel on logout status change'
    5738:
      id: 'user_trade_modify_cancel_status_change_request_message'
      doc: 'Enables or disables trade modification or, with Alpha Char TX, trade cancellation for a user'
    5739:
      id: 'user_trade_modify_cancel_status_change_response_message'
      doc: 'Answers the trade modification or cancellation status change'
    5427:
      id: 'user_address_unlock_request_message'
      doc: 'Requests that a locked user be unlocked'
    5428:
      id: 'user_address_unlock_confirm_message'
      doc: 'Acknowledges that the unlock request reached the trading system'
    5483:
      id: 'user_address_unlock_approve_message'
      doc: 'Approves or rejects the unlock of a user. Transaction Code in the header names which'
    5484:
      id: 'user_address_unlock_approve_message_5484'
      doc: 'Approves or rejects the unlock of a user. Transaction Code in the header names which'
    2093:
      id: 'nlt_order_message_to_trader_message'
      doc: 'Tells the counter member''s corporate manager of a negotiated large trade order placed against it'
    1242:
      id: 'nlt_order_inquiry_request_message'
      doc: 'One time inquiry by a corporate manager for the negotiated large trade counter orders placed against the member'
    1243:
      id: 'nlt_order_inquiry_response_message'
      doc: 'One negotiated large trade counter order, in answer to the inquiry'
    7032:
      id: 'nlt_trailer_record_message'
      doc: 'Ends the negotiated large trade inquiry responses, carrying only the message header'
  error_code:
    293:
      id: 'invalid_instrument_type'
      doc: 'Invalid instrument type.'
    509:
      id: 'order_number_invalid'
      doc: 'Order does not exist.'
    8049:
      id: 'ord_cxl_initiator_auc_not_allowed'
      doc: 'Initiator is not allowed to cancel auction order.'
    8485:
      id: 'auction_number_invalid'
      doc: 'Auction number does not exist'
    16000:
      id: 'market_closed'
      doc: 'The trading system is not available for trading.'
    16001:
      id: 'e_invalid_user'
      doc: 'Header user ID is not equal to user ID in the order packet.'
    16003:
      id: 'error_bad_trans_code'
      doc: 'Invalid Transcode'
    16004:
      id: 'e_user_already_signed_on'
      doc: 'The user is already signed on.'
    16005:
      id: 'e_invalid_signoff'
      doc: 'System error while trying to sign-off. Please call the Exchange.'
    16006:
      id: 'e_invalid_signon'
      doc: 'Invalid sign-on. Please try again.'
    16007:
      id: 'e_signon_not_possible'
      doc: 'Signing onto the trading system is restricted. Please try later on.'
    16011:
      id: 'e_duplicate_report_request'
      doc: 'This report has already been requested.'
    16012:
      id: 'err_invalid_symbol'
      doc: 'Invalid contract descriptor'
    16014:
      id: 'e_not_your_order'
      doc: 'This order is not yours.'
    16015:
      id: 'e_not_your_fill'
      doc: 'This trade is not yours.'
    16016:
      id: 'e_invalid_fill_number'
      doc: 'Invalid trade number.'
    16019:
      id: 'e_stock_not_found'
      doc: 'Stock not found.'
    16035:
      id: 'security_not_available'
      doc: 'Security is unavailable for trading at this time. Please try later.'
    16041:
      id: 'broker_not_found'
      doc: 'Trading member does not exist in the system.'
    16042:
      id: 'user_not_found'
      doc: 'Dealer does not exist in the system.'
    16043:
      id: 'duplicate_record'
      doc: 'This record already exists on the NEAT system.'
    16044:
      id: 'e_order_modified'
      doc: 'Order has been modified. Please try again.'
    16049:
      id: 'stock_suspended'
      doc: 'Stock is suspended.'
    16052:
      id: 'err_function_not_available'
      doc: 'Function Not Available'
    16053:
      id: 'e_change_password'
      doc: 'Your password has expired, must be changed.'
    16054:
      id: 'err_invalid_branch'
      doc: 'Invalid branch for trading member.'
    16056:
      id: 'oe_program_error'
      doc: 'Program error.'
    16086:
      id: 'e_dup_trd_cxl_request'
      doc: 'Duplicate trade cancel request.'
    16098:
      id: 'err_invalid_buyer_user_id'
      doc: 'Invalid trader ID for buyer.'
    16099:
      id: 'err_invalid_seller_user_id'
      doc: 'Invalid trader ID for buyer.'
    16100:
      id: 'e_invalid_version'
      doc: 'Your system version has not been updated.'
    16104:
      id: 'oe_system_error'
      doc: 'System could not complete your transaction - Admin notified.'
    16134:
      id: 'err_user_disabled'
      doc: 'This Dealer is disabled. Please call the Exchange'
    16148:
      id: 'err_invalid_user_id'
      doc: 'Invalid Dealer ID entered.'
    16154:
      id: 'err_invalid_trader_id'
      doc: 'Invalid Trader ID entered.'
    16169:
      id: 'oe_ato_in_open'
      doc: 'Order priced ATO cannot be entered when a security is open.'
    16196:
      id: 'ord_not_allowed_in_preopen'
      doc: 'Order Entry or Modification or Cancellation not allowed in preopen.'
    16197:
      id: 'ord_not_allowed_in_preclose'
      doc: 'Order Entry or Modification or Cancellation not allowed in preclose.'
    16198:
      id: 'e_dup_request'
      doc: 'Duplicate modification or cancellation request for the same trade has been encountered.'
    16227:
      id: 'e_only_cp_allowed'
      doc: 'Only market orders are allowed in postclose.'
    16228:
      id: 'e_sl_mit_nt_not_allowed_pclose'
      doc: 'SL, MIT or NT orders are not allowed during Post Close.'
    16229:
      id: 'e_gtc_gtd_ord_not_allowed_pclose'
      doc: 'GTC GTD or Days orders are Not Allowed during Post Close.'
    16230:
      id: 'oe_cont_mod_not_allowed'
      doc: 'Continuous session orders cannot be modified.'
    16231:
      id: 'trd_cont_mod_not_allowed'
      doc: 'Continuous session trades cannot be changed.'
    16233:
      id: 'str_pro_partivipant_invalid'
      doc: 'Proprietary requests cannot be made for participant.'
    16247:
      id: 'error_invalid_price'
      doc: 'Invalid price received'
    16251:
      id: 'oe_diff_trd_mod_vol'
      doc: 'Trade modification with different quantities is received.'
    16273:
      id: 'record_not_found'
      doc: 'Record does not exist.'
    16278:
      id: 'oe_markets_closed'
      doc: 'The markets have not been opened for trading.'
    16279:
      id: 'oe_security_not_admitted'
      doc: 'The contract has not yet been admitted for trading.'
    16280:
      id: 'oe_security_matured'
      doc: 'The Contract has matured.'
    16281:
      id: 'oe_security_expelled'
      doc: 'The security has been expelled.'
    16282:
      id: 'oe_issued_cap_exceeds'
      doc: 'The order quantity is greater than the issued capital.'
    16283:
      id: 'oe_price_not_mult'
      doc: 'The order price is not multiple of the tick size.'
    16284:
      id: 'oe_price_exceeds_day_min_max'
      doc: 'The order price is out of the day''s price range.'
    16285:
      id: 'oe_is_not_active'
      doc: 'The broker is not active.'
    16300:
      id: 'e_system_wrong_state'
      doc: 'System is in a wrong state to make the requested change.'
    16303:
      id: 'oe_auction_pending'
      doc: 'The auction is pending.'
    16307:
      id: 'oe_qty_freeze_can'
      doc: 'The order has been canceled due to quantity freeze.'
    16308:
      id: 'oe_price_freeze_can'
      doc: 'The order has been canceled due to price freeze.'
    16311:
      id: 'oe_sol_period_over'
      doc: 'The Solicitor period for the Auction is over.'
    16312:
      id: 'oe_comp_period_over'
      doc: 'The Competitor period for the Auction is over.'
    16313:
      id: 'oe_auc_period_greater'
      doc: 'The Auction period will cross market close time.'
    16315:
      id: 'oe_limit_trigger'
      doc: 'The limit price is worse than the trigger price.'
    16316:
      id: 'oe_trigger_price_not_mult'
      doc: 'The trigger price is not a multiple of tick size.'
    16317:
      id: 'oe_no_aon_attrib'
      doc: 'AON attribute not allowed.'
    16318:
      id: 'oe_no_mf_attrib'
      doc: 'MF attribute not allowed.'
    16319:
      id: 'oe_no_aon_in_attrib_1'
      doc: 'AON attribute not allowed at Security level.'
    16320:
      id: 'oe_no_mf_attrib_1'
      doc: 'MF attribute not allowed at security level.'
    16321:
      id: 'oe_mf_greater_disc'
      doc: 'MF quantity is greater than disclosed quantity'
    16322:
      id: 'oe_mf_not_mult'
      doc: 'MF quantity is not a multiple of regular lot.'
    16323:
      id: 'oe_mf_greater_original'
      doc: 'MF quantity is greater than Original quantity.'
    16324:
      id: 'oe_disc_greater_original'
      doc: 'Disclosed quantity is greater than Original quantity.'
    16325:
      id: 'oe_disc_not_mult'
      doc: 'Disclosed quantity is not a multiple of regular lot.'
    16326:
      id: 'oe_gtd_greater'
      doc: 'GTD is greater than that specified at the trading system.'
    16327:
      id: 'oe_quantity_gerater_rl'
      doc: 'Odd lot quantity cannot be greater than or equal to regular lot size.'
    16328:
      id: 'oe_quantity_not_mult_rl'
      doc: 'Quantity is not a multiple of regular lot.'
    16329:
      id: 'oe_broker_not_permitted'
      doc: 'Trading Member not permitted in the market.'
    16330:
      id: 'oe_is_suspended'
      doc: 'Security is suspended.'
    16333:
      id: 'oe_branch_limit_exceeded'
      doc: 'Branch Order Value Limit has been exceeded.'
    16343:
      id: 'oe_ord_can_changed'
      doc: 'The order to be cancelled has changed.'
    16344:
      id: 'oe_ord_cannot_cancel'
      doc: 'The order cannot be cancelled.'
    16345:
      id: 'oe_init_ord_cancel'
      doc: 'Initiator order cannot be cancelled.'
    16346:
      id: 'oe_ord_cannot_modify'
      doc: 'Order cannot be modified.'
    16348:
      id: 'err_trading_not_allowed'
      doc: 'Trading is not allowed in this market.'
    16357:
      id: 'oe_nt_rejected'
      doc: 'Control has rejected the Negotiated Trade.'
    16363:
      id: 'chg_st_exists'
      doc: 'Status is in the required state.'
    16369:
      id: 'oe_security_in_preopen'
      doc: 'Contract is in preopen.'
    16372:
      id: 'oe_inq_not_allowed'
      doc: 'Order entry not allowed for user as it is of inquiry type.'
    16387:
      id: 'oe_security_ineligible'
      doc: 'Contract not allowed to trader in.'
    16388:
      id: 'err_fok_order_cancelled'
      doc: 'When IOC orders are cancelled if not matched or Preopen/ preclose unmatched orders are cancelled by the system after preopen session ends.'
    16392:
      id: 'turnover_limit_not_provided'
      doc: 'Turnover limit not provided. Please contact Exchange.'
    16400:
      id: 'oe_max_dq_allowed'
      doc: 'DQ is less than minimum quantity allowed.'
    16404:
      id: 'oe_admin_susp_can'
      doc: 'Order has been cancelled due to freeze admin suspension.'
    16405:
      id: 'e_invalid_buy_sell_type'
      doc: 'BUY - SELL type entered is invalid.'
    16414:
      id: 'e_invalid_pro_client'
      doc: 'Pro Cli field is invalid (something other than Pro - 2 or Cli - 1)'
    16415:
      id: 'e_invalid_instructions'
      doc: 'Invalid combination of book type and instructions (order_type).'
    16416:
      id: 'e_invalid_order_parameters'
      doc: 'Invalid combination of mf/aon/disclosed volume.'
    16418:
      id: 'e_nnf_req_exceeded'
      doc: 'Number of NNF requests exceeded.'
    16419:
      id: 'invalid_order'
      doc: 'This error code will be returned for invalid data in the order packet.'
    16438:
      id: 'ord_attribute_not_allowed_in_preopen_preclose'
      doc: 'Orders attribute are not allowed in preopen/preclose.'
    16440:
      id: 'e_gtd_gt_maturity'
      doc: 'GTD is greater than Maturity date.'
    16441:
      id: 'e_dq_ord_not_allowed_popen'
      doc: 'DQ orders are not allowed in preopen.'
    16442:
      id: 'e_st_ord_not_allowed_popen'
      doc: 'ST orders are not allowed in preopen.'
    16443:
      id: 'e_ord_lim_exceeds_ord_val_lim'
      doc: 'Order value exceeds the order limit value.'
    16445:
      id: 'sl_not_allowed'
      doc: 'Stop Loss orders are not allowed.'
    16446:
      id: 'mit_not_allowed'
      doc: 'Market If Touched orders are not allowed.'
    16447:
      id: 'e_ord_not_allowed_in_preopen'
      doc: 'Order entry not allowed in Pre-open.'
    16448:
      id: 'error_sl_lmt_rsnblty_check'
      doc: 'Difference between limit price and trigger price is beyond permissible range'
    16500:
      id: 'e_not_allowed'
      doc: 'Ex/Pl not allowed.'
    16501:
      id: 'e_invalid_ex_pl_char'
      doc: 'Invalid ExPl flag value.'
    16513:
      id: 'e_rejection_not_allowed'
      doc: 'Ex/Pl rejection not allowed.'
    16514:
      id: 'e_not_modifiable'
      doc: 'Not modifiable.'
    16518:
      id: 'e_tm_cm_does_not_exist'
      doc: 'Clearing member, Trading Member link not found.'
    16521:
      id: 'e_not_clg_mem'
      doc: 'Not a clearing member.'
    16523:
      id: 'e_user_not_corp_mgr'
      doc: 'User in not a corporate manager.'
    16529:
      id: 'e_not_valid_fo_contract'
      doc: 'Not a valid derivative contract.'
    16532:
      id: 'e_pm_cm_invalid'
      doc: 'Clearing member Participant link not found.'
    16533:
      id: 'e_corp_mgr_vu_mod'
      doc: 'Enter either TM or Participant.'
    16541:
      id: 'e_invalid_participant'
      doc: 'Participant is invalid.'
    16550:
      id: 'e_trade_approved_by_cm'
      doc: 'Trade cannot be modified /cancelled. It has already been approved by CM.'
    16552:
      id: 'e_cm_stock_suspended'
      doc: 'Stock has been suspended.'
    16554:
      id: 'e_broker_not_permitted_in_fut'
      doc: 'Trading Member not permitted in Futures.'
    16555:
      id: 'e_broker_not_permitted_in_opt'
      doc: 'Trading Member not permitted in Options.'
    16556:
      id: 'e_qty_less_than_min_lot'
      doc: 'Quantity less than the minimum lot size.'
    16557:
      id: 'e_disc_qty_less_than_min_lot'
      doc: 'Disclose quantity less than the minimum lot size.'
    16558:
      id: 'e_mf_qty_less_than_min_lot'
      doc: 'Minimum fill is less than the minimum lot size.'
    16560:
      id: 'e_already_rejected'
      doc: 'The give up trade has already been rejected.'
    16561:
      id: 'e_nt_orders_not_allowed'
      doc: 'Negotiated Orders not allowed.'
    16562:
      id: 'e_nt_trade_not_allowed'
      doc: 'Negotiated Trade not allowed.'
    16566:
      id: 'e_inconsistent_broker_branch'
      doc: 'User does not belong to Broker or Branch.'
    16570:
      id: 'm_post_close_start'
      doc: 'The market is in post-close.'
    16571:
      id: 'm_post_close_ended'
      doc: 'The Closing Session has ended.'
    16572:
      id: 'm_post_close_trades'
      doc: 'Closing Session trades have been generated.'
    16573:
      id: 'e_invalid_msg_length'
      doc: 'Message length is invalid.'
    16574:
      id: 'e_invalid_open_close_type'
      doc: 'Open - Close type entered is invalid.'
    16576:
      id: 'e_nnf_inq_req_exceeded'
      doc: 'No. of nnf inquiry requests exceeded.'
    16577:
      id: 'e_participant_and_volume_changed'
      doc: 'Both participant and volume changed.'
    16578:
      id: 'e_invalid_cover_uncover_type'
      doc: 'Cover - Uncover type entered is invalid.'
    16579:
      id: 'e_illegal_cm_id'
      doc: 'Giveup requested for wrong CM ID.'
    16580:
      id: 'e_illegal_participant'
      doc: 'Order does not belong to the given participant.'
    16581:
      id: 'e_invalid_fill_price'
      doc: 'Invalid trade price.'
    16583:
      id: 'e_pro_no_participant'
      doc: 'For Pro order participant entry not allowed.'
    16585:
      id: 'e_invalid_account_no'
      doc: 'Not a valid account number.'
    16586:
      id: 'e_allow_no_participant_order'
      doc: 'Participant Order Entry Not Allowed.'
    16589:
      id: 'm_delete_all_orders'
      doc: 'All continuous session orders are being deleted now.'
    16594:
      id: 'trade_qty_not_mod_after_giveup'
      doc: 'After giveup approve/reject, trade quantity cannot be modified.'
    16596:
      id: 'e_tmid_cant_exercise_for_ptcpnt'
      doc: 'Trading member cannot put Ex/Pl request for Participant.'
    16597:
      id: 'e_cum_ur_ord_val_limit_exceeded'
      doc: 'Branch limit should be greater than sum of user limits.'
    16598:
      id: 'e_branch_ord_val_limit_exceeded'
      doc: 'Branch limit should be greater than used limit.'
    16601:
      id: 'order_rejected_with_system_error'
      doc: 'Order has been rejected due to system error at exchange'
    16602:
      id: 'e_dealer_value_limit_exceeds'
      doc: 'Dealer value limit exceeds the set limit.'
    16604:
      id: 'e_participant_not_found'
      doc: 'Participant not found.'
    16605:
      id: 'e_either_leg_failed'
      doc: 'One leg of spread/2L failed.'
    16606:
      id: 'e_qty_greater_than_freeze_qty'
      doc: 'Quantity greater than Freeze quantity.'
    16607:
      id: 'e_spread_not_allowed'
      doc: 'Spread not allowed.'
    16608:
      id: 'e_spread_allowed_only_in_open'
      doc: 'Spread allowed only when market is open.'
    16609:
      id: 'e_spread_allowed_if_stock_open'
      doc: 'Spread allowed only when stock is open.'
    16610:
      id: 'e_qty_should_be_same'
      doc: 'Both legs should have same quantity.'
    16611:
      id: 'e_ord_mod_qty_frz_not_allowed'
      doc: 'Modified order qty freeze not allowed.'
    16612:
      id: 'e_trade_rec_modified'
      doc: 'The trade record has been modified.'
    16615:
      id: 'e_tm_order_cant_be_modified'
      doc: 'Order cannot be modified.'
    16616:
      id: 'e_tm_order_cant_be_cancelled'
      doc: 'Order cannot be cancelled.'
    16617:
      id: 'e_tm_trade_cant_be_manipulated'
      doc: 'Trade cannot be manipulated.'
    16619:
      id: 'e_pcm_cant_ex_pl_for_himself'
      doc: 'PCM cannot ex_pl for himself.'
    16620:
      id: 'e_clearing_member_cant_expl'
      doc: 'Ex/Pl by clearing member for TM not allowed.'
    16621:
      id: 'e_cant_manipulate_expl_of_tm'
      doc: 'Clearing member cannot change the Ex/Pl requests placed by Trading Member.'
    16625:
      id: 'e_cm_of_tm_suspended'
      doc: 'Clearing member is suspended.'
    16626:
      id: 'e_expdate_not_in_ascending_ord'
      doc: 'Expiry date not in ascending order.'
    16627:
      id: 'e_invalid_contract_comb'
      doc: 'Invalid contract combination.'
    16628:
      id: 'e_bm_cannot_cancel_cm_orders'
      doc: 'Branch manager cannot cancel corporate manager''s order.'
    16629:
      id: 'e_bm_cannot_cancel_bm_orders'
      doc: 'Branch manager cannot cancel other branch manager''s order.'
    16630:
      id: 'e_cm_cannot_cancel_cm_orders'
      doc: 'Corporate manager cannot cancel other corporate manager''s order.'
    16631:
      id: 'e_spread_in_different_underlying'
      doc: 'Spread not allowed for different underlying.'
    16632:
      id: 'e_invalid_cli_ac'
      doc: 'Cli A/c number cannot be modified as trading member ID.'
    16636:
      id: 'e_br_ord_limit_fut_buy_exceeded'
      doc: 'Futures buy branch Order Value Limit has been exceeded.'
    16637:
      id: 'e_br_ord_limit_fut_sell_exceeded'
      doc: 'Futures sell branch Order Value Limit has been exceeded.'
    16638:
      id: 'e_br_ord_limit_opt_buy_exceeded'
      doc: 'Options buy branch Order Value Limit has been exceeded.'
    16639:
      id: 'e_br_ord_limit_opt_sell_exceeded'
      doc: 'Options sell branch Order Value Limit has been exceeded.'
    16640:
      id: 'e_ur_ord_limit_fut_buy_exceeded'
      doc: 'Futures buy used limit exceeded the user limit.'
    16641:
      id: 'e_ur_ord_limit_fut_sell_exceeded'
      doc: 'Futures sell used limit exceeded the user limit.'
    16642:
      id: 'e_ur_ord_limit_opt_buy_exceeded'
      doc: 'Options buy used limit exceeded the user limit.'
    16643:
      id: 'e_ur_ord_limit_opt_sell_exceeded'
      doc: 'Options sell used limit exceeded the user limit.'
    16645:
      id: 'e_cant_appr_bhav_copy_generated'
      doc: 'Cannot approve. Bhav Copy generated.'
    16646:
      id: 'e_collateral_lmt_chk'
      doc: 'Cannot modify.'
    16656:
      id: 'e_address_not_found'
      doc: 'No address in the database.'
    16662:
      id: 'e_stk_in_popen'
      doc: 'Contract is opening. Please wait for the contract to open.'
    16666:
      id: 'e_invalid_nnf_field'
      doc: 'Invalid NNF field.'
    16667:
      id: 'e_gtcgtd_not_allowed'
      doc: 'GTC GTD Orders not allowed.'
    16686:
      id: 'closeout_order_reject'
      doc: 'This error code will be returned if Close out order rejected by the system.'
    16687:
      id: 'closeout_frz_reject'
      doc: 'This error code will be returned if the close out order entered is going into freeze. (Since Freeze is not allowed for close out orders)'
    16688:
      id: 'closeout_not_allowed'
      doc: 'This error code will be returned if the close out order is not allowed in the system.'
    16690:
      id: 'closeout_trdmod_reject'
      doc: 'This error code will be returned when a Trade MOD request is placed by a broker in Close-out.'
    16706:
      id: 'partial_order_reject'
      doc: 'Cancelled by the System'
    16708:
      id: 'partial_quick_order_cxl_rej'
      doc: 'System Error. Orders not completely cancelled by the system. Please request Quick CXL again'
    16713:
      id: 'e_price_diff_out_of_range'
      doc: 'Spread order price difference is out of range.'
    16732:
      id: 'error_algo_mkt_not_allowed'
      doc: 'Market order not allowed for Algo order.'
    16733:
      id: 'error_invalid_nnfid_rejection'
      doc: 'Invalid NNF Id'
    16793:
      id: 'e_vc_order_rejected'
      doc: 'Order Entered has invalid data.'
    16794:
      id: 'e_ssd_order_rejected'
      doc: 'Order Entered has invalid data.'
    16795:
      id: 'e_order_cancelled_for_vc'
      doc: 'Order cancelled due to voluntary close out.'
    16796:
      id: 'e_order_cancelled_for_ssd'
      doc: 'Order cancelled due to OI violation.'
    16807:
      id: 'e_account_debarred'
      doc: 'The account is debarred from trading.'
    17036:
      id: 'e_mba_inq_not_allowed'
      doc: 'MBA inquiry is not allowed for this contract'
    17037:
      id: 'e_mba_insuff_record'
      doc: 'insufficient record for MBA inquiry'
    17038:
      id: 'e_outstanding_order_present'
      doc: 'Order is outstanding.'
    17039:
      id: 'e_pro_cli_mod_not_allowed'
      doc: 'Pro Cli Modification not allowed for the Order.'
    17045:
      id: 'e_ord_qty_exceeds_qty_val_lim'
      doc: 'Order Quantity Exceeds Quantity Value Limit for User.'
    17046:
      id: 'e_user_type_trd_mod_disabled'
      doc: 'Trade Modification Not Allowed for User Type.'
    17047:
      id: 'e_tm_trade_mod_not_allowed'
      doc: 'Trade Modification not Allowed for Broker.'
    17048:
      id: 'e_user_trd_mod_disabled'
      doc: 'Trade Modification Not Allowed for User.'
    17070:
      id: 'e_trd_price_out_of_stock_tpp'
      doc: 'The Price is out of the current execution range'
    17071:
      id: 'e_order_cancelled_for_self_trade'
      doc: 'The order could have resulted in self trade'
    17101:
      id: 'e_invalid_packet'
      doc: 'The packet has invalid data'
    17102:
      id: 'e_hearbeat_not_received'
      doc: 'Heart Beat not received'
    17103:
      id: 'e_single_user_login_allowed'
      doc: 'One user login allowed per box for direct connection'
    17104:
      id: 'e_invalid_box_id'
      doc: 'Invalid box id'
    17105:
      id: 'e_seq_no_mismatch'
      doc: 'Sequence number mismatch'
    17106:
      id: 'e_box_rate_exceeded'
      doc: 'Box Rate has been exceeded by the Member'
    16403:
      id: 'e_invalid_box_ip_combination'
      doc: 'Login from invalid IP'
    17179:
      id: 'err_invalid_algo_id'
      doc: 'Invalid Algo Id'
    17184:
      id: 'err_user_having_null_rights'
      doc: 'Order Rejected as user has no trading rights'
    19028:
      id: 'err_checksum_failed_gr'
      doc: 'Checksum verification failed at Gateway Router'
    19029:
      id: 'err_multiple_gr_query_rcv'
      doc: 'Multiple GR_QUERY request received'
    19030:
      id: 'err_encryption_flag_mismatch'
      doc: 'Encryption Flag Mismatch'
    19031:
      id: 'err_md_5_checksum_failure'
      doc: 'MD5 Checksum Failed'
  user_type:
    0:
      id: 'dealer'
      doc: 'Dealer'
    4:
      id: 'corporate_manager'
      doc: 'Corporate Manager'
    5:
      id: 'branch_manager'
      doc: 'Branch Manager'
  broker_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x41:
      id: 'active'
      doc: 'Active'
    0x44:
      id: 'deactivated'
      doc: 'Deactivated'
    0x43:
      id: 'closeout'
      doc: 'Closeout'
    0x56:
      id: 'voluntary_close_out'
      doc: 'Voluntary Close Out'
  member_type:
    1:
      id: 'trading_member_only'
      doc: 'Trading Member Only'
    2:
      id: 'trading_and_clearing_member'
      doc: 'Trading And Clearing Member'
    3:
      id: 'clearing_member_only'
      doc: 'Clearing Member Only'
    4:
      id: 'professional_clearing_member_and_trading_member'
      doc: 'Professional Clearing Member And Trading Member'
  clearing_status:
    0x41:
      id: 'active'
      doc: 'Active'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x44:
      id: 'deactivated'
      doc: 'Deactivated'
    0x56:
      id: 'voluntary_close_out'
      doc: 'Voluntary Close Out'
  request_for_open_orders:
    0x47:
      id: 'download_gtc_and_gtd_orders'
      doc: 'Download Gtc And Gtd Orders'
    0x4e:
      id: 'no_open_orders'
      doc: 'No Open Orders'
  normal:
    0:
      id: 'preopen'
      doc: 'Preopen'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_end'
      doc: 'Preopen End'
    4:
      id: 'pre_close'
      doc: 'Pre Close'
    5:
      id: 'pre_close_end'
      doc: 'Pre Close End'
  oddlot:
    0:
      id: 'preopen'
      doc: 'Preopen'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_end'
      doc: 'Preopen End'
    4:
      id: 'pre_close'
      doc: 'Pre Close'
    5:
      id: 'pre_close_end'
      doc: 'Pre Close End'
  spot:
    0:
      id: 'preopen'
      doc: 'Preopen'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_end'
      doc: 'Preopen End'
    4:
      id: 'pre_close'
      doc: 'Pre Close'
    5:
      id: 'pre_close_end'
      doc: 'Pre Close End'
  auction:
    0:
      id: 'preopen'
      doc: 'Preopen'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_end'
      doc: 'Preopen End'
    4:
      id: 'pre_close'
      doc: 'Pre Close'
    5:
      id: 'pre_close_end'
      doc: 'Pre Close End'
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
      doc: 'Unmatched pre open order cancelled by the exchange'
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
    15:
      id: 'auction_number'
      doc: 'Auction Number'
    17:
      id: 'price_freeze'
      doc: 'Price Freeze'
    18:
      id: 'quantity_freeze'
      doc: 'Quantity Freeze'
    29:
      id: 'invalid_expl'
      doc: 'Invalid Expl'
    30:
      id: 'exercise_mode_mismatch'
      doc: 'Exercise Mode Mismatch'
    31:
      id: 'ex_pl_number'
      doc: 'Ex Pl Number'
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
  buy_sell_indicator:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  pro_client_indicator:
    1:
      id: 'client_order'
      doc: 'Client Order'
    2:
      id: 'broker_order'
      doc: 'Broker Order'
  stpc:
    0:
      id: 'cancel_order_resulting_in_self_trade_as_per_default'
      doc: 'Cancel order resulting in self trade as per default action by the exchange'
    1:
      id: 'cancel_active_order_resulting_in_self_trade'
      doc: 'Cancel Active Order Resulting In Self Trade'
  session_ind:
    0:
      id: 'session_1'
      doc: 'Trade done in session 1'
    1:
      id: 'session_2'
      doc: 'Trade done in session 2'
  buy_sell:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  mkt_type:
    0x31: 'normal_market'
    0x32: 'odd_lot_market'
    0x33: 'spot_market'
    0x34: 'auction_market'
  buy_open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  requested_by:
    0x31:
      id: 'buy'
      doc: 'The buy side is requesting'
    0x32:
      id: 'sell'
      doc: 'The sell side is requesting'
    0x33:
      id: 'both'
      doc: 'A branch or corporate manager of either side, or both parties, are requesting'
  sell_open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  book_type_1:
    1:
      id: 'regular_lot_order'
      doc: 'Regular Lot Order'
    2:
      id: 'special_terms_order'
      doc: 'Special Terms Order'
  col_user_bit:
    0x30:
      id: 'disable_col_status'
      doc: 'Disable Col Status'
    0x31:
      id: 'enable_col_status'
      doc: 'Enable Col Status'
  trd_mod_cxl_bit:
    0x59:
      id: 'enable'
      doc: 'Enable'
    0x4e:
      id: 'disable'
      doc: 'Disable'
  old_open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  give_up_trade:
    0x50:
      id: 'p'
      doc: 'P'
    0x41:
      id: 'a'
      doc: 'Give up approved: the host sends A when a give up is approved (p178)'
    0x52:
      id: 'r'
      doc: 'R'
  message_type:
    0x48:
      id: 'header'
      doc: 'Header'
    0x52:
      id: 'data'
      doc: 'Data'
    0x54:
      id: 'trailer'
      doc: 'Trailer'
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
  initiated_by_control:
    0x59:
      id: 'initiated_by_control'
      doc: 'Initiated By Control'
    0x4e:
      id: 'not_initiated_by_control'
      doc: 'Not Initiated By Control'
  status:
    1:
      id: 'start_of_outage'
      doc: 'Start Of Outage'
    0:
      id: 'end_of_outage'
      doc: 'End Of Outage'
  counter_order_mkt_type:
    1:
      id: 'normal_market'
      doc: 'Normal Market'
    2:
      id: 'odd_lot_market'
      doc: 'Odd Lot Market'
    3:
      id: 'spot_market'
      doc: 'Spot Market'
    4:
      id: 'auction_market'
      doc: 'Auction Market'

