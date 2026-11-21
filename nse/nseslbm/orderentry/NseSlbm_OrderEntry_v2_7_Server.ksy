# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseSlbm OrderEntry NnfDirect v2.7
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End Direct Interface
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
  id: nse_nseslbm_orderentry_nnfdirect_v2_7_server
  title: Nse NseSlbm OrderEntry NnfDirect v2.7
  license: MIT-0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Securities Lending and Borrowing Market Order Entry NnfDirect v2.7'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: server_direct_packet
    type: server_direct_packet_struct
    repeat: eos
    doc: 'One framed interactive message sent by the exchange'

types:
  server_direct_packet_struct:
    seq:
      - id: packet_header
        type: packet_header
        doc: 'Packet Length and Sequence number, the first six bytes of the direct interface''s twenty two byte packet header; its last sixteen open each packet body branch'
      - id: server_packet_body
        size: packet_header.packet_length - 6
        type:
          switch-on: peek_transaction_code
          cases:
            'transaction_code::secure_box_registration_response_message': server_registration_packet
            _: server_session_packet
    instances:
      peek_transaction_code:
        pos: _io.pos + 16
        type: s2
        enum: transaction_code
  packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the entire packet including this field, capped at 1024 bytes'
      - id: packet_sequence_number
        type: u4
        doc: 'Echoed back on responses to order related requests, zero on a non encrypting connection'
  server_registration_packet:
    seq:
      - id: registration_checksum
        size: 16
        doc: 'Md5 digest of the registration''s message data, which is never encrypted'
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: server_message_payload
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::logon_response_message': server_registration_packet_logon_response_message
            'transaction_code::system_information_response_message': system_information_response_message
            'transaction_code::partial_system_information_response_message': partial_system_information_response_message
            'transaction_code::update_local_database_header_message': update_local_database_header_message
            'transaction_code::update_local_database_data_message': update_local_database_data_message
            'transaction_code::update_local_database_trailer_message': update_local_database_trailer_message
            'transaction_code::message_download_data_message': message_download_data_message
            'transaction_code::board_lot_out_message': board_lot_out_message
            'transaction_code::order_confirmation_response_message': order_confirmation_response_message
            'transaction_code::market_price_confirmation_response_message': market_price_confirmation_response_message
            'transaction_code::order_freeze_response_message': order_freeze_response_message
            'transaction_code::order_error_response_message': order_error_response_message
            'transaction_code::order_modification_response_message': order_modification_response_message
            'transaction_code::order_modification_confirmation_response_message': order_modification_confirmation_response_message
            'transaction_code::order_modification_error_response_message': order_modification_error_response_message
            'transaction_code::order_cancellation_response_message': order_cancellation_response_message
            'transaction_code::order_cancellation_confirmation_response_message': order_cancellation_confirmation_response_message
            'transaction_code::order_cancellation_error_response_message': order_cancellation_error_response_message
            'transaction_code::cancellation_of_orders_in_batch_message': cancellation_of_orders_in_batch_message
            'transaction_code::negotiated_order_entered_by_counter_party_message': negotiated_order_entered_by_counter_party_message
            'transaction_code::negotiated_order_to_regular_lot_message': negotiated_order_to_regular_lot_message
            'transaction_code::cancel_negotiated_order_message': cancel_negotiated_order_message
            'transaction_code::trade_cancellation_requested_response_message': trade_cancellation_requested_response_message
            'transaction_code::trade_cancellation_error_message': trade_cancellation_error_message
            'transaction_code::trade_modification_requested_response_message': trade_modification_requested_response_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::stop_loss_order_triggering_message': stop_loss_order_triggering_message
            'transaction_code::trade_cancellation_confirmation_response_message': trade_cancellation_confirmation_response_message
            'transaction_code::trade_cancellation_rejection_message': trade_cancellation_rejection_message
            'transaction_code::trade_modification_confirmation_message': trade_modification_confirmation_message
            'transaction_code::trade_modification_rejection_message': trade_modification_rejection_message
            'transaction_code::control_message_to_trader_message': control_message_to_trader_message
            'transaction_code::error_response_message': error_response_message
            'transaction_code::gateway_router_response_message': gateway_router_response_message
            'transaction_code::box_sign_on_response_message': box_sign_on_response_message
            'transaction_code::box_sign_off_message': box_sign_off_message
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
        doc: 'User ID'
      - id: error_code
        type: s2_nullable
        doc: 'Zero when the request succeeded, otherwise an Error Response follows. Nullable, No Error = 0'
      - id: header_timestamp
        type: s8
        doc: 'Host end field, carrying nanoseconds since midnight 01-Jan-1980 on the transaction codes listed in the appendix'
      - id: time_stamp_1
        type: str_8_nullable
        doc: 'Time the message arrived at the trading system host, in jiffies; zero when sent to the host. Nullable, No Value = 00000000'
      - id: time_stamp_2
        type: str_8_nullable
        doc: 'Set by the host: the number of the machine the packet comes from on an order entry connection, the stream number on a drop copy one; zero when sent to the host. Nullable, No Value = 00000000'
      - id: message_length
        type: s2
        doc: 'Length of the message including the message header, twenty two less than Packet Length'
  server_registration_packet_logon_response_message:
    seq:
      - id: logon_response_body
        type:
          switch-on: _parent.message_header.message_length
          cases:
            212: logon_confirmation_body
            180: logon_error_body
  logon_confirmation_body:
    seq:
      - id: user_id
        type: s4
        doc: 'User ID of the user or broker'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password entered by the user'
      - id: new_password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'New password, entered only to change the password; otherwise blank'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'User''s name when received from the host; sent as blanks'
      - id: last_password_change_date
        type: dos_second_timestamp
        doc: 'Last date and time the password was changed. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: version_number
        type: s4
        doc: 'Version number of the trading system, as VERSION RELEASE SUB_RELEASE'
      - id: end_time
        type: dos_second_timestamp
        doc: 'Time the markets last closed, in seconds since midnight of January 1 1980. Seconds since Dos epoch'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: user_type
        type: s2
        enum: user_type
        doc: 'Type of user; set to zero while sending to the host'
      - id: sequence_number
        type: floating_point_integer
        doc: 'Set to zero while sending the request to the host'
      - id: reserved_14
        size: 14
        doc: 'Reserved'
      - id: broker_status
        type: u1
        enum: broker_status
        doc: 'Set to blank'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: broker_eligibility_per_market
        type: broker_eligibility_per_market
        doc: 'Markets the trading member may enter orders in, packed into 2 bytes'
      - id: broker_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member name'
      - id: char_filler_3
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  broker_eligibility_per_market:
    seq:
      - id: normal_market
        type: b1
        doc: 'Trading member is eligible for the normal market'
      - id: oddlot_market
        type: b1
        doc: 'Trading member is eligible for the odd lot market'
      - id: spot_market
        type: b1
        doc: 'Trading member is eligible for the spot market'
      - id: auction_market
        type: b1
        doc: 'Trading member is eligible for the auction market'
      - id: reserved_112
        type: b12
        doc: 'Reserved'
  logon_error_body:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: error_message
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Error message describing the error'
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
  system_information_response_message:
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
  partial_system_information_response_message:
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
  update_local_database_header_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'Reserved'
  update_local_database_data_message:
    seq:
      - id: data
        type: str
        size-eos: true
        encoding: ASCII
        pad-right: 0x20
        doc: 'The wrapped message: an inner header naming the record, then its data'
  update_local_database_trailer_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'Reserved'
  message_download_data_message:
    seq:
      - id: data
        type: str
        size-eos: true
        encoding: ASCII
        pad-right: 0x20
        doc: 'The wrapped message: an inner header naming the record, then its data'
  board_lot_out_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  st_order_flags:
    seq:
      - id: ato
        type: b1
        doc: 'Market order in preopen'
      - id: mkt
        type: b1
        doc: 'Market order'
      - id: on_stop
        type: b1
        doc: 'Stop loss attribute'
      - id: day
        type: b1
        doc: 'Day attribute, the default'
      - id: gtc
        type: b1
        doc: 'Good till cancel attribute'
      - id: fok
        type: b1
        doc: 'Immediate or cancel attribute'
      - id: aon
        type: b1
        doc: 'Orders have the all or none attribute set'
      - id: mf
        type: b1
        doc: 'Minimum fill attribute'
      - id: matched_ind
        type: b1
        doc: 'The negotiated order found a matching order'
      - id: traded
        type: b1
        doc: 'The order is traded partially or fully'
      - id: modified
        type: b1
        doc: 'The order is modified'
      - id: frozen
        type: b1
        doc: 'The order has gone for a freeze'
      - id: filler_1
        type: b1
        doc: 'Filler'
      - id: order_flags_reserved_three
        type: b1
        doc: 'Reserved'
      - id: stpc
        type: b1
        doc: 'Self trade prevention check'
      - id: order_flags_reserved_one
        type: b1
        doc: 'Reserved'
  order_confirmation_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  market_price_confirmation_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_freeze_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_error_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_modification_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_modification_confirmation_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_modification_error_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_cancellation_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_cancellation_confirmation_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  order_cancellation_error_response_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  cancellation_of_orders_in_batch_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  negotiated_order_entered_by_counter_party_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  negotiated_order_to_regular_lot_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  cancel_negotiated_order_message:
    seq:
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'C for a competitor order and S for a solicitor order'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'Default solicitor period for auction'
      - id: mod_cxl_by
        type: u1
        enum: mod_cxl_by
        doc: 'Which person modified or cancelled the order'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for an order request rejection or an order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number for an auction order, else zero'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended; C if the broker is in closeout'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number: a two digit stream number followed by a fourteen digit sequence number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number, or the broker code for the broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Trigger price of a stop loss order, multiplied by 100. Implied decimal with scale 1e-2'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order was confirmed; zero on entry. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight of January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'Branch the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: oe_remarks
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks the dealer enters about the order'
      - id: transaction_id
        type: s4
        doc: 'Echo back field, returned as sent with no validation'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Pin code, branch and terminal of the dealer, followed by the algo, vendor and exchange digits'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'Time the order was written to the order book; zero on sending'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
  trade_cancellation_requested_response_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: l_fill_number
        type: s4
        doc: 'Trade number of the trade'
      - id: l_fill_qty
        type: s4
        doc: 'Quantity of the trade'
      - id: l_fill_price
        type: decimal_s4_2
        doc: 'Price of the trade. Implied decimal with scale 1e-2'
      - id: i_mkt_type
        type: s2
        doc: 'Market type of the trade'
      - id: l_new_volume
        type: s4
        doc: 'New volume of the trade'
      - id: buy_participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant of the buy side'
      - id: sell_participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant of the sell side'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker of the buy side'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker of the sell side'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: requested_by
        type: s2
        doc: 'Side requesting the trade cancellation'
  trade_cancellation_error_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: l_fill_number
        type: s4
        doc: 'Trade number of the trade'
      - id: l_fill_qty
        type: s4
        doc: 'Quantity of the trade'
      - id: l_fill_price
        type: decimal_s4_2
        doc: 'Price of the trade. Implied decimal with scale 1e-2'
      - id: i_mkt_type
        type: s2
        doc: 'Market type of the trade'
      - id: l_new_volume
        type: s4
        doc: 'New volume of the trade'
      - id: buy_participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant of the buy side'
      - id: sell_participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant of the sell side'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker of the buy side'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker of the sell side'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: requested_by
        type: s2
        doc: 'Side requesting the trade cancellation'
  trade_modification_requested_response_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: reverse_leg_settl_date
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: l_fill_number
        type: s4
        doc: 'Trade number of the trade'
      - id: l_fill_qty
        type: s4
        doc: 'Quantity of the trade'
      - id: l_fill_price
        type: decimal_s4_2
        doc: 'Price of the trade. Implied decimal with scale 1e-2'
      - id: i_mkt_type
        type: s2
        doc: 'Market type of the trade'
      - id: l_new_volume
        type: s4
        doc: 'New volume of the trade'
      - id: buy_participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant of the buy side'
      - id: sell_participant_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant of the sell side'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker of the buy side'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker of the sell side'
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: requested_by
        type: s2
        doc: 'Side requesting the trade cancellation'
  trade_confirmation_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: trader_num
        type: s4
        doc: 'Trader''s or user ID'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: gtd
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: vol_filled_today
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
      - id: op_order_number
        type: floating_point_integer
        doc: 'Order number of the counter order taking part in the trade'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
  stop_loss_order_triggering_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: trader_num
        type: s4
        doc: 'Trader''s or user ID'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: gtd
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: vol_filled_today
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
      - id: op_order_number
        type: floating_point_integer
        doc: 'Order number of the counter order taking part in the trade'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
  trade_cancellation_confirmation_response_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: trader_num
        type: s4
        doc: 'Trader''s or user ID'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: gtd
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: vol_filled_today
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
      - id: op_order_number
        type: floating_point_integer
        doc: 'Order number of the counter order taking part in the trade'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
  trade_cancellation_rejection_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: trader_num
        type: s4
        doc: 'Trader''s or user ID'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: gtd
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: vol_filled_today
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
      - id: op_order_number
        type: floating_point_integer
        doc: 'Order number of the counter order taking part in the trade'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
  trade_modification_confirmation_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: trader_num
        type: s4
        doc: 'Trader''s or user ID'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: gtd
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: vol_filled_today
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
      - id: op_order_number
        type: floating_point_integer
        doc: 'Order number of the counter order taking part in the trade'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
  trade_modification_rejection_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: order_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank for a normal order, RC for a recall order and RP for a repay order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: trader_num
        type: s4
        doc: 'Trader''s or user ID'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order is a buy or a sell; for SLBM buy is borrow and sell is lend'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after trades'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, multiplied by 100; zero for a market order. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of an order, packed into 2 bytes'
      - id: gtd
        type: dos_second_timestamp
        doc: 'Reverse leg settlement date of the contract. Seconds since Dos epoch'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: vol_filled_today
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
      - id: op_order_number
        type: floating_point_integer
        doc: 'Order number of the counter order taking part in the trade'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code of a negotiated trade order'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Type of order'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation'
      - id: pro_client
        type: s2
        enum: pro_client
        doc: 'Whether the order is a client''s, a broker''s or a warehousing order'
  control_message_to_trader_message:
    seq:
      - id: trader_id
        type: s4
        doc: 'User ID'
      - id: action_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Action taken'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: msg_length
        type: s2
        doc: 'Length of the message'
      - id: msg
        type: str
        size: 239
        encoding: ASCII
        pad-right: 0x20
        doc: 'Message'
  error_response_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: error_message
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'Error message describing the error'
  gateway_router_response_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member ID'
      - id: filler
        size: 1
        doc: 'Filler'
      - id: ip_address
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'IP address assigned by the exchange'
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
        doc: 'Key for encrypting and decrypting every message with the allocated gateway server'
      - id: cryptographic_iv_initialization_vector
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Initialization vector for encrypting and decrypting every message with the allocated gateway server'
  box_sign_on_response_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection'
      - id: reserved_10
        size: 10
        doc: 'Reserved'
  box_sign_off_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection'
  server_session_packet:
    seq:
      - id: checksum
        size: 16
        doc: 'Md5 digest of the plain message data, or the Gcm authentication tag under the new encryption'
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: server_message_payload
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::logon_response_message': server_session_packet_logon_response_message
            'transaction_code::system_information_response_message': system_information_response_message
            'transaction_code::partial_system_information_response_message': partial_system_information_response_message
            'transaction_code::update_local_database_header_message': update_local_database_header_message
            'transaction_code::update_local_database_data_message': update_local_database_data_message
            'transaction_code::update_local_database_trailer_message': update_local_database_trailer_message
            'transaction_code::message_download_data_message': message_download_data_message
            'transaction_code::board_lot_out_message': board_lot_out_message
            'transaction_code::order_confirmation_response_message': order_confirmation_response_message
            'transaction_code::market_price_confirmation_response_message': market_price_confirmation_response_message
            'transaction_code::order_freeze_response_message': order_freeze_response_message
            'transaction_code::order_error_response_message': order_error_response_message
            'transaction_code::order_modification_response_message': order_modification_response_message
            'transaction_code::order_modification_confirmation_response_message': order_modification_confirmation_response_message
            'transaction_code::order_modification_error_response_message': order_modification_error_response_message
            'transaction_code::order_cancellation_response_message': order_cancellation_response_message
            'transaction_code::order_cancellation_confirmation_response_message': order_cancellation_confirmation_response_message
            'transaction_code::order_cancellation_error_response_message': order_cancellation_error_response_message
            'transaction_code::cancellation_of_orders_in_batch_message': cancellation_of_orders_in_batch_message
            'transaction_code::negotiated_order_entered_by_counter_party_message': negotiated_order_entered_by_counter_party_message
            'transaction_code::negotiated_order_to_regular_lot_message': negotiated_order_to_regular_lot_message
            'transaction_code::cancel_negotiated_order_message': cancel_negotiated_order_message
            'transaction_code::trade_cancellation_requested_response_message': trade_cancellation_requested_response_message
            'transaction_code::trade_cancellation_error_message': trade_cancellation_error_message
            'transaction_code::trade_modification_requested_response_message': trade_modification_requested_response_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::stop_loss_order_triggering_message': stop_loss_order_triggering_message
            'transaction_code::trade_cancellation_confirmation_response_message': trade_cancellation_confirmation_response_message
            'transaction_code::trade_cancellation_rejection_message': trade_cancellation_rejection_message
            'transaction_code::trade_modification_confirmation_message': trade_modification_confirmation_message
            'transaction_code::trade_modification_rejection_message': trade_modification_rejection_message
            'transaction_code::control_message_to_trader_message': control_message_to_trader_message
            'transaction_code::error_response_message': error_response_message
            'transaction_code::gateway_router_response_message': gateway_router_response_message
            'transaction_code::box_sign_on_response_message': box_sign_on_response_message
            'transaction_code::box_sign_off_message': box_sign_off_message
  server_session_packet_logon_response_message:
    seq:
      - id: logon_response_body
        type:
          switch-on: _parent.message_header.message_length
          cases:
            212: logon_confirmation_body
            180: logon_error_body
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
      id: 'logon_request_message'
      doc: 'Sent as SIGN_ON_REQUEST_IN to establish an interactive circuit with the host'
    2301:
      id: 'logon_response_message'
      doc: 'Sent as SIGN_ON_REQUEST_OUT: a logon confirmation, or an error response when the logon fails'
    1600:
      id: 'system_information_request_message'
      doc: 'Sent as SYSTEM_INFORMATION_IN once the user has logged on'
    1601:
      id: 'system_information_response_message'
      doc: 'Sent as SYSTEM_INFORMATION_OUT with the market status and global variables'
    7321:
      id: 'partial_system_information_response_message'
      doc: 'Sent as PARTIAL_SYSTEM_INFORMATION when the market status the trader sent is not current'
    7300:
      id: 'update_local_database_request_message'
      doc: 'Sent as UPDATE_LOCALDB_IN to request the local database download'
    7307:
      id: 'update_local_database_header_message'
      doc: 'Sent as UPDATE_LOCALDB_HEADER to signal that the local database download is starting'
    7304:
      id: 'update_local_database_data_message'
      doc: 'Sent as UPDATE_LOCALDB_DATA, wrapping a security master, security status or participant master record'
    7308:
      id: 'update_local_database_trailer_message'
      doc: 'Sent as UPDATE_LOCALDB_TRAILER to signal that the local database download is complete'
    7000:
      id: 'message_download_request_message'
      doc: 'Sent as DOWNLOAD_REQUEST to download the messages intended for the trader'
    7011:
      id: 'message_download_header_message'
      doc: 'Sent as HEADER_RECORD to signal that the message download is starting'
    7021:
      id: 'message_download_data_message'
      doc: 'Sent as MESSAGE_RECORD, wrapping one trader specific or broadcast message'
    7031:
      id: 'message_download_trailer_message'
      doc: 'Sent as TRAILER_RECORD to signal that the message download is complete'
    2320:
      id: 'logoff_request_message'
      doc: 'Sent as SIGN_OFF_REQUEST_IN to sign off from the trading system'
    2321:
      id: 'logoff_confirmation_response_message'
      doc: 'Sent as SIGN_OFF_REQUEST_OUT, giving the logoff time in Log Time'
    2000:
      id: 'order_entry_request_message'
      doc: 'Sent as BOARD_LOT_IN to place an order'
    2001:
      id: 'board_lot_out_message'
      doc: 'Sent as BOARD_LOT_OUT'
    2073:
      id: 'order_confirmation_response_message'
      doc: 'Sent as ORDER_CONFIRMATION when an order is confirmed, or when its freeze is approved'
    2012:
      id: 'market_price_confirmation_response_message'
      doc: 'Sent as PRICE_CONFIRMATION when a market order is not fully traded'
    2170:
      id: 'order_freeze_response_message'
      doc: 'Sent as FREEZE_TO_CONTROL when an order awaits approval from the exchange'
    2231:
      id: 'order_error_response_message'
      doc: 'Sent as ORDER_ERROR when an order is rejected, or its freeze is rejected'
    2040:
      id: 'order_modification_request_message'
      doc: 'Sent as ORDER_MOD_IN to modify an unmatched order'
    2041:
      id: 'order_modification_response_message'
      doc: 'Sent as ORDER_MOD_OUT when an order modification is requested'
    2074:
      id: 'order_modification_confirmation_response_message'
      doc: 'Sent as ORDER_MOD_CONFIRMATION when a modification is confirmed, or its freeze is approved'
    2042:
      id: 'order_modification_error_response_message'
      doc: 'Sent as ORDER_MOD_REJECT when a modification is rejected, or its freeze is rejected'
    2070:
      id: 'order_cancellation_request_message'
      doc: 'Sent as ORDER_CANCEL_IN to cancel an order'
    2071:
      id: 'order_cancellation_response_message'
      doc: 'Sent as ORDER_CANCEL_OUT when an order cancellation is requested'
    2075:
      id: 'order_cancellation_confirmation_response_message'
      doc: 'Sent as ORDER_CANCEL_CONFIRMATION when an order is cancelled'
    2072:
      id: 'order_cancellation_error_response_message'
      doc: 'Sent as ORDER_CANCEL_REJECT when a cancellation is rejected'
    9002:
      id: 'cancellation_of_orders_in_batch_message'
      doc: 'Sent as BATCH_ORDER_CANCEL when untraded orders are deleted at the end of the day'
    2009:
      id: 'negotiated_order_entered_by_counter_party_message'
      doc: 'Sent as NEG_ORDER_BY_CPID to every user of the broker named as counter party'
    2008:
      id: 'negotiated_order_to_regular_lot_message'
      doc: 'Sent as NEG_ORDER_TO_BL to the party whose negotiated order is sent to the regular lot book'
    2076:
      id: 'cancel_negotiated_order_message'
      doc: 'Sent as CANCEL_NEG_ORDER to the party whose negotiated order is cancelled'
    5440:
      id: 'trade_cancellation_request_message'
      doc: 'Sent as TRADE_CANCEL_IN to request cancellation of a trade'
    5441:
      id: 'trade_cancellation_requested_response_message'
      doc: 'Sent as TRADE_CANCEL_OUT to acknowledge that the request reached the trading system'
    2223:
      id: 'trade_cancellation_error_message'
      doc: 'Sent as TRADE_ERROR when an error is detected in the request'
    5445:
      id: 'trade_modification_request_message'
      doc: 'Sent as TRADE_MOD_IN; trade modification is currently not allowed'
    5446:
      id: 'trade_modification_requested_response_message'
      doc: 'Sent as TRADE_MOD_OUT; trade modification is currently not allowed'
    2222:
      id: 'trade_confirmation_message'
      doc: 'Sent as TRADE_CONFIRMATION when an order of the trader trades, or a negotiated trade is approved'
    2212:
      id: 'stop_loss_order_triggering_message'
      doc: 'Sent as ON_STOP_NOTIFICATION when a stop loss order is triggered'
    2282:
      id: 'trade_cancellation_confirmation_response_message'
      doc: 'Sent as TRADE_CANCEL_CONFIRM when the exchange approves a trade cancellation'
    2286:
      id: 'trade_cancellation_rejection_message'
      doc: 'Sent as TRADE_CANCEL_REJECT when the exchange rejects a trade cancellation'
    2287:
      id: 'trade_modification_confirmation_message'
      doc: 'Sent as TRADE_MODIFY_CONFIRM'
    2288:
      id: 'trade_modification_rejection_message'
      doc: 'Sent as TRADE_MODIFY_REJECT'
    5295:
      id: 'control_message_to_trader_message'
      doc: 'Sent as CTRL_MSG_TO_TRADER for a message from NSE-Control to a particular user, and for a counter party''s trade cancellation request'
    2302:
      id: 'error_response_message'
      doc: 'Sent as ERROR_RESPONSE_OUT when the Error Code of the header is not zero'
    2400:
      id: 'gateway_router_request_message'
      doc: 'Sent as GR_REQUEST to the gateway router over a TLS connection'
    2401:
      id: 'gateway_router_response_message'
      doc: 'Sent as GR_RESPONSE with the allocated gateway server, its session key and the cryptographic key and vector'
    23008:
      id: 'secure_box_registration_request_message'
      doc: 'Sent as SECURE_BOX_REGISTRATION_REQUEST_IN on the new connection to the allocated gateway server'
    23009:
      id: 'secure_box_registration_response_message'
      doc: 'Sent as SECURE_BOX_REGISTRATION_RESPONSE_OUT; an error terminates the box connection'
    23000:
      id: 'box_sign_on_request_message'
      doc: 'Sent as BOX_SIGN_ON_REQUEST_IN, the first encrypted message on the box connection'
    23001:
      id: 'box_sign_on_response_message'
      doc: 'Sent as BOX_SIGN_ON_REQUEST_OUT; an error terminates the box connection'
    23506:
      id: 'heartbeat_message'
      doc: 'Sent as HEARTBEAT after thirty seconds of inactivity on the box connection'
    20322:
      id: 'box_sign_off_message'
      doc: 'Sent as BOX_SIGN_OFF with an error code when the exchange terminates the connection'
  user_type:
    0:
      id: 'dealer'
      doc: 'Dealer'
    4:
      id: 'corporate_manager'
      doc: 'Corporate manager'
    5:
      id: 'branch_manager'
      doc: 'Branch manager'
  broker_status:
    0x20:
      id: 'blank'
      doc: 'Set to blank in the logon request'
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
  request_for_open_orders:
    0x47:
      id: 'download_gtc_and_gtd_orders'
      doc: 'GTC and GTD orders are to be downloaded'
    0x4e:
      id: 'no_open_orders'
      doc: 'Other cases'
  normal_market_status:
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
  odd_lot_market_status:
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
  spot_market_status:
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
  auction_market_status:
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
  participant_type:
    0x43:
      id: 'competitor'
      doc: 'Competitor order'
    0x53:
      id: 'solicitor'
      doc: 'Solicitor order'
    0x49:
      id: 'initiator'
      doc: 'Initiator, which only the exchange may set'
  mod_cxl_by:
    0x54:
      id: 'trader'
      doc: 'Trader'
    0x42:
      id: 'branch_manager'
      doc: 'Branch manager'
    0x4d:
      id: 'corporate_manager'
      doc: 'Corporate manager'
    0x43:
      id: 'control'
      doc: 'Control'
  reason_code:
    0:
      id: 'not_set'
      doc: 'Set to zero while sending the request to the host'
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
      doc: 'Counter party'
    11:
      id: 'order_number'
      doc: 'Order number'
    15:
      id: 'auction_number'
      doc: 'Auction number'
    17:
      id: 'price_freeze'
      doc: 'Price freeze'
    18:
      id: 'quantity_freeze'
      doc: 'Quantity freeze'
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
  buy_sell:
    1:
      id: 'buy'
      doc: 'Buy order'
    2:
      id: 'sell'
      doc: 'Sell order'
  stpc:
    0:
      id: 'exchange_default_action'
      doc: 'An order resulting in a self trade is cancelled as per the default action of the exchange'
    1:
      id: 'cancel_active_order'
      doc: 'The active order resulting in a self trade is cancelled'
  pro_client:
    1:
      id: 'client'
      doc: 'Client''s order'
    2:
      id: 'broker'
      doc: 'Broker''s order'
    4:
      id: 'warehousing'
      doc: 'Warehousing order'
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

