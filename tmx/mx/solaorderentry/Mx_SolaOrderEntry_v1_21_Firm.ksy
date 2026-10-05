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
  id: tmx_mx_solaorderentry_sail_v1_21_firm
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
  - id: firm_message
    size: message_length - 2
    type:
      switch-on: message_type
      cases:
        '"TC"': user_connection
        '"TA"': disconnection_instruction
        '"TI"': heartbeat_response
        '"TD"': user_disconnection
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
        '"QP"': bulk_quote
        '"QS"': sail_request_for_quote_with_side
        '"RP"': bulk_quote_participant_bqp_protection_subscription
        '"RQ"': request_for_quote
        '"XE"': order_cancellation
  - id: end_of_text
    type: u1
    doc: 'End of Text character closing each business message'
  - id: alignment_padding
    size: 1
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
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID. Nullable, No Value = 0'
      - id: user_message_timestamp_local_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: exchange_message_id
        type: str_6_nullable
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a connection message as a retransmission starting point. • Zeroes = start from 1st message of the session • Blanks = start from next message for Participant • Valid Exchange Message ID = start at this message ID or the next message for the Participant • Contains spaces = it means that this field is not subject to re-transmission. Nullable, No Value = 0'
      - id: inactivity_interval
        type: str_2_nullable
        doc: 'Number of missed heartbeats before considering the user disconnected. If set to 0, the user is never considered as disconnected by the system. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
      - id: active_y_on_n_off
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 6
        encoding: ASCII
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
        doc: 'Identifies the current Session ID. If set to blank spaces, means that the Participant wants to connect to the current Session ID. Nullable, No Value = 0'
  bulk_quote_data:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
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
        doc: 'Stated inline as String (20). Nullable, No Value = 0'
  incoming_messages_header:
    seq:
      - id: user_timestamp_local_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'User message or trading engine timestamp, Local, HHMMSS'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the Trader: 4 first characters = Firm identifier 4 last characters = Trader identifier'
      - id: user_sequence_id
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. Nullable, No Value = 0'
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
      - id: filler_5
        size: 5
        doc: 'Stated inline as String (5)'
  owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field. Nullable, No Value = 0'
  firm_risk_config:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: firm_level_risk_option
        type: str
        size: 1
        encoding: ASCII
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
        type: str
        size: 1
        encoding: ASCII
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
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: type_of_cancellation_q_quotes_only
        type: str
        size: 1
        encoding: ASCII
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
  user_global_cancellation:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: type_of_cancellation
        type: str
        size: 1
        encoding: ASCII
        doc: 'Type of cancellation: A = All Q = QuotesOnly O = OrdersOnly S = StopOrdersOnly M = MarketOrdersOnly'
      - id: account_type_filter
        type: str_8_nullable
        doc: 'List of account types: ‘24’ for both House and Pro ‘12’ for both Customer and House. Nullable, No Value = 0'
  set_group_risk_limits:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: reset_all_groups
        type: str
        size: 1
        encoding: ASCII
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
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: net_exposure_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: long_exposure_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: short_exposure_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: net_position_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: long_position_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: short_position_action
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: long_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: short_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: filler_2
        size: 2
        doc: 'Stated inline as String (2)'
  set_global_risk_limits:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: global_net_exposure_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_net_exposure_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_long_exposure_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_short_exposure_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_net_position_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_long_position_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: default_short_position_action
        type: str
        size: 1
        encoding: ASCII
        doc: 'Action related to the corresponding limit: ? = Not Set (message does not modify the Limit) E = Enforce Limit (by rejecting and eliminating orders when Limit is reached) N = None (Limit is disabled) W = Warning (by sending an MN: Risk Limits Usage message when Limit is reached)'
      - id: global_net_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: default_maximum_order_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: default_net_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: default_long_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: default_short_exposure_limit
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
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
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: price_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: special_price_term
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'If included, must contain one of the following values: ‘ ’ = None S = Stop order'
      - id: additional_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'If Special Price Term is equal to ‘S’, this field represents the trigger price: i.e., the price from which a STOP order will be triggered. Note: Mandatory if Special Price Term is different from spaces'
      - id: quantity_term
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'If included, must contain one of the following values: ‘ ’ = None D = Disclosed M = Minimum'
      - id: additional_quantity
        type: str_8_nullable
        doc: 'Minimum Quantity Indicates the number of contracts that the trader wishes to trade on the market as soon as the order is introduced. If the market situation allows this minimum amount to be filled immediately, the balance of the order is put in the order book. Otherwise, the order is automatically eliminated. Disclosed Quantity • Indicates the number of contracts that the trader wishes to display on the market sheet • Must be different from ‘0’ if Quantity Term is equal to ‘M’ or ‘D’ • Must be lower than the number in the Quantity field. Nullable, No Value = 0'
      - id: duration_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the order validity duration: D = Valid until GTD date (GTD) E = Immediate order, cannot be booked (FAK) F = Valid until Instrument expiration (GTC) J = Valid for the current Day only (Day) P = Valid during current pre-opening W = While Connected'
      - id: gtd_date
        type: str_8_nullable
        doc: 'Year, Month and Day (YYYYMMDD). Nullable, No Value = 0'
      - id: executing_participant
        type: str_4_nullable
        doc: 'Identifies a firm referenced in the system. Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Anti-Wash instruction to indicate how to handle the trade situation: B = CancelBothInboundOrderAndOpposite RestingOrder I = CancelInboundOrder O = CancelOppositeRestingOrder Note: This field is not provided if the AntiWashId field is empty. Note: This field must be provided if the AntiWashId field is not empty'
      - id: filler_20
        size: 20
        doc: 'Stated inline as String (20). Nullable, No Value = 0'
  order_modification:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: price_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Must contain one of the following Price Types: C = Committed L = Limit (price set in message) O = At opening price M = At best opposite price (Top Order)'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign
        type: str
        size: 1
        encoding: ASCII
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: special_price_term
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'If included, must contain one of the following values: ‘ ’ = None S = Stop order'
      - id: additional_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'If Special Price Term is equal to ‘S’, this field represents the trigger price: i.e., the price from which a STOP order will be triggered. Note: Mandatory if Special Price Term is different from spaces'
      - id: quantity_term
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'If included, must contain one of the following values: ‘ ’ = None D = Disclosed M = Minimum'
      - id: additional_quantity
        type: str_8_nullable
        doc: 'Minimum Quantity Indicates the number of contracts that the trader wishes to trade on the market as soon as the order is introduced. If the market situation allows this minimum amount to be filled immediately, the balance of the order is put in the order book. Otherwise, the order is automatically eliminated. Disclosed Quantity • Indicates the number of contracts that the trader wishes to display on the market sheet • Must be different from ‘0’ if Quantity Term is equal to ‘M’ or ‘D’ • Must be lower than the number in the Quantity field. Nullable, No Value = 0'
      - id: duration_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the order validity duration: D = Valid until GTD date (GTD) E = Immediate order, cannot be booked (FAK) F = Valid until Instrument expiration (GTC) J = Valid for the current Day only (Day) P = Valid during current pre-opening W = While Connected'
      - id: gtd_date
        type: str_8_nullable
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Anti-Wash instruction to indicate how to handle the trade situation: B = CancelBothInboundOrderAndOpposite RestingOrder I = CancelInboundOrder O = CancelOppositeRestingOrder Note: This field is not provided if the AntiWashId field is empty. Note: This field must be provided if the AntiWashId field is not empty'
      - id: filler_20
        size: 20
        doc: 'Stated inline as String (20). Nullable, No Value = 0'
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
        type: str
        size: 1
        encoding: ASCII
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
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: filler_1
        size: 1
        doc: 'Stated inline as String (1)'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
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
        doc: 'Stated inline as String (20). Nullable, No Value = 0'
  buying_clearing_data:
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
      - id: filler_5
        size: 5
        doc: 'Stated inline as String (5)'
  buying_owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field. Nullable, No Value = 0'
  selling_owner_data:
    seq:
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone, which can be used to transmit additional information for processing. No validations are carried out on this field. Nullable, No Value = 0'
  bulk_quote:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
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
        doc: 'The guide states this block as (1 to 280 occurrences)'
  bulk_quote_occurrence:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: verb_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies an order/quote side: B = Buy S = Sell'
      - id: quantity_sign_or
        type: str
        size: 1
        encoding: ASCII
        doc: 'For an order or quote update, it identifies how to handle the quantity: ‘+’ adds the incoming quantity to the booked quantity ‘-’ subtracts the incoming quantity from the booked quantity ‘=’ replaces the booked quantity with the incoming quantity'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price format with format indicator and price mantissa: Format indicator (1) • Alpha: the price is negative (‘A’ means negative value with no decimal, ‘B’ means negative value with 1 decimal, ‘C’ means negative value with 2 decimals, etc.) • Numeric: the price is positive (‘0’ means positive value with no decimal, ‘1’ means positive value with one decimal, ‘2’ means positive value with 2 decimals, etc.) • Set to spaces: the price is not significant Price mantissa (9) • Represents the price value including the number of decimals defined in the format indicator Examples: • Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 • Format indicator = A; Price mantissa = 3567838; Price = -3567838 • Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
  sail_request_for_quote_with_side:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
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
  bulk_quote_participant_bqp_protection_subscription:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: protection_type_advanced_protection_advanced_protection_disabled
        type: str
        size: 1
        encoding: ASCII
        doc: 'Type of protection requested by the Bulk Quote Participant (BQP): A = Advanced Protection N = Advanced Protection Disabled Note: If no RP: Bulk Quote Participant (BQP) Protection Subscription message is sent, MX will assume that the BQP did not request an Advanced Protection. BQP will be required to enable the Advanced Protection'
  request_for_quote:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
  order_cancellation:
    seq:
      - id: incoming_messages_header
        type: incoming_messages_header
        doc: 'The guide states these fields once, as the Incoming Messages Header, for every business message a Participant sends. Message Type is read by the packet before the branch, so it is not repeated here'
      - id: group
        type: str_2_nullable
        doc: 'Group identification within the system. A group is composed of instruments. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a group. Nullable, No Value = 0'
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
        value: text == "0"
  str_10_nullable:
    seq:
      - id: value
        size: 10
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"

