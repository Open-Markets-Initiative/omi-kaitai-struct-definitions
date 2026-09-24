# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures MulticastDepthOfBook Spin v1.2.13
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Futures Multicast Depth Of Book
#   Encoding: Spin
#   Version: 1.2.13
#   Date: 04/07/2025
#   Specification: Cboe Futures Exchange Multicast PITCH Specification (2025-05-04).pdf
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
  id: cboe_cfefutures_multicastdepthofbook_spin_v1_2_13
  title: Cboe CfeFutures MulticastDepthOfBook Spin v1.2.13
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange Futures Multicast Depth Of Book Spin v1.2.13'
doc-ref: http://markets.cboe.com/us/futures/support/technical/

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
            'message_type::time_reference_message': time_reference_message
            'message_type::time_message': time_message
            'message_type::futures_instrument_definition_message': futures_instrument_definition_message
            'message_type::futures_variance_symbol_mapping_message': futures_variance_symbol_mapping_message
            'message_type::add_order_long_message': add_order_long_message
            'message_type::add_order_short_message': add_order_short_message
            'message_type::trading_status_message': trading_status_message
            'message_type::settlement_message': settlement_message
            'message_type::price_limits_message': price_limits_message
            'message_type::end_of_day_summary_message': end_of_day_summary_message
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
  time_reference_message:
    seq:
      - id: midnight_reference
        type: second_timestamp
        doc: 'Midnight Central Time reference time for subsequent Time messages, expressed as number of whole seconds since the Epoch (Midnight January 1, 1970 UTC). Seconds since Unix epoch'
      - id: time_reference
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Central Time. Seconds since Midnight epoch'
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
  time_message:
    seq:
      - id: time_reference
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Central Time. Seconds since Midnight epoch'
      - id: epoch_time
        type: u4
        doc: 'Number of whole seconds since the Epoch (Midnight January 1, 1970 UTC)'
  futures_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: unit_timestamp
        type: u4
        doc: 'Unit timestamp expressed as number of whole seconds since the Epoch (Midnight, January 1, 1970 UTC)'
      - id: report_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol for product or underlying security'
      - id: futures_flags
        type: futures_flags
        doc: 'Futures Flags bitfields'
      - id: expiration_date
        type: u4
        doc: 'Expiration Date of Instrument'
      - id: contract_size
        type: u2
        doc: 'Contract size of Instrument. Contract sizes less than 1 are represented with a 0 value; refer to the product specification for the contract size'
      - id: listing_state
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing State Values'
      - id: price_increment
        type: decimal_u8_4
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-4'
      - id: num_future_leg
        type: u1
        doc: 'Values greater than 0 indicate this is a spread instrument'
      - id: leg_offset
        type: u1
        doc: 'Leg definitions, if any, begin at this offset from the beginning of the message. Possible values are 0 (no legs present) or 45 (spread instrument)'
      - id: reserved_1
        type: u1
        doc: 'Reserved. Value will always be zero'
      - id: contract_date
        type: u4
        doc: 'Populated for single leg instruments only. Zero-filled for spread instruments. The date that should be used in describing the future''s third party symbol and the measurement period of the contract'
      - id: future_leg
        type: future_leg
        repeat: expr
        repeat-expr: num_future_leg
        doc: 'Future Leg'
  futures_flags:
    meta:
      bit-endian: le
    seq:
      - id: variance
        type: b1
        doc: 'Set for a Variance Future, clear for a Standard Future'
      - id: reserved_flags_7
        type: b7
        doc: 'Reserved 1-7 Bits'
  future_leg:
    seq:
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for buy, negative for sell)'
      - id: leg_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of leg'
  futures_variance_symbol_mapping_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: unit_timestamp
        type: u4
        doc: 'Unit timestamp expressed as number of whole seconds since the Epoch (Midnight, January 1, 1970 UTC)'
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: futures_symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Twelve character textual definition of the symbol where the first six characters contain the product symbol, left justified, and padded on the right with spaces, and the right most six characters are the expiration date in YYMMDD format'
      - id: accrued_day_variance
        type: decimal_s8_12
        doc: 'Accrued day variance as of the start of the trading day (signed 64-bit decimal with twelve implied decimal places). Implied decimal with scale 1e-12'
      - id: num_final_returns
        type: u2
        doc: 'Number of S&P 500 Index returns used in the Final Settlement Value calculation'
      - id: num_elapsed_returns
        type: u2
        doc: 'Number of elapsed S&P 500 Index returns including the current day'
  add_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side Indicator Values'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
  add_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side Indicator Values'
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status Values'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  settlement_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
      - id: settlement_price
        type: decimal_u8_4
        doc: 'Settlement Price. Implied decimal with scale 1e-4'
      - id: issue
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Values'
  price_limits_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: upper_price_limit
        type: decimal_u8_4
        doc: 'Upper price limit. Implied decimal with scale 1e-4'
      - id: lower_price_limit
        type: decimal_u8_4
        doc: 'Lower price limit. Implied decimal with scale 1e-4'
  end_of_day_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
      - id: open_interest
        type: u4
        doc: 'Prior Trade Date Open Interest for this symbol'
      - id: high_price
        type: decimal_u8_4
        doc: 'The higher of highest bid price and highest trade price for the day. Block and ECRP trades (Trade Condition=B or E) do not update High Price. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'The lower of lowest offer price and lowest trade price for the day. Block and ECRP trades (Trade Condition=B or E) do not update Low Price. Implied decimal with scale 1e-4'
      - id: open_price
        type: decimal_u8_4
        doc: 'The first trade on the day (in any session) will set the Open Price for the day (valid only if Total Volume > 0). Block and ECRP trades (Trade Condition=B or E) do not update Open Price. Implied decimal with scale 1e-4'
      - id: close_price
        type: decimal_u8_4
        doc: 'The last trade on the day (in any session) will set the Close Price for the day (valid only if Total Volume > 0). Block and ECRP trades (Trade Condition=B or E) do not update Close Price. Implied decimal with scale 1e-4'
      - id: total_volume
        type: u4
        doc: 'Total number of contracts traded for the day, including block and ECRP trades'
      - id: block_volume
        type: u4
        doc: 'Total number of block and derived contracts traded for the day'
      - id: ecrp_volume
        type: u4
        doc: 'Total number of contracts traded for the day'
      - id: summary_flags
        type: summary_flags
        doc: 'Summary Flags bitfields'
  summary_flags:
    meta:
      bit-endian: le
    seq:
      - id: high_price_valid
        type: b1
        doc: 'Set if high price valid value'
      - id: high_price_is_bid
        type: b1
        doc: 'Set if high price was set by the highest bid'
      - id: low_price_valid
        type: b1
        doc: 'Set if low price is a valid value'
      - id: low_price_is_offer
        type: b1
        doc: 'Set if low price was set by the lowest offer'
      - id: offer_close_valid
        type: b1
        doc: 'Set if open price and close price contain valid values'
      - id: reserved_flags_3
        type: b3
        doc: 'Reserved 5-7 Bits'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_12:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000000.0
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x01:
      id: 'login_message'
      doc: 'The Login message is the first message sent to the Spin Server by a user''s process after the connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. The format of the Login message for the Spin Server is identical to that of the GRP.'
    0x02:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by the Spin Server to a user''s process in response to a Login message.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'The Spin Image Available message is sent once per second and indicates through what sequence number a spin is available.'
    0x81:
      id: 'spin_request_message'
      doc: 'The Spin Request message is used by a user''s process to request transmission of a spin of the unit''s order book.'
    0x82:
      id: 'spin_response_message'
      doc: 'The Spin Response message is sent in response to a participant''s Spin Request message indicating whether a spin will be sent.'
    0x83:
      id: 'spin_finished_message'
      doc: 'The Spin Finished message is sent to indicate that all messages for the spin requested have been sent. A Spin Finished message is only sent if a Spin Request was not rejected. Upon receipt of a Spin Finished message, any buffered multicast messages should be applied to the participant''s copy of the book to make it current.'
    0xb1:
      id: 'time_reference_message'
      doc: 'The Time Reference message is used to provide a midnight reference point for recipients of the feed. It is sent whenever the system starts up and when the system crosses a midnight boundary.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second.'
    0xbb:
      id: 'futures_instrument_definition_message'
      doc: 'The Futures Instrument Definition message can be sent as a sequenced message or an un-sequenced message. It is sent as a sequenced message when the system starts up at the beginning of a trading session or an the instrument is created or modified during a trading day.'
    0xfa:
      id: 'futures_variance_symbol_mapping_message'
      doc: 'The Futures Variance Symbol Mapping message is used to disseminate symbol reference data for S&P 500 Variance Futures (VA Futures) symbols.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the CFE book.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the CFE book.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a Futures contract.'
    0xb9:
      id: 'settlement_message'
      doc: 'Settlement messages are used to provide information concerning indicative, approved, or corrected daily and final settlement prices for CFE products.'
    0xbe:
      id: 'price_limits_message'
      doc: 'The Price Limits message is sent out at the start of a session for products subject to price limits per the contract specifications.'
    0xba:
      id: 'end_of_day_summary_message'
      doc: 'The End of Day Summary message is sent immediately after trading ends for a symbol. No more Market Update messages will follow an End of Day Summary message for a particular symbol.'
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
  trading_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x51:
      id: 'queuing'
      doc: 'Queuing'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x48:
      id: 'halted'
      doc: 'Halted'

