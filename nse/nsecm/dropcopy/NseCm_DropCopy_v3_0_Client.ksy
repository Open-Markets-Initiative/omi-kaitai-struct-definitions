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
  id: nse_nsecm_dropcopy_nnfdc_v3_0_client
  title: Nse NseCm DropCopy NnfDc v3.0
  license: GPL-3.0
  endian: be

doc: 'National Stock Exchange of India Ltd NSE Capital Market Drop Copy NnfDc v3.0'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: client_drop_copy_packet
    type: client_drop_copy_packet_struct
    repeat: eos
    doc: 'One drop copy packet sent by the member, carrying a single message'

types:
  client_drop_copy_packet_struct:
    seq:
      - id: packet_header
        type: packet_header
        doc: 'Drop copy twenty two byte packet header'
      - id: request_message_header
        type: request_message_header
        doc: 'REQUEST_MESSAGE_HEADER'
      - id: client_message_payload
        size: packet_header.packet_length - 46
        type:
          switch-on: request_message_header.transaction_code
          cases:
            'transaction_code::dc_signon_in_message': dc_signon_in_message
            'transaction_code::dc_trd_subscription_request_message': dc_trd_subscription_request_message
            'transaction_code::dc_ont_subscription_request_message': dc_ont_subscription_request_message
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
  request_message_header:
    seq:
      - id: transaction_code
        type: s2
        enum: transaction_code
        doc: 'Type of message sent or received'
      - id: trader_id
        type: s4
        doc: 'Id of the user on whose behalf the order is modified or cancelled'
      - id: request_sequence_number
        type: s8
        doc: 'Sequence number of the messages the member sends'
      - id: partition_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Partition or stream the packet is sent from'
      - id: concurrent_login_id
        type: s2
        doc: 'Concurrent login number of the user for which the user has logged in'
      - id: func_indc
        type: str
        size: 1
        encoding: ASCII
        doc: 'Functionality the connection is for, which on this service is always D for drop copy'
      - id: reserve
        size: 1
        doc: 'Reserved, blank filled as chapter 2 directs for every reserved field'
  dc_signon_in_message:
    seq:
      - id: password
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password entered by the user, blank padded when shorter than eight characters'
      - id: session_key
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session Key for the validated session'
  dc_trd_subscription_request_message:
    seq:
      - id: sequence_number
        type: s8
        doc: 'Last sequence number received by the user, zero to retrieve from the beginning of the trading day'
  dc_ont_subscription_request_message:
    seq:
      - id: sequence_number
        type: s8
        doc: 'Last sequence number received by the user, zero to retrieve from the beginning of the trading day'

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

