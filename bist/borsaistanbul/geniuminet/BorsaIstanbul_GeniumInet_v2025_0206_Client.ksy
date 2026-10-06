# ---------------------------------------------------------------------
# Kaitai struct definition for: Bist BorsaIstanbul GeniumInet Ouch v2025.0206
#
# Protocol:
#   Organization: Borsa İstanbul A.Ş.
#   Protocol: Genium Inet
#   Encoding: Ouch
#   Version: 2025.0206
#   Date: 2/6/2025
#   Specification: bistech-ouch-protocol-specification.pdf
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
  id: bist_borsaistanbul_geniuminet_ouch_v2025_0206_client
  title: Bist BorsaIstanbul GeniumInet Ouch v2025.0206
  license: GPL-3.0
  endian: be

doc: 'Borsa İstanbul A.Ş. Borsa Istanbul Genium Inet Ouch v2025.0206'
doc-ref: https://www.borsaistanbul.com/en/technical-resources/technical-documents

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
        type: u1
        enum: unsequenced_message_type
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::enter_order': enter_order
            'unsequenced_message_type::replace_order': replace_order
            'unsequenced_message_type::cancel_order': cancel_order
            'unsequenced_message_type::cancel_by_order_id': cancel_by_order_id
            'unsequenced_message_type::mass_quote': mass_quote
  enter_order:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated order identifier'
      - id: order_book_id
        type: u4
        doc: 'Order book identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: quantity
        type: u8
        doc: 'Order quantity. Must be a multiple of the Round Lot Size for the order book'
      - id: price
        type: decimal_s4_2
        doc: 'Signed integer price. Number of decimals and allowed tick steps are given by the Order book Directory message in ITCH. Implied decimal with scale 1e-2'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Position update for the account'
      - id: client_account
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-thru field. Mandatory for Fund orders (Agency/Fund Code). Account Info should use this field for the derivatives market'
      - id: customer_info
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-thru client reference field. Non-printable ASCII characters should not exist in this field'
      - id: exchange_info_alpha_32
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client account number. Only the first 16 bytes are used. Account Info should use this field for the equity market'
      - id: display_quantity
        type: u8
        doc: 'Display quantity if reserved order, otherwise set to zero (0)'
      - id: client_category
        type: u1
        enum: client_category
        doc: 'Type of client. Not used by the derivatives market'
      - id: off_hours
        type: u1
        enum: off_hours
        doc: 'Off-hours indicator. Used by the derivatives market'
      - id: smp_level
        type: u1
        enum: smp_level
        doc: 'Indicates the scope of self-match prevention'
      - id: smp_method
        type: u1
        enum: smp_method
        doc: 'Indicates the action that should be undertaken by the trading system in case of a potential self-match'
      - id: smp_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Defines that the order is eligible for self-match prevention. For SMP Level 1, assigned by member; for SMP Level 2, assigned by the exchange'
      - id: reserved_numeric_unsigned_2
        type: u2
        doc: 'Reserved for future use'
  replace_order:
    seq:
      - id: existing_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Should be the Order Token from the original Enter Order, not from any intermediate replaces'
      - id: replacement_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated replacement order identifier. Must not be a token previously used in Enter Order or Replace Order transactions'
      - id: quantity
        type: u8
        doc: 'Order quantity. Must be a multiple of the Round Lot Size for the order book'
      - id: price
        type: decimal_s4_2
        doc: 'Signed integer price. Number of decimals and allowed tick steps are given by the Order book Directory message in ITCH. Implied decimal with scale 1e-2'
      - id: replace_open_close
        type: u1
        enum: replace_open_close
        doc: 'Position update for the account'
      - id: client_account
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-thru field. Mandatory for Fund orders (Agency/Fund Code). Account Info should use this field for the derivatives market'
      - id: customer_info
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-thru client reference field. Non-printable ASCII characters should not exist in this field'
      - id: exchange_info_alpha_32
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client account number. Only the first 16 bytes are used. Account Info should use this field for the equity market'
      - id: display_quantity
        type: u8
        doc: 'Display quantity if reserved order, otherwise set to zero (0)'
      - id: client_category
        type: u1
        enum: client_category
        doc: 'Type of client. Not used by the derivatives market'
      - id: reserved_numeric_unsigned_8
        type: u8
        doc: 'Reserved for future use'
  cancel_order:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated order identifier'
  cancel_by_order_id:
    seq:
      - id: order_book_id
        type: u4
        doc: 'Order book identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the order by the system'
  mass_quote:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated order identifier'
      - id: client_category
        type: u1
        enum: client_category
        doc: 'Type of client. Not used by the derivatives market'
      - id: client_account
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-thru field. Mandatory for Fund orders (Agency/Fund Code). Account Info should use this field for the derivatives market'
      - id: exchange_info_alpha_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client account number'
      - id: num_quote_set
        type: u2
        doc: 'Number of double-sided quotes in the following QuoteSet repeating group. Currently restricted to a maximum of 5'
      - id: quote_set
        type: quote_set
        repeat: expr
        repeat-expr: num_quote_set
        doc: 'One double-sided quote entry in a repeating Mass Quote QuoteSet group. Repeats No Quote Entries times, up to a maximum of 5, within the containing Mass Quote message'
  quote_set:
    seq:
      - id: order_book_id
        type: u4
        doc: 'Order book identifier'
      - id: bid_price
        type: decimal_s4_2
        doc: 'Bid price. Number of decimals and allowed tick steps are given by the Order book Directory message in ITCH. Implied decimal with scale 1e-2'
      - id: offer_price
        type: decimal_s4_2
        doc: 'Offer price. Number of decimals and allowed tick steps are given by the Order book Directory message in ITCH. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u8
        doc: 'Bid quantity'
      - id: offer_size
        type: u8
        doc: 'Offer quantity'
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
      id: 'enter_order'
      doc: 'Enters a new order into the system. The response to a successful Enter Order is an Order Accepted message. If the order is rejected, the Order Rejected message will be returned.'
    0x55:
      id: 'replace_order'
      doc: 'Modifies an existing order entered via OUCH. The response is an Order Replaced message if the modification was successful, or an Order Rejected message if the replace failed.'
    0x58:
      id: 'cancel_order'
      doc: 'Cancels an existing order entered via OUCH. Partial cancels are not supported; use Replace Order to modify an existing order. The response to a successful Cancel Order is an Order Canceled message. Failed Cancel Order messages are rejected with the Order Rejected message.'
    0x59:
      id: 'cancel_by_order_id'
      doc: 'Cancels any order in the book, regardless of which session it was inserted over, using the system-generated Order ID. The response to a successful Cancel by Order Id is an Order Canceled message. Failed requests are rejected with the Order Rejected message.'
    0x51:
      id: 'mass_quote'
      doc: 'Used by market makers to send two-sided quotes into a market. Allows submission of multiple quotes (currently restricted to 5) in a single message. Quotes for different securities must belong to the same partition. One quote (two-sided) per participant per instrument is allowed. Quotes can be replaced or cancelled by sending a new Mass Quote for the same instrument(s).'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x54:
      id: 'short_sell'
      doc: 'Short Sell'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    3:
      id: 'immediate_or_cancel'
      doc: 'Fill And Kill Fa K'
    4:
      id: 'fill_or_kill'
      doc: 'Fill Or Kill'
  open_close:
    0:
      id: 'default_field'
      doc: 'Default For The Account'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'close_net'
      doc: 'Close Net'
  client_category:
    1:
      id: 'client'
      doc: 'Client'
    2:
      id: 'house'
      doc: 'House'
    7:
      id: 'fund'
      doc: 'Fund'
    9:
      id: 'investment_trust'
      doc: 'Investment Trust'
    10:
      id: 'primary_dealer_govt'
      doc: 'Primary Dealer Govt'
    11:
      id: 'primary_dealer_corp'
      doc: 'Primary Dealer Corp'
    12:
      id: 'portfolio_mgmt_company'
      doc: 'Portfolio Mgmt Company'
  off_hours:
    0:
      id: 'normal_hours'
      doc: 'Normal Hours'
    1:
      id: 'off_hour_orders'
      doc: 'Off Hour Orders'
  smp_level:
    0:
      id: 'empty'
      doc: 'Empty'
    1:
      id: 'within_a_member'
      doc: 'Within A Member'
    2:
      id: 'across_members'
      doc: 'Across Members'
  smp_method:
    0:
      id: 'empty'
      doc: 'Empty'
    1:
      id: 'cancel_aggressive'
      doc: 'Cancel Aggressive'
    2:
      id: 'cancel_passive'
      doc: 'Cancel Passive'
    3:
      id: 'cancel_both'
      doc: 'Cancel Both'
  replace_open_close:
    0:
      id: 'no_change'
      doc: 'No Change'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'close_net'
      doc: 'Close Net'
    4:
      id: 'default_field'
      doc: 'Default For The Account'
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
    0x41:
      id: 'order_accepted'
      doc: 'Acknowledges the receipt and acceptance of a valid Enter Order message. The data fields from the Enter Order message are echoed back, though accepted values may differ from entered values for some fields. Accepted messages are guaranteed to come before any Executed or Canceled messages for an order.'
    0x4a:
      id: 'order_rejected'
      doc: 'Used to reject Enter Order messages, Cancel Order messages, and Replace Order messages.'
    0x55:
      id: 'order_replaced'
      doc: 'Acknowledges the receipt and acceptance of a valid Replace Order message. The data fields from the Replace Order message are echoed back, though accepted values may differ from entered values for some fields. Uses the Order State field to denote that a replace was accepted and then automatically canceled when the Order State is Not on book.'
    0x43:
      id: 'order_canceled'
      doc: 'Informs that an order has been canceled. This could be acknowledging a Cancel Order message, or the result of system cancellation. Order Canceled messages are sent when orders are suspended due to connection loss; more than one Order Canceled message may be received for the same order.'
    0x45:
      id: 'order_executed'
      doc: 'Returned when a partial or full fill occurs. In case of a combination order fill, one Order Executed message will be received per leg.'
    0x4b:
      id: 'mass_quote_acknowledgement'
      doc: 'A positive response to a Mass Quote message. Every quote in a mass quote message must be responded to with an individual message (Mass Quote Acknowledgement or Mass Quote Rejection). If the individual quote in mass quote is accepted, the system sends two Mass Quote Acknowledgement messages, for bid and offer side.'
    0x52:
      id: 'mass_quote_rejection'
      doc: 'A negative response to a Mass Quote message. If an individual quote in the mass quote is rejected, a single Mass Quote Rejection is sent for that quote with the Order Book Id populated. If all quotes in the mass quote message are rejected, only one Mass Quote Rejection is sent for the whole request, without an Order Book Id.'
  order_state:
    1:
      id: 'on_book'
      doc: 'On Book'
    2:
      id: 'not_on_book'
      doc: 'Not On Book'
    98:
      id: 'paused'
      doc: 'Paused'
    99:
      id: 'ouch_order_ownership_lost'
      doc: 'Ouch Order Ownership Lost'
  reason:
    1:
      id: 'canceled_by_user_or_other_user'
      doc: 'Canceled By User Or Other User'
    3:
      id: 'trade'
      doc: 'Trade'
    4:
      id: 'inactivate'
      doc: 'Inactivate'
    5:
      id: 'replaced_by_user'
      doc: 'Replaced By User'
    6:
      id: 'new_field'
      doc: 'New'
    8:
      id: 'converted_by_system'
      doc: 'Converted By System'
    9:
      id: 'canceled_by_system'
      doc: 'Canceled By System'
    10:
      id: 'canceled_by_proxy'
      doc: 'Canceled By Proxy'
    11:
      id: 'bait_recalculated'
      doc: 'Bait Recalculated'
    12:
      id: 'triggered_by_system'
      doc: 'Triggered By System'
    13:
      id: 'refreshed_by_system'
      doc: 'Refreshed By System'
    15:
      id: 'canceled_by_system_limit_change'
      doc: 'Canceled By System Limit Change'
    17:
      id: 'linked_leg_canceled'
      doc: 'Linked Leg Canceled'
    18:
      id: 'linked_leg_modified'
      doc: 'Linked Leg Modified'
    19:
      id: 'expired'
      doc: 'Expired'
    20:
      id: 'canceled_due_to_iss'
      doc: 'Canceled Due To Iss'
    21:
      id: 'inactivated_due_to_iss'
      doc: 'Inactivated Due To Iss'
    23:
      id: 'inactivated_due_to_purge'
      doc: 'Inactivated Due To Purge'
    24:
      id: 'inactivated_day_order'
      doc: 'Inactivated Day Order'
    25:
      id: 'inactivated_due_to_delist'
      doc: 'Inactivated Due To Delist'
    26:
      id: 'inactivated_due_to_expiry'
      doc: 'Inactivated Due To Expiry'
    27:
      id: 'inactivated_due_to_outside_limits'
      doc: 'Inactivated Due To Outside Limits'
    28:
      id: 'transfer_of_ownership'
      doc: 'Transfer Of Ownership'
    29:
      id: 'new_inactive'
      doc: 'New Inactive'
    30:
      id: 'reloaded'
      doc: 'Reloaded'
    31:
      id: 'reloaded_intraday'
      doc: 'Reloaded Intraday'
    34:
      id: 'canceled_after_auction'
      doc: 'Canceled After Auction'
    35:
      id: 'inactivated_due_to_outside_price_limits'
      doc: 'Inactivated Due To Outside Price Limits'
    36:
      id: 'activated_due_to_outside_limits'
      doc: 'Activated Due To Outside Limits'
    37:
      id: 'trigger_on_session_order_triggered'
      doc: 'Trigger On Session Order Triggered'
    39:
      id: 'undisclosed_quantity_order_converted'
      doc: 'Undisclosed Quantity Order Converted'
    40:
      id: 'inactivated_due_to_order_value'
      doc: 'Inactivated Due To Order Value'
    41:
      id: 'canceled_by_system_delta_protection'
      doc: 'Canceled By System Delta Protection'
    42:
      id: 'canceled_by_system_quantity_protection'
      doc: 'Canceled By System Quantity Protection'
    43:
      id: 'internal_crossing_delete'
      doc: 'Internal Crossing Delete'
    44:
      id: 'canceled_due_to_participant_block_on_market'
      doc: 'Canceled Due To Participant Block On Market'
    45:
      id: 'inactivated_due_to_participant_block_on_market'
      doc: 'Inactivated Due To Participant Block On Market'
    46:
      id: 'order_deleted_due_to_smp'
      doc: 'Order Deleted Due To Smp'
    52:
      id: 'paused'
      doc: 'Paused'
    53:
      id: 'activated_paused_order'
      doc: 'Activated Paused Order'
    56:
      id: 'linked_leg_activated'
      doc: 'Linked Leg Activated'
    115:
      id: 'deleted_ptrm_misc'
      doc: 'Deleted Ptrm Misc'
    116:
      id: 'deleted_ptrm_user_limits_auto'
      doc: 'Deleted Ptrm User Limits Auto'
    117:
      id: 'deleted_ptrm_user_limits_manual'
      doc: 'Deleted Ptrm User Limits Manual'
    118:
      id: 'deleted_ptrm_market_limits'
      doc: 'Deleted Ptrm Market Limits'
    119:
      id: 'deleted_ptrm_investor_limits'
      doc: 'Deleted Ptrm Investor Limits'
    120:
      id: 'deleted_ptrm_margin_breach'
      doc: 'Deleted Ptrm Margin Breach'
    121:
      id: 'deleted_ptrm_participant_suspension'
      doc: 'Deleted Ptrm Participant Suspension'
    122:
      id: 'deleted_ptrm_mra_suspension'
      doc: 'Deleted Ptrm Mra Suspension'
    123:
      id: 'deleted_ptrm_mca_suspension'
      doc: 'Deleted Ptrm Mca Suspension'
    124:
      id: 'deleted_ptrm_ta_suspension'
      doc: 'Deleted Ptrm Ta Suspension'
    125:
      id: 'canceled_by_ptrm_suspension_product_due_to_investor_position_value_limit'
      doc: 'Canceled By Ptrm Suspension Product Due To Investor Position Value Limit'
  quote_side:
    0x42:
      id: 'bid'
      doc: 'Buy Side Bid'
    0x53:
      id: 'offer'
      doc: 'Sell Side Offer'
  quote_status:
    0:
      id: 'accept'
      doc: 'Accept'
    1:
      id: 'updated'
      doc: 'Updated'
    2:
      id: 'canceled'
      doc: 'Canceled'
    3:
      id: 'unsolicited_update'
      doc: 'Unsolicited Update'
    4:
      id: 'unsolicited_cancel'
      doc: 'Unsolicited Cancel'
    5:
      id: 'traded'
      doc: 'Traded'

