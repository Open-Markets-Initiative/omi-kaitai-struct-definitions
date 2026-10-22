# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe TitaniumConsolidated TcpOneEquities CboeOne v1.4.16
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Tcp One Equities
#   Encoding: Cboe One
#   Version: 1.4.16
#   Date: 10/02/2026
#   Specification: technical-specifications-cboe-titanium-cboe-one-equities-feed-specification.pdf
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
  id: cboe_titaniumconsolidated_tcponeequities_cboeone_v1_4_16
  title: Cboe TitaniumConsolidated TcpOneEquities CboeOne v1.4.16
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Titanium Consolidated Tcp One Equities CboeOne v1.4.16'
doc-ref: http://markets.cboe.com/us/equities/support/technical

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Message Count messages to follow'
      - id: message_count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Sequence number that reflects that last update on the feed'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::cboe_one_login_message': cboe_one_login_message
            'message_type::login_response_message': login_response_message
            'message_type::replay_complete_message': replay_complete_message
            'message_type::clear_quote_message': clear_quote_message
            'message_type::fractional_symbol_summary_message': fractional_symbol_summary_message
            'message_type::best_quote_update_message': best_quote_update_message
            'message_type::cboe_market_status_message': cboe_market_status_message
            'message_type::adap_message': adap_message
            'message_type::rpi_message': rpi_message
            'message_type::fractional_trade_message': fractional_trade_message
            'message_type::fractional_trade_break_message': fractional_trade_break_message
            'message_type::trading_status_message': trading_status_message
            'message_type::opening_closing_price_message': opening_closing_price_message
            'message_type::fractional_end_of_day_summary_message': fractional_end_of_day_summary_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  cboe_one_login_message:
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
      - id: next_sequence
        type: u4
        doc: 'Sequence number of the next sequenced message expected by the user'
  login_response_message:
    seq:
      - id: status
        type: u1
        enum: status
        doc: 'Accepted or reason for reject'
  replay_complete_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Sequence number that reflects that last update on the feed'
  clear_quote_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
  fractional_symbol_summary_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: consolidated_best_bid_price
        type: decimal_u8_4
        doc: 'Cboe Consolidated best bid price. Implied decimal with scale 1e-4'
      - id: consolidated_best_bid_quantity
        type: u8
        doc: 'Cboe Consolidated number of buy-side shares available for this symbol'
      - id: consolidated_best_ask_price
        type: decimal_u8_4
        doc: 'Cboe Consolidated best ask price. Implied decimal with scale 1e-4'
      - id: consolidated_best_ask_quantity
        type: u8
        doc: 'Cboe Consolidated number of sell-side shares available for this symbol'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'Cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: fractional_symbol_summary_flags
        type: fractional_symbol_summary_flags
  fractional_symbol_summary_flags:
    meta:
      bit-endian: le
    seq:
      - id: national_volume_status
        type: b1
      - id: unused_7
        type: b7
  best_quote_update_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B=Buy Side S=Sell Side'
      - id: consolidated_best_quote_price
        type: decimal_u8_4
        doc: 'Cboe Consolidated best price. Implied decimal with scale 1e-4'
      - id: consolidated_quote_quantity
        type: u8
        doc: 'Cboe Consolidated number of shares available for this symbol'
  cboe_market_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: market_status
        type: u1
        enum: market_status
        doc: 'N=Normal E=Excluded from Symbol Summary and ADAP updates I=Incomplete'
      - id: session_indicator
        type: u1
        enum: session_indicator
        doc: 'R=Regular trading session P=Pre- or post-market session'
  adap_message:
    seq:
      - id: last_update_timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of the last matching engine message that updated the quote information for this symbol in the Cboe One server''s cache. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: adap_flags
        type: adap_flags
      - id: reserved_1
        type: u1
        doc: 'Reserved'
      - id: num_adap_block
        type: u1
        doc: 'Number of ADAP Block message to follow'
      - id: adap_block_size
        type: u1
        doc: 'Size of each ADAP Block message'
      - id: adap_block
        type: adap_block
        repeat: expr
        repeat-expr: num_adap_block
        doc: 'ADAP Block'
  adap_flags:
    meta:
      bit-endian: le
    seq:
      - id: clear_adap
        type: b1
      - id: adap_complete
        type: b1
      - id: short_long_blocks
        type: b1
      - id: unused_5
        type: b5
  adap_block:
    seq:
      - id: adap_update
        type:
          switch-on: _parent.adap_block_size
          cases:
            10: short_update_adap_block
            18: long_update_adap_block
  short_update_adap_block:
    seq:
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy Side S=Sell Side'
      - id: price_short
        type: decimal_u4_4
        doc: 'Price level to add/update for Market Center''s ADAP book. Implied decimal with scale 1e-4'
      - id: quantity_short
        type: u4
        doc: 'Quantity of shares at this price level in the Market Center''s ADAP book. A value of zero implies deletion of this ADAP level'
  long_update_adap_block:
    seq:
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy Side S=Sell Side'
      - id: price_long
        type: decimal_u8_4
        doc: 'Opening/Closing Price. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u8
        doc: 'Quantity of shares at this price level in the Market Center''s ADAP book. A value of zero implies deletion of this ADAP level'
  rpi_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: retail_price_improvement
        type: u1
        enum: retail_price_improvement
        doc: 'B=Buy Side RPI S=Sell Side RPI A=Buy & Sell RPI N=No RPI'
  fractional_trade_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: last_price
        type: decimal_u8_4
        doc: 'Last trade price. Implied decimal with scale 1e-4'
      - id: last_quantity
        type: u8
        doc: 'Last trade quantity'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'Cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: fractional_trade_flags
        type: fractional_trade_flags
  fractional_trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: national_volume_status
        type: b1
      - id: last_sale_eligible
        type: b1
      - id: unused_6
        type: b6
  fractional_trade_break_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the trade occurred on the specified Market Center. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: market_center_execution_id
        type: u8
        doc: 'Market center specific execution identifier of this Execution. Execution ID is also referenced in the Trade Break message'
      - id: cboe_cumulative_executed_volume
        type: u8
        doc: 'Cumulative number of shares traded today across all applicable Cboe books'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'Cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: fractional_trade_break_flags
        type: fractional_trade_break_flags
  fractional_trade_break_flags:
    meta:
      bit-endian: le
    seq:
      - id: sip_volume_status
        type: b1
      - id: unused_7
        type: b7
  trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'A=Accepting Orders for Queuing H=Halted Q=Quote-Only S=Exchange Specific Suspension T=Trading'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: '0=No price test in effect 1=Reg SHO price test restriction in effect'
  opening_closing_price_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: market_center
        type: u1
        enum: market_center
        doc: '* = All Cboe Markets for this feed Y=BYX Z=BZX A=EDGA X=EDGX'
      - id: open_close_indicator
        type: u1
        enum: open_close_indicator
        doc: 'O=Price is the Opening price C=Price is the Closing price F=First Regular Hours Trade (effective 11/30/26)'
      - id: price_long
        type: decimal_u8_4
        doc: 'Opening/Closing Price. Implied decimal with scale 1e-4'
  fractional_end_of_day_summary_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of when the Market Status changed for the specified Market Center. Encoded as the number of nanoseconds since midnight (effective 11/02/26, since epoch). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: data_source
        type: u1
        enum: data_source
        doc: 'C=CTA U=UTP'
      - id: opening_price
        type: decimal_u8_4
        doc: 'Opening Price. 0 if the system has not received an opening price for the security. Implied decimal with scale 1e-4'
      - id: closing_price
        type: decimal_u8_4
        doc: 'Closing Price. Implied decimal with scale 1e-4'
      - id: high_price
        type: decimal_u8_4
        doc: 'Highest trade price of the day. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'Lowest trade price of the day. Implied decimal with scale 1e-4'
      - id: national_cumulative_volume
        type: decimal_u8_6
        doc: 'Cumulative number of shares traded today as reported to the CTA and UTP SIPs. Implied decimal with scale 1e-6'
      - id: first_regular_hours_trade_price
        type: decimal_u8_4
        doc: 'Represents the first eligible regular-hours SIP trade. Uses the applicable CTA or UTP market-center designation. Coexists with all existing Opening Price messages. Excludes trades with SIP sale condition C, B, H, I, M, N, Q, R, T, U, V, 7, or 8. Implied decimal with scale 1e-4'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0xa0:
      id: 'cboe_one_login_message'
      doc: 'The Cboe One Login message is the first message sent to the server by a user''s process after its connection to the server is established.'
    0x02:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by the server to a user''s process in response to a Login message.'
    0xa1:
      id: 'replay_complete_message'
      doc: 'The Replay Complete message is sent to indicate that messages related to refreshing the state of the Cboe books have been delivered.'
    0xa2:
      id: 'clear_quote_message'
      doc: 'The Clear Quote message instructs feed recipients to clear all quotes and Summary and/or ADAP information for the specified symbol on the specified market(s).'
    0xe7:
      id: 'fractional_symbol_summary_message'
      doc: 'The Fractional Symbol Summary message delivers the Cboe consolidated best bid/offer and total executed volume across all applicable Cboe One US Exchanges.'
    0xa5:
      id: 'best_quote_update_message'
      doc: 'The Best Quote Update message is used to update one side of the Cboe consolidated quote information for a symbol.'
    0xa6:
      id: 'cboe_market_status_message'
      doc: 'The Cboe Market Status message is disseminated to reflect a change in the status of a market.'
    0xa7:
      id: 'adap_message'
      doc: 'Each ADAP message delivers one or more updates for a Symbol''s ADAP book. Each ADAP message contains one or more ADAP Block messages.'
    0xa8:
      id: 'rpi_message'
      doc: 'The Retail Price Improvement (RPI) message is a retail liquidity indicator that includes symbol and side, but not price and size.'
    0xe8:
      id: 'fractional_trade_message'
      doc: 'Fractional Trade messages are sent when an order is executed in whole or in part on a Cboe exchange.'
    0xe9:
      id: 'fractional_trade_break_message'
      doc: 'The Fractional Trade Break message is sent whenever an execution on a Cboe exchange is broken.'
    0xab:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a security on a Cboe exchange.'
    0xb0:
      id: 'opening_closing_price_message'
      doc: 'The Opening/Closing Price message is used to indicate the Opening or Closing price of a security on any of the Cboe markets and the primary listing market.'
    0xea:
      id: 'fractional_end_of_day_summary_message'
      doc: 'The Fractional End of Day Summary message is used to give a consolidated, high-level overview of a security for the day.'
  status:
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
    0x51:
      id: 'next_sequence_is_ahead_of_sequence'
      doc: 'Next Sequence Is Ahead Of Sequence'
  market_center:
    0x2a:
      id: 'all_cboe_markets'
      doc: 'All Cboe Markets for this feed'
    0x59:
      id: 'byx'
      doc: 'Byx'
    0x5a:
      id: 'bzx'
      doc: 'Bzx'
    0x41:
      id: 'edga'
      doc: 'Edga'
    0x58:
      id: 'edgx'
      doc: 'Edgx'
    0x43:
      id: 'cta'
      doc: 'Cta'
    0x55:
      id: 'utp'
      doc: 'Utp'
  side_indicator:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
  market_status:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x45:
      id: 'excluded_from_symbol_summary_and_adap_updates'
      doc: 'Excluded From Symbol Summary And Adap Updates'
    0x49:
      id: 'incomplete'
      doc: 'Incomplete'
  session_indicator:
    0x52:
      id: 'regular_trading_session'
      doc: 'Regular Trading Session'
    0x50:
      id: 'pre_or_postmarket_session'
      doc: 'Pre Or Postmarket Session'
  side:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
  retail_price_improvement:
    0x42:
      id: 'buy_side_rpi'
      doc: 'Buy Side Rpi'
    0x53:
      id: 'sell_side_rpi'
      doc: 'Sell Side Rpi'
    0x41:
      id: 'buy_and_sell_rpi'
      doc: 'Buy & Sell RPI'
    0x4e:
      id: 'no_rpi'
      doc: 'No Rpi'
  trading_status:
    0x41:
      id: 'accepting_orders_for_queuing'
      doc: 'Accepting Orders For Queuing'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x53:
      id: 'exchange_specific_suspension'
      doc: 'Exchange Specific Suspension'
    0x54:
      id: 'trading'
      doc: 'Trading'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_price_test_restriction_in_effect'
      doc: 'Reg Sho Price Test Restriction In Effect'
  open_close_indicator:
    0x4f:
      id: 'opening_price'
      doc: 'Price is the Opening price'
    0x43:
      id: 'closing_price'
      doc: 'Price is the Closing price'
    0x46:
      id: 'first_regular_hours_trade'
      doc: 'First Regular Hours Trade (effective 11/30/26)'
  data_source:
    0x43:
      id: 'cta'
      doc: 'Cta'
    0x55:
      id: 'utp'
      doc: 'Utp'

