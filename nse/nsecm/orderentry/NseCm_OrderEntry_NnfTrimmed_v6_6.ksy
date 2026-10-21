# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCm OrderEntry NnfTrimmed v6.6
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Order Entry
#   Encoding: Non-Neat Front End Trimmed
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
  id: nse_nsecm_orderentry_nnftrimmed_v6_6
  title: Nse NseCm OrderEntry NnfTrimmed v6.6
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Capital Market Order Entry NnfTrimmed v6.6'
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
        doc: 'The transaction code is ORDER_MOD_IN_TR (20040), TRIMMED_ORDER_MOD_ACK_IN (20402), ORDER_CANCEL_IN_TR (20070) or TRIMMED_ORDER_CANCEL_ACK_IN (20404)'
      - id: message_payload
        type:
          switch-on: transaction_code
          cases:
            'transaction_code::order_entry_request_trimmed_message': order_entry_request_trimmed_message
            'transaction_code::order_entry_request_trimmed_message_20400': order_entry_request_trimmed_message
            'transaction_code::order_modify_cancel_request_trimmed_message': order_modify_cancel_request_trimmed_message
            'transaction_code::order_modify_cancel_request_trimmed_message_20070': order_modify_cancel_request_trimmed_message
            'transaction_code::order_modify_cancel_request_trimmed_message_20402': order_modify_cancel_request_trimmed_message
            'transaction_code::order_modify_cancel_request_trimmed_message_20404': order_modify_cancel_request_trimmed_message
            'transaction_code::order_modify_cancel_response_trimmed_message': order_modify_cancel_response_trimmed_message
            'transaction_code::order_modify_cancel_response_trimmed_message_20042': order_modify_cancel_response_trimmed_message
            'transaction_code::order_modify_cancel_response_trimmed_message_20072': order_modify_cancel_response_trimmed_message
            'transaction_code::order_modify_cancel_response_trimmed_message_20073': order_modify_cancel_response_trimmed_message
            'transaction_code::order_modify_cancel_response_trimmed_message_20074': order_modify_cancel_response_trimmed_message
            'transaction_code::order_modify_cancel_response_trimmed_message_20075': order_modify_cancel_response_trimmed_message
            'transaction_code::order_modify_cancel_response_trimmed_message_20231': order_modify_cancel_response_trimmed_message
            'transaction_code::trade_confirmation_trimmed_message': trade_confirmation_trimmed_message
            'transaction_code::quick_acknowledgement_message': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20403': quick_acknowledgement_message
            'transaction_code::quick_acknowledgement_message_20405': quick_acknowledgement_message
  order_entry_request_trimmed_message:
    seq:
      - id: transcode
        type: s2
        doc: 'The transaction code is BOARD_LOT_IN_TR (20000) or TRIMMED_BOARD_LOT_ACK_IN (20400)'
      - id: trader_id
        type: s4
        doc: 'User ID of the user entering the order'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number for an order on behalf of a trader, or the broker code for a broker''s own order'
      - id: book_type
        type: s2
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, in paise. Implied decimal with scale 1e-2'
      - id: good_till_date
        type: s4
        doc: 'Number of days a good till date order remains in the system'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: user_id
        type: s4
        doc: 'Id of the user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settling party name'
      - id: pro_client
        type: s2
        doc: 'Whether the order is a participant''s own or on behalf of a client'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Nnf field as the exchange prescribes'
      - id: transaction_id
        type: s4
        doc: 'Transaction Id of the order'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: algo_id
        type: s4
        doc: 'Algorithm Id of an algorithmic order'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: reserved_32
        size: 32
        doc: 'Reserved'
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
      - id: reserved_3
        type: b1
        doc: 'Reserved'
      - id: stpc
        type: b1
        doc: 'Self trade prevention check'
      - id: reserved_1
        type: b1
        doc: 'Reserved'
  order_modify_cancel_request_trimmed_message:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'The transaction code is ORDER_MOD_IN_TR (20040), TRIMMED_ORDER_MOD_ACK_IN (20402), ORDER_CANCEL_IN_TR (20070) or TRIMMED_ORDER_CANCEL_ACK_IN (20404)'
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was logged, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: user_id
        type: s4
        doc: 'Id of the user'
      - id: error_code
        type: s2
        doc: 'Type of error, zero while sending to the host'
      - id: time_stamp_1_long_long_8
        type: s8
        doc: 'Time the message arrives at the trading system host'
      - id: time_stamp_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for the host'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order was modified or cancelled by the trader, the branch manager or the corporate manager'
      - id: reason_code
        type: s2
        doc: 'Reason the request was rejected'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number the trading system assigned'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number for an order on behalf of a trader, or the broker code for a broker''s own order'
      - id: book_type
        type: s2
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed quantity remaining'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Quantity filled today'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, in paise. Implied decimal with scale 1e-2'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order entered the system, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: second_user_id
        type: s4
        doc: 'Id of the user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settling party name'
      - id: pro_client
        type: s2
        doc: 'Whether the order is a participant''s own or on behalf of a client'
      - id: settlement_type
        type: s2
        doc: 'Settlement period of the security'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Nnf field as the exchange prescribes'
      - id: transaction_id
        type: s4
        doc: 'Transaction Id of the order'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: algo_id
        type: s4
        doc: 'Algorithm Id of an algorithmic order'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_24
        size: 24
        doc: 'Reserved'
  order_modify_cancel_response_trimmed_message:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'The transaction code is ORDER_MOD_IN_TR (20040), TRIMMED_ORDER_MOD_ACK_IN (20402), ORDER_CANCEL_IN_TR (20070) or TRIMMED_ORDER_CANCEL_ACK_IN (20404)'
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was logged, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: user_id
        type: s4
        doc: 'Id of the user'
      - id: error_code
        type: s2
        doc: 'Type of error, zero while sending to the host'
      - id: time_stamp_1_long_long_8
        type: s8
        doc: 'Time the message arrives at the trading system host'
      - id: time_stamp_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for the host'
      - id: modified_cancelled_by
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order was modified or cancelled by the trader, the branch manager or the corporate manager'
      - id: reason_code
        type: s2
        doc: 'Reason the request was rejected'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number the trading system assigned'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number for an order on behalf of a trader, or the broker code for a broker''s own order'
      - id: book_type
        type: s2
        doc: 'Type of order'
      - id: buy_sell
        type: s2
        doc: 'Whether the order is a buy or a sell'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed quantity remaining'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining'
      - id: volume
        type: s4
        doc: 'Quantity of the order'
      - id: volume_filled_today
        type: s4
        doc: 'Quantity filled today'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, in paise. Implied decimal with scale 1e-2'
      - id: entry_date_time
        type: dos_second_timestamp
        doc: 'Time the order entered the system, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: last_modified
        type: dos_second_timestamp
        doc: 'Time the order was last modified, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: branch_id
        type: s2
        doc: 'Branch Id of the trading member'
      - id: second_user_id
        type: s4
        doc: 'Id of the user'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settling party name'
      - id: pro_client
        type: s2
        doc: 'Whether the order is a participant''s own or on behalf of a client'
      - id: settlement_type
        type: s2
        doc: 'Settlement period of the security'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Nnf field as the exchange prescribes'
      - id: transaction_id
        type: s4
        doc: 'Transaction Id of the order'
      - id: timestamp
        type: s8
        doc: 'Time stamped at the matching engine, in nanoseconds from January 1 1980 for the transaction codes the appendix lists'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: algo_id
        type: s4
        doc: 'Algorithm Id of an algorithmic order'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  trade_confirmation_trimmed_message:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'The transaction code is ORDER_MOD_IN_TR (20040), TRIMMED_ORDER_MOD_ACK_IN (20402), ORDER_CANCEL_IN_TR (20070) or TRIMMED_ORDER_CANCEL_ACK_IN (20404)'
      - id: log_time
        type: dos_second_timestamp
        doc: 'Time the message was logged, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: user_id
        type: s4
        doc: 'Id of the user'
      - id: timestamp
        type: s8
        doc: 'Time stamped at the matching engine, in nanoseconds from January 1 1980 for the transaction codes the appendix lists'
      - id: time_stamp_1_char_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time the message arrives at the trading system host'
      - id: response_order_number
        type: floating_point_integer
        doc: 'Order number the trading system assigned'
      - id: time_stamp_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for the host'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading member Id'
      - id: trader_num
        type: s4
        doc: 'Id of the trader'
      - id: buy_sell
        type: s2
        doc: 'Whether the order is a buy or a sell'
      - id: account_num
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trader account number for an order on behalf of a trader, or the broker code for a broker''s own order'
      - id: original_vol
        type: s4
        doc: 'Quantity of the order when it was entered'
      - id: disclosed_vol
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_vol
        type: s4
        doc: 'Quantity remaining'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed quantity remaining'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order, in paise. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: fill_number
        type: s4
        doc: 'Number of the fill'
      - id: fill_qty
        type: s4
        doc: 'Quantity of the fill'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price of the fill, in paise. Implied decimal with scale 1e-2'
      - id: vol_filled_today
        type: s4
        doc: 'Quantity filled today'
      - id: activity_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the activity'
      - id: activity_time
        type: dos_second_timestamp
        doc: 'Time of the activity, seconds from midnight January 1 1980. Seconds since Dos epoch'
      - id: sec_info
        type: sec_info
        doc: 'SEC_INFO'
      - id: book_type
        type: s2
        doc: 'Type of order'
      - id: pro_client
        type: s2
        doc: 'Whether the order is a participant''s own or on behalf of a client'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: algo_id
        type: s4
        doc: 'Algorithm Id of an algorithmic order'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: last_activity_reference
        type: s8
        doc: 'Reference of the last activity on the order'
      - id: reserved_52
        size: 52
        doc: 'Reserved'
  quick_acknowledgement_message:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'The transaction code is ORDER_MOD_IN_TR (20040), TRIMMED_ORDER_MOD_ACK_IN (20402), ORDER_CANCEL_IN_TR (20070) or TRIMMED_ORDER_CANCEL_ACK_IN (20404)'
      - id: trader_id
        type: s4
        doc: 'User ID of the user entering the order'
      - id: timestamp
        type: s8
        doc: 'Time stamped at the matching engine, in nanoseconds from January 1 1980 for the transaction codes the appendix lists'
      - id: reference
        type: s4
        doc: 'Echo of the value received in the filler or reference field of the order packet'
      - id: error_code
        type: s2
        doc: 'Type of error, zero while sending to the host'
      - id: message_length
        type: s2
        doc: 'Length of the entire message'
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

enums:
  transaction_code:
    20000:
      id: 'order_entry_request_trimmed_message'
      doc: 'Trimmed order entry request, and the same structure sent as an immediate acknowledgement request. Chapter 4 directs an order of book type 1, 11 or 12 to this structure rather than to the interactive MS_OE_REQUEST, under transaction code 20000 or 20400'
    20400:
      id: 'order_entry_request_trimmed_message_20400'
      doc: 'Trimmed order entry request, and the same structure sent as an immediate acknowledgement request. Chapter 4 directs an order of book type 1, 11 or 12 to this structure rather than to the interactive MS_OE_REQUEST, under transaction code 20000 or 20400'
    20040:
      id: 'order_modify_cancel_request_trimmed_message'
      doc: 'Trimmed order modification and cancellation request, and the same structure sent as an immediate acknowledgement request. The body text names it MS_OM_REQUEST_TR where the appendix table names it ORDER_OM_REQUEST_TR'
    20070:
      id: 'order_modify_cancel_request_trimmed_message_20070'
      doc: 'Trimmed order modification and cancellation request, and the same structure sent as an immediate acknowledgement request. The body text names it MS_OM_REQUEST_TR where the appendix table names it ORDER_OM_REQUEST_TR'
    20402:
      id: 'order_modify_cancel_request_trimmed_message_20402'
      doc: 'Trimmed order modification and cancellation request, and the same structure sent as an immediate acknowledgement request. The body text names it MS_OM_REQUEST_TR where the appendix table names it ORDER_OM_REQUEST_TR'
    20404:
      id: 'order_modify_cancel_request_trimmed_message_20404'
      doc: 'Trimmed order modification and cancellation request, and the same structure sent as an immediate acknowledgement request. The body text names it MS_OM_REQUEST_TR where the appendix table names it ORDER_OM_REQUEST_TR'
    20012:
      id: 'order_modify_cancel_response_trimmed_message'
      doc: 'Trimmed response to an order entry, modification or cancellation: a confirmation, a rejection, a price confirmation or an order error'
    20042:
      id: 'order_modify_cancel_response_trimmed_message_20042'
      doc: 'Trimmed response to an order entry, modification or cancellation: a confirmation, a rejection, a price confirmation or an order error'
    20072:
      id: 'order_modify_cancel_response_trimmed_message_20072'
      doc: 'Trimmed response to an order entry, modification or cancellation: a confirmation, a rejection, a price confirmation or an order error'
    20073:
      id: 'order_modify_cancel_response_trimmed_message_20073'
      doc: 'Trimmed response to an order entry, modification or cancellation: a confirmation, a rejection, a price confirmation or an order error'
    20074:
      id: 'order_modify_cancel_response_trimmed_message_20074'
      doc: 'Trimmed response to an order entry, modification or cancellation: a confirmation, a rejection, a price confirmation or an order error'
    20075:
      id: 'order_modify_cancel_response_trimmed_message_20075'
      doc: 'Trimmed response to an order entry, modification or cancellation: a confirmation, a rejection, a price confirmation or an order error'
    20231:
      id: 'order_modify_cancel_response_trimmed_message_20231'
      doc: 'Trimmed response to an order entry, modification or cancellation: a confirmation, a rejection, a price confirmation or an order error'
    20222:
      id: 'trade_confirmation_trimmed_message'
      doc: 'Trimmed trade confirmation, sent when an order of a trimmed book type trades'
    20401:
      id: 'quick_acknowledgement_message'
      doc: 'Immediate acknowledgement of a trimmed order entry, modification or cancellation request, answered on the separate port of the gateway router server'
    20403:
      id: 'quick_acknowledgement_message_20403'
      doc: 'Immediate acknowledgement of a trimmed order entry, modification or cancellation request, answered on the separate port of the gateway router server'
    20405:
      id: 'quick_acknowledgement_message_20405'
      doc: 'Immediate acknowledgement of a trimmed order entry, modification or cancellation request, answered on the separate port of the gateway router server'

