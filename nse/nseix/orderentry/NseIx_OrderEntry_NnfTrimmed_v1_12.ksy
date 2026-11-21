# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseIx OrderEntry NnfTrimmed v1.12
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End Trimmed
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
  id: nse_nseix_orderentry_nnftrimmed_v1_12
  title: Nse NseIx OrderEntry NnfTrimmed v1.12
  license: MIT-0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE International Exchange Order Entry NnfTrimmed v1.12'
doc-ref: https://www.nseix.com/technology/tradingprotocol

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Nnf trimmed message'

types:
  message_struct:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Type of message, which also fixes its length'
      - id: message_payload
        type:
          switch-on: transaction_code
          cases:
            'transaction_code::board_lot_in_trimmed_message': board_lot_in_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message': order_modify_cancel_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message_20060': order_modify_cancel_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message_20070': order_modify_cancel_trimmed_message
            'transaction_code::order_response_trimmed_message': order_response_trimmed_message
            'transaction_code::order_response_trimmed_message_20042': order_response_trimmed_message
            'transaction_code::order_response_trimmed_message_20072': order_response_trimmed_message
            'transaction_code::order_response_trimmed_message_20073': order_response_trimmed_message
            'transaction_code::order_response_trimmed_message_20074': order_response_trimmed_message
            'transaction_code::order_response_trimmed_message_20075': order_response_trimmed_message
            'transaction_code::order_response_trimmed_message_20231': order_response_trimmed_message
            'transaction_code::trade_confirmation_trimmed_message': trade_confirmation_trimmed_message
  board_lot_in_trimmed_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user entering the order'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason the request was rejected or the order frozen, zero on entry'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or minus one to validate on the contract descriptor alone'
      - id: contract_desc_tr
        type: contract_desc_tr
        doc: 'CONTRACT_DESC_TR'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
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
        doc: 'Quantity disclosed to the market'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: price
        type: s4
        doc: 'Price of the order'
      - id: good_till_date
        type: s4
        doc: 'Good till date, as a number of days or as a date in seconds since midnight January 1, 1980'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the order opens or closes a position'
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
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: reserved_1
        size: 1
        doc: 'Padding to the two byte alignment of the next field'
      - id: filler_4
        size: 4
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit Non Neat front end identifier supplied by the member'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Echo back field, carrying the algo Id in bytes 11 to 14'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value of the last activity on the order, zero on entry'
      - id: reserved_24
        size: 24
        doc: 'Reserved'
  contract_desc_tr:
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
        doc: 'All or none order'
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
        doc: 'Order was entered in the pre open session'
      - id: preclose
        type: b1
        doc: 'Order was entered in the pre close session'
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
  order_modify_cancel_trimmed_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user entering the order'
      - id: modified_cancelled_by
        type: u1
        enum: modified_cancelled_by
        doc: 'Who modified or cancelled the order'
      - id: filler_1
        size: 1
        doc: 'Filler'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or minus one to validate on the contract descriptor alone'
      - id: contract_desc_tr
        type: contract_desc_tr
        doc: 'CONTRACT_DESC_TR'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the order to be modified or cancelled'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
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
        type: s4
        doc: 'Price of the order'
      - id: good_till_date
        type: s4
        doc: 'Good till date, as a number of days or as a date in seconds since midnight January 1, 1980'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order entered the trading system. Seconds since Dos epoch'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the order opens or closes a position'
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
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: second_filler_1
        size: 1
        doc: 'Filler'
      - id: filler_4
        size: 4
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit Non Neat front end identifier supplied by the member'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Echo back field, carrying the algo Id in bytes 11 to 14'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value of the last activity on the order, zero on entry'
      - id: reserved_24
        size: 24
        doc: 'Reserved'
  order_response_trimmed_message:
    seq:
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch'
      - id: user_id
        type: s4
        doc: 'Id of the user entering the order'
      - id: error_code
        type: s2
        enum: error_code
        doc: 'Zero when the request succeeded'
      - id: time_stamp_1
        type: floating_point_integer
        doc: 'Time the message arrived at the trading system host'
      - id: timestamp_2_char
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of the machine the message came from'
      - id: modified_cancelled_by
        type: u1
        enum: modified_cancelled_by
        doc: 'Who modified or cancelled the order'
      - id: reason_code
        type: s2
        enum: reason_code
        doc: 'Reason the request was rejected or the order frozen, zero on entry'
      - id: token_no
        type: s4
        doc: 'Token number of the contract, or minus one to validate on the contract descriptor alone'
      - id: contract_desc_tr
        type: contract_desc_tr
        doc: 'CONTRACT_DESC_TR'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order closes out a position of a broker in closeout'
      - id: reserved_1
        size: 1
        doc: 'Padding to the two byte alignment of the next field'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the order to be modified or cancelled'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
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
        type: s4
        doc: 'Price of the order'
      - id: good_till_date
        type: s4
        doc: 'Good till date, as a number of days or as a date in seconds since midnight January 1, 1980'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order entered the trading system. Seconds since Dos epoch'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the order opens or closes a position'
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
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the two byte alignment of the next field'
      - id: filler_4
        size: 4
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit Non Neat front end identifier supplied by the member'
      - id: reserved_8
        size: 8
        doc: 'Reserved'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Echo back field, carrying the algo Id in bytes 11 to 14'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value of the last activity on the order, zero on entry'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  trade_confirmation_trimmed_message:
    seq:
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was generated by the trading system. Seconds since Dos epoch'
      - id: trader_id
        type: s4
        doc: 'User Id of the user'
      - id: time_stamp
        type: floating_point_integer
        doc: 'Time stamp'
      - id: time_stamp_1
        type: floating_point_integer
        doc: 'Time the message arrived at the trading system host'
      - id: timestamp_2_double
        type: floating_point_integer
        doc: 'Number of the machine the message came from'
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
        doc: 'Padding to the two byte alignment of the next field'
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
        doc: 'Volume remaining after the trades'
      - id: disclosed_volume_remaining
        type: s4
        doc: 'Disclosed quantity still outstanding'
      - id: price
        type: s4
        doc: 'Price of the order'
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
      - id: token
        type: s4
        doc: 'Token number of the contract'
      - id: contract_desc_tr
        type: contract_desc_tr
        doc: 'CONTRACT_DESC_TR'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Whether the order opens or closes a position'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book type of the order'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant the trade is for'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: second_reserved_1
        size: 1
        doc: 'Padding to the two byte alignment of the next field'
      - id: echo_back
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Echo back field, carrying the algo Id in bytes 11 to 14'
      - id: last_activity_reference
        type: s8
        doc: 'Unique value of the last activity on the order, zero on entry'
      - id: reserved_52
        size: 52
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
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 0
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>

enums:
  transaction_code:
    20000:
      id: 'board_lot_in_trimmed_message'
      doc: 'Trimmed order entry request'
    20040:
      id: 'order_modify_cancel_trimmed_message'
      doc: 'Trimmed order modification, quick cancellation and cancellation requests'
    20060:
      id: 'order_modify_cancel_trimmed_message_20060'
      doc: 'Trimmed order modification, quick cancellation and cancellation requests'
    20070:
      id: 'order_modify_cancel_trimmed_message_20070'
      doc: 'Trimmed order modification, quick cancellation and cancellation requests'
    20012:
      id: 'order_response_trimmed_message'
      doc: 'Trimmed price confirmation, order, modification and cancellation confirmations, modification and cancellation rejections and order error. Transaction Code names the response'
    20042:
      id: 'order_response_trimmed_message_20042'
      doc: 'Trimmed price confirmation, order, modification and cancellation confirmations, modification and cancellation rejections and order error. Transaction Code names the response'
    20072:
      id: 'order_response_trimmed_message_20072'
      doc: 'Trimmed price confirmation, order, modification and cancellation confirmations, modification and cancellation rejections and order error. Transaction Code names the response'
    20073:
      id: 'order_response_trimmed_message_20073'
      doc: 'Trimmed price confirmation, order, modification and cancellation confirmations, modification and cancellation rejections and order error. Transaction Code names the response'
    20074:
      id: 'order_response_trimmed_message_20074'
      doc: 'Trimmed price confirmation, order, modification and cancellation confirmations, modification and cancellation rejections and order error. Transaction Code names the response'
    20075:
      id: 'order_response_trimmed_message_20075'
      doc: 'Trimmed price confirmation, order, modification and cancellation confirmations, modification and cancellation rejections and order error. Transaction Code names the response'
    20231:
      id: 'order_response_trimmed_message_20231'
      doc: 'Trimmed price confirmation, order, modification and cancellation confirmations, modification and cancellation rejections and order error. Transaction Code names the response'
    20222:
      id: 'trade_confirmation_trimmed_message'
      doc: 'Trimmed trade confirmation'
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

