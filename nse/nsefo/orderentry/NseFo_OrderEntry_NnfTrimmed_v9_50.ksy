# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseFo OrderEntry NnfTrimmed v9.50
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End Trimmed
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
  id: nse_nsefo_orderentry_nnftrimmed_v9_50
  title: Nse NseFo OrderEntry NnfTrimmed v9.50
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Futures & Options Order Entry NnfTrimmed v9.50'
doc-ref: https://www.nseindia.com/trade/members-trading-software-vendors-api-download

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
            'transaction_code::board_lot_in_trimmed_message_20400': board_lot_in_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message': order_modify_cancel_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message_20060': order_modify_cancel_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message_20070': order_modify_cancel_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message_20402': order_modify_cancel_trimmed_message
            'transaction_code::order_modify_cancel_trimmed_message_20404': order_modify_cancel_trimmed_message
            'transaction_code::order_confirmation_trimmed_message': order_confirmation_trimmed_message
            'transaction_code::order_confirmation_trimmed_message_20074': order_confirmation_trimmed_message
            'transaction_code::order_confirmation_trimmed_message_20075': order_confirmation_trimmed_message
            'transaction_code::trade_confirmation_trimmed_message': trade_confirmation_trimmed_message
            'transaction_code::quick_acknowledgement_message': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20403': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20405': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20407': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20409': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20411': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20413': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20415': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20417': quick_acknowledgement_message
  board_lot_in_trimmed_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user entering the order'
      - id: reason_code
        type: s2
        doc: 'Reason the request was rejected'
      - id: token_no
        type: s4
        doc: 'Token number of the contract'
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
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity disclosed to the market'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: good_till_date
        type: s4
        doc: 'Number of days a good till date order remains, from two to the maximum the market allows'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: trader_id
        type: s4
        doc: 'User Id that entered the order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlor of the order'
      - id: pro_client_indicator
        type: s2
        doc: 'Whether the order is proprietary or for a client'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding to the two byte alignment of the next field'
      - id: filler
        type: s4
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Non Neat front end identifier'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number'
      - id: algo_id
        type: s4
        doc: 'Algorithm identifier'
      - id: reserved_2
        type: s2
        doc: 'Reserved'
      - id: reserved_32
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
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
        type: second_timestamp
        doc: 'Date the contract expires. Seconds since Dos epoch'
      - id: strike_price
        type: decimal_s4_2
        doc: 'Strike price of an option. Implied decimal with scale 1e-2'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the option is a call or a put'
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
  order_modify_cancel_trimmed_message:
    seq:
      - id: user_id
        type: s4
        doc: 'Id of the user entering the order'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Who modified or cancelled the order'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding to the two byte alignment of the next field'
      - id: token_no
        type: s4
        doc: 'Token number of the contract'
      - id: contract_desc_tr
        type: contract_desc_tr
        doc: 'CONTRACT_DESC_TR'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number allotted by the trading system'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
      - id: book_type
        type: s2
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
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
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: good_till_date
        type: s4
        doc: 'Number of days a good till date order remains, from two to the maximum the market allows'
      - id: entry_date_time
        type: second_timestamp
        doc: 'Time the order entered the system. Seconds since Dos epoch'
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
        doc: 'User Id that entered the order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlor of the order'
      - id: pro_client_indicator
        type: s2
        doc: 'Whether the order is proprietary or for a client'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding to the two byte alignment of the next field'
      - id: filler
        type: s4
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Non Neat front end identifier'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number'
      - id: algo_id
        type: s4
        doc: 'Algorithm identifier'
      - id: reserved_2
        type: s2
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_24
        type: str
        size: 24
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  order_confirmation_trimmed_message:
    seq:
      - id: log_time
        type: second_timestamp
        doc: 'Time the message was generated. Seconds since Dos epoch'
      - id: user_id
        type: s4
        doc: 'Id of the user entering the order'
      - id: error_code
        type: s2
        doc: 'Zero when the request succeeded'
      - id: time_stamp_1
        type: s8
        doc: 'Time the message arrived at the host'
      - id: time_stamp_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the message reached the gateway'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Who modified or cancelled the order'
      - id: reason_code
        type: s2
        doc: 'Reason the request was rejected'
      - id: token_no
        type: s4
        doc: 'Token number of the contract'
      - id: contract_desc_tr
        type: contract_desc_tr
        doc: 'CONTRACT_DESC_TR'
      - id: closeout_flag
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the broker is in closeout status'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding to the two byte alignment of the next field'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number allotted by the trading system'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
      - id: book_type
        type: s2
        doc: 'Book the order belongs to'
      - id: buy_sell_indicator
        type: s2
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
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: good_till_date
        type: s4
        doc: 'Number of days a good till date order remains, from two to the maximum the market allows'
      - id: entry_date_time
        type: second_timestamp
        doc: 'Time the order entered the system. Seconds since Dos epoch'
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
        doc: 'User Id that entered the order'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order opens or closes a position'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlor of the order'
      - id: pro_client_indicator
        type: s2
        doc: 'Whether the order is proprietary or for a client'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding to the two byte alignment of the next field'
      - id: filler
        type: s4
        doc: 'Filler'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Non Neat front end identifier'
      - id: time_stamp
        type: s8
        doc: 'Time stamped at the matching engine'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number'
      - id: algo_id
        type: s4
        doc: 'Algorithm identifier'
      - id: reserved_2
        type: s2
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
  trade_confirmation_trimmed_message:
    seq:
      - id: log_time
        type: second_timestamp
        doc: 'Time the message was generated. Seconds since Dos epoch'
      - id: trader_id
        type: s4
        doc: 'User Id that entered the order'
      - id: time_stamp
        type: s8
        doc: 'Time stamped at the matching engine'
      - id: time_stamp_1
        type: s8
        doc: 'Time the message arrived at the host'
      - id: time_stamp_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the message reached the gateway'
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
        doc: 'Padding to the two byte alignment of the next field'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number the order is for'
      - id: buy_sell_indicator
        type: s2
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
        doc: 'Price of the order. Implied decimal with scale 1e-2'
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
      - id: token
        type: s4
        doc: 'Token number of the contract'
      - id: contract_desc_tr
        type: contract_desc_tr
        doc: 'CONTRACT_DESC_TR'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order opens or closes a position'
      - id: trade_book_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Book the order belongs to'
      - id: participant
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant the trade is for'
      - id: additional_order_flags
        type: additional_order_flags
        doc: 'Further terms attached to the order'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent account number'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding to the two byte alignment of the next field'
      - id: algo_id
        type: s4
        doc: 'Algorithm identifier'
      - id: reserved_2
        type: s2
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
  quick_acknowledgement_message:
    seq:
      - id: trader_id
        type: s4
        doc: 'User Id that entered the order'
      - id: time_stamp
        type: s8
        doc: 'Time stamped at the matching engine'
      - id: reference
        type: s4
        doc: 'Reference supplied with the request'
      - id: error_code
        type: s2
        doc: 'Zero when the request succeeded'
      - id: message_length
        type: s2
        doc: 'Length of this message'
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
    20000:
      id: 'board_lot_in_trimmed_message'
      doc: 'Trimmed order entry request, and the same structure sent as an immediate acknowledgement request'
    20400:
      id: 'board_lot_in_trimmed_message_20400'
      doc: 'Trimmed order entry request, and the same structure sent as an immediate acknowledgement request'
    20040:
      id: 'order_modify_cancel_trimmed_message'
      doc: 'Trimmed order modification and cancellation requests and their immediate acknowledgement requests'
    20060:
      id: 'order_modify_cancel_trimmed_message_20060'
      doc: 'Trimmed order modification and cancellation requests and their immediate acknowledgement requests'
    20070:
      id: 'order_modify_cancel_trimmed_message_20070'
      doc: 'Trimmed order modification and cancellation requests and their immediate acknowledgement requests'
    20402:
      id: 'order_modify_cancel_trimmed_message_20402'
      doc: 'Trimmed order modification and cancellation requests and their immediate acknowledgement requests'
    20404:
      id: 'order_modify_cancel_trimmed_message_20404'
      doc: 'Trimmed order modification and cancellation requests and their immediate acknowledgement requests'
    20073:
      id: 'order_confirmation_trimmed_message'
      doc: 'Trimmed order, modification and cancellation confirmations'
    20074:
      id: 'order_confirmation_trimmed_message_20074'
      doc: 'Trimmed order, modification and cancellation confirmations'
    20075:
      id: 'order_confirmation_trimmed_message_20075'
      doc: 'Trimmed order, modification and cancellation confirmations'
    20222:
      id: 'trade_confirmation_trimmed_message'
      doc: 'Trimmed trade confirmation'
    20401:
      id: 'quick_acknowledgement_message'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20403:
      id: 'quick_acknowledgement_message_20403'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20405:
      id: 'quick_acknowledgement_message_20405'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20407:
      id: 'quick_acknowledgement_message_20407'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20409:
      id: 'quick_acknowledgement_message_20409'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20411:
      id: 'quick_acknowledgement_message_20411'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20413:
      id: 'quick_acknowledgement_message_20413'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20415:
      id: 'quick_acknowledgement_message_20415'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'
    20417:
      id: 'quick_acknowledgement_message_20417'
      doc: 'Immediate acknowledgement that an order related request reached the exchange'

