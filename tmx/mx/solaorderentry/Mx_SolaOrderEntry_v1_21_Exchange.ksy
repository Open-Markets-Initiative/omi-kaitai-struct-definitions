# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaOrderEntry Sail v1.21
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Order Entry
#   Encoding: Sola Access Information Language
#   Version: 1.21
#   Date: 6/18/2020
#   Specification: MX SAIL Specifications Guide (1.21).pdf
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
  id: tmx_mx_solaorderentry_sail_v1_21_exchange
  title: Tmx Mx SolaOrderEntry Sail v1.21
  license: GPL-3.0
  endian: le

doc: 'TMX Group Montreal Exchange Sola Order Entry Sail v1.21'
doc-ref: https://www.tmxwebstore.com/products/mx-order-entry

seq:
  - id: message_length
    type: u4
    doc: 'Length of the business message in bytes'
  - id: message_type
    type: str
    size: 2
    encoding: ASCII
    doc: 'Type of message'
  - id: exchange_message
    size: message_length - 2
    type:
      switch-on: message_type
      cases:
        '"TK"': connection_acknowledgement
        '"TM"': disconnection_instruction_acknowledgement
        '"TH"': heartbeat_question
        '"TO"': out_of_sequence
        '"TE"': technical_error_notice
        '"TL"': disconnection_acknowledgement
        '"TT"': end_of_transmission
        '"AE"': order_reply
        '"ER"': error_notice
        '"KD"': bulk_quote_data_acknowledgement
        '"KE"': order_acknowledgement
        '"KG"': global_cancellation_confirmation
        '"KM"': order_modification_acknowledgement
        '"KN"': new_strategy_instrument_acknowledgement
        '"KO"': standard_acknowledgement
        '"KZ"': order_cancellation_acknowledgement
        '"LA"': bulk_quote_acknowledgement
        '"LB"': bulk_command_acknowledgement
        '"MN"': risk_limits_usage
        '"NE"': excluded_instrument_notice
        '"NG"': group_state_change
        '"NI"': instrument_state_change
        '"NL"': leg_execution_notice
        '"NO"': overstepped_order_or_quote_notice
        '"NP"': cancellation_of_all_quotes_notice
        '"NT"': execution_notice
        '"NX"': execution_cancellation_notice
        '"NY"': leg_execution_cancellation_notice
        '"NZ"': order_cancellation_notice_by_mod_or_system
        '"QW"': request_for_quote_with_side_acknowledgement
  - id: end_of_text
    type: u1
    doc: 'End of Text character closing each business message'
  - id: alignment_padding
    size: (4 - _io.pos % 4) % 4
    if: _io.pos % 4 != 0
    doc: 'Spaces for alignment, up to three bytes'

types:
  connection_acknowledgement:
    seq:
      - id: current_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID'
      - id: last_user_sequence_id_received
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
  disconnection_instruction_acknowledgement:
    seq:
      - id: current_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID'
      - id: last_user_sequence_id_received
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
  heartbeat_question:
    seq:
      - id: user_sequence_id_first_user_sequence_id_for_nextcurrent_heartbeat_period
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence'
      - id: last_exchange_message_id_sent_to_participant
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a connection message as a retransmission starting point. • Zeroes = start from 1st message of the session • Blanks = start from next message for Participant • Valid Exchange Message ID = start at this message ID or the next message for the Participant • Contains spaces = it means that this field is not subject to re-transmission'
      - id: trading_engine_timestamp_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
  out_of_sequence:
    seq:
      - id: received_user_sequence_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence'
      - id: expected_last_user_sequence_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence'
      - id: user_message_timestamp_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
  technical_error_notice:
    seq:
      - id: received_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Type of message'
      - id: preceding_user_sequence_id_received_zeroes_if_none
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence'
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Numeric identifier of the error'
      - id: error_position
        type: str
        size: 4
        encoding: ASCII
        doc: 'Determines the bytes at which an error has been detected'
      - id: error_message
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'First 100 characters of an erroneous message'
      - id: start_of_message_in_error
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (100)'
  disconnection_acknowledgement:
    seq:
      - id: current_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID'
      - id: last_user_sequence_id_received
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
  end_of_transmission:
    seq:
      - id: ended_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID'
      - id: last_user_sequence_id_received_if_no_business_message_has_been_received_on_this_connection_this_field_is_equal_to_zeroes
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
      - id: trading_engine_timestamp_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
  order_reply:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_remaining
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the system'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
  outgoing_messages_header:
    seq:
      - id: trading_engine_timestamp_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: user_sequence_id
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
      - id: exchange_message_id
        type: str_6_nullable
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a connection message as a retransmission starting point. • Zeroes = start from 1st message of the session • Blanks = start from next message for Participant • Valid Exchange Message ID = start at this message ID or the next message for the Participant • Contains spaces = it means that this field is not subject to re-transmission. Nullable, No Value ='
      - id: gap_sequence_id
        type: str
        size: 2
        encoding: ASCII
        doc: 'A numeric sequence (base 10) used to track gaps, running from 0 to 99 over and over. If the Participant detects a gap, they must reconnect with a Trader Connection message'
  clearing_data:
    seq:
      - id: clearing_instruction
        type: str
        size: 12
        encoding: ASCII
        doc: 'Client account number'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Identifies the type of account: 1 = Customer 2 = House 4 = Pro 5 = Non Client D = Non Client Shareholder H = Customer Shareholder I = Customer Insider L = Pro Shareholder N = House Insider O = House Shareholder R = Non Client Insider S = Pro Insider A combination of the above values without a comma may be used, but only within the GZ: User Global Cancellation message (see AccountType List below)'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Indicates how the Participant''s position will be handled by the clearing system:'
      - id: hedge_spec
        type: u1
        enum: hedge_spec
        doc: '• H = Hedger • S = Speculator'
      - id: filler_5
        size: 5
        doc: 'Stated inline as String (5)'
  owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field'
  error_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Numeric identifier of the error'
      - id: error_description
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stated inline as String (100)'
  bulk_quote_data_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: quote_id_identifies_traders_quote_on_this_group
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
  order_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the system'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the system'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
  global_cancellation_confirmation:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: type_of_cancellation_only_q_quotes_only_can_be_returned
        type: u1
        enum: type_of_cancellation_only_q_quotes_only_can_be_returned
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
  order_modification_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the system'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the system'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
  new_strategy_instrument_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: strategy_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: strategy_instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: creation_status
        type: u1
        enum: creation_status
        doc: 'Stated inline as String (1)'
      - id: num_new_strategy_instrument_acknowledgement_leg_definition_repeating_block
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: new_strategy_instrument_acknowledgement_leg_definition_repeating_block
        type: new_strategy_instrument_acknowledgement_leg_definition_repeating_block
        repeat: expr
        repeat-expr: num_new_strategy_instrument_acknowledgement_leg_definition_repeating_block.to_i
        doc: 'The guide states this block as (2 to 4 occurrences)'
  new_strategy_instrument_acknowledgement_leg_definition_repeating_block:
    seq:
      - id: leg_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: leg_instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: leg_verb
        type: u1
        enum: leg_verb
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: filler_1
        size: 1
        doc: 'Stated inline as String (1)'
      - id: leg_quantity_ratio
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
  standard_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: original_message_type_af_gz_ml_ox_or_rq
        type: str
        size: 2
        encoding: ASCII
        doc: 'Type of message'
  order_cancellation_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the system'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the system'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
  bulk_quote_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: quote_identifier_on_this_group
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: num_bulk_quote_acknowledgement_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_acknowledgement_occurrence
        type: bulk_quote_acknowledgement_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_acknowledgement_occurrence.to_i
        doc: 'The guide states this block as (1 to 280 occurrences)'
  bulk_quote_acknowledgement_occurrence:
    seq:
      - id: quote_number
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Numeric identifier of the error'
  bulk_command_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: num_bulk_command_acknowledgement_occurrence
        type: str
        size: 4
        encoding: ASCII
        doc: 'Stated inline as Numeric (4)'
      - id: bulk_command_acknowledgement_occurrence
        type: bulk_command_acknowledgement_occurrence
        repeat: expr
        repeat-expr: num_bulk_command_acknowledgement_occurrence.to_i
        doc: 'The guide states this block as (1 to 1000 occurrences)'
  bulk_command_acknowledgement_occurrence:
    seq:
      - id: command_number
        type: str
        size: 4
        encoding: ASCII
        doc: 'Stated inline as Numeric (4)'
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Numeric identifier of the error'
  risk_limits_usage:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: num_risk_limits_usage_occurrence
        type: str
        size: 4
        encoding: ASCII
        doc: 'Stated inline as Numeric (4)'
      - id: risk_limits_usage_occurrence
        type: risk_limits_usage_occurrence
        repeat: expr
        repeat-expr: num_risk_limits_usage_occurrence.to_i
        doc: 'The guide states this block as (1 to 350 occurrences)'
  risk_limits_usage_occurrence:
    seq:
      - id: usage_trader
        type: str_4_nullable
        doc: 'Last four (4) Characters of the Trader ID. Nullable, No Value ='
      - id: usage_group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value ='
      - id: usage_status
        type: u1
        enum: usage_status
        doc: 'Status of current usage vs limit: I = Info (current usage is below the warning level) L = Limit (usage is at or above the limit) R = Rejection (an order was rejected because either the limit is reached, or accepting the order would cause the limit to be exceeded) W = Warning (current usage is over the warning level)'
      - id: limit_type
        type: u1
        enum: limit_type
        doc: 'Type of limit: 1 = Net Exposure 2 = Long Exposure 3 = Short Exposure 4 = Net Position 5 = Long Position 6 = Short Position'
      - id: current_usage
        type: str
        size: 10
        encoding: ASCII
        doc: 'Represents price or quantity. Actual container type is context dependent. Note: Price or Quantity field contains a price when limit type is an Exposure Limit, o a quantity when limit type is a Position Limit'
      - id: limit_value
        type: str
        size: 10
        encoding: ASCII
        doc: 'Represents price or quantity. Actual container type is context dependent. Note: Price or Quantity field contains a price when limit type is an Exposure Limit, o a quantity when limit type is a Position Limit'
  excluded_instrument_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: filler_2
        size: 2
        doc: 'Stated inline as String (2)'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: filler_4
        size: 4
        doc: 'Stated inline as String (4)'
      - id: num_excluded_instrument_notice_occurrence
        type: str
        size: 4
        encoding: ASCII
        doc: 'Stated inline as Numeric (4)'
      - id: excluded_instrument_notice_occurrence
        type: excluded_instrument_notice_occurrence
        repeat: expr
        repeat-expr: num_excluded_instrument_notice_occurrence.to_i
        doc: 'The guide states this block as (1 to 200 occurrences)'
  excluded_instrument_notice_occurrence:
    seq:
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
  group_state_change:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: group_state
        type: u1
        enum: group_state
        doc: 'Indicates the new status of the group. For message type NG, it contains one of the following values: • C = Consultation Start • E = No Cancel Period • P = Pre-opening • O = Opening • S = Continuous Trading Session • F = Consultation End • N = MOD Intervention • M = Mini-Batch • B = Post-Session • I = Prohibited • Z = Interrupted'
  instrument_state_change:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: instrument_state
        type: u1
        enum: instrument_state
        doc: 'Instrument state: N = Normal. The instrument follows group state processing. F = Forbidden. Trading is forbidden for this instrument. Orders and quotes are rejected. R = Orders and quotes are processed in pre- opening if the group is in trading status'
  leg_execution_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: reference_id_order_id_or_quote_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str_4_nullable
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden. Nullable, No Value ='
      - id: strategy_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: strategy_instrument_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the strategy Instrument ID that has traded in the system'
      - id: strategy_verb_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Verb of the strategy order as specified in the NT: Execution Notice message of the strategy'
      - id: strategy_trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Trade number of the strategy order as specified in the NT message of the strategy'
      - id: leg_number
        type: str
        size: 2
        encoding: ASCII
        doc: 'ID of the leg of the strategy instrument. Maximum value of 40'
  overstepped_order_or_quote_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: verb
        type: u1
        enum: verb
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Indicates the order type: O = Order Q = Quote'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: counterpart_trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: counterpart_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: counterpart_owner_data
        type: counterpart_owner_data
        doc: 'Owner Data of the counterpart, which NO: Overstepped Order or Quote Notice carries'
  counterpart_owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field'
  cancellation_of_all_quotes_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Cancel Reason for emitting the NP:Cancellation of All Quotes Notice message: A = Cancelled by Trader C = Cancelled by Circuit Breaker G = Cancelled by Supervisor I = Eliminated by Disconnection M = Cancelled by MOD N = BQM - Maximum Delta Volume has been reached P = BQM - Maximum Number of Trades has been reached R = BQM - Maximum Value has been reached S = Cancelled by System T= BQM - Maximum Volume has been reached V = BQM - Maximum Delta Value has been reached W = Cancel Pending'
  execution_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: reference_id_order_id_or_quote_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str_4_nullable
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden. Nullable, No Value ='
  execution_cancellation_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: reference_id_order_id_or_quote_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str_4_nullable
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden. Nullable, No Value ='
  leg_execution_cancellation_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: reference_id_order_id_or_quote_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str_4_nullable
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden. Nullable, No Value ='
      - id: strategy_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: strategy_instrument_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the strategy Instrument ID that has traded in the system'
      - id: strategy_verb_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Verb of the strategy order as specified in the NT: Execution Notice message of the strategy'
      - id: strategy_trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Trade number of the strategy order as specified in the NT message of the strategy'
      - id: leg_number
        type: str
        size: 2
        encoding: ASCII
        doc: 'ID of the leg of the strategy instrument. Maximum value of 40'
  order_cancellation_notice_by_mod_or_system:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the system'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the system'
      - id: filler_6
        size: 6
        doc: 'Stated inline as Numeric (6)'
  request_for_quote_with_side_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a group'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'The market side of interest. Must be equal either to ‘B’ (Buy), ‘S’ (Sell) or ‘2’ (Both)'
  str_8_nullable:
    seq:
      - id: value
        size: 8
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  hhmmss_ascii_time:
    seq:
      - id: text
        type: str
        size: 6
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "      "
  str_50_nullable:
    seq:
      - id: value
        size: 50
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "    "
  str_2_nullable:
    seq:
      - id: value
        size: 2
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "  "
  str_10_nullable:
    seq:
      - id: value
        size: 10
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32

enums:
  disconnection_instruction_note_cancel_quotes_only_q_quotes_only:
    0x41:
      id: 'all'
      doc: 'All'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
    0x4f:
      id: 'orders_only'
      doc: 'Orders Only'
    0x53:
      id: 'stop_orders_only'
      doc: 'Stop Orders Only'
    0x4d:
      id: 'market_orders_only'
      doc: 'Market Orders Only'
  active_y_on_n_off:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  account_type:
    0x31:
      id: 'customer'
      doc: 'Customer'
    0x32:
      id: 'house'
      doc: 'House'
    0x34:
      id: 'pro'
      doc: 'Pro'
    0x35:
      id: 'non_client'
      doc: 'Non Client'
    0x44:
      id: 'non_client_shareholder'
      doc: 'Non Client Shareholder'
    0x48:
      id: 'customer_shareholder'
      doc: 'Customer Shareholder'
    0x49:
      id: 'customer_insider'
      doc: 'Customer Insider'
    0x4c:
      id: 'pro_shareholder'
      doc: 'Pro Shareholder'
    0x4e:
      id: 'house_insider'
      doc: 'House Insider'
    0x4f:
      id: 'house_shareholder'
      doc: 'House Shareholder'
    0x52:
      id: 'non_client_insider'
      doc: 'Non Client Insider'
    0x53:
      id: 'pro_insider'
      doc: 'Pro Insider'
  open_close:
    0x4f:
      id: 'all_legs_are_open_or_single_security'
      doc: 'Any Number Of Legs Or Single Security'
    0x43:
      id: 'all_legs_are_closed_or_single_security'
      doc: 'Any Number Of Legs Or Single Security'
    0x31:
      id: 'leg_1_open_leg_2_close'
      doc: '2 Legged Strategy'
    0x32:
      id: 'leg_1_close_leg_2_open'
      doc: '2 Legged Strategy'
    0x33:
      id: 'leg_1_open_leg_2_open_leg_3_close'
      doc: '3 Legged Strategy'
    0x34:
      id: 'leg_1_open_leg_2_close_leg_3_open'
      doc: '3 Legged Strategy'
    0x35:
      id: 'leg_1_open_leg_2_close_leg_3_close'
      doc: '3 Legged Strategy'
    0x36:
      id: 'leg_1_close_leg_2_open_leg_3_open'
      doc: '3 Legged Strategy'
    0x37:
      id: 'leg_1_close_leg_2_open_leg_3_close'
      doc: '3 Legged Strategy'
    0x38:
      id: 'leg_1_close_leg_2_close_leg_3_open'
      doc: '3 Legged Strategy'
    0x41:
      id: 'leg_1_open_leg_2_open_leg_3_open_leg_4_close'
      doc: '4 Legged Strategy'
    0x42:
      id: 'leg_1_open_leg_2_open_leg_3_close_leg_4_open'
      doc: '4 Legged Strategy'
    0x44:
      id: 'leg_1_open_leg_2_open_leg_3_close_leg_4_close'
      doc: '4 Legged Strategy'
    0x45:
      id: 'leg_1_open_leg_2_close_leg_3_open_leg_4_open'
      doc: '4 Legged Strategy'
    0x46:
      id: 'leg_1_open_leg_2_close_leg_3_open_leg_4_close'
      doc: '4 Legged Strategy'
    0x47:
      id: 'leg_1_open_leg_2_close_leg_3_close_leg_4_open'
      doc: '4 Legged Strategy'
    0x48:
      id: 'leg_1_open_leg_2_close_leg_3_close_leg_4_close'
      doc: '4 Legged Strategy'
    0x49:
      id: 'leg_1_close_leg_2_open_leg_3_open_leg_4_open'
      doc: '4 Legged Strategy'
    0x4a:
      id: 'leg_1_close_leg_2_open_leg_3_open_leg_4_close'
      doc: '4 Legged Strategy'
    0x4b:
      id: 'leg_1_close_leg_2_open_leg_3_close_leg_4_open'
      doc: '4 Legged Strategy'
    0x4c:
      id: 'leg_1_close_leg_2_open_leg_3_close_leg_4_close'
      doc: '4 Legged Strategy'
    0x4d:
      id: 'leg_1_close_leg_2_close_leg_3_open_leg_4_open'
      doc: '4 Legged Strategy'
    0x4e:
      id: 'leg_1_close_leg_2_close_leg_3_open_leg_4_close'
      doc: '4 Legged Strategy'
    0x50:
      id: 'leg_1_close_leg_2_close_leg_3_close_leg_4_open'
      doc: '4 Legged Strategy'
  hedge_spec:
    0x48:
      id: 'hedger'
      doc: 'Hedger'
    0x53:
      id: 'speculator'
      doc: 'Speculator'
  firm_level_risk_option:
    0x20:
      id: 'netting_is_disabled'
      doc: 'Netting Is Disabled'
    0x54:
      id: 'cancel_post_trader_team_level_netting'
      doc: 'Cancel Post Trader Team Level Netting'
    0x4e:
      id: 'netting_is_enabled'
      doc: 'Netting Is Enabled'
    0x50:
      id: 'cancel_post_firm_level_netting'
      doc: 'Cancel Post Firm Level Netting'
  team_level_risk_option:
    0x20:
      id: 'netting_is_disabled'
      doc: 'Netting Is Disabled'
    0x54:
      id: 'cancel_post_trader_team_level_netting'
      doc: 'Cancel Post Trader Team Level Netting'
    0x4e:
      id: 'netting_is_enabled'
      doc: 'Netting Is Enabled'
    0x50:
      id: 'cancel_post_firm_level_netting'
      doc: 'Cancel Post Firm Level Netting'
  type_of_cancellation_q_quotes_only:
    0x41:
      id: 'all'
      doc: 'All'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
    0x4f:
      id: 'orders_only'
      doc: 'Orders Only'
    0x53:
      id: 'stop_orders_only'
      doc: 'Stop Orders Only'
    0x4d:
      id: 'market_orders_only'
      doc: 'Market Orders Only'
  type_of_cancellation:
    0x41:
      id: 'all'
      doc: 'All'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
    0x4f:
      id: 'orders_only'
      doc: 'Orders Only'
    0x53:
      id: 'stop_orders_only'
      doc: 'Stop Orders Only'
    0x4d:
      id: 'market_orders_only'
      doc: 'Market Orders Only'
  reset_all_groups:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  net_exposure_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  long_exposure_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  short_exposure_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  net_position_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  long_position_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  short_position_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  global_net_exposure_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  default_net_exposure_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  default_long_exposure_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  default_short_exposure_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  default_net_position_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  default_long_position_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  default_short_position_action:
    0x3f:
      id: 'not_set'
      doc: 'Not Set Message Does Not Modify The Limit'
    0x45:
      id: 'enforce_limit'
      doc: 'Enforce Limit By Rejecting And Eliminating Orders When Limit Is Reached'
    0x4e:
      id: 'none'
      doc: 'None Limit Is Disabled'
    0x57:
      id: 'warning'
      doc: 'Warning By Sending An Mn Risk Limits Usage Message When Limit Is Reached'
  price_type:
    0x43:
      id: 'committed'
      doc: 'Committed'
    0x4c:
      id: 'limit_price_set_in_message'
      doc: 'Limit Price Set In Message'
    0x4f:
      id: 'at_opening_price'
      doc: 'At Opening Price'
    0x4d:
      id: 'at_best_opposite_price_top_order'
      doc: 'At Best Opposite Price Top Order'
  verb_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  special_price_term:
    0x20:
      id: 'none'
      doc: 'None'
    0x53:
      id: 'stop_order'
      doc: 'Stop Order'
  quantity_term:
    0x20:
      id: 'none'
      doc: 'None'
    0x44:
      id: 'disclosed'
      doc: 'Disclosed'
    0x4d:
      id: 'minimum'
      doc: 'Minimum'
  duration_type:
    0x44:
      id: 'good_till_date'
      doc: 'Valid Until Gtd Date Gtd'
    0x45:
      id: 'fill_and_kill'
      doc: 'Immediate Order Cannot Be Booked Fak'
    0x46:
      id: 'good_till_cancel'
      doc: 'Valid Until Instrument Expiration Gtc'
    0x4a:
      id: 'day'
      doc: 'Valid For The Current Day Only Day'
    0x50:
      id: 'pre_opening'
      doc: 'Valid During Current Pre Opening'
    0x57:
      id: 'while_connected'
      doc: 'While Connected'
  anti_wash_instruction:
    0x42:
      id: 'cancel_both_inbound_order_and_opposite_resting_order'
      doc: 'Cancel Both Inbound Order And Opposite Resting Order'
    0x49:
      id: 'cancel_inbound_order'
      doc: 'Cancel Inbound Order'
    0x4f:
      id: 'cancel_opposite_resting_order'
      doc: 'Cancel Opposite Resting Order'
  quantity_sign:
    0x2b:
      id: 'adds_the_incoming_quantity_to_the_booked_quantity'
      doc: 'Adds The Incoming Quantity To The Booked Quantity'
    0x2d:
      id: 'subtracts_the_incoming_quantity_from_the_booked_quantity'
      doc: 'Subtracts The Incoming Quantity From The Booked Quantity'
    0x3d:
      id: 'replaces_the_booked_quantity_with_the_incoming_quantity'
      doc: 'Replaces The Booked Quantity With The Incoming Quantity'
  leg_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  quantity_sign_or:
    0x2b:
      id: 'adds_the_incoming_quantity_to_the_booked_quantity'
      doc: 'Adds The Incoming Quantity To The Booked Quantity'
    0x2d:
      id: 'subtracts_the_incoming_quantity_from_the_booked_quantity'
      doc: 'Subtracts The Incoming Quantity From The Booked Quantity'
    0x3d:
      id: 'replaces_the_booked_quantity_with_the_incoming_quantity'
      doc: 'Replaces The Booked Quantity With The Incoming Quantity'
  market_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x32:
      id: 'both'
      doc: 'Both'
  protection_type_advanced_protection_advanced_protection_disabled:
    0x41:
      id: 'advanced_protection'
      doc: 'Advanced Protection'
    0x4e:
      id: 'advanced_protection_disabled'
      doc: 'Advanced Protection Disabled'
  status:
    0x20:
      id: 'put_in_the_order_book_having_possibly_been_partially_executed'
      doc: 'Put In The Order Book Having Possibly Been Partially Executed'
    0x41:
      id: 'cancelled_by_the_trader'
      doc: 'Cancelled By The Trader'
    0x43:
      id: 'eliminated_by_the_circuit_breaker'
      doc: 'Eliminated By The Circuit Breaker'
    0x45:
      id: 'order_eliminated_by_the_system'
      doc: 'Order Eliminated By The System'
    0x46:
      id: 'eliminated_due_to_wash_trade_prevention'
      doc: 'Eliminated Due To Wash Trade Prevention'
    0x47:
      id: 'cancelled_by_the_firm_supervisor_user_global_cancel'
      doc: 'Cancelled By The Firm Supervisor User Global Cancel'
    0x49:
      id: 'eliminated_on_participant_disconnection'
      doc: 'Eliminated On Participant Disconnection'
    0x4d:
      id: 'eliminated_by_mod'
      doc: 'Eliminated By Mod'
    0x4e:
      id: 'eliminated_due_to_wash_trade_prevention_in_non_trading_state'
      doc: 'Eliminated Due To Wash Trade Prevention In Non Trading State'
    0x51:
      id: 'eliminated_due_to_wash_trade_prevention_against_quote'
      doc: 'Eliminated Due To Wash Trade Prevention Against Quote'
    0x53:
      id: 'put_in_the_order_book_as_stop_order'
      doc: 'Put In The Order Book As Stop Order'
    0x54:
      id: 'eliminated_due_to_trade_limit_exceeded'
      doc: 'Eliminated Due To Trade Limit Exceeded'
    0x55:
      id: 'eliminated_due_to_unpriced_leg'
      doc: 'Eliminated Due To Unpriced Leg'
    0x57:
      id: 'cancel_pending'
      doc: 'Cancel Pending'
    0x58:
      id: 'order_executed_in_full_or_partially_and_the_remaining_part_could_not_be_put_in_the_order_book_fak'
      doc: 'Order Executed In Full Or Partially And The Remaining Part Could Not Be Put In The Order Book Fak'
  type_of_cancellation_only_q_quotes_only_can_be_returned:
    0x41:
      id: 'all'
      doc: 'All'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
    0x4f:
      id: 'orders_only'
      doc: 'Orders Only'
    0x53:
      id: 'stop_orders_only'
      doc: 'Stop Orders Only'
    0x4d:
      id: 'market_orders_only'
      doc: 'Market Orders Only'
  creation_status:
    0x43: 'created_as_specified'
    0x4d: 'created_with_modifications'
  usage_status:
    0x49:
      id: 'info'
      doc: 'Info Current Usage Is Below The Warning Level'
    0x4c:
      id: 'limit'
      doc: 'Limit Usage Is At Or Above The Limit'
    0x52:
      id: 'rejection'
      doc: 'Rejection An Order Was Rejected Because Either The Limit Is Reached Or Accepting The Order Would Cause The Limit To Be Exceeded'
    0x57:
      id: 'warning'
      doc: 'Warning Current Usage Is Over The Warning Level'
  limit_type:
    0x31:
      id: 'net_exposure'
      doc: 'Net Exposure'
    0x32:
      id: 'long_exposure'
      doc: 'Long Exposure'
    0x33:
      id: 'short_exposure'
      doc: 'Short Exposure'
    0x34:
      id: 'net_position'
      doc: 'Net Position'
    0x35:
      id: 'long_position'
      doc: 'Long Position'
    0x36:
      id: 'short_position'
      doc: 'Short Position'
  group_state:
    0x43:
      id: 'consultation_start'
      doc: 'Consultation Start'
    0x45:
      id: 'no_cancel_period'
      doc: 'No Cancel Period'
    0x50:
      id: 'pre_opening'
      doc: 'Pre Opening'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'continuous_trading_session'
      doc: 'Continuous Trading Session'
    0x46:
      id: 'consultation_end'
      doc: 'Consultation End'
    0x4e:
      id: 'mod_intervention'
      doc: 'Mod Intervention'
    0x4d:
      id: 'mini_batch'
      doc: 'Mini Batch'
    0x42:
      id: 'post_session'
      doc: 'Post Session'
    0x49:
      id: 'prohibited'
      doc: 'Prohibited'
    0x5a:
      id: 'interrupted'
      doc: 'Interrupted'
  instrument_state:
    0x4e:
      id: 'normal'
      doc: 'Normal The Instrument Follows Group State Processing'
    0x46:
      id: 'forbidden'
      doc: 'Forbidden Trading Is Forbidden For This Instrument Orders And Quotes Are Rejected'
    0x52:
      id: 'orders_and_quotes_are_processed_in_pre_opening_if_the_group_is_in_trading_status'
      doc: 'Orders And Quotes Are Processed In Pre Opening If The Group Is In Trading Status'
  special_trade_indicator:
    0x20:
      id: 'normal_trade'
      doc: 'Normal Trade'
    0x41:
      id: 'as_of_trade'
      doc: 'As Of Trade'
    0x42:
      id: 'block_trade'
      doc: 'Block Trade'
    0x43:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x44:
      id: 'cross'
      doc: 'Cross'
    0x45:
      id: 'exchange_for_physical'
      doc: 'Exchange For Physical'
    0x48:
      id: 'hidden_trade'
      doc: 'Hidden Trade'
    0x49:
      id: 'implied'
      doc: 'Implied'
    0x4a:
      id: 'delta_trade'
      doc: 'Delta Trade'
    0x4b:
      id: 'committed_block'
      doc: 'Committed Block'
    0x4c:
      id: 'late_trade'
      doc: 'Late Trade'
    0x4d:
      id: 'for_future_use'
      doc: 'For Future Use'
    0x4e:
      id: 'for_future_use_x4e'
      doc: 'For Future Use'
    0x4f:
      id: 'for_future_use_x4f'
      doc: 'For Future Use'
    0x50:
      id: 'for_future_use_x50'
      doc: 'For Future Use'
    0x51:
      id: 'for_future_use_x51'
      doc: 'For Future Use'
    0x54:
      id: 'committed'
      doc: 'Committed'
    0x55:
      id: 'basis_on_close'
      doc: 'Basis On Close'
    0x56:
      id: 'trade_correction'
      doc: 'Trade Correction'
    0x5a:
      id: 'price_volume_adjustment_trade'
      doc: 'Price Volume Adjustment Trade'
  trade_type:
    0x46:
      id: 'traded_during_continuous_trading_following_fifo_algorithm'
      doc: 'Traded During Continuous Trading Following Fifo Algorithm'
    0x4d:
      id: 'trade_entered_by_mod'
      doc: 'Trade Entered By Mod'
    0x4f:
      id: 'traded_during_opening'
      doc: 'Traded During Opening'
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
  cancel_reason:
    0x41:
      id: 'cancelled_by_trader'
      doc: 'Cancelled By Trader'
    0x43:
      id: 'cancelled_by_circuit_breaker'
      doc: 'Cancelled By Circuit Breaker'
    0x47:
      id: 'cancelled_by_supervisor'
      doc: 'Cancelled By Supervisor'
    0x49:
      id: 'eliminated_by_disconnection'
      doc: 'Eliminated By Disconnection'
    0x4d:
      id: 'cancelled_by_mod'
      doc: 'Cancelled By Mod'
    0x4e:
      id: 'bqm_maximum_delta_volume_has_been_reached'
      doc: 'Bqm Maximum Delta Volume Has Been Reached'
    0x50:
      id: 'bqm_maximum_number_of_trades_has_been_reached'
      doc: 'Bqm Maximum Number Of Trades Has Been Reached'
    0x52:
      id: 'bqm_maximum_value_has_been_reached'
      doc: 'Bqm Maximum Value Has Been Reached'
    0x53:
      id: 'cancelled_by_system'
      doc: 'Cancelled By System'
    0x54:
      id: 'bqm_maximum_volume_has_been_reached'
      doc: 'Bqm Maximum Volume Has Been Reached'
    0x56:
      id: 'bqm_maximum_delta_value_has_been_reached'
      doc: 'Bqm Maximum Delta Value Has Been Reached'
    0x57:
      id: 'cancel_pending'
      doc: 'Cancel Pending'

