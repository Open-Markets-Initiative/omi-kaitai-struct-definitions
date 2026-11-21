# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NasdaqCanada Basic Itch v1.6
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nasdaq Basic Canada
#   Encoding: Itch
#   Version: 1.6
#   Date: 8/16/2024
#   Specification: Nasdaq_Basic_Canada_Specification_1.6.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_nasdaqcanada_basic_itch_v1_6
  title: Nasdaq NasdaqCanada Basic Itch v1.6
  license: MIT-0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Canada Nasdaq Basic Canada Itch v1.6'
doc-ref: https://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
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
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::quotation_message': quotation_message
            'message_type::trade_report_message': trade_report_message
            'message_type::trade_break_message': trade_break_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::stock_status_message': stock_status_message
            'message_type::end_of_day_trade_summary_message': end_of_day_trade_summary_message
            'message_type::adjusted_closing_price_message': adjusted_closing_price_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  quotation_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq Canada stock identifier for which the QBBO quotation message is being generated'
      - id: nasdaq_canada_best_bid_price
        type: decimal_u8_8
        doc: 'Denotes the best bid price across Nasdaq Canada Market Centers. Implied decimal with scale 1e-8'
      - id: nasdaq_canada_best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq Canada trading book(s) at the best bid price'
      - id: nasdaq_cxc_best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq CXC trading book at the Nasdaq Canada best bid price'
      - id: nasdaq_cx_2_best_bid_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq CX2 trading book at the Nasdaq Canada best bid price'
      - id: nasdaq_canada_best_ask_price
        type: decimal_u8_8
        doc: 'Denotes the best ask price across Nasdaq Canada Market Centers. Implied decimal with scale 1e-8'
      - id: nasdaq_canada_best_ask_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq Canada trading book(s) at the best ask price'
      - id: nasdaq_cxc_best_ask_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq CXC trading book at the Nasdaq Canada best ask price'
      - id: nasdaq_cx_2_best_ask_size
        type: u4
        doc: 'Denotes the aggregated number of shares available for display within the Nasdaq CX2 trading book at the Nasdaq Canada best ask price'
  trade_report_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq Canada trading book that generated the trade message'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq Canada stock identifier for which the QBBO quotation message is being generated'
      - id: trade_number
        type: u4
        doc: 'Indicates the source''s internal number associated with the given trade transaction'
      - id: trade_price
        type: decimal_u8_8
        doc: 'The price associated with the trade transaction being reported. Implied decimal with scale 1e-8'
      - id: trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the trade transaction'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric Broker Number of the buyer, or 001 for anonymous'
      - id: contra_broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric Broker Number of the seller, or 001 for anonymous'
      - id: sale_condition_modifier
        type: sale_condition_modifier
        doc: 'Sale condition modifier consists of four levels'
      - id: consolidated_trade_volume
        type: u8
        doc: 'Reflects the volume for the Stock Symbol as reported by each exchange at the time that the trade message was generated'
  sale_condition_modifier:
    seq:
      - id: sale_condition_modifier_level_1
        type: u1
        enum: sale_condition_modifier_level_1
        doc: 'Used for Trade Attribute Information'
      - id: sales_condition_modifier_level_2
        type: u1
        enum: sales_condition_modifier_level_2
        doc: 'Used for Cross Type Information'
      - id: sales_condition_modifier_level_3
        type: u1
        enum: sales_condition_modifier_level_3
        doc: 'Used for Settlement Terms Information'
      - id: sales_condition_modifier_level_4
        type: u1
        enum: sales_condition_modifier_level_4
        doc: 'Used for Board Lot Eligibility Information'
  trade_break_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: trade_control_number
        type: u4
        doc: 'Indicates the source''s internal control number associated with the given trade transaction'
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq Canada trading book that generated the trade message'
  trade_correction_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq Canada trading book that generated the trade message'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq Canada stock identifier for which the QBBO quotation message is being generated'
      - id: original_trade_number
        type: u4
        doc: 'Indicates the source''s internal number associated with the given trade transaction'
      - id: original_trade_price
        type: decimal_u8_8
        doc: 'The price associated with the original trade transaction. Implied decimal with scale 1e-8'
      - id: original_trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the original trade transaction'
      - id: corrected_trade_price
        type: decimal_u8_8
        doc: 'The price associated with the trade correction being reported. Implied decimal with scale 1e-8'
      - id: corrected_trade_size
        type: u4
        doc: 'Indicates the reported number of shares on the trade correction'
  system_event_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: originating_market_center_identifier
        type: u1
        enum: originating_market_center_identifier
        doc: 'Denotes the Nasdaq Canada trading book that generated the trade message'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Denotes the Nasdaq Canada market system event code'
  stock_directory_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq Canada stock identifier for which the QBBO quotation message is being generated'
      - id: stock_display_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: '1*40 Printable ASCII; no default'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'Indicates the primary listing market for the stock'
      - id: board_lot_size
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Board Lot Size of the Symbol'
      - id: currency
        type: u1
        enum: currency
        doc: 'Denotes the Currency of the Symbol'
  stock_status_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq Canada stock identifier for which the QBBO quotation message is being generated'
      - id: market
        type: u1
        enum: market
        doc: 'Denotes the Nasdaq Canada trading book that generated the message'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Denotes whether the trading state of the Canada trading books is currently halted'
  end_of_day_trade_summary_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Nasdaq Canada stock identifier for which the QBBO quotation message is being generated'
      - id: consolidated_high_price
        type: decimal_u8_8
        doc: 'The highest price of any high/low eligible transaction on the trading day for any exchange. Implied decimal with scale 1e-8'
      - id: consolidated_low_price
        type: decimal_u8_8
        doc: 'The lowest price of any high/low eligible transaction on the trading day for any exchange. Implied decimal with scale 1e-8'
      - id: consolidated_open_price
        type: decimal_u8_8
        doc: 'The first last sale eligible transactions received on the trading day for any participating exchange. Implied decimal with scale 1e-8'
      - id: listing_center_open_price
        type: decimal_u8_8
        doc: 'The first last sale eligible transactions received on the trading day from the primary listing exchange. Implied decimal with scale 1e-8'
      - id: consolidated_close_price
        type: decimal_u8_8
        doc: 'The final last sale eligible transaction on any participating exchange received on the trading day. Implied decimal with scale 1e-8'
      - id: listing_center_close_price
        type: decimal_u8_8
        doc: 'The final last sale eligible transactions received on the trading day from the primary listing exchange. Implied decimal with scale 1e-8'
      - id: consolidated_volume
        type: u8
        doc: 'Reflects the sum of the total volume for the issue from all participating exchanges'
  adjusted_closing_price_message:
    seq:
      - id: time_stamp
        type: nanosecond_timestamp
        doc: 'Denotes the time stamp of the Nasdaq Canada trading book that generated the quote message. Nanoseconds since Midnight epoch'
      - id: issue_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol for the issue in the Nasdaq execution system'
      - id: security_class
        type: u1
        enum: security_class
        doc: 'Indicates the primary listing market for the issue'
      - id: adjusted_closing_price
        type: decimal_u8_8
        doc: 'The previous trading day''s official closing price adjusted for any applicable corporate actions. Implied decimal with scale 1e-8'
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

enums:
  message_type:
    0x43:
      id: 'quotation_message'
      doc: 'Combined Quotation Report of the Nasdaq Canada best bid and offer, with size attributed to the CXC and CX2 trading books.'
    0x54:
      id: 'trade_report_message'
      doc: 'Relays all transactions available from or reported by the three Nasdaq Canada Trading Books for the current business day.'
    0x58:
      id: 'trade_break_message'
      doc: 'Sent if a Trade is cancelled during the same day as its execution.'
    0x5a:
      id: 'trade_correction_message'
      doc: 'Sent if a Trade is corrected during the same day as its execution.'
    0x53:
      id: 'system_event_message'
      doc: 'Issued to indicate a market state event.'
    0x52:
      id: 'stock_directory_message'
      doc: 'Disseminated at the start of each trading day for all active symbols in the Nasdaq Execution system.'
    0x48:
      id: 'stock_status_message'
      doc: 'Indicates the current trading status of a stock.'
    0x44:
      id: 'end_of_day_trade_summary_message'
      doc: 'Published once at 4:15PM and again at 5:15PM, including all traded symbols from the day.'
    0x47:
      id: 'adjusted_closing_price_message'
      doc: 'Previous Day Adjusted Close Price, sent at 7:00AM to reflect any adjustments made overnight.'
  originating_market_center_identifier:
    0x43:
      id: 'the_nasdaq_cxc_trading_book'
      doc: 'The Nasdaq CXC Trading Book'
    0x58:
      id: 'the_nasdaq_cx_2_trading_book'
      doc: 'The Nasdaq CX2 Trading Book'
    0x44:
      id: 'the_nasdaq_cxd_trading_book'
      doc: 'The Nasdaq CXD Trading Book'
    0x41:
      id: 'all_markets'
      doc: 'All Markets (CXC, CX2, CXD); System Event Message only'
  sale_condition_modifier_level_1:
    0x20:
      id: 'regular_trade'
      doc: 'Regular Trade'
    0x42:
      id: 'bypass'
      doc: 'Bypass (Crosses Only)'
    0x4c:
      id: 'm_elo'
      doc: 'M-ELO'
    0x50:
      id: 'cxd_pure_stream'
      doc: 'CXD Pure Stream'
  sales_condition_modifier_level_2:
    0x20:
      id: 'regular'
      doc: 'Regular (Last Sale Condition Matrix)'
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x56:
      id: 'vwap'
      doc: 'VWAP'
    0x58:
      id: 'intentional'
      doc: 'Intentional'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
  sales_condition_modifier_level_3:
    0x20:
      id: 'regular'
      doc: 'Regular (Last Sale Condition Matrix)'
    0x54:
      id: 'cash_today'
      doc: 'Cash Today'
    0x43:
      id: 'cash_tomorrow'
      doc: 'Cash Tomorrow'
    0x44:
      id: 'delayed_delivery'
      doc: 'Delayed Delivery'
  sales_condition_modifier_level_4:
    0x41:
      id: 'odd_lot'
      doc: 'Odd Lot'
    0x42:
      id: 'board_lot_or_larger'
      doc: 'Board Lot or Larger'
  event_code:
    0x4f:
      id: 'first_message_of_the_day'
      doc: 'First message of the day'
    0x53:
      id: 'start_of_nasdaq_canada_trading_session'
      doc: 'Start of Nasdaq Canada Trading Session'
    0x51:
      id: 'start_of_primary_market_trading_activity_session'
      doc: 'Start of Primary Market Trading Activity Session'
    0x4d:
      id: 'end_of_primary_market_trading_session'
      doc: 'End of Primary Market Trading Session. Indicates the Pegged orders are no longer available for execution'
    0x45:
      id: 'end_of_nasdaq_canada_trading_session'
      doc: 'End of Nasdaq Canada Trading Session'
    0x43:
      id: 'end_of_messages'
      doc: 'End of Messages. Last message of the day'
  listing_market:
    0x54:
      id: 'the_tmx_senior_market'
      doc: 'The TMX Senior Market (TSX)'
    0x43:
      id: 'the_canadian_securities_exchange'
      doc: 'The Canadian Securities Exchange'
    0x56:
      id: 'the_tmx_venture_market'
      doc: 'The TMX Venture Market'
    0x4e:
      id: 'the_neo_exchange'
      doc: 'The NEO Exchange'
  currency:
    0x55:
      id: 'usd'
      doc: 'USD'
    0x43:
      id: 'cad'
      doc: 'CAD'
  market:
    0x43:
      id: 'the_nasdaq_cxc_trading_book'
      doc: 'The Nasdaq CXC Trading Book'
    0x58:
      id: 'the_nasdaq_cx_2_trading_book'
      doc: 'The Nasdaq CX2 Trading Book'
    0x44:
      id: 'the_nasdaq_cxd_trading_book'
      doc: 'The Nasdaq CXD Trading Book'
    0x41:
      id: 'all_markets'
      doc: 'All Markets (CXC, CX2, CXD)'
  system_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x54:
      id: 'trading'
      doc: 'Trading'
  security_class:
    0x54:
      id: 'the_tmx_senior_market'
      doc: 'The TMX Senior Market (TSX)'
    0x43:
      id: 'the_canadian_securities_exchange'
      doc: 'The Canadian Securities Exchange'
    0x56:
      id: 'the_tmx_venture_market'
      doc: 'The TMX Venture Market'
    0x4e:
      id: 'the_neo_exchange'
      doc: 'The NEO Exchange'

