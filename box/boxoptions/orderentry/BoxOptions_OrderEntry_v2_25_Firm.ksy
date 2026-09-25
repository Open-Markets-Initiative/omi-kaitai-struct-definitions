# ---------------------------------------------------------------------
# Kaitai struct definition for: Box BoxOptions OrderEntry Sail v2.25
#
# Protocol:
#   Organization: Box Options Market
#   Protocol: Order Entry
#   Encoding: Sola Access Information Language
#   Version: 2.25
#   Date: 01/20/2025
#   Specification: BOX-SAIL-Specifications-Guide-v2.25.pdf
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
  id: box_boxoptions_orderentry_sail_v2_25_firm
  title: Box BoxOptions OrderEntry Sail v2.25
  license: GPL-3.0
  endian: le

doc: 'Box Options Market BOX Options Exchange Order Entry Sail v2.25'

seq:
  - id: message_length
    type: u4
    doc: 'Length of the SAIL message, little endian, ahead of the message itself'
  - id: incoming_header
    type: incoming_header_struct
    doc: 'The header on all incoming Participant business messages'
  - id: firm_message
    size: message_length - 24
    type:
      switch-on: incoming_header.message_type
      cases:
        '""TC""': user_connection
        '""TD""': user_disconnection
        '""TA""': disconnection_instruction
        '""TI""': heartbeat_response
        '""BD""': bulk_quote_data
        '""GC""': global_cancellation
        '""GZ""': user_global_cancellation
        '""KQ""': directed_routed_order_rejection_and_quote
        '""OA""': auction_entry
        '""OD""': directed_order_acceptation
        '""OE""': order_entry
        '""OI""': improvement_order_entry
        '""OM""': order_modification
        '""ON""': new_complex_order_instrument
        '""OT""': complex_order_auction_entry
        '""Q<i>""': bulk_quote
        '""RP""': market_maker_protection_subscription
        '""RQ""': request_for_quote
        '""XE""': order_cancellation
        '""XI""': improvement_order_cancellation
  - id: end_of_text
    type: u1
    doc: 'End of text, a byte of binary 3, closing the message'

types:
  incoming_header_struct:
    seq:
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of Message'
      - id: user_time_local
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: user_sequence_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on'
  user_connection:
    seq:
      - id: protocol_version
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Protocol ID: Versions A0, A1, A2, and A5 are no longer supported. A6 (includes Complex Order), A7, A8, B1, B3'
      - id: user_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the User for a connection. The User ID must be referenced in the SOLA® configuration database'
      - id: password_md_5_encryption
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contact Technical Help Desk for details Used when establishing a SAIL Logical connection See section 7 for details on how to encode it'
      - id: session_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies current session ID If set to blank spaces, this means the Participant wants to connect to the current session ID'
      - id: time_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
      - id: exchange_message_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a Connection message as a retransmission starting point. If equal to zeroes: start from 1st message of the session. If equal to blanks: start from next message for Participant. If valid Exchange Message ID: start at this message ID or the next message for the Participant. If it contains spaces, it means that this field is not subject to re-transmission'
      - id: inactivity_interval
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of missed heartbeats before considering the user disconnected. If set to 0, the user is never considered as disconnected by the system'
      - id: num_user_connection_occurrence
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: user_connection_occurrence
        type: user_connection_occurrence
        repeat: expr
        repeat-expr: num_user_connection_occurrence
        doc: 'The guide states this block as (1 to 99 occurrences)'
  user_connection_occurrence:
    seq: []
  user_disconnection:
    seq:
      - id: user_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the User for a connection. The User ID must be referenced in the SOLA® configuration database'
      - id: session_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies current session ID If set to blank spaces, this means the Participant wants to connect to the current session ID'
  disconnection_instruction:
    seq:
      - id: num_disconnection_instruction_occurrence
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: disconnection_instruction_occurrence
        type: disconnection_instruction_occurrence
        repeat: expr
        repeat-expr: num_disconnection_instruction_occurrence
        doc: 'The guide states this block as 1 to 99 occurrences'
  disconnection_instruction_occurrence:
    seq:
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
  heartbeat_response:
    seq:
      - id: user_sequence_id_first_user_sequence_id_for_nextcurrent_heartbeat_period
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on'
      - id: last_exchange_message_id_sent_to_participant
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a Connection message as a retransmission starting point. If equal to zeroes: start from 1st message of the session. If equal to blanks: start from next message for Participant. If valid Exchange Message ID: start at this message ID or the next message for the Participant. If it contains spaces, it means that this field is not subject to re-transmission'
      - id: time_local
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
  bulk_quote_data:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: account_type
        type: u1
        enum: account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: hedge_spec
        type: u1
        enum: hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: filler_must_be_blank_string_22
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (2)'
      - id: filler_must_be_blank_2_string_88
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (8)'
      - id: filler_must_be_blank_3_string_22
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (2)'
      - id: calculation_time_interval
        type: str
        size: 8
        encoding: ASCII
        doc: 'Expressed in number of milliseconds'
      - id: maximum_total_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Stated inline as Numeric (8)'
      - id: maximum_total_value
        type: str
        size: 8
        encoding: ASCII
        doc: 'Stated inline as Numeric (8)'
      - id: maximum_delta_volume
        type: str
        size: 8
        encoding: ASCII
        doc: 'Stated inline as Numeric (8)'
      - id: maximum_delta_value
        type: str
        size: 8
        encoding: ASCII
        doc: 'Stated inline as Numeric (8)'
      - id: percent_of_quote
        type: str
        size: 8
        encoding: ASCII
        doc: 'Stated inline as Numeric (8)'
  global_cancellation:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: type_of_cancellation_q_quotes_only
        type: u1
        enum: type_of_cancellation_q_quotes_only
        doc: 'Type of cancellation A: All L: Locked O: OrdersOnly Q: QuotesOnly'
      - id: mm_cat_user_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time at which Market Maker sent their Bulk Quote message to BOX, represented in number of nanoseconds since midnight of the current day, use Eastern Time zone. Must be left blank if not used. BOX will not do any validation of the value provided. The Base62 character set is: “0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz” Any other character is evaluated as 0'
  user_global_cancellation:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: type_of_cancellation
        type: u1
        enum: type_of_cancellation
        doc: 'Type of cancellation A: All L: Locked O: OrdersOnly Q: QuotesOnly'
      - id: account_type_filter
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (8)'
      - id: mm_cat_user_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time at which Market Maker sent their Bulk Quote message to BOX, represented in number of nanoseconds since midnight of the current day, use Eastern Time zone. Must be left blank if not used. BOX will not do any validation of the value provided. The Base62 character set is: “0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz” Any other character is evaluated as 0'
  directed_routed_order_rejection_and_quote:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: rejection_code
        type: str
        size: 4
        encoding: ASCII
        doc: '0001: Executing Participant Discretion 0002: Auction Order failed'
      - id: quote_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: quote_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
  auction_entry:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: buying_clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: buying_account_type
        type: u1
        enum: buying_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: buying_open_close
        type: u1
        enum: buying_open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: buying_hedge_spec
        type: u1
        enum: buying_hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: buying_clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: selling_clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: selling_account_type
        type: u1
        enum: selling_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: selling_open_close
        type: u1
        enum: selling_open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: selling_hedge_spec
        type: u1
        enum: selling_hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: selling_clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: buying_client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: buying_pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: buying_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: selling_client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: selling_pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: selling_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: iml_handling
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'All Public Customer Orders sent to BOX must include NBBO filtering instructions: 1. NBBO Filtering and IML Routing: The order is filtered for NBBO and is routed to the best away Exchange if it is executed and BOX is not at NBBO. 2. No NBBO Filtering: The order is not filtered for NBBO. This type of filtering is not acceptable for Public Customer and Broker Dealer origin orders, regardless of whether they are for BOX Participants or not. 3. NBBO Filtering and No IML Routing: Order filtered against NBBO without Inter-Market Linkage routing instructions, the Order being rejected back to the sender if it is marketable at the time of reception and BOX is not at NBBO. For Complex Order, this is the only valid value. 4. InBound ISO order. The order is a Limit and IOC order. It is not filtered against NBBO and not routed away. 5. Contingent Orders: Specifies that the Auction or Floor Trade is contingent and should not be controlled against the NBBO for the execution price. Only used for Solicitation, Facilitation and Floor Trades. The only values supported for Solicitation and Facilitation are 3 and 5. 6. No Exposure for Complex Order Instrument upon entry. Default behaviour for Complex Order Instrument is to be exposed upon entry. Only valid for Complex Order'
      - id: special_price_term
        type: u1
        enum: special_price_term
        doc: 'PIP Solicitation Facilitation B: Solicitation Auction C: Facilitation Auction G: Regular PIP X: Customer Cross Order or Qualified Contingent Cross Order Note: These values specify the type of Auction to be started. Order Entry ’ ’: (Blank), No Special Price Term O: Directed Order P: Preferenced Order R: Floor Trade A: Indication of Interest'
      - id: additional_price_1
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: quantity_term_quantity_term_1
        type: u1
        enum: quantity_term_quantity_term_1
        doc: 'B: Surrender Quantity for Solicitation, Facilitation and Floor Trade J: Indicates that the Auction type as MIP Space: None The above value indicates that the InitO is willing to surrender a portion of the total number of contracts'
      - id: additional_quantity_additional_quantity_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'For OA Auction Entry, indicates the number of contracts the InitO is willing to surrender. For Solicitation, Facilitation and Floor Trade it is used when the field Quantity Term is set to ’B’. It must contain a quantity less than or equal to the quantity being auctioned'
      - id: buying_additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
      - id: selling_additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
      - id: filler_must_be_blank_string_44
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (4)'
  directed_order_acceptation:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: referenced_order_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: auction_starting_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: clearing_instruction_dealer
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: account_type_dealer
        type: u1
        enum: account_type_dealer
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: open_close_dealer
        type: u1
        enum: open_close_dealer
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: hedge_spec_dealer
        type: u1
        enum: hedge_spec_dealer
        doc: 'H: Hedger S: Speculator'
      - id: clearing_destination_dealer
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: client_order_id_dealer
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: pound_sign_dealer
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: memo_dealer
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: additional_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: quantity_term_quantity_term_1
        type: u1
        enum: quantity_term_quantity_term_1
        doc: 'B: Surrender Quantity for Solicitation, Facilitation and Floor Trade J: Indicates that the Auction type as MIP Space: None The above value indicates that the InitO is willing to surrender a portion of the total number of contracts'
      - id: additional_quantity_quantity_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
  order_entry:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'For regular order: L: Limit (price set in message) O: At Opening price W: At any price (Market Order)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: special_price_term
        type: u1
        enum: special_price_term
        doc: 'PIP Solicitation Facilitation B: Solicitation Auction C: Facilitation Auction G: Regular PIP X: Customer Cross Order or Qualified Contingent Cross Order Note: These values specify the type of Auction to be started. Order Entry ’ ’: (Blank), No Special Price Term O: Directed Order P: Preferenced Order R: Floor Trade A: Indication of Interest'
      - id: filler_must_be_blank_string_1010
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (10)'
      - id: quantity_term_quantity_term_1
        type: u1
        enum: quantity_term_quantity_term_1
        doc: 'B: Surrender Quantity for Solicitation, Facilitation and Floor Trade J: Indicates that the Auction type as MIP Space: None The above value indicates that the InitO is willing to surrender a portion of the total number of contracts'
      - id: additional_quantity_additional_quantity_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'For OA Auction Entry, indicates the number of contracts the InitO is willing to surrender. For Solicitation, Facilitation and Floor Trade it is used when the field Quantity Term is set to ’B’. It must contain a quantity less than or equal to the quantity being auctioned'
      - id: duration_type
        type: u1
        enum: duration_type
        doc: 'A: Auction or Kill D: Order is Valid until GTD date (GTD) E: Immediate order, cannot be booked (FAK) F: Valid until instrument expiration (GTC) J: Valid for the current Day only (Day) W: Valid for the current session order only'
      - id: gtd_date_1
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Year, Month and Day (YYYYMMDD)'
      - id: executing_participant_2
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: iml_handling
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'All Public Customer Orders sent to BOX must include NBBO filtering instructions: 1. NBBO Filtering and IML Routing: The order is filtered for NBBO and is routed to the best away Exchange if it is executed and BOX is not at NBBO. 2. No NBBO Filtering: The order is not filtered for NBBO. This type of filtering is not acceptable for Public Customer and Broker Dealer origin orders, regardless of whether they are for BOX Participants or not. 3. NBBO Filtering and No IML Routing: Order filtered against NBBO without Inter-Market Linkage routing instructions, the Order being rejected back to the sender if it is marketable at the time of reception and BOX is not at NBBO. For Complex Order, this is the only valid value. 4. InBound ISO order. The order is a Limit and IOC order. It is not filtered against NBBO and not routed away. 5. Contingent Orders: Specifies that the Auction or Floor Trade is contingent and should not be controlled against the NBBO for the execution price. Only used for Solicitation, Facilitation and Floor Trades. The only values supported for Solicitation and Facilitation are 3 and 5. 6. No Exposure for Complex Order Instrument upon entry. Default behaviour for Complex Order Instrument is to be exposed upon entry. Only valid for Complex Order'
      - id: clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: account_type
        type: u1
        enum: account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: hedge_spec
        type: u1
        enum: hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
      - id: filler_must_be_blank_2_string_44
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (4)'
  improvement_order_entry:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a quote or an order update, it identifies how to handle the quantity: "+": Add the incoming quantity to the booked quantity "-": Subtract the incoming quantity from the booked quantity "=": Replace the booked quantity with the incoming quantity Participants are able to modify the quantity of an order by specifying the quantity variation from the original value (+, - signs) instead of being limited to specifying only the remaining quantity'
      - id: quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: auction_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction'
      - id: filler_string_1717
        type: str
        size: 17
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (17)'
      - id: clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: account_type
        type: u1
        enum: account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: hedge_spec
        type: u1
        enum: hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
      - id: filler_must_be_blank_string_44
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (4)'
  order_modification:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'For regular order: L: Limit (price set in message) O: At Opening price W: At any price (Market Order)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a quote or an order update, it identifies how to handle the quantity: "+": Add the incoming quantity to the booked quantity "-": Subtract the incoming quantity from the booked quantity "=": Replace the booked quantity with the incoming quantity Participants are able to modify the quantity of an order by specifying the quantity variation from the original value (+, - signs) instead of being limited to specifying only the remaining quantity'
      - id: quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: special_price_term
        type: u1
        enum: special_price_term
        doc: 'PIP Solicitation Facilitation B: Solicitation Auction C: Facilitation Auction G: Regular PIP X: Customer Cross Order or Qualified Contingent Cross Order Note: These values specify the type of Auction to be started. Order Entry ’ ’: (Blank), No Special Price Term O: Directed Order P: Preferenced Order R: Floor Trade A: Indication of Interest'
      - id: filler_must_be_blank_string_1010
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (10)'
      - id: filler_must_be_blank_2_string_11
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (1)'
      - id: filler_must_be_blank_3_string_88
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (8)'
      - id: duration_type
        type: u1
        enum: duration_type
        doc: 'A: Auction or Kill D: Order is Valid until GTD date (GTD) E: Immediate order, cannot be booked (FAK) F: Valid until instrument expiration (GTC) J: Valid for the current Day only (Day) W: Valid for the current session order only'
      - id: gtd_date_1
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Year, Month and Day (YYYYMMDD)'
      - id: firm_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: iml_handling
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'All Public Customer Orders sent to BOX must include NBBO filtering instructions: 1. NBBO Filtering and IML Routing: The order is filtered for NBBO and is routed to the best away Exchange if it is executed and BOX is not at NBBO. 2. No NBBO Filtering: The order is not filtered for NBBO. This type of filtering is not acceptable for Public Customer and Broker Dealer origin orders, regardless of whether they are for BOX Participants or not. 3. NBBO Filtering and No IML Routing: Order filtered against NBBO without Inter-Market Linkage routing instructions, the Order being rejected back to the sender if it is marketable at the time of reception and BOX is not at NBBO. For Complex Order, this is the only valid value. 4. InBound ISO order. The order is a Limit and IOC order. It is not filtered against NBBO and not routed away. 5. Contingent Orders: Specifies that the Auction or Floor Trade is contingent and should not be controlled against the NBBO for the execution price. Only used for Solicitation, Facilitation and Floor Trades. The only values supported for Solicitation and Facilitation are 3 and 5. 6. No Exposure for Complex Order Instrument upon entry. Default behaviour for Complex Order Instrument is to be exposed upon entry. Only valid for Complex Order'
      - id: modified_order_id_2
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: account_type
        type: u1
        enum: account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: hedge_spec
        type: u1
        enum: hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
      - id: filler_must_be_blank_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (4)'
  new_complex_order_instrument:
    seq:
      - id: enabled_y_yes_n_no
        type: u1
        enum: enabled_y_yes_n_no
        doc: 'Y: Yes N: No'
      - id: num_new_complex_order_instrument_occurrence
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: new_complex_order_instrument_occurrence
        type: new_complex_order_instrument_occurrence
        repeat: expr
        repeat-expr: num_new_complex_order_instrument_occurrence
        doc: 'The guide states this block as 2 to 16 occurrences'
  new_complex_order_instrument_occurrence:
    seq: []
  complex_order_auction_entry:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: buying_clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: buying_account_type
        type: u1
        enum: buying_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: buying_open_close
        type: u1
        enum: buying_open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: buying_hedge_spec
        type: u1
        enum: buying_hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: buying_clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: selling_clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Account Number Following characters are accepted but are not transferred to OCC on trade submissions: > (greater than), < (less than), ‘ (single quote), “ (double quote), & (ampersand)'
      - id: selling_account_type
        type: u1
        enum: selling_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: selling_open_close
        type: u1
        enum: selling_open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system. Valid Values for options and individual leg of a Complex Order instrument: C: Close (all legs or single instrument) O: Open (all legs or single instrument) For Complex Orders, '' '' must be used. It indicates that the OpenClose positions are specified in the Post Trading Instruction field. For Legacy support, the following values are still supported for Complex Orders: 1: 1st leg Open, 2nd leg Close 2: 1st leg Close, 2nd leg Open 3: 1st leg Open, 2nd leg Open, 3rd leg Close 4: 1st leg Open, 2nd leg Close, 3rd leg Open 5: 1st leg Open, 2nd leg Close, 3rd leg Close 6: 1st leg Close, 2nd leg Open, 3rd leg Open 7: 1st leg Close, 2nd leg Open, 3rd leg Close 8: 1st leg Close, 2nd leg Close, 3rd leg Open A: 1st leg Open, 2nd leg Open, 3rd leg Open, 4th leg Close B: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Open D: 1st leg Open, 2nd leg Open, 3rd leg Close, 4th leg Close E: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Open F: 1st leg Open, 2nd leg Close, 3rd leg Open, 4th leg Close G: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Open H: 1st leg Open, 2nd leg Close, 3rd leg Close, 4th leg Close I: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Open J: 1st leg Close, 2nd leg Open, 3rd leg Open, 4th leg Close K: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Open L: 1st leg Close, 2nd leg Open, 3rd leg Close, 4th leg Close M: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Open N: 1st leg Close, 2nd leg Close, 3rd leg Open, 4th leg Close P: 1st leg Close, 2nd leg Close, 3rd leg Close, 4th leg Open'
      - id: selling_hedge_spec
        type: u1
        enum: selling_hedge_spec
        doc: 'H: Hedger S: Speculator'
      - id: selling_clearing_destination
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: buying_client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: buying_pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: buying_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: selling_client_order_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant'
      - id: selling_pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: selling_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field'
      - id: iml_handling
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'All Public Customer Orders sent to BOX must include NBBO filtering instructions: 1. NBBO Filtering and IML Routing: The order is filtered for NBBO and is routed to the best away Exchange if it is executed and BOX is not at NBBO. 2. No NBBO Filtering: The order is not filtered for NBBO. This type of filtering is not acceptable for Public Customer and Broker Dealer origin orders, regardless of whether they are for BOX Participants or not. 3. NBBO Filtering and No IML Routing: Order filtered against NBBO without Inter-Market Linkage routing instructions, the Order being rejected back to the sender if it is marketable at the time of reception and BOX is not at NBBO. For Complex Order, this is the only valid value. 4. InBound ISO order. The order is a Limit and IOC order. It is not filtered against NBBO and not routed away. 5. Contingent Orders: Specifies that the Auction or Floor Trade is contingent and should not be controlled against the NBBO for the execution price. Only used for Solicitation, Facilitation and Floor Trades. The only values supported for Solicitation and Facilitation are 3 and 5. 6. No Exposure for Complex Order Instrument upon entry. Default behaviour for Complex Order Instrument is to be exposed upon entry. Only valid for Complex Order'
      - id: special_price_term
        type: u1
        enum: special_price_term
        doc: 'PIP Solicitation Facilitation B: Solicitation Auction C: Facilitation Auction G: Regular PIP X: Customer Cross Order or Qualified Contingent Cross Order Note: These values specify the type of Auction to be started. Order Entry ’ ’: (Blank), No Special Price Term O: Directed Order P: Preferenced Order R: Floor Trade A: Indication of Interest'
      - id: additional_price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: quantity_term_quantity_sign_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a quote or an order update, it identifies how to handle the quantity: "+": Add the incoming quantity to the booked quantity "-": Subtract the incoming quantity from the booked quantity "=": Replace the booked quantity with the incoming quantity Participants are able to modify the quantity of an order by specifying the quantity variation from the original value (+, - signs) instead of being limited to specifying only the remaining quantity'
      - id: additional_quantity_quantity_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: buying_additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
      - id: selling_additional_client_memo
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted'
      - id: filler_must_be_blank_string_44
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (4)'
      - id: num_complex_order_auction_entry_occurrence
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: complex_order_auction_entry_occurrence
        type: complex_order_auction_entry_occurrence
        repeat: expr
        repeat-expr: num_complex_order_auction_entry_occurrence
        doc: 'The guide states this block as 2 to 16 occurrences'
  complex_order_auction_entry_occurrence:
    seq: []
  bulk_quote:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: quote_id_identifies_traders_quote_on_this_group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'If entered by Participant Quote ID is validated against the Quote ID received in the KD “Sail Bulk Quote Acknowledgment message”, On failed validation the system returns an ER “Sail Error Notice” message with the expected Quote ID. An empty Quote ID is accepted and not validated by the system. An empty Quote ID is defined as follows: All ‘ ‘ (blank) spaces 00000000 On all outbound messages with Quote ID, the Quote ID corresponds to the Quote ID referenced in the KD message'
      - id: mm_cat_user_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time at which Market Maker sent their Bulk Quote message to BOX, represented in number of nanoseconds since midnight of the current day, use Eastern Time zone. Must be left blank if not used. BOX will not do any validation of the value provided. The Base62 character set is: “0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz” Any other character is evaluated as 0'
      - id: num_bulk_quote_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_occurrence
        type: bulk_quote_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_occurrence
        doc: 'The guide states this block as 1 to 280 occurrences'
  bulk_quote_occurrence:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For a quote or an order update, it identifies how to handle the quantity: "+": Add the incoming quantity to the booked quantity "-": Subtract the incoming quantity from the booked quantity "=": Replace the booked quantity with the incoming quantity Participants are able to modify the quantity of an order by specifying the quantity variation from the original value (+, - signs) instead of being limited to specifying only the remaining quantity'
      - id: quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
  market_maker_protection_subscription:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: protection_type_advanced_normal
        type: u1
        enum: protection_type_advanced_normal
        doc: 'Type of protection requested by the Market Maker A: Advanced Protection C: Functionally equivalent to N N: Standard Protection Note: If no Market Maker Protection Subscription message is sent, BOX will assume the Participant requested standard protection (N). BOX will reset the selected protection to standard every morning before the pre-opening phase. A new Market Maker Protection Subscription message will be required to activate advanced protection'
  request_for_quote:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: quantity_1
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
  order_cancellation:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: cancelled_order_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
  improvement_order_cancellation:
    seq:
      - id: group
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification within a Group'
      - id: cancelled_order_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'

enums:
  account_type:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
  open_close:
    0x43:
      id: 'close_all_legs_or_single_instrument'
      doc: 'Close All Legs Or Single Instrument'
    0x4f:
      id: 'open_all_legs_or_single_instrument_for_complex_orders_must_be_used_it_indicates_that_the_open_close_positions_are_specified_in_the_post_trading_instruction_field_for_legacy_support_the_following_values_are_still_supported_for_complex_orders'
      doc: 'Open All Legs Or Single Instrument For Complex Orders Must Be Used It Indicates That The Open Close Positions Are Specified In The Post Trading Instruction Field For Legacy Support The Following Values Are Still Supported For Complex Orders'
    0x31:
      id: 'legs_1_st_leg_open_2_nd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close'
    0x32:
      id: 'legs_1_st_leg_close_2_nd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open'
    0x33:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close'
    0x34:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open'
    0x35:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close'
    0x36:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open'
    0x37:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close'
    0x38:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open'
    0x41:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x42:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x44:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x45:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x46:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x47:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
    0x48:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Close'
    0x49:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Open'
    0x4a:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x4b:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x4c:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x4d:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x4e:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x50:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
  hedge_spec:
    0x48:
      id: 'hedger'
      doc: 'Hedger'
    0x53:
      id: 'speculator'
      doc: 'Speculator'
  type_of_cancellation_q_quotes_only:
    0x41:
      id: 'all'
      doc: 'All'
    0x4c:
      id: 'locked'
      doc: 'Locked'
    0x4f:
      id: 'orders_only'
      doc: 'Orders Only'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
  type_of_cancellation:
    0x41:
      id: 'all'
      doc: 'All'
    0x4c:
      id: 'locked'
      doc: 'Locked'
    0x4f:
      id: 'orders_only'
      doc: 'Orders Only'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
  verb_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  buying_account_type:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
  buying_open_close:
    0x43:
      id: 'close_all_legs_or_single_instrument'
      doc: 'Close All Legs Or Single Instrument'
    0x4f:
      id: 'open_all_legs_or_single_instrument_for_complex_orders_must_be_used_it_indicates_that_the_open_close_positions_are_specified_in_the_post_trading_instruction_field_for_legacy_support_the_following_values_are_still_supported_for_complex_orders'
      doc: 'Open All Legs Or Single Instrument For Complex Orders Must Be Used It Indicates That The Open Close Positions Are Specified In The Post Trading Instruction Field For Legacy Support The Following Values Are Still Supported For Complex Orders'
    0x31:
      id: 'legs_1_st_leg_open_2_nd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close'
    0x32:
      id: 'legs_1_st_leg_close_2_nd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open'
    0x33:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close'
    0x34:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open'
    0x35:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close'
    0x36:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open'
    0x37:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close'
    0x38:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open'
    0x41:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x42:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x44:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x45:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x46:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x47:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
    0x48:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Close'
    0x49:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Open'
    0x4a:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x4b:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x4c:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x4d:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x4e:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x50:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
  buying_hedge_spec:
    0x48:
      id: 'hedger'
      doc: 'Hedger'
    0x53:
      id: 'speculator'
      doc: 'Speculator'
  selling_account_type:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
  selling_open_close:
    0x43:
      id: 'close_all_legs_or_single_instrument'
      doc: 'Close All Legs Or Single Instrument'
    0x4f:
      id: 'open_all_legs_or_single_instrument_for_complex_orders_must_be_used_it_indicates_that_the_open_close_positions_are_specified_in_the_post_trading_instruction_field_for_legacy_support_the_following_values_are_still_supported_for_complex_orders'
      doc: 'Open All Legs Or Single Instrument For Complex Orders Must Be Used It Indicates That The Open Close Positions Are Specified In The Post Trading Instruction Field For Legacy Support The Following Values Are Still Supported For Complex Orders'
    0x31:
      id: 'legs_1_st_leg_open_2_nd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close'
    0x32:
      id: 'legs_1_st_leg_close_2_nd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open'
    0x33:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close'
    0x34:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open'
    0x35:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close'
    0x36:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open'
    0x37:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close'
    0x38:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open'
    0x41:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x42:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x44:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x45:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x46:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x47:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
    0x48:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Close'
    0x49:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Open'
    0x4a:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x4b:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x4c:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x4d:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x4e:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x50:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
  selling_hedge_spec:
    0x48:
      id: 'hedger'
      doc: 'Hedger'
    0x53:
      id: 'speculator'
      doc: 'Speculator'
  special_price_term:
    0x42:
      id: 'solicitation_auction'
      doc: 'Solicitation Auction'
    0x43:
      id: 'facilitation_auction'
      doc: 'Facilitation Auction'
    0x47:
      id: 'regular_pip'
      doc: 'Regular Pip'
    0x58:
      id: 'customer_cross_order_or_qualified_contingent_cross_order'
      doc: 'Customer Cross Order Or Qualified Contingent Cross Order'
    0x4f:
      id: 'directed_order'
      doc: 'Directed Order'
    0x50:
      id: 'preferenced_order'
      doc: 'Preferenced Order'
    0x52:
      id: 'floor_trade'
      doc: 'Floor Trade'
    0x41:
      id: 'indication_of_interest'
      doc: 'Indication Of Interest'
  quantity_term_quantity_term_1:
    0x42:
      id: 'surrender_quantity_for_solicitation_facilitation_and_floor_trade'
      doc: 'Surrender Quantity For Solicitation Facilitation And Floor Trade'
    0x4a:
      id: 'indicates_that_the_auction_type_as_mip'
      doc: 'Indicates That The Auction Type As Mip'
  account_type_dealer:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
  open_close_dealer:
    0x43:
      id: 'close_all_legs_or_single_instrument'
      doc: 'Close All Legs Or Single Instrument'
    0x4f:
      id: 'open_all_legs_or_single_instrument_for_complex_orders_must_be_used_it_indicates_that_the_open_close_positions_are_specified_in_the_post_trading_instruction_field_for_legacy_support_the_following_values_are_still_supported_for_complex_orders'
      doc: 'Open All Legs Or Single Instrument For Complex Orders Must Be Used It Indicates That The Open Close Positions Are Specified In The Post Trading Instruction Field For Legacy Support The Following Values Are Still Supported For Complex Orders'
    0x31:
      id: 'legs_1_st_leg_open_2_nd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close'
    0x32:
      id: 'legs_1_st_leg_close_2_nd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open'
    0x33:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close'
    0x34:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open'
    0x35:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close'
    0x36:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open'
    0x37:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close'
    0x38:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open'
    0x41:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x42:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x44:
      id: 'legs_1_st_leg_open_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x45:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x46:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x47:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
    0x48:
      id: 'legs_1_st_leg_open_2_nd_leg_close_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Open 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Close'
    0x49:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Open'
    0x4a:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Open 4 Th Leg Close'
    0x4b:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Open'
    0x4c:
      id: 'legs_1_st_leg_close_2_nd_leg_open_3_rd_leg_close_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Open 3 Rd Leg Close 4 Th Leg Close'
    0x4d:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Open'
    0x4e:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_open_4_th_leg_close'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Open 4 Th Leg Close'
    0x50:
      id: 'legs_1_st_leg_close_2_nd_leg_close_3_rd_leg_close_4_th_leg_open'
      doc: 'Legs 1 St Leg Close 2 Nd Leg Close 3 Rd Leg Close 4 Th Leg Open'
  hedge_spec_dealer:
    0x48:
      id: 'hedger'
      doc: 'Hedger'
    0x53:
      id: 'speculator'
      doc: 'Speculator'
  price_type:
    0x4c:
      id: 'limit_price_set_in_message'
      doc: 'Limit Price Set In Message'
    0x4f:
      id: 'at_opening_price'
      doc: 'At Opening Price'
    0x57:
      id: 'at_any_price_market_order'
      doc: 'At Any Price Market Order'
  duration_type:
    0x41:
      id: 'auction_or_kill'
      doc: 'Auction Or Kill'
    0x44:
      id: 'order_is_valid_until_gtd_date_gtd'
      doc: 'Order Is Valid Until Gtd Date Gtd'
    0x45:
      id: 'immediate_order_cannot_be_booked_fak'
      doc: 'Immediate Order Cannot Be Booked Fak'
    0x46:
      id: 'valid_until_instrument_expiration_gtc'
      doc: 'Valid Until Instrument Expiration Gtc'
    0x4a:
      id: 'valid_for_the_current_day_only_day'
      doc: 'Valid For The Current Day Only Day'
    0x57:
      id: 'valid_for_the_current_session_order_only'
      doc: 'Valid For The Current Session Order Only'
  enabled_y_yes_n_no:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  protection_type_advanced_normal:
    0x41:
      id: 'advanced_protection'
      doc: 'Advanced Protection'
    0x43:
      id: 'functionally_equivalent_to_n'
      doc: 'Functionally Equivalent To N'
    0x4e:
      id: 'standard_protection'
      doc: 'Standard Protection'
  type_of_cancellation_only_q_quotes_only_can_be_returned:
    0x41:
      id: 'all'
      doc: 'All'
    0x4c:
      id: 'locked'
      doc: 'Locked'
    0x4f:
      id: 'orders_only'
      doc: 'Orders Only'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
  group_state:
    0x42:
      id: 'post_session'
      doc: 'Post Session'
    0x43:
      id: 'consultation_start'
      doc: 'Consultation Start'
    0x46:
      id: 'consultation_end'
      doc: 'Consultation End'
    0x49:
      id: 'prohibited'
      doc: 'Prohibited'
    0x4d:
      id: 'minibatch'
      doc: 'Minibatch'
    0x4e:
      id: 'market_operation_center_intervention'
      doc: 'Market Operation Center Intervention'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x50:
      id: 'preopening'
      doc: 'Preopening'
    0x53:
      id: 'continuous_trading_session'
      doc: 'Continuous Trading Session'
    0x5a:
      id: 'interrupted'
      doc: 'Interrupted'
  special_trade_indicator:
    0x41:
      id: 'as_of_trade'
      doc: 'As Of Trade'
    0x42:
      id: 'block_trade'
      doc: 'Block Trade'
    0x4c:
      id: 'late_trade'
      doc: 'Late Trade'
    0x4f:
      id: 'hidden_trade'
      doc: 'Hidden Trade'
    0x53:
      id: 'size_adjustment_trade'
      doc: 'Size Adjustment Trade'
    0x52:
      id: 'floor_trade'
      doc: 'Floor Trade'
    0x44:
      id: 'customer_cross_order_or_qualified_contingent_cross_order_applies_to_solicitation_facilitation_and_floor_trade_only'
      doc: 'Customer Cross Order Or Qualified Contingent Cross Order Applies To Solicitation Facilitation And Floor Trade Only'
    0x67:
      id: 'contingent_trade_trade_was_not_controlled_against_the_nbbo'
      doc: 'Contingent Trade Trade Was Not Controlled Against The Nbbo'
  trade_type:
    0x41:
      id: 'traded_during_a_guaranteed_auction'
      doc: 'Traded During A Guaranteed Auction'
    0x42:
      id: 'solicitation_auction'
      doc: 'Solicitation Auction'
    0x43:
      id: 'facilitation_auction'
      doc: 'Facilitation Auction'
    0x46:
      id: 'traded_during_continuous_trading_following_fifo_algorithm'
      doc: 'Traded During Continuous Trading Following Fifo Algorithm'
    0x4d:
      id: 'trade_entered_by_market_operations'
      doc: 'Trade Entered By Market Operations'
    0x4f:
      id: 'traded_during_opening'
      doc: 'Traded During Opening'
  liquidity_status:
    0x4d:
      id: 'maker'
      doc: 'Maker'
    0x54:
      id: 'taker'
      doc: 'Taker'
  strategy_verb_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  counterpart_account_type:
    0x36:
      id: 'public_customer'
      doc: 'Public Customer'
    0x37:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x38:
      id: 'market_maker'
      doc: 'Market Maker'
    0x54:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x57:
      id: 'broker_dealer_cleared_as_customer'
      doc: 'Broker Dealer Cleared As Customer'
    0x58:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
  quote_cancel_reason:
    0x41:
      id: 'cancelled_by_the_trader'
      doc: 'Cancelled By The Trader'
    0x44:
      id: 'mmp_percent_of_quote_has_been_reached'
      doc: 'Mmp Percent Of Quote Has Been Reached'
    0x45:
      id: 'maximum_triggers_protection_limit_exceeded'
      doc: 'Maximum Triggers Protection Limit Exceeded'
    0x47:
      id: 'cancelled_by_supervisor'
      doc: 'Cancelled By Supervisor'
    0x49:
      id: 'eliminated_on_disconnect'
      doc: 'Eliminated On Disconnect'
    0x4c:
      id: 'traded_activity_protection_limit_exceeded'
      doc: 'Traded Activity Protection Limit Exceeded'
    0x4d:
      id: 'cancelled_by_the_box_market_operations_center_moc'
      doc: 'Cancelled By The Box Market Operations Center Moc'
    0x4f:
      id: 'eliminated_due_to_drill_through_protection'
      doc: 'Eliminated Due To Drill Through Protection'
    0x50:
      id: 'mmp_max_number_of_trades_has_been_reached'
      doc: 'Mmp Max Number Of Trades Has Been Reached'
    0x51:
      id: 'quotes_cancelled'
      doc: 'Quotes Cancelled'
    0x52:
      id: 'mmp_max_value_has_been_reached'
      doc: 'Mmp Max Value Has Been Reached'
    0x53:
      id: 'cancelled_by_the_system'
      doc: 'Cancelled By The System'
    0x54:
      id: 'mmp_max_volume_has_been_reached'
      doc: 'Mmp Max Volume Has Been Reached'
    0x4e:
      id: 'mmp_max_delta_volume_has_been_reached'
      doc: 'Mmp Max Delta Volume Has Been Reached'
    0x56:
      id: 'mmp_max_delta_value_has_been_reached'
      doc: 'Mmp Max Delta Value Has Been Reached'
    0x57:
      id: 'cancel_pending'
      doc: 'Cancel Pending'
  verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  order_type:
    0x4f:
      id: 'order'
      doc: 'Order'
    0x51:
      id: 'quote'
      doc: 'Quote'
  action:
    0x51:
      id: 'quantity_update'
      doc: 'Quantity Update'
    0x53:
      id: 'shelved'
      doc: 'Shelved'
    0x55:
      id: 'unshelved'
      doc: 'Unshelved'

