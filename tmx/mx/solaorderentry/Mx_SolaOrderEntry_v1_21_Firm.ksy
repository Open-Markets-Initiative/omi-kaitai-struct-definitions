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
  id: tmx_mx_solaorderentry_sail_v1_21_firm
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
  - id: firm_message
    size: message_length - 2
    type:
      switch-on: message_type
      cases:
        '"TC"': user_connection
        '"TA"': disconnection_instruction
        '"TI"': heartbeat_response
        '"TD"': user_disconnection
        '"AF"': order_request
        '"BD"': bulk_quote_data
        '"CR"': firm_risk_config
        '"GC"': global_cancellation
        '"GZ"': user_global_cancellation
        '"MK"': set_group_risk_limits
        '"ML"': set_global_risk_limits
        '"OE"': order_entry
        '"OM"': order_modification
        '"ON"': new_strategy_instrument
        '"OX"': cross_entry
        '"QA"': bulk_quote_price_4_quantity_2
        '"QB"': bulk_quote_price_6_quantity_2
        '"QC"': bulk_quote_price_8_quantity_2
        '"QD"': bulk_quote_price_10_quantity_2
        '"QE"': bulk_quote_price_4_quantity_4
        '"QF"': bulk_quote_price_6_quantity_4
        '"QG"': bulk_quote_price_8_quantity_4
        '"QH"': bulk_quote_price_10_quantity_4
        '"QI"': bulk_quote_price_4_quantity_6
        '"QJ"': bulk_quote_price_6_quantity_6
        '"QK"': bulk_quote_price_8_quantity_6
        '"QL"': bulk_quote_price_10_quantity_6
        '"QM"': bulk_quote_price_4_quantity_8
        '"QN"': bulk_quote_price_6_quantity_8
        '"QO"': bulk_quote_price_8_quantity_8
        '"QP"': bulk_quote
        '"QS"': sail_request_for_quote_with_side
        '"RP"': bulk_quote_participant_bqp_protection_subscription
        '"RQ"': request_for_quote
        '"XE"': order_cancellation
  - id: end_of_text
    type: u1
    doc: 'End of Text character closing each business message'
  - id: alignment_padding
    size: (4 - _io.pos % 4) % 4
    if: _io.pos % 4 != 0
    doc: 'Spaces for alignment, up to three bytes'

types:
  user_connection:
    seq:
      - id: protocol_id
        type: str
        size: 2
        encoding: ASCII
        doc: 'Version of the protocol used by this connection'
      - id: user_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Participant for a given connection. User ID must be referenced in the SOLA® configuration database'
      - id: password_md_5_encryption
        type: str
        size: 8
        encoding: ASCII
        doc: 'Contact MX’s Technical Help Desk for details. (MD5 Encryption)'
      - id: session_id
        type: str_4_nullable
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID. Nullable, No Value ='
      - id: user_message_timestamp_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: exchange_message_id
        type: str_6_nullable
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a connection message as a retransmission starting point. • Zeroes = start from 1st message of the session • Blanks = start from next message for Participant • Valid Exchange Message ID = start at this message ID or the next message for the Participant • Contains spaces = it means that this field is not subject to re-transmission. Nullable, No Value ='
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
        repeat-expr: num_user_connection_occurrence.to_i
        doc: 'The guide states this block as (1 to 99 occurrences)'
  user_connection_occurrence:
    seq:
      - id: message_types_to_be_received
        type: str
        size: 2
        encoding: ASCII
        doc: 'Type of message'
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
        repeat-expr: num_disconnection_instruction_occurrence.to_i
        doc: 'The guide states this block as (1 to 99 occurrences)'
  disconnection_instruction_occurrence:
    seq:
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: disconnection_instruction_note_cancel_quotes_only_q_quotes_only
        type: u1
        enum: disconnection_instruction_note_cancel_quotes_only_q_quotes_only
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
      - id: active_y_on_n_off
        type: u1
        enum: active_y_on_n_off
        doc: 'Y = Yes N = No'
  heartbeat_response:
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
      - id: user_message_timestamp_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
  user_disconnection:
    seq:
      - id: user_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Participant for a given connection. User ID must be referenced in the SOLA® configuration database'
      - id: session_id
        type: str_4_nullable
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID. Nullable, No Value ='
  order_request:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
  incoming_messages_header:
    seq:
      - id: user_timestamp_local_hhmmss
        type: hhmmss_ascii_time
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: user_sequence_id
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
  bulk_quote_data:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: maximum_number_trades
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: minimum_volume
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: filler_2
        size: 2
        doc: 'Stated inline as String (2)'
      - id: calculation_time_interval
        type: str_8_nullable
        doc: 'Stated inline as Numeric (8). Nullable, No Value = 0'
      - id: maximum_total_volume
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: maximum_total_value
        type: str_8_nullable
        doc: 'Stated inline as Numeric (8). Nullable, No Value = 0'
      - id: delta_maximum_volume
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: delta_maximum_value
        type: str_8_nullable
        doc: 'Stated inline as Numeric (8). Nullable, No Value = 0'
      - id: anti_wash_id
        type: str_8_nullable
        doc: 'Anti-Wash ID for the Wash Trade Protection. Note: This field cannot be empty if the AntiWashInstruction is set to a value. Nullable, No Value = 0'
      - id: filler_20
        size: 20
        doc: 'Stated inline as String (20)'
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
  firm_risk_config:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: firm_level_risk_option
        type: u1
        enum: firm_level_risk_option
        doc: 'Configures the Risk Netting Options: ‘ ’ = Netting is disabled T = Cancel post Trader-Team level netting N = Netting is enabled P = Cancel post Firm level netting'
      - id: num_firm_risk_config_trader_team
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: firm_risk_config_trader_team
        type: firm_risk_config_trader_team
        repeat: expr
        repeat-expr: num_firm_risk_config_trader_team.to_i
        doc: 'The guide states this block as (1 to 5 occurrences)'
  firm_risk_config_trader_team:
    seq:
      - id: team_level_risk_option
        type: u1
        enum: team_level_risk_option
        doc: 'Configures the Risk Netting Options: ‘ ’ = Netting is disabled T = Cancel post Trader-Team level netting N = Netting is enabled P = Cancel post Firm level netting'
      - id: num_firm_risk_config_trader_team_trader
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: firm_risk_config_trader_team_trader
        type: firm_risk_config_trader_team_trader
        repeat: expr
        repeat-expr: num_firm_risk_config_trader_team_trader.to_i
        doc: 'The guide states this block as (1 to 200 occurrences)'
  firm_risk_config_trader_team_trader:
    seq:
      - id: trader
        type: str_4_nullable
        doc: 'Last four (4) Characters of the Trader ID. Nullable, No Value = 0'
  global_cancellation:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: type_of_cancellation_q_quotes_only
        type: u1
        enum: type_of_cancellation_q_quotes_only
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
  user_global_cancellation:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group_filter
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value ='
      - id: instrument_filter
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value ='
      - id: type_of_cancellation
        type: u1
        enum: type_of_cancellation
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
      - id: account_type_filter
        type: str_8_nullable
        doc: 'List of account types: ‘24’ for both House and Pro ‘12’ for both Customer and House. Nullable, No Value ='
  set_group_risk_limits:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: reset_all_groups
        type: u1
        enum: reset_all_groups
        doc: 'Y = Yes N = No'
      - id: num_set_group_risk_limits_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: set_group_risk_limits_occurrence
        type: set_group_risk_limits_occurrence
        repeat: expr
        repeat-expr: num_set_group_risk_limits_occurrence.to_i
        doc: 'The guide states this block as (1 to 100 occurrences)'
  set_group_risk_limits_occurrence:
    seq:
      - id: trader
        type: str_4_nullable
        doc: 'Last four (4) Characters of the Trader ID. Nullable, No Value = 0'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: net_exposure_action
        type: u1
        enum: net_exposure_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: long_exposure_action
        type: u1
        enum: long_exposure_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: short_exposure_action
        type: u1
        enum: short_exposure_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: net_position_action
        type: u1
        enum: net_position_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: long_position_action
        type: u1
        enum: long_position_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: short_position_action
        type: u1
        enum: short_position_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: maximum_order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: net_position_limit
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: long_position_limit
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: short_position_limit
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: net_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: long_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: short_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: filler_2
        size: 2
        doc: 'Stated inline as String (2)'
  set_global_risk_limits:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: global_net_exposure_action
        type: u1
        enum: global_net_exposure_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_net_exposure_action
        type: u1
        enum: default_net_exposure_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_long_exposure_action
        type: u1
        enum: default_long_exposure_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_short_exposure_action
        type: u1
        enum: default_short_exposure_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_net_position_action
        type: u1
        enum: default_net_position_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_long_position_action
        type: u1
        enum: default_long_position_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_short_position_action
        type: u1
        enum: default_short_position_action
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: global_net_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: default_maximum_order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: default_net_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: default_long_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: default_short_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: default_net_position_limit
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: default_long_position_limit
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: default_short_position_limit
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
  order_entry:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: special_price_term
        type: u1
        enum: special_price_term
        doc: 'If included, must contain one of the following values: ‘ ’ = None S = Stop order'
      - id: additional_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'If Special Price Term is equal to ‘S’, this field represents the trigger price: i.e., the price from which a STOP order will be triggered. Note: Mandatory if Special Price Term is different from spaces'
      - id: quantity_term
        type: u1
        enum: quantity_term
        doc: 'If included, must contain one of the following values: ‘ ’ = None D = Disclosed M = Minimum'
      - id: additional_quantity
        type: str_8_nullable
        doc: 'Minimum Quantity Indicates the number of contracts that the trader wishes to trade on the market as soon as the order is introduced. If the market situation allows this minimum amount to be filled immediately, the balance of the order is put in the order book. Otherwise, the order is automatically eliminated. Disclosed Quantity • Indicates the number of contracts that the trader wishes to display on the market sheet • Must be different from ‘0’ if Quantity Term is equal to ‘M’ or ‘D’ • Must be lower than the number in the Quantity field. Nullable, No Value = 0'
      - id: duration_type
        type: u1
        enum: duration_type
        doc: 'Indicates the order validity duration: D = Valid until GTD date (GTD) E = Immediate order, cannot be booked (FAK) F = Valid until Instrument expiration (GTC) J = Valid for the current Day only (Day) P = Valid during current pre-opening W = While Connected'
      - id: gtd_date
        type: yyyymmdd_ascii_date
        doc: 'Year, Month and Day (YYYYMMDD). Nullable, No Value = 0'
      - id: executing_participant
        type: str_4_nullable
        doc: 'Identifies a firm referenced in the system. Nullable, No Value ='
      - id: filler_1
        size: 1
        doc: 'Stated inline as String (1)'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: anti_wash_id
        type: str_8_nullable
        doc: 'Anti-Wash ID for the Wash Trade Protection. Note: This field cannot be empty if the AntiWashInstruction is set to a value. Nullable, No Value = 0'
      - id: anti_wash_instruction
        type: u1
        enum: anti_wash_instruction
        doc: 'Anti-Wash instruction to indicate how to handle the trade situation: B = CancelBothInboundOrderAndOpposite RestingOrder I = CancelInboundOrder O = CancelOppositeRestingOrder Note: This field is not provided if the AntiWashId field is empty. Note: This field must be provided if the AntiWashId field is not empty'
      - id: filler_20
        size: 20
        doc: 'Stated inline as String (20)'
  order_modification:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign
        type: u1
        enum: quantity_sign
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: special_price_term
        type: u1
        enum: special_price_term
        doc: 'If included, must contain one of the following values: ‘ ’ = None S = Stop order'
      - id: additional_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'If Special Price Term is equal to ‘S’, this field represents the trigger price: i.e., the price from which a STOP order will be triggered. Note: Mandatory if Special Price Term is different from spaces'
      - id: quantity_term
        type: u1
        enum: quantity_term
        doc: 'If included, must contain one of the following values: ‘ ’ = None D = Disclosed M = Minimum'
      - id: additional_quantity
        type: str_8_nullable
        doc: 'Minimum Quantity Indicates the number of contracts that the trader wishes to trade on the market as soon as the order is introduced. If the market situation allows this minimum amount to be filled immediately, the balance of the order is put in the order book. Otherwise, the order is automatically eliminated. Disclosed Quantity • Indicates the number of contracts that the trader wishes to display on the market sheet • Must be different from ‘0’ if Quantity Term is equal to ‘M’ or ‘D’ • Must be lower than the number in the Quantity field. Nullable, No Value = 0'
      - id: duration_type
        type: u1
        enum: duration_type
        doc: 'Indicates the order validity duration: D = Valid until GTD date (GTD) E = Immediate order, cannot be booked (FAK) F = Valid until Instrument expiration (GTC) J = Valid for the current Day only (Day) P = Valid during current pre-opening W = While Connected'
      - id: gtd_date
        type: yyyymmdd_ascii_date
        doc: 'Year, Month and Day (YYYYMMDD). Nullable, No Value = 0'
      - id: filler_4
        size: 4
        doc: 'Stated inline as String (4)'
      - id: filler_1
        size: 1
        doc: 'Stated inline as String (1)'
      - id: modified_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states this field once, as Owner Data, for every message that carries it'
      - id: anti_wash_id
        type: str_8_nullable
        doc: 'Anti-Wash ID for the Wash Trade Protection. Note: This field cannot be empty if the AntiWashInstruction is set to a value. Nullable, No Value = 0'
      - id: anti_wash_instruction
        type: u1
        enum: anti_wash_instruction
        doc: 'Anti-Wash instruction to indicate how to handle the trade situation: B = CancelBothInboundOrderAndOpposite RestingOrder I = CancelInboundOrder O = CancelOppositeRestingOrder Note: This field is not provided if the AntiWashId field is empty. Note: This field must be provided if the AntiWashId field is not empty'
      - id: filler_20
        size: 20
        doc: 'Stated inline as String (20)'
  new_strategy_instrument:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: num_new_strategy_instrument_leg_definition_repeating_block
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: new_strategy_instrument_leg_definition_repeating_block
        type: new_strategy_instrument_leg_definition_repeating_block
        repeat: expr
        repeat-expr: num_new_strategy_instrument_leg_definition_repeating_block.to_i
        doc: 'The guide states this block as (2 to 4 occurrences)'
  new_strategy_instrument_leg_definition_repeating_block:
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
  cross_entry:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: filler_1
        size: 1
        doc: 'Stated inline as String (1)'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: buying_clearing_data
        type: buying_clearing_data
        doc: 'Clearing Data for the buying side, which OX: Cross Entry carries alongside the other side'
      - id: selling_clearing_data
        type: selling_clearing_data
        doc: 'Clearing Data for the selling side, which OX: Cross Entry carries alongside the other side'
      - id: buying_owner_data
        type: buying_owner_data
        doc: 'Owner Data for the buying side, which OX: Cross Entry carries alongside the other side'
      - id: selling_owner_data
        type: selling_owner_data
        doc: 'Owner Data for the selling side, which OX: Cross Entry carries alongside the other side'
      - id: filler_20
        size: 20
        doc: 'Stated inline as String (20)'
  buying_clearing_data:
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
  selling_clearing_data:
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
  buying_owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field'
  selling_owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field'
  bulk_quote_price_4_quantity_2:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_4_quantity_2_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_4_quantity_2_occurrence
        type: bulk_quote_price_4_quantity_2_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_4_quantity_2_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_4_quantity_2_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_2
        type: str_2_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_4
        type: str_4_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_6_quantity_2:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_6_quantity_2_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_6_quantity_2_occurrence
        type: bulk_quote_price_6_quantity_2_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_6_quantity_2_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_6_quantity_2_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_2
        type: str_2_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_6
        type: str_6_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_8_quantity_2:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_8_quantity_2_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_8_quantity_2_occurrence
        type: bulk_quote_price_8_quantity_2_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_8_quantity_2_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_8_quantity_2_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_2
        type: str_2_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_8
        type: str_8_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_10_quantity_2:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_10_quantity_2_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_10_quantity_2_occurrence
        type: bulk_quote_price_10_quantity_2_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_10_quantity_2_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_10_quantity_2_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_2
        type: str_2_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
  bulk_quote_price_4_quantity_4:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_4_quantity_4_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_4_quantity_4_occurrence
        type: bulk_quote_price_4_quantity_4_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_4_quantity_4_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_4_quantity_4_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_4
        type: str_4_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_4
        type: str_4_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_6_quantity_4:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_6_quantity_4_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_6_quantity_4_occurrence
        type: bulk_quote_price_6_quantity_4_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_6_quantity_4_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_6_quantity_4_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_4
        type: str_4_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_6
        type: str_6_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_8_quantity_4:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_8_quantity_4_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_8_quantity_4_occurrence
        type: bulk_quote_price_8_quantity_4_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_8_quantity_4_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_8_quantity_4_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_4
        type: str_4_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_8
        type: str_8_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_10_quantity_4:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_10_quantity_4_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_10_quantity_4_occurrence
        type: bulk_quote_price_10_quantity_4_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_10_quantity_4_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_10_quantity_4_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_4
        type: str_4_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
  bulk_quote_price_4_quantity_6:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_4_quantity_6_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_4_quantity_6_occurrence
        type: bulk_quote_price_4_quantity_6_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_4_quantity_6_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_4_quantity_6_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_6
        type: str_6_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_4
        type: str_4_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_6_quantity_6:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_6_quantity_6_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_6_quantity_6_occurrence
        type: bulk_quote_price_6_quantity_6_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_6_quantity_6_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_6_quantity_6_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_6
        type: str_6_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_6
        type: str_6_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_8_quantity_6:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_8_quantity_6_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_8_quantity_6_occurrence
        type: bulk_quote_price_8_quantity_6_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_8_quantity_6_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_8_quantity_6_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_6
        type: str_6_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_8
        type: str_8_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_10_quantity_6:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_10_quantity_6_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_10_quantity_6_occurrence
        type: bulk_quote_price_10_quantity_6_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_10_quantity_6_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_10_quantity_6_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity_6
        type: str_6_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
  bulk_quote_price_4_quantity_8:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_4_quantity_8_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_4_quantity_8_occurrence
        type: bulk_quote_price_4_quantity_8_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_4_quantity_8_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_4_quantity_8_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_4
        type: str_4_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_6_quantity_8:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_6_quantity_8_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_6_quantity_8_occurrence
        type: bulk_quote_price_6_quantity_8_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_6_quantity_8_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_6_quantity_8_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_6
        type: str_6_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote_price_8_quantity_8:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_price_8_quantity_8_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_price_8_quantity_8_occurrence
        type: bulk_quote_price_8_quantity_8_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_price_8_quantity_8_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_price_8_quantity_8_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price_8
        type: str_8_nullable
        doc: 'Price format with format indicator and price mantissa'
  bulk_quote:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: num_bulk_quote_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_occurrence
        type: bulk_quote_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_occurrence.to_i
        doc: '1 to 280 occurrences'
  bulk_quote_occurrence:
    seq:
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
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: u1
        enum: quantity_sign_or
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant'
  sail_request_for_quote_with_side:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
  bulk_quote_participant_bqp_protection_subscription:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group identification within the system. A group is composed of instruments'
      - id: protection_type_advanced_protection_advanced_protection_disabled
        type: u1
        enum: protection_type_advanced_protection_advanced_protection_disabled
        doc: 'Type of protection requested by the Bulk Quote Participant (BQP): A = Advanced Protection N = Advanced Protection Disabled Note: If no RP: Bulk Quote Participant (BQP) Protection Subscription message is sent, MX will assume that the BQP did not request an Advanced Protection. BQP will be required to enable the Advanced Protection'
  request_for_quote:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
  order_cancellation:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
      - id: cancelled_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID. It is the order key identifier'
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "    "
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
  str_8_nullable:
    seq:
      - id: value
        size: 8
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
        value: value[0] == 32
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
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i

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
      id: 'preopening'
      doc: 'Valid During Current Preopening'
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
      id: 'eliminated_due_to_wash_trade_prevention_in_nontrading_state'
      doc: 'Eliminated Due To Wash Trade Prevention In Nontrading State'
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
      id: 'preopening'
      doc: 'Preopening'
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
      id: 'orders_and_quotes_are_processed_in_preopening_if_the_group_is_in_trading_status'
      doc: 'Orders And Quotes Are Processed In Preopening If The Group Is In Trading Status'
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

