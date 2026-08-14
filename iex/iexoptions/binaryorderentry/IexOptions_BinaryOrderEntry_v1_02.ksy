# ---------------------------------------------------------------------
# Kaitai struct definition for: Iex IexOptions BinaryOrderEntry Sbe v1.02
#
# Protocol:
#   Organization: Investors Exchange
#   Protocol: Binary Order Entry
#   Encoding: Simple Binary Encoding
#   Version: 1.02
#   Date: 6/1/2026
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: iex_iexoptions_binaryorderentry_sbe_v1_02
  title: Iex IexOptions BinaryOrderEntry Sbe v1.02
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Options Binary Order Entry Sbe v1.02'
doc-ref: https://www.iexexchange.io/options

seq:
  - id: sbe_message
    type: sbe_message_struct
    repeat: eos
    doc: 'Iex Options length-framed Sbe Message'

types:
  sbe_message_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Number of bytes after this field until the next packet'
      - id: message_header
        type: message_header
        doc: 'Iex Options Sbe message header — message identifiers and length of message root'
      - id: payload
        size: packet_length - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::new_order_single_message': new_order_single_message
            'template_id::order_cancel_replace_request_message': order_cancel_replace_request_message
            'template_id::order_cancel_request_message': order_cancel_request_message
            'template_id::new_bulk_quote_message': new_bulk_quote_message
            'template_id::mass_cancel_request_message': mass_cancel_request_message
            'template_id::purge_request_message': purge_request_message
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
            'template_id::risk_limit_update_request_message': risk_limit_update_request_message
            'template_id::risk_action_request_message': risk_action_request_message
            'template_id::underlying_ref_data_message': underlying_ref_data_message
            'template_id::instrument_ref_data_message': instrument_ref_data_message
            'template_id::mpid_configuration_acknowledgement_message': mpid_configuration_acknowledgement_message
            'template_id::market_maker_symbol_appointment_message': market_maker_symbol_appointment_message
            'template_id::session_configuration_acknowledgement_message': session_configuration_acknowledgement_message
            'template_id::risk_control_acknowledgment_message': risk_control_acknowledgment_message
            'template_id::risk_control_alert_message': risk_control_alert_message
            'template_id::sequenced_message_header_message': sequenced_message_header_message
            'template_id::subsession_join_message': subsession_join_message
            'template_id::subsession_join_response_message': subsession_join_response_message
            'template_id::subsession_leave_message': subsession_leave_message
            'template_id::subsession_leave_response_message': subsession_leave_response_message
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
        doc: 'Identifier of the schema publishing the message (10000 market data, 20000 session, 20001 order entry business)'
      - id: version
        type: u2
        doc: 'Schema version'
  new_order_single_message:
    seq:
      - id: account_account
        type: str
        size: 16
        encoding: ASCII
        doc: 'account'
      - id: instrument_id_instrument_id
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
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
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
      - id: cancel_instead_of_slide_cancel_instead_of_slide
        type: s1
        enum: cancel_instead_of_slide_cancel_instead_of_slide
        doc: 'cancelInsteadOfSlide'
      - id: display_inst
        type: s1
        enum: display_inst
        doc: 'displayInst'
      - id: exec_inst
        type: s1
        enum: exec_inst
        doc: 'execInst'
      - id: ord_type
        type: s1
        enum: ord_type
        doc: 'ordType'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'targetPartyId'
      - id: auction_id
        type: u4
        doc: 'auctionId'
      - id: clearing_firm
        type: u4
        doc: 'clearingFirm'
      - id: optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'optionalData'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'routingFirmId'
      - id: aiq
        type: str
        size: 3
        encoding: ASCII
        doc: 'aiq'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price_price_8
        type: decimal_s8_8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: order_qty_quantity_non_zero
        type: u4
        doc: 'orderQty'
  order_cancel_replace_request_message:
    seq:
      - id: account_account
        type: str
        size: 16
        encoding: ASCII
        doc: 'account'
      - id: instrument_id_instrument_id
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
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
      - id: orig_cl_ord_id
        type: u8
        doc: 'origClOrdId'
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
      - id: cancel_instead_of_slide_cancel_instead_of_slide_optional
        type: s1_nullable
        doc: 'cancelInsteadOfSlide. Nullable, No Value = 128'
      - id: display_inst
        type: s1
        enum: display_inst
        doc: 'displayInst'
      - id: exec_inst
        type: s1
        enum: exec_inst
        doc: 'execInst'
      - id: ord_type
        type: s1
        enum: ord_type
        doc: 'ordType'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'targetPartyId'
      - id: auction_id
        type: u4
        doc: 'auctionId'
      - id: clearing_firm
        type: u4
        doc: 'clearingFirm'
      - id: optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'optionalData'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'routingFirmId'
      - id: aiq
        type: str
        size: 3
        encoding: ASCII
        doc: 'aiq'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price_price_8
        type: decimal_s8_8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: order_qty_quantity_non_zero
        type: u4
        doc: 'orderQty'
  order_cancel_request_message:
    seq:
      - id: instrument_id_instrument_id
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
      - id: orig_cl_ord_id
        type: u8
        doc: 'origClOrdId'
  new_bulk_quote_message:
    seq:
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: custom_group_id_uint_16
        type: u2
        doc: 'customGroupId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
      - id: cancel_instead_of_slide_cancel_instead_of_slide_optional
        type: s1_nullable
        doc: 'cancelInsteadOfSlide. Nullable, No Value = 128'
      - id: send_time
        type: u8
        doc: 'sendTime'
      - id: aiq
        type: str
        size: 3
        encoding: ASCII
        doc: 'aiq'
      - id: time_in_force
        type: s1
        enum: time_in_force
        doc: 'timeInForce'
      - id: new_bulk_quote_message_quote_updates_groups
        type: new_bulk_quote_message_quote_updates_groups
        doc: 'quoteUpdates Block'
  new_bulk_quote_message_quote_updates_groups:
    seq:
      - id: quote_updates_group_encoding
        type: quote_updates_group_encoding
        doc: 'quoteUpdatesGroupEncoding'
      - id: new_bulk_quote_message_quote_updates_group
        type: new_bulk_quote_message_quote_updates_group
        repeat: expr
        repeat-expr: quote_updates_group_encoding.num_in_group
        doc: 'quoteUpdates'
  quote_updates_group_encoding:
    seq:
      - id: block_length_uint_8
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  new_bulk_quote_message_quote_updates_group:
    seq:
      - id: instrument_id_instrument_id
        type: u4
        doc: 'instrumentId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: price_price_4_optional
        type: decimal_s4_4_nullable
        doc: 'Order price. Implied decimal with scale 1e-4. Nullable, No Value = -2147483648'
      - id: order_qty_quantity_zero_optional
        type: u4_nullable
        doc: 'Order quantity. Nullable, No Value = 4294967295'
      - id: quote_type
        type: s1
        enum: quote_type
        doc: 'Type of quote'
      - id: reserved
        type: s1
        doc: 'Reserved for future use'
  mass_cancel_request_message:
    seq:
      - id: underlying_id_instrument_id_optional
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
      - id: send_time
        type: u8
        doc: 'sendTime'
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
  purge_request_message:
    seq:
      - id: underlying_id_instrument_id
        type: u4
        doc: 'underlyingId'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: send_time
        type: u8
        doc: 'sendTime'
      - id: ack_style_purge_request_ack_style
        type: u1
        enum: ack_style_purge_request_ack_style
        doc: 'ackStyle'
      - id: bulk_action
        type: u1
        enum: bulk_action
        doc: 'bulkAction'
      - id: purge_request_message_custom_group_ids_groups
        type: purge_request_message_custom_group_ids_groups
        doc: 'customGroupIds Block'
  purge_request_message_custom_group_ids_groups:
    seq:
      - id: custom_group_ids_group_encoding
        type: custom_group_ids_group_encoding
        doc: 'customGroupIdsGroupEncoding'
      - id: purge_request_message_custom_group_ids_group
        type: purge_request_message_custom_group_ids_group
        repeat: expr
        repeat-expr: custom_group_ids_group_encoding.num_in_group
        doc: 'customGroupIds'
  custom_group_ids_group_encoding:
    seq:
      - id: block_length_uint_8
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  purge_request_message_custom_group_ids_group:
    seq:
      - id: custom_group_id_uint_16
        type: u2
        doc: 'customGroupId'
  order_ack_message:
    seq:
      - id: account_account
        type: str
        size: 16
        encoding: ASCII
        doc: 'account'
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id_instrument_id
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
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
      - id: orig_cl_ord_id
        type: u8
        doc: 'origClOrdId'
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
      - id: cancel_instead_of_slide_cancel_instead_of_slide
        type: s1
        enum: cancel_instead_of_slide_cancel_instead_of_slide
        doc: 'cancelInsteadOfSlide'
      - id: display_inst
        type: s1
        enum: display_inst
        doc: 'displayInst'
      - id: exec_inst
        type: s1
        enum: exec_inst
        doc: 'execInst'
      - id: ord_type
        type: s1
        enum: ord_type
        doc: 'ordType'
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'targetPartyId'
      - id: auction_id
        type: u4
        doc: 'auctionId'
      - id: clearing_firm
        type: u4
        doc: 'clearingFirm'
      - id: optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'optionalData'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'routingFirmId'
      - id: aiq
        type: str
        size: 3
        encoding: ASCII
        doc: 'aiq'
      - id: side
        type: s1
        enum: side
        doc: 'side'
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
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
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
      - id: instrument_id_instrument_id
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
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
      - id: ack_type
        type: s1
        enum: ack_type
        doc: 'ackType'
  order_cancel_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id_instrument_id
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
      - id: orig_cl_ord_id
        type: u8
        doc: 'origClOrdId'
      - id: order_id
        type: u8
        doc: 'orderId'
      - id: price_price_8
        type: decimal_s8_8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u4
        doc: 'leavesQty'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
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
      - id: underlying_id_instrument_id_optional
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
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
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
      - id: custom_group_id_uint_16
        type: u2
        doc: 'customGroupId'
      - id: cl_ord_id
        type: u8
        doc: 'clOrdId'
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
      - id: aiq
        type: str
        size: 3
        encoding: ASCII
        doc: 'aiq'
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
      - id: block_length_uint_8
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  bulk_quote_ack_message_quote_acks_group:
    seq:
      - id: instrument_id_instrument_id
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
        doc: 'Order price. Implied decimal with scale 1e-4. Nullable, No Value = -2147483648'
      - id: order_qty_quantity_zero_optional
        type: u4_nullable
        doc: 'Order quantity. Nullable, No Value = 4294967295'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
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
        type: str
        size: 3
        encoding: ASCII
        doc: 'aiq'
      - id: instrument_id_instrument_id
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
      - id: price_price_4
        type: decimal_s4_4
        doc: 'price. Implied decimal with scale 1e-4'
      - id: order_qty_quantity_non_zero
        type: u4
        doc: 'orderQty'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  quote_restated_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id_instrument_id
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
      - id: price_price_8
        type: decimal_s8_8
        doc: 'price. Implied decimal with scale 1e-8'
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
        doc: 'delta'
  quote_canceled_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id_instrument_id
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
        doc: 'delta'
  purge_ack_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_instrument_id
        type: u4
        doc: 'underlyingId'
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
  purge_ack_message_custom_group_ids_group:
    seq:
      - id: custom_group_id_uint_16
        type: u2
        doc: 'customGroupId'
  execution_report_message:
    seq:
      - id: account_account
        type: str
        size: 16
        encoding: ASCII
        doc: 'account'
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: instrument_id_instrument_id
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
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'clearingAccount'
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
        type: str
        size: 4
        encoding: ASCII
        doc: 'targetPartyId'
      - id: auction_id
        type: u4
        doc: 'auctionId'
      - id: clearing_firm
        type: u4
        doc: 'clearingFirm'
      - id: optional_data
        type: str
        size: 16
        encoding: ASCII
        doc: 'optionalData'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'routingFirmId'
      - id: aiq
        type: str
        size: 3
        encoding: ASCII
        doc: 'aiq'
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
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
      - id: occ_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'occId'
      - id: contra_clearing_account
        type: str
        size: 4
        encoding: ASCII
        doc: 'contraClearingAccount'
      - id: contra_clearing_firm
        type: u4
        doc: 'contraClearingFirm'
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
      - id: instrument_id_instrument_id
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
      - id: trade_id
        type: u8
        doc: 'tradeId'
      - id: trade_ref_id
        type: u8
        doc: 'tradeRefId'
      - id: last_px
        type: decimal_s8_8
        doc: 'lastPx. Implied decimal with scale 1e-8'
      - id: account_account
        type: str
        size: 16
        encoding: ASCII
        doc: 'account'
      - id: last_qty
        type: u4
        doc: 'lastQty'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
      - id: bust_or_correction
        type: s1
        enum: bust_or_correction
        doc: 'bustOrCorrection'
  application_layer_reject_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_instrument_id
        type: u4
        doc: 'underlyingId'
      - id: instrument_id_instrument_id
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
      - id: account_string_16
        type: str
        size: 16
        encoding: ASCII
        doc: 'account'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'reasonCode'
      - id: reject_type
        type: s1
        enum: reject_type
        doc: 'rejectType'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  risk_limit_update_request_message:
    seq:
      - id: underlying_id_instrument_id_optional
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
      - id: risk_control_risk_control_optional
        type: s1_nullable
        doc: 'riskControl. Nullable, No Value = 128'
      - id: risk_control_status_risk_control_status_optional
        type: s1_nullable
        doc: 'riskControlStatus. Nullable, No Value = 128'
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
      - id: cust_capacity_weight_uint_8_optional
        type: u1_nullable
        doc: 'custCapacityWeight. Nullable, No Value = 255'
  risk_action_request_message:
    seq:
      - id: underlying_id_instrument_id_optional
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
      - id: risk_control_risk_control
        type: s1
        enum: risk_control_risk_control
        doc: 'riskControl'
      - id: risk_action
        type: s1
        enum: risk_action
        doc: 'riskAction'
      - id: custom_group_id_uint_16_optional
        type: u2_nullable
        doc: 'customGroupId. Nullable, No Value = 65535'
  underlying_ref_data_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_uint_32
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
      - id: instrument_id_uint_32
        type: u4
        doc: 'instrumentId'
      - id: underlying_id_uint_32
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
      - id: underlying_id_instrument_id
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
        type: u1
        enum: order_unsolicited_ack_subscription
        doc: 'orderUnsolicitedAckSubscription'
      - id: quote_unsolicited_ack_subscription
        type: u1
        enum: quote_unsolicited_ack_subscription
        doc: 'quoteUnsolicitedAckSubscription'
      - id: default_attributed_quote
        type: s1_nullable
        doc: 'defaultAttributedQuote. Nullable, No Value = 128'
      - id: default_cancel_instead_of_slide
        type: u1_nullable
        doc: 'defaultCancelInsteadOfSlide. Nullable, No Value = 255'
      - id: trading_ring
        type: s1
        doc: 'tradingRing'
  risk_control_acknowledgment_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_instrument_id_optional
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
      - id: custom_group_id_uint_16_optional
        type: u2_nullable
        doc: 'customGroupId. Nullable, No Value = 65535'
      - id: risk_ack_type
        type: s1
        enum: risk_ack_type
        doc: 'riskAckType'
      - id: risk_control_status_risk_control_status
        type: s1
        enum: risk_control_status_risk_control_status
        doc: 'riskControlStatus'
      - id: risk_control_risk_control
        type: s1
        enum: risk_control_risk_control
        doc: 'riskControl'
      - id: risk_action
        type: s1
        enum: risk_action
        doc: 'riskAction'
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
      - id: cust_capacity_weight_uint_8
        type: u1
        doc: 'custCapacityWeight'
      - id: throttle_indicator
        type: s1
        enum: throttle_indicator
        doc: 'throttleIndicator'
  risk_control_alert_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: underlying_id_instrument_id_optional
        type: u4_nullable
        doc: 'underlyingId. Nullable, No Value = 4294967295'
      - id: market_participant_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'marketParticipantId'
      - id: risk_control_risk_control
        type: s1
        enum: risk_control_risk_control
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
  login_request_message:
    seq:
      - id: logon_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'logonId'
      - id: token
        type: str
        size: 32
        encoding: ASCII
        doc: 'token'
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
      - id: gateway_heartbeat_message_sub_sessions_groups
        type: gateway_heartbeat_message_sub_sessions_groups
        doc: 'SubSessions Block'
  gateway_heartbeat_message_sub_sessions_groups:
    seq:
      - id: session_info_group_encoding
        type: session_info_group_encoding
        doc: 'sessionInfoGroupEncoding'
      - id: gateway_heartbeat_message_sub_sessions_group
        type: gateway_heartbeat_message_sub_sessions_group
        repeat: expr
        repeat-expr: session_info_group_encoding.num_in_group
        doc: 'SubSessions'
  session_info_group_encoding:
    seq:
      - id: block_length_uint_8
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  gateway_heartbeat_message_sub_sessions_group:
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
  subsession_join_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: start_sequence
        type: u4
        doc: 'startSequence'
      - id: end_sequence
        type: u4
        doc: 'endSequence'
  subsession_join_response_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: status
        type: u1
        enum: status
        doc: 'status'
  subsession_leave_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
  subsession_leave_response_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: reason
        type: u1
        enum: reason
        doc: 'reason'
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == -128
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  decimal_s8_8_nullable:
    seq:
      - id: value
        type: decimal_s8_8
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
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
  str_3_nullable:
    seq:
      - id: value
        size: 3
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0

enums:
  template_id:
    1:
      id: 'new_order_single_message'
      doc: 'NewOrderSingleMessage'
    2:
      id: 'order_cancel_replace_request_message'
      doc: 'OrderCancelReplaceRequestMessage'
    3:
      id: 'order_cancel_request_message'
      doc: 'OrderCancelRequestMessage'
    4:
      id: 'new_bulk_quote_message'
      doc: 'NewBulkQuoteMessage'
    5:
      id: 'mass_cancel_request_message'
      doc: 'MassCancelRequestMessage'
    6:
      id: 'purge_request_message'
      doc: 'PurgeRequestMessage'
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
  customer_or_firm:
    0:
      id: 'customer'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'firm'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'broker_dealer'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'market_maker'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'away_market_maker'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'prof_customer'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  open_close:
    0:
      id: 'open'
      doc: 'OpenClose Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'close'
      doc: 'OpenClose Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'not_applicable'
      doc: 'OpenClose Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  attributed_quote:
    1:
      id: 'sum'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'order_info_capacity'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_info_mpid'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'order_info_capacity_mpid'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'do_not_use_sum'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force:
    0:
      id: 'day'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'ioc'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_instead_of_slide_cancel_instead_of_slide:
    0:
      id: 'slide'
      doc: 'CancelInsteadOfSlide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel'
      doc: 'CancelInsteadOfSlide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  display_inst:
    1:
      id: 'post_only'
      doc: 'DisplayInst Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exec_inst:
    1:
      id: 'iso'
      doc: 'ExecInst Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'do_not_route'
      doc: 'ExecInst Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_type:
    1:
      id: 'market'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'limit'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    1:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_instead_of_slide_cancel_instead_of_slide_optional:
    0:
      id: 'slide'
      doc: 'CancelInsteadOfSlide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel'
      doc: 'CancelInsteadOfSlide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  quote_type:
    0:
      id: 'standard'
      doc: 'QuoteType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'reprice'
      doc: 'QuoteType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancel'
      doc: 'QuoteType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ack_style_mass_cancel_ack_style:
    0:
      id: 'single_ack'
      doc: 'MassCancelAckStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'per_order_ack_and_single_ack'
      doc: 'MassCancelAckStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mpid_filter:
    0:
      id: 'explicit_mpid'
      doc: 'MPIDFilter Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'across_mpi_ds'
      doc: 'MPIDFilter Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  bulk_action:
    0:
      id: 'cancel'
      doc: 'BulkAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_and_block'
      doc: 'BulkAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'unblock'
      doc: 'BulkAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ack_style_purge_request_ack_style:
    0:
      id: 'single_ack'
      doc: 'PurgeRequestAckStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'single_ack_with_mmqs'
      doc: 'PurgeRequestAckStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reason_code:
    1:
      id: 'unknown_instrument_identifier'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'invalid_ord_type'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'invalid_side'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'invalid_time_in_force'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_open_close'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'invalid_customer_or_firm'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'invalid_display_inst'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_attributed_quote'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_exec_inst'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'invalid_cancel_instead_of_slide'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'invalid_order_qty'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'closing_only'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'not_appointed'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'invalid_price'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'invalid_tag_combination_for_market_order'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'invalid_tag_combination_for_ioc'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'invalid_aiq'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'aiq_cancel_newest'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'aiq_cancel_oldest'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'aiq_cancel_smallest'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'aiq_cancel_both'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'no_order_found'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'order_in_pending_state'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'order_terminal'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'no_bid'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'no_offer'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'order_not_marketable'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'order_would_lock_cross'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'invalid_quote_count'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'inconsistent_underlying'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'duplicate_quote'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'invalid_quote_type'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'invalid_bulk_action'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'invalid_bulk_action_parameters'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'invalid_custom_group_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'blocked_underlying_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'order_will_be_canceled'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'invalid_ack_style'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'invalid_mpid_filter'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'invalid_block'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'invalid_risk_control'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    42:
      id: 'invalid_risk_action_type'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    43:
      id: 'invalid_unblock_parameters'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    44:
      id: 'invalid_cl_ord_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    45:
      id: 'invalid_market_participant_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    46:
      id: 'invalid_nbbo_width'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    47:
      id: 'missing_clearing_account'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    48:
      id: 'invalid_clearing_account'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    49:
      id: 'invalid_account'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    50:
      id: 'price_slide_cancel'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    51:
      id: 'constrained_by_drill_through_protection'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    52:
      id: 'invalid_optional_data'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    53:
      id: 'drill_through_protection_cancel'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    54:
      id: 'risk_breach'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    55:
      id: 'internal_error'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    56:
      id: 'blocked_custom_group_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    57:
      id: 'orp_reject'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    58:
      id: 'quote_not_found'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    59:
      id: 'too_late_to_cancel'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    60:
      id: 'invalid_orp_reprice_check'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    61:
      id: 'contra_mm_interest'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    62:
      id: 'market_closed'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    63:
      id: 'market_suspended'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    64:
      id: 'invalid_ioc_for_non_continuous'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65:
      id: 'limit_up_limit_down'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    66:
      id: 'invalid_risk_control_status'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    67:
      id: 'invalid_time_limit'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    68:
      id: 'invalid_percentage_limit'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    69:
      id: 'invalid_count_limit'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    70:
      id: 'invalid_ioc_attribution'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    71:
      id: 'cancel_remaining_ioc'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    72:
      id: 'no_market_for_market_order'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    73:
      id: 'grmp_block'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    74:
      id: 'fully_filled'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    75:
      id: 'invalid_auction_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    76:
      id: 'invalid_response_order_qty'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    77:
      id: 'sum_complete'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    78:
      id: 'limit_order_price_protection_breach'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    79:
      id: 'intrinsic_value_breach'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    80:
      id: 'invalid_underlying_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    81:
      id: 'market_halt'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    82:
      id: 'market_order_max_notional_breach'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    83:
      id: 'invalid_target_party_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    84:
      id: 'invalid_routing_firm_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    85:
      id: 'opening_process_cancel'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    86:
      id: 'quote_would_lock_cross'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    87:
      id: 'invalid_clearing_firm'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    88:
      id: 'duplicate_cl_ord_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    89:
      id: 'invalid_orig_cl_ord_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    90:
      id: 'unknown_orig_cl_ord_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    91:
      id: 'invalid_on_behalf_of_comp_id'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    92:
      id: 'disallowed_market_orders'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    93:
      id: 'disallowed_iso_ioc_orders'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    94:
      id: 'disallowed_iso_day_orders'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    95:
      id: 'restricted_symbol'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    96:
      id: 'cancel_on_disconnect'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    97:
      id: 'invalid_send_time'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    98:
      id: 'invalid_cust_capacity_weight'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'max_duplicative'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'mpid_blocked'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'quote_canceled'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'invalid_custom_group_id_count'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'grmp_trip'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'max_qty_exceeded'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'max_notional_exceeded'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'occ_identifier_not_configured'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'arbitrage_breach'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'abrc_breach'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'admin_cancel'
      doc: 'ReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ack_type:
    1:
      id: 'new_interest'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'pending_cancel'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'canceled'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'pending_replace'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'replaced'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'individual_market_maker_quote_reject'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'unsolicited_reprice_price_adjust'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'unsolicited_reprice_orp'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'unsolicited_cancel_orp'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'market_maker_quote_not_modified'
      doc: 'AckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  throttle_indicator:
    0:
      id: 'not_throttled'
      doc: 'ThrottleIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'throttled'
      doc: 'ThrottleIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  restatement_reason:
    1:
      id: 'price_adjust_repricing'
      doc: 'RestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'drill_through_protection_repricing'
      doc: 'RestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'trading_halt'
      doc: 'RestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'sum_conclusion'
      doc: 'RestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'book_resubmission'
      doc: 'RestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trade_liquidity_indicator:
    1:
      id: 'added_liquidity'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'removed_liquidity'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'routed'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'opening_process'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 're_opening_process'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'sum_initiating'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'sum_response'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'sum_unrelated'
      doc: 'TradeLiquidityIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  contra_open_close:
    0:
      id: 'open'
      doc: 'OpenClose Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'close'
      doc: 'OpenClose Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'not_applicable'
      doc: 'OpenClose Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  contra_customer_or_firm:
    0:
      id: 'customer'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'firm'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'broker_dealer'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'market_maker'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'away_market_maker'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'prof_customer'
      doc: 'CustomerOrFirm Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  bust_or_correction:
    0:
      id: 'trade_bust'
      doc: 'BustOrCorrection Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'trade_correction'
      doc: 'BustOrCorrection Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reject_type:
    0:
      id: 'new_order_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_replace_request_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancel_request_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'mass_cancel_request_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'new_bulk_quote_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'risk_limit_update_request_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'risk_action_request_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'purge_request_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'new_ioc_quote_reject'
      doc: 'RejectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  risk_control_risk_control_optional:
    1:
      id: 'transaction_based'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'volume_based'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'percentage_based'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'grmp'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'purge_lockout_reset'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'intrinsic_value_and_arbitrage'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  risk_control_status_risk_control_status_optional:
    0:
      id: 'disabled'
      doc: 'RiskControlStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'enabled'
      doc: 'RiskControlStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ioc_attribution:
    1:
      id: 'include_ioc'
      doc: 'IOCAttribution Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'exclude_ioc'
      doc: 'IOCAttribution Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  risk_control_risk_control:
    1:
      id: 'transaction_based'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'volume_based'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'percentage_based'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'grmp'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'purge_lockout_reset'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'intrinsic_value_and_arbitrage'
      doc: 'RiskControl Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  risk_action:
    1:
      id: 'query_risk_control'
      doc: 'RiskActionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'unblock'
      doc: 'RiskActionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mpv_group:
    0:
      id: 'all_penny'
      doc: 'MinimumPriceVariation Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'penny_nickel'
      doc: 'MinimumPriceVariation Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'nickel_dime'
      doc: 'MinimumPriceVariation Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  option_type:
    0:
      id: 'put'
      doc: 'OptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'call'
      doc: 'OptionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  closing_only:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  orp_enabled:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mpid_status:
    1:
      id: 'active'
      doc: 'MPIDStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'inactive'
      doc: 'MPIDStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  allow_market_orders:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  allow_isoioc:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  allow_iso_day:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  appointment_type:
    1:
      id: 'registered_market_maker'
      doc: 'AppointmentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'directed_market_maker'
      doc: 'AppointmentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'specialist'
      doc: 'AppointmentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  appointment_status:
    0:
      id: 'not_appointed'
      doc: 'AppointmentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'appointed'
      doc: 'AppointmentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  user_session_type:
    1:
      id: 'binary_order_entry'
      doc: 'ClientSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'mm_quoting'
      doc: 'ClientSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'purge'
      doc: 'ClientSessionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  user_session_status:
    1:
      id: 'active'
      doc: 'UserSessionStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'inactive'
      doc: 'UserSessionStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_on_disconnect:
    0:
      id: 'off_field'
      doc: 'CancelOnDisconnect Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'on_field'
      doc: 'CancelOnDisconnect Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_unsolicited_ack_subscription:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  quote_unsolicited_ack_subscription:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  default_attributed_quote:
    1:
      id: 'sum'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'order_info_capacity'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_info_mpid'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'order_info_capacity_mpid'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'do_not_use_sum'
      doc: 'AttributedQuote Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  default_cancel_instead_of_slide:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  risk_ack_type:
    0:
      id: 'solicited'
      doc: 'RiskAckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'unsolicited'
      doc: 'RiskAckType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  risk_control_status_risk_control_status:
    0:
      id: 'disabled'
      doc: 'RiskControlStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'enabled'
      doc: 'RiskControlStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  blocked_by_breach_indicator:
    0:
      id: 'not_blocked'
      doc: 'BlockedByBreachIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'blocked'
      doc: 'BlockedByBreachIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  notification_reason:
    0:
      id: 'threshold_exceeded'
      doc: 'NotificationReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'check_failure'
      doc: 'NotificationReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  status:
    0:
      id: 'success'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'session_level_reject'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'logout_requested'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'unknown'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'invalid_logon_id'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_token'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'already_logged_in'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'login_timeout'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_packet_length'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_message'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'join_revoked'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'heartbeat_timeout'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'message_out_of_sequence'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'invalid_subsession_id'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'subsession_not_joined'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'denial_of_service'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'invalid_argument'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'already_joined'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  keep_alive:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  subsession_type:
    0:
      id: 'client_to_gateway'
      doc: 'Subsession Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'gateway_to_client'
      doc: 'Subsession Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'reference_data'
      doc: 'Subsession Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  joined:
    0:
      id: 'false_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reason:
    0:
      id: 'success'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'session_level_reject'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'logout_requested'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'unknown'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'invalid_logon_id'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_token'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'already_logged_in'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'login_timeout'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_packet_length'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_message'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'join_revoked'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'heartbeat_timeout'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'message_out_of_sequence'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'invalid_subsession_id'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'subsession_not_joined'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'denial_of_service'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'invalid_argument'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'already_joined'
      doc: 'Status Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

