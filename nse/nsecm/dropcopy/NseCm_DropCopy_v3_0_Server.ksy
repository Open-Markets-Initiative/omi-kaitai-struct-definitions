# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCm DropCopy NnfDc v3.0
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Drop Copy
#   Encoding: Non-Neat Front End Drop Copy
#   Version: 3.0
#   Date: 9/1/2025
#   Specification: DC_CM_Normal_DROPCOPY_PROTOCOL_3.0_0.pdf
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
  id: nse_nsecm_dropcopy_nnfdc_v3_0_server
  title: Nse NseCm DropCopy NnfDc v3.0
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Capital Market Drop Copy NnfDc v3.0'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: server_drop_copy_packet
    type: server_drop_copy_packet_struct
    repeat: eos
    doc: 'One drop copy packet sent by the host, carrying a packed buffer of messages'

types:
  server_drop_copy_packet_struct:
    seq:
      - id: packet_header
        type: packet_header
        doc: 'Drop copy twenty two byte packet header'
      - id: response_message_header
        type: response_message_header
        doc: 'RESPONSE_MESSAGE_HEADER, present once per packet however many messages are packed behind it'
      - id: message_buffer
        type: message_buffer
        doc: 'Messages packed in Fifo order, inflated first when Compression Indicator says they arrive compressed'
  packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the whole packet including its own two bytes, capped at 1400'
      - id: packet_sequence_number
        type: u4
        doc: 'Packet counter, starting at one on a fresh connection and incrementing for every packet'
      - id: checksum
        size: 16
        doc: 'Md5 digest of the message data on the registration request, and the Gcm authentication tag over it on every packet after'
  response_message_header:
    seq:
      - id: environment_type
        type: u1
        enum: environment_type
        doc: 'Which environment the host is, as a digit'
      - id: compression_indicator
        type: u1
        enum: compression_indicator
        doc: 'Whether the message buffer behind this header is Lz4 compressed'
  message_buffer:
    seq:
      - id: server_message
        type: server_message
        repeat: eos
        doc: 'One packed drop copy message sent by the host'
  server_message:
    seq:
      - id: message_header
        type: message_header
        doc: 'MESSAGE_HEADER'
      - id: server_message_payload
        size: message_header.message_length - 14
        type:
          switch-on: message_header.transaction_code
          cases:
            'transaction_code::gr_response_message': gr_response_message
            'transaction_code::dc_signon_out_message': dc_signon_out_message
            'transaction_code::dc_error_response_trade_message': dc_error_response_trade_message
            'transaction_code::dc_error_response_order_message': dc_error_response_order_message
            'transaction_code::trade_confirmation_message': trade_confirmation_message
            'transaction_code::trade_cancel_confirm_message': trade_cancel_confirm_message
            'transaction_code::trade_cancel_reject_message': trade_cancel_reject_message
            'transaction_code::trade_modify_confirm_message': trade_modify_confirm_message
            'transaction_code::price_confirmation_message': price_confirmation_message
            'transaction_code::order_mod_reject_message': order_mod_reject_message
            'transaction_code::order_cancel_reject_message': order_cancel_reject_message
            'transaction_code::order_confirmation_message': order_confirmation_message
            'transaction_code::order_mod_confirmation_message': order_mod_confirmation_message
            'transaction_code::order_cancel_confirmation_message': order_cancel_confirmation_message
            'transaction_code::freeze_to_control_message': freeze_to_control_message
            'transaction_code::on_stop_notification_message': on_stop_notification_message
            'transaction_code::order_error_message': order_error_message
            'transaction_code::batch_order_cancel_message': batch_order_cancel_message
  message_header:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Type of message sent or received'
      - id: error_code
        type: s2
        doc: 'Zero when the request succeeded, otherwise an Error Response follows'
      - id: sequence_number
        type: s8
        doc: 'Last sequence number received by the user, zero to retrieve from the beginning of the trading day'
      - id: message_length
        type: s2
        doc: 'Length of the entire message including the fourteen byte message header'
  gr_response_message:
    seq:
      - id: message_indicator
        type: s2
        enum: message_indicator
        doc: 'Whether a further response follows: zero for an interim message, one for the last'
      - id: partition_count
        type: s2
        doc: 'Count of partition details present in this message'
      - id: ip_details_partition_wise
        type: ip_details_partition_wise
        doc: 'IP_DETAILS_PARTITION_WISE'
      - id: session_key
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session Key for the validated session'
      - id: cryptographic_key
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cryptographic key for encrypting and decrypting every message to the allocated gateway server'
      - id: cryptographic_iv
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cryptographic Initialization Vector for encrypting and decrypting every message to the allocated gateway server'
  ip_details_partition_wise:
    seq:
      - id: ip_address
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'IP address of the drop copy gateway'
      - id: port
        type: s4
        doc: 'Port of the drop copy gateway'
      - id: partition_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Partition or stream the packet is sent from'
  dc_signon_out_message:
    seq:
      - id: user_id
        type: s4
        doc: 'User Id of the user'
      - id: partition_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Partition or stream the packet is sent from'
      - id: concurrent_login_id
        type: s2
        doc: 'Concurrent login number of the user for which the user has logged in'
  dc_error_response_trade_message:
    seq:
      - id: error_message
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'The error message describing the error received'
  dc_error_response_order_message:
    seq:
      - id: error_message
        type: str
        size: 128
        encoding: ASCII
        pad-right: 0x20
        doc: 'The error message describing the error received'
  trade_confirmation_message:
    seq:
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: trader_number
        type: s4
        doc: 'Trader or user Id'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_volume
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'Volume remaining after the trade'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: pro_client_short_2
        type: s2
        enum: pro_client_short_2
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: segment_short_2
        type: s2
        enum: segment_short_2
        doc: 'Business segment the trade belongs to'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Member Id'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  st_order_flags:
    seq:
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
      - id: on_stop
        type: b1
        doc: 'Stop loss order, triggered on its trigger price'
      - id: mkt
        type: b1
        doc: 'Market order'
      - id: ato
        type: b1
        doc: 'At the opening order'
      - id: order_flags_reserved_7
        type: b1
        doc: 'Reserved. Named by its position in the container because this structure carries two Reserved bits that are not adjacent'
      - id: stpc
        type: b1
        doc: 'Self trade prevention check'
      - id: order_flags_reserved_5
        type: b1
        doc: 'Reserved. Named by its position in the container because this structure carries two Reserved bits that are not adjacent'
      - id: preopen
        type: b1
        doc: 'Set for a trade in the call auction 2 market, and zero for a normal market trade or a pre open carried forward order'
      - id: frozen
        type: b1
        doc: 'Order is frozen for Nse Control to release'
      - id: modified
        type: b1
        doc: 'Order has been modified'
      - id: traded
        type: b1
        doc: 'Order has traded'
      - id: matched_ind
        type: b1
        doc: 'Order has been matched'
  trade_cancel_confirm_message:
    seq:
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: trader_number
        type: s4
        doc: 'Trader or user Id'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_volume
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'Volume remaining after the trade'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: pro_client_short_2
        type: s2
        enum: pro_client_short_2
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: segment_short_2
        type: s2
        enum: segment_short_2
        doc: 'Business segment the trade belongs to'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Member Id'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  trade_cancel_reject_message:
    seq:
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: trader_number
        type: s4
        doc: 'Trader or user Id'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_volume
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'Volume remaining after the trade'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: pro_client_short_2
        type: s2
        enum: pro_client_short_2
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: segment_short_2
        type: s2
        enum: segment_short_2
        doc: 'Business segment the trade belongs to'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Member Id'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  trade_modify_confirm_message:
    seq:
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: trader_number
        type: s4
        doc: 'Trader or user Id'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: original_volume
        type: s4
        doc: 'Original traded volume'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: remaining_volume
        type: s4
        doc: 'Volume remaining after the trade'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: fill_number
        type: s4
        doc: 'Trade number'
      - id: fill_qty
        type: s4
        doc: 'Traded volume'
      - id: fill_price
        type: decimal_s4_2
        doc: 'Price at which the order traded. Implied decimal with scale 1e-2'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: pro_client_short_2
        type: s2
        enum: pro_client_short_2
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: segment_short_2
        type: s2
        enum: segment_short_2
        doc: 'Business segment the trade belongs to'
      - id: broker_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Member Id'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  price_confirmation_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  order_mod_reject_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  order_cancel_reject_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  order_confirmation_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  order_mod_confirmation_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  order_cancel_confirmation_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  freeze_to_control_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  on_stop_notification_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  order_error_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
  batch_order_cancel_message:
    seq:
      - id: reason_code
        type: s2
        doc: 'Reason code for the order request rejection or the order being frozen'
      - id: token
        type: s4
        doc: 'Security identifier'
      - id: order_number
        type: floating_point_integer
        doc: 'Order number of the trader''s order taking part in the trade'
      - id: book_type
        type: s2
        enum: book_type
        doc: 'Book type the order belongs to'
      - id: buy_sell
        type: s2
        enum: buy_sell
        doc: 'Whether the order taking part is a buy or a sell'
      - id: disclosed_volume
        type: s4
        doc: 'Quantity to be disclosed to the market'
      - id: disclosed_vol_remaining
        type: s4
        doc: 'Disclosed volume remaining after the trade'
      - id: total_vol_remaining
        type: s4
        doc: 'Total quantity remaining from the original quantity after trades'
      - id: volume
        type: s4
        doc: 'Quantity of the order placed'
      - id: price
        type: decimal_s4_2
        doc: 'Order price. Implied decimal with scale 1e-2'
      - id: trigger_price
        type: decimal_s4_2
        doc: 'Price at which a stop loss order is triggered and brought to the market. Implied decimal with scale 1e-2'
      - id: st_order_flags
        type: st_order_flags
        doc: 'Terms attached to the order'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: nnf_field
        type: floating_point_integer
        doc: 'Fifteen digit unique identifier for the product, populated only on Trade Confirmation'
      - id: algo_id
        type: s4
        doc: 'Algo Id issued by the exchange, zero for a non algo order'
      - id: activity_time_in_nanos
        type: dos_nanosecond_timestamp
        doc: 'Activity time in nanoseconds. Nanoseconds since Dos epoch'
      - id: competitor_period
        type: s2
        doc: 'Competitor time set by the exchange at the time of initiation'
      - id: solicitor_period
        type: s2
        doc: 'Solicitor time set by the exchange at the time of initiation'
      - id: auction_number
        type: s2
        doc: 'Auction number, available when the initiation of an auction is broadcast and zero for other books'
      - id: suspended
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the security is suspended'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: pan
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Permanent Account Number'
      - id: segment_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business segment the order belongs to'
      - id: participant_type
        type: u1
        enum: participant_type
        doc: 'Initiator, competitor or solicitor order'
      - id: account_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account Number or client code'
      - id: pro_client_char_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Whether the order is a client, broker or warehousing order'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type of the order'
      - id: settlor
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant responsible for settling the trade through the custodian, defaulting to the Broker Code'
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

enums:
  transaction_code:
    2400:
      id: 'gr_request_message'
      doc: 'Asks the gateway router for the member''s partition list. Carries the Request Message Header alone, with Partition Id sent as zero'
    2401:
      id: 'gr_response_message'
      doc: 'Returns the addresses of every partition the member must connect to, together with the session key and the cryptographic material for those connections'
    23008:
      id: 'gr_secure_user_registration_request_message'
      doc: 'Declares to an allocated gateway server that the member application is using encryption. Sent unencrypted as the first message on each partition connection, carrying the Request Message Header alone'
    23009:
      id: 'gr_secure_user_registration_response_message'
      doc: 'Acknowledges the registration. Carries the Message Header alone, whose Error Code terminates the connection when set'
    23506:
      id: 'heartbeat_message'
      doc: 'Keeps the connection alive, sent after thirty seconds of inactivity. The host disconnects the socket after two missed in succession. Carries the Request Message Header alone'
    2500:
      id: 'dc_signon_in_message'
      doc: 'Logs the member on to a partition of the drop copy service'
    2501:
      id: 'dc_signon_out_message'
      doc: 'Confirms the logon, or terminates the connection when Error Code is set'
    8000:
      id: 'dc_trd_subscription_request_message'
      doc: 'Subscribes to the trade only drop copy on this partition from the named sequence number'
    9000:
      id: 'dc_ont_subscription_request_message'
      doc: 'Subscribes to the order and trade drop copy on this partition from the named sequence number'
    8006:
      id: 'dc_error_response_trade_message'
      doc: 'Rejects a trade only request, the reason given in the Error Code of the Message Header'
    9006:
      id: 'dc_error_response_order_message'
      doc: 'Rejects an order and trade request, the reason given in the Error Code of the Message Header'
    2222:
      id: 'trade_confirmation_message'
      doc: 'Confirms a trade'
    2282:
      id: 'trade_cancel_confirm_message'
      doc: 'Confirms the cancellation of a trade'
    2286:
      id: 'trade_cancel_reject_message'
      doc: 'Rejects a trade cancellation'
    2287:
      id: 'trade_modify_confirm_message'
      doc: 'Confirms the modification of a trade'
    2012:
      id: 'price_confirmation_message'
      doc: 'Confirms the price of an order'
    2042:
      id: 'order_mod_reject_message'
      doc: 'Rejects an order modification'
    2072:
      id: 'order_cancel_reject_message'
      doc: 'Rejects an order cancellation'
    2073:
      id: 'order_confirmation_message'
      doc: 'Confirms an order'
    2074:
      id: 'order_mod_confirmation_message'
      doc: 'Confirms an order modification'
    2075:
      id: 'order_cancel_confirmation_message'
      doc: 'Confirms an order cancellation'
    2170:
      id: 'freeze_to_control_message'
      doc: 'Reports an order frozen and referred to Nse Control'
    2212:
      id: 'on_stop_notification_message'
      doc: 'Reports a stop loss order triggered and brought to the market'
    2231:
      id: 'order_error_message'
      doc: 'Reports an error on an order'
    9002:
      id: 'batch_order_cancel_message'
      doc: 'Reports an order cancelled in a batch cancellation'
  environment_type:
    0x31:
      id: 'production_environment'
      doc: 'Production Environment'
    0x32:
      id: 'prod_parallel_mock_environment'
      doc: 'Prod Parallel (Mock) Environment'
    0x33:
      id: 'testing_environment'
      doc: 'Testing Environment'
  compression_indicator:
    0x30:
      id: 'no_compression_done'
      doc: 'No compression done'
    0x31:
      id: 'data_is_compressed'
      doc: 'Data is compressed'
  message_indicator:
    0:
      id: 'interim_message'
      doc: 'Interim Message'
    1:
      id: 'last_message'
      doc: 'Last Message'
  buy_sell:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
  book_type:
    1:
      id: 'regular_lot_order'
      doc: 'Regular Lot Order'
    2:
      id: 'special_terms_order'
      doc: 'Special Terms Order'
    3:
      id: 'stop_loss_order'
      doc: 'Stop Loss Order'
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
    11:
      id: 'call_auction_1'
      doc: 'Call Auction 1'
    12:
      id: 'call_auction_2'
      doc: 'Call Auction 2'
  pro_client_short_2:
    1:
      id: 'clients_order'
      doc: 'Clients Order'
    2:
      id: 'brokers_order'
      doc: 'Brokers Order'
    4:
      id: 'warehousing_order'
      doc: 'Warehousing Order'
  segment_short_2:
    1:
      id: 'equity_derivatives_fo'
      doc: 'Equity Derivatives Fo'
    2:
      id: 'currency_derivatives'
      doc: 'Currency Derivatives'
    3:
      id: 'capital_markets_cash_equity'
      doc: 'Capital Markets Cash Equity'
    4:
      id: 'slbm_markets'
      doc: 'Slbm Markets'
    5:
      id: 'commodity_derivatives'
      doc: 'Commodity Derivatives'
  participant_type:
    0x49:
      id: 'initiator'
      doc: 'Initiator'
    0x43:
      id: 'competitor_order'
      doc: 'Competitor Order'
    0x53:
      id: 'solicitor_order'
      doc: 'Solicitor Order'
  settlement_type:
    0x30:
      id: 't_0_settlement'
      doc: 'T 0 Settlement'
    0x31:
      id: 't_1_settlement'
      doc: 'T 1 Settlement'
    0x32:
      id: 't_2_settlement'
      doc: 'T 2 Settlement'

