# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CboeEurope TradeReporting Boe v2.0.40
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: 
#   Encoding: Cboe Binary Order Entry
#   Version: 2.0.40
#   Date: 5/27/2026
#   Specification: Cboe Europe TRF BOE2 Specification.pdf
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
  id: cboe_cboeeurope_tradereporting_boe_v2_0_40
  title: Cboe CboeEurope TradeReporting Boe v2.0.40
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Europe Boe v2.0.40'
doc-ref: https://www.cboe.com/europe/equities/support/technical/

seq:
  - id: message_header
    type: message_header_struct
    doc: '10-byte BOE v2 message header. Every message starts with StartOfMessage = 0xBA 0xBA'
  - id: message
    type:
      switch-on: message_header.message_type
      cases:
        'message_type::login_request_v_2_message': login_request_v_2_message
        'message_type::login_response_v_2_message': login_response_v_2_message
        'message_type::logout_message': logout_message
        'message_type::trade_capture_report_v_2_message': trade_capture_report_v_2_message
        'message_type::quote_v_2_message': quote_v_2_message
        'message_type::quote_cancel_v_2_message': quote_cancel_v_2_message
        'message_type::trade_capture_report_acknowledgment_v_2_message': trade_capture_report_acknowledgment_v_2_message
        'message_type::trade_capture_report_reject_v_2_message': trade_capture_report_reject_v_2_message
        'message_type::trade_capture_confirm_v_2_message': trade_capture_confirm_v_2_message
        'message_type::trade_capture_report_decline_v_2_message': trade_capture_report_decline_v_2_message
        'message_type::quote_status_v_2_message': quote_status_v_2_message
        'message_type::quote_reject_v_2_message': quote_reject_v_2_message

types:
  message_header_struct:
    seq:
      - id: start_of_message
        type: u2
        doc: 'BA BA (47802). Two initial bytes present to aid in message reassembly for network capture purposes'
      - id: message_length
        type: u2
        doc: 'Number of bytes for the message, including this field but not including the two bytes of the StartOfMessage field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Return message type for which the bitfields are being specified (e.g., 0x30 for a Trade Cap- ture Report Acknowledgment V2 mes- sage)'
      - id: matching_unit
        type: u1
        doc: 'The matching unit which created this message. Only populated on sequenced, non-session level messages sent from Cboe to the Member; 0 for inbound and all session level messages'
      - id: sequence_number
        type: u4
        doc: 'The sequence number for this message. Cboe-to-Member messages sequenced distinctly per matching unit; Member-to-Cboe sequenced across all matching units with a single stream'
  login_request_v_2_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Session Sub ID supplied by Cboe'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        doc: 'Username supplied by Cboe'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Password supplied by Cboe'
      - id: num_param_group
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
      - id: param_group
        type: param_group
        repeat: expr
        repeat-expr: num_param_group
        doc: 'Repeating group stated NumberOfParamGroups times'
  param_group:
    seq:
      - id: param_group_length
        type: u2
        doc: 'Number of bytes for the parameter group, in- cluding this field'
      - id: param_group_type
        type: u1
        doc: '0x80'
  login_response_v_2_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted, or the reason for the rejection. A = Login Accepted N = Not authorized (invalid user- name/password) D = Session is disabled B = Session in use S = Invalid session Q = Sequence ahead in Login message I = Invalid unit given in Login message F = Invalid return bitfield in login message M = Invalid Login Request message structure'
      - id: login_response_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional informa- tion about the reason for rejection. For suc- cessful logins, this is empty. ASCII NUL (0x00) filled on the right, if necessary'
      - id: no_unspecified_unit_replay
        type: u1
        doc: 'Echoed back from the original Login Request V2 message'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Participant to Cboe) message se- quence number processed by Cboe'
      - id: num_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: units
        type: units
        repeat: expr
        repeat-expr: num_units
        doc: 'Repeating group stated NumberOfUnits times'
      - id: num_param_group
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
      - id: param_group
        type: param_group
        repeat: expr
        repeat-expr: num_param_group
        doc: 'Repeating group stated NumberOfParamGroups times'
  units:
    seq:
      - id: unit_number
        type: u1
        doc: 'A unit number'
      - id: unit_sequence
        type: u4
        doc: 'Highest available Cboe to Participant sequence number for the unit'
  logout_message:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'The reason why the Logout message was sent. U = User Requested E = End of Day A = Administrative ! = Protocol Violation'
      - id: logout_reason_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional informa- tion about the reason for logout. Particularly useful if LogoutReason = ! (Protocol Viola- tion)'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Participant to Cboe) message se- quence number processed by Cboe'
      - id: num_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: units
        type: units
        repeat: expr
        repeat-expr: num_units
        doc: 'Repeating group stated NumberOfUnits times'
  trade_capture_report_v_2_message:
    seq:
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. A value of zero or an indicative price may be used if the price is pending, as denoted by PriceFormation. Implied decimal with scale 1e-7'
      - id: number_of_trade_capture_report_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_v_2_bitfield_1
        type: trade_capture_report_v_2_bitfield_1
        if: number_of_trade_capture_report_v_2_bitfields >= 1
        doc: 'BitSet TradeCaptureReportV2 byte 1'
      - id: trade_capture_report_v_2_bitfield_2
        type: trade_capture_report_v_2_bitfield_2
        if: number_of_trade_capture_report_v_2_bitfields >= 2
        doc: 'BitSet TradeCaptureReportV2 byte 2'
      - id: trade_capture_report_v_2_bitfield_3
        type: trade_capture_report_v_2_bitfield_3
        if: number_of_trade_capture_report_v_2_bitfields >= 3
        doc: 'BitSet TradeCaptureReportV2 byte 3'
      - id: trade_capture_report_v_2_bitfield_4
        type: trade_capture_report_v_2_bitfield_4
        if: number_of_trade_capture_report_v_2_bitfields >= 4
        doc: 'BitSet TradeCaptureReportV2 byte 4'
      - id: trade_capture_report_v_2_bitfield_5
        type: trade_capture_report_v_2_bitfield_5
        if: number_of_trade_capture_report_v_2_bitfields >= 5
        doc: 'BitSet TradeCaptureReportV2 byte 5'
      - id: trade_capture_report_v_2_bitfield_6
        type: trade_capture_report_v_2_bitfield_6
        if: number_of_trade_capture_report_v_2_bitfields >= 6
        doc: 'BitSet TradeCaptureReportV2 byte 6'
      - id: num_trd_cap_rpt_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Currently, can be 1 or 2'
      - id: trd_cap_rpt_side_grp
        type: trd_cap_rpt_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_rpt_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_security_exchange > 0
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_last_mkt > 0
      - id: transaction_category
        type: u1
        enum: transaction_category
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_transaction_category > 0
      - id: trade_time
        type: nanosecond_timestamp
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_report_trans_type > 0
      - id: trade_id
        type: u8
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_id > 0
      - id: venue_type
        type: u1
        enum: venue_type
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_venue_type > 0
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trading_session_sub_id > 0
      - id: match_type
        type: u1
        enum: match_type
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_match_type > 0
      - id: trd_sub_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trd_sub_type > 0
      - id: secondary_trd_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_secondary_trd_type > 0
      - id: trade_price_condition
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trade_price_condition > 0
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trade_publish_indicator > 0
      - id: large_size
        type: u8
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_large_size > 0
      - id: execution_method
        type: u1
        enum: execution_method
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_execution_method > 0
      - id: gross_trade_amt
        type: decimal_s8_4
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_gross_trade_amt > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_order_category > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_algorithmic_indicator > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_waiver_type > 0
      - id: deferral_reason
        type: u1
        enum: deferral_reason
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_deferral_reason > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_trade_capture_report_v_2_bitfields >= 6 and trade_capture_report_v_2_bitfield_6.trade_capture_report_v_2_bitfield_6_intra_firm_trade_ind > 0
      - id: tertiary_trd_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 6 and trade_capture_report_v_2_bitfield_6.trade_capture_report_v_2_bitfield_6_tertiary_trd_type > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_account > 0
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
  trade_capture_report_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_1_symbol
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_reserved_2
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_currency
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_id_source
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_security_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_security_exchange
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_last_mkt
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_reserved_128
        type: b1
  trade_capture_report_v_2_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_account
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_transaction_category
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_trade_time
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_party_role
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_trade_report_trans_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_trade_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_venue_type
        type: b1
  trade_capture_report_v_2_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_3_trading_session_sub_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_match_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_trd_sub_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_secondary_trd_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_trade_price_condition
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_trade_publish_indicator
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_large_size
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_execution_method
        type: b1
  trade_capture_report_v_2_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_4_trade_report_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_trade_handling_instruction
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_trade_link_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_trade_report_ref_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_gross_trade_amt
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_tolerance
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_order_category
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_settlement_price
        type: b1
  trade_capture_report_v_2_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_5_settlement_date
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_price_formation
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_algorithmic_indicator
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_waiver_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_deferral_reason
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_settlement_currency
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_settlement_location
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_third_party
        type: b1
  trade_capture_report_v_2_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_6_cust_order_handling_inst
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_open_close
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_account_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_multi_juris_reporting_ind
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_tertiary_trd_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_64
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_128
        type: b1
  trd_cap_rpt_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 8 = Cross'
      - id: capacity
        type: u1
        enum: capacity
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
  quote_v_2_message:
    seq:
      - id: quote_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to QuoteID (117) in Cboe FIX. Mandatory unique ID chosen by client for a Quote or QuoteCancel. 18 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. Please note that the last two bytes are for inter- nal use. Note: Cboe only enforces the uniqueness of QuoteID values among currently live quotes. However, we strongly recommend that you keep your QuoteID values day unique'
      - id: number_of_quote_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: quote_v_2_bitfield_1
        type: quote_v_2_bitfield_1
        if: number_of_quote_v_2_bitfields >= 1
        doc: 'BitSet QuoteV2 byte 1'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_quote_v_2_bitfields >= 1 and quote_v_2_bitfield_1.quote_v_2_bitfield_1_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_quote_v_2_bitfields >= 1 and quote_v_2_bitfield_1.quote_v_2_bitfield_1_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_quote_v_2_bitfields >= 1 and quote_v_2_bitfield_1.quote_v_2_bitfield_1_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_quote_v_2_bitfields >= 1 and quote_v_2_bitfield_1.quote_v_2_bitfield_1_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_quote_v_2_bitfields >= 1 and quote_v_2_bitfield_1.quote_v_2_bitfield_1_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_quote_v_2_bitfields >= 1 and quote_v_2_bitfield_1.quote_v_2_bitfield_1_clearing_firm > 0
  quote_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: quote_v_2_bitfield_1_symbol
        type: b1
      - id: quote_v_2_bitfield_1_currency
        type: b1
      - id: quote_v_2_bitfield_1_id_source
        type: b1
      - id: quote_v_2_bitfield_1_security_id
        type: b1
      - id: quote_v_2_bitfield_1_security_exchange
        type: b1
      - id: quote_v_2_bitfield_1_bid
        type: b1
      - id: quote_v_2_bitfield_1_offer
        type: b1
      - id: quote_v_2_bitfield_1_clearing_firm
        type: b1
  quote_cancel_v_2_message:
    seq:
      - id: quote_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to QuoteID (117) in Cboe FIX. Mandatory unique ID chosen by client for a Quote or QuoteCancel. 18 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. Please note that the last two bytes are for inter- nal use. Note: Cboe only enforces the uniqueness of QuoteID values among currently live quotes. However, we strongly recommend that you keep your QuoteID values day unique'
      - id: number_of_quote_cancel_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: quote_cancel_v_2_bitfield_1
        type: quote_cancel_v_2_bitfield_1
        if: number_of_quote_cancel_v_2_bitfields >= 1
        doc: 'BitSet QuoteCancelV2 byte 1'
      - id: num_quote_cancel_rpt_grp
        type: u1
        doc: 'Mandatory. Corresponds to NoQuoteEntries- Text (295) in Cboe FIX. Indicates the number of repeating groups to fol- low. Currently, can be 0 or 1. 0 - Cancel all symbols 1 - Cancel quote for the specified symbol'
      - id: quote_cancel_rpt_grp
        type: quote_cancel_rpt_grp
        repeat: expr
        repeat-expr: num_quote_cancel_rpt_grp
        doc: 'Repeating group stated NoQuoteEntries times'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_quote_cancel_v_2_bitfields >= 1 and quote_cancel_v_2_bitfield_1.quote_cancel_v_2_bitfield_1_clearing_firm > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_quote_cancel_v_2_bitfields >= 1 and quote_cancel_v_2_bitfield_1.quote_cancel_v_2_bitfield_1_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_quote_cancel_v_2_bitfields >= 1 and quote_cancel_v_2_bitfield_1.quote_cancel_v_2_bitfield_1_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_quote_cancel_v_2_bitfields >= 1 and quote_cancel_v_2_bitfield_1.quote_cancel_v_2_bitfield_1_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_quote_cancel_v_2_bitfields >= 1 and quote_cancel_v_2_bitfield_1.quote_cancel_v_2_bitfield_1_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_quote_cancel_v_2_bitfields >= 1 and quote_cancel_v_2_bitfield_1.quote_cancel_v_2_bitfield_1_security_exchange > 0
  quote_cancel_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: quote_cancel_v_2_bitfield_1_symbol
        type: b1
      - id: quote_cancel_v_2_bitfield_1_currency
        type: b1
      - id: quote_cancel_v_2_bitfield_1_id_source
        type: b1
      - id: quote_cancel_v_2_bitfield_1_security_id
        type: b1
      - id: quote_cancel_v_2_bitfield_1_security_exchange
        type: b1
      - id: quote_cancel_v_2_bitfield_1_clearing_firm
        type: b1
      - id: quote_cancel_v_2_bitfield_1_reserved_64
        type: b1
      - id: quote_cancel_v_2_bitfield_1_reserved_128
        type: b1
  quote_cancel_rpt_grp:
    seq:
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
      - id: currency
        type: str
        size: 3
        encoding: ASCII
      - id: id_source
        type: u1
        enum: id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
  trade_capture_report_acknowledgment_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 1'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 2'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 3'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 4'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 5'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 6'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 7'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 8'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 9'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 10'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 11'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 12'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 13'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 14'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 15'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 16'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 17'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 18'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 19'
      - id: num_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Currently, can be 1 or 2'
      - id: trd_cap_ack_side_grp
        type: trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_order_qty > 0
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_acknowledgment_v_2_return_bitfield_7.trade_capture_report_acknowledgment_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_report_acknowledgment_v_2_return_bitfield_7.trade_capture_report_acknowledgment_v_2_return_bitfield_7_last_mkt > 0
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_capture_report_acknowledgment_v_2_return_bitfield_8.trade_capture_report_acknowledgment_v_2_return_bitfield_8_trade_report_ref_id > 0
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_return_bitfields >= 9 and trade_capture_report_acknowledgment_v_2_return_bitfield_9.trade_capture_report_acknowledgment_v_2_return_bitfield_9_order_category > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and trade_capture_report_acknowledgment_v_2_return_bitfield_10.trade_capture_report_acknowledgment_v_2_return_bitfield_10_waiver_type > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_report_acknowledgment_v_2_return_bitfield_10.trade_capture_report_acknowledgment_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_acknowledgment_v_2_return_bitfield_11.trade_capture_report_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: deferral_reason
        type: u1
        enum: deferral_reason
        if: number_of_return_bitfields >= 11 and trade_capture_report_acknowledgment_v_2_return_bitfield_11.trade_capture_report_acknowledgment_v_2_return_bitfield_11_deferral_reason > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_report_acknowledgment_v_2_return_bitfield_19.trade_capture_report_acknowledgment_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_report_acknowledgment_v_2_return_bitfield_1.trade_capture_report_acknowledgment_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 8 = Cross'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_account > 0
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_report_acknowledgment_v_2_return_bitfield_4.trade_capture_report_acknowledgment_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and trade_capture_report_acknowledgment_v_2_return_bitfield_6.trade_capture_report_acknowledgment_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
  trade_capture_report_acknowledgment_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_128
        type: b1
  trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 8 = Cross'
      - id: capacity
        type: u1
        enum: capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
  trade_capture_report_reject_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for a Trade Capture Report reject or decline. See Reason Codes (§ 8, p. 73) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_reject_v_2_return_bitfield_1
        type: trade_capture_report_reject_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureReportRejectV2 byte 1'
      - id: trade_capture_report_reject_v_2_return_bitfield_2
        type: trade_capture_report_reject_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureReportRejectV2 byte 2'
      - id: trade_capture_report_reject_v_2_return_bitfield_3
        type: trade_capture_report_reject_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureReportRejectV2 byte 3'
      - id: trade_capture_report_reject_v_2_return_bitfield_4
        type: trade_capture_report_reject_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureReportRejectV2 byte 4'
      - id: trade_capture_report_reject_v_2_return_bitfield_5
        type: trade_capture_report_reject_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureReportRejectV2 byte 5'
      - id: trade_capture_report_reject_v_2_return_bitfield_6
        type: trade_capture_report_reject_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureReportRejectV2 byte 6'
      - id: trade_capture_report_reject_v_2_return_bitfield_7
        type: trade_capture_report_reject_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureReportRejectV2 byte 7'
      - id: trade_capture_report_reject_v_2_return_bitfield_8
        type: trade_capture_report_reject_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureReportRejectV2 byte 8'
      - id: trade_capture_report_reject_v_2_return_bitfield_9
        type: trade_capture_report_reject_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureReportRejectV2 byte 9'
      - id: trade_capture_report_reject_v_2_return_bitfield_10
        type: trade_capture_report_reject_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureReportRejectV2 byte 10'
      - id: trade_capture_report_reject_v_2_return_bitfield_11
        type: trade_capture_report_reject_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureReportRejectV2 byte 11'
      - id: trade_capture_report_reject_v_2_return_bitfield_12
        type: trade_capture_report_reject_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureReportRejectV2 byte 12'
      - id: trade_capture_report_reject_v_2_return_bitfield_13
        type: trade_capture_report_reject_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureReportRejectV2 byte 13'
      - id: trade_capture_report_reject_v_2_return_bitfield_14
        type: trade_capture_report_reject_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureReportRejectV2 byte 14'
      - id: trade_capture_report_reject_v_2_return_bitfield_15
        type: trade_capture_report_reject_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureReportRejectV2 byte 15'
      - id: trade_capture_report_reject_v_2_return_bitfield_16
        type: trade_capture_report_reject_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureReportRejectV2 byte 16'
      - id: trade_capture_report_reject_v_2_return_bitfield_17
        type: trade_capture_report_reject_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureReportRejectV2 byte 17'
      - id: trade_capture_report_reject_v_2_return_bitfield_18
        type: trade_capture_report_reject_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureReportRejectV2 byte 18'
      - id: trade_capture_report_reject_v_2_return_bitfield_19
        type: trade_capture_report_reject_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureReportRejectV2 byte 19'
      - id: num_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Currently, can be 1 or 2'
      - id: trd_cap_ack_side_grp
        type: trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_order_qty > 0
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_reject_v_2_return_bitfield_7.trade_capture_report_reject_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_report_reject_v_2_return_bitfield_7.trade_capture_report_reject_v_2_return_bitfield_7_last_mkt > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and trade_capture_report_reject_v_2_return_bitfield_10.trade_capture_report_reject_v_2_return_bitfield_10_waiver_type > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_report_reject_v_2_return_bitfield_10.trade_capture_report_reject_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_reject_v_2_return_bitfield_11.trade_capture_report_reject_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: deferral_reason
        type: u1
        enum: deferral_reason
        if: number_of_return_bitfields >= 11 and trade_capture_report_reject_v_2_return_bitfield_11.trade_capture_report_reject_v_2_return_bitfield_11_deferral_reason > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_report_reject_v_2_return_bitfield_19.trade_capture_report_reject_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_report_reject_v_2_return_bitfield_1.trade_capture_report_reject_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 8 = Cross'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_account > 0
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_report_reject_v_2_return_bitfield_4.trade_capture_report_reject_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and trade_capture_report_reject_v_2_return_bitfield_6.trade_capture_report_reject_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
  trade_capture_report_reject_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_128
        type: b1
  trade_capture_confirm_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
      - id: trade_id
        type: u8
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. A value of zero or an indicative price may be used if the price is pending, as denoted by PriceFormation. Implied decimal with scale 1e-7'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. Indicates the market of execution. 1'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_confirm_v_2_return_bitfield_1
        type: trade_capture_confirm_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureConfirmV2 byte 1'
      - id: trade_capture_confirm_v_2_return_bitfield_2
        type: trade_capture_confirm_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureConfirmV2 byte 2'
      - id: trade_capture_confirm_v_2_return_bitfield_3
        type: trade_capture_confirm_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureConfirmV2 byte 3'
      - id: trade_capture_confirm_v_2_return_bitfield_4
        type: trade_capture_confirm_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureConfirmV2 byte 4'
      - id: trade_capture_confirm_v_2_return_bitfield_5
        type: trade_capture_confirm_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureConfirmV2 byte 5'
      - id: trade_capture_confirm_v_2_return_bitfield_6
        type: trade_capture_confirm_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureConfirmV2 byte 6'
      - id: trade_capture_confirm_v_2_return_bitfield_7
        type: trade_capture_confirm_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureConfirmV2 byte 7'
      - id: trade_capture_confirm_v_2_return_bitfield_8
        type: trade_capture_confirm_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureConfirmV2 byte 8'
      - id: trade_capture_confirm_v_2_return_bitfield_9
        type: trade_capture_confirm_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureConfirmV2 byte 9'
      - id: trade_capture_confirm_v_2_return_bitfield_10
        type: trade_capture_confirm_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureConfirmV2 byte 10'
      - id: trade_capture_confirm_v_2_return_bitfield_11
        type: trade_capture_confirm_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureConfirmV2 byte 11'
      - id: trade_capture_confirm_v_2_return_bitfield_12
        type: trade_capture_confirm_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureConfirmV2 byte 12'
      - id: trade_capture_confirm_v_2_return_bitfield_13
        type: trade_capture_confirm_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureConfirmV2 byte 13'
      - id: trade_capture_confirm_v_2_return_bitfield_14
        type: trade_capture_confirm_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureConfirmV2 byte 14'
      - id: trade_capture_confirm_v_2_return_bitfield_15
        type: trade_capture_confirm_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureConfirmV2 byte 15'
      - id: trade_capture_confirm_v_2_return_bitfield_16
        type: trade_capture_confirm_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureConfirmV2 byte 16'
      - id: trade_capture_confirm_v_2_return_bitfield_17
        type: trade_capture_confirm_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureConfirmV2 byte 17'
      - id: trade_capture_confirm_v_2_return_bitfield_18
        type: trade_capture_confirm_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureConfirmV2 byte 18'
      - id: trade_capture_confirm_v_2_return_bitfield_19
        type: trade_capture_confirm_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureConfirmV2 byte 19'
      - id: num_trade_capture_confirm_v_2_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Currently, can be 1 or 2'
      - id: trade_capture_confirm_v_2_trd_cap_ack_side_grp
        type: trade_capture_confirm_v_2_trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trade_capture_confirm_v_2_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_order_qty > 0
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: text
        type: str
        size: 60
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_text > 0
        doc: 'Human readable text with more information about the reject reason'
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_last_mkt > 0
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_return_bitfields >= 9 and trade_capture_confirm_v_2_return_bitfield_9.trade_capture_confirm_v_2_return_bitfield_9_order_category > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and trade_capture_confirm_v_2_return_bitfield_10.trade_capture_confirm_v_2_return_bitfield_10_waiver_type > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_confirm_v_2_return_bitfield_10.trade_capture_confirm_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_confirm_v_2_return_bitfield_11.trade_capture_confirm_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: deferral_reason
        type: u1
        enum: deferral_reason
        if: number_of_return_bitfields >= 11 and trade_capture_confirm_v_2_return_bitfield_11.trade_capture_confirm_v_2_return_bitfield_11_deferral_reason > 0
      - id: trade_publish_ind
        type: u1
        enum: trade_publish_ind
        if: number_of_return_bitfields >= 15 and trade_capture_confirm_v_2_return_bitfield_15.trade_capture_confirm_v_2_return_bitfield_15_trade_publish_ind > 0
      - id: report_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 15 and trade_capture_confirm_v_2_return_bitfield_15.trade_capture_confirm_v_2_return_bitfield_15_report_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_confirm_v_2_return_bitfield_19.trade_capture_confirm_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_confirm_v_2_return_bitfield_1.trade_capture_confirm_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 8 = Cross'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_account > 0
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_confirm_v_2_return_bitfield_4.trade_capture_confirm_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and trade_capture_confirm_v_2_return_bitfield_6.trade_capture_confirm_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_capture_confirm_v_2_return_bitfield_8.trade_capture_confirm_v_2_return_bitfield_8_fee_code > 0
        doc: 'Indicates fee associated with an execution. Fee codes are published in the pricing schedule. New fee codes may be sent with little to no notice. Participants are encouraged to code their sys- tems to accept unknown fee codes'
  trade_capture_confirm_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_confirm_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_confirm_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_confirm_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_confirm_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_confirm_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_confirm_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_confirm_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_confirm_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_confirm_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_confirm_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_confirm_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_confirm_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_confirm_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_confirm_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_confirm_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_confirm_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_confirm_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_confirm_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_128
        type: b1
  trade_capture_confirm_v_2_trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 8 = Cross'
      - id: capacity
        type: u1
        enum: capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: central_counterparty
        type: str
        size: 1
        encoding: ASCII
        doc: 'The CCP handling the trade Counterparty N = None'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Indicates fee associated with an execution. Fee codes are published in the pricing schedule. New fee codes may be sent with little to no notice. Participants are encouraged to code their sys- tems to accept unknown fee codes'
  trade_capture_report_decline_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
      - id: trade_id
        type: u8
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. A value of zero or an indicative price may be used if the price is pending, as denoted by PriceFormation. Implied decimal with scale 1e-7'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. Indicates the market of execution. 1'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for a Trade Capture Report reject or decline. See Reason Codes (§ 8, p. 73) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_decline_v_2_return_bitfield_1
        type: trade_capture_report_decline_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 1'
      - id: trade_capture_report_decline_v_2_return_bitfield_2
        type: trade_capture_report_decline_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 2'
      - id: trade_capture_report_decline_v_2_return_bitfield_3
        type: trade_capture_report_decline_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 3'
      - id: trade_capture_report_decline_v_2_return_bitfield_4
        type: trade_capture_report_decline_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 4'
      - id: trade_capture_report_decline_v_2_return_bitfield_5
        type: trade_capture_report_decline_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 5'
      - id: trade_capture_report_decline_v_2_return_bitfield_6
        type: trade_capture_report_decline_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 6'
      - id: trade_capture_report_decline_v_2_return_bitfield_7
        type: trade_capture_report_decline_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 7'
      - id: trade_capture_report_decline_v_2_return_bitfield_8
        type: trade_capture_report_decline_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 8'
      - id: trade_capture_report_decline_v_2_return_bitfield_9
        type: trade_capture_report_decline_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 9'
      - id: trade_capture_report_decline_v_2_return_bitfield_10
        type: trade_capture_report_decline_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 10'
      - id: trade_capture_report_decline_v_2_return_bitfield_11
        type: trade_capture_report_decline_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 11'
      - id: trade_capture_report_decline_v_2_return_bitfield_12
        type: trade_capture_report_decline_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 12'
      - id: trade_capture_report_decline_v_2_return_bitfield_13
        type: trade_capture_report_decline_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 13'
      - id: trade_capture_report_decline_v_2_return_bitfield_14
        type: trade_capture_report_decline_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 14'
      - id: trade_capture_report_decline_v_2_return_bitfield_15
        type: trade_capture_report_decline_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 15'
      - id: trade_capture_report_decline_v_2_return_bitfield_16
        type: trade_capture_report_decline_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 16'
      - id: trade_capture_report_decline_v_2_return_bitfield_17
        type: trade_capture_report_decline_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 17'
      - id: trade_capture_report_decline_v_2_return_bitfield_18
        type: trade_capture_report_decline_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 18'
      - id: trade_capture_report_decline_v_2_return_bitfield_19
        type: trade_capture_report_decline_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 19'
      - id: num_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Currently, can be 1 or 2'
      - id: trd_cap_ack_side_grp
        type: trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_order_qty > 0
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_decline_v_2_return_bitfield_7.trade_capture_report_decline_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_report_decline_v_2_return_bitfield_7.trade_capture_report_decline_v_2_return_bitfield_7_last_mkt > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and trade_capture_report_decline_v_2_return_bitfield_10.trade_capture_report_decline_v_2_return_bitfield_10_waiver_type > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_report_decline_v_2_return_bitfield_10.trade_capture_report_decline_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_decline_v_2_return_bitfield_11.trade_capture_report_decline_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: deferral_reason
        type: u1
        enum: deferral_reason
        if: number_of_return_bitfields >= 11 and trade_capture_report_decline_v_2_return_bitfield_11.trade_capture_report_decline_v_2_return_bitfield_11_deferral_reason > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_report_decline_v_2_return_bitfield_19.trade_capture_report_decline_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_report_decline_v_2_return_bitfield_1.trade_capture_report_decline_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 8 = Cross'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_account > 0
        doc: 'Corresponds to Account (1) in Cboe FIX. Contains the Account specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. Allowed charac- ters are alphanumeric and colon'
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_report_decline_v_2_return_bitfield_4.trade_capture_report_decline_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and trade_capture_report_decline_v_2_return_bitfield_6.trade_capture_report_decline_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 2 = EnteringFirm (the party reporting the trade)'
  trade_capture_report_decline_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_128
        type: b1
  quote_status_v_2_message:
    seq:
      - id: quote_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to QuoteID (117) in Cboe FIX. Mandatory unique ID chosen by client for a Quote or QuoteCancel. 18 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. Please note that the last two bytes are for inter- nal use. Note: Cboe only enforces the uniqueness of QuoteID values among currently live quotes. However, we strongly recommend that you keep your QuoteID values day unique'
      - id: status
        type: u1
        enum: status
        doc: 'Indicates the acceptance or otherwise of a Quote or QuoteCancel message. 0 = Accepted in response to a Quote message 1 = Cancelled in response to a QuoteCancel message'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: quote_status_v_2_return_bitfield_1
        type: quote_status_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet QuoteStatusV2 byte 1'
      - id: quote_status_v_2_return_bitfield_2
        type: quote_status_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet QuoteStatusV2 byte 2'
      - id: quote_status_v_2_return_bitfield_3
        type: quote_status_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet QuoteStatusV2 byte 3'
      - id: quote_status_v_2_return_bitfield_4
        type: quote_status_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet QuoteStatusV2 byte 4'
      - id: quote_status_v_2_return_bitfield_5
        type: quote_status_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet QuoteStatusV2 byte 5'
      - id: quote_status_v_2_return_bitfield_6
        type: quote_status_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet QuoteStatusV2 byte 6'
      - id: quote_status_v_2_return_bitfield_7
        type: quote_status_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet QuoteStatusV2 byte 7'
      - id: quote_status_v_2_return_bitfield_8
        type: quote_status_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet QuoteStatusV2 byte 8'
      - id: quote_status_v_2_return_bitfield_9
        type: quote_status_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet QuoteStatusV2 byte 9'
      - id: quote_status_v_2_return_bitfield_10
        type: quote_status_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet QuoteStatusV2 byte 10'
      - id: quote_status_v_2_return_bitfield_11
        type: quote_status_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet QuoteStatusV2 byte 11'
      - id: quote_status_v_2_return_bitfield_12
        type: quote_status_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet QuoteStatusV2 byte 12'
      - id: quote_status_v_2_return_bitfield_13
        type: quote_status_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet QuoteStatusV2 byte 13'
      - id: quote_status_v_2_return_bitfield_14
        type: quote_status_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet QuoteStatusV2 byte 14'
      - id: quote_status_v_2_return_bitfield_15
        type: quote_status_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet QuoteStatusV2 byte 15'
      - id: quote_status_v_2_return_bitfield_16
        type: quote_status_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet QuoteStatusV2 byte 16'
      - id: quote_status_v_2_return_bitfield_17
        type: quote_status_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet QuoteStatusV2 byte 17'
      - id: quote_status_v_2_return_bitfield_18
        type: quote_status_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet QuoteStatusV2 byte 18'
      - id: quote_status_v_2_return_bitfield_19
        type: quote_status_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet QuoteStatusV2 byte 19'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_status_v_2_return_bitfield_2.quote_status_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_status_v_2_return_bitfield_2.quote_status_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and quote_status_v_2_return_bitfield_2.quote_status_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_status_v_2_return_bitfield_2.quote_status_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_status_v_2_return_bitfield_2.quote_status_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and quote_status_v_2_return_bitfield_2.quote_status_v_2_return_bitfield_2_capacity > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and quote_status_v_2_return_bitfield_3.quote_status_v_2_return_bitfield_3_clearing_firm > 0
      - id: text
        type: str
        size: 60
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and quote_status_v_2_return_bitfield_7.quote_status_v_2_return_bitfield_7_text > 0
        doc: 'Human readable text with more information about the reject reason'
  quote_status_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_1_side
        type: b1
      - id: quote_status_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: quote_status_v_2_return_bitfield_1_price
        type: b1
      - id: quote_status_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: quote_status_v_2_return_bitfield_1_ord_type
        type: b1
      - id: quote_status_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: quote_status_v_2_return_bitfield_1_min_qty
        type: b1
      - id: quote_status_v_2_return_bitfield_1_max_remove_pct
        type: b1
  quote_status_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_2_symbol
        type: b1
      - id: quote_status_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: quote_status_v_2_return_bitfield_2_currency
        type: b1
      - id: quote_status_v_2_return_bitfield_2_id_source
        type: b1
      - id: quote_status_v_2_return_bitfield_2_security_id
        type: b1
      - id: quote_status_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: quote_status_v_2_return_bitfield_2_capacity
        type: b1
      - id: quote_status_v_2_return_bitfield_2_reserved_128
        type: b1
  quote_status_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_3_account
        type: b1
      - id: quote_status_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: quote_status_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: quote_status_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_3_max_floor
        type: b1
      - id: quote_status_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: quote_status_v_2_return_bitfield_3_order_qty
        type: b1
      - id: quote_status_v_2_return_bitfield_3_prevent_match
        type: b1
  quote_status_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: quote_status_v_2_return_bitfield_4_strike_price
        type: b1
      - id: quote_status_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: quote_status_v_2_return_bitfield_4_open_close
        type: b1
      - id: quote_status_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: quote_status_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: quote_status_v_2_return_bitfield_4_party_id
        type: b1
      - id: quote_status_v_2_return_bitfield_4_access_fee
        type: b1
  quote_status_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: quote_status_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: quote_status_v_2_return_bitfield_5_last_shares
        type: b1
      - id: quote_status_v_2_return_bitfield_5_last_price
        type: b1
      - id: quote_status_v_2_return_bitfield_5_display_price
        type: b1
      - id: quote_status_v_2_return_bitfield_5_working_price
        type: b1
      - id: quote_status_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_5_expire_time
        type: b1
  quote_status_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: quote_status_v_2_return_bitfield_6_ccp
        type: b1
      - id: quote_status_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: quote_status_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: quote_status_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: quote_status_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: quote_status_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: quote_status_v_2_return_bitfield_6_party_role
        type: b1
  quote_status_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: quote_status_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: quote_status_v_2_return_bitfield_7_text
        type: b1
      - id: quote_status_v_2_return_bitfield_7_bid
        type: b1
      - id: quote_status_v_2_return_bitfield_7_offer
        type: b1
      - id: quote_status_v_2_return_bitfield_7_large_size
        type: b1
      - id: quote_status_v_2_return_bitfield_7_last_mkt
        type: b1
  quote_status_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_8_fee_code
        type: b1
      - id: quote_status_v_2_return_bitfield_8_echo_text
        type: b1
      - id: quote_status_v_2_return_bitfield_8_stop_px
        type: b1
      - id: quote_status_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: quote_status_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: quote_status_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: quote_status_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: quote_status_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  quote_status_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: quote_status_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: quote_status_v_2_return_bitfield_9_auction_id
        type: b1
      - id: quote_status_v_2_return_bitfield_9_order_category
        type: b1
      - id: quote_status_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: quote_status_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: quote_status_v_2_return_bitfield_9_cross_type
        type: b1
      - id: quote_status_v_2_return_bitfield_9_cross_prioritization
        type: b1
  quote_status_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_10_cross_id
        type: b1
      - id: quote_status_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: quote_status_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: quote_status_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: quote_status_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: quote_status_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_10_price_formation
        type: b1
      - id: quote_status_v_2_return_bitfield_10_client_qualified_role
        type: b1
  quote_status_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_11_client_id
        type: b1
      - id: quote_status_v_2_return_bitfield_11_investor_id
        type: b1
      - id: quote_status_v_2_return_bitfield_11_executor_id
        type: b1
      - id: quote_status_v_2_return_bitfield_11_order_origination
        type: b1
      - id: quote_status_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: quote_status_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: quote_status_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  quote_status_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_12_cti_code
        type: b1
      - id: quote_status_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_12_operator_id
        type: b1
      - id: quote_status_v_2_return_bitfield_12_trade_date
        type: b1
      - id: quote_status_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: quote_status_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: quote_status_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: quote_status_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  quote_status_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: quote_status_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: quote_status_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: quote_status_v_2_return_bitfield_13_avg_px
        type: b1
      - id: quote_status_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: quote_status_v_2_return_bitfield_13_pending_status
        type: b1
      - id: quote_status_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: quote_status_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  quote_status_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: quote_status_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: quote_status_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: quote_status_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: quote_status_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: quote_status_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: quote_status_v_2_return_bitfield_14_username
        type: b1
      - id: quote_status_v_2_return_bitfield_14_user_status
        type: b1
  quote_status_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: quote_status_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: quote_status_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: quote_status_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: quote_status_v_2_return_bitfield_15_report_time
        type: b1
      - id: quote_status_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: quote_status_v_2_return_bitfield_15_client_id_attr
        type: b1
  quote_status_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: quote_status_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: quote_status_v_2_return_bitfield_16_combo_order
        type: b1
      - id: quote_status_v_2_return_bitfield_16_compression
        type: b1
      - id: quote_status_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: quote_status_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: quote_status_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: quote_status_v_2_return_bitfield_16_order_origin
        type: b1
  quote_status_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_17_price_type
        type: b1
      - id: quote_status_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: quote_status_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: quote_status_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: quote_status_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: quote_status_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: quote_status_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: quote_status_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  quote_status_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_18_account_type
        type: b1
      - id: quote_status_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: quote_status_v_2_return_bitfield_18_subreason
        type: b1
      - id: quote_status_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: quote_status_v_2_return_bitfield_18_leg_price
        type: b1
      - id: quote_status_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: quote_status_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: quote_status_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  quote_status_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: quote_status_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: quote_status_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: quote_status_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: quote_status_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: quote_status_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: quote_status_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: quote_status_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: quote_status_v_2_return_bitfield_19_reserved_128
        type: b1
  quote_reject_v_2_message:
    seq:
      - id: quote_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to QuoteID (117) in Cboe FIX. Mandatory unique ID chosen by client for a Quote or QuoteCancel. 18 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. Please note that the last two bytes are for inter- nal use. Note: Cboe only enforces the uniqueness of QuoteID values among currently live quotes. However, we strongly recommend that you keep your QuoteID values day unique'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for a Trade Capture Report reject or decline. See Reason Codes (§ 8, p. 73) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: quote_reject_v_2_return_bitfield_1
        type: quote_reject_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet QuoteRejectV2 byte 1'
      - id: quote_reject_v_2_return_bitfield_2
        type: quote_reject_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet QuoteRejectV2 byte 2'
      - id: quote_reject_v_2_return_bitfield_3
        type: quote_reject_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet QuoteRejectV2 byte 3'
      - id: quote_reject_v_2_return_bitfield_4
        type: quote_reject_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet QuoteRejectV2 byte 4'
      - id: quote_reject_v_2_return_bitfield_5
        type: quote_reject_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet QuoteRejectV2 byte 5'
      - id: quote_reject_v_2_return_bitfield_6
        type: quote_reject_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet QuoteRejectV2 byte 6'
      - id: quote_reject_v_2_return_bitfield_7
        type: quote_reject_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet QuoteRejectV2 byte 7'
      - id: quote_reject_v_2_return_bitfield_8
        type: quote_reject_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet QuoteRejectV2 byte 8'
      - id: quote_reject_v_2_return_bitfield_9
        type: quote_reject_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet QuoteRejectV2 byte 9'
      - id: quote_reject_v_2_return_bitfield_10
        type: quote_reject_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet QuoteRejectV2 byte 10'
      - id: quote_reject_v_2_return_bitfield_11
        type: quote_reject_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet QuoteRejectV2 byte 11'
      - id: quote_reject_v_2_return_bitfield_12
        type: quote_reject_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet QuoteRejectV2 byte 12'
      - id: quote_reject_v_2_return_bitfield_13
        type: quote_reject_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet QuoteRejectV2 byte 13'
      - id: quote_reject_v_2_return_bitfield_14
        type: quote_reject_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet QuoteRejectV2 byte 14'
      - id: quote_reject_v_2_return_bitfield_15
        type: quote_reject_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet QuoteRejectV2 byte 15'
      - id: quote_reject_v_2_return_bitfield_16
        type: quote_reject_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet QuoteRejectV2 byte 16'
      - id: quote_reject_v_2_return_bitfield_17
        type: quote_reject_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet QuoteRejectV2 byte 17'
      - id: quote_reject_v_2_return_bitfield_18
        type: quote_reject_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet QuoteRejectV2 byte 18'
      - id: quote_reject_v_2_return_bitfield_19
        type: quote_reject_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet QuoteRejectV2 byte 19'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_reject_v_2_return_bitfield_2.quote_reject_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_reject_v_2_return_bitfield_2.quote_reject_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and quote_reject_v_2_return_bitfield_2.quote_reject_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_reject_v_2_return_bitfield_2.quote_reject_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and quote_reject_v_2_return_bitfield_2.quote_reject_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and quote_reject_v_2_return_bitfield_2.quote_reject_v_2_return_bitfield_2_capacity > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and quote_reject_v_2_return_bitfield_3.quote_reject_v_2_return_bitfield_3_clearing_firm > 0
  quote_reject_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_1_side
        type: b1
      - id: quote_reject_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: quote_reject_v_2_return_bitfield_1_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: quote_reject_v_2_return_bitfield_1_ord_type
        type: b1
      - id: quote_reject_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: quote_reject_v_2_return_bitfield_1_min_qty
        type: b1
      - id: quote_reject_v_2_return_bitfield_1_max_remove_pct
        type: b1
  quote_reject_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_2_symbol
        type: b1
      - id: quote_reject_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: quote_reject_v_2_return_bitfield_2_currency
        type: b1
      - id: quote_reject_v_2_return_bitfield_2_id_source
        type: b1
      - id: quote_reject_v_2_return_bitfield_2_security_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: quote_reject_v_2_return_bitfield_2_capacity
        type: b1
      - id: quote_reject_v_2_return_bitfield_2_reserved_128
        type: b1
  quote_reject_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_3_account
        type: b1
      - id: quote_reject_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: quote_reject_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: quote_reject_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_3_max_floor
        type: b1
      - id: quote_reject_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: quote_reject_v_2_return_bitfield_3_order_qty
        type: b1
      - id: quote_reject_v_2_return_bitfield_3_prevent_match
        type: b1
  quote_reject_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: quote_reject_v_2_return_bitfield_4_strike_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: quote_reject_v_2_return_bitfield_4_open_close
        type: b1
      - id: quote_reject_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: quote_reject_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: quote_reject_v_2_return_bitfield_4_party_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_4_access_fee
        type: b1
  quote_reject_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: quote_reject_v_2_return_bitfield_5_last_shares
        type: b1
      - id: quote_reject_v_2_return_bitfield_5_last_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_5_display_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_5_working_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_5_expire_time
        type: b1
  quote_reject_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_6_ccp
        type: b1
      - id: quote_reject_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: quote_reject_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: quote_reject_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: quote_reject_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: quote_reject_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: quote_reject_v_2_return_bitfield_6_party_role
        type: b1
  quote_reject_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: quote_reject_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: quote_reject_v_2_return_bitfield_7_text
        type: b1
      - id: quote_reject_v_2_return_bitfield_7_bid
        type: b1
      - id: quote_reject_v_2_return_bitfield_7_offer
        type: b1
      - id: quote_reject_v_2_return_bitfield_7_large_size
        type: b1
      - id: quote_reject_v_2_return_bitfield_7_last_mkt
        type: b1
  quote_reject_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_8_fee_code
        type: b1
      - id: quote_reject_v_2_return_bitfield_8_echo_text
        type: b1
      - id: quote_reject_v_2_return_bitfield_8_stop_px
        type: b1
      - id: quote_reject_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: quote_reject_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: quote_reject_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: quote_reject_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: quote_reject_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  quote_reject_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: quote_reject_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_9_auction_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_9_order_category
        type: b1
      - id: quote_reject_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: quote_reject_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: quote_reject_v_2_return_bitfield_9_cross_type
        type: b1
      - id: quote_reject_v_2_return_bitfield_9_cross_prioritization
        type: b1
  quote_reject_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_10_cross_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: quote_reject_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: quote_reject_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_10_price_formation
        type: b1
      - id: quote_reject_v_2_return_bitfield_10_client_qualified_role
        type: b1
  quote_reject_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_11_client_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_11_investor_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_11_executor_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_11_order_origination
        type: b1
      - id: quote_reject_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: quote_reject_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: quote_reject_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  quote_reject_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_12_cti_code
        type: b1
      - id: quote_reject_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_12_operator_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_12_trade_date
        type: b1
      - id: quote_reject_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: quote_reject_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: quote_reject_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  quote_reject_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: quote_reject_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: quote_reject_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: quote_reject_v_2_return_bitfield_13_avg_px
        type: b1
      - id: quote_reject_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: quote_reject_v_2_return_bitfield_13_pending_status
        type: b1
      - id: quote_reject_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: quote_reject_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  quote_reject_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: quote_reject_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: quote_reject_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_14_username
        type: b1
      - id: quote_reject_v_2_return_bitfield_14_user_status
        type: b1
  quote_reject_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: quote_reject_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: quote_reject_v_2_return_bitfield_15_report_time
        type: b1
      - id: quote_reject_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: quote_reject_v_2_return_bitfield_15_client_id_attr
        type: b1
  quote_reject_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: quote_reject_v_2_return_bitfield_16_combo_order
        type: b1
      - id: quote_reject_v_2_return_bitfield_16_compression
        type: b1
      - id: quote_reject_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: quote_reject_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: quote_reject_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: quote_reject_v_2_return_bitfield_16_order_origin
        type: b1
  quote_reject_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_17_price_type
        type: b1
      - id: quote_reject_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: quote_reject_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: quote_reject_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: quote_reject_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: quote_reject_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  quote_reject_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_18_account_type
        type: b1
      - id: quote_reject_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: quote_reject_v_2_return_bitfield_18_subreason
        type: b1
      - id: quote_reject_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: quote_reject_v_2_return_bitfield_18_leg_price
        type: b1
      - id: quote_reject_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: quote_reject_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: quote_reject_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  quote_reject_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: quote_reject_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: quote_reject_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: quote_reject_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: quote_reject_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: quote_reject_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: quote_reject_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: quote_reject_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: quote_reject_v_2_return_bitfield_19_reserved_128
        type: b1
  decimal_u8_7:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000000.0
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x37:
      id: 'login_request_v_2_message'
      doc: 'Login Request V2 Message.'
    0x02:
      id: 'logout_request_message'
      doc: 'Logout Request Message.'
    0x03:
      id: 'client_heartbeat_message'
      doc: 'Client Heartbeat Message.'
    0x24:
      id: 'login_response_v_2_message'
      doc: 'Login Response V2 Message.'
    0x08:
      id: 'logout_message'
      doc: 'Logout Message.'
    0x09:
      id: 'server_heartbeat_message'
      doc: 'Server Heartbeat Message.'
    0x13:
      id: 'replay_complete_message'
      doc: 'Replay Complete Message.'
    0x3c:
      id: 'trade_capture_report_v_2_message'
      doc: 'Trade Capture Report V2 Message.'
    0x3d:
      id: 'quote_v_2_message'
      doc: 'Quote V2 Message.'
    0x3e:
      id: 'quote_cancel_v_2_message'
      doc: 'Quote Cancel V2 Message.'
    0x30:
      id: 'trade_capture_report_acknowledgment_v_2_message'
      doc: 'Trade Capture Report Acknowledgment V2 Message.'
    0x31:
      id: 'trade_capture_report_reject_v_2_message'
      doc: 'Trade Capture Report Reject V2 Message.'
    0x32:
      id: 'trade_capture_confirm_v_2_message'
      doc: 'Trade Capture Confirm V2 Message.'
    0x33:
      id: 'trade_capture_report_decline_v_2_message'
      doc: 'Trade Capture Report Decline V2 Message.'
    0x3f:
      id: 'quote_status_v_2_message'
      doc: 'Quote Status V2 Message.'
    0x40:
      id: 'quote_reject_v_2_message'
      doc: 'Quote Reject V2 Message.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized'
      doc: 'Not Authorized Invalid User Namepassword'
    0x44:
      id: 'session_is_disabled'
      doc: 'Session Is Disabled'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
    0x51:
      id: 'sequence_ahead_in_login_message'
      doc: 'Sequence Ahead In Login Message'
    0x49:
      id: 'invalid_unit_given_in_login_message'
      doc: 'Invalid Unit Given In Login Message'
    0x46:
      id: 'invalid_return_bitfield_in_login_message'
      doc: 'Invalid Return Bitfield In Login Message'
    0x4d:
      id: 'invalid_login_request_message_structure'
      doc: 'Invalid Login Request Message Structure'
  logout_reason:
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x41:
      id: 'administrative'
      doc: 'Administrative'
    0x21:
      id: 'protocol_violation'
      doc: 'Protocol Violation'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x38:
      id: 'cross'
      doc: 'Cross'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency Maps To Aotc'
    0x50:
      id: 'principal'
      doc: 'Principal Maps To Deal'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal Maps To Mtch'
  id_source:
    0x34:
      id: 'isin'
      doc: 'Isin'
    0x35:
      id: 'ric'
      doc: 'Ric'
  transaction_category:
    0x50:
      id: 'regular_trade'
      doc: 'Regular Trade Aka Plain Vanilla Trade'
    0x4f:
      id: 'portfolio_trade'
      doc: 'Portfolio Trade'
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
    0x52:
      id: 'trade_with_price_improvement'
      doc: 'Trade With Price Improvement Rpri Deprecated For Uk Apa Only Valid For Eu Apa With Trade Time Set To A Date Before 2 March 2026'
    0x59:
      id: 'exchange_for_physical'
      doc: 'Exchange For Physical Xfph Rts 2 Nonequities Only'
    0x5a:
      id: 'package_trade'
      doc: 'Package Trade Tpac Rts 2 Nonequities Only'
  trade_report_trans_type:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'cancel'
      doc: 'Cancel'
    2:
      id: 'replace'
      doc: 'Replace'
    3:
      id: 'release'
      doc: 'Release'
  venue_type:
    0x4f:
      id: 'off_book'
      doc: 'Off Book'
    0x42:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    0x51:
      id: 'quote_driven_market'
      doc: 'Quote Driven Market'
    0x44:
      id: 'dark_order_book'
      doc: 'Dark Order Book'
    0x41:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    0x4e:
      id: 'request_for_quotes'
      doc: 'Request For Quotes'
    0x48:
      id: 'hybrid_market'
      doc: 'Hybrid Market'
    0x7a:
      id: 'other'
      doc: 'Other Excluding Hybrid'
  trading_session_sub_id:
    2:
      id: 'scheduled_opening_auction'
      doc: 'Scheduled Opening Auction'
    4:
      id: 'scheduled_closing_auction'
      doc: 'Scheduled Closing Auction'
    6:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    8:
      id: 'unspecified_auction'
      doc: 'Unspecified Auction'
    9:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
    3:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    5:
      id: 'post_trading'
      doc: 'Post Trading 10 Out Of Main Session Trading'
  match_type:
    1:
      id: 'trade_reporting'
      doc: 'Trade Reporting Off Exchange'
    3:
      id: 'trade_reporting_3'
      doc: 'Trade Reporting On Exchange'
    9:
      id: 'trade_reporting_9'
      doc: 'Trade Reporting Systematic Internalizer'
  trade_publish_indicator:
    0:
      id: 'do_not_publish'
      doc: 'Do Not Publish'
    1:
      id: 'publish_trade'
      doc: 'Publish Trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred Publication'
  execution_method:
    0x41:
      id: 'automated'
      doc: 'Automated'
    0x4d:
      id: 'manual'
      doc: 'Manual'
    0x55:
      id: 'unspecified'
      doc: 'Unspecified Default'
  order_category:
    0:
      id: 'not_a_negotiated_trade'
      doc: 'Not A Negotiated Trade'
    3:
      id: 'privately_negotiated_trade'
      doc: 'Privately Negotiated Trade On Return Fields This Field Indicates Whether Cboe Deems The Trade As Utilising The Negotiated Transaction Waiver Under Mi Fid'
  price_formation:
    0x4a:
      id: 'trade_not_contributing_to_the_price_discovery_process'
      doc: 'Trade Not Contributing To The Price Discovery Process Tncp Invalid For Eu Apa'
    0x4e:
      id: 'price_is_pending'
      doc: 'Price Is Pending Pndg'
  algorithmic_indicator:
    0x4e:
      id: 'no_algorithm_was_involved'
      doc: 'No Algorithm Was Involved Default'
    0x59:
      id: 'algorithm_was_involved'
      doc: 'Algorithm Was Involved Algo'
  waiver_type:
    0x2d:
      id: 'no_waiver_type'
      doc: 'No Waiver Type'
    0x30:
      id: 'negotiated_trade_in_liquid_instrument'
      doc: 'Negotiated Trade In Liquid Instrument For Mtf Only Nliq'
    0x31:
      id: 'negotiated_trade_in_illiquid_instrument'
      doc: 'Negotiated Trade In Illiquid Instrument For Mtf Only Oilq'
    0x32:
      id: 'negotiated_trade_subject_to_conditions_other_than_the'
      doc: 'Negotiated Trade Subject To Conditions Other Than The Current Market Price For Mtf Only Pric'
    0x38:
      id: 'negotiated_trade_subject_to_a_pre_trade_transparency'
      doc: 'Negotiated Trade Subject To A Pre Trade Transparency Waiver For Uk Mtf Only Netw'
    0x63:
      id: 'negotiated_trade_larger_than_lis_brought_onto_a'
      doc: 'Negotiated Trade Larger Than Lis Brought Onto A Venue For Which Pre Trade Transparency Can Be Waived Ntls Implies Netw For Uk Mtf Only'
    0x33:
      id: 'reference_price'
      doc: 'Reference Price Dark Book For Mtf Only Rfpt'
    0x34:
      id: 'pre_trade_transparency_waiver_for_illiquid_instrument'
      doc: 'Pre Trade Transparency Waiver For Illiquid Instrument For Si Only Ilqd Deprecated'
    0x35:
      id: 'pre_trade_transparency_waiver_for_above_standard_mar'
      doc: 'Pre Trade Transparency Waiver For Above Standard Mar Ket Size For Si Only Size Deprecated'
    0x42:
      id: 'pre_trade_transparency_waiver_for_illiquid_instrument_x42'
      doc: 'Pre Trade Transparency Waiver For Illiquid Instrument For Si Only Ilqd And Pre Trade Transparency Waiver For Above Standard Market Size For Si Only Size Deprecated Note The Values 45 Or B Can Only Be Used For Eu Apa With Trade Time Set To A Date Before 2 March 2026 Negotiated Trade Indicators And Pre Trade Transparency Waivers Are Mmt Level 3.2 Values Reference Price Is A Mmt Level 3.5 Value All Values Are Mutually Exclusive And So Only One May Be Requested The Negotiated Trade Indicators Nliq Oilq Pric Netw And Reference Price Waiver Rfpt Are Mtf Only For Mtf Reporting To Uk Apa The New Negotiated Trade Subject To A Pre Trade Transparency Waiver Netw Should Be Used Instead Of Nliq Oliq And Pric The Pre Trade Transparency Waivers Ilqd And Size Are Si Only If Both Ilqd And Size Are Required Then The Discrete Value B Must Be Used The Business Confirmation Contains The Waivers That Have Been Appplied'
  deferral_reason:
    0x2d:
      id: 'no_deferral_reason'
      doc: 'No Deferral Reason'
    0x36:
      id: 'deferral_for_large_in_scale'
      doc: 'Deferral For Large In Scale Lrgs'
    0x37:
      id: 'deferral_for_illiquid_instrument'
      doc: 'Deferral For Illiquid Instrument For Rts 2 Only Ilqd Deprecated'
    0x38:
      id: 'deferral_for_size_specific'
      doc: 'Deferral For Size Specific For Rts 2 Only Size Dep Recated'
    0x43:
      id: 'deferral_for_illiquid_instrument_x43'
      doc: 'Deferral For Illiquid Instrument For Rts 2 Only Ilqd And Deferral For Large In Scale Lrgs Deprecated'
    0x44:
      id: 'deferral_for_illiquid_instrument_x44'
      doc: 'Deferral For Illiquid Instrument For Rts 2 Only Ilqd And Deferral For Size Specific For Rts 2 Only Size Deprecated'
    0x47:
      id: 'deferral_for_transactions_in_et_cs_et_ns_etc'
      doc: 'Deferral For Transactions In Et Cs Et Ns Etc For Rts Only Only Applicable On Eu Apa Deff'
    0x56:
      id: 'indicates_a_net_asset_value'
      doc: 'Indicates A Net Asset Value Nav Trade Cboe Will Publish Such Trades Immediately On Receipt And They Will Not Be Considered As Late Reporting Regardless Of The Arrangement Time On The Message Each Deferral Reason Is Represented By A Distinct Value That Can Be Requested Individually Deferrals That Can Be Applied Together Are Represented By Values That Indicates The Deferrals Being Set Together Based Upon What Is Requested The System Calculates Which Of These Are Valid The Business Confirmation Contains The Deferrals That Have Been Appplied The Values 78 C D Are Deprecated And Are Only Valid On Eu Apa With Trade Time Set To A Date Before 2 March 2026'
  intra_firm_trade_ind:
    0x4e:
      id: 'not_an_intragroup_transaction'
      doc: 'Not An Intragroup Transaction Default'
    0x59:
      id: 'is_an_intragroup_transaction'
      doc: 'Is An Intragroup Transaction'
  reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforseen_reason'
      doc: 'Unforseen Reason'
  trade_publish_ind:
    0:
      id: 'do_not_publish'
      doc: 'Do Not Publish'
    1:
      id: 'publish_trade'
      doc: 'Publish Trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred Publication'
  status:
    0x30:
      id: 'accepted_in_response_to_a_quote_message'
      doc: 'Accepted In Response To A Quote Message'
    0x31:
      id: 'cancelled_in_response_to_a_quote_cancel'
      doc: 'Cancelled In Response To A Quote Cancel Message'

