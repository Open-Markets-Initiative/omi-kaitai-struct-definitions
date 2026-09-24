# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax PearlEquities DepthOfMarket Mach v1.3.d
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Depth Of Market
#   Encoding: Mach
#   Version: 1.3.d
#   Date: 02/04/2026
#   Specification: pearl_equities_dom_feed_v1.3.d.pdf
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
  id: miax_pearlequities_depthofmarket_mach_v1_3_d_tcp
  title: Miax PearlEquities DepthOfMarket Mach v1.3.d
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Pearl Equities Depth Of Market Mach v1.3.d'
doc-ref: https://www.miaxglobal.com/markets/us-equities/pearl-equities/interface-specifications

seq:
  - id: esesm_tcp_packet
    type: esesm_tcp_packet_struct
    repeat: eos
    doc: 'ESesM Tcp Packet'

types:
  esesm_tcp_packet_struct:
    seq:
      - id: esesm_packet_header
        type: esesm_packet_header
        doc: 'ESesM packet header'
      - id: esesm_payload
        size: esesm_packet_header.esesm_packet_length + 2 - 3
        type:
          switch-on: esesm_packet_header.esesm_packet_type
          cases:
            'esesm_packet_type::sequenced_data_packet': sequenced_data_packet
            'esesm_packet_type::unsequenced_data_packet': unsequenced_data_packet
            'esesm_packet_type::login_request': login_request
            'esesm_packet_type::login_response': login_response
            'esesm_packet_type::synchronization_complete': synchronization_complete
            'esesm_packet_type::retransmission_request': retransmission_request
            'esesm_packet_type::logout_request': logout_request
            'esesm_packet_type::goodbye_packet': goodbye_packet
            'esesm_packet_type::test_packet': test_packet
  esesm_packet_header:
    seq:
      - id: esesm_packet_length
        type: u2
        doc: 'The length of rest of the packet'
      - id: esesm_packet_type
        type: u1
        enum: esesm_packet_type
        doc: 'ESesM protocol packet type'
  sequenced_data_packet:
    seq:
      - id: sequence_number
        type: u8
        doc: 'For Symbol Update/Trading Status/System State refreshes this is the original sequence number from the live feed; for Order Book refresh this is the last sequence number on the live feed at the time of the refresh request'
      - id: matching_engine_id
        type: u1
        doc: 'Matching Engine that originated the packet'
      - id: sequenced_message_type
        type: u1
        doc: 'Market-data application message type carried over the ESesM sequenced channel (matches the MACH UDP Message Type byte)'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: u1
        enum: unsequenced_message_type
        doc: 'Market-data Refresh request/response discriminator carried over the ESesM unsequenced channel (Request Type R, Response Type r, End of Refresh E)'
      - id: unsequenced_message
        size: _parent.esesm_packet_header.esesm_packet_length - 2 - 1
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::refresh_request_message': refresh_request_message
            'unsequenced_message_type::refresh_response_message': refresh_response_message
            'unsequenced_message_type::end_of_refresh_notification_message': end_of_refresh_notification_message
  refresh_request_message:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Identifies the data set the firm is requesting a refresh of'
  refresh_response_message:
    seq:
      - id: sequence_number
        type: u8
        doc: 'For Symbol Update/Trading Status/System State refreshes this is the original sequence number from the live feed; for Order Book refresh this is the last sequence number on the live feed at the time of the refresh request'
  end_of_refresh_notification_message:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Identifies the data set the firm is requesting a refresh of'
  login_request:
    seq:
      - id: esesm_version
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Protocol version'
      - id: username
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX during initial setup'
      - id: computer_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX Futures Exchange during initial setup'
      - id: application_protocol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Miax Application Protocol'
      - id: requested_trading_session_id
        type: u1
        doc: 'Specifies the session the client would like to log into, or zero to log into the currently active session'
      - id: requested_sequence_number
        type: u8
        doc: 'Specifies client requested sequence number'
  login_response:
    seq:
      - id: number_of_matching_engines
        type: u1
        doc: 'Count of all Matching Engines for the exchange'
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Login Status'
      - id: trading_session_id
        type: u1
        doc: 'The current trading session ID of the corresponding Matching Engine'
      - id: highest_sequence_number
        type: u8
        doc: 'the highest sequence number that the server currently has for the client'
  synchronization_complete:
    seq:
      - id: number_of_matching_engines
        type: u1
        doc: 'Count of all Matching Engines for the exchange'
  retransmission_request:
    seq:
      - id: start_sequence_number
        type: u8
        doc: 'Sequence number of the first packet to be retransmitted'
      - id: end_sequence_number
        type: u8
        doc: 'Sequence number of the last packet to be retransmitted'
  logout_request:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.esesm_packet_header.esesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  goodbye_packet:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.esesm_packet_header.esesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  test_packet:
    seq:
      - id: test_text
        type: str
        size: _parent.esesm_packet_header.esesm_packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'

enums:
  mach_packet_type:
    0:
      id: 'heartbeat'
      doc: 'Mach Heartbeat Message'
    1:
      id: 'start_of_session'
      doc: 'Mach Start Of Session Message; Sequence Number is set to 0'
    2:
      id: 'end_of_session'
      doc: 'Mach end of session Message'
    3:
      id: 'application_message'
      doc: 'Mach Application Message'
  message_type:
    49:
      id: 'system_time_message'
      doc: 'This message is used to disseminate the "seconds" part of the timestamp that is applicable to all messages that are sent in the current second.'
    1:
      id: 'symbol_update_message'
      doc: 'This is the message format that will be used to disseminate all security symbols traded on MIAX Pearl Equities for the current trading session. The Symbol ID sent in this message will be disseminated in Depth of Market messages.'
    83:
      id: 'system_state_message'
      doc: 'This is the message format that will be used to notify firms of the state changes of the system. This is a notification that applies to all symbols on the feed.'
    4:
      id: 'security_trading_status_notification_message'
      doc: 'This message is used to notify firms of changes to the trading status of a particular security.'
    5:
      id: 'symbol_clear_message'
      doc: 'This message format is used to indicate that the MIAX Pearl Equities book for a symbol has been cleared of all orders.'
    20:
      id: 'add_order_message'
      doc: 'This is the message format that will be used when a displayed order is received and added to MIAX Pearl Equities book. It includes an Order ID that is unique to the order across the exchange and across trading days.'
    21:
      id: 'modify_order_message'
      doc: 'This message format is used to publish price/size changes for an existing displayed order on MIAX Pearl Equities book.'
    23:
      id: 'delete_order_message'
      doc: 'This message format is used to indicate that a displayed order has been removed from the MIAX Pearl Equities book.'
    24:
      id: 'order_execution_message'
      doc: 'This message format is used when a displayed order on the book executes in whole or in part. The execution is identified by a unique Trade ID that is unique across the exchange for the trading day. Subsequent partial executions of the order would be published with the same Order ID but different Trade ID.'
    10:
      id: 'trade_message'
      doc: 'This message format is used to publish trade executions for orders not displayed on the book. Executions for orders routed and executed in another trading center and trade corrections are also published using this message.'
    11:
      id: 'trade_cancel_message'
      doc: 'This message format is used to publish cancellation of a trade which was previously published via an Order Execution Message or a Trade Message.'
  test_security_indicator:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  primary_market_code:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x46:
      id: 'texas_stock_exchange'
      doc: 'Texas Stock Exchange'
    0x47:
      id: 'n_24_x_exchange'
      doc: 'N 24 X Exchange'
    0x48:
      id: 'miax_pearl_equities'
      doc: 'Miax Pearl Equities'
    0x49:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'cboe_edga_exchange'
      doc: 'Cboe Edga Exchange'
    0x4b:
      id: 'cboe_edgx_exchange'
      doc: 'Cboe Edgx Exchange'
    0x4c:
      id: 'long_term_stock_exchange'
      doc: 'Long Term Stock Exchange'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x4e:
      id: 'new_york_stock_exchange'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x55:
      id: 'members_exchange'
      doc: 'Members Exchange'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x57:
      id: 'cboe_stock_exchange'
      doc: 'Cboe Stock Exchange'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'Nasdaq Phlx'
    0x59:
      id: 'cboe_byx_exchange'
      doc: 'Cboe Byx Exchange'
    0x5a:
      id: 'cboe_bzx_exchange'
      doc: 'Cboe Bzx Exchange'
  system_status:
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x43:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x31:
      id: 'start_of_test_session'
      doc: 'Sent Before Tests'
    0x32:
      id: 'end_of_test_session'
      doc: 'End Of Test Session'
  trading_status:
    1:
      id: 'pre_open'
      doc: 'Pre Open'
    2:
      id: 'trading'
      doc: 'Trading'
    3:
      id: 'halt'
      doc: 'Halt'
    4:
      id: 'operational_halt'
      doc: 'Operational Halt'
    5:
      id: 'closed'
      doc: 'Closed'
  market_state:
    1:
      id: 'pre_opening'
      doc: 'Pre Opening'
    2:
      id: 'early_trading_session'
      doc: 'Early Trading Session'
    3:
      id: 'regular_trading_session'
      doc: 'Regular Trading Session'
    4:
      id: 'late_trading_session'
      doc: 'Late Trading Session'
  short_sale_restriction:
    0x59:
      id: 'short_sale_restriction_is_in_effect'
      doc: 'Short Sale Restriction Is In Effect'
    0x4e:
      id: 'short_sale_restriction_is_not_in_effect'
      doc: 'Short Sale Restriction Is Not In Effect'
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  esesm_packet_type:
    0x73:
      id: 'sequenced_data_packet'
      doc: 'ESesM sequenced data packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'ESesM unsequenced data packet'
    0x6c:
      id: 'login_request'
      doc: 'ESesM Login Request'
    0x72:
      id: 'login_response'
      doc: 'ESesM Login Response'
    0x63:
      id: 'synchronization_complete'
      doc: 'ESesM Synchronization Complete'
    0x61:
      id: 'retransmission_request'
      doc: 'ESesM Retransmission Request'
    0x58:
      id: 'logout_request'
      doc: 'ESesM Logout Request'
    0x47:
      id: 'goodbye_packet'
      doc: 'ESesM Logout Request'
    0x75:
      id: 'trading_session_update'
      doc: 'ESesM Trading Session Update'
    0x30:
      id: 'server_heartbeat'
      doc: 'ESesM Server Heartbeat'
    0x31:
      id: 'client_heartbeat'
      doc: 'ESesM Client Heartbeat'
    0x54:
      id: 'test_packet'
      doc: 'ESesM Test Packet'
  unsequenced_message_type:
    0x52:
      id: 'refresh_request_message'
      doc: 'Sent by the firm over the DoM Retransmission Interface (ESeSM Unsequenced Data Packet) to request a Last Value Refresh of a particular data set identified by Refresh Message Type.'
    0x72:
      id: 'refresh_response_message'
      doc: 'Sent by MIAX Pearl Equities over the DoM Retransmission Interface (ESeSM Unsequenced Data Packet) carrying one Application Message that satisfies a previous Refresh Request.'
    0x45:
      id: 'end_of_refresh_notification_message'
      doc: 'Sent by MIAX Pearl Equities over the DoM Retransmission Interface (ESeSM Unsequenced Data Packet) when the refresh response is complete.'
  refresh_message_type:
    0x53:
      id: 'symbol_update_refresh'
      doc: 'Symbol Update Refresh'
    0x74:
      id: 'security_trading_status_refresh'
      doc: 'Security Trading Status Refresh'
    0x73:
      id: 'system_state_refresh'
      doc: 'System State Refresh'
    0x4f:
      id: 'order_book_refresh'
      doc: 'Order Book Refresh'
  login_status:
    0x20:
      id: 'successful'
      doc: 'Successful'
    0x53:
      id: 'invalid_trading_session_requested'
      doc: 'Invalid trading session requested for the Matching Engine'
    0x55:
      id: 'no_active_trading_session_exists'
      doc: 'No active trading session exists for the Matching Engine, Matching Engine unavailable'
    0x58:
      id: 'rejected'
      doc: 'Invalid Username/Computer ID combination'
    0x4e:
      id: 'invalid_start_sequence_number_requested'
      doc: 'Invalid start sequence number requested'
    0x49:
      id: 'incompatible_session_protocol_version'
      doc: 'Incompatible Session protocol version'
    0x41:
      id: 'incompatible_application_protocol_version'
      doc: 'Incompatible application protocol version'
    0x4c:
      id: 'request_rejected_because_client_already_logged_in'
      doc: 'Request rejected because client already logged in'
  logout_reason:
    0x20:
      id: 'graceful_logout'
      doc: 'Graceful Logout'
    0x42:
      id: 'bad_packet'
      doc: 'Bad SesM packet'
    0x4c:
      id: 'timed_out'
      doc: 'Timed out waiting for Login Packet'
    0x41:
      id: 'application_terminating_connection'
      doc: 'Application terminating connection'

