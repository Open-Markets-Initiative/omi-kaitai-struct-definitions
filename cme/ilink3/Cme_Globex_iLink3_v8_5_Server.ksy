# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex iLink3 Sbe v8.5
#
# Protocol:
#   Organization: CME Group
#   Protocol: iLink 3
#   Encoding: Simple Binary Encoding
#   Version: 8.5
#   Date: 02/27/2020
#   Specification: Unknown
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
  id: cme_globex_ilink3_sbe_v8_5_server
  title: Cme Globex iLink3 Sbe v8.5
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex iLink 3 Sbe v8.5'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/iLink+3+-+Simple+Binary+Encoding

seq:
  - id: server_simple_open_frame
    type: server_simple_open_frame_struct
    repeat: eos
    doc: 'Simple Open Frame sent by Cme to the firm'

types:
  server_simple_open_frame_struct:
    seq:
      - id: simple_open_framing_header
        type: simple_open_framing_header
        doc: 'Simple Open Framing Header'
      - id: message_header
        type: message_header
        doc: 'Template ID and length of message root'
      - id: server_payload
        size: simple_open_framing_header.message_length - 12
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::negotiation_response': negotiation_response
            'template_id::negotiation_reject': negotiation_reject
            'template_id::establishment_ack': establishment_ack
            'template_id::establishment_reject': establishment_reject
            'template_id::sequence': sequence
            'template_id::terminate': terminate
            'template_id::retransmission': retransmission
            'template_id::retransmit_reject': retransmit_reject
            'template_id::not_applied': not_applied
            'template_id::party_details_definition_request_ack': party_details_definition_request_ack
            'template_id::business_reject': business_reject
            'template_id::execution_report_new': execution_report_new
            'template_id::execution_report_reject': execution_report_reject
            'template_id::execution_report_elimination': execution_report_elimination
            'template_id::execution_report_trade_outright': execution_report_trade_outright
            'template_id::execution_report_trade_spread': execution_report_trade_spread
            'template_id::execution_report_trade_spread_leg': execution_report_trade_spread_leg
            'template_id::execution_report_modify': execution_report_modify
            'template_id::execution_report_status': execution_report_status
            'template_id::execution_report_cancel': execution_report_cancel
            'template_id::order_cancel_reject': order_cancel_reject
            'template_id::order_cancel_replace_reject': order_cancel_replace_reject
            'template_id::party_details_list_report': party_details_list_report
            'template_id::execution_ack': execution_ack
            'template_id::mass_quote_ack': mass_quote_ack
            'template_id::request_for_quote_ack': request_for_quote_ack
            'template_id::execution_report_trade_addendum_outright': execution_report_trade_addendum_outright
            'template_id::execution_report_trade_addendum_spread': execution_report_trade_addendum_spread
            'template_id::execution_report_trade_addendum_spread_leg': execution_report_trade_addendum_spread_leg
            'template_id::security_definition_response': security_definition_response
            'template_id::order_mass_action_report': order_mass_action_report
            'template_id::quote_cancel_ack': quote_cancel_ack
  simple_open_framing_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Message Length'
      - id: encoding_type
        type: u2
        doc: 'Encoding Type'
  message_header:
    seq:
      - id: block_length
        type: u2
      - id: template_id
        type: u2
        enum: template_id
      - id: schema_id
        type: u2
      - id: version
        type: u2
  negotiation_response:
    seq:
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request; recommended to use timestamp as number of nanoseconds since epoch (Jan 1, 1970). Nanoseconds since Unix epoch'
      - id: secret_key_secure_id_expiration
        type: u2_nullable
        doc: 'This indicates in how many days the HMAC secret key will expire. Nullable, No Value = 65535'
      - id: fault_tolerance_indicator
        type: u1_nullable
        doc: 'Indicates whether the connection is primary or backup. Nullable, No Value = 255'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: previous_seq_no
        type: u4
        doc: 'Refers to the SeqNum sent in the previous message before this one from CME'
      - id: previous_uuid
        type: u8
        doc: 'Refers to the UUID sent in the previous message before this one from CME'
      - id: credentials
        type: credentials
        doc: 'Not used and will be set to 0'
  credentials:
    seq:
      - id: len_credentials_data
        type: u2
        doc: 'Length Field'
      - id: credentials_data
        size: len_credentials_data
        if: len_credentials_data > 0
        doc: 'Variable Length Data'
  negotiation_reject:
    seq:
      - id: reason
        type: str
        size: 48
        encoding: ASCII
        doc: 'Reject reason details'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request; recommended to use timestamp as number of nanoseconds since epoch (Jan 1, 1970). Nanoseconds since Unix epoch'
      - id: error_codes
        type: u2
        doc: 'Error code for reject reason'
      - id: fault_tolerance_indicator
        type: u1_nullable
        doc: 'Indicates whether the connection is primary or backup. Nullable, No Value = 255'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  establishment_ack:
    seq:
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request; recommended to use timestamp as number of nanoseconds since epoch (Jan 1, 1970). Nanoseconds since Unix epoch'
      - id: next_seq_no
        type: u4
        doc: 'Next expected message sequence number'
      - id: previous_seq_no
        type: u4
        doc: 'Refers to the SeqNum sent in the previous message before this one from CME'
      - id: previous_uuid
        type: u8
        doc: 'Refers to the UUID sent in the previous message before this one from CME'
      - id: keep_alive_interval
        type: u2
        doc: 'The longest time in milliseconds the customer or CME could remain silent before sending a keep alive message'
      - id: secret_key_secure_id_expiration
        type: u2_nullable
        doc: 'This indicates in how many days the HMAC secret key will expire. Nullable, No Value = 65535'
      - id: fault_tolerance_indicator
        type: u1_nullable
        doc: 'Indicates whether the connection is primary or backup. Nullable, No Value = 255'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  establishment_reject:
    seq:
      - id: reason
        type: str
        size: 48
        encoding: ASCII
        doc: 'Reject reason details'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request; recommended to use timestamp as number of nanoseconds since epoch (Jan 1, 1970). Nanoseconds since Unix epoch'
      - id: next_seq_no
        type: u4
        doc: 'Next expected message sequence number'
      - id: error_codes
        type: u2
        doc: 'Error code for reject reason'
      - id: fault_tolerance_indicator
        type: u1_nullable
        doc: 'Indicates whether the connection is primary or backup. Nullable, No Value = 255'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  sequence:
    seq:
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: next_seq_no
        type: u4
        doc: 'Next expected message sequence number'
      - id: fault_tolerance_indicator
        type: u1_nullable
        doc: 'Indicates whether the connection is primary or backup. Nullable, No Value = 255'
      - id: keep_alive_interval_lapsed
        type: u1
        enum: keep_alive_interval_lapsed
        doc: 'This indicates if the Sequence message being sent by CME is to warn that one keep alive interval has lapsed without any message received from customer (this can also be sent from customer to CME)'
  terminate:
    seq:
      - id: reason
        type: str
        size: 48
        encoding: ASCII
        doc: 'Reject reason details'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request; recommended to use timestamp as number of nanoseconds since epoch (Jan 1, 1970). Nanoseconds since Unix epoch'
      - id: error_codes
        type: u2
        doc: 'Error code for reject reason'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  retransmission:
    seq:
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: last_uuid
        type: u8_nullable
        doc: 'If RetransmitRequest is for a previous UUID then put that here otherwise put default null value. Nullable, No Value = 18446744073709551615'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request; recommended to use timestamp as number of nanoseconds since epoch (Jan 1, 1970). Nanoseconds since Unix epoch'
      - id: from_seq_no
        type: u4
        doc: 'Sequence number of the first business message requested. This should not be greater than the latest sequence number from CME'
      - id: msg_count_16
        type: u2
        doc: 'Count of business messages requested'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  retransmit_reject:
    seq:
      - id: reason
        type: str
        size: 48
        encoding: ASCII
        doc: 'Reject reason details'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: last_uuid
        type: u8_nullable
        doc: 'If RetransmitRequest is for a previous UUID then put that here otherwise put default null value. Nullable, No Value = 18446744073709551615'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request; recommended to use timestamp as number of nanoseconds since epoch (Jan 1, 1970). Nanoseconds since Unix epoch'
      - id: error_codes
        type: u2
        doc: 'Error code for reject reason'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  not_applied:
    seq:
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: from_seq_no
        type: u4
        doc: 'Sequence number of the first business message requested. This should not be greater than the latest sequence number from CME'
      - id: msg_count
        type: u4
        doc: 'Count of how many messages have not been applied'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  party_details_definition_request_ack:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: memo
        type: str
        size: 75
        encoding: ASCII
        doc: 'This general purpose text field could be mapped from iLink to Clearing STP for trades. Not available for use with the short format where PartyDetailsListRequestID not equal to FFFFFFFF. Available for use only with the long format where PartyDetailsListRequestID=FFFFFFFF'
      - id: avg_px_group_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Used by submitting firm to group trades being allocated into an average price group. The trades in average price group will be used to calculate an average price for the group'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: self_match_prevention_id
        type: u8_nullable
        doc: 'Identifies an order or trade that should not be matched to an opposite order or trade if both buy and sell orders for the same asset contain the same SelfMatchPreventionID (2362) and submitted by the same firm. Nullable, No Value = 18446744073709551615'
      - id: party_detail_request_status
        type: u1
        doc: 'Status of party details definition request'
      - id: cust_order_capacity
        type: u1_nullable
        doc: 'Capacity of customer placing the order. Used by futures exchanges to indicate the CTICode (customer type indicator) as required by the US CFTC (Commodity Futures Trading Commission). Nullable, No Value = 255'
      - id: clearing_account_type
        type: u1_nullable
        doc: 'Designates the account type to be used for the order when submitted to clearing. Nullable, No Value = 255'
      - id: self_match_prevention_instruction
        type: u1
        enum: self_match_prevention_instruction
        doc: 'Used to act upon the outcome when a self-match is detected and an order is prevented from trading against another order with the same SelfMatchPreventionID (Tag 2362). 1=Cancel newest signifies that incoming order is cancelled. 2=Cancel Oldest signifies that the resting order is cancelled. Absence of this field (with Tag 2362) is interpreted as cancel oldest'
      - id: avg_px_indicator
        type: u1_nullable
        doc: 'Average pricing indicator. Nullable, No Value = 255'
      - id: clearing_trade_price_type
        type: u1_nullable
        doc: 'Indicates to recipient whether trade is clearing at execution prices LastPx (tag 31) or alternate clearing price (prior day settlement price). Nullable, No Value = 255'
      - id: cmta_giveup_cd
        type: u1
        enum: cmta_giveup_cd
        doc: 'Indicates if the order is a give-up or SGX offset. Reject if greater than max length or not containing valid value'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'Codes that apply special information that the Broker / Dealer needs to report, as specified by the customer. Defines source of the order'
      - id: list_update_action
        type: u1
        enum: list_update_action
        doc: 'Indicates if all of the information sent in this message with a unique new PartyDetailsListRequestID is a new addition or deletion of existing information associated with an existing PartyDetailsListRequestID. For PartyDetailsListRequestID=FFFFFFFF this should always be set to "A"'
      - id: party_detail_definition_status
        type: u1
        doc: 'Status of party detail definition for one party'
      - id: executor
        type: u8_nullable
        doc: 'Will be populated with a short code for the person or algo identified in FIX tag 5392 which will be mapped to National ID or Algo at reporting time. Applicable for EU fixed income markets only. Nullable, No Value = 18446744073709551615'
      - id: idm_short_code
        type: u8_nullable
        doc: 'Represents the Investment Decision Maker Short Code. Applicable for EU fixed income markets only. Nullable, No Value = 18446744073709551615'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: party_details_groups
        type: party_details_groups
        doc: 'NoPartyDetails Block'
      - id: trd_reg_publications_groups
        type: trd_reg_publications_groups
        doc: 'NoTrdRegPublications Block'
  party_details_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: party_details_group
        type: party_details_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of party details. More than one occurrence of the same party role is not allowed and will be rejected'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  party_details_group:
    seq:
      - id: party_detail_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The identification of the party. Required when NoPartyDetails(1671) > 0'
      - id: party_detail_role
        type: u2
        enum: party_detail_role
        doc: 'Identifies the type of PartyDetailID. Required when NoPartyDetails(1671) > 0'
  trd_reg_publications_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trd_reg_publications_group
        type: trd_reg_publications_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of regulatory publication rules in repeating group. Should always be "1" if being used otherwise set to 0'
  trd_reg_publications_group:
    seq:
      - id: trd_reg_publication_type
        type: u1
        doc: 'Specifies the type of regulatory trade publication. Additional reasons for the publication type will be specified in TrdRegPublicationReason (2670). 2=Exempt from Publication. There are allowable exemptions for the post-trade publication of trade transactions'
      - id: trd_reg_publication_reason
        type: u1
        doc: 'Additional reason for trade publication type specified in TrdRegPublicationType (2669). Reasons may be specific to regulatory trade publication rules. 12=Exempted due to European System of Central Banks (ESCB) policy transaction'
  business_reject:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: sender_id_optional
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: party_details_list_req_id_optional
        type: u8_nullable
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message. Nullable, No Value = 18446744073709551615'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: business_reject_ref_id
        type: u8_nullable
        doc: 'The value of the business-level ID field on the message being referenced. Required unless the corresponding ID field was not specified. Nullable, No Value = 18446744073709551615'
      - id: location_optional
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: ref_seq_num
        type: u4_nullable
        doc: 'Tag 9726 - SeqNum of the rejected message. Nullable, No Value = 4294967295'
      - id: ref_tag_id
        type: u2_nullable
        doc: 'The tag number of the FIX/FIXP field being referenced which is invalid. Nullable, No Value = 65535'
      - id: business_reject_reason
        type: u2
        doc: 'Code to identify reason for a Business Message Reject message'
      - id: ref_msg_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'The MsgType of the FIX message being referenced'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: manual_order_indicator_optional
        type: u1_nullable
        doc: 'Indicates if order was sent manually or generated by automated trading logi. Nullable, No Value = 255'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
  execution_report_new:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price
        type: decimal_s8_9
        doc: 'Price per share or contract. Implied decimal with scale 1e-9'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'The quantity to be displayed . Required for iceberg orders. On orders specifies the qty to be displayed, on execution reports the currently displayed quantity. Nullable, No Value = 4294967295'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
  exec_inst:
    seq:
      - id: aon
        type: b1
        doc: 'AON'
      - id: ob
        type: b1
        doc: 'OB'
      - id: nh
        type: b1
        doc: 'NH'
      - id: reserved_1
        type: b1
        doc: 'Reserved1'
      - id: reserved_2
        type: b1
        doc: 'Reserved2'
      - id: reserved_3
        type: b1
        doc: 'Reserved3'
      - id: reserved_4
        type: b1
        doc: 'Reserved4'
      - id: reserved_5
        type: b1
        doc: 'Reserved5'
  execution_report_reject:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price_optional
        type: decimal_s8_9_nullable
        doc: 'Price per share or contract. Conditionally required if the order type requires a price (not market orders). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'The quantity to be displayed . Required for iceberg orders. On orders specifies the qty to be displayed, on execution reports the currently displayed quantity. Nullable, No Value = 4294967295'
      - id: ord_rej_reason
        type: u2
        doc: 'Code to identify reason for order rejection'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
  execution_report_elimination:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price
        type: decimal_s8_9
        doc: 'Price per share or contract. Implied decimal with scale 1e-9'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'The quantity to be displayed . Required for iceberg orders. On orders specifies the qty to be displayed, on execution reports the currently displayed quantity. Nullable, No Value = 4294967295'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
  execution_report_trade_outright:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: last_px
        type: decimal_s8_9
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-9'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price
        type: decimal_s8_9
        doc: 'Price per share or contract. Implied decimal with scale 1e-9'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: sec_exec_id
        type: u8
        doc: 'Unique identifier that allows linking id spread summary fill notice with leg fill notice and trade cancel messages'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: last_qty
        type: u4
        doc: 'Quantity of shares bought/sold on this (last) fill'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: md_trade_entry_id
        type: u4
        doc: 'Market Data Trade Entry ID. This identifier is assigned to all trades that take place for an instrument at a particular price level'
      - id: side_trade_id
        type: u4
        doc: 'The unique ID assigned to the trade once it is received or matched by the exchange'
      - id: trade_link_id
        type: u4_nullable
        doc: 'Contains the workup ID; unique per instrument per day. Nullable, No Value = 4294967295'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution; LeavesQty = OrderQty (38) - CumQty (14); Only present for outrights and spreads and not spread legs'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trading day (expressed in local time at place of trade). Nullable, No Value = 65535'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: ord_status_trd
        type: u1
        enum: ord_status_trd
        doc: 'Identifies status of order as partially filled or completely filled'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Indicates if order was incoming or resting for the match event'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: ownership
        type: u1
        doc: 'Specifies the owner of the work up private phase'
      - id: fills_groups
        type: fills_groups
        doc: 'NoFills Block'
      - id: outright_order_events_groups
        type: outright_order_events_groups
        doc: 'NoOrderEvents Block'
  fills_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: fills_group
        type: fills_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Specifies the number of fill reasons included in this Execution Report'
  fills_group:
    seq:
      - id: fill_px
        type: decimal_s8_9
        doc: 'Price of this fill reason or allocation. Required if NoFills(1362) > 0. Same as LastPx(31). Implied decimal with scale 1e-9'
      - id: fill_qty
        type: u4
        doc: 'Quantity bought/sold for this fill reason'
      - id: fill_exec_id
        type: str
        size: 2
        encoding: ASCII
        doc: 'Used as an identifier for each fill reason or allocation reported in single Execution Report. Required if NoFills(1362) > 0. Append FillExecID with ExecID to derive unique identifier for each fill reason or allocation'
      - id: fill_yield_type
        type: u1
        doc: 'Enumeration of the Fill Reason field using Integer. This identifies the type of match algorithm'
  outright_order_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: outright_order_events_group
        type: outright_order_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of fills which comprise fill quantity'
  outright_order_events_group:
    seq:
      - id: order_event_px
        type: decimal_s8_9
        doc: 'Refers to the fill price; same as LastPx (Tag 31). Implied decimal with scale 1e-9'
      - id: order_event_text
        type: str
        size: 5
        encoding: ASCII
        doc: 'Will not be present for BrokerTec US; Will be populated with the firm ID of the opposite order for BrokerTec EU bilateral trades'
      - id: order_event_exec_id
        type: u4
        doc: 'This is a unique ID which ties together a specific fill between two orders; It will be unique per instrument per day'
      - id: order_event_qty
        type: u4
        doc: 'Refers to the specific fill quantity between this order and the opposite order'
      - id: order_event_type
        type: u1_nullable
        doc: 'The type of event affecting an order. Nullable, No Value = 255'
      - id: order_event_reason
        type: u1
        doc: 'Action that caused the event to ocurr. 100=Binary Trade Reporting'
  execution_report_trade_spread:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: last_px
        type: decimal_s8_9
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-9'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price
        type: decimal_s8_9
        doc: 'Price per share or contract. Implied decimal with scale 1e-9'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: sec_exec_id
        type: u8
        doc: 'Unique identifier that allows linking id spread summary fill notice with leg fill notice and trade cancel messages'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: last_qty
        type: u4
        doc: 'Quantity of shares bought/sold on this (last) fill'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: md_trade_entry_id
        type: u4
        doc: 'Market Data Trade Entry ID. This identifier is assigned to all trades that take place for an instrument at a particular price level'
      - id: side_trade_id
        type: u4
        doc: 'The unique ID assigned to the trade once it is received or matched by the exchange'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution; LeavesQty = OrderQty (38) - CumQty (14); Only present for outrights and spreads and not spread legs'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trading day (expressed in local time at place of trade). Nullable, No Value = 65535'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: ord_status_trd
        type: u1
        enum: ord_status_trd
        doc: 'Identifies status of order as partially filled or completely filled'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Indicates if order was incoming or resting for the match event'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: total_num_securities
        type: u1
        doc: 'Indicates total number of leg fills for the spread; Will represent total number of ExecutionReportTradeSpreadLeg messages sent for the spread and will be set to 0 when spread leg fills are consolidated with spread fill'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: fills_groups
        type: fills_groups
        doc: 'NoFills Block'
      - id: trade_legs_groups
        type: trade_legs_groups
        doc: 'NoLegs Block'
      - id: spread_order_events_groups
        type: spread_order_events_groups
        doc: 'NoOrderEvents Block'
  trade_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_legs_group
        type: trade_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of Leg executions; Will currently be set to 0 and in future will contain the leg fills for the spread when spread leg fills are consolidated with the spread fill as a single message'
  trade_legs_group:
    seq:
      - id: leg_exec_id
        type: u8
        doc: 'The ExecID (17) value corresponding to a trade leg'
      - id: leg_last_px
        type: decimal_s8_9
        doc: 'Execution price assigned to a leg of a multileg instrument. Implied decimal with scale 1e-9'
      - id: leg_security_id
        type: s4
        doc: 'Multileg instrument''s individual security''s SecurityID'
      - id: leg_trade_id
        type: u4
        doc: 'The TradeID value corresponding to a trade leg'
      - id: leg_last_qty
        type: u4
        doc: 'Fill quantity for the leg instrument'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of this individual leg of a multileg security'
  spread_order_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: spread_order_events_group
        type: spread_order_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of fills which comprise fill quantity'
  spread_order_events_group:
    seq:
      - id: order_event_px
        type: decimal_s8_9
        doc: 'Refers to the fill price; same as LastPx (Tag 31). Implied decimal with scale 1e-9'
      - id: order_event_text
        type: str
        size: 5
        encoding: ASCII
        doc: 'Will not be present for BrokerTec US; Will be populated with the firm ID of the opposite order for BrokerTec EU bilateral trades'
      - id: order_event_exec_id
        type: u4
        doc: 'This is a unique ID which ties together a specific fill between two orders; It will be unique per instrument per day'
      - id: order_event_qty
        type: u4
        doc: 'Refers to the specific fill quantity between this order and the opposite order'
      - id: order_event_type
        type: u1_nullable
        doc: 'The type of event affecting an order. Nullable, No Value = 255'
      - id: order_event_reason
        type: u1
        doc: 'Action that caused the event to ocurr. 100=Binary Trade Reporting'
  execution_report_trade_spread_leg:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: volatility
        type: volatility
        doc: 'ExecutionReportTradeSpreadLeg'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: last_px
        type: decimal_s8_9
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-9'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: underlying_px
        type: decimal_s8_9_nullable
        doc: 'Underlying price associated with a derivative instrument. Price for the future used in calculating the conversion of vol. to premium for the option. Only applicable for vol quoted option trades. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: sec_exec_id
        type: u8
        doc: 'Unique identifier that allows linking id spread summary fill notice with leg fill notice and trade cancel messages'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: option_delta
        type: option_delta
        doc: 'ExecutionReportTradeSpreadLeg'
      - id: time_to_expiration
        type: time_to_expiration
        doc: 'ExecutionReportTradeSpreadLeg'
      - id: risk_free_rate
        type: risk_free_rate
        doc: 'ExecutionReportTradeSpreadLeg'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: last_qty
        type: u4
        doc: 'Quantity of shares bought/sold on this (last) fill'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: side_trade_id
        type: u4
        doc: 'The unique ID assigned to the trade once it is received or matched by the exchange'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trading day (expressed in local time at place of trade). Nullable, No Value = 65535'
      - id: ord_status_trd
        type: u1
        enum: ord_status_trd
        doc: 'Identifies status of order as partially filled or completely filled'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: fills_groups
        type: fills_groups
        doc: 'NoFills Block'
      - id: spread_leg_order_events_groups
        type: spread_leg_order_events_groups
        doc: 'NoOrderEvents Block'
  volatility:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  option_delta:
    seq:
      - id: mantissa_32
        type: s4
        doc: 'mantissa. Nullable, No Value = 2147483647'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa_32 * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  time_to_expiration:
    seq:
      - id: mantissa_32
        type: s4
        doc: 'mantissa. Nullable, No Value = 2147483647'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa_32 * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  risk_free_rate:
    seq:
      - id: mantissa_32
        type: s4
        doc: 'mantissa. Nullable, No Value = 2147483647'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa_32 * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  spread_leg_order_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: spread_leg_order_events_group
        type: spread_leg_order_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of fills which comprise fill quantity'
  spread_leg_order_events_group:
    seq:
      - id: order_event_px
        type: decimal_s8_9
        doc: 'Refers to the fill price; same as LastPx (Tag 31). Implied decimal with scale 1e-9'
      - id: order_event_text
        type: str
        size: 5
        encoding: ASCII
        doc: 'Will not be present for BrokerTec US; Will be populated with the firm ID of the opposite order for BrokerTec EU bilateral trades'
      - id: order_event_exec_id
        type: u4
        doc: 'This is a unique ID which ties together a specific fill between two orders; It will be unique per instrument per day'
      - id: order_event_qty
        type: u4
        doc: 'Refers to the specific fill quantity between this order and the opposite order'
      - id: order_event_type
        type: u1_nullable
        doc: 'The type of event affecting an order. Nullable, No Value = 255'
      - id: order_event_reason
        type: u1
        doc: 'Action that caused the event to ocurr. 100=Binary Trade Reporting'
  execution_report_modify:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price
        type: decimal_s8_9
        doc: 'Price per share or contract. Implied decimal with scale 1e-9'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution; LeavesQty = OrderQty (38) - CumQty (14); Only present for outrights and spreads and not spread legs'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'The quantity to be displayed . Required for iceberg orders. On orders specifies the qty to be displayed, on execution reports the currently displayed quantity. Nullable, No Value = 4294967295'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
  execution_report_status:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price_optional
        type: decimal_s8_9_nullable
        doc: 'Price per share or contract. Conditionally required if the order type requires a price (not market orders). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: ord_status_req_id_optional
        type: u8_nullable
        doc: 'Used to uniquely identify a specific Order Status Request message. Nullable, No Value = 18446744073709551615'
      - id: mass_status_req_id_optional
        type: u8_nullable
        doc: 'Unique ID of Order Mass Status Request as assigned by the client system. Nullable, No Value = 18446744073709551615'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution; LeavesQty = OrderQty (38) - CumQty (14); Only present for outrights and spreads and not spread legs'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'The quantity to be displayed . Required for iceberg orders. On orders specifies the qty to be displayed, on execution reports the currently displayed quantity. Nullable, No Value = 4294967295'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Identifies status of order'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: last_rpt_requested
        type: u1_nullable
        doc: 'Indicates whether this message is the last report message in response to an Order Mass Status Request. Required if responding to a Order Mass Status Request. Nullable, No Value = 255'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
  execution_report_cancel:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: price
        type: decimal_s8_9
        doc: 'Price per share or contract. Implied decimal with scale 1e-9'
      - id: stop_px
        type: decimal_s8_9_nullable
        doc: 'The stop price of a stop protect or stop limit order. (Conditionally required if OrdType = 3 or 4). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: cross_id_optional
        type: u8_nullable
        doc: 'Identifier for a cross order. Will be present if execution report is in response to a cross order. Nullable, No Value = 18446744073709551615'
      - id: host_cross_id
        type: u8_nullable
        doc: 'Host assigned entity ID that can be used to reference all components of a cross; sides + strategy + legs. The HostCrossID will also be used to link together components of the cross order. For example, each individual execution report associated with the order will carry HostCrossID in order to tie them back together to the original cross order. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: order_qty
        type: u4
        doc: 'Number of shares or contracts ordered'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'The quantity to be displayed . Required for iceberg orders. On orders specifies the qty to be displayed, on execution reports the currently displayed quantity. Nullable, No Value = 4294967295'
      - id: expire_date
        type: u2_nullable
        doc: 'Date of order expiration (last day the order can trade), always expressed in terms of the local market date. Applicable only to GTD orders which expire at the end of the trading session specified. This has to be a future or current session date and cannot be in the past. Nullable, No Value = 65535'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Specifies how long the order remains in effect'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: exec_restatement_reason
        type: u1_nullable
        doc: 'Used to communicate unsolicited cancels. Nullable, No Value = 255'
      - id: cross_type
        type: u1_nullable
        doc: 'ype of cross being submitted to a market. (if in response to a cross order). Nullable, No Value = 255'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
  order_cancel_reject:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: cxl_rej_reason
        type: u2
        doc: 'Code to identify reason for cancel rejection'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
  order_cancel_replace_reject:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: cxl_rej_reason
        type: u2
        doc: 'Code to identify reason for cancel rejection'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
  party_details_list_report:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: avg_px_group_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Used by submitting firm to group trades being allocated into an average price group. The trades in average price group will be used to calculate an average price for the group'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: party_details_list_report_id
        type: u8
        doc: 'Refers to the unique identifier of the PartyDetailsListRequest(35=CF) message used to request this PartyDetailsListReport'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: self_match_prevention_id
        type: u8_nullable
        doc: 'Identifies an order or trade that should not be matched to an opposite order or trade if both buy and sell orders for the same asset contain the same SelfMatchPreventionID (2362) and submitted by the same firm. Nullable, No Value = 18446744073709551615'
      - id: tot_num_parties
        type: u2
        doc: 'Indicates total number of PartyDetailsListReports being returned in response to PartyDetailsListRequest'
      - id: request_result
        type: u1
        enum: request_result
        doc: 'Status of party details list request'
      - id: last_fragment
        type: u1
        enum: last_fragment
        doc: 'Indicates whether the message is the last message in a sequence of messages to support fragmentation'
      - id: cust_order_capacity
        type: u1_nullable
        doc: 'Capacity of customer placing the order. Used by futures exchanges to indicate the CTICode (customer type indicator) as required by the US CFTC (Commodity Futures Trading Commission). Nullable, No Value = 255'
      - id: clearing_account_type
        type: u1_nullable
        doc: 'Designates the account type to be used for the order when submitted to clearing. Nullable, No Value = 255'
      - id: self_match_prevention_instruction
        type: u1
        enum: self_match_prevention_instruction
        doc: 'Used to act upon the outcome when a self-match is detected and an order is prevented from trading against another order with the same SelfMatchPreventionID (Tag 2362). 1=Cancel newest signifies that incoming order is cancelled. 2=Cancel Oldest signifies that the resting order is cancelled. Absence of this field (with Tag 2362) is interpreted as cancel oldest'
      - id: avg_px_indicator
        type: u1_nullable
        doc: 'Average pricing indicator. Nullable, No Value = 255'
      - id: clearing_trade_price_type
        type: u1_nullable
        doc: 'Indicates to recipient whether trade is clearing at execution prices LastPx (tag 31) or alternate clearing price (prior day settlement price). Nullable, No Value = 255'
      - id: cmta_giveup_cd
        type: u1
        enum: cmta_giveup_cd
        doc: 'Indicates if the order is a give-up or SGX offset. Reject if greater than max length or not containing valid value'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        doc: 'Codes that apply special information that the Broker / Dealer needs to report, as specified by the customer. Defines source of the order'
      - id: executor
        type: u8_nullable
        doc: 'Will be populated with a short code for the person or algo identified in FIX tag 5392 which will be mapped to National ID or Algo at reporting time. Applicable for EU fixed income markets only. Nullable, No Value = 18446744073709551615'
      - id: idm_short_code
        type: u8_nullable
        doc: 'Represents the Investment Decision Maker Short Code. Applicable for EU fixed income markets only. Nullable, No Value = 18446744073709551615'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: party_details_groups
        type: party_details_groups
        doc: 'NoPartyDetails Block'
      - id: trd_reg_publications_groups
        type: trd_reg_publications_groups
        doc: 'NoTrdRegPublications Block'
  execution_ack:
    seq:
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: exec_ack_status
        type: u1
        enum: exec_ack_status
        doc: 'Indicates the status of the execution acknowledgement'
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: sec_exec_id
        type: u8
        doc: 'Unique identifier that allows linking id spread summary fill notice with leg fill notice and trade cancel messages'
      - id: last_px
        type: decimal_s8_9
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-9'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: last_qty
        type: u4
        doc: 'Quantity of shares bought/sold on this (last) fill'
      - id: dk_reason
        type: u1
        enum: dk_reason
        doc: 'Reason for execution rejection'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
  mass_quote_ack:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: request_time
        type: u8
        doc: 'Information carried on a response to convey the time (UTC) when the request was received by the MSGW application. UTC timestamps are sent in number of nanoseconds since the UNIX epoch with microsecond precision'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: quote_req_id_optional
        type: u8_nullable
        doc: 'Unique identifier for quote request being responded to. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: quote_id
        type: u4
        doc: 'Unique identifier for mass quote populated by the client system'
      - id: quote_reject_reason
        type: u2_nullable
        doc: 'Contains reason (error code) the corresponding MassQuote message has been rejected. When this tag is returned, all quotes in the corresponding Mass Quote message are rejected. Nullable, No Value = 65535'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: quote_ack_status
        type: u1
        enum: quote_ack_status
        doc: 'Identifies the status of the quote acknowledgement'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: no_processed_quotes
        type: u1
        doc: 'Number of quotes that have been accepted from the corresponding inbound message'
      - id: mm_protection_reset
        type: u1
        enum: mm_protection_reset
        doc: 'When market maker protection is triggered CME will not accept any new quotes from the market maker for that product group until it receives a mass quote message with the MMProtectionReset flag set to true'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: tot_no_quote_entries_optional
        type: u1_nullable
        doc: 'Total number of quotes for the quote set across all messages. Should be the sum of all NoQuoteEntries in each message that has repeating quotes that are part of the same quote set. Required if NoQuoteEntries > 0. Since fragmentation is not supported in practice this will always be equal to the value of NoQuoteEntries. Nullable, No Value = 255'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
      - id: quote_ack_entries_groups
        type: quote_ack_entries_groups
        doc: 'NoQuoteEntries Block'
  quote_ack_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: quote_ack_entries_group
        type: quote_ack_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'The number of quoute entries for a quote set'
  quote_ack_entries_group:
    seq:
      - id: quote_entry_id
        type: u4
        doc: 'Unique identifier for a quote. The QuoteEntryID stays with the quote as a static identifier even if the quote is updated. For fills this value is transposed into client order ID (tag 11)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: quote_set_id
        type: u2
        doc: 'Unique id for the Quote Set'
      - id: quote_entry_reject_reason
        type: u1
        doc: 'Reason (error code) quote has been rejected'
  request_for_quote_ack:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: exchange_quote_req_id
        type: str
        size: 17
        encoding: ASCII
        doc: 'CME Globex generated QuoteID'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: request_time
        type: u8
        doc: 'Information carried on a response to convey the time (UTC) when the request was received by the MSGW application. UTC timestamps are sent in number of nanoseconds since the UNIX epoch with microsecond precision'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: quote_req_id
        type: u8
        doc: 'Unique identifier for quote request message'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: quote_reject_reason
        type: u2_nullable
        doc: 'Contains reason (error code) the corresponding MassQuote message has been rejected. When this tag is returned, all quotes in the corresponding Mass Quote message are rejected. Nullable, No Value = 65535'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: quote_ack_status
        type: u1
        enum: quote_ack_status
        doc: 'Identifies the status of the quote acknowledgement'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
  execution_report_trade_addendum_outright:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: last_px
        type: decimal_s8_9
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-9'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: sec_exec_id
        type: u8
        doc: 'Unique identifier that allows linking id spread summary fill notice with leg fill notice and trade cancel messages'
      - id: orig_secondary_execution_id
        type: u8_nullable
        doc: 'Unique identifier of the fill which is being corrected. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: last_qty
        type: u4
        doc: 'Quantity of shares bought/sold on this (last) fill'
      - id: side_trade_id
        type: u4
        doc: 'The unique ID assigned to the trade once it is received or matched by the exchange'
      - id: orig_side_trade_id
        type: u4_nullable
        doc: 'Refers back to the unique ID assigned to the corrected trade. Nullable, No Value = 4294967295'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trading day (expressed in local time at place of trade). Nullable, No Value = 65535'
      - id: ord_status_trd_cxl
        type: u1
        enum: ord_status_trd_cxl
        doc: 'Identifies status of order as trade cancellation or correction'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Describes the specific ExecutionRpt as trade cancellation or correction'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: fills_groups
        type: fills_groups
        doc: 'NoFills Block'
      - id: outright_trade_events_groups
        type: outright_trade_events_groups
        doc: 'NoOrderEvents Block'
  outright_trade_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: outright_trade_events_group
        type: outright_trade_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of fills which comprise fill quantity'
  outright_trade_events_group:
    seq:
      - id: order_event_px
        type: decimal_s8_9
        doc: 'Refers to the fill price; same as LastPx (Tag 31). Implied decimal with scale 1e-9'
      - id: order_event_text
        type: str
        size: 5
        encoding: ASCII
        doc: 'Will not be present for BrokerTec US; Will be populated with the firm ID of the opposite order for BrokerTec EU bilateral trades'
      - id: order_event_exec_id
        type: u4
        doc: 'This is a unique ID which ties together a specific fill between two orders; It will be unique per instrument per day'
      - id: order_event_qty
        type: u4
        doc: 'Refers to the specific fill quantity between this order and the opposite order'
      - id: trade_addendum
        type: u1
        enum: trade_addendum
        doc: 'The type of event affecting an order'
      - id: order_event_reason
        type: u1
        doc: 'Action that caused the event to ocurr. 100=Binary Trade Reporting'
      - id: original_order_event_exec_id
        type: u4_nullable
        doc: 'Contains the previous OrderEventExecID value (Tag 1797) of the trade being adjusted or busted. Nullable, No Value = 4294967295'
  execution_report_trade_addendum_spread:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: last_px
        type: decimal_s8_9
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-9'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: sec_exec_id
        type: u8
        doc: 'Unique identifier that allows linking id spread summary fill notice with leg fill notice and trade cancel messages'
      - id: orig_secondary_execution_id
        type: u8_nullable
        doc: 'Unique identifier of the fill which is being corrected. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: md_trade_entry_id
        type: u4
        doc: 'Market Data Trade Entry ID. This identifier is assigned to all trades that take place for an instrument at a particular price level'
      - id: last_qty
        type: u4
        doc: 'Quantity of shares bought/sold on this (last) fill'
      - id: side_trade_id
        type: u4
        doc: 'The unique ID assigned to the trade once it is received or matched by the exchange'
      - id: orig_side_trade_id
        type: u4_nullable
        doc: 'Refers back to the unique ID assigned to the corrected trade. Nullable, No Value = 4294967295'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trading day (expressed in local time at place of trade). Nullable, No Value = 65535'
      - id: ord_status_trd_cxl
        type: u1
        enum: ord_status_trd_cxl
        doc: 'Identifies status of order as trade cancellation or correction'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Describes the specific ExecutionRpt as trade cancellation or correction'
      - id: ord_type_optional
        type: u1
        enum: ord_type_optional
        doc: 'Order type'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: total_num_securities
        type: u1
        doc: 'Indicates total number of leg fills for the spread; Will represent total number of ExecutionReportTradeSpreadLeg messages sent for the spread and will be set to 0 when spread leg fills are consolidated with spread fill'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInst bit set'
      - id: execution_mode
        type: u1
        enum: execution_mode
        doc: 'Identifies whether the order should be treated as passive (will not match when entered) or aggressive (could match when entered); default behavior when absent is aggressive'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: managed_order
        type: u1_nullable
        doc: 'Boolean: flags a managed order. Nullable, No Value = 255'
      - id: short_sale_type
        type: u1_nullable
        doc: 'Indicates the type of short sale. Will not be used for Buy orders but Sell orders should have this tag populated for MiFID. Nullable, No Value = 255'
      - id: fills_groups
        type: fills_groups
        doc: 'NoFills Block'
      - id: trade_addendum_legs_groups
        type: trade_addendum_legs_groups
        doc: 'NoLegs Block'
      - id: spread_trade_events_groups
        type: spread_trade_events_groups
        doc: 'NoOrderEvents Block'
  trade_addendum_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_addendum_legs_group
        type: trade_addendum_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of legs (repeating groups)'
  trade_addendum_legs_group:
    seq:
      - id: leg_exec_id
        type: u8
        doc: 'The ExecID (17) value corresponding to a trade leg'
      - id: leg_last_px
        type: decimal_s8_9
        doc: 'Execution price assigned to a leg of a multileg instrument. Implied decimal with scale 1e-9'
      - id: leg_exec_ref_id
        type: u8_nullable
        doc: 'The original ExecID(17) value corresponding to trade leg which is being corrected. Nullable, No Value = 18446744073709551615'
      - id: leg_trade_id
        type: u4
        doc: 'The TradeID value corresponding to a trade leg'
      - id: leg_trade_ref_id
        type: u4_nullable
        doc: 'Refers to the original LegTradeID of the leg trade being corrected. Nullable, No Value = 4294967295'
      - id: leg_security_id
        type: s4
        doc: 'Multileg instrument''s individual security''s SecurityID'
      - id: leg_last_qty
        type: u4
        doc: 'Fill quantity for the leg instrument'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of this individual leg of a multileg security'
  spread_trade_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: spread_trade_events_group
        type: spread_trade_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of fills which comprise fill quantity'
  spread_trade_events_group:
    seq:
      - id: order_event_px
        type: decimal_s8_9
        doc: 'Refers to the fill price; same as LastPx (Tag 31). Implied decimal with scale 1e-9'
      - id: order_event_text
        type: str
        size: 5
        encoding: ASCII
        doc: 'Will not be present for BrokerTec US; Will be populated with the firm ID of the opposite order for BrokerTec EU bilateral trades'
      - id: order_event_exec_id
        type: u4
        doc: 'This is a unique ID which ties together a specific fill between two orders; It will be unique per instrument per day'
      - id: order_event_qty
        type: u4
        doc: 'Refers to the specific fill quantity between this order and the opposite order'
      - id: trade_addendum
        type: u1
        enum: trade_addendum
        doc: 'The type of event affecting an order'
      - id: order_event_reason
        type: u1
        doc: 'Action that caused the event to ocurr. 100=Binary Trade Reporting'
      - id: original_order_event_exec_id
        type: u4_nullable
        doc: 'Contains the previous OrderEventExecID value (Tag 1797) of the trade being adjusted or busted. Nullable, No Value = 4294967295'
  execution_report_trade_addendum_spread_leg:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: exec_id
        type: str
        size: 40
        encoding: ASCII
        doc: 'Unique identifier of execution message as assigned by the exchange and is unique per day across all instruments and across all good till orders'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for Order as assigned by the buy-side (institution, broker, intermediary etc.). Uniqueness must be guaranteed within a single trading day. Firms, particularly those which electronically submit multi-day orders, trade globally or throughout market close periods, should ensure uniqueness across days, for example by embedding a date within the ClOrdID field'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: last_px
        type: decimal_s8_9
        doc: 'Price of this (last) fill. Implied decimal with scale 1e-9'
      - id: order_id
        type: u8
        doc: 'Unique identifier for order as assigned by the exchange. Uniqueness is guaranteed within a single trading day across all instruments'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: sec_exec_id
        type: u8
        doc: 'Unique identifier that allows linking id spread summary fill notice with leg fill notice and trade cancel messages'
      - id: orig_secondary_execution_id
        type: u8_nullable
        doc: 'Unique identifier of the fill which is being corrected. Nullable, No Value = 18446744073709551615'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: last_qty
        type: u4
        doc: 'Quantity of shares bought/sold on this (last) fill'
      - id: side_trade_id
        type: u4
        doc: 'The unique ID assigned to the trade once it is received or matched by the exchange'
      - id: orig_side_trade_id
        type: u4_nullable
        doc: 'Refers back to the unique ID assigned to the corrected trade. Nullable, No Value = 4294967295'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trading day (expressed in local time at place of trade). Nullable, No Value = 65535'
      - id: ord_status_trd_cxl
        type: u1
        enum: ord_status_trd_cxl
        doc: 'Identifies status of order as trade cancellation or correction'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Describes the specific ExecutionRpt as trade cancellation or correction'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: fills_groups
        type: fills_groups
        doc: 'NoFills Block'
      - id: spread_trade_events_groups
        type: spread_trade_events_groups
        doc: 'NoOrderEvents Block'
  security_definition_response:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Long name of the instrument for TM Repo'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Short Name for TM Repo'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: security_req_id
        type: u8
        doc: 'Unique identifier for a security definition request. It is incumbent on the market participant to maintain uniqueness'
      - id: security_response_id
        type: u8
        doc: 'Unique ID of a SecurityDefinition message'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Specifies the Product Group for which working orders should be cancelled. Conditionally required if MassActionScope=?Product Group? (Tag1374=10). Will be ignored if present for any other criteria specified in MassActionScope besides Product Group'
      - id: security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id_optional
        type: s4_nullable
        doc: 'Conditionally required if MassActionScope=?Instrument? (Tag 1374=1). Will be ignored if present for any other criteria specified in MassActionScope besides Instrument. Nullable, No Value = 2147483647'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the currency for the price'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'SecurityDefinitionResponse'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: start_date
        type: u2_nullable
        doc: 'Start date of a financing deal, i.e. the date the buyer pays the seller cash and takes control of the collateral. Nullable, No Value = 65535'
      - id: end_date
        type: u2_nullable
        doc: 'End date of a financing deal, i.e. the date the seller reimburses the buyer and takes back control of the collateral. Nullable, No Value = 65535'
      - id: max_no_of_substitutions
        type: u1_nullable
        doc: 'Max number of substitutions allowed. The value of 0 indicates that substitutions are not allowed. Nullable, No Value = 255'
      - id: source_repo_id
        type: s4_nullable
        doc: 'Represents the source repo instrument on which the new tailor made repo should be modeled on. Nullable, No Value = 2147483647'
      - id: termination_type
        type: str
        size: 8
        encoding: ASCII
        doc: 'Represents the term code'
      - id: security_response_type
        type: u1
        enum: security_response_type
        doc: 'Type of security definition message response'
      - id: expiration_cycle
        type: u1_nullable
        doc: 'For tag 827-ExpirationCycle=2, instrument expires as indicated in market data Security Definition (tag 35-MsgType=d) repeating block: Tag 865-EventType=7 (Last Eligible Trade Date) Tag 1145-EventTime. Nullable, No Value = 255'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: auto_quote_request
        type: u1
        enum: auto_quote_request
        doc: 'Boolean flag (0/1) to automatically send a quote request message following the security definition (35=d) message'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: response_legs_groups
        type: response_legs_groups
        doc: 'NoLegs Block'
  maturity_month_year:
    seq:
      - id: year
        type: u2_nullable
        doc: 'YYYY. Nullable, No Value = 65535'
      - id: month
        type: u1_nullable
        doc: 'MM. Nullable, No Value = 255'
      - id: day
        type: u1_nullable
        doc: 'DD. Nullable, No Value = 255'
      - id: week
        type: u1_nullable
        doc: 'WW. Nullable, No Value = 255'
  response_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: response_legs_group
        type: response_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of legs (repeating groups)'
  response_legs_group:
    seq:
      - id: leg_price
        type: decimal_s8_9_nullable
        doc: 'Price of the futures contract as part of UDS Covered. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: leg_option_delta
        type: leg_option_delta
        doc: 'Up to 26 legs (i.e., repeating groups) supported for UDS for options. Up to 40 legs (i.e., repeating groups) supported for UDS for futures. Will be set to 0 for REPO'
      - id: leg_security_id
        type: s4
        doc: 'Multileg instrument''s individual security''s SecurityID'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of this individual leg of a multileg security'
      - id: leg_ratio_qty
        type: u1_nullable
        doc: 'Specifies ratio for the instrument defined in this repeating group. Required for any UDS options leg. Optional for Covereds leg. Nullable, No Value = 255'
  leg_option_delta:
    seq:
      - id: mantissa_32
        type: s4
        doc: 'mantissa. Nullable, No Value = 2147483647'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa_32 * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  order_mass_action_report:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Time the transaction represented by this ExecutionReport (35=8) occurred. Expressed as nanoseconds since epoch time. Nanoseconds since Unix epoch'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: order_request_id
        type: u8
        doc: 'Use OrderRequestID to identify a request to enter, modify or delete an order and echo the value on the ExecutionReport representing the response'
      - id: mass_action_report_id
        type: u8
        doc: 'Unique ID of Order Mass Action Report as assigned by CME. If fragmented then all messages must have the same value'
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Specifies the Product Group for which working orders should be cancelled. Conditionally required if MassActionScope=?Product Group? (Tag1374=10). Will be ignored if present for any other criteria specified in MassActionScope besides Product Group'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: security_id_optional
        type: s4_nullable
        doc: 'Conditionally required if MassActionScope=?Instrument? (Tag 1374=1). Will be ignored if present for any other criteria specified in MassActionScope besides Instrument. Nullable, No Value = 2147483647'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: mass_action_response
        type: u1
        enum: mass_action_response
        doc: 'Specifies the action taken by CME when it received the Order Mass Action Request'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: mass_action_scope
        type: u1
        enum: mass_action_scope
        doc: 'Specifies the scope of the action'
      - id: total_affected_orders
        type: u4
        doc: 'Total number of orders affected by the Order Mass Action Request. Will be returned as zero for rejects or if request is accepted but no orders could be cancelled. If fragmented then this is the sum of NoAffectedOrders across all messages with the same MassActionReportID. Otherwise will have same value as NoAffectedOrders when one or more orders is cancelled'
      - id: last_fragment
        type: u1
        enum: last_fragment
        doc: 'Indicates whether the message is the last message in a sequence of messages to support fragmentation'
      - id: mass_action_reject_reason
        type: u1_nullable
        doc: 'Reason Order Mass Action Request was rejected. Required if Mass Action Response=0. Nullable, No Value = 255'
      - id: market_segment_id
        type: u1_nullable
        doc: 'Specifies the market segment (physical match engine partition) for which working orders should be cancelled. Conditionally Required if MassActionScope=?Market Segment? (Tag 1374=9). Will be ignored if present for any other criteria specified in MassActionScope besides Market Segment. Nullable, No Value = 255'
      - id: mass_cancel_request_type
        type: u1_nullable
        doc: 'If present ? specifies the scope of the OrderMassActionRequest within the context of Session and Firm. If absent then all orders belonging to Session and Firm combination will be cancelled for specified MassActionScope. Nullable, No Value = 255'
      - id: side_optional
        type: u1_nullable
        doc: 'If provided then only orders belonging to one side will be cancelled. If absent then orders belonging to both sides will be cancelled. Nullable, No Value = 255'
      - id: mass_action_ord_typ
        type: u1
        enum: mass_action_ord_typ
        doc: 'If provided then only orders of this type will be cancelled. If absent then all order types will be cancelled'
      - id: mass_cancel_tif
        type: u1_nullable
        doc: 'If provided then only orders with this qualifier will be cancelled. If absent then all Day & GT orders will be cancelled. Nullable, No Value = 255'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
      - id: affected_orders_groups
        type: affected_orders_groups
        doc: 'NoAffectedOrders Block'
  affected_orders_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: affected_orders_group
        type: affected_orders_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Total number of order identifiers affected by the OrderMass Action Request. Only used if orders could actually be cancelled otherwise will be set to zero. Must be followed by OrigCIOrdID'
  affected_orders_group:
    seq:
      - id: origclordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Contains the ClOrd of the cancelled order'
      - id: affected_order_id
        type: u8
        doc: 'Order ID of an order cancelled by a mass action request'
      - id: cxl_quantity
        type: u4
        doc: 'Total quantity cancelled for this order'
  quote_cancel_ack:
    seq:
      - id: seq_num
        type: u4
        doc: 'Sequence number as assigned to message'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long (uInt64); recommended to use timestamp as number of microseconds since epoch (Jan 1, 1970)'
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Reject reason details. Will be used only for descriptive rejects'
      - id: sender_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Operator ID. Should be unique per Firm ID. Assigned value used to identify specific message originator. Represents last individual or team in charge of the system which modifies the order before submission to the Globex platform, or if not modified from initiator (party role=118), last individual or team in charge of the system, which submit the order to the Globex platform'
      - id: party_details_list_req_id
        type: u8
        doc: 'Refers to the ID of the related PartyDetailsDefinitionRequest message which will logically be tied to this message'
      - id: request_time
        type: u8
        doc: 'Information carried on a response to convey the time (UTC) when the request was received by the MSGW application. UTC timestamps are sent in number of nanoseconds since the UNIX epoch with microsecond precision'
      - id: sending_time_epoch
        type: nanosecond_timestamp
        doc: 'Time when the message is sent. 64-bit integer expressing the number of nano seconds since midnight January 1, 1970. Nanoseconds since Unix epoch'
      - id: cancelled_symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Instrument Group cancelled for a Quote Cancel acknowledgement'
      - id: location
        type: str
        size: 5
        encoding: ASCII
        doc: 'Text describing sender''s location (i.e. geopraphic location and/or desk)'
      - id: quote_id
        type: u4
        doc: 'Unique identifier for mass quote populated by the client system'
      - id: quote_reject_reason
        type: u2_nullable
        doc: 'Contains reason (error code) the corresponding MassQuote message has been rejected. When this tag is returned, all quotes in the corresponding Mass Quote message are rejected. Nullable, No Value = 65535'
      - id: delay_duration
        type: u2_nullable
        doc: 'Not being currently used. Nullable, No Value = 65535'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        doc: 'Indicates if the order was initially received manually (as opposed to electronically)'
      - id: quote_cxl_status
        type: u1
        enum: quote_cxl_status
        doc: 'Identifies the type of Quote Cancel. A working quote can be cancelled by providing either it''s instrument, quote set, product group, or by cancelling all'
      - id: no_processed_entries
        type: u4
        doc: 'Number of quotes successfully cancelled (if in response to a Quote Cancel message)'
      - id: mm_protection_reset
        type: u1
        enum: mm_protection_reset
        doc: 'When market maker protection is triggered CME will not accept any new quotes from the market maker for that product group until it receives a mass quote message with the MMProtectionReset flag set to true'
      - id: unsolicited_cancel_type
        type: str_1_nullable
        doc: 'Type of quote cancel generated by CME -- returned only for unsolicited quote cancels. Nullable, No Value = 0'
      - id: split_msg
        type: u1_nullable
        doc: 'Indicates whether a message was delayed as a result of being split among multiple packets (0) or if a message was delayed as a result of TCP re-transmission (1) or if a complete message was delayed due to a previously submitted split or out of order message (2). If absent then the message was not delayed and was neither split nor received out of order. Nullable, No Value = 255'
      - id: tot_no_quote_entries_optional
        type: u1_nullable
        doc: 'Total number of quotes for the quote set across all messages. Should be the sum of all NoQuoteEntries in each message that has repeating quotes that are part of the same quote set. Required if NoQuoteEntries > 0. Since fragmentation is not supported in practice this will always be equal to the value of NoQuoteEntries. Nullable, No Value = 255'
      - id: liquidity_flag
        type: u1_nullable
        doc: 'New field added to capture if an order was submitted for market making obligation or not. Applicable only for EU fixed income markets. Nullable, No Value = 255'
      - id: poss_retrans_flag
        type: u1
        enum: poss_retrans_flag
        doc: 'Flags message as possible retransmission. This will convey whether a message is an original transmission or duplicate in response to RetransmissionRequest. This will become pertinent when original messages get interleaved with Retransmission responses'
      - id: delay_to_time
        type: u8_nullable
        doc: 'Indicates the amount of time that a message was delayed as a result of being split (9553=0) or as a result of being out of order due to TCP retransmission (9553=1) or as a result of being queued behind a split message (9553=2). Represented as number of nanoseconds in unix epoch format (since Jan 1, 1970). Subtracting this number from FIFO time will represent original received time of delayed message. Nullable, No Value = 18446744073709551615'
      - id: quote_cancel_ack_entries_groups
        type: quote_cancel_ack_entries_groups
        doc: 'NoQuoteEntries Block'
      - id: quote_cancel_ack_sets_groups
        type: quote_cancel_ack_sets_groups
        doc: 'NoQuoteSets Block'
  quote_cancel_ack_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: quote_cancel_ack_entries_group
        type: quote_cancel_ack_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'The number of quote entries for a quote set. Will be populated only for enumerated rejects for Cancel By Instrument'
  quote_cancel_ack_entries_group:
    seq:
      - id: quote_entry_id
        type: u4
        doc: 'Unique identifier for a quote. The QuoteEntryID stays with the quote as a static identifier even if the quote is updated. For fills this value is transposed into client order ID (tag 11)'
      - id: security_id
        type: s4
        doc: 'Security ID as defined by CME. For the security ID list, see the security definition messages'
      - id: quote_entry_reject_reason
        type: u1
        doc: 'Reason (error code) quote has been rejected'
  quote_cancel_ack_sets_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: quote_cancel_ack_sets_group
        type: quote_cancel_ack_sets_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'The number of sets of quotes in the message. Will be populated only for enumerated rejects for Cancel By Quote Set'
  quote_cancel_ack_sets_group:
    seq:
      - id: quote_set_id
        type: u2
        doc: 'Unique id for the Quote Set'
      - id: quote_error_code
        type: u2
        doc: 'Reason (error code) quote set cancel has been rejected'
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
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  decimal_s8_9:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000.0
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
    instances:
      is_null:
        value: value.mantissa == 9223372036854775807
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 2147483647
  str_1_nullable:
    seq:
      - id: value
        size: 1
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"

enums:
  template_id:
    500:
      id: 'negotiate'
      doc: 'Negotiate'
    501:
      id: 'negotiation_response'
      doc: 'NegotiationResponse'
    502:
      id: 'negotiation_reject'
      doc: 'NegotiationReject'
    503:
      id: 'establish'
      doc: 'Establish'
    504:
      id: 'establishment_ack'
      doc: 'EstablishmentAck'
    505:
      id: 'establishment_reject'
      doc: 'EstablishmentReject'
    506:
      id: 'sequence'
      doc: 'Sequence'
    507:
      id: 'terminate'
      doc: 'Terminate'
    508:
      id: 'retransmit_request'
      doc: 'RetransmitRequest'
    509:
      id: 'retransmission'
      doc: 'Retransmission'
    510:
      id: 'retransmit_reject'
      doc: 'RetransmitReject'
    513:
      id: 'not_applied'
      doc: 'NotApplied'
    514:
      id: 'new_order_single'
      doc: 'NewOrderSingle'
    515:
      id: 'order_cancel_replace_request'
      doc: 'OrderCancelReplaceRequest'
    516:
      id: 'order_cancel_request'
      doc: 'OrderCancelRequest'
    517:
      id: 'mass_quote'
      doc: 'MassQuote'
    518:
      id: 'party_details_definition_request'
      doc: 'PartyDetailsDefinitionRequest'
    519:
      id: 'party_details_definition_request_ack'
      doc: 'PartyDetailsDefinitionRequestAck'
    521:
      id: 'business_reject'
      doc: 'BusinessReject'
    522:
      id: 'execution_report_new'
      doc: 'ExecutionReportNew'
    523:
      id: 'execution_report_reject'
      doc: 'ExecutionReportReject'
    524:
      id: 'execution_report_elimination'
      doc: 'ExecutionReportElimination'
    525:
      id: 'execution_report_trade_outright'
      doc: 'ExecutionReportTradeOutright'
    526:
      id: 'execution_report_trade_spread'
      doc: 'ExecutionReportTradeSpread'
    527:
      id: 'execution_report_trade_spread_leg'
      doc: 'ExecutionReportTradeSpreadLeg'
    528:
      id: 'quote_cancel'
      doc: 'QuoteCancel'
    529:
      id: 'order_mass_action_request'
      doc: 'OrderMassActionRequest'
    530:
      id: 'order_mass_status_request'
      doc: 'OrderMassStatusRequest'
    531:
      id: 'execution_report_modify'
      doc: 'ExecutionReportModify'
    532:
      id: 'execution_report_status'
      doc: 'ExecutionReportStatus'
    533:
      id: 'order_status_request'
      doc: 'OrderStatusRequest'
    534:
      id: 'execution_report_cancel'
      doc: 'ExecutionReportCancel'
    535:
      id: 'order_cancel_reject'
      doc: 'OrderCancelReject'
    536:
      id: 'order_cancel_replace_reject'
      doc: 'OrderCancelReplaceReject'
    537:
      id: 'party_details_list_request'
      doc: 'PartyDetailsListRequest'
    538:
      id: 'party_details_list_report'
      doc: 'PartyDetailsListReport'
    539:
      id: 'execution_ack'
      doc: 'ExecutionAck'
    543:
      id: 'request_for_quote'
      doc: 'RequestForQuote'
    544:
      id: 'new_order_cross'
      doc: 'NewOrderCross'
    545:
      id: 'mass_quote_ack'
      doc: 'MassQuoteAck'
    546:
      id: 'request_for_quote_ack'
      doc: 'RequestForQuoteAck'
    548:
      id: 'execution_report_trade_addendum_outright'
      doc: 'ExecutionReportTradeAddendumOutright'
    549:
      id: 'execution_report_trade_addendum_spread'
      doc: 'ExecutionReportTradeAddendumSpread'
    550:
      id: 'execution_report_trade_addendum_spread_leg'
      doc: 'ExecutionReportTradeAddendumSpreadLeg'
    560:
      id: 'security_definition_request'
      doc: 'SecurityDefinitionRequest'
    561:
      id: 'security_definition_response'
      doc: 'SecurityDefinitionResponse'
    562:
      id: 'order_mass_action_report'
      doc: 'OrderMassActionReport'
    563:
      id: 'quote_cancel_ack'
      doc: 'QuoteCancelAck'
  fault_tolerance_indicator:
    0:
      id: 'backup'
      doc: 'Backup'
    1:
      id: 'primary'
      doc: 'Primary'
  keep_alive_interval_lapsed:
    0:
      id: 'not_lapsed'
      doc: 'NotLapsed'
    1:
      id: 'lapsed'
      doc: 'Lapsed'
  split_msg:
    0:
      id: 'split_message_delayed'
      doc: 'Split Message Delayed'
    1:
      id: 'outof_order_message_delayed'
      doc: 'Out of Order Message Delayed'
    2:
      id: 'complete_message_delayed'
      doc: 'Complete Message Delayed'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  ord_type:
    0x31:
      id: 'marketwith_protection'
      doc: 'Market with Protection'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x33:
      id: 'stopwith_protection'
      doc: 'Stop with Protection'
    0x34:
      id: 'stop_limitt'
      doc: 'Stop Limit'
    0x4b:
      id: 'market_with_leftover_as_limit'
      doc: 'Market With Leftover As Limit'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'good_till_cancel'
      doc: 'Good Till Cancel'
    3:
      id: 'fill_and_kill'
      doc: 'Fill And Kill'
    4:
      id: 'fill_or_kill'
      doc: 'Fill Or Kill'
    6:
      id: 'good_till_date'
      doc: 'Good Till Date'
  manual_order_indicator:
    0:
      id: 'automated'
      doc: 'Automated'
    1:
      id: 'manual'
      doc: 'Manual'
  execution_mode:
    0x41:
      id: 'aggressive'
      doc: 'Aggressive'
    0x50:
      id: 'passive'
      doc: 'Passive'
  liquidity_flag:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  managed_order:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  short_sale_type:
    0:
      id: 'long_sell'
      doc: 'Long Sell'
    1:
      id: 'short_sale_with_no_exemption_sesh'
      doc: 'Short Sale With No Exemption SESH'
    2:
      id: 'short_sale_with_exemption_ssex'
      doc: 'Short Sale With Exemption SSEX'
    3:
      id: 'undisclosed_sell_information_not_available_undi'
      doc: 'Undisclosed Sell Information Not Available UNDI'
  ofm_override:
    0:
      id: 'disabled'
      doc: 'Disabled'
    1:
      id: 'enabled'
      doc: 'Enabled'
  mm_protection_reset:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  list_update_action:
    0x41:
      id: 'add'
      doc: 'Add'
    0x44:
      id: 'delete_field'
      doc: 'Delete'
  cmta_giveup_cd:
    0x47:
      id: 'give_up'
      doc: 'Give Up'
    0x53:
      id: 'sg_xoffset'
      doc: 'SGX offset'
  cust_order_capacity:
    1:
      id: 'membertradingfortheirownaccount'
      doc: 'Member trading for their own account'
    2:
      id: 'clearingfirmtradingforitsproprietaryaccount'
      doc: 'Clearing firm trading for its proprietary account'
    3:
      id: 'membertradingforanothermember'
      doc: 'Member trading for anothermember'
    4:
      id: 'allother'
      doc: 'All other'
  clearing_account_type:
    0:
      id: 'customer'
      doc: 'Customer'
    1:
      id: 'firm'
      doc: 'Firm'
  self_match_prevention_instruction:
    0x4e:
      id: 'cancel_newest'
      doc: 'Cancel Newest'
    0x4f:
      id: 'cancel_oldest'
      doc: 'Cancel Oldest'
  avg_px_indicator:
    0:
      id: 'no_average_pricing'
      doc: 'No Average Pricing'
    1:
      id: 'tradeispartofan_average_price_group_identifiedbythe_avg_px_grp_id'
      doc: 'Trade is part of an Average Price Group Identified by the AvgPxGrp ID'
    3:
      id: 'tradeispartofa_notional_value_average_price_group'
      doc: 'Trade is part of a Notional Value Average Price Group'
  clearing_trade_price_type:
    0:
      id: 'trade_clearingat_execution_price'
      doc: 'Trade Clearing at Execution Price'
    1:
      id: 'trade_clearingat_alternate_clearing_price'
      doc: 'Trade Clearing at Alternate Clearing Price'
  cust_order_handling_inst:
    0x43:
      id: 'fc_mprovidedscreen'
      doc: 'FCM provided screen'
    0x44:
      id: 'otherprovidedscreen'
      doc: 'Other provided screen'
    0x47:
      id: 'fcmapi_cta_ix'
      doc: 'FCM API or FIX'
    0x48:
      id: 'algo_engine'
      doc: 'Algo Engine'
    0x57:
      id: 'desk_electronic'
      doc: 'Desk Electronic'
    0x59:
      id: 'client_electronic'
      doc: 'Client Electronic'
  party_detail_role:
    1:
      id: 'executing_firm'
      doc: 'Executing Firm'
    24:
      id: 'customer_account'
      doc: 'Customer Account'
    96:
      id: 'take_up_firm'
      doc: 'Take Up Firm'
    118:
      id: 'operator_field'
      doc: 'Operator'
    1000:
      id: 'take_up_account'
      doc: 'Take Up Account'
  quote_cancel_type:
    1:
      id: 'cancelper_instrument'
      doc: 'Cancel per Instrument'
    3:
      id: 'cancelper_instrumentgroup'
      doc: 'Cancel per Instrument group'
    4:
      id: 'cancelallquotes'
      doc: 'Cancel all quotes'
    100:
      id: 'cancelper_quote_set'
      doc: 'Cancel per Quote Set'
  mass_action_scope:
    1:
      id: 'instrument'
      doc: 'Instrument'
    7:
      id: 'all'
      doc: 'All'
    9:
      id: 'market_segment_id'
      doc: 'Market Segment ID'
    10:
      id: 'instrument_group'
      doc: 'Instrument Group'
    100:
      id: 'quote_set_id'
      doc: 'Quote Set ID'
  mass_cancel_request_type:
    100:
      id: 'sender_sub_id'
      doc: 'Sender Sub ID'
    101:
      id: 'account'
      doc: 'Account'
  side_optional:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  mass_action_ord_typ:
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit'
  mass_cancel_tif:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'good_till_cancel'
      doc: 'Good Till Cancel'
    6:
      id: 'good_till_date'
      doc: 'Good Till Date'
  mass_status_req_type:
    1:
      id: 'instrument'
      doc: 'Instrument'
    3:
      id: 'instrument_group'
      doc: 'Instrument Group'
    100:
      id: 'market_segment'
      doc: 'Market Segment'
  ord_status_req_type:
    100:
      id: 'sender_sub_id'
      doc: 'SenderSubID'
    101:
      id: 'account'
      doc: 'Account'
  mass_status_tif:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'gtc'
      doc: 'GTC'
    6:
      id: 'gtd'
      doc: 'GTD'
  quote_type:
    1:
      id: 'tradeable'
      doc: 'Tradeable'
  rfq_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    8:
      id: 'cross'
      doc: 'Cross'
  side_time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    3:
      id: 'fak'
      doc: 'FAK'
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  poss_retrans_flag:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  manual_order_indicator_optional:
    0:
      id: 'automated'
      doc: 'Automated'
    1:
      id: 'manual'
      doc: 'Manual'
  ord_type_optional:
    0x31:
      id: 'market_with_protection'
      doc: 'Market With Protection'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit'
    0x4b:
      id: 'market_with_leftover_as_limit'
      doc: 'Market With Leftover As Limit'
  ord_status_trd:
    1:
      id: 'partially_filled'
      doc: 'Partially Filled'
    2:
      id: 'filled'
      doc: 'Filled'
  aggressor_indicator:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  order_event_type:
    4:
      id: 'partially_filled'
      doc: 'Partially Filled'
    5:
      id: 'filled'
      doc: 'Filled'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x31:
      id: 'partially_filled'
      doc: 'Partially Filled'
    0x32:
      id: 'filled'
      doc: 'Filled'
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
    0x55:
      id: 'undefined'
      doc: 'Undefined'
  last_rpt_requested:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  exec_restatement_reason:
    8:
      id: 'market_exchange_option'
      doc: 'Market Exchange Option'
    9:
      id: 'cancelled_not_best'
      doc: 'Cancelled Not Best'
    100:
      id: 'cancel_on_disconnect'
      doc: 'Cancel On Disconnect'
    103:
      id: 'self_match_prevention_oldest_order_cancelled'
      doc: 'Self Match Prevention Oldest Order Cancelled'
    104:
      id: 'cancel_on_globex_credit_controls_violation'
      doc: 'Cancel On Globex Credit Controls Violation'
    105:
      id: 'cancel_from_firmsoft'
      doc: 'Cancel From Firmsoft'
    106:
      id: 'cancel_from_risk_management_api'
      doc: 'Cancel From Risk Management API'
    107:
      id: 'self_match_prevention_newest_order_cancelled'
      doc: 'Self Match Prevention Newest Order Cancelled'
    108:
      id: 'cancelduetovolquotedoptionorderrestedqtylessthanminordersize'
      doc: 'Cancel due to vol quoted option order rested qty less than min order size'
  request_result:
    0:
      id: 'valid_request'
      doc: 'Valid Request'
    2:
      id: 'no_data_found_that_matched_selection_criteria'
      doc: 'No Data Found That Matched Selection Criteria'
    3:
      id: 'not_authorizedto_retrieve_data'
      doc: 'Not Authorized to Retrieve Data'
    4:
      id: 'data_temporarily_unavailable'
      doc: 'Data Temporarily Unavailable'
  last_fragment:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  exec_ack_status:
    1:
      id: 'accepted'
      doc: 'Accepted'
    2:
      id: 'rejected'
      doc: 'Rejected'
  dk_reason:
    0x41:
      id: 'unknown_security'
      doc: 'Unknown Security'
    0x42:
      id: 'wrong_side'
      doc: 'Wrong Side'
    0x43:
      id: 'quantity_exceeds_order'
      doc: 'Quantity Exceeds Order'
    0x44:
      id: 'no_matching_order'
      doc: 'No Matching Order'
    0x45:
      id: 'price_exceeds_limit'
      doc: 'Price Exceeds Limit'
    0x46:
      id: 'calculation_difference'
      doc: 'Calculation Difference'
    0x47:
      id: 'no_matching_execution_report'
      doc: 'No Matching Execution Report'
    0x5a:
      id: 'other'
      doc: 'Other'
  quote_ack_status:
    0:
      id: 'accepted'
      doc: 'Accepted'
    5:
      id: 'rejected'
      doc: 'Rejected'
  ord_status_trd_cxl:
    0x47:
      id: 'trade_correction'
      doc: 'Trade Correction'
    0x48:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
  exec_type:
    0x47:
      id: 'trade_correction'
      doc: 'Trade Correction'
    0x48:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
  trade_addendum:
    4:
      id: 'partially_filled'
      doc: 'Partially Filled'
    5:
      id: 'filled'
      doc: 'Filled'
    100:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
    101:
      id: 'trade_correction'
      doc: 'Trade Correction'
  security_response_type:
    1:
      id: 'accept_security_proposalasis'
      doc: 'Accept Security Proposal as is'
    2:
      id: 'accept_securityproposalwithrevisionsasindicatedinthemessage'
      doc: 'Accept Security proposal with revisions as indicated in the message'
    5:
      id: 'reject_security_proposal'
      doc: 'Reject Security Proposal'
  expiration_cycle:
    0:
      id: 'expire_on_trading_session_close'
      doc: 'Expire On Trading Session Close'
    2:
      id: 'expirationatgivendate'
      doc: 'Expiration at given date'
  auto_quote_request:
    0:
      id: 'false_field'
      doc: 'False, No'
    1:
      id: 'true_field'
      doc: 'True, Yes'
  mass_action_response:
    0:
      id: 'rejected'
      doc: 'Rejected'
    1:
      id: 'accepted'
      doc: 'Accepted'
  quote_cxl_status:
    1:
      id: 'cancelper_instrument'
      doc: 'Cancel per Instrument'
    3:
      id: 'cancelper_instrumentgroup'
      doc: 'Cancel per Instrument group'
    4:
      id: 'cancelallquotes'
      doc: 'Cancel all quotes'
    5:
      id: 'rejected'
      doc: 'Rejected'
    100:
      id: 'cancelper_quote_set'
      doc: 'Cancel per Quote Set'

