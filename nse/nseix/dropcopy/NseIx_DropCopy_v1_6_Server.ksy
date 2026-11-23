# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseIx DropCopy NnfDirect v1.6
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Drop Copy
#   Encoding: Non-Neat Front End Direct Interface
#   Version: 1.6
#   Date: 10/1/2025
#   Specification: NSEIFSC_DROP_COPY_PROTOCOL_v1_6_20260324141958.pdf
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
  id: nse_nseix_dropcopy_nnfdirect_v1_6_server
  title: Nse NseIx DropCopy NnfDirect v1.6
  license: MIT-0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE International Exchange Drop Copy NnfDirect v1.6'
doc-ref: https://www.nseix.com/technology/tradingprotocol

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
          switch-on: peek_transaction_code.to_i.as<s4>
          cases:
            23009: server_registration_packet
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
        doc: 'Starts at 1 on a fresh connection and is incremented for every packet, in sequential order'
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
            'transaction_code::sign_on_out_message': sign_on_out_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::trade_modify_confirm_message': trade_modify_confirm_message
            'transaction_code::trade_modify_reject_message': trade_modify_reject_message
            'transaction_code::trade_cancel_confirm_message': trade_cancel_confirm_message
            'transaction_code::trade_cancel_reject_message': trade_cancel_reject_message
            'transaction_code::nlt_trade_confirmation_message': nlt_trade_confirmation_message
            'transaction_code::nlt_trd_mod_confirmation_message': nlt_trd_mod_confirmation_message
            'transaction_code::nlt_trd_mod_reject_message': nlt_trd_mod_reject_message
            'transaction_code::nlt_trd_cxl_confirmation_message': nlt_trd_cxl_confirmation_message
            'transaction_code::nlt_trd_cxl_reject_message': nlt_trd_cxl_reject_message
            'transaction_code::giveup_app_confirm_tm_message': giveup_app_confirm_tm_message
            'transaction_code::giveup_rej_confirm_tm_message': giveup_rej_confirm_tm_message
            'transaction_code::board_lot_out_message': board_lot_out_message
            'transaction_code::order_mod_out_message': order_mod_out_message
            'transaction_code::order_mod_reject_message': order_mod_reject_message
            'transaction_code::order_cancel_out_message': order_cancel_out_message
            'transaction_code::order_cancel_reject_message': order_cancel_reject_message
            'transaction_code::order_confirmation_message': order_confirmation_message
            'transaction_code::order_mod_confirmation_message': order_mod_confirmation_message
            'transaction_code::order_cancel_confirmation_message': order_cancel_confirmation_message
            'transaction_code::freeze_to_control_message': freeze_to_control_message
            'transaction_code::order_error_message': order_error_message
            'transaction_code::batch_order_cancel_message': batch_order_cancel_message
            'transaction_code::net_order_error_message': net_order_error_message
            'transaction_code::nlt_confirmation_message': nlt_confirmation_message
            'transaction_code::nlt_mod_confirmation_message': nlt_mod_confirmation_message
            'transaction_code::nlt_cxl_confirmation_message': nlt_cxl_confirmation_message
            'transaction_code::nlt_mod_reject_message': nlt_mod_reject_message
            'transaction_code::nlt_cxl_reject_message': nlt_cxl_reject_message
            'transaction_code::spread_order_confirmation_message': spread_order_confirmation_message
            'transaction_code::sp_order_error_message': sp_order_error_message
            'transaction_code::sp_net_order_error_message': sp_net_order_error_message
            'transaction_code::spread_cxl_confirmation_message': spread_cxl_confirmation_message
            'transaction_code::spread_mod_confirmation_message': spread_mod_confirmation_message
            'transaction_code::spread_mod_reject_message': spread_mod_reject_message
            'transaction_code::spread_cxl_reject_message': spread_cxl_reject_message
            'transaction_code::batch_spread_order_cancel_message': batch_spread_order_cancel_message
            'transaction_code::twol_order_confirmation_message': twol_order_confirmation_message
            'transaction_code::thrl_order_confirmation_message': thrl_order_confirmation_message
            'transaction_code::twol_order_error_message': twol_order_error_message
            'transaction_code::thrl_order_error_message': thrl_order_error_message
            'transaction_code::twol_net_order_error_message': twol_net_order_error_message
            'transaction_code::thrl_net_order_error_message': thrl_net_order_error_message
            'transaction_code::twol_order_cxl_confirmation_message': twol_order_cxl_confirmation_message
            'transaction_code::thrl_order_cxl_confirmation_message': thrl_order_cxl_confirmation_message
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
        type: str_2_nullable
        doc: 'First two characters of Symbol when the message carries one. Nullable, No Value ='
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'Stream number the packet comes from; zero when sent to the host. Nullable, No Value = 00000000'
      - id: message_length
        type: s2
        doc: 'Length of the message including the message header, twenty two less than Packet Length'
  sign_on_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'User Id of the user'
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password entered by the user; alphabet, numbers and special characters are allowed'
      - id: reserved_8
        size: 8
        doc: 'Reserved'
      - id: reserved_30
        size: 30
        doc: 'Reserved'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: reserved_119
        size: 119
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  st_order_flags:
    seq:
      - id: ato
        type: b1
        doc: 'Market order in preopen'
      - id: market
        type: b1
        doc: 'Market order'
      - id: sl
        type: b1
        doc: 'Stop loss'
      - id: mit
        type: b1
        doc: 'Market if touched'
      - id: day
        type: b1
        doc: 'Day order, the default attribute'
      - id: gtc
        type: b1
        doc: 'Good till cancel'
      - id: ioc
        type: b1
        doc: 'Immediate or cancel'
      - id: aon
        type: b1
        doc: 'All or none'
      - id: mf
        type: b1
        doc: 'Minimum fill'
      - id: matched_ind
        type: b1
        doc: 'A negotiated trade order has found a matching order'
      - id: traded
        type: b1
        doc: 'The order has traded partially or fully'
      - id: modified
        type: b1
        doc: 'The order has to be modified'
      - id: frozen
        type: b1
        doc: 'The order has gone for a freeze'
      - id: nlt_indc
        type: b1
        doc: 'The order is an NLT order'
      - id: preclose
        type: b1
        doc: 'Order entered or modified in the preclose session; zero for orders entered in other sessions'
      - id: preopen
        type: b1
        doc: 'Order entered in the preopen session, or a preopen order modification response; zero for orders entered in other sessions'
  contract_desc:
    seq:
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument name of the contract'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contract name'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Expiry date of the contract. Seconds since Dos epoch'
      - id: strike_price
        type: s4_nullable
        doc: 'Valid strike for an options contract, and -1 for a futures contract. Nullable, Futures Contract = -1'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type identifier'
      - id: ca_level
        type: s2
        doc: 'Corporate action level, which should be zero'
  additional_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: additional_order_flags_reserved_1
        type: b1
        doc: 'Reserved'
      - id: col
        type: b1
        doc: 'Cancel on logoff'
      - id: additional_order_flags_reserved_3
        type: b1
        doc: 'Reserved'
      - id: additional_order_flags_reserved_4
        type: b1
        doc: 'Reserved'
      - id: stpc
        type: b1
        doc: 'Self trade prevention: zero cancels the order resulting in a self trade as per the exchange''s default action, one cancels the active order resulting in the self trade'
      - id: session_ind
        type: b1
        doc: 'Zero for a session 1 trade, one for a session 2 trade'
      - id: additional_order_flags_reserved_78
        type: b2
        doc: 'Reserved'
  trade_modify_confirm_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  trade_modify_reject_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  trade_cancel_confirm_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  trade_cancel_reject_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  nlt_trade_confirmation_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  nlt_trd_mod_confirmation_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  nlt_trd_mod_reject_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  nlt_trd_cxl_confirmation_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  nlt_trd_cxl_reject_message:
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
      - id: trader_num
        type: s4
        doc: 'Trader or user Id'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number or client code'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_vol
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Volume remaining after the trades'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trades'
      - id: price
        type: s4
        doc: 'Order price'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: gtd
        type: s4
        doc: 'Number of days for a GTD order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity traded today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of activity being confirmed'
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
        doc: 'Trading member Id of the counter party taking part in the trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Previous open or close indicator, the same as Open Close for a trade confirmation'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved'
      - id: new_volume
        type: s4
        doc: 'Always zero for a trade confirmation; the modified trade quantity on a trade modification approval'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: old_participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Old participant name when an order modification changes the participant'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: give_up_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the trade is a give up'
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
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: reserved_60
        size: 60
        doc: 'Reserved'
  giveup_app_confirm_tm_message:
    seq:
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for the give up packet'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument name of the contract'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contract name'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Expiry date of the contract. Seconds since Dos epoch'
      - id: strike_price
        type: s4_nullable
        doc: 'Valid strike for an options contract, and -1 for a futures contract. Nullable, Futures Contract = -1'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type identifier'
      - id: ca_level
        type: s2
        doc: 'Corporate action level, which should be zero'
      - id: fill_volume
        type: s4
        doc: 'Quantity of the contract traded'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
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
        doc: 'Whether the order taking part is a buy or a sell'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: last_modified_date_time
        type: dos_second_timestamp
        doc: 'Time of the last activity on the order, which could be order entry, order modification or the last trade, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: initiated_by_control
        type: u1
        enum: initiated_by_control
        doc: 'Y or N, whether the approval was initiated by Control; the host sends N'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: deleted
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The host sends N'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  giveup_rej_confirm_tm_message:
    seq:
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason code for the give up packet'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: instrument_name
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument name of the contract'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contract name'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Expiry date of the contract. Seconds since Dos epoch'
      - id: strike_price
        type: s4_nullable
        doc: 'Valid strike for an options contract, and -1 for a futures contract. Nullable, Futures Contract = -1'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option type identifier'
      - id: ca_level
        type: s2
        doc: 'Corporate action level, which should be zero'
      - id: fill_volume
        type: s4
        doc: 'Quantity of the contract traded'
      - id: fill_price
        type: s4
        doc: 'Price at which the order traded, to be divided by 10000 for a contract traded in USD or by 100 for a contract traded in cents to get the actual price'
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
        doc: 'Whether the order taking part is a buy or a sell'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: last_modified_date_time
        type: dos_second_timestamp
        doc: 'Time of the last activity on the order, which could be order entry, order modification or the last trade, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: initiated_by_control
        type: u1
        enum: initiated_by_control
        doc: 'Y or N, whether the approval was initiated by Control; the host sends N'
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
        doc: 'Participant name, the same as Old Participant for a trade confirmation'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: deleted
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The host sends N'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  board_lot_out_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_mod_out_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_mod_reject_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_cancel_out_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_cancel_reject_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_mod_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_cancel_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  freeze_to_control_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  order_error_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  batch_order_cancel_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  net_order_error_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  nlt_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  nlt_mod_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  nlt_cxl_confirmation_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  nlt_mod_reject_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  nlt_cxl_reject_message:
    seq:
      - id: participant_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not applicable for regular lot orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: competitor_period
        type: s2
        doc: 'Always zero'
      - id: solicitor_period
        type: s2
        doc: 'Always zero'
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
        doc: 'Reason code for the give up packet'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: counter_party_broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counter party broker code for a negotiated trade order'
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
        doc: 'Set to blank'
      - id: fourth_reserved_1
        size: 1
        doc: 'Reserved'
      - id: order_type
        type: s2
        doc: 'Set to blank'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the approved individual order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        enum: buy_sell_indicator
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed volume remaining from the original disclosed volume after trades'
      - id: total_volume_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Order quantity'
      - id: volume_filled_today
        type: s4
        doc: 'Total quantity traded in the day'
      - id: price
        type: s4
        doc: 'Order price'
      - id: trigger_price
        type: s4
        doc: 'Trigger price, applicable only for a stop loss order'
      - id: good_till_date
        type: dos_second_timestamp
        doc: 'Date until which the GTD order is retained in the system. Seconds since Dos epoch'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Date and time the order entered the system. Seconds since Dos epoch'
      - id: minimum_fill_aon_volume
        type: s4
        doc: 'Minimum fill quantity when the minimum fill attribute is set for the order'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Entry date time on an order entry, then the time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
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
        doc: 'cOrdFiller'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the trade opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians'
      - id: pro_client_indicator
        type: s2
        enum: pro_client_indicator
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Give up flag, A when the give up is approved'
      - id: reference
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: mkt_replay
        type: floating_point_integer
        doc: 'Set to zero'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  spread_order_confirmation_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  ms_spd_leg_info_leg_2:
    seq:
      - id: token_2
        type: s4
        doc: 'Token number of the leg''s contract, or -1 when only the contract descriptor is validated; not the same as Token1'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_2
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: fillerx_2
        size: 1
        doc: 'Filler'
      - id: order_type_2
        type: s2
        doc: 'Not used'
      - id: buy_sell_2
        type: s2
        enum: buy_sell_2
        doc: 'Whether the leg is a buy or a sell'
      - id: disclosed_vol_2
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_2
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_2
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_2
        type: s4
        doc: 'Quantity of the leg, in multiples of the regular lot'
      - id: volume_filled_today_2
        type: s4
        doc: 'Not used'
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
        doc: 'Attributes of the order'
      - id: open_close_2
        type: u1
        enum: open_close_2
        doc: 'Open or close order indicator'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_y
        size: 1
        doc: 'Filler'
  ms_spd_leg_info_leg_3:
    seq:
      - id: token_2
        type: s4
        doc: 'Token number of the leg''s contract, or -1 when only the contract descriptor is validated; not the same as Token1'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_2
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: fillerx_2
        size: 1
        doc: 'Filler'
      - id: order_type_2
        type: s2
        doc: 'Not used'
      - id: buy_sell_2
        type: s2
        enum: buy_sell_2
        doc: 'Whether the leg is a buy or a sell'
      - id: disclosed_vol_2
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_2
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_2
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_2
        type: s4
        doc: 'Quantity of the leg, in multiples of the regular lot'
      - id: volume_filled_today_2
        type: s4
        doc: 'Not used'
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
        doc: 'Attributes of the order'
      - id: open_close_2
        type: u1
        enum: open_close_2
        doc: 'Open or close order indicator'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_y
        size: 1
        doc: 'Filler'
  sp_order_error_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  sp_net_order_error_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  spread_cxl_confirmation_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  spread_mod_confirmation_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  spread_mod_reject_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  spread_cxl_reject_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  batch_spread_order_cancel_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  twol_order_confirmation_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_order_confirmation_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  twol_order_error_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_order_error_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  twol_net_order_error_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_net_order_error_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  twol_order_cxl_confirmation_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  thrl_order_cxl_confirmation_message:
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
        doc: 'Not used'
      - id: filler_9
        size: 1
        doc: 'Filler'
      - id: reason_code_1
        type: s2
        doc: 'Not used'
      - id: start_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'StartAlpha1'
      - id: end_alpha_1
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'EndAlpha1'
      - id: token_1
        type: s4
        doc: 'Token number of the first leg''s contract, or -1 when only the contract descriptor is validated'
      - id: contract_desc
        type: contract_desc
        doc: 'CONTRACT_DESC'
      - id: op_broker_id_1
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
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
        doc: 'Set to blank'
      - id: order_number_1
        type: floating_point_integer
        doc: 'Order number assigned to the order'
      - id: account_number_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number when the order is entered on behalf of a trader, blank for a broker''s own order'
      - id: book_type_1
        type: s2
        enum: book_type_1
        doc: 'Book type, regular lot or special terms'
      - id: buy_sell_1
        type: s2
        enum: buy_sell_1
        doc: 'Whether the first leg is a buy or a sell'
      - id: disclosed_vol_1
        type: s4
        doc: 'Not used'
      - id: disclosed_vol_remaining_1
        type: s4
        doc: 'Not used'
      - id: total_vol_remaining_1
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume_1
        type: s4
        doc: 'Quantity of the order, in multiples of the regular lot'
      - id: volume_filled_today_1
        type: s4
        doc: 'Not used'
      - id: price_1
        type: s4
        doc: 'Not used for a spread order; the order price for a two or three leg order'
      - id: trigger_price_1
        type: s4
        doc: 'Not used'
      - id: good_till_date_1
        type: dos_second_timestamp
        doc: 'Not used. Seconds since Dos epoch'
      - id: entry_date_time_1
        type: dos_second_timestamp
        doc: 'Time the order first entered the trading system. Seconds since Dos epoch'
      - id: min_fill_aon_1
        type: s4
        doc: 'Not used'
      - id: last_modified_1
        type: dos_second_timestamp
        doc: 'Time the order was last modified, in seconds from midnight 1 January 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Attributes of the order'
      - id: branch_id_1
        type: s2
        doc: 'Branch number the broker belongs to'
      - id: trader_id_1
        type: s4
        doc: 'User Id'
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
        doc: 'cOrdFiller'
      - id: open_close_1
        type: u1
        enum: open_close_1
        doc: 'Open or close order indicator'
      - id: settlor_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id of the participant responsible for settling the trades through the custodians, blank for a broker''s own order'
      - id: pro_client_1
        type: s2
        enum: pro_client_1
        doc: 'Whether the order is entered on behalf of a client or is the broker''s own'
      - id: settlement_period_1
        type: s2
        doc: 'Number of days in a settlement cycle, currently 10'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further attributes of the order'
      - id: giveup_flag_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used'
      - id: filler_1_to_16
        size: 2
        doc: 'Sixteen one bit fillers, Filler1 to Filler16, reserved for future use'
      - id: filler_17
        size: 1
        doc: 'Reserved for future use'
      - id: filler_18
        size: 1
        doc: 'Reserved for future use'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier'
      - id: spread_entry_time
        type: floating_point_integer
        doc: 'Time the order entered the system, stamped at the host end'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sixteen character echo back field for members, which should carry the Algo Id issued by the exchange; blank for a non algo order'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value for the activity, currently in nanoseconds'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
      - id: price_diff
        type: s4
        doc: 'Difference between the prices at which leg two and leg one should trade, a multiple of the tick size within the price range, multiplied by 10000 for a contract traded in USD or by 100 for a contract traded in cents; spread orders only'
      - id: ms_spd_leg_info_leg_2
        type: ms_spd_leg_info_leg_2
        doc: 'MS_SPD_LEG_INFO Leg 2'
      - id: ms_spd_leg_info_leg_3
        type: ms_spd_leg_info_leg_3
        doc: 'MS_SPD_LEG_INFO Leg 3'
  server_session_packet:
    seq:
      - id: checksum
        size: 16
        doc: 'Md5 digest of the plain message data, or the Gcm authentication tag under the new encryption'
      - id: server_message_data
        type: server_message_data
        doc: 'The message data the exchange sends, a Message Header first, as every interactive message has; on an encrypting connection, what is encrypted'
  server_message_data:
    seq:
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: server_message_payload
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::sign_on_out_message': sign_on_out_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::trade_modify_confirm_message': trade_modify_confirm_message
            'transaction_code::trade_modify_reject_message': trade_modify_reject_message
            'transaction_code::trade_cancel_confirm_message': trade_cancel_confirm_message
            'transaction_code::trade_cancel_reject_message': trade_cancel_reject_message
            'transaction_code::nlt_trade_confirmation_message': nlt_trade_confirmation_message
            'transaction_code::nlt_trd_mod_confirmation_message': nlt_trd_mod_confirmation_message
            'transaction_code::nlt_trd_mod_reject_message': nlt_trd_mod_reject_message
            'transaction_code::nlt_trd_cxl_confirmation_message': nlt_trd_cxl_confirmation_message
            'transaction_code::nlt_trd_cxl_reject_message': nlt_trd_cxl_reject_message
            'transaction_code::giveup_app_confirm_tm_message': giveup_app_confirm_tm_message
            'transaction_code::giveup_rej_confirm_tm_message': giveup_rej_confirm_tm_message
            'transaction_code::board_lot_out_message': board_lot_out_message
            'transaction_code::order_mod_out_message': order_mod_out_message
            'transaction_code::order_mod_reject_message': order_mod_reject_message
            'transaction_code::order_cancel_out_message': order_cancel_out_message
            'transaction_code::order_cancel_reject_message': order_cancel_reject_message
            'transaction_code::order_confirmation_message': order_confirmation_message
            'transaction_code::order_mod_confirmation_message': order_mod_confirmation_message
            'transaction_code::order_cancel_confirmation_message': order_cancel_confirmation_message
            'transaction_code::freeze_to_control_message': freeze_to_control_message
            'transaction_code::order_error_message': order_error_message
            'transaction_code::batch_order_cancel_message': batch_order_cancel_message
            'transaction_code::net_order_error_message': net_order_error_message
            'transaction_code::nlt_confirmation_message': nlt_confirmation_message
            'transaction_code::nlt_mod_confirmation_message': nlt_mod_confirmation_message
            'transaction_code::nlt_cxl_confirmation_message': nlt_cxl_confirmation_message
            'transaction_code::nlt_mod_reject_message': nlt_mod_reject_message
            'transaction_code::nlt_cxl_reject_message': nlt_cxl_reject_message
            'transaction_code::spread_order_confirmation_message': spread_order_confirmation_message
            'transaction_code::sp_order_error_message': sp_order_error_message
            'transaction_code::sp_net_order_error_message': sp_net_order_error_message
            'transaction_code::spread_cxl_confirmation_message': spread_cxl_confirmation_message
            'transaction_code::spread_mod_confirmation_message': spread_mod_confirmation_message
            'transaction_code::spread_mod_reject_message': spread_mod_reject_message
            'transaction_code::spread_cxl_reject_message': spread_cxl_reject_message
            'transaction_code::batch_spread_order_cancel_message': batch_spread_order_cancel_message
            'transaction_code::twol_order_confirmation_message': twol_order_confirmation_message
            'transaction_code::thrl_order_confirmation_message': thrl_order_confirmation_message
            'transaction_code::twol_order_error_message': twol_order_error_message
            'transaction_code::thrl_order_error_message': thrl_order_error_message
            'transaction_code::twol_net_order_error_message': twol_net_order_error_message
            'transaction_code::thrl_net_order_error_message': thrl_net_order_error_message
            'transaction_code::twol_order_cxl_confirmation_message': twol_order_cxl_confirmation_message
            'transaction_code::thrl_order_cxl_confirmation_message': thrl_order_cxl_confirmation_message
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
  str_2_nullable:
    seq:
      - id: value
        size: 2
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "  "
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
        value: value == -1

enums:
  transaction_code:
    2300:
      id: 'signon_in_message'
      doc: 'Logs the user on to the drop copy feed'
    2301:
      id: 'sign_on_out_message'
      doc: 'Confirms the logon. Alpha Char carries the number of streams the drop copy feed is sent from, one download request being needed per stream. On an error the same transaction code carries the Error Response layout instead, distinguished only by a non zero Error Code'
    23506:
      id: 'heartbeat_message'
      doc: 'Keeps the connection alive, sent only after 30 seconds of inactivity; two missed heartbeats in succession disconnect the socket. Carries the Message Header alone'
    8000:
      id: 'dc_download_request_message'
      doc: 'Requests the trade download for one stream, named in the first byte of Alpha Char, from the time given in Sequence Number; only trade messages are sent'
    8400:
      id: 'dc_order_request_message'
      doc: 'Requests the order download for one stream, named in the first byte of Alpha Char, from the time given in Sequence Number; only order messages are sent'
    8500:
      id: 'dc_ord_trd_request_message'
      doc: 'Requests the order and trade download for one stream, named in the first byte of Alpha Char, from the time given in Sequence Number; orders are sent first, then trades, then live messages'
    2222:
      id: 'trade_confirmation_message'
      doc: 'Confirms a trade'
    2287:
      id: 'trade_modify_confirm_message'
      doc: 'Confirms a trade modification and carries the new trade data; Log Time holds the activity time, the latest modified time'
    2288:
      id: 'trade_modify_reject_message'
      doc: 'Rejection of a trade modification by NSE IFSC Control'
    2282:
      id: 'trade_cancel_confirm_message'
      doc: 'Approval of a trade cancellation by NSE IFSC Control; Log Time holds the activity time, the latest modified time'
    2286:
      id: 'trade_cancel_reject_message'
      doc: 'Rejection of a trade cancellation by NSE IFSC Control'
    2090:
      id: 'nlt_trade_confirmation_message'
      doc: 'Confirms an NLT trade, in the Trade Confirmation structure'
    5449:
      id: 'nlt_trd_mod_confirmation_message'
      doc: 'Confirms an NLT trade modification, in the Trade Confirmation structure'
    5450:
      id: 'nlt_trd_mod_reject_message'
      doc: 'Rejects an NLT trade modification, in the Trade Confirmation structure'
    5452:
      id: 'nlt_trd_cxl_confirmation_message'
      doc: 'Confirms an NLT trade cancellation, in the Trade Confirmation structure'
    5453:
      id: 'nlt_trd_cxl_reject_message'
      doc: 'Rejects an NLT trade cancellation, in the Trade Confirmation structure'
    4506:
      id: 'giveup_app_confirm_tm_message'
      doc: 'Approves a give up'
    4507:
      id: 'giveup_rej_confirm_tm_message'
      doc: 'Rejects a give up'
    2001:
      id: 'board_lot_out_message'
      doc: 'Order entry, in the Order Confirmation structure'
    2041:
      id: 'order_mod_out_message'
      doc: 'Order modification, in the Order Confirmation structure'
    2042:
      id: 'order_mod_reject_message'
      doc: 'Rejects an order modification, the reason given by the Error Code in the header'
    2071:
      id: 'order_cancel_out_message'
      doc: 'Order cancellation, in the Order Confirmation structure'
    2072:
      id: 'order_cancel_reject_message'
      doc: 'Rejects an order cancellation, the reason given by the Error Code in the header'
    2073:
      id: 'order_confirmation_message'
      doc: 'Confirms an order'
    2074:
      id: 'order_mod_confirmation_message'
      doc: 'Confirms an order modification; Entry Date Time carries the user modified order time'
    2075:
      id: 'order_cancel_confirmation_message'
      doc: 'Confirms an order cancellation, unsolicited when NSE IFSC Control cancels the order, and also sent for the partial cancellation of an IOC order; Last Modified is the cancellation time, the same as Log Time'
    2170:
      id: 'freeze_to_control_message'
      doc: 'The order has gone for a freeze'
    2231:
      id: 'order_error_message'
      doc: 'Rejects an order because of an error, the error number in the Error Code of the header; also the kill switch error response'
    9002:
      id: 'batch_order_cancel_message'
      doc: 'Batch order cancellation; Last Modified is the cancellation time, the same as Log Time'
    27100:
      id: 'net_order_error_message'
      doc: 'Rejects an order because of an error, the error number in the Error Code of the header'
    2083:
      id: 'nlt_confirmation_message'
      doc: 'Confirms an NLT order'
    2085:
      id: 'nlt_mod_confirmation_message'
      doc: 'Confirms an NLT order modification; Entry Date Time carries the user modified order time'
    2087:
      id: 'nlt_cxl_confirmation_message'
      doc: 'Confirms an NLT order cancellation; Last Modified is the cancellation time, the same as Log Time'
    2088:
      id: 'nlt_mod_reject_message'
      doc: 'Rejects an NLT order modification, the reason given by the Error Code in the header'
    2089:
      id: 'nlt_cxl_reject_message'
      doc: 'Rejects an NLT order cancellation, the reason given by the Error Code in the header'
    2124:
      id: 'spread_order_confirmation_message'
      doc: 'Confirms a spread order'
    2154:
      id: 'sp_order_error_message'
      doc: 'Rejects a spread order, the error number in the Error Code of the header'
    27102:
      id: 'sp_net_order_error_message'
      doc: 'Rejects a spread order, in the MS_SPD_OE_REQUEST structure'
    2130:
      id: 'spread_cxl_confirmation_message'
      doc: 'Confirms the cancellation of a spread order; Last Modified is the cancellation time, the same as Log Time'
    2136:
      id: 'spread_mod_confirmation_message'
      doc: 'Confirms a spread order modification; Last Modified is the modification time'
    2133:
      id: 'spread_mod_reject_message'
      doc: 'Rejects a spread order modification, the reason given by the Error Code in the header'
    2127:
      id: 'spread_cxl_reject_message'
      doc: 'Rejects a spread order cancellation, the reason given by the Error Code in the header'
    9004:
      id: 'batch_spread_order_cancel_message'
      doc: 'Spread batch order cancellation; Last Modified is the cancellation time, the same as Log Time'
    2125:
      id: 'twol_order_confirmation_message'
      doc: 'Confirms a two leg order'
    2126:
      id: 'thrl_order_confirmation_message'
      doc: 'Confirms a three leg order'
    2155:
      id: 'twol_order_error_message'
      doc: 'Rejects a two leg order, the error number in the Error Code of the header'
    2156:
      id: 'thrl_order_error_message'
      doc: 'Rejects a three leg order, the error number in the Error Code of the header'
    27103:
      id: 'twol_net_order_error_message'
      doc: 'Rejects a two leg order, the error number in the Error Code of the header'
    27104:
      id: 'thrl_net_order_error_message'
      doc: 'Rejects a three leg order, the error number in the Error Code of the header'
    2131:
      id: 'twol_order_cxl_confirmation_message'
      doc: 'Confirms the cancellation of a two leg order; Last Modified is the cancellation time, the same as Log Time'
    2132:
      id: 'thrl_order_cxl_confirmation_message'
      doc: 'Confirms the cancellation of a three leg order; Last Modified is the cancellation time, the same as Log Time'
  error_code:
    16001:
      id: 'err_invalid_user_type'
      doc: 'Invalid User Type'
    16004:
      id: 'err_user_already_signed_on'
      doc: 'User already signed on.'
    16006:
      id: 'err_invalid_signon'
      doc: 'Invalid sign-on, Please try again.'
    16007:
      id: 'err_signon_not_possible'
      doc: 'Signing on to the trading system is restricted. Please try later on.'
    16041:
      id: 'err_invalid_broker_or_branch'
      doc: 'Trading Member does not exist in the system.'
    16042:
      id: 'err_user_not_found'
      doc: 'Dealer does not exist in the system.'
    16056:
      id: 'err_program_error'
      doc: 'Program error.'
    16104:
      id: 'err_system_error'
      doc: 'System could not complete your transaction - ADMIN notified.'
    16123:
      id: 'err_cant_complete_your_request'
      doc: 'System not able to complete your request. Please try again.'
    16134:
      id: 'err_user_is_disabled'
      doc: 'This Dealer is disabled. Please call the Exchange.'
    16148:
      id: 'err_invalid_user_id'
      doc: 'Invalid Dealer ID entered.'
    16154:
      id: 'err_invalid_trader_id'
      doc: 'Invalid Trader ID entered.'
    16285:
      id: 'err_broker_not_active'
      doc: 'The broker is not active.'
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
    16169:
      id: 'oe_ato_in_open'
      doc: 'Order priced ATO cannot be entered when a Security is open.'
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
      doc: 'The security has not yet been admitted for trading.'
    16280:
      id: 'oe_security_matured'
      doc: 'The security has matured.'
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
      doc: 'MF attribute not allowed at Security level.'
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
      doc: 'Security is in preopen.'
    16372:
      id: 'oe_inq_not_allowed'
      doc: 'Order entry not allowed for user as it is of inquiry type.'
    16387:
      id: 'oe_security_ineligible'
      doc: 'Security not allowed to trader in.'
    16388:
      id: 'err_fok_order_cancelled'
      doc: 'When Preopen/ preclose unmatched orders are cancelled by the system after preopen session ends.'
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
    16444:
      id: 'err_usr_ord_value_limit_exceeded'
      doc: 'User Order value limit exceeded.'
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
      id: 'e_not_valid_fo_security'
      doc: 'Not a valid derivative security.'
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
    16797:
      id: 'msg_code_voluntary_close_out_status'
      doc: 'Broker is in Voluntary Closeout.'
    16798:
      id: 'msg_code_suspended_status'
      doc: 'Broker is Suspended.'
    16807:
      id: 'e_account_debarred'
      doc: 'The account is debarred from trading.'
    17184:
      id: 'err_user_having_null_rights'
      doc: 'Order Rejected as user has no trading rights'
  buy_sell:
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
      id: 'stop_loss_mit_order'
      doc: 'Stop Loss Mit Order'
    4:
      id: 'negotiated_order_not_used'
      doc: 'Negotiated Order Not Used'
    5:
      id: 'odd_lot_order_not_used'
      doc: 'Odd Lot Order Not Used'
    6:
      id: 'spot_order_not_used'
      doc: 'Spot Order Not Used'
    7:
      id: 'auction_order_not_used'
      doc: 'Auction Order Not Used'
  initiated_by_control:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
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
  buy_sell_indicator:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  pro_client_indicator:
    1:
      id: 'clients_order'
      doc: 'Clients Order'
    2:
      id: 'brokers_order'
      doc: 'Brokers Order'
  book_type_1:
    1:
      id: 'regular_lot_order'
      doc: 'Regular Lot Order'
    2:
      id: 'special_terms_order'
      doc: 'Special Terms Order'
  buy_sell_1:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  open_close_1:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  pro_client_1:
    1:
      id: 'clients_order'
      doc: 'Clients Order'
    2:
      id: 'brokers_order'
      doc: 'Brokers Order'
  buy_sell_2:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  open_close_2:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'

