# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCm OrderEntry NnfDirect v6.6
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End Direct Interface
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
  id: nse_nsecm_orderentry_nnfdirect_v6_6_server
  title: Nse NseCm OrderEntry NnfDirect v6.6
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Capital Market Order Entry NnfDirect v6.6'
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
        doc: 'Direct interface twenty two byte packet header'
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: server_message_payload
        size: packet_header.packet_length - 62
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::auction_inquiry_response_message': auction_inquiry_response_message
            'transaction_code::branch_order_value_limit_update_out_message': branch_order_value_limit_update_out_message
            'transaction_code::cancel_on_logout_status_response_message': cancel_on_logout_status_response_message
            'transaction_code::error_response_message': error_response_message
            'transaction_code::secure_box_registration_request_message': secure_box_registration_request_message
            'transaction_code::box_sign_on_response_message': box_sign_on_response_message
            'transaction_code::gateway_router_response_message': gateway_router_response_message
            'transaction_code::control_message_to_trader_message': control_message_to_trader_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2222': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2282': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2286': trade_confirmation_message
            'transaction_code::trade_confirmation_message_2287': trade_confirmation_message
            'transaction_code::order_entry_out_message': order_entry_out_message
            'transaction_code::order_entry_out_message_2042': order_entry_out_message
            'transaction_code::order_entry_out_message_2061': order_entry_out_message
            'transaction_code::order_entry_out_message_2072': order_entry_out_message
            'transaction_code::order_entry_out_message_2073': order_entry_out_message
            'transaction_code::order_entry_out_message_2074': order_entry_out_message
            'transaction_code::order_entry_out_message_2075': order_entry_out_message
            'transaction_code::order_entry_out_message_2170': order_entry_out_message
            'transaction_code::order_entry_out_message_2231': order_entry_out_message
            'transaction_code::order_entry_out_message_9002': order_entry_out_message
            'transaction_code::order_entry_short_message': order_entry_short_message
            'transaction_code::order_entry_short_message_2071': order_entry_short_message
            'transaction_code::order_limit_update_out_message': order_limit_update_out_message
            'transaction_code::password_reset_out_message': password_reset_out_message
            'transaction_code::security_status_change_message': security_status_change_message
            'transaction_code::security_status_change_message_18707': security_status_change_message
            'transaction_code::security_master_change_message': security_master_change_message
            'transaction_code::sign_on_request_out_message': sign_on_request_out_message
            'transaction_code::sign_on_response_message': sign_on_response_message
            'transaction_code::system_information_message': system_information_message
            'transaction_code::system_information_message_7321': system_information_message
            'transaction_code::trade_inquiry_out_message': trade_inquiry_out_message
            'transaction_code::trade_inquiry_out_message_5441': trade_inquiry_out_message
            'transaction_code::update_local_database_header_message': update_local_database_header_message
            'transaction_code::update_local_database_trailer_message': update_local_database_trailer_message
            'transaction_code::user_unlock_approval_rejection_message': user_unlock_approval_rejection_message
            'transaction_code::user_unlock_approval_rejection_message_5579': user_unlock_approval_rejection_message
            'transaction_code::user_unlock_requested_response_message': user_unlock_requested_response_message
            'transaction_code::user_order_value_limit_update_out_message': user_order_value_limit_update_out_message
            'transaction_code::trade_modification_cancellation_status_response_message': trade_modification_cancellation_status_response_message
            'transaction_code::update_local_database_data_message': update_local_database_data_message
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
        doc: 'Type of message sent or received'
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch'
      - id: alpha_char
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'First two characters of Symbol when the message carries one'
      - id: trader_id
        type: s4
        doc: 'This field should contain the user ID'
      - id: error_code
        type: s2
        doc: 'Zero when the request succeeded, otherwise an Error Response follows'
      - id: header_timestamp
        type: dos_nanosecond_timestamp
        doc: 'Host end field, carrying nanoseconds since midnight 01-Jan-1980 on the transaction codes listed in the appendix. Nanoseconds since Dos epoch'
      - id: time_stamp_1
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for the host'
      - id: time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the message reached the gateway'
      - id: message_length
        type: s2
        doc: 'Length of the message including the message header, twenty two less than Packet Length'
  auction_inquiry_response_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'This field contains the number of markets for which Market Statistics is being sent'
      - id: inquirydata
        type: inquirydata
        repeat: expr
        repeat-expr: 5
        doc: 'INQUIRYDATA'
  inquirydata:
    seq:
      - id: token
        type: s4
        doc: 'This field contains the token number of the security being updated'
      - id: auction_number
        type: s2
        doc: 'Auction number is available when initiation of auction is broadcast (Auction Status Change Broadcast)'
      - id: auction_status
        type: s2
        enum: auction_status
        doc: 'Status of the auction'
      - id: initiator_type
        type: s2
        doc: 'Whether the auction was initiated by control or by a trader'
      - id: total_buy
        type: s4
        doc: 'Total buy quantity in the auction'
      - id: best_buy_price
        type: decimal_s4_2
        doc: 'Best buy price in the auction, in paise. Implied decimal with scale 1e-2'
      - id: total_sell
        type: s4
        doc: 'Total sell quantity in the auction'
      - id: best_sell_price
        type: decimal_s4_2
        doc: 'Best sell price in the auction, in paise. Implied decimal with scale 1e-2'
      - id: auctioin_price
        type: decimal_s4_2
        doc: 'Price at which the auction matched, in paise, which the document spells AuctioinPrice. Implied decimal with scale 1e-2'
      - id: auction_quantity
        type: s4
        doc: 'Quantity the auction matched'
      - id: settlement_period
        type: s2
        doc: 'Settlement period of the security'
  branch_order_value_limit_update_out_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_25
        size: 25
        doc: 'Reserved for future use 172 173'
      - id: branch
        type: s2
        doc: 'This field should contain the branch number for which limit to be set This field should contain the branch number of user for which limit to be set 7'
      - id: branch_limit
        type: branch_limit
        doc: 'BRANCH_LIMIT'
  branch_limit:
    seq:
      - id: branch_buy_value_limit
        type: floating_point_integer
        doc: 'Buy value limit set for the branch'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use 172 173'
      - id: branch_sell_value_limit
        type: floating_point_integer
        doc: 'Sell value limit set for the branch'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use 172 173'
  cancel_on_logout_status_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
      - id: colo_user_bit
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain user’s COL status to be set'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
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
        doc: 'Error Message'
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
  secure_box_registration_request_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection 165 SECURE_BOX_REGISTRATION_RESPONSE Exchange provided Box ID to be used for this connection 166 Exchange provided Box ID used for this connection Exchange provided Box ID used for this connection 170'
  box_sign_on_response_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection 165 SECURE_BOX_REGISTRATION_RESPONSE Exchange provided Box ID to be used for this connection 166 Exchange provided Box ID used for this connection Exchange provided Box ID used for this connection 170'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use 172 173'
  gateway_router_response_message:
    seq:
      - id: box_id
        type: s2
        doc: 'Exchange provided Box ID to be used for this connection 165 SECURE_BOX_REGISTRATION_RESPONSE Exchange provided Box ID to be used for this connection 166 Exchange provided Box ID used for this connection Exchange provided Box ID used for this connection 170'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
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
        doc: 'IP address assigned by exchange IP address assigned by exchange'
      - id: port
        type: s4
        doc: 'Port Number given by exchange Port Number given by exchange'
      - id: session_key
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session key received in GR_RESPONSE(2401) MS_BOX_SIGN_ON_REQUEST_OUT'
      - id: cryptographic_key
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cryptographic key for both the encryption and decryption of all messages between member application and allocated Gateway Server'
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
        pad-right: 0x20
        doc: 'Initialisation vector for encryption and decryption with the gateway'
  new_encryption_tail:
    seq:
      - id: static_cryptographic_iv
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Static half of the initialisation vector used by the new encryption'
      - id: dynamic_cryptographic_iv
        type: s8
        doc: 'Dynamic half of the initialisation vector used by the new encryption'
      - id: cryptographic_additional_key
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional key the new encryption authenticates with'
  control_message_to_trader_message:
    seq:
      - id: trader_id
        type: s4
        doc: 'This field should contain the user ID'
      - id: action_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the action code to indicate the action taken'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: msg_length
        type: s2
        doc: 'Msg Length'
      - id: msg
        type: str
        size: 240
        encoding: ASCII
        pad-right: 0x20
        doc: 'Msg'
  trade_confirmation_message:
    seq:
      - id: response_order_number
        type: floating_point_integer
        doc: 'Response Order Number'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: trader_num
        type: s4
        doc: 'This field contains the trader’s or user ID'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the Account Number or Client code'
      - id: buy_sell
        type: s2
        doc: 'This field should specify whether the order is a buy or sell'
      - id: original_vol
        type: s4
        doc: 'This field contains the Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'This field should specify the quantity that has to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'This field contains the volume remaining after trade(s)'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'This field contains the disclosed volume remaining from the original disclosed volume after trade(s)'
      - id: price
        type: decimal_s4_2
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Flags packed into 2 bytes'
      - id: gtd
        type: s4
        doc: 'This field contains the number of days for a GTD Order'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_qty
        type: s4
        doc: 'This field contains the traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-2'
      - id: vol_filled_today
        type: s4
        doc: 'This field contains the quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the activity type'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'This field contains the time when the activity took place. Seconds since Dos epoch'
      - id: op_order_number
        type: floating_point_integer
        doc: 'This field will always be blank'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field will always be blank'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'This field should contain the type of order'
      - id: new_volume
        type: s4
        doc: 'This field value should be same as that of FillQuantity'
      - id: pro_client
        type: s2
        doc: 'This field should contain one of the following values based on the order entering is on behalf of the broker or a trader'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number / PAN_EXEMPT) - This field shall be mandatory for all orders (client / participant / PRO orders)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'This field is reserved for future use'
      - id: last_activity_reference
        type: s8
        doc: 'This field should be set to zero while sending the order entry request'
      - id: reserved_52
        size: 52
        doc: 'Reserved for future use 172 173'
  st_order_flags:
    seq:
      - id: ato
        type: b1
        doc: 'At the open order'
      - id: mkt
        type: b1
        doc: 'Market order'
      - id: on_stop
        type: b1
        doc: 'Stop loss order'
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
      - id: preopen
        type: b1
        doc: 'Order belongs to the pre open session'
      - id: order_flags_reserved_three
        type: b1
        doc: 'Reserved'
      - id: stpc
        type: b1
        doc: 'Self trade prevention check'
      - id: order_flags_reserved_one
        type: b1
        doc: 'Reserved'
  order_entry_out_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Since only exchange can initiate the auction, this field should not be set to ‘I’ for initiator'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: mod_cxl_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field denotes which person has modified or cancelled a particular order'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use 172 173'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number is available when initiation of auction is broadcast (Auction Status Change Broadcast)'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field will always be blank'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field specifies whether the security is suspended or not'
      - id: order_number
        type: floating_point_integer
        doc: 'This field contains an Order Number assigned to the order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the trader account number should be specified in this field'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'This field should contain the type of order'
      - id: buy_sell
        type: s2
        doc: 'This field should specify whether the order is a buy or sell'
      - id: disclosed_vol
        type: s4
        doc: 'This field should specify the quantity that has to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'This field contains the disclosed volume remaining from the original disclosed volume after trade(s)'
      - id: total_vol_remaining
        type: s4
        doc: 'This field specifies the total quantity remaining from the original quantity after trade(s)'
      - id: volume
        type: s4
        doc: 'This field should specify the quantity of the order placed'
      - id: volume_filled_today
        type: s4
        doc: 'This field contains the total quantity traded in a day'
      - id: price
        type: decimal_s4_2
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-2'
      - id: good_till_date
        type: s4
        doc: 'This field should contain the number of days for a GTD order'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field should be set to zero while sending the order entry request. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Min Fill Aon'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'If the order has been modified, this field contains the time when the order was last modified. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Flags packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: oe_remarks
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field may contain any remarks that the dealer can enter about the order in this field'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        doc: 'This field should contain one of the following values based on the order entering is on behalf of the broker or a trader'
      - id: settlement_type
        type: s2
        doc: 'This field contains the settlement type'
      - id: nnf_field
        type: floating_point_integer
        doc: 'This field should contain a 15 digit a unique identifier for various products deployed as per Exchange circular download ref no'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'This field is used to store the time of writing to the order book'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use 172 173'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number / PAN_EXEMPT) - This field shall be mandatory for all orders (client / participant / PRO orders)'
      - id: algo_id
        type: s4
        doc: 'For Algo order this field shall contain the Algo ID issued by the exchange'
      - id: reserved_2
        size: 2
        doc: 'This field is reserved for future use'
      - id: last_activity_reference
        type: s8
        doc: 'This field should be set to zero while sending the order entry request'
      - id: reserved_52
        size: 52
        doc: 'Reserved for future use 172 173'
  order_entry_short_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Since only exchange can initiate the auction, this field should not be set to ‘I’ for initiator'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: mod_cxl_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field denotes which person has modified or cancelled a particular order'
      - id: filler_9
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: reason_code
        type: s2
        doc: 'This field contains the reason code for a particular order request rejection or order being frozen'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use 172 173'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: auction_number
        type: s2
        doc: 'Auction number is available when initiation of auction is broadcast (Auction Status Change Broadcast)'
      - id: op_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field will always be blank'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field specifies whether the security is suspended or not'
      - id: order_number
        type: floating_point_integer
        doc: 'This field contains an Order Number assigned to the order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the order is entered on behalf of a trader, the trader account number should be specified in this field'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'This field should contain the type of order'
      - id: buy_sell
        type: s2
        doc: 'This field should specify whether the order is a buy or sell'
      - id: disclosed_vol
        type: s4
        doc: 'This field should specify the quantity that has to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'This field contains the disclosed volume remaining from the original disclosed volume after trade(s)'
      - id: total_vol_remaining
        type: s4
        doc: 'This field specifies the total quantity remaining from the original quantity after trade(s)'
      - id: volume
        type: s4
        doc: 'This field should specify the quantity of the order placed'
      - id: volume_filled_today
        type: s4
        doc: 'This field contains the total quantity traded in a day'
      - id: price
        type: decimal_s4_2
        doc: 'This field should contain the price at which the order is placed. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'This field is applicable only for a Stop Loss order and should be a multiple of the tick size. Implied decimal with scale 1e-2'
      - id: good_till_date
        type: s4
        doc: 'This field should contain the number of days for a GTD order'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'This field should be set to zero while sending the order entry request. Seconds since Dos epoch'
      - id: min_fill_aon
        type: s4
        doc: 'Min Fill Aon'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'If the order has been modified, this field contains the time when the order was last modified. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Flags packed into 2 bytes'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: trader_id
        type: s4
        doc: 'This field should contain the user ID'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: oe_remarks
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field may contain any remarks that the dealer can enter about the order in this field'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the ID of the participants who are responsible for settling the trades through the custodians'
      - id: pro_client
        type: s2
        doc: 'This field should contain one of the following values based on the order entering is on behalf of the broker or a trader'
      - id: settlement_type
        type: s2
        doc: 'This field contains the settlement type'
      - id: nnf_field
        type: floating_point_integer
        doc: 'This field should contain a 15 digit a unique identifier for various products deployed as per Exchange circular download ref no'
      - id: exec_time_stamp
        type: floating_point_integer
        doc: 'This field is used to store the time of writing to the order book'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use 172 173'
  order_limit_update_out_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
      - id: order_qty_limit
        type: floating_point_integer
        doc: 'Order Qty Limit'
      - id: order_val_limit
        type: floating_point_integer
        doc: 'This field should contain Order Limit to be Set in lakhs Valid values: 0 to 9999999.99 This is to be multiplied by (100000*100) before sending to the trading system host 178'
      - id: reserved_2
        size: 2
        doc: 'This field is reserved for future use'
  password_reset_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
      - id: reserved_14
        size: 14
        doc: 'Reserved for future use 172 173'
  security_status_change_message:
    seq:
      - id: number_of_records
        type: s2
        doc: 'This field contains the number of markets for which Market Statistics is being sent'
      - id: token_and_eligibility
        type: token_and_eligibility
        repeat: expr
        repeat-expr: 25
        doc: 'TOKEN AND ELIGIBILITY'
  token_and_eligibility:
    seq:
      - id: token
        type: s4
        doc: 'This field contains the token number of the security being updated'
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
        doc: 'Status of the security in one market'
  security_master_change_message:
    seq:
      - id: token
        type: s4
        doc: 'This field contains the token number of the security being updated'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: instrument_type
        type: s2
        doc: 'This field contains the instrument type of the security'
      - id: permitted_to_trade
        type: s2
        doc: 'This field contains one of the following values: ‘0’ – Listed but not permitted to trade ‘1’ – Permitted to trade ‘2’ - BSE listed (BSE exclusive security will be available, however trading on the same will be allowed only in case of outage at BSE) • ‘0’ - Listed but not permitted to trade • ‘1’ - Permitted to trade • ‘2’ – BSE listed (BSE exclusive security will be available, however trading on the same will be allowed only in case of outage at BSE) This field can have any one of the following value: • ‘0’ - Listed but not permitted to trade 232'
      - id: issued_capital
        type: floating_point_integer
        doc: 'This field contains issue size of the security'
      - id: settlement_type
        type: s2
        doc: 'This field contains the settlement type'
      - id: freeze_percent
        type: s2
        doc: 'This field contains the volume freeze percent w.r.t'
      - id: credit_rating
        type: str
        size: 19
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains daily price range of the security'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: secuirity_eligibility_per_market
        type: secuirity_eligibility_per_market
        repeat: expr
        repeat-expr: 6
        doc: 'SECUIRITY ELIGIBILITY PER MARKET'
      - id: surv_ind
        type: s2
        doc: 'Indicator for security in Surveillance Measure Indicator for security in Surveillance Measure'
      - id: issue_start_date
        type: s4
        doc: 'This field contains the date of issue of the security'
      - id: interest_payment_date
        type: s4
        doc: 'This field contains the interest payment date of the issue'
      - id: issue_maturity_date
        type: s4
        doc: 'This field contains the maturity date'
      - id: board_lot_quantity
        type: s4
        doc: 'This field contains the board lot quantity'
      - id: tick_size
        type: s4
        doc: 'This field contains the Tick size'
      - id: name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the security name'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: listing_date
        type: s4
        doc: 'This field contains the date of listing'
      - id: expulsion_date
        type: s4
        doc: 'This field contains the date of expulsion'
      - id: re_admission_date
        type: s4
        doc: 'This field contains the date of readmission'
      - id: record_date
        type: s4
        doc: 'This field contains the date of record changed'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'This field contains the last date of trading before any corporate action. Seconds since Dos epoch'
      - id: no_delivery_start_date
        type: s4
        doc: 'This field contains the date from when physical delivery of share certificates is stopped for book closure'
      - id: no_delivery_end_date
        type: s4
        doc: 'This field contains the date from when physical delivery of share certificates starts after book closure'
      - id: eligiblity_indicators
        type: eligiblity_indicators
        doc: 'ELIGIBLITY INDICATORS'
      - id: book_closure_start_date
        type: s4
        doc: 'This field contains the date when the record books in the company for shareholder names starts'
      - id: book_closure_end_date
        type: s4
        doc: 'This field contains the date when the record books in the company for shareholder names ends'
      - id: purpose
        type: purpose
        doc: 'PURPOSE'
      - id: local_update_date_time
        type: s4
        doc: 'This field contains the local database update date and time'
      - id: delete_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains the status of the security, that is, whether the security is deleted or not'
      - id: remark
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field contains remarks'
      - id: face_value
        type: s4
        doc: 'This field contains face value of the security'
      - id: isin_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'I S I N Number'
      - id: mkt_maker_spread
        type: s4
        doc: 'This field contains spread value of the security, used by Market maker user to place two-way quotes'
      - id: mkt_maker_min_qty
        type: s4
        doc: 'This field contains the Minimum quantity for the security, Used by Market maker user for market maker order'
      - id: call_auction_1_flag
        type: s2
        doc: 'Call Auction1 Flag'
  secuirity_eligibility_per_market:
    seq:
      - id: security_eligibility_indicator
        type: security_eligibility_indicator
        doc: 'Flags packed into 1 byte'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: status
        type: s2
        enum: status
        doc: 'Status of the security in one market'
  security_eligibility_indicator:
    meta:
      bit-endian: le
    seq:
      - id: security_eligibility_reserved
        type: b7
        doc: 'Reserved'
      - id: eligibility
        type: b1
        doc: 'Security is eligible to trade in this market'
  eligiblity_indicators:
    seq:
      - id: eligiblity_indicator
        type: eligiblity_indicator
        doc: 'Flags packed into 1 byte'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
  eligiblity_indicator:
    meta:
      bit-endian: le
    seq:
      - id: eligibility_reserved
        type: b5
        doc: 'Reserved'
      - id: minimum_fill
        type: b1
        doc: 'Security is eligible for minimum fill orders'
      - id: aon
        type: b1
        doc: 'All or none order'
      - id: participate_in_market_index
        type: b1
        doc: 'Security participates in the market index'
  purpose:
    seq:
      - id: purpose_indicator
        type: purpose_indicator
        doc: 'Flags packed into 1 byte'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
  purpose_indicator:
    meta:
      bit-endian: le
    seq:
      - id: purpose_reserved
        type: b2
        doc: 'Reserved'
      - id: egm
        type: b1
        doc: 'Extraordinary general meeting'
      - id: agm
        type: b1
        doc: 'Annual general meeting'
      - id: interest
        type: b1
        doc: 'Interest'
      - id: bonus
        type: b1
        doc: 'Bonus'
      - id: rights
        type: b1
        doc: 'Rights'
      - id: dividend
        type: b1
        doc: 'Dividend'
  sign_on_request_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use 172 173'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the password entered by the user'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use 172 173'
      - id: new_password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the new password entered by the user'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field when received from the host contains the user’s name'
      - id: last_password_change_date_time
        type: dos_second_timestamp
        doc: 'Last Password Change Date Time. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: version_number
        type: s4
        doc: 'This field should contain the version number of the trading system'
      - id: reserved_56
        size: 56
        doc: 'Reserved for future use 172 173'
      - id: user_type
        type: s2
        doc: 'This field indicates the type of user'
      - id: sequence_number
        type: floating_point_integer
        doc: 'This field should be set to numerical zero while sending the request to host'
      - id: workstation_number
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Workstation Number'
      - id: broker_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: show_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '‘T’ = to use Trimmed-NNF protocol with Total Traded Quantity and Value Data Type Change Note: Only Trimmed-NNF protocol is supported by Direct Interface 167 HEARTBEAT'
      - id: broker_eligibility_per_market
        type: broker_eligibility_per_market
        doc: 'Flags packed into 2 bytes'
      - id: broker_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank This field contains the broker’s name (trading member name)'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use 172 173'
      - id: second_reserved_16
        size: 16
        doc: 'Reserved for future use 172 173'
      - id: third_reserved_16
        size: 16
        doc: 'Reserved for future use 172 173'
  broker_eligibility_per_market:
    seq:
      - id: normal_market
        type: b1
        doc: 'Broker is eligible to trade in the normal market'
      - id: oddlot_market
        type: b1
        doc: 'Broker is eligible to trade in the odd lot market'
      - id: spot_market
        type: b1
        doc: 'Broker is eligible to trade in the spot market'
      - id: auction_market
        type: b1
        doc: 'Broker is eligible to trade in the auction market'
      - id: call_auction_11
        type: b1
        doc: 'Broker is eligible to trade in the first call auction market'
      - id: call_auction_21
        type: b1
        doc: 'Broker is eligible to trade in the second call auction market'
      - id: broker_eligibility_reserved_lower
        type: b2
        doc: 'Reserved'
      - id: broker_eligibility_reserved_upper
        type: b7
        doc: 'Reserved'
      - id: preopen
        type: b1
        doc: 'Order belongs to the pre open session'
  sign_on_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use 172 173'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the password entered by the user'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use 172 173'
      - id: new_password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the new password entered by the user'
      - id: trader_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field when received from the host contains the user’s name'
      - id: last_password_change_date
        type: dos_second_timestamp
        doc: 'Last Password Change Date. Seconds since Dos epoch'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: branch_id
        type: s2
        doc: 'This field should contain the Branch ID to which the broker belongs'
      - id: version_number
        type: s4
        doc: 'This field should contain the version number of the trading system'
      - id: end_time
        type: dos_second_timestamp
        doc: 'This field contains the time the markets last closed and is sent as the number of seconds since midnight of January 1, 1980. Seconds since Dos epoch'
      - id: reserved_52
        size: 52
        doc: 'Reserved for future use 172 173'
      - id: user_type
        type: s2
        doc: 'This field indicates the type of user'
      - id: sequence_number
        type: floating_point_integer
        doc: 'This field should be set to numerical zero while sending the request to host'
      - id: reserved_14
        size: 14
        doc: 'Reserved for future use 172 173'
      - id: broker_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: broker_eligibility_per_market
        type: broker_eligibility_per_market
        doc: 'Flags packed into 2 bytes'
      - id: broker_name
        type: str
        size: 26
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should be set to blank This field contains the broker’s name (trading member name)'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use 172 173'
      - id: second_reserved_16
        size: 16
        doc: 'Reserved for future use 172 173'
      - id: third_reserved_16
        size: 16
        doc: 'Reserved for future use 172 173'
  system_information_message:
    seq:
      - id: normal
        type: s2
        doc: 'Normal'
      - id: oddlot
        type: s2
        doc: 'Oddlot'
      - id: spot
        type: s2
        doc: 'Spot'
      - id: auction
        type: s2
        doc: 'Market ATO output, set if Market order, value of order price returned is ‘0’'
      - id: call_auction_1_short_2
        type: s2
        doc: '11 Call auction1 market 219'
      - id: call_auction_2_short_2
        type: s2
        doc: '12 Call auction2 market'
      - id: market_index
        type: s4
        doc: 'This field contains the current market index'
      - id: default_settlement_period
        type: s2
        doc: 'Default Settlement Period'
      - id: second_default_settlement_period
        type: s2
        doc: 'Default Settlement Period'
      - id: third_default_settlement_period
        type: s2
        doc: 'Default Settlement Period'
      - id: competitor_period
        type: s2
        doc: 'This field contains the default competitor period for auction'
      - id: solicitor_period
        type: s2
        doc: 'This field contains the default solicitor period for auction'
      - id: warning_percent
        type: s2
        doc: 'This field contains the warning percentage'
      - id: volume_freeze_percent
        type: s2
        doc: 'This field contains the volume freeze percentage'
      - id: reserved_2
        size: 2
        doc: 'This field is reserved for future use'
      - id: terminal_idle_time
        type: s2
        doc: 'This field contains the idle time of the TWS terminal'
      - id: board_lot_quantity
        type: s4
        doc: 'This field contains the board lot quantity'
      - id: tick_size
        type: s4
        doc: 'This field contains the Tick size'
      - id: maximum_gtc_days
        type: s2
        doc: 'Maximum Gtc Days'
      - id: security_eligible_indicators
        type: security_eligible_indicators
        doc: 'SECURITY ELIGIBLE INDICATORS'
      - id: disclosed_quantity_percent_allowed
        type: s2
        doc: 'Disclosed Quantity Percent Allowed'
      - id: reserved_6
        size: 6
        doc: 'Reserved for future use 172 173'
  security_eligible_indicators:
    seq:
      - id: security_eligible_indicator
        type: security_eligible_indicator
        doc: 'Flags packed into 1 byte'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
  security_eligible_indicator:
    meta:
      bit-endian: le
    seq:
      - id: security_eligible_reserved
        type: b5
        doc: 'Reserved'
      - id: books_merged
        type: b1
        doc: 'Books of the security are merged'
      - id: minimum_fill
        type: b1
        doc: 'Security is eligible for minimum fill orders'
      - id: aon
        type: b1
        doc: 'All or none order'
  trade_inquiry_out_message:
    seq:
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: fill_number
        type: s4
        doc: 'This field should contain the trade number of the trade to be modified'
      - id: fill_qty
        type: s4
        doc: 'This field contains the traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'This field should contain the price at which the trade took place. Implied decimal with scale 1e-2'
      - id: market_type
        type: s2
        enum: market_type
        doc: 'This field should contain the value to denote the type of market, • ‘1’ for Normal Market'
      - id: new_volume
        type: s4
        doc: 'This field value should be same as that of FillQuantity'
      - id: reserved_24
        size: 24
        doc: 'Reserved for future use 172 173'
      - id: buy_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Buy Broker Id'
      - id: sell_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sell Broker Id'
      - id: trader_id
        type: s4
        doc: 'This field should contain the user ID'
      - id: requested_by
        type: s2
        doc: 'This field indicates which side (Buy/Sell) of the trade is to be modified/cancelled'
      - id: buy_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the Account Number of the trade on Buy side'
      - id: sell_account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the Account Number of the trade on Sell side'
      - id: buy_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: sell_pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field shall contain the PAN (Permanent Account Number/PAN_EXEMPT)'
      - id: reserved_60
        size: 60
        doc: 'Reserved for future use 172 173'
  update_local_database_header_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'This field is reserved for future use'
  update_local_database_trailer_message:
    seq:
      - id: reserved_2
        size: 2
        doc: 'This field is reserved for future use'
  user_unlock_approval_rejection_message:
    seq:
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
  user_unlock_requested_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
  user_order_value_limit_update_out_message:
    seq:
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain the trading member ID'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
      - id: branch
        type: s2
        doc: 'This field should contain the branch number for which limit to be set This field should contain the branch number of user for which limit to be set 7'
      - id: reserved_26
        size: 26
        doc: 'Reserved for future use 172 173'
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
      - id: user_limits
        type: user_limits
        doc: 'USER_LIMITS'
  user_limits:
    seq:
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use 172 173'
      - id: user_order_buy_value_limit
        type: floating_point_integer
        doc: 'Buy value limit set for the user'
      - id: reserved_24
        size: 24
        doc: 'Reserved for future use 172 173'
      - id: user_order_sell_value_limit
        type: floating_point_integer
        doc: 'Sell value limit set for the user'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use 172 173'
  trade_modification_cancellation_status_response_message:
    seq:
      - id: user_id
        type: s4
        doc: 'This field should contain User ID of user/broker'
      - id: trd_mod_cxl_bit
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain user’s Trade Cancellation Status to be set'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use 172 173'
  update_local_database_data_message:
    seq:
      - id: inner_header
        type: inner_header
        doc: 'Forty byte header prefacing each downloaded record'
      - id: local_database_data
        type: local_database_data
        size: _parent.message_header.message_length
        doc: 'Record body selected by Inner Transaction Code'
  inner_header:
    seq:
      - id: inner_trader_id
        type: s4
        doc: 'User Id'
      - id: inner_log_time
        type: dos_second_timestamp
        doc: 'Time the message was logged. Seconds since Dos epoch'
      - id: inner_alpha_char
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'First two characters of Symbol when the record carries one'
      - id: inner_transaction_code
        type: s2
        doc: 'Transaction code naming the record carried'
      - id: inner_error_code
        type: s2
        doc: 'Type of error'
      - id: inner_timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time stamped at the trading system. Nanoseconds since Dos epoch'
      - id: inner_time_stamp_1
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the message arrives at the trading system host'
      - id: inner_time_stamp_2
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for the host'
      - id: inner_message_length
        type: s2
        doc: 'Length of the record including this header'
  local_database_data:
    seq:
      - id: data_payload
        size-eos: true
        doc: 'Record body, opaque until the master change structures are transcribed'
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
    18017:
      id: 'auction_inquiry_response_message'
      doc: 'Sent as AUCTION_INQUIRY_OUT'
    5717:
      id: 'branch_order_value_limit_update_out_message'
      doc: 'Sent as BRANCH_ORDER_LIMIT_UPDATE_OUT'
    5716:
      id: 'branch_order_value_limit_update_in_message'
      doc: 'Sent as BRANCH_ORDER_LIMIT_UPDATE_IN'
    5790:
      id: 'cancel_on_logout_status_request_message'
      doc: 'Sent as COL_USER_STATUS_CHANGE _IN'
    5791:
      id: 'cancel_on_logout_status_response_message'
      doc: 'Sent as COL_USER_STATUS_CHANGE _OUT'
    2302:
      id: 'error_response_message'
      doc: 'Sent as ERROR_RESPONSE_OUT'
    7000:
      id: 'message_download_request_message'
      doc: 'Sent as DOWNLOAD_REQUEST'
    23008:
      id: 'secure_box_registration_request_message'
      doc: 'Sent as SECURE_BOX_REGISTRATION_REQUE'
    18016:
      id: 'auction_inquiry_request_message'
      doc: 'Sent as AUCTION_INQUIRY_IN'
    20322:
      id: 'box_sign_off_message'
      doc: 'Sent as BOX_SIGN_OFF'
    23000:
      id: 'box_sign_on_request_message'
      doc: 'Sent as BOX_SIGN_ON_REQUEST_IN'
    23001:
      id: 'box_sign_on_response_message'
      doc: 'Sent as BOX_SIGN_ON_REQUEST_OUT'
    2400:
      id: 'gateway_router_request_message'
      doc: 'Sent as GR_REQUEST'
    2401:
      id: 'gateway_router_response_message'
      doc: 'Sent as GR_RESPONSE'
    5295:
      id: 'control_message_to_trader_message'
      doc: 'Sent as CTRL_MSG_TO_TRADER'
    2212:
      id: 'trade_confirmation_message'
      doc: 'Sent as ON_STOP_NOTIFICATION, TRADE_CONFIRMATION, TRADE_CANCEL_CONFIRM, TRADE_CANCEL_REJECT, and others'
    2222:
      id: 'trade_confirmation_message_2222'
      doc: 'Sent as ON_STOP_NOTIFICATION, TRADE_CONFIRMATION, TRADE_CANCEL_CONFIRM, TRADE_CANCEL_REJECT, and others'
    2282:
      id: 'trade_confirmation_message_2282'
      doc: 'Sent as ON_STOP_NOTIFICATION, TRADE_CONFIRMATION, TRADE_CANCEL_CONFIRM, TRADE_CANCEL_REJECT, and others'
    2286:
      id: 'trade_confirmation_message_2286'
      doc: 'Sent as ON_STOP_NOTIFICATION, TRADE_CONFIRMATION, TRADE_CANCEL_CONFIRM, TRADE_CANCEL_REJECT, and others'
    2287:
      id: 'trade_confirmation_message_2287'
      doc: 'Sent as ON_STOP_NOTIFICATION, TRADE_CONFIRMATION, TRADE_CANCEL_CONFIRM, TRADE_CANCEL_REJECT, and others'
    2012:
      id: 'order_entry_out_message'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2042:
      id: 'order_entry_out_message_2042'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2061:
      id: 'order_entry_out_message_2061'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2072:
      id: 'order_entry_out_message_2072'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2073:
      id: 'order_entry_out_message_2073'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2074:
      id: 'order_entry_out_message_2074'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2075:
      id: 'order_entry_out_message_2075'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2170:
      id: 'order_entry_out_message_2170'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2231:
      id: 'order_entry_out_message_2231'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    9002:
      id: 'order_entry_out_message_9002'
      doc: 'Sent as PRICE_CONFIRMATION, ORDER_MOD_REJECT, QUICK_CANCEL_OUT, ORDER_CANCEL_REJECT, and others'
    2001:
      id: 'order_entry_short_message'
      doc: 'Sent as BOARD_LOT_OUT, ORDER_CANCEL_OUT'
    2071:
      id: 'order_entry_short_message_2071'
      doc: 'Sent as BOARD_LOT_OUT, ORDER_CANCEL_OUT'
    2000:
      id: 'order_entry_in_message'
      doc: 'Sent as BOARD_LOT_IN, ORDER_MOD_IN, KILL_SWITCH_IN, ORDER_CANCEL_IN'
    2040:
      id: 'order_entry_in_message_2040'
      doc: 'Sent as BOARD_LOT_IN, ORDER_MOD_IN, KILL_SWITCH_IN, ORDER_CANCEL_IN'
    2062:
      id: 'order_entry_in_message_2062'
      doc: 'Sent as BOARD_LOT_IN, ORDER_MOD_IN, KILL_SWITCH_IN, ORDER_CANCEL_IN'
    2070:
      id: 'order_entry_in_message_2070'
      doc: 'Sent as BOARD_LOT_IN, ORDER_MOD_IN, KILL_SWITCH_IN, ORDER_CANCEL_IN'
    5722:
      id: 'order_limit_update_out_message'
      doc: 'Sent as DEALER_LIMIT_UPDATE_OUT'
    5721:
      id: 'order_limit_update_in_message'
      doc: 'Sent as DEALER_LIMIT_UPDATE_IN'
    5739:
      id: 'password_reset_out_message'
      doc: 'Sent as RESET_PASSWORD_OUT'
    5738:
      id: 'password_reset_in_message'
      doc: 'Sent as RESET_PASSWORD_IN'
    18130:
      id: 'security_status_change_message'
      doc: 'Sent as BCAST_SECURITY_STATUS_CHG, BCAST_SECURITY_STATUS_CHG_PREO'
    18707:
      id: 'security_status_change_message_18707'
      doc: 'Sent as BCAST_SECURITY_STATUS_CHG, BCAST_SECURITY_STATUS_CHG_PREO'
    18720:
      id: 'security_master_change_message'
      doc: 'Sent as BCAST_SECURITY_MSTR_CHG'
    5724:
      id: 'sign_on_request_out_message'
      doc: 'Sent as SIGN_OFF_TRADER_OUT'
    2300:
      id: 'sign_on_request_in_message'
      doc: 'Sent as SIGN_ON_REQUEST_IN, SIGN_OFF_TRADER_IN'
    5723:
      id: 'sign_on_request_in_message_5723'
      doc: 'Sent as SIGN_ON_REQUEST_IN, SIGN_OFF_TRADER_IN'
    2301:
      id: 'sign_on_response_message'
      doc: 'Sent as SIGN_ON_REQUEST_OUT'
    1601:
      id: 'system_information_message'
      doc: 'Sent as SYSTEM_INFORMATION_OUT, PARTIAL_SYSTEM_INFORMATION'
    7321:
      id: 'system_information_message_7321'
      doc: 'Sent as SYSTEM_INFORMATION_OUT, PARTIAL_SYSTEM_INFORMATION'
    2223:
      id: 'trade_inquiry_out_message'
      doc: 'Sent as TRADE_ERROR, TRADE_CANCEL_OUT'
    5441:
      id: 'trade_inquiry_out_message_5441'
      doc: 'Sent as TRADE_ERROR, TRADE_CANCEL_OUT'
    5440:
      id: 'trade_inquiry_in_message'
      doc: 'Sent as TRADE_CANCEL_IN, TRADE_MOD_IN'
    5445:
      id: 'trade_inquiry_in_message_5445'
      doc: 'Sent as TRADE_CANCEL_IN, TRADE_MOD_IN'
    7307:
      id: 'update_local_database_header_message'
      doc: 'Sent as UPDATE_LOCALDB_HEADER'
    7308:
      id: 'update_local_database_trailer_message'
      doc: 'Sent as UPDATE_LOCALDB_TRAILER'
    7300:
      id: 'update_local_database_request_message'
      doc: 'Sent as UPDATE_LOCALDB_IN'
    5792:
      id: 'trade_modification_cancellation_status_request_message'
      doc: 'Sent as TRD_MOD_CXL_STATUS_CHANGE _IN'
    5575:
      id: 'user_unlock_approval_rejection_message'
      doc: 'Sent as USER_ADDR_UNLOCK_APPROVE_OUT, USER_ADDR_UNLOCK_REJECT_OUT'
    5579:
      id: 'user_unlock_approval_rejection_message_5579'
      doc: 'Sent as USER_ADDR_UNLOCK_APPROVE_OUT, USER_ADDR_UNLOCK_REJECT_OUT'
    5424:
      id: 'user_unlock_request_message'
      doc: 'Sent as USER_ADDR_UNLOCK_IN'
    5425:
      id: 'user_unlock_requested_response_message'
      doc: 'Sent as USER_ADDR_UNLOCK_OUT'
    5720:
      id: 'user_order_value_limit_update_out_message'
      doc: 'Sent as USER_ORDER_LIMIT_UPDATE_OUT'
    5719:
      id: 'user_order_value_limit_update_in_message'
      doc: 'Sent as USER_ORDER_LIMIT_UPDATE_IN'
    5793:
      id: 'trade_modification_cancellation_status_response_message'
      doc: 'Sent as TRD_MOD_CXL_STATUS_CHANGE _OUT'
    2321:
      id: 'sign_off_confirmation_message'
      doc: 'Carries the message header and no body: SIGN_OFF_REQUEST_OUT'
    7011:
      id: 'header_record_message'
      doc: 'Carries the message header and no body: HEADER_RECORD'
    7021:
      id: 'message_record_message'
      doc: 'Carries the message header and no body: MESSAGE_RECORD'
    7031:
      id: 'trailer_record_message'
      doc: 'Carries the message header and no body: TRAILER_RECORD'
    1600:
      id: 'system_information_request_message'
      doc: 'Carries the message header and no body: SYSTEM_INFORMATION_IN'
    23009:
      id: 'secure_box_registration_response_message'
      doc: 'Carries the message header and no body: SECURE_BOX_REGISTRATION_RESPO'
    7304:
      id: 'update_local_database_data_message'
      doc: 'Carries one local database record wrapped in an inner header'
  book_type:
    1:
      id: 'regular_lot_order'
      doc: 'Regular Lot Order, in the Normal Market'
    2:
      id: 'special_terms_order'
      doc: 'Special Terms Order, in the Normal Market'
    3:
      id: 'stop_loss_order'
      doc: 'Stop Loss Order, in the Normal Market'
    5:
      id: 'odd_lot_order'
      doc: 'Odd Lot Order, in the Odd Lot Market'
    6:
      id: 'spot_order'
      doc: 'Spot Order, in the Spot Market'
    7:
      id: 'auction_order'
      doc: 'Auction Order, in the Auction Market'
    11:
      id: 'call_auction_1'
      doc: 'Call Auction1, in the first call auction market'
    12:
      id: 'call_auction_2'
      doc: 'Call Auction2, in the second call auction market'
  market_type:
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
    5:
      id: 'call_auction_1_market'
      doc: 'Call auction1 Market'
    6:
      id: 'call_auction_2_market'
      doc: 'Call auction2 Market'
  auction_status:
    1:
      id: 'auction_pending_approval'
      doc: 'The auction was initiated by a trader and is pending approval'
    2:
      id: 'auction_pending'
      doc: 'An auction in the security is already going on, so this one is pending'
    3:
      id: 'open_competitor_period'
      doc: 'The auction has been initiated'
    4:
      id: 'open_solicitor_period'
      doc: 'The auction has entered its solicitor period'
    5:
      id: 'auction_matching'
      doc: 'The solicitor period has ended and auction orders are matching'
    6:
      id: 'auction_finished'
      doc: 'Matching is done and auction trades are generated'
    7:
      id: 'auction_cancelled'
      doc: 'The auction was cancelled by Nse Control'
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

