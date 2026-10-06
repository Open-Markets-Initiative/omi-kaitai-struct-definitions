# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Millennium NativeTradingGateway Ntgi v21.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Native Trading Gateway
#   Encoding: Native Trading Gateway Interface
#   Version: 21.2
#   Date: 01/05/2024
#   Specification: mit203-native-trading-gateway-specification-issue-21-2.pdf
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
  id: lseg_millennium_nativetradinggateway_ntgi_v21_2
  title: Lseg Millennium NativeTradingGateway Ntgi v21.2
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange Millennium Exchange Native Trading Gateway Ntgi v21.2'
doc-ref:
  - https://www.londonstockexchange.com/resources/equities-trading-resources?tab=technical-library
  - https://docs.londonstockexchange.com/sites/default/files/documents/mit203-native-trading-gateway-specification-issue-21-2.pdf

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Native Trading Gateway Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Native Trading Gateway Message Header'
      - id: payload
        size: message_header.message_length + 3 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::logon_message': logon_message
            'message_type::logon_reply_message': logon_reply_message
            'message_type::logout_message': logout_message
            'message_type::reject_message': reject_message
            'message_type::system_status_message': system_status_message
            'message_type::new_order_message': new_order_message
            'message_type::new_quote_message': new_quote_message
            'message_type::order_cancel_replace_request_message': order_cancel_replace_request_message
            'message_type::order_cancel_request_message': order_cancel_request_message
            'message_type::order_mass_cancel_request_message': order_mass_cancel_request_message
            'message_type::execution_report_message': execution_report_message
            'message_type::order_cancel_reject_message': order_cancel_reject_message
            'message_type::order_mass_cancel_report_message': order_mass_cancel_report_message
            'message_type::quote_request_message': quote_request_message
            'message_type::quote_status_report_message': quote_status_report_message
            'message_type::quote_request_reject_message': quote_request_reject_message
            'message_type::rfq_quote_message': rfq_quote_message
            'message_type::quote_ack_message': quote_ack_message
            'message_type::quote_response_message': quote_response_message
            'message_type::rfq_execution_report_message': rfq_execution_report_message
            'message_type::business_reject_message': business_reject_message
  message_header:
    seq:
      - id: start_of_message
        type: s1
        doc: 'Indicates the start of the message; always the binary value 2'
      - id: message_length
        type: s2
        doc: 'Length of the message from the Message Type field onwards'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Type of message'
  logon_message:
    seq:
      - id: user_name
        type: str
        size: 25
        encoding: ASCII
        doc: 'User name'
      - id: password
        type: str
        size: 25
        encoding: ASCII
        doc: 'Password'
      - id: new_password
        type: str
        size: 25
        encoding: ASCII
        doc: 'New Password'
      - id: message_version
        type: u1
        doc: 'Message Version that will be used in this session'
  logon_reply_message:
    seq:
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: password_expiry_day_count
        type: str
        size: 30
        encoding: ASCII
        doc: 'The number of days before the password will expire'
  logout_message:
    seq:
      - id: reason
        type: str
        size: 20
        encoding: ASCII
        doc: 'Reason for the logout'
  reject_message:
    seq:
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: reject_reason
        type: str
        size: 30
        encoding: ASCII
        doc: 'Reject Reason'
      - id: rejected_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message type of the rejected message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
  system_status_message:
    seq:
      - id: app_id
        type: u1
        enum: app_id
        doc: 'Partition ID'
      - id: app_status
        type: u1
        enum: app_status
  new_order_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: trader_id
        type: str
        size: 11
        encoding: ASCII
        doc: 'Optional Trader ID that clients may submit'
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Optional reference of the investor the order is submitted for'
      - id: clearing_account
        type: u1
        enum: clearing_account
        doc: 'Clearing Account Type'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: mi_fid_flags
        type: mi_fid_flags
        doc: 'Flags identifying Dea involvement, Algo and liquidity provision activity'
      - id: party_role_qualifiers
        type: party_role_qualifiers
        doc: 'Further qualification for the Client Id, Investment Decision Maker and Executing Trader identifiers'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of order'
      - id: tif
        type: u1
        enum: tif
        doc: 'Time qualifier of the order'
      - id: expire_date_time
        type: second_timestamp
        doc: 'This field will indicate the date or the time the order expires on. Seconds since Unix epoch'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: order_qty
        type: s4
        doc: 'Total order quantity'
      - id: display_qty
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: limit_price
        type: decimal_s8_8
        doc: 'Limit Price. Implied decimal with scale 1e-8'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the order'
      - id: auto_cancel
        type: u1
        enum: auto_cancel
        doc: 'Cancel orders on logout/disconnection of session'
      - id: new_order_order_sub_type
        type: u1
        enum: new_order_order_sub_type
        doc: 'Whether the order is a pegged order'
      - id: anonymity
        type: u1
        enum: anonymity
        doc: 'Whether the order is a named or anonymous order'
      - id: stop_price
        type: decimal_s8_8
        doc: 'Stop price. Implied decimal with scale 1e-8'
      - id: passive_only_order
        type: u1
        enum: passive_only_order
        doc: 'Order level parameter to allow clients to specify that they would like their order to rest prior to execution, with flexibility for visible orders to rest at a specified price level on the book'
      - id: client_id
        type: u4
        enum: client_id
        doc: 'Identifier of the client'
      - id: investment_decision_maker
        type: u4
        enum: investment_decision_maker
        doc: 'Identifier of the trading member/participant who made investment decision'
      - id: group_id
        type: u1
        doc: 'Specified by the user as order submission'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Execution Size (MES) of an order'
      - id: executing_trader
        type: u4
        enum: executing_trader
        doc: 'Identifier of the trading member/participant who made the execution decision'
      - id: offset
        type: s4
        doc: 'Offset to the Dynamic Reference Price (in basis points) for ATC TIF orders'
      - id: new_order_pegged_exec_inst
        type: u1
        enum: new_order_pegged_exec_inst
        doc: 'The instruction for permissioning to trade against mid-priced pegged orders'
      - id: owner_type
        type: u1
        enum: owner_type
        doc: 'Optional identification (non-public)'
      - id: reserved_14
        size: 14
        doc: 'Reserved for future use'
  mi_fid_flags:
    meta:
      bit-endian: le
    seq:
      - id: dea_flag
        type: b1
        doc: 'Direct electronic access involvement'
      - id: liquidity_provision
        type: b1
        doc: 'Liquidity provision activity'
      - id: algo
        type: b1
        doc: 'Algorithmic trading activity'
      - id: reserved_37
        type: b5
        doc: 'Reserved for future use'
  party_role_qualifiers:
    meta:
      bit-endian: le
    seq:
      - id: client_id_qualifier
        type: b2
        doc: 'Qualifies the Client Id short code'
      - id: investor_information_qualifier
        type: b2
        doc: 'Qualifies the Investment Decision Maker short code'
      - id: executing_trader_qualifier
        type: b2
        doc: 'Qualifies the Executing Trader short code'
      - id: reserved_67
        type: b2
        doc: 'Reserved for future use'
  new_quote_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: trader_id
        type: str
        size: 11
        encoding: ASCII
        doc: 'Optional Trader ID that clients may submit'
      - id: clearing_account
        type: u1
        enum: clearing_account
        doc: 'Clearing Account Type'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: bid_price
        type: decimal_s8_8
        doc: 'Bid price. Implied decimal with scale 1e-8'
      - id: bid_size
        type: s4
        doc: 'Bid quantity'
      - id: ask_price
        type: decimal_s8_8
        doc: 'Offer price. Implied decimal with scale 1e-8'
      - id: ask_size
        type: s4
        doc: 'Offer quantity'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the order'
      - id: auto_cancel
        type: u1
        enum: auto_cancel
        doc: 'Cancel orders on logout/disconnection of session'
      - id: client_id
        type: u4
        enum: client_id
        doc: 'Identifier of the client'
      - id: investment_decision_maker
        type: u4
        enum: investment_decision_maker
        doc: 'Identifier of the trading member/participant who made investment decision'
      - id: executing_trader
        type: u4
        enum: executing_trader
        doc: 'Identifier of the trading member/participant who made the execution decision'
      - id: mi_fid_flags
        type: mi_fid_flags
        doc: 'Flags identifying Dea involvement, Algo and liquidity provision activity'
      - id: party_role_qualifiers
        type: party_role_qualifiers
        doc: 'Further qualification for the Client Id, Investment Decision Maker and Executing Trader identifiers'
      - id: new_quote_pegged_exec_inst
        type: u1
        enum: new_quote_pegged_exec_inst
        doc: 'The instruction for permissioning to trade against mid-priced pegged orders'
  order_cancel_replace_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: original_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order ID of the order being amended'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: group_id
        type: u1
        doc: 'Specified by the user as order submission'
      - id: reserved_1
        size: 1
        doc: 'This will always be zero (0)'
      - id: expire_date_time
        type: second_timestamp
        doc: 'This field will indicate the date or the time the order expires on. Seconds since Unix epoch'
      - id: order_qty
        type: s4
        doc: 'Total order quantity'
      - id: display_qty
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: limit_price
        type: decimal_s8_8
        doc: 'Limit Price. Implied decimal with scale 1e-8'
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Optional reference of the investor the order is submitted for'
      - id: second_reserved_1
        size: 1
        doc: 'This will always be zero (0)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: stop_price
        type: decimal_s8_8
        doc: 'Stop price. Implied decimal with scale 1e-8'
      - id: passive_only_order
        type: u1
        enum: passive_only_order
        doc: 'Order level parameter to allow clients to specify that they would like their order to rest prior to execution, with flexibility for visible orders to rest at a specified price level on the book'
      - id: offset
        type: s4
        doc: 'Offset to the Dynamic Reference Price (in basis points) for ATC TIF orders'
      - id: reserved_5
        size: 5
        doc: 'Reserved for future use'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Execution Size (MES) of an order'
  order_cancel_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: original_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client Order ID of the order being amended'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: reserved_1
        size: 1
        doc: 'This will always be zero (0)'
      - id: second_reserved_1
        size: 1
        doc: 'This will always be zero (0)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
  order_mass_cancel_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: mass_cancel_request_type
        type: u1
        enum: mass_cancel_request_type
        doc: 'Type of Mass Cancellation'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: reserved_1
        size: 1
        doc: 'This will always be zero (0)'
      - id: group_id
        type: u1
        doc: 'Specified by the user as order submission'
      - id: segment
        type: str
        size: 4
        encoding: ASCII
        doc: 'The segment for which the orders will be cancelled'
      - id: order_mass_cancel_request_order_sub_type
        type: u1
        enum: order_mass_cancel_request_order_sub_type
        doc: 'Whether cancellation should apply to orders or quotes'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
  execution_report_message:
    seq:
      - id: app_id
        type: u1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique ID of the Execution Report'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'The reason the Execution Report is being sent'
      - id: execution_report_ref_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Reference to the trade being cancelled or corrected'
      - id: execution_report_order_status
        type: u1
        enum: execution_report_order_status
        doc: 'The status of the order'
      - id: order_reject_code
        type: s4
        doc: 'Code specifying the reason for the reject or the expiry'
      - id: executed_price
        type: decimal_s8_8
        doc: 'Value of this fill. Implied decimal with scale 1e-8'
      - id: executed_qty
        type: s4
        doc: 'Quantity that was executed in this fill'
      - id: leaves_qty
        type: s4
        doc: 'Quantity available for further execution'
      - id: waiver_flags_post_trade_flags
        type: waiver_flags_post_trade_flags
        doc: 'Pre-trade waiver and post trade flags'
      - id: display_qty
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: restatement_reason
        type: u1
        doc: 'Reason order was restated or cancelled'
      - id: execution_report_pegged_exec_inst
        type: u1
        enum: execution_report_pegged_exec_inst
        doc: 'The instruction for permissioning to trade against mid-priced pegged orders'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: owner_type
        type: u1
        enum: owner_type
        doc: 'Optional identification (non-public)'
      - id: reserved_7
        size: 7
        doc: 'Reserved for future use'
      - id: counterparty
        type: str
        size: 11
        encoding: ASCII
        doc: 'Counterparty Firm'
      - id: trade_liquidity_indicator
        type: u1
        enum: trade_liquidity_indicator
        doc: 'Whether the order added or removed liquidity'
      - id: trade_match_id
        type: u8
        doc: 'Identifier of the trade'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: last_market
        type: u1
        enum: last_market
        doc: 'Market (Segment MIC) where execution took place'
      - id: type_of_trade
        type: u1
        enum: type_of_trade
        doc: 'Indicates whether the executed portion of a passive order during continuous trading session is visible or hidden'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the order'
      - id: reserved_1
        size: 1
        doc: 'This will always be zero (0)'
      - id: public_order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Maintained by matching engine, will be unique for each replenishment of a particular iceberg order'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Execution Size (MES) of an order'
  waiver_flags_post_trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_bit_0
        type: b1
        doc: 'Reserved for future use'
      - id: clse
        type: b1
        doc: 'Post trade flag: trade executed during the CPX session at closing price'
      - id: reserved_bit_2
        type: b1
        doc: 'Reserved for future use'
      - id: ilqd
        type: b1
        doc: 'Waiver flag: illiquid instrument'
      - id: reserved_bit_4
        type: b1
        doc: 'Reserved for future use'
      - id: rfpt
        type: b1
        doc: 'Waiver flag: reference price'
      - id: reserved_67
        type: b2
        doc: 'Reserved for future use'
  transact_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds elapsed since midnight 1 January 1970 UTC, not counting leap seconds. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the Transact Time. Nanoseconds since Second epoch'
  order_cancel_reject_message:
    seq:
      - id: app_id
        type: u1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: cancel_reject_reason
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
  order_mass_cancel_report_message:
    seq:
      - id: app_id
        type: u1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: mass_cancel_response
        type: u1
        enum: mass_cancel_response
        doc: 'Whether the Mass Cancel Request was accepted or rejected'
      - id: mass_cancel_reject_reason
        type: s4
        doc: 'The code that identifies the reason the order mass cancel was rejected'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
  quote_request_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'The server will stamp the identifier of the matching partition for the instrument'
      - id: sequence_number
        type: s4
        doc: 'The server will stamp the message sequence number of the matching partition'
      - id: quote_req_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client specified identifier of the RFQ'
      - id: order_book
        type: u1
        enum: order_book
      - id: private_quote
        type: u1
        enum: private_quote
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: order_quantity
        type: s4
        doc: 'Quantity that the Requester is expecting to trade'
      - id: expire_time
        type: second_timestamp
        doc: 'Indicates the date or the time the RFQ expires, in Unix (Posix) time format (number of seconds after 1 January 1970). Seconds since Unix epoch'
      - id: market_makers
        type: str
        size: 60
        encoding: ASCII
        doc: 'Pipe separated list of Firm IDs, if it is required to target this quote request to specific Market Makers'
      - id: contra_trader
        type: str
        size: 11
        encoding: ASCII
        doc: 'For Named Models only, the server will stamp the User ID of the Requester to send to the Market Maker'
      - id: contra_firm
        type: str
        size: 11
        encoding: ASCII
        doc: 'For Named Models only, the server will stamp the Firm ID of the Requester to send to the Market Maker'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
      - id: client_id
        type: u4
        enum: client_id
        doc: 'Identifier of the client'
      - id: investment_decision_maker
        type: u4
        enum: investment_decision_maker
        doc: 'Identifier of the trading member/participant who made investment decision'
      - id: executing_trader
        type: u4
        enum: executing_trader
        doc: 'Identifier of the trading member/participant who made the execution decision'
      - id: mi_fid_flags
        type: mi_fid_flags
        doc: 'Flags identifying Dea involvement, Algo and liquidity provision activity'
      - id: party_role_qualifiers
        type: party_role_qualifiers
        doc: 'Further qualification for the Client Id, Investment Decision Maker and Executing Trader identifiers'
      - id: quote_request_type
        type: u1
        enum: quote_request_type
        doc: 'Indicates the type of Quote Request'
      - id: price
        type: decimal_s8_8
        doc: 'Limit Price. Implied decimal with scale 1e-8'
      - id: rfq_execution_delay
        type: u1
        doc: 'The minimum number of seconds from the time of RFQ submission to be elapsed for the RFQ execution to be triggered automatically'
      - id: rfq_min_quotes
        type: u1
        doc: 'The minimum number of market maker quotes to be available for the RFQ execution to be triggered automatically'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Clearing Account Type'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Capacity of the RFQ'
      - id: rfq_disclose_side
        type: u1
        enum: rfq_disclose_side
        doc: 'Instructs the system whether to disclose the side of the request as stated in the Side field to the market makers or not'
      - id: expire_time_milliseconds
        type: u4
        doc: 'Indicates the number of milliseconds to be added to the date or the time the RFQ expires on specified in the ‘Expire Time’ field'
      - id: auto_rfq_exec_strategy
        type: u1
        enum: auto_rfq_exec_strategy
        doc: 'This field will include the applicable Auto RFQ Execution Strategy ‘Sub LIS Auction with Order Book Sweep or LIS Winner Takes All’ model'
      - id: num_of_competitors
        type: u1
        doc: 'The number of competing Respondents (the total number of market maker firms) the quote request has been routed to'
      - id: market_maker_rank
        type: u1
        doc: 'The rank of the market makers the request should be routed to'
  quote_status_report_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'The server will stamp the identifier of the matching partition for the instrument'
      - id: sequence_number
        type: s4
        doc: 'The server will stamp the message sequence number of the matching partition'
      - id: quote_msg_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Identifier specified by the client in the RFQ modification/cancellation/execution request'
      - id: quote_req_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client specified identifier of the RFQ'
      - id: quote_status
        type: u1
        enum: quote_status
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: order_book
        type: u1
        enum: order_book
      - id: market_makers
        type: str
        size: 60
        encoding: ASCII
        doc: 'Pipe separated list of Firm IDs, if it is required to target this quote request to specific Market Makers'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
      - id: expire_time
        type: second_timestamp
        doc: 'Indicates the date or the time the RFQ expires, in Unix (Posix) time format (number of seconds after 1 January 1970). Seconds since Unix epoch'
      - id: bid_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the bid side of the quote'
      - id: offer_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the offer side of the quote'
      - id: expire_time_milliseconds
        type: u4
        doc: 'Indicates the number of milliseconds to be added to the date or the time the RFQ expires on specified in the ‘Expire Time’ field'
  quote_request_reject_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'The server will stamp the identifier of the matching partition for the instrument'
      - id: sequence_number
        type: s4
        doc: 'The server will stamp the message sequence number of the matching partition'
      - id: quote_req_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client specified identifier of the RFQ'
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: order_book
        type: u1
        enum: order_book
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: order_quantity
        type: s4
        doc: 'Quantity that the Requester is expecting to trade'
      - id: market_makers
        type: str
        size: 60
        encoding: ASCII
        doc: 'Pipe separated list of Firm IDs, if it is required to target this quote request to specific Market Makers'
      - id: contra_trader
        type: str
        size: 11
        encoding: ASCII
        doc: 'For Named Models only, the server will stamp the User ID of the Requester to send to the Market Maker'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
  rfq_quote_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'The server will stamp the identifier of the matching partition for the instrument'
      - id: sequence_number
        type: s4
        doc: 'The server will stamp the message sequence number of the matching partition'
      - id: quote_msg_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Identifier specified by the client in the RFQ modification/cancellation/execution request'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: bid_price
        type: decimal_s8_8
        doc: 'Bid price. Implied decimal with scale 1e-8'
      - id: bid_quantity
        type: s4
        doc: 'Bid quantity'
      - id: offer_price
        type: decimal_s8_8
        doc: 'Offer price. Implied decimal with scale 1e-8'
      - id: offer_quantity
        type: s4
        doc: 'Offer quantity'
      - id: auto_cancel
        type: u1
        enum: auto_cancel
        doc: 'Cancel orders on logout/disconnection of session'
      - id: market_maker
        type: str
        size: 11
        encoding: ASCII
        doc: 'The Market Maker ID who is the owner of the quote'
      - id: market_maker_firm
        type: str
        size: 11
        encoding: ASCII
        doc: 'The Market Makers’ Firm ID'
      - id: bid_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the bid side of the quote'
      - id: offer_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the offer side of the quote'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the order'
      - id: clearing_account
        type: u1
        enum: clearing_account
        doc: 'Clearing Account Type'
      - id: client_id
        type: u4
        enum: client_id
        doc: 'Identifier of the client'
      - id: investment_decision_maker
        type: u4
        enum: investment_decision_maker
        doc: 'Identifier of the trading member/participant who made investment decision'
      - id: executing_trader
        type: u4
        enum: executing_trader
        doc: 'Identifier of the trading member/participant who made the execution decision'
      - id: mi_fid_flags
        type: mi_fid_flags
        doc: 'Flags identifying Dea involvement, Algo and liquidity provision activity'
      - id: party_role_qualifiers
        type: party_role_qualifiers
        doc: 'Further qualification for the Client Id, Investment Decision Maker and Executing Trader identifiers'
  quote_ack_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'The server will stamp the identifier of the matching partition for the instrument'
      - id: sequence_number
        type: s4
        doc: 'The server will stamp the message sequence number of the matching partition'
      - id: quote_msg_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Identifier specified by the client in the RFQ modification/cancellation/execution request'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
      - id: bid_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the bid side of the quote'
      - id: offer_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the offer side of the quote'
      - id: quote_ack_status
        type: u1
        enum: quote_ack_status
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: order_book
        type: u1
        enum: order_book
  quote_response_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'The server will stamp the identifier of the matching partition for the instrument'
      - id: sequence_number
        type: s4
        doc: 'The server will stamp the message sequence number of the matching partition'
      - id: quote_msg_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Identifier specified by the client in the RFQ modification/cancellation/execution request'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
      - id: quote_resp_type
        type: u1
        enum: quote_resp_type
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: order_quantity
        type: s4
        doc: 'Quantity that the Requester is expecting to trade'
      - id: limit_price
        type: decimal_s8_8
        doc: 'Limit Price. Implied decimal with scale 1e-8'
      - id: order_book
        type: u1
        enum: order_book
      - id: bid_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the bid side of the quote'
      - id: offer_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier assigned to the offer side of the quote'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the order'
      - id: clearing_account
        type: u1
        enum: clearing_account
        doc: 'Clearing Account Type'
      - id: reserved_8
        size: 8
        doc: 'Reserved for Future use'
  rfq_execution_report_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'The server will stamp the identifier of the matching partition for the instrument'
      - id: sequence_number
        type: s4
        doc: 'The server will stamp the message sequence number of the matching partition'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique ID of the Execution Report'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identifier of the initial RFQ by the Requester'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: execution_type
        type: u1
        enum: execution_type
      - id: trade_match_id
        type: u8
        doc: 'Identifier of the trade'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: executed_quantity
        type: s4
        doc: 'Quantity executed'
      - id: executed_price
        type: decimal_s8_8
        doc: 'Value of this fill. Implied decimal with scale 1e-8'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: reserved_8
        size: 8
        doc: 'Reserved for Future use'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for Future use'
      - id: rfq_execution_report_order_status
        type: u1
        enum: rfq_execution_report_order_status
      - id: leaves_quantity
        type: s4
        doc: 'Remaining quantity of the quote'
      - id: instrument_id
        type: s4
        doc: 'Identifier of the instrument for which the order is submitted'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for Future use'
      - id: fourth_reserved_8
        size: 8
        doc: 'Reserved for Future use'
      - id: contra_firm
        type: str
        size: 11
        encoding: ASCII
        doc: 'For Named Models only, the server will stamp the Firm ID of the Requester to send to the Market Maker'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of the order'
      - id: clearing_account
        type: u1
        enum: clearing_account
        doc: 'Clearing Account Type'
      - id: waiver_flags
        type: waiver_flags
        doc: 'Pre-trade waiver flags'
      - id: execution_report_ref_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Reference to the trade being cancelled or corrected'
      - id: contra_order_book
        type: u1
        enum: contra_order_book
        doc: 'Identifier of the order book of the contra party of an RFQ execution'
      - id: avg_px
        type: decimal_s8_8
        doc: 'Volume Weighted Average Price of all the executions reported so far for an RFQ on the requestor side and it will be the executed price on the quote side. Implied decimal with scale 1e-8'
      - id: last_market
        type: u1
        enum: last_market
        doc: 'Market (Segment MIC) where execution took place'
      - id: reserved_7
        size: 7
        doc: 'Reserved for future use'
  waiver_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_02
        type: b3
        doc: 'Reserved for future use'
      - id: ilqd
        type: b1
        doc: 'Waiver flag: illiquid instrument'
      - id: reserved_47
        type: b4
        doc: 'Reserved for future use'
  business_reject_message:
    seq:
      - id: app_id
        type: u1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000

enums:
  message_type:
    0x41:
      id: 'logon_message'
      doc: 'Allows the client and server to establish a session.'
    0x42:
      id: 'logon_reply_message'
      doc: 'Allows the server to acknowledge a client''s Logon.'
    0x35:
      id: 'logout_message'
      doc: 'Allows the client and server to terminate a session.'
    0x30:
      id: 'heartbeat_message'
      doc: 'Allows the client and server to exercise the communication line during periods of inactivity and verify that the interfaces at each end are available.'
    0x33:
      id: 'reject_message'
      doc: 'Used to reject a message that does not comply with the Native Trading Gateway messaging protocol.'
    0x6e:
      id: 'system_status_message'
      doc: 'Indicates service non availability of a partition, disseminated on the recovery and realtime channels.'
    0x44:
      id: 'new_order_message'
      doc: 'Allows the client to submit a new order.'
    0x53:
      id: 'new_quote_message'
      doc: 'Allows the client to submit and update a quote.'
    0x47:
      id: 'order_cancel_replace_request_message'
      doc: 'Allows the client to cancel or replace a live order.'
    0x46:
      id: 'order_cancel_request_message'
      doc: 'Allows the client to cancel a live order.'
    0x71:
      id: 'order_mass_cancel_request_message'
      doc: 'Allows the client to mass cancel live orders, optionally scoped to an instrument or a segment.'
    0x38:
      id: 'execution_report_message'
      doc: 'Indicates order accepted, rejected, executed, expired, cancelled, cancel/replaced, restated or suspended, or a trade cancel.'
    0x39:
      id: 'order_cancel_reject_message'
      doc: 'Indicates that an order cancel request or order cancel/replace request has been rejected.'
    0x72:
      id: 'order_mass_cancel_report_message'
      doc: 'Indicates that a mass order cancel request was accepted or rejected.'
    0x61:
      id: 'quote_request_message'
      doc: 'Carries a Request For Quote. Sent by the Requester to submit an RFQ, and by the server to deliver it to the Market Maker.'
    0x63:
      id: 'quote_status_report_message'
      doc: 'Allows the server to communicate the status of the RFQ to the Requester.'
    0x62:
      id: 'quote_request_reject_message'
      doc: 'Rejects an RFQ. Sent by the Market Maker to reject, and by the server to reject or to relay a Market Maker rejection.'
    0x64:
      id: 'rfq_quote_message'
      doc: 'Carries an RFQ Quote. Sent by the Market Maker to accept an RFQ, and by the server to deliver the quote to the Requester.'
    0x65:
      id: 'quote_ack_message'
      doc: 'Allows the server to acknowledge a new or modified RFQ Quote to the Market Maker.'
    0x66:
      id: 'quote_response_message'
      doc: 'Carries an RFQ response. Sent by the Requester to execute or cancel an RFQ Quote, and by the server to report quote and RFQ status.'
    0x67:
      id: 'rfq_execution_report_message'
      doc: 'Allows the system to notify the Requester and the Market Maker about a trade or the status of the quote.'
    0x6a:
      id: 'business_reject_message'
      doc: 'Indicates that an application message could not be processed.'
  app_id:
    0:
      id: 'system_suspended_unknown_instrument'
      doc: 'System Suspended Unknown Instrument'
    1:
      id: 'partition_1'
      doc: 'Partition 1'
    2:
      id: 'partition_2'
      doc: 'Partition 2'
    3:
      id: 'partition_3'
      doc: 'Partition 3'
    4:
      id: 'partition_4'
      doc: 'Partition 4'
  app_status:
    1:
      id: 'recovery_service_resumed'
      doc: 'Recovery Service Resumed'
    2:
      id: 'recovery_service_not_available'
      doc: 'Recovery Service Not Available'
    3:
      id: 'realtime_channel_to_indicate_service_non_availability_of_a_partition_due_to_order_cache_outage'
      doc: 'Realtime Channel To Indicate Service Non Availability Of A Partition Due To Order Cache Outage'
  clearing_account:
    1:
      id: 'client'
      doc: 'Client'
    3:
      id: 'house'
      doc: 'House'
  client_id_qualifier:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'lei_or_firm'
      doc: 'Lei Or Firm'
    2:
      id: 'algo'
      doc: 'Algo'
    3:
      id: 'natural_person'
      doc: 'Natural Person'
  investor_information_qualifier:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'lei_or_firm'
      doc: 'Lei Or Firm'
    2:
      id: 'algo'
      doc: 'Algo'
    3:
      id: 'natural_person'
      doc: 'Natural Person'
  executing_trader_qualifier:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'lei_or_firm'
      doc: 'Lei Or Firm'
    2:
      id: 'algo'
      doc: 'Algo'
    3:
      id: 'natural_person'
      doc: 'Natural Person'
  order_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'stop'
      doc: 'Stop'
    4:
      id: 'stop_limit'
      doc: 'Stop Limit'
  tif:
    0:
      id: 'day'
      doc: 'Day'
    3:
      id: 'immediate_or_cancel_ioc'
      doc: 'Immediate Or Cancel Ioc'
    4:
      id: 'fill_or_kill_fok'
      doc: 'Fill Or Kill Fok'
    5:
      id: 'at_the_opening_opg'
      doc: 'At The Opening Opg'
    6:
      id: 'good_till_date_gtd'
      doc: 'Good Till Date Gtd'
    8:
      id: 'good_till_time_gtt'
      doc: 'Good Till Time Gtt'
    10:
      id: 'at_the_close_atc'
      doc: 'At The Close Atc'
    12:
      id: 'closing_price_cross_cpx'
      doc: 'Closing Price Cross Cpx'
    50:
      id: 'good_for_auction_gfa'
      doc: 'Good For Auction Gfa'
    51:
      id: 'good_for_intraday_auction_gfx'
      doc: 'Good For Intraday Auction Gfx'
    52:
      id: 'good_for_scheduled_auction_gfs'
      doc: 'Good For Scheduled Auction Gfs'
    54:
      id: 'auction_volume_discovery_avd'
      doc: 'Auction Volume Discovery Avd'
    55:
      id: 'auction_volume_close_avc'
      doc: 'Auction Volume Close Avc'
  side:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  capacity:
    1:
      id: 'matched_principal_mtch'
      doc: 'Matched Principal Mtch'
    2:
      id: 'dealing_on_own_account_deal'
      doc: 'Dealing On Own Account Deal'
    3:
      id: 'any_other_trading_capacity_aotc'
      doc: 'Any Other Trading Capacity Aotc'
  auto_cancel:
    0:
      id: 'do_not_cancel'
      doc: 'Do Not Cancel'
    1:
      id: 'conform_to_users_configuration'
      doc: 'Conform To Users Configuration'
  new_order_order_sub_type:
    0:
      id: 'order'
      doc: 'Order'
    5:
      id: 'pegged_order'
      doc: 'Pegged Order'
    51:
      id: 'random_peak_size'
      doc: 'Random Peak Size'
    55:
      id: 'offset'
      doc: 'Offset'
  anonymity:
    0:
      id: 'anonymous'
      doc: 'Anonymous'
    1:
      id: 'named'
      doc: 'Named'
  passive_only_order:
    0:
      id: 'no_constraint'
      doc: 'No Constraint'
    99:
      id: 'only_accept_order_if_it_will_not_match_with_visible_contra_order_otherwise_expire_order'
      doc: 'Only Accept Order If It Will Not Match With Visible Contra Order Otherwise Expire Order'
    100:
      id: 'only_accept_order_if_setting_new_visible_bbo_otherwise_expire_order'
      doc: 'Only Accept Order If Setting New Visible Bbo Otherwise Expire Order'
    1:
      id: 'only_accept_order_if_setting_new_bbo_or_joining_existing_bbo_otherwise_expire_order'
      doc: 'Only Accept Order If Setting New Bbo Or Joining Existing Bbo Otherwise Expire Order'
    2:
      id: 'only_accept_order_if_will_be_at_bbo_or_within_one_visible_pricepoint_otherwise_expire_order'
      doc: 'Only Accept Order If Will Be At Bbo Or Within One Visible Pricepoint Otherwise Expire Order'
    3:
      id: 'only_accept_order_if_will_be_at_bbo_or_within_two_visible_pricepoints_otherwise_expire_order'
      doc: 'Only Accept Order If Will Be At Bbo Or Within Two Visible Pricepoints Otherwise Expire Order'
  client_id:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'aggr'
      doc: 'Aggr'
    2:
      id: 'pnal'
      doc: 'Pnal'
  investment_decision_maker:
    0:
      id: 'none'
      doc: 'None'
  executing_trader:
    3:
      id: 'client'
      doc: 'Client'
  new_order_pegged_exec_inst:
    0:
      id: 'default_field'
      doc: 'Default'
    1:
      id: 'permitted_to_execute_against_midpriced_pegged_orders'
      doc: 'Permitted To Execute Against Midpriced Pegged Orders'
    2:
      id: 'not_permitted_to_execute_against_midpriced_pegged_orders'
      doc: 'Not Permitted To Execute Against Midpriced Pegged Orders'
  owner_type:
    0:
      id: 'default_field'
      doc: 'Default'
    1:
      id: 'retail_investor'
      doc: 'Retail Investor'
    2:
      id: 'retail_liquidity_provider'
      doc: 'Retail Liquidity Provider'
  new_quote_pegged_exec_inst:
    0:
      id: 'default_field'
      doc: 'Default'
    1:
      id: 'permitted_to_execute_against_midpriced_pegged_orders'
      doc: 'Permitted To Execute Against Midpriced Pegged Orders'
    2:
      id: 'not_permitted_to_execute_against_midpriced_pegged_orders'
      doc: 'Not Permitted To Execute Against Midpriced Pegged Orders'
  mass_cancel_request_type:
    3:
      id: 'all_firm_orders_of_an_instrument'
      doc: 'All Firm Orders Of An Instrument'
  order_mass_cancel_request_order_sub_type:
    0:
      id: 'order'
      doc: 'Order'
    3:
      id: 'quote'
      doc: 'Quote'
  exec_type:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x35:
      id: 'replaced'
      doc: 'Replaced'
    0x38:
      id: 'rejected'
      doc: 'Rejected'
    0x43:
      id: 'expired'
      doc: 'Expired'
    0x44:
      id: 'restated'
      doc: 'Restated'
    0x46:
      id: 'trade'
      doc: 'Trade'
    0x48:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
    0x39:
      id: 'suspended'
      doc: 'Suspended'
  execution_report_order_status:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'partially_filled'
      doc: 'Partially Filled'
    2:
      id: 'filled'
      doc: 'Filled'
    4:
      id: 'cancelled'
      doc: 'Cancelled'
    6:
      id: 'expired'
      doc: 'Expired'
    8:
      id: 'rejected'
      doc: 'Rejected'
    9:
      id: 'suspended'
      doc: 'Suspended'
  execution_report_pegged_exec_inst:
    1:
      id: 'permissioned_for_execution_against_midpriced_pegged_orders'
      doc: 'Permissioned For Execution Against Midpriced Pegged Orders'
    2:
      id: 'not_permissioned_for_execution_against_midpriced_pegged_orders'
      doc: 'Not Permissioned For Execution Against Midpriced Pegged Orders'
  trade_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x43:
      id: 'auction'
      doc: 'Auction'
  last_market:
    21:
      id: 'xlon_on_exchange_lse_rm'
      doc: 'Xlon On Exchange Lse Rm'
    22:
      id: 'xlom_on_exchange_non_aim_mtf'
      doc: 'Xlom On Exchange Non Aim Mtf'
    23:
      id: 'aimx_on_exchange_aim_mtf'
      doc: 'Aimx On Exchange Aim Mtf'
  type_of_trade:
    0:
      id: 'visible'
      doc: 'Visible'
    1:
      id: 'hidden'
      doc: 'Hidden'
    2:
      id: 'not_specified_for_aggressive_side_auction_trades_and_rfq_trades'
      doc: 'Not Specified For Aggressive Side Auction Trades And Rfq Trades'
  mass_cancel_response:
    0:
      id: 'rejected'
      doc: 'Rejected'
    7:
      id: 'accepted'
      doc: 'Accepted'
  order_book:
    11:
      id: 'rfq_trades'
      doc: 'Rfq Trades'
  private_quote:
    2:
      id: 'private_quote'
      doc: 'Private Quote'
  quote_request_type:
    0:
      id: 'manual_named_if_any_market_maker_i_ds_are_specified_else_anonymous'
      doc: 'Manual Named If Any Market Maker I Ds Are Specified Else Anonymous'
    1:
      id: 'automatic_named_if_any_market_maker_i_ds_are_specified_else_anonymous'
      doc: 'Automatic Named If Any Market Maker I Ds Are Specified Else Anonymous'
    2:
      id: 'manual_named'
      doc: 'Manual Named'
    3:
      id: 'manual_anonymous'
      doc: 'Manual Anonymous'
    4:
      id: 'automatic_named'
      doc: 'Automatic Named'
    5:
      id: 'automatic_anonymous'
      doc: 'Automatic Anonymous'
  account_type:
    1:
      id: 'client'
      doc: 'Client'
  order_capacity:
    1:
      id: 'matched_principal_mtch'
      doc: 'Matched Principal Mtch'
    2:
      id: 'dealing_on_own_account_deal'
      doc: 'Dealing On Own Account Deal'
    3:
      id: 'any_other_trading_capacity_aotc'
      doc: 'Any Other Trading Capacity Aotc'
  rfq_disclose_side:
    0:
      id: 'do_not_disclose'
      doc: 'Do Not Disclose'
    1:
      id: 'disclose'
      doc: 'Disclose'
  auto_rfq_exec_strategy:
    1:
      id: 'sub_lis_auction'
      doc: 'Sub Lis Auction'
    4:
      id: 'lis_winner_takes_all'
      doc: 'Lis Winner Takes All'
  quote_status:
    1:
      id: 'accepted'
      doc: 'Accepted'
    2:
      id: 'rejected'
      doc: 'Rejected'
  quote_ack_status:
    1:
      id: 'accepted'
      doc: 'Accepted'
    2:
      id: 'rejected'
      doc: 'Rejected'
  quote_resp_type:
    1:
      id: 'hit_lift'
      doc: 'Hit Lift'
    3:
      id: 'expired'
      doc: 'Expired'
    7:
      id: 'end_trade'
      doc: 'End Trade'
    8:
      id: 'timed_out'
      doc: 'Timed Out'
    11:
      id: 'cancelled'
      doc: 'Cancelled'
    100:
      id: 'replace'
      doc: 'Replace'
    101:
      id: 'executable'
      doc: 'Executable'
    102:
      id: 'make_rfq_quotes_public'
      doc: 'Make Rfq Quotes Public'
  execution_type:
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x43:
      id: 'expired'
      doc: 'Expired'
    0x44:
      id: 'restated'
      doc: 'Restated'
    0x46:
      id: 'trade'
      doc: 'Trade'
    0x48:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
  rfq_execution_report_order_status:
    1:
      id: 'p_fill'
      doc: 'P Fill'
    2:
      id: 'fill'
      doc: 'Fill'
    4:
      id: 'cancelled'
      doc: 'Cancelled'
    6:
      id: 'expired'
      doc: 'Expired'
  contra_order_book:
    1:
      id: 'regular'
      doc: 'Regular'

