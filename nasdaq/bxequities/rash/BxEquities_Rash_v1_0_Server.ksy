# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq BxEquities Rash AsciiRash v1.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Rash
#   Encoding: Ascii Rash
#   Version: 1.0
#   Date: 03/11/2020
#   Specification: NQBX_RASH.pdf
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
  id: nasdaq_bxequities_rash_asciirash_v1_0_server
  title: Nasdaq BxEquities Rash AsciiRash v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq BX Rash AsciiRash v1.0'
doc-ref:
  - https://www.nasdaqtrader.com/Trader.aspx?id=TradingSpecs
  - https://www.nasdaqtrader.com/content/technicalsupport/specifications/TradingProducts/NQBX_RASH.pdf

seq:
  - id: server_packet_header
    type: server_packet_header_struct
    doc: 'SoupTcp Packet Header sent by the server'
  - id: server_payload
    type:
      switch-on: server_packet_header.server_packet_type
      cases:
        'server_packet_type::debug_packet': debug_packet
        'server_packet_type::login_accepted_packet': login_accepted_packet
        'server_packet_type::login_rejected_packet': login_rejected_packet
        'server_packet_type::sequenced_data_packet': sequenced_data_packet
  - id: soup_lf
    type: u1
    doc: 'Terminating line feed character'

types:
  server_packet_header_struct:
    seq:
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type'
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
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
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
      - id: sequenced_message_header
        type: sequenced_message_header
        doc: 'Time Stamp and type carried ahead of every RASH outbound sequenced message'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::accepted_order_message': accepted_order_message
            'sequenced_message_type::accepted_order_message_with_cross_functionality': accepted_order_message_with_cross_functionality
            'sequenced_message_type::canceled_order_message': canceled_order_message
            'sequenced_message_type::rejected_order_message': rejected_order_message
            'sequenced_message_type::executed_order_message': executed_order_message
            'sequenced_message_type::broken_trade_message': broken_trade_message
  sequenced_message_header:
    seq:
      - id: timestamp
        type: millisecond_ascii_timestamp
        doc: 'Milliseconds past midnight Eastern, 8 ascii digits right justified and zero filled. Milliseconds since Midnight epoch'
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Code identifying the RASH outbound message type'
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Codes'
  accepted_order_message:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: side
        type: u1
        enum: side
        doc: 'B/S/T/E: Buy, Sell, Short, Short Exempt. For sell short and sell short exempt, the subscriber affirms the ability to borrow securities in good deliverable form for delivery within three business days'
      - id: shares_order_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Total number of shares entered. Must be greater than zero'
      - id: stock_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price, 6 whole and 4 implied decimal digits. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of seconds that this order should live before being automatically canceled; special values (0 = Immediate or Cancel, 99998 = Market Day, 99999 = system day and the others the document lists) are listed in section 2.1.1'
      - id: firm_client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MPID'
      - id: display
        type: u1
        enum: display
        doc: 'Display instruction; see the Display values'
      - id: order_reference_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'The day-unique Order Reference Number assigned by the system to this order'
      - id: min_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum fill amount allowed'
      - id: max_floor
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to display. If zero this field will default to the order quantity. Use the display field to specify a hidden order'
      - id: peg_type
        type: u1
        enum: peg_type
        doc: 'Peg type'
      - id: peg_difference_sign
        type: u1
        enum: peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: discretion_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Discretion Price for Discretionary Order. If set to 0, this order does not have discretion. Implied decimal with scale 1e-4'
      - id: discretion_peg_type
        type: u1
        enum: discretion_peg_type
        doc: 'Discretion peg type'
      - id: discretion_peg_difference_sign
        type: u1
        enum: discretion_peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: discretion_peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: capacity_rule_80_a_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Capacity code'
      - id: random_reserve
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to do random reserve with'
      - id: route_dest_exec_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Target ID: a routing strategy or a directed order destination code'
      - id: cust_terminal_id_sender_sub_id
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client initiated; pass-thru. Must be left-justified'
  accepted_order_message_with_cross_functionality:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: side
        type: u1
        enum: side
        doc: 'B/S/T/E: Buy, Sell, Short, Short Exempt. For sell short and sell short exempt, the subscriber affirms the ability to borrow securities in good deliverable form for delivery within three business days'
      - id: shares_order_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Total number of shares entered. Must be greater than zero'
      - id: stock_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price, 6 whole and 4 implied decimal digits. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of seconds that this order should live before being automatically canceled; special values (0 = Immediate or Cancel, 99998 = Market Day, 99999 = system day and the others the document lists) are listed in section 2.1.1'
      - id: firm_client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MPID'
      - id: display
        type: u1
        enum: display
        doc: 'Display instruction; see the Display values'
      - id: order_reference_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'The day-unique Order Reference Number assigned by the system to this order'
      - id: min_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum fill amount allowed'
      - id: max_floor
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to display. If zero this field will default to the order quantity. Use the display field to specify a hidden order'
      - id: peg_type
        type: u1
        enum: peg_type
        doc: 'Peg type'
      - id: peg_difference_sign
        type: u1
        enum: peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: discretion_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Discretion Price for Discretionary Order. If set to 0, this order does not have discretion. Implied decimal with scale 1e-4'
      - id: discretion_peg_type
        type: u1
        enum: discretion_peg_type
        doc: 'Discretion peg type'
      - id: discretion_peg_difference_sign
        type: u1
        enum: discretion_peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: discretion_peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: capacity_rule_80_a_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Capacity code'
      - id: random_reserve
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to do random reserve with'
      - id: route_dest_exec_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Target ID: a routing strategy or a directed order destination code'
      - id: cust_terminal_id_sender_sub_id
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client initiated; pass-thru. Must be left-justified'
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
        doc: 'Inter-market sweep eligibility'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross type'
  canceled_order_message:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        doc: 'Specify zero to cancel the order; otherwise the new intended order size'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'The reason the order was reduced or canceled. See Cancel Order Reasons'
  rejected_order_message:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: reject_reason
        type: u1
        enum: reject_reason
        doc: 'See Rejected Order Reasons'
  executed_order_message:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        doc: 'Specify zero to cancel the order; otherwise the new intended order size'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price, 6 whole and 4 implied decimal digits. Implied decimal with scale 1e-4'
      - id: liquidity
        type: u1
        enum: liquidity
        doc: 'See Liquidity Flags'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'Assigned to each match executed. Each match consists of one buy and one sell; the matching buy and sell executions share the same match number'
  broken_trade_message:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The order Token field as entered'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'Assigned to each match executed. Each match consists of one buy and one sell; the matching buy and sell executions share the same match number'
      - id: broken_trade_reason
        type: u1
        enum: broken_trade_reason
        doc: 'The reason the trade was broken. See Broken Trade Reasons'
  millisecond_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      hour:
        value: text.to_i / 3600000 % 24
      minute:
        value: text.to_i / 60000 % 60
      second:
        value: text.to_i / 1000 % 60
      millisecond:
        value: text.to_i % 1000

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SoupTcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupTcp Logout Request Packet'
  unsequenced_message_type:
    0x4f:
      id: 'enter_order_message'
      doc: 'The Enter Order Message lets you enter a new order. Each new order must have a Token that is unique to the day and that logical RASH Port account. If you send a valid order, you should receive an Accepted Order Message.'
    0x51:
      id: 'enter_order_message_with_cross_functionality'
      doc: 'Enters orders in much the same way as the Enter Order Message, with a few additional fields. Notably, the Cross Type Flag allows you to specify that an order begins participation in a cross.'
    0x58:
      id: 'cancel_order_message'
      doc: 'Requests that an order be canceled. A Shares field of zero cancels the entire balance of the order; otherwise Shares is the new intended order size.'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x54:
      id: 'short_field'
      doc: 'Sell Short'
    0x45:
      id: 'short_exempt'
      doc: 'Sell Short Exempt'
  display:
    0x59:
      id: 'anonymous_price_to_comply'
      doc: 'Anonymous Price To Comply'
    0x4e:
      id: 'non_displayed'
      doc: 'Non Displayed'
    0x41:
      id: 'attributable_price_to_display'
      doc: 'Attributable Price To Display'
    0x49:
      id: 'imbalance_only'
      doc: 'Imbalance Only'
    0x50:
      id: 'post_only'
      doc: 'Post Only For Stocks Over 1 Bx Post Only Orders Will Remove Liquidity At Any Price Equal To Or Better Than Its Limit'
    0x57:
      id: 'mid_point_peg_post_only'
      doc: 'Mid Point Peg Post Only'
    0x4d:
      id: 'mid_point_peg'
      doc: 'Mid Point Peg'
    0x4f:
      id: 'retail_order_type_1'
      doc: 'Retail Order Type 1'
    0x54:
      id: 'retail_order_type_2'
      doc: 'Retail Order Type 2'
    0x51:
      id: 'retail_price_improvement_order'
      doc: 'Retail Price Improvement Order'
  peg_type:
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint'
    0x4e:
      id: 'no_peg'
      doc: 'No Peg'
    0x50:
      id: 'market'
      doc: 'Market'
    0x52:
      id: 'primary'
      doc: 'Primary'
  peg_difference_sign:
    0x2b:
      id: 'plus'
      doc: 'Positive Peg Difference'
    0x2d:
      id: 'minus'
      doc: 'Negative Peg Difference'
  discretion_peg_type:
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint'
    0x4e:
      id: 'no_peg'
      doc: 'No Peg'
    0x50:
      id: 'market'
      doc: 'Market'
    0x52:
      id: 'primary'
      doc: 'Primary'
  discretion_peg_difference_sign:
    0x2b:
      id: 'plus'
      doc: 'Positive Peg Difference'
    0x2d:
      id: 'minus'
      doc: 'Negative Peg Difference'
  intermarket_sweep_eligibility:
    0x59:
      id: 'eligible'
      doc: 'Eligible'
    0x4e:
      id: 'not_eligible'
      doc: 'Not Eligible'
    0x79:
      id: 'trade_at_intermarket_sweep_order'
      doc: 'Tradeat Intermarket Sweep Order'
  cross_type:
    0x4f:
      id: 'opening_cross'
      doc: 'Opening Cross'
    0x43:
      id: 'closing_cross'
      doc: 'Closing Cross'
    0x4e:
      id: 'immediately_live'
      doc: 'Order Is Immediately Live Dont Wait For A Cross'
  customer_type:
    0x52:
      id: 'retail_designated_order'
      doc: 'Retail Designated Order'
    0x4e:
      id: 'not_a_retail_designated_order'
      doc: 'Not A Retail Designated Order'
  reactive_trade_now:
    0x42:
      id: 'reactive_trade_now'
      doc: 'Reactive Trade Now'
    0x4e:
      id: 'not_a_reactive_trade_now'
      doc: 'Not A Reactive Trade Now Order'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupTcp Server Heartbeat Packet'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire system.'
    0x41:
      id: 'accepted_order_message'
      doc: 'An Accepted Order Message acknowledges the receipt of a valid Enter Order Message. The data fields from the Enter Order Message are echoed back; the accepted values may differ from the entered values for some fields.'
    0x52:
      id: 'accepted_order_message_with_cross_functionality'
      doc: 'Similar to the regular Accepted Order Message, with the additional information provided upon order entry using the Enter Order Message with Cross Functionality.'
    0x43:
      id: 'canceled_order_message'
      doc: 'A Canceled Order Message informs you that an order has been reduced or canceled. Canceled shares reflect the number of shares that are out.'
    0x4a:
      id: 'rejected_order_message'
      doc: 'A Rejected Order Message may be sent in response to an Enter Order Message if the order cannot be accepted at this time. The Token of a rejected order cannot be re-used.'
    0x45:
      id: 'executed_order_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed.'
    0x42:
      id: 'broken_trade_message'
      doc: 'A Broken Trade Message informs you that an execution has been broken. The trade is no longer good and will not clear.'
  event_code:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day This Is Always The First Message Each Day It Indicates That The System Is Open And Ready To Start Accepting Orders'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day This Indicates That The System Is Now Closed And Will Not Accept Any New Orders In This Session There Will Not Be Any More Executions During This Session However It Is Still Possible To Receive Broken Trade Messages And Canceled Order Messages'
  cancel_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'User Requested Cancel Sent In Response To A Cancel Request Message'
    0x49:
      id: 'immediate_or_cancel'
      doc: 'Immediate Or Cancel Order'
    0x54:
      id: 'timeout'
      doc: 'Timeout The Time In Force For This Order Has Expired'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory The Order Was Manually Canceled Or Reduced By A Supervisory Terminal'
    0x44:
      id: 'regulatory_restriction'
      doc: 'This Order Cannot Be Executed Because Of A Regulatory Restriction Eg Trade Through Restrictions'
    0x51:
      id: 'self_match_prevention'
      doc: 'Self Match Prevention The Order Was Cancelled Because It Would Have Executed With An Existing Order Entered By The Same Mpid'
    0x5a:
      id: 'system_cancel'
      doc: 'System Cancel This Order Was Cancelled By The System'
    0x4b:
      id: 'market_collars'
      doc: 'This Order Cannot Be Executed Because Of Market Collars'
    0x45:
      id: 'closed'
      doc: 'Closed Any Day Order That Was Received After The Closing Cross Is Complete In A Given Symbol Will Receive This Cancel Reason'
    0x4a:
      id: 'rejected_by_away_destination'
      doc: 'System Cancel This Order Was Cancelled Because It Was Rejected By An Away Destination Includes Midpoint Orders Cancelled Due To A Crossed Market'
    0x41:
      id: 'administrative_cancel'
      doc: 'Administrative Cancel This Order Was Cancelled By The System'
  reject_reason:
    0x59:
      id: 'no_shares_found_for_routing'
      doc: 'No Shares Found For Routing'
    0x43:
      id: 'nasdaq_omx_bx_is_closed'
      doc: 'Nasdaq Omx Bx Is Closed'
    0x49:
      id: 'invalid_order_side'
      doc: 'Invalid Order Side'
    0x45:
      id: 'invalid_peg'
      doc: 'Invalid Peg'
    0x4c:
      id: 'invalid_firm'
      doc: 'Invalid Firm'
    0x5a:
      id: 'quantity_exceeds_threshold'
      doc: 'Quantity Exceeds Threshold'
    0x4f:
      id: 'other'
      doc: 'Other A Reason Not Contemplated In This Version Of Rash'
    0x42:
      id: 'quote_not_available_for_pegged_order'
      doc: 'Quote Not Available For Pegged Order'
    0x50:
      id: 'pegging_not_allowed'
      doc: 'Pegging Not Allowed'
    0x58:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x47:
      id: 'destination_not_available'
      doc: 'Destination Not Available'
    0x4a:
      id: 'processing_error'
      doc: 'Processing Error'
    0x4e:
      id: 'invalid_routing_instructions'
      doc: 'Invalid Routing Instructions'
    0x44:
      id: 'invalid_display_value'
      doc: 'Invalid Display Value'
    0x4d:
      id: 'outside_of_permitted_times_for_clearing_destination'
      doc: 'Outside Of Permitted Times For Clearing Destination'
    0x48:
      id: 'security_is_halted'
      doc: 'Security Is Halted'
    0x53:
      id: 'invalid_symbol'
      doc: 'Invalid Symbol'
    0x51:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    0x4b:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    0x57:
      id: 'invalid_destination'
      doc: 'Invalid Destination'
    0x41:
      id: 'advance_features_not_allowed'
      doc: 'Advance Features Not Allowed'
    0x55:
      id: 'possible_duplicate_order'
      doc: 'Possible Duplicate Order'
    0x56:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    0x54:
      id: 'test_mode'
      doc: 'Test Mode'
    0x52:
      id: 'routing_not_allowed'
      doc: 'Routing Not Allowed'
    0x46:
      id: 'order_not_marketable'
      doc: 'Order Not Marketable Conflicting Instructions Improper Cross Type'
    0x71:
      id: 'midpoint_peg_not_accepted_in_crossed_market'
      doc: 'Midpoint Peg Orders Are Not Accepted In A Crossed Market'
    0x61:
      id: 'prm_invalid_message_format'
      doc: 'Pre Trade Risk Management Invalid Message Format'
    0x62:
      id: 'prm_no_quote'
      doc: 'Pre Trade Risk Management No Quote'
    0x63:
      id: 'prm_invalid_account'
      doc: 'Pre Trade Risk Management Invalid Account'
    0x64:
      id: 'prm_short_sale_violation'
      doc: 'Pre Trade Risk Management Short Sale Violation'
    0x65:
      id: 'prm_iso_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Iso Order Check'
    0x66:
      id: 'prm_gtc_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Gtc Order Check'
    0x67:
      id: 'prm_pre_market_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Premarket Order Check'
    0x68:
      id: 'prm_post_market_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Postmarket Order Check'
    0x69:
      id: 'prm_delayed_checking_flag_off'
      doc: 'Pre Trade Risk Management Order Rejected Due To The Delayed Checking Flag Turned Off'
    0x6a:
      id: 'prm_exceeded_maximum_shares_threshold'
      doc: 'Pre Trade Risk Management Exceeded Maximum Shares Threshold'
    0x6b:
      id: 'prm_exceeded_maximum_value_threshold'
      doc: 'Pre Trade Risk Management Exceeded Maximum Value Threshold'
    0x6d:
      id: 'prm_reject_all_orders'
      doc: 'Pre Trade Risk Management Order Rejected Due To Previous Command To Reject All Orders'
    0x6e:
      id: 'prm_invalid_price_fat_finger'
      doc: 'Pre Trade Risk Management Order Rejected Due To Invalid Price Fat Finger'
    0x6f:
      id: 'prm_not_on_easy_to_borrow_list'
      doc: 'Pre Trade Risk Management Order Rejected Due To Symbol Not Listed On Easy To Borrow List'
    0x70:
      id: 'prm_not_available'
      doc: 'Pre Trade Risk Management Prm Is Not Available'
    0x73:
      id: 'prm_symbol_halted'
      doc: 'Pre Trade Risk Management Symbol Halted'
    0x74:
      id: 'prm_on_open'
      doc: 'Pre Trade Risk Management Order Rejected Due To On Open'
    0x75:
      id: 'prm_on_close'
      doc: 'Pre Trade Risk Management Order Rejected Due To On Close'
    0x76:
      id: 'prm_program_trading'
      doc: 'Pre Trade Risk Management Order Rejected Due To Program Trading'
    0x7b:
      id: 'prm_not_on_restricted_list'
      doc: 'Pre Trade Risk Management Order Rejected Due To Symbol Not Listed On Restricted List'
  liquidity:
    0x41:
      id: 'added'
      doc: 'Added'
    0x52:
      id: 'removed'
      doc: 'Removed'
    0x4a:
      id: 'non_displayed_and_added_liquidity'
      doc: 'Nondisplayed And Added Liquidity'
    0x58:
      id: 'routed'
      doc: 'Routed'
    0x44:
      id: 'dot'
      doc: 'Dot'
    0x46:
      id: 'added_or_opening_trade'
      doc: 'Added Or Opening Trade On Nyse'
    0x47:
      id: 'odd_lot_or_on_close_order'
      doc: 'Odd Lot Or On Close Order On Nyse'
    0x59:
      id: 're_routed_by_nyse'
      doc: 'Re Routed By Nyse'
    0x53:
      id: 'odd_lot_execution'
      doc: 'Odd Lot Execution On Nyse'
    0x55:
      id: 'added_liquidity'
      doc: 'Added Liquidity On Nyse'
    0x45:
      id: 'nyse_other'
      doc: 'Nyse Other'
    0x50:
      id: 'routed_to_psx'
      doc: 'Routed To Psx'
    0x54:
      id: 'opening_trade'
      doc: 'Opening Trade On Arca'
    0x5a:
      id: 'on_close_order'
      doc: 'On Close Order On Arca'
    0x51:
      id: 'routed_to_nasdaq'
      doc: 'Routed To Nasdaq'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'Removed Liquidity At A Midpoint'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'Added Liquidity Via A Midpoint Order'
    0x6a:
      id: 'rpi_order_provides_liquidity'
      doc: 'Rpi Retail Price Improving Order Provides Liquidity'
    0x72:
      id: 'rmo_retail_order_removes_rpi_liquidity'
      doc: 'Rmo Retail Order Removes Rpi Liquidity'
    0x74:
      id: 'rmo_retail_order_removes_price_improving_non_displayed_liquidity_other_than_rpi_liquidity'
      doc: 'Rmo Retail Order Removes Price Improving Nondisplayed Liquidity Other Than Rpi Liquidity'
    0x71:
      id: 'rmo_retail_order_removes_non_rpi_midpoint_liquidity'
      doc: 'Rmo Retail Order Removes Non Rpi Midpoint Liquidity'
    0x37:
      id: 'displayed_liquidity_adding_order_improves_the_nbbo'
      doc: 'Displayed Liquidityadding Order Improves The Nbbo'
    0x38:
      id: 'displayed_liquidity_adding_order_sets_the_bxbbo_while_joining_the_nbbo'
      doc: 'Displayed Liquidityadding Order Sets The Bxbbo While Joining The Nbbo'
    0x70:
      id: 'removed_price_improving_non_displayed_liquidity'
      doc: 'Removed Price Improving Nondisplayed Liquidity'
    0x4e:
      id: 'passive_midpoint_execution'
      doc: 'Passive Midpoint Execution'
  broken_trade_reason:
    0x45:
      id: 'erroneous'
      doc: 'Erroneous The Trade Was Deemed Clearly Erroneous'
    0x43:
      id: 'consent'
      doc: 'Consent The Two Parties Mutually Agreed To Break The Trade'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory The Trade Was Manually Broken By A Supervisory Terminal'
    0x58:
      id: 'external'
      doc: 'External The Trade Was Broken By An External Third Party'

