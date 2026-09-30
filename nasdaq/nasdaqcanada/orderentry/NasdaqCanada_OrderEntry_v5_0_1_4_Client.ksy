# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NasdaqCanada OrderEntry Ouch v5.0.1.4
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nasdaq Canada Order Entry
#   Encoding: Ouch
#   Version: 5.0.1.4
#   Date: 09/02/2026
#   Specification: nasdaq-canada-ouch.pdf
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
  id: nasdaq_nasdaqcanada_orderentry_ouch_v5_0_1_4_client
  title: Nasdaq NasdaqCanada OrderEntry Ouch v5.0.1.4
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Canada Nasdaq Canada Order Entry Ouch v5.0.1.4'
doc-ref:
  - https://www.nasdaq.com/products/north-american-markets/canada/connectivity
  - https://www.nasdaq.com/docs/nasdaq-canada-ouch

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
        size: 1
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
            'unsequenced_message_type::enter_order_message': enter_order_message
            'unsequenced_message_type::replace_order_request_message': replace_order_request_message
            'unsequenced_message_type::cancel_order_request_message': cancel_order_request_message
            'unsequenced_message_type::account_query_request_message': account_query_request_message
  enter_order_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'As described above in Data Types. UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: order_qty
        type: u4
        doc: 'Total number of shares'
      - id: price
        type: decimal_u8_8
        doc: 'Maximum 999,999. A price of 0 will be treated as a market order. Implied 8 decimal places. Implied decimal with scale 1e-8'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy; 2 = Sell; 5 = Sell Short'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Local/exchange symbol only'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: '0 = Day; 3 = Immediate or Cancel; 6 = Good Till Date (GTD), must be used with ExpireTime; 8 = Stream Or Kill (SOK), CXD PureStream only; P = Post-Only Order'
      - id: ex_destination
        type: u1
        enum: ex_destination
        doc: 'Indicates how the order should be routed: C = CXC; 2 = CX2; D = CXD; S = Smart Order Router (requires RoutingStrategy)'
      - id: umir_account_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Required for Canadian regulatory reporting'
      - id: umir_user_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Required for Canadian regulatory reporting, and represents the trading system''s user ID for the trader'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage Field. Required. If no optional appendage, length=0'
      - id: enter_order_appendage
        type: enter_order_appendage
        repeat: eos
        doc: 'Enter Order Appendage'
  enter_order_appendage:
    seq:
      - id: optional_field_length
        type: s1
        doc: 'Apendage Length Type'
      - id: enter_order_optional_field
        type: s1
        enum: enter_order_optional_field
        doc: 'Apendage Id'
      - id: enter_order_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: enter_order_optional_field
          cases:
            'enter_order_optional_field::userrefidx': user_ref_idx_value
            'enter_order_optional_field::account': account_value
            'enter_order_optional_field::pegtype': peg_type_value
            'enter_order_optional_field::minqtytype': min_qty_type_value
            'enter_order_optional_field::minqty': min_qty_value
            'enter_order_optional_field::maxfloor': max_floor_value
            'enter_order_optional_field::expiretime': expire_time_value
            'enter_order_optional_field::pegoffset': peg_offset_value
            'enter_order_optional_field::targetstrategy': target_strategy_value
            'enter_order_optional_field::orderorigination': order_origination_value
            'enter_order_optional_field::routingarrangementindicator': routing_arrangement_indicator_value
            'enter_order_optional_field::baskettrade': basket_trade_value
            'enter_order_optional_field::programtrade': program_trade_value
            'enter_order_optional_field::jitney': jitney_value
            'enter_order_optional_field::gefeligible': gef_eligible_value
            'enter_order_optional_field::anonymous': anonymous_value
            'enter_order_optional_field::umirregulationid': umir_regulation_id_value
            'enter_order_optional_field::bypass': bypass_value
            'enter_order_optional_field::tsxncib': tsxncib_value
            'enter_order_optional_field::notradefeat': no_trade_feat_value
            'enter_order_optional_field::notradekey': no_trade_key_value
            'enter_order_optional_field::shortmarkingexempt': short_marking_exempt_value
            'enter_order_optional_field::pocomment': po_comment_value
            'enter_order_optional_field::displayrange': display_range_value
            'enter_order_optional_field::customeraccount': customer_account_value
            'enter_order_optional_field::algorithmid': algorithm_id_value
            'enter_order_optional_field::customerlei': customer_lei_value
            'enter_order_optional_field::brokerlei': broker_lei_value
            'enter_order_optional_field::conditionalorder': conditional_order_value
            'enter_order_optional_field::allowconditional': allow_conditional_value
            'enter_order_optional_field::firmupid': firm_up_id_value
            'enter_order_optional_field::cxdconnect': cxd_connect_value
            'enter_order_optional_field::purestreamconnect': pure_stream_connect_value
            'enter_order_optional_field::minrate': min_rate_value
            'enter_order_optional_field::maxrate': max_rate_value
            'enter_order_optional_field::routingstrategy': routing_strategy_value
            'enter_order_optional_field::handlinst': handl_inst_value
  replace_order_request_message:
    seq:
      - id: orig_user_ref_num
        type: u4
        doc: 'This must be filled out with the Order UserRefNum sent on the Enter Order Message or last Replace Order Message'
      - id: user_ref_num
        type: u4
        doc: 'As described above in Data Types. UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: order_qty
        type: u4
        doc: 'Total number of shares'
      - id: price
        type: decimal_u8_8
        doc: 'Maximum 999,999. A price of 0 will be treated as a market order. Implied 8 decimal places. Implied decimal with scale 1e-8'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy; 2 = Sell; 5 = Sell Short'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: '0 = Day; 3 = Immediate or Cancel; 6 = Good Till Date (GTD), must be used with ExpireTime; 8 = Stream Or Kill (SOK), CXD PureStream only; P = Post-Only Order'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage Field. Required. If no optional appendage, length=0'
      - id: replace_order_request_appendage
        type: replace_order_request_appendage
        repeat: eos
        doc: 'Replace Order Request Appendage'
  replace_order_request_appendage:
    seq:
      - id: optional_field_length
        type: s1
        doc: 'Apendage Length Type'
      - id: replace_order_request_optional_field
        type: s1
        enum: replace_order_request_optional_field
        doc: 'Apendage Id'
      - id: replace_order_request_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: replace_order_request_optional_field
          cases:
            'replace_order_request_optional_field::userrefidx': user_ref_idx_value
            'replace_order_request_optional_field::minqtytype': min_qty_type_value
            'replace_order_request_optional_field::pegtype': peg_type_value
            'replace_order_request_optional_field::minqty': min_qty_value
            'replace_order_request_optional_field::maxfloor': max_floor_value
            'replace_order_request_optional_field::expiretime': expire_time_value
            'replace_order_request_optional_field::pegoffset': peg_offset_value
            'replace_order_request_optional_field::targetstrategy': target_strategy_value
            'replace_order_request_optional_field::orderorigination': order_origination_value
            'replace_order_request_optional_field::routingarrangementindicator': routing_arrangement_indicator_value
            'replace_order_request_optional_field::umirregulationid': umir_regulation_id_value
            'replace_order_request_optional_field::anonymous': anonymous_value
            'replace_order_request_optional_field::displayrange': display_range_value
            'replace_order_request_optional_field::customeraccount': customer_account_value
            'replace_order_request_optional_field::algorithmid': algorithm_id_value
            'replace_order_request_optional_field::customerlei': customer_lei_value
            'replace_order_request_optional_field::brokerlei': broker_lei_value
            'replace_order_request_optional_field::allowconditional': allow_conditional_value
            'replace_order_request_optional_field::cxdconnect': cxd_connect_value
            'replace_order_request_optional_field::purestreamconnect': pure_stream_connect_value
            'replace_order_request_optional_field::minrate': min_rate_value
            'replace_order_request_optional_field::maxrate': max_rate_value
            'replace_order_request_optional_field::handlinst': handl_inst_value
  cancel_order_request_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'As described above in Data Types. UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: order_qty
        type: u4
        doc: 'Total number of shares'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage Field. Required. If no optional appendage, length=0'
      - id: cancel_order_request_appendage
        type: cancel_order_request_appendage
        repeat: eos
        doc: 'Cancel Order Request Appendage'
  cancel_order_request_appendage:
    seq:
      - id: optional_field_length
        type: s1
        doc: 'Apendage Length Type'
      - id: cancel_order_request_optional_field
        type: s1
        enum: cancel_order_request_optional_field
        doc: 'Apendage Id'
      - id: cancel_order_request_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: cancel_order_request_optional_field
          cases:
            'cancel_order_request_optional_field::userrefidx': user_ref_idx_value
  account_query_request_message:
    seq:
      - id: appendage_length
        type: u2
        if: not _io.eof
        doc: 'The length of the remaining Optional Appendage Field. Required. If no optional appendage, length=0'
      - id: account_query_request_appendage
        type: account_query_request_appendage
        repeat: eos
        doc: 'Account Query Request Appendage'
  account_query_request_appendage:
    seq:
      - id: optional_field_length
        type: s1
        doc: 'Apendage Length Type'
      - id: account_query_request_optional_field
        type: s1
        enum: account_query_request_optional_field
        doc: 'Apendage Id'
      - id: account_query_request_optional_value
        size: optional_field_length + 1 - 2
        type:
          switch-on: account_query_request_optional_field
          cases:
            'account_query_request_optional_field::userrefidx': user_ref_idx_value
  user_ref_idx_value:
    seq:
      - id: user_ref_idx
        type: u1
        doc: 'User Reference Index - identifies the channel within the given port'
  account_value:
    seq:
      - id: account
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account'
  peg_type_value:
    seq:
      - id: peg_type
        type: u1
        enum: peg_type
        doc: 'M = Midpoint Peg; R = Primary Peg; x = Minimum Price Improvement; S = Seek Price Improvement; L = M-ELO (CXC Only); o = Odd Lot Liquidity Providing (OLP) (CXD Only)'
  min_qty_type_value:
    seq:
      - id: min_qty_type
        type: u1
        enum: min_qty_type
        doc: 'N = MAQ; m = MAQ at touch (CXD only); t = MQ at touch (CXD only); z = Minimum Quantity (MQ). Default N'
  min_qty_value:
    seq:
      - id: min_qty
        type: u4
        doc: 'Works in conjunction with MinQtyType. Order will be rejected if Bypass=Y is combined with MinQty. Requires MaxFloor=0 (Hidden). Default 0 (zero), no minimum quantity'
  max_floor_value:
    seq:
      - id: max_floor
        type: u4
        doc: 'Represents the portion of the order to be displayed (0=Hidden). Default Max Floor=OrderQty'
  expire_time_value:
    seq:
      - id: expire_time
        type: u4
        doc: 'Seconds to live. Must be less than 86400 (number of seconds in a day). Default 0 (zero), no expire time'
  peg_offset_value:
    seq:
      - id: peg_offset
        type: decimal_s8_8
        doc: 'Offset amount for the pegged value. Default 0 (zero), no peg offset. Implied decimal with scale 1e-8'
  target_strategy_value:
    seq:
      - id: target_strategy
        type: u2
        enum: target_strategy
        doc: '1000 = Liquidity Rate 5-15%; 1001 = Liquidity Rate 5-30%; 1002 = Mach Two 10 - 200%; 1003 = Custom Liquidity Rate'
  order_origination_value:
    seq:
      - id: order_origination
        type: u1
        enum: order_origination
        doc: 'Broker/Dealer needs to report, as specified by the customer'
  routing_arrangement_indicator_value:
    seq:
      - id: routing_arrangement_indicator
        type: u1
        enum: routing_arrangement_indicator
        doc: '0 = No routing arrangement in place; 1 = Routing arrangement in place'
  basket_trade_value:
    seq:
      - id: basket_trade
        type: u1
        enum: basket_trade
        doc: 'N = No; Y = Yes. Default N (No)'
  program_trade_value:
    seq:
      - id: program_trade
        type: u1
        enum: program_trade
        doc: 'N = No; Y = Yes. Default N (No)'
  jitney_value:
    seq:
      - id: jitney
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'To mark an order as being executed on behalf of another broker: TSX Broker Number, 3 digit numbers'
  gef_eligible_value:
    seq:
      - id: gef_eligible
        type: u1
        enum: gef_eligible
        doc: 'N = No; Y = Yes. Default N (No)'
  anonymous_value:
    seq:
      - id: anonymous
        type: u1
        enum: anonymous
        doc: 'N = No; Y = Yes. Default N (No)'
  umir_regulation_id_value:
    seq:
      - id: umir_regulation_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'IA = Insider Account; SS = Significant Shareholder'
  bypass_value:
    seq:
      - id: bypass
        type: u1
        enum: bypass
        doc: 'Order marker that indicates the order should only trade with displayed quantity. N = No; Y = Yes. Default N (No)'
  tsxncib_value:
    seq:
      - id: tsxncib
        type: u1
        enum: tsxncib
        doc: 'Identifies Normal-Course Issuer Bid (NCIB) orders. N = No; Y = Yes. Default N (No)'
  no_trade_feat_value:
    seq:
      - id: no_trade_feat
        type: u1
        enum: no_trade_feat
        doc: 'Defines the behavior of self-trade prevention when using NoTradeKey. If option E is selected, resulting trades are suppressed on public market data, and ExecuteMatch appendage will be returned to entry firm. Default N (Cancel Newest)'
  no_trade_key_value:
    seq:
      - id: no_trade_key
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant-generated key prevents the order from trading against orders with the same key value'
  short_marking_exempt_value:
    seq:
      - id: short_marking_exempt
        type: u1
        enum: short_marking_exempt
        doc: '0 = SME'
  po_comment_value:
    seq:
      - id: po_comment
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'A free-form pass-through field for use by the participants'
  display_range_value:
    seq:
      - id: display_range
        type: u4
        doc: 'Quantity assigned to max floor orders indicating the range in which the displayed quantity will randomly increase or decrease'
  customer_account_value:
    seq:
      - id: customer_account
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Account number for clients not eligible to obtain an LEI'
  algorithm_id_value:
    seq:
      - id: algorithm_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier for the end-client (orders automatically generated on a predetermined basis)'
  customer_lei_value:
    seq:
      - id: customer_lei
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'LEI for clients eligible to obtain an LEI including LEI of the foreign dealer equivalent (Encryption Required)'
  broker_lei_value:
    seq:
      - id: broker_lei
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Non-PO IIROC Dealer Member (Correspondent Broker)'
  conditional_order_value:
    seq:
      - id: conditional_order
        type: u1
        enum: conditional_order
        doc: 'C = Conditional Order (CXD only); X = eXtended Firm-up Time (XFT) conditional order (CXD only)'
  allow_conditional_value:
    seq:
      - id: allow_conditional
        type: u1
        enum: allow_conditional
        doc: 'N = No; Y = Yes. Default N (No)'
  firm_up_id_value:
    seq:
      - id: firm_up_id
        type: u8
        doc: 'Unique firm up ID for a Conditional match'
  cxd_connect_value:
    seq:
      - id: cxd_connect
        type: u1
        enum: cxd_connect
        doc: 'Y = Yes; N = No. Default N (No)'
  pure_stream_connect_value:
    seq:
      - id: pure_stream_connect
        type: u1
        enum: pure_stream_connect
        doc: 'Y = Yes; N = No. Default N (No)'
  min_rate_value:
    seq:
      - id: min_rate
        type: u2
        doc: 'Minimum rate for CXD PureStream Customer Reference Rate Range. Specified in percent as integer. Default 1 (1%)'
  max_rate_value:
    seq:
      - id: max_rate
        type: u2
        doc: 'Required maximum rate for CXD PureStream Custom Reference Rate Range orders. Specified in percent as integer. Should be between 1% and 500%'
  routing_strategy_value:
    seq:
      - id: routing_strategy
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Routing Strategy provided by Nasdaq Canada'
  handl_inst_value:
    seq:
      - id: handl_inst
        type: u1
        enum: handl_inst
        doc: 'f = DAO; 1 = OPR Reprice; 5 = OPR Cancel. Default 1'
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0

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
      doc: 'Enter Order Message'
    0x55:
      id: 'replace_order_request_message'
      doc: 'The Replace Order Message allows you to alter most of the attributes of an order in a single message. This is more efficient than canceling an existing order and immediately succeeding it with a new order.'
    0x58:
      id: 'cancel_order_request_message'
      doc: 'The Cancel Order Message is used to request that an order be canceled or reduced. You must specify the new intended order size, the maximum number of shares that can be executed in total after the cancel is applied.'
    0x51:
      id: 'account_query_request_message'
      doc: 'The Account Query Request message can be used when recovering state to request the next available UserRefNum that can be used for identifying new transactions.'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x35:
      id: 'sell_short'
      doc: 'Sell Short'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'Immediate Or Cancel As Much Of The Order As Possible Must Be Executed Immediately Any Part Of The Order That Is Not Executed Immediately Gets Canceled'
    0x36:
      id: 'good_till_date'
      doc: 'Good Till Date Gtd Date Must Be Todays Trading Date This Field Must Be Used In Conjunction With Expire Time'
    0x38:
      id: 'stream_or_kill'
      doc: 'Stream Or Kill Sok Order Is Paired In A Stream Immediately Or Is Cancelled Cxd Pure Stream Only'
    0x50:
      id: 'post_only_order'
      doc: 'Post Only Order'
  ex_destination:
    0x43:
      id: 'cxc'
      doc: 'Cxc'
    0x32:
      id: 'cx_2'
      doc: 'Cx 2'
    0x44:
      id: 'cxd'
      doc: 'Cxd'
    0x53:
      id: 'smart_order_router'
      doc: 'Smart Order Router Requires Routing Strategy'
  enter_order_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Enter Order Optional UserRefIdx Enum'
    1:
      id: 'account'
      doc: 'Enter Order Optional Account Enum'
    2:
      id: 'pegtype'
      doc: 'Enter Order Optional PegType Enum'
    3:
      id: 'minqtytype'
      doc: 'Enter Order Optional MinQtyType Enum'
    4:
      id: 'minqty'
      doc: 'Enter Order Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Enter Order Optional MaxFloor Enum'
    6:
      id: 'expiretime'
      doc: 'Enter Order Optional ExpireTime Enum'
    7:
      id: 'pegoffset'
      doc: 'Enter Order Optional PegOffset Enum'
    8:
      id: 'targetstrategy'
      doc: 'Enter Order Optional TargetStrategy Enum'
    9:
      id: 'orderorigination'
      doc: 'Enter Order Optional OrderOrigination Enum'
    10:
      id: 'routingarrangementindicator'
      doc: 'Enter Order Optional RoutingArrangementIndicator Enum'
    11:
      id: 'baskettrade'
      doc: 'Enter Order Optional BasketTrade Enum'
    12:
      id: 'programtrade'
      doc: 'Enter Order Optional ProgramTrade Enum'
    14:
      id: 'jitney'
      doc: 'Enter Order Optional Jitney Enum'
    15:
      id: 'gefeligible'
      doc: 'Enter Order Optional GEFEligible Enum'
    16:
      id: 'anonymous'
      doc: 'Enter Order Optional Anonymous Enum'
    17:
      id: 'umirregulationid'
      doc: 'Enter Order Optional UMIRRegulationID Enum'
    18:
      id: 'bypass'
      doc: 'Enter Order Optional Bypass Enum'
    19:
      id: 'tsxncib'
      doc: 'Enter Order Optional TSXNCIB Enum'
    20:
      id: 'notradefeat'
      doc: 'Enter Order Optional NoTradeFeat Enum'
    21:
      id: 'notradekey'
      doc: 'Enter Order Optional NoTradeKey Enum'
    22:
      id: 'shortmarkingexempt'
      doc: 'Enter Order Optional ShortMarkingExempt Enum'
    23:
      id: 'pocomment'
      doc: 'Enter Order Optional POComment Enum'
    24:
      id: 'displayrange'
      doc: 'Enter Order Optional DisplayRange Enum'
    25:
      id: 'customeraccount'
      doc: 'Enter Order Optional CustomerAccount Enum'
    26:
      id: 'algorithmid'
      doc: 'Enter Order Optional AlgorithmID Enum'
    27:
      id: 'customerlei'
      doc: 'Enter Order Optional CustomerLEI Enum'
    28:
      id: 'brokerlei'
      doc: 'Enter Order Optional BrokerLEI Enum'
    29:
      id: 'conditionalorder'
      doc: 'Enter Order Optional ConditionalOrder Enum'
    30:
      id: 'allowconditional'
      doc: 'Enter Order Optional AllowConditional Enum'
    31:
      id: 'firmupid'
      doc: 'Enter Order Optional FirmUpID Enum'
    32:
      id: 'cxdconnect'
      doc: 'Enter Order Optional CXDConnect Enum'
    33:
      id: 'purestreamconnect'
      doc: 'Enter Order Optional PureStreamConnect Enum'
    34:
      id: 'minrate'
      doc: 'Enter Order Optional MinRate Enum'
    35:
      id: 'maxrate'
      doc: 'Enter Order Optional MaxRate Enum'
    39:
      id: 'routingstrategy'
      doc: 'Enter Order Optional RoutingStrategy Enum'
    43:
      id: 'handlinst'
      doc: 'Enter Order Optional HandlInst Enum'
  peg_type:
    0x4d:
      id: 'midpoint_peg'
      doc: 'Midpoint Peg'
    0x52:
      id: 'primary_peg'
      doc: 'Primary Peg'
    0x78:
      id: 'minimum_price_improvement'
      doc: 'Minimum Price Improvement'
    0x53:
      id: 'seek_price_improvement'
      doc: 'Seek Price Improvement'
    0x4c:
      id: 'melo'
      doc: 'Melo Cxc Only'
    0x6f:
      id: 'odd_lot_liquidity_providing'
      doc: 'Odd Lot Liquidity Providing Olp Cxd Only'
  min_qty_type:
    0x4e:
      id: 'maq'
      doc: 'Maq Minimum Acceptable Quantity Min Qty Must Be Met On Every Partial Execution'
    0x6d:
      id: 'maq_at_touch'
      doc: 'Maq At Touch Cxd Only'
    0x74:
      id: 'mq_at_touch'
      doc: 'Mq At Touch Cxd Only'
    0x7a:
      id: 'minimum_quantity'
      doc: 'Minimum Quantity Mq Min Qty May Be Met In Aggregate'
  target_strategy:
    1000:
      id: 'liquidity_rate_515'
      doc: 'Liquidity Rate 515%'
    1001:
      id: 'liquidity_rate_530'
      doc: 'Liquidity Rate 530%'
    1002:
      id: 'mach_two_10200'
      doc: 'Mach Two 10200%'
    1003:
      id: 'custom_liquidity_rate'
      doc: 'Custom Liquidity Rate'
  order_origination:
    0x35:
      id: 'direct_access_customer'
      doc: 'Order Received From Direct Access Customer Dea'
    0x36:
      id: 'foreign_dealer_equivalent'
      doc: 'Order Received From Foreign Dealer Equivalent Fde'
    0x37:
      id: 'executiononly_service'
      doc: 'Order Received From An Executiononly Service Oeo'
  routing_arrangement_indicator:
    0x30:
      id: 'no_routing_arrangement_in_place'
      doc: 'No Routing Arrangement In Place'
    0x31:
      id: 'routing_arrangement_in_place'
      doc: 'Routing Arrangement In Place'
  basket_trade:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  program_trade:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  gef_eligible:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  anonymous:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  bypass:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  tsxncib:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  no_trade_feat:
    0x4e:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    0x4f:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
    0x44:
      id: 'decrement_and_cancel'
      doc: 'Decrement And Cancel'
    0x45:
      id: 'execute_trade'
      doc: 'Execute Trade'
  short_marking_exempt:
    0x30:
      id: 'sme'
      doc: 'Sme'
  conditional_order:
    0x43:
      id: 'conditional_order'
      doc: 'Conditional Order Cxd Only'
    0x58:
      id: 'extended_firmup_time_conditional_order'
      doc: 'E Xtended Firmup Time Xft Conditional Order Cxd Only'
  allow_conditional:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  cxd_connect:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  pure_stream_connect:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  handl_inst:
    0x66:
      id: 'dao'
      doc: 'Dao'
    0x31:
      id: 'opr_reprice'
      doc: 'Opr Reprice'
    0x35:
      id: 'opr_cancel'
      doc: 'Opr Cancel'
  replace_order_request_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Replace Order Request Optional UserRefIdx Enum'
    3:
      id: 'minqtytype'
      doc: 'Replace Order Request Optional MinQtyType Enum'
    2:
      id: 'pegtype'
      doc: 'Replace Order Request Optional PegType Enum'
    4:
      id: 'minqty'
      doc: 'Replace Order Request Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Replace Order Request Optional MaxFloor Enum'
    6:
      id: 'expiretime'
      doc: 'Replace Order Request Optional ExpireTime Enum'
    7:
      id: 'pegoffset'
      doc: 'Replace Order Request Optional PegOffset Enum'
    8:
      id: 'targetstrategy'
      doc: 'Replace Order Request Optional TargetStrategy Enum'
    9:
      id: 'orderorigination'
      doc: 'Replace Order Request Optional OrderOrigination Enum'
    10:
      id: 'routingarrangementindicator'
      doc: 'Replace Order Request Optional RoutingArrangementIndicator Enum'
    17:
      id: 'umirregulationid'
      doc: 'Replace Order Request Optional UMIRRegulationID Enum'
    16:
      id: 'anonymous'
      doc: 'Replace Order Request Optional Anonymous Enum'
    24:
      id: 'displayrange'
      doc: 'Replace Order Request Optional DisplayRange Enum'
    25:
      id: 'customeraccount'
      doc: 'Replace Order Request Optional CustomerAccount Enum'
    26:
      id: 'algorithmid'
      doc: 'Replace Order Request Optional AlgorithmID Enum'
    27:
      id: 'customerlei'
      doc: 'Replace Order Request Optional CustomerLEI Enum'
    28:
      id: 'brokerlei'
      doc: 'Replace Order Request Optional BrokerLEI Enum'
    30:
      id: 'allowconditional'
      doc: 'Replace Order Request Optional AllowConditional Enum'
    32:
      id: 'cxdconnect'
      doc: 'Replace Order Request Optional CXDConnect Enum'
    33:
      id: 'purestreamconnect'
      doc: 'Replace Order Request Optional PureStreamConnect Enum'
    34:
      id: 'minrate'
      doc: 'Replace Order Request Optional MinRate Enum'
    35:
      id: 'maxrate'
      doc: 'Replace Order Request Optional MaxRate Enum'
    43:
      id: 'handlinst'
      doc: 'Replace Order Request Optional HandlInst Enum'
  cancel_order_request_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Cancel Order Request Optional UserRefIdx Enum'
  account_query_request_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Account Query Request Optional UserRefIdx Enum'
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
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire Nasdaq Canada system.'
    0x41:
      id: 'order_accepted_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Enter Order Message. The data fields from the Enter Order Message are echoed back in this message. When the Order State is Order Dead (D) the order was accepted and automatically canceled and no additional messages will be received for it.'
    0x55:
      id: 'order_replaced_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Replace Order Message. The data fields from the Replace Order Message are echoed back in this message. The OrderQty indicates how many shares were left exposed when the replacement completed.'
    0x43:
      id: 'order_canceled_message'
      doc: 'A Canceled Message informs you that an order has been reduced or canceled. This could be acknowledging a Cancel Order Message, or it could be the result of the order timing out or being canceled automatically.'
    0x44:
      id: 'stp_canceled_message'
      doc: 'STP Canceled Message'
    0x45:
      id: 'order_executed_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed.'
    0x42:
      id: 'corrected_trade_message'
      doc: 'A Corrected Trade Message informs you that an execution has been corrected. The corrected trade details are provided in the message. You will always get an Executed Order Message prior to getting a Corrected Trade Message for a given execution. If no Optional Appendage fields are present, the Appendage Length will be set to 0.'
    0x4a:
      id: 'rejected_order_message'
      doc: 'Rejected Order Message'
    0x49:
      id: 'cancel_reject_message'
      doc: 'Cancel Reject Message'
    0x52:
      id: 'order_restated_message'
      doc: 'The Order Restated Message is sent to indicate that the system has modified an order as part of its order management.'
    0x51:
      id: 'account_query_response_message'
      doc: 'The Account Query Response message is sent in response to an Account Query Request to indicate the next available UserRefNum that can be used to identify new transactions. It only carries the Appendage Length and Optional Appendage fields if the Appendage Length was specified on the inbound message.'
  event_code:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day Indicating That The Exchange Is Open And Is Ready To Accept Orders'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day Indicating That The Exchange Is Closed And Will No Longer Accept New Orders Note That It Is Still Possible To Receive Breaks And Cancels After This Event'
  order_state:
    0x4c:
      id: 'order_live'
      doc: 'Order Live'
    0x44:
      id: 'order_dead'
      doc: 'Order Dead'
  order_accepted_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Order Accepted Optional UserRefIdx Enum'
    1:
      id: 'account'
      doc: 'Order Accepted Optional Account Enum'
    2:
      id: 'pegtype'
      doc: 'Order Accepted Optional PegType Enum'
    3:
      id: 'minqtytype'
      doc: 'Order Accepted Optional MinQtyType Enum'
    4:
      id: 'minqty'
      doc: 'Order Accepted Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Order Accepted Optional MaxFloor Enum'
    6:
      id: 'expiretime'
      doc: 'Order Accepted Optional ExpireTime Enum'
    7:
      id: 'pegoffset'
      doc: 'Order Accepted Optional PegOffset Enum'
    8:
      id: 'targetstrategy'
      doc: 'Order Accepted Optional TargetStrategy Enum'
    9:
      id: 'orderorigination'
      doc: 'Order Accepted Optional OrderOrigination Enum'
    10:
      id: 'routingarrangementindicator'
      doc: 'Order Accepted Optional RoutingArrangementIndicator Enum'
    11:
      id: 'baskettrade'
      doc: 'Order Accepted Optional BasketTrade Enum'
    12:
      id: 'programtrade'
      doc: 'Order Accepted Optional ProgramTrade Enum'
    14:
      id: 'jitney'
      doc: 'Order Accepted Optional Jitney Enum'
    15:
      id: 'gefeligible'
      doc: 'Order Accepted Optional GEFEligible Enum'
    16:
      id: 'anonymous'
      doc: 'Order Accepted Optional Anonymous Enum'
    17:
      id: 'umirregulationid'
      doc: 'Order Accepted Optional UMIRRegulationID Enum'
    18:
      id: 'bypass'
      doc: 'Order Accepted Optional Bypass Enum'
    19:
      id: 'tsxncib'
      doc: 'Order Accepted Optional TSXNCIB Enum'
    20:
      id: 'notradefeat'
      doc: 'Order Accepted Optional NoTradeFeat Enum'
    21:
      id: 'notradekey'
      doc: 'Order Accepted Optional NoTradeKey Enum'
    22:
      id: 'shortmarkingexempt'
      doc: 'Order Accepted Optional ShortMarkingExempt Enum'
    23:
      id: 'pocomment'
      doc: 'Order Accepted Optional POComment Enum'
    24:
      id: 'displayrange'
      doc: 'Order Accepted Optional DisplayRange Enum'
    25:
      id: 'customeraccount'
      doc: 'Order Accepted Optional CustomerAccount Enum'
    26:
      id: 'algorithmid'
      doc: 'Order Accepted Optional AlgorithmID Enum'
    27:
      id: 'customerlei'
      doc: 'Order Accepted Optional CustomerLEI Enum'
    28:
      id: 'brokerlei'
      doc: 'Order Accepted Optional BrokerLEI Enum'
    29:
      id: 'conditionalorder'
      doc: 'Order Accepted Optional ConditionalOrder Enum'
    30:
      id: 'allowconditional'
      doc: 'Order Accepted Optional AllowConditional Enum'
    31:
      id: 'firmupid'
      doc: 'Order Accepted Optional FirmUpID Enum'
    32:
      id: 'cxdconnect'
      doc: 'Order Accepted Optional CXDConnect Enum'
    33:
      id: 'purestreamconnect'
      doc: 'Order Accepted Optional PureStreamConnect Enum'
    34:
      id: 'minrate'
      doc: 'Order Accepted Optional MinRate Enum'
    35:
      id: 'maxrate'
      doc: 'Order Accepted Optional MaxRate Enum'
    39:
      id: 'routingstrategy'
      doc: 'Order Accepted Optional RoutingStrategy Enum'
    43:
      id: 'handlinst'
      doc: 'Order Accepted Optional HandlInst Enum'
    44:
      id: 'repricereason'
      doc: 'Order Accepted Optional RepriceReason Enum'
    45:
      id: 'nbbosetter'
      doc: 'Order Accepted Optional NBBOSetter Enum'
  reprice_reason:
    1:
      id: 'repriced_to_prevent_trade'
      doc: 'Repriced To Prevent Trade'
    2:
      id: 'repriced_to_prevent_lock'
      doc: 'Repriced To Prevent Lock'
    3:
      id: 'repriced_to_prevent_cross'
      doc: 'Repriced To Prevent Cross'
    4:
      id: 'repriced_for_marketplace_thresholds'
      doc: 'Repriced For Marketplace Thresholds'
  nbbo_setter:
    0x59:
      id: 'nbbo_setter'
      doc: 'Order Is Nbbo Setter'
  order_replaced_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Order Replaced Optional UserRefIdx Enum'
    3:
      id: 'minqtytype'
      doc: 'Order Replaced Optional MinQtyType Enum'
    2:
      id: 'pegtype'
      doc: 'Order Replaced Optional PegType Enum'
    4:
      id: 'minqty'
      doc: 'Order Replaced Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Order Replaced Optional MaxFloor Enum'
    6:
      id: 'expiretime'
      doc: 'Order Replaced Optional ExpireTime Enum'
    7:
      id: 'pegoffset'
      doc: 'Order Replaced Optional PegOffset Enum'
    8:
      id: 'targetstrategy'
      doc: 'Order Replaced Optional TargetStrategy Enum'
    9:
      id: 'orderorigination'
      doc: 'Order Replaced Optional OrderOrigination Enum'
    10:
      id: 'routingarrangementindicator'
      doc: 'Order Replaced Optional RoutingArrangementIndicator Enum'
    17:
      id: 'umirregulationid'
      doc: 'Order Replaced Optional UMIRRegulationID Enum'
    16:
      id: 'anonymous'
      doc: 'Order Replaced Optional Anonymous Enum'
    24:
      id: 'displayrange'
      doc: 'Order Replaced Optional DisplayRange Enum'
    25:
      id: 'customeraccount'
      doc: 'Order Replaced Optional CustomerAccount Enum'
    26:
      id: 'algorithmid'
      doc: 'Order Replaced Optional AlgorithmID Enum'
    27:
      id: 'customerlei'
      doc: 'Order Replaced Optional CustomerLEI Enum'
    28:
      id: 'brokerlei'
      doc: 'Order Replaced Optional BrokerLEI Enum'
    30:
      id: 'allowconditional'
      doc: 'Order Replaced Optional AllowConditional Enum'
    32:
      id: 'cxdconnect'
      doc: 'Order Replaced Optional CXDConnect Enum'
    33:
      id: 'purestreamconnect'
      doc: 'Order Replaced Optional PureStreamConnect Enum'
    34:
      id: 'minrate'
      doc: 'Order Replaced Optional MinRate Enum'
    35:
      id: 'maxrate'
      doc: 'Order Replaced Optional MaxRate Enum'
    43:
      id: 'handlinst'
      doc: 'Order Replaced Optional HandlInst Enum'
    44:
      id: 'repricereason'
      doc: 'Order Replaced Optional RepriceReason Enum'
    45:
      id: 'nbbosetter'
      doc: 'Order Replaced Optional NBBOSetter Enum'
  order_canceled_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Order Canceled Optional UserRefIdx Enum'
  liquidity_flag:
    0x41:
      id: 'order_added_liquidity'
      doc: 'Order Added Liquidity'
    0x52:
      id: 'order_removed_liquidity'
      doc: 'Order Removed Liquidity'
    0x61:
      id: 'order_added_hidden_liquidity'
      doc: 'Order Added Hidden Liquidity'
    0x72:
      id: 'order_removed_hidden_liquidity'
      doc: 'Order Removed Hidden Liquidity'
    0x64:
      id: 'order_added_hidden_liquidity_atthetouch'
      doc: 'Order Added Hidden Liquidity Atthetouch'
    0x44:
      id: 'order_removed_hidden_liquidity_atthetouch'
      doc: 'Order Removed Hidden Liquidity Atthetouch'
    0x67:
      id: 'order_added_gef_liquidity'
      doc: 'Order Added Gef Liquidity'
    0x47:
      id: 'order_removed_gef_liquidity'
      doc: 'Order Removed Gef Liquidity'
    0x43:
      id: 'market_on_close'
      doc: 'Market On Close'
    0x53:
      id: 'displayed_liquidityadding_order_improves_the_nbbo'
      doc: 'Displayed Liquidityadding Order Improves The Nbbo'
    0x4f:
      id: 'opening_closing_auction'
      doc: 'Opening Closing Auction'
    0x45:
      id: 'last_sale_trading_session'
      doc: 'Last Sale Trading Session Tsxtsxv'
    0x4c:
      id: 'melo'
      doc: 'Melo'
    0x50:
      id: 'cxd_pure_stream_ratebased_execution'
      doc: 'Cxd Pure Stream Ratebased Execution'
    0x4d:
      id: 'cxd_pure_stream_ls_midpoint_block_removed_liquidity'
      doc: 'Cxd Pure Stream Ls Midpoint Block Removed Liquidity'
    0x46:
      id: 'xft'
      doc: 'Xft'
  stp_canceled_optional_field:
    37:
      id: 'userrefidx'
      doc: 'STP Canceled Optional UserRefIdx Enum'
  exec_broker:
    0x20:
      id: 'unspecified'
      doc: 'Unspecified'
    0x41:
      id: 'chix'
      doc: 'Chix'
    0x42:
      id: 'cx_2'
      doc: 'Cx 2'
    0x43:
      id: 'cxd'
      doc: 'Cxd'
    0x44:
      id: 'tsx'
      doc: 'Tsx'
    0x45:
      id: 'pure'
      doc: 'Pure'
    0x46:
      id: 'alph'
      doc: 'Alph'
    0x47:
      id: 'match_field'
      doc: 'Match'
    0x48:
      id: 'omga'
      doc: 'Omga'
    0x49:
      id: 'lynx'
      doc: 'Lynx'
    0x4a:
      id: 'aeqn'
      doc: 'Aeqn'
    0x4b:
      id: 'aeql'
      doc: 'Aeql'
    0x4c:
      id: 'cse_2'
      doc: 'Cse 2'
    0x4d:
      id: 'alpx'
      doc: 'Alpx'
    0x4e:
      id: 'alpd'
      doc: 'Alpd'
    0x4f:
      id: 'icx'
      doc: 'Icx'
  order_executed_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Order Executed Optional UserRefIdx Enum'
    38:
      id: 'executematch'
      doc: 'Order Executed Optional ExecuteMatch Enum'
    40:
      id: 'secondaryorderid'
      doc: 'Order Executed Optional SecondaryOrderID Enum'
    42:
      id: 'brokerpref'
      doc: 'Order Executed Optional BrokerPref Enum'
    13:
      id: 'principaltrade'
      doc: 'Order Executed Optional PrincipalTrade Enum'
    41:
      id: 'washtrade'
      doc: 'Order Executed Optional WashTrade Enum'
    36:
      id: 'cumrate'
      doc: 'Order Executed Optional CumRate Enum'
  execute_match:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  broker_pref:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  principal_trade:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  wash_trade:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  corrected_trade_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Corrected Trade Optional UserRefIdx Enum'
  rejected_order_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Rejected Order Optional UserRefIdx Enum'
  cancel_reject_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Cancel Reject Optional UserRefIdx Enum'
  restate_reason:
    0x4f:
      id: 'stream_on'
      doc: 'Stream On'
    0x58:
      id: 'stream_off'
      doc: 'Stream Off'
    0x52:
      id: 'conditional_order_firmup_request'
      doc: 'Conditional Order Firmup Request'
  order_restated_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Order Restated Optional UserRefIdx Enum'
    31:
      id: 'firmupid'
      doc: 'Order Restated Optional FirmUpID Enum'
  account_query_response_optional_field:
    37:
      id: 'userrefidx'
      doc: 'Account Query Response Optional UserRefIdx Enum'

