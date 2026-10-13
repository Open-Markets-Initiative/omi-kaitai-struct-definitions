# ---------------------------------------------------------------------
# Kaitai struct definition for: Iex IexOptions BinaryOrderEntry Sbe v1.03
#
# Protocol:
#   Organization: Investors Exchange
#   Protocol: Binary Order Entry
#   Encoding: Simple Binary Encoding
#   Version: 1.03
#   Date: 9/8/2026
#   Specification: IEX Binary Options Protocol Specification
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
  id: iex_iexoptions_binaryorderentry_sbe_v1_03_server
  title: Iex IexOptions BinaryOrderEntry Sbe v1.03
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Options Binary Order Entry Sbe v1.03'
doc-ref: https://www.iex.io/options/resources

seq:
  - id: server_sbe_message
    type: server_sbe_message_struct
    repeat: eos
    doc: 'Iex Options length-framed Sbe Message sent by Iex Options to the User'

types:
  server_sbe_message_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Number of bytes after this field until the next packet'
      - id: message_header
        type: message_header
        doc: 'Iex Options Sbe message header — message identifiers and length of message root'
      - id: server_payload
        size: packet_length - 10
        type:
          switch-on: message_header.schema_id
          cases:
            'schema_id::session': server_session_message
            'schema_id::business': server_business_message
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Length of the message root before repeating groups or variable-length fields'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        enum: schema_id
        doc: 'Identifier of the schema publishing the message (10000 market data, 20000 session, 20001 order entry business)'
      - id: version
        type: u2
        doc: 'Schema version'
  server_session_message:
    seq:
      - id: server_session_payload
        type:
          switch-on: _parent.message_header.template_id
          cases:
            'template_id::login_response_message': login_response_message
            'template_id::gateway_heartbeat_message': gateway_heartbeat_message
            'template_id::terminate_message': terminate_message
            'template_id::sequenced_message_header_message': sequenced_message_header_message
            'template_id::subsession_join_response_message': subsession_join_response_message
            'template_id::subsession_leave_response_message': subsession_leave_response_message
  login_response_message:
    seq:
      - id: logon_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'logonId'
      - id: status
        type: u1
        enum: status
        doc: 'status'
  gateway_heartbeat_message:
    seq:
      - id: keep_alive
        type: u1
        enum: keep_alive
        doc: 'keepAlive'
      - id: sub_sessions_groups
        type: sub_sessions_groups
        doc: 'SubSessions Block'
  sub_sessions_groups:
    seq:
      - id: session_info_group_encoding
        type: session_info_group_encoding
        doc: 'sessionInfoGroupEncoding'
      - id: sub_sessions_group
        type: sub_sessions_group
        repeat: expr
        repeat-expr: session_info_group_encoding.num_in_group
        doc: 'SubSessions'
  session_info_group_encoding:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  sub_sessions_group:
    seq:
      - id: subsession_type
        type: s1
        enum: subsession_type
        doc: 'subsessionType'
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: joined
        type: u1
        enum: joined
        doc: 'joined'
      - id: next_seq_no
        type: u4
        doc: 'nextSeqNo'
  terminate_message:
    seq:
      - id: reason
        type: u1
        enum: reason
        doc: 'reason'
  sequenced_message_header_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: sequence
        type: u4
        doc: 'sequence'
      - id: timestamp
        type: u8
        doc: 'timestamp'
  subsession_join_response_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: status
        type: u1
        enum: status
        doc: 'status'
  subsession_leave_response_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: reason
        type: u1
        enum: reason
        doc: 'reason'
  server_business_message:
    seq:
      - id: server_business_payload
        type:
          switch-on: _parent.message_header.template_id
          cases:
            'template_id::order_ack_message': order_ack_message
            'template_id::unsolicited_modify_ack_message': unsolicited_modify_ack_message
            'template_id::order_cancel_ack_message': order_cancel_ack_message
            'template_id::mass_cancel_ack_message': mass_cancel_ack_message
            'template_id::bulk_quote_ack_message': bulk_quote_ack_message
            'template_id::new_ioc_quote_ack_message': new_ioc_quote_ack_message
            'template_id::quote_restated_message': quote_restated_message
            'template_id::quote_canceled_message': quote_canceled_message
            'template_id::purge_ack_message': purge_ack_message
            'template_id::execution_report_message': execution_report_message
            'template_id::trade_bust_correct_message': trade_bust_correct_message
            'template_id::application_layer_reject_message': application_layer_reject_message
            'template_id::underlying_ref_data_message': underlying_ref_data_message
            'template_id::instrument_ref_data_message': instrument_ref_data_message
            'template_id::mpid_configuration_acknowledgement_message': mpid_configuration_acknowledgement_message
            'template_id::market_maker_symbol_appointment_message': market_maker_symbol_appointment_message
            'template_id::session_configuration_acknowledgement_message': session_configuration_acknowledgement_message
            'template_id::risk_control_acknowledgment_message': risk_control_acknowledgment_message
            'template_id::risk_control_alert_message': risk_control_alert_message
  order_ack_message:
    seq:
      - id: account_account_optional
        type: str_16_nullable
        doc: 'account. Nullable, No Value = 0'
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: clearing_account_optional
        type: str_4_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: orig_cl_ord_id_optional
        type: u8_nullable
        doc: 'origClOrdId. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: customer_or_firm
        type: s1
        enum: customer_or_firm
        doc: 'customerOrFirm'
      - id: open_close
        type: s1
        enum: open_close
        doc: 'openClose'
      - id: attributed_quote
        type: s1
        enum: attributed_quote
        doc: 'attributedQuote'
      - id: time_in_force
        type: s1
        enum: time_in_force
        doc: 'timeInForce'
      - id: cancel_instead_of_slide
        type: s1
        enum: cancel_instead_of_slide
        doc: 'cancelInsteadOfSlide'
      - id: display_inst
        type: s1_nullable
        doc: 'displayInst. Nullable, No Value = 128'
      - id: exec_inst
        type: s1_nullable
        doc: 'execInst. Nullable, No Value = 128'
      - id: ord_type
        type: s1
        enum: ord_type
        doc: 'ordType'
      - id: target_party_id
        type: str_4_nullable
        doc: 'targetPartyId. Nullable, No Value = 0'
      - id: auction_id
        type: u4_nullable
        doc: 'auctionId. Nullable, No Value = 4294967295'
      - id: clearing_firm
        type: u4_nullable
        doc: 'clearingFirm. Nullable, No Value = 4294967295'
      - id: optional_data
        type: str_16_nullable
        doc: 'optionalData. Nullable, No Value = 0'
      - id: routing_firm_id
        type: str_4_nullable
        doc: 'routingFirmId. Nullable, No Value = 0'
      - id: aiq
        type: str_3_nullable
        doc: 'aiq. Nullable, No Value = 0'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price_price_8_optional
        type: decimal_s8_8_nullable
        doc: 'price. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: order_qty_quantity_non_zero
        type: u4
        doc: 'orderQty'
      - id: leaves_qty
        type: u4
        doc: 'leavesQty'
      - id: effective_limit_price
        type: decimal_s8_8_nullable
        doc: 'effectiveLimitPrice. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: display_price
        type: decimal_s8_8_nullable
        doc: 'displayPrice. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  unsolicited_modify_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: orig_cl_ord_id
        type: u8
        doc: 'origClOrdId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: price_price_8
        type: decimal_s8_8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: order_qty_quantity_non_zero
        type: u4
        doc: 'orderQty'
      - id: leaves_qty
        type: u4
        doc: 'leavesQty'
      - id: effective_limit_price
        type: decimal_s8_8_nullable
        doc: 'effectiveLimitPrice. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: display_price
        type: decimal_s8_8_nullable
        doc: 'displayPrice. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: restatement_reason
        type: s1
        enum: restatement_reason
        doc: 'restatementReason'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
  order_cancel_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id_optional
        type: u8_nullable
        doc: 'clOrdId. Nullable, No Value = 18446744073709551615'
      - id: orig_cl_ord_id
        type: u8
        doc: 'origClOrdId'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderId. Nullable, No Value = 18446744073709551615'
      - id: price_price_8_optional
        type: decimal_s8_8_nullable
        doc: 'price. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: leaves_qty
        type: u4
        doc: 'leavesQty'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  mass_cancel_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_optional
        type: u4_nullable
        doc: 'underlyingId. Nullable, No Value = 4294967295'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: ack_style_mass_cancel_ack_style
        type: u1
        enum: ack_style_mass_cancel_ack_style
        doc: 'ackStyle'
      - id: mpid_filter
        type: u1
        enum: mpid_filter
        doc: 'mpidFilter'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'bulkAction'
      - id: cancel_count
        type: u4
        doc: 'cancelCount'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  bulk_quote_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: custom_group_id_optional
        type: u2_nullable
        doc: 'customGroupId. Nullable, No Value = 65535'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
      - id: aiq
        type: str_3_nullable
        doc: 'aiq. Nullable, No Value = 0'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
      - id: bulk_quote_ack_message_quote_acks_groups
        type: bulk_quote_ack_message_quote_acks_groups
        doc: 'quoteAcks Block'
  bulk_quote_ack_message_quote_acks_groups:
    seq:
      - id: quote_acks_group_encoding
        type: quote_acks_group_encoding
        doc: 'quoteAcksGroupEncoding'
      - id: bulk_quote_ack_message_quote_acks_group
        type: bulk_quote_ack_message_quote_acks_group
        repeat: expr
        repeat-expr: quote_acks_group_encoding.num_in_group
        doc: 'quoteAcks'
  quote_acks_group_encoding:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  bulk_quote_ack_message_quote_acks_group:
    seq:
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderId. Nullable, No Value = 18446744073709551615'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
      - id: price_price_4_optional
        type: decimal_s4_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -2147483648'
      - id: order_qty_quantity_zero_optional
        type: u4_nullable
        doc: 'Order quantity. Nullable, No Value = 4294967295'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
  new_ioc_quote_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
      - id: aiq
        type: str_3_nullable
        doc: 'aiq. Nullable, No Value = 0'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
      - id: price_price_4_optional
        type: decimal_s4_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -2147483648'
      - id: order_qty_quantity_non_zero
        type: u4
        doc: 'orderQty'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  quote_restated_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price_price_4
        type: decimal_s4_4
        doc: 'price. Implied decimal with scale 1e-4'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
      - id: delta
        size: 4
        doc: 'delta. Nullable, No Value = NaN'
  quote_canceled_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
      - id: delta
        size: 4
        doc: 'delta. Nullable, No Value = NaN'
  purge_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_optional
        type: u4_nullable
        doc: 'underlyingId. Nullable, No Value = 4294967295'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: ack_style_purge_request_ack_style
        type: u1
        enum: ack_style_purge_request_ack_style
        doc: 'ackStyle'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'bulkAction'
      - id: cancel_count
        type: u4
        doc: 'cancelCount'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
      - id: purge_ack_message_custom_group_ids_groups
        type: purge_ack_message_custom_group_ids_groups
        doc: 'customGroupIds Block'
  purge_ack_message_custom_group_ids_groups:
    seq:
      - id: custom_group_ids_group_encoding
        type: custom_group_ids_group_encoding
        doc: 'customGroupIdsGroupEncoding'
      - id: purge_ack_message_custom_group_ids_group
        type: purge_ack_message_custom_group_ids_group
        repeat: expr
        repeat-expr: custom_group_ids_group_encoding.num_in_group
        doc: 'customGroupIds'
  custom_group_ids_group_encoding:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  purge_ack_message_custom_group_ids_group:
    seq:
      - id: custom_group_id
        type: u2
        doc: 'Custom group identifier'
  execution_report_message:
    seq:
      - id: account_account_optional
        type: str_16_nullable
        doc: 'account. Nullable, No Value = 0'
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: clearing_account_optional
        type: str_4_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: customer_or_firm
        type: s1
        enum: customer_or_firm
        doc: 'customerOrFirm'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: exec_id
        type: u8
        doc: 'execId'
      - id: trade_id
        type: u8
        doc: 'tradeId'
      - id: last_px
        type: decimal_s8_8
        doc: 'lastPx. Implied decimal with scale 1e-8'
      - id: open_close
        type: s1
        enum: open_close
        doc: 'openClose'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: target_party_id
        type: str_4_nullable
        doc: 'targetPartyId. Nullable, No Value = 0'
      - id: auction_id
        type: u4_nullable
        doc: 'auctionId. Nullable, No Value = 4294967295'
      - id: clearing_firm
        type: u4_nullable
        doc: 'clearingFirm. Nullable, No Value = 4294967295'
      - id: optional_data
        type: str_16_nullable
        doc: 'optionalData. Nullable, No Value = 0'
      - id: routing_firm_id
        type: str_4_nullable
        doc: 'routingFirmId. Nullable, No Value = 0'
      - id: aiq
        type: str_3_nullable
        doc: 'aiq. Nullable, No Value = 0'
      - id: leaves_qty
        type: u4
        doc: 'leavesQty'
      - id: cum_qty
        type: u4
        doc: 'cumQty'
      - id: last_qty
        type: u4
        doc: 'lastQty'
      - id: trade_liquidity_indicator
        type: s1
        enum: trade_liquidity_indicator
        doc: 'tradeLiquidityIndicator'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'feeCode'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: occ_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'occId'
      - id: contra_clearing_account
        type: str_4_nullable
        doc: 'contraClearingAccount. Nullable, No Value = 0'
      - id: contra_clearing_firm
        type: u4_nullable
        doc: 'contraClearingFirm. Nullable, No Value = 4294967295'
      - id: contra_mpid
        type: str
        size: 4
        encoding: ASCII
        doc: 'contraMpid'
      - id: contra_open_close
        type: s1
        enum: contra_open_close
        doc: 'contraOpenClose'
      - id: contra_customer_or_firm
        type: s1
        enum: contra_customer_or_firm
        doc: 'contraCustomerOrFirm'
      - id: contra_occ_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'contraOccId'
  trade_bust_correct_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: exec_id
        type: u8
        doc: 'execId'
      - id: trade_id_optional
        type: u8_nullable
        doc: 'tradeId. Nullable, No Value = 18446744073709551615'
      - id: trade_ref_id
        type: u8
        doc: 'tradeRefId'
      - id: last_px
        type: decimal_s8_8
        doc: 'lastPx. Implied decimal with scale 1e-8'
      - id: account_account_optional
        type: str_16_nullable
        doc: 'account. Nullable, No Value = 0'
      - id: last_qty
        type: u4
        doc: 'lastQty'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: bust_or_correction
        type: s1
        enum: bust_or_correction
        doc: 'bustOrCorrection'
  application_layer_reject_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_optional
        type: u4_nullable
        doc: 'underlyingId. Nullable, No Value = 4294967295'
      - id: instrument_id_instrument_id_optional
        type: u4_nullable
        doc: 'instrumentId. Nullable, No Value = 4294967295'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: account_string_16_optional
        type: str_16_nullable
        doc: 'account. Nullable, No Value = 0'
      - id: reason_code_optional
        type: u1_nullable
        doc: 'reasonCode. Nullable, No Value = 255'
      - id: reject_type
        type: s1
        enum: reject_type
        doc: 'rejectType'
      - id: throttle_indicator_optional
        type: s1_nullable
        doc: 'throttleIndicator. Nullable, No Value = 128'
  underlying_ref_data_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id
        type: u4
        doc: 'underlyingId'
      - id: underlying_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'underlyingSymbol'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'mic'
      - id: mpv_group
        type: s1
        enum: mpv_group
        doc: 'mpvGroup'
  instrument_ref_data_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id
        type: u4
        doc: 'instrumentId'
      - id: underlying_id
        type: u4
        doc: 'underlyingId'
      - id: osi_symbol
        type: str
        size: 21
        encoding: ASCII
        doc: 'osiSymbol'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'maturityDate'
      - id: option_type
        type: s1
        enum: option_type
        doc: 'optionType'
      - id: strike_price
        type: decimal_s8_8
        doc: 'strikePrice. Implied decimal with scale 1e-8'
      - id: closing_only
        type: u1
        enum: closing_only
        doc: 'closingOnly'
      - id: orp_enabled
        type: u1
        enum: orp_enabled
        doc: 'ORPEnabled'
      - id: trading_ring
        type: s1
        doc: 'tradingRing'
      - id: matching_unit
        type: s2
        doc: 'matchingUnit'
  mpid_configuration_acknowledgement_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: mpid_status
        type: s1
        enum: mpid_status
        doc: 'mpidStatus'
      - id: member
        type: str
        size: 8
        encoding: ASCII
        doc: 'member'
      - id: max_qty
        type: u4_nullable
        doc: 'maxQty. Nullable, No Value = 4294967295'
      - id: max_notional
        type: decimal_s8_8_nullable
        doc: 'maxNotional. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: default_account
        type: str_16_nullable
        doc: 'defaultAccount. Nullable, No Value = 0'
      - id: default_optional_data
        type: str_16_nullable
        doc: 'defaultOptionalData. Nullable, No Value = 0'
      - id: default_clearing_account
        type: str_4_nullable
        doc: 'defaultClearingAccount. Nullable, No Value = 0'
      - id: allow_market_orders
        type: u1_nullable
        doc: 'allowMarketOrders. Nullable, No Value = 255'
      - id: allow_isoioc
        type: u1_nullable
        doc: 'allowISOIOC. Nullable, No Value = 255'
      - id: allow_iso_day
        type: u1_nullable
        doc: 'allowISODay. Nullable, No Value = 255'
      - id: max_duplicative
        type: u4_nullable
        doc: 'maxDuplicative. Nullable, No Value = 4294967295'
  market_maker_symbol_appointment_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id
        type: u4
        doc: 'underlyingId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: appointment_type
        type: s1
        enum: appointment_type
        doc: 'appointmentType'
      - id: appointment_status
        type: s1
        enum: appointment_status
        doc: 'appointmentStatus'
      - id: max_allowable_width
        type: u4_nullable
        doc: 'maxAllowableWidth. Nullable, No Value = 4294967295'
      - id: quote_relief_mult
        type: u4_nullable
        doc: 'quoteReliefMult. Nullable, No Value = 4294967295'
  session_configuration_acknowledgement_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: user_session_type
        type: s1
        enum: user_session_type
        doc: 'userSessionType'
      - id: user_session_status
        type: s1
        enum: user_session_status
        doc: 'userSessionStatus'
      - id: member
        type: str
        size: 8
        encoding: ASCII
        doc: 'member'
      - id: default_mpid
        type: str_4_nullable
        doc: 'defaultMpid. Nullable, No Value = 0'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'mic'
      - id: cancel_on_disconnect
        type: s1_nullable
        doc: 'cancelOnDisconnect. Nullable, No Value = 128'
      - id: aiq_default
        type: str_3_nullable
        doc: 'aiqDefault. Nullable, No Value = 0'
      - id: order_unsolicited_ack_subscription
        type: u1_nullable
        doc: 'orderUnsolicitedAckSubscription. Nullable, No Value = 255'
      - id: quote_unsolicited_ack_subscription
        type: u1_nullable
        doc: 'quoteUnsolicitedAckSubscription. Nullable, No Value = 255'
      - id: default_attributed_quote
        type: s1_nullable
        doc: 'defaultAttributedQuote. Nullable, No Value = 128'
      - id: default_cancel_instead_of_slide
        type: u1_nullable
        doc: 'defaultCancelInsteadOfSlide. Nullable, No Value = 255'
      - id: trading_ring_optional
        type: s1_nullable
        doc: 'tradingRing. Nullable, No Value = 128'
  risk_control_acknowledgment_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_optional
        type: u4_nullable
        doc: 'underlyingId. Nullable, No Value = 4294967295'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: custom_group_id_optional
        type: u2_nullable
        doc: 'customGroupId. Nullable, No Value = 65535'
      - id: risk_ack_type
        type: s1
        enum: risk_ack_type
        doc: 'riskAckType'
      - id: risk_control_status
        type: s1_nullable
        doc: 'riskControlStatus. Nullable, No Value = 128'
      - id: risk_control
        type: s1
        enum: risk_control
        doc: 'riskControl'
      - id: risk_action_optional
        type: s1_nullable
        doc: 'riskAction. Nullable, No Value = 128'
      - id: time_limit
        type: u8_nullable
        doc: 'timeLimit. Nullable, No Value = 18446744073709551615'
      - id: percentage_limit
        type: u4_nullable
        doc: 'percentageLimit. Nullable, No Value = 4294967295'
      - id: count_limit
        type: u4_nullable
        doc: 'countLimit. Nullable, No Value = 4294967295'
      - id: ioc_attribution
        type: s1_nullable
        doc: 'iocAttribution. Nullable, No Value = 128'
      - id: blocked_by_breach_indicator
        type: s1_nullable
        doc: 'blockedByBreachIndicator. Nullable, No Value = 128'
      - id: cust_capacity_weight
        type: u1_nullable
        doc: 'custCapacityWeight. Nullable, No Value = 255'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  risk_control_alert_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_optional
        type: u4_nullable
        doc: 'underlyingId. Nullable, No Value = 4294967295'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: risk_control
        type: s1
        enum: risk_control
        doc: 'riskControl'
      - id: time_limit
        type: u8_nullable
        doc: 'timeLimit. Nullable, No Value = 18446744073709551615'
      - id: percentage_limit
        type: u4_nullable
        doc: 'percentageLimit. Nullable, No Value = 4294967295'
      - id: count_limit
        type: u4_nullable
        doc: 'countLimit. Nullable, No Value = 4294967295'
      - id: notification_reason
        type: s1
        enum: notification_reason
        doc: 'notificationReason'
  str_16_nullable:
    seq:
      - id: value
        size: 16
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == -128
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  str_3_nullable:
    seq:
      - id: value
        size: 3
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s8_8_nullable:
    seq:
      - id: value
        type: decimal_s8_8
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s4_4_nullable:
    seq:
      - id: value
        type: decimal_s4_4
    instances:
      is_null:
        value: value.mantissa == -2147483648

enums:
  template_id:
    1:
      id: 'login_request_message'
      doc: 'LoginRequestMessage'
    2:
      id: 'login_response_message'
      doc: 'LoginResponseMessage'
    3:
      id: 'gateway_heartbeat_message'
      doc: 'GatewayHeartbeatMessage'
    4:
      id: 'client_heartbeat_message'
      doc: 'ClientHeartbeatMessage'
    5:
      id: 'logout_request_message'
      doc: 'LogoutRequestMessage'
    6:
      id: 'terminate_message'
      doc: 'TerminateMessage'
    7:
      id: 'sequenced_message_header_message'
      doc: 'SequencedMessageHeaderMessage'
    8:
      id: 'subsession_join_message'
      doc: 'SubsessionJoinMessage'
    9:
      id: 'subsession_join_response_message'
      doc: 'SubsessionJoinResponseMessage'
    10:
      id: 'subsession_leave_message'
      doc: 'SubsessionLeaveMessage'
    11:
      id: 'subsession_leave_response_message'
      doc: 'SubsessionLeaveResponseMessage'
    101:
      id: 'order_ack_message'
      doc: 'OrderAckMessage'
    102:
      id: 'unsolicited_modify_ack_message'
      doc: 'UnsolicitedModifyAckMessage'
    103:
      id: 'order_cancel_ack_message'
      doc: 'OrderCancelAckMessage'
    104:
      id: 'mass_cancel_ack_message'
      doc: 'MassCancelAckMessage'
    105:
      id: 'bulk_quote_ack_message'
      doc: 'BulkQuoteAckMessage'
    106:
      id: 'new_ioc_quote_ack_message'
      doc: 'NewIocQuoteAckMessage'
    107:
      id: 'quote_restated_message'
      doc: 'QuoteRestatedMessage'
    108:
      id: 'quote_canceled_message'
      doc: 'QuoteCanceledMessage'
    109:
      id: 'purge_ack_message'
      doc: 'PurgeAckMessage'
    110:
      id: 'execution_report_message'
      doc: 'ExecutionReportMessage'
    111:
      id: 'trade_bust_correct_message'
      doc: 'TradeBustCorrectMessage'
    112:
      id: 'application_layer_reject_message'
      doc: 'ApplicationLayerRejectMessage'
    51:
      id: 'risk_limit_update_request_message'
      doc: 'RiskLimitUpdateRequestMessage'
    52:
      id: 'risk_action_request_message'
      doc: 'RiskActionRequestMessage'
    151:
      id: 'underlying_ref_data_message'
      doc: 'UnderlyingRefDataMessage'
    152:
      id: 'instrument_ref_data_message'
      doc: 'InstrumentRefDataMessage'
    153:
      id: 'mpid_configuration_acknowledgement_message'
      doc: 'MPIDConfigurationAcknowledgementMessage'
    154:
      id: 'market_maker_symbol_appointment_message'
      doc: 'MarketMakerSymbolAppointmentMessage'
    155:
      id: 'session_configuration_acknowledgement_message'
      doc: 'SessionConfigurationAcknowledgementMessage'
    156:
      id: 'risk_control_acknowledgment_message'
      doc: 'RiskControlAcknowledgmentMessage'
    157:
      id: 'risk_control_alert_message'
      doc: 'RiskControlAlertMessage'
  schema_id:
    20000:
      id: 'session'
      doc: 'Sbe Schema Id for iex.options.boe.session'
    20001:
      id: 'business'
      doc: 'Sbe Schema Id for iex.options.boe.business'
  customer_or_firm:
    0:
      id: 'customer'
      doc: 'Customer'
    1:
      id: 'firm'
      doc: 'Firm'
    2:
      id: 'broker_dealer'
      doc: 'BrokerDealer'
    3:
      id: 'market_maker'
      doc: 'MarketMaker'
    4:
      id: 'away_market_maker'
      doc: 'AwayMarketMaker'
    5:
      id: 'prof_customer'
      doc: 'ProfCustomer'
  open_close:
    0:
      id: 'open'
      doc: 'Open'
    1:
      id: 'close'
      doc: 'Close'
    2:
      id: 'not_applicable'
      doc: 'NotApplicable'
  attributed_quote_optional:
    1:
      id: 'sum'
      doc: 'Sum'
    2:
      id: 'order_info_capacity'
      doc: 'OrderInfo_Capacity'
    3:
      id: 'order_info_mpid'
      doc: 'OrderInfo_Mpid'
    4:
      id: 'order_info_capacity_mpid'
      doc: 'OrderInfo_Capacity_Mpid'
    5:
      id: 'do_not_use_sum'
      doc: 'DoNotUseSum'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'ioc'
      doc: 'IOC'
  cancel_instead_of_slide_optional:
    0:
      id: 'slide'
      doc: 'Slide'
    1:
      id: 'cancel'
      doc: 'Cancel'
  display_inst:
    1:
      id: 'post_only'
      doc: 'PostOnly'
  exec_inst:
    1:
      id: 'iso'
      doc: 'ISO'
    2:
      id: 'do_not_route'
      doc: 'DoNotRoute'
  ord_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  customer_or_firm_optional:
    0:
      id: 'customer'
      doc: 'Customer'
    1:
      id: 'firm'
      doc: 'Firm'
    2:
      id: 'broker_dealer'
      doc: 'BrokerDealer'
    3:
      id: 'market_maker'
      doc: 'MarketMaker'
    4:
      id: 'away_market_maker'
      doc: 'AwayMarketMaker'
    5:
      id: 'prof_customer'
      doc: 'ProfCustomer'
  open_close_optional:
    0:
      id: 'open'
      doc: 'Open'
    1:
      id: 'close'
      doc: 'Close'
    2:
      id: 'not_applicable'
      doc: 'NotApplicable'
  time_in_force_optional:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'ioc'
      doc: 'IOC'
  ord_type_optional:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
  side_optional:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  quote_type:
    0:
      id: 'standard'
      doc: 'Standard'
    1:
      id: 'reprice'
      doc: 'Reprice'
    2:
      id: 'cancel'
      doc: 'Cancel'
  ack_style_mass_cancel_ack_style:
    0:
      id: 'single_ack'
      doc: 'Send a single Mass Cancel Acknowledgement once all cancels have been processed.'
    1:
      id: 'per_order_ack_and_single_ack'
      doc: 'Send both Order Cancel Acknowledgements messages for each canceled order and a single Mass Cancel Acknowledgement once all cancels have been processed.'
  mpid_filter:
    0:
      id: 'explicit_mpid'
      doc: 'Take BulkAction explicitly for this MPID on this session.'
    1:
      id: 'across_mpi_ds'
      doc: 'Take BulkAction across MPIDs on this session.'
  bulk_action:
    0:
      id: 'cancel'
      doc: 'Cancel'
    1:
      id: 'cancel_and_block'
      doc: 'CancelAndBlock'
    2:
      id: 'unblock'
      doc: 'Unblock'
  ack_style_purge_request_ack_style:
    0:
      id: 'single_ack'
      doc: 'Send a single Purge Acknowledgement on the Purge Session once all cancels have been processed.'
    1:
      id: 'single_ack_with_mmqs'
      doc: 'Send a single Purge Acknowledgement on the Purge Session once all cancels have been processed. Separately, send a Purge Acknowledgment to each Market Maker Quoting Session with this MPID on this Trading Ring once all cancels have been processed.'
  risk_control_optional:
    1:
      id: 'transaction_based'
      doc: 'TransactionBased'
    2:
      id: 'volume_based'
      doc: 'VolumeBased'
    3:
      id: 'percentage_based'
      doc: 'PercentageBased'
    4:
      id: 'grmp'
      doc: 'GRMP'
    5:
      id: 'purge_lockout_reset'
      doc: 'PurgeLockoutReset'
    6:
      id: 'intrinsic_value_and_arbitrage'
      doc: 'IntrinsicValueAndArbitrage'
    7:
      id: 'all_blocks_for_underlying'
      doc: 'AllBlocksForUnderlying'
  risk_control_status:
    0:
      id: 'disabled'
      doc: 'Disabled'
    1:
      id: 'enabled'
      doc: 'Enabled'
  ioc_attribution:
    1:
      id: 'include_ioc'
      doc: 'IncludeIOC'
    2:
      id: 'exclude_ioc'
      doc: 'ExcludeIOC'
  risk_control:
    1:
      id: 'transaction_based'
      doc: 'TransactionBased'
    2:
      id: 'volume_based'
      doc: 'VolumeBased'
    3:
      id: 'percentage_based'
      doc: 'PercentageBased'
    4:
      id: 'grmp'
      doc: 'GRMP'
    5:
      id: 'purge_lockout_reset'
      doc: 'PurgeLockoutReset'
    6:
      id: 'intrinsic_value_and_arbitrage'
      doc: 'IntrinsicValueAndArbitrage'
    7:
      id: 'all_blocks_for_underlying'
      doc: 'AllBlocksForUnderlying'
  risk_action:
    1:
      id: 'query_risk_control'
      doc: 'QueryRiskControl'
    2:
      id: 'unblock'
      doc: 'Unblock'
  status:
    0:
      id: 'success'
      doc: 'Success'
    1:
      id: 'session_level_reject'
      doc: 'SessionLevelReject'
    2:
      id: 'logout_requested'
      doc: 'LogoutRequested'
    3:
      id: 'unknown'
      doc: 'Unknown'
    4:
      id: 'invalid_logon_id'
      doc: 'InvalidLogonId'
    5:
      id: 'invalid_token'
      doc: 'InvalidToken'
    6:
      id: 'already_logged_in'
      doc: 'AlreadyLoggedIn'
    7:
      id: 'login_timeout'
      doc: 'LoginTimeout'
    8:
      id: 'invalid_packet_length'
      doc: 'InvalidPacketLength'
    9:
      id: 'invalid_message'
      doc: 'InvalidMessage'
    10:
      id: 'join_revoked'
      doc: 'JoinRevoked'
    11:
      id: 'heartbeat_timeout'
      doc: 'HeartbeatTimeout'
    12:
      id: 'message_out_of_sequence'
      doc: 'MessageOutOfSequence'
    13:
      id: 'invalid_subsession_id'
      doc: 'InvalidSubsessionId'
    14:
      id: 'subsession_not_joined'
      doc: 'SubsessionNotJoined'
    15:
      id: 'denial_of_service'
      doc: 'DenialOfService'
    16:
      id: 'invalid_argument'
      doc: 'InvalidArgument'
    17:
      id: 'already_joined'
      doc: 'AlreadyJoined'
  keep_alive:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  subsession_type:
    0:
      id: 'client_to_gateway'
      doc: 'ClientToGateway'
    1:
      id: 'gateway_to_client'
      doc: 'GatewayToClient'
    2:
      id: 'reference_data'
      doc: 'ReferenceData'
  joined:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  reason:
    0:
      id: 'success'
      doc: 'Success'
    1:
      id: 'session_level_reject'
      doc: 'SessionLevelReject'
    2:
      id: 'logout_requested'
      doc: 'LogoutRequested'
    3:
      id: 'unknown'
      doc: 'Unknown'
    4:
      id: 'invalid_logon_id'
      doc: 'InvalidLogonId'
    5:
      id: 'invalid_token'
      doc: 'InvalidToken'
    6:
      id: 'already_logged_in'
      doc: 'AlreadyLoggedIn'
    7:
      id: 'login_timeout'
      doc: 'LoginTimeout'
    8:
      id: 'invalid_packet_length'
      doc: 'InvalidPacketLength'
    9:
      id: 'invalid_message'
      doc: 'InvalidMessage'
    10:
      id: 'join_revoked'
      doc: 'JoinRevoked'
    11:
      id: 'heartbeat_timeout'
      doc: 'HeartbeatTimeout'
    12:
      id: 'message_out_of_sequence'
      doc: 'MessageOutOfSequence'
    13:
      id: 'invalid_subsession_id'
      doc: 'InvalidSubsessionId'
    14:
      id: 'subsession_not_joined'
      doc: 'SubsessionNotJoined'
    15:
      id: 'denial_of_service'
      doc: 'DenialOfService'
    16:
      id: 'invalid_argument'
      doc: 'InvalidArgument'
    17:
      id: 'already_joined'
      doc: 'AlreadyJoined'
  attributed_quote:
    1:
      id: 'sum'
      doc: 'Sum'
    2:
      id: 'order_info_capacity'
      doc: 'OrderInfo_Capacity'
    3:
      id: 'order_info_mpid'
      doc: 'OrderInfo_Mpid'
    4:
      id: 'order_info_capacity_mpid'
      doc: 'OrderInfo_Capacity_Mpid'
    5:
      id: 'do_not_use_sum'
      doc: 'DoNotUseSum'
  cancel_instead_of_slide:
    0:
      id: 'slide'
      doc: 'Slide'
    1:
      id: 'cancel'
      doc: 'Cancel'
  reason_code_optional:
    1:
      id: 'unknown_instrument_identifier'
      doc: 'UnknownInstrumentIdentifier'
    2:
      id: 'invalid_ord_type'
      doc: 'InvalidOrdType'
    3:
      id: 'invalid_side'
      doc: 'InvalidSide'
    4:
      id: 'invalid_time_in_force'
      doc: 'InvalidTimeInForce'
    5:
      id: 'invalid_open_close'
      doc: 'InvalidOpenClose'
    6:
      id: 'invalid_customer_or_firm'
      doc: 'InvalidCustomerOrFirm'
    7:
      id: 'invalid_display_inst'
      doc: 'InvalidDisplayInst'
    8:
      id: 'invalid_attributed_quote'
      doc: 'InvalidAttributedQuote'
    9:
      id: 'invalid_exec_inst'
      doc: 'InvalidExecInst'
    10:
      id: 'invalid_cancel_instead_of_slide'
      doc: 'InvalidCancelInsteadOfSlide'
    11:
      id: 'invalid_order_qty'
      doc: 'InvalidOrderQty'
    12:
      id: 'closing_only'
      doc: 'ClosingOnly'
    13:
      id: 'not_appointed'
      doc: 'NotAppointed'
    14:
      id: 'invalid_price'
      doc: 'InvalidPrice'
    15:
      id: 'invalid_tag_combination_for_market_order'
      doc: 'InvalidTagCombinationForMarketOrder'
    16:
      id: 'invalid_tag_combination_for_ioc'
      doc: 'InvalidTagCombinationForIOC'
    17:
      id: 'invalid_aiq'
      doc: 'InvalidAIQ'
    18:
      id: 'aiq_cancel_newest'
      doc: 'AIQCancelNewest'
    19:
      id: 'aiq_cancel_oldest'
      doc: 'AIQCancelOldest'
    20:
      id: 'aiq_cancel_smallest'
      doc: 'AIQCancelSmallest'
    21:
      id: 'aiq_cancel_both'
      doc: 'AIQCancelBoth'
    22:
      id: 'no_order_found'
      doc: 'NoOrderFound'
    23:
      id: 'order_in_pending_state'
      doc: 'OrderInPendingState'
    24:
      id: 'order_terminal'
      doc: 'OrderTerminal'
    25:
      id: 'no_bid'
      doc: 'NoBid'
    26:
      id: 'no_offer'
      doc: 'NoOffer'
    27:
      id: 'order_not_marketable'
      doc: 'OrderNotMarketable'
    28:
      id: 'order_would_lock_cross'
      doc: 'OrderWouldLockCross'
    29:
      id: 'invalid_quote_count'
      doc: 'InvalidQuoteCount'
    30:
      id: 'inconsistent_underlying'
      doc: 'InconsistentUnderlying'
    31:
      id: 'duplicate_quote'
      doc: 'DuplicateQuote'
    32:
      id: 'invalid_quote_type'
      doc: 'InvalidQuoteType'
    33:
      id: 'invalid_bulk_action'
      doc: 'InvalidBulkAction'
    34:
      id: 'invalid_bulk_action_parameters'
      doc: 'InvalidBulkActionParameters'
    35:
      id: 'invalid_custom_group_id'
      doc: 'InvalidCustomGroupId'
    36:
      id: 'blocked_underlying_id'
      doc: 'BlockedUnderlyingId'
    37:
      id: 'order_will_be_canceled'
      doc: 'OrderWillBeCanceled'
    38:
      id: 'invalid_ack_style'
      doc: 'InvalidAckStyle'
    39:
      id: 'invalid_mpid_filter'
      doc: 'InvalidMPIDFilter'
    40:
      id: 'invalid_block'
      doc: 'InvalidBlock'
    41:
      id: 'invalid_risk_control'
      doc: 'InvalidRiskControl'
    42:
      id: 'invalid_risk_action_type'
      doc: 'InvalidRiskActionType'
    43:
      id: 'invalid_unblock_parameters'
      doc: 'InvalidUnblockParameters'
    44:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdId'
    45:
      id: 'invalid_market_participant_id'
      doc: 'InvalidMarketParticipantId'
    46:
      id: 'invalid_nbbo_width'
      doc: 'InvalidNbboWidth'
    47:
      id: 'missing_clearing_account'
      doc: 'MissingClearingAccount'
    48:
      id: 'invalid_clearing_account'
      doc: 'InvalidClearingAccount'
    49:
      id: 'invalid_account'
      doc: 'InvalidAccount'
    50:
      id: 'quote_not_marketable'
      doc: 'QuoteNotMarketable'
    51:
      id: 'constrained_by_drill_through_protection'
      doc: 'ConstrainedByDrillThroughProtection'
    52:
      id: 'invalid_optional_data'
      doc: 'InvalidOptionalData'
    53:
      id: 'drill_through_protection_cancel'
      doc: 'DrillThroughProtectionCancel'
    54:
      id: 'risk_breach'
      doc: 'RiskBreach'
    55:
      id: 'internal_error'
      doc: 'InternalError'
    56:
      id: 'blocked_custom_group_id'
      doc: 'BlockedCustomGroupId'
    57:
      id: 'orp_reject'
      doc: 'OrpReject'
    58:
      id: 'quote_not_found'
      doc: 'QuoteNotFound'
    59:
      id: 'too_late_to_cancel'
      doc: 'TooLateToCancel'
    60:
      id: 'invalid_orp_reprice_check'
      doc: 'InvalidOrpRepriceCheck'
    61:
      id: 'contra_mm_interest'
      doc: 'ContraMMInterest'
    62:
      id: 'market_closed'
      doc: 'MarketClosed'
    63:
      id: 'market_suspended'
      doc: 'MarketSuspended'
    64:
      id: 'invalid_ioc_for_non_continuous'
      doc: 'InvalidIOCForNonContinuous'
    65:
      id: 'limit_up_limit_down'
      doc: 'LimitUpLimitDown'
    66:
      id: 'invalid_risk_control_status'
      doc: 'InvalidRiskControlStatus'
    67:
      id: 'invalid_time_limit'
      doc: 'InvalidTimeLimit'
    68:
      id: 'invalid_percentage_limit'
      doc: 'InvalidPercentageLimit'
    69:
      id: 'invalid_count_limit'
      doc: 'InvalidCountLimit'
    70:
      id: 'invalid_ioc_attribution'
      doc: 'InvalidIOCAttribution'
    71:
      id: 'cancel_remaining_ioc'
      doc: 'CancelRemainingIOC'
    72:
      id: 'no_market_for_market_order'
      doc: 'NoMarketForMarketOrder'
    73:
      id: 'grmp_block'
      doc: 'GrmpBlock'
    74:
      id: 'fully_filled'
      doc: 'FullyFilled'
    75:
      id: 'invalid_auction_id'
      doc: 'InvalidAuctionId'
    76:
      id: 'invalid_response_order_qty'
      doc: 'InvalidResponseOrderQty'
    77:
      id: 'sum_complete'
      doc: 'SUMComplete'
    78:
      id: 'limit_order_price_protection_breach'
      doc: 'LimitOrderPriceProtectionBreach'
    79:
      id: 'intrinsic_value_breach'
      doc: 'IntrinsicValueBreach'
    80:
      id: 'invalid_underlying_id'
      doc: 'InvalidUnderlyingId'
    81:
      id: 'market_halt'
      doc: 'MarketHalt'
    82:
      id: 'market_order_max_notional_breach'
      doc: 'MarketOrderMaxNotionalBreach'
    83:
      id: 'invalid_target_party_id'
      doc: 'InvalidTargetPartyId'
    84:
      id: 'invalid_routing_firm_id'
      doc: 'InvalidRoutingFirmId'
    85:
      id: 'opening_process_cancel'
      doc: 'OpeningProcessCancel'
    86:
      id: 'quote_would_lock_cross'
      doc: 'QuoteWouldLockCross'
    87:
      id: 'invalid_clearing_firm'
      doc: 'InvalidClearingFirm'
    88:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdId'
    89:
      id: 'invalid_orig_cl_ord_id'
      doc: 'InvalidOrigClOrdId'
    90:
      id: 'unknown_orig_cl_ord_id'
      doc: 'UnknownOrigClOrdId'
    91:
      id: 'invalid_on_behalf_of_comp_id'
      doc: 'InvalidOnBehalfOfCompId'
    92:
      id: 'disallowed_market_orders'
      doc: 'DisallowedMarketOrders'
    93:
      id: 'disallowed_iso_ioc_orders'
      doc: 'DisallowedIsoIocOrders'
    94:
      id: 'disallowed_iso_day_orders'
      doc: 'DisallowedIsoDayOrders'
    95:
      id: 'restricted_symbol'
      doc: 'RestrictedSymbol'
    96:
      id: 'cancel_on_disconnect'
      doc: 'CancelOnDisconnect'
    97:
      id: 'invalid_send_time'
      doc: 'InvalidSendTime'
    98:
      id: 'invalid_cust_capacity_weight'
      doc: 'InvalidCustCapacityWeight'
    99:
      id: 'max_duplicative'
      doc: 'MaxDuplicative'
    100:
      id: 'mpid_blocked'
      doc: 'MPIDBlocked'
    101:
      id: 'quote_canceled'
      doc: 'QuoteCanceled'
    102:
      id: 'invalid_custom_group_id_count'
      doc: 'InvalidCustomGroupIdCount'
    103:
      id: 'grmp_trip'
      doc: 'GrmpTrip'
    104:
      id: 'max_qty_exceeded'
      doc: 'MaxQtyExceeded'
    105:
      id: 'max_notional_exceeded'
      doc: 'MaxNotionalExceeded'
    106:
      id: 'occ_identifier_not_configured'
      doc: 'OccIdentifierNotConfigured'
    107:
      id: 'arbitrage_breach'
      doc: 'ArbitrageBreach'
    108:
      id: 'abrc_breach'
      doc: 'ABRCBreach'
    109:
      id: 'admin_cancel'
      doc: 'AdminCancel'
    110:
      id: 'invalid_reserved'
      doc: 'InvalidReserved'
    111:
      id: 'nbbo_fade'
      doc: 'NBBOFade'
    112:
      id: 'locked_or_crossed_by_away'
      doc: 'LockedOrCrossedByAway'
    113:
      id: 'sum_timeout'
      doc: 'SUMTimeout'
    114:
      id: 'portal_cancel_external'
      doc: 'PortalCancelExternal'
    115:
      id: 'portal_cancel_internal'
      doc: 'PortalCancelInternal'
  ack_type:
    1:
      id: 'new_interest'
      doc: 'NewInterest'
    2:
      id: 'pending_cancel'
      doc: 'PendingCancel'
    3:
      id: 'canceled'
      doc: 'Canceled'
    4:
      id: 'pending_replace'
      doc: 'PendingReplace'
    5:
      id: 'replaced'
      doc: 'Replaced'
    6:
      id: 'individual_market_maker_quote_reject'
      doc: 'IndividualMarketMakerQuoteReject'
    7:
      id: 'unsolicited_reprice_price_adjust'
      doc: 'UnsolicitedRepricePriceAdjust'
    8:
      id: 'unsolicited_reprice_orp'
      doc: 'UnsolicitedRepriceOrp'
    9:
      id: 'unsolicited_cancel_orp'
      doc: 'UnsolicitedCancelOrp'
    10:
      id: 'market_maker_quote_not_modified'
      doc: 'MarketMakerQuoteNotModified'
  throttle_indicator:
    0:
      id: 'not_throttled'
      doc: 'NotThrottled'
    1:
      id: 'throttled'
      doc: 'Throttled'
  restatement_reason:
    1:
      id: 'price_adjust_repricing'
      doc: 'PriceAdjustRepricing'
    2:
      id: 'drill_through_protection_repricing'
      doc: 'DrillThroughProtectionRepricing'
    3:
      id: 'trading_halt'
      doc: 'TradingHalt'
    4:
      id: 'sum_conclusion'
      doc: 'SUMConclusion'
    5:
      id: 'book_resubmission'
      doc: 'BookResubmission'
  reason_code:
    1:
      id: 'unknown_instrument_identifier'
      doc: 'UnknownInstrumentIdentifier'
    2:
      id: 'invalid_ord_type'
      doc: 'InvalidOrdType'
    3:
      id: 'invalid_side'
      doc: 'InvalidSide'
    4:
      id: 'invalid_time_in_force'
      doc: 'InvalidTimeInForce'
    5:
      id: 'invalid_open_close'
      doc: 'InvalidOpenClose'
    6:
      id: 'invalid_customer_or_firm'
      doc: 'InvalidCustomerOrFirm'
    7:
      id: 'invalid_display_inst'
      doc: 'InvalidDisplayInst'
    8:
      id: 'invalid_attributed_quote'
      doc: 'InvalidAttributedQuote'
    9:
      id: 'invalid_exec_inst'
      doc: 'InvalidExecInst'
    10:
      id: 'invalid_cancel_instead_of_slide'
      doc: 'InvalidCancelInsteadOfSlide'
    11:
      id: 'invalid_order_qty'
      doc: 'InvalidOrderQty'
    12:
      id: 'closing_only'
      doc: 'ClosingOnly'
    13:
      id: 'not_appointed'
      doc: 'NotAppointed'
    14:
      id: 'invalid_price'
      doc: 'InvalidPrice'
    15:
      id: 'invalid_tag_combination_for_market_order'
      doc: 'InvalidTagCombinationForMarketOrder'
    16:
      id: 'invalid_tag_combination_for_ioc'
      doc: 'InvalidTagCombinationForIOC'
    17:
      id: 'invalid_aiq'
      doc: 'InvalidAIQ'
    18:
      id: 'aiq_cancel_newest'
      doc: 'AIQCancelNewest'
    19:
      id: 'aiq_cancel_oldest'
      doc: 'AIQCancelOldest'
    20:
      id: 'aiq_cancel_smallest'
      doc: 'AIQCancelSmallest'
    21:
      id: 'aiq_cancel_both'
      doc: 'AIQCancelBoth'
    22:
      id: 'no_order_found'
      doc: 'NoOrderFound'
    23:
      id: 'order_in_pending_state'
      doc: 'OrderInPendingState'
    24:
      id: 'order_terminal'
      doc: 'OrderTerminal'
    25:
      id: 'no_bid'
      doc: 'NoBid'
    26:
      id: 'no_offer'
      doc: 'NoOffer'
    27:
      id: 'order_not_marketable'
      doc: 'OrderNotMarketable'
    28:
      id: 'order_would_lock_cross'
      doc: 'OrderWouldLockCross'
    29:
      id: 'invalid_quote_count'
      doc: 'InvalidQuoteCount'
    30:
      id: 'inconsistent_underlying'
      doc: 'InconsistentUnderlying'
    31:
      id: 'duplicate_quote'
      doc: 'DuplicateQuote'
    32:
      id: 'invalid_quote_type'
      doc: 'InvalidQuoteType'
    33:
      id: 'invalid_bulk_action'
      doc: 'InvalidBulkAction'
    34:
      id: 'invalid_bulk_action_parameters'
      doc: 'InvalidBulkActionParameters'
    35:
      id: 'invalid_custom_group_id'
      doc: 'InvalidCustomGroupId'
    36:
      id: 'blocked_underlying_id'
      doc: 'BlockedUnderlyingId'
    37:
      id: 'order_will_be_canceled'
      doc: 'OrderWillBeCanceled'
    38:
      id: 'invalid_ack_style'
      doc: 'InvalidAckStyle'
    39:
      id: 'invalid_mpid_filter'
      doc: 'InvalidMPIDFilter'
    40:
      id: 'invalid_block'
      doc: 'InvalidBlock'
    41:
      id: 'invalid_risk_control'
      doc: 'InvalidRiskControl'
    42:
      id: 'invalid_risk_action_type'
      doc: 'InvalidRiskActionType'
    43:
      id: 'invalid_unblock_parameters'
      doc: 'InvalidUnblockParameters'
    44:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdId'
    45:
      id: 'invalid_market_participant_id'
      doc: 'InvalidMarketParticipantId'
    46:
      id: 'invalid_nbbo_width'
      doc: 'InvalidNbboWidth'
    47:
      id: 'missing_clearing_account'
      doc: 'MissingClearingAccount'
    48:
      id: 'invalid_clearing_account'
      doc: 'InvalidClearingAccount'
    49:
      id: 'invalid_account'
      doc: 'InvalidAccount'
    50:
      id: 'quote_not_marketable'
      doc: 'QuoteNotMarketable'
    51:
      id: 'constrained_by_drill_through_protection'
      doc: 'ConstrainedByDrillThroughProtection'
    52:
      id: 'invalid_optional_data'
      doc: 'InvalidOptionalData'
    53:
      id: 'drill_through_protection_cancel'
      doc: 'DrillThroughProtectionCancel'
    54:
      id: 'risk_breach'
      doc: 'RiskBreach'
    55:
      id: 'internal_error'
      doc: 'InternalError'
    56:
      id: 'blocked_custom_group_id'
      doc: 'BlockedCustomGroupId'
    57:
      id: 'orp_reject'
      doc: 'OrpReject'
    58:
      id: 'quote_not_found'
      doc: 'QuoteNotFound'
    59:
      id: 'too_late_to_cancel'
      doc: 'TooLateToCancel'
    60:
      id: 'invalid_orp_reprice_check'
      doc: 'InvalidOrpRepriceCheck'
    61:
      id: 'contra_mm_interest'
      doc: 'ContraMMInterest'
    62:
      id: 'market_closed'
      doc: 'MarketClosed'
    63:
      id: 'market_suspended'
      doc: 'MarketSuspended'
    64:
      id: 'invalid_ioc_for_non_continuous'
      doc: 'InvalidIOCForNonContinuous'
    65:
      id: 'limit_up_limit_down'
      doc: 'LimitUpLimitDown'
    66:
      id: 'invalid_risk_control_status'
      doc: 'InvalidRiskControlStatus'
    67:
      id: 'invalid_time_limit'
      doc: 'InvalidTimeLimit'
    68:
      id: 'invalid_percentage_limit'
      doc: 'InvalidPercentageLimit'
    69:
      id: 'invalid_count_limit'
      doc: 'InvalidCountLimit'
    70:
      id: 'invalid_ioc_attribution'
      doc: 'InvalidIOCAttribution'
    71:
      id: 'cancel_remaining_ioc'
      doc: 'CancelRemainingIOC'
    72:
      id: 'no_market_for_market_order'
      doc: 'NoMarketForMarketOrder'
    73:
      id: 'grmp_block'
      doc: 'GrmpBlock'
    74:
      id: 'fully_filled'
      doc: 'FullyFilled'
    75:
      id: 'invalid_auction_id'
      doc: 'InvalidAuctionId'
    76:
      id: 'invalid_response_order_qty'
      doc: 'InvalidResponseOrderQty'
    77:
      id: 'sum_complete'
      doc: 'SUMComplete'
    78:
      id: 'limit_order_price_protection_breach'
      doc: 'LimitOrderPriceProtectionBreach'
    79:
      id: 'intrinsic_value_breach'
      doc: 'IntrinsicValueBreach'
    80:
      id: 'invalid_underlying_id'
      doc: 'InvalidUnderlyingId'
    81:
      id: 'market_halt'
      doc: 'MarketHalt'
    82:
      id: 'market_order_max_notional_breach'
      doc: 'MarketOrderMaxNotionalBreach'
    83:
      id: 'invalid_target_party_id'
      doc: 'InvalidTargetPartyId'
    84:
      id: 'invalid_routing_firm_id'
      doc: 'InvalidRoutingFirmId'
    85:
      id: 'opening_process_cancel'
      doc: 'OpeningProcessCancel'
    86:
      id: 'quote_would_lock_cross'
      doc: 'QuoteWouldLockCross'
    87:
      id: 'invalid_clearing_firm'
      doc: 'InvalidClearingFirm'
    88:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdId'
    89:
      id: 'invalid_orig_cl_ord_id'
      doc: 'InvalidOrigClOrdId'
    90:
      id: 'unknown_orig_cl_ord_id'
      doc: 'UnknownOrigClOrdId'
    91:
      id: 'invalid_on_behalf_of_comp_id'
      doc: 'InvalidOnBehalfOfCompId'
    92:
      id: 'disallowed_market_orders'
      doc: 'DisallowedMarketOrders'
    93:
      id: 'disallowed_iso_ioc_orders'
      doc: 'DisallowedIsoIocOrders'
    94:
      id: 'disallowed_iso_day_orders'
      doc: 'DisallowedIsoDayOrders'
    95:
      id: 'restricted_symbol'
      doc: 'RestrictedSymbol'
    96:
      id: 'cancel_on_disconnect'
      doc: 'CancelOnDisconnect'
    97:
      id: 'invalid_send_time'
      doc: 'InvalidSendTime'
    98:
      id: 'invalid_cust_capacity_weight'
      doc: 'InvalidCustCapacityWeight'
    99:
      id: 'max_duplicative'
      doc: 'MaxDuplicative'
    100:
      id: 'mpid_blocked'
      doc: 'MPIDBlocked'
    101:
      id: 'quote_canceled'
      doc: 'QuoteCanceled'
    102:
      id: 'invalid_custom_group_id_count'
      doc: 'InvalidCustomGroupIdCount'
    103:
      id: 'grmp_trip'
      doc: 'GrmpTrip'
    104:
      id: 'max_qty_exceeded'
      doc: 'MaxQtyExceeded'
    105:
      id: 'max_notional_exceeded'
      doc: 'MaxNotionalExceeded'
    106:
      id: 'occ_identifier_not_configured'
      doc: 'OccIdentifierNotConfigured'
    107:
      id: 'arbitrage_breach'
      doc: 'ArbitrageBreach'
    108:
      id: 'abrc_breach'
      doc: 'ABRCBreach'
    109:
      id: 'admin_cancel'
      doc: 'AdminCancel'
    110:
      id: 'invalid_reserved'
      doc: 'InvalidReserved'
    111:
      id: 'nbbo_fade'
      doc: 'NBBOFade'
    112:
      id: 'locked_or_crossed_by_away'
      doc: 'LockedOrCrossedByAway'
    113:
      id: 'sum_timeout'
      doc: 'SUMTimeout'
    114:
      id: 'portal_cancel_external'
      doc: 'PortalCancelExternal'
    115:
      id: 'portal_cancel_internal'
      doc: 'PortalCancelInternal'
  trade_liquidity_indicator:
    1:
      id: 'added_liquidity'
      doc: 'AddedLiquidity'
    2:
      id: 'removed_liquidity'
      doc: 'RemovedLiquidity'
    3:
      id: 'routed'
      doc: 'Routed'
    4:
      id: 'opening_process'
      doc: 'OpeningProcess'
    5:
      id: 're_opening_process'
      doc: 'ReOpeningProcess'
    6:
      id: 'sum_initiating'
      doc: 'SUMInitiating'
    7:
      id: 'sum_response'
      doc: 'SUMResponse'
    8:
      id: 'sum_unrelated'
      doc: 'SUMUnrelated'
  contra_open_close:
    0:
      id: 'open'
      doc: 'Open'
    1:
      id: 'close'
      doc: 'Close'
    2:
      id: 'not_applicable'
      doc: 'NotApplicable'
  contra_customer_or_firm:
    0:
      id: 'customer'
      doc: 'Customer'
    1:
      id: 'firm'
      doc: 'Firm'
    2:
      id: 'broker_dealer'
      doc: 'BrokerDealer'
    3:
      id: 'market_maker'
      doc: 'MarketMaker'
    4:
      id: 'away_market_maker'
      doc: 'AwayMarketMaker'
    5:
      id: 'prof_customer'
      doc: 'ProfCustomer'
  bust_or_correction:
    0:
      id: 'trade_bust'
      doc: 'TradeBust'
    1:
      id: 'trade_correction'
      doc: 'TradeCorrection'
  reject_type:
    0:
      id: 'new_order_reject'
      doc: 'NewOrderReject'
    1:
      id: 'cancel_replace_request_reject'
      doc: 'CancelReplaceRequestReject'
    2:
      id: 'cancel_request_reject'
      doc: 'CancelRequestReject'
    3:
      id: 'mass_cancel_request_reject'
      doc: 'MassCancelRequestReject'
    4:
      id: 'new_bulk_quote_reject'
      doc: 'NewBulkQuoteReject'
    5:
      id: 'risk_limit_update_request_reject'
      doc: 'RiskLimitUpdateRequestReject'
    6:
      id: 'risk_action_request_reject'
      doc: 'RiskActionRequestReject'
    7:
      id: 'purge_request_reject'
      doc: 'PurgeRequestReject'
    8:
      id: 'new_ioc_quote_reject'
      doc: 'NewIocQuoteReject'
  throttle_indicator_optional:
    0:
      id: 'not_throttled'
      doc: 'NotThrottled'
    1:
      id: 'throttled'
      doc: 'Throttled'
  mpv_group:
    0:
      id: 'all_penny'
      doc: 'AllPenny'
    1:
      id: 'penny_nickel'
      doc: 'PennyNickel'
    2:
      id: 'nickel_dime'
      doc: 'NickelDime'
  option_type:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'
  closing_only:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  orp_enabled:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  mpid_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'inactive'
      doc: 'Inactive'
  allow_market_orders:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  allow_isoioc:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  allow_iso_day:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  appointment_type:
    1:
      id: 'registered_market_maker'
      doc: 'RegisteredMarketMaker'
    2:
      id: 'directed_market_maker'
      doc: 'DirectedMarketMaker'
    3:
      id: 'specialist'
      doc: 'Specialist'
  appointment_status:
    0:
      id: 'not_appointed'
      doc: 'NotAppointed'
    1:
      id: 'appointed'
      doc: 'Appointed'
  user_session_type:
    1:
      id: 'binary_order_entry'
      doc: 'BinaryOrderEntry'
    2:
      id: 'mm_quoting'
      doc: 'MMQuoting'
    3:
      id: 'purge'
      doc: 'Purge'
  user_session_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'inactive'
      doc: 'Inactive'
  cancel_on_disconnect:
    0:
      id: 'off_field'
      doc: 'Off'
    1:
      id: 'on_field'
      doc: 'On'
  order_unsolicited_ack_subscription:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  quote_unsolicited_ack_subscription:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  default_attributed_quote:
    1:
      id: 'sum'
      doc: 'Sum'
    2:
      id: 'order_info_capacity'
      doc: 'OrderInfo_Capacity'
    3:
      id: 'order_info_mpid'
      doc: 'OrderInfo_Mpid'
    4:
      id: 'order_info_capacity_mpid'
      doc: 'OrderInfo_Capacity_Mpid'
    5:
      id: 'do_not_use_sum'
      doc: 'DoNotUseSum'
  default_cancel_instead_of_slide:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  risk_ack_type:
    0:
      id: 'solicited'
      doc: 'Solicited'
    1:
      id: 'unsolicited'
      doc: 'Unsolicited'
  risk_action_optional:
    1:
      id: 'query_risk_control'
      doc: 'QueryRiskControl'
    2:
      id: 'unblock'
      doc: 'Unblock'
  blocked_by_breach_indicator:
    0:
      id: 'not_blocked'
      doc: 'NotBlocked'
    1:
      id: 'blocked'
      doc: 'Blocked'
  notification_reason:
    0:
      id: 'threshold_exceeded'
      doc: 'Threshold exceeded'
    1:
      id: 'check_failure'
      doc: 'Market Maker Arbitrage or Intrinsic Value Check Failure'

