# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseFo OrderEntry NnfDirect v9.50
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End Direct Interface
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
  id: nse_nsefo_orderentry_nnfdirect_v9_50_client
  title: Nse NseFo OrderEntry NnfDirect v9.50
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Futures & Options Order Entry NnfDirect v9.50'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: client_direct_packet
    type: client_direct_packet_struct
    repeat: eos
    doc: 'One framed interactive message sent by the firm'

types:
  client_direct_packet_struct:
    seq:
      - id: packet_header
        type: packet_header
        doc: 'Direct interface twenty two byte packet header'
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: client_message_payload
        size: packet_header.packet_length - 62
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::sign_on_request_in_message': sign_on_request_in_message
            'transaction_code::system_information_in_message': system_information_in_message
            'transaction_code::gateway_router_request_message': gateway_router_request_message
            'transaction_code::update_local_database_in_message': update_local_database_in_message
            'transaction_code::download_request_message': download_request_message
            'transaction_code::order_entry_request_message': order_entry_request_message
            'transaction_code::order_modification_request_message': order_modification_request_message
            'transaction_code::order_cancellation_request_message': order_cancellation_request_message
            'transaction_code::order_confirmation_message': order_confirmation_message
            'transaction_code::order_modification_confirmation_message': order_modification_confirmation_message
            'transaction_code::order_entry_message': order_entry_message
            'transaction_code::order_entry_message_2042': order_entry_message
            'transaction_code::order_entry_message_2062': order_entry_message
            'transaction_code::order_entry_message_2072': order_entry_message
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
            'transaction_code::secure_box_registration_request_in_message': secure_box_registration_request_in_message
            'transaction_code::box_sign_on_request_in_message': box_sign_on_request_in_message
            'transaction_code::box_sign_off_message': box_sign_off_message
            'transaction_code::branch_order_value_limit_update_message': branch_order_value_limit_update_message
            'transaction_code::user_order_value_limit_update_message': user_order_value_limit_update_message
            'transaction_code::normal_order_limit_update_message': normal_order_limit_update_message
            'transaction_code::reset_user_password_message': reset_user_password_message
            'transaction_code::collateral_user_status_change_request_message': collateral_user_status_change_request_message
            'transaction_code::user_trade_modify_cancel_status_change_request_message': user_trade_modify_cancel_status_change_request_message
            'transaction_code::user_address_unlock_request_message': user_address_unlock_request_message
  packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the entire packet including this field, capped at 1024 bytes'
      - id: packet_sequence_number
        type: u4
        doc: 'Echoed back on responses to order related requests, zero on a non encrypting connection'
      - id: checksum
        size: 16
        doc: 'Md5 digest of the message data, or the Gcm authentication tag under the new encryption'
  message_header:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Transaction code of the record carried'
      - id: log_time
        type: dos_second_timestamp
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
        type: dos_nanosecond_timestamp
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
        size: 8
        doc: 'Reserved'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password of the user'
      - id: second_reserved_8
        size: 8
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
        doc: 'Version number of the front end'
      - id: batch_2_start_time
        type: dos_second_timestamp
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
        size: 1
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
        size: 16
        doc: 'Reserved'
      - id: second_reserved_16
        size: 16
        doc: 'Reserved'
      - id: third_reserved_16
        size: 16
        doc: 'Reserved'
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
      - id: reserved_212
        type: b11
        doc: 'Reserved'
      - id: pre_open
        type: b1
        doc: 'Eligible for the pre open market'
  system_information_in_message:
    seq:
      - id: last_update_portfolio_t_ime
        type: dos_second_timestamp
        doc: 'Time the portfolio was last updated. Seconds since Dos epoch'
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
  update_local_database_in_message:
    seq:
      - id: last_update_security_time
        type: dos_second_timestamp
        doc: 'Time the security master was last updated. Seconds since Dos epoch'
      - id: last_update_participant_time
        type: dos_second_timestamp
        doc: 'Time the participant master was last updated. Seconds since Dos epoch'
      - id: last_update_instrument_time
        type: dos_second_timestamp
        doc: 'Time the instrument master was last updated. Seconds since Dos epoch'
      - id: last_update_index_time
        type: dos_second_timestamp
        doc: 'Time the index master was last updated. Seconds since Dos epoch'
      - id: request_for_open_orders
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether open orders are also requested'
      - id: reserved_1
        size: 1
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
  download_request_message:
    seq:
      - id: sequence_number
        type: floating_point_integer
        doc: 'Sequence number'
  order_entry_request_message:
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
        size: 1
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
        doc: 'Whether the broker is in closeout status'
      - id: fourth_reserved_1
        size: 1
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
        type: dos_second_timestamp
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
        size: 1
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
        size: 2
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
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
        doc: 'Symbol of the underlying security'
      - id: expiry_date
        type: dos_second_timestamp
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
    seq:
      - id: ato
        type: b1
        doc: 'At the open order'
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
        doc: 'All or none order'
      - id: mf
        type: b1
        doc: 'Minimum fill order'
      - id: matched_ind
        type: b1
        doc: 'Order has been matched'
      - id: traded
        type: b1
        doc: 'Order has traded at least partly'
      - id: modified
        type: b1
        doc: 'Order has been modified'
      - id: frozen
        type: b1
        doc: 'Order has resulted in a freeze awaiting approval'
      - id: order_pre_open
        type: b1
        doc: 'Order belongs to the pre open session'
      - id: reserved_12
        type: b2
        doc: 'Reserved'
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
  order_modification_request_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_cancellation_request_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_confirmation_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_modification_confirmation_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
  order_entry_message:
    seq:
      - id: order_entry_body
        type: order_entry_body
        doc: 'Order Entry Body'
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
        size: 24
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
        size: 4
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
        size: 24
        doc: 'Reserved'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: second_reserved_2
        size: 2
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
        size: 60
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
        type: dos_second_timestamp
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
        size: 1
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
        size: 2
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_52
        size: 52
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
        size: 1
        doc: 'Reserved'
      - id: filler_y
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
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
        size: 5
        doc: 'Reserved'
      - id: session_key
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session key to be used for authentication'
  box_sign_off_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided box Id used for this connection'
  branch_order_value_limit_update_message:
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
        doc: 'Branch buy value limit'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'Branch sell value limit'
      - id: reserved_16
        size: 16
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
        doc: 'Id of the user signing on'
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
        doc: 'User order buy value limit'
      - id: user_order_sell_value_limit
        type: floating_point_integer
        doc: 'User order sell value limit'
      - id: reserved_16
        size: 16
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
        size: 1
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
        size: 14
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
        size: 7
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
        size: 7
        doc: 'Reserved'
  user_address_unlock_request_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user signing on'
      - id: reserved_70
        size: 70
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
  dos_nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      unix_seconds:
        value: time / 1000000000 + 315532800
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
      id: 'order_entry_request_message'
      doc: 'Order entry request, carried in the shared order entry structure'
    2040:
      id: 'order_modification_request_message'
      doc: 'Order modification request, carried in the shared order entry structure'
    2070:
      id: 'order_cancellation_request_message'
      doc: 'Order cancellation request, carried in the shared order entry structure'
    2073:
      id: 'order_confirmation_message'
      doc: 'Order entry confirmation, carried in the shared order entry structure'
    2074:
      id: 'order_modification_confirmation_message'
      doc: 'Order modification confirmation, carried in the shared order entry structure'
    2012:
      id: 'order_entry_message'
      doc: 'Order entry acknowledgements, rejections, errors and kill switch, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2042:
      id: 'order_entry_message_2042'
      doc: 'Order entry acknowledgements, rejections, errors and kill switch, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2062:
      id: 'order_entry_message_2062'
      doc: 'Order entry acknowledgements, rejections, errors and kill switch, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2072:
      id: 'order_entry_message_2072'
      doc: 'Order entry acknowledgements, rejections, errors and kill switch, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2170:
      id: 'order_entry_message_2170'
      doc: 'Order entry acknowledgements, rejections, errors and kill switch, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    2231:
      id: 'order_entry_message_2231'
      doc: 'Order entry acknowledgements, rejections, errors and kill switch, all carried in the shared order entry structure. Transaction Code in the header names the operation'
    9002:
      id: 'order_entry_message_9002'
      doc: 'Order entry acknowledgements, rejections, errors and kill switch, all carried in the shared order entry structure. Transaction Code in the header names the operation'
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
      doc: 'Invalid Box/User sign-on. Please try again.'
    16007:
      id: 'e_signon_not_possible'
      doc: 'Signing onto the trading system is restricted. Please try later on.'
    16012:
      id: 'err_invalid_symbol'
      doc: 'Invalid Symbol.'
    16013:
      id: 'err_invalid_order_number'
      doc: 'Invalid order number'
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
    16020:
      id: 'e_order_price_out_of_revised_price_ra'
      doc: 'Order price is outside the revised nge price range'
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
      doc: 'Function Not Available When Preopen trade cancel request is rejected'
    16053:
      id: 'e_change_password'
      doc: 'Your password has expired, must be changed.'
    16054:
      id: 'err_invalid_branch'
      doc: 'Invalid branch for trading member.'
    16056:
      id: 'oe_program_error'
      doc: 'Program error.'
    16063:
      id: 'err_invalid_status'
      doc: 'Requested user status is active.'
    16070:
      id: 'err_data_not_changed'
      doc: 'If Data in the incoming packet is same as the existing data.'
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
      doc: 'The system could not complete your transaction - Admin notified.'
    16134:
      id: 'err_user_disabled'
      doc: 'This Dealer is disabled. Please call the Exchange'
    16145:
      id: 'oe_invalid_stock_status'
      doc: 'Security is not eligible to trade in Preopen.'
    16148:
      id: 'err_invalid_user_id'
      doc: 'Invalid Dealer ID entered.'
    16154:
      id: 'err_invalid_trader_id'
      doc: 'Invalid Trader ID entered.'
    16169:
      id: 'oe_ato_in_open'
      doc: 'Order priced ATO cannot be entered when a security is open.'
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
      doc: 'GTC or GTD orders are not allowed during Post Close.'
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
      doc: '“Invalid Price”'
    16251:
      id: 'oe_diff_trd_mod_vol'
      doc: 'Trade modification with different quantities is received.'
    16260:
      id: 'error_user_not_exists_in_system'
      doc: 'User does not exists in system'
    16264:
      id: 'err_already_deleted'
      doc: 'User or Branch is deleted.'
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
      doc: 'The contract has matured.'
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
      doc: 'The order price is out of the day’s price range.'
    16285:
      id: 'oe_is_not_active'
      doc: 'The broker is not active.'
    16300:
      id: 'e_system_wrong_state'
      doc: 'The system is in a wrong state to make the requested change.'
    16303:
      id: 'oe_auction_pending'
      doc: 'The auction is pending.'
    16307:
      id: 'oe_qty_freeze_can'
      doc: 'The order has been cancelled due to quantity freeze.'
    16308:
      id: 'oe_price_freeze_can'
      doc: 'The order has been cancelled due to price freeze.'
    16311:
      id: 'oe_sol_period_over'
      doc: 'The Solicitor period for the Auction is over.'
    16312:
      id: 'oe_comp_period_over'
      doc: 'The Competitor period for the Auction is over.'
    16313:
      id: 'oe_auc_period_greater'
      doc: 'The auction period will cross market close time.'
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
      doc: 'MF quantity is greater than disclosed quantity.'
    16322:
      id: 'oe_mf_not_mult'
      doc: 'MF quantity is not a multiple of regular lot.'
    16323:
      id: 'oe_mf_greater_original'
      doc: 'MF quantity is greater than Original quantity.'
    16324:
      id: 'oe_disc_greater_original'
      doc: 'Disclosed quantity is greater than original quantity.'
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
      doc: 'Trading member not permitted in the market.'
    16330:
      id: 'oe_is_suspended'
      doc: 'Security is suspended.'
    16333:
      id: 'oe_branch_li_mit_exceeded'
      doc: 'Branch order value limit has been exceeded.'
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
      doc: 'Order entry not allowed for the user as it is of inquiry type.'
    16387:
      id: 'oe_security_ineligible'
      doc: 'Contract not allowed to trader in.'
    16388:
      id: 'e_fok_order_cancelled'
      doc: '“Order Cancelled By System” When Preopen unmatched orders are cancelled by the system after preopen session ends. When normal market unmatched orders are cancelled by the system if order collection phase is planned after circuit hit. When IOC unmatched orders are cancelled by the system.'
    16392:
      id: 'turnover_limit_not_provided'
      doc: 'Turnover limit not provided. Please contact Exchange.'
    16397:
      id: 'err_cannot_mod_auc_order'
      doc: 'Cannot modify Auction orders'
    16400:
      id: 'oe_max_dq_allowed'
      doc: 'DQ is less than minimum quantity allowed.'
    16404:
      id: 'oe_admin_susp_can'
      doc: 'Order has been cancelled due to freeze admin suspension.'
    16405:
      id: 'e_invalid_buy_sell_type'
      doc: 'BUY – SELL type entered is invalid.'
    16406:
      id: 'e_invalid_book_type'
      doc: 'BOOK type entered is invalid.'
    16408:
      id: 'e_invalid_trigger_price'
      doc: 'trigger_price entered has invalid characters.'
    16414:
      id: 'e_invalid_pro_client'
      doc: 'Pro/Client should be either 1 (client) or 2 (broker).'
    16415:
      id: 'e_invalid_instructions'
      doc: 'Invalid combination of book type and instructions (order_type).'
    16416:
      id: 'e_invalid_order_parameters'
      doc: 'Invalid Order Parameters.'
    16418:
      id: 'e_nnf_req_exceeded'
      doc: 'Number of NNF requests exceeded.'
    16419:
      id: 'invalid_order'
      doc: 'This error code will be returned for invalid data in the order packet.'
    16420:
      id: 'err_box_rate_exceeded_at_millisecond_level'
      doc: 'Box Rate has been exceeded by the Member at Millisecond level'
    16440:
      id: 'e_gtd_gt_maturity'
      doc: 'GTD is greater than Maturity date.'
    16441:
      id: 'dq_not_allowed_in_preopen'
      doc: 'DQ Orders are not allowed in preopen.'
    16442:
      id: 'st_ord_not_allowed_popen'
      doc: 'ST orders are not allowed in preopen.'
    16443:
      id: 'e_ord_lim_exceeds_ord_val_lim'
      doc: 'Order value exceeds the order limit value.'
    16444:
      id: 'err_usr_ord_value_limit_exceeded'
      doc: 'User Order value limit exceeded.'
    16445:
      id: 'sl_not_allowed'
      doc: 'Stop Loss (SL) orders are not allowed.'
    16446:
      id: 'mit_not_allowed'
      doc: 'Market If Touched (MIT) orders are not allowed.'
    16447:
      id: 'e_ord_not_allowed_in_preopen'
      doc: 'Order entry not allowed in Pre-open.'
    16448:
      id: 'error_sl_lmt_rsnblty_check'
      doc: 'Difference between limit price and trigger price is beyond permissible range'
    16514:
      id: 'e_not_modifiable'
      doc: 'Not modifiable.'
    16518:
      id: 'e_tm_cm_does_not_exist'
      doc: 'Clearing member, trading member link not found.'
    16521:
      id: 'e_not_clg_mem'
      doc: 'Not a clearing member.'
    16523:
      id: 'e_user_not_corp_mgr'
      doc: 'The user in not a corporate manager.'
    16532:
      id: 'e_pm_cm_invalid'
      doc: 'Clearing member participant link not found.'
    16533:
      id: 'e_corp_mgr_vu_mod'
      doc: 'Enter either Trading Member or participant.'
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
      doc: 'Trading member not permitted in futures.'
    16555:
      id: 'e_broker_not_permitted_in_opt'
      doc: 'Trading member not permitted in options.'
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
      doc: 'Negotiated orders not allowed.'
    16562:
      id: 'e_nt_trade_not_allowed'
      doc: 'Negotiated trade not allowed.'
    16566:
      id: 'e_inconsistent_broker_branch'
      doc: 'User does not belong to broker or branch.'
    16570:
      id: 'm_post_close_start'
      doc: 'The market is in post-close.'
    16571:
      id: 'm_post_close_ended'
      doc: 'The closing session has ended.'
    16572:
      id: 'm_post_close_trades'
      doc: 'Closing session trades have been generated.'
    16573:
      id: 'e_invalid_msg_length'
      doc: 'Message length is invalid.'
    16574:
      id: 'e_invalid_open_close_type'
      doc: 'Open - Close type entered is invalid.'
    16576:
      id: 'e_nnf_inq_req_exceeded'
      doc: 'No. of NNF inquiry requests exceeded.'
    16577:
      id: 'e_participant_and_volume_changed'
      doc: 'Both participant and volume changed.'
    16578:
      id: 'e_invalid_cover_uncover_type'
      doc: 'Cover - Uncover type entered is invalid.'
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
      doc: 'Participant order entry not allowed.'
    16589:
      id: 'm_delete_all_orders'
      doc: 'All continuous session orders are being deleted now.'
    16597:
      id: 'e_cum_ur_ord_val_limit_exceede'
      doc: 'Branch limit should be d greater than sum of user limits.'
    16598:
      id: 'e_branch_ord_val_limit_exceeded'
      doc: 'Branch limit should be greater than used limit.'
    16600:
      id: 'err_ord_val_exceeded'
      doc: 'The order value has exceeded maximum permissible limit.'
    16601:
      id: 'err_preopen_order_reject'
      doc: 'Request Rejected by the exchange'
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
    16609:
      id: 'e_spread_allowed_if_stock_open'
      doc: 'Spread allowed only when stock is open.'
    16610:
      id: 'e_qty_should_be_same'
      doc: 'Both legs should have same quantity.'
    16611:
      id: 'e_ord_mod_qty_frz_not_allowed'
      doc: 'Modified order quantity freeze not allowed.'
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
      doc: 'Branch manager cannot cancel corporate manager’s order.'
    16629:
      id: 'e_bm_cannot_cancel_bm_orders'
      doc: 'Branch manager cannot cancel other branch manager’s order.'
    16630:
      id: 'e_cm_cannot_cancel_cm_orders'
      doc: 'Corporate manager cannot cancel other corporate manager’s order.'
    16631:
      id: 'e_spread_in_different_underlying'
      doc: 'Spread not allowed for different underlying.'
    16632:
      id: 'e_invalid_cli_ac'
      doc: 'Cli A/c number cannot be modified as trading member ID.'
    16636:
      id: 'e_br_ord_limit_fut_buy_exceeded'
      doc: 'Futures buy branch order value limit has been exceeded.'
    16637:
      id: 'e_br_ord_limit_fut_sell_exceeded'
      doc: 'Futures sell branch order value limit has been exceeded.'
    16638:
      id: 'e_br_ord_limit_opt_buy_exceeded'
      doc: 'Options buy branch Order Value Limit has been exceeded.'
    16639:
      id: 'e_br_ord_limit_opt_sell_exceeded'
      doc: 'Options sell branch order value limit has been exceeded.'
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
      doc: 'Cannot approve. Bhavcopy generated.'
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
      doc: 'GTC GTD orders not allowed.'
    16683:
      id: 'err_user_already_signed_off'
      doc: 'User has already signed off.'
    16684:
      id: 'err_no_privilege'
      doc: 'User has no authority to request for change of mentioned User in actual packet.'
    16686:
      id: 'closeout_order_reject'
      doc: 'This error code will be returned if Close out order rejected by the system.'
    16687:
      id: 'closeout_frz_reject'
      doc: 'This error code will be returned if the close out order entered is going into freeze. (Since freeze is not allowed for close out orders)'
    16688:
      id: 'closeout_not_allowed'
      doc: 'This error code will be returned if the close out order is not allowed in the system.'
    16690:
      id: 'closeout_trdmod_reject'
      doc: 'This error code will be returned when a Trade MOD request is placed by a broker in Close-out.'
    16706:
      id: 'partial_order_reject'
      doc: 'Cancelled by the system.'
    16708:
      id: 'partial_quick_order_cxl_rej'
      doc: 'System Error. Orders not completely cancelled by the system. Please request quick CXL again.'
    16711:
      id: 'error_invalid_sprd_combination'
      doc: 'Spread order entered has invalid combination'
    16713:
      id: 'e_price_diff_out_of_range'
      doc: 'Price difference is beyond operating range.'
    16725:
      id: 'rms_rejected_in_preopen'
      doc: 'Order entry / Modification rejected by the Exchange.'
    16730:
      id: 'error_algoid_nnfid_mismatch_1'
      doc: 'NNF id & Algo id mismatch - Algo ID entered is 0 in order request.'
    16731:
      id: 'error_algoid_nnfid_mismatch_2'
      doc: 'NNF id & Algo id mismatch - For Non- Algo orders Algo id should be 0 (zero) in order request.'
    16732:
      id: 'error_algo_mkt_not_allowed'
      doc: 'Market order not allowed for Algo order.'
    16733:
      id: 'error_invalid_nnf_id'
      doc: 'Invalid NNF Id'
    16749:
      id: 'error_preopn_ato_mod_can_rej'
      doc: 'Modification / Cancellation of ATO orders are currently not allowed.'
    16752:
      id: 'error_preopn_ato_not_allowed'
      doc: 'ATO orders are currently not allowed in preopen.'
    16778:
      id: 'err_usr_not_found_in_nnf_file'
      doc: 'User is not NNF user'
    16793:
      id: 'e_vc_order_rejected'
      doc: 'Order entered has invalid data.'
    16794:
      id: 'e_ssd_order_rejected'
      doc: 'Order entered has invalid data.'
    16795:
      id: 'e_order_cancelled_for_vc'
      doc: 'Order cancelled due to voluntary close out.'
    16796:
      id: 'e_order_cancelled_for_ssd'
      doc: 'Order cancelled due to OI violation.'
    16797:
      id: 'msg_code_voluntary_close_out_status'
      doc: 'Broker is in Voluntary Closeout.'
    16798:
      id: 'msg_code_suspended_status'
      doc: 'Broker is Suspended.'
    16803:
      id: 'e_bo_price_out_of_range'
      doc: 'Bulk order rejected due to price freeze.'
    16804:
      id: 'e_bo_excess_quantity'
      doc: 'Bulk order rejected due to quantity Freeze.'
    16805:
      id: 'e_user_ineligible_for_bulk_orders'
      doc: 'Trader not eligible for bulk order.'
    16806:
      id: 'e_user_not_allowed_for_regular'
      doc: 'Trader allowed to enter only bulk order.'
    16807:
      id: 'e_account_debarred'
      doc: 'The account is disabled from trading as per directions of SEBI/Statutory Authority.'
    16816:
      id: 'e_account_debarred_by_pit'
      doc: 'Account is disabled for trading in the scrip during the Trading Window closure period (SEBI PIT Reg). Please contact the company for more details.'
    16810:
      id: 'err_usr_already_unlcked'
      doc: 'User is already unlocked.'
    16811:
      id: 'err_duplicate_unlck_alrt'
      doc: 'User unlock request is already present for requested user.'
    17022:
      id: 'err_actv_num_of_usrs_in_brnch_exceeded'
      doc: 'Active number of users in branch exceeded'
    17039:
      id: 'ec_trd_mod_rej_cli_cp_mod_not_allowed'
      doc: 'Client code/Participant modification not allowed'
    17045:
      id: 'error_quantity_lim_exceeds_qty_val_lim'
      doc: 'Order quantity exceeds quantity value limit for the user.'
    17046:
      id: 'user_trd_mod_disabled'
      doc: 'Trade modification not allowed for the user.'
    16055:
      id: 'preopen_trade_cancellation_not_allowed'
      doc: 'Trade executed during pre-open session not allowed to cancel.'
    17063:
      id: 'err_depndent_sessn_not_active'
      doc: 'Dependent session is not active'
    17070:
      id: 'e_trd_price_out_of_stock_tpp'
      doc: 'The Price is out of the current execution LPP range e$trd_price_out_of_stock_lpp'
    17071:
      id: 'e_order_cancelled_for_self_trade'
      doc: 'The order could have resulted in self trade'
    17101:
      id: 'e_invalid_packet'
      doc: 'The packet has invalid data'
    17102:
      id: 'sssssse_hearbeat_not_received'
      doc: 'Heartbeat not received'
    17104:
      id: 'e_invalid_box_id'
      doc: 'Invalid box id'
    17105:
      id: 'e_seq_no_mismatch'
      doc: 'Sequence number mismatch'
    17106:
      id: 'e_box_rate_exceeded'
      doc: 'Box Rate has been exceeded by the Member'
    17107:
      id: 'error_hb_rate_exceeded'
      doc: 'Heart beat rate exceeded by the member'
    17142:
      id: 'e_max_user_count_exceeded'
      doc: 'Maximum user login allowed per box has been exceeded'
    16403:
      id: 'e_invalid_box_ip_combination'
      doc: 'Login from invalid IP'
    17177:
      id: 'err_invalid_pan_id'
      doc: 'Invalid PAN Id'
    17179:
      id: 'err_invalid_algo_id'
      doc: 'Invalid Algo Id'
    17180:
      id: 'err_invalid_value_in_reserved'
      doc: 'Invalid value in the Reserved Field'
    17185:
      id: 'err_algo_id_disabled'
      doc: 'Order rejected as Algo ID is disabled by the Exchange'
    17186:
      id: 'err_order_cancelled_algoid_disabled'
      doc: 'Order cancelled as Algo ID is disabled by the Exchange'
    19028:
      id: 'err_checksum_failed_gr'
      doc: 'Checksum verification failed at Gateway Router'
    19029:
      id: 'err_multiple_gr_query_rcv'
      doc: 'Multiple GR_QUERY request received'
    17181:
      id: 'err_mkt_order_not_allowed'
      doc: 'Contract not traded. Market order not allowed'
    17182:
      id: 'err_trade_beyond_markup_price'
      doc: 'Order could have resulted in trade beyond mark-up price'
    19030:
      id: 'err_encryption_flag_mismatch'
      doc: 'Encryption Flag Mismatch'
    19031:
      id: 'err_md_5_checksum_failure'
      doc: 'MD5 Checksum Failed'
    17184:
      id: 'err_user_having_null_rights'
      doc: 'Order Rejected as user has NO trading rights'
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
  status:
    0:
      id: 'end_of_outage'
      doc: 'End Of Outage'
    1:
      id: 'start_of_outage'
      doc: 'Start Of Outage'

