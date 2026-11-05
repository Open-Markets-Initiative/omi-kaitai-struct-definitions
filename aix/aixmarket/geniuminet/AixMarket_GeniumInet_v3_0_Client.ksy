# ---------------------------------------------------------------------
# Kaitai struct definition for: Aix AixMarket GeniumInet Itch v3.0
#
# Protocol:
#   Organization: Astana International Exchange
#   Protocol: Genium Inet
#   Encoding: Itch
#   Version: 3.0
#   Date: 6/4/2026
#   Specification: new_ITCH_ProtSpec_AIX_v3.pdf
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
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: aix_aixmarket_geniuminet_itch_v3_0_client
  title: Aix AixMarket GeniumInet Itch v3.0
  license: MIT-0
  endian: be

doc: 'Astana International Exchange Astana International Exchange Genium Inet Itch v3.0'
doc-ref: https://www.aixkz.com/en/pages/aix-specifications

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type sent by the client'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: _parent.client_packet_header.packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        doc: 'The unsequenced (client to server) message carried by the packet, opaque bytes unless an application source dispatches it'

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x54:
      id: 'seconds_message'
      doc: 'This message is sent every second for which at least one ITCH message is being generated.'
    0x52:
      id: 'order_book_directory_message'
      doc: 'At the start of each trading day, Order book directory messages are disseminated for all active securities, including halted securities, in the AIX Trading system.'
    0x4c:
      id: 'tick_size_table_entry_message'
      doc: 'This message contains information on a tick size for a price range.'
    0x56:
      id: 'short_sell_status_message'
      doc: 'A Short Sell Status Message indicates the short sell rules of an order book.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'The Order book state message relays information on state changes.'
    0x41:
      id: 'add_order_message'
      doc: 'An Add Order Message indicates that a new order has been accepted by the AIX Trading system and was added to the displayable book.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent that an order on the book is executed in whole or in part with a price different than the initial display price.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being deleted.'
    0x59:
      id: 'order_book_flush_message'
      doc: 'This message is sent whenever an order book is flushed.'
    0x50:
      id: 'trade_message'
      doc: 'The Trade Message is designed to provide execution details for normal match events involving non-displayable order types.'
    0x5a:
      id: 'equilibrium_price_update_message'
      doc: 'This message is used when auctions occur.'
  financial_product:
    1:
      id: 'option'
      doc: 'Option'
    2:
      id: 'forward'
      doc: 'Forward'
    3:
      id: 'future'
      doc: 'Future'
    4:
      id: 'fra'
      doc: 'Fra'
    5:
      id: 'cash'
      doc: 'Cash'
    6:
      id: 'payment'
      doc: 'Payment'
    7:
      id: 'exchange_rate'
      doc: 'Exchange Rate'
    8:
      id: 'interest_rate_swap'
      doc: 'Interest Rate Swap'
    9:
      id: 'repo'
      doc: 'Repo'
    10:
      id: 'synthetic_box_leg_reference'
      doc: 'Synthetic Box Leg Reference'
    11:
      id: 'standard_combination'
      doc: 'Standard Combination'
    12:
      id: 'guarantee'
      doc: 'Guarantee'
    13:
      id: 'otc_general'
      doc: 'Otc General'
    14:
      id: 'equity_warrant'
      doc: 'Equity Warrant'
    15:
      id: 'security_lending'
      doc: 'Security Lending'
    18:
      id: 'certificate'
      doc: 'Certificate'
  number_of_decimals_in_nominal_value:
    0: 'zero_decimals'
    1: 'one_decimals'
    2: 'two_decimals'
    3: 'three_decimals'
    4: 'four_decimals'
    5: 'five_decimals'
    6: 'six_decimals'
    7: 'seven_decimals'
    8: 'eight_decimals'
    9: 'nine_decimals'
  number_of_decimals_in_strike_price:
    0: 'zero_decimals'
    1: 'one_decimals'
    2: 'two_decimals'
    3: 'three_decimals'
    4: 'four_decimals'
    5: 'five_decimals'
    6: 'six_decimals'
    7: 'seven_decimals'
    8: 'eight_decimals'
    9: 'nine_decimals'
  put_or_call:
    0:
      id: 'undefined'
      doc: 'Undefined'
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  ranking_type:
    1:
      id: 'price_time'
      doc: 'Price Time'
  short_sale_restriction:
    0:
      id: 'no_restrictions'
      doc: 'No Restrictions'
    1:
      id: 'short_selling_is_not_allowed'
      doc: 'Short Selling Is Not Allowed'
    2:
      id: 'short_selling_is_allowed_with_up_tick_rule'
      doc: 'Short Selling Is Allowed With Up Tick Rule'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
    0x20:
      id: 'blank'
      doc: 'Blank'
  order_attributes:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
  lot_type:
    2:
      id: 'round_lot'
      doc: 'Round Lot'
  occurred_at_cross:
    0x59:
      id: 'trade_occurred_at_the_cross'
      doc: 'Trade Occurred At The Cross'
    0x4e:
      id: 'trade_occurred_at_continuous_market'
      doc: 'Trade Occurred At Continuous Market'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  trade_report:
    0x59:
      id: 'matched_trade_report'
      doc: 'Matched Trade Report'
    0x4e:
      id: 'standard_trade'
      doc: 'Standard Trade'

