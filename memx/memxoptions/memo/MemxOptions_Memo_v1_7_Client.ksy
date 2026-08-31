# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxOptions Memo Sbe v1.7
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Members Orders
#   Encoding: Simple Binary Encoding
#   Version: 1.7
#   Date: 4/17/2024
#   Specification: MEMO for US Options - SBE-v1_7a.pdf
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
  id: memx_memxoptions_memo_sbe_v1_7_client
  title: Memx MemxOptions Memo Sbe v1.7
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Options Members Orders Sbe v1.7'
doc-ref: https://memxtrading.com

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Tcp Common Header'
  - id: client_data
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::login_request': login_request_message
        'message_type::replay_request': replay_request_message
        'message_type::replay_all_request': replay_all_request_message
        'message_type::stream_request': stream_request_message
        'message_type::unsequenced_message': unsequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: message_length
        type: u2
        doc: 'Total bytes following the header (does not include this header)'
  login_request_message:
    seq:
      - id: token_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Token type'
      - id: token
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Token'
  replay_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
      - id: count
        type: u4
        doc: 'Total number of messages to include in the replay'
  replay_all_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
  stream_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
  unsequenced_message:
    seq:
      - id: client_sbe_message
        type: client_sbe_message
        doc: 'Sbe message sent by the firm to Memx'
  client_sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: client_payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::new_order_single_message': new_order_single_message
            'template_id::short_two_sided_bulk_quote_message': short_two_sided_bulk_quote_message
            'template_id::long_two_sided_bulk_quote_message': long_two_sided_bulk_quote_message
            'template_id::short_one_sided_bulk_quote_message': short_one_sided_bulk_quote_message
            'template_id::long_one_sided_bulk_quote_message': long_one_sided_bulk_quote_message
            'template_id::order_cancel_replace_request_message': order_cancel_replace_request_message
            'template_id::order_cancel_request_message': order_cancel_request_message
            'template_id::mass_cancel_request_message': mass_cancel_request_message
            'template_id::mass_cancel_clear_lockout_request_message': mass_cancel_clear_lockout_request_message
            'template_id::allocation_instruction_message': allocation_instruction_message
            'template_id::mass_cancel_bulk_clear_all_lockouts_request_message': mass_cancel_bulk_clear_all_lockouts_request_message
            'template_id::mass_cancel_bulk_clear_lockouts_by_efid_or_underlier_request_message': mass_cancel_bulk_clear_lockouts_by_efid_or_underlier_request_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Memx Udp Message Type'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'T8 Identifier of the message template'
      - id: schema_id
        type: u1
        doc: 'The identifier of a message schema'
      - id: version
        type: u2
        doc: 'The version number of the message schema that was used to encode a message'
  new_order_single_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the quote'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered. This represents the number of options contracts'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: price_optional
        type: decimal_u8_8_nullable
        doc: 'Price of the quote. Price per unit of quantity. MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 13 3.3.5 Long One Sided Quote Group The One Sided Quote repeating group allows for up to 20 one sided quotes in messages. This group is used within the LongOneSidedBulkQuote message. All quotes in a Long One Sided Quote repeating group must be for the same Underlier. The OptionsSecurityID of the first quote in the repeating group identifies the Underlier that is used to validate all of the following quotes in the repeating group. This group is always preceded by RepeatingGroupDimensions field that denotes the length of this group and the number of them expected in the message. Field Offset Length Type Tag Ref Num Req''d Description. Implied decimal with scale 1e-8. Nullable, No Value = 18446744073709551615'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: position_effect_optional
        type: u1
        enum: position_effect_optional
        doc: 'Opening or closing a position. Nullable, No Value = 0'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'Trading Capacity of allocation'
      - id: reprice_frequency
        type: u1_nullable
        doc: 'Defines the frequency of a MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 38 Field Offset Length Type Tag Ref Num Req''d Description reprice. If this tag is not sent then the order will not be repriced. Nullable, No Value = 255'
      - id: reprice_behavior
        type: u1_nullable
        doc: 'Defines the reprice behavior when market is locked or crossed. Nullable, No Value = 255'
      - id: mtp_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom match-trade prevention group. Nullable, No Value = 65535'
      - id: match_trade_prevention
        type: u1_nullable
        doc: 'Defines the desired behavior in the event of a wash. The UINT8 Null (0xFF) value disables match trade prevention. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom cancel group. Nullable, No Value = 65535'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set to be applied to this order. The UINT16 Null value (0xFFFF) disables custom risk controls. NoPartyIDs - - RepeatingGroupDimensions 453 Y The dimensions of the Repeating Group. Parties - - Parties Group N/A N The parties associated with the quotes. 5.1.2 ShortTwoSidedBulkQuote The two sided bulk quote message type is used by market makers wishing to electronically submit multiple quotes with similar semantics to the exchange for execution. This messages supports two sided quotes with smaller field sizes for quantities and prices. This message corresponds to FIX message type i. Field Offset Length Type Tag Ref Num Req''d Description SBE Header 0 7 SBE Header N/A Y SBE Header with templateID = 2 MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 39 Field Offset Length Type Tag Ref Num Req''d Description. Nullable, No Value = 65535'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  exec_inst:
    seq:
      - id: participate_do_not_initiate
        type: b1
        doc: 'ParticipateDoNotInitiate'
      - id: intermarket_sweep
        type: b1
        doc: 'IntermarketSweep'
      - id: external_routing_not_allowed
        type: b1
        doc: 'ExternalRoutingNotAllowed'
      - id: reserved_13
        type: b13
        doc: '13 reserved bits'
  parties_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'RepeatingGroupDimensions'
      - id: parties_group
        type: parties_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'Parties'
  repeating_group_dimensions:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  parties_group:
    seq:
      - id: party_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Party identifier/code. Printable characters only (ascii HEX 0x20 to 0x7E), with the exception of &, <, >, ” and ’'
      - id: party_id_source
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies class or source of the PartyID (448) value. The exchange currently accepts the following values for this field: - ''D'' for Proprietary/Custom Code'
      - id: party_role
        type: u1
        enum: party_role
        doc: 'Identifies the type or role of the PartyID (448) specified. MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 14 3.3.7 Execution Allocations Group (Repeating Group 124) The Execution Allocations Group repeating group allows for identification of the original Exchange Trade that post trade allocations are occurring on. Though this is denoted as a repeating group, at the current time, this group will always contain a single entry. This group is always preceded by RepeatingGroupDimensions field that denotes the length of this group and the number of the items in the group in the message. (Always set to 1) Field Offset Length Type Tag Ref Num Req''d Description'
  short_two_sided_bulk_quote_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'Trading Capacity of allocation'
      - id: mtp_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom match-trade prevention group. Nullable, No Value = 65535'
      - id: match_trade_prevention
        type: u1_nullable
        doc: 'Defines the desired behavior in the event of a wash. The UINT8 Null (0xFF) value disables match trade prevention. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom cancel group. Nullable, No Value = 65535'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set to be applied to this order. The UINT16 Null value (0xFFFF) disables custom risk controls. NoPartyIDs - - RepeatingGroupDimensions 453 Y The dimensions of the Repeating Group. Parties - - Parties Group N/A N The parties associated with the quotes. 5.1.2 ShortTwoSidedBulkQuote The two sided bulk quote message type is used by market makers wishing to electronically submit multiple quotes with similar semantics to the exchange for execution. This messages supports two sided quotes with smaller field sizes for quantities and prices. This message corresponds to FIX message type i. Field Offset Length Type Tag Ref Num Req''d Description SBE Header 0 7 SBE Header N/A Y SBE Header with templateID = 2 MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 39 Field Offset Length Type Tag Ref Num Req''d Description. Nullable, No Value = 65535'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
      - id: two_sided_quotes_groups
        type: two_sided_quotes_groups
        doc: 'Quotes Block'
  two_sided_quotes_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'RepeatingGroupDimensions'
      - id: two_sided_quotes_group
        type: two_sided_quotes_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'Quotes'
  two_sided_quotes_group:
    seq:
      - id: list_seq_no
        type: u1
        doc: 'Unique identifier for a single Quote within the collection. Note the ListSeqNo must be continuous starting with a value of 1 for the quote group'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group'
      - id: bid_size
        type: u2
        doc: 'Bid side quantity of the quote'
      - id: bid_px
        type: decimal_u2_2
        doc: 'Bid side price of the quote. Price per unit of quantity. Implied decimal with scale 1e-2'
      - id: offer_size
        type: u2
        doc: 'Ask side quantity of the quote'
      - id: offer_px
        type: decimal_u2_2
        doc: 'Ask side price of the quote. Price per unit of quantity. 3.3.3 Long Two Sided Quote Group The Two Sided Quote repeating group allows for up to 20 two sided quotes in messages. This group is used within the LongTwoSidedBulkQuote message. All quotes in a Long Two Sided Quote repeating group must be for the same Underlier. The OptionsSecurityID of the first quote in the repeating group identifies the Underlier that is used to validate all of the following quotes in the repeating group. This group is always preceded by a RepeatingGroupDimensions field that denotes the length of this group and the number of them expected in the message. Field Offset Length Type Tag Ref Num Req''d Description. Implied decimal with scale 1e-2'
  long_two_sided_bulk_quote_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'Trading Capacity of allocation'
      - id: mtp_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom match-trade prevention group. Nullable, No Value = 65535'
      - id: match_trade_prevention
        type: u1_nullable
        doc: 'Defines the desired behavior in the event of a wash. The UINT8 Null (0xFF) value disables match trade prevention. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom cancel group. Nullable, No Value = 65535'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set to be applied to this order. The UINT16 Null value (0xFFFF) disables custom risk controls. NoPartyIDs - - RepeatingGroupDimensions 453 Y The dimensions of the Repeating Group. Parties - - Parties Group N/A N The parties associated with the quotes. 5.1.2 ShortTwoSidedBulkQuote The two sided bulk quote message type is used by market makers wishing to electronically submit multiple quotes with similar semantics to the exchange for execution. This messages supports two sided quotes with smaller field sizes for quantities and prices. This message corresponds to FIX message type i. Field Offset Length Type Tag Ref Num Req''d Description SBE Header 0 7 SBE Header N/A Y SBE Header with templateID = 2 MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 39 Field Offset Length Type Tag Ref Num Req''d Description. Nullable, No Value = 65535'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
      - id: two_sided_quotes_groups
        type: two_sided_quotes_groups
        doc: 'Quotes Block'
  short_one_sided_bulk_quote_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'Trading Capacity of allocation'
      - id: mtp_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom match-trade prevention group. Nullable, No Value = 65535'
      - id: match_trade_prevention
        type: u1_nullable
        doc: 'Defines the desired behavior in the event of a wash. The UINT8 Null (0xFF) value disables match trade prevention. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom cancel group. Nullable, No Value = 65535'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set to be applied to this order. The UINT16 Null value (0xFFFF) disables custom risk controls. NoPartyIDs - - RepeatingGroupDimensions 453 Y The dimensions of the Repeating Group. Parties - - Parties Group N/A N The parties associated with the quotes. 5.1.2 ShortTwoSidedBulkQuote The two sided bulk quote message type is used by market makers wishing to electronically submit multiple quotes with similar semantics to the exchange for execution. This messages supports two sided quotes with smaller field sizes for quantities and prices. This message corresponds to FIX message type i. Field Offset Length Type Tag Ref Num Req''d Description SBE Header 0 7 SBE Header N/A Y SBE Header with templateID = 2 MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 39 Field Offset Length Type Tag Ref Num Req''d Description. Nullable, No Value = 65535'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
      - id: one_sided_quotes_groups
        type: one_sided_quotes_groups
        doc: 'Quotes Block'
  one_sided_quotes_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'RepeatingGroupDimensions'
      - id: one_sided_quotes_group
        type: one_sided_quotes_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'Quotes'
  one_sided_quotes_group:
    seq:
      - id: list_seq_no
        type: u1
        doc: 'Unique identifier for a single Quote within the collection. Note the ListSeqNo must be continuous starting with a value of 1 for the quote group'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the quote'
      - id: quantity
        type: u2
        doc: 'Contracts in the quote'
      - id: price_short
        type: decimal_u2_2
        doc: 'Price of the quote. Price per unit of quantity. MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 13 3.3.5 Long One Sided Quote Group The One Sided Quote repeating group allows for up to 20 one sided quotes in messages. This group is used within the LongOneSidedBulkQuote message. All quotes in a Long One Sided Quote repeating group must be for the same Underlier. The OptionsSecurityID of the first quote in the repeating group identifies the Underlier that is used to validate all of the following quotes in the repeating group. This group is always preceded by RepeatingGroupDimensions field that denotes the length of this group and the number of them expected in the message. Field Offset Length Type Tag Ref Num Req''d Description. Implied decimal with scale 1e-2'
  long_one_sided_bulk_quote_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: exec_inst
        type: exec_inst
        doc: 'ExecInstType bit set'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'Trading Capacity of allocation'
      - id: mtp_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom match-trade prevention group. Nullable, No Value = 65535'
      - id: match_trade_prevention
        type: u1_nullable
        doc: 'Defines the desired behavior in the event of a wash. The UINT8 Null (0xFF) value disables match trade prevention. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom cancel group. Nullable, No Value = 65535'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set to be applied to this order. The UINT16 Null value (0xFFFF) disables custom risk controls. NoPartyIDs - - RepeatingGroupDimensions 453 Y The dimensions of the Repeating Group. Parties - - Parties Group N/A N The parties associated with the quotes. 5.1.2 ShortTwoSidedBulkQuote The two sided bulk quote message type is used by market makers wishing to electronically submit multiple quotes with similar semantics to the exchange for execution. This messages supports two sided quotes with smaller field sizes for quantities and prices. This message corresponds to FIX message type i. Field Offset Length Type Tag Ref Num Req''d Description SBE Header 0 7 SBE Header N/A Y SBE Header with templateID = 2 MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 39 Field Offset Length Type Tag Ref Num Req''d Description. Nullable, No Value = 65535'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
      - id: one_sided_quotes_groups
        type: one_sided_quotes_groups
        doc: 'Quotes Block'
  order_cancel_replace_request_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: order_id_optional
        type: u8_nullable
        doc: 'OrderID as assigned by the exchange. Nullable, No Value = 18446744073709551615'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: list_seq_no
        type: u1
        doc: 'Unique identifier for a single Quote within the collection. Note the ListSeqNo must be continuous starting with a value of 1 for the quote group'
      - id: origclordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID (11) of the previous order MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 45 Field Offset Length Type Tag Ref Num Req''d Description (NOT the initial order of the day)'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the quote'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered. This represents the number of options contracts'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: price_optional
        type: decimal_u8_8_nullable
        doc: 'Price of the quote. Price per unit of quantity. MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 13 3.3.5 Long One Sided Quote Group The One Sided Quote repeating group allows for up to 20 one sided quotes in messages. This group is used within the LongOneSidedBulkQuote message. All quotes in a Long One Sided Quote repeating group must be for the same Underlier. The OptionsSecurityID of the first quote in the repeating group identifies the Underlier that is used to validate all of the following quotes in the repeating group. This group is always preceded by RepeatingGroupDimensions field that denotes the length of this group and the number of them expected in the message. Field Offset Length Type Tag Ref Num Req''d Description. Implied decimal with scale 1e-8. Nullable, No Value = 18446744073709551615'
  order_cancel_request_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: order_id_optional
        type: u8_nullable
        doc: 'OrderID as assigned by the exchange. Nullable, No Value = 18446744073709551615'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: list_seq_no
        type: u1
        doc: 'Unique identifier for a single Quote within the collection. Note the ListSeqNo must be continuous starting with a value of 1 for the quote group'
      - id: origclordid_optional
        type: str_20_nullable
        doc: 'ClOrdID (11) of the previous order MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 45 Field Offset Length Type Tag Ref Num Req''d Description (NOT the initial order of the day). Nullable, No Value = 0'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'Side of the quote. Nullable, No Value = 0'
  mass_cancel_request_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: efid_optional
        type: str_4_nullable
        doc: 'Cancel all orders on this EFID. Nullable, No Value = 0'
      - id: underlying_or_series
        type: u1
        enum: underlying_or_series
        doc: 'If UnderlyingOrSeries is set to CancelAllOnSeries then OptionsSecurityID must be provided to denote the specific option series (root, put/call, expiration, and strike price) to cancel orders on. This option must be a series of the provided underlying symbol. If UnderlyingOrSeries is set to CancelAllOnUnderlying then all orders on that underlying that match the rest of the filter will be canceled'
      - id: underlier
        type: str
        size: 6
        encoding: ASCII
        doc: 'The Underlying symbol on which to cancel orders. If UnderlyingOrSeries is set to CancelAllOnSeries, cancels will be limited in scope for the OptionsSecurityID provided on this message'
      - id: options_security_id_optional
        type: str_8_nullable
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group. Nullable, No Value = 0'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom cancel group. Nullable, No Value = 65535'
      - id: mass_cancel_inst
        type: mass_cancel_inst
        doc: 'MassCancelInstType bit set'
  mass_cancel_inst:
    seq:
      - id: lockout
        type: b1
        doc: 'Lockout'
      - id: send_cancels
        type: b1
        doc: 'SendCancels'
      - id: cancel_orders_from_this_port_only
        type: b1
        doc: 'CancelOrdersFromThisPortOnly'
      - id: reserved_5
        type: b5
        doc: '5 reserved bits'
  mass_cancel_clear_lockout_request_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: underlier
        type: str
        size: 6
        encoding: ASCII
        doc: 'The Underlying symbol on which to cancel orders. If UnderlyingOrSeries is set to CancelAllOnSeries, cancels will be limited in scope for the OptionsSecurityID provided on this message'
      - id: lockout_id
        type: u8
        doc: 'The LockoutID of a previous lockout, returned in a PendingMassCancel message. 5.1.10 MassCancelBulkClearAllLockoutsRequest The mass cancel clear all lockouts request message requests the clearing of previously placed lockouts. A lockout can be requested as part of a MassCancelRequest using the MassCancelInst field. The MassCancelBulkClearAllLockoutsRequest will clear all existing lockouts for the FIRM associated with the port. A MassCancelBulkClearLockoutAccepted message will be sent on the requesting port if the request is deemed valid else a MassCancelBulkClearLockoutReject will be sent instead with the appropriate reject reason code. note: Lockouts initiated via a different port sent in parallel to this request may be cleared as part of this operation as well. MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 49 Field Offset Length Type Tag Ref Num Req''d Description SBE Header 0 7 SBE Header N/A Y SBE Header with templateID = 32'
  allocation_instruction_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: alloc_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier for this allocation instruction message - supplied by customer, similar to ClOrdId. Printable characters only (ascii HEX 0x20 to 0x7E), with the exception of &, <, >, ” and ’'
      - id: alloc_type
        type: u1
        enum: alloc_type
        doc: 'Specifies the purpose or type of Allocation message'
      - id: alloc_trans_type
        type: u1
        enum: alloc_trans_type
        doc: 'Identifies allocation transaction type being requested (New or Replace) RefAllocID 37 20 CHAR 72 C Required when AllocTransType = Replace, contains the IndividualAllocID of the MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 51 Field Offset Length Type Tag Ref Num Req''d Description allocation unit being changed'
      - id: ref_alloc_id_optional
        type: str_20_nullable
        doc: 'RefAllocID. Nullable, No Value = 0'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the quote'
      - id: execution_allocations_groups
        type: execution_allocations_groups
        doc: 'ExecutionAllocations Block'
      - id: requested_allocations_groups
        type: requested_allocations_groups
        doc: 'RequestedAllocations Block'
  execution_allocations_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'RepeatingGroupDimensions'
      - id: execution_allocations_group
        type: execution_allocations_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'ExecutionAllocations'
  execution_allocations_group:
    seq:
      - id: trade_id
        type: u8
        doc: 'TrdMatchID of the original Trade'
      - id: last_qty
        type: u4
        doc: 'Qty of original Trade'
      - id: last_px
        type: decimal_u8_8
        doc: 'Price of original Trade 3.3.8 Nested Parties Group (Repeating Group 539) The Nested Parties Group repeating group allows for multiple party identifiers to be supplied inside a Allocation Group entry in post trade allocation messages. This group is always preceded by RepeatingGroupDimensions field that denotes the length of this group and the number of the items in the group in the message. Field Offset Length Type Tag Ref Num Req''d Description. Implied decimal with scale 1e-8'
  requested_allocations_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'RepeatingGroupDimensions'
      - id: requested_allocations_group
        type: requested_allocations_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'RequestedAllocations'
  requested_allocations_group:
    seq:
      - id: alloc_qty
        type: u4
        doc: 'Quantity of allocation'
      - id: alloc_position_effect
        type: u1
        enum: alloc_position_effect
        doc: 'Position Effect of allocation'
      - id: nested_parties_groups
        type: nested_parties_groups
        doc: 'Parties Block'
  nested_parties_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'RepeatingGroupDimensions'
      - id: nested_parties_group
        type: nested_parties_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'Parties'
  nested_parties_group:
    seq:
      - id: nested_party_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Party identifier/code. An empty string or whitespace filled string indicates this PartyRole will be cleared. Printable characters only (ascii HEX 0x20 to 0x7E), with the exception of &, <, >, ” and ’'
      - id: nested_party_id_source
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies class or source of the NestedPartyID (524) value. The exchange currently accepts the following values for this field: • ''D'' for Proprietary/Custom Code'
      - id: nested_party_role
        type: u1
        enum: nested_party_role
        doc: 'Identifies the type or role of the NestedPartyID (524) specified. 3.3.9 Request Allocations Group (Repeating Group 78) The Request Allocations Group repeating group allows for multiple allocations to be supplied in a post-trade request message. MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 15 This group is always preceded by RepeatingGroupDimensions field that denotes the length of this group and the number of the items in the group in the message. Field Offset Length Type Tag Ref Num Req''d Description'
  mass_cancel_bulk_clear_all_lockouts_request_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
  mass_cancel_bulk_clear_lockouts_by_efid_or_underlier_request_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Time of message transmission always expressed in UTC (Universal Time Coordinated, also known as GMT). Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client'
      - id: efid_optional
        type: str_4_nullable
        doc: 'Cancel all orders on this EFID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'The Underlying symbol on which to cancel orders. If UnderlyingOrSeries is set to CancelAllOnSeries, cancels will be limited in scope for the OptionsSecurityID provided on this message. Nullable, No Value = 0'
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_u8_8_nullable:
    seq:
      - id: value
        type: decimal_u8_8
    instances:
      is_null:
        value: value.mantissa == 18446744073709551615
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  str_20_nullable:
    seq:
      - id: value
        size: 20
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
  str_8_nullable:
    seq:
      - id: value
        size: 8
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0

enums:
  message_type:
    0:
      id: 'heartbeat'
      doc: 'Memx Tcp Heartbeat'
    100:
      id: 'login_request'
      doc: 'Memx Tcp Login Request'
    101:
      id: 'replay_request'
      doc: 'Memx Tcp Replay Request'
    102:
      id: 'replay_all_request'
      doc: 'Memx Tcp Replay All Request'
    103:
      id: 'stream_request'
      doc: 'Memx Tcp Stream Request'
    104:
      id: 'unsequenced_message'
      doc: 'Memx Tcp Unsequenced Message'
    1:
      id: 'login_accepted'
      doc: 'Memx Tcp Login Accepted Message'
    2:
      id: 'login_rejected'
      doc: 'Memx Tcp Login Rejected Message'
    3:
      id: 'start_of_session'
      doc: 'Memx Tcp Start of Session Message'
    4:
      id: 'end_of_session'
      doc: 'Memx Tcp End of Session Message'
    5:
      id: 'replay_begin'
      doc: 'Memx Tcp Replay Begin Message'
    6:
      id: 'replay_rejected'
      doc: 'Memx Tcp Replay Rejected Message'
    7:
      id: 'replay_complete'
      doc: 'Memx Tcp Replay Complete Message'
    8:
      id: 'stream_begin'
      doc: 'Memx Tcp Stream Begin Message'
    9:
      id: 'stream_rejected'
      doc: 'Memx Tcp Stream Rejected Message'
    10:
      id: 'stream_complete'
      doc: 'Memx Tcp Stream Complete Message'
    11:
      id: 'sequenced_message'
      doc: 'Memx Tcp Sequenced Message'
  template_id:
    1:
      id: 'new_order_single_message'
      doc: 'NewOrderSingleMessage'
    2:
      id: 'short_two_sided_bulk_quote_message'
      doc: 'ShortTwoSidedBulkQuoteMessage'
    3:
      id: 'long_two_sided_bulk_quote_message'
      doc: 'LongTwoSidedBulkQuoteMessage'
    4:
      id: 'short_one_sided_bulk_quote_message'
      doc: 'ShortOneSidedBulkQuoteMessage'
    5:
      id: 'long_one_sided_bulk_quote_message'
      doc: 'LongOneSidedBulkQuoteMessage'
    6:
      id: 'order_cancel_replace_request_message'
      doc: 'OrderCancelReplaceRequestMessage'
    7:
      id: 'order_cancel_request_message'
      doc: 'OrderCancelRequestMessage'
    8:
      id: 'mass_cancel_request_message'
      doc: 'MassCancelRequestMessage'
    9:
      id: 'mass_cancel_clear_lockout_request_message'
      doc: 'MassCancelClearLockoutRequestMessage'
    32:
      id: 'mass_cancel_bulk_clear_all_lockouts_request_message'
      doc: 'MassCancelBulkClearAllLockoutsRequestMessage'
    33:
      id: 'mass_cancel_bulk_clear_lockouts_by_efid_or_underlier_request_message'
      doc: 'MassCancelBulkClearLockoutsByEFIDOrUnderlierRequestMessage'
    10:
      id: 'allocation_instruction_message'
      doc: 'AllocationInstructionMessage'
    11:
      id: 'execution_report_new_message'
      doc: 'ExecutionReport_NewMessage'
    12:
      id: 'execution_report_bulk_quote_pending_new_message'
      doc: 'ExecutionReport_BulkQuote_PendingNewMessage'
    13:
      id: 'execution_report_bulk_quote_component_new_message'
      doc: 'ExecutionReport_BulkQuote_ComponentNewMessage'
    14:
      id: 'execution_report_rejected_message'
      doc: 'ExecutionReport_RejectedMessage'
    15:
      id: 'execution_report_trade_message'
      doc: 'ExecutionReport_TradeMessage'
    16:
      id: 'execution_report_pending_cancel_message'
      doc: 'ExecutionReport_PendingCancelMessage'
    17:
      id: 'execution_report_canceled_message'
      doc: 'ExecutionReport_CanceledMessage'
    18:
      id: 'execution_report_pending_replace_message'
      doc: 'ExecutionReport_PendingReplaceMessage'
    19:
      id: 'execution_report_replaced_message'
      doc: 'ExecutionReport_ReplacedMessage'
    20:
      id: 'execution_report_trade_correction_message'
      doc: 'ExecutionReport_TradeCorrectionMessage'
    21:
      id: 'execution_report_trade_break_message'
      doc: 'ExecutionReport_TradeBreakMessage'
    22:
      id: 'execution_report_restatement_message'
      doc: 'ExecutionReport_RestatementMessage'
    23:
      id: 'pending_mass_cancel_message'
      doc: 'PendingMassCancelMessage'
    24:
      id: 'mass_cancel_reject_message'
      doc: 'MassCancelRejectMessage'
    25:
      id: 'mass_cancel_done_message'
      doc: 'MassCancelDoneMessage'
    26:
      id: 'order_cancel_reject_message'
      doc: 'OrderCancelRejectMessage'
    27:
      id: 'allocation_instruction_ack_message'
      doc: 'AllocationInstructionAckMessage'
    28:
      id: 'allocation_instruction_alert_message'
      doc: 'AllocationInstructionAlertMessage'
    29:
      id: 'user_notification_message'
      doc: 'UserNotificationMessage'
    30:
      id: 'mass_cancel_clear_lockout_reject_message'
      doc: 'MassCancelClearLockoutRejectMessage'
    31:
      id: 'mass_cancel_clear_lockout_done_message'
      doc: 'MassCancelClearLockoutDoneMessage'
    35:
      id: 'mass_cancel_bulk_clear_lockout_reject_message'
      doc: 'MassCancelBulkClearLockoutRejectMessage'
    36:
      id: 'mass_cancel_bulk_clear_lockout_accepted_message'
      doc: 'MassCancelBulkClearLockoutAcceptedMessage'
  side:
    0x31:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'as_defined'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_type:
    0x31:
      id: 'market'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'limit'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  position_effect_optional:
    0x4f:
      id: 'open'
      doc: 'PositionEffectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'close'
      doc: 'PositionEffectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_capacity:
    1:
      id: 'customer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'professional_customer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'broker_dealer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'broker_dealer_customer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'firm'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'market_maker'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'away_market_maker'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reprice_frequency:
    0:
      id: 'single_reprice'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'continuous_reprice'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'none'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reprice_behavior:
    1:
      id: 'reprice_lock_cancel_cross'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'reprice_lock_reprice_cross'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  match_trade_prevention:
    0:
      id: 'cancel_newest'
      doc: 'MatchTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_oldest'
      doc: 'MatchTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_both'
      doc: 'MatchTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'MatchTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  party_role:
    1:
      id: 'executing_firm_id'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'actionable_identifier'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'give_up_clearing_firm'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'contra_efid'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'contra_give_up'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'optional_occ_data'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'contra_mm_sub_account'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'cmta'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'contra_cmta'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    66:
      id: 'market_maker_sub_account'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side_optional:
    0x31:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'as_defined'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  underlying_or_series:
    0:
      id: 'cancel_all_on_underlying'
      doc: 'UnderlyingOrSeriesType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_all_on_series'
      doc: 'UnderlyingOrSeriesType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'UnderlyingOrSeriesType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_type:
    100:
      id: 'post_trade_edit'
      doc: 'AllocType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'AllocType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_trans_type:
    0:
      id: 'new_field'
      doc: 'AllocTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'replace'
      doc: 'AllocTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancel'
      doc: 'AllocTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'AllocTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_position_effect:
    0x4f:
      id: 'open'
      doc: 'PositionEffectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'close'
      doc: 'PositionEffectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  nested_party_role:
    1:
      id: 'executing_firm_id'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'actionable_identifier'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'give_up_clearing_firm'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'contra_efid'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'contra_give_up'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'optional_occ_data'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'contra_mm_sub_account'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'cmta'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'contra_cmta'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    66:
      id: 'market_maker_sub_account'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  supported_request_mode:
    0x53:
      id: 'stream'
      doc: 'Stream Mode'
    0x52:
      id: 'replay'
      doc: 'Replay Mode'
    0x54:
      id: 'snapshot_mode'
      doc: 'Snapshot Mode'
  login_reject_code:
    0x54:
      id: 'malformed_token'
      doc: 'Malformed Token'
    0x55:
      id: 'token_type_unsupported'
      doc: 'Token type unsupported by this server'
    0x56:
      id: 'token_type_invalid'
      doc: 'Token type invalid on any server'
    0x41:
      id: 'authorization_failed'
      doc: 'Authorization failed'
  replay_reject_code:
    0x52:
      id: 'replay_requests_are_not_allowed'
      doc: 'Stream requests are not allowed by this server. Must use replay requests to receive data'
    0x41:
      id: 'replay_all_requests_are_not_allowed'
      doc: 'Replay all requests are not allowed by this server'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session ID on the request is not the active session'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'Start sequence number out of range'
  stream_reject_code:
    0x52:
      id: 'stream_requests_are_not_allowed'
      doc: 'Stream requests are not allowed by this server. Must use replay requests to receive data'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session ID on the request is not the active session'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'Start sequence number out of range'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'partial_filled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'filled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'canceled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'pending_cancel'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'rejected'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'pending_replace'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'expired'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_reject_reason:
    1:
      id: 'unknown_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'exchange_closed'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'duplicate_order'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'price_exceeds_current_price_band'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'invalid_price_increment'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'missing_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'invalid_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'missing_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'invalid_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'missing_side'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'invalid_side'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'missing_order_qty'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'invalid_order_qty'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'missing_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'invalid_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    110:
      id: 'missing_time_in_force'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    111:
      id: 'invalid_time_in_force'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    112:
      id: 'missing_trading_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    113:
      id: 'invalid_trading_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    114:
      id: 'missing_exec_inst'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    115:
      id: 'invalid_exec_inst'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    118:
      id: 'missing_limit_price'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    119:
      id: 'invalid_limit_price'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    124:
      id: 'missing_match_trade_prevention_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    125:
      id: 'invalid_match_trade_prevention_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    126:
      id: 'missing_cancel_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    127:
      id: 'invalid_cancel_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    128:
      id: 'missing_mtp_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    129:
      id: 'invalid_mtp_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    134:
      id: 'missing_risk_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    135:
      id: 'invalid_risk_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    136:
      id: 'missing_efid'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    137:
      id: 'invalid_efid'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    138:
      id: 'missing_list_seq_no'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    139:
      id: 'invalid_list_seq_no'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    140:
      id: 'quotes_have_different_underliers'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    141:
      id: 'two_sided_quotes_cross'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    142:
      id: 'missing_position_effect'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    143:
      id: 'invalid_position_effect'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    144:
      id: 'missing_reprice_behavior_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    145:
      id: 'invalid_reprice_behavior_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    146:
      id: 'missing_reprice_frequency_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    147:
      id: 'invalid_reprice_frequency_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    148:
      id: 'missing_party_role_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    149:
      id: 'invalid_party_role_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    150:
      id: 'missing_party_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    151:
      id: 'invalid_party_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    152:
      id: 'missing_party_id_source'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    153:
      id: 'invalid_party_id_source'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    154:
      id: 'underlying_symbol_not_open'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    155:
      id: 'missing_sending_time'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    156:
      id: 'invalid_sending_time'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    157:
      id: 'missing_sub_account'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    158:
      id: 'invalid_sub_account'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    159:
      id: 'missing_give_up'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    160:
      id: 'invalid_give_up'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    161:
      id: 'missing_cmta'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    162:
      id: 'invalid_cmta'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    163:
      id: 'missing_actionable_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    164:
      id: 'invalid_actionable_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    165:
      id: 'missing_optional_occ_data'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    166:
      id: 'invalid_optional_occ_data'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    200:
      id: 'halted'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    201:
      id: 'firm_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    202:
      id: 'efid_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    203:
      id: 'account_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    204:
      id: 'invalid_modifier_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    205:
      id: 'invalid_time_in_force_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    207:
      id: 'post_only_not_allowed'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    208:
      id: 'quote_modify_rejected'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    209:
      id: 'quoting_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    210:
      id: 'invalid_quote_component_count'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    300:
      id: 'non_test_symbols_blocked'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    301:
      id: 'notional_value_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    302:
      id: 'max_notional_value_per_order_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    303:
      id: 'block_non_test_symbol_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    304:
      id: 'max_contracts_per_order_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    305:
      id: 'nbbo_width_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    306:
      id: 'exchange_price_value_collar_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    307:
      id: 'execution_price_higher_than_strike_price'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    308:
      id: 'market_buy_when_nbo_is_zero'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    309:
      id: 'market_sell_when_nbb_greater_than_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    310:
      id: 'quote_price_outside_exchange_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    312:
      id: 'num_contracts_executed_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    313:
      id: 'notional_value_of_executions_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    314:
      id: 'count_of_executions_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    315:
      id: 'outstanding_percentage_threshold_exceeded'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    316:
      id: 'trips_threshold_exceeded'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    317:
      id: 'iso_orders_not_allowed'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    318:
      id: 'market_is_crossed'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    319:
      id: 'active_risk_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    320:
      id: 'manual_risk_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    321:
      id: 'gross_notional_value_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    322:
      id: 'net_notional_value_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    323:
      id: 'duplicate_order_threshold_exceeded'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    324:
      id: 'order_rate_threshold_exceeded'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    325:
      id: 'mass_cancel_lockout_in_effect'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    326:
      id: 'market_order_gross_notional_value_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    327:
      id: 'market_order_net_notional_value_exceeds_threshold'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    328:
      id: 'limit_order_fat_finger_check'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    329:
      id: 'bulk_quote_fat_finger_check'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65535:
      id: 'null_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  last_liquidity_ind:
    1:
      id: 'added'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'removed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  position_effect:
    0x4f:
      id: 'open'
      doc: 'PositionEffectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'close'
      doc: 'PositionEffectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  contra_trading_capacity:
    1:
      id: 'customer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'professional_customer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'broker_dealer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'broker_dealer_customer'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'firm'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'market_maker'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'away_market_maker'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'TradingCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_reason:
    0:
      id: 'other'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'user_requested_cancel'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'execution_price_collar'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'halted'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'exchange_supervisory'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'order_expired'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'match_trade_prevention'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'participant_disconnect'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'order_not_bookable'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'firm_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'efid_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'account_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'quote_update_rejected_orig_quote_canceled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'active_risk_breach'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'manual_risk_breach'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'num_contracts_executed_exceeds_threshold'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'notional_value_of_executions_exceeds_threshold'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'count_of_executions_exceeds_threshold'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'outstanding_percentage_threshold_exceeded'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'trips_threshold_exceeded'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'gross_notional_value_exceeds_threshold'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'net_notional_value_exceeds_threshold'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'duplicate_order_threshold_exceeded'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'order_rate_threshold_exceeded'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'market_order_gross_notional_value_exceeds_threshold'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'market_order_net_notional_value_exceeds_threshold'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'market_order_nbbo_width_exceeded'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'market_order_no_national_best_bid'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'market_order_no_national_best_offer'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'drill_through_price_exceeded'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'order_would_lock_or_cross'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'mass_cancel_request'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    42:
      id: 'locked_or_crossed_market'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exec_restatement_reason:
    3:
      id: 'order_reprice'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'match_trade_prevention'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  extended_restatement_reason:
    0:
      id: 'none'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'match_trade_cancel_newest'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'match_trade_cancel_oldest'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'match_trade_cancel_both'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_cancel_reject_reason:
    0:
      id: 'other'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'duplicate_cl_ord_id'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'missing_cl_ord_id'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'invalid_cl_ord_id'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'missing_efid'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_efid'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'missing_underlying_or_series'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'invalid_underlying_or_series'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'missing_underlier'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_underlier'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'missing_options_security_id'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'invalid_options_security_id'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'missing_cancel_group_id'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'invalid_cancel_group_id'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'missing_mass_cancel_inst'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'invalid_mass_cancel_inst'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'mass_cancel_in_progress'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'missing_sending_time'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'invalid_sending_time'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'invalid_options_security_id_for_underlier'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65535:
      id: 'null_value'
      doc: 'MassCxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  underlying_or_series_optional:
    0:
      id: 'cancel_all_on_underlying'
      doc: 'UnderlyingOrSeriesType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_all_on_series'
      doc: 'UnderlyingOrSeriesType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'UnderlyingOrSeriesType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cxl_rej_response_to:
    0x31:
      id: 'order_cancel_request'
      doc: 'CxlRejResponseToType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'order_cancel_replace_request'
      doc: 'CxlRejResponseToType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cxl_rej_reason:
    0:
      id: 'too_late_to_cancel'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'unknown_order'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_already_pending_cancel_or_replace'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'price_exceeds_current_price_band'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'invalid_price_increment'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'missing_symbol'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'invalid_symbol'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'missing_cl_ord_id'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'invalid_cl_ord_id'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'missing_side'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'invalid_side'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'missing_order_qty'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'invalid_order_qty'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'missing_order_type'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'invalid_order_type'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    110:
      id: 'missing_limit_price'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    111:
      id: 'invalid_limit_price'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    114:
      id: 'missing_list_seq_no'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    115:
      id: 'invalid_list_seq_no'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    116:
      id: 'missing_orig_cl_ord_id'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    117:
      id: 'invalid_orig_cl_ord_id'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    118:
      id: 'missing_order_id'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    119:
      id: 'invalid_order_id'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    120:
      id: 'missing_sending_time'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    121:
      id: 'invalid_sending_time'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    200:
      id: 'halted'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    201:
      id: 'firm_disabled'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    202:
      id: 'efid_disabled'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    203:
      id: 'account_disabled'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    204:
      id: 'unsupported_ord_type_change'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    205:
      id: 'unsupported_side_change'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    206:
      id: 'symbol_mismatch'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    207:
      id: 'orig_order_id_mismatch'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    208:
      id: 'unsupported_order_property_change'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    300:
      id: 'non_test_symbols_blocked'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    301:
      id: 'notional_value_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    302:
      id: 'max_notional_value_per_order_risk_rule_violated'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    303:
      id: 'block_non_test_symbol_risk_rule_violated'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    304:
      id: 'max_contracts_per_order_risk_rule_violated'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    305:
      id: 'nbbo_width_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    306:
      id: 'exchange_price_value_collar_risk_rule_violated'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    307:
      id: 'execution_price_higher_than_strike_price'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    308:
      id: 'market_buy_when_nbo_is_zero'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    309:
      id: 'market_sell_when_nbb_greater_than_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    310:
      id: 'quote_price_outside_exchange_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    312:
      id: 'num_contracts_executed_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    313:
      id: 'notional_value_of_executions_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    314:
      id: 'count_of_executions_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    315:
      id: 'outstanding_percentage_threshold_exceeded'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    316:
      id: 'trips_threshold_exceeded'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    317:
      id: 'iso_orders_not_allowed'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    318:
      id: 'market_is_crossed'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    319:
      id: 'active_risk_breach'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    320:
      id: 'manual_risk_breach'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    321:
      id: 'gross_notional_value_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    322:
      id: 'net_notional_value_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    323:
      id: 'duplicate_order_threshold_exceeded'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    324:
      id: 'order_rate_threshold_exceeded'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    325:
      id: 'mass_cancel_lockout_in_effect'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    326:
      id: 'market_order_gross_notional_value_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    327:
      id: 'market_order_net_notional_value_exceeds_threshold'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    328:
      id: 'limit_order_fat_finger_check'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    329:
      id: 'bulk_quote_fat_finger_check'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65535:
      id: 'null_value'
      doc: 'CxlRejReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_status:
    0:
      id: 'accepted'
      doc: 'AllocStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'block_level_reject'
      doc: 'AllocStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'account_level_reject'
      doc: 'AllocStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'AllocStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_rej_code:
    1:
      id: 'incorrect_quantity'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'incorrect_allocated_quantity'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'unknown_or_stale_exec_id'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'mismatched_data'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'duplicate_or_missing_individual_alloc_id'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'trade_not_recognized'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'duplicate_trade'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'incorrect_or_missing_instrument'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'unknown_or_missing_party'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'incorrect_or_missing_side'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'missing_position_effect_type'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'invalid_position_effect_type'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65535:
      id: 'null_value'
      doc: 'AllocRejCodeType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_canc_replace_reason:
    2:
      id: 'change_in_underlying_order_details'
      doc: 'AllocCancReplaceReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65535:
      id: 'null_value'
      doc: 'AllocCancReplaceReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  user_status:
    8:
      id: 'session_shutdown_warning'
      doc: 'UserStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'end_of_events_for_session'
      doc: 'UserStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'UserStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  rej_reason:
    0:
      id: 'other'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'missing_cl_ord_id'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'invalid_cl_ord_id'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'missing_lockout_id'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'invalid_lockout_id'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'unknown_lockout_id'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'no_lockouts_active'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'missing_efid'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_efid'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'missing_underlier'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'invalid_underlier'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'missing_efid_or_underlier'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'invalid_underlier_for_lockout_id'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65535:
      id: 'null_value'
      doc: 'MassCancelClearLockoutRejCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

