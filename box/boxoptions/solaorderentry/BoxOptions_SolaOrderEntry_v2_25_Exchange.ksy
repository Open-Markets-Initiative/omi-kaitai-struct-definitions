# ---------------------------------------------------------------------
# Kaitai struct definition for: Box BoxOptions SolaOrderEntry Sail v2.25
#
# Protocol:
#   Organization: Box Options Market
#   Protocol: Sola Order Entry
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
  id: box_boxoptions_solaorderentry_sail_v2_25_exchange
  title: Box BoxOptions SolaOrderEntry Sail v2.25
  license: GPL-3.0
  endian: le

doc: 'Box Options Market BOX Options Exchange Sola Order Entry Sail v2.25'

seq:
  - id: message_length
    type: u4
    doc: 'Length of the Sail message, little endian, right justified and left filled with zeroes, ahead of the message itself'
  - id: outgoing_header
    type: outgoing_header_struct
    doc: 'The header on all outgoing exchange messages'
  - id: exchange_message
    size: message_length - 30
    type:
      switch-on: outgoing_header.message_type
      cases:
        '"TH"': heartbeat_question
        '"TO"': out_of_sequence
        '"TE"': technical_error_notice
        '"TM"': disconnection_instruction_acknowledgement
        '"TK"': connection_acknowledgement
        '"TL"': disconnection_acknowledgement
        '"TT"': end_of_transmission
        '"ER"': error_notice
        '"KD"': bulk_quote_data_acknowledgement
        '"KE"': order_acknowledgement
        '"KG"': global_cancellation_confirmation
        '"KI"': improvement_order_acknowlegment
        '"KM"': order_modification_acknowledgement
        '"KN"': new_complex_order_instrument_acknowledgement
        '"KO"': standard_acknowledgement
        '"KT"': complex_order_auction_acknowledgement
        '"KY"': auction_or_improvement_cancellation_acknowledgement
        '"KZ"': order_cancellation_acknowledgement
        '"LA"': bulk_quote_acknowledgement
        '"MU"': trader_status
        '"NC"': directed_order_cancellation_notice
        '"ND"': directed_order_notice
        '"NE"': excluded_instrument_notice
        '"NG"': group_state_change
        '"NL"': leg_execution_notice
        '"NP"': cancellation_of_all_quotes_notices
        '"NQ"': quality_market_maker_notification
        '"NT"': execution_notice
        '"NU"': quote_notice
        '"NX"': execution_cancellation_notice
        '"NY"': leg_execution_cancellation_notice
        '"NZ"': order_cancellation_notice_by_system
  - id: end_of_text
    type: u1
    doc: 'End of text, a byte of binary 3, closing every Sail message'

types:
  outgoing_header_struct:
    seq:
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'The two characters naming which message follows the header'
      - id: message_timestamp
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time of day the trading engine states, HHMMSS'
      - id: user_sequence_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Sequence number the participant assigns, incremented by one for each new business message and reset to zero after 99999999'
      - id: exchange_message_id
        type: str_6_nullable
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a Connection message as a retransmission starting point. If equal to zeroes: start from 1st message of the session. If equal to blanks: start from next message for Participant. If valid Exchange Message ID: start at this message ID or the next message for the Participant. If it contains spaces, it means that this field is not subject to re-transmission. Nullable, No Value = 0'
      - id: gap_sequence_id
        type: str
        size: 2
        encoding: ASCII
        doc: 'States a gap in the exchange message sequence'
      - id: system_sequence_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Sequence number the trading system assigns'
  heartbeat_question:
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
        doc: 'Identifies a message sent by the exchange for a Participant connection. It represents the exchange identifier of the message for the current session. It is used in a Connection message as a retransmission starting point. If equal to zeroes: start from 1st message of the session. If equal to blanks: start from next message for Participant. If valid Exchange Message ID: start at this message ID or the next message for the Participant. If it contains spaces, it means that this field is not subject to re-transmission'
      - id: time_local
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
  out_of_sequence:
    seq:
      - id: received_user_sequence_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on'
      - id: expected_last_user_sequence_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on'
      - id: message_time_local
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
  technical_error_notice:
    seq:
      - id: received_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Received Message type in Error'
      - id: preceding_user_sequence_id_received_zeroes_if_none
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on'
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Refer to Error Codes for error code definitions'
      - id: error_position
        type: str
        size: 4
        encoding: ASCII
        doc: 'Stated inline as Numeric (4)'
      - id: error_message
        type: str
        size: 100
        encoding: ASCII
        doc: 'Stated inline as String (100)'
      - id: start_of_message_in_error
        type: str
        size: 100
        encoding: ASCII
        doc: 'Stated inline as String (100)'
  disconnection_instruction_acknowledgement:
    seq:
      - id: current_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies current session ID If set to blank spaces, this means the Participant wants to connect to the current session ID'
      - id: last_user_sequence_id_received
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on. Nullable, No Value = 0'
  connection_acknowledgement:
    seq:
      - id: current_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies current session ID If set to blank spaces, this means the Participant wants to connect to the current session ID'
      - id: last_user_sequence_id_received
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on. Nullable, No Value = 0'
  disconnection_acknowledgement:
    seq:
      - id: current_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies current session ID If set to blank spaces, this means the Participant wants to connect to the current session ID'
      - id: last_user_sequence_id_received
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on. Nullable, No Value = 0'
  end_of_transmission:
    seq:
      - id: ended_session_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies current session ID If set to blank spaces, this means the Participant wants to connect to the current session ID'
      - id: last_user_sequence_id_received_if_no_business_message_has_been_received_on_this_connection_this_field_is_equal_to_zeroes
        type: str_8_nullable
        doc: 'Identifies all the incoming business messages for one connection. Must be sequential and start at 1 at the beginning of the day. Used by SOLA® to track gaps in message sequence. When the maximum User Sequence ID of 99999999 is reached, the Participant is required to reset back to 0 (zero), and then increment by 1 for each new business message sent to the Exchange. The same reset is required when the Participant reaches the next maximum User Sequence ID of 99999999 and so on. Nullable, No Value = 0'
      - id: time
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
  error_notice:
    seq:
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Refer to Error Codes for error code definitions'
      - id: error_description
        type: str
        size: 100
        encoding: ASCII
        doc: 'Stated inline as String (100)'
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: order_id_client_order_id_20
        type: str_20_nullable
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant. Nullable, No Value = 0'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: original_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Type of Message'
      - id: error_detail
        type: str_200_nullable
        doc: 'Free format text string used to provide additional detail on errors. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up. Nullable, No Value = 0'
      - id: client_order_id
        type: str_20_nullable
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant. Nullable, No Value = 0'
  bulk_quote_data_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: quote_id_identifies_traders_quote_on_this_group
        type: str_8_nullable
        doc: 'If entered by Participant Quote ID is validated against the Quote ID received in the KD “Sail Bulk Quote Acknowledgment message”, On failed validation the system returns an ER “Sail Error Notice” message with the expected Quote ID. An empty Quote ID is accepted and not validated by the system. An empty Quote ID is defined as follows: All ‘ ‘ (blank) spaces 00000000 On all outbound messages with Quote ID, the Quote ID corresponds to the Quote ID referenced in the KD message. Nullable, No Value = 0'
  order_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the Participant with the outcome reserved for the order that is the subject of the entry, modification, or cancellation. " ": Order put in the Order Book (having possibly been partially executed) A: Order cancelled by the trader or at the end of the exposition phase B: Order has been eliminated by the trading system due to invalid out of limits price D: The order is a ''Directed/Routed Order'' and has been received by ExecutingParticipant E: The order has been eliminated by the trading system G: Cancelled By Supervisor I: Session Order has been cancelled when the Participant closes or loses his connection to the SOLA trading system J: Eliminated Due To Maximum Nb Triggers Limit Exceeded K: Eliminated Due To Trade Activity Limit Exceeded L: Order has been sent to the away exchange M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: Order is being exposed R: Order is eliminated due to trading restriction T: Eliminated Due To Trade Limit Exceeded W: Cancel Pending X: Order executed in full (or partially and the remaining part could not be put in the Order Book) (Fill & Kill) The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the Trading System. Refer toPrice for format details'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the trading system'
      - id: filler_numeric_66
        size: 6
        doc: 'Stated inline as Numeric (6)'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_44
        size: 4
        doc: 'Stated inline as String (4). Nullable, No Value = 0'
  clearing_data:
    seq:
      - id: clearing_instruction
        type: str
        size: 12
        encoding: ASCII
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
      - id: clearing_operation_mode
        type: u1
        enum: clearing_operation_mode
        doc: 'Indicates the pre-posting action to be taken by the clearing system when a trade has occurred. When this field is filled, the field ''Clearing Destination'' must also be filled. Space: No clearing operation C: CMTA (Clearing Member Trading Agreement), firm will be defined in the Clearing Destination field G: Give-Up Firm will be defined in the Clearing Destination field I: Both CMTA and Give-Up firms will be defined in the Post Trading Instruction field The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: clearing_destination
        type: str_4_nullable
        doc: 'Identifies a firm referenced in the SOLA® database. Nullable, No Value = 0'
  owner_data:
    seq:
      - id: client_order_id
        type: str_20_nullable
        doc: 'Client Order Id Unique identifier for orders as assigned by participants. Trailing blanks are not significant. Nullable, No Value = 0'
      - id: pound_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Printed by the guide as a field named #. Separates the ClientOrderId from the Memo within Owner Data: anything before it is the ClientOrderId, anything after it the Memo. # Pound sign'
      - id: memo
        type: str_50_nullable
        doc: 'Free text zone can be used to transmit additional information for processing. No validations are carried out on this field. Nullable, No Value = 0'
  global_cancellation_confirmation:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: type_of_cancellation_only_q_quotes_only_can_be_returned
        type: u1
        enum: type_of_cancellation_only_q_quotes_only_can_be_returned
        doc: 'Type of cancellation A: All L: Locked O: OrdersOnly Q: QuotesOnly'
  improvement_order_acknowlegment:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the Participant with the outcome reserved for the order that is the subject of the entry, modification, or cancellation. " ": Order put in the Order Book (having possibly been partially executed) A: Order cancelled by the trader or at the end of the exposition phase B: Order has been eliminated by the trading system due to invalid out of limits price D: The order is a ''Directed/Routed Order'' and has been received by ExecutingParticipant E: The order has been eliminated by the trading system G: Cancelled By Supervisor I: Session Order has been cancelled when the Participant closes or loses his connection to the SOLA trading system J: Eliminated Due To Maximum Nb Triggers Limit Exceeded K: Eliminated Due To Trade Activity Limit Exceeded L: Order has been sent to the away exchange M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: Order is being exposed R: Order is eliminated due to trading restriction T: Eliminated Due To Trade Limit Exceeded W: Cancel Pending X: Order executed in full (or partially and the remaining part could not be put in the Order Book) (Fill & Kill) The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the Trading System. Refer toPrice for format details'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the trading system'
      - id: auction_id_only_if_message_type_is_ki_or_else_zeroes
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_44
        size: 4
        doc: 'Stated inline as String (4). Nullable, No Value = 0'
  order_modification_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the Participant with the outcome reserved for the order that is the subject of the entry, modification, or cancellation. " ": Order put in the Order Book (having possibly been partially executed) A: Order cancelled by the trader or at the end of the exposition phase B: Order has been eliminated by the trading system due to invalid out of limits price D: The order is a ''Directed/Routed Order'' and has been received by ExecutingParticipant E: The order has been eliminated by the trading system G: Cancelled By Supervisor I: Session Order has been cancelled when the Participant closes or loses his connection to the SOLA trading system J: Eliminated Due To Maximum Nb Triggers Limit Exceeded K: Eliminated Due To Trade Activity Limit Exceeded L: Order has been sent to the away exchange M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: Order is being exposed R: Order is eliminated due to trading restriction T: Eliminated Due To Trade Limit Exceeded W: Cancel Pending X: Order executed in full (or partially and the remaining part could not be put in the Order Book) (Fill & Kill) The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the Trading System. Refer toPrice for format details'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the trading system'
      - id: filler_numeric_66
        size: 6
        doc: 'Stated inline as Numeric (6)'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_44
        size: 4
        doc: 'Stated inline as String (4). Nullable, No Value = 0'
  new_complex_order_instrument_acknowledgement:
    seq:
      - id: strategy_group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: strategy_instrument_id
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: creation_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Stated inline as String (1)'
      - id: num_new_complex_order_instrument_acknowledgement_occurrence
        type: str
        size: 2
        encoding: ASCII
        doc: 'Stated inline as Numeric (2)'
      - id: new_complex_order_instrument_acknowledgement_occurrence
        type: new_complex_order_instrument_acknowledgement_occurrence
        repeat: expr
        repeat-expr: num_new_complex_order_instrument_acknowledgement_occurrence
        doc: 'The guide states this block as 2 to 16 occurrences'
  new_complex_order_instrument_acknowledgement_occurrence:
    seq:
      - id: leg_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying'
      - id: leg_instrument_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a Group'
      - id: leg_verb
        type: u1
        enum: leg_verb
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: filler_must_be_spaces
        size: 1
        doc: 'Stated inline as String (1)'
      - id: leg_quantity_ratio
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
  standard_acknowledgement:
    seq:
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: original_message_type_re_rf_rq_rp_gz
        type: str
        size: 2
        encoding: ASCII
        doc: 'Type of Message'
  complex_order_auction_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the Participant with the outcome reserved for the order that is the subject of the entry, modification, or cancellation. " ": Order put in the Order Book (having possibly been partially executed) A: Order cancelled by the trader or at the end of the exposition phase B: Order has been eliminated by the trading system due to invalid out of limits price D: The order is a ''Directed/Routed Order'' and has been received by ExecutingParticipant E: The order has been eliminated by the trading system G: Cancelled By Supervisor I: Session Order has been cancelled when the Participant closes or loses his connection to the SOLA trading system J: Eliminated Due To Maximum Nb Triggers Limit Exceeded K: Eliminated Due To Trade Activity Limit Exceeded L: Order has been sent to the away exchange M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: Order is being exposed R: Order is eliminated due to trading restriction T: Eliminated Due To Trade Limit Exceeded W: Cancel Pending X: Order executed in full (or partially and the remaining part could not be put in the Order Book) (Fill & Kill) The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the Trading System. Refer toPrice for format details'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the trading system'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_44
        size: 4
        doc: 'Stated inline as String (4). Nullable, No Value = 0'
  auction_or_improvement_cancellation_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the Participant with the outcome reserved for the order that is the subject of the entry, modification, or cancellation. " ": Order put in the Order Book (having possibly been partially executed) A: Order cancelled by the trader or at the end of the exposition phase B: Order has been eliminated by the trading system due to invalid out of limits price D: The order is a ''Directed/Routed Order'' and has been received by ExecutingParticipant E: The order has been eliminated by the trading system G: Cancelled By Supervisor I: Session Order has been cancelled when the Participant closes or loses his connection to the SOLA trading system J: Eliminated Due To Maximum Nb Triggers Limit Exceeded K: Eliminated Due To Trade Activity Limit Exceeded L: Order has been sent to the away exchange M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: Order is being exposed R: Order is eliminated due to trading restriction T: Eliminated Due To Trade Limit Exceeded W: Cancel Pending X: Order executed in full (or partially and the remaining part could not be put in the Order Book) (Fill & Kill) The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the Trading System. Refer toPrice for format details'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the trading system'
      - id: auction_id_only_if_message_type_is_ki_or_else_zeroes
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction'
  order_cancellation_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the Participant with the outcome reserved for the order that is the subject of the entry, modification, or cancellation. " ": Order put in the Order Book (having possibly been partially executed) A: Order cancelled by the trader or at the end of the exposition phase B: Order has been eliminated by the trading system due to invalid out of limits price D: The order is a ''Directed/Routed Order'' and has been received by ExecutingParticipant E: The order has been eliminated by the trading system G: Cancelled By Supervisor I: Session Order has been cancelled when the Participant closes or loses his connection to the SOLA trading system J: Eliminated Due To Maximum Nb Triggers Limit Exceeded K: Eliminated Due To Trade Activity Limit Exceeded L: Order has been sent to the away exchange M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: Order is being exposed R: Order is eliminated due to trading restriction T: Eliminated Due To Trade Limit Exceeded W: Cancel Pending X: Order executed in full (or partially and the remaining part could not be put in the Order Book) (Fill & Kill) The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the Trading System. Refer toPrice for format details'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the trading system'
      - id: auction_id_only_if_message_type_is_ki_or_else_zeroes
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_44
        size: 4
        doc: 'Stated inline as String (4). Nullable, No Value = 0'
  bulk_quote_acknowledgement:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: quote_id_identifies_traders_quote_on_this_group
        type: str_8_nullable
        doc: 'If entered by Participant Quote ID is validated against the Quote ID received in the KD “Sail Bulk Quote Acknowledgment message”, On failed validation the system returns an ER “Sail Error Notice” message with the expected Quote ID. An empty Quote ID is accepted and not validated by the system. An empty Quote ID is defined as follows: All ‘ ‘ (blank) spaces 00000000 On all outbound messages with Quote ID, the Quote ID corresponds to the Quote ID referenced in the KD message. Nullable, No Value = 0'
      - id: num_bulk_quote_acknowledgement_occurrence
        type: str
        size: 3
        encoding: ASCII
        doc: 'Stated inline as Numeric (3)'
      - id: bulk_quote_acknowledgement_occurrence
        type: bulk_quote_acknowledgement_occurrence
        repeat: expr
        repeat-expr: num_bulk_quote_acknowledgement_occurrence
        doc: 'The guide states this block as 1 to 280 occurrences'
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
        doc: 'Refer to Error Codes for error code definitions'
  trader_status:
    seq:
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: trader_lock_out
        type: u1
        enum: trader_lock_out
        doc: 'L: Locked U: Unlocked The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: risk_team_lock_out
        type: u1
        enum: risk_team_lock_out
        doc: 'L: Locked U: Unlocked The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
  directed_order_cancellation_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: referenced_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
  directed_order_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: price
        type: str_10_nullable
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: referenced_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
  excluded_instrument_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: filler_string_22
        size: 2
        doc: 'Stated inline as String (2)'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: filler_2
        size: 2
        doc: 'Stated inline as String (2)'
      - id: nb_of_instruments
        type: str
        size: 4
        encoding: ASCII
        doc: 'Stated inline as Numeric (4)'
      - id: 1_to_9999_occurrences_instrument
        type: str
        size: 4
        encoding: ASCII
        doc: 'Instrument identification within a Group'
  group_state_change:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: group_state
        type: u1
        enum: group_state
        doc: 'This parameter indicates the new status of the group. For message type NG, it contains one of the following values: B: Post session C: Consultation Start F: Consultation End I: Prohibited M: Mini-batch N: Market Operation Center Intervention O: Opening P: Pre-opening S: Continuous Trading Session Z: Interrupted'
  leg_execution_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity_traded
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: time_trade_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Defines the type of trade A: As-Of-Trade B: Block Trade L: Late Trade O: Hidden Trade S: Size Adjustment Trade R: Floor Trade D: Customer Cross Order or Qualified Contingent Cross Order Applies to Solicitation, Facilitation and Floor Trade only: g: Contingent Trade (trade was not controlled against the NBBO)'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'For regular order: L: Limit (price set in message) O: At Opening price W: At any price (Market Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the trade A: Traded during a Guaranteed Auction B: Solicitation Auction C: Facilitation Auction F: Traded during Continuous Trading following FIFO algorithm M: Trade entered by Market Operations O: Traded during Opening'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an instrument and one day'
      - id: trade_memo_string_5050
        type: str_50_nullable
        doc: 'Stated inline as String (50). Nullable, No Value = 0'
      - id: original_reference_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: liquidity_status
        type: u1
        enum: liquidity_status
        doc: 'Indicates if the trade adds or removes liquidity M: Maker T: Taker [ ]: Trade is not eligible for Make or Take fee pricing structure'
      - id: strategy_group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: strategy_instrument_id
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: strategy_verb_side
        type: u1
        enum: strategy_verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: strategy_trade_number
        type: str_8_nullable
        doc: 'Identifies the trade number for an instrument and one day. Nullable, No Value = 0'
      - id: leg_number
        type: str_2_nullable
        doc: 'ID of the leg of the Complex Order Instrument. Maximum value of 16. Nullable, No Value = 0'
      - id: counterpart_account_type
        type: u1
        enum: counterpart_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_11
        size: 1
        doc: 'Stated inline as String (1)'
      - id: filler_zero_filled
        size: 4
        doc: 'Stated inline as String (4)'
  cancellation_of_all_quotes_notices:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: quote_cancel_reason
        type: u1
        enum: quote_cancel_reason
        doc: 'Identifies the type of quote cancellation A: Cancelled by the Trader D: MMP – Percent Of Quote has been reached E: Maximum Triggers Protection Limit Exceeded G: Cancelled By Supervisor I: Eliminated on Disconnect L: Traded Activity Protection Limit Exceeded M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: MMP - Max number of trades has been reached Q: Quotes Cancelled R: MMP - Max value has been reached S: Cancelled by the System T: MMP - Max Volume has been reached N: MMP - Max Delta Volume has been reached V: MMP - Max Delta Value has been reached W: Cancel Pending'
  quality_market_maker_notification:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: verb
        type: u1
        enum: verb
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: auction_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: auction_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: quote_quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: quote_price
        type: str_10_nullable
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant. Nullable, No Value = 0'
      - id: qualified_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
  execution_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: reference_id_order_id_or_quote_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The guide states the field type as Order ID/Quote ID'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity_traded
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: time_of_the_trade_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Defines the type of trade A: As-Of-Trade B: Block Trade L: Late Trade O: Hidden Trade S: Size Adjustment Trade R: Floor Trade D: Customer Cross Order or Qualified Contingent Cross Order Applies to Solicitation, Facilitation and Floor Trade only: g: Contingent Trade (trade was not controlled against the NBBO)'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'For regular order: L: Limit (price set in message) O: At Opening price W: At any price (Market Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the trade A: Traded during a Guaranteed Auction B: Solicitation Auction C: Facilitation Auction F: Traded during Continuous Trading following FIFO algorithm M: Trade entered by Market Operations O: Traded during Opening'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an instrument and one day'
      - id: trade_memo_trade_memo_50
        type: str
        size: 50
        encoding: ASCII
        doc: 'Text entered by Market Operation when it is a Manual Trade Entry'
      - id: original_reference_id_original_reference_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order or the Quote ID of the quote that has traded ID Code for the Counterpart Participant Trader ID firm if it is a cross trade, else blank'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: liquidity_status
        type: u1
        enum: liquidity_status
        doc: 'Indicates if the trade adds or removes liquidity M: Maker T: Taker [ ]: Trade is not eligible for Make or Take fee pricing structure'
      - id: counterpart_account_type
        type: u1
        enum: counterpart_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_11
        size: 1
        doc: 'Stated inline as String (1)'
      - id: filler_zero_filled
        size: 4
        doc: 'Stated inline as String (4)'
  quote_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: reference_id_quote
        type: str
        size: 8
        encoding: ASCII
        doc: 'If entered by Participant Quote ID is validated against the Quote ID received in the KD “Sail Bulk Quote Acknowledgment message”, On failed validation the system returns an ER “Sail Error Notice” message with the expected Quote ID. An empty Quote ID is accepted and not validated by the system. An empty Quote ID is defined as follows: All ‘ ‘ (blank) spaces 00000000 On all outbound messages with Quote ID, the Quote ID corresponds to the Quote ID referenced in the KD message'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'O: Order Q: Quote'
      - id: action
        type: u1
        enum: action
        doc: 'Q: Quantity Update S: Shelved U: Un-shelved'
      - id: new_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: new_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: previous_quantity
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of contracts or shares'
      - id: previous_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: original_reference_id_quote_or_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
  execution_cancellation_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: reference_id_order_id_or_quote_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'The guide states the field type as Order ID/Quote ID'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity_traded
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: time_of_the_trade_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Defines the type of trade A: As-Of-Trade B: Block Trade L: Late Trade O: Hidden Trade S: Size Adjustment Trade R: Floor Trade D: Customer Cross Order or Qualified Contingent Cross Order Applies to Solicitation, Facilitation and Floor Trade only: g: Contingent Trade (trade was not controlled against the NBBO)'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'For regular order: L: Limit (price set in message) O: At Opening price W: At any price (Market Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the trade A: Traded during a Guaranteed Auction B: Solicitation Auction C: Facilitation Auction F: Traded during Continuous Trading following FIFO algorithm M: Trade entered by Market Operations O: Traded during Opening'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an instrument and one day'
      - id: trade_memo_trade_memo_50
        type: str
        size: 50
        encoding: ASCII
        doc: 'Text entered by Market Operation when it is a Manual Trade Entry'
      - id: original_reference_id_original_reference_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'References either the Original Order ID of the traded order or the Quote ID of the quote that has traded ID Code for the Counterpart Participant Trader ID firm if it is a cross trade, else blank'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: liquidity_status
        type: u1
        enum: liquidity_status
        doc: 'Indicates if the trade adds or removes liquidity M: Maker T: Taker [ ]: Trade is not eligible for Make or Take fee pricing structure'
      - id: counterpart_account_type
        type: u1
        enum: counterpart_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_11
        size: 1
        doc: 'Stated inline as String (1)'
      - id: filler_zero_filled
        size: 4
        doc: 'Stated inline as String (4)'
  leg_execution_cancellation_notice:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: reference_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity_traded
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: trade_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price with format indicator and price mantissa Format indicator (1): If the format indicator is Alpha, it means that the price is negative (A means negative value with no decimal, B means negative value with 1 decimal, C means negative value with 2 decimals, etc.). If the format indicator is Numeric, it means that the price is positive (0 means positive value with no decimal, 1 means positive value with one decimal, 2 means positive value with 2 decimals, etc.). If the format indicator is set to spaces, it means that the price is not significant. Price mantissa (9): Represents the price value including the number of decimals defined in the format indicator. Examples: Format indicator = 2; Price mantissa = 3509438; Price = 35094.38 Format indicator = A; Price mantissa = 3567838; Price = -3567838 Format indicator = ; Price mantissa = 3567838; Price = not significant'
      - id: time_trade_hhmmss
        type: str
        size: 6
        encoding: ASCII
        doc: 'HHMMSS'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: special_trade_indicator
        type: u1
        enum: special_trade_indicator
        doc: 'Defines the type of trade A: As-Of-Trade B: Block Trade L: Late Trade O: Hidden Trade S: Size Adjustment Trade R: Floor Trade D: Customer Cross Order or Qualified Contingent Cross Order Applies to Solicitation, Facilitation and Floor Trade only: g: Contingent Trade (trade was not controlled against the NBBO)'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'For regular order: L: Limit (price set in message) O: At Opening price W: At any price (Market Order)'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Identifies the origin of the trade A: Traded during a Guaranteed Auction B: Solicitation Auction C: Facilitation Auction F: Traded during Continuous Trading following FIFO algorithm M: Trade entered by Market Operations O: Traded during Opening'
      - id: auction_id
        type: str_6_nullable
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction. Nullable, No Value = 0'
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trade number for an instrument and one day'
      - id: trade_memo_string_5050
        type: str_50_nullable
        doc: 'Stated inline as String (50). Nullable, No Value = 0'
      - id: original_reference_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: id_code_for_the_counterpart_participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies a firm referenced in the SOLA® database'
      - id: liquidity_status
        type: u1
        enum: liquidity_status
        doc: 'Indicates if the trade adds or removes liquidity M: Maker T: Taker [ ]: Trade is not eligible for Make or Take fee pricing structure'
      - id: strategy_group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: strategy_instrument_id
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: strategy_verb_side
        type: u1
        enum: strategy_verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: strategy_trade_number
        type: str_8_nullable
        doc: 'Identifies the trade number for an instrument and one day. Nullable, No Value = 0'
      - id: leg_number
        type: str_2_nullable
        doc: 'ID of the leg of the Complex Order Instrument. Maximum value of 16. Nullable, No Value = 0'
      - id: counterpart_account_type
        type: u1
        enum: counterpart_account_type
        doc: '6: Public Customer 7: Broker Dealer 8: Market Maker T: Professional Customer W: Broker Dealer cleared as Customer X: Away Market Maker'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_11
        size: 1
        doc: 'Stated inline as String (1)'
      - id: filler_zero_filled
        size: 4
        doc: 'Stated inline as String (4)'
  order_cancellation_notice_by_system:
    seq:
      - id: group
        type: str_2_nullable
        doc: 'Group Identification within the system. A Group is composed of instruments and is usually associated with a specific underlying. Nullable, No Value = 0'
      - id: instrument
        type: str_4_nullable
        doc: 'Instrument identification within a Group. Nullable, No Value = 0'
      - id: trader_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the trader 4 first characters: Firm Identifier 4 Last characters: Trader Identifier'
      - id: order_id_order_id_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies an order. Associated with Group ID and Instrument ID; it is the Order Key identifier'
      - id: status
        type: u1
        enum: status
        doc: 'Provides the Participant with the outcome reserved for the order that is the subject of the entry, modification, or cancellation. " ": Order put in the Order Book (having possibly been partially executed) A: Order cancelled by the trader or at the end of the exposition phase B: Order has been eliminated by the trading system due to invalid out of limits price D: The order is a ''Directed/Routed Order'' and has been received by ExecutingParticipant E: The order has been eliminated by the trading system G: Cancelled By Supervisor I: Session Order has been cancelled when the Participant closes or loses his connection to the SOLA trading system J: Eliminated Due To Maximum Nb Triggers Limit Exceeded K: Eliminated Due To Trade Activity Limit Exceeded L: Order has been sent to the away exchange M: Cancelled by the BOX Market Operations Center (MOC) O: Eliminated Due To Drill Through Protection P: Order is being exposed R: Order is eliminated due to trading restriction T: Eliminated Due To Trade Limit Exceeded W: Cancel Pending X: Order executed in full (or partially and the remaining part could not be put in the Order Book) (Fill & Kill) The guide states no width for this type. One character is inferred from the values it states, each of which is one character wide'
      - id: verb_side
        type: u1
        enum: verb_side
        doc: 'Identifies an order/quote side B: Buy S: Sell'
      - id: quantity
        type: str_8_nullable
        doc: 'Number of contracts or shares. Nullable, No Value = 0'
      - id: assigned_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price assigned by the Trading System. Refer toPrice for format details'
      - id: clearing_data
        type: clearing_data
        doc: 'The guide states these fields once, as Clearing Data, for every message that carries them'
      - id: owner_data
        type: owner_data
        doc: 'The guide states these fields once, as Owner Data, for every message that carries them'
      - id: original_order_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'First Order ID assigned to the order by the trading system'
      - id: auction_id_only_if_message_type_is_ki_or_else_zeroes
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifies the number of an auction (Improvement Phase). It is a sequential number which is unique per Instrument and per Trading Day. Current Auction identifier if the trade occurred during an auction'
      - id: additional_client_memo
        type: str_16_nullable
        doc: 'Free format text string can be used to transmit additional information for processing. Left justified, right blank filled Format rules: None of the following ascii characters: ‘%’ (percent sign), ‘,’ (comma), ‘;’ (semi-colon), ‘#’ (pound sign), ‘ “ ’ (double-quote) and ‘|’ (pipe) ASCII characters in the decimal code ranges between 0 and 31 and 127 and up are not permitted. Nullable, No Value = 0'
      - id: filler_must_be_blank_string_44
        size: 4
        doc: 'Stated inline as String (4). Nullable, No Value = 0'
  str_6_nullable:
    seq:
      - id: value
        size: 6
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
  str_20_nullable:
    seq:
      - id: value
        size: 20
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  str_200_nullable:
    seq:
      - id: value
        size: 200
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
  str_16_nullable:
    seq:
      - id: value
        size: 16
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

enums:
  disconnection_instruction_note_cancel_quotes_only_q_quotes_only:
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
  active_y_on_n_off:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
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
  clearing_operation_mode:
    0x20:
      id: 'no_clearing_operation'
      doc: 'No Clearing Operation'
    0x43:
      id: 'cmta_clearing_member_trading_agreement_firm_will_be_defined_in_the_clearing_destination_field'
      doc: 'Cmta Clearing Member Trading Agreement Firm Will Be Defined In The Clearing Destination Field'
    0x47:
      id: 'give_up_firm_will_be_defined_in_the_clearing_destination_field'
      doc: 'Give Up Firm Will Be Defined In The Clearing Destination Field'
    0x49:
      id: 'both_cmta_and_give_up_firms_will_be_defined_in_the_post_trading_instruction_field_the_guide_states_no_width_for_this_type_one_character_is_inferred_from_the_values_it_states_each_of_which_is_one_character_wide'
      doc: 'Both Cmta And Give Up Firms Will Be Defined In The Post Trading Instruction Field The Guide States No Width For This Type One Character Is Inferred From The Values It States Each Of Which Is One Character Wide'
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
    0x20:
      id: 'none_the_above_value_indicates_that_the_init_o_is_willing_to_surrender_a_portion_of_the_total_number_of_contracts'
      doc: 'None The Above Value Indicates That The Init O Is Willing To Surrender A Portion Of The Total Number Of Contracts'
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
  leg_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
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
  status:
    0x41:
      id: 'order_cancelled_by_the_trader_or_at_the_end_of_the_exposition_phase'
      doc: 'Order Cancelled By The Trader Or At The End Of The Exposition Phase'
    0x42:
      id: 'order_has_been_eliminated_by_the_trading_system_due_to_invalid_out_of_limits_price'
      doc: 'Order Has Been Eliminated By The Trading System Due To Invalid Out Of Limits Price'
    0x44:
      id: 'the_order_is_a_directed_routed_order_and_has_been_received_by_executing_participant'
      doc: 'The Order Is A Directed Routed Order And Has Been Received By Executing Participant'
    0x45:
      id: 'the_order_has_been_eliminated_by_the_trading_system'
      doc: 'The Order Has Been Eliminated By The Trading System'
    0x47:
      id: 'cancelled_by_supervisor'
      doc: 'Cancelled By Supervisor'
    0x49:
      id: 'session_order_has_been_cancelled_when_the_participant_closes_or_loses_his_connection_to_the_sola_trading_system'
      doc: 'Session Order Has Been Cancelled When The Participant Closes Or Loses His Connection To The Sola Trading System'
    0x4a:
      id: 'eliminated_due_to_maximum_nb_triggers_limit_exceeded'
      doc: 'Eliminated Due To Maximum Nb Triggers Limit Exceeded'
    0x4b:
      id: 'eliminated_due_to_trade_activity_limit_exceeded'
      doc: 'Eliminated Due To Trade Activity Limit Exceeded'
    0x4c:
      id: 'order_has_been_sent_to_the_away_exchange'
      doc: 'Order Has Been Sent To The Away Exchange'
    0x4d:
      id: 'cancelled_by_the_box_market_operations_center_moc'
      doc: 'Cancelled By The Box Market Operations Center Moc'
    0x4f:
      id: 'eliminated_due_to_drill_through_protection'
      doc: 'Eliminated Due To Drill Through Protection'
    0x50:
      id: 'order_is_being_exposed'
      doc: 'Order Is Being Exposed'
    0x52:
      id: 'order_is_eliminated_due_to_trading_restriction'
      doc: 'Order Is Eliminated Due To Trading Restriction'
    0x54:
      id: 'eliminated_due_to_trade_limit_exceeded'
      doc: 'Eliminated Due To Trade Limit Exceeded'
    0x57:
      id: 'cancel_pending'
      doc: 'Cancel Pending'
    0x58:
      id: 'order_executed_in_full_or_partially_and_the_remaining_part_could_not_be_put_in_the_order_book_fill_kill_the_guide_states_no_width_for_this_type_one_character_is_inferred_from_the_values_it_states_each_of_which_is_one_character_wide'
      doc: 'Order Executed In Full Or Partially And The Remaining Part Could Not Be Put In The Order Book Fill Kill The Guide States No Width For This Type One Character Is Inferred From The Values It States Each Of Which Is One Character Wide'
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
  trader_lock_out:
    0x4c:
      id: 'locked'
      doc: 'Locked'
    0x55:
      id: 'unlocked_the_guide_states_no_width_for_this_type_one_character_is_inferred_from_the_values_it_states_each_of_which_is_one_character_wide'
      doc: 'Unlocked The Guide States No Width For This Type One Character Is Inferred From The Values It States Each Of Which Is One Character Wide'
  risk_team_lock_out:
    0x4c:
      id: 'locked'
      doc: 'Locked'
    0x55:
      id: 'unlocked_the_guide_states_no_width_for_this_type_one_character_is_inferred_from_the_values_it_states_each_of_which_is_one_character_wide'
      doc: 'Unlocked The Guide States No Width For This Type One Character Is Inferred From The Values It States Each Of Which Is One Character Wide'
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

