# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaOrderEntry Sail v1.21
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Order Entry
#   Encoding: Sola Access Information Language
#   Version: 1.21
#   Date: 6/18/2020
#   Specification: sail-mx-001e-mx-sail-specifications-guide-v1-21.pdf
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
doc-ref: https://www.tmxwebstore.com

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
    size: 1
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
        type: str
        size: 6
        encoding: ASCII
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
        type: str
        size: 6
        encoding: ASCII
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
        doc: 'First 100 characters of an erroneous message'
      - id: start_of_message_in_error
        type: str
        size: 100
        encoding: ASCII
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
  order_reply:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: user_sequence_id
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
      - id: exchange_message_id
        type: str_6_nullable
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a connection message as a retransmission starting point. • Zeroes = start from 1st message of the session • Blanks = start from next message for Participant • Valid Exchange Message ID = start at this message ID or the next message for the Participant • Contains spaces = it means that this field is not subject to re-transmission. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the type of account: 1 = Customer 2 = House 4 = Pro 5 = Non Client D = Non Client Shareholder H = Customer Shareholder I = Customer Insider L = Pro Shareholder N = House Insider O = House Shareholder R = Non Client Insider S = Pro Insider A combination of the above values without a comma may be used, but only within the GZ: User Global Cancellation message (see AccountType List below)'
      - id: open_close
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates how the Participant''s position will be handled by the clearing system:'
      - id: hedge_spec
        type: str
        size: 1
        encoding: ASCII
        doc: '• H = Hedger • S = Speculator'
      - id: filler_must_be_blank_x_5
        size: 5
        doc: 'Stated inline as String (5)'
  owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field. Nullable, No Value = 0'
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
        doc: 'Stated inline as String (100)'
  bulk_quote_data_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
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
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
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
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
  global_cancellation_confirmation:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: type_of_cancellation_only_q_quotes_only_can_be_returned
        type: str
        size: 1
        encoding: ASCII
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
  order_modification_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
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
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: filler_x_1
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
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
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
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
  bulk_quote_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
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
      - id: trader
        type: str_4_nullable
        doc: 'Last four (4) Characters of the Trader ID. Nullable, No Value = 0'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: usage_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Status of current usage vs limit: I = Info (current usage is below the warning level) L = Limit (usage is at or above the limit) R = Rejection (an order was rejected because either the limit is reached, or accepting the order would cause the limit to be exceeded) W = Warning (current usage is over the warning level)'
      - id: limit_type
        type: str
        size: 1
        encoding: ASCII
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
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: filler_x_2
        size: 2
        doc: 'Stated inline as String (2)'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: filler_x_4
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
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
  group_state_change:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: group_state
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the new status of the group. For message type NG, it contains one of the following values: • C = Consultation Start • E = No Cancel Period • P = Pre-opening • O = Opening • S = Continuous Trading Session • F = Consultation End • N = MOD Intervention • M = Mini-Batch • B = Post-Session • I = Prohibited • Z = Interrupted'
  instrument_state_change:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: instrument_state
        type: str
        size: 1
        encoding: ASCII
        doc: 'Instrument state: N = Normal. The instrument follows group state processing. F = Forbidden. Trading is forbidden for this instrument. Orders and quotes are rejected. R = Orders and quotes are processed in pre- opening if the group is in trading status'
  leg_execution_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden'
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
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: verb
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: order_type
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field. Nullable, No Value = 0'
  cancellation_of_all_quotes_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: cancel_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Cancel Reason for emitting the NP:Cancellation of All Quotes Notice message: A = Cancelled by Trader C = Cancelled by Circuit Breaker G = Cancelled by Supervisor I = Eliminated by Disconnection M = Cancelled by MOD N = BQM - Maximum Delta Volume has been reached P = BQM - Maximum Number of Trades has been reached R = BQM - Maximum Value has been reached S = Cancelled by System T= BQM - Maximum Volume has been reached V = BQM - Maximum Delta Value has been reached W = Cancel Pending'
  execution_notice:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden'
  execution_cancellation_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden'
  leg_execution_cancellation_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_traded
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: trading_engine_timestamp_of_the_trade_local_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: special_trade_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies a particular TradeType: ‘ ’ = Normal Trade A = As Of Trade B = Block Trade C = Contingent Trade D = Cross E = Exchange For Physical H = Hidden Trade I = Implied J = Delta Trade K = Committed Block L = Late Trade M = For future use N = For future use O = For future use P = For future use Q = For future use T = Committed U = Basis On Close V = Trade Correction Z = Price/Volume Adjustment Trade'
      - id: price_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: trade_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the origin of the Trade: F = Traded during continuous trading following FIFO algorithm M = Trade entered by MOD O = Traded during opening'
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an Instrument and one day'
      - id: trade_memo
        type: str
        size: 50
        encoding: ASCII
        doc: 'Text entered by the MOD when it is a manual trade entry'
      - id: original_reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order, or the Quote ID of the quote that has traded'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Blank, except for cross trades. For cross trades, it will be Firm ID unless Participant requests it to be hidden'
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
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Provides the outcome reserved for the order that is the subject of the entry, modification, or cancellation: ‘ ’ = Put in the order book (having possibly been partially executed) A = Cancelled by the Trader C = Eliminated by the Circuit Breaker E = Order eliminated by the system F = Eliminated due to Wash Trade Prevention G = Cancelled by the Firm Supervisor (User Global Cancel) I = Eliminated on Participant disconnection M = Eliminated by MOD N = Eliminated due to Wash Trade Prevention in non-trading state Q = Eliminated due to Wash Trade Prevention against quote S = Put in the order book as Stop order T = Eliminated due to trade limit exceeded U = Eliminated due to unpriced leg W = Cancel pending X = Order executed in full (or partially and the remaining part could not be put in the order book) (FAK)'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
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
      - id: filler_n_6
        size: 6
        doc: 'Stated inline as Numeric (6). Nullable, No Value = 0'
  request_for_quote_with_side_acknowledgement:
    seq:
      - id: outgoing_messages_header
        type: outgoing_messages_header
        doc: 'The guide states these fields once, as the Outgoing Messages Header, for every business message the Exchange sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: market_side
        type: str
        size: 1
        encoding: ASCII
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
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  str_2_nullable:
    seq:
      - id: value
        size: 2
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  str_50_nullable:
    seq:
      - id: value
        size: 50
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"

