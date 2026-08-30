# ---------------------------------------------------------------------
# Kaitai struct definition for: Asx AsxSecurities Trade Ouch v2.0
#
# Protocol:
#   Organization: Australian Securities Exchange
#   Protocol: Asx Trade
#   Encoding: Ouch
#   Version: 2.0
#   Date: 04/01/2015
#   Specification: asx_036435.pdf
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
  id: asx_asxsecurities_trade_ouch_v2_0_server
  title: Asx AsxSecurities Trade Ouch v2.0
  license: GPL-3.0
  endian: be

doc: 'Australian Securities Exchange Asx Securities Asx Trade Ouch v2.0'

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::order_accepted_message': order_accepted_message
            'sequenced_message_type::order_rejected_message': order_rejected_message
            'sequenced_message_type::order_replaced_message': order_replaced_message
            'sequenced_message_type::order_cancelled_message': order_cancelled_message
            'sequenced_message_type::order_executed_message': order_executed_message
  order_accepted_message:
    seq:
      - id: timestamp_nanoseconds
        type: u8
        doc: 'UNIX time (number of nanoseconds since 1970-01-01 00:00:00 UTC)'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated order identifier'
      - id: order_book_id
        type: u4
        doc: 'Order book identifier (i.e. the instrument identifier)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being entered'
      - id: order_id
        type: u8
        doc: 'The order identifier assigned to the order by ASX Trade'
      - id: quantity
        type: u8
        doc: 'Order quantity'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order (signed integer). Implied decimal with scale 1e-2'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'The time validity of the order'
      - id: open_close
        type: u1
        doc: 'Not used by ASX. Set to zero'
      - id: client_account
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client – a free text field typically used by the customer to indicate the ultimate client making the order'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Current state of the order'
      - id: customer_info
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer information – a free text field typically used by the customer to indicate the own order identifier'
      - id: exchange_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'A free text field used at the customer''s discretion'
      - id: clearing_participant
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing participant identifier'
      - id: crossing_key
        type: u4
        doc: 'Crossing key for Unintentional Crossing Prevention. When two orders from the same customer with the same crossing key trade out, the resulting trade is treated like a booked transaction and not published to the market as a trade. 0 (zero) means no Unintentional Crossing Prevention for this order'
      - id: capacity_of_participant
        type: u1
        enum: capacity_of_participant
        doc: 'Capacity of the participant'
      - id: directed_wholesale
        type: u1
        enum: directed_wholesale
        doc: 'Directed wholesale indicator for agency orders and transactions'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution venue'
      - id: intermediary_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Intermediary identifier for agency orders and transactions'
      - id: order_origin
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Origin or order information for agency orders and transactions'
      - id: filler
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ignore, not currently used'
      - id: ouch_order_type
        type: u1
        enum: ouch_order_type
        doc: 'OUCH order type'
      - id: short_sell_quantity
        type: u8
        doc: 'For short sell orders, the portion of the quantity that is short'
      - id: minimum_acceptable_quantity
        type: u8
        doc: 'MAQ of Centre Point Block order, Any Price Block order or Limit Sweep order when executing in Centre Point. Specifies the minimum quantity that must be traded in each execution cycle'
  order_rejected_message:
    seq:
      - id: timestamp_nanoseconds
        type: u8
        doc: 'UNIX time (number of nanoseconds since 1970-01-01 00:00:00 UTC)'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated order identifier'
      - id: reject_code
        type: u4
        doc: 'ASX Trade error code'
  order_replaced_message:
    seq:
      - id: timestamp_nanoseconds
        type: u8
        doc: 'UNIX time (number of nanoseconds since 1970-01-01 00:00:00 UTC)'
      - id: replacement_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The original order token used when the order was entered, or the replacement order token from any prior amendments'
      - id: previous_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The original order token used when the order was entered, not from any prior amendments'
      - id: order_book_id
        type: u4
        doc: 'Order book identifier (i.e. the instrument identifier)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being entered'
      - id: order_id
        type: u8
        doc: 'The order identifier assigned to the order by ASX Trade'
      - id: quantity
        type: u8
        doc: 'Order quantity'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order (signed integer). Implied decimal with scale 1e-2'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'The time validity of the order'
      - id: open_close
        type: u1
        doc: 'Not used by ASX. Set to zero'
      - id: client_account
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client – a free text field typically used by the customer to indicate the ultimate client making the order'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Current state of the order'
      - id: customer_info
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer information – a free text field typically used by the customer to indicate the own order identifier'
      - id: exchange_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'A free text field used at the customer''s discretion'
      - id: clearing_participant
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing participant identifier'
      - id: crossing_key
        type: u4
        doc: 'Crossing key for Unintentional Crossing Prevention. When two orders from the same customer with the same crossing key trade out, the resulting trade is treated like a booked transaction and not published to the market as a trade. 0 (zero) means no Unintentional Crossing Prevention for this order'
      - id: capacity_of_participant
        type: u1
        enum: capacity_of_participant
        doc: 'Capacity of the participant'
      - id: directed_wholesale
        type: u1
        enum: directed_wholesale
        doc: 'Directed wholesale indicator for agency orders and transactions'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution venue'
      - id: intermediary_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Intermediary identifier for agency orders and transactions'
      - id: order_origin
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Origin or order information for agency orders and transactions'
      - id: filler
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ignore, not currently used'
      - id: ouch_order_type
        type: u1
        enum: ouch_order_type
        doc: 'OUCH order type'
      - id: short_sell_quantity
        type: u8
        doc: 'For short sell orders, the portion of the quantity that is short'
      - id: minimum_acceptable_quantity
        type: u8
        doc: 'MAQ of Centre Point Block order, Any Price Block order or Limit Sweep order when executing in Centre Point. Specifies the minimum quantity that must be traded in each execution cycle'
  order_cancelled_message:
    seq:
      - id: timestamp_nanoseconds
        type: u8
        doc: 'UNIX time (number of nanoseconds since 1970-01-01 00:00:00 UTC)'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated order identifier'
      - id: order_book_id
        type: u4
        doc: 'Order book identifier (i.e. the instrument identifier)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being entered'
      - id: order_id
        type: u8
        doc: 'The order identifier assigned to the order by ASX Trade'
      - id: reason
        type: u1
        enum: reason
        doc: 'The reason for the cancellation'
  order_executed_message:
    seq:
      - id: timestamp_nanoseconds
        type: u8
        doc: 'UNIX time (number of nanoseconds since 1970-01-01 00:00:00 UTC)'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated order identifier'
      - id: order_book_id
        type: u4
        doc: 'Order book identifier (i.e. the instrument identifier)'
      - id: traded_quantity
        type: u8
        doc: 'Quantity that traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price that the order traded at (signed integer). Note: Number of decimals is specified in the ITCH Order Book Directory message: ASX Trade ITCH and Glimpse Specification. The number of decimal places for prices in ASX Trade OUCH is universally set to two decimal places, regardless of the configured number of decimal places for the instrument in ASX Trade. Implied decimal with scale 1e-2'
      - id: match_id
        size: 12
        doc: 'Assigned by ASX Trade to each match executed'
      - id: deal_source
        type: u2
        doc: 'The deal source is a numeric code that gives information about how the execution took place. The code matches the deal_source_c variable disseminated in the ASX Trade Open Interface. Applicable values for OUCH: 1 = Single series to single series auto-matched during continuous trading. 20 = Single series to single series auto-matched during an auction. 36 = Tailor made combination match. 43 = Combination order matched against outright legs. 44 = Booked transaction resulting from Unintentional Crossing Prevention. 45 = Booked transaction resulting from Unintentional Crossing Prevention during an auction. 46 = Centre Point Preference Matched trade. 47 = Centre Point trade. 48 = Centre Point booked transaction resulting from Unintentional Crossing Prevention. 49 = Reserved for future use. 50 = Block Trade. 51 = Preference Block Trade. 52 = Reserved for future use)'
      - id: match_attributes
        type: match_attributes
        doc: 'Match attributes of the executed order'
  match_attributes:
    seq:
      - id: passive_aggressive_indicator
        type: b1
        doc: 'Last Traded Price'
      - id: crossing_dealing_capacity
        type: b2
        doc: 'Crossing Dealing Capacity'
      - id: reserved
        type: b5
        doc: 'Reserved'
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0

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
  unsequenced_message_type:
    0x4f:
      id: 'enter_order_message'
      doc: 'The Enter Order message is used to enter a new order into the market. The response to a successful Enter Order message is an Order Accepted message. If the order is rejected, the Order Rejected message will be returned.'
    0x55:
      id: 'replace_order_message'
      doc: 'The Replace Order message is used to amend an existing order that was entered with ASX Trade OUCH. The response to a successful Replace Order message is an Order Replaced message. If the amendment is rejected, the Order Rejected message will be returned.'
    0x58:
      id: 'cancel_order_message'
      doc: 'The Cancel Order message is used to cancel an existing order that was entered with ASX Trade OUCH, using the order token to identify the order being cancelled. The response to a successful Cancel Order message is an Order Cancelled message. If the cancellation is rejected, the Order Rejected message will be returned.'
    0x59:
      id: 'cancel_by_order_id_message'
      doc: 'The Cancel By Order ID message is used to cancel an existing own customer order that was entered with ASX Trade OUCH or another protocol (for example the OMNet API), using the order ID to identify the order being cancelled. The response to a successful Cancel By Order ID message is an Order Cancelled message. If the cancellation is rejected, the Order Rejected message will be returned.'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
    0x54:
      id: 'short_sell_order'
      doc: 'Short Sell Order'
    0x43:
      id: 'buy_order_in_a_combination'
      doc: 'Buy Order In A Combination Where The Sell Legs Are Short Sells'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    3:
      id: 'fill_and_kill'
      doc: 'Fill And Kill'
    4:
      id: 'fill_or_kill'
      doc: 'Fill Or Kill'
  capacity_of_participant:
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x4d:
      id: 'mixed_agency_and_principal'
      doc: 'Mixed Agency And Principal'
  directed_wholesale:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_default'
      doc: 'False Default'
  ouch_order_type:
    0x59:
      id: 'limit_order'
      doc: 'Limit Order'
    0x4e:
      id: 'centre_point_order'
      doc: 'Centre Point Order Midpoint Only'
    0x44:
      id: 'centre_point_order_x44'
      doc: 'Centre Point Order Dark Limit Order'
    0x53:
      id: 'sweep_order'
      doc: 'Sweep Order Can Be Dualposted If Entered Price Is At Halftick'
    0x50:
      id: 'dualposted_sweep_order'
      doc: 'Dualposted Sweep Order Midtick Flag Enabled'
    0x42:
      id: 'centre_point_block_order_with_single_fill_maq'
      doc: 'Centre Point Block Order Midpoint Only With Single Fill Maq'
    0x46:
      id: 'centre_point_order_with_single_fill_maq'
      doc: 'Centre Point Order Dark Limit Order With Single Fill Maq'
    0x54:
      id: 'limit_sweep_order_with_single_fill_maq'
      doc: 'Limit Sweep Order Can Be Dualposted If Entered Price Is At Halftick With Single Fill Maq'
    0x43:
      id: 'any_price_block_order'
      doc: 'Any Price Block Order'
    0x45:
      id: 'any_price_block_order_with_single_fill_maq'
      doc: 'Any Price Block Order With Single Fill Maq'
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
  sequenced_message_type:
    0x41:
      id: 'order_accepted_message'
      doc: 'The Order Accepted message acknowledges the receipt and acceptance of a valid Enter Order message. The data fields from the Enter Order message are echoed back in the Order Accepted message, but some of the accepted values may differ from the entered values for some fields, depending on the state of the order. If the order for example traded immediately at entry, the Order Accepted message will show the state of the order after the trade.'
    0x4a:
      id: 'order_rejected_message'
      doc: 'This message is returned when an Enter Order, Replace Order, Cancel Order or Cancel By Order ID message is rejected'
    0x55:
      id: 'order_replaced_message'
      doc: 'The Order Replaced message acknowledges the receipt and acceptance of a valid Replace Order message.'
    0x43:
      id: 'order_cancelled_message'
      doc: 'The Order Cancelled message informs the ASX Trade OUCH user that an order has been cancelled. This could be to acknowledge a Cancel Order or Cancel By Order Id message, or it could be as a result of system cancellation of an order.'
    0x45:
      id: 'order_executed_message'
      doc: 'The Order Executed message is returned when an order partially or fully trades.'
  order_state:
    1:
      id: 'on_book'
      doc: 'On Book'
    2:
      id: 'not_on_book'
      doc: 'Not On Book'
    99:
      id: 'ouch_ownership_lost'
      doc: 'Ouch Ownership Lost'
  reason:
    1:
      id: 'cancelled_by_user'
      doc: 'Cancelled By User'
    4:
      id: 'order_inactivated_due_to_connection_loss'
      doc: 'Order Inactivated Due To Connection Loss'
    9:
      id: 'fill_and_kill_order_that_was_deleted_in_an_auction'
      doc: 'Fill And Kill Order That Was Deleted In An Auction'
    10:
      id: 'order_deleted_by_asx_on_behalf_of_the_customer'
      doc: 'Order Deleted By Asx On Behalf Of The Customer'
    20:
      id: 'deleted_by_system_due_to_instrument_session_change'
      doc: 'Deleted By System Due To Instrument Session Change'
    21:
      id: 'inactivated_by_system_due_to_instrument_session_change'
      doc: 'Inactivated By System Due To Instrument Session Change'
    24:
      id: 'inactivated_day_order'
      doc: 'Inactivated Day Order'

