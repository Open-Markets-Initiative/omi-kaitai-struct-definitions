# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Turquoise NativeTradingGateway Ntgi v6.1.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Native Trading Gateway
#   Encoding: Native Trading Gateway Interface
#   Version: 6.1.2
#   Date: 10/07/2026
#   Specification: tq301-trading-gateway-native-issue-6-1-2.pdf
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: lseg_turquoise_nativetradinggateway_ntgi_v6_1_2
  title: Lseg Turquoise NativeTradingGateway Ntgi v6.1.2
  license: MIT-0
  endian: le

doc: 'London Stock Exchange Turquoise Native Trading Gateway Ntgi v6.1.2'

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
            'message_type::new_order_message': new_order_message
            'message_type::order_cancel_replace_request_message': order_cancel_replace_request_message
            'message_type::order_cancel_request_message': order_cancel_request_message
            'message_type::order_mass_cancel_request_message': order_mass_cancel_request_message
            'message_type::execution_report_message': execution_report_message
            'message_type::order_cancel_reject_message': order_cancel_reject_message
            'message_type::order_mass_cancel_report_message': order_mass_cancel_report_message
            'message_type::new_cross_btf_message': new_cross_btf_message
            'message_type::cross_btf_cancel_request_message': cross_btf_cancel_request_message
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
      - id: comp_id
        type: str
        size: 25
        encoding: ASCII
        doc: 'Participant name'
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
        type: s1
        doc: 'Message Version that will be used in this session. Always set to one (1)'
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
      - id: logout_reason
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
        doc: 'Participant specified identifier of the rejected message if it is available'
  new_order_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: trader_id
        type: str
        size: 11
        encoding: ASCII
        doc: 'Optional Trader ID that Participants may submit'
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Optional reference of the desk the order is submitted for'
      - id: clearing_account
        type: u1
        enum: clearing_account
        doc: 'Clearing Account Type'
      - id: mtf_common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
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
        doc: 'Time the order expires on, in Unix (Posix) time: seconds since midnight 1 January 1970 UTC, not counting leap seconds. Ignored if the TIF is not GTT. Seconds since Unix epoch'
      - id: side
        type: s1
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
        doc: 'Limit Price. Required if OrderType is Limit. Else this field will be ignored. Implied decimal with scale 1e-8'
      - id: capacity
        type: s1
        enum: capacity
        doc: 'Capacity of the order'
      - id: auto_cancel
        type: s1
        enum: auto_cancel
        doc: 'Checks Participant preferences on logout/disconnection of session'
      - id: order_sub_type
        type: s1
        enum: order_sub_type
        doc: 'Used to specify the order sub type'
      - id: owner_type
        type: u1
        enum: owner_type
        doc: 'Denotes whether the order is Retail, from a Retail Liquidity Provider (LP) or neither'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: target_book
        type: u1
        enum: target_book
        doc: 'Indicates the target book for the order'
      - id: exec_instruction
        type: s1
        enum: exec_instruction
        doc: 'Indicates if the order should participate only in Turquoise Dark Uncross events, or in continuous trading as well'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Fill size. Set to zero if there is no minimum fill size'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: peg_price_type
        type: u1
        enum: peg_price_type
        doc: 'Pegged Price Type of the Order'
      - id: passive_only_order
        type: s1
        enum: passive_only_order
        doc: 'Whether an order will rest prior to execution, and for a BI whether it matches with CBIs'
      - id: cl_ord_link_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Identifier linking the Order to the OSR. Must be populated with the Order ID of the OSR'
      - id: client_id
        type: u4
        enum: client_id
        doc: 'Identifier of the client. Short codes 4 - 4,294,967,295'
      - id: investment_decision_maker
        type: u4
        enum: investment_decision_maker
        doc: 'Identifier of the trading member/participant who made investment decision. Short codes 4 - 4,294,967,295'
      - id: executing_within_firm
        type: u4
        enum: executing_within_firm
        doc: 'Identifier of the trading member/participant who made the execution decision. Short codes 4 - 4,294,967,295'
      - id: mi_fid_flags
        type: mi_fid_flags
        doc: 'Flags identifying DEA involvement, Algo and liquidity provision activity'
      - id: party_role_qualifiers
        type: party_role_qualifiers
        doc: 'Further qualification for the Client ID, Investment Decision Maker and Executing Trader identifiers'
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
        doc: 'Qualifies the Client ID'
      - id: investor_information_qualifier
        type: b2
        doc: 'Qualifies the Investment Decision Maker'
      - id: executing_trader_qualifier
        type: b2
        doc: 'Qualifies the Executing Trader'
      - id: reserved_67
        type: b2
        doc: 'Reserved for future use'
  order_cancel_replace_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: original_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant Order ID of the order being amended'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
      - id: expire_date_time
        type: second_timestamp
        doc: 'Time the order expires on, in Unix (Posix) time: seconds since midnight 1 January 1970 UTC, not counting leap seconds. Ignored if the TIF is not GTT. Seconds since Unix epoch'
      - id: order_qty
        type: s4
        doc: 'Total order quantity'
      - id: display_qty
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: limit_price
        type: decimal_s8_8
        doc: 'Limit Price. Required if OrderType is Limit. Else this field will be ignored. Implied decimal with scale 1e-8'
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Optional reference of the desk the order is submitted for'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: side
        type: s1
        enum: side
        doc: 'Side of the order'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: target_book
        type: u1
        enum: target_book
        doc: 'Indicates the target book for the order'
      - id: exec_instruction
        type: s1
        enum: exec_instruction
        doc: 'Indicates if the order should participate only in Turquoise Dark Uncross events, or in continuous trading as well'
      - id: min_qty
        type: s4
        doc: 'Minimum Fill size. Set to zero if there is no minimum fill size'
      - id: passive_only_order
        type: s1
        enum: passive_only_order
        doc: 'Whether an order will rest prior to execution, and for a BI whether it matches with CBIs'
      - id: reserved_3
        size: 3
        doc: 'Reserved for future use'
  order_cancel_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: original_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant Order ID of the order being amended'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
      - id: side
        type: s1
        enum: side
        doc: 'Side of the order'
      - id: target_book
        type: u1
        enum: target_book
        doc: 'Indicates the target book for the order'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
  order_mass_cancel_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: mass_cancel_type
        type: s1
        enum: mass_cancel_type
        doc: 'Type of Mass Cancellation'
      - id: common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
      - id: segment
        type: str
        size: 4
        encoding: ASCII
        doc: 'The segment for which the orders will be cancelled. Required if MassCancelType = 4 or 15'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: target_book
        type: u1
        enum: target_book
        doc: 'Indicates the target book for the order'
      - id: reserved_9
        size: 9
        doc: 'Reserved for future use'
  execution_report_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique ID of the Execution Report. Unique across all partitions'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
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
        doc: 'Execution ID of the trade being cancelled or corrected. Populated if ExecType is Trade Cancel'
      - id: order_status
        type: s1
        enum: order_status
        doc: 'The status of the order'
      - id: order_reject_code
        type: s4
        doc: 'Code specifying the reason for the reject. See TQ801'
      - id: executed_price
        type: decimal_s8_8
        doc: 'Value of this fill. Required if ExecType is Trade. Implied decimal with scale 1e-8'
      - id: executed_qty
        type: s4
        doc: 'Quantity that was executed in this fill'
      - id: leaves_qty
        type: s4
        doc: 'Quantity available for further execution'
      - id: waiver_flags
        type: u1
        doc: 'Pre-trade waiver flag. Populated when Execution Type is F or H'
      - id: display_qty
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
      - id: side
        type: s1
        enum: side
        doc: 'Side of the order'
      - id: secondary_order_id
        type: u8
        doc: 'GTP Order ID'
      - id: counterparty
        type: str
        size: 11
        encoding: ASCII
        doc: 'Own Firm ID if internalised, Contra Party Firm ID if not cleared, else the CCP (ECCP, LCH, X-Clear)'
      - id: trade_liquidity_indicator
        type: u1
        enum: trade_liquidity_indicator
        doc: 'Whether the order added or removed liquidity. Only considered if Exec Type is Trade (F) or Trade Cancel (H)'
      - id: trade_match_id
        type: u8
        doc: 'Contains the trade identifier sent on the GTP market data feed'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: target_book
        type: u1
        enum: target_book
        doc: 'Indicates the target book for the order'
      - id: type_of_trade
        type: s1
        enum: type_of_trade
        doc: 'Indicates whether the executed portion of a passive order is visible or hidden'
      - id: capacity
        type: s1
        enum: capacity
        doc: 'Capacity of the order'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: public_order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique for each replenishment of a particular iceberg order. Base 62 in ASCII'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Fill size. Set to zero if there is no minimum fill size'
      - id: reputational_score
        type: s1
        doc: 'Reputational Score for a BI Participant at the time of the Turquoise Block Discovery match'
      - id: last_market
        type: u1
        enum: last_market
        doc: 'Market (Segment MIC) where execution took place'
      - id: peg_price_type
        type: u1
        enum: peg_price_type
        doc: 'Pegged Price Type of the Order'
      - id: owner_type
        type: u1
        enum: owner_type
        doc: 'Denotes whether the order is Retail, from a Retail Liquidity Provider (LP) or neither'
      - id: waiver_flags_2
        type: u1
        doc: 'The pre-trade waiver flag introduced in MiFID II. Populated when ExecType is F and H'
      - id: reserved_21
        size: 21
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
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
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
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
  order_mass_cancel_report_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: mass_cancel_response
        type: s1
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
  new_cross_btf_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'An identifier of the BTF pre-arranged Trade'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The type of the BTF pre-arranged Trade'
      - id: buy_side_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the buy side'
      - id: buy_side_order_capacity
        type: u1
        enum: buy_side_order_capacity
        doc: 'Capacity of the buy side'
      - id: buy_side_clearing_account
        type: u1
        enum: buy_side_clearing_account
        doc: 'Clearing Account Type'
      - id: buy_side_order_quantity
        type: s4
        doc: 'Total quantity of the BTF pre-arranged Trade'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: buy_side_firm_id
        type: str
        size: 11
        encoding: ASCII
        doc: 'Identifier of the Buy Side Firm'
      - id: buy_side_party_role
        type: u1
        enum: buy_side_party_role
        doc: 'Role of the specified Firm'
      - id: buy_mi_fid_flags
        type: buy_mi_fid_flags
        doc: 'Buy side flags identifying DEA involvement, Algo and liquidity provision activity'
      - id: buy_client_id
        type: u4
        enum: buy_client_id
        doc: 'Identifier of the client. Short codes 4 - 4294967295'
      - id: buy_investment_decision_maker
        type: u4
        enum: buy_investment_decision_maker
        doc: 'Identifier of the trading member/participant who made investment decision'
      - id: buy_executing_trader
        type: u4
        enum: buy_executing_trader
        doc: 'Identifier of the trading member/participant who made the execution decision'
      - id: buy_party_role_qualifiers
        type: buy_party_role_qualifiers
        doc: 'Further qualification for the buy side Client ID, Investment Decision Maker and Executing Trader identifiers'
      - id: sell_side_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the sell side'
      - id: sell_side_order_capacity
        type: u1
        enum: sell_side_order_capacity
        doc: 'Capacity of the sell side'
      - id: sell_side_clearing_account
        type: u1
        enum: sell_side_clearing_account
        doc: 'Clearing Account Type'
      - id: sell_side_order_quantity
        type: s4
        doc: 'Total quantity of the BTF pre-arranged Trade'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: sell_side_firm_id
        type: str
        size: 11
        encoding: ASCII
        doc: 'Identifier of the Sell Side Firm'
      - id: sell_side_party_role
        type: u1
        enum: sell_side_party_role
        doc: 'Role of the specified Firm'
      - id: sell_mi_fid_flags
        type: sell_mi_fid_flags
        doc: 'Sell side flags identifying DEA involvement, Algo and liquidity provision activity'
      - id: sell_client_id
        type: u4
        enum: sell_client_id
        doc: 'Identifier of the client. Short codes 4 - 4294967295'
      - id: sell_investment_decision_maker
        type: u4
        enum: sell_investment_decision_maker
        doc: 'Identifier of the trading member/participant who made investment decision'
      - id: sell_executing_trader
        type: u4
        enum: sell_executing_trader
        doc: 'Identifier of the trading member/participant who made the execution decision'
      - id: sell_party_role_qualifiers
        type: sell_party_role_qualifiers
        doc: 'Further qualification for the sell side Client ID, Investment Decision Maker and Executing Trader identifiers'
      - id: mtf_common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
      - id: price
        type: decimal_s8_8
        doc: 'Price of the BTF. Implied decimal with scale 1e-8'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of order'
      - id: tif
        type: u1
        enum: tif
        doc: 'Time qualifier of the order'
  buy_mi_fid_flags:
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
  buy_party_role_qualifiers:
    meta:
      bit-endian: le
    seq:
      - id: client_id_qualifier
        type: b2
        doc: 'Qualifies the Client ID'
      - id: investor_information_qualifier
        type: b2
        doc: 'Qualifies the Investment Decision Maker'
      - id: executing_trader_qualifier
        type: b2
        doc: 'Qualifies the Executing Trader'
      - id: reserved_67
        type: b2
        doc: 'Reserved for future use'
  sell_mi_fid_flags:
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
  sell_party_role_qualifiers:
    meta:
      bit-endian: le
    seq:
      - id: client_id_qualifier
        type: b2
        doc: 'Qualifies the Client ID'
      - id: investor_information_qualifier
        type: b2
        doc: 'Qualifies the Investment Decision Maker'
      - id: executing_trader_qualifier
        type: b2
        doc: 'Qualifies the Executing Trader'
      - id: reserved_67
        type: b2
        doc: 'Reserved for future use'
  cross_btf_cancel_request_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'An identifier of the BTF pre-arranged Trade'
      - id: original_cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Cross ID of the BTF being cancelled'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The type of the BTF pre-arranged Trade'
      - id: buy_side_original_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The Buy Side ClOrdID of the BTF pre-arranged Trade to be cancelled'
      - id: buy_side_order_quantity
        type: s4
        doc: 'Total quantity of the BTF pre-arranged Trade'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: sell_side_original_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The Sell Side ClOrdID of the BTF pre-arranged Trade to be cancelled'
      - id: sell_side_order_quantity
        type: s4
        doc: 'Total quantity of the BTF pre-arranged Trade'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: mtf_common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
  business_reject_message:
    seq:
      - id: app_id
        type: s1
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
        doc: 'Participant specified identifier of the rejected message if it is available'
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
      doc: 'Allows the Participant and server to establish a session.'
    0x42:
      id: 'logon_reply_message'
      doc: 'Allows the server to acknowledge a Participant''s Logon.'
    0x35:
      id: 'logout_message'
      doc: 'Allows the Participant and server to terminate a session.'
    0x30:
      id: 'heartbeat_message'
      doc: 'Allows the Participant and server to exercise the communication line during periods of inactivity and verify that the interfaces at each end are available.'
    0x33:
      id: 'reject_message'
      doc: 'Allows the Server to reject a message that does not comply with the Native Trading Gateway messaging protocol.'
    0x44:
      id: 'new_order_message'
      doc: 'Allows the Participant to submit a new order.'
    0x47:
      id: 'order_cancel_replace_request_message'
      doc: 'Allows the Participant to cancel/replace a live order.'
    0x46:
      id: 'order_cancel_request_message'
      doc: 'Allows the Participant to cancel a live order.'
    0x71:
      id: 'order_mass_cancel_request_message'
      doc: 'Allows the Participant to mass cancel all live orders, those for an instrument or those for a segment.'
    0x38:
      id: 'execution_report_message'
      doc: 'Indicates order accepted, rejected, executed, expired, cancelled, cancel/replaced, trade cancel, BI triggered or pending cancel.'
    0x39:
      id: 'order_cancel_reject_message'
      doc: 'Indicates that an Order Cancel Request or Order Cancel/Replace Request has been rejected.'
    0x72:
      id: 'order_mass_cancel_report_message'
      doc: 'Indicates a mass order cancel request was accepted or rejected.'
    0x43:
      id: 'new_cross_btf_message'
      doc: 'Allows the client to submit a BTF pre-arranged Trade.'
    0x48:
      id: 'cross_btf_cancel_request_message'
      doc: 'Allows the client to cancel a Committed BTF pre-arranged Trade.'
    0x6a:
      id: 'business_reject_message'
      doc: 'Indicates that an application message could not be processed.'
  clearing_account:
    1:
      id: 'client'
      doc: 'Client'
    3:
      id: 'house'
      doc: 'House'
  order_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
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
    8:
      id: 'good_till_time_gtt'
      doc: 'Good Till Time Gtt'
    9:
      id: 'good_for_auction_gfa'
      doc: 'Good For Auction Gfa'
  side:
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
      id: 'do_not_cancel_on_disconnect'
      doc: 'Do Not Cancel On Disconnect'
    1:
      id: 'check_system_preference'
      doc: 'Check System Preference'
  order_sub_type:
    0:
      id: 'order'
      doc: 'Order'
    1:
      id: 'bi'
      doc: 'Bi'
    3:
      id: 'order_bdn'
      doc: 'Order Bdn'
    5:
      id: 'pegged_order'
      doc: 'Pegged Order'
    51:
      id: 'random'
      doc: 'Random'
  owner_type:
    0:
      id: 'non_retail'
      doc: 'Non Retail'
    1:
      id: 'retail'
      doc: 'Retail'
    2:
      id: 'retail_lp'
      doc: 'Retail Lp'
  target_book:
    0:
      id: 'turquoise_dark_order_book_trqm_or_tqem'
      doc: 'Turquoise Dark Order Book Trqm Or Tqem'
    1:
      id: 'turquoise_lit_order_book_trqx_or_tqex'
      doc: 'Turquoise Lit Order Book Trqx Or Tqex'
    3:
      id: 'turquoise_dark_lit_sweep_trqm_and_trqx_or_tqem_and_tqex'
      doc: 'Turquoise Dark Lit Sweep Trqm And Trqx Or Tqem And Tqex'
    4:
      id: 'turquoise_periodic_auctions_order_book_trqa_or_tqea'
      doc: 'Turquoise Periodic Auctions Order Book Trqa Or Tqea'
  exec_instruction:
    0:
      id: 'apply_user_level_default'
      doc: 'Apply User Level Default'
    1:
      id: 'turquoise_dark_uncross_only'
      doc: 'Turquoise Dark Uncross Only'
    2:
      id: 'continuous_only'
      doc: 'Continuous Only'
    5:
      id: 'continuous_and_turquoise_dark_uncross'
      doc: 'Continuous And Turquoise Dark Uncross'
    6:
      id: 'turquoise_dark_uncross_then_continuous'
      doc: 'Turquoise Dark Uncross Then Continuous'
  peg_price_type:
    0:
      id: 'default_midpoint'
      doc: 'Default Midpoint'
    1:
      id: 'closing_price_clse_tghl_only'
      doc: 'Closing Price Clse Tghl Only'
    2:
      id: 'midpoint'
      doc: 'Midpoint'
    10:
      id: 'best_bid'
      doc: 'Best Bid'
    11:
      id: 'best_offer'
      doc: 'Best Offer'
  passive_only_order:
    0:
      id: 'no_constraint'
      doc: 'No Constraint'
    1:
      id: 'accept_order_if_setting_new_bbo_or_joining_existing_bbo'
      doc: 'Accept Order If Setting New Bbo Or Joining Existing Bbo'
    2:
      id: 'accept_order_if_joining_existing_bbo_or_within_one_visible_price_point'
      doc: 'Accept Order If Joining Existing Bbo Or Within One Visible Price Point'
    3:
      id: 'accept_order_if_joining_existing_bbo_or_within_two_visible_price_points'
      doc: 'Accept Order If Joining Existing Bbo Or Within Two Visible Price Points'
    50:
      id: 'bi_opt_out_of_matching_with_cbi'
      doc: 'Bi Opt Out Of Matching With Cbi'
    99:
      id: 'accept_order_only_if_passive_upon_order_entry'
      doc: 'Accept Order Only If Passive Upon Order Entry'
    100:
      id: 'accept_order_if_setting_new_bbo'
      doc: 'Accept Order If Setting New Bbo'
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
  executing_within_firm:
    3:
      id: 'client'
      doc: 'Client'
  client_id_qualifier:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'lei_firm'
      doc: 'Lei Firm'
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
      id: 'lei_firm'
      doc: 'Lei Firm'
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
      id: 'lei_firm'
      doc: 'Lei Firm'
    2:
      id: 'algo'
      doc: 'Algo'
    3:
      id: 'natural_person'
      doc: 'Natural Person'
  mass_cancel_type:
    3:
      id: 'all_firm_orders_for_an_instrument'
      doc: 'All Firm Orders For An Instrument'
    4:
      id: 'all_firm_orders_in_a_segment'
      doc: 'All Firm Orders In A Segment'
    7:
      id: 'all_orders_submitted_by_the_comp_id'
      doc: 'All Orders Submitted By The Comp Id'
    8:
      id: 'all_firm_orders'
      doc: 'All Firm Orders'
    9:
      id: 'all_orders_submitted_by_the_comp_id_for_an_instrument'
      doc: 'All Orders Submitted By The Comp Id For An Instrument'
    15:
      id: 'all_orders_submitted_by_the_comp_id_for_a_segment'
      doc: 'All Orders Submitted By The Comp Id For A Segment'
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
    0x36:
      id: 'pending_cancel'
      doc: 'Pending Cancel'
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
    0x4c:
      id: 'triggered'
      doc: 'Triggered'
  order_status:
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
    13:
      id: 'pending_cancel'
      doc: 'Pending Cancel'
  trade_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x43:
      id: 'turquoise_dark_uncross_or_periodic_auctions_execution'
      doc: 'Turquoise Dark Uncross Or Periodic Auctions Execution'
    0x53:
      id: 'turquoise_block_discovery_execution_turquoise_dark_uncross'
      doc: 'Turquoise Block Discovery Execution Turquoise Dark Uncross'
    0x42:
      id: 'btf_trade'
      doc: 'Btf Trade'
  type_of_trade:
    0:
      id: 'visible'
      doc: 'Visible'
    1:
      id: 'hidden'
      doc: 'Hidden'
    2:
      id: 'not_specified'
      doc: 'Not Specified'
  last_market:
    1:
      id: 'trqx_turquoise_lit_order_book'
      doc: 'Trqx Turquoise Lit Order Book'
    2:
      id: 'trqm_turquoise_dark_order_book'
      doc: 'Trqm Turquoise Dark Order Book'
    3:
      id: 'trqa_turquoise_periodic_auctions_order_book'
      doc: 'Trqa Turquoise Periodic Auctions Order Book'
    5:
      id: 'tqex_turquoise_lit_order_book_tghe'
      doc: 'Tqex Turquoise Lit Order Book Tghe'
    6:
      id: 'tqem_turquoise_dark_order_book_tghe'
      doc: 'Tqem Turquoise Dark Order Book Tghe'
    7:
      id: 'tqea_turquoise_periodic_auctions_order_book_tghe'
      doc: 'Tqea Turquoise Periodic Auctions Order Book Tghe'
  mass_cancel_response:
    0:
      id: 'rejected'
      doc: 'Rejected'
    7:
      id: 'accepted'
      doc: 'Accepted'
  cross_type:
    6:
      id: 'internal_btf'
      doc: 'Internal Btf'
    8:
      id: 'committed_btf'
      doc: 'Committed Btf'
  buy_side_order_capacity:
    1:
      id: 'matched_principal_mtch'
      doc: 'Matched Principal Mtch'
    2:
      id: 'dealing_on_own_account_deal'
      doc: 'Dealing On Own Account Deal'
    3:
      id: 'any_other_trading_capacity_aotc'
      doc: 'Any Other Trading Capacity Aotc'
  buy_side_clearing_account:
    1:
      id: 'client'
      doc: 'Client'
    3:
      id: 'house'
      doc: 'House'
  buy_side_party_role:
    1:
      id: 'executing_firm'
      doc: 'Executing Firm'
    17:
      id: 'counterparty_firm'
      doc: 'Counterparty Firm'
  buy_client_id:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'aggr'
      doc: 'Aggr'
    2:
      id: 'pnal'
      doc: 'Pnal'
  buy_investment_decision_maker:
    0:
      id: 'none'
      doc: 'None'
  buy_executing_trader:
    3:
      id: 'client'
      doc: 'Client'
  sell_side_order_capacity:
    1:
      id: 'matched_principal_mtch'
      doc: 'Matched Principal Mtch'
    2:
      id: 'dealing_on_own_account_deal'
      doc: 'Dealing On Own Account Deal'
    3:
      id: 'any_other_trading_capacity_aotc'
      doc: 'Any Other Trading Capacity Aotc'
  sell_side_clearing_account:
    1:
      id: 'client'
      doc: 'Client'
    3:
      id: 'house'
      doc: 'House'
  sell_side_party_role:
    1:
      id: 'executing_firm'
      doc: 'Executing Firm'
    17:
      id: 'counterparty_firm'
      doc: 'Counterparty Firm'
  sell_client_id:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'aggr'
      doc: 'Aggr'
    2:
      id: 'pnal'
      doc: 'Pnal'
  sell_investment_decision_maker:
    0:
      id: 'none'
      doc: 'None'
  sell_executing_trader:
    3:
      id: 'client'
      doc: 'Client'

