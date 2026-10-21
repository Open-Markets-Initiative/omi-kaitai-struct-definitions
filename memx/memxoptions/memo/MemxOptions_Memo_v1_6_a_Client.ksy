# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxOptions Memo Sbe v1.6.a
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Members Orders
#   Encoding: Simple Binary Encoding
#   Version: 1.6.a
#   Date: 11/13/2023
#   Specification: MEMO for US Options - SBE-v1_6b (2024-08-07).pdf
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
  id: memx_memxoptions_memo_sbe_v1_6_a_client
  title: Memx MemxOptions Memo Sbe v1.6.a
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Options Members Orders Sbe v1.6.a'
doc-ref: https://memxtrading.com/

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Tcp Common Header'
  - id: client_data
    size: common_header.message_length
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
      - id: num_groups
        type: u1
        doc: 'A count of repeating groups at the root level of the message'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 64
        doc: 'Bytes the stated block holds beyond the 64 this version reads'
      - id: parties_groups
        type: parties_groups
        doc: 'Parties Block'
  exec_inst:
    seq:
      - id: reserved_13
        type: b13
        doc: '13 reserved bits'
      - id: external_routing_not_allowed
        type: b1
        doc: 'ExternalRoutingNotAllowed'
      - id: intermarket_sweep
        type: b1
        doc: 'IntermarketSweep'
      - id: participate_do_not_initiate
        type: b1
        doc: 'ParticipateDoNotInitiate'
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
      - id: block_extension
        size: _parent.repeating_group_dimensions.block_length_short - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 39
        doc: 'Bytes the stated block holds beyond the 39 this version reads'
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
      - id: block_extension
        size: _parent.repeating_group_dimensions.block_length_short - 17
        doc: 'Bytes the stated block holds beyond the 17 this version reads'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 39
        doc: 'Bytes the stated block holds beyond the 39 this version reads'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 39
        doc: 'Bytes the stated block holds beyond the 39 this version reads'
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
      - id: block_extension
        size: _parent.repeating_group_dimensions.block_length_short - 14
        doc: 'Bytes the stated block holds beyond the 14 this version reads'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 39
        doc: 'Bytes the stated block holds beyond the 39 this version reads'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 79
        doc: 'Bytes the stated block holds beyond the 79 this version reads'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 66
        doc: 'Bytes the stated block holds beyond the 66 this version reads'
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
        type: u1_nullable
        doc: 'If UnderlyingOrSeries is set to CancelAllOnSeries then OptionsSecurityID must be provided to denote the specific option series (root, put/call, expiration, and strike price) to cancel orders on. This option must be a series of the provided underlying symbol. If UnderlyingOrSeries is set to CancelAllOnUnderlying then all orders on that underlying that match the rest of the filter will be canceled. Nullable, No Value = 255'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'The Underlying symbol on which to cancel orders. If UnderlyingOrSeries is set to CancelAllOnSeries, cancels will be limited in scope for the OptionsSecurityID provided on this message. Nullable, No Value = 0'
      - id: options_security_id_optional
        type: str_8_nullable
        doc: 'The OptionsSecurityID of the tradable options product for the quote. The Underlier for all quotes in the repeating group must match the Underlier of the first quote in the repeating group. Nullable, No Value = 0'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of custom cancel group. Nullable, No Value = 65535'
      - id: mass_cancel_inst
        type: mass_cancel_inst
        doc: 'MassCancelInstType bit set'
      - id: block_extension
        size: _parent.sbe_header.block_length - 50
        doc: 'Bytes the stated block holds beyond the 50 this version reads'
  mass_cancel_inst:
    meta:
      bit-endian: le
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
      - id: lockout_id
        type: u8_nullable
        doc: 'The LockoutID of a previous lockout, returned in a PendingMassCancel message. 5.1.10 MassCancelBulkClearAllLockoutsRequest The mass cancel clear all lockouts request message requests the clearing of previously placed lockouts. A lockout can be requested as part of a MassCancelRequest using the MassCancelInst field. The MassCancelBulkClearAllLockoutsRequest will clear all existing lockouts for the FIRM associated with the port. A MassCancelBulkClearLockoutAccepted message will be sent on the requesting port if the request is deemed valid else a MassCancelBulkClearLockoutReject will be sent instead with the appropriate reject reason code. note: Lockouts initiated via a different port sent in parallel to this request may be cleared as part of this operation as well. MEMO for Options - SBE - v1.10 COPYRIGHT MEMX LLC 2025. ALL RIGHTS RESERVED. 49 Field Offset Length Type Tag Ref Num Req''d Description SBE Header 0 7 SBE Header N/A Y SBE Header with templateID = 32. Nullable, No Value = 18446744073709551615'
      - id: block_extension
        size: _parent.sbe_header.block_length - 36
        doc: 'Bytes the stated block holds beyond the 36 this version reads'
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
      - id: block_extension
        size: _parent.sbe_header.block_length - 59
        doc: 'Bytes the stated block holds beyond the 59 this version reads'
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
      - id: block_extension
        size: _parent.repeating_group_dimensions.block_length_short - 20
        doc: 'Bytes the stated block holds beyond the 20 this version reads'
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
      - id: block_extension
        size: _parent.repeating_group_dimensions.block_length_short - 5
        doc: 'Bytes the stated block holds beyond the 5 this version reads'
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
      - id: block_extension
        size: _parent.repeating_group_dimensions.block_length_short - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
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
  str_6_nullable:
    seq:
      - id: value
        size: 6
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
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x42:
      id: 'as_defined'
      doc: 'AsDefined'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'ImmediateOrCancel'
  position_effect_optional:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  trading_capacity:
    1:
      id: 'customer'
      doc: 'Customer'
    2:
      id: 'professional_customer'
      doc: 'ProfessionalCustomer'
    3:
      id: 'broker_dealer'
      doc: 'BrokerDealer'
    4:
      id: 'broker_dealer_customer'
      doc: 'BrokerDealerCustomer'
    5:
      id: 'firm'
      doc: 'Firm'
    6:
      id: 'market_maker'
      doc: 'MarketMaker'
    7:
      id: 'away_market_maker'
      doc: 'AwayMarketMaker'
    255:
      id: 'null_value'
      doc: 'NullValue'
  reprice_frequency:
    0:
      id: 'single_reprice'
      doc: 'SingleReprice'
    1:
      id: 'continuous_reprice'
      doc: 'ContinuousReprice'
    2:
      id: 'none'
      doc: 'None'
    255:
      id: 'null_value'
      doc: 'NullValue'
  reprice_behavior:
    1:
      id: 'reprice_lock_cancel_cross'
      doc: 'RepriceLockCancelCross'
    2:
      id: 'reprice_lock_reprice_cross'
      doc: 'RepriceLockRepriceCross'
    255:
      id: 'null_value'
      doc: 'NullValue'
  match_trade_prevention:
    0:
      id: 'cancel_newest'
      doc: 'CancelNewest'
    1:
      id: 'cancel_oldest'
      doc: 'CancelOldest'
    3:
      id: 'cancel_both'
      doc: 'CancelBoth'
    255:
      id: 'null_value'
      doc: 'NullValue'
  party_role:
    1:
      id: 'executing_firm_id'
      doc: 'ExecutingFirmId'
    3:
      id: 'actionable_identifier'
      doc: 'ActionableIdentifier'
    14:
      id: 'give_up_clearing_firm'
      doc: 'GiveUpClearingFirm'
    17:
      id: 'contra_efid'
      doc: 'ContraEFID'
    18:
      id: 'contra_give_up'
      doc: 'ContraGiveUp'
    24:
      id: 'optional_occ_data'
      doc: 'OptionalOCCData'
    37:
      id: 'contra_mm_sub_account'
      doc: 'ContraMMSubAccount'
    40:
      id: 'cmta'
      doc: 'CMTA'
    41:
      id: 'contra_cmta'
      doc: 'ContraCMTA'
    66:
      id: 'market_maker_sub_account'
      doc: 'MarketMakerSubAccount'
  side_optional:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x42:
      id: 'as_defined'
      doc: 'AsDefined'
  underlying_or_series:
    0:
      id: 'cancel_all_on_underlying'
      doc: 'CancelAllOnUnderlying'
    1:
      id: 'cancel_all_on_series'
      doc: 'CancelAllOnSeries'
    255:
      id: 'null_value'
      doc: 'NullValue'
  alloc_type:
    100:
      id: 'post_trade_edit'
      doc: 'PostTradeEdit'
    255:
      id: 'null_value'
      doc: 'NullValue'
  alloc_trans_type:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'replace'
      doc: 'Replace'
    2:
      id: 'cancel'
      doc: 'Cancel'
    255:
      id: 'null_value'
      doc: 'NullValue'
  alloc_position_effect:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  nested_party_role:
    1:
      id: 'executing_firm_id'
      doc: 'ExecutingFirmId'
    3:
      id: 'actionable_identifier'
      doc: 'ActionableIdentifier'
    14:
      id: 'give_up_clearing_firm'
      doc: 'GiveUpClearingFirm'
    17:
      id: 'contra_efid'
      doc: 'ContraEFID'
    18:
      id: 'contra_give_up'
      doc: 'ContraGiveUp'
    24:
      id: 'optional_occ_data'
      doc: 'OptionalOCCData'
    37:
      id: 'contra_mm_sub_account'
      doc: 'ContraMMSubAccount'
    40:
      id: 'cmta'
      doc: 'CMTA'
    41:
      id: 'contra_cmta'
      doc: 'ContraCMTA'
    66:
      id: 'market_maker_sub_account'
      doc: 'MarketMakerSubAccount'
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
      doc: 'New'
    0x31:
      id: 'partial_filled'
      doc: 'PartialFilled'
    0x32:
      id: 'filled'
      doc: 'Filled'
    0x34:
      id: 'canceled'
      doc: 'Canceled'
    0x36:
      id: 'pending_cancel'
      doc: 'PendingCancel'
    0x38:
      id: 'rejected'
      doc: 'Rejected'
    0x45:
      id: 'pending_replace'
      doc: 'PendingReplace'
    0x43:
      id: 'expired'
      doc: 'Expired'
  order_reject_reason:
    1:
      id: 'unknown_symbol'
      doc: 'UnknownSymbol'
    2:
      id: 'exchange_closed'
      doc: 'ExchangeClosed'
    6:
      id: 'duplicate_order'
      doc: 'DuplicateOrder'
    16:
      id: 'price_exceeds_current_price_band'
      doc: 'PriceExceedsCurrentPriceBand'
    18:
      id: 'invalid_price_increment'
      doc: 'InvalidPriceIncrement'
    27:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'MaxNotionalValuePerOrderRiskRuleBreach'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'missing_symbol'
      doc: 'MissingSymbol'
    101:
      id: 'invalid_symbol'
      doc: 'InvalidSymbol'
    102:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdID'
    103:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdID'
    104:
      id: 'missing_side'
      doc: 'MissingSide'
    105:
      id: 'invalid_side'
      doc: 'InvalidSide'
    106:
      id: 'missing_order_qty'
      doc: 'MissingOrderQty'
    107:
      id: 'invalid_order_qty'
      doc: 'InvalidOrderQty'
    108:
      id: 'missing_order_type'
      doc: 'MissingOrderType'
    109:
      id: 'invalid_order_type'
      doc: 'InvalidOrderType'
    110:
      id: 'missing_time_in_force'
      doc: 'MissingTimeInForce'
    111:
      id: 'invalid_time_in_force'
      doc: 'InvalidTimeInForce'
    112:
      id: 'missing_trading_capacity'
      doc: 'MissingTradingCapacity'
    113:
      id: 'invalid_trading_capacity'
      doc: 'InvalidTradingCapacity'
    114:
      id: 'missing_exec_inst'
      doc: 'MissingExecInst'
    115:
      id: 'invalid_exec_inst'
      doc: 'InvalidExecInst'
    118:
      id: 'missing_limit_price'
      doc: 'MissingLimitPrice'
    119:
      id: 'invalid_limit_price'
      doc: 'InvalidLimitPrice'
    124:
      id: 'missing_match_trade_prevention_type'
      doc: 'MissingMatchTradePreventionType'
    125:
      id: 'invalid_match_trade_prevention_type'
      doc: 'InvalidMatchTradePreventionType'
    126:
      id: 'missing_cancel_group_id'
      doc: 'MissingCancelGroupID'
    127:
      id: 'invalid_cancel_group_id'
      doc: 'InvalidCancelGroupID'
    128:
      id: 'missing_mtp_group_id'
      doc: 'MissingMTPGroupID'
    129:
      id: 'invalid_mtp_group_id'
      doc: 'InvalidMTPGroupID'
    134:
      id: 'missing_risk_group_id'
      doc: 'MissingRiskGroupID'
    135:
      id: 'invalid_risk_group_id'
      doc: 'InvalidRiskGroupID'
    136:
      id: 'missing_efid'
      doc: 'MissingEFID'
    137:
      id: 'invalid_efid'
      doc: 'InvalidEFID'
    138:
      id: 'missing_list_seq_no'
      doc: 'MissingListSeqNo'
    139:
      id: 'invalid_list_seq_no'
      doc: 'InvalidListSeqNo'
    140:
      id: 'quotes_have_different_underliers'
      doc: 'QuotesHaveDifferentUnderliers'
    141:
      id: 'two_sided_quotes_cross'
      doc: 'TwoSidedQuotesCross'
    142:
      id: 'missing_position_effect'
      doc: 'MissingPositionEffect'
    143:
      id: 'invalid_position_effect'
      doc: 'InvalidPositionEffect'
    144:
      id: 'missing_reprice_behavior_type'
      doc: 'MissingRepriceBehaviorType'
    145:
      id: 'invalid_reprice_behavior_type'
      doc: 'InvalidRepriceBehaviorType'
    146:
      id: 'missing_reprice_frequency_type'
      doc: 'MissingRepriceFrequencyType'
    147:
      id: 'invalid_reprice_frequency_type'
      doc: 'InvalidRepriceFrequencyType'
    148:
      id: 'missing_party_role_type'
      doc: 'MissingPartyRoleType'
    149:
      id: 'invalid_party_role_type'
      doc: 'InvalidPartyRoleType'
    150:
      id: 'missing_party_id'
      doc: 'MissingPartyID'
    151:
      id: 'invalid_party_id'
      doc: 'InvalidPartyID'
    152:
      id: 'missing_party_id_source'
      doc: 'MissingPartyIDSource'
    153:
      id: 'invalid_party_id_source'
      doc: 'InvalidPartyIDSource'
    154:
      id: 'underlying_symbol_not_open'
      doc: 'UnderlyingSymbolNotOpen'
    155:
      id: 'missing_sending_time'
      doc: 'MissingSendingTime'
    156:
      id: 'invalid_sending_time'
      doc: 'InvalidSendingTime'
    157:
      id: 'missing_sub_account'
      doc: 'MissingSubAccount'
    158:
      id: 'invalid_sub_account'
      doc: 'InvalidSubAccount'
    159:
      id: 'missing_give_up'
      doc: 'MissingGiveUp'
    160:
      id: 'invalid_give_up'
      doc: 'InvalidGiveUp'
    161:
      id: 'missing_cmta'
      doc: 'MissingCMTA'
    162:
      id: 'invalid_cmta'
      doc: 'InvalidCMTA'
    163:
      id: 'missing_actionable_id'
      doc: 'MissingActionableID'
    164:
      id: 'invalid_actionable_id'
      doc: 'InvalidActionableID'
    165:
      id: 'missing_optional_occ_data'
      doc: 'MissingOptionalOCCData'
    166:
      id: 'invalid_optional_occ_data'
      doc: 'InvalidOptionalOCCData'
    200:
      id: 'halted'
      doc: 'Halted'
    201:
      id: 'firm_disabled'
      doc: 'FirmDisabled'
    202:
      id: 'efid_disabled'
      doc: 'EFIDDisabled'
    203:
      id: 'account_disabled'
      doc: 'AccountDisabled'
    204:
      id: 'invalid_modifier_for_order_type'
      doc: 'InvalidModifierForOrderType'
    205:
      id: 'invalid_time_in_force_for_order_type'
      doc: 'InvalidTimeInForceForOrderType'
    207:
      id: 'post_only_not_allowed'
      doc: 'PostOnlyNotAllowed'
    208:
      id: 'quote_modify_rejected'
      doc: 'QuoteModifyRejected'
    209:
      id: 'quoting_disabled'
      doc: 'QuotingDisabled'
    210:
      id: 'invalid_quote_component_count'
      doc: 'InvalidQuoteComponentCount'
    300:
      id: 'non_test_symbols_blocked'
      doc: 'NonTestSymbolsBlocked'
    301:
      id: 'notional_value_exceeds_threshold'
      doc: 'NotionalValueExceedsThreshold'
    302:
      id: 'max_notional_value_per_order_risk_rule_violated'
      doc: 'MaxNotionalValuePerOrderRiskRuleViolated'
    303:
      id: 'block_non_test_symbol_risk_rule_violated'
      doc: 'BlockNonTestSymbolRiskRuleViolated'
    304:
      id: 'max_contracts_per_order_risk_rule_violated'
      doc: 'MaxContractsPerOrderRiskRuleViolated'
    305:
      id: 'nbbo_width_exceeds_threshold'
      doc: 'NBBOWidthExceedsThreshold'
    306:
      id: 'exchange_price_value_collar_risk_rule_violated'
      doc: 'ExchangePriceValueCollarRiskRuleViolated'
    307:
      id: 'execution_price_higher_than_strike_price'
      doc: 'ExecutionPriceHigherThanStrikePrice'
    308:
      id: 'market_buy_when_nbo_is_zero'
      doc: 'MarketBuyWhenNBOIsZero'
    309:
      id: 'market_sell_when_nbb_greater_than_threshold'
      doc: 'MarketSellWhenNBBGreaterThanThreshold'
    310:
      id: 'quote_price_outside_exchange_threshold'
      doc: 'QuotePriceOutsideExchangeThreshold'
    312:
      id: 'num_contracts_executed_exceeds_threshold'
      doc: 'NumContractsExecutedExceedsThreshold'
    313:
      id: 'notional_value_of_executions_exceeds_threshold'
      doc: 'NotionalValueOfExecutionsExceedsThreshold'
    314:
      id: 'count_of_executions_exceeds_threshold'
      doc: 'CountOfExecutionsExceedsThreshold'
    315:
      id: 'outstanding_percentage_threshold_exceeded'
      doc: 'OutstandingPercentageThresholdExceeded'
    316:
      id: 'trips_threshold_exceeded'
      doc: 'TripsThresholdExceeded'
    317:
      id: 'iso_orders_not_allowed'
      doc: 'ISOOrdersNotAllowed'
    318:
      id: 'market_is_crossed'
      doc: 'MarketIsCrossed'
    319:
      id: 'active_risk_breach'
      doc: 'ActiveRiskBreach'
    320:
      id: 'manual_risk_breach'
      doc: 'ManualRiskBreach'
    321:
      id: 'gross_notional_value_exceeds_threshold'
      doc: 'GrossNotionalValueExceedsThreshold'
    322:
      id: 'net_notional_value_exceeds_threshold'
      doc: 'NetNotionalValueExceedsThreshold'
    323:
      id: 'duplicate_order_threshold_exceeded'
      doc: 'DuplicateOrderThresholdExceeded'
    324:
      id: 'order_rate_threshold_exceeded'
      doc: 'OrderRateThresholdExceeded'
    325:
      id: 'mass_cancel_lockout_in_effect'
      doc: 'MassCancelLockoutInEffect'
    326:
      id: 'market_order_gross_notional_value_exceeds_threshold'
      doc: 'MarketOrderGrossNotionalValueExceedsThreshold'
    327:
      id: 'market_order_net_notional_value_exceeds_threshold'
      doc: 'MarketOrderNetNotionalValueExceedsThreshold'
    328:
      id: 'limit_order_fat_finger_check'
      doc: 'LimitOrderFatFingerCheck'
    329:
      id: 'bulk_quote_fat_finger_check'
      doc: 'BulkQuoteFatFingerCheck'
    65535:
      id: 'null_value'
      doc: 'NullValue'
  last_liquidity_ind:
    1:
      id: 'added'
      doc: 'Added'
    2:
      id: 'removed'
      doc: 'Removed'
    255:
      id: 'null_value'
      doc: 'NullValue'
  position_effect:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
  contra_trading_capacity:
    1:
      id: 'customer'
      doc: 'Customer'
    2:
      id: 'professional_customer'
      doc: 'ProfessionalCustomer'
    3:
      id: 'broker_dealer'
      doc: 'BrokerDealer'
    4:
      id: 'broker_dealer_customer'
      doc: 'BrokerDealerCustomer'
    5:
      id: 'firm'
      doc: 'Firm'
    6:
      id: 'market_maker'
      doc: 'MarketMaker'
    7:
      id: 'away_market_maker'
      doc: 'AwayMarketMaker'
    255:
      id: 'null_value'
      doc: 'NullValue'
  cancel_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'user_requested_cancel'
      doc: 'UserRequestedCancel'
    5:
      id: 'execution_price_collar'
      doc: 'ExecutionPriceCollar'
    6:
      id: 'halted'
      doc: 'Halted'
    7:
      id: 'exchange_supervisory'
      doc: 'ExchangeSupervisory'
    8:
      id: 'order_expired'
      doc: 'OrderExpired'
    10:
      id: 'match_trade_prevention'
      doc: 'MatchTradePrevention'
    13:
      id: 'participant_disconnect'
      doc: 'ParticipantDisconnect'
    14:
      id: 'order_not_bookable'
      doc: 'OrderNotBookable'
    17:
      id: 'firm_disabled'
      doc: 'FirmDisabled'
    18:
      id: 'efid_disabled'
      doc: 'EFIDDisabled'
    19:
      id: 'account_disabled'
      doc: 'AccountDisabled'
    22:
      id: 'quote_update_rejected_orig_quote_canceled'
      doc: 'QuoteUpdateRejectedOrigQuoteCanceled'
    23:
      id: 'active_risk_breach'
      doc: 'ActiveRiskBreach'
    24:
      id: 'manual_risk_breach'
      doc: 'ManualRiskBreach'
    25:
      id: 'num_contracts_executed_exceeds_threshold'
      doc: 'NumContractsExecutedExceedsThreshold'
    26:
      id: 'notional_value_of_executions_exceeds_threshold'
      doc: 'NotionalValueOfExecutionsExceedsThreshold'
    27:
      id: 'count_of_executions_exceeds_threshold'
      doc: 'CountOfExecutionsExceedsThreshold'
    28:
      id: 'outstanding_percentage_threshold_exceeded'
      doc: 'OutstandingPercentageThresholdExceeded'
    29:
      id: 'trips_threshold_exceeded'
      doc: 'TripsThresholdExceeded'
    30:
      id: 'gross_notional_value_exceeds_threshold'
      doc: 'GrossNotionalValueExceedsThreshold'
    31:
      id: 'net_notional_value_exceeds_threshold'
      doc: 'NetNotionalValueExceedsThreshold'
    32:
      id: 'duplicate_order_threshold_exceeded'
      doc: 'DuplicateOrderThresholdExceeded'
    33:
      id: 'order_rate_threshold_exceeded'
      doc: 'OrderRateThresholdExceeded'
    34:
      id: 'market_order_gross_notional_value_exceeds_threshold'
      doc: 'MarketOrderGrossNotionalValueExceedsThreshold'
    35:
      id: 'market_order_net_notional_value_exceeds_threshold'
      doc: 'MarketOrderNetNotionalValueExceedsThreshold'
    36:
      id: 'market_order_nbbo_width_exceeded'
      doc: 'MarketOrderNBBOWidthExceeded'
    37:
      id: 'market_order_no_national_best_bid'
      doc: 'MarketOrderNoNationalBestBid'
    38:
      id: 'market_order_no_national_best_offer'
      doc: 'MarketOrderNoNationalBestOffer'
    39:
      id: 'drill_through_price_exceeded'
      doc: 'DrillThroughPriceExceeded'
    40:
      id: 'order_would_lock_or_cross'
      doc: 'OrderWouldLockOrCross'
    41:
      id: 'mass_cancel_request'
      doc: 'MassCancelRequest'
    42:
      id: 'locked_or_crossed_market'
      doc: 'LockedOrCrossedMarket'
    255:
      id: 'null_value'
      doc: 'NullValue'
  exec_restatement_reason:
    3:
      id: 'order_reprice'
      doc: 'OrderReprice'
    5:
      id: 'match_trade_prevention'
      doc: 'MatchTradePrevention'
    99:
      id: 'other'
      doc: 'Other'
    255:
      id: 'null_value'
      doc: 'NullValue'
  extended_restatement_reason:
    0:
      id: 'none'
      doc: 'None'
    3:
      id: 'match_trade_cancel_newest'
      doc: 'MatchTradeCancelNewest'
    4:
      id: 'match_trade_cancel_oldest'
      doc: 'MatchTradeCancelOldest'
    6:
      id: 'match_trade_cancel_both'
      doc: 'MatchTradeCancelBoth'
    255:
      id: 'null_value'
      doc: 'NullValue'
  mass_cancel_reject_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    2:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdID'
    3:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdID'
    4:
      id: 'missing_efid'
      doc: 'MissingEFID'
    5:
      id: 'invalid_efid'
      doc: 'InvalidEFID'
    6:
      id: 'missing_underlying_or_series'
      doc: 'MissingUnderlyingOrSeries'
    7:
      id: 'invalid_underlying_or_series'
      doc: 'InvalidUnderlyingOrSeries'
    8:
      id: 'missing_underlier'
      doc: 'MissingUnderlier'
    9:
      id: 'invalid_underlier'
      doc: 'InvalidUnderlier'
    10:
      id: 'missing_options_security_id'
      doc: 'MissingOptionsSecurityID'
    11:
      id: 'invalid_options_security_id'
      doc: 'InvalidOptionsSecurityID'
    12:
      id: 'missing_cancel_group_id'
      doc: 'MissingCancelGroupID'
    13:
      id: 'invalid_cancel_group_id'
      doc: 'InvalidCancelGroupID'
    14:
      id: 'missing_mass_cancel_inst'
      doc: 'MissingMassCancelInst'
    15:
      id: 'invalid_mass_cancel_inst'
      doc: 'InvalidMassCancelInst'
    17:
      id: 'mass_cancel_in_progress'
      doc: 'MassCancelInProgress'
    18:
      id: 'missing_sending_time'
      doc: 'MissingSendingTime'
    19:
      id: 'invalid_sending_time'
      doc: 'InvalidSendingTime'
    65535:
      id: 'null_value'
      doc: 'NullValue'
  cxl_rej_response_to:
    0x31:
      id: 'order_cancel_request'
      doc: 'OrderCancelRequest'
    0x32:
      id: 'order_cancel_replace_request'
      doc: 'OrderCancelReplaceRequest'
  cxl_rej_reason:
    0:
      id: 'too_late_to_cancel'
      doc: 'TooLateToCancel'
    1:
      id: 'unknown_order'
      doc: 'UnknownOrder'
    3:
      id: 'order_already_pending_cancel_or_replace'
      doc: 'OrderAlreadyPendingCancelOrReplace'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    8:
      id: 'price_exceeds_current_price_band'
      doc: 'PriceExceedsCurrentPriceBand'
    18:
      id: 'invalid_price_increment'
      doc: 'InvalidPriceIncrement'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'missing_symbol'
      doc: 'MissingSymbol'
    101:
      id: 'invalid_symbol'
      doc: 'InvalidSymbol'
    102:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdID'
    103:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdID'
    104:
      id: 'missing_side'
      doc: 'MissingSide'
    105:
      id: 'invalid_side'
      doc: 'InvalidSide'
    106:
      id: 'missing_order_qty'
      doc: 'MissingOrderQty'
    107:
      id: 'invalid_order_qty'
      doc: 'InvalidOrderQty'
    108:
      id: 'missing_order_type'
      doc: 'MissingOrderType'
    109:
      id: 'invalid_order_type'
      doc: 'InvalidOrderType'
    110:
      id: 'missing_limit_price'
      doc: 'MissingLimitPrice'
    111:
      id: 'invalid_limit_price'
      doc: 'InvalidLimitPrice'
    114:
      id: 'missing_list_seq_no'
      doc: 'MissingListSeqNo'
    115:
      id: 'invalid_list_seq_no'
      doc: 'InvalidListSeqNo'
    116:
      id: 'missing_orig_cl_ord_id'
      doc: 'MissingOrigClOrdID'
    117:
      id: 'invalid_orig_cl_ord_id'
      doc: 'InvalidOrigClOrdID'
    118:
      id: 'missing_order_id'
      doc: 'MissingOrderID'
    119:
      id: 'invalid_order_id'
      doc: 'InvalidOrderID'
    120:
      id: 'missing_sending_time'
      doc: 'MissingSendingTime'
    121:
      id: 'invalid_sending_time'
      doc: 'InvalidSendingTime'
    200:
      id: 'halted'
      doc: 'Halted'
    201:
      id: 'firm_disabled'
      doc: 'FirmDisabled'
    202:
      id: 'efid_disabled'
      doc: 'EFIDDisabled'
    203:
      id: 'account_disabled'
      doc: 'AccountDisabled'
    204:
      id: 'unsupported_ord_type_change'
      doc: 'UnsupportedOrdTypeChange'
    205:
      id: 'unsupported_side_change'
      doc: 'UnsupportedSideChange'
    206:
      id: 'symbol_mismatch'
      doc: 'SymbolMismatch'
    207:
      id: 'orig_order_id_mismatch'
      doc: 'OrigOrderIDMismatch'
    208:
      id: 'unsupported_order_property_change'
      doc: 'UnsupportedOrderPropertyChange'
    300:
      id: 'non_test_symbols_blocked'
      doc: 'NonTestSymbolsBlocked'
    301:
      id: 'notional_value_exceeds_threshold'
      doc: 'NotionalValueExceedsThreshold'
    302:
      id: 'max_notional_value_per_order_risk_rule_violated'
      doc: 'MaxNotionalValuePerOrderRiskRuleViolated'
    303:
      id: 'block_non_test_symbol_risk_rule_violated'
      doc: 'BlockNonTestSymbolRiskRuleViolated'
    304:
      id: 'max_contracts_per_order_risk_rule_violated'
      doc: 'MaxContractsPerOrderRiskRuleViolated'
    305:
      id: 'nbbo_width_exceeds_threshold'
      doc: 'NBBOWidthExceedsThreshold'
    306:
      id: 'exchange_price_value_collar_risk_rule_violated'
      doc: 'ExchangePriceValueCollarRiskRuleViolated'
    307:
      id: 'execution_price_higher_than_strike_price'
      doc: 'ExecutionPriceHigherThanStrikePrice'
    308:
      id: 'market_buy_when_nbo_is_zero'
      doc: 'MarketBuyWhenNBOIsZero'
    309:
      id: 'market_sell_when_nbb_greater_than_threshold'
      doc: 'MarketSellWhenNBBGreaterThanThreshold'
    310:
      id: 'quote_price_outside_exchange_threshold'
      doc: 'QuotePriceOutsideExchangeThreshold'
    312:
      id: 'num_contracts_executed_exceeds_threshold'
      doc: 'NumContractsExecutedExceedsThreshold'
    313:
      id: 'notional_value_of_executions_exceeds_threshold'
      doc: 'NotionalValueOfExecutionsExceedsThreshold'
    314:
      id: 'count_of_executions_exceeds_threshold'
      doc: 'CountOfExecutionsExceedsThreshold'
    315:
      id: 'outstanding_percentage_threshold_exceeded'
      doc: 'OutstandingPercentageThresholdExceeded'
    316:
      id: 'trips_threshold_exceeded'
      doc: 'TripsThresholdExceeded'
    317:
      id: 'iso_orders_not_allowed'
      doc: 'ISOOrdersNotAllowed'
    318:
      id: 'market_is_crossed'
      doc: 'MarketIsCrossed'
    319:
      id: 'active_risk_breach'
      doc: 'ActiveRiskBreach'
    320:
      id: 'manual_risk_breach'
      doc: 'ManualRiskBreach'
    321:
      id: 'gross_notional_value_exceeds_threshold'
      doc: 'GrossNotionalValueExceedsThreshold'
    322:
      id: 'net_notional_value_exceeds_threshold'
      doc: 'NetNotionalValueExceedsThreshold'
    323:
      id: 'duplicate_order_threshold_exceeded'
      doc: 'DuplicateOrderThresholdExceeded'
    324:
      id: 'order_rate_threshold_exceeded'
      doc: 'OrderRateThresholdExceeded'
    325:
      id: 'mass_cancel_lockout_in_effect'
      doc: 'MassCancelLockoutInEffect'
    326:
      id: 'market_order_gross_notional_value_exceeds_threshold'
      doc: 'MarketOrderGrossNotionalValueExceedsThreshold'
    327:
      id: 'market_order_net_notional_value_exceeds_threshold'
      doc: 'MarketOrderNetNotionalValueExceedsThreshold'
    328:
      id: 'limit_order_fat_finger_check'
      doc: 'LimitOrderFatFingerCheck'
    329:
      id: 'bulk_quote_fat_finger_check'
      doc: 'BulkQuoteFatFingerCheck'
    65535:
      id: 'null_value'
      doc: 'NullValue'
  alloc_status:
    0:
      id: 'accepted'
      doc: 'Accepted'
    1:
      id: 'block_level_reject'
      doc: 'BlockLevelReject'
    2:
      id: 'account_level_reject'
      doc: 'AccountLevelReject'
    255:
      id: 'null_value'
      doc: 'NullValue'
  alloc_rej_code:
    1:
      id: 'incorrect_quantity'
      doc: 'IncorrectQuantity'
    8:
      id: 'incorrect_allocated_quantity'
      doc: 'IncorrectAllocatedQuantity'
    10:
      id: 'unknown_or_stale_exec_id'
      doc: 'UnknownOrStaleExecID'
    11:
      id: 'mismatched_data'
      doc: 'MismatchedData'
    14:
      id: 'duplicate_or_missing_individual_alloc_id'
      doc: 'DuplicateOrMissingIndividualAllocID'
    15:
      id: 'trade_not_recognized'
      doc: 'TradeNotRecognized'
    16:
      id: 'duplicate_trade'
      doc: 'DuplicateTrade'
    17:
      id: 'incorrect_or_missing_instrument'
      doc: 'IncorrectOrMissingInstrument'
    23:
      id: 'unknown_or_missing_party'
      doc: 'UnknownOrMissingParty'
    24:
      id: 'incorrect_or_missing_side'
      doc: 'IncorrectOrMissingSide'
    29:
      id: 'missing_position_effect_type'
      doc: 'MissingPositionEffectType'
    30:
      id: 'invalid_position_effect_type'
      doc: 'InvalidPositionEffectType'
    99:
      id: 'other'
      doc: 'Other'
    65535:
      id: 'null_value'
      doc: 'NullValue'
  alloc_canc_replace_reason:
    2:
      id: 'change_in_underlying_order_details'
      doc: 'ChangeInUnderlyingOrderDetails'
    65535:
      id: 'null_value'
      doc: 'NullValue'
  user_status:
    8:
      id: 'session_shutdown_warning'
      doc: 'SessionShutdownWarning'
    100:
      id: 'end_of_events_for_session'
      doc: 'EndOfEventsForSession'
    255:
      id: 'null_value'
      doc: 'NullValue'
  rej_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdID'
    2:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdID'
    3:
      id: 'missing_lockout_id'
      doc: 'MissingLockoutID'
    4:
      id: 'invalid_lockout_id'
      doc: 'InvalidLockoutID'
    5:
      id: 'unknown_lockout_id'
      doc: 'UnknownLockoutID'
    6:
      id: 'no_lockouts_active'
      doc: 'NoLockoutsActive'
    65535:
      id: 'null_value'
      doc: 'NullValue'

