# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options Flex Spin v1.1.30
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Flex
#   Encoding: Spin
#   Version: 1.1.30
#   Date: 04/01/2026
#   Specification: US_Options_FLEX_Specification.pdf
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
  id: cboe_c1options_flex_spin_v1_1_30
  title: Cboe C1Options Flex Spin v1.1.30
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C1 Options Flex Spin v1.1.30'
doc-ref: http://markets.cboe.com/us/options/support/technical/

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Hdr Count messages to follow'
      - id: count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_message': login_message
            'message_type::login_response_message': login_response_message
            'message_type::spin_image_available_message': spin_image_available_message
            'message_type::spin_request_message': spin_request_message
            'message_type::spin_response_message': spin_response_message
            'message_type::spin_finished_message': spin_finished_message
            'message_type::instrument_definition_request_message': instrument_definition_request_message
            'message_type::instrument_definition_response_message': instrument_definition_response_message
            'message_type::time_message': time_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::flex_instrument_definition_message': flex_instrument_definition_message
            'message_type::complex_flex_instrument_definition_message': complex_flex_instrument_definition_message
            'message_type::trading_status_message': trading_status_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  login_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'SessionSubId supplied by Cboe'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username supplied by Cboe'
      - id: filler
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '(space filled)'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password supplied by Cboe'
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted or reason for reject'
  spin_image_available_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: order_count
        type: u4
        doc: 'Always zero'
      - id: spin_response_status
        type: u1
        enum: spin_response_status
        doc: 'Accepted or reason for reject. All non-A status codes should be interpreted as a reject'
  spin_finished_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: instrument_count
        type: u4
        doc: 'Number of Symbol Mapping and Complex Instrument Definition Expanded (if applicable) messages which will be contained in this spin'
      - id: instrument_definition_response_status
        type: u1
        enum: instrument_definition_response_status
        doc: 'Accepted or reason for reject'
  time_message:
    seq:
      - id: time
        type: u4
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day'
      - id: epoch_time
        type: u4
        doc: 'Number of whole seconds since the Epoch (midnight January 1, 1970 UTC)'
  symbol_mapping_message:
    seq:
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_symbol
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Symbol'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: 'Symbol condition indicator'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
  flex_instrument_definition_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_root
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Root right padded with spaces'
      - id: year
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit year'
      - id: month
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit month'
      - id: day
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit day'
      - id: call_put_indicator
        type: u1
        enum: call_put_indicator
        doc: 'Call/Put indicator'
      - id: dollar_strike
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Dollar strike (if not percentage) left padded with zero. If percentage, field is space padded'
      - id: decimal_strike
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Decimal strike (if not percentage) left padded with zero. If percentage, field is space padded'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: 'Symbol condition indicator'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Exercise style indicator'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement type indicator'
      - id: percentage
        type: u4
        doc: 'Percentage when strike and price is percentage based (implied 4 decimal places). Otherwise zero'
      - id: observation_day
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit observation day of month. Valid only for Asian and Cliquet options, otherwise space padded'
      - id: return_cap_percentage
        type: u4
        doc: 'Return cap percentage (implied 2 decimal places). Valid only for Cliquet, otherwise zero'
      - id: creation_day
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Two digit creation day of the month. Valid only for Cliquet, otherwise space padded'
      - id: bit_fields
        type: bit_fields
  bit_fields:
    meta:
      bit-endian: le
    seq:
      - id: percentage_1
        type: b1
      - id: reserved_7
        type: b7
  complex_flex_instrument_definition_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: complex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument ID right padded with spaces'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
      - id: complex_instrument_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '4 character field. Character 1: Complex Option Type. Characters 2-4: Reserved'
      - id: leg_count
        type: u1
        doc: 'The number of legs in the complex instrument. The maximum number of legs is 100'
      - id: message_count
        type: u1
        doc: 'Number of messages required to define the complex instrument'
      - id: message_number
        type: u1
        doc: 'Message number of the message count, e.g. 1 of 5'
      - id: num_complex_flex_leg
        type: u1
        doc: 'The number of legs in this message'
      - id: complex_flex_leg
        type: complex_flex_leg
        repeat: expr
        repeat-expr: num_complex_flex_leg
        doc: 'Repeating leg definition for complex FLEX instruments. Repeats Message Leg Count times'
  complex_flex_leg:
    seq:
      - id: leg_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Symbol, right padded with spaces'
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for buy-side, negative for sell-side)'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'The instrument type of this leg'
  trading_status_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status indicator'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: gth_trading_status
        type: u1
        enum: gth_trading_status
        doc: 'GTH Trading Status indicator'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'

enums:
  message_type:
    0x01:
      id: 'login_message'
      doc: 'The Login message is the first message sent to the Spin Server by a user''s process after the connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. The format of the Login message for the Spin Server is identical to that of the GRP.'
    0x02:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by the Spin Server to a user''s process in response to a Login message. The status field is used to reflect an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'The Spin Image Available message is sent once per second and indicates through what sequence number a spin is available.'
    0x81:
      id: 'spin_request_message'
      doc: 'The Spin Request message is used by a user''s process to request transmission of a spin of the unit''s order book.'
    0x82:
      id: 'spin_response_message'
      doc: 'The Spin Response message is sent in response to a user''s Spin Request message indicating whether a spin will be sent.'
    0x83:
      id: 'spin_finished_message'
      doc: 'The Spin Finished message is sent to indicate that all messages for the spin requested have been sent. A Spin Finished message is only sent if a Spin Request was not rejected. Upon receipt of a Spin Finished message, any buffered multicast messages should be applied to the customer''s copy of the book to make it current.'
    0x84:
      id: 'instrument_definition_request_message'
      doc: 'The Instrument Definition Request message is used by a user''s process to request transmission of this unit''s Symbol Mappings and Complex Instrument Definitions. All Symbol Mapping messages will be sent before Complex Instrument Definition Expanded and Exchange Designated Complex Instrument Definition messages.'
    0x85:
      id: 'instrument_definition_response_message'
      doc: 'The Instrument Definition Response message is sent in response to a user''s Instrument Definition Request message indicating whether a spin will be sent.'
    0x86:
      id: 'instrument_definition_finished_message'
      doc: 'The Instrument Definition Finished message is sent to indicate that all Symbol Mapping and Complex Instrument Definition Expanded messages for this unit have been sent. An Instrument Definition Finished message is only sent if an Instrument Definition Request was not rejected.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a FLEX event for a given clock second.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol and Underlying.'
    0x9c:
      id: 'flex_instrument_definition_message'
      doc: 'A FLEX Instrument Definition message represents an instrument that is available to place orders.'
    0x9b:
      id: 'complex_flex_instrument_definition_message'
      doc: 'A Complex FLEX Instrument Definition message represents a complex instrument that is available to place orders.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a FLEX options instrument.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized_invalid_username_password'
      doc: 'Not Authorized Invalid Username Password'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
  spin_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_requested_is_greater_than_sequence_available_by_the_next_spin'
      doc: 'Out Of Range Sequence Requested Is Greater Than Sequence Available By The Next Spin'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  instrument_definition_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_must_be_0'
      doc: 'Out Of Range Sequence Must Be 0'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
  call_put_indicator:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  exercise_style:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
  settlement_type:
    0x41:
      id: 'am'
      doc: 'Am'
    0x50:
      id: 'pm'
      doc: 'Pm'
    0x53:
      id: 'asian'
      doc: 'Asian'
    0x51:
      id: 'cliquet'
      doc: 'Cliquet'
  leg_security_type:
    0x58:
      id: 'flex_option'
      doc: 'Flex Option'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x4f:
      id: 'listed_option'
      doc: 'Listed Option'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x4c:
      id: 'curb_trading'
      doc: 'Curb Trading'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x54:
      id: 'rth_trading'
      doc: 'Rth Trading'
  gth_trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x54:
      id: 'trading'
      doc: 'Trading'

